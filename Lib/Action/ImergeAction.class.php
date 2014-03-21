<?php
/**
 * Created by JetBrains PhpStorm. 合图接口
 * User: zoujiawei
 * Date: 14-3-11
 * Time: 下午2:06
 * To change this template use File | Settings | File Templates.
 */

class ImergeAction extends Action {
    private $tool;

    public function __construct() {
        parent::__construct();
        $path = C('SITE_PATH').'/'.$_GET['site'].'/'.C('SITE_SRC_DIR').'/'.$_GET['module'].'/'.C('M3D_FILENAME');
//        $path = '/home/music/javey/music_1-0-165-34_BRANCH/m3d.php';
        $this->tool = new InstantmergeTool($path);
    }

    public function type() {
        switch ($this->method) {
            case 'get':
                $this->getTypes();
                break;
        }
    }

    public function image() {
        switch ($this->method) {
            case 'get':
                $this->getImages();
                break;
        }
    }

    public function config() {
        switch ($this->method) {
            case 'get':
                $this->getImageConfig();
                break;
            case 'put':
                $this->updateImageConfig();
                break;
            case 'delete':
                $this->removeImageConfig();
                break;
            case 'post':
                $this->addImageConfig();
                break;
        }
    }

    /**
     * 展示小图
     */
    public function showImage() {
        $uri = $_GET['uri'];
        header('Content-type: image/png');
        echo file_get_contents(C('SRC_SRC_PATH').$uri);
    }


    /**
     * 自动合图
     */
    public function auto() {
        ini_set('memory_limit', -1);
        set_time_limit(0);
        header('Content-Type: text/event-stream');
        header('Cache-Control: no-cache');
        $this->tool->run();
        mark('Done！', 'emphasize');
        show_json();
    }

    public function showSprite() {
        $type = $_GET['type'];
        $sprite = new Sprite(C('M3D_IMERGE_PATH'), C('SRC_SRC_PATH'));
        $sprite->output($type);
    }

    /**
     * 获取所有图片列表
     * 用于智能提示
     */
    public function hint() {
        if (!isset($_GET['key'])) {
            show_json('No key!');
            return;
        }

        $ret = array();
        $key = $_GET['key'];
        $total = 8;
        $count = 0;

        $options = $this->tool->getOptions();
        $scanPath = null;
        foreach ($options['process'] as $process) {
            if ($process['processor'] === 'media') {
                $scanPath = $process['from'];
            }
        }
        if ($scanPath) {
            $srcPath = C('SRC_SRC_PATH');
            $len = strlen($srcPath);
            $fileList = get_files_by_type($scanPath, 'png', $srcPath);
            foreach ($fileList as $index => $file) {
                if ($count >= $total) {
                    break;
                }
                $file = substr($file, $len);
                if (strpos($file, $key) !== false) {
                    array_push($ret, $file);
                    $count++;
                }
            }
            show_json($ret);
        }
    }

    /**
     * 获取所有sprite图片类型
     */
    private function getTypes() {
        $types = $this->tool->getLoader()->getTypes();
        show_json($types);
    }

    /**
     * 获取配置
     */
    private  function getImages() {
        $type = $_GET['type'];
        $config = $this->tool->getLoader()->getImagesListByType($type);
        show_json($config);
    }

    private function getImageConfig() {
        $type = $_GET['type'];
        $image = $_GET['image'];
        $config = $this->tool->getLoader()->getSingleImageConfig($type, $image);
        $config ? show_json($config) : show_error('该小图配置不存在');
    }

    private function updateImageConfig() {
        $type = $_POST['type'];
        $image = $_POST['image'];
        $this->tool->getWriter()->writeSingleImageConfig($type, $image['name'], $image['attr']);

        // 更新大图
        $this->tool->getDraw()->draw($type);
        show_json();
    }

    private function removeImageConfig() {
        $type = $_POST['type'];
        $image = $_POST['image'];
        $this->tool->getWriter()->removeSingleImageConfig($type, $image);

        // 更新大图
        $this->tool->getDraw()->draw($type);
        show_json();
    }

    private function addImageConfig() {
        $type = $_POST['type'];
        $image = $_POST['image'];
        if ($this->tool->getWriter()->addSingleImageConfig($type, $image)) {
            // 更新大图
            $this->tool->getDraw()->draw($type);
            show_json();
        } else {
            show_error('该小图已存在！');
        }
    }
}