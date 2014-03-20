{include 'widget/button/button.html.tpl' inline}
{include "widget/app_layer/app_layer.html.tpl" inline}

<div class="song-info" monkey="songInfo">
		<div class="play-holder clearfix">				
			<div class="song">
				<h2 class="songpage-title clearfix"> 
				{$versionsNeedLink = ["现场"]}
        {if $grayData ||  $blackData}
				<span class="gray-icon"></span>
        {/if}
				<span class="name">{$song_info.title}</span>{if strlen($song_info.versions) > 0}{if in_array($song_info.versions, $versionsNeedLink)} <a href="/tag/{$song_info.versions}" class="songpage-version">[{$song_info.versions nofilter}]</a>{else}<span class="songpage-version">[{$song_info.versions}]</span>{/if}{/if}
                    {if $song_info.destructive === 0 && ($song_info.resource_type == 0 || $song_info.resource_type == 1) && $song_info.beDownloaded != 1}<span data-id="{$song_info.song_id}" class="icon-lossless lossless-hook" title="无损品质音乐"></span>{/if}
                    {if $song_info.has_mv2 > 0}{/if}{if $song_info.is_new}<span class="icon-new"></span>{/if}

					
				</h2>
				{if $song_info.license_number}
				<div>文化审批：{$song_info.license_number}</div>
				{/if}
        {if $grayData ||  $blackData}
          <p class="link-src clearfix"><span class="label">歌曲来源：</span> {if $song_info.songShowLink} <span class="link-src-info"><a href="{$song_info.songShowLink}" target="_blank">{$song_info.songShowLink}</a></span> {else}互联网{/if}</p>
        {/if}        
                <span class="song-play-num hot-num">{if  $smarty.now|date_format:'%Y-%m-%d' == $song_info.publishtime}<span class="num">新上架</span>{else}<span class="c6">热度</span><span class="num">{number_format($song_info.hot)}</span>{**<span class="c6">播放</span>**}{/if}</span>
			</div>
			
		</div>
        <div class="song-opera clearfix">
          {* 收藏和分享按钮 *}
          <div class="song-page-share clearfix">
            {button style="b" class="song-share" str="分享" icon="share" href="#"}
            <span class="sep"></span>
            {block name="song-collect"}
              {button
              style = "b"
              class = "song-collect"
              data = ['ids'=>$song_info.song_id,'type'=>"song"]
              str = "收藏"
              icon = "collect"
              href="#"
              }
            {/block}

            <div id="bdshare" class="bds_tools bdshare_t" >
              <span class="arrow-down"></span>
              <a class="bds_qzone"></a>
              <a class="bds_renren"></a>
              <a class="bds_tqq"></a>
              <a class="bds_tsina"></a>
              <span class="bds_more"></span>
            </div>
          </div>
          {* 收藏和分享按钮 *}

          {if isset($song_info.bePlayed) && ($song_info.bePlayed==1)}
            <span class="play-btn">
          	  {button style = "disabled" str = "播放" icon = "play" class = " clicklog-play-btn" title="因版权保护，本资源不能播放"}
            </span>
            <span class="add-song-btn">
          	  {button style = "disabled" str = "添加" icon = "add" title="因版权保护，本资源不能播放"}
            </span>
          {else}
            <span class="play-btn" data-playdata='{json_encode([ "id"=>$song_info.song_id , "moduleName"=> "playBtn" ])}'>
          	  {button style = "a" str = "播放" icon = "play" class = " clicklog-play-btn" }
            </span>
            <span class="add-song-btn" data-adddata='{json_encode([ "id"=>$song_info.song_id , "moduleName"=> "addBtn" ])}'>
          	  {button style = "b" str = "添加" icon = "add" }
            </span>
          {/if}
		      {** 调整下载逻辑，通过$song中的power字段来判断是否可以下载 **}
          {if isset($song_info.beDownloaded) && $song_info.beDownloaded == 1}
            {button style = "disabled" class = "down-song" str = "下载" icon = "down" title="因版权保护，本资源不能下载"}
          {else}
            {if $song_info.is_chinavoice == 1 }
              {$download_btn_class = "down-song-btn jsClientsDownload chinavoice" }
            {elseif $song_info.download_limit == 1}
              {$download_btn_class = "down-song-btn jsClientsDownload" }
            {else}
              {$download_btn_class = "down-song-btn"}
            {/if}
	          {button style = "b" class = $download_btn_class data = ['id'=>$song_info.song_id] str = "下载" icon = "down"}
          {/if}


        {if $song_info.songLink}
        <a  onclick="bd_app_dl(this);" href="javascript:void(0);" class="btn btn-b btn-telapp" restype="music" download_url="{$song_info.songLink}" sname="{$song_info.title}" package="" versionname="" icon="{$song_info.pic_small}" size="{$song_info.size}" bd_from="1001490z" ext_restype="apk" ext_download_url="http://music.baidu.com/cms/mobile/static/apk/BaiduMusic_pcbdshoujizhushou.apk" ext_sname="百度音乐" ext_package="com.ting.mp3.android" ext_versionname="3.8.1" ext_icon="http://hiphotos.baidu.com/wisegame/pic/item/2410b912c8fcc3ce99f9f1709345d688d43f20b3.jpg" ext_size="6828251">
            <span class="inner">
                <i class="icon btn-icon-telapp"></i>                           
                <span class="txt">下载到手机</span>
            </span>
        </a>  
        {/if}        
        </div>

		<div class="info-holder clearfix">
				<ul class="base-info c6">
					{*{if $song_info.info}*}
                        {*{$info = preg_split("/[《》]/", $song_info.info)}*}
                        {*{$info = explode('《', $song_info.info)}*}
                        {*{$temp = explode('》', $info[1])}*}
                        {*{$info[1] = $temp[0]}*}
                        {*{$info[2] = $temp[1]}*}
                        {*{if $song_info.film_title}*}
                            {*<li class="film">{$song_info.film_type}<a href="/film/{$song_info.film_id}" title="{$song_info.film_title}">《{$song_info.film_title}》</a>{$song_info.song_content_type}</li>*}
                        {*{else}*}
                            {*<li class="film">{$song_info.info nofilter}</li>*}
                        {*{/if}*}
                    {*{/if}*}
          {if $song_info.film}
            <li class="film"><span>{foreach $song_info.film as $film}{$film.film_type}《<a href="/film/{$film.film_id}">{$film.film_title}</a>》{$film.song_content_type}{if !$film@last}, {/if}{/foreach}</span></li>
          {elseif $song_info.info}
            <li class="film"><span>{$song_info.info nofilter}</span></li>
          {/if}
					<li>歌手：{if $song_info.author}{author_list releaseStatus=$song_info.relate_status ids=$song_info.all_artist_ting_uid names=$song_info.author width = 500}{else}未知{/if}
					</li>
					{if $song_info.album_id && strlen($song_info.album_title) > 0}
					<li class="clearfix">所属专辑：{if $song_info.relate_status == 0 || $song_info.relate_status == 2}<a href="/album/{$song_info.album_id}">《{$song_info.album_title}》</a>{else}<a href="/search?key={$song_info.album_title|escape:'url' nofilter}+{$song_info.author|escape:'url' nofilter}">《{$song_info.album_title}》{/if}</a>
					</li>
					{/if}
          {*去除发行时间和公司信息by wy*}
{*					{if ($song_info.resource_type == 0 || $song_info.resource_type == 1) && $song_info.publishtime && $song_info.publishtime!="0000-00-00"}
					<li>
						{$pubTime = ""}
						{$pubTimes = explode('-',$song_info.publishtime)}
						{foreach $pubTimes as $item }
							{if $item == "00"}
								{$pubTime = "{$pubTimes[0]}年"}
							{else}
								{$pubTime = $song_info.publishtime}

							{/if}
						{/foreach}
						发行时间：{$pubTime}
					</li>
					{/if}
					{if ($song_info.resource_type == 0 || $song_info.resource_type == 1) && $song_info.publishcompany}
					<li>
						所属公司：{$song_info.publishcompany}<br />
					</li>
					{/if}
									  *}
					{if ($song_info.resource_type == 0 || $song_info.resource_type == 1) && $song_info.tags}
					<li class="clearfix tag">
						<span class="label">歌曲标签：</span>{foreach $song_info.tags as $item}<a class="tag-list" href="/tag/{$item|escape:url nofilter}">{$item}</a>{if !$item@last}<i class='module-line'></i>{/if}{/foreach}
					</li>
					
					{/if}
				</ul>

				{if $song_info.has_mv2 != 0 }
				{include file="sns/song_page/mod_mv.html.tpl" inline}
				{/if}

			
            {**
			<a href="#" class="song-collection stat-info collection-hook { ids:{$song_info.song_id},type:'song' }">
				<span class="b">
					<b class="favorites-num-hook  { 'num': '{$song_info.favorites_num}' }">
						{$song_info.favorites_num}
					</b>
					<br /><span class="text-collection">收藏到云</span>
				</span>
			</a>
            **}
		</div>


	
