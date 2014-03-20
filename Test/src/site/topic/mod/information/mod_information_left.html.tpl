{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-information-left{/block}
{block name='mod_attr'}monkey="mod-information-left{$index}"{/block}
{block name="mod_body"}
{if $modData.parames.sm_img}
<div class="mod-info clearfix">
    		<!--<img org_src="{$modData.parames.sm_img}" src="{#PIC_PLACEHOLDER#}" />--><img src="{$modData.parames.sm_img}" />
    	</div>
{/if}
<div class="content">
    {$modData.parames.content nofilter}
    {if $modData.parames.btn_title}
<p class="btn-wrap">
{if $modData.parames.btn_target == 0}  {$tagAtt = "target='_blank'"} {/if}
{button
   style="c"
   str = $modData.parames.btn_title
   tagAtt = $tagAtt
   href = $modData.parames.btn_link
   isShadow = false}</p>
{/if}
</div>
      
{/block}