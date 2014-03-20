<div class="clearfix hot-head head">
	<h2 class="title">{$menu[$artistSelected]}</h2>
		<div class="hot-artist clearfix">
	{foreach $tplData.topList as $item}
		{if $item@iteration > ($COLUMN*2)}{break}{/if}
			<dl class="cover-item {if $item@iteration % $COLUMN == 0} last {/if}">
			<dt class="cover-img">
				<a class="cover" href="/artist/{$item.ting_uid}">
					<img title="{$item.name}" src="{if $item.avatar_s130}{$item.avatar_s130}{else}{#ARTIST_DEFAULT_130b#}{/if}">
				</a>
			</dt>
			<dd>
				<a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:$TRUNCATE:'tahoma_14'}</a>
			</dd>
		</dl>
	{/foreach}
		</div>
</div>

<ul class="container">
	<li class="list-item">
		<ul class="clearfix">
		{foreach $tplData.list as $item}
			{if $item@iteration % $COLUMN == 0}				
				<li {if $item@iteration % $COLUMN == 0} class="last" {/if} >
					<a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:$TRUNCATE_L:'tahoma_14'}</a>
				</li>
				</ul>
				{if !$item@last}
				{if $item@iteration % ($COLUMN*10) == 0}
					{$className = "class='clearfix line-space'" }
				{else}
					{$className = "class=clearfix" }

				{/if}
					<ul {$className nofilter}>
				{/if}
			{else}
				<li>
					<a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:$TRUNCATE:'tahoma_14'}</a>
				</li>
			{/if}
			{if $item@last && $item@iteration % $COLUMN != 0}
				</ul>
			{/if}			
		{/foreach}	
	</li>
</ul>
