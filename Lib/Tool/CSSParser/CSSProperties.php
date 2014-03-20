<?php

interface AtRule {
    const BLOCK_RULES = 'media/document/supports/region-style/font-feature-values';
    // Since there are more set rules than block rules, we’re whitelisting the block rules and have anything else be treated as a set rule.
    const SET_RULES = 'font-face/counter-style/page/swash/styleset/annotation'; //…and more font-specific ones (to be used inside font-feature-values)

    public function atRuleName();
    public function atRuleArgs();
    public function __toString();
}

class Charset implements AtRule {

    private $sCharset;

    public function __construct($sCharset) {
        $this->sCharset = $sCharset;
    }

    public function setCharset($sCharset) {
        $this->sCharset = $sCharset;
    }

    public function getCharset() {
        return $this->sCharset;
    }

    public function __toString() {
        return "@charset {$this->sCharset->__toString()};";
    }

    public function atRuleName() {
        return 'charset';
    }

    public function atRuleArgs() {
        return $this->sCharset;
    }
}

class CSSNamespace implements AtRule {
    private $mUrl;
    private $sPrefix;

    public function __construct($mUrl, $sPrefix = null) {
        $this->mUrl = $mUrl;
        $this->sPrefix = $sPrefix;
    }

    public function __toString() {
        return '@namespace '.($this->sPrefix === null ? '' : $this->sPrefix.' ').$this->mUrl->__toString().';';
    }

    public function getUrl() {
        return $this->mUrl;
    }

    public function getPrefix() {
        return $this->sPrefix;
    }

    public function setUrl($mUrl) {
        $this->mUrl = $mUrl;
    }

    public function setPrefix($sPrefix) {
        $this->sPrefix = $sPrefix;
    }

    public function atRuleName() {
        return 'namespace';
    }

    public function atRuleArgs() {
        $aResult = array($this->mUrl);
        if($this->sPrefix) {
            array_unshift($aResult, $this->sPrefix);
        }
        return $aResult;
    }
}

class Import implements AtRule {
    private $oLocation;
    private $sMediaQuery;
    private $removeImport = FALSE;
    //remove import property for merge css content add by lq @20121201

    public function __construct(URL $oLocation, $sMediaQuery) {
        $this->oLocation = $oLocation;
        $this->sMediaQuery = $sMediaQuery;
    }

    public function setRemoveImport($remove = TRUE) {
        $this->removeImport = $remove;
    }

    public function setLocation($oLocation) {
        $this->oLocation = $oLocation;
    }

    public function getLocation() {
        return $this->oLocation;
    }

    public function __toString() {
        if($this->removeImport){
            return '';
        }
        return "@import ".$this->oLocation->__toString().($this->sMediaQuery === null ? '' : ' '.$this->sMediaQuery).';';
    }

    public function atRuleName() {
        return 'import';
    }

    public function atRuleArgs() {
        $aResult = array($this->oLocation);
        if($this->sMediaQuery) {
            array_push($aResult, $this->sMediaQuery);
        }
        return $aResult;
    }
}

class Selector {

    const
        NON_ID_ATTRIBUTES_AND_PSEUDO_CLASSES_RX = '/
			(\.[\w]+)										 # classes
			|
			\[(\w+)											 # attributes
			|
			(\:(												 # pseudo classes
				link|visited|active
				|hover|focus
				|lang
				|target
				|enabled|disabled|checked|indeterminate
				|root
				|nth-child|nth-last-child|nth-of-type|nth-last-of-type
				|first-child|last-child|first-of-type|last-of-type
				|only-child|only-of-type
				|empty|contains
			))
		/ix',
        ELEMENTS_AND_PSEUDO_ELEMENTS_RX = '/
			((^|[\s\+\>\~]+)[\w]+ # elements
			|
			\:{1,2}(								 # pseudo-elements
				after|before
				|first-letter|first-line
				|selection
			)
		)/ix';

    private $sSelector;
    private $iSpecificity;

    public function __construct($sSelector, $bCalculateSpecificity = false) {
        $this->setSelector($sSelector);
        if ($bCalculateSpecificity) {
            $this->getSpecificity();
        }
    }

    public function getSelector() {
        return $this->sSelector;
    }

    public function setSelector($sSelector) {
        $this->sSelector = trim($sSelector);
        $this->iSpecificity = null;
    }

    public function __toString() {
        return $this->getSelector();
    }

    public function getSpecificity() {
        if ($this->iSpecificity === null) {
            $a = 0;
            /// @todo should exclude \# as well as "#"
            $aMatches;
            $b = substr_count($this->sSelector, '#');
            $c = preg_match_all(self::NON_ID_ATTRIBUTES_AND_PSEUDO_CLASSES_RX, $this->sSelector, $aMatches);
            $d = preg_match_all(self::ELEMENTS_AND_PSEUDO_ELEMENTS_RX, $this->sSelector, $aMatches);
            $this->iSpecificity = ($a * 1000) + ($b * 100) + ($c * 10) + $d;
        }
        return $this->iSpecificity;
    }

}
