(function ($, undefined) {
    var queryname = $('#ww').val();
    songitems = $('.song-list li'),
        opts = {
            page: 'c_tag_d',
            queryname: queryname
        },
        songid = 0;

    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    }

    var tagstyle = $(".tag-main").data("tagstyle");
    if (tagstyle) {
        opts.tag = tagstyle;
    }
    ting.logger.log('exposure_pv', opts);


    var pagenum = getUrlParam('start') ? (getUrlParam('start') / getUrlParam('size')) : 0;
    pagenum = pagenum + 1;

    opts.pagenum = pagenum;
    function getPos(t) {
        var $tag = $(t), tagName = t.tagName.toLowerCase(), pos = '';
        if (tagName === 'a' || $tag.parents('a').length) {
            var $lnk = (tagName === 'a' ? $tag : $tag.parents('a'));
            if ($lnk.hasClass('list-micon')) {
                if ($lnk.hasClass('icon-play')) {
                    pos = 'play_song';
                } else if ($lnk.hasClass('icon-add')) {
                    pos = 'add_song';
                } else if ($lnk.hasClass('icon-download')) {
                    pos = 'down_song';
                }
            } else {
                if ($lnk.parents('.song-title').length) {
                    pos = 'song_name';
                } else if ($lnk.parents('.singer').length) {
                    pos = 'artist_name';
                } else if ($lnk.parents('.album-title').length) {
                    pos = 'album_name';
                }
            }
        }
        return pos;
    }

    var clickLogged = false;
//	$(".music-icon-hook a").bind("mousedown",function(e){
//		songid = $(this).parents().data("musicicon").id;
//		pos = getPos(e.target);
//		opts.pos = pos;
//		opts.songid = songid;
//    if(!clickLogged){
//      clickLogged = true;
//      opts.logtype = 'click_pv';
//    }else{
//      opts.logtype = 'click_num';
//    }
//
//		ting.logger.log('click',opts);
//	});
    songitems.bind('mousedown', function (e) {
        var songid = $(this).data('songitem').songItem.sid,
            pos = getPos(e.target);
        opts.songid = songid;

        if (pos) {
            if (!clickLogged) {
                clickLogged = true;
                opts.logtype = 'click_pv';
            } else {
                opts.logtype = 'click_num';
            }
            opts.pos = pos;
            ting.logger.log('click', opts);
        }
    });
  $("#rec_tag .item-tag ").bind('mousedown', function (e) {
    var pos = "recommend_tag";
    if (pos) {
      if (!clickLogged) {
        clickLogged = true;
        opts.logtype = 'click_pv';
      } else {
        opts.logtype = 'click_num';
      }
      opts.pos = pos;
      ting.logger.log('click', opts);
    }
  });
//流派详情
//热门歌手轮播
    var isie6 = ($.browser.msie && $.browser.version == "6.0") ? true : false;

    var artistList = $("#artistList"),
        focus = $(".artist-list"),
        focusWrap = $(".wrap", focus),
        list = $("li", focusWrap),
    // 滚动宽度
        width = parseInt($("ul", focus).width()),
    // 切换动画，如果是left或者right左右切换，item则渐隐渐显
        effect = null,
    // 当前处于焦点图的索引，默认第一张
        curIndex = 0,
        item = $(".artist-focus-page a"),
        tab = item.parent(),
        clickType = isie6 ? "btn" : "item",
    // 动画时间
        clickTime = true,

    // 记录点击是否仍为当前元素
        e = 0,
    // 是否自动切换
        focusAuto = true,
    // 切换时间
        interval = 7000,
    // 自动切换动画函数
        autoAnimate = null;
    /*****焦点组件参数end*****/

    $(" .right-btn", artistList).bind("click", function () {
        // clickType ="btn";
        nextFocus();
        swidthAnimate(clickType);
        return false;
    });

    $(" .left-btn", artistList).bind("click", function () {
        // clickType ="btn";
        curIndex--;
        if (curIndex < 0) {
            curIndex = item.length - 1;
        }

        swidthAnimate(clickType);
        return false;
    });

    item.bind("click", function (e) {
        if ($(this).hasClass("page-active")) {
            return false;
        }
        e.preventDefault();
        curIndex = $(this).index();

        // clickType ="item";
        swidthAnimate(clickType);
        return false;
    });

    artistList.bind("mouseover", function () {
        clearInterval(autoAnimate);
        autoAnimate = null;
    });

    artistList.bind("mouseout", function () {
        if (focusAuto) {
            autoPlay();
        }
    });

    var nextFocus = function () {
        if (curIndex >= 0 && curIndex < item.length - 1) {
            curIndex++;
        } else {
            curIndex = 0;
        }

        if (curIndex > item.length - 1) {
            curIndex = item.length - 1;
            return false;
        }
    };

    var autoPlay = function () {
        autoAnimate = setInterval(function () {
            nextFocus();
            swidthAnimate();
        }, interval);
    };
    if (autoPlay) {
        autoPlay();
    }

    var swidthAnimate = function (clickType) {

        var curFocus = $($("ul", focusWrap)[curIndex]),
            img = $("img", curFocus);

        img.each(function (i, v) {
            img_src = $(v).attr("src"),
                img_org_src = $(v).attr("org_src");

            if (img_org_src != img_src) {
                $(v).attr("src", img_org_src);
            }
        });
        var clickType = "btn";
        var swidth = curIndex * width;
        effect = ( clickType == "btn" ) ? { left: -swidth } : { opacity: "0.3"  };
        focusWrap.stop(true, true).animate(
            effect,
            "100",
            function () {
                if (clickType != "btn") {
                    focusWrap.css("left", -swidth);
                    focusWrap.stop(true, true).animate({  opacity: '1' }, "normal");
                    clickTime = true;
                }

            }
        );

        changeTab();
    };
    // 切换tab焦点
    var changeTab = function () {
        item.removeClass("page-active");
        $(item[curIndex]).addClass("page-active");
    };

//展开流派说明
    $(".des-more-hook").toggle(function () {
        $(".style-desc .description").hide();
        $(".style-desc .description-all").show();
        $(this).find('span').text("收起");
        $(this).find('i').addClass("expand");
        return false;
    }, function () {
        $(".style-desc .description-all ").hide();
        $(".style-desc .description").show();
        $(this).find('span').text("展开");
        $(this).find('i').removeClass("expand");
        return false;
    });

    // 歌曲专辑tab
    $('#mod_works').tab();

    $('#albumList .album-cover-hook').albumCover();

    // 歌曲翻页
    var songPageNavigator = $('#mod_works .songs-list .page-navigator-hook').pageNavigator();
    songPageNavigator.bind('pagenavigator.pagechange', function (e, data) {
        var obj = {
                start: data.start,
                worksList: $("#songList")
            },
            opt = {
                start: obj.start,
                title: $('.target-tag .title').text()
            };

        createMask(obj);

        ting.connect.getStyleSongs(opt, null, function (result) {
            $(".song-list-wrap", obj.worksList).html(result.data.html);
            removeMask(obj);
            $(".song-list-hook", obj.worksList).songList();
            $(".music-icon-hook", obj.worksList).musicIcon();
            //回到列表首部
            location.hash = "list-top";
        });
    });


    // 专辑翻页
    var albumPageNavigator = $('#mod_works .albums-list .page-navigator-hook').pageNavigator();
    albumPageNavigator.bind('pagenavigator.pagechange', function (e, data) {
        var obj = {
                start: data.start,
                worksList: $("#albumList")
            },
            opt = {
                start: obj.start,
                title: $('.target-tag .title').text()
            };

        createMask(obj);
        ting.connect.getStyleAlbums(opt, null, function (result) {
            $(".album-list-wrap", obj.worksList).html(result.data.html);
            removeMask(obj);
            $('.album-list .songlist-fold-hook', obj.worksList).songlistExpand({
                hotBar: true,
                moduleName: "album"
            });
            $(".album-cover-hook", obj.worksList).albumCover();

            location.hash = "list-top";
        });
    });


    var createMask = function (obj) {
        $mask = $("<div>").attr("class", "ajax-mask").css("height", obj.worksList.height());
        $maskBox = $("<div>").attr("class", "ajax-mask-box")
            .html("加载中...");
        obj.worksList.css({"position": "relative", "zoom": 1})
            .append($mask)
            .append($maskBox);
    };

    var removeMask = function (obj) {
        $mask = $("<div>").attr("class", "ajax-mask");
        $maskBox = $("<div>").attr("class", "ajax-mask-box")
        $(".ajax-mask", obj.worksList).remove();
        $(".ajax-mask-box", obj.worksList).remove();
    };
    //专辑展开

    if ($.ting.songlistExpand) {
        $('.album-list .songlist-fold-hook').songlistExpand({
            hotBar: true,
            moduleName: "album"
        });
    }

    // tag详情页的songList批量操作按钮悬浮
    //$(".song-list-hook").songList().songList("floatBar");

    // 标签页面聚合特殊处理
    var operation = $(".join-operation");
    if (operation.length) {
        // 播放专辑按钮
        $(".play-album").on('click', function () {
            var self = $(this),
                ids = self.data('ids');

            if (ids) {
                ting.media.playSong(ids.split(','), {moduleName: "newTagPage"});
                self.tip().tip("tipup", {
                    msg: "已开始播放",
                    iconClass: "tip-success"
                });
            }
            return false;
        });

        var sids = operation.data("ids").split(",");
        operation.find(".play-selected-hook").on("click", function () {
            ting.media.playSong(sids, {moduleName: "newTagPage"});
            $(this).tip().tip("tipup", {
                msg: "已开始播放",
                iconClass: "tip-success"
            });

            /* 点击统计 start by lutaining */
            if (ting && ting.logger && ting.logger.plogClick) {
                ting.logger.plogClick("play_sel");
            }
            /* 点击统计 end by lutaining */
        });
        operation.find(".add-selected-hook").on("click", function () {
            ting.media.addSong(sids);
            $(this).tip("tipup", {msg: "添加成功！", iconClass: "tip-success"});
            /* 点击统计 start by lutaining */
            if (ting && ting.logger && ting.logger.plogClick) {
                ting.logger.plogClick("add_sel");
            }
            /* 点击统计 end by lutaining */
        });
        operation.find(".collect-selected-hook").on("click", function () {
            var self = $(this);
            ting.connect.collect(null, {ids: sids.join(','), type: 'song'}, function (result) {
                //self.tip("tipup",{msg:"已保存到我的收藏",iconClass:"tip-success"});

            ting.media.collectSong(sids.join('_'));
            }, function (result) {
                //针对重复喜欢做特殊处理
                var tipIcon = "tip-error";

                switch (result.errorCode) {
                    case  22322 :
                        tipIcon = "tip-warning";
                        result.errTip = "歌曲已被保存";
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
                self.tip().tip("tipup", tipParam);
            });

            return false;
        });
        operation.find(".down-selected-hook").on("click", function () {
            ting.media.downloadAll(sids);
            ting.logger.log("down_mutli", { page: ting.logger.getPage(), song_num: 50  });
            return false;
        });
    }

})(jQuery);
