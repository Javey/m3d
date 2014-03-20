{extends file="plaza/ting_diy_detail/mod_block.html.tpl"}
{block name='mod_attr'}monkey="mod-albumlist{$albumIndex}"{/block}
{block name="mod_block_class"}
	album-list-block
{/block}

{block name="mod_block_body"}
	<div class="block-desc bb-dashed">
		{$listData.desc nofilter}
	</div>
	{include file="widget/album_cover/album_cover.html.tpl" inline}
	{include file="widget/author_list/author_list.html.tpl" inline}
	{if $layout=="compact"}
		{$listAry = array_chunk($listData.albums, 5)}
		{foreach $listAry as $list}
		<ul class="album-list-compact clearfix {if !$list@last} bb-dashed {/if}">
			{foreach $list as $item}
			<li>
				{album_cover album=$item}
				<div class="album-name fwb"><a href="/album/{$item.album_id}" title="{$item.title}">{$item.title|pixel_truncate:104}</a></div>
				<div class="album-author">{author_list releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid names=$item.author width=110}</div>
			</li>
			{/foreach}
		</ul>
		{/foreach}
	{else}
		{$listAry = array_chunk($listData.albums, 3)}
		{foreach $listAry as $list}
		<ul class="album-list-loose clearfix {if !$list@last} bb-dashed {/if}">
			{foreach $list as $item}
			<li>
				{album_cover album=$item}
				<div class="album-name fwb"><a href="/album/{$item.album_id}" title="{$item.title}">{$item.title|pixel_truncate:110}</a></div>
				<div class="album-author">{author_list releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid names=$item.author width=110}</div>
				<div class="album-desc cl">{if $item.desc}“{$item.desc|pixel_truncate:110}”{else}&nbsp;{/if}</div>
			</li>
			{/foreach}
		</ul>
		{/foreach}
	{/if}
	
{/block}