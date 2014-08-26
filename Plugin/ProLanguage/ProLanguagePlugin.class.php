<?php
/**
 * 前端编译语言扩展
 * User: zoujiawei
 * Date: 14-8-22
 * Time: 下午2:12
 */

C(include 'config.php');

on(array('process_css_start', 'process_js_start'), 'ProLanguage');

class ProLanguagePlugin extends Plugin {
    public function run($params) {
        $processor = $params[1];
        switch ($processor->getType()) {
            case 'coffee':
                $this->compile($processor, C('COFFEE').' -bsp', 'js');
                break;
            case 'sass':
                $this->compile($processor, C('SASS').' -s -I '.C('SRC.SRC_PATH'), 'css');
                break;
        }
    }

    private function compile($processor, $exec, $ext) {
        $content = $processor->getContents();
        $content = shell_exec_stdio($exec, $content);
        $relativePath = $processor->getRelativePath();
        $relativePath = str_slice($relativePath, 0, -strlen($processor->getType())) . $ext;
        $processor->setType($ext);
        $processor->setRelativePath($relativePath);
        $processor->setContents($content);
    }
}