<?php
/**
 * Created by JetBrains PhpStorm. 提供json格式的map
 * User: zoujiawei
 * Date: 13-11-21
 * Time: 下午4:30
 * To change this template use File | Settings | File Templates.
 */

on('export_map_end', 'MapJson');

class MapJsonPlugin extends Plugin {
    // 默认配置
    protected $options = array(
        'is_gen_json_map' => true // 是否生成json map
    );

    public function run($args) {
        if ($this->options['is_gen_json_map']) {
            $tool = $args[1];
            $type = $args[2];
            $map = json_encode($tool->map[$type]);
            contents_to_file(C('M3D_MAP_PATH').'/'.$type.'_map.json', $map);
        }
    }
}