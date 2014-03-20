{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-information{/block}
{block name='mod_attr'}monkey="mod-information{$index}"{/block}
{block name="mod_body"}
{if $modData.data}
<div class="longitudinal-list">
  {foreach $modData.data as $item}
  <dl class="item">
    <dt><a href="{$item.link}">{$item.title}</a></dt>
    <dd>{$item.desc}</dd>
  </dl>
  {/foreach}
</div>
{/if}
{/block}