<div class="topic-cate module cate-info" monkey = "cate-info">
  <div class="head clearfix">
    <h2>{$tplData.data.title}</h2>
    <span class="c9">共{$tplData.data.total}个专题</span>
  </div>
  {if $tplData.data.list}
  <div class="cate-list">
    <ul class="clearfix">
      {foreach $tplData.data.list as $item}
      {$urlarr = explode('/', $item.url) }
          {if count($urlarr) > 1}
            {$url = "/diyalbum/`$item.url`"}
          {else}
            {$url = "/topic/`$item.type`/`$item.url`"}
          {/if}
       <li>
        <a href="{$url}"><img class="lazyload" org_src="{$item.thumb_img}" src ="{#PIC_PLACEHOLDER#}" alt=""> </a>
        <a href="{$url}">{$item.song_ids|default:$item.intro|pixel_truncate:360 nofilter}</a>
       </li>
       {/foreach}

    </ul>
  </div>
  {else}
  <p class="no-data">暂无该专题数据</p>
  {/if}
</div>
{if $tplData.data.list}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{page_navigator total={$tplData.data.total} size={$tplData.data.limit} start={$tplData.data.start} url="/topic/type/{$tplData.data.type}?start=#start#&size=#size#"}
{/if}
