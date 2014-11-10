<?php
/**
 * Parse css to AST and stringify it
 * @example
 *  $node = JCssParser::parse('a {display: block;}');
 *  $css = JCssParser::stringify($node);
 */

/**
 * Parser
 * Class JCssParser
 */
class JCssParser {
    const COMMENT_REG = '/\/\*[^\*]*\*+([^\/\*][^\*]*\*+)*\//';

    private static $css = '';

    public static function parse($css) {
        self::$css = $css;
        return self::stylesheet();
    }

    public static function stringify($node) {
        return JCssStringifier::stringify($node);
    }

    private static function stylesheet() {
        return array(
            'type' => 'stylesheet',
            'stylesheet' => array(
                'rules' => self::rules()
            )
        );
    }

    private static function open() {
        return self::match('/^{\s*/');
    }

    private static function close() {
        return self::match('/^}\s*/');
    }

    private static function rules() {
        $rules = array();
        self::whitespace();
        self::comments($rules);
        while (strlen(self::$css) && self::$css{0} !== '}' && ($node = ($temp = self::atRule()) ? $temp : self::rule())) {
            array_push($rules, $node);
            self::comments($rules);
        }
        return $rules;
    }

    private static function match($reg) {
        if (preg_match($reg, self::$css, $matches)) {
            $str = $matches[0];
            self::$css = substr(self::$css, strlen($str));
            return $matches;
        }
        return null;
    }

    private static function whitespace() {
        self::match('/^\s*/');
    }

    private static function comments(&$rules = array()) {
        while ($c = self::comment()) {
            array_push($rules, $c);
        }
        return $rules;
    }

    private static function comment() {
        if (self::$css{0} !== '/' || self::$css{1} !== '*') {
            return null;
        }
        $i = 2;
        while (isset(self::$css{$i}) && (self::$css{$i} !== '*' || (isset(self::$css{$i + 1}) && self::$css{$i + 1} !== '/'))) {
            ++$i;
        }
        $i += 2;

        if (!isset(self::$css{$i - 1})) {
            throw new Exception('End of comment missing');
        }

        $str = substr(self::$css, 2, $i - 2 - 2);
        self::$css = substr(self::$css, $i);

        self::whitespace();

        return array(
            'type' => 'comment',
            'comment' => $str
        );
    }

    private static function selector() {
        $m = self::match('/^([^{]+)/');
        if (!$m) {
            return null;
        }
        $m = trim($m[0]);
        $m = preg_replace('/\/\*([^\*]|[\r\n]|(\*+([^\*\/]|[\r\n])))*\*\/+/', '', $m);
        $m = preg_replace_callback('/(?:"[^"]*"|\'[^\']*\')/', create_function('$m', 'return str_replace(",", "\u200C", $m[0]);'), $m);
        $m = preg_split('/\s*(?![^\(]*\)),\s*/', $m);
        return array_map(create_function('$s', 'return str_replace("/\u200C/", ",", $s);'), $m);
    }

    private static function declaration() {
        $prop = self::match('/^\s*\*?[0-9a-z_-]+\s*/');
        if (!$prop) {
            return null;
        }
        $prop = trim($prop[0]);
        if (!self::match('/^:\s*/')) {
            throw new Exception('property missing ":" at '.substr(self::$css, 0, 20));
        }
        $val = self::match('/^((?:\'(?:\\\'|.)*?\'|"(?:\\\"|.)*?"|\([^\)]*?\)|\/\*.*\*\/|[^};])+)/');
        $ret = array(
            'type' => 'declaration',
            'property' => preg_replace(self::COMMENT_REG, '', $prop),
            'value' => $val ? preg_replace(self::COMMENT_REG, '', trim($val[0])) : ''
        );

        self::match('/^[;\s]*/');
        return $ret;
    }

    private static function declarations() {
        $decls = array();
        if (!self::open()) {
            throw new Exception('missing "{" at '.substr(self::$css, 0, 20));
        }
        self::comments($decls);
        while ($decl = self::declaration()) {
            array_push($decls, $decl);
//            $decls[$decl['property']] = $decl;
            self::comments($decls);
        }
        if (!self::close()) {
            throw new Exception('missing "}" at '.substr(self::$css, 0, 20));
        }
        return $decls;
    }

    private static function keyframe() {
        $vals = array();
        while($m = self::match('/^((\d+\.\d+|\.\d+|\d+)%?|[a-z]+)\s*/')) {
            array_push($vals, $m[1]);
            self::match('/^,\s*/');
        }

        return empty($vals) ? null : array(
            'type' => 'keyframe',
            'values' => $vals,
            'declarations' => self::declarations()
        );
    }

