<?php
/**
 * Created by JetBrains PhpStorm. 合图配置迁移
 * User: zoujiawei
 * Date: 14-3-31
 * Time: 下午9:45
 * To change this template use File | Settings | File Templates.
 */

on('imerge_start', 'ImergeMigrate');

class ImergeMigratePlugin extends Plugin {
    protected $options = array(
        'imerge.is_migrate' => true
    );

    public function run($params) {
        if (C('IMERGE.IS_MIGRATE') && !file_exists(C('IMERGE_PATH').'/'.C('IMERGE_IMAGE_DIR'))) {
            mark('正在进行合图配置迁移...', 'emphasize');
            $tool = $params[1];
            $path = $this->findOldM3dPath();
            if ($path) {
                mark('找到旧配置文件，开始迁移...');
                $imergePath = $path.'/imerge/*';
                $entries = glob($imergePath);
                foreach ($entries as $entry) {
                    if (is_dir($entry)) {
                        $files = scandir($entry);
                        foreach ($files as $file) {
                            if ($file[0] === '_') {
                                include $entry.'/'.$file;
                            }
                        }
                        $type = basename($entry);
                        $var = 'post_'.$type.'_confs_maps';
                        if (isset($$var)) {
                            $tool->getWriter()->writeImageConfigByType($$var, $type, true);
                        }
                    }
                }
            }
        }
    }

    private function findOldM3dPath() {
        $path = C('SRC.SRC_PATH');
        $glob = $path.'/*';
        while ($entries = glob($glob)) {
            foreach ($entries as $entry) {
                if (is_dir($entry) && basename($entry) === '_m3d') {
                    return $entry;
                }
            }
            $glob .='/*';
        }
        return null;
    }
}