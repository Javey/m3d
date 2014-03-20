<div class="outline clearfix">
	{if !$tplData.result_from_orig && $tplData.redirect}  {**原词无结果且自动跳转**}
	<div class="cs fwb">
		<p>已经为您跳转到同义词：<span class="similar-query">{$tplData.query}</span></p>
	</div>
	{/if}

	{if $queryType == 'song'}
		{$typeName = '歌曲'}
		{$typeQuan = '首'}
	{elseif $queryType == 'album'}
		{$typeName = '专辑'}
		{$typeQuan = '张'}
	{elseif $queryType == 'artist'}
		{$typeName = '歌手'}
		{$typeQuan = '位'}
	{elseif $queryType == "lrc"}
		{$typeName = "歌词"}
		{$typeQuan = "首"}
	{else}
		{$typeName = '结果'}
		{$typeQuan = '篇'}
	{/if}

	{if !$tplData.noData}
    {*>>> 版权提示文案*}
    {if $tplData.search_hitted}
    <p class="limited-search-result">抱歉，应版权方要求，部分结果未能展现。</p>
    {/if}
    {*<<< 版权提示文案*}
		<p>搜索“<span class="fwb ci">{$tplData.query}</span>”，找到相关{$typeName}共<span class="number">{$tplData.param.all_result}</span>{$typeQuan}。</p>
		{if $targetBannerType[$tplData.heterobject.hetertype] == 'tag'}
			<a class="tag-tip" href="/search/tag/{$tplData.query}">为您推荐“{$tplData.query}”歌曲>></a>
		{/if}
	{/if}
	
	{if $tplData.result_from_orig && $tplData.syn_words}    {**同义词提示-原词有结果**}
		<div class="cs fwb">		
			<p>您要找的是不是：			
				<a href="/search?key={$tplData.syn_words|escape:'url' nofilter}">{$tplData.syn_words}</a>		
			</p>
		</div>
	{/if}

	{** 中国好声音活动，显示广告 **}
	{if intval($tplData.specialTarget.type) == 1}
		<a href="/topic/cooperation/chinavoice2013?pst=search" target="_blank" style="display: block; margin-top: 10px;">
			<img src="http://mu5.bdstatic.com/static/images/thevoice2013.jpg" alt="中国好声音第二季" style="width: 710px; height: 160px;" />
		</a>
	{/if}

	
	{if $tplData.noData}
	{block name="op_monitor"}{**Noah稳定性监控代码，勿删**}<!--STATUS NODATA-->{/block}
	{if $tplData.rqt_type==14}	
	<div class="rem-qianqian">
		<img class="search-pc-bg" width=336 height=229 src="/static/images/music/search_qianqian_bg.jpg">
		<p class="sorry">
			根据您的搜索,为您推荐百度音乐PC客户端<br/>
			<span class="c9 fwb">比酷狗更强大更好用!高品质,无损资源免费体验!</span>
		</p>	
		<img width=246 height=48 src="/static/images/music/search_qianqian_intro.jpg" alt="">	<br/>
		<a class="ttp-down-btn"  target="_blank" href="http://music.baidu.com/pc/download/BaiduMusic-12345639.exe"></a>
	</div>
	{else}
	<div class="no-result">
		<p class="sorry">
			
			抱歉，没有找到相关的音乐内容，我们正在努力地建设百度音乐的歌曲资源<br/>
		</p>
		<h3>建议您：</h3>
		<ul>
			<li>看看输入的文字是否有误</li>
			<li>去掉可能不必要的字词，如“的”、“什么”等</li>
			<li><a href="http://www.baidu.com/s?cl=3&wd={$tplData.query}">去网页搜索：<span class="ci">{$tplData.query}</span>&gt;&gt;</a></li>
		</ul>
	</div>
		{/if}
	{/if}
</div>
