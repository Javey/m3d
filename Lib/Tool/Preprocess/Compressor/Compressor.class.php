<?php
/**
 * Created by JetBrains PhpStorm. 文件压缩抽象类
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 下午6:10
 * To change this template use File | Settings | File Templates.
 */

abstract class Compressor {
    protected $contents;
    protected $beforeSize;
    protected $afterSize;

    private static $_instance = array();

    public function __construct($contents=null) {
        if (!is_null($contents)) {
            $this->setContents($contents);
        }
    }

    public function setContents($contents) {
        $this->contents = $contents;
        $this->beforeSize = strlen($contents) / 1024;
    }

    public function exec($exec) {
        return shell_exec_stdio($exec, $this->contents);
    }

    abstract public function compress($option=null);

    public function __get($name) {
        return isset($this->$name) ? $this->$name : null;
    }

    final public static function getInstance($class, $options=null) {
        if (empty($class)) {
            return null;
        }
        $class = ucfirst(strtolower($class)).'Compressor';
        if (!isset(self::$_instance[$class])) {
            $instance = new stdClass();
            $instance->return = null;
            trigger('get_compressor', $instance, $options);
            self::$_instance[$class] = is_null($instance->return) ?
                (empty($options) ? new $class() : new $class($options)) :
                $instance->return;
        }

        return self::$_instance[$class];
    }
}