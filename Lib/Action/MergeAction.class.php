<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-18
 * Time: 下午4:22
 * To change this template use File | Settings | File Templates.
 */

class MergeAction extends Action {
    private $tool;

    public function __construct() {
        $path = '/home/music/javey/music_1-0-165-34_BRANCH/m3d.php';
        $this->tool = new InstantmergeTool($path);
    }
    public function index() {
//        $loader = new MergeConfigLoader();
//        $loader->loadImageConfig(M3D_PATH.'/Test/src/static/_m3d/imerge');
//        $types = $loader->getAllTypes();
//        $type = $_GET['type'];
//        if (!$type) {
//            $type = $types[0];
//        }
//        $this->assign('types', $types);
//        $this->assign('config', $loader->getAllConfigByType($type));
//        $this->assign('curType', $type);
//        $this->display();
        ini_set('memory_limit', -1);
        set_time_limit(0);
        header('Content-Type: text/event-stream');
        header('Cache-Control: no-cache');
        $this->tool->run();
    }
    public function image() {
        $uri = $_GET['uri'];
        header('Content-type: image/png');
        echo file_get_contents(M3D_PATH.'/Test/src'.$uri);
    }
    public function sprite() {
        $this->tool->sprite();
//        $type = $_GET['type'];
//        $sprite = new Sprite(M3D_PATH.'/Test/src');
//        $sprite->output($type);
    }
    public function showSpriteConfig() {
        $loader = new MergeConfigLoader('/home/music/javey/music_1-0-165-34_BRANCH/m3d/imerge');
        $config = $loader->getSpriteConfig();
        print_r($config);
    }
}