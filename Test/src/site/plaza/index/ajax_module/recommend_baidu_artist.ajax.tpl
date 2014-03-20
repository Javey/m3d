{extends file="ajax.tpl"}
{block name="ajax_html"}
    {extends file="module/module.html.tpl"}
    {block name='mod_class'}baidu-artist{/block}
    {block name='mod_attr'}monkey="baidu-artist" log-alias="baidu-artist"{/block}
    {block name="mod_head"}
        <h2 class="title">百度原创音乐人</h2>
        <a class="more" href="http://y.baidu.com/?pst=music_home" target="_blank">更多<span>&gt;&gt;</span></a>
        <div class="baidu-artist-focus clearfix">
            <a href="" class="left-btn js-slider-left"></a>
            <div class="baidu-artist-focus-page js-slider-indicator">
                {include file="widget/slider_indicator/slider_indicator.html.tpl" inline}
                {slider_indicator count=3}
            </div>
            <a href="" class="right-btn js-slider-right"></a>
        </div>
    {/block}
    {block name="mod_body"}
        {if $tplData.data}

        {*  Function gen baidu artist focus *}
            {function name=gen_baidu_artist_focus item=false lazyload=true}
                {pixel_double_truncate
                totalWidth = 170
                one = ["string" => $item.name, ratio => 0.8, font => "tahoma_12"]
                two = ["string" => $item.style, ratio => 0.2, font => "tahoma_12"]
                ret = ret
                }
                <div class="baidu-artist-left-panel">
                    <div class="focus-thumbnail">
                        <a href="http://y.baidu.com/artist/{$item.musician_id}?pst=music_home{if $item.song_id}&sid={$item.song_id}{/if}" target="_blank">
                            {if $lazyload}
                                <img org_src="{$item.img}" class="lazyload" alt="{$item.name}"/>
                            {else}
                                <img src="{$item.img}" alt="{$item.name}">
                            {/if}
                        </a>
                        <a class="css-play" href="http://y.baidu.com/artist/{$item.musician_id}?pst=music_home{if $item.song_id}&sid={$item.song_id}{/if}" target="_blank"></a>
                    </div>
                    <div class="focus-author-info">
        <span class="artist-name">
                  <a title="{$item.name}" target="_blank" href="http://y.baidu.com/artist/{$item.musician_id}?pst=music_home">
                      {$item.name|pixel_truncate:$ret.oneWidth:'tahoma_12'}
                  </a>
                </span>
                        <span class="hor-line"></span>
                        <span class="artist-style" title="{$item.style}">{$item.style|pixel_truncate:$ret.twoWidth:'tahoma_12'}</span>
                    </div>
                    <div class="focus-author-intro">
                        {$item.intro|pixel_truncate: 340}
                    </div>
                </div>
            {/function}
        {* End function gen baidu artist focus  *}


        {*>>>>>>>>>>>> Function gen_baidu_artist *}
            {function name=gen_baidu_artist data=false}
                {foreach $data as $item}
                    {pixel_double_truncate
                    totalWidth = 100
                    one = ["string" => $item.name, ratio => 0.8, font => "tahoma_12"]
                    two = ["string" => $item.style, ratio => 0.2, font => "tahoma_12"]
                    ret = ret
                    }
                    <div class="baidu-artist-wrapper">
                        <div class="baidu-artist-cover-wrapper">
                            <a class="baidu-artist-cover" href="//y.baidu.com/artist/{$item.musician_id}?pst=music_home{if $item.song_list}&sid={$item.song_list[0].song_id}{/if}" target="_blank">
                                <img src="{$item.avatar|default:#ARTIST_DEFAULT_90s#}" alt="{$item.name}" class="lazyload" title="{$item.name}"/>
                            </a>
                            <a class="css-play" href="//y.baidu.com/artist/{$item.musician_id}?pst=music_home{if $item.song_list}&sid={$item.song_list[0].song_id}{/if}" target="_blank"></a>
                        </div>
                        <div class="baidu-artist-detail">
                            <div class="baidu-artist-info clearfix">
                <span class="artist-name">
                  <a title="{$item.name}" target="_blank" href="http://y.baidu.com/artist/{$item.musician_id}?pst=music_home">
                      {$item.name|pixel_truncate:$ret.oneWidth:'tahoma_12'}
                  </a>
                </span>
                                <span class="hor-line"></span>
                                <span class="artist-style" title="{$item.style}">{$item.style|pixel_truncate:$ret.twoWidth:'tahoma_12'}</span>
                            </div>
                            <ul>
                                {foreach $item.song_list as $song}
                                    <li>
                                        <a href="//y.baidu.com/artist/{$item.musician_id}?pst=music_home&sid={$song.song_id}" target="music_play">
                                            <span class="artist-play icon-play js-log"></span><span class="artist-song js-log">{$song.title|pixel_truncate:110}</span>
                                        </a>
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                {/foreach}
            {/function}

            {function name=gen_baidu_artist_right data=false}
                {$artistList1 = []}
                {$artistList2 = []}
                {foreach $data as $list}
                    {if $list@index < 2}
                        {$a = array_push( $artistList1, $list)}
                    {elseif $list@index >= 2 &&  $list@index < 4}
                        {$b = array_push( $artistList2, $list)}
                    {/if}
                {/foreach}
                <div class="baidu-artist-right-panel">
                    <div class="clearfix">
                        {gen_baidu_artist data=$artistList1}
                    </div>
                    <div class="module-dotted"></div>
                    <div class="clearfix">
                        {gen_baidu_artist data=$artistList2}
                    </div>
                </div>
            {/function}
        {*<<<<<<<<<<<<<<<< Function gen_baidu_artist *}

        {*>>>准备音乐人分屏数据*}
            {$artistPageOne = []}
            {$artistPageTwo = []}
            {$artistPageThree = []}
            {foreach $tplData.data.list as $list}
                {if $list@index < 4}
                    {$a = array_push( $artistPageOne, $list)}
                {elseif $list@index >= 4 &&  $list@index < 8}
                    {$b = array_push( $artistPageTwo, $list)}
                {elseif $list@index >= 8 && $list@index < 12}
                    {$c = array_push( $artistPageThree, $list)}
                {/if}
            {/foreach}
        {*<<<准备右侧音乐人分屏数据*}



            <div class="baidu-artist-list wrap clearfix">
                <ul class="clearfix page-hook" >
                    {* 左侧焦点图 *}
                    {gen_baidu_artist_focus item=$tplData.data.focus[0] lazyload=false}
                    {* 右侧列表 *}
                    {gen_baidu_artist_right data=$artistPageOne}
                </ul>
                <ul class="page-hook">
                    {* 左侧焦点图 *}
                    {gen_baidu_artist_focus item=$tplData.data.focus[1]}
                    {* 右侧列表 *}
                    {gen_baidu_artist_right data=$artistPageTwo}
                </ul>
                <ul class="page-hook">
                    {* 左侧焦点图 *}
                    {gen_baidu_artist_focus item=$tplData.data.focus[2]}
                    {* 右侧列表 *}
                    {gen_baidu_artist_right data=$artistPageThree}
                </ul>
            </div>
            <div class="module-dotted"></div>
            <div class="baidu-artist-tags-wrapper clearfix">
                <span class="baidu-artist-tags-summary">音乐风格:</span>
                <ul class="baidu-artist-tags">
                    <li><a href="http://y.baidu.com/musician?pst=music_home#pop/hot/all" target="_blank"><em>流行</em></a></li>
                    <li><a href="http://y.baidu.com/musician?pst=music_home#electronic/hot/all" target="_blank">电子</a></li>
                    <li><a href="http://y.baidu.com/musician?pst=music_home#rock/hot/all" target="_blank"><em>摇滚</em></a></li>
                    <li><a href="http://y.baidu.com/musician?pst=music_home#jazz/hot/all" target="_blank">爵士</a></li>
                    <li><a href="http://y.baidu.com/musician?pst=music_home#esay/hot/all" target="_blank">轻音乐</a></li>
                    <li><a href="http://y.baidu.com/musician?pst=music_home#world/hot/all" target="_blank">世界音乐/新世纪</a></li>
                    <li><a href="http://y.baidu.com/musician?pst=music_home#folk/hot/all" target="_blank"><em>民谣/乡村</em></a></li>
                    <li class="last"><a href="http://y.baidu.com/musician?pst=music_home#classical/hot/all" target="_blank">古典</a></li>
                </ul>
            </div>
        {else}
            <p class="no-data">很抱歉，暂无百度音乐人数据</p>
        {/if}

    {/block}

{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}
    // 通过call绑定jQuery对象来成为选择器作用域
    context = this;

    // 初始化Slider
    new ting.Slider($(".baidu-artist-list"), $(".baidu-artist-focus"))

    // 单曲播放和添加按钮
    //$(".music-icon-hook", context).musicIcon();

{/block}
