<?php

$realPath = $_SERVER['SCRIPT_FILENAME'];
define('M3D_CORE_PATH', dirname(dirname(dirname($realPath))));
define('M3D_PATH', dirname(M3D_CORE_PATH));
require(M3D_CORE_PATH.'/Common/functions.php');

