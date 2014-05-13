<?php
/**
 * Created by PhpStorm. Css预处理器，node版
 * User: zoujiawei tanghao
 * Date: 14-5-12
 * Time: 下午3:13
 */

//on('processor_init', 'NodeCssPreprocess');

class NodeCssPreprocessPlugin extends Plugin {
    public function run($params) {
        $tool = $params[1]; // 第1个参数是PreprocessTool对象
        $options = $params[2]; // 第2个参数是配置信息
        $processor = $params[3]; // 第3个参数是返回，将最后的预处理器对象赋给$processor->return

        // 判断当前是否在初始化CssPreprocess
        if ($options['processor'] === 'css') {
            $processor->return = new NodeCssPreprocess($tool->getMap(), $options);
        }
    }
}

/**
 * css预处理器node版，继承CssPreprocess，有些方法可以复用
 * 有些数据可以直接通过$this获取
 *      $this->spriteConfig = Array() {Array} 合图配置表
 *      $this->isMergeImage = true {Boolean} 是否进行合图替换
 *
 * Class NodeCssPreprocess
 * Extend CssPreprocess
 */
class NodeCssPreprocess extends CssPreprocess {
    /**
     * css解析入口
     * @param $contents {String} css文本内容
     * @return string {String} 处理后的文件
     */
    protected function cssParse($contents) {
        // 处理逻辑
        return $contents;
    }
}
