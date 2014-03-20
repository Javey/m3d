{extends file="plaza/plaza.html.tpl"}
 {block name="body_class"}
class="tag-body"
{/block}
 {block name="assign"}{**用来放assign数据**}
    {$navIndex='tag'}
 {/block}
{block name="title"}音乐分类{/block}

{block name='keywords'}音乐分类，百度音乐{/block}
{block name='description'}百度音乐音乐歌曲分类，为你提供不同的“曲风流派、心情感受、主题场合、语言地域、乐器演奏”的歌曲列表，中国风、伤感、怀旧、空间背景音乐、轻音乐，mp3试听下载{/block}

{block name="css"}
<link rel="stylesheet" type="text/css" href="/static/css/mv_tag.css{*version file='/static/css/mv_tag.css' prefix='?' suffix='.css'*}" />
 {/block}	

{block name="js" append}
<script type="text/javascript" _xcompress="true">
  $(".ecom-ad").ecomad();
    // createClickMonkey("ting-music-plaza-tag-index");
</script>
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-tag-index{/block}

{block name="content_main"} 
  <!-- music seo begin -->
  <div><h1 class="music-seo">歌曲分类</h1></div>
  <!-- music seo end-->
    {**<div class="ecom-ad ad-banner ecomad-banner-loading" data-id ="631"></div>**}
	{adm
		id = "652797"
		class = "ad-banner ecomad-banner-loading"
		width = "960"
	}
  <div class="main-body">
    <div class="main-body-cont">
      {include file="plaza/tag/main-body.html.tpl"}
    </div>
  </div>

  <div class="sidebar" monkey="sidebar">
    {include file="plaza/tag/sidebar.html.tpl"}
    {include file="plaza/tag/mod_topic.html.tpl"}
    {include file="sns/module/mod_right_recommend_links.html.tpl" inline}
  </div>
{/block}
