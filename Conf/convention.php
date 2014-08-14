<?php
/**
 * 默认配置表
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午4:09
 * To change this template use File | Settings | File Templates.
 */

return array(
    // 系统变量名称设置
    'VAR_MODULE' => 'm',
    'VAR_ACTION' => 'a',
    'VAR_URL_PARAMS' => '_URL_',

    // 默认设定
    'DEFAULT_C_SUFFIX' => 'Action',
    'DEFAULT_M_SUFFIX' => 'Model',
    'DEFAULT_MODULE' => 'Index',
    'DEFAULT_ACTION' => 'Index',
    'DEFAULT_TIMEZONE' => 'PRC',

    // 全局配置
    'M3D_CONF_PATH' => M3D_PATH.'/conf', // 存放全局配置文件
    'SRC_PATH' => M3D_PATH.'/src', // 存放svn源码的路径
    'RESTART' => null, // server重启脚本
    'SVN' => 'svn', // svn命令

    // project配置
    'PROJECT' => array(
        'DATA_PATH' => PROJECT_PATH.'/data',
        'SITE_PATH' => PROJECT_PATH.'/site',
        'TEMP_DIR' => 'site-template', // 模板环境目录名
        'CONF_FILE' => 'lighttpd.conf', // 环境lighttpd配置文件名
        'SRC_DIR' => 'src', // 存放该环境所需的源码
        'BUILD_DIR' => 'build', // 编译后代码存放文件夹
        'TEST_ENV_DIR' => 'wwwdata.test', // 测试环境
        'BUILD_ENV_DIR' => 'wwwdata.build' // 编译环境
    ),

    'M3D_FILENAME' => 'm3d.php', // m3d配置文件名，放在源码根目录下，编译合图入口文件
    /**
     * 源码中m3d相关配置
     * 相对源码根目录
     */
    'SRC' => array(
        'ROOT' => '', // 源码根目录
        'SRC_PATH' => '{SRC.ROOT}/src', // 源码路径
        'BUILD_PATH' => '{SRC.ROOT}/build', // 存放编译后文件的路径
        'M3D_PATH' => '{SRC.ROOT}/m3d', // m3d路径
        'M3D_MAP_PATH' => '{SRC.M3D_PATH}/map', // map地址
        'M3D_MAP_SUFFIX' => '_map', // map文件后缀
        'BUILD_CACHE_PATH' => '{SRC.M3D_PATH}/cache', // 编译缓存目录
        'SMARTY_LEFT_DELIMITER' => '{', // smarty分界符
        'SMARTY_RIGHT_DELIMITER' => '}'
    ),

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
);