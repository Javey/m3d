<?php

define('LAZER_SECURE', true); //Security constant
define('LAZER_DATA_PATH', C('PROJECT.DATA_PATH').'/'); //Path to folder with tables

require_once('Classes/Helpers/Validate.php');
require_once('Classes/Helpers/FileInterface.php');
require_once('Classes/Helpers/File.php');
require_once('Classes/Helpers/Config.php');
require_once('Classes/Helpers/Data.php');
require_once('Classes/Core/Relation.php');
require_once('Classes/Core/Database.php');
require_once('Classes/LazerException.php');
require_once('Classes/Database.php');
require_once('Classes/Relation.php');

 /**
  * Example autoloading function compatible with PSR-0
  * @param string $classname
  * @link https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md#example-implementation
  */
// function __autoload($className)
// {
//     $className = ltrim($className, '\\');
//     $fileName = '';
//     $namespace = '';
//     if ($lastNsPos = strrpos($className, '\\'))
//     {
//         $namespace = substr($className, 0, $lastNsPos);
//         $className = substr($className, $lastNsPos + 1);
//         $fileName = str_replace('\\', DIRECTORY_SEPARATOR, $namespace).DIRECTORY_SEPARATOR;
//     }
//     $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className).'.php';
//
//     $fileName = LIB_PATH.'/Db/'.$fileName;
//     if (file_exists($fileName)) {
//         require_cache($fileName);
//     }
// }
//
//spl_autoload_register('__autoload');

