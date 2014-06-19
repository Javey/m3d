<?php
/**
 * Created by JetBrains PhpStorm. 增量编译，依赖svn
 * User: zoujiawei
 * Date: 14-3-19
 * Time: 下午12:17
 * To change this template use File | Settings | File Templates.
 */

require_once('IncreMap.class.php');

on('process_start', 'IncreProcess');
on('rm_old_build_file', 'IncreProcessPlugin::remain');
on('one_process_start', 'IncreProcessPlugin::importMap');
on('processor_fetch_files', 'IncreProcessPlugin::getFileList');
on('change_file', 'IncreProcessPlugin::updateChangeList');

class IncreProcessPlugin extends Plugin {
    // 改变的文件，分为三类
    const MODIFY = 'M';
    const ADD = 'A';
    const DELETE = 'D';

    // 保存改变的文件
    private static $files = array(
        self::MODIFY => array(),
        self::ADD => array(),
        self::DELETE => array()
    );

    protected $options = array(
        // 由于存在m3d_path变量，用C方法取值
        'incre.is_incre' => false,
        'incre.path' => '{SRC.M3D_PATH}/incre',
        'incre.cache_dir' => '{incre.path}/cache',
        'incre.map_filename' => 'file_belong_map.php',
        'incre.md5_filename' => 'imerge_md5.php',
        'incre.ver_filename' => 'version'
    );

    public function run($params) {
//        $oldRevision = 117093;
        $oldRevision = self::getPrevRevision();
//        $oldRevision = null;

        if ((isset($_GET['isIncre']) && $_GET['isIncre'] === 'false') || !C('INCRE.IS_INCRE') || is_null($oldRevision)) {
            // 事件解绑
            off('rm_old_build_file', 'IncreProcessPlugin::remain');
            off('one_process_start', 'IncreProcessPlugin::importMap');
            off('processor_fetch_files', 'IncreProcessPlugin::getFileList');
        } else {
            mark('增量编译准备中...', 'emphasize');
            $newRevision = IncreMap::getRevision();
            self::$files = self::getChangeList($newRevision, $oldRevision);
            IncreMap::loadBelongMap();
            if (!empty(self::$files[self::DELETE])) {
                IncreMap::rebuildBelongMap(self::$files[self::DELETE]);
            }
            // 更新modify列表
            self::$files[self::MODIFY] = array_unique(
                array_merge(
                    self::$files[self::MODIFY],
                    IncreMap::getAffectList(self::$files[self::MODIFY])
                )
            );
        }
    }

    /**
     * 保留上次编译结果
     * @param $params
     */
    public static function remain($params) {
        $params[1]->return = false;
    }

    /**
     * 导入map
     * @param $params
     */
    public static function importMap($params) {
        $tool = $params[1];
        $item = $params[2];
        if (empty($item['name'])) {
            $item['name'] = $item['processor'];
        }
        $path = C('SRC.M3D_MAP_PATH').'/'.$item['name'].C('SRC.M3D_MAP_SUFFIX').'.php';
        $map = include $path;

        $types = comma_str_to_array($item['type']);
        $files = self::getFilesByActionsAndTypes(array(self::MODIFY, self::DELETE), $types);
        $map = self::cleanRedundant($map, $files);

        $tool->updateMap($item['name'], $map);
    }

    /**
     * 得到待编译的文件
     * @param $params
     */
    public static function getFileList($params) {
        $paths = $params[1];
        $types = $params[2];
        $ret = $params[3];
        $ret->return = array();

        // 若为sprite合图文件
        $spritePath = C('IMERGE_PATH').'/'.C('IMERGE_SPRITE_DIR');
        if ($paths === $spritePath) {
            $files = self::getChangeMergeImage();
            $files = array_merge($files[self::MODIFY], $files[self::ADD]);
            foreach ($files as $file) {
                $file = $spritePath.'/'.$file;
                array_push($ret->return, $file);
            }
        } else {
            $files = array_merge(self::$files[self::MODIFY], self::$files[self::ADD]);
            if (!empty($files)) {
                $paths = comma_str_to_array($paths);
                $types = comma_str_to_array($types);
                foreach ($paths as $path) {
                    $len = strlen($path);
                    foreach ($files as $file) {
                        if (substr($file, 0, $len) === $path && in_array(pathinfo($file, PATHINFO_EXTENSION), $types)) {
                            $file = C('SRC.SRC_PATH').$file;
                            array_push($ret->return, $file);
                        }
                    }
                }
            }
        }
    }

    /**
     * 获取上一个版本号
     * @return null|string
     */
    private static function getPrevRevision() {
        $file = C('INCRE.PATH').'/version';
        return file_exists($file) ? file_get_contents($file) : null;
    }

    /**
     * 获取两个版本号之间文件修改列表
     * 同时merge本地合图文件修改列表
     * @param $nVer
     * @param $oVer
     * @return array
     */
    private static function getChangeList($nVer, $oVer) {
        $ret = array();
        $cmd = 'cd '.C('SRC.SRC_PATH').' && '.C('SVN').' diff -r '.$oVer.':'.$nVer.' --summarize';
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

        // merge合图改变列表
        $ret = array_merge_recursive($ret, self::getChangeMergeImage());

        return $ret;
    }

    /**
     * 获取合图改变列表，并生成新的md5数据
     * @return array
     */
    private static function getChangeMergeImage() {
        static $ret = null;

        if (!is_null($ret)) {
            return $ret;
        }

        $ret = array(
            self::MODIFY => array(),
            self::ADD => array(),
            self::DELETE => array()
        );
        $file = C('INCRE.PATH').'/'.C('INCRE.MD5_FILENAME');
        $nData = IncreMap::getMd5Map();
        if (file_exists($file)) {
            $oData = include $file;
        }
        if (isset($oData)) {
            foreach ($nData as $key => $value) {
                $action = null;
                if (isset($oData[$key])) {
                    // 同一张图，md5不同，则表示已修改
                    if ($oData[$key] !== $value) {
                        $action = self::MODIFY;
                    }
                    // 从oData中删除，最后oData中剩下的值即为已删除的图片
                    unset($oData[$key]);
                } else {
                    // 不存在，则表示是新增
                    $action = self::ADD;
                }
                if (!is_null($action)) {
                    array_push($ret[$action], $key);
                }
            }
            $ret[self::DELETE] = array_map('basename', array_keys($oData));
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
//            $file = Tool::getVirtualPath($file);
            if (isset($map[$file])) {
                // 清除文件
                $path = C('SRC.BUILD_PATH').$map[$file];
                if (file_exists($path)) {
                    unlink($path);
                }
                $path = C('SRC.BUILD_CACHE_PATH').$map[$file];
                if (file_exists($path)) {
                    unlink($path);
                }
                // 清除map
                unset($map[$file]);
            }
        }

        return $map;
    }

    /**
     * 更新改变文件列表，用于手动触发
     * @param $action
     * @param $file
     */
    private static function updateChangeList($params) {
        $action = $params[1];
        $file = $params[2];
        if (!isset(self::$files[$action][$file])) {
            array_push(self::$files[$action], $file);
        }
    }
}