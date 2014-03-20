{extends file="topic/topic.html.tpl"}
{block name="assign" append}
{include file="topic/tpl/coopconfig.html.tpl"}
{/block}
{block name='title'}
{$tplData.title}-专题
{/block}

{block name='keywords'}"{$tplData.title}专题，{$tplData.title} 歌曲首发,热门专题,音乐专题,活动,独家策划,情感主题,精彩演出"{/block}
{block name='description'}"{$tplData.title}专题，{$tplData.title} 歌曲首发,为你提供热门专题,音乐专题,活动,独家策划的歌曲专题，带给你全新音乐体验。"{/block}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/cooperate.css{*version file='/static/css/cooperate.css' prefix='?' suffix='.css'*}" />
<style type="text/css">

/*网站背景 模块*/
/*.music-main{ background:url( {$tplData.bg_x_img} ) repeat-x #{$tplData.bgcolor}; }*/   /*配置网站线性渐变图和颜色*/   /*此值提供给ipad端 , PC端不用此背景图*/
.music-main{ background: #{$tplData.bgcolor}; }   /*配置网站线性渐变图和颜色*/

/*banner 模块*/
.music-main-body { background:url({$tplData.bg_img} ) no-repeat center 0; }  /*配置banner图片*/

.topic-banner{ }/*配置banner高度*/


/*module 模块*/
.module{ background:#{$tplData.column_bg_color}; }  /*配置模块背景颜色*/
.module .mod-head{  position:relative; }
.module .mod-body{ background:#fff; }  /*配置模块内容层颜色*/
.module .mod-title{   font-size:14px;color:#{$tplData.column_title_color}; }  /*配置模块标题字号，颜色*/
.mod-head .more,
.mod-head .more:hover{ color:#{$tplData.column_title_color};}

/*头部活动信息说明 模块*/
.mod-intro .bg{ opacity:0.9;filter:Alpha(Opacity=90); }  /*配置背景，透明度*/
.mod-intro .mod-head .bg{ opacity:0.25;filter:Alpha(Opacity=25);}  /*配置背景，透明度*/
</style>
<link rel="stylesheet" type="text/css" href="http://ting.baidu.com/widget/topic/skins/topic/mbox.css?v=20120912" media="all" />
<link rel="stylesheet" type="text/css" href="http://ting.baidu.com/cms/topics/tpl_topic/css/topic_{$tplData.url}.css?{$smarty.now}" media="all" />
{/block}
{block name="topic_top"}
{if $tplData.attr.Top}
{foreach $tplData.attr.Top as $item}
	{include file=$module[$item.mid]["path"] modData=$item index=$item@index class=$module[$item.mid]["className"]}
{/foreach}
{/if}
{/block}	


{**  topic 左侧模块 **}
{block name="topic_left"}
{if $tplData.attr.Left}
{foreach $tplData.attr.Left as $item}
	{include file=$module[$item.mid]["path"] modData=$item index=$item@index class=$module[$item.mid]["className"]}
{/foreach}	
{/if}
{/block}

{**  topic 右侧模块 **}
{block name="topic_right"}
{****}
<div class="mobileapp-down clearfix"><a href="http://music.baidu.com/mobile?fr=zhuanti" target="_blank"><i></i></a></div>
{if $tplData.attr.Right}
{foreach $tplData.attr.Right as $item}
	{include file=$module[$item.mid]["path"] modData=$item index=$item@index class=$module[$item.mid]["className"]}
{/foreach}	
{/if}

{/block}

{block name="topic_bottom"}
{if $tplData.attr.Bottom}
{foreach $tplData.attr.Bottom as $item}
	{include file=$module[$item.mid]["path"] modData=$item index=$item@index class=$module[$item.mid]["className"]}
{/foreach}	
{/if}
{/block}
{block name="js" append} 
<script type="text/javascript" src="/static/js/swf_baidu.js" _xbuilder="true" _xcompress="true"></script>
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript" src="/static/js/cooperate.js{*version file='/static/js/cooperate.js' prefix='?'  suffix='.js'*}"></script>
<script type="text/javascript" src="http://ting.baidu.com/cms/topics/tpl_topic/js/topic_{$tplData.url}.js?{$smarty.now}"></script>
<script type="text/javascript">
var topic_info={};
topic_info.id={$tplData.sid};
createClickMonkey("ting-music-plaza-topic-{$tplData.url}");
$.cookie('event_reg_from',"{$tplData.url}",{ 'expires': 0.1, path:'/' });

{if $tplData.thumb_img}
var bds_config = {
	'bdText':'推荐一个超赞的音乐专题 —— 《{$tplData.title}》 （来自@百度音乐 ）',
	'bdPic':'{$tplData.thumb_img}' 
};
{/if}
</script>

{/block}


{block name='js-monkey-pageid'}ting-music-plaza-topic-{$tplData.url}{/block}
