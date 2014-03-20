<?php
/**
 * @fileoverview M3D入口
 * @author zoujiawei@baidu.com
 * 13-3-21 下午2:03
 * Created by JetBrains PhpStorm.
 *
 * 每位工程师都有保持代码优雅的义务
 * each engineer has a duty to keep the code elegant
 */

defined('M3D_PATH') or die('M3D Access deny.');

// 路径定义
defined('LIB_PATH') or define('LIB_PATH', M3D_PATH.'/Lib');
defined('PLUGIN_PATH') or define('PLUGIN_PATH', M3D_PATH.'/Plugin');
defined('CONF_PATH') or define('CONF_PATH', M3D_PATH.'/Conf');
defined('SHELL_PATH') or define('SHELL_PATH', M3D_PATH.'/Shell');
defined('UI_PATH') or define('UI_PATH', M3D_PATH.'/Ui');
//defined('CACHE_PATH') or define('CACHE_PATH', M3D_PATH.'/Cache');

defined('_PHP_FILE_') or define('_PHP_FILE_', rtrim($_SERVER['SCRIPT_NAME'], '/'));

// 加载函数库
require(M3D_PATH.'/Common/functions.php');
require(LIB_PATH.'/Core/M3d.class.php');
M3d::start();