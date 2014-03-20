{extends file="sns/sns.html.tpl"}

{block name="assign" append}{$navIndex='singer'}{$secNavIndex='people_artist'}{$showSubNav=true}{$showBackTing=false}{/block}
{block name="title"}{$tplData.artist_info.name|default:$ownerInfo.realname|default:$ownerInfo.nick}的歌曲,{$tplData.artist_info.name|default:$ownerInfo.realname|default:$ownerInfo.nick}的专辑,{$tplData.artist_info.name|default:$ownerInfo.realname|default:$ownerInfo.nick}最好听的歌{/block}
{block name='keywords'}"{$tplData.artist_info.name},{if $tplData.artist_info.aliasname}{$tplData.artist_info.aliasname},{/if}{if $tplData.artist_info.translatename}（{$tplData.artist_info.translatename}）,{/if}专辑,歌曲,MV,演唱会,资料,简介,在线听歌,试听,MP3歌曲免费下载,好听的歌"{/block}
{block name='description'}"{$tplData.artist_info.name}的歌曲、{$tplData.artist_info.name}的专辑、{$tplData.artist_info.name}的MV、{$tplData.artist_info.name}演唱会,在线试听,MP3歌曲免费下载,{$tplData.artist_info.name}资料,简介,好听的歌,免费听歌{if $tplData.artist_info.aliasname},{$tplData.artist_info.aliasname}{/if}{if $tplData.artist_info.translatename},（{$tplData.artist_info.translatename}）{/if}"{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/people_artist.css{*version file='/static/css/people_artist.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="js-page"}
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
var bds_config = {
	'bdText':'推荐{$tplData.artist_info.name}的歌 （分享自@百度音乐）',
	"bdPic" : "{$ownerInfo.avatar_middle|default:#ARTIST_DEFAULT_130b#}"
};
// add rochappy 存储热度条最大值
var hotbarMax = {if $tplData.artist_info.top_song_hot}{$tplData.artist_info.top_song_hot}{else}0{/if} ;
var artistname = "{$tplData.artist_info.tiebaName|default:$ownerInfo.nick}";




document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
$(".ecom-ad").ecomad();
</script>
<script type="text/javascript" src="/static/js/people_artist.js{*version file='/static/js/people_artist.js' prefix='?' suffix='.js'*}"></script>
{**
<script type="text/javascript" _xcompress="true">	 
    createClickMonkey("ting-music-artist");
</script>
**}

{/block}

{block name='js-monkey-pageid'}ting-muisc-artist{/block}

{block name="sns_top"}
	<div class="music-seo">
		<h1>{$tplData.artist_info.name}最好听的歌曲、{$tplData.artist_info.name}的最新专辑、{$tplData.artist_info.name}的MV、{$tplData.artist_info.name}演唱会,在线试听,MP3歌曲免费下载,{$tplData.artist_info.name}简介、图片、资料,尽在百度音乐。</h1>
	</div>
	{include file="widget/adm/adm.html.tpl" inline }
  {if $tplData.artist_info.ting_uid=='1226'}
    <div class="artist-banner">
      <a href="/topic/cooperation/ershourose?pst=artist"  target="_blank"><img src="http://music.baidu.com/cms/huodongbanner.jpg"></a>
    </div>
  {else}
    {if $tplData.artist_info.ting_uid}
      {$extraArgs = ["artistid" => $tplData.artist_info.ting_uid ,"artistname" => $ownerInfo.nick]}
    {else}
      {$extraArgs = []}
    {/if}
    {if  $tplData.artist_info.ting_uid=='8477'}
	    {adm
	    id = "776434"
	    class = "ad-banner ecomad-banner-loading"
	    width = 960
	    extraArgs = $extraArgs
	    }    
    {else}
	    {adm
	    id = "633"
	    class = "ad-banner ecomad-banner-loading"
	    width = 960
	    extraArgs = $extraArgs
	    }
    {/if}
  {/if}

  <div class="path_navigator clearfix clicklog-path-navigator">
	
	{include "widget/path_navigator/path_navigator.html.tpl" inline}
	
	{$area = $tplData.artist_info.area}
	{$sex = $ownerInfo.sex}


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
	{$pathList = [
		[
			"label" => "歌手",
			"link"  => "/artist"
		],
		[
			"label" => "{$areaLabel}{$sexLabel}",
			"link" => "/artist/{$areaUrl}/{$sexUrl}"
		]
	]}

	{$t = array_push( $pathList, [
		"label" => "{$ownerInfo.nick}"
	])}

	
	{path_navigator pathList=$pathList}
	
</div>
	{**by rochappy remove 商业广告占据了此位置
		{if $tplData.artist_info.advertise_id}
			<div class="artist-banner">
				
			</div>
		{/if}
	**}
{/block}
{block name="sns_left"}
<div class="main-body-cont">
{include file="sns/people_artist/mod_info.html.tpl"}
{include file="sns/people_artist/mod_works.html.tpl" funIcon=["play","add","download","collect"] funBtn=["play","add","collect","down"] works=["songs","albums", "mvs", "photos"] inline}
</div>
{/block}

{block name="sns_right"}
	{include file="sns/people_artist/sidebar.html.tpl" inline}
{/block}
