{extends file="module/module.html.tpl"}
{block name='mod_class'}group-artist{/block}
{block name='mod_attr'}monkey="group-artist"{/block}
{block name="mod_head"}
<h2 class="title">代表艺人</h2>
{/block}

{block name="mod_body"}
<ul class="group-list">
{foreach $tplData.artistobject.res_array as $item}
{if $item@index<5}
<li class="group-item {if $item@index==4}group-last-item {/if}">
	<a class="cover"  target="_blank"  href="/data/artist/redirect?id={$item.artist_id}">
		<img with=120 height=120 title="{$item.name}" src="{if $item.avatar_s130}{$item.avatar_s130}{else}{#ARTIST_DEFAULT_130b#}{/if}">
	</a>
	<div>
		<a class="c3"  target="_blank"  href="/data/artist/redirect?id={$item.artist_id}" title="{$item.name}">{$item.name|pixel_truncate:120:'tahoma_12'}</a>
	</div>
	{if $item.song_ids}
	<a href="#" data-playdata="{json_encode(['ids'=> $item.song_ids,'moduleName'=> 'groupArtist'])}" class="play-hot-btn">播放TA的热门歌曲</a>	
	{/if}
 </li>
 {/if}
{/foreach}
</ul>

{/block}