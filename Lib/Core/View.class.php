<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */

class View extends Smarty {
    public function __construct() {
        parent::__construct();
        $this->template_dir = UI_PATH.'/Templates';
        $this->compile_dir = UI_PATH.'/TemplatesC';
        $this->caching = C('TMPL_CACHE');
        $this->cache_dir = UI_PATH.'/Cache';
        $this->debugging = C('TMPL_DEBUG');
    }

    /**
     * 通过模板引擎渲染页面
     * @param null $resourceName
     * @param null $cacheId
     * @param null $compileId
     * @param null $parent
     */
    public function display($resourceName = null, $cacheId = null, $compileId = null, $parent = null) {
        if (empty($resourceName)) {
            $resourceName = MODULE_NAME.'/'.ACTION_NAME;
        } else if (strpos($resourceName, '/') === false) {
            $resourceName = MODULE_NAME.'/'.$resourceName;
        }
        // 如果没有指定后缀
        if (strpos($resourceName, '.') === false) {
            $resourceName = $resourceName.C('TMPL_SUFFIX');
        }
        parent::display($resourceName, $cacheId, $compileId);
    }

    /**
     * 直接输出静态html页面
     * @param null $resourceName
     */
    public static function show($resourceName = null) {
        if (empty($resourceName)) {
            $resourceName = MODULE_NAME.'/'.ACTION_NAME;
        } else if (strpos($resourceName, '/') === false) {
            $resourceName = MODULE_NAME.'/'.$resourceName;
        }
        // 如果没有指定后缀
        if (strpos($resourceName, '.') === false) {
            $resourceName = $resourceName.C('HTML_SUFFIX');
        }
        View::render(file_get_contents(UI_PATH.'/Templates/'.$resourceName));
    }

    /**
     * 输出内容文本可以包括Html
     * @access public
     * @param string $content 输出内容
     * @param string $charset 模板输出字符集
     * @param string $contentType 输出类型
     * @return mixed
     */
    public static function render($content, $charset='utf8', $contentType='text/html'){
        // 网页字符编码
        header('Content-Type:'.$contentType.'; charset='.$charset);
        header('X-Powered-By:M3D');
        // 输出模板文件
        echo $content;
    }
}