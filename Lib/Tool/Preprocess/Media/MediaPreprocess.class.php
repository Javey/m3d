<?php
/**
 * Created by PhpStorm.
 * User: zoujiawei
 * Date: 13-11-1
 * Time: 下午4:36
 */

class MediaPreprocess extends Preprocess {
    // 保存media处理了多少种类型的数组
    private static $types = array();

    public function process() {
        if (!isset(self::$types[$this->type])) {
            self::$types[$this->type] = true;
        }
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

    public static function getTypes() {
        return self::$types;
    }
}