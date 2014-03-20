{extends file="plaza/ting_diy_detail/mod_block.html.tpl"}
{block name='mod_attr'}monkey="mod-songlist{$songsIndex}"{/block}
{block name="mod_block_class"}
	song-list-block
{/block}

{block name="mod_block_body"}
	<div class="block-desc">
		{$listData.desc nofilter}
	</div>
	{if $style.song_position=='right'}
		{$pos = "20px 25px 10px 200px"}
	{else}
		{$pos = "20px 200px 10px 25px"}
	{/if}
	<div style="margin:{$pos};">
		{include file="widget/button/button.html.tpl" inline=true}
		{$songIds=[]}
		{foreach $listData.songs as $song}
			{$count = array_push($songIds, $song.song_id)}
		{/foreach}
		{button tagName="a" style="a" str="播放该列表" icon="play" class="btn-play-list" data =  ['button'=>['data'=>$songIds]]}

		<h4>自选辑曲目&nbsp;&nbsp;({count($listData.songs)})</h4>
		{include file="widget/song_list/song_list.html.tpl"}
		{song_list total = 200 quotDesc=false  funBtn=["play","add","collect","down","mobile"] songData="{$listData.songs}" funIcon=["play","add","download","collect"]}
	</div>
{/block}
