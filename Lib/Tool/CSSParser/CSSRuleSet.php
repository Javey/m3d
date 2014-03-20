<?php

abstract class RuleSet {

    private $aRules;

    public function __construct() {
        $this->aRules = array();
    }

    public function addRule(Rule $oRule) {
        $sRule = $oRule->getRule();
        if(!isset($this->aRules[$sRule])) {
            $this->aRules[$sRule] = array();
        }
        $this->aRules[$sRule][] = $oRule;
    }

    /**
     * Returns all rules matching the given rule name
     * @param (null|string|Rule) $mRule pattern to search for. If null, returns all rules. if the pattern ends with a dash, all rules starting with the pattern are returned as well as one matching the pattern with the dash excluded. passing a Rule behaves like calling getRules($mRule->getRule()).
     * @example $oRuleSet->getRules('font-') //returns an array of all rules either beginning with font- or matching font.
     * @example $oRuleSet->getRules('font') //returns array(0 => $oRule, …) or array().
     */
    public function getRules($mRule = null) {
        if ($mRule instanceof Rule) {
            $mRule = $mRule->getRule();
        }
        $aResult = array();
        foreach($this->aRules as $sName => $aRules) {
            // Either no search rule is given or the search rule matches the found rule exactly or the search rule ends in “-” and the found rule starts with the search rule.
            // 再加一个前面有“-”的情况，针对-webkit-background-size by Javey 13/09/25
            if(
                !$mRule ||
                $sName === $mRule ||
//                (strrpos($mRule, '-') === strlen($mRule) - strlen('-') && (strpos($sName, $mRule) === 0 || $sName === substr($mRule, 0, -1))) ||
                ((strpos($mRule, '-') === 0 || strrpos($mRule, '-') === strlen($mRule) - strlen('-')) && strpos($sName, trim($mRule, '-')) !== false)
            ) {
                $aResult = array_merge($aResult, $aRules);
            }
        }
        return $aResult;
    }

    /**
     * Returns all rules matching the given pattern and returns them in an associative array with the rule’s name as keys. This method exists mainly for backwards-compatibility and is really only partially useful.
     * @param (string) $mRule pattern to search for. If null, returns all rules. if the pattern ends with a dash, all rules starting with the pattern are returned as well as one matching the pattern with the dash excluded. passing a Rule behaves like calling getRules($mRule->getRule()).
     * Note: This method loses some information: Calling this (with an argument of 'background-') on a declaration block like { background-color: green; background-color; rgba(0, 127, 0, 0.7); } will only yield an associative array containing the rgba-valued rule while @link{getRules()} would yield an indexed array containing both.
     */
    public function getRulesAssoc($mRule = null) {
        $aResult = array();
        foreach($this->getRules($mRule) as $oRule) {
            $aResult[$oRule->getRule()] = $oRule;
        }
        return $aResult;
    }

    /**
     * Remove a rule from this RuleSet. This accepts all the possible values that @link{getRules()} accepts. If given a Rule, it will only remove this particular rule (by identity). If given a name, it will remove all rules by that name. Note: this is different from pre-v.2.0 behaviour of PHP-CSS-Parser, where passing a Rule instance would remove all rules with the same name. To get the old behvaiour, use removeRule($oRule->getRule()).
     * @param (null|string|Rule) $mRule pattern to remove. If $mRule is null, all rules are removed. If the pattern ends in a dash, all rules starting with the pattern are removed as well as one matching the pattern with the dash excluded. Passing a Rule behaves matches by identity.
     */
    public function removeRule($mRule) {
        if($mRule instanceof Rule) {
            $sRule = $mRule->getRule();
            if(!isset($this->aRules[$sRule])) {
                return;
            }
            foreach($this->aRules[$sRule] as $iKey => $oRule) {
                if($oRule === $mRule) {
                    unset($this->aRules[$sRule][$iKey]);
                }
            }
        } else {
            foreach($this->aRules as $sName => $aRules) {
                // Either no search rule is given or the search rule matches the found rule exactly or the search rule ends in “-” and the found rule starts with the search rule or equals it (without the trailing dash).
                if(!$mRule || $sName === $mRule || (strrpos($mRule, '-') === strlen($mRule) - strlen('-') && (strpos($sName, $mRule) === 0 || $sName === substr($mRule, 0, -1)))) {
                    unset($this->aRules[$sName]);
                }
            }
        }
    }

