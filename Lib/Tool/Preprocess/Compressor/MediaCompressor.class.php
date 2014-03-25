<?php
/**
 * Created by JetBrains PhpStorm. 图片压缩器
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 下午6:22
 * To change this template use File | Settings | File Templates.
 */

class MediaCompressor extends Compressor {
    /**
     * 图片优化
     * @param null $option
     */
    public function compress($option=null) {
        $type = get_type_by_content($this->contents);
        // 支处理png
        if ($type === 'image/png') {
            if ($option && $option['png8']) {
                $this->compress2png8();
            } else {
                $this->optimize();
            }
        }
    }

    /**
     * 将32位png图压缩成8位
     */
    private function compress2png8() {
        $compressor = C('PNG8_COMPRESSOR');
        if ($compressor) {
//            $shell = $compressor.' 256 --ext -fs8.png ';
            $this->contents = $this->exec($compressor);
        }
        $this->afterSize = strlen($this->contents) / 1024;
    }
    /**
     * 优化图片
     */
    private function optimize() {
        $compressor = C('PNG_COMPRESSOR');
        if ($compressor) {
//            $shell = $compressor.' --max-line-len=5000 ';
            $this->contents = $this->exec($compressor);
        }
        $this->afterSize = strlen($this->contents) / 1024;
    }
}