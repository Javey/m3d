<?php
/**
 * 请将该文件命名为m3d.php，放在源码根目录
 * 或者放置其他目录，然后再根目录下新建m3d.php require该文件
 * <code>
 *  <?php
 *  define('SRC_ROOT', dirname(__FILE__));
 *  return require('path_to_m3d.php');
 * </code>
 *
 * @description m3d配置
 * @filename m3d.php
 */

defined('SRC_ROOT') or define('SRC_ROOT', dirname(__FILE__));
$root = SRC_ROOT; // 分支根目录路径

return array(
    /**
     * 编译配置
     * from:相对于src.src_path 扫描目录
     * to:相对于src.build_path 编译后存放目录
     * type: 扫描文件类型
     * processor: 预处理器，处理扫描到的文件
     * [name]: 用于生成map文件时的文件名，否则等于processor名
     */
    'process' => array(
        // media预处理器，用于md5化，如果是png则压缩
        array(
            'from' => '/static/images',
            'to' => '/static/i',
            'type' => 'png, jpg, gif',
            'processor' => 'media'
        ),
        // 如果存在静态模板，如需进行md5化，则可以当做media资源处理
        // 存在这种情况，是当有requireJs，需要加载静态模板时，
        // 可以只将静态模板map写入requireJs，如果和图片一起处理，则会将map信息混合到图片中，
        // 这样造成不必要的map（图片map）写入requireJs
        // 如果requireJs不存在加载静态模板的情况，则可以和图片一起处理
//        array(
//            'from' => '/static/html',
//            'to' => '/static/h',
//            'type' => 'html',
//            'name' => 'shtml',
//            'processor' => 'media'
//        ),
        // css预处理器，解析css，处理@import合并，进行图片替换，md5化，压缩
        array(
            'from' => '/static/css',
            'to' => '/static/c',
            'type' => 'css',
            'processor' => 'css'
        ),
        // js预处理器，document.write合并，压缩，md5
        array(
            'from' => '/static/js',
            'to' => '/static/j',
            'type' => 'js',
            'processor' => 'js'
        ),
        // html预处理器，img,link[rel='stylesheet'],script地址替换，去掉注释
        array(
            'from' => '/site, /common, /static/html',
            'type' => 'tpl, html',
            'processor' => 'html',
        ),
        // other预处理器，仅做文件移动，保持原始路径
        array(
            'from' => '/static, /config, /plugin, /data',
            'type' => 'mp3, ogg, swf, ico, cur, conf, php, tpl',
            'processor' => 'other'
        )
    ),

    /**
     * 发布到线上时，需要替换的文本内容
     */
    'replace_list' => array(
//        'passport.rdtest' => 'passport'
    ),

    /**
     * 黑名单
     * css文件，不进行解析处理，用于无法解析的情况
     * 图片文件，不进行压缩(png8)，用于需要较高色彩值的图片
     */
    'black_list' => array(
//        '/common/css/hack.css',
//        'bg_9527.png'
    ),

    /**
     * 白名单
     * 不改变文件路径
     */
    'white_list' => array(
//        '/static/css/base.css',
//        '/static/images/ad/yinglun-banner.jpg'
    ),

    /**
     * cdn列表
     * 根据既定的规则，针对某个资源，从配置列表中选择一项作为url
     */
    'cdn_list' => array(
//        '//mu0.bdstatic.com',
//        '//mu1.bdstatic.com',
//        '//mu2.bdstatic.com'
    ),

    /**
     * 项目配置信息
     */
    'config' => array(
        #'is_replace_uri' => false, // 是否替换成编译后的地址 default: true
        #'is_merge_image' => false, // 是否合图替换 default:true
        #'is_md5' => false, // 是否md5 default: true
        #'is_cdn' => false, // 是否为静态资源加入cdn default: true
        #'is_compress_image' => true, // 是否将图片压缩，目前只支持png图片压缩成png8 default: false
        #'is_remove_html_comment' => false, // 是否去掉html中的注释 default: true

        /** 源码中路径配置 **/
        'src' => array(
            'root' => $root, // 代码分支根目录
            #'smarty_left_delimiter' => '{', // smarty分割符，default: { }
            #'smarty_right_delimiter' => '}',
            #'src_path' => $root.'/src', // 需要处理的源码路径 default: {src.root}/src
            #'build_path' => $root.'/build' // 编译后文件路径 default: {src.root}/build
        ),

        /** 插件配置 **/
        // requireJs插件，用于处理将加载模块路径替换为编译后的路径
        #'requirejs' => array(
            #'path' => '/static/js/require/require.js', // requireJs路径（相对src.src_path)，进行路径替换 default: null(没有默认值)
            #'map' => 'js', // 需要将什么类型的map，写入requireJs源文件中(多个用','分割) default: js
        #),
        // 增量编译插件
        #'incre' => array(
            #'is_incre' => true, // 是否进行增量编译 default: false
        #),
        // jsonMap插件，用于生成json格式的map
        #'json_map' => array(
            #'is_gen' => true, // 是否生成json格式map default：false
        #),
        // svn操作插件
        #'svnop' => array(
            #'is_svn' => true // 是否进行svn操作 default:false
        #)
    ),

    /**
     * 静态文件访问case
     * 用于决定静态文件在源码中的实际路径和在文件中被引用的路径的对应关系
     */
    #'static_case' => array(
        #'static_in_src' => '/static/js/a.js', // 在源码目录中路径
        #'static_in_file' => '/static/js/a.js' // 在文本中引用路径
    #)
);
