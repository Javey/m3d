{extends file="module/module.html.tpl"}
{block name='mod_class'}mod-topic{/block}
{block name='mod_attr'}monkey="mod-topic" alog-alias="mod-topic"{/block}
{block name="mod_head"}
<h2 class="title">精彩专题</h2>
{/block}
{block name="mod_body"}
<ul>
	{foreach $tplData.topic_ads as $item}
		{if $item@index < 4}
			<li><i></i><a href="{$item.link}" target="_blank" title="{$item.title}">{$item.title|pixel_truncate:200}</a> </li>
		{/if}
	{/foreach}
</ul>
{/block}