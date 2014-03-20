{include file="widget/author_list/author_list.html.tpl" inline=true}
{include file="widget/music_icon/music_icon.html.tpl"}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{if $tplData.param.start}{$start = $tplData.param.start}{else}{$start = 0}{/if}

<div class="lrc-list" id="lrc_list">
	<ul>
		{foreach $tplData.resultList as $item}
			<li class="clearfix bb" {if $start == 0 && $item@index == 0} id="first_lrc_li" {/if}>
				<div class="song-content">
					<span class="song-title">歌曲:
						{song_link_url_plugin song=$item linkWithNoSongId="#" songLinkUrl=theSongLink}
						<a href="{$theSongLink}" title="{$item.song|replace:'<em>':''|replace:'</em>':'' nofilter}{if $item.license_number}审批文号：{$item.license_number}{/if}">
							{$item.song|html_pixel_truncate:150 nofilter}
						</a>
					</span>
					<span class="artist-title">歌手:
						{author_list ids=$item.artist_id names=$item.singer width=100 filter=false redirect=true releaseStatus=$item.relate_status}
					</span>
					<span class="album-title">
						{if $item.album}专辑:
							{if $item.relate_status == 0 || $item.relate_status == 2}
								<a href="/album/{$item.album_id}" title="{$item.album|replace:'<em>':''|replace:'</em>':'' nofilter}">《{$item.album|html_pixel_truncate:100 nofilter}》</a>
							{else}
								<span class="unreleased">《{$item.album|html_pixel_truncate:100 nofilter}》</span>
							{/if}
						{/if}
					</span>
					<span class="fun-icon">
						{music_icon id={$item.song_id} icons=['play','download'] bePlayed = $item.bePlayed beDownloaded = $item.beDownloaded}
					</span>
				</div>
				{if $item.content}
				<div class="lrc-content">
					<span class="lyric-action">
						<span class="copy-lyric-hook"><a data-clipboard-target="lyricCont-{$item@index}"  href="#" class="copy-lyric">复制歌词</a></span>
						
						<a class="down-lrc-btn { 'href':'{$item.lrc_url}' }" href="#">下载LRC歌词</a>
					</span>
					<p id="lyricCont-{$item@index}">{$item.content|nl2br nofilter}</p>
				</div>
				{/if}
			</li>
		{/foreach}
	</ul>
</div>

{page_navigator total=$tplData.param.total size=$tplData.param.size start=$tplData.param.start 			url="/search/lrc?key={$tplData.query|escape:'url' nofilter}&start=#start#&size=#size#"}
