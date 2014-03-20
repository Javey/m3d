{extends file="ting.html.tpl"}
{block name="assign" append}
{$navIndex='top'}

{include file="plaza/top/top_title_config.html.tpl" inline}
{include file="widget/top/top_title.html.tpl" inline}

{$type = $tplData.type}
{capture assign=title}{top_title titleConfig=$titleConfig type=$type}{/capture}
{/block}

{block name="head" append}
<link rel="stylesheet" type="text/css" href="/static/css/top_detail.css{*version file='/static/css/mod_top_others.css' prefix='?' suffix='.css'*}" />
<link rel="stylesheet" type="text/css" href="/static/css/datepicker.css{*version file='/static/css/datepicker.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="title"}{$title}-百度音乐排行榜{/block}
{block name="body_class"}
class="channel top-channel top-detail"
{/block}

{block name='keywords'}{$title}，排行榜，榜单，百度音乐{/block}
{block name='description'}百度音乐排行榜，{$title}榜单为你提供最权威的{$title}榜单，海量正版高品质音乐，带给你全新音乐体验。{/block}

{block name="assign" append}
	{$COLUMN=5}
	{$ITEMS=50}
	{$TRUNCATE=65}
	{$TRUNCATE_L=80}
{/block}

{block name="js-page"}
{if $type == "new"}
<script type="text/javascript" src="/static/js/datepicker.js{*version file='/static/js/datepicker.js' prefix='?' suffix='.js'*}"></script>

{/if}
{if $type != "artist"}
<script type="text/javascript" src="/static/js/top.js{*version file='/static/js/top.js' prefix='?' suffix='.js'*}"></script>
{/if}
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-top-{$type}{if $type=='new'}-{$tplData.new_type}{/if}{/block}

{block name="content_main"}
{include file="widget/adm/adm.html.tpl" inline}

{if $type == "new"}
	{adm 
	    id = "628"
	    class = "ad-banner ecomad-banner-loading"
	    width = 960
	    
	}
{elseif $type =="dayhot"}
	{adm 
	    id = "629"
	    class = "ad-banner ecomad-banner-loading"
	    width = 960
	    
	}
{else}
	{adm 
	    id = "630"
	    class = "ad-banner ecomad-banner-loading"
	    width = 960
	}
{/if}
{**此处将列表中的歌曲名、歌手名宽度作为变量传参，使得页面定制化更灵活**}

{** 2013.01.31，飙升榜时用到 **}
{if $type == 'biaosheng'}
    {include file="plaza/top/mod_top_biaosheng.html.tpl" songW=240 singerW=240 funIcon=["play","add", "download"] funBtn=["play","add","collect","down"] inline}
{else}
    {include file="plaza/top/mod_top_others.html.tpl" songW=240 singerW=240 funIcon=["play","add", "download"] funBtn=["play","add","collect","down"] inline}
{/if}

{**include file="plaza/top/mod_top_others.html.tpl" songW=240 singerW=240 funIcon=["play","add", "download"] funBtn=["play","add","collect","down"] inline**}
{/block}
