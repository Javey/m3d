{extends file="ting.html.tpl"}


{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/topic.css{*version file='/static/css/topic.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="assign" append}
  {$navIndex='topic'}
{/block}
{block name="content_main"}

<div class="topic clearfix">
	<h1 class="music-seo">
		<strong>{$tplData.title}</strong>精选专题，<strong>{$tplData.title}</strong>独家策划，精彩演出，带给你全新音乐体验。
	</h1>
	<div class="topic-top ">
	    {block name="topic_top"}			
	    {/block}
	</div>	
	<div class="topic-body clearfix ">
	<div class="topic-left ">
		{block name="topic_left"}			
		{/block}
	</div>
	
	<div class="topic-right">
		{block name="topic_right"}			
		{/block}
	</div>
	</div>
	<div class="topic-bottom">
		{block name="topic_bottom"}			
		{/block}
	</div>	
</div>

<div id="share" class="share">
	<a id="share_up" class="share-up" href="javascript:void(0)"></a>
	<a id="share_weixin" class="share-weixin" href="javascript:void(0)"></a>
	<a id="bdshare" class="bdshare_t bds_tools_32 get-codes-bdshare">	
		<span class="bds_more"></span>
	</a>
	<a id="share_weibo" class="share-weibo" href="http://e.weibo.com/musicbaidu" target="_blank"></a>
	<div class="share-weixin-detail" id="share_weixin_detail"><div class="share-weixin-qr"></div><span>微信扫一扫<br/>精选音乐每日推送!</span></div>
</div>

{/block}
{block name="papa-foot"}<a href="javascript:void(0)" id="papa-follow">加啪啪好友<div class="follow-target"><div class="two-code two-code-papa"></div><span class="info">微信扫一扫<br/>精选音乐每日推送!</span></div></a>{/block}