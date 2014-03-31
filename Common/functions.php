<?php
/**
 * @fileoverview M3D工具函数集
 * @author zoujiawei@baidu.com
 * 13-3-21 下午2:03
 * Created by JetBrains PhpStorm.
 *
 * 每位工程师都有保持代码优雅的义务
 * each engineer has a duty to keep the code elegant
 */

/**
 * 优化的require_once
 * @param $filename string 文件地址
 * @return bool
 */
function require_cache($filename) {
    static $_importFiles = array();
    if (!isset($_importFiles[$filename])) {
        if (file_exists($filename)) {
            require $filename;
            $_importFiles[$filename] = true;
        } else {
            $_importFiles[$filename] = false;
        }
    }
    return $_importFiles[$filename];
}

/**
 * 批量导入文件
 * @param $files
 * @return bool
 */
function require_array($files) {
    foreach ($files as $file) {
        if (!require_cache($file)) {
            return false;
        }
    }
    return true;
}

/**
 * 错误输出
 * @param $error
 */
function halt($error) {
    $e = array();
    if (!is_array($error)) {
        $trace          = debug_backtrace();
        $e['message']   = $error;
        $e['file']      = $trace[0]['file'];
        $e['line']      = $trace[0]['line'];
        ob_start();
        debug_print_backtrace();
        $e['trace']     = ob_get_clean();
    } else {
        $e = $error;
    }
    var_dump($e);
    exit;
}

/**
 * 类似php5.3的array_replace_recursive方法
 * 参考自php文档
 * 但是为了C方法需要，将key统一转换成大些
 */
function recurse($array, $array1) {
    foreach ($array1 as $key => $value) {
        // create new key in $array, if it is empty or not an array
        if (!isset($array[$key]) || (isset($array[$key]) && !is_array($array[$key]))) {
            $array[$key] = array();
        }

        // overwrite the value in the base array
        if (is_array($value)) {
            $value = recurse($array[$key], array_change_key_case($value, CASE_UPPER));
        }
        $array[$key] = $value;
    }
    return $array;
}
function array_replace_recursive_case_upper() {
    // handle the arguments, merge one by one
    $args = func_get_args();
    $array = $args[0];
    if (!is_array($array)) {
        return $array;
    }
    for ($i = 1, $c = count($args); $i < $c; $i++) {
        if (is_array($args[$i])) {
            $array = recurse($array, array_change_key_case($args[$i], CASE_UPPER));
        }
    }
    return $array;
}

/**
 * 获取和设置配置参数 支持批量定义
 * @param string|array $name 配置变量
 * @param mixed $value 配置值
 * @return mixed
 */
function C($name=null, $value=null) {
    static $_config = array();
    // 无参数时获取所有
    if (empty($name)) {
        return $_config;
    }
    // 优先执行设置获取或赋值
    if (is_string($name)) {
        $name = strtoupper($name);
        if (!strpos($name, '.')) {
            if (is_null($value)) {
                if (isset($_config[$name])) {
                    if (is_string($_config[$name]) && preg_match('/{(.*?)}/', $_config[$name])) {
                        $_config[$name] = preg_replace_callback("/{(.*?)}/", '_config_replace', $_config[$name]);
                    }
                    return $_config[$name];
                } else {
                    return null;
                }
            }

            if (isset($_config[$name]) && is_array($_config[$name]) && is_array($value)) {
                // 如果值为数组，则merge二维数组
                $_config[$name] = array_merge($_config[$name], $value);
            } else {
                $_config[$name] = $value;
            }

        } else {
            // 二维数组设置和获取
            $name = explode('.', $name);
            if (is_null($value)) {
                if (isset($_config[$name[0]][$name[1]])) {
                    $temp = $_config[$name[0]][$name[1]];
                    if (is_string($temp) && preg_match('/{(.*?)}/', $temp)) {
                        $_config[$name[0]][$name[1]] = preg_replace_callback("/{(.*?)}/", '_config_replace', $temp);
                    }
                    return $_config[$name[0]][$name[1]];
                }else {
                    return null;
                }
            }
            $_config[$name[0]][$name[1]] = $value;
        }
    } elseif (is_array($name)){
        // 批量设置
        $_config = array_replace_recursive_case_upper($_config, $name);
    }
    return null;
}

