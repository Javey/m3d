{extends file="module/module.html.tpl"}
{block name='mod_class'}module-mv{/block}
{block name='mod_attr'}monkey="module-mv" {/block}
{block name="mod_head"}
<h2 class="title">歌曲MV</h2>
{/block}

{block name="mod_body"}
{include file="widget/mv_cover/mv_cover.html.tpl" inline}
{mv_cover data = $song_info}
{/block}
