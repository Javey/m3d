{extends file="plaza/artist/artist.html.tpl"}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/artist_index.css{*version file='/static/css/artist_index.css' prefix='?' suffix='.css'*}" />
<style type="text/css">.container .list-item .line-space { width: 100%;   height: 80px; }</style>
{/block}


{block name="main_body"}
	<div class="main-body {if $COLUMN == 4}western{/if}">
		{include file="plaza/artist/main-body.html.tpl"}
	</div>
{/block}
