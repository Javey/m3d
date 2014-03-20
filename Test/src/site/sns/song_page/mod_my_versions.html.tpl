{extends file="module/module.html.tpl"}
{block name='mod_class'}myversion-song{/block}
{block name='mod_attr'}monkey="myversion"{/block}
{block name="mod_head"}
{$commaPos = strpos($song_info.all_artist_ting_uid, ',')}
{if $commaPos === false}
	{$authorName = $song_info.author}
{else}
	{$authorNameList = explode(',', $song_info.author)}
	{$authorName = $authorNameList[0]}
{/if}
<h2 class="title">{$authorName}的其他版本"{$song_info.title}"</h2>
{/block}
{block name="mod_body"}
{if $tplData.own_cover_info}
	{$ids = []}
	{foreach $tplData.own_cover_info as $key => $song}
		{$tplData.own_cover_info[$key]["title"] = $song["title"]|pixel_truncate:183}
		{$tmp = array_push($ids, $song.song_id)}
	{/foreach}
	<div class="myversion-song-list" >

{include 'widget/song_list/song_list.html.tpl' inline}
{include file="widget/music_icon/music_icon.html.tpl"}
	{** song_list moduleName = "myversionsong" isDisplayInedexNum = true indexWidth =20 btnPos = "none" songData = $tplData.own_cover_info funBtn=["playall"] colCheck =false songWidth = 220 colSinger = false funIcon=["play","add"] appendix=false **}


<div data-listdata="" class="song-list song-list-hook  ">
	<ul>
{$index = 0}
{$albumNameWidth = 260}
{$infoWidth = 160 }
{foreach $tplData.own_cover_info as $item}
	<!-- 页面索引开始值 -->
	<!-- 每一个条目的索引值设置 -->
            {$index = $index + 1}
            {if $index < 10}
                {$index_num = 0|cat:$index} 
            {else}
                {$index_num = $index}
            {/if}
		<li data-songitem="{json_encode(["songItem"=>["sid"=>$item.song_id,"author"=>$item.author|replace:"&#039;":"\\&#039;"]])}" class="  bb-dotimg clearfix  last-item song-item-hook { 'songItem': { 'sid': '{$item.song_id}', 'sname': '{$item.title|replace:"&#039;":"\\&#039;"}', 'author': '{$item.author|replace:"&#039;":"\\&#039;"}' } }    list1   ">
			<div class="song-item">	
			<span class="index-num index-hook" style="width: 20px;">
				{$index_num}
			</span>
			<!-- 设置截断长度，考虑到有热门歌曲后会跟一个hot标签，需要做相应处理 -->
			<span class="song-title " style="width: 630px;">
				{song_link_url_plugin song=$item linkWithNoSongId="#" songLinkUrl=theSongLink}
				<a href="{$theSongLink}">《{$item.album_title|pixel_truncate:$albumNameWidth nofilter}》版</a>
				{if strlen($item.versions) > 0}&nbsp;&nbsp;<span class="song-title-extra">{$item.versions}</span>{/if}
				{if strlen($item.info) > 0}&nbsp;&nbsp;<span class="song-title-extra">{$item.info|pixel_truncate:$infoWidth nofilter}</span>{/if}
				{if $item.has_mv2 == '1'}<a title="歌曲MV" target="_blank" href="/mv/{$item.song_id}" class="mv-icon"></a>{/if}
			</span> 
			<span class="fun-icon">
				{music_icon moduleName = "myversions"|cat:"Icon" id={$item.song_id} icons=["play", "add"] bePlayed = $item.bePlayed beDownloaded = $item.beDownloaded}
			</span>
			{**
			<span class="fun-icon">
				<span class="music-icon-hook " data-musicicon="">
					<a class="list-micon icon-play" data-action="play" title="播放" href="#"><i></i></a>
					<i class="module-line music-icon-line"></i>				
					<a class="list-micon icon-add" data-action="add" title="添加" href="#"><i></i></a>
				</span>					
			</span>
			**}
			</div>
		</li>
{/foreach}
	</ul>
</div>

</div>
	{**
	<div class="myversion-playall">
	{$ids = join( $ids, ',' )}
		<span class="myversion-play play-all-btn" data-playdata = '{json_encode([ "ids"=>$ids , "moduleName"=> "myversionsong" ])}'>
			{button 
				style = "a"
				str = "播放全部"
				icon = "play"
				href = "#"}
		</span>	
	</div>	
	**}

{/if}
{/block}
