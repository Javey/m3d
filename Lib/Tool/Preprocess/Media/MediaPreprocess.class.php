<?php
/**
 * Created by PhpStorm.
 * User: zoujiawei
 * Date: 13-11-1
 * Time: 下午4:36
 */

class MediaPreprocess extends Preprocess {

    public function process() {
        $this->contents = $this->oContents;
    }

    /**
     * 压缩图片
     * @return mixed|void
     */
    public function compress() {
        if (C('IS_COMPRESS_IMAGE') && !$this->isBlackFile()) {
            $compressor = Compressor::getInstance('media');
            $compressor->setContents($this->contents);
            $compressor->compress(array('png8' => true));
            $this->contents = $compressor->contents;
        }
    }
}