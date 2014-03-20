{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-media{/block}
{block name='mod_attr'}monkey="mod-media{$index}"{/block}
{block name="mod_body"}
{if $modData.data}
        <div class="mod-list">
          <ul class="pic-list media-list clearfix">
          {foreach $modData.data as $item}
            <li>
              <div class="pic-img"><a href="{$item.link}"><img   class="lazyload"   org_src="{$item.media_img}" src="{#PIC_PLACEHOLDER#}" alt="{$item.title}" title="{$item.title}" /></a></div>
              <div class="pic-title"><a href="{$item.link}">{$item.title|pixel_truncate:120}</a></div>
            </li>
          {/foreach}
          </ul>
        </div>
        {/if}
{/block}