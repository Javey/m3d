<?php

define('JSONDB_SECURE', true); //Security constant

define('JSONDB_DATA_PATH', C('DATA_PATH').'/');

/**
* Example autoloading function
* @param string $class
*/
function __autoload($class) {
    $path = strtolower(str_replace('\\', '/' , $class).'.php');
    $path = LIB_PATH.'/Db/'.$path;

    if (file_exists($path)) {
        require_cache($path);
    }
}
spl_autoload_register('__autoload');

?>
