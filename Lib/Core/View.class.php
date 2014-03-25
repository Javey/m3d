<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */

class View {
    /**
     * 直接输出静态html页面
     * @param null $resourceName
     */
    public static function show($resourceName = null) {
        View::render(file_get_contents(UI_PATH.'/'.$resourceName));
    }

    /**
     * 输出内容文本可以包括Html
     * @access public
     * @param string $content 输出内容
     * @param string $charset 模板输出字符集
     * @param string $contentType 输出类型
     * @return mixed
     */
    public static function render($content, $contentType='text/html', $charset='utf8'){
        // 网页字符编码
        header('Content-Type:'.$contentType.'; charset='.$charset);
        header('X-Powered-By:M3D');
        // 输出模板文件
        echo $content;
    }
}