{extends file="module/module.html.tpl"}
{block name='mod_class'}qunxin-song{/block}
{block name='mod_attr'}monkey="qunxin"{/block}
{block name="mod_head"}
{foreach $tplData.qx_song_list as $key => $song}
	{$albumId = $song.album_id}
	{$albumName = $song.album_title}
	{break}
{/foreach}
{if $albumId}
<a href="{if $song_info.relate_status == 0 || $song_info.relate_status == 2}/album/{$albumId}{else}/search?key={$albumName|escape:'url' nofilter}{/if}" class="more">更多<span>&gt;&gt;</span></a>
{/if}
<h2 class="title">《{$song_info.album_title|pixel_truncate:350}》的其他歌曲</h2>
{/block}
{block name="mod_body"}
{if $tplData.qx_song_list}
	{$ids = []}
	{foreach $tplData.qx_song_list as $key => $song}
		{$tplData.qx_song_list[$key]["title"] = $song["title"]|pixel_truncate:183}
		{$tmp = array_push($ids, $song.song_id)}
	{/foreach}
	<div class="qunxin-song-list" >

{include 'widget/song_list/song_list.html.tpl' inline}
	{song_list moduleName = "qunxinsong" isDisplayInedexNum = true indexWidth =20 btnPos = "none" songData = $tplData.qx_song_list funBtn=["playall"] colCheck =false songWidth = 145 singerWidth = 80 colSinger = true funIcon=["play","add"] appendix=false}
	</div>
	<div class="qunxin-playall">
	{$ids = join( $ids, ',' )}
		<span class="qunxin-play play-all-btn" data-playdata = '{json_encode([ "ids"=>$ids , "moduleName"=> "qunxinsong" ])}'>
			{button 
				style = "a"
				str = "播放全部"
				icon = "play"
				href = "#"}
		</span>	
	</div>	

{/if}
{/block}