</div>


<div class="guide-to-mobile-wrapper">
     {*张韶涵app  *}
    {*{if $song_info.all_artist_ting_uid == "1069"}*}
    {*<p class="guide-to-mobile">张韶涵官方客户端已经发布！音乐资讯应有尽有，点击下载：（<a class="android-icon" href="http://music.baidu.com/cms/artistapp/zhangshaohan/artist_angela.apk?rf=w"><b>Android</b>版</a>）。</p>*}
    {*{else}*}
    {*{include file="sns/song_page/mod_guide_to_mobile.html.tpl"}*}
    {include file="sns/module/mod_download_clients.html.tpl"}
    {*{/if}*}
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
    {*ipaLink = 'http://mu5.bdstatic.com/static/flash/Baidu_Music_song.ipa'*}
{*}*}

{*{app_layer id = 'android-down-layer'*}
    {*os = "Android"*}
    {*title = '<img src="/static/images/music/app-down-title-android.png" alt="百度音乐Android版"/>'*}
    {*desc = '<p class="down-desc">下载会自动在几秒钟内开始，如果浏览器长时间没有响应，<a href="http://ting.baidu.com/mobile/app/BaiduMusic_musicsong.apk" style="text-decoration: underline;" rel="nofollow">请点击这里下载</a></p>'*}
    {*istep1 = '用数据线将手机连接至电脑'*}
    {*istep2 = '将下载的apk文件复制到手机，<br/>在手机中点击该文件安装'*}
    {*istep3 = '安装成功后，打开"百度音乐"<br/>享受听觉盛宴'*}
    {*otext1 = '使用短信免费发送下载链接到手机'*}
    {*otext2 = '使用百度手机助手一键安装'*}
    {*otext3 = '使用二维码扫描软件直接扫描下载'*}
    {*obtn3 = '<img class="tdc" src="/static/images/music/tdc-android-song.png"/>'*}
    {*apkId = '10'*}
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

