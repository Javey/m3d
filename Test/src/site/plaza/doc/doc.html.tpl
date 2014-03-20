{extends file="plaza/plaza.html.tpl"}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/site/plaza/doc/doc.css" />
{/block}
{block name="js" append}
<script type="text/javascript" src="/site/plaza/doc/doc.js" _xbuilder="true" _xcompress="true"></script>
{/block}}
{block name="assign" append}
{$navIndex=''}
{/block}
{block name="body_class_name"}
	channel help
{/block}

{block name="content_main"}
	<div class="sidebar doc-sidebar">
		{include file="plaza/doc/sidebar.html.tpl" }
	</div>
	<div class="main-body doc-body">
		{block name="main_body"}{/block}
	</div>
{/block}
