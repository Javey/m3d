<?php /* Smarty version Smarty-3.1.13, created on 2013-12-09 14:35:52
         compiled from "/home/music/javey/m3d/Ui/Templates/Testindex/index.html.tpl" */ ?>
<?php /*%%SmartyHeaderCode:181733573652a0363e853a33-65398864%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '0b4f90270a4261db9a804f8e19dfd867a11c8362' => 
    array (
      0 => '/home/music/javey/m3d/Ui/Templates/Testindex/index.html.tpl',
      1 => 1386559214,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '181733573652a0363e853a33-65398864',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_52a0363ea54a93_59601331',
  'variables' => 
  array (
    'tplData' => 0,
    'name' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_52a0363ea54a93_59601331')) {function content_52a0363ea54a93_59601331($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>M3D开发联调平台</title>
    <link rel="stylesheet" href="/static/css/base1.css">
    <script type="text/javascript" src="/static/js/lib/jquery.js"></script>
    <script type="text/javascript" src="/static/js/lib/angular.js"></script>
    
</head>
<body>
<nav class="fun-panel">
    <div class="item glyphicon glyphicon-cog" title="test"></div>
    <div class="item glyphicon glyphicon-star"></div>
    <div class="item glyphicon glyphicon-cloud-download"></div>
    <div class="item"></div>
</nav>
<aside class="sidebar">
    <div class="search-wrap">
        <input type="text"/>
        <span class="btn btn-a">提交</span>
    </div>
    <nav class="sites">
        <?php  $_smarty_tpl->tpl_vars['list'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['list']->_loop = false;
 $_smarty_tpl->tpl_vars['name'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['all_sites']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['list']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['list']->key => $_smarty_tpl->tpl_vars['list']->value){
$_smarty_tpl->tpl_vars['list']->_loop = true;
 $_smarty_tpl->tpl_vars['name']->value = $_smarty_tpl->tpl_vars['list']->key;
 $_smarty_tpl->tpl_vars['list']->index++;
 $_smarty_tpl->tpl_vars['list']->first = $_smarty_tpl->tpl_vars['list']->index === 0;
?>
            <div class="item <?php if ($_smarty_tpl->tpl_vars['list']->first){?>selected<?php }?>"><?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
</div>
        <?php } ?>
    </nav>
</aside>
<article class="site-container">
    <div class="head">
        <h1 class="name">youhua</h1>
        <div class="info">Javey - 2013/12/06</div>
    </div>
    <div class="body">
        <ul class="modules">
            <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['all_modules']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
                
                    
                    
                
                <li class="item">
                    <span class="title"><?php echo $_smarty_tpl->tpl_vars['value']->value['title'];?>
</span>
                    <span class="branch">trunk</span>
                    <span class="ctrl">
                        <span class="btn compile">编译</span>
                        <span class="btn merge">合图</span>
                        <span class="btn test">提测</span>
                    </span>
                </li>
            <?php } ?>
        </ul>
    </div>
</article>
</body>
</html>
<?php }} ?>