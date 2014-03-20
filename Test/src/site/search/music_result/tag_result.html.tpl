{extends file="search/search.html.tpl"}

{block name='title'}{if $tplData.query}为你推荐"{$tplData.query}"的音乐{else}音乐搜索{/if}{/block}
{block name="js-page"}
<script type="text/javascript" src="/static/js/search.js"></script>
<script type="text/javascript">	
	{if $tplData.param.start}{$start = $tplData.param.start}{else}{$start = 0}{/if}
	$('.song-list-hook').songList({
			start:{$start}
	});

	// createClickMonkey("ting-music-search-tag");
</script>
{/block}

{block name='js-monkey-pageid'}ting-music-search-tag{/block}

{block name="main-body"}
	<div class="outline tag-outline clearfix">
		<input type="hidden" name="queryType" value="tag" id="query_type">
		<p>为您推荐“<span class="fwb ci">{$tplData.query}</span>”歌曲，共{$tplData.param.all_result}首。</p> 
		{button 
            str = "收听 <span class='ci'>{$tplData.radio_name|default:$tplData.query}</span> 的电台"
            style="b"
            tagAtt ="target='_blank'"
            isRightIcon =true
            icon ="fm"
            href = "{$tplData.param.fm_host}/#/channel/public_tag_{$tplData.radio_name|default:$tplData.query|escape:url}"
        }
		<a class="bkcommon" href="/search/song?key={$tplData.query}&jump=0">返回搜索结果>></a>
	</div>
	{**tagStyle 标签页分类 _1 无二级标签的一级标签页 _2 有二级标签的一级标签页 _3 二级标签页 **}
	{$tagStyle="_1"}
	{if $tplData.son_tag_list}
		{$tagStyle="_2"}
		<div id="rec_tag" class="rec-tag">
			<span class="item-tag  {if $tplData.father_tag==$tplData.query}first-tag{/if}"><a href="/search?key={$tplData.father_tag}">{$tplData.father_tag}</a></span>
			{foreach $tplData.son_tag_list as $item}
				<span class="item-tag  {if $item.tag_name==$tplData.query}first-tag{/if}">
				<a href="/search?key={$item.tag_name}&tag={$tplData.father_tag}">{$item.tag_name}</a>
				</span>
			{/foreach}
		</div> 
	{/if} 
	{if $smarty.get.tag}
		{$tagStyle="_3"}
	{/if}	 	
	<div class="search-result-container" data-tagstyle="tag{$tagStyle}" id="result_container" monkey="result-container">
		{include file="search/music_result/mod_tag_list.html.tpl" funIcon=["play","add","download"] funBtn=["play","add"]}
		{include file="search/music_result/group/mod_group_list.html.tpl"}		
	</div>
{/block}
{block name="search-right-body"}
	{if $tplData.yyrobject.res_array}
		{include file="search/music_result/group/mod_group_ybaidu.html.tpl"}
	{/if}
{/block}