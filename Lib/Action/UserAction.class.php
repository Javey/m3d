<?php
/**
 * Created by JetBrains PhpStorm. 用户名管理
 * User: zoujiawei
 * Date: 14-4-1
 * Time: 下午4:52
 * To change this template use File | Settings | File Templates.
 */

class UserAction extends Action {
    public function index() {
        switch ($this->method) {
            case 'get':
                $this->getUser();
                break;
            case 'post':
                $this->addUser();
                break;
            case 'delete':
                $this->deleteUser();
                break;
        }
    }

    private function getUser() {
        $model = new UserModel();
        $ret = $model->getUser();
        show_json($ret);
    }

    private function addUser() {
        $data = array(
            'name' => $_POST['name'],
            'email' => $_POST['email'],
            'type' => $_POST['type']
        );

        $model = new UserModel();
        $model->addUser($data);
        show_json();
    }

    private function deleteUser() {
        $model = new UserModel();
        $model->deleteUser($_POST['name'], $_POST['type']);
        show_json();
    }
}