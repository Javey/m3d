{extends file="module/module.html.tpl"}
{block name='mod_class'}media-top{/block}
{block name='mod_attr'}monkey="media-top"{/block}
{block name="mod_head"}
<a href="/top/ktv" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">KTV榜</h2>
{/block}
{block name="mod_body"}
{$data = $tplData.Billboard}
{if $data}
{$type = "media"}
{include file="plaza/index/top_rank.html.tpl" inline}
{else}
    <p class="no-data">很抱歉，暂无Billboard榜数据</p>
{/if}
{/block}
