<?php /* Smarty version Smarty-3.1.13, created on 2013-04-11 20:05:03
         compiled from "/home/music/javey/m3d/Ui/Templates/Test/index.html.tpl" */ ?>
<?php /*%%SmartyHeaderCode:13428266425166a6efab0ac9-76178229%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '5f844e7ad69c928d375405105fa03aa1841f8c16' => 
    array (
      0 => '/home/music/javey/m3d/Ui/Templates/Test/index.html.tpl',
      1 => 1365474632,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '13428266425166a6efab0ac9-76178229',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'tplData' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_5166a6efb1f257_01490536',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5166a6efb1f257_01490536')) {function content_5166a6efb1f257_01490536($_smarty_tpl) {?><?php echo time();?>

<?php echo var_dump($_smarty_tpl->tpl_vars['tplData']->value);?>

<?php echo $_smarty_tpl->tpl_vars['tplData']->value['test'];?>
<?php }} ?>