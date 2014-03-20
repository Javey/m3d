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
    'IS_COMPRESS_IMAGE' => true, // 是否压缩图片，仅支持png压缩成png8

    // css预处理缓存，用于避免重复解析import的css
    'CSS_CACHE_PATH' => M3D_PATH.'/.Cache', // css编译缓存文件

    // 几个依赖的可执行程序
//    'JAVA' => '/home/bae/ci/CI/bin/jdk1.6.0_06/bin/java',
    'PNG8_COMPRESSOR' => '/usr/bin/pngquant --speed 10 --ext -fs8.png --iebug 256 ', // pngquant png压缩工具
    'JS_COMPRESSOR' => LIB_PATH.'/Tool/NodeModule/uglify-js/bin/uglifyjs -m --max-line-len=5000 ', // js压缩工具
);