<?php

abstract class Value {

    public abstract function __toString();
}

abstract class ValueList extends Value {

    protected $aComponents;
    protected $sSeparator;

    public function __construct($aComponents = array(), $sSeparator = ',') {
        if (!is_array($aComponents)) {
            $aComponents = array($aComponents);
        }
        $this->aComponents = $aComponents;
        $this->sSeparator = $sSeparator;
    }

    public function addListComponent($mComponent) {
        $this->aComponents[] = $mComponent;
    }

    public function getListComponents() {
        return $this->aComponents;
    }

    public function setListComponents($aComponents) {
        $this->aComponents = $aComponents;
    }

    public function getListSeparator() {
        return $this->sSeparator;
    }

    public function setListSeparator($sSeparator) {
        $this->sSeparator = $sSeparator;
    }

    function __toString() {
        return implode($this->sSeparator, $this->aComponents);
    }

}

abstract class PrimitiveValue extends Value {

}

class URL extends PrimitiveValue {

    private $oURL;

    public function __construct(String $oURL) {
        $this->oURL = $oURL;
    }

    public function setURL(String $oURL) {
        $this->oURL = $oURL;
    }

    public function getURL() {
        return $this->oURL;
    }

    public function __toString() {
        return "url({$this->oURL->__toString()})";
    }

}

class String extends PrimitiveValue {

    private $sString;

    public function __construct($sString) {
        $this->sString = $sString;
    }

    public function setString($sString) {
        $this->sString = $sString;
    }

    public function getString() {
        return $this->sString;
    }

    public function __toString() {
//        $sString = addslashes($this->sString);
//         去掉反斜线 会将src="a" => src="\"a\""
        $sString = trim($this->sString, '"');
        $sString = str_replace("\n", '\A', $sString);
        return '"' . $sString . '"';
    }

}

class Size extends PrimitiveValue {

    const ABSOLUTE_SIZE_UNITS = 'px/cm/mm/mozmm/in/pt/pc/vh/vw/vm/vmin/vmax/rem'; //vh/vw/vm(ax)/vmin/rem are absolute insofar as they don’t scale to the immediate parent (only the viewport)
    const RELATIVE_SIZE_UNITS = '%/em/ex/ch';
    const NON_SIZE_UNITS = 'deg/grad/rad/s/ms/turns/Hz/kHz';

    private $fSize;
    private $sUnit;
    private $bIsColorComponent;

    public function __construct($fSize, $sUnit = null, $bIsColorComponent = false) {
        $this->fSize = floatval($fSize);
        $this->sUnit = $sUnit;
        $this->bIsColorComponent = $bIsColorComponent;
    }

    public function setUnit($sUnit) {
        $this->sUnit = $sUnit;
    }

    public function getUnit() {
        return $this->sUnit;
    }

    public function setSize($fSize) {
        $this->fSize = floatval($fSize);
    }

    public function getSize() {
        return $this->fSize;
    }

    public function isColorComponent() {
        return $this->bIsColorComponent;
    }

    /**
     * Returns whether the number stored in this Size really represents a size (as in a length of something on screen).
     * @return false if the unit an angle, a duration, a frequency or the number is a component in a Color object.
     */
    public function isSize() {
        if (in_array($this->sUnit, explode('/', self::NON_SIZE_UNITS))) {
            return false;
        }
        return !$this->isColorComponent();
    }

    public function isRelative() {
        if (in_array($this->sUnit, explode('/', self::RELATIVE_SIZE_UNITS))) {
            return true;
        }
        if ($this->sUnit === null && $this->fSize != 0) {
            return true;
        }
        return false;
    }

    public function __toString() {
        $l = localeconv();
//        return str_replace(array($l['decimal_point'], '0.'), '.', $this->fSize) . ($this->sUnit === null ? '' : $this->sUnit);
        // 阻止将10.5px转为1.5px, by javey
        return str_replace(array($l['decimal_point']), '.', $this->fSize) . ($this->sUnit === null ? '' : $this->sUnit);
    }

}

class RuleValueList extends ValueList {

    public function __construct($sSeparator = ',') {
        parent::__construct(array(), $sSeparator);
    }

}

class CSSFunction extends ValueList {

    private $sName;

    public function __construct($sName, $aArguments, $sSeparator = ',') {
        if($aArguments instanceof RuleValueList) {
            $sSeparator = $aArguments->getListSeparator();
            $aArguments = $aArguments->getListComponents();
        }
        $this->sName = $sName;
        parent::__construct($aArguments, $sSeparator);
    }

    public function getName() {
        return $this->sName;
    }

    public function setName($sName) {
        $this->sName = $sName;
    }

    public function getArguments() {
        return $this->aComponents;
    }

    public function __toString() {
        $aArguments = parent::__toString();
        return "{$this->sName}({$aArguments})";
    }

}

class Color extends CSSFunction {

    public function __construct($aColor) {
        parent::__construct(implode('', array_keys($aColor)), $aColor);
    }

    public function getColor() {
        return $this->aComponents;
    }

    public function setColor($aColor) {
        $this->setName(implode('', array_keys($aColor)));
        $this->aComponents = $aColor;
    }

    public function getColorDescription() {
        return $this->getName();
    }

    public function __toString() {
        // Shorthand RGB color values
        // TODO: Include in output settings (once they’re done)
        if(implode('', array_keys($this->aComponents)) === 'rgb') {
            $sResult = sprintf(
                '%02x%02x%02x',
                $this->aComponents['r']->__toString(),
                $this->aComponents['g']->__toString(),
                $this->aComponents['b']->__toString()
            );
            return '#'.(($sResult[0] == $sResult[1]) && ($sResult[2] == $sResult[3]) && ($sResult[4] == $sResult[5]) ? "$sResult[0]$sResult[2]$sResult[4]" : $sResult);
        }
        return parent::__toString();
    }
}

