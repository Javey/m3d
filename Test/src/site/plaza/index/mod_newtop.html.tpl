{extends file="module/module.html.tpl"}
{block name='mod_class'}new-top{/block}
{block name='mod_attr'}monkey="new-top"{/block}
{block name="mod_head"}
<a href="/top/new" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">新歌榜 <span>TOP100</span></h2>
{/block}
{block name="mod_body"}
{$data = $tplData.newBillboard}
{if $data}
{$type = "new"}
{if count($data) >= 10}
<!--STATUS TOPNEW OK-->
{/if}
      {include file="plaza/index/top_rank.html.tpl" inline}
{else}
    <p class="no-data">很抱歉，暂无新歌榜数据</p>
{/if}
{/block}