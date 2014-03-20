{**include file="widget/attention/attention.html.tpl"**}{**By Javey**}
{include file="widget/avatar/avatar.html.tpl" inline}
{$targetArtist = $tplData.heterobject.res_array[0]}

<div id="target_banner" monkey="target-banner">
<div class="target-artist clearfix" id="target_artist">
	<a href="/data/artist/redirect?id={$targetArtist.artist_id}" class="avatar cover-img">
		<img src="{avatar user=$targetArtist type=middle}" width="90" height="90" alt="{$targetArtist.singer}" />
	</a>
	<div class="artist-info">
		<div class="name">
			<a href="/data/artist/redirect?id={$targetArtist.artist_id}">{$targetArtist.singer|pixel_truncate:330}</a>
		</div>
		<div class="info">
			<span class="has-split">单曲：<a href="/data/artist/redirect?id={$targetArtist.artist_id}">{$targetArtist.song_num}</a>首</span>
			<span class="module-line splice-line"></span>
			<span {if $targetArtist.country} class="has-split" {/if} >专辑：<a href="/data/artist/redirect?type=album&id={$targetArtist.artist_id}">{$targetArtist.album_num}</a>张</span>
			{if $targetArtist.country}
				<span class="module-line splice-line"></span>
				<span>地区：<span>{$targetArtist.country|pixel_truncate:200}</span></span>
			{/if}
		</div>
		
		<span class="play-hotsong-hook" data-playdata="{json_encode(['ids'=> $targetArtist.song_ids,'moduleName'=> 'playhot'])}">
            {button 
            style = "a"
            str = "播放 <b>Ta</b> 的热门歌曲"
            icon = "play"
            class = " "
            href = "#"}
        </span>
		{button 
        style = "b"
        str = "收听 <b>Ta</b> 的电台"
        icon = "fm"
        isRightIcon = true
        class = "btn-singer-fm"
        href = "#"
        tagAtt = "artist = '{$targetArtist.singer}' target='_blank'"
    	}

		<!-- <div class="intro">
			{$targetArtist.artist_desc|pixel_truncate:420 nofilter}
		</div> -->
	</div>
</div>
</div>
