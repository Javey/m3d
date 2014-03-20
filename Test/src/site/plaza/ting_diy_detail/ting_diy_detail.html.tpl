{extends file="ting.html.tpl"}

{block name="title" append}{$tplData.data.name}_ting!为你精选{/block}
{block name="assign" append}
  {$navIndex='topic'}
{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/diy_detail.css{*version file='/static/css/mv_ting_diy_detail.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="js" append}
<script type="text/javascript">
	$(function () {
		var $pageNavigator, $comment;

		$pageNavigator = $('.page-navigator-hook').pageNavigator();
		$pageNavigator.bind('pagenavigator.pagechange',function(e, data){
			$comment.comment('load', data.start);
		});

		$comment = $('.comment-hook').comment({
			subjectId:{$tplData.data.comment_id},
			subjectType:'zhuanti',
			pageSize:10
		});

		$comment.bind('comment.loadsuccess',function(e, data){
			$pageNavigator.pageNavigator('setTotal', data.total).
			pageNavigator('setStart', data.start);
		});

		//$comment.bind('comment.loadsuccess',function(e, data){
		//	scrollTo(0, $comment.position().top - 60);
		//});

		// $('.album-cover-hook').albumCover();
		// $('.diy-cover-hook').diyCover();
		$('.song-list-hook').songList();

		$(".btn-play-list").bind("click",function(){
			var ids =$(this).data("btndata").button.data;
			ting.media.playSong(ids);
			$(this).tip().tip("tipup", {
                        msg: "已开始播放",
                        iconClass: "tip-success"
                    });
		});

	});
</script>
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>

<script type="text/javascript" _xcompress="true">
document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();

</script>
{/block}

{block name="content_main"}
{include file="widget/path_navigator/path_navigator.html.tpl"}
{path_navigator pathList=[ ["label"=>"专题", "link"=>"/topic"],["label"=>"{$tplData.data.name}"]]}

<div class="detail-wrapper clearfix" style="background:url({$tplData.data.background}) no-repeat #{$tplData.data.bg_color|default:7D7D7D};">
	<div class='detail-top clearfix'>
		<div class="desc" style="color:#{$tplData.data.desc_color|default:fff}; ">
			{$tplData.data.desc nofilter}
		</div>
		<div class="diyalbum-share">
			<span class="share-labe fl">分享到： </span>
			<div id="bdshare" class="bds_tools bdshare_t">	
		        <a class="bds_qzone"></a>
		        <a class="bds_renren"></a>
		        <a class="bds_tqq"></a>
		        <a class="bds_tsina"></a>
		        <span class="bds_more"></span>
			</div>	
		</div>
	</div>
	{foreach $tplData.data.content.songlist as $songListItem}
		{include file="plaza/ting_diy_detail/mod_song_list.html.tpl" title="{$songListItem.name}" listData=$songListItem style=$songListItem songsIndex=$songListItem@index}
	{/foreach}
	
	{foreach $tplData.data.content.albumlist as $albumListItem}
		{include file="plaza/ting_diy_detail/mod_album_list.html.tpl" title="{$albumListItem.name}" layout="{if $albumListItem.albums[0].desc}loose{else}compact{/if}" listData=$albumListItem style=$albumListItem albumIndex=$albumListItem@index}
	{/foreach}
	
	{include file="plaza/ting_diy_detail/mod_comment.html.tpl" title="网友留言"}
	{include file="plaza/ting_diy_detail/mod_other_diys.html.tpl" title="专题" listData=$tplData.other}
</div>
{/block}