function _config_replace($matches) {
    $config = C($matches[1]);
    if (is_null($config)) {
        halt('配置项: '. $matches[0]. ' 中引用的 '.$matches[1].'不存在');
    }
    return $config;
}

/**
 * 实例化Action
 * @param $name
 * @param string $suffix
 * @return bool
 */
function A($name, $suffix = '') {
    static $_action = array();
    $suffix = $suffix ? $suffix : C('DEFAULT_C_SUFFIX');
    $name = $suffix.'/'.$name;
    if (isset($_action[$name])) {
        return $_action[$name];
    }
    $class = basename($name.$suffix);
    if (class_exists($class)) {
        $action = new $class();
        $_action[$name] = $action;
        return $action;
    } else {
        return false;
    }
}

/**
 * 前端打印日志
 * @param $msg
 * @param string $type emphasize/normal/error/warn
 */
function mark($msg, $type = 'normal'){
    $array = array(
        'errorCode' => 200,
        'data' => array(
            'info' => $msg,
            'type' => $type
        ),
        'log' => true
    );
    $array = json_encode($array);
    echo $array.'EOF';
    ob_flush();
    flush();

//    echo 'data: '.$msg.PHP_EOL;
//    echo PHP_EOL;
//    ob_flush();
//    flush();
}

/**
 * 执行shell
 * @param $shell
 * @param bool $showInfo
 * @param bool $showError
 * @return array
 */
//function shell_exec_ensure($shell, $showInfo = true, $showError = true) {
//    // svn up时,如果包含中文名，需要导入LANG环境变量
//    exec('export LANG="zh_CN.UTF-8" && ' . 'ping www.baidu.com -c 5' . " 2>&1", $info, $ret);
//    if ($showError && $ret != 0) {
//        mark("xxxxxxxxxxxx命令执行失败xxxxxxxxxxxxxxx", 'span', 'red');
//    }
//    if ($showInfo && !empty($info)) {
////        print_r($info);
////        mark($info);
////        echo(implode(';;', $info));
////        foreach ($info as $item) {
////            mark($item);
////        }
//
//    }
//
//    return array(
//        'output' => $info,
//        'status' => $ret
//    );
//}

function shell_exec_ensure($shell, $showInfo = true, $showError = true) {
    // svn up时,如果包含中文名，需要导入LANG环境变量
//    $shell = 'ls -l ~';
//    $shell = 'ping www.baidu.com -c 5';
    $ret = array(
        'output' => '',
        'status' => 0
    );
    $descriptorspec = array(
        0 => array('pipe', 'r'),
        1 => array('pipe', 'w'),
        2 => array('pipe', 'w')
    );

    // 多命令，错误重定向
    $shell = explode(' && ', $shell);
    foreach($shell as &$cmd) {
        $cmd .= ' 2>&1';
    }
    $shell = implode($shell, ' && ');

    // 导入LANG环境变量，处理一些包含中文字符的情况，否则会报错
    $shell = 'export LANG="zh_CN.UTF-8" && '.$shell;

    $process = proc_open($shell, $descriptorspec, $pipes);
    if (is_resource($process)) {
        if ($showInfo) {
            while ($s = fgets($pipes[1])) {
                mark($s);
            }
        }

        $ret['output'] = stream_get_contents($pipes[1]);
        array_map('fclose', $pipes);
        $ret['status'] = proc_close($process);
        // 如果展示错误
        if ($showError && $ret['status']) {
            mark('执行命令：'.$shell.' 出现错误', 'error');
            mark($ret['output'], 'error');
        }
    }
    return $ret;
}

/**
 * 输出json数据
 * @param $errorCode
 * @param string $msg
 */
function show_json($msg = '', $errorCode = 200) {
    $array = array(
        'errorCode' => $errorCode,
        'data' => $msg
    );
    $array = json_encode($array);

    echo $array;
}

