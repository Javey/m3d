<?php
/**
 * Created by PhpStorm.
 * User: zoujiawei
 * Date: 14-5-20
 * Time: 上午10:52
 */

define('PROJECT_PATH', dirname(__FILE__));
//define('M3D_CORE_PATH', dirname(__FILE__));
define('M3D_CORE_PATH', '/home/music/m3d_tool/m3d');
if (preg_match("/^\/static\/.*/", $_SERVER['REQUEST_URI'], $matches)) {
    header("Location: /Ui$matches[0]");
} else if (preg_match("/^\/Ui\/.*/", $_SERVER['REQUEST_URI'], $matches)) {
    return false;
} else {
    require('index.php');
}
