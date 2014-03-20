{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/song_list/song_list.html.tpl" inline}
	{$order = $smarty.get.order}
	{if $order == 'hot'}
		{$colNewIcon = true}
		{$colHotIcon = false}
	{else if $order == 'time'} 
		{$colNewIcon = false}
		{$colHotIcon = true}
	{/if}
	{song_list  hotbarMax = $smarty.get.hotmax|escape:'html'  moduleName = "song" colHighRate = true songInfo=true  btnPos="both" songData=$tplData.songlist funIcon=["play","add","download","collect"] funBtn=["play","add","collect","down"] songWidth="157" indexWidth="25" colAlbum=true colSinger =false hotBar = true total = 20 colNewIcon = $colNewIcon showChinaVoice=true colHotIcon = $colHotIcon}
{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}

{/block}