function show_error($msg = '', $die = false, $errorCode = 500) {
    show_json($msg, $errorCode);
    if ($die) {
        exit();
    }
}

/**
 * 二维数组根据某个值排序
 * @param $arr
 * @param $key
 * @param string $order
 */
function array_sort($arr, $key, $order='asc') {
    $ret = $keys = array();
    foreach ($arr as $k => $v) {
        $keys[$k] = $v[$key];
    }

    if ($order === 'asc') {
        asort($keys);
    } else {
        arsort($keys);
    }
    reset($keys);

    foreach ($keys as $k => $v) {
        $ret[$k] = $arr[$k];
    }

    return $ret;
}

/**
 * 按优先级，注入插件
 * @param $array
 * @param $plugin
 */
function _insert_plugin_asc(&$arr, $plugin) {
    $index = 0;
    foreach ($arr as $item) {
        if ($item['priority'] > $plugin['priority']) {
            break;
        }
        $index++;
    }

    array_splice($arr, $index, 0, array($plugin));
}

/**
 * 事件绑定
 * @param $event {String/Array} 事件名，支持多个event，绑定到同一个class
 * @param $class 类名
 * @param $priority 事件优先级 越小越优先
 */
function on($event, $class, $priority=9999) {
    $event = (array)$event;
    foreach ($event as $item) {
        $plugins = C('event.'.$item);
        if (empty($plugins)) {
            $plugins = array();
        }
        _insert_plugin_asc($plugins, array(
            'class' => $class,
            'priority' => $priority
        ));
//        $plugins = array_sort($plugins, 'priority');
        C('event.'.$item, $plugins);
    }
}

/**
 * 事件解绑
 * @param $event
 * @param $class
 */
function off($event, $class) {
    $event = (array)$event;
    foreach ($event as $item) {
        $plugins = C('event.'.$item);
        if (!empty($plugins)) {
//            unset($plugins[$class]);
            $plugins = array_filter($plugins, create_function('$v', 'return $v["class"] !== "' . $class .'";'));
            C('event.'.$item, $plugins);
        }
    }
}

/**
 * 触发事件
 * @param $event
 * @param $value
 */
function trigger() {
    $args = func_get_args();
    $event = $args[0];
    $plugins = C('event.'.$event);
    if (!empty($plugins)) {
        foreach ($plugins as $plugin) {
            $plugin = $plugin['class'];
            if (strpos($plugin, '::') !== false) {
                call_user_func($plugin, $args);
            } else {
                $class = $plugin.'Plugin';
                $plugin = new $class();
                $plugin->run($args);
            }
        }
        return true;
    } else {
        return false;
    }
}

/**
 * 执行某个插件
 * @param $name
 * @param null $params
 */
function B($name, &$params = null) {
    $class = $name.'Plugin';
    $plugin = new $class();
    $plugin->run($params);
}

/**
 * 将'a, b, c'格式的字符串转为数组，并去掉空白
 * @param $str
 * @return array
 */
function comma_str_to_array($str) {
    if (is_string($str)) {
        $str = explode(',', $str);
        $str = array_map('trim', $str);
    }

    return $str;
}

/**
 * 递归扫描，得到所需的文件
 * @param $paths
 * @param $types
 * @param string $root
 * @return array
 */
function get_files_by_type($paths, $types, $root='') {
    $ret = array();
    $paths = comma_str_to_array($paths);
    $types = comma_str_to_array($types);

    foreach ($paths as $path) {
        $glob = $root.$path.'*';
        while ($entries = glob($glob)) {
            foreach ($entries as $entry) {
                if (is_file($entry)) {
                    $extension = pathinfo($entry, PATHINFO_EXTENSION);
                    if (in_array($extension, $types)) {
                        $ret[] = $entry;
                    }
                }
            }
            $glob .='/*';
        }
    }
    return $ret;
}

/**
 * 得到文件的md5值
 * @param $contents
 * @param string $type
 * @return string
 */
