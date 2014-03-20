<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 上午11:33
 * To change this template use File | Settings | File Templates.
 */

require_once('define.php');
require_once('../Common/functions.php');
require_once('../Lib/Tool/CSSParser/CSSParserTool.class.php');
require_once('../Lib/Tool/Preprocess/PreprocessTool.class.php');

class JsProprocessTest extends PHPUnit_Framework_TestCase {
    protected static $process;

    public static function setUpBeforeClass() {
        self::$process = new JsPreprocess('./src/static/js/documentWriteA.js');
    }

    public function testDocumentWrite() {
        self::$process->handleDocumentWrite();
        self::$process->writeCompiledFile('./build/static/j/documentWrite.js');
        $contentsA = file_get_contents('./build/static/j/documentWrite.js');
        $contentsB = file_get_contents('./templateBuild/static/j/documentWrite.js');
        $this->assertEquals($contentsA, $contentsB);
    }
    public function testProcess() {
        $contents = self::$process->process();
        self::$process->writeCompiledFile('./build/static/j/documentWrite.js');
        $contentsA = file_get_contents('./build/static/j/documentWrite.js');
        $contentsB = file_get_contents('./templateBuild/static/j/documentWrite.js');
        $this->assertEquals($contentsA, $contentsB);
    }
    public function testCompress() {
        self::$process->compress();
        self::$process->writeCompiledFile('./build/static/j/buildjs.js');
        $this->assertEquals(file_get_contents('./build/static/j/buildjs.js'), file_get_contents('./templateBuild/static/j/buildjs.js'));
    }
}