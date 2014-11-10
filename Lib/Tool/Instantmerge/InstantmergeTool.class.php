<?php
/**
 * 合图工具
 * Dependency: CSSParserTool
 * User: zoujiawei
 * Date: 13-11-11
 * Time: 下午5:27
 * To change this template use File | Settings | File Templates.
 */

defined('INSTANTMERGE_PATH') or define('INSTANTMERGE_PATH', dirname(__FILE__).'/');
// 加载编译配置
C(include INSTANTMERGE_PATH . 'config.php');

require_once('MergeConfig/MergeConfigGenerator.class.php');
require_once('MergeConfig/MergeConfigLoader.class.php');
require_once('MergeConfig/MergeConfigWriter.class.php');
require_once('MergeImage/typedef.php');
require_once('MergeImage/Image.class.php');
require_once('MergeImage/Layout.class.php');
require_once('MergeImage/Sprite.class.php');

class InstantmergeTool extends Tool {
    // 合图开始
    public function run() {
        trigger('imerge_start', $this);

        mark('开始自动合图扫描', 'emphasize');
        $files = get_files_by_type(C('SRC.SRC_PATH'), 'css');
        $generator = new MergeConfigGenerator($files);
        $generator->generate();
        $writer = new MergeConfigWriter(C('IMERGE_PATH'));
        $writer->writeImageConfig($generator->getConfig());

        // 更新大图
        $this->updateSprite();

        trigger('imerge_end', $this);
    }

    /**
     * 更新大图
     */
    public function updateSprite() {
        $types = $this->getLoader()->getTypes();
        $sprite = $this->getDraw();
        foreach ($types as $type) {
            $sprite->draw($type);
        }
    }

    public function getLoader() {
        static $loader;
        return $loader ? $loader : new MergeConfigLoader(C('IMERGE_PATH'));
    }

    public function getWriter() {
        static $writer;
        return $writer ? $writer : new MergeConfigWriter(C('IMERGE_PATH'));
    }

    public function getDraw() {
        static $draw;
        return $draw ? $draw : new Sprite(C('IMERGE_PATH'), C('SRC.SRC_PATH'));
    }
}