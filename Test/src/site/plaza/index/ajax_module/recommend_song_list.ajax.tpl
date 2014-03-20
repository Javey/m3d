{extends file="ajax.tpl"}
{block name="ajax_html"}
    {extends file="module/module.html.tpl"}
    {block name='mod_class'}recommend-songlist{/block}
    {block name='mod_attr'}monkey="recommend-songlist"{/block}
    {block name="mod_head"}
        {*<a href="/mv" class="more">更多<span>&gt;&gt;</span></a>*}
        {*<h2 class="title">推荐MV</h2>*}
        {*{$page = 8}*}
        {*<div class="mv-focus clearfix">*}
            {*<a href="" class="left-btn js-slider-left"></a>*}
            {*<div class="mv-focus-page js-slider-indicator">*}
                {*{include file="widget/slider_indicator/slider_indicator.html.tpl" inline}*}
                {*{slider_indicator data=$tplData.data}*}
            {*</div>*}
            {*<a href="" class="right-btn js-slider-right"></a>*}
        {*</div>*}
        <a class="more" href="/songlist">更多<span>&gt;&gt;</span></a>
        <h2 class="title">热门歌单</h2>
        {$page = 4}
        <div class="song-list-focus clearfix">
            <a href="" class="left-btn"></a>

            <div class="song-list-focus-page">
                {include file="widget/slider_indicator/slider_indicator.html.tpl" inline}
                {slider_indicator count=5}
            </div>
            <a href="" class="right-btn"></a>
        </div>
    {/block}
    {block name="mod_body"}
        {include file="widget/author_list/author_list.html.tpl" inline}
        {if $tplData.data}
            {$lastIndex = 20}
            <div class="recommend-songlist-cover wrap">
                {foreach $tplData.data as $item}
                    {if $item@index<20}
                        {if $item@index%4==0}
                            <ul class="clearfix film-page ul-hook">
                            <li>
                            <div class="clearfix">
                        {/if}
                    {if $item@index < $lastIndex}
                    {if $item@index %2 == 0 && $item@index%4!=0}
                        </div>
                        <div class="module-dotted"></div>
                        <div class="clearfix">
                    {/if}
                        {if $item@index % 2 == 1}{$filmListEvenClass = "even"}{else}{$filmListEvenClass = ""}{/if}
                        {$ids = []}
                        {foreach $item.song_list as $songid}
                            {$idsArr = array_push($ids, $songid.song_id)}
                        {/foreach}
                        <div class="songlist-item clearfix {$filmListEvenClass}">
                            <div class="songlist-cover">
                                <div class="col-listen">
                                    <span><i></i>{number_format($item.info.listen_count)}</span>
                                </div>
                                <a href="/songlist/{$item.info.playlist_id}">
                                    {if ($item@index < $page)}
                                    <img width="130" height="130" src="{$item.pic|default:#SONGLIST_COVER_DEFAULT_150s#}"/>
                                    {else}
                                    <img width="130" height="130" org_src="{$item.pic|default:#SONGLIST_COVER_DEFAULT_150s#}" src="{#PIC_PLACEHOLDER#}" class="lazyload"/>
                                    {/if}
                                </a>

                                <div class="songlist-title">
                                    <h2>{$item.info.title|pixel_truncate:160|escape:"html" nofilter}</h2>
                                </div>
                                <a href="#" title="播放"
                                    {$logData = "hotsl_`$item.info.playlist_id`_`$item.info.title`||plazaSonglistBtn"}
                                   data-song='{json_encode(["ids"=>$ids,"moduleName" => $logData,
                                   "listid"=>$item.info.playlist_id,"logAction"=>"play_song"])}'
                                   class="songlist-all-play play"></a>
                            </div>
                            <div class="col-list" style="width: 180px;">
                                {strip}
                                    <ul class="song-list">
                                        {foreach $item.song_list as $song}
                                            {pixel_double_truncate
                                            totalWidth = 140
                                            one = ["string" => $song.title, ratio => 0.6, font => "tahoma_14"]
                                            two = ["string" => $song.author, ratio => 0.4, font => "tahoma_12"]
                                            ret = ret
                                            }
                                            {if $song@index<5}
                                                <li class="clearfix">
                    <span class="music-icon-hook "
                          data-musicicon="{json_encode(["id"=>$song.song_id,"type"=>"song","iconStr"=>"play","moduleName"=>$logData])}">
								      <a class="list-micon icon-play{if $song.bePlayed==1}-disabled{/if}" data-action="play"
                         title="{if $song.bePlayed==1}因版权保护，本资源不能播放{else}播放{/if}" href="#"></a>
		                </span>
	                <span class="song-name">
	                    <a href="/song/{$song.song_id}" sid="{$song.song_id}" class="song top-song-hook"
                         title="{$song.title}">{$song.title|pixel_truncate:$ret.oneWidth:'tahoma_14' nofilter}</a>
	                </span>&nbsp;-&nbsp;<span class="singer-name">
	                    {author_list releaseStatus=$song.relate_status ids=$song.all_artist_ting_uid  names=$song.author width=$ret.twoWidth}
	                </span>
                                                </li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                {/strip}
                            </div>
                        </div>
                        　　
                    {/if}


                        {if $item@index%4==3||$item@last}
                            </div>
                            </li>
                            </ul>
                        {/if}
                    {/if}
                {/foreach}
            </div>
        {else}
            <p class="no-data">很抱歉，暂无歌单数据</p>
        {/if}
    {/block}

{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}
    // 通过call绑定jQuery对象来成为选择器作用域
    context = this;

    // 初始化Slider
    new ting.Slider($(".recommend-songlist-cover"), $(".song-list-focus"))

    // 单曲播放和添加按钮
    $(".music-icon-hook", context).musicIcon();

    // 播放影视、 歌单歌曲
    $('.songlist-all-play', context).click(function () {
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

    // 统计播放歌单 (歌单配图上播放按钮)
    $('.songlist-all-play', context).bind('click', function () {
        var listid = $(this).data("song").listid;
        $.ajax({ url: "/data/music/songlist/listen?playlistId=" + listid + "&t=" + (new Date() * 1)});
        return false;
    });
{/block}