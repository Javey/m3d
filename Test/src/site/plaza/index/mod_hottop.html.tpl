{extends file="module/module.html.tpl"}
{block name='mod_class'}hot-top{/block}
{block name='mod_attr'}monkey="hot-top"{/block}
{block name="mod_head"}
<a href="/top/dayhot" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">热歌榜 <span>TOP500</span></h2>
{/block}
{block name="mod_body"}

{$data = $tplData.hotBillboard}
{if $data}
{$type = "dayhot"}
{if count($data) >= 10}
<!--STATUS TOPHOT OK-->
{/if}
{include file="plaza/index/top_rank.html.tpl" inline}
{else}
    <p class="no-data">很抱歉，暂无热歌榜数据</p>
{/if}
{/block}
