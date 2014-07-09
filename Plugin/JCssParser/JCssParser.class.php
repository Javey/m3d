<?php

class JCssParser {
    const COMMENT_REG = '/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//';

    private $css = '';

    public function parse($css) {
        $this->css = $css;
        return $this->stylesheet();
    }

    private function stylesheet() {
        return array(
            'type' => 'stylesheet',
            'stylesheet' => array(
                'rules' => $this->rules()
            )
        );
    }

    private function open() {
        return $this->match('/^{\s*/');
    }

    private function close() {
        return $this->match('/^}\s*/');
    }

    private function rules() {
        $rules = array();
        $this->whitespace();
        $this->comments($rules);
        while (strlen($this->css) && $this->css{0} !== '}' && ($node = ($temp = $this->atRule()) ? $temp : $this->rule())) {
            array_push($rules, $node);
            $this->comments($rules);
        }
        return $rules;
    }

    private function match($reg) {
        if (preg_match($reg, $this->css, $matches)) {
            $str = $matches[0];
            $this->css = substr($this->css, strlen($str));
            return $matches;
        }
        return null;
    }

    private function whitespace() {
        $this->match('/^\s*/');
    }

    private function comments(&$rules = array()) {
        while ($c = $this->comment()) {
            array_push($rules, $c);
        }
        return $rules;
    }

    private function comment() {
        if ($this->css{0} !== '/' || $this->css{1} !== '*') {
            return null;
        }
        $i = 2;
        while (isset($this->css{$i}) && ($this->css{$i} !== '*' || (isset($this->css{$i + 1}) && $this->css{$i + 1} !== '/'))) {
            ++$i;
        }
        $i += 2;

        if (!isset($this->css{$i - 1})) {
            throw new Exception('End of comment missing');
        }

        $str = substr($this->css, 2, $i - 2 - 2);
        $this->css = substr($this->css, $i);

        $this->whitespace();

        return array(
            'type' => 'comment',
            'comment' => $str
        );
    }

    private function selector() {
        $m = $this->match('/^([^{]+)/');
        if (!$m) {
            return null;
        }
        $m = trim($m[0]);
        $m = preg_replace('/\/\*([^\*]|[\r\n]|(\*+([^\*\/]|[\r\n])))*\*\/+/', '', $m);
        $m = preg_replace_callback('/(?:"[^"]*"|\'[^\']*\')/', create_function('$m', 'return str_replace(",", "\u200C", $m[0]);'), $m);
        $m = preg_split('/\s*(?![^\(]*\)),\s*/', $m);
        return array_map(create_function('$s', 'return str_replace("/\u200C/", ",", $s);'), $m);
    }

    private function declaration() {
        $prop = $this->match('/^\s*\*?[0-9a-z_-]+\s*/');
        if (!$prop) {
            return null;
        }
        $prop = trim($prop[0]);
        if (!$this->match('/^:\s*/')) {
            throw new Exception('property missing ":"');
        }
        $val = $this->match('/^((?:\'(?:\\\'|.)*?\'|"(?:\\\"|.)*?"|\([^\)]*?\)|[^};](?!\/\*))+)/');
        $ret = array(
            'type' => 'declaration',
            'property' => preg_replace(self::COMMENT_REG, '', $prop),
            'value' => $val ? preg_replace(self::COMMENT_REG, '', trim($val[0])) : ''
        );

        $this->match('/^[;\s]*/');
        return $ret;
    }

    private function declarations() {
        $decls = array();
        if (!$this->open()) {
            throw new Exception('missing "{"');
        }
        $this->comments($decls);
        while ($decl = $this->declaration()) {
            array_push($decls, $decl);
//            $decls[$decl['property']] = $decl;
            $this->comments($decls);
        }
        if (!$this->close()) {
            var_dump($this->css);
            throw new Exception('missing "}"');
        }
        return $decls;
    }

    private function keyframe() {
        $vals = array();
        while($m = $this->match('/^((\d+\.\d+|\.\d+|\d+)%?|[a-z]+)\s*/')) {
            array_push($vals, $m[1]);
            $this->match('/^,\s*/');
        }

        return empty($vals) ? null : array(
            'type' => 'keyframe',
            'values' => $vals,
            'declarations' => $this->declarations()
        );
    }

    private function atKeyframes() {
        $m = $this->match('/^@([-\w]+)?keyframes */');
        if (!$m) {
            return null;
        }
        $vendor = isset($m[1]) ? $m[1] : null;

        $m = $this->match('/^([-\w]+)\s*/');
        if (!$m) {
            throw new Exception('@keyframes missing name');
        }
        $name = $m[1];

        if (!$this->open()) {
            throw new Exception('@keyframes missing "{"');
        }

        $frames = $this->comments();
        while ($frame = $this->keyframe()) {
            array_push($frames, $frame);
            $frames = array_merge($frames, $this->comments());
        }

        if (!$this->close()) {
            throw new Exception('@keyframes missing "}"');
        }

        return array(
            'type' => 'keyframes',
            'name' => $name,
            'vendor' => $vendor,
            'keyframes' => $frames
        );
    }

