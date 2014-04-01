<?php

class UserModel extends Model {
    /**
     * 添加用户
     * @param $data {Array}
     */
    public function addUser($data) {
        if ($this->where('name', '=', $data['name'])->where('type', '=', $data['type'])->count()) {
            show_error('该用户已存在', true);
        }

        $this->set($data);
        $this->save();
    }

    public function getUser() {
        return $this->findAll()->asArray();
    }

    public function deleteUser($name, $type) {
        $this->where('name', '=', $name)->where('type', '=', $type)->delete();
    }
}