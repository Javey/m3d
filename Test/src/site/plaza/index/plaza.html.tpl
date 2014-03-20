{extends file="plaza/plaza.html.tpl"}
{block name="assign" append}
  {**
    {$plazaNav='plaza'}
  **}
{include file="widget/adm/adm.html.tpl" inline}
{/block}
{block name="body_class_name"}music-home{/block}


{block name="base_css"}
{** add rochappy 为首页定制化样式-[性能优化] 修改请在/static/css相应的文件文件下修改 **}
{/block}



{block name="widget_pack_js"}
{** add rochappy 为首页定制化样式-[性能优化] 修改请在/static/js相应的文件文件下修改 **}
{/block}


{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/plaza_index.css" />
{/block}


{block name="js-page"}
<!--广告位代码放在页面最后-->
<script type="text/javascript" src="http://cbjs.baidu.com/js/m.js"></script>
<script type="text/javascript" src="/static/js/plaza_index.js"></script>
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-index{/block}

{block name="alltitle"}{if $isHao123}音乐_hao123上网导航{else}百度音乐-听到极致{/if}{/block}
{block name="plaza_top"}
{/block}
{block name="plaza_left"}
   {include file="plaza/index/mod_image_slider.html.tpl"}
	{include file="plaza/index/mod_newalbum.html.tpl"}
    <div class="module top clearfix">
        <div class="clearfix top-wrap">
            {include file="plaza/index/mod_newtop.html.tpl"}
            {include file="plaza/index/mod_hottop.html.tpl"}
            {include file="plaza/index/mod_movie.html.tpl"}
            {**include file="plaza/index/mod_mediatop.html.tpl"**}
        </div>
	       {*{include file="plaza/index/mod_ad_left.html.tpl"}*}
      <div class="ad ecomad-banner-loading" style="width: 728px" id="adm-main-left"></div>
		<div class="clearfix top-wrap">
			{**
				{include file="plaza/index/mod_movie.html.tpl"}
			**}
			{include file="plaza/index/mod_oldsong.html.tpl"}
			{include file="plaza/index/mod_netsong.html.tpl"}
      {include file="plaza/index/mod_artisttop.html.tpl"}
			
		</div>
	</div>
    <div id="plaza-song-list" class="async-module css-loading" data-load-module="plaza/song_list"></div>
    <div id="plaza-baidu-artist" class="async-module css-loading" data-load-module="plaza/baidu_artist"></div>
    {*{include file="plaza/index/mod_songlist.html.tpl"}*}
    {*{include file="plaza/index/mod_baidu_artist.html.tpl"}*}

    <div id="plaza-mv" class="async-module css-loading" data-load-module="plaza/mv"></div>
    <div id="plaza-kr" class="async-module css-loading" data-load-module="plaza/kr"></div>
   
    <div id="plaza-film" class="async-module css-loading" data-load-module="plaza/film"></div>
    <div id="plaza-topic" class="async-module css-loading" data-load-module="plaza/topic"></div>
    {* async module load by wangyu 20130910 *}
    {*{include file="plaza/index/mod_mv.html.tpl"}*}
    {*{include file="plaza/index/mod_film.html.tpl"}*}
    {*{include file="plaza/index/mod_topic.html.tpl"}*}

{/block}
{block name="plaza_right"}
  {include file="plaza/index/mod_play_entry.html.tpl"}
  {* 预加载策略 *}
  {*{adm id = "727409" width="200" height="200"}*}
  {* 延迟加载策略 *}
  <div id="adm-main-right" class="ecomad-banner-loading">
  </div>
  {*右侧广告结束*}
  {include file="plaza/index/mod_tag.html.tpl"}
  {**include file="plaza/index/mod_focus.html.tpl"**}
  {include file="plaza/index/mod_fm.html.tpl"}
  {include file="plaza/index/mod_hotsinger.html.tpl"}
  {**
  {include file="plaza/index/mod_control_user.html.tpl"}
  **}
  {include file="plaza/index/mod_ad_right.html.tpl"}
{/block}
{block name="plaza_bottom"}

<div class="ecom-banner">
	<div class="module-line module-line-bottom"></div>
  <div style="width: 960px; margin: 0 auto;" class="ad-banner" id="adm-bottom"></div>
{*{adm id = "621"*}
     {*class="ad-banner"*}
     {*width = "960"*}
 {*}*}
</div>
{/block}

