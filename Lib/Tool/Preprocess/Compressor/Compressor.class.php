<?php
/**
 * Created by JetBrains PhpStorm. 文件压缩抽象类
 * User: zoujiawei
 * Date: 13-11-12
 * Time: 下午6:10
 * To change this template use File | Settings | File Templates.
 */

abstract class Compressor {
    protected $contents;
    protected $beforeSize;
    protected $afterSize;

    public function __construct($contents) {
        $this->contents = $contents;
        $this->beforeSize = strlen($contents) / 1024;
    }

    public function exec($exec){
        $descriptorspec = array(
            0 => array("pipe", "r"), // stdin
            1 => array("pipe", "w"), // stdout
            2 => array("pipe", "w") // stderr
        );
        //windows only, bypass cmd.exe shell when set to TRUE
        $options = array('bypass_shell' => true);
        $process = proc_open($exec, $descriptorspec, $pipes, null, null, $options);
        if (is_resource($process)) {
            fwrite($pipes[0], $this->contents);
            fclose($pipes[0]);
            $output = stream_get_contents($pipes[1]);
            fclose($pipes[1]);
            $err = stream_get_contents($pipes[2]);
            fclose($pipes[2]);
            $ret = proc_close($process);
            if ($ret !== 0) {
                mark('文件压缩错误,返回值:' . $ret . ',errmsg:' . $err, 'error');
                return $this->contents;
            }
            return $output;
        } else {
            mark('文件压缩错误,执行命令' . $exec . '失败', 'error');
            return $this->contents;
        }
    }

    abstract public function compress($option=null);

    public function __get($name) {
        return isset($this->$name) ? $this->$name : null;
    }
}