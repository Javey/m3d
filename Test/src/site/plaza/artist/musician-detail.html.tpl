{**百度音乐人模块（与其它模块数据结构不一致）**}
{extends file="plaza/artist/artist.html.tpl"}

{block name="js" append}
	
{/block}
{block name="css" append}
	<link rel="stylesheet" type="text/css" href="/static/css/artist_index.css{*version file='/static/css/artist_index.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="main_body"}
	<div monkey="mainbody" class="main-body">
		{include file="plaza/artist/musician-detail-body.html.tpl"}
	</div>
{/block}
