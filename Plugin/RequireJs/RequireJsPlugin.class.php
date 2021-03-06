<?php
/**
 * 处理requireJs，改变依赖模块路径
 * User: zoujiawei
 * Date: 14-03-19
 * Time: 下午4:30
 * To change this template use File | Settings | File Templates.
 */

on('one_process_end', 'RequireJs');

class RequireJsPlugin extends Plugin {
    protected $options = array(
        'requirejs.path' => null,
        'requirejs.map' => 'js',
        'requirejs.var' => '_MD5_HASHMAP'
    );

    public function run($params) {
        $item = $params[2];
        if ($this->options['requirejs.path'] && $item['processor'] === 'js') {
            mark('requireJs插件开始处理'.$this->options['requirejs.path'], 'emphasize');

            $this->options['requirejs.path'] = C('SRC.SRC_PATH').$this->options['requirejs.path'];
            if (!file_exists($this->options['requirejs.path'])) {
                mark('"' . $this->options['requirejs.path'] . '"不存在，请检查m3d.php中requireJs配置', 'error');
                return;
            }
            $tool = $params[1];
            $map = $this->getMap($tool);
            $script = $this->genScript($map);
            $processor = Preprocess::getInstance('js');
            $mapFiles = $this->options['requirejs.path'];
            if (is_string($mapFiles)) {
                $mapFiles = array($mapFiles);
            }
            foreach ($mapFiles as $file) {
                $processor->setFile($file);
                $processor->setContents($script);
                $processor->process();
                $processor->compress();

                $path = $processor->getRelativePath();
                $buildPath = $tool->writeBuildFile($processor, $item, $path);

                $oldBuildPath = $tool->getMap('js', $path);

                if ($buildPath !== $oldBuildPath) {
                    $tool->updateMap('js', $path, $buildPath);
                    // 清除文件
                    $file = C('SRC.BUILD_PATH').$oldBuildPath;
                    if (file_exists($file)) {
                        unlink($file);
                    }
                    $file = C('SRC.BUILD_CACHE_PATH').$oldBuildPath;
                    if (file_exists($file)) {
                        unlink($file);
                    }
                    trigger('change_file', $path);
                }
            }
        }
    }

    private function getMap(PreprocessTool $tool) {
        $ret = array();
        $mapKey = comma_str_to_array($this->options['requirejs.map']);

        foreach ($mapKey as $key) {
            $ret = array_merge($ret, $tool->getMap($key));
        }

        // 去掉自身
        unset($ret[str_replace(C('SRC.SRC_PATH'), '', $this->options['requirejs.path'])]);

        // map中地址为实际地址，将其变为引用地址
        // 为value加入cdn
        $ret = array_combine(
            array_map(create_function('$key', 'return Tool::getVirtualPath($key);'), array_keys($ret)),
            array_map(create_function('$value', 'return Tool::addCdn($value);'), array_values($ret))
        );

        return $ret;
    }

    private function genScript($map) {
        $ret = 'var '.$this->options['requirejs.var'].' = ';
        $ret .= json_encode($map);
        $ret .= ';';
        $ret .= file_get_contents($this->options['requirejs.path']);

        return $ret;
    }
}