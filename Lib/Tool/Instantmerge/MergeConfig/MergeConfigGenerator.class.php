<?php
/**
 * Created by JetBrains PhpStorm. 扫描所有css，得到所有小图配置
 * User: zoujiawei
 * Date: 13-11-13
 * Time: 下午9:21
 * To change this template use File | Settings | File Templates.
 */

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
            $cssParser = new Parser($content);
            $cssDoc = $cssParser->parse();

            foreach ($cssDoc->getAllDeclarationBlocks() as $block) {
                if ($mergeRule = $block->getRules('merge')) {
                    $mergeValue = $mergeRule[0]->getValue();
                    if (!isset($this->mergeConfig[$mergeValue])) {
                        $this->mergeConfig[$mergeValue] = array();
                    }

                    $bgValues = $block->getRulesAssoc('-background-');

                    if (isset($bgValues['background'])) {
                        // 所有属性写在单一规则里
                        $this->setConfigBySingleRule($mergeValue, $bgValues);
                    } else {
                        // 分开书写各个属性
                        $this->setConfigByMultiRule($mergeValue, $bgValues);
                    }
                }
            }
        }
//        return $this->mergeConfig;
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

    /**
     * 所有属性写在单一规则里的处理
     * @param $mergeValue {String} 大图类型
     * @param $values {Array}
     * @param $defaultConfig {Array}
     * @param $mergeConfig {Array}
     */
    private function setConfigBySingleRule($mergeValue, $bgValues) {
        $processLeft = true; // 处理位置参数时，标识是否处理x/y轴
        $mergeConfig = self::$defaultConfig;

        $values = $bgValues['background']->getValue();

        if ($values instanceof RuleValueList) {
            $values = $values->getListComponents();
        } else {
            $values = array($values);
        }

        foreach ($values as $value) {
            if ($value instanceof URL) {
                // 处理图片url
                $url = $this->getUrl($value);

            } elseif ($value instanceof Size || in_array(strtolower($value), array('right', 'left', 'top', 'bottom'))) {
                // 处理图片位置, 位置参数存在负数情况，该情况默认为0
                $position = $this->getPosition($value, $processLeft);
                $mergeConfig = array_merge($mergeConfig, $position);

            } elseif (strpos(strtolower($value), 'repeat') !== false) {
                // 处理平铺
                $repeat = $this->getRepeat($value);
                $mergeConfig = array_merge($mergeConfig, $repeat);
            }
        }

        if (isset($url)) {
            // 可能存在外链，base64... 忽略之
            $this->setConfig($mergeValue, $url, $mergeConfig);
        }
    }


    /**
     * 分开书写各个属性的处理
     * @param $mergeValue {String} 大图类型
     * @param $values {Array}
     * @param $defaultConfig {Array}
     * @param $mergeConfig {Array}
     */
    private function setConfigByMultiRule($mergeValue, $bgValues) {
        $processLeft = true; // 处理位置参数时，标示是否处理x/y轴
        $mergeConfig = self::$defaultConfig;

        // 处理图片url
        if (isset($bgValues['background-image'])) {
            $value = $bgValues['background-image']->getValue();
            if ($value instanceof URL) {
                $url = $this->getUrl($value);
            }
        }
        // 处理图片位置, 位置参数存在负数情况，该情况默认为0
        if (isset($bgValues['background-position'])) {
            $values = $bgValues['background-position']->getValue();
            if ($values instanceof RuleValueList) {
                $values = $values->getListComponents();
            } else {
                $values = array($values);
            }
            foreach ($values as $value) {
                $position = $this->getPosition($value, $processLeft);
                $mergeConfig = array_merge($mergeConfig, $position);
            }
        }
        // 处理平铺
        if (isset($bgValues['background-repeat'])) {
            $value = $bgValues['background-repeat']->getValue();
            $repeat = $this->getRepeat($value);
            $mergeConfig = array_merge($mergeConfig, $repeat);
        }

        if (isset($url)) {
            // 可能存在外链，base64... 忽略之
            $this->setConfig($mergeValue, $url, $mergeConfig);
        }
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

    private function getUrl(URL $value) {
        $url = $value->getURL();
        $url = $url->getString();
        // 排除非链接，及外链
        if (strpos($url, 'data:') !== false || strpos($url, 'about:') !== false || strpos($url, '://') !== false) {
            return null;
        }
        return $url;
    }

    /**
     * 处理图片位置, 位置参数存在负数情况，该情况默认为0
     * @param $value {Object|String}
     * @param $mergeConfig {Array}
     * @param $i {Bool} 标识是否处理x/y轴
     */
    private function getPosition($value, &$i) {
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
                $ret[$padding] = max(self::$defaultConfig[$padding], $value->getSize());
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