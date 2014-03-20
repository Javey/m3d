$(function(){
	var $albumDown = $(".album-down"),
		$collectPlaylist=$(".playlist-add");

	
	var changeBatchDownStatus = function(){
		if( !ting.userInfo ){
			$.getJSON('/data/user/info?callback=?', function(result) {
				if( result.data.batchDown == 1 ){
					$albumDown.show();
				}
			});
		}else{
			if( ting.userInfo.batchDown == 1 ){
				$albumDown.show();
			}
		}
	};

	$(".album-cover-hook").albumCover();

	$collectPlaylist.bind('click',function  () {
		$(this).collectPlaylist();
        return false;           
	});

	$(".album-add").click(function(e){
		var ids =$(this).data("adddata").ids,
			opt = {
				moduleName : $(this).data("adddata").moduleName
		};
		ting.media.addSong(ids , opt);
		$(this).tip();

		$(this).tip("tipup",{msg:"添加成功！", iconClass:"tip-success"});

        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("add_album");
        }
        /* 点击统计 end by lutaining */

		return false;
	});

	$('.song-list-hook').songList({
		type : "album",
		data : {
			albumname : albumName
		}
	});


  $albumDown.bind("click", function () {
    var ids = $(this).data("downdata").ids,
      albumName = $(this).data("downdata").albumname,
      singerName = $(this).data("downdata").author;

    ting.media.downloadAll(ids, {type: 'album', title: albumName, author: singerName});
    return false;
  });

	$albumDown.bind("mousedown",function(){
		var songNum = $(this).data("downdata").ids.length;
		ting.logger.log( "down_album" ,{ page: ting.logger.getPage() , song_num : songNum  } );
	});
	//$albumDown.tooltip({str: "VIP优先体验下载专辑功能"}).tooltip("show");


	/*
	changeBatchDownStatus();
           
	$(document).on('logined', function() {
        changeBatchDownStatus();
    });
	*/

	$(".des-more-hook").toggle(function(){
		$(".album-info .description").hide();
		$(".album-info .description-all").show();
		$(".mod-song-list").addClass("info-expand");
		$(".album-recommend").addClass("info-expand");
		$(this).text("收起");
		return false;
	},function(){
		$(".album-info .description-all ").hide();
		$(".album-info .description").show();
		$(".mod-song-list").removeClass("info-expand");
		$(".album-recommend").removeClass("info-expand");
		$(this).text("展开");	
		return false;
	});

	$('.page-navigator-hook a').refreshTrigger({
		target:'.album-recommend-list'
	});		

	ting.logger.exposureAndAnchorClickLog("m_album", [
		{
			root: $(".mod-other-list"),
			logName: "otheralbum",
			returnFalseSelector: [".play-icon"]
		}
	]);
  /**
   * 百度音乐客户端浮层事件注册
   */
  var pcTipsTID;
  $('.bd-music-setup').on('mouseenter', function(){
    var obj = $('.pc-tips');
    ting.loadChildImages(obj, arguments.callee);
    obj.show();
    ting.logger.log("exposure", {
      page: ting.logger.getPage(),
      expoitem: 'pannel_dl_qianqian'
    });
  }).on('mouseleave', function(){
      pcTipsTID = setTimeout(function(){
        $('.pc-tips').hide();
      },100);
    });
  $('.pc-tips').on('mouseenter', function(){
    clearTimeout(pcTipsTID);
  }).on('mouseleave', function(){
      $(this).hide();
    }).on('click', function(){
      ting.logger.log('click', {
        pos: 'dl_qianqian',
        page: 'panel',
        sub: ting.logger.getPage()
      });
    });
  /**
   * 点击iPhone客户端弹出二维码
   */
  $('.ios-icon').click(function(){
    var leftOffset = $(this).position().left - 167 || 257;
    var obj = $('.ios-tips');
    ting.loadChildImages(obj, arguments.callee);

    obj.css('display') === 'none' ? obj.css('left', leftOffset).fadeIn() : obj.fadeOut();
    return false;
  });
  $('.ios-tips .close').click(function(){
    $('.ios-tips').fadeOut();
    return false;
  });
    $(".bd-music-setup,.android-icon,.ios-icon",$(".guide-to-mobile")).bind('click', function  () {
    	ting.logger.plogClick($(this).data("log").pos);
    });
});//end domready
/*_JCH_site/sns/module/jch/jch_mod_download_clients.html.tpl_text/javascript */

    /**
     * 百度音乐客户端浮层事件注册
     */
    var pcTipsTID;
    $('.clients-pc').on('mouseenter',function () {
        var obj = $('.pc-tips');
        ting.loadChildImages(obj, arguments.callee);
        obj.show();
        ting.logger.log("exposure", {
            page: ting.logger.getPage(),
            expoitem: 'pannel_dl_qianqian'
        });
    }).on('mouseleave', function () {
            pcTipsTID = setTimeout(function () {
                $('.pc-tips').hide();
            }, 100);
        });
    $('.pc-tips').on('mouseenter', function () {
        clearTimeout(pcTipsTID);
    }).on('mouseleave', function () {
            $(this).hide();
        }).on('click', function () {
            ting.logger.log('click', {
                pos: 'dl_qianqian',
                page: 'panel',
                sub: ting.logger.getPage()
            });
        });
    /**
     * 点击iPhone客户端弹出二维码
     */
    $('.clients-iphone').click(function(){
        var leftOffset = 295;
        var obj = $('.ios-tips');
        ting.loadChildImages(obj, arguments.callee);

        obj.css('display') === 'none' ? obj.css('left', leftOffset).fadeIn() : obj.fadeOut();
        return false;
    });
    $('.ios-tips .close').click(function(){
        $('.ios-tips').fadeOut();
        return false;
    });
    /**
     * 统计
     */
    $(".clients-iphone,.clients-pc,.clients-iphone,.clients-ipad",$("#download-clients")).bind('click', function  () {
        ting.logger.plogClick($(this).data("log").pos);
    });
/*_JCH_*/
