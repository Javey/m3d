{extends file="module/module.html.tpl"}
{block name='mod_class'}movie-top{/block}
{block name='mod_attr'}monkey="movie-top"{/block}
{block name="mod_head"}
<a href="/top/chinavoice2013" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">中国好声音榜</h2>
{/block}
{block name="mod_body"}

{$data = $tplData.chinavoice}
{if $data}
{$type = "chinavoice2013"}
{if count($data) >= 10}
<!--STATUS TOPHOT OK-->
{/if}
{include file="plaza/index/top_rank.html.tpl" inline}
{else}
    <p class="no-data">很抱歉，暂无中国好声音榜数据</p>
{/if}
{/block}
