<?php
/**
 * Created by JetBrains PhpStorm. 提供用于增量编译的各种数据
 * User: zoujiawei
 * Date: 14-3-19
 * Time: 下午3:37
 * To change this template use File | Settings | File Templates.
 */

on('process_start', 'IncreMap::init');
on(
    array(
        'css_import',
        'css_background_change',
        'js_import',
        'html_href_change'
    ),
    'IncreMap::update'
);
on('process_end', 'IncreMap::export');

class IncreMap {
    // 依赖链表
    // 保存某一文件改变会影响其他文件的map，
    private static $belongMap = array();
    private static $md5Map = array();
    private static $revision = null;

    public static function init() {
        mark('init');
        self::genMd5Map();
        self::genLatestRevision();
    }

    public static function update($params) {
        $event = $params[0];
        $processor = $params[1];
        $value = $processor->getRelativePath();
        $key = $params[2];

        switch ($event) {
            case 'css_import':
            case 'js_import':
                $key = $key->getRelativePath();
                break;
        }

        self::updateMap($key, $value);
    }

    /**
     * 导出配置
     * 包括belongMap,md5Map,revision
     */
    public static function export() {
        $path = C('INCRE.PATH').'/'.C('INCRE.MAP_FILENAME');
        contents_to_file($path, MergeConfigWriter::configStringify(self::$belongMap));

        $path = C('INCRE.PATH').'/'.C('INCRE.MD5_FILENAME');
        contents_to_file($path, MergeConfigWriter::configStringify(self::$md5Map));

        $path = C('INCRE.PATH').'/'.C('INCRE.VER_FILENAME');
        contents_to_file($path, self::$revision);
    }

    public static function loadBelongMap() {
        $path = C('INCRE.PATH').'/'.C('INCRE.MAP_FILENAME');
        if (file_exists($path)) {
            self::$belongMap = include($path);
        }
    }

    public static function getBelongMap() {
        return self::$belongMap;
    }

    public static function getMd5Map() {
        return self::$md5Map;
    }

    public static function getRevision() {
        return self::$revision;
    }

    /**
     * 根据删除文件列表，重建map
     * @param $files
     */
    public static function rebuildBelongMap($files) {
        // 建立一个belongMap的反向map
        $containMap = array();
        foreach (self::$belongMap as $path => $values) {
            foreach ($values as $index => $value) {
                if (!isset($containMap[$value])) {
                    $containMap[$value] = array();
                }

                array_push($containMap[$value], array(
                    'contain' => $path,
                    'index' => $index
                ));
            }
        }

        // 开始查找删除
        foreach ($files as $file) {
            if (isset(self::$belongMap[$file])) {
                unset(self::$belongMap[$file]);
            }
            if (isset($containMap[$file])) {
                foreach ($containMap[$file] as $item) {
                    if (isset(self::$belongMap[$item['contain']])) {
                        unset(self::$belongMap[$item['contain']][$item['index']]);
                        if (empty(self::$belongMap[$item['contain']])) {
                            unset(self::$belongMap[$item['contain']]);
                        }
                    }
                }
            }
        }
    }

    /**
     * 根据文件列表，递归查找所有受影响的文件
     * @param $files
     */
    public static function getAffectList($files) {
        $ret = array();
        self::_getAffectList($files, $ret);
        return array_unique($ret);
    }
    private static function _getAffectList($files, &$ret) {
        $files = (array)$files;

        foreach ($files as $file) {
            if (isset(self::$belongMap[$file])) {
                $ret = array_merge($ret, self::$belongMap[$file]);
                self::_getAffectList(self::$belongMap[$file], $ret);
            }
        }
    }

    /**
     * 生成合图md5信息
     */
    private static function genMd5Map() {
        $images = get_files_by_type(C('IMERGE_PATH').'/'.C('IMERGE_SPRITE_DIR'), 'png');
        foreach ($images as $image) {
            self::$md5Map[basename($image)] = md5(file_get_contents($image));
        }
    }

    /**
     * 生成最新版本号
     */
    private static function genLatestRevision() {
        $cmd = 'cd '.C('SRC.SRC_PATH').' && '.C('SVN').' info --xml';
        $info = shell_exec_ensure($cmd, false);
        if (!$info['status']) {
            $info = $info['output'];
            $info = simplexml_load_string($info);
            $revision = $info->entry->commit->attributes()->revision;
            self::$revision = (int)$revision;
        }
    }

    /**
     * 当监听的事件触发时，更新belongMap
     * @param $key
     * @param $value
     */
    private static function updateMap($key, $value) {
        if (!isset(self::$belongMap[$key])) {
            self::$belongMap[$key] = array();
        }
        if (!in_array($value, self::$belongMap[$key])) {
            array_push(self::$belongMap[$key], $value);
        }
    }
}