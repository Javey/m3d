<?php
/**
 * 插件类
 * User: javey
 * Date: 13-4-27
 * Time: 下午4:14
 * To change this template use File | Settings | File Templates.
 */

abstract class Plugin {
    protected $options = array();

    public function __construct() {
        if (!empty($this->options)) {
            foreach ($this->options as $key => $val) {
                if (!is_null(C($key))) {
                    $this->options[$key] = C($key);
                } else {
                    C($key, $val);
                }
            }
        }
    }

    /**
     * 初始化插件事件绑定
     */
    final public static function start($path = PLUGIN_PATH) {
        foreach (scandir($path) as $entry) {
            if ($entry[0] !== '.') {
                $file = $path.'/'.$entry.'/'.$entry.'Plugin.class.php';
                if (file_exists($file)) {
                    require_once($file);
                }
            }
        }
    }

    /**
     * 插件入口
     * @param $params
     * @return mixed
     */
    abstract public function run($params);
}
