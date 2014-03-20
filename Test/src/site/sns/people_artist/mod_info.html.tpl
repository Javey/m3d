{include file="widget/button/button.html.tpl" inline}
{include "widget/app_layer/app_layer.html.tpl" inline}

<div id="baseInfo" class="base-info clearfix" monkey="baseInfo" ting_uid="{$tplData.artist_info.ting_uid}">
	{**
	<span class="play-num"><span class="num">{number_format($tplData.listener_total)}</span><span class="c6">听众</span></span>
	**}

	<div class="cover-img">
		<span class="cover"><img src="{$ownerInfo.avatar_middle|default:#ARTIST_DEFAULT_130b#}" alt="{$ownerInfo.realname|default:$ownerInfo.nick}" /></span>
        {if $tplData.inBillboard}
            {if $tplData.inBillboard<=20}
                <i class="top-index">{$tplData.inBillboard}</i>
            {else}
                <i class="top-index top-default"></i>  
            {/if}
        {/if}
	</div>
	<div class="base-info-cont people-artist">
    <div class="clearfix">
		<h2 class="singer-name">{$ownerInfo.realname|default:$ownerInfo.nick}</h2>
      {*音乐人提示*}
      {if $tplData.artist_info.musician_id}
        <a href="//y.baidu.com/artist/{$tplData.artist_info.musician_id}?pst=music_home" class="musician-link"><span class="text-align">Ta已入驻百度音乐人社区</span><sup>>></sup></a>
      {/if}
      {*热度提示*}
      {if $ownerInfo.hot}
      <span class="hot-num"><span class="c6">热度</span><span class="num">{number_format($ownerInfo.hot)}</span></span>
      {/if}
    </div>
		<ul class="c6 clearfix">
            {if $tplData.artist_info.country || $tplData.artist_info.constellation}<li>{if $tplData.artist_info.country}地区：<span>{$tplData.artist_info.country}</span>{/if}&nbsp;&nbsp;&nbsp;&nbsp;{if (substr($ownerInfo.birth,-5)!='00-00')&&$tplData.artist_info.gender!=2}生日：<span class="">{substr($ownerInfo.birth,-5)} {if $tplData.artist_info.constellation && $tplData.artist_info.constellation !="未知"} ({$tplData.artist_info.constellation}座){/if}</span>{/if}</li>{/if}
            {$gbk_nick = urlencode(iconv("UTF-8", "GB2312//IGNORE", $ownerInfo.realname|default:$ownerInfo.nick))}            
            <li class="artist-more-info clearfix"><a id="baike_artist" href="http://baike.baidu.com/search/word?word={$gbk_nick}&pic=1&fr=bdmusicPC " target="_blank">Ta的简介</a> <i class="module-line vline"></i> {if $tplData.artist_info.tiebaName}<a id="artistTieba" href="javascript:;">Ta的贴吧</a> <i class="module-line vline"></i> {/if}<a id="artistImgLink"  href="javascript:;">Ta的图片</a>

            </li>
            
            
            <li class="opera">
				<div class="singer-share c6">
	            	<span class="share-label">分享到： </span>
					<div id="bdshare" class="bds_tools bdshare_t" style="display: block;position: static; border: none;padding: 0 0 2px 0;">
				        <a class="bds_qzone"></a>
				        <a class="bds_renren"></a>
				        <a class="bds_tqq"></a>
				        <a class="bds_tsina"></a>
				        <span class="bds_more"></span>
					</div>	
            	</div>

	{$ids = []}
	{foreach $tplData.song_list as $item}
		{if $item@index <20}
			{$tmp = array_push($ids, $item.song_id)}
		{/if}
	{/foreach}
                {if $tplData.artist_info.topHost50}
				<span class="play-all-hook" data-ids="{$tplData.artist_info.topHost50}" data-playdata = '{json_encode(["ids"=> $ids, "moduleName"=> "playhot" , "ting_uid"=>$tplData.artist_info.ting_uid , "artist_id"=> $tplData.artist_info.artist_id])}'>
                    {button 
                    style = "a"
                    str = "播放 <b>Ta</b> 的热门歌曲"
                    icon = "play"
                    class = " "
                    href = "#"}
                </span>
            {/if}
            {button 
            style = "b"
            str = "收听 <b>Ta</b> 的电台"
            icon = "fm"
            isRightIcon = true
            class = "btn-singer-fm"
            href = "#"
            tagAtt = "artist = '{$ownerInfo.realname|default:$ownerInfo.nick}' target='_blank'"
        }
            
			</li>
						
		</ul>
	</div>
