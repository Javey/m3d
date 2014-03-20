{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/avatar/avatar.html.tpl" inline}
{if $tplData.param.start}{$start = $tplData.param.start}{else}{$start = 0}{/if}

<div class="artist-list" id="artist_list">
	<ul>
		{foreach $tplData.resultList as $item}
		<li class="clearfix bb item {if $item@last}item-last{/if}" {if $start == 0 && $item@index == 0} id="first_artist_li" {/if}> 
	        {capture}
	        	{assign var="artist" value=$item.singer|replace:'<em>':''|replace:'</em>':''}
	        {/capture}			
			{if $item.yyr_artist==1}
			<div class="info">
				<div class="artist-face cover-img">
					<a class="cover" href="http://y.baidu.com/artist/{$item.artist_id}?pst=music_search" class="avatar">
						<img class="cover-img lazyload" src="{#PIC_PLACEHOLDER#}" org_src="{$item.avatar_middle}" width="90" height="90" alt="{$item.singer}" />
					</a>
				</div>
				<div class="artist-info">
					<div class="name">
						<a href="http://y.baidu.com/artist/{$item.artist_id}?pst=music_search"><span>{$item.singer|html_pixel_truncate:434 nofilter}</span></a>
						<span class="icon-ybaidu" title="百度音乐人"></span>
					</div>
					<div class="detail clearfix">
						<span class="has-split">单曲：
							<a href="http://y.baidu.com/artist/{$item.artist_id}?pst=music_search">{$item.song_num}</a>首
						</span>
						{if $item.country}
						<span>
							<span class="module-line"></span>
							地区：<span>{$item.country|pixel_truncate:200}</span>
						</span>
						{/if}
					</div>
					<div class="intro">
						{if $item.artist_desc && $item.artist_desc !== 'None'}{$item.artist_desc|pixel_truncate:440 nofilter}{/if}
					</div>
		            <span class="" >
             			<a href="http://y.baidu.com/artist/{$item.artist_id}?pst=music_search" class="btn btn-a">
 							<span class="inner">
 			 				<span class="txt">访问 <b>Ta</b> 的音乐人主页</span>
							</span>
						</a>
        			</span>
				</div>				
			</div>
			{else}
			<div class="info">

				{button 
		            style = "b"
		            str = "收听 <b>Ta</b> 的电台"
		            icon = "fm"
		            isRightIcon = true
		            class = "btn-singer-fm"
		            href = "#"
		            tagAtt = "artist = '{$artist nofilter}' target='_blank'"
		        }
				<div class="artist-face cover-img">
					<a class="cover" href="/data/artist/redirect?id={$item.artist_id}" class="avatar">
						<img class="cover-img lazyload" src="{#PIC_PLACEHOLDER#}" org_src="{avatar user=$item type='middle'}" width="90" height="90" alt="{$item.singer}" />
					</a>
				</div>
				<div class="artist-info">
					<div class="name">
						<a href="/data/artist/redirect?id={$item.artist_id}"><span>{$item.singer|html_pixel_truncate:434 nofilter}</span></a>
					</div>
					<div class="detail clearfix">
						<span class="has-split">单曲：
							<a href="/data/artist/redirect?id={$item.artist_id}&type=song">{$item.song_num}</a>首
						</span>
						<span class="module-line"></span>
						<span {if $item.country} class="has-split" {/if}>专辑：
							<a href="/data/artist/redirect?id={$item.artist_id}&type=album">{$item.album_num}</a>张
						</span>
						{if $item.country}
						<span>
							<span class="module-line"></span>
							地区：<span>{$item.country|pixel_truncate:200}</span>
						</span>
						{/if}
					</div>
					<div class="intro">
						{if $item.artist_desc && $item.artist_desc !== 'None'}{$item.artist_desc|pixel_truncate:440 nofilter}{/if}
					</div>
					{if $item.song_num}
					<div class="artist-fold search-folder">
		                	<a href="javascript:void(0)" data-songlistexpand='{json_encode(["type"=>"artist",id=>$item.artist_id])}' class="songlist-fold-hook fold"><span class="action-hook">展开</span>热门歌曲<i></i></a>
		            </div>
		            {/if}
				</div>
			</div>
			<div class="songlist-expand"></div>
			{/if}
		</li>
		{/foreach}
	</ul>
	

</div>
{page_navigator total=$tplData.param.total size=$tplData.param.size start=$tplData.param.start 			url="/search/artist?key={$tplData.query|escape:'url' nofilter}&start=#start#&size=#size#"}