    public function __toString() {
        $sResult = '';
        foreach ($this->aRules as $aRules) {
            foreach($aRules as $oRule) {
                $sResult .= $oRule->__toString();
            }
        }
        return $sResult;
    }

}

class AtRuleSet extends RuleSet implements AtRule {

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

class DeclarationBlock extends RuleSet {

    private $aSelectors;

    public function __construct() {
        parent::__construct();
        $this->aSelectors = array();
    }

    public function setSelectors($mSelector) {
        if (is_array($mSelector)) {
            $this->aSelectors = $mSelector;
        } else {
            $this->aSelectors = explode(',', $mSelector);
        }
        foreach ($this->aSelectors as $iKey => $mSelector) {
            if (!($mSelector instanceof Selector)) {
                $this->aSelectors[$iKey] = new Selector($mSelector);
            }
        }
    }

    /**
     * @deprecated use getSelectors()
     */
    public function getSelector() {
        return $this->getSelectors();
    }

    /**
     * @deprecated use setSelectors()
     */
    public function setSelector($mSelector) {
        $this->setSelectors($mSelector);
    }

    public function getSelectors() {
        return $this->aSelectors;
    }

    /**
     * Split shorthand declarations (e.g. +margin+ or +font+) into their constituent parts.
     * */
    public function expandShorthands() {
        // border must be expanded before dimensions
        $this->expandBorderShorthand();
        $this->expandDimensionsShorthand();
        $this->expandFontShorthand();
        $this->expandBackgroundShorthand();
        $this->expandListStyleShorthand();
    }

    /**
     * Create shorthand declarations (e.g. +margin+ or +font+) whenever possible.
     * */
    public function createShorthands() {
        $this->createBackgroundShorthand();
        $this->createDimensionsShorthand();
        // border must be shortened after dimensions
        $this->createBorderShorthand();
        $this->createFontShorthand();
        $this->createListStyleShorthand();
    }

    /**
     * Split shorthand border declarations (e.g. <tt>border: 1px red;</tt>)
     * Additional splitting happens in expandDimensionsShorthand
     * Multiple borders are not yet supported as of 3
     * */
    public function expandBorderShorthand() {
        $aBorderRules = array(
            'border', 'border-left', 'border-right', 'border-top', 'border-bottom'
        );
        $aBorderSizes = array(
            'thin', 'medium', 'thick'
        );
        $aRules = $this->getRulesAssoc();
        foreach ($aBorderRules as $sBorderRule) {
            if (!isset($aRules[$sBorderRule]))
                continue;
            $oRule = $aRules[$sBorderRule];
            $mRuleValue = $oRule->getValue();
            $aValues = array();
            if (!$mRuleValue instanceof RuleValueList) {
                $aValues[] = $mRuleValue;
            } else {
                $aValues = $mRuleValue->getListComponents();
            }
            foreach ($aValues as $mValue) {
                if ($mValue instanceof Value) {
                    $mNewValue = clone $mValue;
                } else {
                    $mNewValue = $mValue;
                }
                if ($mValue instanceof Size) {
                    $sNewRuleName = $sBorderRule . "-width";
                } else if ($mValue instanceof Color) {
                    $sNewRuleName = $sBorderRule . "-color";
                } else {
                    if (in_array($mValue, $aBorderSizes)) {
                        $sNewRuleName = $sBorderRule . "-width";
                    } else/* if(in_array($mValue, $aBorderStyles)) */ {
                        $sNewRuleName = $sBorderRule . "-style";
                    }
                }
                $oNewRule = new Rule($sNewRuleName);
                $oNewRule->setIsImportant($oRule->getIsImportant());
                $oNewRule->addValue(array($mNewValue));
                $this->addRule($oNewRule);
            }
            $this->removeRule($sBorderRule);
        }
    }

