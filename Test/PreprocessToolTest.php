<?php

require_once('define.php');
require_once('../Common/functions.php');
require_once('../Lib/Tool/CSSParser/CSSParserTool.class.php');
require_once('../Lib/Tool/Preprocess/PreprocessTool.class.php');

class ProprocessToolTest extends PHPUnit_Framework_TestCase {
    protected static $process;

    public static function setUpBeforeClass() {
        self::$process = new PreprocessTool();
    }

    public function testRun() {
        self::$process->run();
    }
}