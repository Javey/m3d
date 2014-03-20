{include file="widget/song_list/search_song_list.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}

{if $tplData.query=='大闹天宫'}
<div class="yinpin-ad">
	<h2><a href="http://youxi.baidu.com/yxpm/pm.jsp?pid=10112900495_1028530" target="_blank">快来《大闹天宫OL》与大圣 一起飞驰三界</a></h2>
	<p class="yinpin-content">
		<a class="yinpin-ad-link" href="http://youxi.baidu.com/yxpm/pm.jsp?pid=10112900495_1028530" target="_blank"><img width=150 height=90 src="http://music.baidu.com/cms/image/danaotiangong.jpg" alt="快来《大闹天宫OL》与大圣 一起飞驰三界"></a>
		《大闹天宫OL》是一款由百度独家营运的ARPG网页游戏，以名著西游记以及各大神话故事为背景改编而成，对同名电影的场景高度还原，创造出了美轮美奂的奇幻世界。
		<!-- <span class="i-tuiguang">推广</span> -->
	</p>
</div>
{/if}
{search_song_list colHighRate= true checked = false truncated=false colIndex=true songInfo=true selectAll=false colAlbum=true indexWidth="33" songWidth="170" singerWidth="120" albumWidth="130" funIcon=$funIcon funBtn=$funBtn songData=$tplData.songobject.res_array colHotIcon=false  searchSuggest=true target=true}
{**jump==0 直接搜索结果**}
{page_navigator total=$tplData.param.total size=$tplData.param.size start=$tplData.param.start 			url="/search/song?key={$tplData.query|escape:'url' nofilter}&{if $smarty.get.jump==0}jump=0&{/if}start=#start#&size=#size#"}

