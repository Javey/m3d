<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午3:38
 * To change this template use File | Settings | File Templates.
 */

class M3d {
    private static $_instance = array();

    /**
     * 应用程序初始化
     */
    static public function start() {
        // 加载默认配置
        C(include CONF_PATH.'/convention.php');

        date_default_timezone_set(C('DEFAULT_TIMEZONE'));
        spl_autoload_register(array('M3d', 'autoload'));

        require_array(array(
            LIB_PATH.'/Core/Dispatcher.class.php',
            LIB_PATH.'/Core/Model.class.php',
            LIB_PATH.'/Core/Action.class.php',
            LIB_PATH.'/Core/View.class.php',
            LIB_PATH.'/Core/Tool.class.php',
            LIB_PATH.'/Core/Plugin.class.php'
        ));

        define('REQUEST_METHOD', strtolower($_SERVER['REQUEST_METHOD']));
        define('IS_GET', REQUEST_METHOD === 'get');
        define('IS_POST', REQUEST_METHOD === 'post');
        define('IS_PUT', REQUEST_METHOD === 'put');
        define('IS_DELETE', REQUEST_METHOD === 'delete');
        define('IS_AJAX', isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest');

        Tool::start();
        Plugin::start();

        // 加载全局配置
        C(include C('M3D_CONF_PATH').'/config.php');
        // 加载project配置
        C(include PROJECT_PATH.'/conf/config.php');

        Dispatcher::dispatch();
        self::exec();
    }

    static public function exec() {
        $module = A(MODULE_NAME);
        $action = ACTION_NAME;

        try {
            if (!preg_match('/^[A-Za-z](\w)*$/',$action)) {
                throw new ReflectionException();
            }
            $method = new ReflectionMethod($module, $action);
            if ($method->isPublic()) {
//                $class = new ReflectionClass($module);
                switch (REQUEST_METHOD) {
                    case 'post':
                        $vars = array_merge($_POST, $_GET);
                        break;
                    case 'put':
                        parse_str(file_get_contents('php://input'), $vars);
                        break;
                    default:
                        $vars = $_GET;
                        break;
                }
                $_REQUEST = $vars;
                if ($method->getNumberOfParameters() > 0) {
                    $params = $method->getParameters();
                    foreach ($params as $param) {
                        $name = $param->getName();
                        if (isset($vars[$name])) {
                            $args[] = $vars[$name];
                        } elseif ($param->isDefaultValueAvailable()) {
                            $args[] = $param->getDefaultValue();
                        } else {
                            echo 'Error';
                        }
                    }
                    $method->invokeArgs($module, $args);
                } else {
                    $method->invoke($module);
                }
            } else {
                // 非public方法
                throw new ReflectionException();
            }
        } catch (ReflectionException $e) {
            // 引导到_call
//            $method = new ReflectionMethod($module,'__call');
//            $method->invokeArgs($module,array($action,''));
            print_r($e);
        }
    }

    /**
     * 自动加载
     * @param $class
     */
    static public function autoload($class) {
        $file = $class.'.class.php';
        if (substr($class, -6) == 'Plugin') {
            require_cache(PLUGIN_PATH.substr($class, 0, strlen($class) - 6).'/'.$file);
        } elseif (substr($class, -5) == 'Model') {
            require_cache(LIB_PATH.'/Core/Model.class.php');
            require_cache(LIB_PATH.'/Model/'.$file);
        } elseif (substr($class, -6) == 'Action') {
            require_cache(LIB_PATH.'/Action/'.$file);
        }
    }

    static public function instance($class, $method = '') {
        $identify = $class.$method;
        if (!isset(self::$_instance[$identify])) {
            if (class_exists($class)) {
                $o = new $class();
                if (!empty($method) && method_exists($o, $method)) {
                    self::$_instance[$identify] = call_user_func_array(array($o, $method), array());
                } else {
                    self::$_instance[$identify] = $o;
                }
            } else {
                halt('类不存在： '.$class);
            }
        }
        return self::$_instance[$identify];
    }
}