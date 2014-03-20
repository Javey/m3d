{extends file="module/module.html.tpl"}
{block name='mod_class'}user-center-info{/block}
{block name='mod_attr'}monkey="user-center-info" {/block}
{block name="mod_head"}
{**模块头部**}
<h2 class="title">音乐个人中心</h2>
{/block}

{block name="mod_body"}
<div class="user-avatar">
	<img src="{avatar user=$loginInfo.pass_info}" alt="">
</div>
<div class="user-info">
	<h3 class="user-name">{$loginInfoUserName}</h3>
	<div class="desc">{$loginInfo.reg_time|date_format:'%Y.%m.%d'} 年成为百度用户</div>
</div>
{/block}
