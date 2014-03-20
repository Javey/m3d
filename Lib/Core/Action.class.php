<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */

abstract class Action {
    protected $view = null;
    protected $tVar = array();
    protected $method = 'get';

    public function __construct() {
        $this->method = isset($_GET['method']) ? $_GET['method'] : REQUEST_METHOD;
    }

    /**
     * 初始化视图
     */
    private function _initView() {
        if (!$this->view) {
            $this->view = M3d::instance('View');
        }
//        if ($this->tVar) {
            $this->view->assign('tplData', $this->tVar);
//        }
    }

    public function display($templateFile = null) {
        $this->_initView();
        $this->view->display($templateFile);
    }

    public function assign($name, $value='') {
        if (is_array($name)) {
            $this->tVar = array_merge($this->tVar, $name);
        } else {
            $this->tVar[$name] = $value;
        }
    }
    public function show($templateFile = null) {
        View::show($templateFile);
    }
}