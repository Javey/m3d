{extends file="module/module.html.tpl"}
{block name='mod_class'}song-lyric clicklog-lyric{/block}
{block name='mod_attr'}monkey="song-lyric" {/block}
{block name="mod_head"}
{**模块头部**}
{$lrc_data = $tplData.lrc_data}

{if $lrc_data}
	{$lrc_rows=count(explode("\n",$lrc_data))}
	{if $lrc_rows > 12}
		{$lyric_hidden = true}
	{else}
		{$lyric_hidden = false}
	{/if}
	{$exist_lyric = true}
{else}
	{$lyric_hidden = false}
	{$exist_lyric = false}
{/if}
<a name="song_lyric"></a>
<span class="opera">
	<a class="down-lrc-btn" data-lyricdata='{ "href":"{$song_info.lrclink}" }' href="#">下载LRC歌词</a>
	<span class="module-line"></span>
	<span data-clipboard-target="lyricCont" id="copy-lyric" class="copy-lyric copy-lyric-hook">复制歌词</span>
</span>
<h2 class="title">歌词</h2>
{/block}

{block name="mod_body"}
{**临时需求：没有歌词的时候直接不显示该模块**}
{if $exist_lyric}
	<div id="lyricCont" class="lyric-content{if $lyric_hidden} lyric-hidden{/if}">{$lrc_data|nl2br nofilter}</div>
	{if $lyric_hidden}
		<a href="" id="lyricSwitch" class="lyric-switch"><span class="text">展开</span><span class="icon"></span>	 </a>
	{/if}
{/if}
{/block}
