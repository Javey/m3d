<?php

class AdminAction extends Action {
//    public function addSite() {
//        Model::create('site', array(
//            'name' => 'string',
//            'author' => 'string',
//            'createTime' => 'string',
//            'description' => 'string',
//            'modules' => 'string'
//        ));
//    }

    public function info() {
        phpinfo();
    }

    public function m3d() {
        $file = M3D_CORE_PATH.'/Install/m3d.php';
        View::render(file_get_contents($file), 'application/x-javascript');
    }

    public function createUserDb() {
        Model::create('user', array(
            'name' => 'string',
            'email' => 'string',
            'type' => 'string'
        ));
    }

//    public function delSite() {
//        Model::remove('site');
//    }
//
//    public function getSite() {
//        $model = new Model('site');
//        var_dump($model);
//        $data = $model->findAll();
//        var_dump($data);
//    }
//
//    public function addInfo() {
//        $model = new Model('site');
//
//        $model->set(array(
//            'name' => 'javey',
//            'author' => 'Javey',
//            'createTime' => '2014',
//            'description' => 'test',
//            'modules' => serialize(array(1, 2))
//        ));
//        $model->save();
//    }
//
//    public function getInfo() {
//        $site = 'javey_test1';
//        $model = new Model('site');
//        $info = $model->where('name', '=', $site)->findAll();
//        var_dump($info);
//    }
//
//    public function createModule() {
//        Model::create('module', array(
//            'title' => 'string',
//            'filename' => 'string',
//            'storename' => 'string',
//            'description' => 'string',
//            'fe' => 'integer'
//        ));
//    }
//
//    public function deleteModule() {
//        Model::remove('module');
//    }

//    public function addModule() {
//        $model = new Model('module');
//        $model->set(array(
//            'title' => 'fe-main',
//            'filename' => 'fe-main',
//            'type' => 'fe',
//            'storename' => 'string'
//        ));
//        $model->save();
//    }

//    public function flush() {
//        ob_end_flush();
//        ob_start();
//        ob_implicit_flush(1);
//        for ($i = 0; $i < 20; $i++) {
//            echo 'good'.$i;
//            ob_flush();
//            flush();
//            sleep(1);
//        }
//    }
}