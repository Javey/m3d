<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-11-8
 * Time: 下午5:37
 * To change this template use File | Settings | File Templates.
 */


class CssPreprocess extends Preprocess {
    // 合图配置表
    private $spriteConfig = array();
    // 是否进行合图处理
    private $isMergeImage = true;
    private $isReplaceUri = true;

    // 记录已解析文件的map
    private static $cacheDir;
    private static $cacheMap = array();


    public function __construct($map, $isMergeImage=null, $isReplaceUri=null) {
        parent::__construct($map);
        $this->isMergeImage = is_null($isMergeImage) ? C('IS_MERGE_IMAGE') : $isMergeImage;
        $this->isReplaceUri = is_null($isReplaceUri) ? C('IS_REPLACE_URI') : $isReplaceUri;

        if (!self::$cacheDir) {
            self::$cacheDir = C('CSS_CACHE_PATH').'/'.str_random();
        }

        // 如果需要合图，则导入合图配置
        if ($this->isMergeImage) {
            $loader = new MergeConfigLoader(C('IMERGE_PATH'));
            $this->spriteConfig = $loader->getSpriteConfig();
        }
    }

    /**
     * 预处理开始
     * @return mixed|void
     */
    public function process() {
        $path = $this->getRelativePath();
        if (isset(self::$cacheMap[$path])) {
            $this->contents = file_get_contents(self::$cacheMap[$path]);
        } else {
            $this->contents = $this->isBlackFile() ? $this->oContents : $this->cssParse($this->oContents);
            self::updateCache($path, $this->contents);
        }
    }

    /**
     * 压缩css
     * @return mixed|void
     */
    public function compress() {
        $compressor = new CssCompressor($this->contents);
        $compressor->compress();
        $this->contents = $compressor->contents;
    }

    /**
     * 删除cache文件夹
     */
    public function end() {
        rm_dir(self::$cacheDir);
    }

    /**
     * 解析，处理css
     * @param $contents
     * @return string
     */
    private function cssParse($contents) {
        $cssParser = new Parser($contents);
        $cssDoc = $cssParser->parse();

        // TODO import文件编译缓存
        $importContents = $this->handleImport($cssDoc);

        // 如果需要进行地址替换
        if ($this->isReplaceUri) {
            $this->handleBackground($cssDoc);
        }

//        trigger('CSS_PARSE', $cssDoc, 'hello world');

        return $importContents.$cssDoc->__toString();
    }

    /**
     * 递归处理import，将import进行合并
     * @param Document $cssDoc
     * @return mixed
     */
    private function handleImport(Document $cssDoc) {
        $allValues = $cssDoc->getAllValues();

        foreach ($allValues as $value) {
            if ($value instanceof Import) {
                $path = $value->getLocation()->getURL()->__toString();
                $path = trim($path, '"');
                $path = Tool::getActualPath($path);

                $processor = new CssPreprocess($this->map);
                $processor->setFile(C('SRC.SRC_PATH').$path);
                $processor->process();
                $this->contents .= $processor->getContents();
                $value->setRemoveImport(true);

                trigger('css_import', $this, $processor);
            }
        }

        return $this->contents;
    }

    /**
     * 找到需要处理的background，filter属性，进行处理
     * @param Document $cssDoc
     */
    private function handleBackground(Document $cssDoc) {
        foreach ($cssDoc->getAllDeclarationBlocks() as $block) {
            $merge = $this->isMergeImage ? (($mergeRule = $block->getRules('merge')) ? $mergeRule[0]->getValue() : null) : null;
            $bgValues = $block->getRulesAssoc('-background-');

            $this->rewriteBackground($block, $bgValues, $merge);
            $this->rewriteFilter($block);
        }
    }

