{**
by rochappy remove 2013-01-31
  <!--
  <i class="music-guide-bg" id="musicGuideBg"></i>
<div class="music-guide" id="musicGuide">
  <div class="body">
    <span class="btn-music-guide" id="musicGuideBtn">立刻体验！</span>
  </div>
</div>
  -->
**}
<div class="music-head"  monkey="music-head">
  <div class="lg"> <a id="bm-logo" href="/" ></a> </div>
  <div class="search-wrap">
    <div class="lk"> <a href="http://news.baidu.com/"  onmouseover="s(this)">新闻</a><a    href="http://www.baidu.com/" onmouseover="s(this)">网页</a><a    href="http://tieba.baidu.com/" onmouseover="s(this)">贴吧</a><a    href="http://zhidao.baidu.com/" onmouseover="s(this)">知道</a><span>音乐</span><a    href="http://image.baidu.com/" onmouseover="s(this)">图片</a><a   href="http://v.baidu.com/" onmouseover="s(this)" >视频</a><a   href="http://map.baidu.com/" onmouseover="s(this)" >地图</a><a   href="http://baike.baidu.com/" onmouseover="s(this)" >百科</a><a   href="http://wenku.baidu.com/" onmouseover="s(this)" >文库</a></div>
    <form id="search_form" name="f1" action="/search">
      <div class="search">
        <span class="s_ipt_wr"><input type="text" name="key" value="{$tplData.query|default:''}" data-default="请输入歌名、歌词、歌手或专辑" id="ww" class="kw s_ipt{if !$tplData.query} s_ipt_def{/if}" size="42" maxlength="100" autocomplete="off"></span><span class="s_btn_wr"><input type="submit" value="百度一下" class="s_btn" onmousedown="this.className='s_btn s_btn_h'" onmouseout="this.className='s_btn'"></span><span class="s_tools"></span>
      </div>
      <div id="loading-pic"></div>
      <div class="sug-result"></div>
    </form>

  </div>

  <form style="width:0;height:0;" name="vform" id="vform"  action="http://v.baidu.com/v">
    <input type="hidden" name="ct" value="301989888">
    <input type="hidden" name="rn" value="20">
    <input type="hidden" name="pn" value="0">
    <input type="hidden" name="db" value="0">
    <input type="hidden" name="s" value="3">
    <input type="hidden" name="word" value="">
  </form>

  <div class="nav " monkey="nav">
    <i class="tl"></i><i class="tr"></i><i class="bl"></i><i class="br"></i>
    <i class="nav-shadow"><i></i> </i>
    <ul class="main-nav">
      <li class="nav-home {if $navIndex==='home'}nav-current{/if}"><a href="/?fr=nf_nav_1"><span>首页</span></a></li>
      <li class="nav-top {if $navIndex==='top'}nav-current{/if}"><a href="/top?fr=nf_nav_1"><span>榜单</span></a></li>
      <li class="nav-singer {if $navIndex==='singer'}nav-current{/if}"><a href="/artist?fr=nf_nav_1"><span>歌手</span></a></li>
      <li class="nav-music-cate {if $navIndex==='tag'}nav-current{/if}"><a href="/tag?fr=nf_nav_1"><span>分类</span></a></li>
      {*<li class="nav-topic {if $navIndex==='topic'}nav-current{/if}"><a href="/topic"><span>专题</span></a></li>*}
      <li class="nav-songlist {if $navIndex==='songlist'}nav-current{/if}"><a href="/songlist?fr=nf_nav_1"><span>歌单</span></a></li>
      <li class="nav-mv {if $navIndex==='mv'}nav-current{/if}"><a href="/mv?fr=nf_nav_1"><span>MV</span></a></li>
    </ul>
    <ul class="sub-nav">
      <li><a href="/topic/cooperation/chinavoice2013?pst=pc" target="_blank" id="the-voice">
          <div id="the-voice-logo"></div>中国好声音</a></li>
      <li class="line"></li>
      <li><a href="/lossless">无损专区</a><i class="icon-new"></i></li>
      <li class="line"></li>
      <li><a href="http://qianqian.baidu.com" target="_blank">电脑版</a></li>
      <li class="line"></li>
      <li><a href="/app/android?pst=banner" target="_blank">手机版</a></li>
      <li class="line"></li>
      <li><i class="line"></i><a href="http://fm.baidu.com" target="_blank">百度随心听</a></li>
      <li><a href="http://play.baidu.com" id="myMbox" target="_blank" class="nav-musicmbox">我的音乐盒</a>
        {**
        by rochapy remove 2013-01-31

        **}
      </li>
    </ul>
  </div>
  {** by rochappy 2013-01-31
  <!--
 <div id="uplogoGuige" class="uplogo-guide c9"><strong>ting!</strong> 全新更名为<strong>“百度音乐”</strong>     </div>
 -->
  **}
  {include file="widget/adm/adm.html.tpl" inline}
  {block name="adm-top-right"}
    <div class="head-ad">
      {adm id = "476522" width = "235" height = "73" }
    </div>
  {/block}
