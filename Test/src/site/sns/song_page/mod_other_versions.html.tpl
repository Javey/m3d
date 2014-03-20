{extends file="module/module.html.tpl"}
{block name='mod_class'}other-versions{/block}
{block name='mod_attr'}monkey="otherVersions"{/block}
{block name="mod_head"}
<h2 class="title">其他歌手演唱的"{$tplData.song_info.title}"</h2>
{/block}
{block name="mod_body"}
{include file="widget/people_icon/people_icon.html.tpl" empty=false inline}
{include file="widget/user_link/user_link.html.tpl" inline}
{if $tplData.covert_info}
{$page = 8}
<ul class="related-list clearfix">
{foreach $tplData.covert_info as $artist}
	{if $artist@index % $page == 0 && $artist@index != 0}
</ul>
<ul class="related-list clearfix">
	{/if}
	<li>
		{people_icon type = 60 imgsize = 60 people=$artist showName=false}
		{song_link_url_plugin song=$artist linkWithNoSongId="#" songLinkUrl=theSongLink}
		<a href="{$theSongLink}" class="play" title="播放"></a>
		<h4>
			<a href="{$theSongLink}" title="{$artist.author}版">{$artist.author|pixel_truncate:90}版</a>
		</h4>
	</li>
{/foreach}
</ul>
{/if}
{/block}
