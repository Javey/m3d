<?php
/**
 * Created by JetBrains PhpStorm. 与svn的一些交互逻辑
 * User: zoujiawei
 * Date: 14-3-25
 * Time: 下午11:01
 * To change this template use File | Settings | File Templates.
 */

on(array('process_start', 'imerge_start'), 'SvnOperator', 10);
on('process_end', 'SvnOperatorPlugin::ci', 10000);

class SvnOperatorPlugin extends Plugin {
    protected $options = array(
        'svnop.is_svn' => false
    );

    public function run($params) {
        if (!$this->options['svnop.is_svn']) {
            off('process_end', 'SvnOperatorPlugin::ci');
            return;
        }
        self::ciImerge();
        self::svnUp();
    }

    /**
     * 提交合图配置
     */

    public static function ciImerge() {
        mark('提交合图配置...', 'emphasize');
        self::localDelToSvn();
        $cmd = C('SVN').' add '.C('IMERGE_PATH').' --force && '.C('SVN').' ci '.C('IMERGE_PATH').' -m "Commit imerge by M3D"';
        shell_exec_ensure($cmd, false);
    }

    /**
     * 确保代码最新
     */
    public static function svnUp() {
        mark('执行svn up...', 'emphasize');
        self::cleanLocalChange();
        $cmd = C('SVN').' up '. C('SRC.ROOT');
        shell_exec_ensure($cmd, false);
    }

    public static function ci() {
        mark('执行svn提交操作...', 'emphasize');
        self::localDelToSvn();
        shell_exec_ensure(C('SVN').' add '.C('SRC.BUILD_PATH').' --force', false);
        shell_exec_ensure(C('SVN').' add '.C('SRC.M3D_PATH').' --force', false);
        shell_exec_ensure(C('SVN').' ci "'.C('SRC.ROOT').'" -m "commit by M3D"', false);
    }

    /**
     * 清除所有本地文件修改
     * 将以svn文件为准
     */
    private static function cleanLocalChange() {
        $cmd = 'cd '.C('SRC.SRC_PATH').' && '.C('SVN').' st';
        $ret = shell_exec_ensure($cmd, false);
        if (!$ret['status']) {
            $list = $ret['output'];
            $list = explode("\n", $list);
            if (!empty($list)) {
                foreach ($list as $item) {
                    // 前8位字符，表示状态信息，去掉
                    $item = trim(substr($item, 8));
                    if (!$item || ($item && $item[0] === '.')) {
                        continue;
                    }

//                    mark('忽略本地文件修改：'.$item, 'emphasize');
                    $item = C('SRC.SRC_PATH').'/'.$item;
                    if (is_dir($item)) {
                        rm_dir($item);
                    } else {
                        @unlink($item);
                    }
                }
            }
        }
    }

    /**
     * 将本地非svn方式删除的文件，在svn中删除
     */
    private static function localDelToSvn() {
        $cmd = 'cd '.C('SRC.ROOT').' && '.C('SVN').' st';
        $ret = shell_exec_ensure($cmd, false);
        if (!$ret['status']) {
            $list = $ret['output'];
            $list = explode("\n", $list);
            if (!empty($list)) {
                foreach ($list as $item) {
                    // 前8位字符，表示状态信息，去掉
                    $file = trim(substr($item, 8));
                    if (!$file || ($file && $file[0] === '.')) {
                        continue;
                    }
                    $action = trim(substr($item, 0, 7));
                    $action = $action[0];

                    if ($action === '!') {
                        $cmd = C('SVN').' del "'.C('SRC.ROOT').'/'.$file.'"';
                        shell_exec_ensure($cmd, false);
                    }
                }
            }
        }
    }
}