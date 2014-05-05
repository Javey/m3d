<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 下午8:35
 * To change this template use File | Settings | File Templates.
 */

require_once('simple_html_dom.php');

class HtmlPreprocess extends Preprocess {
    public function process() {
        $html = str_get_html($this->contents, false);

        // 如果是空文件，直接返回
        if (!$html) {
            return;
        }

        // 如果需要进行地址替换
        if (C('IS_REPLACE_URI')) {
            $this->handleImage($html);
            $this->handleCss($html);
            $this->handleJs($html);
        }

        // 若果去掉注释
        if (C('IS_REMOVE_HTML_COMMENT')) {
            $this->removeComment($html);
        }

        $this->contents = $html->save();
        $html->clear();
        unset($html);
    }

    public function compress() {

    }

    /**
     * 处理img地址
     * @param simple_html_dom $html
     */
    private function handleImage(simple_html_dom $html) {
        foreach ($html->find('img') as $value) {
            // 是否存在org_src，图片延迟加载
            $srcName = 'src';
            if (!empty($value->org_src)) {
                $src = $value->org_src;
                $srcName = 'org_src';
            } else {
                $src = $value->src;
            }

            if (empty($src) || strpos($src, "data:") !== false || strpos($src, "about:") !== false) {
                continue;
            }

            $this->replacePath('media', $value, $srcName);
        }
    }

    /**
     * 处理css地址
     * @param simple_html_dom $html
     */
    private function handleCss(simple_html_dom $html) {
        $cssTags = $html->find('link[type="text/css"]');
        if (empty($cssTags)) {
            $cssTags = $html->find('link[rel="stylesheet"]');
        }
        foreach ($cssTags as $value) {
            if (!empty($value->href)) {
                $this->replacePath('css', $value, 'href');
            }
        }

        // 处理内联压缩
        $cssStyles = $html->find('style');
        $lDelimiter = C('SRC.SMARTY_LEFT_DELIMITER');
        $rDelimiter = C('SRC.SMARTY_RIGHT_DELIMITER');

        foreach ($cssStyles as $style) {
            if (isset($style->_xcompress) && $style->_xcompress === 'true') {
                $processor = Preprocess::getInstance('css');
                $processor->setContents($style->innertext);
                $processor->compress();

                $text = $lDelimiter.'literal'.$rDelimiter;
                $text .= $processor->getContents();
                $text .= $lDelimiter.'/literal'.$rDelimiter;

                $style->innertext = $text;

                $style->_xcompress = null;
            }
        }
    }

    /**
     * 处理js地址
     * @param simple_html_dom $html
     */
    private function handleJs(simple_html_dom $html) {
        $lDelimiter = C('SRC.SMARTY_LEFT_DELIMITER');
        $rDelimiter = C('SRC.SMARTY_RIGHT_DELIMITER');

        foreach ($html->find('script') as $value) {
            if (!empty($value->src)) {
                $this->replacePath('js', $value, 'src');
            } else {
                // 处理内联js
                if (isset($value->_xcompress) && $value->_xcompress === 'true') {
                    $processor = Preprocess::getInstance('js');
                    $processor->setContents($value->innertext);
                    $processor->compress();

                    $text = $lDelimiter.'literal'.$rDelimiter;
                    $text .= $processor->getContents();
                    $text .= $lDelimiter.'/literal'.$rDelimiter;

                    $value->innertext = $text;

                    $value->_xcompress = null;
                }
            }
        }
    }

    /**
     * 进行地址替换
     * @param $type
     * @param $key
     * @param $orgValue
     */
    private function replacePath($type, &$key, $prop) {
        $value = $key->$prop;
        // 去掉queryString
        $pos = strpos($value, '?');
        if ($pos !== false) {
            $value = substr($value, 0, $pos);
        }
        $value = Tool::getActualPath($value);
        if (isset($this->map[$type][$value])) {
            $key->$prop = Tool::addCdn($this->map[$type][$value]);

            trigger('html_href_change', $this, $value);
        }
    }

    /**
     * 去掉注释
     * @param simple_html_dom $html
     */
    private function removeComment(simple_html_dom $html) {
        foreach ($html->find('comment') as $value) {
            if ((strpos($value->outertext, '<!--[if') === false)
                && (strpos($value->outertext, '<!--STATUS') === false)
                && (strpos($value->outertext, '<!--<!') === false) // cover这一类注释: <!--[if !IE]>-->xxxxxxxxx......<!--<![endif]-->
            ) {
                $value->outertext = '';
            }
        }
    }
}