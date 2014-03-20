{extends file="module/module.html.tpl"}
{block name='mod_class'}mod-newtop{/block}
{block name='mod_attr'}monkey="mod-newtop"{/block}
{block name="mod_head"}
<span class="more"><a href="/top/new">更多<span>&gt;&gt;</span></a> </span>
<h2 class="title">新歌榜</h2>
{/block}
{block name="mod_body"}
{include file="widget/top/right_mini_top.html.tpl"  inline}
{include file="widget/song_list/fun_btn.html.tpl"}
	
{right_mini_top topData=$tplData.newBillboard moduleName='songpage-newtop'}

	{button 
		style = "a"
		str = "播放榜单"
		icon = "play"
		class = "play-all-hook"
		href = "javascript:;"
		tagAtt = "data-type='day'"}
{/block}