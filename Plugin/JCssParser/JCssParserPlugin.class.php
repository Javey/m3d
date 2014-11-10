<?php
/**
 * 该插件已合并至Core，故废弃，不过可以当成一个预处理器替换的Demo
 * Deprecated
 * User: zoujiawei
 * Date: 14-7-7
 * Time: 下午8:59
 */

require_once(LIB_PATH.'/Third/JCssParser/JCssParser.php');

//on('processor_init', 'JCssParser');

class JCssParserPlugin extends Plugin {
    protected $options = array(
        'jcss.is_jcss' => true
    );

    public function run($params) {
        if (!C('JCSS.IS_JCSS')) {
            off('processor_init', 'JCssParser');
            return;
        }
        $tool = $params[1]; // 第1个参数是PreprocessTool对象
        $options = $params[2]; // 第2个参数是配置信息
        $processor = $params[3]; // 第3个参数是返回，将最后的预处理器对象赋给$processor->return

        // 判断当前是否在初始化CssPreprocess
        if ($options['processor'] === 'css') {
            $processor->return = new JCssPreprocess($tool->getMap(), $options);
            Preprocess::setInstance('CssPreprocess', $processor->return);
        }
    }
}

class JCssPreprocess extends CssPreprocess {
    /**
     * css解析入口
     * @param $contents {String} css文本内容
     * @return string {String} 处理后的文件
     */
    protected function cssParse($contents) {
        // 处理逻辑
        $doc = JCssParser::parse($contents);

        $ret = new stdClass();
        $ret->return = null;
        trigger('css_parse_start', $this, $doc, $ret);
        if ($ret->return) {
            $doc = $ret->return;
        }

        $importContents = $this->handleImport($doc['stylesheet']['rules']);

        if ($this->isReplaceUri) {
            $this->handleBackground($doc['stylesheet']['rules']);
        }

        return $importContents.JCssParser::stringify($doc);
    }

    private function handleImport(&$rules) {
        $contents = '';

        foreach ($rules as $index => &$rule) {
            if ($rule['type'] === 'import') {
                $path = trim($rule['import'], '"');
                $path = Tool::getActualPath($path);

                $processor = new JCssPreprocess($this->map);
                $processor->setFile(C('SRC.SRC_PATH').$path);
                $processor->process();

                $contents .= $processor->getContents();

                unset($rules[$index]);

                trigger('css_import', $this, $processor);
            }
        }

        return $contents;
    }

    private function handleBackground(&$rules) {
        foreach ($rules as &$rule) {
            if ($rule['type'] === 'rule') {
                $bgDecls = array();
                $merge = null;
                foreach ($rule['declarations'] as $index => &$declaration) {
                    if (strpos($declaration['property'], 'background') !== false) {
//                        array_push($bgDecls, &$declaration);
                        $bgDecls[] = &$declaration;
                    } elseif ($declaration['property'] === 'merge') {
                        $merge = $declaration['value'];
                        unset($rule['declarations'][$index]);
                    }
                }

                $this->rewriteBackground($rule, $bgDecls, $merge);
                $this->rewriteFilter($rule);
            }
        }
    }

    private function rewriteBackground(&$rule, &$bgDecls, $merge) {
        foreach ($bgDecls as &$bgDecl) {
            if ($bgDecl['property'] === 'background' || $bgDecl['property'] === 'background-image') {
                if (preg_match('/(.*url\()([\'\"]?)([^\'\"\)]+)([\'\"]?)(\).*)/', $bgDecl['value'], $matches)) {
                    $url = $matches[3];
                    $urlData = $this->getBackgroundUrlData($url, $merge);
                    $bgDecl['value'] = $matches[1].'"'.$urlData['url'].'"'.$matches[5];
                }
            }
        }

        if ($merge && isset($urlData) && $urlData['config']) {
            $position = array('left' => $urlData['config']['left'], 'top' => $urlData['config']['top']);
            $this->rewriteBackgroundSize($bgDecls, $urlData['config'], $this->spriteConfig[$merge]['attr'], $position);
            $this->rewriteBackgroundPosition($rule, $bgDecls, $position);
        }
    }

    private function rewriteFilter(&$rule) {
        foreach ($rule['declarations'] as &$declaration) {
            if (strpos($declaration['property'], 'filter') !== false) {
                if (preg_match('/(.*?src=)([\'\"]?)([^\'\"\)]+)([\'\"]?)(.*)/', $declaration['value'], $matches)) {
                    $url = $matches[3];
                    $urlData = $this->getBackgroundUrlData($url);
                    $declaration['value'] = $matches[1].'"'.$urlData['url'].'"'.$matches[5];
                    break;
                }
            }
        }
    }