    /**
     * 找到需要处理的background，进行处理
     * 支持自定义属性merge，进行合图替换
     * @param DeclarationBlock $block
     */
    private function rewriteBackground(DeclarationBlock $block, &$bgValues, $merge) {
        $values = array();

        if (isset($bgValues['background'])) {
            // 写的是background属性
            $values = $bgValues['background']->getValue();
            if ($values instanceof RuleValueList) {
                $values = $values->getListComponents();
            } else {
                $values = array($values);
            }
        } else if (isset($bgValues['background-image'])) {
            // 写的是background-image属性
            $values = $bgValues['background-image']->getValue();
            $values = array($values);
        }

        if (!empty($values)) {
            $config = null;
            foreach ($values as $value) {
                if ($value instanceof URL) {
                    // 找到url，开始替换
                    $config = $this->rewriteBackgroundUrl($value, $merge);
                    break;
                }
            }

            if ($merge) {
                $block->removeRule('merge');
                if ($config) {
                    $position = array(
                        'left' => $config['left'],
                        'top' => $config['top']
                    );
                    // 需要先设置backgroundSize，可能需要修正position
                    $this->rewriteBackgroundSize($bgValues, $config, $this->spriteConfig[$merge]['attr'], $position);
                    $this->rewriteBackgroundPosition($block, $bgValues, $position);
                }
            }
        }
    }

    /**
     * 处理滤镜图片
     * @param DeclarationBlock $block
     */
    private function rewriteFilter(DeclarationBlock $block) {
        $bgValues = ($temp = $block->getRules('_filter')) ?
            $temp : (($temp = $block->getRules('-ms-filter')) ?
                $temp : (($temp = $block->getRules('filter')) ?
                    $temp : null));

        if ($bgValues === null) {
            return;
        }

        // 分辨是不是滤镜图片
        $rule = $bgValues[0]->__toString();
        if (strpos($rule, 'progid') === false || strpos($rule, 'AlphaImageLoader') === false) {
            return;
        }

        $filterValue = $bgValues[0]->getValue()->getListComponents();
        $filterValue = $filterValue[2]->getArguments();

        foreach($filterValue as $fValues) {
            $fValues = $fValues->getListComponents();
            if (strpos($fValues[0], "src") !== false) {
                $filterStringObj = $fValues[1];
                $this->rewriteBackgroundUrl($filterStringObj);
                break;
            }
        }
    }

    /**
     * 替换url
     * @param PrimitiveValue $url
     * @param null $merge
     * @return array|null
     */
    private function rewriteBackgroundUrl(PrimitiveValue $url, $merge=null) {
        // 将合图配置信息返回
        $ret = null;

        // background传入的是URL对象
        // filter传入的是String对象
        if ($url instanceof URL) {
            $urlString = $url->getURL()->__toString();
            $setMethod = 'setURL';
        } elseif ($url instanceof String) {
            $urlString = $url->getString();
            $setMethod = 'setString';
        } else {
            throw new PreprocessException('参数错误');
        }

        $urlString = trim($urlString, '"');
        $newUrl = $urlString;

        if (
            strpos($urlString, 'data:') !== false ||
            strpos($urlString, 'about:') !== false ||
            strpos($urlString, '://') !== false
        ) {
            return null;
        }

        // 根据引用地址，获取真实文件地址
        $urlString = Tool::getActualPath($urlString);

        $mask = 0;
        $mask += isset($merge);
        $mask += ($mask > 0 && isset($this->spriteConfig[$merge]));
        $mask += ($mask > 1 && isset($this->spriteConfig[$merge]['config'][$urlString]));

        $mask <<= 1;
        $mask += isset($this->map['media'][$urlString]);

        if (($mask & 6) === 6) {
            $sprite = $this->spriteConfig[$merge]['attr']['filename'];
            $newUrl = $this->map['media'][$sprite];
            $ret = $this->spriteConfig[$merge]['config'][$urlString];

            trigger('css_background_change', $this, $sprite);
        } else {
            if (($mask & 1) === 1) {
                $newUrl = $this->map['media'][$urlString];
            }

            trigger('css_background_change', $this, $urlString);

            // 5中异常情况
            switch ($mask) {
                case 0:
                    mark('文件“'.$this->path.'”中引用了“'.$urlString.'”，但该图片不存在！', 'warn');
                    return null;
                case 1:
                    // 正常情况
                    break;
                case 2:
                    mark('文件“'.$this->path.'”中存在未知合图类型“'.$merge.'”，并且图片“'.$urlString.'”也不存在', 'warn');
                    return null;
                case 3:
                    mark('文件“'.$this->path.'”中存在未知合图类型“'.$merge.'”，将用小图地址代替', 'warn');
                    break;
                case 4:
                    mark('文件“'.$this->path.'”中引用了合图“'.$merge.'”，但该合图类型中不存在“'.$urlString.'”的配置信息，并且该图片也不存在', 'warn');
                    return null;
                case 5:
                    mark('文件“'.$this->path.'”中引用了合图“'.$merge.'”，但该合图类型中不存在“'.$urlString.'”的配置信息，将用小图地址代替', 'warn');
                    break;
                default:
                    mark('文件“'.$this->path.'”中引用了“'.$urlString.'”，位置错误码：'.$mask, 'error');
                    return null;
            }
        }

        $newUrl = new String($newUrl);
        call_user_func(array($url, $setMethod), $newUrl);

        return $ret;
    }

