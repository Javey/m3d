{extends file="search/search.html.tpl"}
{block name='title'}

{if $tplData.query}搜索含有"{$tplData.query}"的音乐{else}音乐搜索{/if}{/block}

{block name="assign" append}
{**targetBannerType 1歌曲2歌手3专辑4歌词6Tag**}
{$targetBannerType=[
	1=>"song",
	2=>"artist",
	3=>"album",
	4=>"lrc",
	6=>"tag"
	]}
{if $tplData.noData}
		{$monkeypageid = "ting-music-search-noresult"}
	{else}
		{if $tplData.queryType == 'song'}
			{if $tplData.heterobject.hetertype && $tplData.heterobject.res_array}
				{$monkeypageid = "ting-music-search-song-`$targetBannerType[$tplData.heterobject.hetertype]`"|cat:"banner"}
			{else}
			{$monkeypageid = "ting-music-search-song-nobanner"}
				
			{/if}
		{else}
			{$monkeypageid = "ting-music-search-`$tplData.queryType`"}
		{/if}
	{/if}

{/block}
{block name='js-monkey-pageid'}{$monkeypageid}{/block}

{block name="js-page"}
<script type="text/javascript" src="/static/js/ZeroClipboard.js"></script>
<script type="text/javascript" src="/static/js/search.js"></script>
<script type="text/javascript">
	var monkeyid;
	{if $tplData.noData}
		monkeyid = 'ting-music-search-noresult';
	{else}
		{if $tplData.queryType == 'song'}
			{if $tplData.heterobject.hetertype && $tplData.heterobject.res_array}
				monkeyid = 'ting-music-search-song-{$targetBannerType[$tplData.heterobject.hetertype]}banner';
			{else}
				monkeyid = 'ting-music-search-song-nobanner';
			{/if}
		{else}
			monkeyid = 'ting-music-search-{$tplData.queryType}';
		{/if}
	{/if}

	
	{if $tplData.param.start}{$start = $tplData.param.start}{else}{$start = 0}{/if}
	$('.song-list-hook').songList({
			start:{$start}
	});

	// if(monkeyid){ createClickMonkey(monkeyid); }
</script>
{/block}




{block name="main-body"}
{block name="ad-banner"}{/block}
{$queryType = $tplData.queryType}
{$query = $tplData.query}

{if strlen($query)}
	{include file="search/music_result/mod_outline.html.tpl"}
{/if}
{if !$tplData.noData}
	{include file="search/music_result/mod_search_tabs.html.tpl"}
{/if}
<!-- {**只在歌曲维度展示异形区**} -->
{**hetertype 1歌曲2歌手3专辑4歌词6Tag**}
{if $queryType == 'song' && $tplData.heterobject && $tplData.heterobject.res_array}
	{if $tplData.heterobject.hetertype == 3}
		{include file="search/music_result/mod_target_album.html.tpl"}
	{elseif $tplData.heterobject.hetertype == 2}
		{include file="search/music_result/mod_target_artist.html.tpl"}
	  {$resultTypeClass=" search-artist"}
  {/if}
{/if}
<!-- {**异形区end**} -->

{include file="search/music_result/group_top/base.tpl" inline}

<div class="search-result-container{$resultTypeClass}" id="result_container" monkey="result-container">
	{if $tplData.noData}
		{include file="search/music_result/mod_ting_recommend.html.tpl"}
	{/if}

	{block name="resultlist"}
		{if $queryType == 'song'}
	      {* 搜索歌手展示异形 *}
	      {if $tplData.heterobject.hetertype == 2}
	        {include file="search/music_result/artist/mod_song_list.html.tpl" funIcon=["play","add","download"] funBtn=["play","add"]}
	      {else}
	        {include file="search/music_result/mod_song_list.html.tpl" funIcon=["play","add","download"] funBtn=["play","add"]}
	      {/if}
		  {* 搜索歌手展示异形 *}
		{elseif $queryType == 'album'}
			{include file="search/music_result/mod_album_list.html.tpl"}
		{elseif $queryType == 'artist'}
			{include file="search/music_result/mod_artist_list.html.tpl"}
		{elseif $queryType == 'lrc'}
			{include file="search/music_result/mod_lrc_list.html.tpl"}
		{/if}
	{/block}
	<div class="clearfix">
		<div class="mp3logo">以上搜索结果由百度mp3搜索提供</div>
	</div>
{include file="search/music_result/group/mod_group_list.html.tpl"}	
</div>

{/block}
{block name="search-right-body"}
	{if $tplData.yyrobject.res_array}
		{include file="search/music_result/group/mod_group_ybaidu.html.tpl"}
	{/if}
{/block}