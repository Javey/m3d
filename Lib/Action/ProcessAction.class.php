<?php
/**
 * Created by JetBrains PhpStorm.
 * User: javey
 * Date: 13-4-27
 * Time: 下午2:57
 * To change this template use File | Settings | File Templates.
 */

class ProcessAction extends Action {
    // 模块名
    private $mod = "";
    // 是否设置cdn
    private $cdn = false;
    // 测试站点名
    private $site = "";
    // 模块配置
    private $config = array();

//    public function __construct() {
//        $this->mod = $_GET['mod'];
//        $this->site = $_GET['site'];
//
//        // 加载proprocess配置
////        C('PROCESS', include CONF_PATH.'preprocess.php');
//    }

    public function index() {
        ini_set('memory_limit', -1);
        set_time_limit(0);
        // Server Sent Event
        header('Content-Type: text/event-stream');
//        header('Content-Type: text/octet-stream');
        header('Cache-Control: no-cache');

        $t1 = microtime(true);
//        if ($this->mod === 'hybrid-mac') {
//            $path = C('FE_BRANCH_PATH').'/hybrid-mac/music_1-0-92_BRANCH/config.php';
//        } else {
//            $path = '/home/music/javey/music_1-0-165-34_BRANCH/m3d.php';
            $path = C('SITE_PATH').'/'.$_GET['site'].'/'.C('SITE_SRC_DIR').'/'.$_GET['module'].'/'.C('M3D_FILENAME');
//        }

        $tool = new PreprocessTool($path);
        $tool->run();
        $t2 = microtime(true);
        show_json('编译用时：' . round($t2 - $t1, 2). 's');
    }

    /**
     * 加载配置
     *   加载路径配置
     *   加载黑白名单等配置
     */
    private function setConfig() {
        $model = new ModuleModel('users');
        $config = $model->getModuleConfig($this->mod);
        $currentSitePath = C('SITE_PATH').$this->site.'/';
        $currentCodePath = $currentSitePath.C('SITE_SRC_DIR').'/'.$config['ln_name'].'/';
        $temp = array(
            'src_path' => $currentCodePath.$config['src'].'/',
            'build_path' => $currentSitePath.C('SITE_BUILD_DIR').'/'.$config['ln_name'].'/',
            'svn_build_path' => $currentCodePath.$config['svn_build'].'/'
        );
        $temp['m3d_path'] = $temp['src_path'].$config['m3d_path'];
        $this->config = array_merge($config, $temp);

        $this->loadPreprocessConfigs();
        print_r($this->config);
    }

    /**
     * 加载预处理白黑名单配置
     */
    private function loadPreprocessConfigs() {
        mark('Loading preprocess global configs...');
        $filePath = $this->config['m3d_path'].C('CIN_DIR').'/'.C('PROCESS.CONFIG_FILE');

        var_dump($filePath);
        if (file_exists($filePath)) {
            require_cache($filePath);
            $this->config['blacklist'] = $black_list;
            $this->config['whitelist'] = $white_list;
            $this->config['replacelist'] = $debug2online_replace_list;
        } else {
            exit("Preprocess全局配置文件：'". C('PROCESS.CONFIG_FILE') ."'不存在");
        }
    }

    public function getConfig() {
        return 'aaaa';
    }
    public function getFilelist() {
        $path = $this->config['src_path'];
        return $path.'site/ting.css';
    }
}