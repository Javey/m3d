<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-15
 * Time: 下午4:54
 * To change this template use File | Settings | File Templates.
 */

require_once('../Common/functions.php');
require_once('../Lib/Tool/CSSParser/CSSParserTool.class.php');
require_once('../Lib/Tool/Instantmerge/InstantmergeTool.class.php');
//require_once('../Lib/Tool/Instantmerge/MergeConfig/MergeConfigGenerator.class.php');
//require_once('../Lib/Tool/Instantmerge/MergeConfig/MergeConfigWriter.class.php');

class MergeConfigGeneratorTest extends PHPUnit_Framework_TestCase {
    public function testGetConfig() {
        $mergeConfig = new MergeConfigGenerator('./src/static/css/merge.css');
        $config = $mergeConfig->generate()->getConfig();
        print_r($config);
//        exit();
        $writer = new MergeConfigWriter('./src/static/_m3d');
        $writer->writeImageConfig($config);

        $sprite = new Sprite('./src/static/_m3d', './src');
        foreach ($config as $key => $value) {
            $sprite->draw($key, $value);
        }
    }
}