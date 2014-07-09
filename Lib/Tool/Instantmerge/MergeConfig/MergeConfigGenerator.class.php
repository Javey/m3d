<?php
/**
 * Created by JetBrains PhpStorm. 扫描所有css，得到所有小图配置
 * User: zoujiawei
 * Date: 13-11-13
 * Time: 下午9:21
 * To change this template use File | Settings | File Templates.
 */

require_once(PLUGIN_PATH.'/JCssParser/JCssParser.class.php');
require_once(PLUGIN_PATH.'/JCssParser/JCssStringifier.class.php');

class MergeConfigException extends Exception {}

class MergeConfigGenerator {
    private static $defaultConfig = array(
        'padding-top' => 0,
        'padding-right' => 0,
        'padding-bottom' => 0,
        'padding-left' => 0,
        'float' => 'none',
        'repeat' => 'none',
        'border-top' => 0,
        'border-right' => 0,
        'border-bottom' => 0,
        'border-left' => 0,
        'min-width' => 0,
        'min-height' => 0
    );
    private $mergeConfig = array();
    private $files = array();

    // 异常类型
    const MERGE_FLOAT_ERROR = 0;
    const MERGE_REPEAT_ERROR = 1;

    public function __construct($files) {
        $this->files = (array)$files;
    }

    public function generate() {
        foreach ($this->files as $file) {
            mark('解析CSS文件：'.$file);
            $content = file_get_contents($file);
            $cssParser = new JCssParser();
            $cssDoc = $cssParser->parse($content);

            foreach ($cssDoc['stylesheet']['rules'] as $rule) {
                if ($rule['type'] === 'rule') {
                    $bgDecls = array();
                    $merge = null;
                    foreach ($rule['declarations'] as $declaration) {
                        if (strpos($declaration['property'], 'background') !== false) {
                            array_push($bgDecls, $declaration);
                        } elseif ($declaration['property'] === 'merge') {
                            $merge = $declaration['value'];
                        }
                    }
                    if ($merge) {
                        $this->setConfigByRule($merge, $bgDecls);
                    }
                }
            }
        }
        return $this;
    }

    /**
     * 返回配置信息
     * @return array
     */
    public function getConfig() {
        return $this->mergeConfig;
    }

    /**
     * 返回默认配置信息
     * @return array
     */
    public static function getDefaultConfig() {
        return self::$defaultConfig;
    }

    private function setConfigByRule($merge, $bgDecls) {
        $mergeConfig = array();
        foreach ($bgDecls as $decl) {
            switch ($decl['property']) {
                case 'background':
                    $mergeConfig = array_merge($mergeConfig, $this->handleBackground($decl['value']));
                    break;
                case 'background-image':
                    $mergeConfig = array_merge($mergeConfig, $this->handleBackgroundImage($decl['value']));
                    break;
                case 'background-position':
                    $values = preg_split('/\s+/', $decl['value']);
                    foreach ($values as $value) {
                        $mergeConfig = array_merge($mergeConfig, $this->handleBackgroundPosition($value));
                    }
                    break;
                case 'background-repeat':
                    $mergeConfig = array_merge($mergeConfig, $this->handleBackgroundRepeat($decl['value']));
                    break;
                default:
                    break;
            }
        }

        if ($url = $mergeConfig['url']) {
            unset($mergeConfig['url']);
            $this->setConfig($merge, $url, array_merge(self::$defaultConfig, $mergeConfig));
        }

    }

    private function handleBackground($value) {
        $ret = array();
        $values = preg_split('/\s+/', $value);
        foreach ($values as $val) {
            if (($temp = $this->handleBackgroundImage($val)) && !empty($temp)) {
                $ret = array_merge($ret, $temp);
            } elseif (($temp = $this->handleBackgroundPosition($val)) && !empty($temp)) {
                $ret = array_merge($ret, $temp);
            } elseif (($temp = $this->handleBackgroundRepeat($val)) && !empty($temp)) {
                $ret = array_merge($ret, $temp);
            }
        }
        return $ret;
    }

