{extends file="module/module.html.tpl"}
{block name='mod_class'}hot-song{/block}
{block name='mod_attr'}monkey="hotSongs"{/block}
{block name="mod_head"}
<a href="{if $song_info.relate_status == 0 || $song_info.relate_status == 1}/artist/{$firstArtistId}{else}/search?key={$firstArtist|escape:'url' nofilter}{/if}" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">{$firstArtist}的其他热歌</h2>
{/block}
{block name="mod_body"}
{if $tplData.hot_song_list}
	{$ids = []}
	{foreach $tplData.hot_song_list as $key => $song}
		{$tplData.hot_song_list[$key]["title"] = $song["title"]|pixel_truncate:183}
		{$tmp = array_push($ids, $song.song_id)}
	{/foreach}
	<div class="hot-song-list" >

{include 'widget/song_list/song_list.html.tpl' inline}
	{song_list moduleName = "otherhotsong" isDisplayInedexNum = true indexWidth =20 btnPos = "none" songData = $tplData.hot_song_list funBtn=["playall"] colCheck =false songWidth = 220 colSinger = false funIcon=["play","add"] appendix=false}
	</div>
	<div class="hot-playall">
	{$ids = join( $ids, ',' )}
		<span class="hot-play play-all-btn" data-playdata = '{json_encode([ "ids"=>$ids , "moduleName"=> "otherhotsong" ])}'>
			{button 
				style = "a"
				str = "播放全部"
				icon = "play"
				href = "#"}
		</span>	
	</div>	

{/if}
{/block}
