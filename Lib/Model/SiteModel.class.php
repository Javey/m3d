<?php

class SiteModel extends Model {
    /**
     * 获取所有环境名
     * @return array
     */
    public function getSites() {
        $ret = array();
        $sitePath = C('PROJECT.SITE_PATH');
        if (empty($sitePath)) {
            halt('没有定义存放分支站点的目录：SITE_PATH');
        }

        $rows = $this->findAll();
        foreach ($rows as $row) {
            array_push($ret, $row->name);
        }

        return $ret;
    }

    /**
     * 新增环境
     * @param array $data
     */
    public function addSite($data = array()) {
        if ($this->where('name', '=', $data['siteName'])->count()) {
            show_error('新建环境失败，该环境已存在!', true);
        }
        // 拷贝环境
        $this->copyTemplateSite($data['siteName']);

        // 更新环境模块软链
        $this->updateBranch($data);

        // 仅保存需要的模块id到数据库
        $modules = array();
        foreach ($data['modules'] as $module) {
            if ($module['checked']) {
                $modules[] = $module['id'];
            }
        }

        $this->set(array(
            'name' => $data['siteName'],
            'author' => $data['author'],
            'createTime' => date('Y/m/d', time()),
            'description' => $data['description'],
            'modules' => serialize($modules)
        ));
        $this->save();

        return true;
    }

    /**
     * 更新环境信息
     * @param $data
     * @return bool
     */
    public function updateSite($data) {
        try {
            $row = $this->find($data['id']);
        } catch(Exception $e) {
            show_error('该站点不存在', true);
            return false;
        }

        // 仅保存需要的模块id到数据库
        $modules = array();
        foreach ($data['modules'] as $module) {
            $modules[] = $module['id'];
        }

        $row->description = $data['description'];
        $row->modules = serialize($modules);
        $data['siteName'] = $row->name;
        // 更新环境模块软链
        if (!$this->updateBranch($data)) {
            return false;
        }

        $row->save();

        return true;
    }

    /**
     * 删除环境
     * @param $name
     * @return array
     */
    public function deleteSite($name) {
        $this->where('name', '=', $name)->delete();
        $path = C('PROJECT.SITE_PATH').'/'.$name;
        return shell_exec_ensure('rm -rf '.$path, false, false);
    }

    /**
     * 重建环境
     * @param array $data
     * @return bool
     */
    public function refreshSite($data = array()) {
        // 拷贝环境
        if (!$this->copyTemplateSite($data['siteName'])) {
            return false;
        };

        // 更新环境模块软链
        return $this->updateBranch($data);
    }

    /**
     * 获取环境信息
     * @param $site 环境名称
     * @return mixed
     */
    public function getSiteInfo($site) {
        $info = $this->where('name', '=', $site)->findAll()->asArray();
        if (!empty($info)) {
            $info = $info[0];

            $model = new ModuleModel();
            $modules = unserialize($info->modules);
            $modules = $model->getInfoById($modules);
            $info->modules = array();

            foreach ($modules as $module) {
                $path = C('PROJECT.SITE_PATH').'/'.$info->name.'/src/'.$module->filename;

                // realpath()会被缓存？
                $branch = basename(readlink($path));

                $module->branch = $branch;
                $info->modules[] = $module;
            }
        }

        return $info;
    }

    /**
     * 拷贝一份模板环境
     * @param $name
     */
    private function copyTemplateSite($name) {
        $dest = C('PROJECT.SITE_PATH').'/'.$name;
        if (file_exists($dest)) {
            shell_exec_ensure('rm -rf '.$dest, false, false);
        }
        $source = C('PROJECT.SITE_PATH').'/'.C('PROJECT.TEMP_DIR');
        $confPath = $dest.'/'.C('PROJECT.CONF_FILE');

        $ret = shell_exec_ensure('cp -rf '.$source.' '.$dest, false, false);
        if ($ret['status']) {
            show_error($ret['output'], true);
            return false;
        }
        $conf = file_get_contents($confPath);
        $conf = str_replace(C('PROJECT.TEMP_DIR'), $name, $conf);
        file_put_contents($confPath, $conf);
        return true;
    }

    /**
     * 更新各个模块软链接
     * @param $data
     */
    private function updateBranch($data) {
        $siteName = $data['siteName'];
        foreach ($data['modules'] as $module) {
            $path = C('PROJECT.SITE_PATH').'/'.$siteName.'/src/'.$module['filename'];
//            $svnPath = $this->getSvnPath($module['branch'], $module['type'], $module['storename']);
            $svnPath = C('SRC_PATH').'/'.$module['storename'].'/'.$module['branch'];
            $ret = shell_exec_ensure('ln -snf '.$svnPath.' '.$path, false, false);
            if ($ret['status']) {
                show_error($ret['output'], true);
                return false;
            }
        }
        return true;
    }
}