{extends file="module/module.html.tpl"}
{block name='mod_class'}user-privilege{/block}
{block name='mod_attr'}monkey="user-privilege" {/block}
{block name="mod_head"}
{**模块头部**}
<h3 class="title">音乐下载特权</h3>
{/block}

{block name="mod_body"}
{if !$serviceinfo}
	{include file="usercenter/mod_service_show.html.tpl"}
{else}
	{include file="usercenter/mod_mypower.html.tpl"}
{/if}
{/block}
