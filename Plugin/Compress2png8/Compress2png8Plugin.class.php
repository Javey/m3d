<?php
/**
 * Created by JetBrains PhpStorm. sprite绘制完成时，将之压缩成png8
 * User: zoujiawei
 * Date: 13-11-19
 * Time: 下午5:14
 * To change this template use File | Settings | File Templates.
 */

//on('DRAW_SPRITE_END', 'Compress2png8');

class Compress2png8Plugin extends Plugin {
    public function run($args) {
        $path = $args[1];
        $content = file_get_contents($path);
        $compressor = new MediaCompressor($content);
        $compressor->compress(array('png8' => true));
        file_put_contents($path, $compressor->contents);
    }
}