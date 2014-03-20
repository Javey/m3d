{extends file="plaza/plaza.html.tpl"}

{block name="title"}{$menu[$artistSelected]}{/block}

{block name='keywords'}“{$menu[$artistSelected]}，免费音乐，MV，在线听歌，MP3下载，百度音乐”{/block}
{block name='description'}“百度音乐提供{$menu[$artistSelected]}的专辑,演唱会专辑,歌曲,MV，图片,资料。免费试听，MP3免费下载，尽在百度音乐。”{/block}

{block name="body_class"}
class="channel artist-channel"
{/block}
{block name="assign" append}
	{$navIndex='singer'}
	{$menu=[
		"all-all"=>"全部歌手",
		"cn-hot"=>"华语热门歌手",
		"cn-male"=>"华语男歌手",
		"cn-female"=>"华语女歌手",
		"cn-group"=>"华语乐队组合",
		"western-male"=>"欧美男歌手",
		"western-hot"=>"欧美热门歌手",
		"western-female"=>"欧美女歌手",
		"western-group"=>"欧美乐队组合",
		"jpkr-male"=>"日韩男歌手",
		"jpkr-female"=>"日韩女歌手",
		"jpkr-hot"=>"日韩热门歌手",
		"jpkr-group"=>"日韩乐队组合",
		"other-other"=>"其他歌手",
		"baidu-musician"=>"百度原创音乐人"
	]}
	{**if $tplData.area && $tplData.gender**}
		{$artistSelected = "{$tplData.area}-{$tplData.gender}"}
	{**else**}
		{**$artistSelected = "index"**}
	{**/if**}

	

	{**定义常量用于分别显示4列或5列数据,并对字符截取长度作相应改变**}
	{if $tplData.area == "western"}
		{$COLUMN = 4}
		{$TRUNCATE = 145}
		{$TRUNCATE_L = 150}
	{else}
		{$COLUMN = 5}
		{$TRUNCATE = 125}
		{$TRUNCATE_L = 130}
	{/if}
{/block}
{block name="body_class_name"}
	channel
{/block}

{block name="content_main"}
	<h1 class="music-seo">{$menu[$artistSelected]}</h1>
	{include file="widget/adm/adm.html.tpl" inline}
	{adm 
	    id = "622"
	    class = "ad-banner ecomad-banner-loading"
	    width = "960"
	}
	<div class="sidebar" monkey="sidebar">
		{include file="plaza/artist/sidebar.html.tpl"}
	</div>

	{block name="main_body"}
	{/block}
{/block}

{block name="js-page" append}
{if $tplData.area == "all" && $tplData.gender == "all"}
	{$monkey = "index"}
	{else}
	{$monkey = $artistSelected}
{/if}
{if $tplData.area == "all" && $tplData.gender == "all"}
	{$monkey = "index"}
	{else}
	{$monkey = $artistSelected}
	{/if}

<script type="text/javascript">
	$(".ecom-ad").ecomad();
	
  // createClickMonkey("ting-music-plaza-artist-{$monkey}");
</script>
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-artist-{$monkey}{/block}
