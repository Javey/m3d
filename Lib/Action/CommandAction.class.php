<?php
/**
 * Created by JetBrains PhpStorm.
 * User: javey
 * Date: 13-4-12
 * Time: 下午1:43
 * To change this template use File | Settings | File Templates.
 */

/**
 * 接受各种命令
 */
class CommandAction extends Action {
    private $opMap = array(
        'add_module' => 'addModule',
        'mobile_compile' => 'mobileCompile',
        'mobile_commit' => 'mobileCommit'
    );

    public function index() {
        $op = $_POST['op'];
        $op = $this->opMap[$op] ? $this->opMap[$op] : $op;

        call_user_func(array($this, $op));
    }

    /**
     * 根据$args重新建立软链
     * @param null $args
     */
    private function save() {
        $args = $this->getbranchesArg();

        $sitePath = C('SITE_PATH');
        $siteName = $_POST['branch_name'];

        foreach ($args as $key => $value) {
            // svn代码库软链
            $shell = 'cd '.$sitePath.$siteName.'/src && ln -snf '.$value.' '.$key;
            shell_exec_ensure($shell, false);
            // todo:同步代码库软链
        }
    }

    private function delete() {
        $siteName = $_POST['branch_name'];
        if ($siteName == C('SITE_TEMP_DIR')) {
            show_error(30001, '不允许删除模板站点', false);
            return;
        }
        shell_exec_ensure('rm -rf '. $siteName, false);
        $this->restart();
    }

    private function clear() {
        $shell = 'cd '.C('SITE_PATH').$_POST['branch_name'].' && rm -rf "/src/fe-main/tool/.cache" "wwwdata.build/fe/templates_c" "wwwdata.test/fe/template_c"';
        shell_exec_ensure($shell, false);
    }

    private function commit() {

    }

    /**
     * 新建分支
     */
    private function add() {
        $sitePath = C('SITE_PATH');
        $siteName = $_POST['branch_name'];
        // 复制template-branch
        $shell = 'cd '.$sitePath.' && cp -rf '.C('SITE_TEMP_DIR').' '.$siteName;
        shell_exec_ensure($shell, false);

        $this->save();
        // 替换站点配置branch.conf
        $shell = 'cd '.$sitePath.$siteName.' && sed -i "s/'.C('SITE_TEMP_DIR').'/'.$siteName.'/g '.C('SITE_CONFIG_FILE');
        shell_exec_ensure($shell, false);
        $this->restart();
    }

    private function addModule() {

    }

    private function restart() {
        shell_exec_ensure(C('RESTART_SHELL'), false);
    }

    private function mobileCompile() {
//        $shell = '~/luoqin/local/php/bin/php -c ~/luoqin/local/php/etc/php.ini ~/music/resources/m3dsrc/process.php mobile #org_branch_name# false false';

    }

    private function mobileCommit() {

    }

    /**
     * 得到svn分支参数
     * @return array
     */
    private function getbranchesArg() {
        $model = new ModuleModel('users');
        $modules = $model->getModules();

        $ret = array();
        foreach ($modules as $module => $value) {
            $branch = $_POST[$module];

            if ($branch == 'trunk') {
                $branch = ($value['type'] == 'rd' ? C('RD_TRUNK_PATH') : C('FE_TRUNK_PATH')).$module;
            } else {
                $branch = ($value['type'] == 'rd' ? C('RD_BRANCH_PATH') : C('FE_BRANCH_PATH')).$module.'/'.$branch;
            }

            $ret[$value['ln_name']] = $branch;
        }

        return $ret;
    }
}