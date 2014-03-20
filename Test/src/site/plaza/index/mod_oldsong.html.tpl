{extends file="module/module.html.tpl"}
{block name='mod_class'}oldsong-top{/block}
{block name='mod_attr'}monkey="oldsong-top"{/block}
{block name="mod_head"}
<a href="/top/oldsong" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">经典老歌榜</h2>
{/block}
{block name="mod_body"}

{$data = $tplData.oldsong}
{if $data}
{$type = "oldsong"}
{if count($data) >= 10}
<!--STATUS TOPHOT OK-->
{/if}
{include file="plaza/index/top_rank.html.tpl" inline}
{else}
    <p class="no-data">很抱歉，暂无经典老歌榜数据</p>
{/if}
{/block}
