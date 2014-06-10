<?php

defined('PREPROCESS_PATH') or define('PREPROCESS_PATH', dirname(__FILE__).'/');
// 加载编译配置
C(include PREPROCESS_PATH . 'Common/config.php');
// 加载处理器
require_once('Compressor/Compressor.class.php');
require_once('Compressor/JsCompressor.class.php');
require_once('Compressor/CssCompressor.class.php');
require_once('Compressor/MediaCompressor.class.php');
require_once('Common/Preprocess.class.php');
require_once('Media/MediaPreprocess.class.php');
require_once('Css/CssPreprocess.class.php');
require_once('Js/JsPreprocess.class.php');
require_once('Html/HtmlPreprocess.class.php');
require_once('Other/OtherPreprocess.class.php');

class PreprocessTool extends Tool {
    // 编译前后文件对应路径map
    private $map = array();

    public function __construct($options) {
        parent::__construct($options);
        // 加载黑名单文件
        if (!empty($this->options['black_list'])) {
            C('BLACK_LIST', $this->options['black_list']);
        }
        if (!empty($this->options['cdn_list'])) {
            C('CDN_LIST', $this->options['cdn_list']);
        }
    }

    /**
     * 编译入口
     */
    public function run() {
        // 派发预处理开始事件
        trigger('process_start', $this);

        $this->rmOldBuildFile();

        foreach ($this->options['process'] as $item) {
            trigger('one_process_start', $this, $item);

            if (empty($item['name'])) {
                // 如果不存在name，则用预处理器类型名，作为name
                // name的作用用于生成map的key，及文件名，使统一处理器，可以处理多种类型文件分别生成不同的map
                $item['name'] = $item['processor'];
            }
            // 初始化map
            if (!isset($this->map[$item['name']])) {
                $this->map[$item['name']] = array();
            }

            // 初始化预处理器
            $processor = new stdClass();
            $processor->return = null;
            trigger('processor_init', $this, $item, $processor);
            $processor = is_null($processor->return) ? Preprocess::getInstance($item['processor'], $this->map, $item) : $processor->return;

            // 如果处理图片，则需要先处理合图
            if ($processor instanceof MediaPreprocess && strpos($item['type'], 'png') !== false && C('IS_MERGE_IMAGE')) {
                $this->processSprite($processor, $item);
            }
            // 根据扫描目录和类型，扫描到所有待编译文件
            $fileList = $this->getFileList($item['from'], $item['type'], C('SRC.SRC_PATH'));

            foreach ($fileList as $file) {
                mark('处理文件：' . $file);

                $processor->setFile($file);
                $processor->process();
                $processor->compress();

                $path = $processor->getRelativePath();
                $buildPath = $this->writeBuildFile($processor, $item, $path);

                // 更新map
                $this->updateMap($item['name'], $path, $buildPath);
            }

            trigger('one_process_end', $this, $item);
            $processor->end();

            // 一种类型的文件处理完后，导出map到相应文件中
            $this->exportMapByType($item['name']);
        }

        $this->copyToTestEnv();

        // 派发预处理结束事件
        trigger('process_end', $this);
    }

    /**
     * 获取map
     * @param null $key
     * @return array|null
     */
    public function getMap($key=null) {
        return is_null($key) ?
            $this->map : (isset($this->map[$key]) ?
                $this->map[$key] : null);
    }

    /**
     * 更新map
     * @param $type 预处理器类型
     * @param $from 原始路径 如果为Array则覆盖整个map[$type]
     * @param $to 编译后路径
     */
    public function updateMap($type, $from, $to=null) {
        if (is_array($from)) {
            $this->map[$type] = $from;
        } else {
            $this->map[$type][$from] = $to;
        }
    }

    /**
     * 写编译后文件
     * @param Preprocess $processor
     * @param $item
     * @param $path
     */
    public function writeBuildFile(Preprocess $processor, $item, $path) {
        // 如果设置了to参数，则改变编译后文件路径
        if (!$this->isWhitefile($path)) {
            if (!empty($item['to'])) {
                // 是否md5化
                if (C('IS_MD5') && in_array($item['processor'], array('media', 'css', 'js'))) {
                    $path = $item['to'] .'/'. $processor->fileUid() . '.' . $processor->getType();
                } else {
                    $path = $item['to'].$path;
                    // for webapp node
//                    $path = $item['to'].'/'.$processor->getFilename();
                }
            }
        } else {
            $path = C('STATIC_VIRTUAL_PREFIX').$path;
        }

        $buildPath = C('SRC.BUILD_PATH') . $path;
        $cachePath = C('SRC.BUILD_CACHE_PATH') . $path;

        $contents = $processor->getContents();
        // 写入文件到编译后路径中
        contents_to_file($cachePath, $contents);
        contents_to_file($buildPath, $this->onlineStrReplace($contents, $processor));

        return $path;
    }

