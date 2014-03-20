<?php
/**
 * Created by JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-5
 * Time: 下午4:08
 * To change this template use File | Settings | File Templates.
 */

return array(
    // 系统变量名称设置
    'VAR_MODULE' => 'm',
    'VAR_ACTION' => 'a',
    'VAR_URL_PARAMS' => '_URL_',

    // 默认设定
    'DEFAULT_C_SUFFIX' => 'Action',
    'DEFAULT_M_SUFFIX' => 'Model',
    'DEFAULT_MODULE' => 'Index',
    'DEFAULT_ACTION' => 'Index',
    'DEFAULT_TIMEZONE' => 'PRC',

    // 模板
    'TMPL_CACHE' => false,
    'TMPL_SUFFIX' => '.html.tpl',
    'TMPL_DEBUG' => true, // 模板调试

    // 静态页面
    'HTML_SUFFIX' => '.html',

    // Database
    'DATA_PATH' => M3D_PATH.'/Data',
);