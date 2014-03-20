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
        if ($this->type === 'png' && C('IS_COMPRESS_IMAGE') && !$this->isBlackFile()) {
            $compressor = new MediaCompressor($this->contents);
            $compressor->compress(array('png8' => true));
            $this->contents = $compressor->contents;
        }
    }
}