    private static function atKeyframes() {
        $m = self::match('/^@([-\w]+)?keyframes */');
        if (!$m) {
            return null;
        }
        $vendor = isset($m[1]) ? $m[1] : null;

        $m = self::match('/^([-\w]+)\s*/');
        if (!$m) {
            throw new Exception('@keyframes missing name at '.substr(self::$css, 0, 20));
        }
        $name = $m[1];

        if (!self::open()) {
            throw new Exception('@keyframes missing "{" at '.substr(self::$css, 0, 20));
        }

        $frames = self::comments();
        while ($frame = self::keyframe()) {
            array_push($frames, $frame);
            $frames = array_merge($frames, self::comments());
        }

        if (!self::close()) {
            throw new Exception('@keyframes missing "}" at '.substr(self::$css, 0, 20));
        }

        return array(
            'type' => 'keyframes',
            'name' => $name,
            'vendor' => $vendor,
            'keyframes' => $frames
        );
    }

    private static function atMedia() {
        $m = self::match('/^@media *([^{]+)/');
        if (!$m) {
            return null;
        }
        $media = trim($m[1]);
        if (!self::open()) {
            throw new Exception('@media missing "{" at '.substr(self::$css, 0, 20));
        }
        $style = array_merge(self::comments(), self::rules());
        if (!self::close()) {
            throw new Exception('@media missing "}" at '.substr(self::$css, 0, 20));
        }

        return array(
            'type' => 'media',
            'media' => $media,
            'rules' => $style
        );
    }

    private static function atCustomMedia() {
        $m = self::match('/^@custom-media (--[^\s]+) *([^{;]+);\s*/');
        if (!$m) {
            return null;
        }
        return array(
            'type' => 'custom-media',
            'name' => trim($m[1]),
            'media' => trim($m[2])
        );
    }

    private static function atSupports() {
        $m = self::match('/^@supports *([^{]+)/');
        if (!$m) {
            return null;
        }
        $supports = trim($m[1]);
        if (!self::open()) {
            throw new Exception('@supports missing "{" at '.substr(self::$css, 0, 20));
        }
        $style = array_merge(self::comments(), self::rules());
        if (!self::close()) {
            throw new Exception('@supports missing "}" at '.substr(self::$css, 0, 20));
        }
        return array(
            'type' => 'supports',
            'supports' => $supports,
            'rules' => $style
        );
    }

    private static function atHost() {
        $m = self::match('/^@host */');
        if (!$m) {
            return null;
        }
        if (!self::open()) {
            throw new Exception('@host missing "{" at '.substr(self::$css, 0, 20));
        }
        $style = array_merge(self::comments(), self::rules());
        if (!self::close()) {
            throw new Exception('@host missing "}" at '.substr(self::$css, 0, 20));
        }
        return array(
            'type' => 'host',
            'rules' => $style
        );
    }

    private static function atPage() {
        $m = self::match('/^@page */');
        if (!$m) {
            return null;
        }
        $sel = self::selector();
        $sel = $sel ? $sel : array();
        if (!self::open()) {
            throw new Exception('@page missing "{" at '.substr(self::$css, 0, 20));
        }
        $decls = self::comments();
        while ($decl = self::declaration()) {
            array_push($decls, $decl);
            $decls = array_merge($decls, self::comments());
        }
        if (!self::close()) {
            throw new Exception('@page missing "}" at '.substr(self::$css, 0, 20));
        }
        return array(
            'type' => 'page',
            'selectors' => $sel,
            'declarations' => $decls
        );
    }

    private static function atDocument() {
        $m = self::match('/^@([-\w]+)?document *([^{]+)/');
        if (!$m) {
            return null;
        }
        $vendor = trim($m[1]);
        $doc = trim($m[2]);
        if (!self::open()) {
            throw new Exception('@document missing "{" at '.substr(self::$css, 0, 20));
        }
        $style = array_merge(self::comments(), self::rules());
        if (!self::close()) {
            throw new Exception('@document missing "}" at '.substr(self::$css, 0, 20));
        }
        return array(
            'type' => 'document',
            'document' => $doc,
            'vendor' => $vendor,
            'rules' => $style
        );
    }

