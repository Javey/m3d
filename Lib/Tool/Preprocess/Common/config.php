<?php
/**
 * Created by JetBrains PhpStorm.
 * Description: 编译配置文件
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 下午5:22
 * To change this template use File | Settings | File Templates.
 */

return array(
    // 预处理配置
    'IS_MD5' => true, // 是否md5静态文件
    'IS_REPLACE_URI' => true, // 是否将地址替换成编译后的地址
    'IS_MERGE_IMAGE' => true, // 是否进行CSS合图替换
    'IS_CDN' => true, // 是否加入cdn
    'IS_COMPRESS_IMAGE' => false, // 是否压缩图片，仅支持png压缩成png8

    // css预处理缓存，用于避免重复解析import的css
    'CSS_CACHE_PATH' => M3D_PATH.'/.Cache', // css编译缓存文件
    'CDN_IDENTIFIER' => 'cdn_9527_', // cdn标示符，用于文本替换

    // 几个依赖的可执行程序
    'PNG8_COMPRESSOR' => '', // pngquant png压缩工具
    'JS_COMPRESSOR' => '', // js压缩工具
);