function file_uid($contents, $type='') {
    static $map, $count;
    if (empty($map)) {
        $map = array_merge(range(48, 57), range(65, 90), range(97, 122));
        $count = count($map);
    }
    $seed = $contents.$type;
    $md5Code = unpack('S*', md5($seed, true));
    $uid = '';
    foreach($md5Code as $code) {
        $uid .= chr($map[$code % $count]);
    }

    return $uid;
}

/**
 * 写入内容到文件，确保文件夹存在
 * @param $path
 * @param $contents
 * @return int
 */
function contents_to_file($path, $contents) {
    $dir = dirname($path);
    if (!file_exists($dir)) {
        mkdir($dir, 0777, true);
    }
    return file_put_contents($path, $contents);
}

/**
 * 删除文件夹
 * @param $path
 * @return array|bool
 */
function rm_dir($path) {
    if (file_exists($path)) {
        return shell_exec_ensure('rm -rf '.$path, false, false);
    }
    return true;
}

/**
 * 根据开始和结束位置截取字符串
 * 与substr不同的是，传入的是两个位置信息
 * @param $str 将要被截取的字符串
 * @param $start 开始位置，负数则倒数
 * @param null $end 结束位置，不存在则到末尾，负数则倒数
 * @return string
 */
function str_slice($str, $start, $end = null) {
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

/**
 * 比较两个字符串，找到不同的部分
 * 从字符串后面开始查找，直到遇见不同的字符
 * 该函数没有返回，传入$pos引用，接受位置
 *  'abcd' & 'aacd' => $pos = -2
 * @param $str1
 * @param $str2
 * @param int $pos
 */
function str_diff($str1, $str2, &$pos = 0) {
    $len1 = strlen($str1);
    $len2 = strlen($str2);
    $minLen = min($len1, $len2);
    if ($minLen > 0) {
        $minLen = ceil($minLen / 2);
        $temp1 = array(
            'start' => str_slice($str1, 0, -$minLen),
            'end' => str_slice($str1, -$minLen)
        );
        $temp2 = array(
            'start' => str_slice($str2, 0, -$minLen),
            'end' => str_slice($str2, -$minLen)
        );
        if ($temp1['end'] === $temp2['end']) {
            $pos = $pos + $minLen;
            str_diff($temp1['start'], $temp2['start'], $pos);
        } elseif ($temp1['start'] && $temp2['start']) {
            str_diff($temp1['end'], $temp2['end'], $pos);
        }
    }
}

/**
 * 给字符串去掉一个字符串，并加上一个字符串
 * @param $str
 * @param $remove
 * @param $add
 * @return string
 */
function str_remove_add($str, $remove, $add) {
    if (!empty($remove)) {
        $len = strlen($remove);
        if (str_slice($str, 0, $len) === $remove) {
            $str = str_slice($str, $len);
        }
    }
    if (!empty($add)) {
        $str = $add.$str;
    }

    return $str;
}

/**
 * 生成随机字符串
 * @param int $length
 * @return string
 */
function str_random($length=5) {
    $ret = '';
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    $charsLen = strlen($chars);
    for ($i = 0; $i < $length; $i++) {
        $ret .= $chars[mt_rand(0, $charsLen - 1)];
    }

    return $ret;
}

/**
 * 根据文件内容返回文件类型
 * @param $content
 * @return string
 */
if (class_exists('finfo')) {
    function get_type_by_content($content) {
        $info = new finfo(FILEINFO_MIME_TYPE);
        return $info->buffer($content);
    }
} elseif (function_exists('mime_content_type')) {
    function get_type_by_content($content) {
        $tempFile = str_random(5);
        file_put_contents($tempFile, $content);
        $info = mime_content_type($tempFile);
        unlink($tempFile);
        return $info;
    }
} else {
    function get_type_by_content($content) {
        $tempFile = str_random(5);
        $info = null;
        file_put_contents($tempFile, $content);
        $cmd = 'file -nbi '.$tempFile;
        $ret = shell_exec_ensure($cmd, false, false);
        if (!$ret['status']) {
            $info = $ret['output'];
            $info = explode(';', $info);
            $info = $info[0];
        }
        unlink($tempFile);
        return $info;
    }
}