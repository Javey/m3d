<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-14
 * Time: 下午10:05
 * To change this template use File | Settings | File Templates.
 */

require_once('../Common/functions.php');
require_once('../Lib/Tool/Instantmerge/InstantmergeTool.class.php');

class MergeConfigLoaderTest extends PHPUnit_Framework_TestCase {
    private static $loader;

    public static function setUpBeforeClass() {
        self::$loader = new MergeConfigLoader('./src/static/_m3d');
    }
//    public function testGetConfig() {
//        self::$loader->loadImageConfig();
//    }

    public function testGetAllTypes() {
        $types = self::$loader->getTypes();
//        $this->assertEquals($types, array('bg', 'blue'));
        print_r($types);
    }

    public function testGetAllConfigByType() {
        $config = self::$loader->getImageConfigByType('blue');
        print_r($config);

        $config = self::$loader->getImageConfig();
        print_r($config);
//        $this->assertEquals($config, array(
//            "/static/images/music/top-date-arrow-next.png" => array(
//                'action' => 'change',
//                'padding-top' => '10',
//                'padding-right' => '10',
//                'padding-bottom' => '10',
//                'padding-left' => '13',
//                'float' => 'none',
//                'repeat' => 'none',
//                'border-top' => '0',
//                'border-right' => '0',
//                'border-bottom' => '0',
//                'border-left' => '0',
//                'min-width' => '0',
//                'min-height' => '0',
//            ),
//            "/static/images/music/datepicker-next.png" => array(
//                'action' => 'change',
//                'padding-top' => '6',
//                'padding-right' => '6',
//                'padding-bottom' => '6',
//                'padding-left' => '6',
//                'float' => 'none',
//                'repeat' => 'none',
//                'border-top' => '0',
//                'border-right' => '0',
//                'border-bottom' => '0',
//                'border-left' => '0',
//                'min-width' => '0',
//                'min-height' => '0',
//            )
//        ));
    }
//    public function testLoadSprite() {
//        self::$loader->loadSprite();
//    }

    public function testGetSpriteConfig() {
        print_r(self::$loader->getSpriteConfig());
        print_r(self::$loader->getSpriteConfigByType('blue'));
    }
}