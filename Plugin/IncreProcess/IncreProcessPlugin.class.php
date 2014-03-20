<?php
/**
 * Created by JetBrains PhpStorm. 增量编译，依赖svn
 * User: zoujiawei
 * Date: 14-3-19
 * Time: 下午12:17
 * To change this template use File | Settings | File Templates.
 */

require_once('FileBelong.class.php');

on('process_start', 'IncreProcess');
on('one_process_start', 'IncreProcessPlugin::importMap');
on('processor_fetch_files', 'IncreProcessPlugin::getFileList');

class IncreProcessPlugin extends Plugin {
    // 保存改变的文件
    private static $files = array();

    // 改变的文件，分为三类
    const MODIFY = 'M';
    const ADD = 'A';
    const DELETE = 'D';

    protected $options = array(
        // 由于存在m3d_path变量，用C方法取值
        'incre.is_incre' => true,
        'incre.path' => '{M3D_PATH}/incre',
        'incre.map_filename' => 'file_belong_map.php'
    );

    public function run($params) {
        mark('增量编译准备中...', 'emphasize');
        $this->svnUp();
        $newRevision = $this->getLatestRevision();
        $oldRevision = 117093; //$this->prevRevision();

        if (is_null($oldRevision)) {
            // 事件解绑
            off('one_process_start', 'IncreProcessPlugin::importMap');
            off('processor_fetch_files', 'IncreProcessPlugin::getFileList');
            $this->prevRevision($newRevision);
        } else {
            self::$files = $this->getChangeList($newRevision, $oldRevision);
            FileBelong::load();
            if (!empty(self::$files[self::DELETE])) {
                FileBelong::rebuildMap(self::$files[self::DELETE]);
            }
            // 更新modify列表
            self::$files[self::MODIFY] = array_unique(
                array_merge(
                    self::$files[self::MODIFY],
                    FileBelong::getAffectList(self::$files[self::MODIFY])
                )
            );
        }
    }

    public static function importMap($params) {
        $tool = $params[1];
        $item = $params[2];
        if (empty($item['name'])) {
            $item['name'] = $item['processor'];
        }
        $path = C('M3D_MAP_PATH').'/'.$item['name'].C('M3D_MAP_SUFFIX').'.php';
        $map = include $path;

        $types = comma_str_to_array($item['type']);
        $files = self::getFilesByActionsAndTypes(array(self::ADD, self::DELETE), $types);
        $map = self::cleanRedundant($map, $files);

        $tool->updateMap($item['name'], $map);
    }

    public static function getFileList($params) {
        $paths = $params[1];
        $types = $params[2];
        $ret = $params[3];
        $ret->list = array();

        $files = array_merge(self::$files[self::MODIFY], self::$files[self::ADD]);
        if (!empty($files)) {
            $paths = comma_str_to_array($paths);
            $types = comma_str_to_array($types);
            foreach ($paths as $path) {
                $len = strlen($path);
                foreach ($files as $file) {
                    if (substr($file, 0, $len) === $path &&
                        ($info = pathinfo($file)) &&
                        isset($info['extension']) &&
                        in_array($info['extension'], $types)
                    ) {
                        $file = C('SRC_SRC_PATH').$file;
                        array_push($ret->list, $file);
                    }
                }
            }
        }
    }

    /**
     * 确保代码最新
     */
    private function svnUp() {
        $this->cleanLocalChange();
        $cmd = C('SVN').' up '. C('SRC_ROOT');
        shell_exec_ensure($cmd, false);
    }

    /**
     * 清除所有本地文件修改
     * 将以svn文件为准
     */
    private function cleanLocalChange() {
        $cmd = 'cd '.C('SRC_SRC_PATH').' && '.C('SVN').' st';
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

                    mark('忽略本地文件修改：'.$item, 'emphasize');
                    $item = C('SRC_SRC_PATH').'/'.$item;
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
     * 获取最新版本号
     * @return int|null
     */
    private function getLatestRevision() {
        $cmd = 'cd '.C('SRC_SRC_PATH').' && '.C('SVN').' info --xml';
        $info = shell_exec_ensure($cmd, false);
        if (!$info['status']) {
            $info = $info['output'];
            $info = simplexml_load_string($info);
            $revision = $info->entry->commit->attributes()->revision;
            return (int)$revision;
        }
        return null;
    }

    /**
     * 设置/获取上一个版本号
     * @param null $revision
     * @return null|string
     */
    private function prevRevision($revision=null) {
        $file = C('INCRE.PATH').'/version';
        if (!is_null($revision)) {
            contents_to_file($file, $revision);
            return $revision;
        } else {
            return file_exists($file) ? file_get_contents($file) : null;
        }
    }

    /**
     * 获取两个版本号之间文件修改列表
     * 同时merge本地合图文件修改列表
     * @param $nVer
     * @param $oVer
     * @return array
     */
    private function getChangeList($nVer, $oVer) {
        $ret = array();
        $cmd = 'cd '.C('SRC_SRC_PATH').' && '.C('SVN').' diff -r '.$oVer.':'.$nVer.' --summarize';
        $list = shell_exec_ensure($cmd, false);

        if (!$list['status']) {
            $list = $list['output'];
            $list = explode("\n", $list);
            foreach ($list as $item) {
                if (!$item) {
                    continue;
                }
                $action = trim(substr($item, 0, 7));
                $action = $action[0];
                $file = trim(substr($item, 8));
                $file = '/'.$file;
                if (!isset($ret[$action])) {
                    $ret[$action] = array();
                }
                array_push($ret[$action], $file);
            }
        }

        return $ret;
    }

    /**
     * 根据action和type，找到所需的changelist
     * @param $actions
     * @param $types
     * @return array
     */
    private static function getFilesByActionsAndTypes($actions, $types) {
        $ret = array();
        $files = array();
        foreach ($actions as $action) {
            $files = array_merge($files, self::$files[$action]);
        }
        foreach ($files as $file) {
            if (in_array(pathinfo($file, PATHINFO_EXTENSION), $types)) {
                array_push($ret, $file);
            }
        }

        return $ret;
    }

    /**
     * 清除冗余的映射关系和文件
     * @param $map
     * @param $files
     * @return mixed
     */
    private static function cleanRedundant($map, $files) {
        foreach ($files as $file) {
            $file = Tool::getVirtualPath($file);
            if (isset($map[$file])) {
                // 清除文件
                $path = C('SRC_BUILD_PATH').$map[$file];
                if (file_exists($path)) {
                    shell_exec_ensure(C('SVN').' del '.$path.' --force', false, false);
                    unlink($path);
                }
                // 清除map
                unset($map[$file]);
            }
        }

        return $map;
    }
}