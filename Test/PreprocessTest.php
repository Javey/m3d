<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-8
 * Time: 下午8:40
 * To change this template use File | Settings | File Templates.
 */

require_once('../Lib/Tool/Preprocess/PreprocessTool.class.php');

class PreprocessTest extends PHPUnit_Framework_TestCase {
    protected $process;

    protected function setUp() {
        $this->process = new MediaPreprocess('./src/static/css/albumlist.css');
    }
    public function testFileUid() {
        $fileUid = $this->process->fileUid();
        $this->assertTrue(gettype($fileUid) === 'string');

        return $fileUid;
    }

    /**
     * @depends testFileUid
     */
    public function testWriteCompiledFile($uid) {
        $path = './build/static/css/'.$uid.'.css';
        $this->process->writeCompiledFile($path);
        $this->assertFileExists($path);
    }
}
