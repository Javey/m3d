{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-information-banner{/block}
{block name='mod_attr'}monkey="mod-information-banner{$index}"{/block}
{block name="mod_body"}
<div class="mod-info">
      <!--<img org_src="{$modData.parames.info_img}" src="{#PIC_PLACEHOLDER#}" alt="{$modData.parames.info_title}" />--><img src="{$modData.parames.info_img}" alt="{$modData.parames.info_title}" />
      <div class="content">
        <h3><a href="{$modData.parames.info_link}">{$modData.parames.info_title}</a></h3>
        <div class="inner">
          <p>{$modData.parames.info_intro nofilter}</p>
        </div>
      </div>
    </div>
{/block}