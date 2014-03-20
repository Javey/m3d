{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-message{/block}
{block name='mod_attr'}monkey="mod-message{$index}"{/block}
{block name="mod_body"}
<div id="album-comment" class="left-content-block songpage-voice clicklog-voice">
	{include 'widget/user_voice/user_voice.html.tpl' inline}
	{user_voice
		id = $modData.parames.board_id
		subjectType = $modData.parames.board_type|default:'zhuanti'
		emptyMsg = '这个专题怎么样？快来评论一下吧！'
		pageSize = $modData.parames.page_num}
</div>
{/block}