    /**
     * Split shorthand dimensional declarations (e.g. <tt>margin: 0px auto;</tt>)
     * into their constituent parts.
     * Handles margin, padding, border-color, border-style and border-width.
     * */
    public function expandDimensionsShorthand() {
        $aExpansions = array(
            'margin' => 'margin-%s',
            'padding' => 'padding-%s',
            'border-color' => 'border-%s-color',
            'border-style' => 'border-%s-style',
            'border-width' => 'border-%s-width'
        );
        $aRules = $this->getRulesAssoc();
        foreach ($aExpansions as $sProperty => $sExpanded) {
            if (!isset($aRules[$sProperty]))
                continue;
            $oRule = $aRules[$sProperty];
            $mRuleValue = $oRule->getValue();
            $aValues = array();
            if (!$mRuleValue instanceof RuleValueList) {
                $aValues[] = $mRuleValue;
            } else {
                $aValues = $mRuleValue->getListComponents();
            }
            $top = $right = $bottom = $left = null;
            switch (count($aValues)) {
                case 1:
                    $top = $right = $bottom = $left = $aValues[0];
                    break;
                case 2:
                    $top = $bottom = $aValues[0];
                    $left = $right = $aValues[1];
                    break;
                case 3:
                    $top = $aValues[0];
                    $left = $right = $aValues[1];
                    $bottom = $aValues[2];
                    break;
                case 4:
                    $top = $aValues[0];
                    $right = $aValues[1];
                    $bottom = $aValues[2];
                    $left = $aValues[3];
                    break;
            }
            foreach (array('top', 'right', 'bottom', 'left') as $sPosition) {
                $oNewRule = new Rule(sprintf($sExpanded, $sPosition));
                $oNewRule->setIsImportant($oRule->getIsImportant());
                $oNewRule->addValue(${$sPosition});
                $this->addRule($oNewRule);
            }
            $this->removeRule($sProperty);
        }
    }

    /**
     * Convert shorthand font declarations
     * (e.g. <tt>font: 300 italic 11px/14px verdana, helvetica, sans-serif;</tt>)
     * into their constituent parts.
     * */
    public function expandFontShorthand() {
        $aRules = $this->getRulesAssoc();
        if (!isset($aRules['font']))
            return;
        $oRule = $aRules['font'];
        // reset properties to 'normal' per http://www.w3.org/TR/21/fonts.html#font-shorthand
        $aFontProperties = array(
            'font-style' => 'normal',
            'font-variant' => 'normal',
            'font-weight' => 'normal',
            'font-size' => 'normal',
            'line-height' => 'normal'
        );
        $mRuleValue = $oRule->getValue();
        $aValues = array();
        if (!$mRuleValue instanceof RuleValueList) {
            $aValues[] = $mRuleValue;
        } else {
            $aValues = $mRuleValue->getListComponents();
        }
        foreach ($aValues as $mValue) {
            if (!$mValue instanceof Value) {
                $mValue = mb_strtolower($mValue);
            }
            if (in_array($mValue, array('normal', 'inherit'))) {
                foreach (array('font-style', 'font-weight', 'font-variant') as $sProperty) {
                    if (!isset($aFontProperties[$sProperty])) {
                        $aFontProperties[$sProperty] = $mValue;
                    }
                }
            } else if (in_array($mValue, array('italic', 'oblique'))) {
                $aFontProperties['font-style'] = $mValue;
            } else if ($mValue == 'small-caps') {
                $aFontProperties['font-variant'] = $mValue;
            } else if (
                in_array($mValue, array('bold', 'bolder', 'lighter'))
                || ($mValue instanceof Size
                && in_array($mValue->getSize(), range(100, 900, 100)))
            ) {
                $aFontProperties['font-weight'] = $mValue;
            } else if ($mValue instanceof RuleValueList && $mValue->getListSeparator() == '/') {
                list($oSize, $oHeight) = $mValue->getListComponents();
                $aFontProperties['font-size'] = $oSize;
                $aFontProperties['line-height'] = $oHeight;
            } else if ($mValue instanceof Size && $mValue->getUnit() !== null) {
                $aFontProperties['font-size'] = $mValue;
            } else {
                $aFontProperties['font-family'] = $mValue;
            }
        }
        foreach ($aFontProperties as $sProperty => $mValue) {
            $oNewRule = new Rule($sProperty);
            $oNewRule->addValue($mValue);
            $oNewRule->setIsImportant($oRule->getIsImportant());
            $this->addRule($oNewRule);
        }
        $this->removeRule('font');
    }

