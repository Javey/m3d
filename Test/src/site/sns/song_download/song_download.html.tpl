{extends file="ting.html.tpl"}
{include 'widget/button/button.html.tpl' inline}

{block name='keywords'}"音乐,mp3,百度音乐,下载,高品质下载"{/block}
{block name='description'}"mp3歌曲免费下载,高品质音乐下载。百度音乐是中国第一音乐门户，为你提供海量正版高品质音乐，最权威的音乐榜单，最快的新歌速递，最契合你的主题电台，最人性化的歌曲搜索，让你更快地找到喜爱的音乐，带给你全新音乐体验。"{/block}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/song_download.css{*version file='/static/css/song_download.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="title"}下载{/block}

{block name="assign" append}
    {** 用户状态 **}
    {if $loginInfo}
        {$serviceLevel = $loginInfo.vip.cloud.service_level}
        {if $serviceLevel == 'gold'}
            {$userStatus = 'goldVip'}
        {elseif $serviceLevel == 'comm'}
            {$userStatus = 'commVip'}
        {else}
            {$userStatus = 'login'}
        {/if}
    {else}
        {$userStatus = 'none'}
    {/if}

    {** 是否为三大资源 **}
    {if $tplData.data.song.is_charge == 1}
        {$three = 'isThree'}
    {else}
        {$three = 'notThree'}
    {/if}

    {*{$userStatus = 'none'}*}
    {*{$three = 'isThree'}*}
{/block}

{block name="body"}
{include "widget/adm/adm.html.tpl" inline}

{if $tplData.data.userPower.app}
	{$isAppActive = true}
{else}
	{$isAppActive = true}
{/if}

{if $tplData.errorCode == 22232}
	{** 海外IP **}
	{include "sns/song_download/mod_song_download_abroad.html.tpl" inline}
{else}
	<div class="download-info clearfix">
		<div id="loginbtn" style="display:none;"></div>

        {if $tplData.errorCode == 22012}
            {** 下架歌曲 **}
            {include "sns/song_download/mod_song_download_off.html.tpl" inline}
        {else if preg_match('/^\d+$/', $tplData.data.song.song_id)}
            {** 曲库资源歌曲 **}
            {include "sns/song_download/mod_song_download_quku.html.tpl" inline}
        {else}
            {** 第三方歌曲 **}
            {include "sns/song_download/mod_song_download_thirdparty.html.tpl" inline}
        {/if}
        {include file="sns/song_download/mod_mobile_spread.html.tpl" inline}
	</div>
	{include "sns/song_download/mod_ads.html.tpl" inline}
{/if}
{/block}

{block name='js-monkey-pageid'}ting-music-songdownload{$pageId}{/block}

{block name="js" append}
    {$song = $tplData.data.song}
    <script type="text/javascript" src="/static/js/song_download.js"></script>
	<script type="text/javascript">
        $(function() {
            ting.initDownload({
                downloadInfo: {
                    song_id: "{$song.song_id}",
                    song_title: "{$song.title}",
                    singer_id: "{$song.artist_id}",
                    singer_name: "{$song.author}",
                    album_id: "{$song.album_id}",
                    album_name: "{$song.album_name}",
                    resource_type: "{$song.resource_type}"
                },
                get: {json_encode($smarty.get) nofilter},
                loginInfo: {json_encode($tplData.loginInfo) nofilter}
            });
        })
	</script>
{/block}
{block name="body_fixed_pop"}
{include file="sns/song_batchdownload/song_batchdownload_dialog.html.tpl"}  
{/block}