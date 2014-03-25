<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-15
 * Time: 下午4:13
 * To change this template use File | Settings | File Templates.
 */

class MergeConfigWriter {
    private $root;

    public function __construct($root) {
        $this->root = $root;
    }

    /**
     * 写入小图配置
     */
    public function writeImageConfig($mergeConfig) {
        $imergePath = $this->root.'/'.C('IMERGE_IMAGE_DIR');
        foreach ($mergeConfig as $type => $value) {
            $typePath = $imergePath.'/'.$type;
            if (!file_exists($typePath)) {
                mkdir($typePath, 0777, true);
            } else {
                $this->cleanupFile($typePath);
            }
            foreach ($value as $url => $config) {
                $uid = file_uid($url);

                // 只有当自定义配置文件不存在时，才进行配置写入
                // 自定义配置文件名以'_'开头
                $customFile = $typePath.'/_'.$uid.'.php';
                if (!file_exists($customFile)) {
                    $configFile = $typePath.'/'.$uid.'.php';
                    $contents = self::configStringify($config, $url);
                    contents_to_file($configFile, $contents);
                }
            }
        }
        $this->cleanupDir(array_keys($mergeConfig));
    }

    /**
     * 单个小图配置文件写入，用于手动更新配置信息
     * @param $type
     * @param $image
     * @param $config
     */
    public function writeSingleImageConfig($type, $image, $config) {
        $path = $this->root.'/'.C('IMERGE_IMAGE_DIR').'/'.$type;
        $filename = file_uid($image);
        $oldFile = $path.'/'.$filename.'.php';
        $newFile = $path.'/_'.$filename.'.php';
        @unlink($oldFile);
        contents_to_file($newFile, self::configStringify($config, $image));
    }

    /**
     * 删除某一张小图配置信息
     * @param $type
     * @param $image
     */
    public function removeSingleImageConfig($type, $image) {
        $path = $this->root.'/'.C('IMERGE_IMAGE_DIR').'/'.$type;
        $filename = file_uid($image);
        $oldFile = $path.'/'.$filename.'.php';
        $newFile = $path.'/_'.$filename.'.php';
        @unlink($oldFile);
        @unlink($newFile);
    }

    /**
     * 添加一张小图配置
     * @param $type
     * @param $image
     * @param null $config
     * @return bool
     */
    public function addSingleImageConfig($type, $image, $config=null) {
        $path = $this->root.'/'.C('IMERGE_IMAGE_DIR').'/'.$type;
        $filename = file_uid($image);
        $oldFile = $path.'/'.$filename.'.php';
        $newFile = $path.'/_'.$filename.'.php';
        if (file_exists($oldFile) || file_exists($newFile)) {
            // 小图已存在
            return false;
        } else {
            if (is_null($config)) {
                $config = MergeConfigGenerator::getDefaultConfig();
            }
            contents_to_file($newFile, self::configStringify($config, $image));
            return true;
        }
    }

    /**
     * 写入大图配置
     */
    public function writeSpriteConfig($spriteConfig) {
        $path = $this->root.'/'.C('IMERGE_SPRITE_DIR');
        foreach ($spriteConfig as $type => $value) {
            $configFile = $path.'/'.$type.'.php';
            $contents = self::configStringify($value);
            contents_to_file($configFile, $contents);
        }
    }

    /**
     * 删除掉之前的自动配置文件，自定义配置保留
     * @param $path
     */
    private function cleanupFile($path) {
        $files = glob($path.'/[^_]*/php');
        if ($files) {
            foreach ($files as $file) {
                unlink($file);
            }
        }
    }

    /**
     * 清除掉冗余的配置文件
     * @param $types
     */
    private function cleanupDir($types) {
        // 获取已存在的小图配置文件夹列表
        $imergePath = $this->root.'/'.C('IMERGE_IMAGE_DIR');
        $entries = scandir($imergePath);
        foreach ($entries as $entry) {
            $typePath = $imergePath.'/'.$entry;
            // 如果这个文件夹名，在$types中不存在，则表示这张大图已经废弃
            if ($entry[0] !== '.' && is_dir($typePath) && !in_array($entry, $types)) {
                rm_dir($typePath);
                // 同时还要删除相应的大图，及大图配置
                $cOutFiles = glob($this->root.'/'.C('IMERGE_SPRITE_DIR').'/'.$entry.'.*');
//                var_dump($this->root.C('COUT_DIR').'/'.$entry.'_*');
                if ($cOutFiles) {
                    foreach ($cOutFiles as $file) {
                        unlink($file);
                    }
                }
            }
        }
    }

    public static function configStringify($config, $url = null) {
        if (!is_null($url)) {
            $temp = array();
            $temp[$url] = $config;
        } else {
            $temp = $config;
        }
        $string = '<?php '.PHP_EOL.'return ';
        $string .= var_export($temp, true);
        $string .= ';';

        return $string;
    }
}