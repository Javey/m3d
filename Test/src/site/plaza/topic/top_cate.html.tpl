{extends file="plaza/plaza.html.tpl"}
{block name="title"}{$tplData.data.title}_音乐专题{/block}
{block name='keywords'}"音乐,百度音乐,专题,热门专题,音乐专题,活动,{$tplData.data.title}专题"{/block}
{block name='description'}"百度音乐是中国第一音乐门户，为你提供海量正版高品质音乐，最权威的音乐榜单，最快的新歌速递，最契合你的主题电台，最人性化的歌曲搜索，让你更快地找到喜爱的音乐，带给你全新音乐体验。"{/block}

{block name="assign" append}
	{$navIndex = 'topic'}
    {**
      {$plazaNav = "diy"}
    **}
{/block}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/topic_index.css{*version file='/static/css/topic_index.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="body_class"}
class=" topic-cate-page"
{/block}
{block name="widget_pack_js"}
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-topic-cate-{$tplData.data.type}{/block}





{block name="content_main"}
<h1 class="music-seo">
   	<strong>音乐</strong>,<strong>百度音乐</strong>,<strong>{$tplData.data.title}</strong>,<strong>音乐专题</strong>,<strong>专题</strong>,<strong>热门专题</strong>
</h1>	
{block name="plaza-top"}
{include file="widget/music_icon/music_icon.html.tpl" inline}
<div class="path_navigator clearfix clicklog-path-navigator">
	{include "widget/path_navigator/path_navigator.html.tpl" inline}
	{$pathList = [
		[
			"label" => "专题",
			"link"  => "/topic"
		],
		[
			"label" => "{$tplData.data.title}"
		]
	]}
	{path_navigator pathList=$pathList}	
</div>
{/block}
	<div class="main-body">
		<div class="main-body-cont">
			{include file="plaza/topic/main-body.html.tpl"}
		</div>
	</div>

	<div class="sidebar">
		{include file="plaza/topic/sidebar.html.tpl"}
	</div>
{/block}
