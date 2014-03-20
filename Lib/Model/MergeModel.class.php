<?php

class MergeModel extends Model {
    private $mergeLoader = null;

    public function __construct() {
        $this->mergeLoader = new MergeConfigLoader(M3D_PATH.'/Test/src/static/_m3d/');
        $this->mergeLoader->load();
    }
    public function getAllTypes() {
        return $this->mergeLoader->getAllTypes();
    }
    public function getAllConfigByType($type) {
        return $this->mergeLoader->getAllConfigByType($type);
    }
}