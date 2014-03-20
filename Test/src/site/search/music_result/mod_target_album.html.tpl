{include file="widget/album_cover/album_cover.html.tpl" inline}
{include file="widget/music_icon/music_icon.html.tpl" inline}
{include file="widget/author_list/author_list.html.tpl" inline}

{$targetAlbum = $tplData.heterobject.res_array[0]}
<div id="target_banner" monkey="target-banner">
<div class="target-album clearfix" id="target_album">
	{album_cover album=$targetAlbum showStatus = true}
	<div class="info">
		<div class="title-info">
			<a class="title" href="/album/{$targetAlbum.album_id}">{$targetAlbum.album|pixel_truncate:208}</a> - {author_list ids=$targetAlbum.artist_id  names=$targetAlbum.singer width="130" redirect=true releaseStatus = $targetAlbum.relate_status source='album'}
		</div>
		<div class="album-info clearfix">
            {if $targetAlbum.time=='0000-00-00'}{$targetAlbum.time=''}{/if}
            {if !$targetAlbum.company && !$targetAlbum.time}
                {$descTrun = 880}{else}{$descTrun = 440}
            {/if}
            {if $targetAlbum.time}
                <span class="time">{$targetAlbum.time}</span>
                <span class="module-line splice-line"></span>
            {/if}
            {if $targetAlbum.styles}
                <span class="styles">{$targetAlbum.styles}</span>
                <span class="module-line splice-line"></span>
            {/if}
            {if $targetAlbum.company}
                <span class="company {if $targetAlbum.time} has-split{/if}">{$targetAlbum.company|pixel_truncate:228}</span>
            {/if}
           
		</div>
         <span class="album-cover album-cover-hook album-play-btn"   data-albumdata = '{json_encode(["id"=>$targetAlbum.album_id,"moduleName" => "playAlbum"])}'>
            <span class="play-icon">
              {button
                str = "播放该专辑"
                style = "a"
                icon = "play"
              }
            </span> 
          </span>
          {$ids = $targetAlbum.song_ids}
          <span class="album-add" data-adddata='{json_encode(["moduleName"=>"addAlbum","ids"=> $ids])}'>
            {button
            str = "添加该专辑"
            style = "b"
            icon = "add"
          }
          </span>
	</div>
</div>
</div>
