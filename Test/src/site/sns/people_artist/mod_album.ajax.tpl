{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/album_list/album_list.html.tpl" inline}
	{alubm_list moduleName ="album" list=$tplData.album_list subChannel = true total =10 lazyload =false showAlbumList =true showStatus=true order=$smarty.get.order|escape:'html'}
{/block}

{block name="ajax_css"}

{/block}


{block name="ajax_js"}
var me=this;
$(".album-cover-hook",me).albumCover();
{/block}
