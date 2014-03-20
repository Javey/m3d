<div class="module {block name='mod_class'}{/block} {$class} {if !$modData.parames.title}mod-no-title{/if}" id="mod_{$modData.parames.module_id}" {block name='mod_attr'}{/block} >
	{if $modData.parames.title}
	<div class="mod-head clearfix">
		{block name="mod_head"}
			{if $modData.parames.more_title} <a class="more"  {if $modData.parames.link_target == 0 } target="_blank" {/if} href="{$modData.parames.more_link}"  style="{if $modData.parames.title_color}color:#{$modData.parames.title_color};{/if}" >{$modData.parames.more_title}</a>{/if}<h2 class="mod-title" style="{if $modData.parames.title_font_size}font-size:{$modData.parames.title_font_size}px; {if $modData.parames.title_font_size<12}-webkit-text-size-adjust:none;{/if}{/if} {if $modData.parames.title_color}color:#{$modData.parames.title_color};{/if}">{$modData.parames.title}</h2>
		{/block}
	</div>
	{/if}
    {block name="mod_body_head"}
    {/block}
	<div class="mod-body">
		{block name="mod_body"}{/block}
	</div>
    {block name="mod_foot"}
    {/block}
</div>
