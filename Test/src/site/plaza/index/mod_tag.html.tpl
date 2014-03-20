{extends file="module/module.html.tpl"}
{block name='mod_class'}tag{/block}
{block name='mod_body_class'}tag-list clearfix{/block}
{block name='mod_attr'}monkey="tag"{/block}
{block name="mod_head"}
{include file="widget/album_cover/album_cover.html.tpl" inline}

{**模块头部**}
<a class="more" href="/tag">更多<span>&gt;&gt;</span></a>
<h2 class="title">音乐分类</h2>
{/block}

{block name="mod_body"}
<p class="clearfix">
{foreach $tplData.songTag as $item}
    {if $item@index <35}
      {if ($item@index+1) % 5 == 0}
        {$wrap = true}
      {else}
        {$wrap = false}
      {/if}
      <a  href="/tag/{$item.title|escape:'url' nofilter}" {if $item.title_class} class="{$item.title_class}" {/if}>{$item.title|default:"&nbsp;"|pixel_truncate:60}</a>{if !$wrap}<i class="module-line"></i>{/if}

      {if $wrap && $item@index + 1 !=35}
        </p><p class="clearfix">
      {/if}
  {/if}
{foreachelse}
哇塞！空数据唉！
{/foreach}
</p>
{/block}
