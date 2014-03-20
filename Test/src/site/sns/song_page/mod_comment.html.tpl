{extends file="module/module.html.tpl"}
{block name='mod_class'}clicklog-hot{/block}
{block name='mod_attr'}monkey="hotSongs"{/block}
{block name="mod_head"}
<h2 class="title">最新评论</h2>
{/block}
{block name="mod_body"}
<div id="song-comment" class="mod-song-comment songpage-voice clicklog-voice">
	{include 'widget/user_voice/user_voice.html.tpl' inline}
	{user_voice
		id = $song_info.song_id
		subjectType = 'song'
		emptyMsg = '这首歌怎么样？快来评论一下吧！'
		pageSize = 10}
	
</div>
{/block}