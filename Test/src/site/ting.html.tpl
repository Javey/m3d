{nocache}
    {if $tplData.loginInfo}
        {assign var=loginInfo value=$tplData.loginInfo scope='global'}
        {assign var=loginInfoUserName value=$loginInfo.pass_info.displayname|default:$loginInfo.user_bdname|default:$loginInfo.pass_info.secureemail|default:$loginInfo.pass_info.securemobil scope='global'}
    {/if}
    {if $tplData.ownerInfo}{assign var=ownerInfo value=$tplData.ownerInfo scope='global'}{/if}
    {if $smarty.server.HTTP_HOST === 'music.hao123.com'}
        {$isHao123 = true scope='global'}
    {/if}
{/nocache}
{capture}{**这个capture保证下面的内容不会被输出，以防止import的模块有除了Function以外的内容输出**}
  {assign var=isSelf value=(($loginInfo.ting_uid==$ownerInfo.ting_uid)&&($loginInfo.ting_uid!==null)) scope='global'}
  {assign var=navIndex value="" scope="global"}
  {assign var=plazaNav value="" scope="global"}
  {assign var=secNavIndex value="" scope="global"}
  {assign var=curpage value="home" scope="global"}
  {assign var=showSubNav value=!$isSelf scope='global'}
  {assign var=showBackTing value=$isSelf scope='global'}
  {block name="import"}{**这个block的作用是挖一个用来放include模块的坑**}
    {include file="widget/user_link/user_link.html.tpl" inline}
    {include file="widget/people_name/people_name.html.tpl" inline}
    {include file="widget/song_link/song_link.html.tpl" inline}
    {include file="widget/author_list/author_list.html.tpl" inline}
    {include file="widget/people_icon/people_icon.html.tpl" inline}
    {include file="widget/avatar/avatar.html.tpl" inline}
    {include file="widget/music_icon/music_icon.html.tpl" inline}
    {include file="widget/button/button.html.tpl" inline}
  {/block}
  {block name="assign"}{**用来放assign数据**}{/block}
{/capture}
<!DOCTYPE HTML>
<html>
<head>
  {block name="head"}
  {**一些共用代码**}
    <meta charset="utf-8"/>
    <title>{block name='alltitle'}{block name='title'}{/block}_{if $isHao123}音乐_hao123上网导航{else}百度音乐-听到极致{/if}{/block}</title>
    <!--leave space on purpose here-->
    <meta content={block name='keywords'}"百度音乐，音乐，音乐网，音乐播放器，mp3免费下载，流行歌曲，在线听歌，音乐网站"{/block} name="keywords"/>
    <meta content={block name='description'}"百度音乐是中国第一音乐门户，为你提供海量正版高品质音乐，最权威的音乐榜单，最快的新歌速递，最契合你的主题电台，最人性化的歌曲搜索，让你更快地找到喜爱的音乐，带给你全新音乐体验。"{/block}
          name="description"/>
    <!-- baidu -->
    <meta name="baidu-tc-verification" content="5532f353892ad86095cb538ab988fb55"/>
    <!-- google  -->
    <meta name="google-site-verification" content="-michJB8aokthZhSsY3KIyd7TW9tQ2jSXI_87qveZpo"/>
    <!-- bing  -->
    <meta name="msvalidate.01" content="B96798BECBFD1C248180D6DA843E27ED"/>
    <!-- sian weibo-->
    <meta property="wb:webmaster" content="95125c09ba4c1de4"/>
    {block name='op_monitor'}<!--STATUS OK--><!--status OK--><!--xxx OK-->{/block}
      {if $isHao123}
        <link rel="shortcut icon" href="/static/images/hao123/favicon.ico"/>
      {else}
        <link rel="shortcut icon" href="/static/images/favicon.ico"/>
      {/if}
    <!--symbol link to http://123.125.65.120/js/m.js available, by lq-->
    <script type="text/javascript">
      var ting = ting || {};
      {if $smarty.server.HTTP_X_BDTIP_TAG}ting.sample = "{$smarty.server.HTTP_X_BDTIP_TAG}"
      {/if}
    </script>
    <script type="text/javascript" _xbuilder="true" _xcompress="true">
      var ting = ting || {};
      var httpSuccess = function (xhr) {
        try {
          // IE error sometimes returns 1223 when it should be 204 so treat it as success, see #1450
          return !xhr.status && location.protocol === "file:" ||
            // Opera returns 0 when status is 304
            ( xhr.status >= 200 && xhr.status < 300 ) ||
            xhr.status === 304 || xhr.status === 1223 || xhr.status === 0;
        } catch (e)
        {}

        return false;
      };
      var parseJSON = function (data) {
        if (typeof data !== "string" || !data) {
          return null;
        }
        // Make sure leading/trailing whitespace is removed (IE can't handle it)
        var rtrim = /^(\s|\u00A0)+|(\s|\u00A0)+$/g,
          data1 = data.replace(rtrim, "");
        // Make sure the incoming data is actual JSON
        // Logic borrowed from http://json.org/json2.js
        if (/^[\],:{}\s]*$/.test(data1.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])/g, "@")
          .replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]")
          .replace(/(?:^|:|,)(?:\s*\[)+/g, ""))) {
          // Try to use the native JSON parser first
          return window.JSON && window.JSON.parse ?
            window.JSON.parse(data1) :
            (new Function("return " + data1))();

        } else {
          throw "Invalid JSON: " + data1;
        }
      };
      var httpData = function (xhr, type) {
        var data = xhr.responseText;
        // The filter can actually parse the response
        if (typeof data === "string") {
          // Get the JavaScript object, if JSON is used.
          if (type === "json") {
            data = parseJSON(data);
          }
        }
        return data;
      };
      //发送ajax请求拉取user_bar
      function getUserBar(content, url) {
        var requestDone = false;
        var getXhr = window.XMLHttpRequest && (window.location.protocol != 'file' || window.ActiveXObject) ?　
				function () {
          return new window.XMLHttpRequest();
        }

      :
        function () {
          try {
            return new window.ActiveXObject("Microsoft.XMLHTTP");
          } catch (e)
          {}
        };
        var xhr = getXhr();

        if (!xhr) {
          return;
        }


        url += '?_t=' + (new Date).getTime();
        xhr.open('get', url, true);
        xhr.setRequestHeader("Accept", "application/json, text/javascript, */*");
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        // Wait for a response to come back
        var onreadystatechange = xhr.onreadystatechange = function () {
          var status = false;
          // The request was aborted
          if (!xhr || xhr.readyState === 0) {

            requestDone = true;
            if (xhr) {
              xhr.onreadystatechange = {};
            }

            // The transfer is complete and the data is available, or the request timed out
          } else if (!requestDone && xhr && xhr.readyState === 4) {
            requestDone = true;
            xhr.onreadystatechange = {};

            status = !httpSuccess(xhr) ?
              "error" :
              "success";

            var errMsg;
            if (status === "success") {
              // Watch for, and catch, XML document parse errors
              try {
                // process the data (runs the xml through httpData regardless of callback)
                data = httpData(xhr, 'json');
              } catch (err) {
                status = "parsererror";
                errMsg = err;
              }
            }
            // Make sure that the request was successful or notmodified
            if (status === "success") {
              content.innerHTML = data.data.html;
              if (!!window.$) {
                (new Function(data.data.js)).call(data.data.html);
              } else {
                ting.userBarInit = new Function(data.data.js);
              }


            } else {
            }
            // Stop memory leaks
            xhr = null;

          }
        };

        // Send the data
        try {
          xhr.send(null);
        } catch (e) {
        }
      }
      try {
        document.execCommand('BackgroundImageCache', false, true);
      } catch (e) {
      }
      // function _xbg(o,e){
      // 	if(e==='f'){
      // 		o.style.fontSize = "16px";
      // 		o.style.color = "#000";
      // 		if(o.value == $(o).data('default')){ o.value = '';}
      // 	}
      // 	if(e === 'b' && !o.value){ o.style.color = "#999"; o.style.fontSize = "14px"; o.value = $(o).data('default'); }
      // }
    </script>
    <!-- <link rel="apple-touch-icon-precomposed" href=""/> -->

    {block name="base_css"}
    {**add rochappy 为个别页面定制化样式-[性能优化]**}
      <link rel="stylesheet" type="text/css" href="/static/css/base.css"/>
    {/block}
    {block name="css"}{**这是用来放Css的坑**}{/block}
    {block name="js-preload"}{**批量加载首页广告，用于提升首页加载速度**}{/block}
  {/block}
