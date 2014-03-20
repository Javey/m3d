{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-information-right{/block}
{block name='mod_attr'}monkey="mod-information-right{$index}"{/block}
{block name="mod_body"}
    	<div class="mod-info clearfix">
          {$modData.parames.content nofilter}
        </div>
        
{/block}