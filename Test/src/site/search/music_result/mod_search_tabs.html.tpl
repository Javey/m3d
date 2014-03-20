{include file="widget/tab/tab.html.tpl" inline}
<div class="search-tabs">
	<input type="hidden" name="queryType" value="{$queryType}" id="query_type" />
	{**
	<ul class="action-tabs">
		{$tabs=[
			'song' => '歌曲',
			'artist' => '歌手',
			'album' => '专辑',
			'lrc' => '歌词'
		]}
		{$Num = $tplData.nums}
		{foreach $tabs as $item key=tab}
			{if $Num[$tab]>1000}{$Num[$tab] = '1000+'}{/if}
			<li class="{if $item@last}last-tab {/if} {if $queryType == $tab}on{/if}">
				{if $Num[$tab] !== 0}
					<a href="/search/{$tab}?key={$tplData.query|escape:'url' nofilter}">{$item}({$Num[$tab]})</a>
				{else}
					<span class="num0">{$item}({$Num[$tab]})</span>
				{/if}
			</li>
		{/foreach}
	</ul>
	**}
{$Num = $tplData.nums}
{$worksTab =[ 
	[
		"link" => "{if $Num.song != 0}/search/song?key={$tplData.query|escape:'url' nofilter}{/if}",
		"title" => "歌曲({if $Num.song>1000}1000+{else}{$Num.song}{/if})",
		"active" => "{if $queryType == "song"} 1 {else}0{/if}"
	],
	[
		"link" => "{if $Num.artist != 0}/search/artist?key={$tplData.query|escape:'url' nofilter}{/if}",
		"title" => "歌手({if $Num.artist>1000}1000+{else}{$Num.artist}{/if})",
		"active" => "{if $queryType == "artist"} 1 {else}0{/if}"
	],
	[
		"link" => "{if $Num.album != 0}/search/album?key={$tplData.query|escape:'url' nofilter}{/if}",
		"title" => "专辑({if $Num.album>1000}1000+{else}{$Num.album}{/if})",
		"active" => "{if $queryType == "album"} 1 {else}0{/if}"
	],
	[
		"link" => "{if $Num.lrc != 0}/search/lrc?key={$tplData.query|escape:'url' nofilter}{/if}",
		"title" => "歌词({if $Num.lrc>1000}1000+{else}{$Num.lrc}{/if})",
		"active" => "{if $queryType == "lrc"} 1 {else}0{/if}"
	]
]}
{tab tablist = $worksTab style="middle"}




    <a id="search-suggest" class="search-suggest" href="#" data-target="#search-suggest-container">找不到你想要的？</a>
    <div id="search-suggest-container">
        <a class="css-close close" href="#"></a>
        <div id="questions">这些结果是你想要的吗？
            <input type="radio" name="wanted" value="0" checked="true"/>是
            <input type="radio" name="wanted" value="1"/>不是
            <textarea name="suggest" id="user-suggest" cols="32" rows="6" placeholder="说点什么..."></textarea>
            <button id="suggest-submit">提交</button>
            <button class="close">关闭</button>
            <p class="tips">音乐的小伙伴正在努力改进中</p>
        </div>
    </div>
</div>