    /*
     * Convert shorthand background declarations
     * (e.g. <tt>background: url("chess.png") gray 50% repeat fixed;</tt>)
     * into their constituent parts.
     * @see http://www.w3.org/TR/21/colors.html#propdef-background
     * */

    public function expandBackgroundShorthand() {
        $aRules = $this->getRulesAssoc();
        if (!isset($aRules['background']))
            return;
        $oRule = $aRules['background'];
        $aBgProperties = array(
            'background-color' => array('transparent'), 'background-image' => array('none'),
            'background-repeat' => array('repeat'), 'background-attachment' => array('scroll'),
            'background-position' => array(new Size(0, '%'), new Size(0, '%'))
        );
        $mRuleValue = $oRule->getValue();
        $aValues = array();
        if (!$mRuleValue instanceof RuleValueList) {
            $aValues[] = $mRuleValue;
        } else {
            $aValues = $mRuleValue->getListComponents();
        }
        if (count($aValues) == 1 && $aValues[0] == 'inherit') {
            foreach ($aBgProperties as $sProperty => $mValue) {
                $oNewRule = new Rule($sProperty);
                $oNewRule->addValue('inherit');
                $oNewRule->setIsImportant($oRule->getIsImportant());
                $this->addRule($oNewRule);
            }
            $this->removeRule('background');
            return;
        }
        $iNumBgPos = 0;
        foreach ($aValues as $mValue) {
            if (!$mValue instanceof Value) {
                $mValue = mb_strtolower($mValue);
            }
            if ($mValue instanceof URL) {
                $aBgProperties['background-image'] = $mValue;
            } else if ($mValue instanceof Color) {
                $aBgProperties['background-color'] = $mValue;
            } else if (in_array($mValue, array('scroll', 'fixed'))) {
                $aBgProperties['background-attachment'] = $mValue;
            } else if (in_array($mValue, array('repeat', 'no-repeat', 'repeat-x', 'repeat-y'))) {
                $aBgProperties['background-repeat'] = $mValue;
            } else if (in_array($mValue, array('left', 'center', 'right', 'top', 'bottom'))
                || $mValue instanceof Size
            ) {
                if ($iNumBgPos == 0) {
                    $aBgProperties['background-position'][0] = $mValue;
                    $aBgProperties['background-position'][1] = 'center';
                } else {
                    $aBgProperties['background-position'][$iNumBgPos] = $mValue;
                }
                $iNumBgPos++;
            }
        }
        foreach ($aBgProperties as $sProperty => $mValue) {
            $oNewRule = new Rule($sProperty);
            $oNewRule->setIsImportant($oRule->getIsImportant());
            $oNewRule->addValue($mValue);
            $this->addRule($oNewRule);
        }
        $this->removeRule('background');
    }

    public function expandListStyleShorthand() {
        $aListProperties = array(
            'list-style-type' => 'disc',
            'list-style-position' => 'outside',
            'list-style-image' => 'none'
        );
        $aListStyleTypes = array(
            'none', 'disc', 'circle', 'square', 'decimal-leading-zero', 'decimal',
            'lower-roman', 'upper-roman', 'lower-greek', 'lower-alpha', 'lower-latin',
            'upper-alpha', 'upper-latin', 'hebrew', 'armenian', 'georgian', 'cjk-ideographic',
            'hiragana', 'hira-gana-iroha', 'katakana-iroha', 'katakana'
        );
        $aListStylePositions = array(
            'inside', 'outside'
        );
        $aRules = $this->getRulesAssoc();
        if (!isset($aRules['list-style']))
            return;
        $oRule = $aRules['list-style'];
        $mRuleValue = $oRule->getValue();
        $aValues = array();
        if (!$mRuleValue instanceof RuleValueList) {
            $aValues[] = $mRuleValue;
        } else {
            $aValues = $mRuleValue->getListComponents();
        }
        if (count($aValues) == 1 && $aValues[0] == 'inherit') {
            foreach ($aListProperties as $sProperty => $mValue) {
                $oNewRule = new Rule($sProperty);
                $oNewRule->addValue('inherit');
                $oNewRule->setIsImportant($oRule->getIsImportant());
                $this->addRule($oNewRule);
            }
            $this->removeRule('list-style');
            return;
        }
        foreach ($aValues as $mValue) {
            if (!$mValue instanceof Value) {
                $mValue = mb_strtolower($mValue);
            }
            if ($mValue instanceof Url) {
                $aListProperties['list-style-image'] = $mValue;
            } else if (in_array($mValue, $aListStyleTypes)) {
                $aListProperties['list-style-types'] = $mValue;
            } else if (in_array($mValue, $aListStylePositions)) {
                $aListProperties['list-style-position'] = $mValue;
            }
        }
        foreach ($aListProperties as $sProperty => $mValue) {
            $oNewRule = new Rule($sProperty);
            $oNewRule->setIsImportant($oRule->getIsImportant());
            $oNewRule->addValue($mValue);
            $this->addRule($oNewRule);
        }
        $this->removeRule('list-style');
    }

