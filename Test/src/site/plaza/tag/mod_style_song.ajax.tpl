{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/song_list/song_list.html.tpl" inline}
	
	{song_list moduleName = "song" colHighRate = true songInfo = true  btnPos="both" songData=$tplData.songList funIcon=["play","add","download"] funBtn=["play","add","collect","down"] colAlbum=true singerWidth="120" songWidth="162" albumWidth="130" indexWidth="25" total = 20 colHighRate = true}
{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}

{/block}

