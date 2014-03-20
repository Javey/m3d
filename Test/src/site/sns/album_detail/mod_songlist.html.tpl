{extends file="module/module.html.tpl"}
{block name='mod_class'} mod-song-list{/block}
{block name='mod_attr'}monkey="song-list"{/block}
{block name="mod_head"}
<h2 class="title">专辑曲目</h2> ( {count($songData)} )
{/block}
{block name="mod_body"}
{include file="widget/song_list/song_list.html.tpl" inline}
{foreach $tplData.data.album.artistInfos as $item}
	
	{if $item@index == 0}
		{$first = $item}
	{/if}
{/foreach}
{song_list moduleName="albumList" colHighRate = true songInfo = true songData=$songData btnPos ="both" total = 200 funIcon=$funIcon funBtn=$funBtn hotBar=true songWidth="170" singerWidth="140" indexWidth="25" albumSinger = $tplData.data.album.author}
{/block}
