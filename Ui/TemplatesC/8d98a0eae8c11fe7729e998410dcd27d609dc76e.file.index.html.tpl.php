<?php /* Smarty version Smarty-3.1.13, created on 2014-03-14 14:33:28
         compiled from "/home/music/javey/m3d/Ui/Templates/Imerge/index.html.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1566823080531ead611a72b1-97132042%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '8d98a0eae8c11fe7729e998410dcd27d609dc76e' => 
    array (
      0 => '/home/music/javey/m3d/Ui/Templates/Imerge/index.html.tpl',
      1 => 1394778806,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1566823080531ead611a72b1-97132042',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_531ead615694e9_19983240',
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
<?php if ($_valid && !is_callable('content_531ead615694e9_19983240')) {function content_531ead615694e9_19983240($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Images Merge Preprocess</title>
    <link type="text/css" rel="stylesheet" href="/static/css/imerge.css"/>
</head>
<body>
<header>
    <h1>Images Merge Preprocess</h1>
    <nav>
        <?php  $_smarty_tpl->tpl_vars['type'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['type']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['types']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['type']->key => $_smarty_tpl->tpl_vars['type']->value){
$_smarty_tpl->tpl_vars['type']->_loop = true;
?>
            <a href="/imerge?site=<?php echo $_smarty_tpl->tpl_vars['tplData']->value['params']['site'];?>
&module=<?php echo $_smarty_tpl->tpl_vars['tplData']->value['params']['module'];?>
&type=<?php echo $_smarty_tpl->tpl_vars['type']->value;?>
" title="<?php echo $_smarty_tpl->tpl_vars['type']->value;?>
" <?php if ($_smarty_tpl->tpl_vars['tplData']->value['curType']===$_smarty_tpl->tpl_vars['type']->value){?>class="actived"<?php }?>><?php echo $_smarty_tpl->tpl_vars['type']->value;?>
</a>
        <?php } ?>
    </nav>
</header>
<aside>
    <a href="/imerge/sprite/type/<?php echo $_smarty_tpl->tpl_vars['tplData']->value['curType'];?>
" title="点击浏览大图">
        <img src="/imerge/sprite/type/<?php echo $_smarty_tpl->tpl_vars['tplData']->value['curType'];?>
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
        <tr>
            <td class="td-input" colspan="6">
                <input type="text" id="new_image" placeholder="输入小图文件名" />
                <input type="button" id="confirm" value="确认">
                
            </td>
        </tr>
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
                <a href="/imerge/image?uri=<?php echo $_smarty_tpl->tpl_vars['uri']->value;?>
" target="_blank">
                    <img src="/imerge/image?uri=<?php echo $_smarty_tpl->tpl_vars['uri']->value;?>
"/>
                </a>
                <div><?php echo basename($_smarty_tpl->tpl_vars['uri']->value);?>
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
<script type="text/javascript" src="/static/js/lib/jquery.js"></script>
<script type="text/javascript" src="/static/js/ui/imerge.js"></script>
</body>
</html><?php }} ?>