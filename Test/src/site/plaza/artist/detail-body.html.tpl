<div class="detailtop head">
	<h2 class="title">
		{$menu[$artistSelected]}
	</h2>
	<div class="index-tag clearfix">
		<h3>索引:</h3>
		{if !$tplData.topList}
			<span class="nodata">热门</span>
		{else}
			<a href="#top">热门</a>
		{/if}
		<div class="letter-index">
		{foreach $tplData.list as $indexChar => $data}
            {** 目前rd数据存在 'E' => array( 0 => array() ) 的情况, 对于这样的字母，需要置灰 **}
			{if count($data) <= 0 || count($data[0]) <=0}
				<span class="no-data">
				{if $indexChar=="other"}其他{else}{$indexChar}{/if}
				</span>
			{elseif $indexChar=="other"}
				<a href="#{$indexChar}">其他</a>
			{else}
				<a href="#{$indexChar}">{$indexChar}</a>
			{/if}		
		{/foreach}
		</div>
	</div>	
</div>
<div class="module-line module-line-bottom"></div>
<ul class="container">
	<!--热门歌手-->
	{**全部歌手显示两行热门图片 其他一行**}
	{if $tplData.area == "all"}
		{$IMG_ROW = 2}
	{else}
		{$IMG_ROW = 1}
	{/if}
	{if $tplData.topList}
	<li class="list-item">		
		<div class="hot-head clearfix"> 
		<h3><a name="top"></a>热门</h3>
		{foreach $tplData.topList as $item}
			{if $item@iteration <= $COLUMN * $IMG_ROW}
				<dl class="cover-item {if $item@iteration % $COLUMN == 0}last{/if}">
					<dt class="cover-img">
						<a class="cover" href="/artist/{$item.ting_uid}">
							<img title="{$item.name}" src="{$item.avatar_s130|default:#ARTIST_DEFAULT_130b#}">
						</a>
					</dt>
					<dd>
						<a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:$TRUNCATE:'tahoma_14'}</a>
					</dd>
				</dl>
				{if $item@iteration == $COLUMN * $IMG_ROW}</div>{/if}
			{else}
				{if $item@iteration == $COLUMN * $IMG_ROW + 1}
					<ul class="clearfix">
				{/if}							
					<li {if $item@iteration % $COLUMN == 0}class="last"{/if}>
						<a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:$TRUNCATE_L:'tahoma_14'}</a>
					</li>
					{if !$item@last && ($item@iteration - $COLUMN * $IMG_ROW) % ($COLUMN*10) == 0}
						<li class="line-space"></li>
					{/if}
			{/if}
		{/foreach}
		</ul>
	</li>
	{/if}

	{foreach $tplData.list as $indexChar => $data}
        {** 目前rd数据存在 'E' => array( 0 => array() ) 的情况, 对于这样的字母，需要不显示 **}
		{if count($data) > 0 &&  !count($data[0]) <=0 }
			<li class="list-item">
				<div class="module-line module-line-bottom"></div>
				<h3><a name="{$indexChar}"></a>{if $indexChar == "other"}其他{else}{$indexChar}{/if}</h3>
				<ul class="clearfix">
					{$count = 1}
					{foreach $data as $item}
						{if $item.ting_uid}
							{$I_TRUNCATE_L = $TRUNCATE_L}
							{$I_TRUNCATE = $TRUNCATE}
							{$I_ICON_WIDTH = 40}

							{if array_key_exists($item.ting_uid, $tplData.topList)}
								{$hotIcon = true }
								{$I_TRUNCATE_L = $TRUNCATE_L - $I_ICON_WIDTH}
								{$I_TRUNCATE = $TRUNCATE - $I_ICON_WIDTH}
							{else}
								{$hotIcon = false }
							{/if}				
							<li {if $count % $COLUMN == 0}class="last"{/if}>
								<a href="/artist/{$item.ting_uid}" title="{$item.name}" {if $hotIcon}class="has-icon"{/if}>{$item.name|pixel_truncate:$I_TRUNCATE_L:'tahoma_14' nofilter}</a>
								{if $hotIcon} <span class="icon-hot"></span>{/if}
							</li>
							{if !$item@last && $count % ($COLUMN*10) == 0}
								<li class="line-space"></li>
							{/if}
							{$count = $count + 1}
						{/if}
					{/foreach}
				</ul>
			</li>		
		{/if}	
	{/foreach}
</ul>


