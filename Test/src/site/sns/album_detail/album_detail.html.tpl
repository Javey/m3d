{extends file="sns/sns.html.tpl"}
{block name="assign"}
{$navIndex='singer'}
{$showSubNav=false}
{/block}
{block name="title"}{$tplData.data.album.title}-{$tplData.data.album.author}专辑{/block}
{block name='keywords'}"{$tplData.data.album.author},{foreach $tplData.data.album.artistInfos as $item}{if $item@first && $item.aliasname}{$item.aliasname},{/if}{/foreach}{$tplData.data.album.title},专辑,在线试听,MP3下载，歌词下载"{/block}
{block name='description'}"{$tplData.data.album.title},{$tplData.data.album.author},专辑,歌曲下载,在线试听,MP3下载,歌词下载{foreach $tplData.data.album.artistInfos as $item}{if $item@first && $item.aliasname},{$item.aliasname}{/if}{if $item@first && $item.translatename},（{$item.translatename}）{/if}{/foreach}"{/block}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/mv_album_detail.css{*version file='/static/css/mv_album_detail.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="js" append}
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
var albumName = "{$tplData.data.album.title}" || "";
var bds_config = { 
	'bdText':'推荐一张{$tplData.data.album.author}的专辑《{$tplData.data.album.title}》 （分享自@百度音乐）',
	"bdPic" : "{$tplData.data.album.pic_big|default:#ALBUM_COVER_DEFAULT_130#}"
}
document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
</script>
<script type="text/javascript" src="/static/js/ting.apk.js"></script>
<script type="text/javascript" src="/static/js/ting.appdown.js"></script>
{/block}

{block name="js-page"}
<script src="/site/sns/album_detail/album_detail.js" type="text/javascript" _xbuilder="true" _xcompress="true"></script>
<script type="text/javascript" _xcompress="true">
	
    // createClickMonkey("ting-music-album");
</script>
{/block}
{block name='js-monkey-pageid'}ting-muisc-album{/block}

{block name="sns_top"}
  {if $tplData.ownerInfo.ting_uid=='1226'}
    <div class="artist-banner">
      <a href="/topic/cooperation/ershourose?pst=artist" target="_blank"><img src="http://music.baidu.com/cms/huodongbanner.jpg"></a>
    </div>
  {else}
  {*原始广告策略*}
    {if $tplData.data.album.album_id}
      {$albumsongname = ""}
      {$albumsongid = ""}
      {foreach $tplData.data.album.songList as $item}
        {if $item@last}
          {$albumsongname = $albumsongname|cat:$item.title}
          {$albumsongid = $albumsongid|cat:$item.song_id}
        {else}
          {$albumsongname = $albumsongname|cat:$item.title|cat:","}
          {$albumsongid = $albumsongid|cat:$item.song_id|cat:","}
        {/if}
      {/foreach}
      {$extraArgs = ["albumartistname" => $tplData.data.album.author, "albumartistid" =>$tplData.data.album.all_artist_id , "albumname"=>$tplData.data.album.title , "albumid"=> $tplData.data.album.album_id,  "albumsongid" => $albumsongid ]}
    {else}
      {$extraArgs = []}
    {/if}
    {if $tplData.data.album.album_id=='83409992'}
	    {adm
	    id = "776444"
	    class = "ad-banner ecomad-banner-loading"
	    width = 960
	    extraArgs = $extraArgs
	    }    
    {else}
	    {adm
	    id = "646866"
	    class = "ad-banner ecomad-banner-loading"
	    width = 960
	    extraArgs = $extraArgs
	    }
    {/if}
  {/if}
<div class="music-seo">
	<h1>{$tplData.data.album.title},{$tplData.data.album.author}最新专辑,{$tplData.data.album.title}专辑歌曲下载,在线试听,MP3歌曲免费下载,歌词下载</h1>
</div>
<div class="path_navigator clearfix">
{include file="widget/path_navigator/path_navigator.html.tpl" inline}
	{$allArtist=explode(',', $tplData.data.album.author)}
	{$firstArtist=$allArtist[0]}

	{foreach $tplData.data.album.artistInfos as $item}
	{if $item@index == 0}
		{$area = $item.area}
	{/if}
	{/foreach}
	{$sex = $tplData.ownerInfo.sex}

	
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
			"label" => "{if $firstArtist && $tplData.ownerInfo }{$areaLabel}{$sexLabel}{else}未知{/if}",
			"link" => "{if $firstArtist && $tplData.ownerInfo}/artist/{$areaUrl}/{$sexUrl}{/if}"
		],[
			"label" => "{if $firstArtist}{$firstArtist}{/if}",
			"link"  => "{if $firstArtist}{if $tplData.data.album.relate_status == 0}/artist/{$tplData.data.album.artist_ting_uid}{else}/search?key={$firstArtist|escape:'url'}{/if}{/if}"
		],
		[
		"label" => "{$tplData.data.album.title|pixel_truncate:200 nofilter}"
		]
	]}
	
	{path_navigator pathList=$pathList}

</div>
{/block}
{block name="sns_nav"}
{/block}
{block name="sns_left"}
		{include file="sns/album_detail/main-body.html.tpl" funIcon=["play","add","download"] funBtn=["play","add", "collect","down"]}
{/block}

{block name="sns_right"}
{include file="sns/album_detail/sidebar.html.tpl"}
{/block}