</div>
<div id="userbar" class="userbar" alog-alias="userbar"></div>
{literal}
  <script type="text/javascript" _xcompress="true">

  function s(c) {
    if (document.f1.key.value.length > 0) {
      var urls = {
        "news" : {
          url:"http://news.baidu.com/",
          word : "ns?tn=news&cl=2&rn=20&ct=1&ie=utf-8&word="
        },
        "www" : {
          url : "http://www.baidu.com/",
          word : "s?cl=3&wd="
        },
        "tieba" : {
          url : "http://tieba.baidu.com/",
          word : "f?ie=utf-8&kw="
        },
        "zhidao" : {
          url : "http://zhidao.baidu.com/",
          word : "search?pn=0&rn=10&lm=0&word="
        },
        "image" : {
          url : "http://image.baidu.com/",
          word : "i?ct=201326592&cl=2&nc=1&lm=-1&st=-1&tn=baiduimage&istype=2&fm=&pv=&z=0&ie=utf-8&word="
        },
        "v" : {
          url : "http://v.baidu.com/",
          word : "v?ct=301989888&s=25&ie=utf-8&word="
        },
        "map" : {
          url : "http://map.baidu.com/",
          word : "?newmap=1&ie=utf-8&s=s%26wd%3D"
        },
        "baike" : {
          url: "http://baike.baidu.com/",
          word : "search/word?enc=utf8&word="
        },
        "wenku" : {
          url : "http://wenku.baidu.com/",
          word : "search?ie=utf-8&word="
        }
      };
      var href = c.href ,
        reg = /^http:\/\/([^.]+)\./ ,
        domain = href.match(reg)[1] ,
        b = c.href.split("?"),
        searchInput = document.getElementById("ww");
      var value = encodeURIComponent(searchInput.value);
      // alert(urls[domain].word);
      if(searchInput.value == searchInput.getAttribute("data-default")) {
        c.href = urls[domain].url;
      }else{
        c.href = urls[domain].url + urls[domain].word + value;
      }
    }
  }

  var ting = ting || {};

  var enterState = (function( sUsrBarWapperID ) {
    var oUserInfo, oTemplateMap, sLocation, eUsrBar, bBindUserBar, fEnterState, showUserCenter;
    sLocation = encodeURIComponent( location.href );
    oUserInfo = {
      "sTemplate": "guest",
      "sUserName": '',
      "sSpaceLink": '',
      "sProfileURL": 'http://passport.baidu.com/#0,1',
      "sHomeURL": "http://passport.baidu.com/v2/?ucenteradduname",
      "sBaiduURL": 'http://www.baidu.com',
      "sLoginURL": 'javascript:;',
      "sRegURL": 'http://passport.baidu.com/v2/?reg&regType=1&tpl=music&u=' + sLocation,
      "sLogoutURL": 'http://passport.baidu.com/?logout&tpl=music&u=' + sLocation,
      'sOpenMbox': '<a href="###" onclick="return ting.media.openPlayer(),false">音乐盒</a>',
      "sMusicVIPURL": '/home/vip?pst=home',
      "sUsercenterURL" : "/home/user",
      "sReceiveURL" : "/home/gift",
      "enable_fee" : false,
      "sUserVipURL" : "/home/vip",
      "vipIcon" : "<span title='未开通VIP会员' class='power-icon-min index-icon-vipidentity'></span>",
      "activeVipIcon": "<span title='成为音乐VIP会员' class='power-icon-min index-icon-vip-active'></span>"
    };

    oTemplateMap = {

      "guest": '<ul><li id="receiveActive" style="margin-right:20px; display:none;"><a rel="nofollow" href="#{sReceiveURL}"><span class="limit-active"></span>免费体验特权！</a></li><li><a  target="_blank" href="#{sBaiduURL}">百度首页</a></li><li class="line">|</li><li class="vip-intro"><a  target="_blank" href="#{sMusicVIPURL}"><span class="z1">音乐VIP</span><span class="mn-lk"></span></a><a target="_blank" href="#{sMusicVIPURL}">#{activeVipIcon}</a></li><li class="line">|</li><li><a rel="nofollow" href="#{sLoginURL}" id="loginbtn">登录</a><a target="_blank" href="#{sRegURL}" rel="nofollow">注册</a></li><li id="oldLine" style="display:none" class="line">|</li><li id="oldMp3Entry" style="display:none"><a href="/?goto=old_mp3">MP3旧版</a></li></ul>',

      "user": '<ul><li id="receiveActive" style="margin-right:20px; display:none;"><a rel="nofollow" href="#{sReceiveURL}"><span class="limit-active"></span>免费体验特权！</a></li><li class="uname mn-lk-w"><a id="anchor-user-name" href="#{sHomeURL}" target="_blank">#{sSourceIcon}#{sUserName}<span class="mn-lk"></span></a><a id="anchor-user-vip" href="#{sUserVipURL}">#{vipIcon}</a><div id="menu-user"  style="display:none" class="mn-tip" style=" width:75px; right:0;"><ul class="mn"><li><a class="my-home" href="#{sHomeURL}" target="_blank" rel="nofollow">我的主页</a></li><li><a class="my-info" href="#{sProfileURL}" target="_blank" rel="nofollow">帐号设置</a></li><li><a href="#{sLogoutURL}" class="logout" rel="nofollow" >退出</a></li></ul></div></li><li class="line">|</li><li class="vip-intro"><a id="userCenter" href="#{sMusicVIPURL}" target="_blank">我的VIP<span class="mn-lk"></span></a></li><li class="line" id="userCenterLine">|</li><li><a href="#{sBaiduURL}" target="_blank">百度首页</a></li></ul>'
    };

    showUserCenter = function () {
      document.getElementById("userCenter").style.display = "block";
      document.getElementById("userCenterLine").style.display = "block";
    };

    showReceive = function () {
      document.getElementById("receiveActive").style.display = "block";
    };

    oCallbacks = {
      "guest": function() {
        var loginBtn = document.getElementById("loginbtn"),
          popupLogin = function () {
            if (ting && ting.passport && ting.passport.checkLogin) {
              ting.passport.checkLogin({}, {pos: "userbar"});
            }
            return false;
          };

        if (loginBtn) {
          if( !window.attachEvent ) {
            loginBtn.addEventListener('click', popupLogin, false);
          } else {
            loginBtn.attachEvent('onclick', popupLogin);
          }
        }

        // showUserCenter();

        oCallbacks.invoked = true;
      },
      "user": function() {
        var eAnchorUserName, eMenu, iWatchID, iWatchInterval, bAllowHideMenu, bMenuShow;

        // showUserCenter();


        eAnchorUserName = document.getElementById( 'anchor-user-name' );
        eMenu = document.getElementById( 'menu-user' );
        iWatchID = -1;
        iWatchInterval = 500;
        bAllowHideMenu = false;
        bMenuShow = false;

        function hideMenu() {
          if( bAllowHideMenu )
          {
            if( bMenuShow )
            {
              eMenu.style.display = "none";
              bMenuShow = false;

              clearInterval( iWatchID );
              iWatchID = -1;
            }
          }
        }

        eAnchorUserName.onmouseover = function() {
          if( !bMenuShow )
          {
            eMenu.style.display = "block";
            bMenuShow = true;
            bAllowHideMenu = false;

            if( iWatchID<0 )
            {
              iWatchID = setInterval( hideMenu, iWatchInterval );
            }
          } else {
            hideMenu();
          }
          return false
        };

        eAnchorUserName.onmouseout = function() {
          bAllowHideMenu = true;
        };

        eMenu.onmouseover = function() {
          bAllowHideMenu = false;
        };

        eMenu.onmouseout = function() {
          bAllowHideMenu = true;
        };

        oCallbacks.invoked = true;
      }
    };

    function formatTpl(source, opts) {
      source = String(source);
      var data = Array.prototype.slice.call(arguments,1), toString = Object.prototype.toString;
      if(data.length){
        data = data.length == 1 ?
          /* ie 下 Object.prototype.toString.call(null) == '[object Object]' */
          (opts !== null && (/\[object Array\]|\[object Object\]/.test(toString.call(opts))) ? opts : data)
          : data;
        return source.replace(/#\{(.+?)\}/g, function (match, key){
          var replacer = data[key];
          // chrome 下 typeof /a/ == 'function'
          if('[object Function]' == toString.call(replacer)){
            replacer = replacer(key);
          }
          return ('undefined' == typeof replacer ? '' : replacer);
        });
      }
      return source;
    }

    fEnterState = function( _oUserInfo , onComplete) {
      _oUserInfo = _oUserInfo || {};

      for( var i in oUserInfo )
      {
        if( _oUserInfo.hasOwnProperty( i ) )
        {
          continue;
        }
        _oUserInfo[i] = oUserInfo[i];
      }

      eUsrBar = document.getElementById( sUsrBarWapperID );
      eUsrBar.innerHTML = formatTpl( oTemplateMap[_oUserInfo['sTemplate']], _oUserInfo );
      if( _oUserInfo.enable_fee ){
        showReceive();
        if( _oUserInfo['sTemplate'] ==  'user' ){
          showUserCenter();
        }
      }

      oCallbacks[ _oUserInfo['sTemplate'] ]();

      if (onComplete){
        onComplete();
      }

      // 临时代码，vip活动判断
      if (ting.vipTip) ting.vipTip.call();
      ting.vipTipReady = true;

      return false
    };

    /*
     @cache bdErrCode
     @cache uName
     @cache isOnline
     @cache isSpaceUser
     */
    function updateUserState( _oUserInfo) {
      var sUserName, oRtUserInfo, errorCode, data, passInfo, cb;

      errorCode = parseInt(_oUserInfo.errorCode);
      data = _oUserInfo.data;
      oRtUserInfo = {};
      passInfo = _oUserInfo.data.passInfo || {};

      var icon = {
        'comm': "<i title='已开通VIP会员' class='power-icon-min index-icon-vip-active'></i>",
        'gold': "<i title='已开通白金VIP会员' class='power-icon-min index-icon-goldvip-active'></i>"
      };
      if (errorCode == 22000) {
        ting.userInfo = _oUserInfo.data;
        sUserName = data.bdName ? data.bdName : (data.bdEmail ? data.bdEmail : (data.bdMobile ? data.bdMobile : passInfo.displayname));
        oRtUserInfo.sUserName = sUserName;
        oRtUserInfo.sTemplate =  'user';
        oRtUserInfo.sHomeURL = data.bdName ? ['http://www.baidu.com/p/', data.bdName, '?from=music'].join("") : 'http://passport.baidu.com/v2/?ucenteradduname&u=' + encodeURIComponent('http://music.baidu.com');
        oRtUserInfo.enable_fee = !!data.enable_fee;
        if(data.vip ){
          oRtUserInfo.vipIcon = icon[data.vip.cloud.service_level];
          try {
            var status = data.vip.cloud.service_level
          }catch (e){}

          // stage3 两种VIP
          cb = ting.vip.genInitFn(status, data.vip_expiry);
        }else{
          // stage 2 非VIP
          cb = ting.vip.genInitFn('notVip');
        }
        if (!data.bdName && !data.bdEmail && !data.bdMobile && passInfo.incomplete_user == 1) {
          oRtUserInfo.sSourceIcon = '<img src="' + passInfo.source_icon + '" width="16" height="16" style="vertical-align:top;margin-right:3px" />';
        }
      } else {
        // state 1 未登陆
        oRtUserInfo.enable_fee = !!data.enable_fee;
        oRtUserInfo.sTemplate = 'guest';
        cb = ting.vip.genInitFn('anonymous');
      }

      return fEnterState( oRtUserInfo, cb );
    }


    if( !window.attachEvent )
    {
      window.addEventListener( 'load', initUserBar, false );
    } else {
      window.attachEvent( 'onload', initUserBar );
    }

    return updateUserState;
  })( 'userbar' );

  function initUserBar() {
    var sc = "/data/user/info?callback=enterState&r=" + +new Date(),
      d = document.getElementsByTagName( 'head' )[ 0 ], s;

    s = document.createElement( 'script' );
    s.src = sc;

    d.appendChild( s );
  }

  ting.refreshUserBar = initUserBar;
  </script>
{/literal}
