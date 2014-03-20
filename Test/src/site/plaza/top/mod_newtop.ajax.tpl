{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/song_list/song_list.html.tpl" inline}
{include file="widget/top/top_newlist.html.tpl" inline}   
{include file="widget/top/top_others.html.tpl" inline}  
{foreach $tplData.result as $item}
	{$newTopIds="`$newTopIds`_`$item.song_id`"}
{/foreach}
{$newTopIds=substr($newTopIds,1)}
{if $tplData.new_type=="day"}
	{top_others total = 50 songW=240 singerW=240 type='new' songData=$tplData.result src='top'    funBtn=["play","add","collect","down"] funIcon=["play","add","download"]}
{else}
	{top_new_song_list colHighRate= true  movieWidth = "150" funBtn=["play","add","collect","down"]  btnPos ="both" colAlbum =false topStatusWidth = 30 isSpecial = true total = 20 stressFirst = true indexWidth = 30 songData = $tplData.result  numPluszero=false}
{/if}
{/block}

{block name="ajax_css"}{/block}

{block name="ajax_js"}{ 'new_type':'{$tplData.new_type}','no':'{$tplData.no}','maxNo':'{$tplData.latestno}','newTopIds':'{$newTopIds}' }{/block}