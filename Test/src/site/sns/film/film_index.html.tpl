{extends file="sns/sns.html.tpl"}

{block name="assign" append}
{$filmTitle=$tplData.film_info.title|cat:$tplData.film_info.versions|cat:$tplData.film_info.session}
    {capture name="keywords"}
        "{$filmTitle},{foreach $tplData.song_list as $item}{$item.title},{/foreach}影视歌曲,影视,在线试听,MP3下载，歌词下载"
    {/capture}
    {$navIndex='singer'}
    {$showSubNav=false}
{/block}
{block name="title"}{$filmTitle}_{$tplData.film_info.type}{/block}
{block name='keywords'}{$smarty.capture.keywords}{/block}
{block name='description'}{$smarty.capture.keywords}{/block}

{block name='js-monkey-pageid'}ting-music-filmpage{/block}

{block name="css" append}
    <link rel="stylesheet" type="text/css" href="/site/sns/film/film_index.css"/>
{/block}

{block name="js" append}
    <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
    <script type="text/javascript" id="bdshell_js"></script>
    <script type="text/javascript">
        var filmName = "{$filmTitle}" || "";
        var bds_config = {
            'bdText':'{$tplData.film_info.type}《{$filmTitle}》全部原声歌曲，推荐给大家~ （分享自@百度音乐）'
            {*"bdPic" : "{$tplData.data.album.pic_big|default:#ALBUM_COVER_DEFAULT_130#}"*}
        };
        document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
    </script>
    <script type="text/javascript" src="/static/js/film_index.js"></script>
{/block}

{block name="sns_left"}
    <div class="main-body-cont film-page">
        {include file="sns/film/mod_info_index.html.tpl" inline}
        {include file="sns/film/mod_songlist_index.html.tpl" songData = $tplData.song_list}
        {if !empty($tplData.mv_list)}
            {include file="sns/film/mod_mv.html.tpl" mvNname=$filmTitle inline}
        {/if}
    </div>
{/block}
{block name="sns_right"}
    {include file="sns/film/mod_sidebar.html.tpl" inline}
{/block}