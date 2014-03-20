{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/mv_list/mv_list.html.tpl" inline}
	{mv_list list=$tplData.mv_list perLine=4 total=20 titleParam="title" titleTruncate=140 showSinger=false}
{/block}

{block name="ajax_css"}

{/block}


{block name="ajax_js"}
var me=this;
$(".album-cover-hook",me).albumCover();
{/block}
