<ul class="privilege-list">
	<li class="item bb-dotimg">
		<div class="label">权限到期日：</div>
		<div class="item-info">
			<span class="power-time">{$serviceinfo.down.start_time|date_format:'%Y.%m.%d'} 至  {$serviceinfo.down.end_time|date_format:'%Y.%m.%d'}</span> {if $serviceinfo.down.time_rest} <span class="maturity-tips">还有{$serviceinfo.down.time_rest}到期</span>{/if}{button href = "/home/payment" class="renewals" style="a" str="续期" }
		</div>
	</li>
	<li class="item bb-dotimg">
		<div class="label">本期已下载数量：</div>
		<div class="item-info">
			<p>本月共 150 首音乐下载权限，已下载 {$tplData.data.serviceused.used} 首，每个月 {$serviceinfo.down.start_time|date_format:'%d'} 日重置</p>
			<div class="space-size clearfix">
				<div class="start-time">{$tplData.data.serviceused.start_down|date_format:'%Y.%m.%d'}</div>
				<div class="progress-bar">
					{**
						used 用户下载的歌曲总数
						quota 系统自动分配的固定空间大小 默认150
					**}
					{$max = 460}
					{$user_size = $tplData.data.serviceused.used}
					{$fixed_size = $tplData.data.serviceused.quota}
					{if $user_size <  $fixed_size}
						{$barWidth = ($max / $fixed_size) * $user_size}
					{else}
						{$barWidth = $max}
					{/if}
					<div class="progress" style="width:{$barWidth}px;"></div>
					<div class="progress-text"><em>{$user_size}</em> / {$fixed_size}</div>
				</div>
				<div class="end-time">{$tplData.data.serviceused.end_down|date_format:'%Y.%m.%d'}</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="label">本期已下载历史：</div>
		<div class="item-info">
			<div class="down-history">
				<ul class="title clearfix">
					<li>
						<div class="index">序号</div>
						<div class="song-name">歌曲 </div>
						<div class="down-time">下载时间</div>
						<div class="remark">备注</div>
					</li>
				</ul>
				<ul class="down-list clearfix" {if $user_size < 11} style="height:auto;"{/if}>
					{if $tplData.data.serviceused.songs}
					{foreach $tplData.data.serviceused.songs as $item}
					{song_link_url_plugin song=$item.info linkWithNoSongId="#" songLinkUrl=theSongLink}
					<li {if ($item@index+1) %2 == 0}class="even"{/if}>
						<div class="index">{if $item@index+1 <10}0{/if}{$item@index+1}</div>
						<div class="song-name"><a href="{$theSongLink}">{$item.info.title|pixel_truncate:120}</a> - {author_list source='album' releaseStatus=$item.info.relate_status ids=$item.info.all_artist_ting_uid  names=$item.info.author width=108} </div>
						<div class="down-time">{date('Y-m-d H:i:s',$item.create_time)}</div>
						<div class="remark">{if $item.fee == 1}超出包月额度下载{else}-{/if}</div>
					</li>
					{/foreach}
					{else}
					<li class="c9">
						<div class="index"> - </div>
						<div class="song-name"> - </div>
						<div class="down-time"> - </div>
						<div class="remark"> - </div>
				</li>
					{/if}
				</ul>
			</div>
		</div>
	</li>
</ul>
