<?php
/**
 * 工程相关，即:music/play/piao这样的工程
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
        $ret = array_change_key_case(C('PROJECT.INFO'));
        $ret['master_name'] = C('MASTER_NAME');
        show_json($ret);
    }
}