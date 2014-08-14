<?php
/**
 * 图片处理器
 * User: zoujiawei
 * Date: 13-11-1
 * Time: 下午4:36
 */

class MediaPreprocess extends Preprocess {

    public function process() {}

    /**
     * 压缩图片
     * @return mixed|void
     */
    public function compress($isSprite=false) {
        // 只有合图图片，才进行压缩，其他小图，可能存在滤镜应用情况，压缩会造成ie6失真
        if (C('IS_COMPRESS_IMAGE') && !$this->isBlackFile() && $isSprite) {
            $compressor = Compressor::getInstance('media');
            $compressor->setContents($this->contents);
            $compressor->compress(array('png8' => true));
            $this->contents = $compressor->contents;
        }
    }
}