<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-14
 * Time: 下午1:50
 * To change this template use File | Settings | File Templates.
 */

require_once('../Common/functions.php');
require_once('../Lib/Tool/CSSParser/CSSParserTool.class.php');
require_once('../Lib/Tool/Instantmerge/MergeConfig/MergeConfigGenerator.class.php');
require_once('../Lib/Tool/Instantmerge/MergeConfig/MergeConfigWriter.class.php');

class MergeConfigGeneratorTest extends PHPUnit_Framework_TestCase {
    public function testGetConfig() {
//        $mergeConfig = new MergeConfigGenerator('./src/static/css/merge.css');
        $mergeConfig = new MergeConfigGenerator('/home/music/javey/testsite/src/site/plaza/mv/mv.css');
        $mergeConfig->generate();
        print_r($mergeConfig->getConfig());
    }
}