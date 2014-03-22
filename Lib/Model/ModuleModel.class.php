<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-10
 * Time: 下午3:18
 * To change this template use File | Settings | File Templates.
 */

class ModuleModel extends Model {
    /**
     * 通过id找到module信息
     * @param $id
     * @return array
     */
    public function getInfoById($id) {
        $id = (array)$id;
        return $this->where('id', 'IN', $id)->findAll()->asArray();
    }

    /**
     * 找到所有的module信息
     * @return mixed
     */
    public function getAllModules() {
        return $this->findAll()->asArray();
    }

    public function getInfoByStorename($storename) {
        return $this->where('storename', '=', $storename)->findAll()->asArray();
    }

    /**
     * 添加一个新模块
     * @param $name 模块路径
     * @param $title 前端显示名
     * @return bool
     */
    public function addModule($data) {
        $name = $data['name'];
        $title = $data['title'];
        $info = $this->getInfoByStorename($name);
        if (!empty($info)) {
            show_error($name.'模块已存在', true);
        }
        $modulePath = C('SRC_PATH').'/'.$name;
        mkdir($modulePath, 0777, true);

        $siteSrcPath = C('PROJECT.SITE_PATH').'/'.C('PROJECT.TEMP_DIR').'/'.C('PROJECT.SRC_DIR');
        $cmd = 'cd '.$siteSrcPath.' && ln -snf '.C('SRC_PATH').'/'.$name.'/trunk '.$title;
        shell_exec_ensure($cmd, false, false);

        $this->set(array(
            'storename' => $name,
            'title' => $title,
            'filename' => $title,
            'description' => $data['description']
        ));
        $this->save();

        return true;
    }

    public function deleteModule($id) {
        $info = $this->getInfoById($id);
        if (empty($info)) {
            show_error('模块不存在', true);
        }
        $info = $info[0];

        // 删除src目录中所有源码
        $modulePath = C('SRC_PATH').'/'.$info->storename;
        rm_dir($modulePath);
        // 删除模板环境中src软链
        $siteSrcPath = C('PROJECT.SITE_PATH').'/'.C('PROJECT.TEMP_DIR').'/'.C('PROJECT.SRC_DIR');
        unlink($siteSrcPath.'/'.$info->filename);

        // 从数据库删除
        $this->find($id)->delete();


        return true;
    }
}