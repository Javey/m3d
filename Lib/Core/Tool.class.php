<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-8
 * Time: 下午2:47
 * To change this template use File | Settings | File Templates.
 */

abstract class Tool {
    protected $options = array();

    /**
     * 构造函数
     * @param null $options 编译配置表或配置文件路径
     */
    public function __construct($options, $initConfig=true) {
        if (is_string($options) && file_exists($options)) {
            $this->options = include($options);
        } elseif (is_array($options)) {
            $this->options = $options;
        } else {
            halt('传入的参数'.$options.'不正确，或文件不存在');
        }
        // 加载配置信息
        if ($initConfig) {
            $this->initConfig();
        }
    }

    public function getOptions() {
        return $this->options;
    }

    abstract public function run();

    static public function start() {
        foreach (scandir(LIB_PATH.'/Tool/') as $entry) {
            if ($entry[0] !== '.') {
                $file = LIB_PATH.'/Tool/'.$entry.'/'.$entry.'Tool.class.php';
                if (file_exists($file)) {
                    require_once($file);
                }
            }
        }
    }

    /**
     * 根据(实际/引用)地址得到(引用/实际)地址
     * @param $path
     * @return string
     */
    static public function getActualPath($path) {
        return str_remove_add($path, C('STATIC_VIRTUAL_PREFIX'), C('STATIC_ACTUAL_PREFIX'));
    }
    static public function getVirtualPath($path) {
        return str_remove_add($path, C('STATIC_ACTUAL_PREFIX'), C('STATIC_VIRTUAL_PREFIX'));
    }

    /**
     * 加入cdn
     * @param $path
     * @return string
     */
    static public function addCdn($path) {
        $cdnList = C('CDN_LIST');
        if ($cdnList) {
            $index = (strlen($path) + ord(basename($path))) % count($cdnList);
            $cdn = $cdnList[$index];
            $path = $cdn.$path;
        }

        return $path;
    }

    /**
     * 加载配置
     */
    protected function initConfig() {
        // 加载配置文件
        C($this->options['config']);

        // 初始化静态文件访问前缀
        // 用于引用路径和实际路径的映射
        if (isset($this->options['static_case'])) {
            $staticInSrc = $this->options['static_case']['static_in_src'];
            $staticInFile = $this->options['static_case']['static_in_file'];
            str_diff($staticInSrc, $staticInFile, $pos);
            $pos = $pos ? -$pos : null;
            C('STATIC_ACTUAL_PREFIX', str_slice($staticInSrc, 0, $pos));
            C('STATIC_VIRTUAL_PREFIX', str_slice($staticInFile, 0, $pos));
        }
    }
}