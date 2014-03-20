{extends file="module/mod_left/mod_left.html.tpl"}
{block name='mod_class'} mod-show{/block}

{block name="mod_body"}
{include file="widget/show_information/show_information.html.tpl" inline}
	{show data=$tplData.perform_news}
{/block}