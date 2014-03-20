{extends file="sns/sns.html.tpl"}
{block name="body_class_name" append}body-song-page{/block}
{block name="assign"}
	{$navIndex='singer'}
	{$showSubNav=false}
	{$song_info = $tplData.song_info}
	{$allArtist=explode(',', $song_info.author)}
	{$allArtistId=explode(',', $song_info.all_artist_ting_uid)}
	{$firstArtist=$allArtist[0]}
	{$firstArtistId=$allArtistId[0]}
	
	{if $song_info.resource_type ==0 || $song_info.resource_type ==1}
			{$copyrightData = true}
		{*{elseif $song_info.resource_type ==1}*}
			{*{$whiteData = true}*}
		{elseif $song_info.resource_type ==2}
			{$grayData = true}
		{elseif $song_info.resource_type ==3}
			{$blackData = true}
		{/if}

{/block}

{block name="title"}{$song_info.title}-{$song_info.author},{$song_info.title}在线试听,MP3免费下载,{$song_info.title}歌词下载{/block}
{block name='keywords'}"{$song_info.author}, {$song_info.title} ,音乐,歌曲,在线,试听,MP3,下载,歌词,免费"{/block}
{block name='description'}"{$song_info.author}单曲{$song_info.title},{$song_info.title}在线试听,{$song_info.title}歌词,{$song_info.title}在线试听,MP3免费下载"{/block}

{block name="css" append}   
 	<script type="text/javascript" src="/static/js/res2exe-img-1.0.1.js"></script>
	<link rel="stylesheet" type="text/css" href="/static/css/song_page.css{*version file='/static/css/song_page.css' prefix='?' suffix='.css'*}" />
    <!--[if IE 6]>
    <link rel="stylesheet" id="bd_app_dl" type="text/css" href="http://m.baidu.com/static/as/res2exe/external/apk2exe-img.css?v=0703" />
    <![endif]-->	   
{/block}

{block name="js" append}
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
    // var lyric_clip = '{$tplData.lrc_data|escape:"javascript" }';
    var bds_config = { 'bdText':'推荐一首{$song_info.author}的歌曲《{$song_info.title}》 （分享自@百度音乐）', 'bdPic':'{$tplData.song_info.pic_big}' };
	var tmpImg = new Image();
	tmpImg.src = "{$tplData.song_info.pic_big}";
    document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
</script>
<script type="text/javascript" src="/static/js/ting.apk.js"></script>
<script type="text/javascript" src="/static/js/ting.appdown.js"></script>
{/block}

{block name="js-page"}
<script type="text/javascript" src="/static/js/ZeroClipboard.js"></script>
<script type="text/javascript" src="/static/js/song_page.js{*version file='/static/js/song_page.js' prefix='?' suffix='.js'*}"></script>
<script type="text/javascript">
		initCollection({$song_info.song_id});
	
	$(document).bind("logined", function () {
	    initCollection({$song_info.song_id});
	});
	$(".ecom-ad").ecomad();
	// createClickMonkey("ting-music-songpage");
</script>
{/block}

{block name='js-monkey-pageid'}ting-muisc-songpage{/block}


{block name="sns_top"}
{include file="widget/music_icon/music_icon.html.tpl" inline}

{if $song_info.tags}
	{$tags = ''}
	{foreach $song_info.tags as $item}
		{if $item@last}
			{$tags = $tags|cat:$item}
		{else}
			{$tags = $tags|cat:$item|cat:","}
		{/if}
	{/foreach}
{/if}
   
