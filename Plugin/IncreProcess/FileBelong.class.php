<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 14-3-19
 * Time: 下午3:37
 * To change this template use File | Settings | File Templates.
 */

on(
    array(
        'css_import',
        'css_background_change',
        'js_import',
        'html_href_change'
    ),
    'FileBelong::update'
);

on('process_end', 'FileBelong::export');

class FileBelong {
    // 依赖链表
    // 保存某一文件改变会影响其他文件的map，
    private static $belongMap = array();

    public static function load() {
        $path = C('INCRE.PATH').'/'.C('INCRE.MAP_FILENAME');
        if (file_exists($path)) {
            self::$belongMap = include($path);
        }
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

    public static function getMap() {
        return self::$belongMap;
    }

    /**
     * 导出配置
     */
    public static function export() {
        $path = C('INCRE.PATH').'/'.C('INCRE.MAP_FILENAME');
        contents_to_file($path, MergeConfigWriter::configStringify(self::$belongMap));
    }


    /**
     * 根据删除文件列表，重建map
     * @param $files
     */
    public static function rebuildMap($files) {
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

    private static function updateMap($key, $value) {
        if (!isset(self::$belongMap[$key])) {
            self::$belongMap[$key] = array();
        }
        if (!in_array($value, self::$belongMap[$key])) {
            array_push(self::$belongMap[$key], $value);
        }
    }
}