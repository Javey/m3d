<?php
/**
 * Created by JetBrains PhpStorm. 提供json格式的map
 * User: zoujiawei
 * Date: 13-11-21
 * Time: 下午4:30
 * To change this template use File | Settings | File Templates.
 */

on('export_map_end', 'JsonMap');

class JsonMapPlugin extends Plugin {
    // 默认配置
    protected $options = array(
        'json_map.is_gen' => false, // 是否生成json map
        'json_map.path' => '{m3d_map_path}',
        'json_map.suffix' => '{m3d_map_suffix}'
    );

    public function run($args) {
        if ($this->options['json_map.is_gen']) {
            $tool = $args[1];
            $type = $args[2];
            $map = json_encode($tool->map[$type]);
            contents_to_file(C('JSON_MAP.PATH').'/'.$type.C('JSON_MAP.SUFFIX').'.json', $map);
        }
    }
}