{extends file="ajax.tpl"}
{block name="ajax_html"}
{if $tplData.recommend_list}
{include file="widget/recommend_list/recommend_list.html.tpl" inline}
	{recommend_list list=$tplData.recommend_list editable=$isSelf}
	<a class="fr mb10p" href="/artist/{$tplData.owner_user_id}/recommend">更多推荐&nbsp;&nbsp;>></a>
{else}
<div class="no-data">
       Ta还没推荐过东西呢。
</div>
{/if}	
{/block}

{block name="ajax_css"}

{/block}


{block name="ajax_js"}
var me=this;
$(".music-icon-hook",me).musicIcon();
$(".diy-cover-hook",me).diyCover();
$(".album-cover-hook",me).albumCover();	
ting.LL.add($(".lazyload",this));
{/block}
