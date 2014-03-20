(function ($) {

  $(function () {
    ting.traceSource.setCookie();
    ting.traceSource.postLog();

    var userList = $("#user_list"),
      userMenu = $("#user_menu"),
      tingSearch = $("#search_form"),
      sugInp = $('#ww'),
      submitBtn = $('input[type="submit"]', tingSearch),
      inpDefaultVal = sugInp.data('default');
    onSubmit = function (e) {
      var inpVal = $.trim(sugInp.val());

      e.preventDefault();

      if (!inpVal || !inpVal.length || inpVal === inpDefaultVal) {
        window.location.href = "/";
        return;
      } else {
        /**主动统计*/
        /*
         ting.tinylog.log( {
         name: "ting-search-new/ting-search-common"
         } );
         */

        ting.logger.log("clicksearch", {
          page: 'search_num',
          key: inpVal
        });

        setTimeout(function () {
          $(tingSearch).submit()
        }, 500);
      }
    };


    sugInp.bind('focus',function () {
      if ($.trim(sugInp.val()) === inpDefaultVal) {
        sugInp.val('');
        sugInp.removeClass('s_ipt_def');
      }
    }).bind('blur',function () {
        if (sugInp.val() === '') {
          sugInp.val(inpDefaultVal);
          sugInp.addClass('s_ipt_def');
        }
      }).bind('keydown', function (e) {
        if (e.keyCode != 13)  return true;
        onSubmit(e);
      });
    ;

    submitBtn.bind('click', onSubmit);

    if (!sugInp.val()) {
      sugInp.val(inpDefaultVal);
    }
    sugInp.blur();

    //解决ie6下sug自动弹出的bug
    tingSearch.autoComplete().bind("auto.change",function (e, obj) {
      //var url = 'http://10.81.64.223:8888/info/suggestion?format=json&word='+encodeURIComponent(obj.keyword)+'&version=2&callback=window.baidu.sug&from=0';
      var url = 'http://sug.music.baidu.com/info/suggestion?format=json&word=' + encodeURIComponent(obj.keyword) + '&version=2&from=0&callback=window.baidu.sug';
      // 下面是sug的旧接口，若新接口存在问题，请首先【将旧接口备份文件autoComplete.js.bak覆盖新接口augoComplete.js！！】，然后在此切换sug的请求地址
      // var url = 'http://sug.music.baidu.com/info/suggestion?format=json&word='+encodeURIComponent(obj.keyword)+'&callback=window.baidu.sug';
      ting.connect.getMusicSuggestion(null, {wd: obj.keyword}, function (result) {
        obj.handleReady(result.data);
      }, null, url);
    }).bind("auto.commonlog",function (e, obj) {
        /**主动统计*/
        /*
         ting.tinylog.log( {
         name: "ting-search-new/ting-search-common"
         } );
         */
        var query = sugInp.val();
        if (!$.trim(query) || $.trim(query) === inpDefaultVal) {
          return;
        } else {
          // 回车搜索统计需求by zhengjiahui开始
          ting.logger.log("clicksearch", {
            page: 'search_num',
            key: query
          });
          // 回车搜索统计需求by zhengjiahui结束
        }
      }).bind('auto.suggestionlog', function (e, obj) {
        /*sug统计需求by zhengjiahui开始*/
        var query = $('#ww').val();
        ting.logger.log("clicksearch", {
          page: 'suglog',
          pos: 'sug_' + obj.channelName,
          key: query
        });
        /*sug统计需求by zhengjiahui结束*/
      });

    //在页面初始化时种cookie，用户登陆状态、用户id、用户类型
    var loginStatus = "0";
    var tid = "";
    var userType = "";
    if (ting.userInfo) {
      if (ting.userInfo.active) {
        loginStatus = "1";
        tid = ting.userInfo.userId;
        userType = ting.userInfo.userType;
      } else {
        loginStatus = "2";
      }
    }
    jQuery.cookie("u_lo", loginStatus, {path: "/", expires: 30});
    jQuery.cookie("u_id", tid, {path: "/", expires: 30});
    jQuery.cookie("u_t", userType, {path: "/", expires: 30});

//	if($.browser.msie&&parseFloat($.browser.version) < 7){
//		$(".ting-feedback").attr('href','mailto:tinghelp@baidu.com?subject=ting-bug');
//	}
    ting.LL.add(".lazyload:not(.notlazy .lazyload)");


    if (ting.userBarInit) {
      ting.userBarInit();
    }


    // 注册关注微信事件
    $("#weixin_follow").hoverShow($("#weixin_detail"), {delay: 0})


    /* 全站导航统计 */
    $(".main-nav li a").click(function () {
      var self = $(this);

      ting.logger.plogClick((self.parent().attr("class") || "").replace(/nav-current/g, "").replace(/^\s*|\s*$/g, ""));
    });

    var textMap = {
      "中国好声音": "hsy",
      "无损专区": "nav-lossless",
      "电脑版": "ttplayer",
      "手机版": "mobileapp",
      "百度随心听": "bdfm",
      "我的音乐盒": "mymbox"
    };

    $(".sub-nav li a").click(function () {
      var self = $(this),
        text = (self.html() || "").replace(/^\s*|\s*$/g, "");

      //去除html标签
      text = text.replace(/<[\w\s="->]*/g, "");

      if (textMap[text]) {
        ting.logger.plogClick(textMap[text]);
      }
    });

    $('#myMbox').click(function () {
      ting.logger.log('click', {
        pos: 'home_box'
      });

      ting.media.openPlayer();

      $(this).tip().tip('tipup', {
        msg: '音乐盒已打开',
        iconClass: 'tip-warning'
      });

      return false;
    });

    /* ting.vipTip = function () { */
    ting.vipTip_off = function () {
      var userInfo = ting.userInfo || {},
        vipInfo = userInfo.vip || {},
        cloudInfo = vipInfo.cloud || {},
        cloudXrank = cloudInfo.xrank,
        theXrank = { 4104: 1, 8200: 1 }, /* 7天活动id: 4104, 三个月活动id: 8200 */
        extraOffsetX = -43;

      /* 已参加过活动 */
      if (false && theXrank[cloudXrank]) {
        return;
      }

      /* 如果当天关闭过，则不再显示 */
      var cookieName = "mvip_4104";

      if ($.cookie("mvip_4104")) {
        return;
      }
      ;


      /* 剩下的要显示tips （位置，文字内容) */
      var $vipTips = $("#vip_tips"),
        $vipText = $("#vip_tips_text_vip"),
        $notVipText = $("#vip_tips_text_not_vip"),
        $vipTipsClose = $vipTips.find(".vip-tips-close"),
        $vipBtn = $vipTips.find(".vip-tips-btn"),
        $refer = ting.userInfo ? $("#anchor-user-vip") : $("#loginbtn"),
        referOffset = $refer.offset(),
        referOffsetX = referOffset.left,
        referWidth = $refer.width(),
        winW = $(window).width(),
        vipTipRight = winW - referOffsetX - referWidth / 2 + extraOffsetX,
        storeCookie = function () {
          var expireDate;
          expireDate = new Date();
          expireDate.setDate(expireDate.getDate() + 1);
          expireDate.setHours(0);
          expireDate.setMinutes(0);
          expireDate.setSeconds(0);
          $.cookie(cookieName, 1, { path: "/", expires: expireDate });
        };


      /* 不是VIP */
      if (!userInfo.vip) {
        $notVipText.html("百度音乐<em>免费</em>送2个月VIP会员");
        $notVipText.show();
        $vipText.hide();
        $vipTips.addClass("not-vip");
      }
      /* 还有5天vip就到期， 5 * 24 * 3600 * 1000 = 432000000 */
      /* 反馈的end_time以秒为单位，要转成ms */
      else if (userInfo.vip.cloud && userInfo.vip.cloud.end_time * 1000 <= (new Date).valueOf() + 432000000) {
        $notVipText.html("您的VIP资格即将到期");
        $notVipText.show();
        $vipText.hide();
        $vipTips.addClass("not-vip");

        /* 活动到期时间2013-06-05 */
        var expired = (new Date).valueOf() > 1370361600000;
        $vipBtn.html(expired ? "立即续期" : "免费续期");
        $vipTips.attr("href", expired ? "/mobile?pst=tips" : "/mobile?pst=tips");
      }
      /* 是VIP，但没参加过活动 */
      else if (userInfo.vip.cloud) {
        $vipText.html("<em>免费续期</em>2个月VIP");
        $vipText.show();
        $notVipText.hide();
        $vipTips.addClass("is-vip");
      }

      $vipTips.css("right", vipTipRight).show();

      $vipTips.click(function () {
        $vipTips.hide();
        storeCookie();
        return true;
      });

      $vipTipsClose.click(function () {
        $vipTips.hide();
        storeCookie();
        return false;
      });
    };

    //ting.vipTipReady && ting.vipTip();


    /* 尝试调用passport loga接口 （如果用户在其他产品线已登录，会执行隐含登录 【设置我们的stoken】） */
    // ting.passport.getLoga();

    ting.getBatchDownPower = 1;


    /* 统计屏幕的分辨率 by lutaining */
    ting.logger.logResolution();

  });

  /*右侧下载面板*/
  //根据滚动距离判断是否显示回到顶部按钮
  $(window).bind('scroll', function () {
    var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
    if (scrollTop > 760) {
      $('.go-to-top').show();
    } else {
      $('.go-to-top').hide();
    }
    ;
  });
  $('.go-to-top').click(function (event) {
    var $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'); // opera fix
    $body.stop().animate({ scrollTop: 0}, 200);
    $(this).blur();
    event.preventDefault();
    event.stopPropagation();
  });
  //控制鼠标移动上去时候的事件
  $('.go-to-top').hover(function () {
    $(this).addClass('go-to-top-ac');
  }, function () {
    $(this).removeClass('go-to-top-ac');
  });
  $('.down-mobile').bind({
    'mouseenter': function () {
      ting.loadChildImages($(this), arguments.callee);

      $(this).addClass('down-mobile-ac');
    },
    'mouseleave': function () {
      $(this).removeClass('down-mobile-ac');
    },
    'click': function () {
      //发送日志
      var opt = {
        ref: 'music_web',
        pos: 'dl_app'
      }
      ting.logger.log('click', opt);
    }
  });
  $('.down-pc').bind({
    'mouseenter': function () {
      ting.loadChildImages($(this), arguments.callee);

      $(this).addClass('down-pc-ac');
    },
    'mouseleave': function () {
      $(this).removeClass('down-pc-ac');
    },
    'click': function () {
      //发送日志
      var opt = {
        ref: 'music_web',
        pos: 'dl_pcclient'
      }
      ting.logger.log('click', opt);
    }
  });

    /*hao123Header*/
    $('#hao123SiteSub').hover(function() {
        $(this).addClass('hover');
    }, function() {
        $(this).removeClass('hover');
    });

})(jQuery);