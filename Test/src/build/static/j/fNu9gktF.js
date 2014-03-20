function initCollection(songId) {
	var dataUrlPrefix = "/data/user/isCollect?type=song&ids=",
		collectBtn;

	if (songId) {
		collectBtn = $(".song-collect");
		
		/*由于需要实时判断歌曲的收藏状态 所以需要实时调用， 若写入connect接口，即便不需要登录也会根据errCode让用户登录，所以此处不需要走统一接口*/
		$.ajax({
			url: dataUrlPrefix + songId + "&r=" + Math.round(Math.random() * 100000) + (new Date()).getTime(),
			dataType:"json",
			success: function(result) {
				// result.data 为null 是未登录
				if(!result.data ){
					collectBtn.css("display", "inline-block");
				}else{
					// 登录情况下
					if(result.data.isCollect === 1){
						collectBtn.css("display", "inline-block").addClass("song-collect-cancel btn-d");
						$(".txt", collectBtn).html("已收藏");
						
					}else if(result.data.isCollect === 0){
						collectBtn.css("display", "inline-block");
					}
				}
				// collectBtn.tooltip({str: "<a href ='/doc/cloud' target = '_black'>什么是云音乐？</a>"}).tooltip("show");
			}
		});
	}
}

// function showMyCloudTip () {
// 	var cookieName = "collect_tip",
// 		isShown = $.cookie(cookieName);

// 	if (isShown)	return;

// 	var $tip = $("#my_cloud_big_tip"),
// 		$close = $tip.find(".btn-close");

// 	if (!$tip.length || !$close.length)	return;

// 	$tip.floatLayer().floatLayer("show");
// 	$tip.find(".btn-close").unbind("click").click(function () {
// 		$tip.floatLayer("hide");
// 		return false;
// 	});

// 	$.cookie(cookieName, 1, { path: "/", expires: 365 });
// }


