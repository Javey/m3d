$(function(){


	
	var artistnameEncode = encodeURIComponent(window.artistname);
		link = {
			img : "http://image.baidu.com/i?ct=201326592&cl=2&nc=1&lm=-1&st=-1&tn=baiduimage&istype=2&fm=&pv=&z=0&ie=utf-8&word=" + artistnameEncode,
			tieba : "http://tieba.baidu.com/f?ie=utf-8&kw=" + artistnameEncode
		};
	$("#artistImgLink").bind("click",function(){

		$(this).attr("href" , link.img )
				.attr("target" , "_blank");
	});
	$("#artistTieba").bind("click",function(){
		$(this).attr("href" , link.tieba )
				.attr("target" , "_blank");
	});



	$(".play-all-hook").click(function(){
		/*如果RD没有top50数据则从当前的20首歌曲取id*/
		var ids =$(this).data("ids") ? $(this).data("ids").toString().split(",") : $(this).data("playdata").ids,
			opt = {
				moduleName : $(this).data("playdata").moduleName
			};
		ting.media.playSong(ids,opt);
		$(this).tip().tip("tipup", {
                        msg: "已开始播放",
                        iconClass: "tip-success"
                    });
        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("play_all");
        }
        /* 点击统计 end by lutaining */

        //bdbrowser effect
        if(ting.browser.isSpecial()){
            ting.browser.add2box('play');
        }
		return false;
	});
	// $(".rool-hook").roll();
	$(".song-list-hook").songList();
	$(".album-cover-hook").albumCover();

	var playFmBtn = $(".btn-singer-fm"),
		artistEncode= encodeURIComponent( playFmBtn.attr("artist") );
		playFmBtn.attr('href','http://fm.baidu.com/#/channel/public_artist_'+artistEncode);
	
	$('.album-list .songlist-fold-hook').songlistExpand({
		hotBar : true,
		moduleName : "album"
	});
	$("#singerWorks").tab({
		callBackStartEvent : function(index){
            $("img" , $(".ui-tab-content")[index]).each(function(){
                var org_src = $(this).attr("org_src"),
                    src = $(this).attr("src");
                if( org_src != src ){
                    $(this).attr("src", org_src );
                }
           })
        }
	});



	var goWorksScrollTop = function(){
		var $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body');
		var singerWorksScrollTo = $('#singerWorks').offset().top;
		$body.stop().animate({ scrollTop: singerWorksScrollTo}, 200);
	};

	/*歌曲翻页*/
    var curStart = 0;
	var songPageNavigator = $('#singerWorks .songs-list .page-navigator-hook').pageNavigator();
		songPageNavigator.bind('pagenavigator.pagechange',function(e, data){
			var obj ={
					start     : data.start,
					worksList : $("#songList")
				},
				opt = getWorksData(obj);
				opt.order = $('#singerWorks .songs-list .sort .on').attr("type");
				opt.hotmax = hotbarMax;
				
			createMask(obj);

			ting.connect.getArtistSong(opt,null,function(result){
				$(".song-list-wrap",obj.worksList).html(result.data.html);
				removeMask(obj);
				$(".song-list-hook",obj.worksList).songList();
				$(".music-icon-hook",obj.worksList).musicIcon();
				//回到列表首部
				goWorksScrollTop();
			});
		});


	/*排序*/
    var songSort = $('#singerWorks .songs-list .sort a');
		songSort.click(function(e){
			e.stopPropagation();
			if( $(this).hasClass("on") ){
				return false;
			};
			var obj ={
					start     : 0,
					worksList : $("#songList")
				},
				opt = getWorksData(obj);
				opt.order = $(this).attr("type");
				opt.hotmax = hotbarMax;
				
			createMask(obj);
			ting.connect.getArtistSong(opt,null,function(result){
				$(".song-list-wrap",obj.worksList).html(result.data.html);
				removeMask(obj);
				$(".song-list-hook",obj.worksList).songList();
				$(".music-icon-hook",obj.worksList).musicIcon();
			},function(){});
			$(this).addClass("on")
					.siblings("a").removeClass("on");
			$('#singerWorks .songs-list .page-navigator-hook').pageNavigator("setPage",1);
			return false;
			
		});

	/*专辑翻页*/
	var albumPageNavigator = $('#singerWorks .albums-list .page-navigator-hook').pageNavigator();
		albumPageNavigator.bind('pagenavigator.pagechange',function(e, data){
			var obj ={
					start     : data.start,
					worksList : $("#albumList")
				},
				opt = getWorksData(obj);
				opt.order = $('#singerWorks .albums-list .sort .on').attr("type");

			createMask(obj);
			ting.connect.getArtistAlbum(opt,null,function(result){
				$(".album-list-wrap",obj.worksList).html(result.data.html);
				removeMask(obj);
				$('.album-list .songlist-fold-hook',obj.worksList).songlistExpand({
					hotBar : true,
					moduleName : "album"
				});
				$(".album-cover-hook",obj.worksList).albumCover();

				goWorksScrollTop();
			});
		});


		var albumSort = $('#singerWorks .albums-list .sort a');
		albumSort.click(function(e){
			e.stopPropagation();
			var obj ={
					start     : 0,
					worksList : $("#albumList")
				},
				opt = getWorksData(obj);
				opt.order = $(this).attr("type");
				
			createMask(obj);
			ting.connect.getArtistAlbum(opt,null,function(result){
				$(".album-list-wrap",obj.worksList).html(result.data.html);
				removeMask(obj);
				$('.album-list .songlist-fold-hook',obj.worksList).songlistExpand({
					hotBar : true,
					moduleName : "album"
				});
				$(".album-cover-hook",obj.worksList).albumCover();
			},function(){});
			$(this).addClass("on")
					.siblings("a").removeClass("on");
			$('#singerWorks .albums-list .page-navigator-hook').pageNavigator("setPage",1);
			return false;
		});


	/* MV翻页*/
	var mvPageNavigator = $('#singerWorks .mvs-list .page-navigator-hook').pageNavigator(),
		mvSort = $('#singerWorks .mvs-list .sort a'),
		mvPageNavFactory = function (afterConnect, afterAll) {
			return function(e, data){
				var that = this,
					obj ={
						start     : data ? data.start : 0,
						worksList : $("#mvList")
					},
					opt = getWorksData(obj);
					opt.order = $('#singerWorks .mvs-list .sort .on').attr("type");

				createMask(obj);
				ting.connect.getArtistMV(opt,null,function(result){
					$(".mv-list-wrap",obj.worksList).html(result.data.html);
					ting.LL && ting.LL.add($(".lazyload", obj.worksList));
					removeMask(obj);
					//goWorksScrollTop();
					afterConnect && afterConnect.call(that);
				});

				afterAll && afterAll.call(that);

				return false;
			};
		},
		mvSortClick = function () {
			$(this).addClass("on").siblings("a").removeClass("on");
			$('#singerWorks .mvs-list .page-navigator-hook').pageNavigator("setPage",1);
		};

	mvPageNavigator.bind('pagenavigator.pagechange', mvPageNavFactory(goWorksScrollTop, null));
	mvSort.click(mvPageNavFactory(null, mvSortClick));

	/*相册翻页*/
    var photoPageSize = 12;
    var photoCurPage = -1;
    var getPhotoOfPage = function (start) {
        var page = parseInt(start / photoPageSize),
            obj, opt, pageStart;

        if (!page && page !== 0) {
            return;
        }

        if (page == photoCurPage) {
            return; 
        } 

        photoCurPage = page;
        curStart = page * photoPageSize;

        obj = {
            start     : curStart,
            worksList : $("#photoList")
        };

        opt = getWorksData(obj);
        opt.size = photoPageSize;
        //opt.p = 1;

        createMask(obj);

        ting.connect.getArtistPhotos(opt, null, function(result){
            $(".photo-list-wrap",obj.worksList).html(result.data.html);
				removeMask(obj);
            
            goWorksScrollTop();
        });
        photoPageNavigator.pageNavigator("setPage", photoCurPage + 1);
    };

	var photoPageNavigator = $('#singerWorks .photos-list .page-navigator-hook').pageNavigator();
		photoPageNavigator.bind('pagenavigator.pagechange',function(e, data){
            getPhotoOfPage(data.start);
		});


	var getWorksData = function(obj){
		var $baseInfo = $("#baseInfo"),
			opt = { 
				start    : obj.start,
				ting_uid : $baseInfo.attr("ting_uid")
			};
		return opt;
	};

	var createMask = function(obj){
			$mask    = $("<div>").attr("class","ajax-mask").css("height",obj.worksList.height());
			$maskBox = $("<div>").attr("class","ajax-mask-box")
								 .html("加载中...");
			obj.worksList.css({"position":"relative","zoom":1})
				.append($mask)
				.append($maskBox);
	};

	var removeMask = function(obj){
			$mask    = $("<div>").attr("class","ajax-mask");
			$maskBox = $("<div>").attr("class","ajax-mask-box")
			$(".ajax-mask",obj.worksList).remove();
			$(".ajax-mask-box",obj.worksList).remove();
	};

	var photoInfo = $(".photos-info"),
		photoView = $(".phpto-view");

    /*
    $(".photo-list .photo-item").click(function () {
        return false;
    });
    */

	$(".photo-list").delegate(".photo-item", "click", function () {
		var url = $("a" , $(this)).attr("href").split("#")[1] || "",
			href = window.location.href,
			obj = {
				id 	  : url.split("-")[0],
				index : url.split("-")[1]
			};

		window.location.href = href.split("#")[0] + "#" + obj.id + '-' + obj.index;
		photoView.show();
		photoInfo.hide();
		//initPhotoView(obj);
        viewHook.photoview("ajaxdata", curStart + parseInt(obj.index), obj.index);

		return false;
	});
	$(".phpto-view .back").click(function(){
		photoView.hide();
		photoInfo.show();
		return false;
	});


    var viewHook = $(".photo-view-hook");
    var picPageSize = 12;

	var initPhotoView = function(obj){
		var p_id = obj.id,
			p_index = obj.index;

        viewHook.photoview({
            id: p_id,
            total: viewHook.attr("total"),
            prebtn: ".photo-pre",
            nextbtn: ".photo-next",
            ajaxParam: {
                "ting_uid":viewHook.attr("ting_uid"),
                type: "fans",
                size: picPageSize,
                start: p_index
            }
        }).bind('photoview.loadinfo', function(e, obj) {
            var photo = obj.currentInfo,
                index = obj.p_index * 1 + 1,
                opt = obj.options;

            getPhotoOfPage(obj.p_index);

            if (index == 1) {
                opt.prebtn && $(opt.prebtn).addClass("disable");
            } else {
                opt.prebtn && $(opt.prebtn).removeClass("disable");
            }
            if (index == opt.total) {
                opt.nextbtn && $(opt.nextbtn).addClass("disable");
            } else {
                opt.nextbtn && $(opt.nextbtn).removeClass("disable");
            }
            // $(".upload-time").html(photo.create_time);
            $(".photo-order").html(index);
        }).photoview("ajaxdata");

			

        $(".photo-pre ,.photo-next").bind("click",	function(e) {
            if ($(e.currentTarget).hasClass("photo-pre")) {
                $(".photo-view-hook").photoview("getNext", -1)
            }
            if ($(e.currentTarget).hasClass("photo-next")) {
                $(".photo-view-hook").photoview("getNext", 1)
            }
            return false;
        });
	};

    initPhotoView({
        id: 0,
        index: 0
    });


	var initNum = 0,
		end = false;
	$("#updateArtist").bind("click",function(){
		var list = $(".related-list"),
			curlist = $(".related-list:visible");

		curlist.hide()
		++initNum;

		if(initNum >= list.length){
			initNum = 0;
			end = true;
		}

		if(!end){
			$( ".cover img" , $(list[initNum]) ).each( function(){
                var org_src = $(this).attr("org_src"),
                    src = $(this).attr("src");
                if( org_src != src ){
                    $(this).attr("src", org_src );
                }
            });
        }
		$(list[initNum]).show();

		return false;
	});
    // 相似歌手统计
    $(".related-list li").bind("click",function(){
    	var parentdata = $(this).parent().data("data"),
    		thisdata = $(this).data("data");

	    var opt = {
	    	page : "m_artist",
	    	pos  : "commend",
	    	method : thisdata.m,
	    	test : parentdata.t,
	    	starid_page : parentdata.id,
	    	starid_click : thisdata.id
	    };

	    ting.logger.log("click", opt );	
    });


    if($('.related-singer').length){
    	var opt ={
    		ref  : 'music_web',
    		page : 'm_artist',
    		artistname : artistname,
    		expoitem: 'similarartist'
    	}
    	ting.logger.log("exposure",opt);
    }


	ting.logger.exposureAndAnchorClickLog("m_artist", [
		{
			root: $(".mod-newsong"),
			logName: "newalbum",
			returnFalseSelector: []
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

});

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

  // 百科简介统计
  $('#baike_artist').on('click', function(){
    ting.logger.plogClick('jianjie');
  });