    private function handleBackgroundImage($value) {
        $ret = array();
        if (preg_match('/(url\()([\'\"]?)([^\'\"\)]+)([\'\"]?)(\).*)/', $value, $matches)) {
            $url = $matches[3];
            $ret['url'] = $url;
            // 排除非链接，及外链
            if (strpos($url, 'data:') !== false || strpos($url, 'about:') !== false || strpos($url, '://') !== false) {
                $ret['url'] =  null;
            }
        }
        return $ret;
    }

    private function handleBackgroundPosition($value) {
        $ret = array();
        if (preg_match('/^([\d\.]+)(px)?/', $value, $matches) || in_array(strtolower($value), array('right', 'left', 'top', 'bottom'))) {
            if (!empty($matches)) {
                $value = $matches[1];
            }
            $ret = $this->getPosition($value);
        }
        return $ret;
    }

    private function handleBackgroundRepeat($value) {
        $ret = array();
        if (strpos(strtolower($value), 'repeat') !== false) {
            // 处理平铺
            $ret = $this->getRepeat($value);
        }
        return $ret;
    }

    /**
     * 设置mergeConfig，并检查合法性
     * @param $mergeValue
     * @param $url
     * @param $config
     * @throws MergeConfigException
     */
    private function setConfig($mergeValue, $url, $config) {
        $url = Tool::getActualPath($url);
        if (!isset($this->mergeConfig[$mergeValue][$url])) {
            $this->mergeConfig[$mergeValue][$url] = $config;
        } else {
            // 如果这个图片地址，之前处理过
            // 取最大的padding
            $paddings = array('padding-left', 'padding-right', 'padding-top', 'padding-bottom');
            $oldConfig = &$this->mergeConfig[$mergeValue][$url];
            foreach ($paddings as $padding) {
                $oldConfig[$padding] = max($oldConfig[$padding], $config[$padding]);
            }

            // 之前float = none，而现在float != none
            if ($oldConfig['float'] === 'none'){
                if ($config['float'] !== 'none') {
                    $oldConfig['float'] = $config['float'];
                }
            } else {
                if ($config['float'] !== 'none' && $oldConfig['float'] !== $config['float']) {
//                    throw new MergeConfigException('图片：'.$url.',被多次引用，但存在冲突，请检查background-position!', self::MERGE_FLOAT_ERROR);
                }
            }
            // 之前 repeat none, 现在 repeat !none
            if ($oldConfig['repeat'] === 'none') {
                if ($config['repeat'] !== 'none') {
                    $oldConfig['repeat'] = $config['repeat'];
                }
            } else {
                if ($config['repeat'] !== 'none' && $oldConfig['repeat'] !== $config['repeat']) {
                    throw new MergeConfigException('图片：'.$url.'，被多次引用，但存在冲突，请检查background-repeat!', self::MERGE_REPEAT_ERROR);
                }
            }
        }
    }

    /**
     * 处理图片位置, 位置参数存在负数情况，该情况默认为0
     * @param $value {Object|String}
     * @param $mergeConfig {Array}
     * @param $i {Bool} 标识是否处理x/y轴
     */
    private function getPosition($value) {
        static $i = true;
        $ret = array();
        if (is_string($value)) {
            // top, left... 处理左右浮动
            $ret['float'] = strtolower($value);
        } else {
            $paddings = array(
                array('padding-left', 'padding-right'), // 水平方向，默认让left = right
                array('padding-top', 'padding-bottom')  // 垂直方向
            );
            $paddings = $i ? $paddings[0] : $paddings[1];

            foreach ($paddings as $padding) {
                $ret[$padding] = max(self::$defaultConfig[$padding], $value);
            }
        }
        $i = !$i;
        return $ret;
    }

    /**
     * 处理平铺
     * @param $value {String}
     * @param $mergeConfig {Array}
     */
    private function getRepeat($value) {
        $ret = array();
        switch (strtolower($value)) {
            case 'repeat-x':
                $ret['repeat'] = 'x';
                break;
            case 'repeat-y':
                $ret['repeat'] = 'y';
                break;
            default:
                break;
        }
        return $ret;
    }
}