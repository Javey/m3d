<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-8
 * Time: 下午11:24
 * To change this template use File | Settings | File Templates.
 */

require_once('define.php');
require_once('../Common/functions.php');
require_once('../Lib/Tool/Instantmerge/InstantmergeTool.class.php');
require_once('../Lib/Tool/CSSParser/CSSParserTool.class.php');
require_once('../Lib/Tool/Preprocess/PreprocessTool.class.php');

class CssProprocessTest extends PHPUnit_Framework_TestCase {
    protected $process;

    protected function setUp() {
        $this->process = new CssPreprocess(array());
        $this->process->setFile('./src/static/css/importA.css');
    }
    public function testProcess() {
        $contents = $this->process->process();
        $this->process->write('./build/static/c/testImport.css');
//        $contentsA = file_get_contents('./build/static/c/testImport.css');
//        $contentsB = file_get_contents('./templateBuild/static/c/testImport.css');
//        $this->assertEquals($contentsA, $contentsB);
    }
    public function testBackground() {
//        $process = new CssPreprocess('./src/static/css/background.css');
//        $contents = $process->process();
//        $process->writeCompiledFile('./build/static/c/background.css');
//        $contentsA = file_get_contents('./build/static/c/background.css');
//        $contentsB = file_get_contents('./templateBuild/static/c/background.css');
//        $this->assertEquals($contentsA, $contentsB);
    }
}