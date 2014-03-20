{$CONFIG_BRANCH = "M3D音乐"}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{strtoupper($CONFIG_BRANCH)}开发联调平台</title>
    <link rel="stylesheet" href="/static/css/base.css?v=20121221">
    <script type="text/javascript" src="/static/js/lib/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="/static/js/base.js?v=20121221"></script>
</head>
<body class="flex-box-v">
<header class="flex-box-h">
    <div>
        <span>{strtoupper($CONFIG_BRANCH)}开发联调平台</span>
    </div>
    <div>
        <span id="branch_title"></span>
        <div class="r-buttons">
            <a id="add" class="button">新增分支</a>
            <a id="restart" class="button">重启服务器</a>
            <a class="button add-module">新模块添加</a>
        </div>
        <div class="l-buttons">
        {**<a id="save" class="button">保存</a>
        <a id="delete" class="button">删除</a>
        <a id="clear" class="button">清缓存</a>**}
					{**<a style="color: #999;" href="old.php">旧版入口</a>**}

        </div>
    </div>
</header>
<div class="content">
    <aside>
        <nav>
        {foreach $tplData['current_branches'] as $name=>$list}
            <div class="nav-item {if $list@first}selected{/if}">{$name|escape}</div>
        {/foreach}
        </nav>
    </aside>
    <article>
    {foreach $tplData['current_branches'] as $name=>$list}
        <section {if $list@first}class="current-content"{/if}>
            <div class="selects widget">
                <h3>分支代码</h3>
                {foreach $tplData['all_branches'] as $key=>$value}
                    <div class="select">
                        <a class="hyperlink" href="/{$name|escape}/src/rd-main" target="_blank">{$value.title}:</a>
                        {html_options name=$key options=$value.branch selected=$list.$key}
                    </div>
                {/foreach}
            </div>
            <div class="op widget">
                <h3>操作</h3>
                <div class="op-item op-item-first">
                    <a class="button button-white save ">保存</a>
                    <a class="button button-white delete">删除</a>
                    <a class="button button-white clear">清缓存</a>
                {*<a class="button button-white test">提测通知</a>*}
                {**<a class="button">JS检查</a>**}
                </div>
                {foreach $tplData['module'] as $key=>$value}
                    {if $value.title == "rd"}
                        {continue}
                    {/if}
                    {if $value.module_name}
                        {$module_name = $value.module_name}
                        {else}
                        {$module_name = $key}
                    {/if}
                    <div class="op-item">
                        <div class="op-header">{$value.title}</div>
                        {*{if $value.title == "mobile"}*}
                            {*<div class="multi">*}
                                {*<a class="mobile-compile button button-white" title="sh">sh</a>*}
                                <a class="op-button" target="_blank" href="/process?site={$name|escape}&cdn=false&mod={$module_name}" title="网站编译">编译</a>
                            {*</div>*}
                            {*{else}*}
                            {*<a class="op-button" target="_blank" href="/process?branch={$name|escape}&cdn=false&mod={$module_name}" title="网站编译">编译</a>*}
                        {*{/if}*}
                        {*{if $value.title == "main"}*}
                            {*<div class="multi">*}
                                {*<a class="op-button" target="_blank" href="/process?branch={$name|escape}&cdn=true&mod={$module_name}&commit=true" title="网站发布">发布</a>*}
                                {*<a class="main-ci button button-white" title="主站ci">ci</a>*}
                            {*</div>*}
                            {*{elseif $value.title == "mobile"}*}
                            {*<div class="multi">*}
                                {*<a class="mobile-commit button button-white" title="ci">ci</a>*}
                                {*<a class="op-button" target="_blank" href="/process?branch={$name|escape}&cdn=true&mod={$module_name}&commit=true" title="网站提交">提交</a>*}
                            {*</div>*}
                            {*{else}*}
                            <a class="op-button" target="_blank" href="/process?branch={$name|escape}&cdn=true&mod={$module_name}&commit=true" title="网站提交">提交</a>
                        {*{/if}*}
                        <a class="op-button new-func" target="_blank" href="/merge?branch={$name|escape}&mod={$module_name}" title="实时合图配置">一键合图</a>
                        <a class="op-button test" href="#" title="提测邮件通知" data-index="{$value@index}">提测</a>
                    </div>
                {/foreach}
            </div>

            <div class="link widget">
                <h3>分支预览</h3>
                <a class="hyperlink  new-func" target="_blank" href="http://preview.{$name|escape}.music.baidu.com">预览环境</a>
                <a class="hyperlink" href="/m3dsync-tool" target="_blank">同步工具下载</a><br>
                <a class="hyperlink" target="_blank" href="http://{$name|escape}.music.baidu.com">测试环境</a>
                <a class="hyperlink" href="/xhprof.php?name={$name|escape}&env=test" target="_blank">性能观察</a><br>
                <a class="hyperlink" target="_blank" href="http://build.{$name|escape}.music.baidu.com">编译环境</a>
                <a class="hyperlink" href="/xhprof.php?name={$name|escape}&env=build" target="_blank">性能观察</a><br>
                <a class="hyperlink" target="_blank" href="http://release.{$name|escape}.music.baidu.com">发布环境</a>
                <a class="hyperlink" href="/xhprof.php?name={$name|escape}&env=release" target="_blank">性能观察</a>
            </div>

            <div class="qa widget">
                <h3>QA集成</h3>
                <span>项目名称:</span><input type="text" name="pj_name" value="{$list.pj_name}" />
                <div>
                    <a class="save_pj button">保存名称</a>
                    <a class="test_pj button">测试</a>
                </div>
            </div>
            <div class="remark widget">
                <h3>备注</h3>
                <textarea name="remark">{$list.remark}</textarea>
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
    {/foreach}
    </article>
</div>
<div class="add-content dialog" id="add_content">
    <div class="selects widget">
        <h3>代码分支</h3>
    {foreach $tplData['all_branches'] as $key=>$value}
        <div class="select">
            <span class="label">{$value.title}:</span>
            {html_options name=$key options=$value.branch}
        </div>
    {/foreach}
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
{*<div class="widget nofloat">*}
{*<span>抄送：</span>*}
{*<input type="text" name="cc" />*}
{*</div>*}
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
{*<div id="message"></div>*}
    <div class="r-buttons">
        <a id="mail" class="button">发送</a>
        <a class="button cancel">取消</a>
    </div>
</div>
</body>
</html>