    private static function atFontFace() {
        $m = self::match('/^@font-face */');
        if (!$m) {
            return null;
        }
        if (!self::open()) {
            throw new Exception('@font-face missing "{" at '.substr(self::$css, 0, 20));
        }
        $decls = self::comments();
        while ($decl = self::declaration()) {
            array_push($decls, $decl);
            $decls = array_merge($decls, self::comments());
        }
        if (!self::close()) {
            throw new Exception('@font-face missing "}" at '.substr(self::$css, 0, 20));
        }
        return array(
            'type' => 'font-face',
            'declarations' => $decls
        );
    }

    private static function atCommonRule($name) {
        $m = self::match('/^@' . $name . ' *([^;\\n]+);\s*/');
        if (!$m) {
            return null;
        }
        $ret = array(
            'type' => $name,
            $name => trim($m[1])
        );
        return $ret;
    }

    private static function atRule() {
        return self::$css{0} !== '@' ?
            null : (($ret = self::atKeyframes()) ?
            $ret : (($ret = self::atMedia()) ?
            $ret : (($ret = self::atCustomMedia()) ?
            $ret : (($ret = self::atSupports()) ?
            $ret : (($ret = self::atHost()) ?
            $ret : (($ret = self::atPage()) ?
            $ret : (($ret = self::atDocument()) ?
            $ret : (($ret = self::atFontFace()) ?
            $ret : (($ret = self::atCommonRule('import')) ?
            $ret : (($ret = self::atCommonRule('charset')) ?
            $ret : (($ret = self::atCommonRule('namespace')) ?
            $ret : null)))))))))));
    }

    private static function rule() {
        $sel = self::selector();
        if (!$sel) {
            throw new Exception('selector missing at '.substr(self::$css, 0, 20));
        }
        self::comments();
        return array(
            'type' => 'rule',
            'selectors' => $sel,
            'declarations' => self::declarations()
        );
    }
}

/**
 * Stringifier
 * Class JCssStringifier
 */
class JCssStringifier {
    public static function stringify($node) {
        return self::stylesheet($node);
    }

    private static function stylesheet($node) {
        return self::mapVisit($node['stylesheet']['rules']);
    }

    private static function import($node) {
        return '@import ' . $node['import'] . ';';
    }

    private static function media($node) {
        return '@media ' . $node['media'] . '{' . self::mapVisit($node['rules']) . '}';
    }

    private static function document($node) {
        return '@' . $node['vendor'] . 'document ' . $node['document'] . '{' . self::mapVisit($node['rules']) . '}';
    }

    private static function charset($node) {
        return '@charset ' . $node['charset'] . ';';
    }

    private static function _namespace($node) {
        return '@namespace ' . $node['namespace'] . ';';
    }

    private static function supports($node) {
        return '@supports ' . $node['supports'] . '{' . self::mapVisit($node['rules']) . '}';
    }

    private static function keyframes($node) {
        return '@' . $node['vendor'] . 'keyframes ' . $node['name'] . '{' . self::mapVisit($node['keyframes']) . '}';
    }

    private static function keyframe($node) {
        return implode(',', $node['values']) . '{' . self::mapVisit($node['declarations']) . '}';
    }

    private static function page($node) {
        return '@page ' . (empty($node['selectors']) ? '' : implode(',', $node['selectors'])) . '{' . self::mapVisit($node['declarations']) . '}';
    }

    private static function fontFace($node) {
        return '@font-face ' . '{' . self::mapVisit($node['declarations']) . '}';
    }

    private static function host($node) {
        return '@host{' . self::mapVisit($node['rules']) . '}';
    }

    private static function customMedia($node) {
        return '@custom-media ' . $node['name'] . ' ' . $node['media'] . ';';
    }

    private static function rule($node) {
        return empty($node['declarations']) ? '' : implode(',', $node['selectors']) . '{' . self::mapVisit($node['declarations']) . '}';
    }

    private static function declaration($node) {
        return $node['property'] . ':' . $node['value'] . ';';
    }

    private static function visit($node) {
        $type = $node['type'];
        switch ($type) {
            case 'namespace':
                $type = '_namespace';
                break;
            case 'font-face':
                $type = 'fontFace';
                break;
            case 'custom-media':
                $type = 'customMedia';
                break;
            default:
                break;
        }
        if (method_exists('JCssStringifier', $type)) {
            return self::$type($node);
        }
        return '';
    }

    private static function mapVisit($nodes) {
        $ret = '';
        foreach ($nodes as $node) {
            $ret .= self::visit($node);
        }

        return $ret;
    }
}