    /**
     * 替换background-position
     * @param DeclarationBlock $block
     * @param $bgValues
     * @param $config Array 位置数组
     */
    private function rewriteBackgroundPosition(DeclarationBlock $block, &$bgValues, $config) {
        $positionRule = isset($bgValues['background-position']) ?
            $bgValues['background-position'] :
            (isset($bgValues['background']) ?
                $bgValues['background'] :
                null
            );

        if ($positionRule) {
            $values = $positionRule->getValue();

            if ($values instanceof RuleValueList) {
                $values = $values->getListComponents();
            } else {
                $values = array($values);
            }

            if (!$this->setPosition($values, $config)) {
                // 到setPosition返回false时，表示没有找到可以设置position的属性，需要添加
                $newRule = new Rule('background-position');
                $newRule->addValue(array(
                    new Size(-$config['left'], 'px'),
                    new Size(-$config['top'], 'px')
                ));
                $block->addRule($newRule);
            }
        }
    }

    /**
     * 替换background-size
     * @param $bgValues
     * @param $config {Array} 合图配置
     * @param $attr {Array} sprite图片大小信息
     * @param $position {Array} 位置信息，需要根据background-size改写position
     */
    private function rewriteBackgroundSize(&$bgValues, $config, $attr, &$position) {
        // 宽高缩放比例
        $ratio = array('width' => 1, 'height' => 1);

        foreach($bgValues as $key => $bgValue) {
            if (strpos($key, 'background-size') !== false) {
                $bgSize = $bgValue->getValues();
                $order = 'width';
                $setTimes = 0;

                foreach ($bgSize as $size) {
                    $size = $size[0];
                    if ($size instanceof Size && $size->isSize()) {
                        $oSize = $size->getSize();
                        $ratio[$order] = $oSize / $config[$order];
                        $nSize = round($ratio[$order] * $attr[$order]);
                        $size->setSize($nSize);

                        $setTimes++;
                    }
                    $order = 'height';
                }

                // 针对background-size: auto 1px / 1px auto的情况
                if ($setTimes < 2) {
                    if ($ratio['width'] !== 1) {
                        $ratio['height'] = $ratio['width'];
                    } else if ($ratio['height'] !== 1) {
                        $ratio['width'] = $ratio['height'];
                    }
                }
            }
        }

        // 改变position
        $position = array(
            'left' => round($position['left'] * $ratio['width']),
            'top' => round($position['top'] * $ratio['height'])
        );
    }

    /**
     * 设置background-size
     * @param $value
     * @param $config
     * @return bool 是否找到可以改写的background-size项
     */
    private function setPosition(&$value, $config) {
        // 此时处理的position的位置
        $order = 'left';
        $setTimes = 0;
        foreach ($value as $pValue) {
            if ($pValue instanceof Size && $pValue->isSize()) {
                // 不存在单位时，此时为“0”，加上px
                if (!$pValue->getUnit()) {
                    $pValue->setUnit('px');
                }
                $oSize = $pValue->getSize();
                $pValue->setSize($oSize - $config[$order]);
                $order = 'top';
                $setTimes++;
            } elseif (is_string($pValue) && in_array($pValue, array('left', 'center', 'right', 'top', 'bottom'))) {
                $order = 'top';
                $setTimes++;
            }
            // 处理两次了，则退出
            if ($setTimes === 2) {
                break;
            }
        }

        // 如果$setTimes > 0,则找到了可以设置的position项
        // 存在background属性没有设置position的情况
        return $setTimes > 0;
    }

    /**
     * 写入缓存
     * @param $path
     * @param $contents
     */
    private static function updateCache($path, $contents) {
        $file = self::$cacheDir.'/'.file_uid($path);
        contents_to_file($file, $contents);
        self::$cacheMap[$path] = $file;
    }
}