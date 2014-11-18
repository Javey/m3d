<?php
/**
 * 帮助文档
 * User: zoujiawei
 * Date: 14-9-16
 * Time: 上午10:46
 */

require_once(LIB_PATH.'/Third/Parsedown/Parsedown.php');
require_once(LIB_PATH.'/Third/Parsedown/ParsedownExtra.php');

class DocAction extends Action {
    private $parsedown;

    public function __construct() {
        parent::__construct();
        $this->parsedown = new ParsedownExtra();
    }

    public function __call($method, $args) {
        $this->_show($method);
    }

    private function _show($name) {
        $header = file_get_contents(DOC_PATH.'/header.html');
        $footer = file_get_contents(DOC_PATH.'/footer.html');
        $body = $this->parsedown->text(file_get_contents(DOC_PATH.'/'.$name.'.md'));
        View::render($header.$body.$footer);
    }
}
