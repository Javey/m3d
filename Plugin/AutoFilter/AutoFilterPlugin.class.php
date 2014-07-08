<?php

//on('css_handle_background_start', 'AutoFilter');

class AutoFilterPlugin extends Plugin {
    public function run($params) {
        $cssDoc = $params[1];
        foreach ($cssDoc->getAllDeclarationBlocks() as $block) {
            $filter = !!($rule = $block->getRules('autofilter'));
            if ($filter) {
                $url = $this->getBackgroundImage($block);
            }
        }
    }

    private function getBackgroundImage(DeclarationBlock $block) {
        $values = array();
        $bgValues = $block->getRulesAssoc('-background-');

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
            foreach ($values as $value) {
                if ($value instanceof URL) {
                    return $value->getURL()->__toString();
                }
            }
        }
        return null;
    }
}