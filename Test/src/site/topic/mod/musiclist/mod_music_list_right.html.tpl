{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-music-list-right{/block}
{block name='mod_attr'}monkey="mod-music-list-right{$index}"{/block}
{block name="mod_body"}
{include 'widget/button/button.html.tpl' inline}
{include 'widget/song_list/song_list.html.tpl' inline}
	{$ids = []}
	{foreach $modData.data  as $key => $song}
		{$song["title"] = $song["title"]|pixel_truncate:165}
		{$tmp = array_push($ids, $song.song_id)}
	{/foreach}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
<div class="hot-song">
	{song_list moduleName = "songList"|cat:$modData.parames.module_id total= "100"
		songWidth=160 colCheck =false colIndex =true indexWidth="20" colSinger=false diplostichous=false btnPos ="none" songData=$modData.data  
		funIcon=['play','add','download'] appendix=false}
	</div>
	<div class="hot-links clearfix">
	{$ids = join( $ids, ',' )}
		<span class="hot-play play-all-btn" data-playdata = '{json_encode([ "ids"=>$ids , "moduleName"=> "songList"|cat:$modData.parames.module_id ])}'>
			{button 
				style = "a"
				str = "播放全部"
				icon = "play"
				href = "#"}
		</span>	
	</div>
{/block}
