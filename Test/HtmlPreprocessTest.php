<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 下午8:59
 * To change this template use File | Settings | File Templates.
 */

require_once('define.php');
require_once('../Common/functions.php');
require_once('../Lib/Tool/CSSParser/CSSParserTool.class.php');
require_once('../Lib/Tool/Preprocess/PreprocessTool.class.php');

class HtmlProprocessTest extends PHPUnit_Framework_TestCase {
    protected static $process;

    public static function setUpBeforeClass() {
        self::$process = new HtmlPreprocess('./src/static/html/web_pc_proxy.html');
    }

    public function testProcess() {
        self::$process->process();
        self::$process->writeCompiledFile('./build/static/html/pipe.html');
        $contentsA = file_get_contents('./build/static/html/pipe.html');
        $contentsB = file_get_contents('./templateBuild/static/html/pipe.html');
        $this->assertEquals($contentsA, $contentsB);
    }
}