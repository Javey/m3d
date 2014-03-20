{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-video-right{/block}
{block name='mod_attr'}monkey="mod-video-right{$index}"{/block}
{block name="mod_body"}
{if $modData.data}
            <div class="mod-list">
              <ul>
              {foreach $modData.data as $item}
                <li>
                  
                  <div class="video-pic" rel="{$item.link}"><a href="javascript:;" class="play-icon"></a><img alt="{$item.title}" org_src="{$item.prevue_img}" src="{#PIC_PLACEHOLDER#}"   class="lazyload"   /></div>
                  <div class="video-title">{$item.title|pixel_truncate:220}</div>
                </li>
                {/foreach}
              </ul>
            </div>
      {/if}    
{/block}