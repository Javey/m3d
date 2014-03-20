{extends file="plaza/plaza.html.tpl"}
{block name="title"}音乐专题{/block}
{block name='keywords'}"音乐,百度音乐,专题,热门专题,音乐专题,活动,独家策划,情感主题,精彩演出"{/block}
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
class="topic-index"
{/block}
{block name="widget_pack_js"}
{/block}
{block name="js" append}
<script type="text/javascript" src="/static/js/topic_index.js{*version file='/static/js/topic_index.js' prefix='?' suffix='.js'*}"></script>
{**
<script type="text/javascript" _xcompress="true">
    createClickMonkey("ting-music-plaza-topic-index");
</script>
**}
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-topic-index{/block}

{block name="body_fixed_pop"}
{if $tplData.categoryList}
<div class="cate-menu" monkey="cate-menu">
	{foreach $tplData.categoryList as $item}
		{if count($item.data)}
		<a hidefocus = "true" href="">{$item.name}</a>
		{/if}
		{/foreach}
		{**<span class="c9">Hi,到底部喽!</span>**}
	</div>
{/if}
{/block}
{block name="content_main"}
<h1 class="music-seo">
   	<strong>音乐</strong>,<strong>百度音乐</strong>,<strong>音乐专题</strong>,<strong>专题频道</strong>,<strong>热门专题</strong> 
</h1>	
	{include file="plaza/topic/mod_topic.html.tpl"}
{/block}
{block name="papa-foot"}<a href="javascript:void(0)" id="papa-follow">加啪啪好友<div class="follow-target"><div class="two-code two-code-papa"></div><span class="info">微信扫一扫<br/>精选音乐每日推送!</span></div></a>{/block}