<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-20
 * Time: 下午1:49
 * To change this template use File | Settings | File Templates.
 */

class PPFactory {
    private static $_instance = array();

    public static function getInstance($class, $options=null) {
        if (empty($class)) {
            return null;
        }
        $class = ucfirst(strtolower($class)).'Preprocess';
        if (!isset(self::$_instance[$class])) {
            self::$_instance[$class] = empty($options) ? new $class() : new $class($options);
        }

        return self::$_instance[$class];
    }
}