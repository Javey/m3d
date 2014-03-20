<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-13
 * Time: 下午9:10
 * To change this template use File | Settings | File Templates.
 */

class FunctionTest extends PHPUnit_Framework_TestCase {
    function testArrayMap() {
        $array = array('sdfsd ', 'sdfd', '  sdfds', ' sdf  ');
        $array = array_map('trim', $array);
        var_dump($array);
        $array = array(
            'config' => array(1, 2)
        );
        $config = $array['config'];
        $config = 3;
        print_r($array);
        $array['config'] = 3;
        print_r($array);
        $config = &$array['config'];
        $config = 4;
        print_r($array);
    }
    public function testStringRightDiff() {
        $str1 = '/common/s';
        $str2 = '/play/s';
        $this->_testStr($str1, $str2);
        $this->_testStr('/static/a.js', '/player/static/a.js');
        $this->_testStr('/player/static/a.js', '/static/a.js');
        $this->_testStr('', 'a.js');
        $this->_testStr('abb', 'abb');
        $this->_testStr('a', 'b');
    }
    private function _testStr($str1, $str2) {
        $pos = 0;
        $this->diff($str1, $str2, $pos);
        if (!$pos) {
            $pos = null;
        } else {
            $pos = -$pos;
        }
        $str1 = $this->strSlice($str1, 0, $pos);
//        var_dump($this->strSlice('aa', 0, -1));
        $str2 = $this->strSlice($str2, 0, $pos);
//        var_dump($pos);
        var_dump(array(
            'str1' => $str1,
            'str2' => $str2
        ));
    }
    private function strSlice($str, $start, $end = null) {
        if (!$str) {
            return $str;
        }
        if (!is_null($end)) {
            $len = strlen($str);
            if ($start < 0) {
                $start = $len + $start;
            }
            if ($end < 0) {
                $end = $len + $end;
            }
            if ($end < $start) {
                return $str;
            } else {
                $end = $end - $start;
                return substr($str, $start, $end);
            }
        } else {
            return substr($str, $start);
        }
    }
    private function diff($str1, $str2, &$pos = 0) {
        $len1 = strlen($str1);
        $len2 = strlen($str2);
        $minLen = min($len1, $len2);
        if ($minLen > 0) {
            $minLen = ceil($minLen / 2);
            $temp1 = array(
                'start' => $this->strSlice($str1, 0, -$minLen),
                'end' => $this->strSlice($str1, -$minLen)
            );
            $temp2 = array(
                'start' => $this->strSlice($str2, 0, -$minLen),
                'end' => $this->strSlice($str2, -$minLen)
            );
            if ($temp1['end'] === $temp2['end']) {
                $pos += $minLen;
                $this->diff($temp1['start'], $temp2['start'], $pos);
            } elseif ($temp1['start'] && $temp2['start']) {
                $this->diff($temp1['end'], $temp2['end'], $pos);
            }
        }
    }
    public function testSlice() {
        $str = '12345678';
//        $this->strSlice($str, 3);
        var_dump(substr($str, 3));
        var_dump(substr($str, -3));
        var_dump(substr($str, 3, 5));
        var_dump(substr($str, -3, 5));
        var_dump(substr($str, -3, -1));
        var_dump(substr($str, 3, -1));
        var_dump(substr($str, 3, -5));
        $this->assertEquals('45678', $this->strSlice($str, 3));
        $this->assertEquals('678', $this->strSlice($str, -3));
        $this->assertEquals('45', $this->strSlice($str, 3, 5));
        $this->assertEquals('67', $this->strSlice($str, -3, 7));
        $this->assertEquals('67', $this->strSlice($str, -3, -1));
        $this->assertEquals('4567', $this->strSlice($str, 3, -1));
        $this->assertEquals('12345678', $this->strSlice($str, 3, -6));
    }
}