<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-10
 * Time: 下午3:18
 * To change this template use File | Settings | File Templates.
 */

class ModuleModel extends Model {
    public function getModules() {
        return array(
            'web' => array(
                //前端显示标题
                'title' => 'rd',
                //后台软链接文件名
                'ln_name' => 'rd-main',
                //模块名，为空则取$key
                'module_name' => '',
                //类型，标识rd/fe
                'type' => 'rd'
            ),

            'main' => array(
                'title' => 'main',
                'ln_name' => 'fe-main',
                'module_name' => 'newpcweb',
                'type' => 'fe'
            ),

            'hybrid-mac' => array(
                'title' => 'hybrid-mac',
                'ln_name' => 'hybrid-mac',
                'module_name' => 'hybrid-mac',
                'type' => 'fe'
            )
        );
    }

    public function getModuleKeys() {
        return array(
            'web',
            'main',
            'hybrid-mac'
        );
    }

    public function getModuleConfig($module=null) {
        return array(
            'ln_name' => 'fe-main', // 软链接文件名
            'src'  => 'src',//产品线文件扫描路径，默认"/"
            'svn_build' => 'build',//文件编译后的路径，默认"/"，即: BUILD_PATH.output_path
//            'build' => 'build/fe-main/',//文件编译后的路径，默认"/"，即: BUILD_PATH.$build
            'static_name' => 'static', //build放置js,css,image的路径，同时也是html中静态资源的URL，如此处为/static
            'css_prefix' => 'c', //不能为空，后面有: /st/c/带斜杠, 在html替换URL时使用的路径，如此处为:/static/css/md5.css
            'js_prefix' => 'j', //同上
            'image_prefix' => 'i',//同上
//            'png_prefix' => 'i',//同上
//            'jpg_prefix' => 'i',//同上
//            'gif_prefix' => 'i',//同上
            'swf_prefix' => 'm',//同上
            'cdn' => 2, //use cdn index

            'filter_url_prefix' => '', //filter if /player/static/js/xxx
//            'root_path' => '/home/bae/music', //product root path


//            'source_url' => 'http://'.$_GLOBAL_M3D['branch'].'.music.baidu.com',//eg: test1.music.baidu.com/
            //编译前源文件预览地址
//            'preview_url' => 'http://build.'.$_GLOBAL_M3D['branch'].'.music.baidu.com',//eg: build.test1.music.baidu.com/
            //编译后文件预览地址

            // _m3d目录
            'm3d_path' => 'static/_m3d/',

//            'cin_path' => '/static/_m3d/cin',
            //输入配置的路径，相对于SRC_PATH
            //用于存放白名单，合并配置等相关数据

            // 'cout_path' => '/static/_m3d/cout',
            //输出配置的路径，相对于SRC_PATH
            //对用户不透明,主要用于Preprocess.class.php
            //使用默认的Preprocess/cout即可

            //=========实时合图===========
//            'imerge_cin_path' => '/static/_m3d/imerge',
            //imerge合图中小配置的读取路径，默认为 INSTANTMERGE_MERGECONFIG_PATH = SRC_PATH.DS.'static'.DS.'_m3d'.DS.'imerge'

//            'imerge_cout_path' => '/static/_m3d/cout',
            //imerge合图中大图以及大图配置map输出路径

            'imerge_scan_path' => '/static/images/',
            //imerge合图中小图片的扫描路径

//            'imerge_view_root_path' => '/resources/m3dsrc',
            //imerge合图界面静态文件根路径

        );
    }
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

        $siteSrcPath = C('SITE_PATH').'/'.C('SITE_TEMP_DIR').'/'.C('SITE_SRC_DIR');
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
        $siteSrcPath = C('SITE_PATH').'/'.C('SITE_TEMP_DIR').'/'.C('SITE_SRC_DIR');
        unlink($siteSrcPath.'/'.$info->filename);

        // 从数据库删除
        $this->find($id)->delete();


        return true;
    }
}