{extends file="module/module.html.tpl"}
{block name='mod_class'}mod-topic{/block}
{block name='mod_attr'}monkey="mod-topic"{/block}
{block name="mod_head"}
<!--h2 class="title">精彩专题</h2-->
{/block}
{block name="mod_body"}
<ul>
	{foreach $tplData.tagLinks as $item}
		{if $item@index < 4}
			<li><i></i><a href="{$item.link}" target="_blank" title="{$item.desc}">{$item.desc|pixel_truncate:200}</a> </li>
		{/if}
	{/foreach}
</ul>
{/block}
