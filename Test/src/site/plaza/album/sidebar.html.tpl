<div class="new-album-title">
	<a href="/album/shoufa?order={$order}&style={$stylename}" {if $area == "shoufa"} class="type-selected" {/if}>新碟首发</a>
</div>
<div class="select">
	<div class="by-area select-item" id="by-area">
		<div class="module-dotted"></div>
		<h4>按地区筛选</h4>
		<ul class="clearfix">
			{foreach $areaArray as $key => $value}
				<li><a href="/album/{$key}?order={$order}&style={$stylename}" {if $area == $key} class="type-selected" {/if}>{$value}</a></li>
			{/foreach}
		</ul>
	</div>
	<div class="by-style select-item" id="by-style">
		<h4>按流派筛选</h4>
		<ul class="clearfix">
			{foreach $styleArray as $key => $value}
				<li><a href="/album/{if $area == "shoufa" || $area == "new"}all{else}{$area}{/if}?order={$order}&style={$key}" {if $area != "shoufa" && $area != "new" && $stylename == $key} class="type-selected" {/if}>{$value}</a></li>
			{/foreach}
		</ul>
	</div>	
</div>
