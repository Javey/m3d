<?php
/**
 * Model类
 * User: Administrator
 * Date: 13-4-9
 * Time: 下午11:30
 * To change this template use File | Settings | File Templates.
 */

// 包含Db文件
require_cache(LIB_PATH.'/Third/Lazer/bootstrap.php');

class Model {
    protected $name = '';
    protected $db = null;

    public function __construct($name = '') {
        $this->name = $name === '' ? strtolower($this->getModelName()) : $name;
        $this->database($this->name);
    }

    public function getModelName() {
        if (empty($this->name)) {
            $this->name = substr(get_class($this), 0, -5);
        }
        return $this->name;
    }

    public static function create($tableName, $schema) {
        Database::create($tableName, $schema);
    }

    public static function remove($tableName) {
        Database::remove($tableName);
    }

    public function __call($method, $args) {
        if (is_callable(array($this->db, $method))) {
            return call_user_func_array(array($this->db, $method), $args);
        } else {
            halt('方法不存在或不可调用');
            return null;
        }
    }

    public function set($data = array()) {
        foreach ($data as $key => $value) {
            $this->db->$key = $value;
        }
    }

    private function database($name) {
        if ($this->db) {
            return $this->db;
        }
        $this->db = Database::table($name);
        return $this->db;
    }
}