$(function () {
    // 首次点击统计
    var clicklog_holder = [
            $('.clicklog-path-navigator'), $('.clicklog-info'), $('.clicklog-play-btn'), $('.clicklog-lyric'), $('.clicklog-voice'), $('.clicklog-hot'), $('.clicklog-albums')],
        first_clicked = false,
        time_start = (new Date).getTime();

    function init_first_click(elem, i) {
        elem.click(function (i) {
            return function () {
                if (!first_clicked) {
                    var logurl = "/static/images/v.gif?pid=304&url=&v=1.0.0&type=firstclick",
                        interval = (new Date).getTime() - time_start,
                        imgId = "ting_" + Math.round(Math.random() * 100000) + (new Date()).getTime(),
                        img = window[imgId] = new Image(1, 1);

                    logurl += '&index=' + i;
                    logurl += '&time=' + interval;

                    img.onload = (img.onerror = function () {
                        window[imgId] = null;
                    }); //对Image()对象添加事件监听，以便快速释放对象资源
                    img.src = logurl;
                    img = null;

                    // 该请求，在下一个版本时删除
                    ting.logger.log('firstclick', {
                        index: i,
                        time: interval
                    });

                    first_clicked = true;
                }
            }
        }(i + 1));
    }

    for (var i = 0; i < clicklog_holder.length; i++) {
        init_first_click($('a', clicklog_holder[i]), i);
    }

    //
    // +++++++++ 本页内容开始 +++++++++++++++
    //
    var lyricSwitch = $("#lyricSwitch"),
        lyricSwitchText = $(".text", lyricSwitch),
        lyricCont = $("#lyricCont"),
        unfold = true;

    if (lyricSwitch[0]) {
        lyricSwitch.click(function () {
            if (unfold) {
                lyricCont.removeClass('lyric-hidden');
                lyricSwitchText.text("收起");
                $(this).addClass("lyric-close");
                unfold = false;
            } else {
                lyricCont.addClass('lyric-hidden');
                lyricSwitchText.text("展开");
                $(this).removeClass("lyric-close");
                unfold = true;
            }

            return false;
        });
    }

    if (window.location.hash == '#song_lyric') {
        if (lyricSwitchText[0] && lyricSwitchText.text() == "展开") {
            lyricSwitch.click();
        }
    }

    var collectBtn = $(".song-collect");

    collectBtn.live("click", function (e) {
        var me = $(this),
            param = me.data("btndata");

        if (me.hasClass("song-collect-cancel btn-d")) {
            ting.connect.deleteCollection(null, param, function (result) {
                $(".txt", me).html("收藏");
                me.removeClass("song-collect-cancel btn-d");
                ting.media.collectSong(param.ids, {
                    cancel: true
                });
            }, function (result) {
                me.tip();
                me.tip("tipup", {
                    msg: result.errorMessage || "操作失败，请稍候再试",
                    iconClass: "tip-error"
                });
            });
        } else {
            ting.connect.collect(null, param, function (result) {
                me.addClass("song-collect-cancel btn-d");
                $(".txt", me).html("已收藏");
                // me.tip("tipup",{msg:"已保存到我的收藏",iconClass:"tip-success"});
                // showMyCloudTip();

                //bdbrowser effect
                if (ting.browser.isSpecial()) {
                    ting.browser.add2box('collect');
                }
                ting.media.collectSong(param.ids);
            }, function (result) {
                me.tip();
                var tipIcon = "tip-error";

                switch (result.errorCode) {
                    case  22322 :
                        result.errTip = "歌曲已收藏";
                        break;
                    case  22331 :
                        result.errTip = "云空间已满，去<a href ='http://yinyueyun.baidu.com/' target = '_blank'>整理云空间</a>吧！";
                        break;

                    case  22232 :
                        result.errTip = "对不起，百度音乐只能在中国内地提供服务";
                        break;

                    default :
                        result.errTip = "操作失败，请稍候再试";
                        break;

                }
                var tipParam = {msg: result.errTip ? result.errTip : "操作失败", iconClass: tipIcon};
                if (result.errorCode = 22331) {
                    tipParam.showTime = 5000;
                }
                ;
                me.tip("tipup", tipParam);
            });
        }
        return false;
    });


    $(".play-all-btn").click(function (e) {
        var ids = $(this).data("playdata").ids,
            opt = {
                moduleName: $(this).data("playdata").moduleName
            };
        ting.media.playSong(ids.split(','), opt);
        $(this).tip().tip("tipup", {
            msg: "已开始播放",
            iconClass: "tip-success"
        });

        //bdbrowser effect
        if (ting.browser.isSpecial()) {
            ting.browser.add2box('play');
        }

        return false;
    });
    // var lrcdata = $("#lyricCont").text();
    /*
     $('.copy-lyric-hook').zeroClipboard({
     clipText: lrcdata
     }).tip({
     msg: '复制成功',
     iconClass: 'tip-success'
     }).bind('zeroclipboard.complete', function() {
     $(this).tip('tipup');
     });
     */

    // $('.copy-lyric-hook')[0].setAttribute("data-clipboard-target","lyricCont")
    var clipboard = new ZeroClipboard($('#copy-lyric')[0], {
        moviePath: "/static/flash/ZeroClipboard.swf"
    });
    clipboard.on('load', function () {
        $('.copy-lyric-hook').show();
    });
    $('.copy-lyric-hook').tip({
        msg: '复制成功',
        iconClass: 'tip-success'
    });

    clipboard.on('complete', function (client, args) {
        //	alert(1111)
        $('.copy-lyric-hook').tip('tipup');
    });


    $(".page-navigator-hook").pageNavigator({
        hash: '#song-comment'
    });

    $('.page-navigator-hook a').refreshTrigger({
        target: '.album-recommend-list'
    });

    $('.play-btn').tip().click(function () {
        var self = $(this),
            playData = self.data('playdata') || {},
            id = playData.id,
            opt = {
                moduleName: playData.moduleName
            };

        //检查歌曲是否可以播放
        if (!id) {
            return false;
        }

        ting.media.playSong(id, opt);
        $(this).tip("tipup", {
            msg: "已开始播放",
            iconClass: "tip-success"
        });

        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("play_song");
        }
        /* 点击统计 end by lutaining */

        //bdbrowser effect
        if (ting.browser.isSpecial()) {
            ting.browser.add2box('play');
        }

        return false;
    });

    var $addBtn = $('.add-song-btn'),
        $add2Web = $('<a class="add2web" href="#">添加到音乐盒</a>'),
        $add2Client = $('<a class="add2client" href="#">添加到PC端</a>'),
        $addLayer = $('<div class="addlayer"></div>').append($add2Web).append($add2Client).appendTo($addBtn).hide(),
        addData = $addBtn.data('adddata') || {},
        id = addData.id;

    if (id) {
        $addBtn.hover(
            function() {
                $addLayer.show();
            },
            function() {
                $addLayer.hide();
            }
        ).tip();

        $add2Web.add($addBtn).click(function () {
            var opt = {
                    moduleName: addData.moduleName
                };
            ting.media.addSong(id, opt);
            $addBtn.tip("tipup", {
                msg: "添加成功！",
                iconClass: "tip-success"
            });

            /* 点击统计 start by lutaining */
            if (ting && ting.logger && ting.logger.plogClick) {
                ting.logger.plogClick("add_song");
            }
            /* 点击统计 end by lutaining */

            //bdbrowser effect
            if (ting.browser.isSpecial()) {
                ting.browser.add2box('play');
            }

            return false;
        });
        ting.openApp.init();
        var $loading = $('<i class="openapp-loading loading"></i>');
        $loading.css({float: "left", margin: 3}).insertAfter($addBtn).hide();

        $add2Client.click(function(e) {
            $loading.show();
            e.preventDefault();
            e.stopPropagation();
            var data = {
                songIds: id,
                rate: 320
            };
            openApp.addSong(data, {
                success: function() {
                    $addBtn.tip("tipup", {
                        msg: "添加成功！",
                        iconClass: "tip-success"
                    });
                },
                error: function() {
                    $addBtn.tip("tipup", {
                        msg: "添加失败！",
                        iconClass: "tip-error"
                    });
                },
                complete: function() {
                    $loading.hide();
                }
            }, null, {
                appUrl: 'http://music.baidu.com/pc/download/BaiduMusic-12345648.exe'
            });
        });
    }

    // 下载歌词
    $('.down-lrc-btn').click(function () {
        window.location = $(this).data("lyricdata").href;
        return false;
    });

    // 下载歌曲
    $('.down-song-btn').click(function () {
        var obj = $(this),
            id = obj.data("btndata").id;

        if (obj.hasClass('jsClientsDownload')) {
            var isChinaVoice = obj.hasClass('chinavoice');
            ting.clientsDownload.download(id, isChinaVoice);
        } else {
            ting.media.downloadSong(id);
        }

        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("down_song");
        }
        /* 点击统计 end by lutaining */

        return false;
    });


    $(".high-rate-icon").bind('click', function () {
        var sid = $(this).data("id");

        ting.media.downloadSong(sid);
        return false;
    });

    var $otherVersions = $(".other-versions"),
        $myVersions = $(".myversion-song"),
        $qunxing = $(".qunxin-song"),
        $hotSong = $(".hot-song"),
        $tag = $(".base-info .tag"),
        $mv = $(".module-mv"),
        $film = $(".film");

    var exposureAndAnchorClickLogList = [
        {
            root: $otherVersions,
            logName: "version",
            returnFalseSelector: [".img-link", ".play"]
        },
        {
            root: $myVersions,
            logName: "myversion",
            returnFalseSelector: [".list-micon"]
        },
        {
            root: $qunxing,
            logName: "qunxing",
            returnFalseSelector: [".list-micon", ".btn"]
        },
        {
            root: $hotSong,
            logName: "otherhotsong",
            returnFalseSelector: [".list-micon", ".btn"]
        },
        {
            root: $tag,
            logName: "tag",
            returnFalseSelector: []
        },
        {
            root: $mv,
            logName: "mv",
            returnFalseSelector: []
        },
        {
            root: $film,
            logName: "film",
            returnFalseSelector: []
        }
    ];

    ting.logger.exposureAndAnchorClickLog("m_song", exposureAndAnchorClickLogList);

    /*
     // 不同版本的歌曲
     if ($otherVersions.length && ting && ting.logger) {
     ting.logger.log("exposure", {
     expoitem: "version",
     page: "m_song"
     });

     $otherVersions.find("a").click(function () {
     var $me = $(this);
     ting.logger.log("click", {
     pos: "version",
     page: "m_song"
     });
     return !($me.hasClass(".img-link") || $me.hasClass(".play"));
     });
     }
     // 自己不同版本的歌曲
     if ($myVersions.length && ting && ting.logger) {
     ting.logger.log("exposure", {
     expoitem: "myversion",
     page: "m_song"
     });

     $myVersions.find("a").click(function () {
     var $me = $(this);
     ting.logger.log("click", {
     pos: "myversion",
     page: "m_song"
     });
     return !$me.hasClass(".list-micon");
     });
     }

     // 群星专辑中其他歌曲
     if ($qunxing.length && ting && ting.logger) {
     ting.logger.log("exposure", {
     expoitem: "qunxing",
     page: "m_song"
     });

     $qunxing.find("a").click(function () {
     var $me = $(this);
     ting.logger.log("click", {
     pos: "qunxing",
     page: "m_song"
     });
     return !($me.hasClass(".list-micon") || $me.hasClass(".btn"));
     });
     }

     // 其他热门歌曲
     if ($hotSong.length && ting && ting.logger) {
     ting.logger.log("exposure", {
     expoitem: "otherhotsong",
     page: "m_song"
     });

     $hotSong.find("a").click(function () {
     var $me = $(this);
     ting.logger.log("click", {
     pos: "otherhotsong",
     page: "m_song"
     });
     return !($me.hasClass(".list-micon") || $me.hasClass(".btn"));
     });
     }
     */


    var relatedList = $(".related-list");
    relatedList.find(".img-link, .play").bind("click", function () {
        var $me = $(this),
            songId;

        if (!$me.hasClass("play")) {
            $me = $me.parents("li").find(".play");
        }

        songId = $me.attr("href").replace("/song/", "").replace(/#.*$/, "");

        if (!songId.length) return false;
        ting.media && ting.media.playSong(songId, {
            moduleName: "versionBtn"
        });

        return false;
    });


    $('.play-all-hook').click(function () {
        var type = $(this).data("type"),
            opt = {
                moduleName: type
            },
            no = $(this).data("no") || "";
        if (no) {
            type = type + "_" + no;
        }
        ting.media.playTop(type, opt);
        $(this).tip().tip("tipup", {
            msg: "已开始播放",
            iconClass: "tip-success"
        });

        //bdbrowser effect
        if (ting.browser.isSpecial()) {
            ting.browser.add2box('play');
        }
        return false;
    });
    $(".bd-music-setup,.android-icon,.ios-icon", $(".guide-to-mobile")).bind('click', function () {
        ting.logger.plogClick($(this).data("log").pos);
    });

    var ua = navigator.userAgent.toLowerCase();
    var isWindows = (ua.indexOf("windows") != -1 || ua.indexOf("win32") != -1);
    if (isWindows) {
        $(".btn-telapp").css("display", "inline-block");
    }

    $('.lossless-hook').on('click', function () {
        var sid = $(this).data('id');

        ting.media.downloadSong(sid, 1000);
        return false;
    });

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
    $('.pc-tips').on('mouseenter',function () {
        clearTimeout(pcTipsTID);
    }).on('mouseleave',function () {
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
    $('.clients-iphone').click(function () {
        var leftOffset = 295;
        var obj = $('.ios-tips');
        ting.loadChildImages(obj, arguments.callee);

        obj.css('display') === 'none' ? obj.css('left', leftOffset).fadeIn() : obj.fadeOut();
        return false;
    });
    $('.ios-tips .close').click(function () {
        $('.ios-tips').fadeOut();
        return false;
    });

    /**
     * 统计
     */
    $(".clients-iphone,.clients-pc,.clients-iphone,.clients-ipad", $("#download-clients")).bind('click', function () {
        ting.logger.plogClick($(this).data("log").pos);
    });
    /*_JCH_*/

    $('.song-share').hoverShow($('#bdshare'), {delay: 500});
});
