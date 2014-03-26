<?php
/**
 * Created by JetBrains PhpStorm.
 * User: javey
 * Date: 13-4-27
 * Time: 下午4:31
 * To change this template use File | Settings | File Templates.
 */

//on('process_start', 'Test');
class TestPlugin extends Plugin {
    static private $data = array();

    public function run($param) {
//        var_dump($param[0]->getConfig());
        echo "test1";
        self::$data['a'] = 'a';
    }

    static public function setData($key, $value) {
        self::$data[$key] = $value;
    }

    static public function showData() {
        var_dump(self::$data);
    }
    static public function testStatic($param) {
        var_dump($param);
        $param[2]->test = 'bbb';
//        exit();
    }
}

//on ('process_start', 'TestOther');
class TestOtherPlugin extends Plugin {
    public function run($param) {
        echo "test2";
        TestPlugin::setData('b', 'b');
        TestPlugin::showData();
    }
}

on('processor_ready', 'TestPlugin::testStatic');