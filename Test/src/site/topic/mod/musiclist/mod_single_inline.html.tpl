<!--
	模块：内嵌播放器
    注意：只能播放器最基本的Dom结构，播放器位置及外观另加css来实现。
-->
<div class="mod-single-inline  clearfix" monkey="mod-blank{$index}" id="mod_{$modData.parames.module_id}">
	{if $modData.data}
	{$ids = []}
		{foreach $modData.data  as $key => $song}
			{$tmp=array_push($ids, $song.song_id)}
		{/foreach}
		{$ids = join( $ids, ',' )}
		<div class="player-hook play-box { 'songid':'{$ids}' }" id="player-hook" ></div>
	{/if}	
</div>