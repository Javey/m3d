{extends file="sns/sns.html.tpl"}

{block name="assign" append}{$navIndex='singer'}{$secNavIndex='people_artist'}{$showSubNav=true}{$showBackTing=false}{/block}
{block name="title"}{$tplData.artist_info.name|default:$ownerInfo.realname|default:$ownerInfo.nick}的相似艺人{/block}
{block name='keywords'}"{$tplData.artist_info.name|default:$ownerInfo.realname|default:$ownerInfo.nick}"{/block}
{block name='description'}"{$tplData.artist_info.name|default:$ownerInfo.realname|default:$ownerInfo.nick}的相似艺人"{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/people_artist.css{*version file='/static/css/people_artist.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="js-page"}
<script type="text/javascript" src="/static/js/artist_similar.js{*version file='/static/js/artist_similar.js' prefix='?' suffix='.js'*}"></script>
{/block}

{block name='js-monkey-pageid'}ting-music-artist-similar{/block}

{block name="sns_top"}
	<div class="music-seo">
		<h1>{$tplData.artist_info.name}最好听的歌曲、{$tplData.artist_info.name}的最新专辑、{$tplData.artist_info.name}的MV、{$tplData.artist_info.name}演唱会,在线试听,MP3歌曲免费下载,{$tplData.artist_info.name}简介、图片、资料,尽在百度音乐。</h1>
	</div>
	{include file="widget/adm/adm.html.tpl" inline }
	{** 针对王菲首发，临时修改王菲艺人页上的广告 **}
	{if $tplData.artist_info.ting_uid == 45561} 
		<a href="http://music.baidu.com/topic/cooperation/wangfeizhiqingchun?pst=artist_banner" target="_blank" style="display: block; width: 960px; height: 90px; padding: 0 10px 15px;">
			<img src="/static/images/wangfei_young.jpg" width="960px" height="90px" />	
		</a>
	{else}
		{adm 
			id = "633"
			class = "ad-banner ecomad-banner-loading"
			width = 960
		}
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
		],
		[	"label" =>"{$ownerInfo.nick}",
			"link"  => "/artist/{$ownerInfo.ting_uid}"
		]
	]}

	{$t = array_push( $pathList, [
		"label" => "相似歌手"
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
{include file="sns/people_artist/mod_artist_similar.html.tpl"}
</div>
{/block}

{block name="sns_right"}
	{include file="sns/song_page/mod_sidebar_top.html.tpl" inline}
{/block}
