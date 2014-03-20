{if $modData.parames.opacity}
{assign var = "opacity" value = $modData.parames.opacity/100 }
{/if}
{include file="widget/button/button.html.tpl" inline}
<div class="mod-intro" monkey="mod-intro{$index}" id="mod_{$modData.parames.module_id}">
	{if $modData.parames.title}
	<div class="mod-head" style="border-bottom:none">
		<h2 class="mod-title" style="{if $modData.parames.title_font_size}font-size:{$modData.parames.title_font_size}px; {if $modData.parames.title_font_size<12}-webkit-text-size-adjust:none;{/if}{/if} {if $modData.parames.title_color}color:#{$modData.parames.title_color};{/if}">{$modData.parames.title}</h2>
		<i class="bg" style="background-color:#{$modData.parames.title_bg_color|default:'4F5C68'};opacity:{$opacity};filter:Alpha(Opacity={$modData.parames.opacity});"></i>
	</div>
	{/if}
	<div class="body clearfix">
		{if $modData.parames.sm_img}<img src="{$modData.parames.sm_img}" />{/if}
		{if $modData.parames.content}
		<div class="info">
			{$modData.parames.content nofilter}
			{if $modData.parames.btn_title}
			<p class="btn-wrap">
				{if $modData.parames.btn_target == 0}  {$tagAtt = "target='_blank'"} {/if}
				{button
				style="c"
				str = $modData.parames.btn_title
				tagAtt = $tagAtt
				href = $modData.parames.btn_link
				isShadow = false}
			</p>
			{/if}
		</div>
		{/if}
		{if $modData.parames._category}
		<div class="topic-tab">
			<div class="tab-nav">
			{foreach $modData.parames._category as $item}
				{button
				style="{if $item@first}p{else}o{/if}"
                class = "{if $item@first}btn-o{/if}"
				str = $item.title
				href = "#" }
			{/foreach}				
			</div>
			<div class='tab-body'>
			{foreach $modData.parames._category as $item}
	
				<div class="tab-item {if $item@first}on{/if}">
					{foreach $modData.data[$item.code] as $content}
					{if $content@first}
						{$content.content nofilter}
					{/if}
					{/foreach}
				</div>
			{/foreach}					
			</div>
		</div>
		{/if}
	</div>
	<i class="bg" style="background-color:#{$modData.parames.column_bg_color|default:'201734'};opacity:{$opacity};filter:Alpha(Opacity={$modData.parames.opacity});"></i>
</div>