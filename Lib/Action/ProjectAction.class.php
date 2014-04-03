<?php
/**
 * Created by JetBrains PhpStorm. 工程相关
 * User: zoujiawei
 * Date: 14-3-31
 * Time: 下午9:02
 * To change this template use File | Settings | File Templates.
 */

class ProjectAction extends Action {
    public function info() {
        switch ($this->method) {
            case 'get':
                $this->getInfo();
                break;
        }
    }

    private function getInfo() {
        show_json(array_change_key_case(C('PROJECT.INFO')));
    }
}