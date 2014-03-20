<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午4:09
 * To change this template use File | Settings | File Templates.
 */

return array(
    /**
     * 全局路径配置
     */
    'SRC_PATH' => '/home/music/src', // 存放svn源码的路径
    'SITE_PATH' => '/home/music/wwwdata/music', // 存放各分支站点的路径

//    'RD_BRANCH_PATH' => '{SRC_PATH}/branches/rd', // rd/fe分支目录
//    'FE_BRANCH_PATH' => '{SRC_PATH}/branches/fe',
//    'RD_TRUNK_PATH' => '{SRC_PATH}/trunk/rd',
//    'FE_TRUNK_PATH' => '{SRC_PATH}/trunk/fe',

    // 重启lighttpd脚本
    'RESTART' => SHELL_PATH.'/restart',

    // m3d
    'SITE_TEMP_DIR' => 'branch-template', // 子站模板目录名
    'SITE_CONFIG_FILE' => 'branch.conf', //子站lighttpd配置文件名

    /**
     * 子站点目录名配置
     */
    'SITE_SRC_DIR' => 'src', // svn代码库文件夹
//    'SITE_PREVIEW_SRC_DIR' => 'preview.src', // 同步代码库
    'SITE_BUILD_DIR' => 'build', // 编译后代码存放文件夹
    'SITE_TEST_ENV_DIR' => 'wwwdata.test', // 测试环境
    'SITE_BUILD_ENV_DIR' => 'wwwdata.build', // 编译环境
//    'SITE_RELEASE_ENV_DIR' => 'wwwdata.release', // 发布环境

    /**
     * 源码中m3d相关配置
     * 相对源码根目录
     */
    'M3D_FILENAME' => 'm3d.php', // m3d配置文件名，放在源码根目录下
    'SRC_ROOT' => '', // 源码根目录
    'SRC_SRC_PATH' => '{SRC_ROOT}/src', // 源码路径
    'SRC_BUILD_PATH' => '{SRC_ROOT}/build', // 存放编译后文件的路径
    'M3D_PATH' => '{SRC_ROOT}/m3d', // m3d路径
    'M3D_IMERGE_PATH' => '{M3D_PATH}/imerge', // 合图配置路径
//    'M3D_IMERGE_IMAGE_DIR' => 'image', // 小图配置路径
//    'M3D_IMERGE_SPRITE_DIR' => 'sprite', // 大图配置路径
    'M3D_CONF_PATH' => '{SRC_ROOT}/src/static/_m3d/cin', //'{M3D_PATH}/config', // 配置文件路径
    'M3D_BUILD_CACHE' => '{M3D_PATH}/buildcache', // 编译缓存文件路径
    'M3D_MAP_PATH' => '{M3D_PATH}/map', // map地址
    'M3D_MAP_SUFFIX' => '_map', // map文件后缀

    /**
     * 定义这两个参数，是为了在灵活的静态文件中，找到目标
     * 如：当a.js在源码目录中(相对SRC_SRC_PATH)中的路径是/static/js/a.js
     * 但在html中，引用的路径是/st/js/a.js
     * 在开发环境下，可以将static软链成st目录，即可正常开发
     * 编译时，如果要找/st/js/a.js对应的编译后文件路径，由于/st/js/a.js并非a.js实际路径，会造成查询失败
     * 将/static/js/a.js & /st/js/a.js diff可以得到：
     *      'STATIC_ACTUAL_PREFIX' => '/static'
     *      'STATIC_VIRTUAL_PREFIX' => '/st'
     * 有了这两个参数，就可以在引用地址和实际地址间，找到对应关系
     * 如果没有定义这两个参数，则可以从m3d.php给定的例子中计算得到
     **/
    'STATIC_ACTUAL_PREFIX' => null,
    'STATIC_VIRTUAL_PREFIX' => null,
//    'SRC_M3D_PATH' => '/static/_m3d', // 源码中_m3d文件夹路径
//    'SRC_CONF_FILE_PATH' => '{SRC_M3D_PATH}/cin/config.php', // 编译配置文件

    /**
     * SVN配置
     */
    'SVN' => 'svn', // svn命令 'SVN' => '/home/bae/local/subversion/bin/svn --config-dir /home/bae/.svn-fe-lq/',

    /**
     * 源码中m3d相关配置
     * 相对源码根目录
     */
    'SRC' => array(
        'ROOT' => '', // 源码根目录
        'SRC_PATH' => '/src', // 源码路径
        'BUILD_PATH' => '/build', // 存放编译后文件的路径
        'M3D_PATH' => '/m3d', // m3d路径
        'IMERGE_PATH' => '{SRC.M3D_PATH}/imerge', // 合图配置路径
//    'M3D_IMERGE_IMAGE_DIR' => 'image', // 小图配置路径
//    'M3D_IMERGE_SPRITE_DIR' => 'sprite', // 大图配置路径
        'CONF_PATH' => '/src/static/_m3d/cin', //'{M3D_PATH}/config', // 配置文件路径
        'BUILD_CACHE_PATH' => '{M3D_PATH}/buildcache', // 编译缓存文件路径
        'MAP_PATH' => '{M3D_PATH}/map', // map地址

//    'SRC_M3D_PATH' => '/static/_m3d', // 源码中_m3d文件夹路径
//    'SRC_CONF_FILE_PATH' => '{SRC_M3D_PATH}/cin/config.php', // 编译配置文件
    )
);