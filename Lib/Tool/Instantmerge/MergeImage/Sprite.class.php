<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-19
 * Time: 下午2:58
 * To change this template use File | Settings | File Templates.
 */

class Sprite {
    // 图片文件所相对的路径
    private $staticRelativePath = '';
    // 合图配置文件路径
    private $imergePath = '';

    private $sprite = null;

    public function __construct($imergePath='', $staticRelativePath='') {
        $this->imergePath = $imergePath;
        $this->staticRelativePath = $staticRelativePath;
        $this->ensureDirExist();
    }

    /**
     * 设置合图配置根目录
     * @param $root {String}
     */
    public function setImergePath($path) {
        $this->imergePath = $path;
        $this->ensureDirExist();
    }

    public function setStaticRelativePath($path) {
        $this->staticRelativePath = $path;
    }

    /**
     * 绘制图像
     * @param $type
     */
    public function draw($type, $config=array()) {
        if (empty($config)) {
            $loader = new MergeConfigLoader($this->imergePath);
            $config = $loader->getImageConfigByType($type);
        }

        $imgList = array();
        if (!empty($config)) {
            foreach ($config as $key => $value) {
                $imgList[$key] = new Image($this->staticRelativePath.$key, $value);
            }
        }
        $layout = new Layout($imgList);

        $spriteConfigs = array();
        $spriteConfigs[$type] = array();
        if ($layout->reflow($width, $height)) {
            $this->sprite = imagecreatetruecolor($width, $height);
            imagealphablending($this->sprite, false);
            imagesavealpha($this->sprite, true);
            imagefill($this->sprite, 0, 0, imagecolorallocatealpha($this->sprite, 0, 0, 0, 127));
            $spriteConfigs[$type]['config'] = $this->repaint($this->sprite, $imgList, $width, $height);
            // 记录sprite的属性
            $spriteConfigs[$type]['attr'] = array(
                'filename' => $type.C('SPRITE_SUFFIX').'.png',
                'width' => $width,
                'height' => $height
            );
//            $spriteConfigs[$type]['filename'] = $type.C('SPRITE_SUFFIX').'.png';
            // 生成大图到imerge_sprite_dir
            $path = $this->imergePath.'/'.C('IMERGE_SPRITE_DIR').'/'.$type.C('SPRITE_SUFFIX').'.png';
            imagepng($this->sprite, $path);

            // 写入配置
            $writer = new MergeConfigWriter($this->imergePath);
            $writer->writeSpriteConfig($spriteConfigs);

            // 派发处理完成事件
            trigger('DRAW_SPRITE_END', $path);
        }
    }

    /**
     * 输出图像，文件存在直接输出，不存在则重绘
     * @param null $type
     */
    public function output($type=null) {
        if ($type) {
            if (!$this->sprite) {
                $path = $this->imergePath.'/'.C('IMERGE_SPRITE_DIR').'/'.$type.C('SPRITE_SUFFIX').'.png';
                if (!file_exists($path)) {
                    $this->draw($type);
                } else {
                    $this->sprite = imagecreatefrompng($path);
                    imagesavealpha($this->sprite , true);
                }
            }
            $this->output();
        } else {
            header('Content-Type: image/png');
            imagepng($this->sprite);
        }
    }

    /**
     * 绘制图像，并返回sprite配置信息
     * @param $image
     * @param $imgList
     * @param $width
     * @param $height
     * @return array
     */
    private function repaint(&$image, $imgList, $width, $height) {
        $spriteConf = array();
        foreach ($imgList as $key => $img) {
            $img->paint($image, $width, $height);
            $spriteConf[$key] = array(
                'width' => $img->width,
                'height' => $img->height,
                'top' => $img->top,
                'right' => $img->right,
                'bottom' => $img->bottom,
                'left' => $img->left,
                'config' => $img->config
            );
        }
        return $spriteConf;
    }

    /**
     * 销毁图像
     */
    public function __destruct() {
        if (is_resource($this->sprite)) {
            imagedestroy($this->sprite);
        }
    }

    /**
     * 确保大图输出文件夹存在
     */
    private function ensureDirExist() {
        if ($this->imergePath) {
            $path = $this->imergePath.'/'.C('IMERGE_SPRITE_DIR');
            if (!file_exists($path)) {
                mkdir($path, 0777, true);
            }
        }
    }
}