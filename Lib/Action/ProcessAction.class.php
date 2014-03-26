<?php
/**
 * Created by JetBrains PhpStorm. 编译入口
 * User: javey
 * Date: 13-4-27
 * Time: 下午2:57
 * To change this template use File | Settings | File Templates.
 */

class ProcessAction extends Action {
    public function index() {
        // Server Sent Event
//        header('Content-Type: text/event-stream');
        header('Content-Type: text/octet-stream');
        header('Cache-Control: no-cache');

        $t1 = microtime(true);
//        if ($this->mod === 'hybrid-mac') {
//            $path = C('FE_BRANCH_PATH').'/hybrid-mac/music_1-0-92_BRANCH/config.php';
//        } else {
//            $path = '/home/music/javey/music_1-0-165-34_BRANCH/m3d.php';
            $path = C('PROJECT.SITE_PATH').'/'.$_GET['site'].'/'.C('PROJECT.SRC_DIR').'/'.$_GET['module'].'/'.C('M3D_FILENAME');
//        }

        $tool = new PreprocessTool($path);
        $tool->run();
        $t2 = microtime(true);
        show_json('编译用时：' . round($t2 - $t1, 2). 's');
    }
}