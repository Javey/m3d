<?php
/**
 * 全局配置文件
 */

$base = dirname(__FILE__);

return array(
    'SRC_PATH' => $base.'/src', // 存放svn源码的路径
    'RESTART' => SHELL_PATH.'/restart', // server重启脚本
    'SVN' => 'svn', // svn命令 'SVN' => '/home/bae/local/subversion/bin/svn --config-dir /home/bae/.svn-fe-lq/',
);