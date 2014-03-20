{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/album_list/album_list.html.tpl" inline}
	{alubm_list moduleName ="album" showCreator=true list=$tplData.albumList subChannel = true lazyload =false total =10 showAlbumList =true showStatus=true}
{/block}

{block name="ajax_css"}

{/block}


{block name="ajax_js"}
var me=this;
$(".album-cover-hook",me).albumCover();
{/block}
