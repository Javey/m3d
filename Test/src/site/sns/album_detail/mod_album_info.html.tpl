{include file="widget/author_list/author_list.html.tpl" inline}
{include "widget/app_layer/app_layer.html.tpl" inline}

<div class="album-info" monkey="album-info">
	<div class="base-info clearfix">
    <div class="cover-img">
          <span class="cover"><img src="{$albumInfo.pic_big|default:#ALBUM_COVER_DEFAULT_130b#}" alt="{$albumInfo.title}" /></span>
          {**展示首发或新标，先注释，31号上**}
          {if $albumInfo.first_release == 1}
            <span class="album-exclufirstpub-icon"></span>
          {elseif $albumInfo.is_new}
            <span class="album-new-icon"></span>
          {/if}
  </div>
  <div class="base-info-cont">
    <h2 class="album-name">{$albumInfo.title}</h2>
  <ul class="c6">
      <li class="album-singer">歌手：{if $albumInfo.author}{author_list source='album' releaseStatus=$albumInfo.relate_status ids=$albumInfo.all_artist_ting_uid  names=$albumInfo.author}{else}未知{/if}
                {**
                <a href="#" class="stat-info album-collection collection-hook { ids:'{$albumInfo.album_id}',type:'album' }">
                    <span class="b">
                        <b class="favorites-num-hook  { 'num': '{$albumInfo.favorites_num}' }">
                            {$albumInfo.favorites_num}
                        </b>
                        <br /><span class="text-album-collection">收藏</span>
                    </span>
                </a>
                **}     
      </li>
      {$pubTime = ""}
            {$pubTimes = explode('-',$albumInfo.publishtime)}
            {foreach $pubTimes as $item }
              {if $item == "00"}
                {$pubTime = "{$pubTimes[0]}年"}
              {else}
                {$pubTime = $albumInfo.publishtime}

              {/if}
            {/foreach}

      <li>{if $albumInfo.publishtime && $albumInfo.publishtime != "0000-00-00"}发行时间：{$pubTime} &nbsp;&nbsp;&nbsp;&nbsp; {/if}{if $albumInfo.styles}流派：{$albumInfo.styles}&nbsp;&nbsp;&nbsp;&nbsp; {/if}{if $albumInfo.publishcompany}发行公司：{$albumInfo.publishcompany}{/if}</li>
            <li class="opera">
              <div class="share clearfix">
      <span class="share-labe">分享到： </span>
      <div id="bdshare" class="bds_tools bdshare_t" style="display: block;position: static; border: none;padding: 0 0 2px 0;">
            <a class="bds_qzone"></a>
            <a class="bds_renren"></a>
            <a class="bds_tqq"></a>
            <a class="bds_tsina"></a>
            <span class="bds_more"></span>
      </div>  
    </div>
              <span class="album-cover album-cover-hook"   data-albumdata = '{json_encode(["id"=>$albumInfo.album_id,"moduleName" => "playAlbum"])}'>
                <span class="play-icon">
                  {button
                    str = "播放"
                    style = "a"
                    icon = "play"
                  }
                </span> 
              </span>
            {$ids = []}
              {foreach $tplData.data.album.songList as $item}
              
                {$idsArr = array_push($ids, $item.song_id  )}
              {/foreach}         
              <span class="album-add" data-adddata='{json_encode(["moduleName"=>"addAlbum","ids"=> $ids])}'>
                {button
                str = "添加"
                style = "b"
                icon = "add"
              }
              </span>
              {*歌单统计需求*}
              {$logData = "`$albumInfo.album_id`_`$albumInfo.title`||playlistAdd"}
              <span class="playlist-add" data-playlist='{json_encode(["moduleName"=>$logData,"type"=>"album","listid"=>$albumInfo.album_id,"title"=>$albumInfo.title,"ids"=> implode(",",$ids)])}'>
                {button
                str = "收藏为歌单"
                style = "b"
                icon = "collect"
              }
              </span>                 
              {if $tplData.data.album.songList|@count < 50}
              <span class="album-down" data-downdata='{json_encode(["moduleName"=>"downAlbum","ids"=> $ids,"author"=> $albumInfo.author, "albumname"=> $albumInfo.title])}'>
                {button
                str = "下载专辑 <i class='power-icon-min power-icon-vipidentity-active'></i>"
                style = "b"
                icon = "down"
              }
              </span>
              {/if}
              
            </li>
