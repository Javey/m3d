<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-14
 * Time: 下午8:48
 * To change this template use File | Settings | File Templates.
 */

class MergeConfigLoader {
    // 合图配置目录
    private $root = '';

    public function __construct($root) {
        $this->root = $root;
    }

    /**
     * 加载所有小图配置
     * @return array
     */
    public function getImageConfig() {
        $ret = array();
        $types = $this->getTypes();
        foreach ($types as $type) {
            $ret[$type] = $this->getImageConfigByType($type);
        }

        return $ret;
    }

    /**
     * 根据type，加载某一类小图配置
     * @param $type
     */
    public function getImageConfigByType($type) {
        $ret = array();
        $typePath = $this->root.'/'.C('IMERGE_IMAGE_DIR').'/'.$type;
        if (is_dir($typePath)) {
            // 扫描每个type下的小图配置
            $files = scandir($typePath);
            foreach ($files as $file) {
                if (preg_match('/.*\.php/', $file)) {
                    $file = $typePath.'/'.$file;
                    $config = include($file);
                    $ret = array_merge($ret, $config);
                }
            }
        }

        return $ret;
    }

    /**
     * 得到某一类型下，所有小图文件列表
     * @param $type
     * @return array
     */
    public function getImagesListByType($type) {
        $ret = $this->getImageConfigByType($type);
        return array_keys($ret);
    }

    /**
     * 根据类型和小图路径，得到某一张小图的配置
     * @param $type
     * @param $image
     */
    public function getSingleImageConfig($type, $image) {
        $ret = null;
        $path = $this->root.'/'.C('IMERGE_IMAGE_DIR').'/'.$type;
        $filename = file_uid($image);
        $autoPath = $path .'/'.$filename.'.php';
        $customPath = $path .'/_'.$filename.'.php';
        if (file_exists($customPath)) {
            $config = include($customPath);
            $ret = $config[$image];
        } elseif (file_exists($autoPath)) {
            $config = include($autoPath);
            $ret = $config[$image];
        }

        return $ret;
    }

    /**
     * 加载所有大图配置
     * @return array
     */
    public function getSpriteConfig() {
        $ret = array();
        $path = $this->root.'/'.C('IMERGE_SPRITE_DIR');
        $files = get_files_by_type($path, 'php');
        foreach ($files as $file) {
//            $temp = include($file);
//            $ret = array_merge($ret, $temp);
            $type = basename($file, '.php');
            $ret[$type] = include $file;
        }

        return $ret;
    }

    public function getSpriteConfigByType($type) {
        $ret = array();
        $path = $this->root.'/'.C('IMERGE_SPRITE_DIR').'/'.$type.'.php';
        if (file_exists($path)) {
            $ret = include($path);
        }

        return $ret;
    }

    /**
     * 得到所有的合图类型
     * @return array
     */
    public function getTypes() {
        $path = $this->root.'/'.C('IMERGE_IMAGE_DIR');
        if (!file_exists($path)) {
            return array();
        }
        $types = scandir($path);
        $types = array_filter($types, array($this, 'filterTypes'));
        // 重建索引
        $types = array_values($types);

        return $types;
    }

    /**
     * 过滤文件夹
     * @param $type
     * @return bool
     */
    private function filterTypes($type) {
        return $type[0] !== '.' && is_dir($this->root.'/'.C('IMERGE_IMAGE_DIR').'/'.$type);
    }
}