    private function getBackgroundUrlData($url, $merge = null) {
        $ret = array(
            'url' => $url,
            'config' => null
        );

        $newUrl = $url;

        if (!$url || strpos($url, 'data:') !== false || strpos($url, 'about:') !== false || strpos($url, '://') !== false) {
            return $ret;
        }

        $url = Tool::getActualPath($url);

        $mask = 0;
        $mask += !is_null($merge);
        $mask += ($mask > 0 && isset($this->spriteConfig[$merge]));
        $mask += ($mask > 1 && isset($this->spriteConfig[$merge]['config'][$url]));

        $mask <<= 1;
        $mask += isset($this->map['media'][$url]);

        if (($mask & 6) === 6) {
            $sprite = $this->spriteConfig[$merge]['attr']['filename'];
            if (isset($this->map['media'][$sprite])) {
                $newUrl = $this->map['media'][$sprite];
            } else {
                mark('找不到合图文件'.$sprite.'的去向，请确定该合图已编译', 'error');
                return $ret;
            }
            $ret['config'] = $this->spriteConfig[$merge]['config'][$url];

            trigger('css_background_change', $this, $sprite);
        } else {
            if (($mask & 1) === 1) {
                $newUrl = $this->map['media'][$url];
            }

            trigger('css_background_change', $this, $url);
            // 依然将合图加入依赖关系表中，万一某天心血来潮又合图了，依然可以进行增量编译
            if ($mask > 1) {
                trigger('css_background_change', $this, $merge.C('SPRITE_SUFFIX').'.png');
            }

            // 5中异常情况
            switch ($mask) {
                case 0:
                    mark('文件“'.$this->path.'”中引用了“'.$url.'”，但该图片不存在！', 'warn');
                    return $ret;
                case 1:
                    // 正常情况
                    break;
                case 2:
                    mark('文件“'.$this->path.'”中存在未知合图类型“'.$merge.'”，并且图片“'.$url.'”也不存在', 'warn');
                    return $ret;
                case 3:
                    mark('文件“'.$this->path.'”中存在未知合图类型“'.$merge.'”，将用小图地址代替', 'warn');
                    break;
                case 4:
                    mark('文件“'.$this->path.'”中引用了合图“'.$merge.'”，但该合图类型中不存在“'.$url.'”的配置信息，并且该图片也不存在', 'warn');
                    return $ret;
                case 5:
                    mark('文件“'.$this->path.'”中引用了合图“'.$merge.'”，但该合图类型中不存在“'.$url.'”的配置信息，将用小图地址代替', 'warn');
                    break;
                default:
                    mark('文件“'.$this->path.'”中引用了“'.$url.'”，未知错误码：'.$mask, 'error');
                    return $ret;
            }
        }

        $ret['url'] = Tool::addCdn($newUrl);

        return $ret;
    }

    private function rewriteBackgroundSize(&$bgDecls, $config, $attr, &$position) {
        $ratio = array('width' => 1, 'height' => 1);

        foreach ($bgDecls as &$bgDecl) {
            if (strpos($bgDecl['property'], 'background-size') !== false) {
                $bgSize = preg_split('/\s+/', $bgDecl['value']);
                $order = 'width';
                $setTimes = 0;

                foreach ($bgSize as $index => $size) {
                    if (($matches = $this->matchSize($size)) && !empty($matches)) {
                        $size = $matches[1];
                        $ratio[$order] = $size / $config['ori_'.$order];
                        $size = floor($ratio[$order] * $attr[$order]);
                        $bgSize[$index] = (string)$size.'px';

                        $setTimes++;
                    }
                    $order = 'height';
                }

                $bgDecl['value'] = implode(' ', $bgSize);

                if ($setTimes < 2) {
                    if ($ratio['width'] !== 1) {
                        $ratio['height'] = $ratio['width'];
                    } elseif ($ratio['height'] !== 1) {
                        $ratio['width'] = $ratio['height'];
                    }
                }
            }
        }

        $position = array(
            'left' => round($position['left'] * $ratio['width']),
            'top' => round($position['top'] * $ratio['height'])
        );
    }

    private function rewriteBackgroundPosition(&$rule, &$bgDecls, $config) {
        foreach ($bgDecls as &$bgDecl) {
            if ($bgDecl['property'] === 'background-position') {
                $posDecl = &$bgDecl;
                break;
            } else if ($bgDecl['property'] === 'background') {
                $posDecl = &$bgDecl;
            }
        }

        if (isset($posDecl)) {
            $posValues = preg_split('/\s+/', $posDecl['value']);
            if ($this->setPosition($posValues, $config)) {
                $posDecl['value'] = implode(' ', $posValues);
            } else {
                $this->addPositionDecl($rule['declarations'], $config);
            }
        } else {
            $this->addPositionDecl($rule['declarations'], $config);
        }
    }

    private function setPosition(&$values, $config) {
        $order = 'left';
        $setTimes = 0;
        foreach ($values as &$value) {
            if (($matches = $this->matchSize($value)) && !empty($matches)) {
                $value = (string)($matches[1] - $config[$order]).'px';
                $order = 'top';
                $setTimes++;
            } elseif (is_string($value) && in_array($value, array('left', 'center', 'right', 'top', 'bottom'))) {
                $order = 'top';
                $setTimes++;
            }
            if ($setTimes === 2) {
                break;
            }
        }

        return $setTimes > 0;
    }

    private function addPositionDecl(&$decls, $config) {
        $decl = array(
            'type' => 'declaration',
            'property' => 'background-position',
            'value' => (string)(-$config['left']).'px '.(string)(-$config['top']).'px',
        );
        array_push($decls, $decl);
    }

    private function matchSize($value) {
        preg_match('/^([\d\.\-]+)(px)?/', $value, $matches);
        return $matches;
    }
}