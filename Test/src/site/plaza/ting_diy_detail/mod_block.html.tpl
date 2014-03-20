<div {block name='mod_attr'}{/block} class="mod-tdiy-block {block name="mod_block_class"}{/block} clearfix">
	<div class="mod-block-title clearfix" {if $style.title_bg} style="background:url({$style.title_bg}) no-repeat;" {/if} >
			<h3 style="color:#{$style.title_color|default:333}">{$title}</h3>{if $aText} <a class="right-link"  href="{$aLink}">{$aText}</a>{/if}
	</div>
	{if $style.pic}
		{if $style.song_position=='right'}
			{$elestyle="style='background:#fff url(`$style.pic`) top left no-repeat; ' "}
		{else}
			{$elestyle="style='background:#fff url(`$style.pic`) top right no-repeat;'"}
		{/if}
	   " 
	{/if}
	<div class="mod-block-body clearfix" {$elestyle nofilter}>
		{block name="mod_block_body"}{/block}
	</div>
</div>
