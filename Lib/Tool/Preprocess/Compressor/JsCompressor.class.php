<?php
/**
 * Created by JetBrains PhpStorm. JS压缩器
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 下午6:22
 * To change this template use File | Settings | File Templates.
 */

class JsCompressor extends Compressor {
    public function compress($option=null) {
        $compressor = C('JS_COMPRESSOR');
        if ($compressor) {
//            $shell = $compressor.' --max-line-len=5000 ';
            $this->contents = $this->exec($compressor);
        }
        $this->afterSize = strlen($this->contents) / 1024;
    }
}