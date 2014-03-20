<?php /* Smarty version Smarty-3.1.13, created on 2013-11-19 20:39:33
         compiled from "/home/music/javey/m3d/Ui/Templates/Index/index.html.tpl" */ ?>
<?php /*%%SmartyHeaderCode:3153423805166a5b029c439-30702720%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '84689c0b925dae893f3aabe446757b2e2989ed7d' => 
    array (
      0 => '/home/music/javey/m3d/Ui/Templates/Index/index.html.tpl',
      1 => 1384864772,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '3153423805166a5b029c439-30702720',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_5166a5b068b259_30971563',
  'variables' => 
  array (
    'CONFIG_BRANCH' => 0,
    'tplData' => 0,
    'name' => 0,
    'value' => 0,
    'key' => 0,
    'list' => 0,
    'module_name' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5166a5b068b259_30971563')) {function content_5166a5b068b259_30971563($_smarty_tpl) {?><?php if (!is_callable('smarty_function_html_options')) include '/home/music/javey/m3d/Lib/Smarty/plugins/function.html_options.php';
?><?php $_smarty_tpl->tpl_vars['CONFIG_BRANCH'] = new Smarty_variable("M3D音乐", null, 0);?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title><?php echo strtoupper($_smarty_tpl->tpl_vars['CONFIG_BRANCH']->value);?>
开发联调平台</title>
    <link rel="stylesheet" href="/static/css/base.css?v=20121221">
    <script type="text/javascript" src="/static/js/lib/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="/static/js/base.js?v=20121221"></script>
</head>
<body class="flex-box-v">
<header class="flex-box-h">
    <div>
        <span><?php echo strtoupper($_smarty_tpl->tpl_vars['CONFIG_BRANCH']->value);?>
开发联调平台</span>
    </div>
    <div>
        <span id="branch_title"></span>
        <div class="r-buttons">
            <a id="add" class="button">新增分支</a>
            <a id="restart" class="button">重启服务器</a>
            <a class="button add-module">新模块添加</a>
        </div>
        <div class="l-buttons">
        
					

        </div>
    </div>
</header>
<div class="content">
    <aside>
        <nav>
        <?php  $_smarty_tpl->tpl_vars['list'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['list']->_loop = false;
 $_smarty_tpl->tpl_vars['name'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['current_branches']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['list']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['list']->key => $_smarty_tpl->tpl_vars['list']->value){
$_smarty_tpl->tpl_vars['list']->_loop = true;
 $_smarty_tpl->tpl_vars['name']->value = $_smarty_tpl->tpl_vars['list']->key;
 $_smarty_tpl->tpl_vars['list']->index++;
 $_smarty_tpl->tpl_vars['list']->first = $_smarty_tpl->tpl_vars['list']->index === 0;
?>
            <div class="nav-item <?php if ($_smarty_tpl->tpl_vars['list']->first){?>selected<?php }?>"><?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
</div>
        <?php } ?>
        </nav>
    </aside>
    <article>
    <?php  $_smarty_tpl->tpl_vars['list'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['list']->_loop = false;
 $_smarty_tpl->tpl_vars['name'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['current_branches']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['list']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['list']->key => $_smarty_tpl->tpl_vars['list']->value){
$_smarty_tpl->tpl_vars['list']->_loop = true;
 $_smarty_tpl->tpl_vars['name']->value = $_smarty_tpl->tpl_vars['list']->key;
 $_smarty_tpl->tpl_vars['list']->index++;
 $_smarty_tpl->tpl_vars['list']->first = $_smarty_tpl->tpl_vars['list']->index === 0;
?>
        <section <?php if ($_smarty_tpl->tpl_vars['list']->first){?>class="current-content"<?php }?>>
            <div class="selects widget">
                <h3>分支代码</h3>
                <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['all_branches']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['value']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
 $_smarty_tpl->tpl_vars['value']->index++;
?>
                    <div class="select">
                        <a class="hyperlink" href="/<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
/src/rd-main" target="_blank"><?php echo $_smarty_tpl->tpl_vars['value']->value['title'];?>
:</a>
                        <?php echo smarty_function_html_options(array('name'=>$_smarty_tpl->tpl_vars['key']->value,'options'=>$_smarty_tpl->tpl_vars['value']->value['branch'],'selected'=>$_smarty_tpl->tpl_vars['list']->value[$_smarty_tpl->tpl_vars['key']->value]),$_smarty_tpl);?>

                    </div>
                <?php } ?>
            </div>
            <div class="op widget">
                <h3>操作</h3>
                <div class="op-item op-item-first">
                    <a class="button button-white save ">保存</a>
                    <a class="button button-white delete">删除</a>
                    <a class="button button-white clear">清缓存</a>
                
                
                </div>
                <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['module']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['value']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
 $_smarty_tpl->tpl_vars['value']->index++;
?>
                    <?php if ($_smarty_tpl->tpl_vars['value']->value['title']=="rd"){?>
                        <?php continue 1?>
                    <?php }?>
                    <?php if ($_smarty_tpl->tpl_vars['value']->value['module_name']){?>
                        <?php $_smarty_tpl->tpl_vars['module_name'] = new Smarty_variable($_smarty_tpl->tpl_vars['value']->value['module_name'], null, 0);?>
                        <?php }else{ ?>
                        <?php $_smarty_tpl->tpl_vars['module_name'] = new Smarty_variable($_smarty_tpl->tpl_vars['key']->value, null, 0);?>
                    <?php }?>
                    <div class="op-item">
                        <div class="op-header"><?php echo $_smarty_tpl->tpl_vars['value']->value['title'];?>
</div>
                        
                            
                                
                                <a class="op-button" target="_blank" href="/process?site=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
&cdn=false&mod=<?php echo $_smarty_tpl->tpl_vars['module_name']->value;?>
" title="网站编译">编译</a>
                            
                            
                            
                        
                        
                            
                                
                                
                            
                            
                            
                                
                                
                            
                            
                            <a class="op-button" target="_blank" href="/process?branch=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
&cdn=true&mod=<?php echo $_smarty_tpl->tpl_vars['module_name']->value;?>
&commit=true" title="网站提交">提交</a>
                        
                        <a class="op-button new-func" target="_blank" href="/merge?branch=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
&mod=<?php echo $_smarty_tpl->tpl_vars['module_name']->value;?>
" title="实时合图配置">一键合图</a>
                        <a class="op-button test" href="#" title="提测邮件通知" data-index="<?php echo $_smarty_tpl->tpl_vars['value']->index;?>
">提测</a>
                    </div>
                <?php } ?>
            </div>

            <div class="link widget">
                <h3>分支预览</h3>
                <a class="hyperlink  new-func" target="_blank" href="http://preview.<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
.music.baidu.com">预览环境</a>
                <a class="hyperlink" href="/m3dsync-tool" target="_blank">同步工具下载</a><br>
                <a class="hyperlink" target="_blank" href="http://<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
.music.baidu.com">测试环境</a>
                <a class="hyperlink" href="/xhprof.php?name=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
&env=test" target="_blank">性能观察</a><br>
                <a class="hyperlink" target="_blank" href="http://build.<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
.music.baidu.com">编译环境</a>
                <a class="hyperlink" href="/xhprof.php?name=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
&env=build" target="_blank">性能观察</a><br>
                <a class="hyperlink" target="_blank" href="http://release.<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
.music.baidu.com">发布环境</a>
                <a class="hyperlink" href="/xhprof.php?name=<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['name']->value, ENT_QUOTES, 'UTF-8', true);?>
&env=release" target="_blank">性能观察</a>
            </div>

            <div class="qa widget">
                <h3>QA集成</h3>
                <span>项目名称:</span><input type="text" name="pj_name" value="<?php echo $_smarty_tpl->tpl_vars['list']->value['pj_name'];?>
" />
                <div>
                    <a class="save_pj button">保存名称</a>
                    <a class="test_pj button">测试</a>
                </div>
            </div>
            <div class="remark widget">
                <h3>备注</h3>
                <textarea name="remark"><?php echo $_smarty_tpl->tpl_vars['list']->value['remark'];?>
</textarea>
                <div>
                    <a class="save_remark button">保存备注</a>
                </div>
            </div>
            <div class="sanbox widget">
                <h3>沙盒切换</h3>
                DEF:<input type="radio" name="niepan" value="niepan,default">
                QA:<input type="radio" name="niepan" value="niepan,qa">
                RD:<input type="radio" checked="true" name="niepan" value="niepan,rd">
                <br>
                <span>TiKToK.</span>
            </div>

        </section>
    <?php } ?>
    </article>
</div>
<div class="add-content dialog" id="add_content">
    <div class="selects widget">
        <h3>代码分支</h3>
    <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tplData']->value['all_branches']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['value']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
 $_smarty_tpl->tpl_vars['value']->index++;
?>
        <div class="select">
            <span class="label"><?php echo $_smarty_tpl->tpl_vars['value']->value['title'];?>
:</span>
            <?php echo smarty_function_html_options(array('name'=>$_smarty_tpl->tpl_vars['key']->value,'options'=>$_smarty_tpl->tpl_vars['value']->value['branch']),$_smarty_tpl);?>

        </div>
    <?php } ?>
    </div>
    <div class="widget">
        <h3>分支名</h3>
        <input type="text" name="branch_name" />
        <span>*</span>
    </div>
    <div class="widget">
        <h3>QA</h3>
        <span>项目名称:</span><input type="text" name="pj_name" />
    </div>
    <div class="widget remark">
        <h3>备注</h3>
        <textarea name="remark"></textarea>
        <span>*</span>
    </div>
    <div class="r-buttons">
        <a id="new_add" class="button">保存</a>
        <a class="button cancel">取消</a>
    </div>
</div>
<div id="add_module" class="dialog">
    <div class="module-item">
        <span class="label">SVN模块名：</span>
        <input type="text" name="svn_name" required="required" />
        <span>*</span>
    </div>
    <div class="module-item">
        <span class="label">产品线名：</span>
        <input type="text" name="online_name" placeholder="默认为模块名" data-default-from="svn_name" />
    </div>
    <div class="module-item">
        <span class="label">静态资源访问前缀：</span>
        <input type="text" name="static_prefix" placeholder="默认为产品线名" data-default-from="online_name" />
    </div>
    <div class="module-item">
        <span class="label">静态资源目录：</span>
        <input type="text" name="static_path" placeholder="默认为src目录" data-default="src" />
    </div>
    <div class="module-item">
        <span class="label">模版资源访问前缀：</span>
        <input type="text" name="template_prefix" placeholder="默认为产品线名" data-default-from="online_name" />
    </div>
    <div class="module-item">
        <span class="label">模版资源目录：</span>
        <input type="text" name="template_path" placeholder="默认为src/template" data-default="src/template" />
    </div>
    <div class="r-buttons">
        <a id="new_module" class="button">添加</a>
        <a class="button cancel">取消</a>
    </div>
</div>
<div id="test_notice" class="dialog">
    <div class="widget nofloat">
        <span>收件人：</span>
        <div >
            <ul class="qa-list">
                <li><label for="caoli"><input data-mail="caoli01" type="checkbox" id="caoli">曹利</label> </li>
                <li><label for="tianyu"><input data-mail="liaotianyu" type="checkbox" id="tianyu">廖天宇</label></li>
                <li><label for="shuqing"><input data-mail="songshuqing" type="checkbox" id="shuqing">宋书青</label></li>
                <li><label for="yaying"><input data-mail="chouyaying" type="checkbox" id="yaying">仇亚颖</label></li>
                <li><label for="zhoushan"><input data-mail="zhoushan01" type="checkbox" id="zhoushan">周山</label></li>
            </ul>
            <input id ="qamails" type="text" name="mailto" placeholder="默认为music-qa,多个收件人用”,“分割,只写邮箱前缀" data-default="music-qa"/>@baidu.com
        </div>
    </div>




    <div class="widget nofloat">
        <span>主题：</span>
        <div>
            <input type="text" name="to_who" required="required" placeholder="提给谁*" />
            <input type="text" name="subject" required="required" placeholder="短小精悍的主题*"/>
        </div>
    </div>
    <div class="widget nofloat">
        <span>提测人：</span>
        <ul class="fe-list">
            <li><label for="shaofeng"><input data-mail="mushaofeng" type="checkbox" id="shaofeng">少峰</label></li>
            <li><label for="xiangpeng"><input data-mail="sunxiangpeng" type="checkbox" id="xiangpeng">祥鹏</label></li>
            <li><label for="jiahui"><input data-mail="zhengjiahui" type="checkbox" id="jiahui">佳卉</label></li>
            <li><label for="liuwei"><input data-mail="liuwei06" type="checkbox" id="liuwei">刘伟</label></li>
            <li><label for="chunyan"><input data-mail="chaichunyan" type="checkbox" id="chunyan">春燕</label></li>
            <li><label for="qiwei"><input data-mail="qiwei03" type="checkbox" id="qiwei">齐伟</label></li>
            <li><label for="luoqin"><input data-mail="luoqin" type="checkbox" id="luoqin">骆勤</label></li>
            <li><label for="jiexuan"><input data-mail="gaojiexuan" type="checkbox" id="jiexuan">洁璇</label></li>
            <li><label for="taining"><input data-mail="lutaining" type="checkbox" id="taining">泰宁</label></li>
            <li><label for="lijing"><input data-mail="lijing07" type="checkbox" id="lijing">李竞</label></li>
            <li><label for="jiawei"><input data-mail="zoujiawei" type="checkbox" id="jiawei">家伟</label></li>
            <li><label for="zhongjian"><input data-mail="huangzhongjian" type="checkbox" id="zhongjian">忠剑</label></li>
            <li><label for="xiaoqiao"><input data-mail="qiaogang" type="checkbox" id="xiaoqiao">小乔</label></li>
            <li><label for="weibin"><input data-mail="liangweibin" type="checkbox" id="weibin">伟斌</label></li>
        </ul>
        <input id ="femails" type="text" name="from_who" required="required" placeholder="提测人,填写自己的邮箱前缀*" />@baidu.com
        <textarea id="test-description" placeholder="提测描述：项目内容，修改点等*"></textarea>
        <div id="message">
            <table border="1" cellspacing="0" cellpadding="5" bordercolor="#333" style="border-collapse:collapse">
                <tbody id="message_hook"></tbody>
                <tr>
                    <th colspan="2">Host</th>
                </tr>
                <tr id="host"></tr>
                <tr>
                    <th colspan="2">分支</th>
                </tr>
                <tbody id="branches"></tbody>
            </table>
            <br />
            <br />
            <hr style="border: none;border-top: 1px solid #999;"/>
            <div style="font-size: 14px;color: #333;font-family: 'Microsoft Yahei';">
                <a href="http://config.music.baidu.com">M3D开发联调平台</a>
                <span style="width: auto;font-weight: normal;">&nbsp;|&nbsp;IP: 10.65.42.27</span>
            </div>
        </div>
    </div>

    <div class="r-buttons">
        <a id="mail" class="button">发送</a>
        <a class="button cancel">取消</a>
    </div>
</div>
</body>
</html>
<?php }} ?>