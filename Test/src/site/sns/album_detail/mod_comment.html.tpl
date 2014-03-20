{extends file="module/module.html.tpl"}
{block name='mod_class'}mod-comment{/block}
{block name="mod_head"}

{**模块头部**}
<h2 class="title">最新评论</h2>
{/block}
{block name="mod_body"}
<div id="album-comment" class="left-content-block  album-recommend ">
{include 'widget/user_voice/user_voice.html.tpl' inline}
{user_voice
	id = $tplData.data.album.album_id
	subjectType = 'album'
	emptyMsg = '这张专辑怎么样？快来评论一下吧！'
	pageSize = 10}
</div>
{/block}