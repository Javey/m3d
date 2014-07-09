<?php
/**
 * Created by PhpStorm.
 * User: zoujiawei
 * Date: 14-7-7
 * Time: 下午8:10
 */

class JCssStringifier {
    public function stringify($node) {
        return $this->stylesheet($node);
    }

    private function stylesheet($node) {
        return $this->mapVisit($node['stylesheet']['rules']);
    }

    private function import($node) {
        return '@import ' . $node['import'] . ';';
    }

    private function media($node) {
        return '@media ' . $node['media'] . '{' . $this->mapVisit($node['rules']) . '}';
    }

    private function document($node) {
        return '@' . $node['vendor'] . 'document ' . $node['document'] . '{' . $this->mapVisit($node['rules']) . '}';
    }

    private function charset($node) {
        return '@charset ' . $node['charset'] . ';';
    }

    private function _namespace($node) {
        return '@namespace ' . $node['namespace'] . ';';
    }

    private function supports($node) {
        return '@supports ' . $node['supports'] . '{' . $this->mapVisit($node['rules']) . '}';
    }

    private function keyframes($node) {
        return '@' . $node['vendor'] . 'keyframes ' . $node['name'] . '{' . $this->mapVisit($node['keyframes']) . '}';
    }

    private function keyframe($node) {
        return implode(',', $node['values']) . '{' . $this->mapVisit($node['declarations']) . '}';
    }

    private function page($node) {
        return '@page ' . (empty($node['selectors']) ? '' : implode(',', $node['selectors'])) . '{' . $this->mapVisit($node['declarations']) . '}';
    }

    private function fontFace($node) {
        return '@font-face ' . '{' . $this->mapVisit($node['declarations']) . '}';
    }

    private function host($node) {
        return '@host{' . $this->mapVisit($node['rules']) . '}';
    }

    private function customMedia($node) {
        return '@custom-media ' . $node['name'] . ' ' . $node['media'] . ';';
    }

    private function rule($node) {
        return empty($node['declarations']) ? '' : implode(',', $node['selectors']) . '{' . $this->mapVisit($node['declarations']) . '}';
    }

    private function declaration($node) {
        return $node['property'] . ':' . $node['value'] . ';';
    }

    private function visit($node) {
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
        if (method_exists($this, $type)) {
            return $this->$type($node);
        }
        return '';
    }

    private function mapVisit($nodes) {
        $ret = '';
        foreach ($nodes as $node) {
            $ret .= $this->visit($node);
        }

        return $ret;
    }
}