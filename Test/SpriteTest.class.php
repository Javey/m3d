<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-19
 * Time: 下午3:17
 * To change this template use File | Settings | File Templates.
 */

require_once('../Common/functions.php');
require_once('../Lib/Tool/CSSParser/CSSParserTool.class.php');
require_once('../Lib/Tool/Instantmerge/InstantmergeTool.class.php');

class SpriteTest extends PHPUnit_Framework_TestCase {
    public function testDraw() {
        $sprite = new Sprite('./src/static/_m3d', './src');
        $sprite->draw('blue');
    }
}