{if $song_info.song_id}
	{$extraArgs = ["songid" => $song_info.song_id ,"songname" => $song_info.title, "songartistname" => $song_info.author , "songartistid" => $song_info.all_artist_id , "songalbumname" => $song_info.album_title , "songalbumid" => $song_info.album_id , "songtagname" => $tags]}
{else}
	{$extraArgs = []}
{/if}
{if  $song_info.song_id=='72624708'}
	{adm 
		id = "776443"
		class = "ad-banner ecomad-banner-loading"
		width = 960
		extraArgs = $extraArgs
	}
{else}
	{adm 
		id = "634"
		class = "ad-banner ecomad-banner-loading"
		width = 960
		extraArgs = $extraArgs
	}
{/if}
<div class="path_navigator clearfix clicklog-path-navigator">
	
	{include "widget/path_navigator/path_navigator.html.tpl" inline}

	{*************************************暂时先注释，RD获取性别数据需要额外查询一次表。   暂时有热门歌手替代
	{$area = $tplData.data.artistInfos.area}
	********************************************************************************************}
	{$sex = $tplData.song_info.artistGender}

	{$area = $tplData.song_info.artistArea}

	{if $area == 0 || $area == 1}
		{$areaLabel = "华语"}
		{$areaUrl = "cn"}
	{elseif $area == 2}
		{$areaLabel = "欧美"}
		{$areaUrl = "western"}
	{elseif $area == 3}
		{$areaLabel = "日韩"}
		{$areaUrl = "jpkr"}
	{else}
		{$areaLabel = "其他"}
		{$areaUrl = "other"}
	{/if}

	
	{**********************暂时先注释，RD获取性别数据需要额外查询一次表。   暂时有热门歌手替代
	***************************************************************************}
	{**首先判断区域如果区域不存在现实未知，如果为4 显示其他歌手**}
	{if !isset($area)}
		{$sexLabel = "未知"}
		{$sexUrl = ""}
	{elseif $area == 4}
		{$sexLabel = "歌手"}
		{$sexUrl = ""}
	{else}
		{if $sex == 0}
			{$sexLabel = "男歌手"}
			{$sexUrl = "male"}
		{elseif $sex == 1}
			{$sexLabel = "女歌手"}
			{$sexUrl = "female"}
		{elseif $sex == 2}
			{$sexLabel = "乐队组合"}
			{$sexUrl = "group"}
		{elseif $sex == 3}
			{$sexLabel = "歌手"}
			{if $area != 4} 
				{$sexUrl = "hot"}
			{else}
				{$sexUrl = ""}
			{/if}
		{/if} 
	{/if}

	{$pathList = [
		[
			"label" => "歌手",
			"link"  => "/artist"
		],
		[
			"label" => "{if $firstArtist}{$areaLabel}{$sexLabel}{else}未知{/if}",
			"link" => "{if $firstArtist}/artist/{$areaUrl}/{$sexUrl}{/if}"
		],
		[
			"label" => "{if $firstArtist}{$firstArtist|pixel_truncate:140 nofilter}{/if}",
			"link"  => "{if $firstArtist}{if $song_info.relate_status == 0 || $song_info.relate_status == 1}/artist/{$song_info.ting_uid}{else}/search?key={$firstArtist|escape:'url'}{/if}{/if}"
		],
		[
			"label" => "{$song_info.title|pixel_truncate:600 nofilter}"
		]
	]}
	{path_navigator pathList=$pathList}	
</div>
{** by rochappy  2012-12-19 单曲页banner广告暂时去掉 PM看去掉后的数据  待SVN上线  
<div class="song-banner ad-banner">
	{include file="widget/adm/adm.html.tpl" inline }
	{adm id ="491542" width = 960 }		
</div>
 **}
  {include file="widget/adm/adm.html.tpl" inline }
{/block}

{block name="sns_left"}
<div class="main-body-cont">
<div class="mod-song-info" {if $blackData} style="margin-bottom:50px;" {/if}>
	<h1 class="music-seo">
		{$song_info.author}歌曲{$song_info.title},{$song_info.title}在线试听,{$song_info.title}歌词下载,{$song_info.title}在线试听,MP3免费下载。百度音乐为你提供<strong>{$song_info.title}</strong>高品质的音乐享受。
	</h1>
	{include file="sns/song_page/mod_song_info.html.tpl"}

{if $tplData.lrc_data}
	{if !$blackData}
		<!--<div class="module-dotted"></div>-->
		{include file="sns/song_page/mod_song_lyric.html.tpl"}
	{/if}
{/if}

</div>
{if $tplData.qx_song_list}
	{if !$blackData}
			{include file="sns/song_page/mod_qunxin_song.html.tpl"}	
	{/if}
{/if}
{if $tplData.own_cover_info}
	{if !$blackData}
		<!--<div class="module-dotted"></div>-->
		{include file="sns/song_page/mod_my_versions.html.tpl"}
	{/if}
{/if}

{if $tplData.covert_info}
	{if !$blackData}
		<!--<div class="module-dotted"></div>-->
		{include file="sns/song_page/mod_other_versions.html.tpl"}
	{/if}
{/if}
{if $tplData.hot_song_list}
	{if !$blackData}
			{include file="sns/song_page/mod_hot_song.html.tpl"}	
	{/if}
{/if}
{block name="comment"}
{if $copyrightData}
	{include file="sns/song_page/mod_comment.html.tpl"}
{/if}

{/block}

{include file="sns/song_page/mod_cloud_tip.html.tpl"}
</div>
{/block}

{block name="sns_right"}
  {*{if $song_info.has_mv2 != 0 }*}
    {*{include file="sns/song_page/mod_right_mv.html.tpl" inline}*}
  {*{/if}*}
  {*{include file="sns/module/mod_right_music_clients.html.tpl" inline}*}
	{include file="sns/song_page/mod_sidebar_top.html.tpl" inline}
	{include file="sns/song_page/mod_right_ad.html.tpl" inline}
	{include file="sns/module/mod_right_recommend_links.html.tpl" inline}
{/block}
