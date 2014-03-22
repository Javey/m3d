<?php
/**
 * @fileoverview M3D入口
 * @author zoujiawei@baidu.com
 * 13-3-20 下午2:03
 * Created by JetBrains PhpStorm.
 *
 * 每位工程师都有保持代码优雅的义务
 * each engineer has a duty to keep the code elegant
 */

defined('PROJECT_PATH') or define('PROJECT_PATH', dirname($_SERVER['SCRIPT_FILENAME']));
defined('M3D_CORE_PATH') or define('M3D_CORE_PATH', dirname(__FILE__));
defined('M3D_PATH') or define('M3D_PATH', dirname(M3D_CORE_PATH));

require M3D_CORE_PATH . '/Common/common.php';