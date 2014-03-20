{extends file="plaza/artist/artist.html.tpl"}

{block name="js" append}
	
{/block}
{block name="css" append}
	<link rel="stylesheet" type="text/css" href="/static/css/artist_index.css{*version file='/static/css/artist_index.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="main_body"}
	<div monkey="mainbody" class="main-body {if $COLUMN == 4}western{/if}">
		{include file="plaza/artist/detail-body.html.tpl"}
	</div>
{/block}