</head>
<body {block name="body_class"}{/block}>
{block name="body"}
  {block name="top_main"}
      {if $isHao123}
        {include file="mod_top_hao123.html.tpl" navIndex=$navIndex}
      {else}
        {include file="mod_top.html.tpl" navIndex=$navIndex}
      {/if}
  {/block}
  <div class="music-main" alog-alias="music-main-alog">
    <div class="music-main-body">
      <div class="music-body clearfix">
        {block name="content_main"}{/block}
      </div>
    </div>
  </div>
  {block name="music_banner_ad"}{/block}

  {block name="music-foot"}
    <div class="music-foot" monkey="music-foot" alog-alias="music-foot-alog">
        {if $isHao123}
            {include file="mod_foot_hao123.html.tpl"}
        {else}
            {include file="mod_foot.html.tpl"}
        {/if}
    </div>
  {/block}

  {block name="go-top"}
    <div class="app-down-panel">
      <ul>
        <li class="go-to-top"></li>
        <li class="down-mobile">
          <div class="down-preview-wrapper down-mobile-preview">
            <div class="down-preview">
              <span>百度音乐手机版</span>
              <a href="/app" target="_blank">
                <img width="128" height="128" src="{#PIC_PLACEHOLDER#}" org_src="/static/images/2code/app-down-index.png"/>
              </a>
              <span>点击或扫描下载</span>
            </div>
          </div>
        </li>
        <li class="down-pc">
          <a href="http://qianqian.baidu.com/download/BaiduMusic-12345616.exe" target="_blank">
            <div class="down-pc-icon"></div>
          </a>

          <div class="down-preview-wrapper down-pc-preview">
            <div class="down-preview">
              <span>百度音乐电脑版</span>
              <a href="http://qianqian.baidu.com/download/BaiduMusic-12345616.exe" target="_blank">
                <img width="96" height="96" src="{#PIC_PLACEHOLDER#}" org_src="/static/images/music/download-pc-preview.png"></a>
              <span>点击下载</span>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <a class="vip-tips" id="vip_tips" target="_blank" href="/mobile?pst=tips">
      <div class="vip-tips-content">
        <div class="vip-tips-left">

        </div>
        <div class="vip-tips-right">
          <span class="vip-tips-text" id="vip_tips_text_vip"><em>免费续期</em>2个月VIP</span>
          <span class="vip-tips-text" id="vip_tips_text_not_vip">百度音乐<em>免费</em>送2个月VIP会员</span>

          <div class="vip-tips-btn" href="" target="_blank">点击领取</div>
        </div>
        <div class="vip-tips-close" href="javascript:void(0)"></div>
      </div>
    </a>
  {/block}
  {include file="widget/browser/browser.html.tpl" inline}
  {browser }
{/block}
{block name="body_fixed_pop"}{/block}
</body>
{block name="js"}
    {*hao123 相关js*}
    {if $isHao123}
        <script type="text/javascript" src="http://www.hao123.com/js/public11-11-21.js"></script>
    {/if}
    {block name="js-mu"}
        <script type="text/javascript" src="/static/js/require/require.js"></script>
        <script type="text/javascript" src="/static/js/base.js"></script>
    {block name="widget_pack_js"}
        <script type="text/javascript" src="/static/js/widget_pack.js"></script>
    {/block}
{/block}
{**
by rochappy remove 采用异步方式加载
<script type="text/javascript" src="http://passport.rdtest.baidu.com/js/pass_uni_loginWrapper.js"></script>
**}
  {block name="js-page"}{/block}
  <div style="display:none;">
    <script type="text/javascript">
      var pageId = "{block name='js-monkey-pageid'}{/block}";
      (document.getElementsByTagName('head')[0] || body).appendChild(document.createElement('script')).src = 'http://img.baidu.com/hunter/musicmonkey.min.js';
      var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
      document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fd0ad46e4afeacf34cd12de4c9b553aa6' type='text/javascript'%3E%3C/script%3E"));
    </script>
  </div>
{/block}
{* End of js Block *}
{if $debugData}
  <a style="position:fixed;right:10px; top:50px;" href="">查看该页面模板</a>
  <script type="text/javascript">var __DEBUG_DATA__ = {json_encode($debugData)  nofilter};</script>
  <script type="text/javascript" src="/tool/js/beautify.js"></script>
  <script type="text/javascript" src="/tool/js/debug.js"></script>
{/if}
</html>