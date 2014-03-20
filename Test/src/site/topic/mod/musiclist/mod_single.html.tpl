{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-single{/block}
{block name='mod_attr'}monkey="mod-single{$index}"{/block}
{block name="mod_body"}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
{if $modData.data}
{foreach $modData.data  as $key => $song}
{if $song@first}
        <div class="play-holder clearfix">
			<div class="play-btn-holder clicklog-play-btn ">
				<a class="play-btn { 'id':{$song.song_id} }" title="播放" href="#"></a>
			</div>				
			<div class="song-title">
				{song_link_url_plugin song=$song linkWithNoSongId="#" songLinkUrl=theSongLink}
				<a href="{$theSongLink}" target="_blank" >{$song.title|pixel_truncate:335} </a><br />
				{if $song.license_number}
				文化审批：{$song.license_number}
				{/if}
			</div>
			<div class="fr mt15p">			
            <span class=" music-icon-hook song-love { 'musicIcon': { id: {$song.song_id} , type:'song', iconStr:'collect' } }"><a href="#" title="收藏" class="icon-collect song-love-btn">收藏</a></span>
			<span class="music-icon-hook { 'musicIcon': { id: {$song.song_id} , type:'song' } }">
				<a href="#" title="添加" class="icon-add">添加</a>
			</span>
			</div>
		</div>
{/if}
{/foreach}
{/if}
{/block}
