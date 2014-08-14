<?php
/**
 * 路由分发
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */

class Dispatcher {
    static public function dispatch() {
        $url = dirname(_PHP_FILE_);
        if ($url == '/' || $url == '\\') {
            $url = '';
        }
        define('PHP_FILE', $url);

        if (!empty($_SERVER['PATH_INFO'])) {
            $paths = explode('/', trim($_SERVER['PATH_INFO'], '/'));
            // 去掉index.php
            if ($paths[0] === 'index.php') {
                array_shift($paths);
            }
            $_GET[C('VAR_URL_PARAMS')] = $paths;

            $var = array();
            if (!isset($_GET[C('VAR_MODULE')])) {
                $var[C('VAR_MODULE')] = array_shift($paths);
            }
            $var[C('VAR_ACTION')] = array_shift($paths);

            //解析剩余的URL参数
            $params = implode('/', $paths);
            preg_replace('/(\w+)\/([^\/]+)/e', '$var[\'$1\']=strip_tags(\'$2\');', $params);
            $_GET = array_merge($var, $_GET);
        }

        define('MODULE_NAME', self::_getModule(C('VAR_MODULE')));
        define('ACTION_NAME', self::_getAction(C('VAR_ACTION')));
        define('__URL__', PHP_FILE.'/'.MODULE_NAME);
    }

    static private function _getModule($var) {
        $module = !empty($_GET[$var]) ? $_GET[$var] : C('DEFAULT_MODULE');
        unset($_GET[$var]);

        return strip_tags(ucfirst($module));
    }

    static private function _getAction($var) {
        $action = !empty($_POST[$var]) ? $_POST[$var] : (!empty($_GET[$var]) ? $_GET[$var] : C('DEFAULT_ACTION'));
        unset($_POST[$var], $_GET[$var]);

        return strtolower($action);
    }
}