</ul>
  </div>
  </div>
         <span class="hot-num">{if  $smarty.now|date_format:'%Y-%m-%d' == $albumInfo.publishtime}<span class="num">新上架</span>{else}<span class="c6">热度</span><span class="num">{number_format($albumInfo.hot)}</span>{/if}</span>

		{**
        <div class="album-play-num">{if  $smarty.now|date_format:'%Y-%m-%d' == $albumInfo.publishtime}<span class="num">新上架</span>{else}<span class="num">{number_format($albumInfo.hot)}</span><span class="c6">播放</span>{/if}</div>
		**}
        <div class="guide-to-mobile-wrapper">
            {** 张韶涵app  **}
            {if $albumInfo.all_artist_ting_uid == "1069"}
            <p class="guide-to-mobile">张韶涵官方客户端已经发布！音乐资讯应有尽有，点击下载：（<a class="android-icon" href="http://music.baidu.com/cms/artistapp/zhangshaohan/artist_angela.apk?rf=w"><b>Android</b>版</a>）。</p>
            {else}
            {**
            <p class="guide-to-mobile">在手机上搜音乐 - 下载客户端（<a id="android-down-link" class="android-icon" href="http://ting.baidu.com/mobile/app/BaiduMusic_musicalbum.apk"><b>Android</b>版</a>，<a id="ios-down-link" class="ios-icon" target="_blank" href="https://itunes.apple.com/cn/app/id468623917"><b>iPhone</b>版</a>），或直接访问 <b>music.baidu.com</b>。</p>
            **}
            {include file="sns/song_page/mod_guide_to_mobile.html.tpl"}
            </p>
            {/if}
        </div>

		<p class="album-desc c6">
            <span class="description">{$albumInfo.info|utf8_truncate:200|replace:"\n":'<br />' nofilter}</span>
            {if strlen($albumInfo.info)>200}
                <span class="description-all">{$albumInfo.info|replace:"\n":'<br />'}</span>
                <a class="des-more-hook" href="#">展开</a>
            {/if}
        </p>
						

</div>

{*{app_layer id = 'ios-down-layer'*}
    {*os = "iOS"*}
    {*title = '<img src="/static/images/music/app-down-title-ios.png" alt="百度音乐iPhone版"/>'*}
    {*desc = '<p class="down-desc">已自动转入App Store，您可以同过App Store下载，如浏览器长时间没有反应，<a href="https://itunes.apple.com/cn/app/id468623917" target="_blank" style="text-decoration: underline;" rel="nofollow">请点击这里进入</a></p>'*}
    {*istep1 = '启动并连接iTunes'*}
    {*istep2 = '下载百度音乐APP，安装成功'*}
    {*istep3 = '打开“百度音乐”享受听觉盛宴'*}
    {*otext1 = '使用短信免费发送下载链接到手机'*}
    {*otext2 = '下载安装包到电脑<br/>（仅适合已越狱的iPhone）'*}
    {*otext3 = '使用二维码扫描软件直接扫描下载'*}
    {*obtn3 = '<img class="tdc" src="/static/images/music/tdc-ios.png"/>'*}
    {*ipaLink = 'http://mu5.bdstatic.com/static/flash/Baidu_Music_album.ipa'*}
{*}*}

{*{app_layer id = 'android-down-layer'*}
    {*os = "Android"*}
    {*title = '<img src="/static/images/music/app-down-title-android.png" alt="百度音乐Android版"/>'*}
    {*desc = '<p class="down-desc">下载会自动在几秒钟内开始，如果浏览器长时间没有响应，<a href="http://ting.baidu.com/mobile/app/BaiduMusic_musicalbum.apk" style="text-decoration: underline;" rel="nofollow">请点击这里下载</a></p>'*}
    {*istep1 = '用数据线将手机连接至电脑'*}
    {*istep2 = '将下载的apk文件复制到手机，<br/>在手机中点击该文件安装'*}
    {*istep3 = '安装成功后，打开"百度音乐"<br/>享受听觉盛宴'*}
    {*otext1 = '使用短信免费发送下载链接到手机'*}
    {*otext2 = '使用百度手机助手一键安装'*}
    {*otext3 = '使用二维码扫描软件直接扫描下载'*}
    {*obtn3 = '<img class="tdc" src="/static/images/music/tdc-android-album.png"/>'*}
    {*apkId = '12'*}
{*}*}

{*<div id="sendmessage" class="send-message" style="display: none; ">*}
    {*<div class="app-layer-h5">发送到手机<span class="cl-sms">close</span></div>*}
    {*<form name="sms" id="sms_form">*}
        {*<span>*}
            {*<label for="sms_phone">手机号：</label>*}
            {*<input type="text" name="sms_phone" id="sms_phone" maxlength="11">*}
        {*</span>*}
        {*<span>*}
            {*<label for="sms_vercode">验证码：</label>*}
            {*<input type="text" name="sms_vercode" id="sms_vercode" maxlength="4">*}
            {*<img id="imgVer" src="/static/images/blank.gif" alt="点击更新" title="点击更新">*}
        {*</span>*}
        {*<button type="submit" id="sms_button">发送到手机</button>*}
        {*<span id="verify_tips"></span>*}
        {*<span class="sms-remark">此短信不造成任何费用，百度保证不透露给第三方，请放心使用</span>*}
    {*</form>*}
{*</div>*}
