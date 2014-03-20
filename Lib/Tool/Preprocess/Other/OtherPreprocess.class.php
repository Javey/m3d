<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-19
 * Time: 下午9:20
 * To change this template use File | Settings | File Templates.
 */

class OtherPreprocess extends Preprocess {
    public function process() {
        $this->contents = $this->oContents;
    }

    public function compress() {
    }
}