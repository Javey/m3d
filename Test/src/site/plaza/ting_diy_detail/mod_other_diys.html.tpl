{extends file="plaza/ting_diy_detail/mod_block.html.tpl"}
{block name='mod_attr'}monkey="mod-otherDiys"{/block}
{block name="mod_block_class"}
	other-diys-block
{/block}

{block name="mod_block_body"}

<ul class="tdiy-list clearfix">
	{foreach $listData as $item}
		<li class="{if !$item@last}bb-dashed{/if} clearfix">
			<a href="/diyalbum/collection/{$item.code}" class="tdiy-cover" title="{$item.name}"><img src="{$item.thumb_pic}" width="90" height="90" /></a>
			<div class="tdiy-name fwb"><a href="/diyalbum/collection/{$item.code}" title="{$item.name}">《{$item.name|pixel_truncate:90}》</a></div>
			<div class="tdiy-desc">{$item.desc|pixel_truncate:360}</div>
		</li>
	{/foreach}
</ul>
{/block}
