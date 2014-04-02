<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-11
 * Time: 下午6:03
 * To change this template use File | Settings | File Templates.
 */

class JsPreprocess extends Preprocess {
    /**
     * 需要去掉bom头
     * @param $contents
     */
    public function setContents($contents) {
        parent::setContents($contents);
        $this->removeBom();
    }

    /**
     * 预处理开始，document.write合并
     * @return mixed|void
     */
    public function process() {
        $this->handleDocumentWrite();
        $this->handleMediaResource();
    }

    /**
     * Js压缩
     * @return mixed|void
     */
    public function compress() {
        $compressor = Compressor::getInstance('js');
        $compressor->setContents($this->contents);
        $compressor->compress();
        $this->contents = $compressor->contents;
    }

    /**
     * 将document.write进来的文件合并
     */
    private function handleDocumentWrite() {
        $this->contents = preg_replace_callback(
            '/(?<!\\/{2})document\.write\\((\\\'|\\")<script(?:(?:\s+?[^>]+?)*?\s+?type=(\\\\?(?:\\\'|\\"))text\\/javascript\\2)?(?:\s+?[^>]+?)*?\s+?src=(\\\\?(?:\\\'|\\"))([^>\\s\\3]+?)\\3(?:(?:\s+?[^>]+?)*?\s+?type=\\\\?(\\\'|\\")text\\/javascript\\5)?[^>]*?>\\s*<\\/script>\\1\\);?/i',
            array($this, 'handle'),
            $this->oContents
        );
    }

    private function handle($matches) {
        $path = Tool::getActualPath($matches[4]);
        $processor = new JsPreprocess($this->map);
        $processor->setFile(C('SRC.SRC_PATH').$path);
        $processor->process();

        trigger('js_import', $this, $processor);

        return $processor->getContents();
    }

    /**
     * 处理media资源，地址替换
     */
    private function handleMediaResource() {
        $mediaTypes = MediaPreprocess::getTypes();
        $mediaTypes = array_keys($mediaTypes);
        $reg = '/(?<=[\'\"])(?:'.C('STATIC_VIRTUAL_PREFIX').'[^\'\"]*)\.(?:'.implode('|', $mediaTypes).')(?=[\'\"])/';

        preg_replace_callback($reg, array($this, 'replaceMediaPath'), $this->contents);
    }

    private function replaceMediaPath($matches) {
        $path = $matches[0];
        $aPath = Tool::getActualPath($path);
        if (isset($this->map['media'][$aPath])) {
            trigger('js_replace', $this, $aPath);
            return Tool::addCdn($this->map['media'][$aPath]);
        }
        return $path;
    }
}