<div class="ting-recommend" id="ting_recommend">
	<div class="top-list clearfix">
		<h3>推荐榜单</h3>
		<a href="/top/new" class="has-split">新歌榜 TOP100</a><span class="module-line"></span><a href="/top/dayhot">热歌榜 TOP500</a><!--<a href="/top/artist">歌手听众榜</a>-->
	</div>
	<div class="hot-album">
		<h3>热门专辑推荐</h3>
		{include file="widget/roll/roll.html.tpl" inline}
		{roll data=$tplData.recommendAlbumList showAlbumName=true}		
	</div>
</div>
