<?php
/**
 * 可编译语言工具
 * User: zoujiawei
 * Date: 14-8-29
 * Time: 下午4:15
 */

$realPath = readlink($_SERVER['SCRIPT_FILENAME']);
define('M3D_CORE_PATH', dirname(dirname(dirname($realPath))));
define('M3D_PATH', dirname(M3D_CORE_PATH));
require(M3D_CORE_PATH.'/Common/functions.php');


C(include M3D_PATH.'/conf/config.php');

$docRoot = $_SERVER['DOCUMENT_ROOT'];
$uriPath = $_SERVER['REQUEST_URI'];
$uriPath = preg_replace('/\?.*/', '', $uriPath);
$uriPath = substr($uriPath, 1);
$staticPath = $docRoot.$uriPath;
$ext = pathinfo($staticPath, PATHINFO_EXTENSION);

$langExt = array(
    'js' => array('js', 'coffee'),
    'css' => array('css', 'sass', 'scss', 'stylus', 'less')
);
$type = $ext;
foreach ($langExt as $key => $value) {
    if (in_array($ext, $value)) {
        $type = $key;
        break;
    }
}
switch ($type) {
    case 'js':
        header('Content-Type: text/javascript;');
        break;
    case 'css':
        header('Content-Type: text/css;');
        break;
}
foreach ($langExt[$type] as $_ext) {
    $_path = str_replace('.'.$ext, '.'.$_ext, $uriPath);
    if (file_exists($_path)) {
        $contents = file_get_contents($_path);
        switch ($_ext) {
            case 'coffee':
                $contents = shell_exec_stdio(C('COFFEE').' -bsp', $contents);
                break;
            case 'sass':
                $contents = shell_exec_stdio(C('SASS').' -s -I '.$docRoot, $contents);
                break;
        }
        echo $contents;
        exit();
    }
}

header("Status: 404 Not Found");
exit();