    public function createShorthandProperties(array $aProperties, $sShorthand) {
        $aRules = $this->getRulesAssoc();
        $aNewValues = array();
        foreach ($aProperties as $sProperty) {
            if (!isset($aRules[$sProperty]))
                continue;
            $oRule = $aRules[$sProperty];
            if (!$oRule->getIsImportant()) {
                $mRuleValue = $oRule->getValue();
                $aValues = array();
                if (!$mRuleValue instanceof RuleValueList) {
                    $aValues[] = $mRuleValue;
                } else {
                    $aValues = $mRuleValue->getListComponents();
                }
                foreach ($aValues as $mValue) {
                    $aNewValues[] = $mValue;
                }
                $this->removeRule($sProperty);
            }
        }
        if (count($aNewValues)) {
            $oNewRule = new Rule($sShorthand);
            foreach ($aNewValues as $mValue) {
                $oNewRule->addValue($mValue);
            }
            $this->addRule($oNewRule);
        }
    }

    public function createBackgroundShorthand() {
        $aProperties = array(
            'background-color', 'background-image', 'background-repeat',
            'background-position', 'background-attachment'
        );
        $this->createShorthandProperties($aProperties, 'background');
    }

    public function createListStyleShorthand() {
        $aProperties = array(
            'list-style-type', 'list-style-position', 'list-style-image'
        );
        $this->createShorthandProperties($aProperties, 'list-style');
    }

    /**
     * Combine border-color, border-style and border-width into border
     * Should be run after create_dimensions_shorthand!
     * */
    public function createBorderShorthand() {
        $aProperties = array(
            'border-width', 'border-style', 'border-color'
        );
        $this->createShorthandProperties($aProperties, 'border');
    }

    /*
     * Looks for long format CSS dimensional properties
     * (margin, padding, border-color, border-style and border-width)
     * and converts them into shorthand CSS properties.
     * */

    public function createDimensionsShorthand() {
        $aPositions = array('top', 'right', 'bottom', 'left');
        $aExpansions = array(
            'margin' => 'margin-%s',
            'padding' => 'padding-%s',
            'border-color' => 'border-%s-color',
            'border-style' => 'border-%s-style',
            'border-width' => 'border-%s-width'
        );
        $aRules = $this->getRulesAssoc();
        foreach ($aExpansions as $sProperty => $sExpanded) {
            $aFoldable = array();
            foreach ($aRules as $sRuleName => $oRule) {
                foreach ($aPositions as $sPosition) {
                    if ($sRuleName == sprintf($sExpanded, $sPosition)) {
                        $aFoldable[$sRuleName] = $oRule;
                    }
                }
            }
            // All four dimensions must be present
            if (count($aFoldable) == 4) {
                $aValues = array();
                foreach ($aPositions as $sPosition) {
                    $oRule = $aRules[sprintf($sExpanded, $sPosition)];
                    $mRuleValue = $oRule->getValue();
                    $aRuleValues = array();
                    if (!$mRuleValue instanceof RuleValueList) {
                        $aRuleValues[] = $mRuleValue;
                    } else {
                        $aRuleValues = $mRuleValue->getListComponents();
                    }
                    $aValues[$sPosition] = $aRuleValues;
                }
                $oNewRule = new Rule($sProperty);
                if ((string) $aValues['left'][0] == (string) $aValues['right'][0]) {
                    if ((string) $aValues['top'][0] == (string) $aValues['bottom'][0]) {
                        if ((string) $aValues['top'][0] == (string) $aValues['left'][0]) {
                            // All 4 sides are equal
                            $oNewRule->addValue($aValues['top']);
                        } else {
                            // Top and bottom are equal, left and right are equal
                            $oNewRule->addValue($aValues['top']);
                            $oNewRule->addValue($aValues['left']);
                        }
                    } else {
                        // Only left and right are equal
                        $oNewRule->addValue($aValues['top']);
                        $oNewRule->addValue($aValues['left']);
                        $oNewRule->addValue($aValues['bottom']);
                    }
                } else {
                    // No sides are equal
                    $oNewRule->addValue($aValues['top']);
                    $oNewRule->addValue($aValues['left']);
                    $oNewRule->addValue($aValues['bottom']);
                    $oNewRule->addValue($aValues['right']);
                }
                $this->addRule($oNewRule);
                foreach ($aPositions as $sPosition) {
                    $this->removeRule(sprintf($sExpanded, $sPosition));
                }
            }
        }
    }

