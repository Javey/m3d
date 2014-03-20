{extends file="module/module.html.tpl"}
{block name='mod_class'}hot-song{/block}
{block name='mod_attr'}monkey="hotSongs"{/block}
{block name="mod_head"}
<h2 class="title">推荐歌曲</h2>
{/block}
{block name="mod_body"}
{if $tplData.relation_song_info.songs}
	{$ids = []}
	{foreach $tplData.relation_song_info.songs as $key => $song}
		{$tplData.relation_song_info.songs[$key]["title"] = $song["title"]|pixel_truncate:183}
		{$tmp = array_push($ids, $song.song_id)}
	{/foreach}
	<div class="hot-song-list" data-data ='{json_encode(["t"=>$tplData.relation_song_info.t,"song_id"=>$tplData.song_info.song_id,"artist_id"=>$tplData.song_info.all_artist_ting_uid])}'>

{include 'widget/song_list/song_list.html.tpl' inline}
	{song_list isDisplayInedexNum = true width="auto" indexWidth =20 btnPos = "none" songData = $tplData.relation_song_info.songs funBtn=["playall"] colCheck =false otherdata = true songWidth =150 singerWidth=150   funIcon=["play","add"] appendix=false}
	</div>
	<div class="hot-playall">
	{$ids = join( $ids, ',' )}
		<span class="hot-play">
			{button 
				style = "a"
				str = "播放全部"
				icon = "play"
				class = "play-all-btn"
				data =  ['button'=>['data'=>$ids]]  
				href = "#"}
		</span>	
	</div>	

{/if}
{/block}
