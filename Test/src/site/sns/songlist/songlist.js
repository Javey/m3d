$(function() {
	var $collectBtn=$(".col-collect a"),
		listData=$collectBtn.data("playlist")||{},
		ids=listData.ids,
		title=listData.title,
		listid=listData.listid,
		$allDown=$(".col-down a");
	$collectBtn.bind("click",function  () {
		// $(this).collectPlaylist({log:{page:"c_songlist_d"}});
		$(this).collectPlaylist();
        return false;
	});
	$(".col-play a").bind('click',function  () {
        if(ids){
            ting.media.playSong(ids.split(","),listData);
            $.ajax({ url: "/data/music/songlist/listen?playlistId="+listid+"&t="+(new Date()*1)});
            ting.logger.log('click', {
                pos: 'play_songlist'
            });
			$(this).tip().tip("tipup", {
				msg: "已开始播放！",
				iconClass: "tip-success"
			});
        }
        return false;
    });
	$(".col-add a").bind('click',function  () {
        if(ids){
            ting.media.addSong(ids.split(","),listData);
			$(this).tip().tip("tipup", {
				msg: "添加成功！",
				iconClass: "tip-success"
			});            
        }           
        return false;
    });
	$(".other-songlist li>a").bind("click",function(){
            ting.logger.log('click',$(this).parent().data("log"));		
		return;
	})
	$allDown.bind("click", function () {

    ting.media.downloadAll(ids, {type: 'songList', title: title});
     ting.logger.log("click",{ page:"c_songlist_d",pos:"multi_down",listid:listid });
    return false;
	});

  //歌单统计by wangyu
  var logData = $(".js-log-sl-share").data('log-info');
  function logSL(key){
    ting.logger.log('click', {
      page: ting.logger.getPage(),
      pos: 'share_list',
      sub: key,
      listid: logData.id,
      listname: logData.title
    })
  }
  //百度统计不支持事件代理
  $('.bds_qzone').on('click', function(){
    logSL('qzone');
  });
  $('.bds_renren').on('click', function(){
    logSL('renren');
  });
  $('.bds_tqq').on('click', function(){
    logSL('tengxun');
  });
  $('.bds_tsina').on('click', function(){
    logSL('sina');
  });
});