    /**
     * Looks for long format CSS font properties (e.g. <tt>font-weight</tt>) and
     * tries to convert them into a shorthand CSS <tt>font</tt> property.
     * At least font-size AND font-family must be present in order to create a shorthand declaration.
     * */
    public function createFontShorthand() {
        $aFontProperties = array(
            'font-style', 'font-variant', 'font-weight', 'font-size', 'line-height', 'font-family'
        );
        $aRules = $this->getRulesAssoc();
        if (!isset($aRules['font-size']) || !isset($aRules['font-family'])) {
            return;
        }
        $oNewRule = new Rule('font');
        foreach (array('font-style', 'font-variant', 'font-weight') as $sProperty) {
            if (isset($aRules[$sProperty])) {
                $oRule = $aRules[$sProperty];
                $mRuleValue = $oRule->getValue();
                $aValues = array();
                if (!$mRuleValue instanceof RuleValueList) {
                    $aValues[] = $mRuleValue;
                } else {
                    $aValues = $mRuleValue->getListComponents();
                }
                if ($aValues[0] !== 'normal') {
                    $oNewRule->addValue($aValues[0]);
                }
            }
        }
        // Get the font-size value
        $oRule = $aRules['font-size'];
        $mRuleValue = $oRule->getValue();
        $aFSValues = array();
        if (!$mRuleValue instanceof RuleValueList) {
            $aFSValues[] = $mRuleValue;
        } else {
            $aFSValues = $mRuleValue->getListComponents();
        }
        // But wait to know if we have line-height to add it
        if (isset($aRules['line-height'])) {
            $oRule = $aRules['line-height'];
            $mRuleValue = $oRule->getValue();
            $aLHValues = array();
            if (!$mRuleValue instanceof RuleValueList) {
                $aLHValues[] = $mRuleValue;
            } else {
                $aLHValues = $mRuleValue->getListComponents();
            }
            if ($aLHValues[0] !== 'normal') {
                $val = new RuleValueList('/');
                $val->addListComponent($aFSValues[0]);
                $val->addListComponent($aLHValues[0]);
                $oNewRule->addValue($val);
            }
        } else {
            $oNewRule->addValue($aFSValues[0]);
        }
        $oRule = $aRules['font-family'];
        $mRuleValue = $oRule->getValue();
        $aFFValues = array();
        if (!$mRuleValue instanceof RuleValueList) {
            $aFFValues[] = $mRuleValue;
        } else {
            $aFFValues = $mRuleValue->getListComponents();
        }
        $oFFValue = new RuleValueList(',');
        $oFFValue->setListComponents($aFFValues);
        $oNewRule->addValue($oFFValue);

        $this->addRule($oNewRule);
        foreach ($aFontProperties as $sProperty) {
            $this->removeRule($sProperty);
        }
    }

    public function __toString() {
        $sResult = implode(', ', $this->aSelectors) . ' {';
        $sResult .= parent::__toString();
        $sResult .= '}' . "\n";
        return $sResult;
    }

}
