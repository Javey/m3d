<?php

abstract class CSSValueList extends CSSValue {
	protected $aComponents;
	protected $sSeparator;
	
	public function __construct($aComponents = array(), $sSeparator = ',') {
		if($aComponents instanceof CSSValueList && $aComponents->getListSeparator() === $sSeparator) {
			$aComponents = $aComponents->getListComponents();
		} else if(!is_array($aComponents)) {
			$aComponents = array($aComponents);
		}
		$this->aComponents = $aComponents;
		$this->sSeparator = $sSeparator;
	}

	public function addListComponent($mComponent) {
		$this->aComponents[] = $mComponent;
	}

	public function getListComponents() {
		return $this->aComponents;//unicode
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

class CSSRuleValueList extends CSSValueList {
	public function __construct($sSeparator = ',') {
		parent::__construct(array(), $sSeparator);
	}
}

class CSSFunction extends CSSValueList {
	private $sName;
	public function __construct($sName, $aArguments) {
		$this->sName = $sName;
		parent::__construct($aArguments);
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

class CSSColor extends CSSFunction {
	
	private $hex = array();
	
	public function __construct($aColor,$sign = '') {
		if($sign == '#'){
			//此处用于如果在new CSSColor() 时，设置了$sign标识为"#",则设置成16进制表示颜色，否则用默认的RGB表示
			//同时，该类在CSSParser.php文件LINE 352:parseColorValue() 中已经被拦截一次，即解析到"#"标识时，直接return初始的#16进制值，不做处理
			$this->hex = $aColor;
		}else{
			parent::__construct(implode('', array_keys($aColor)), $aColor);
		}
		//parent::__construct(implode('', array_keys($aColor)), $aColor);
		
		//modify by luoqin
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
			//this function add by luoqin reset the parent __toString()
			//add by luoqin
	 		//$aArguments = parent::__toString();
		if(!empty($this->hex)){
			return '#'.implode('',$this->hex);
		}else{
			return parent::__toString();
		}
	}
}