</div>
{if $tplData.new_song}
    <div class="mod-newsong-wrapper">
        <div class="mod-newsong clearfix">
        {if $tplData.new_song.album}
            {$data = $tplData.new_song.album}
            <div class="new-album"> 
                <i class="mod-new-icon"></i> 
                {if $data.first_release == 1}<i class="firstpub">独家首发</i>{/if}<i>最新专辑:</i>
                <a href="/album/{$data.album_id}" title="{$data.title}">《{$data.title|html_pixel_truncate:250}》</a>
                <i>{$data.publishtime}</i> 
                {if $data.styles}
                    <i class="module-line vline"></i>
                    <i>{$data.styles}</i>
                {/if}
                {if $data.publishcompany}
                    <i class="module-line vline"></i>
                    <i>{$data.publishcompany}</i>
                {/if}
            </div>
        {elseif $tplData.new_song.song}
            {$data = $tplData.new_song.song}
			{song_link_url_plugin song=$data linkWithNoSongId="#" songLinkUrl=theSongLink}
            <div class="new-song">
                <i class="mod-new-icon"></i>
                <i>最新单曲:</i>
                <a href="{$theSongLink}" title="{$data.title}" {if $data.album_title}class="mr5"{/if}>{$data.title|html_pixel_truncate:150}</a>
                {if $data.album_title}
                    <i class="c9 mr5">-</i>
                    {if $data.relate_status ==0 || $data.relate_status == 2}
                    <a href="/album/{$data.album_id}" title="{$data.album_title}">《{$data.album_title|html_pixel_truncate:100}》</a>
                    {else}<a href="/search?key={$data.album_title|escape:'url'}+{$data.author|escape:'url'}">《{$data.album_title|pixel_truncate:100}》</a>{/if}
                {/if}
                <i>{$data.publishtime}</i> 
                {if $data.style}
                    <i class="module-line vline"></i>
                    <i>{$data.style}</i>
                {/if}
                {if $data.publishcompany}
                    <i class="module-line vline"></i>
                    <i>{$data.publishcompany}</i>
                {/if}
            </div>
        {/if}
        </div>
    </div>
{else}
<div class="guide-to-mobile-wrapper">
    {** 张韶涵app  **}
    {if $tplData.artist_info.ting_uid == "1069"}
    <p class="guide-to-mobile">张韶涵官方客户端已经发布！音乐资讯应有尽有，点击下载：（<a class="android-icon" href="http://music.baidu.com/cms/artistapp/zhangshaohan/artist_angela.apk?rf=w"><b>Android</b>版</a>）。</p>
    {else}
    {**
    <p class="guide-to-mobile">在手机上搜音乐 - 下载客户端（<a id="android-down-link" class="android-icon" href="http://ting.baidu.com/mobile/app/BaiduMusic_musicartist.apk"><b>Android</b>版</a>，<a id="ios-down-link" class="ios-icon" target="_blank" href="https://itunes.apple.com/cn/app/id468623917"><b>iPhone</b>版</a>），或直接访问 <b>music.baidu.com</b>。</p>
    **}
    {include file="sns/song_page/mod_guide_to_mobile.html.tpl"}
    </p>
    {/if}
</div>
{/if}


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
    {*ipaLink = 'http://mu5.bdstatic.com/static/flash/Baidu_Music_artist.ipa'*}
    {*apkId = '11'*}
{*}*}

{*{app_layer id = 'android-down-layer'*}
    {*os = "Android"*}
    {*title = '<img src="/static/images/music/app-down-title-android.png" alt="百度音乐Android版"/>'*}
    {*desc = '<p class="down-desc">下载会自动在几秒钟内开始，如果浏览器长时间没有响应，<a href="http://ting.baidu.com/mobile/app/BaiduMusic_musicartist.apk" style="text-decoration: underline;" rel="nofollow">请点击这里下载</a></p>'*}
    {*istep1 = '用数据线将手机连接至电脑'*}
    {*istep2 = '将下载的apk文件复制到手机，<br/>在手机中点击该文件安装'*}
    {*istep3 = '安装成功后，打开"百度音乐"<br/>享受听觉盛宴'*}
    {*otext1 = '使用短信免费发送下载链接到手机'*}
    {*otext2 = '使用百度手机助手一键安装'*}
    {*otext3 = '使用二维码扫描软件直接扫描下载'*}
    {*obtn3 = '<img class="tdc" src="/static/images/music/tdc-android-artist.png"/>'*}
    {*apkId = '11'*}
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
