(function ($) {
  $(function () {
    // $("#target_artist .attention-hook").attention({"addClass":"addAtt","cancelClass":"cancelAtt"});
    $('#ting_recommend .album-cover-hook').albumCover();
    $('#target_album .album-cover-hook').albumCover();
    $('#album_list .album-cover-hook').albumCover();
    //$('#relative_diy .diy-cover-hook').diyCover();
    $("#ting_recommend .rool-hook").roll({
      rollNum: 5,
      screen: ".rool-inner",
      rollList: ".rool-inner ul",
      leftBtn: ".rool-left-btn",
      rightBtn: ".rool-right-btn"
    });

    /*歌手异形区播放热门歌曲*/
    $(".play-hotsong-hook").bind('click', function () {
      var ids = $(this).data("playdata").ids,
        opt = { moduleName: $(this).data("playdata").moduleName };
      ting.media.playSong(ids, opt);
      return false;
    });

    /*专辑异形区添加专辑*/
    $(".album-add").bind('click', function () {
      var ids = $(this).data("adddata").ids,
        opt = { moduleName: $(this).data("adddata").moduleName };
      ting.media.addSong(ids, opt);
      $me.tip();
      $me.tip("tipup", {msg: "添加成功！", iconClass: "tip-success"});
    });

    //展开专辑和歌手热门歌曲
    $('#album_list .songlist-fold-hook').songlistExpand({
      moduleName: "albumlist",
      noAlbum: true
    });
    $('#artist_list .songlist-fold-hook').songlistExpand({
      moduleName: "artisthotsong"
    });

    //鼠标经过li变灰，点击空白处展开歌曲列表的js在songlistExpand组件代码里-zhengjiahui

    //复制歌词
    // $('#lrc_list .copy-lyric-hook').each(function(){
    // 	var lyric = $(this).parent().next('p').text();
    // 	$(this).zeroClipboard({
    // 		clipText: lyric
    // 	}).tip({
    // 		msg:'复制成功',
    // 		iconClass:'tip-success'
    // 	}).bind('zeroclipboard.complete',function(){
    // 		$(this).tip('tipup');
    // 	});
    // });
//$('#lrc_list .copy-lyric')
    if($('.copy-lyric').length){
      var clipboard = new ZeroClipboard(null, {
        moviePath: "/static/flash/ZeroClipboard.swf"
      });
      clipboard.on('load', function () {
        $('.copy-lyric-hook').show();
      });
      var tipObj = null
      clipboard.on('complete', function (client, args) {
        $(tipObj).tip({
          msg: '复制成功',
          iconClass: 'tip-success'
        })
        $(tipObj).tip('tipup');
      });
      $('.copy-lyric').live('mouseenter', function () {
        var me = $(this)[0];
        clipboard.setCurrent(me);
        tipObj = me;
      })

    }

    //下载歌词
    $('#lrc_list .down-lrc-btn').click(function () {
      window.location = $(this).metadata().href;
      return false;
    });

    /*各种统计开始*/
    var query = $('input[name="key"]').val();
    var subpage = $('#query_type').val();
    var log = function (_pos, _logtype, _params) {
      var params = { page: 'searchresult', sub: subpage, logtype: _logtype, key: query },
          tagstyle=$("#result_container").data("tagstyle");
      if(tagstyle){
        params.tag=tagstyle;
      }
      if (_pos) {
        params.pos = _pos;
      }
      ;
      if (_params) {
        for (var key in _params) {
          params[key] = _params[key];
        }
      }

      ting.logger.log("clicksearch", params);
    }
    log(null,'exposure_pv');
    var checkTag = function (target) {  //判断target的链接类型
      var $tag = $(target), tagName = target.tagName.toLowerCase(), tagInfo = {};
      if (tagName === 'a' || $tag.parents('a').length) { //设定被a包含的大前提
        var $lnk = (tagName === 'a' ? $tag : $tag.parents('a'));
        tagInfo.isLink = true;
        tagInfo.lnk = $lnk;
        if ($lnk.hasClass('btn')) { //先判断是否是btn，因btn中含i标签，易与ico混淆
          tagInfo.isLink = $lnk.hasClass('btn-disabled') ? false : true; //去除btn灰掉的情况
          tagInfo.lnkType = 'btn';
        } else if ($lnk.hasClass('list-micon')) { //判断是否是icon
          tagInfo.lnkType = 'ico';
        } else if ($lnk.children('img').length) { //判断是否是img
          tagInfo.lnkType = 'img';
        } else {
          tagInfo.lnkType = 'txt'; //其余情况归为文本链接
        }
      } else {
        tagInfo.isLink = false;
      }
      return tagInfo;
    }

    var resIsThird = function (lnk) {
      var sitem = $(lnk).parents('li.song-item-hook');
      if (sitem.length) {
        var sid = sitem.data('songitem').songItem.sid;
        if (sid && isNaN(sid)) {
          return true;
        }
      }
      return false;
    }

    //session的点击pv统计
    var sessionLog = function (selector, pos, logtype) {
      var flag = 0;

      $(selector).each(function () {

        $(this).bind('mousedown', function (e) {

          var tag = checkTag(e.target),
            targetIsA = tag.isLink,
            params = {};
            // 检索结果页聚合模块所有链接act=detailpage
          if (/group-/.test(pos)){
              params.act='detailpage';
          }

          if (targetIsA) {
            var lnk = tag.lnk, lnkType = tag.lnkType, isThirdRes = false;
            params.linktype = lnkType;
            //判断是否是第三方资源
            params.resourcetype = 0;
            if (lnkType === 'txt' || lnkType === 'ico') {
              isThirdRes = resIsThird(lnk);
              if (isThirdRes) {
                params.resourcetype = 1;
              }
            }
            //songid 统计信息
            try {
              params.song_id = lnk.parents('.song-item-hook').data('songitem').songItem.sid;
            }catch (e){
            }

            //打上其他特殊字段信息
            switch (lnkType) {
              case 'ico':
                var act = lnk.data('action');
                params.act = (act === 'add' || act === 'play') ? 'audio' : act;
                break;
              case 'btn':
                if (lnk.hasClass('play-selected-hook') || lnk.hasClass('add-selected-hook')) {
                  params.act = 'audio';
                } else if (lnk.hasClass('collect-selected-hook')) {
                  params.act = 'collect';
                }
                break;
              case 'txt':  //在songlist中的文本链接并去除第三方歌曲名和未发布的歌手和专辑（跳至检索页）
                if (lnk.parents('li.song-item-hook').length && !(isThirdRes && lnk.parents('.song-title').length || lnk.children('.unreleased').length)) {
                  if(lnk.parents('.song-title').length){
                    params.act = "song_name";
                  }else if(lnk.parents('.singer').length){
                    params.act = "artist_name";
                  }else if(lnk.parents('.album-title').length){
                    params.act = "album_name";
                  }
                  else{
                    params.act = 'detailpage';
                  }
                }else if(lnk.hasClass("album-play")||lnk.hasClass("play-hot-btn")||lnk.hasClass("songlist-all-play")){
                    params.act = "play";
                }
                break;
              default:
                break;
            }
          }

          if (targetIsA && flag == 0) {
            if (logtype === undefined) {
              log(pos, 'click_pv', params);
              flag = 1;
            } else if (logtype == 'click_num') {
              var clickOBJ = $(e.target);
              var extra = {}
              //带上recommend信息
              var recommend = clickOBJ.parents('.song-item-hook').data('log-recommend');
              if (recommend) {
                extra.recommend = recommend;
              }
              //翻页参数
              extra.page_num = $('.page-navigator-current').html() || 1;
              //排列序号参数
              extra.position = $('.song-item').index(clickOBJ.parents('.song-item'));

              $.extend(params, extra)

              log(pos, 'click_num', params);
            }
          }
        });
      });
    }
    //异形区的曝光量和点击pv
    if ($('#target_banner').length) {
      if ($('#target_banner').find('.target-artist').length) {
        ting.logger.log('exposure', {
          expoitem: 'targetbanner_artist'
        });
      } else if ($('#target_banner').find('.target-album').length) {
        ting.logger.log('exposure', {
          expoitem: 'targetbanner_album'
        });
      } else if ($('#target_banner').find('.target-tag').length) {
        ting.logger.log('exposure', {
          expoitem: 'targetbanner_tag'
        });
      }
      sessionLog('#target_banner .target-artist', 'targetbanner_artist');
      sessionLog('#target_banner .target-album', 'targetbanner_album');
      sessionLog('#target_banner .target-tag', 'targetbanner_tag');
      sessionLog('#target_banner .target-artist', 'targetbanner_artist', 'click_num');
      sessionLog('#target_banner .target-album', 'targetbanner_album', 'click_num');
      sessionLog('#target_banner .target-tag', 'targetbanner_tag', 'click_num');
    }
    //搜索结果区及首条结果pv统计
    sessionLog('#result_container .song-list', 'resultcontent');
    sessionLog('#first_song_li', 'firstsong');
    sessionLog('#first_artist_li', 'firstartist');
    sessionLog('#first_album_li', 'firstalbum');
    sessionLog('#first_lrc_li', 'firstlrc');

    //普通搜索结果区点击量统计
    sessionLog('#result_container .song-list', 'resultcontent', 'click_num');

    //推荐标签区 
    sessionLog('#rec_tag', 'recommend_tag');
    sessionLog('#rec_tag', 'recommend_tag','click_num');
    //聚合标签统计
    sessionLog('.group-album a', 'group-album');
    sessionLog('.group-album a', 'group-album','click_num');
    sessionLog('.group-artist a', 'group-artist');
    sessionLog('.group-artist a', 'group-artist','click_num');
    sessionLog('.group-songlist a', 'group-songlist');
    sessionLog('.group-songlist a', 'group-songlist','click_num');
    sessionLog('.group-mv a', 'group-mv');
    sessionLog('.group-mv a', 'group-mv','click_num');    
    sessionLog('.group-ybaidu a', 'group-ybaidu');
    sessionLog('.group-ybaidu a', 'group-ybaidu','click_num');
    sessionLog('#rec-movie-list a', 'rec-movie-list');
    sessionLog('#rec-movie-list a', 'rec-movie-list', 'click_num');
    //试听pv统计
//	var audEle = $('#result_container').find('.play-selected-hook,.add-selected-hook,.icon-play,.icon-add');
//	sessionLog(audEle,'audition');

//	//下载pv统计
//	sessionLog('.icon-download','downloadsong');

    /*统计完成*/

    /*收听电台*/
    var playFmBtn = $(".btn-singer-fm");
    playFmBtn.bind("click", function () {
      var artistEncode = encodeURIComponent($(this).attr("artist"));
      $(this).attr('href', 'http://fm.baidu.com/#/channel/public_artist_' + artistEncode);
    });

    $(".ecom-ad").ecomad({
      callback: function () {
        $(".ecom-banner").remove();
        $(".music-body").css({
          "margin-bottom": "0",
          "border-bottom": "none"
        });
      }
    });

    $(".ttp-down-btn").bind("click", function () {
      ting.logger.log("click", {page: "m_search_song", pos: "down_qianqian"});
    })
  });

  // 搜索结果建议
  function submitSuggest() {
    var query = $('.fwb').html() || "empty",
      choose = $('input', $('#questions')).eq(0).attr('checked') ? 0 : 1 ,
      suggest = $('#user-suggest').val() || "";

    ting.logger.log('search_null', {
      key: query,
      content: suggest,
      num: choose
    });
  }

  $('#search-suggest').on('click', function () {
    $(this).showTips({update: true, left: -100});
    $('#suggest-submit').off('click').on('click', function () {
      submitSuggest();
      $('#search-suggest-container').fadeOut();
    });
    return false;
  });
  $('#search-suggest-bottom').on('click', function () {
    $(this).showTips({update: true, left: -100, top: -235});
    $('#suggest-submit').off('click').on('click', function () {
      submitSuggest();
      $('#search-suggest-container').fadeOut();
    });
    return false;
  });

  //歌手页面热度条替换
  var artistResult = $('.search-artist');
  if( artistResult.length ){
    var items = $('li', artistResult);
    var indicator

    items.each(function(i, item){
      item = $(item);
      item.on('mouseenter', function(){
        var self = $(this),
          target = self.find('.hot-info'),
          num = target.data('num');
        if (num){
          if (!indicator){
            self.append('<div id="listen-indicator">'+num+'人听过</div>');
            indicator = $('#listen-indicator');
          }
          target.append(indicator.remove());
          indicator.html(num + '人听过');
          indicator.show();
        }
      });

      item.on('mouseleave', function(){
        indicator&&indicator.hide();
      })
    });
  };
  $(".yinpin-ad a").bind("click",function  () {
    ting.logger.log("click",{page:"search",pos:"yixing",sub:"dntg"});
  });
  // 搜索聚合模块 JS
  $(".group-album .album-cover-hook").albumCover();
    // 播放影视、 歌单歌曲
    $('.group-songlist .songlist-all-play').click(function () {
        var self = $(this),
        listid = $(this).data("song").listid,
        conf = self.data("song"),
        ids = conf.ids,
        opt = {
            moduleName: conf.moduleName
        },
        action = conf.logAction;

        ting.media.playSong(ids, opt);
            self.tip().tip("tipup", {
                msg: "已开始播放",
            iconClass: "tip-success"
        });
        $.ajax({ url: "/data/music/songlist/listen?playlistId=" + listid + "&t=" + (new Date() * 1)});            
        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick(action);
        }
        /* 点击统计 end by lutaining */

        //bdbrowser effect
        if (ting.browser.isSpecial()) {
            ting.browser.add2box('play');
        }
        return false;
    });
 

  $(".group-artist .play-hot-btn").bind("click",function  () {
    var opt={},
        self=$(this),
        data=self.data("playdata");
      if(data.ids){
        ting.media.playSong(data.ids,{"moduleName":data.moduleName});
        self.tip().tip("tipup", {
                msg: "已开始播放",
            iconClass: "tip-success"
        });        
      }
      
    return false;
  })

  $(".yinpin-ad a").bind("click",function  () {
    ting.logger.log("click",{page:"search",pos:"yixing",sub:"dntg"});
  }) 
  $(".yinpin-ad a").bind("click",function  () {
    ting.logger.log("click",{page:"search",pos:"yixing",sub:"dntg"});
  })

  /*_JCH_site/search/music_result/group_top/jch/jch_mod_movie.tpl_text/javascript */

  $('#film-change').on('click', function(){
    require.config({
      baseUrl: '/static/js/require',
//      urlArgs: "bust=" + (new Date()).getTime(),
      paths: {
        'slider': 'slider/slider'
      }
    });

    require(['slider'], function(Slider){
      new Slider($('#rec-movie-list'), $('#film-change'), 250 ,'changeRight');
    });

    // remove init event
    $(this).off('click');
  });

  // 单曲播放和添加按钮
  $(".music-icon-hook").musicIcon();

  // 全部播放 播放影视
  $('.rec-film-all-play').click(function () {
    var self = $(this),
      conf = self.data("song"),
      ids = conf.ids,
      opt = {
        moduleName: conf.moduleName
      },
      action = conf.logAction;

    ting.media.playSong(ids, opt);
    self.tip().tip("tipup", {
      msg: "已开始播放",
      iconClass: "tip-success"
    });

    /* 点击统计 start by lutaining */
    if (ting && ting.logger && ting.logger.plogClick) {
      ting.logger.plogClick(action);
    }

    /* 点击统计 end by lutaining */
    //bdbrowser effect
    if (ting.browser.isSpecial()) {
      ting.browser.add2box('play');
    }
    return false;
  });
/*_JCH_*/

})(jQuery);

