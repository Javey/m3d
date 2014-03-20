<?php /* Smarty version Smarty-3.1.13, created on 2013-11-19 19:40:54
         compiled from "/home/music/javey/m3d/Ui/Templates/Merge/index.html.tpl" */ ?>
<?php /*%%SmartyHeaderCode:17602233305289d1591eb772-57289675%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '79714b6032c9e9958b36741f5e3f71725facc9ff' => 
    array (
      0 => '/home/music/javey/m3d/Ui/Templates/Merge/index.html.tpl',
      1 => 1384861252,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '17602233305289d1591eb772-57289675',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_5289d15927f404_79116975',
  'variables' => 
  array (
    'tplData' => 0,
    'type' => 0,
    'uri' => 0,
    'i' => 0,
    'direct' => 0,
    'config' => 0,
    'key' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5289d15927f404_79116975')) {function content_5289d15927f404_79116975($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Images Merge Preprocess</title>
    <link type="text/css" rel="stylesheet" href="/static/css/merge.css"/>
</head>
<body>
<header>
    <h1>Images Merge Prprocess</h1>
    <nav>
        <?php  $_smarty_tpl->tpl_vars['type'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['type']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['types']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['type']->key => $_smarty_tpl->tpl_vars['type']->value){
$_smarty_tpl->tpl_vars['type']->_loop = true;
?>
            <a href="/merge?type=<?php echo $_smarty_tpl->tpl_vars['type']->value;?>
" title="<?php echo $_smarty_tpl->tpl_vars['type']->value;?>
" <?php if ($_smarty_tpl->tpl_vars['tplData']->value['curType']===$_smarty_tpl->tpl_vars['type']->value){?>class="actived"<?php }?>><?php echo $_smarty_tpl->tpl_vars['type']->value;?>
</a>
        <?php } ?>
    </nav>
</header>
<aside>
    <a href="/merge/sprite/type/<?php echo $_smarty_tpl->tpl_vars['tplData']->value['curType'];?>
" title="点击浏览大图">
        <img src="/merge/sprite/type/<?php echo $_smarty_tpl->tpl_vars['tplData']->value['curType'];?>
"/>
    </a>
</aside>
<article>
    <table id="control-panel">
        <thead>
        <tr>
            <th >Source</th><th >Padding</th><th>Float</th><th>Repeat</th><th>Border</th><th >Limit</th>
        </tr>
        <tr>
            <td>(uri)</td><td>(px)</td><td>direct</td><td>x|0|y</td><td>(px)</td><td>w|h(px)</td>
        </tr>
        </thead>
        <tbody id="tbody">
        <?php $_smarty_tpl->tpl_vars['direct'] = new Smarty_variable(array('top','left','right','bottom','none'), null, 0);?>
        <?php  $_smarty_tpl->tpl_vars['config'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['config']->_loop = false;
 $_smarty_tpl->tpl_vars['uri'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['config']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['config']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['config']->key => $_smarty_tpl->tpl_vars['config']->value){
$_smarty_tpl->tpl_vars['config']->_loop = true;
 $_smarty_tpl->tpl_vars['uri']->value = $_smarty_tpl->tpl_vars['config']->key;
 $_smarty_tpl->tpl_vars['config']->index++;
?>
        <tr>
            <td class="td-img">
                <img src="/merge/image?uri=<?php echo $_smarty_tpl->tpl_vars['uri']->value;?>
"/>
                <div><?php echo $_smarty_tpl->tpl_vars['uri']->value;?>
</div>
            </td>
            <td class="td-padding">
                <?php $_smarty_tpl->tpl_vars['i'] = new Smarty_Variable;$_smarty_tpl->tpl_vars['i']->step = 1;$_smarty_tpl->tpl_vars['i']->total = (int)ceil(($_smarty_tpl->tpl_vars['i']->step > 0 ? 8+1 - (0) : 0-(8)+1)/abs($_smarty_tpl->tpl_vars['i']->step));
if ($_smarty_tpl->tpl_vars['i']->total > 0){
for ($_smarty_tpl->tpl_vars['i']->value = 0, $_smarty_tpl->tpl_vars['i']->iteration = 1;$_smarty_tpl->tpl_vars['i']->iteration <= $_smarty_tpl->tpl_vars['i']->total;$_smarty_tpl->tpl_vars['i']->value += $_smarty_tpl->tpl_vars['i']->step, $_smarty_tpl->tpl_vars['i']->iteration++){
$_smarty_tpl->tpl_vars['i']->first = $_smarty_tpl->tpl_vars['i']->iteration == 1;$_smarty_tpl->tpl_vars['i']->last = $_smarty_tpl->tpl_vars['i']->iteration == $_smarty_tpl->tpl_vars['i']->total;?>
                    <?php if ($_smarty_tpl->tpl_vars['i']->value%2){?>
                        <input type="text" name="padding-<?php echo $_smarty_tpl->tpl_vars['direct']->value[floor($_smarty_tpl->tpl_vars['i']->value/2)];?>
" value="<?php echo $_smarty_tpl->tpl_vars['config']->value[('padding-').($_smarty_tpl->tpl_vars['direct']->value[floor($_smarty_tpl->tpl_vars['i']->value/2)])];?>
"/>
                    <?php }else{ ?>
                        <div class="empty"></div>
                    <?php }?>
                <?php }} ?>
            </td>
            <td class="td-float">
                <?php $_smarty_tpl->tpl_vars['i'] = new Smarty_Variable;$_smarty_tpl->tpl_vars['i']->step = 1;$_smarty_tpl->tpl_vars['i']->total = (int)ceil(($_smarty_tpl->tpl_vars['i']->step > 0 ? 8+1 - (0) : 0-(8)+1)/abs($_smarty_tpl->tpl_vars['i']->step));
if ($_smarty_tpl->tpl_vars['i']->total > 0){
for ($_smarty_tpl->tpl_vars['i']->value = 0, $_smarty_tpl->tpl_vars['i']->iteration = 1;$_smarty_tpl->tpl_vars['i']->iteration <= $_smarty_tpl->tpl_vars['i']->total;$_smarty_tpl->tpl_vars['i']->value += $_smarty_tpl->tpl_vars['i']->step, $_smarty_tpl->tpl_vars['i']->iteration++){
$_smarty_tpl->tpl_vars['i']->first = $_smarty_tpl->tpl_vars['i']->iteration == 1;$_smarty_tpl->tpl_vars['i']->last = $_smarty_tpl->tpl_vars['i']->iteration == $_smarty_tpl->tpl_vars['i']->total;?>
                    <?php if ($_smarty_tpl->tpl_vars['i']->value%2){?>
                        <input type="radio" name="float<?php echo $_smarty_tpl->tpl_vars['config']->index;?>
" value="<?php echo $_smarty_tpl->tpl_vars['direct']->value[floor($_smarty_tpl->tpl_vars['i']->value/2)];?>
" <?php if ($_smarty_tpl->tpl_vars['direct']->value[floor($_smarty_tpl->tpl_vars['i']->value/2)]===$_smarty_tpl->tpl_vars['config']->value['float']){?>checked="checked"<?php }?>/>
                    <?php }elseif($_smarty_tpl->tpl_vars['i']->value===4){?>
                        <input type="radio" name="float<?php echo $_smarty_tpl->tpl_vars['config']->index;?>
" value="<?php echo $_smarty_tpl->tpl_vars['direct']->value[$_smarty_tpl->tpl_vars['i']->value];?>
" <?php if ($_smarty_tpl->tpl_vars['direct']->value[$_smarty_tpl->tpl_vars['i']->value]===$_smarty_tpl->tpl_vars['config']->value['float']){?>checked="checked"<?php }?>/>
                    <?php }else{ ?>
                        <div class="empty"></div>
                    <?php }?>
                <?php }} ?>
            </td>
            <td class="td-repeat">
                <?php  $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['key']->_loop = false;
 $_from = array('x','none','y'); if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['key']->key => $_smarty_tpl->tpl_vars['key']->value){
$_smarty_tpl->tpl_vars['key']->_loop = true;
?>
                    <input type="radio" name="repeat<?php echo $_smarty_tpl->tpl_vars['config']->index;?>
" value="<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
" <?php if ($_smarty_tpl->tpl_vars['config']->value['repeat']===$_smarty_tpl->tpl_vars['key']->value){?>checked="checked"<?php }?> />
                <?php } ?>
            </td>
            <td class="td-border">
                <?php $_smarty_tpl->tpl_vars['i'] = new Smarty_Variable;$_smarty_tpl->tpl_vars['i']->step = 1;$_smarty_tpl->tpl_vars['i']->total = (int)ceil(($_smarty_tpl->tpl_vars['i']->step > 0 ? 8+1 - (0) : 0-(8)+1)/abs($_smarty_tpl->tpl_vars['i']->step));
if ($_smarty_tpl->tpl_vars['i']->total > 0){
for ($_smarty_tpl->tpl_vars['i']->value = 0, $_smarty_tpl->tpl_vars['i']->iteration = 1;$_smarty_tpl->tpl_vars['i']->iteration <= $_smarty_tpl->tpl_vars['i']->total;$_smarty_tpl->tpl_vars['i']->value += $_smarty_tpl->tpl_vars['i']->step, $_smarty_tpl->tpl_vars['i']->iteration++){
$_smarty_tpl->tpl_vars['i']->first = $_smarty_tpl->tpl_vars['i']->iteration == 1;$_smarty_tpl->tpl_vars['i']->last = $_smarty_tpl->tpl_vars['i']->iteration == $_smarty_tpl->tpl_vars['i']->total;?>
                    <?php if ($_smarty_tpl->tpl_vars['i']->value%2){?>
                        <input type="text" name="border-<?php echo $_smarty_tpl->tpl_vars['direct']->value[floor($_smarty_tpl->tpl_vars['i']->value/2)];?>
" value="<?php echo $_smarty_tpl->tpl_vars['config']->value[('border-').($_smarty_tpl->tpl_vars['direct']->value[floor($_smarty_tpl->tpl_vars['i']->value/2)])];?>
"/>
                    <?php }else{ ?>
                        <div class="empty"></div>
                    <?php }?>
                <?php }} ?>
            </td>
            <td class="td-limit">
                <?php  $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['key']->_loop = false;
 $_from = array('width','height'); if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['key']->key => $_smarty_tpl->tpl_vars['key']->value){
$_smarty_tpl->tpl_vars['key']->_loop = true;
?>
                    <input type="text" name="min-<?php echo $_smarty_tpl->tpl_vars['key']->value;?>
" value="<?php echo $_smarty_tpl->tpl_vars['config']->value[('min-').($_smarty_tpl->tpl_vars['key']->value)];?>
"/>
                <?php } ?>
            </td>
        </tr>
        <?php } ?>
        </tbody>
    </table>
</article>
<script type="text/javascript" src="/static/js/jquery.js"></script>
</body>
</html><?php }} ?>