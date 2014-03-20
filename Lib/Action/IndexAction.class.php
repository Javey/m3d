<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午10:43
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action {
    public function index() {
//        $modules = $this->_getModules();
//        $curBranches = $this->_getSites($modules);
//        uksort($curBranches, array($this, '_sortDir'));
//        $allBranches = $this->_getAllBranches($modules);
//
//        $this->assign('current_branches', $curBranches);
//        $this->assign('all_branches', $allBranches);
//        $this->assign('module', $modules);
//        $this->display();
        $this->show('Testindex/index.html');
    }

    private function _getSites($modules) {
        $sitePath = C('SITE_PATH');
        $ret = array();
        if (empty($sitePath)) {
            halt('没有定义存放分支站点的目录：SITE_PATH');
        }
        $entries = glob($sitePath.'*');
        if ($entries) {
            foreach ($entries as $entry) {
                $siteName = basename($entry);

                if (is_dir($entry) && $siteName !== C('SITE_TEMP_DIR') && file_exists($entry.'/'.C('SITE_CONFIG_FILE'))) {

                    $branch = array();
                    foreach ($modules as $key => $value) {
                        $path = $entry .'/src/'.($value['ln_name'] ? $value['ln_name'] : $key);
                        $branch[$key] = basename(realpath($path));
                    }

                    $info = $this->_getSiteInfo($siteName);
                    array_merge($branch, $info);

                    $ret[$siteName] = $branch;
                }
            }
        }

        return $ret;
    }

    private function _getModules() {
        $model = new ModuleModel('users');
        return $model->getModules();
    }

    /**
     * 得到当前分支站点的一些附加信息，如备注
     */
    private function _getSiteInfo($site) {
        return array(
            'pj_name'=> 'test',
            'remark' => 'test too'
        );
    }

    private function _getAllBranches($modules) {
        $ret = array();
        foreach ($modules as $key => $value) {
            $path = ($value['type'] == 'rd' ? C('RD_BRANCH_PATH') : C('FE_BRANCH_PATH')).'/'.$key;
            $branches = array('trunk' => 'trunk');
            if (is_dir($path)) {
                foreach(scandir($path) as $branch) {
                    if ($branch[0] !== '.') {
                        $branches[$branch] = $branch;
                    }
                }
            }
            $ret[$key]['branch'] = $branches;
            $ret[$key]['title'] = ($value['title'] ? $value['title'] : $key);
        }

        return $ret;
    }

    private function _sortDir($a, $b) {
        $sitePath = C('SITE_PATH');
        $a = filectime($sitePath.$a);
        $b = filectime($sitePath.$b);
        return ($a == $b) ? 0 : ($a > $b) ? -1 : 1;
    }
}