    /**
     * 清除上次编译结果
     */
    private function rmOldBuildFile() {
        $ret = new stdClass();
        $ret->return = true;
        trigger('rm_old_build_file', $ret);
        if ($ret->return) {
            $buildPath = C('SRC.BUILD_PATH');
            $cachePath = C('SRC.BUILD_CACHE_PATH');
            rm_dir($buildPath);
            rm_dir($cachePath);
        }
    }

    /**
     * 发布版本，地址替换
     * @param $contents
     * @return mixed
     */
    private function onlineStrReplace($contents, Preprocess $processor) {
        // 地址替换配置列表替换
        if (!empty($this->options['replace_list'])) {
            $contents = str_replace(
                array_keys($this->options['replace_list']),
                array_values($this->options['replace_list']),
                $contents,
                $count
            );
            if ($count) {
                mark('在文件'.$processor->getFilename().'中，找到了替换文本', 'emphasize');
            }
        }

        // cdn替换
        if (C('IS_CDN') && !empty($this->options['cdn_list'])) {
            $contents = preg_replace('/(?<=[\'\"])([^\'\"]*)(?:[\?&])'.C('CDN_IDENTIFIER').'([^\'\"]*)(?=[\'\"])/', '${2}${1}', $contents);
        }

        return $contents;
    }

    /**
     * 导出map到文件
     * @param $type 预处理器类型
     */
    private function exportMapByType($type) {
        $string = '<?php '.PHP_EOL.'return ';
        $string .= var_export($this->map[$type], true);
        $string .= ';';

        contents_to_file(C('SRC.M3D_MAP_PATH').'/'.$type.C('SRC.M3D_MAP_SUFFIX').'.php', $string);
        // 派发map写入完成事件
        trigger('export_map_end', $this, $type);
    }

    /**
     * 扫描所有文件
     * @param $paths 扫描目录
     * @param $types 扫描文件类型
     * @return array 文件列表数组
     */
    private function getFileList($paths, $types, $base='') {
        // 使用object，进行引用传参
        $ret = new stdClass();
        $ret->return = null;
        trigger('processor_fetch_files', $paths, $types, $ret);
        return is_null($ret->return) ? get_files_by_type($paths, $types, $base) : $ret->return;
    }

    /**
     * 合图文件处理
     * @param $processor
     * @param $item
     */
    private function processSprite(Preprocess $processor, $item) {
        // 确保大图最新
        $imergeTool = new InstantmergeTool($this->options, false);
        $imergeTool->updateSprite();

        // 如果处理图片类，则需要扫描合图目录
        $spriteList = $this->getFileList(C('IMERGE_PATH').'/'.C('IMERGE_SPRITE_DIR'), $item['type']);

        foreach ($spriteList as $file) {
            mark('处理文件：' . $file);
            $processor->setFile($file);
            $processor->process();
            $processor->compress(true);
            $path = str_replace(C('SRC.ROOT'), '', $file);
            $buildPath = $this->writeBuildFile($processor, $item, $path);
            // 更新map, 合图文件仅使用文件名作为key
            $filename = $processor->getFilename();
            $this->map[$item['name']][$filename] = $buildPath;
        }
    }

    /**
     * 拷贝结果到测试环境
     */
    private function copyToTestEnv() {
        $envBuildPath = PROJECT_SITE_PATH.'/'.C('PROJECT.BUILD_DIR').'/'.PROJECT_MODULE_NAME;
        if (file_exists($envBuildPath)) {
            shell_exec_ensure('rm -rf '.$envBuildPath.'/*');
        } else {
            mkdir($envBuildPath, 0777, true);
        }
        shell_exec_ensure('cp -rf '.C('SRC.BUILD_CACHE_PATH').'/* '.$envBuildPath);
    }

    /**
     * 是否是黑名单文件
     * @param $file
     * @return bool
     */
    private function isBlackFile($file) {
        return isset($this->options['black_list']) ?
            (in_array($file, $this->options['black_list']) ?
                true : false) : false;
    }

    /**
     * 是否是白名单文件
     * @param $file
     * @return bool
     */
    private function isWhiteFile($file) {
        return !empty($this->options['white_list']) ?
            (in_array($file, $this->options['white_list']) ?
                true : false) : false;
    }
}