    private function atMedia() {
        $m = $this->match('/^@media *([^{]+)/');
        if (!$m) {
            return null;
        }
        $media = trim($m[1]);
        if (!$this->open()) {
            throw new Exception('@media missing "{"');
        }
        $style = array_merge($this->comments(), $this->rules());
        if (!$this->close()) {
            throw new Exception('@media missing "}"');
        }

        return array(
            'type' => 'media',
            'media' => $media,
            'rules' => $style
        );
    }

    private function atCustomMedia() {
        $m = $this->match('/^@custom-media (--[^\s]+) *([^{;]+);\s*/');
        if (!$m) {
            return null;
        }
        return array(
            'type' => 'custom-media',
            'name' => trim($m[1]),
            'media' => trim($m[2])
        );
    }

    private function atSupports() {
        $m = $this->match('/^@supports *([^{]+)/');
        if (!$m) {
            return null;
        }
        $supports = trim($m[1]);
        if (!$this->open()) {
            throw new Exception('@supports missing "{"');
        }
        $style = array_merge($this->comments(), $this->rules());
        if (!$this->close()) {
            throw new Exception('@supports missing "}"');
        }
        return array(
            'type' => 'supports',
            'supports' => $supports,
            'rules' => $style
        );
    }

    private function atHost() {
        $m = $this->match('/^@host */');
        if (!$m) {
            return null;
        }
        if (!$this->open()) {
            throw new Exception('@host missing "{"');
        }
        $style = array_merge($this->comments(), $this->rules());
        if (!$this->close()) {
            throw new Exception('@host missing "}"');
        }
        return array(
            'type' => 'host',
            'rules' => $style
        );
    }

    private function atPage() {
        $m = $this->match('/^@page */');
        if (!$m) {
            return null;
        }
        $sel = $this->selector();
        $sel = $sel ? $sel : array();
        if (!$this->open()) {
            throw new Exception('@page missing "{"');
        }
        $decls = $this->comments();
        while ($decl = $this->declaration()) {
            array_push($decls, $decl);
            $decls = array_merge($decls, $this->comments());
        }
        if (!$this->close()) {
            throw new Exception('@page missing "}"');
        }
        return array(
            'type' => 'page',
            'selectors' => $sel,
            'declarations' => $decls
        );
    }

    private function atDocument() {
        $m = $this->match('/^@([-\w]+)?document *([^{]+)/');
        if (!$m) {
            return null;
        }
        $vendor = trim($m[1]);
        $doc = trim($m[2]);
        if (!$this->open()) {
            throw new Exception('@document missing "{"');
        }
        $style = array_merge($this->comments(), $this->rules());
        if (!$this->close()) {
            throw new Exception('@document missing "}"');
        }
        return array(
            'type' => 'document',
            'document' => $doc,
            'vendor' => $vendor,
            'rules' => $style
        );
    }

    private function atFontFace() {
        $m = $this->match('/^@font-face */');
        if (!$m) {
            return null;
        }
        if (!$this->open()) {
            throw new Exception('@font-face missing "{"');
        }
        $decls = $this->comments();
        while ($decl = $this->declaration()) {
            array_push($decls, $decl);
            $decls = array_merge($decls, $this->comments());
        }
        if (!$this->close()) {
            throw new Exception('@font-face missing "}"');
        }
        return array(
            'type' => 'font-face',
            'declarations' => $decls
        );
    }

    private function atCommonRule($name) {
        $m = $this->match('/^@' . $name . ' *([^;\\n]+);\s*/');
        if (!$m) {
            return null;
        }
        $ret = array(
            'type' => $name,
            $name => trim($m[1])
        );
        return $ret;
    }

    private function atRule() {
        return $this->css{0} !== '@' ?
            null : (($ret = $this->atKeyframes()) ?
            $ret : (($ret = $this->atMedia()) ?
            $ret : (($ret = $this->atCustomMedia()) ?
            $ret : (($ret = $this->atSupports()) ?
            $ret : (($ret = $this->atHost()) ?
            $ret : (($ret = $this->atPage()) ?
            $ret : (($ret = $this->atDocument()) ?
            $ret : (($ret = $this->atFontFace()) ?
            $ret : (($ret = $this->atCommonRule('import')) ?
            $ret : (($ret = $this->atCommonRule('charset')) ?
            $ret : (($ret = $this->atCommonRule('namespace')) ?
            $ret : null)))))))))));
    }

    private function rule() {
        $sel = $this->selector();
        if (!$sel) {
            throw new Exception('selector missing');
        }
        $this->comments();
        return array(
            'type' => 'rule',
            'selectors' => $sel,
            'declarations' => $this->declarations()
        );
    }
}