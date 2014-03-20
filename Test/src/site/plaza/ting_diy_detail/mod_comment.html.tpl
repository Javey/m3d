{extends file="plaza/ting_diy_detail/mod_block.html.tpl"}
{block name='mod_attr'}monkey="mod-comment"{/block}
{block name="mod_block_class"}
	comment-block
{/block}

{block name="mod_block_body"}
{include file="widget/comment/comment.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{comment loading_str="留言加载中..." blank_str="请输入留言内容"}
{page_navigator url="#" total=0 size=10 start=0}
{/block}