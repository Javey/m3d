<?php

/**
 * A CSSList is the most generic container available. Its contents include RuleSet as well as other CSSList objects.
 * Also, it may contain Import and Charset objects stemming from @-rules.
 */
abstract class CSSList {

    protected $aContents;

    public function __construct() {
        $this->aContents = array();
    }

    public function append($oItem) {
        $this->aContents[] = $oItem;
    }

    /**
     * Removes an item from the CSS list.
     * @param RuleSet|Import|Charset|CSSList $oItemToRemove May be a RuleSet (most likely a DeclarationBlock), a Import, a Charset or another CSSList (most likely a MediaQuery)
     */
    public function remove($oItemToRemove) {
        $iKey = array_search($oItemToRemove, $this->aContents, true);
        if ($iKey !== false) {
            unset($this->aContents[$iKey]);
        }
    }

    public function removeDeclarationBlockBySelector($mSelector, $bRemoveAll = false) {
        if ($mSelector instanceof DeclarationBlock) {
            $mSelector = $mSelector->getSelectors();
        }
        if (!is_array($mSelector)) {
            $mSelector = explode(',', $mSelector);
        }
        foreach ($mSelector as $iKey => &$mSel) {
            if (!($mSel instanceof Selector)) {
                $mSel = new Selector($mSel);
            }
        }
        foreach ($this->aContents as $iKey => $mItem) {
            if (!($mItem instanceof DeclarationBlock)) {
                continue;
            }
            if ($mItem->getSelectors() == $mSelector) {
                unset($this->aContents[$iKey]);
                if (!$bRemoveAll) {
                    return;
                }
            }
        }
    }

    public function __toString() {
        $sResult = '';
        foreach ($this->aContents as $oContent) {
            $sResult .= $oContent->__toString();
        }
        return $sResult;
    }

    public function getContents() {
        return $this->aContents;
    }
}

abstract class CSSBlockList extends CSSList {
    protected function allDeclarationBlocks(&$aResult) {
        foreach ($this->aContents as $mContent) {
            if ($mContent instanceof DeclarationBlock) {
                $aResult[] = $mContent;
            } else if ($mContent instanceof CSSBlockList) {
                $mContent->allDeclarationBlocks($aResult);
            }
        }
    }

    protected function allRuleSets(&$aResult) {
        foreach ($this->aContents as $mContent) {
            if ($mContent instanceof RuleSet) {
                $aResult[] = $mContent;
            } else if ($mContent instanceof CSSBlockList) {
                $mContent->allRuleSets($aResult);
            }
        }
    }

    protected function allValues($oElement, &$aResult, $sSearchString = null, $bSearchInFunctionArguments = false) {
        if ($oElement instanceof CSSBlockList) {
            foreach ($oElement->getContents() as $oContent) {
                $this->allValues($oContent, $aResult, $sSearchString, $bSearchInFunctionArguments);
            }
        } else if ($oElement instanceof RuleSet) {
            foreach ($oElement->getRules($sSearchString) as $oRule) {
                $this->allValues($oRule, $aResult, $sSearchString, $bSearchInFunctionArguments);
            }
        } else if ($oElement instanceof Rule) {
            $this->allValues($oElement->getValue(), $aResult, $sSearchString, $bSearchInFunctionArguments);
        } else if ($oElement instanceof ValueList) {
            if ($bSearchInFunctionArguments || !($oElement instanceof CSSFunction)) {
                foreach ($oElement->getListComponents() as $mComponent) {
                    $this->allValues($mComponent, $aResult, $sSearchString, $bSearchInFunctionArguments);
                }
            }
        } else {
            //Non-List Value or String (CSS identifier)
            $aResult[] = $oElement;
        }
    }

    protected function allSelectors(&$aResult, $sSpecificitySearch = null) {
        $aDeclarationBlocks = array();
        $this->allDeclarationBlocks($aDeclarationBlocks);
        foreach ($aDeclarationBlocks as $oBlock) {
            foreach ($oBlock->getSelectors() as $oSelector) {
                if ($sSpecificitySearch === null) {
                    $aResult[] = $oSelector;
                } else {
                    $sComparison = "\$bRes = {$oSelector->getSpecificity()} $sSpecificitySearch;";
                    eval($sComparison);
                    if ($bRes) {
                        $aResult[] = $oSelector;
                    }
                }
            }
        }
    }

}

