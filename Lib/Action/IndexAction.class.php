<?php
/**
 * Created by JetBrains PhpStorm. 前端入口
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午10:43
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action {
    public function index() {
        $this->show('index');
    }
}