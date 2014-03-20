{extends file="sns/sns.html.tpl"}
{block name="body_class_name" append}body-songlist-page{/block}
{block name="assign"}
{$navIndex='songlist'}
{$songlist_info = $tplData.data.playlist.info}

{/block}

{block name="title"}{$songlist_info.title}{/block}
{block name='keywords'}{$songlist_info.title},{$songlist_info.title}歌单，{$songlist_info.title}精选集，{$songlist_info.title}下载，百度音乐{/block}
{block name='description'}{$songlist_info.title},{$songlist_info.title}歌单，{$songlist_info.title}精选集，{$songlist_info.title}下载，尽在百度音乐-中国第一音乐门户{/block}

{block name="css" append}
	<link rel="stylesheet" type="text/css" href="/static/css/songlist.css{*version file='/static/css/songlist.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="js" append}
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
    var bds_config = { 'bdText':'推荐歌单《{$songlist_info.title}》 （分享自@百度音乐）', 'bdPic':'{$songlist_info.cover}' };
	var tmpImg = new Image();
	tmpImg.src = "{$songlist_info.cover}";
    document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
</script>
{/block}

{block name="js-page"}
<script type="text/javascript" src="/static/js/songlist.js{*version file='/static/js/songlist.js' prefix='?' suffix='.js'*}"></script>
{/block}

{block name='js-monkey-pageid'}ting-muisc-songlist{/block}

{block name="sns_body"}
		{include 'widget/song_list/song_list.html.tpl' inline}
    {$ids = []}
	{foreach $tplData.data.playlist.song_list as $songid}
	    {$idsArr = array_push($ids, $songid.song_id)}
	{/foreach} 		
<div class="main-body-cont">
 	<h1 class="music-seo">
		{$songlist_info.title}歌单
	</h1> 
	<div class="left-cont">
		<img src="{$songlist_info.cover|default:#SONGLIST_COVER_DEFAULT_280s#}" width="280" alt="">
		<ul class="base-info">
			{if  $songlist_info.author}
			<li class=""><span class="label">作者：</span><p class="info-cont">{$songlist_info.author}</p></li>
			{/if}
			{if  $songlist_info.tag_name}
			<li class=""><span  class="label">标签：</span><p class="info-cont">
            {foreach explode(',',$songlist_info.tag_name) as $item}
                <a href="/songlist/{$item}">{$item}</a>
            {/foreach}				
			</p></li>
			{/if}
		</ul>
		<div class="song-page-share clearfix js-log-sl-share" data-log-info={json_encode(["id"=>$songlist_info.playlist_id,"title" => $songlist_info.title])}>
			<div class="share-label">分享到： </div>

			<div id="bdshare" class="bds_tools bdshare_t" >
				<a class="bds_qzone"></a>
				<a class="bds_renren"></a>	
				<a class="bds_tqq"></a>	
				<a class="bds_tsina"></a>
				<span class="bds_more"></span>	
			</div>
		</div>		
	</div>
	<div class="right-cont">
		<div class="sonlist-info">
			<div class="sonlist-name">
				<h2>{$songlist_info.title}</h2>
				<span class="col-status">
					{if $songlist_info.listen_count}
					<span class="listen-num"><i></i>{$songlist_info.listen_count}</span>
					{/if}
					{if  $songlist_info.collect_count}
					<span class="collect-num"><i></i>{$songlist_info.collect_count}</span>
					{/if}
				</span>
			</div>
			{if $songlist_info.desc}
			<p class="col-desc">
				歌单简介：{$songlist_info.desc}
			</p>
			{/if}
			<ul class="col-btns">
				<li class="col-play"><a href="#"><span><i class="btn-icon"></i>播放歌单</span></a></li>
				<li class="col-add"><a href="#"><span><i class="btn-icon"></i>添加到播放列表</span></a></li>
        {*歌单统计需求*}
        {$logData = "`$songlist_info.playlist_id`_`$songlist_info.title`||playlistAdd"}
				<li class="col-collect"><a href="#" data-playlist="{json_encode(["moduleName"=>$logData,"listid"=>"`$songlist_info.playlist_id`","type"=>"songlist","title"=>"`$songlist_info.title`" ,"ids"=> implode(",",$ids)])}"><span><i class="btn-icon"></i>收藏为歌单</span></a></li>
				<li class="col-down"><a class="down-selected-hook" href="#"><span><i class="btn-icon"></i>批量下载</span><i class="btn-icon col-vip-icon"></i></a></li>
			</ul>
		</div>
		<div class="col-song-list" > 
		{song_list moduleName = "colsonglist" isDisplayInedexNum = true indexWidth =35 btnPos = "none" total=count($tplData.data.playlist.song_list) songData = $tplData.data.playlist.song_list colCheck =false songWidth = 280  funIcon=["play","add","download","collect"] appendix=false}
		</div>	
		{if $tplData.data.relevant.result}
		<div class="other-cont">
			<h2>相似歌单</h2>
			<ul class="other-songlist">
				{foreach $tplData.data.relevant.result as $item}
				{if $item@index<4}
	<li class="{if $item@index==3}last{/if}" data-log="{json_encode(["page"=>"c_songlist_d","type"=>"click","pos"=>"commend","listid"=>$songlist_info.playlist_id,"method"=>$item.m,"slid_click"=>$item.playlist_id])}">
					<a href="/songlist/{$item.playlist_id}"><img width="150" height="150" src="{$item.pic_w150_h150|default:#SONGLIST_COVER_DEFAULT_150s#}" alt="{$item.title}"></a>
					<a href="/songlist/{$item.playlist_id}">{$item.title|pixel_truncate:140}</a>
				</li>
				{/if}
				 {/foreach}	
			</ul>
		</div>	
		{/if}	
	</div>

</div>

{/block}


