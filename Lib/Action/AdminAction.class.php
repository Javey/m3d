<?php

class AdminAction extends Action {
    public function addSite() {
        Model::create('site', array(
            'name' => 'string',
            'author' => 'string',
            'createTime' => 'string',
            'description' => 'string',
            'modules' => 'string'
        ));
    }

    public function info() {
        phpinfo();
    }

    public function delSite() {
        Model::remove('site');
    }

    public function getSite() {
        $model = new Model('site');
        var_dump($model);
        $data = $model->findAll();
        var_dump($data);
    }

    public function addInfo() {
        $model = new Model('site');

        $model->set(array(
            'name' => 'javey',
            'author' => 'Javey',
            'createTime' => '2014',
            'description' => 'test',
            'modules' => serialize(array(1, 2))
        ));
        $model->save();
    }

    public function getInfo() {
        $site = 'javey_test1';
        $model = new Model('site');
        $info = $model->where('name', '=', $site)->findAll();
        var_dump($info);
    }

    public function createModule() {
//        Model::create('module', array(
//            'title' => 'string',
//            'filename' => 'string',
//            'type' => 'string',
//            'storename' => 'string'
//        ));
        Model::create('module', array(
            'title' => 'string',
            'filename' => 'string',
            'storename' => 'string',
            'description' => 'string'
        ));
    }

    public function deleteModule() {
        Model::remove('module');
    }

    public function addModule() {
        $model = new Model('module');
        $model->set(array(
            'title' => 'fe-main',
            'filename' => 'fe-main',
            'type' => 'fe',
            'storename' => 'string'
        ));
        $model->save();
    }
}