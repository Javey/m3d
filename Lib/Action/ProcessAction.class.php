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

        define('PROJECT_SITE_PATH', C('PROJECT.SITE_PATH').'/'.$_GET['site']);
        define('PROJECT_MODULE_NAME', $_GET['module']);

        $path = PROJECT_SITE_PATH.'/'.C('PROJECT.SRC_DIR').'/'.PROJECT_MODULE_NAME.'/'.C('M3D_FILENAME');

        $tool = new PreprocessTool($path);
        $tool->run();

        mark('处理完成！', 'emphasize');

        $t2 = microtime(true);

        show_json('编译用时：' . round($t2 - $t1, 2). 's');
    }
}