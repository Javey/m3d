{extends file="ting.html.tpl"}
{block name="assign" append}
{$navIndex='top'}
{/block}

{block name="head" append}
<link rel="stylesheet" type="text/css" href="/static/css/mod_top.css{*version file='/static/css/mod_top.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="body_class"}
class="channel top-channel"
{/block}

{block name="js-page"}
<script type="text/javascript" _xcompress="true">
    $(".song-list").songList();
    $('.play-all-hook').click(function(){
            var type = $(this).data("type"),
                opt = {
                    moduleName : type
                };
            ting.media.playTop( type ,opt );

        $(this).tip().tip("tipup", {
                        msg: "已开始播放",
                        iconClass: "tip-success"
                    });
        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("play_all");
        }
        /* 点击统计 end by lutaining */

        return false;
    });
    $(".ecom-ad").ecomad();
</script>

{**
<script type="text/javascript">
    createClickMonkey("ting-music-plaza-top-index");
</script>
**}
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-top-index{/block}


{block name="title"}百度音乐排行榜{/block}
{block name='keywords'}“歌曲排行榜，2012歌曲排行榜，新歌排行榜2012，音乐排行榜，流行音乐排行榜，流行歌曲2012排行榜，榜单，百度音乐”{/block}
{block name='description'}“百度音乐排行榜，为你提供最权威的2012歌曲排行榜，新歌排行榜2012，音乐排行榜，流行音乐排行榜，流行歌曲2012排行榜榜单，最快的新歌速递，最详尽的媒体榜单，最全的分类榜单，享受欧美金曲榜，华语金曲榜，影视金曲榜，网络歌曲榜，经典老歌榜，中国好声音等榜单歌曲的魅力。”{/block}

{block name="content_main"}
{include file="widget/adm/adm.html.tpl" inline}
{adm 
    id = "627"
    class = "ad-banner ecomad-banner-loading"
    width = 960
}
{include file="plaza/top/mod_top.html.tpl" singerW=100 songW=150 artist_trun_width=125 inline}
{/block}
