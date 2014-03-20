{extends file="module/module.html.tpl"}
{block name='mod_class'}netsong-top{/block}
{block name='mod_attr'}monkey="netsong-top"{/block}
{block name="mod_head"}
<a href="/top/netsong" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">网络歌曲榜</h2>
{/block}
{block name="mod_body"}

{$data = $tplData.netsong}
{if $data}
{$type = "netsong"}
{if count($data) >= 10}
<!--STATUS TOPHOT OK-->
{/if}
{include file="plaza/index/top_rank.html.tpl" inline}
{else}
    <p class="no-data">很抱歉，暂无网络歌曲榜数据</p>
{/if}
{/block}