class Document extends CSSBlockList {

    /**
     * Gets all DeclarationBlock objects recursively.
     */
    public function getAllDeclarationBlocks() {
        $aResult = array();
        $this->allDeclarationBlocks($aResult);
        return $aResult;
    }

    /**
     * @deprecated use getAllDeclarationBlocks()
     */
    public function getAllSelectors() {
        return $this->getAllDeclarationBlocks();
    }

    /**
     * Returns all RuleSet objects found recursively in the tree.
     */
    public function getAllRuleSets() {
        $aResult = array();
        $this->allRuleSets($aResult);
        return $aResult;
    }

    /**
     * Returns all Value objects found recursively in the tree.
     * @param (object|string) $mElement the CSSList or RuleSet to start the search from (defaults to the whole document). If a string is given, it is used as rule name filter (@see{RuleSet->getRules()}).
     * @param (bool) $bSearchInFunctionArguments whether to also return Value objects used as Function arguments.
     */
    public function getAllValues($mElement = null, $bSearchInFunctionArguments = false) {
        $sSearchString = null;
        if ($mElement === null) {
            $mElement = $this;
        } else if (is_string($mElement)) {
            $sSearchString = $mElement;
            $mElement = $this;
        }
        $aResult = array();
        $this->allValues($mElement, $aResult, $sSearchString, $bSearchInFunctionArguments);
        return $aResult;
    }

    /**
     * Returns all Selector objects found recursively in the tree.
     * Note that this does not yield the full DeclarationBlock that the selector belongs to (and, currently, there is no way to get to that).
     * @param $sSpecificitySearch An optional filter by specificity. May contain a comparison operator and a number or just a number (defaults to "==").
     * @example getSelectorsBySpecificity('>= 100')
     */
    public function getSelectorsBySpecificity($sSpecificitySearch = null) {
        if (is_numeric($sSpecificitySearch) || is_numeric($sSpecificitySearch[0])) {
            $sSpecificitySearch = "== $sSpecificitySearch";
        }
        $aResult = array();
        $this->allSelectors($aResult, $sSpecificitySearch);
        return $aResult;
    }

    /**
     * Expands all shorthand properties to their long value
     */
    public function expandShorthands() {
        foreach ($this->getAllDeclarationBlocks() as $oDeclaration) {
            $oDeclaration->expandShorthands();
        }
    }

    /*
     * Create shorthands properties whenever possible
     */

    public function createShorthands() {
        foreach ($this->getAllDeclarationBlocks() as $oDeclaration) {
            $oDeclaration->createShorthands();
        }
    }

}

class AtRuleBlockList extends CSSBlockList implements AtRule {

    private $sType;
    private $sArgs;

    public function __construct($sType, $sArgs = '') {
        parent::__construct();
        $this->sType = $sType;
        $this->sArgs = $sArgs;
    }

    public function atRuleName() {
        return $this->sType;
    }

    public function atRuleArgs() {
        return $this->sArgs;
    }

    public function __toString() {
        $sResult = "@{$this->sType} {$this->sArgs}{";
        $sResult .= parent::__toString();
        $sResult .= '}';
        return $sResult;
    }

}

class KeyFrame extends CSSList implements AtRule {

    private $vendorKeyFrame;
    private $animationName;

    public function __construct() {
        parent::__construct();
        $this->vendorKeyFrame = null;
        $this->animationName  = null;
    }

    public function setVendorKeyFrame($vendorKeyFrame) {
        $this->vendorKeyFrame = $vendorKeyFrame;
    }

    public function getVendorKeyFrame() {
        return $this->vendorKeyFrame;
    }

    public function setAnimationName($animationName) {
        $this->animationName = $animationName;
    }

    public function getAnimationName() {
        return $this->animationName;
    }

    public function __toString() {
        $sResult = "@{$this->vendorKeyFrame} {$this->animationName} {";
        $sResult .= parent::__toString();
        $sResult .= '}';
        return $sResult;
    }

    public function atRuleName() {
        return $this->vendorKeyFrame;
    }

    public function atRuleArgs() {
        return $this->animationName;
    }
}
