<?php
/**
 * 全局配置文件
 */

return array(
    'RESTART' => '/home/music/lighttpd/restart-lighttpd', // server重启脚本
    'SVN' => 'svn', // svn命令 'SVN' => '/home/bae/local/subversion/bin/svn --config-dir /home/bae/.svn-fe-lq/',
    'PNG8_COMPRESSOR' => 'pngquant --speed 10 --ext -fs8.png --iebug 256 ', // pngquant png压缩工具
    'JS_COMPRESSOR' => 'uglifyjs -m -r "require,exports" --max-line-len=5000 ', // js压缩工具
);
