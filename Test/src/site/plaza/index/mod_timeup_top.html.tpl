{extends file="module/module.html.tpl"}
{block name='mod_class'}timeup-top{/block}
{block name='mod_attr'}monkey="timeup-top"{/block}
{block name="mod_head"}
<a href="/top/biaosheng" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">24小时飙升榜</h2>
{/block}
{block name="mod_body"}

{$data = $tplData.biaosheng}
{if $data}
{$type = "biaosheng"}
{if count($data) >= 10}
<!--STATUS TOPHOT OK-->
{/if}
{include file="plaza/index/top_rank.html.tpl" inline}
{else}
    <p class="no-data">很抱歉，暂无24小时飙升榜数据</p>
{/if}
{/block}
