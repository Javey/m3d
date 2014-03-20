{extends file="module/module.html.tpl"}
{block name='mod_class'}recommend-song{/block}
{block name='mod_attr'}monkey="recommend-song"{/block}
{block name="mod_head"}
<h2 class="title">推荐金曲</h2>
{/block}
{block name="mod_body"}
{include file="widget/song_list/song_list.html.tpl"}
    <div class="recommend-song-list clearfix">
        {$topiclist1 = []}
        {$topiclist2 = []}
        {$topiclist3 = []}
        {foreach $tplData.recommendSong.songList as $list}
            {if $list@index < 3}
                {$a = array_push( $topiclist1, $list)}
            {elseif $list@index >= 3 &&  $list@index < 6}
                {$b = array_push( $topiclist2, $list)}
            {elseif $list@index >= 6 && $list@index < 9}
                {$c = array_push( $topiclist3, $list)}
            {/if}
        {/foreach}

        {song_list moduleName = "recommend" indexWidth="20" total=3 colIndex = false isDotted = false width="auto" numPluszero = false singerWidth=50 btnPos= "none" songWidth=108 colCheck= false songData=$topiclist1 funIcon=["play","add"] appendix=false colNewIcon=true colHotIcon=true}
        <div class="module-line songlist-spacing"></div>
        {song_list moduleName = "recommend" indexWidth="20" total=3 colIndex = false isDotted = false width="auto" numPluszero = false singerWidth=50 btnPos= "none" songWidth=108 colCheck= false songData=$topiclist2 funIcon=["play","add"] appendix=false colNewIcon=true colHotIcon=true}
        <div class="module-line songlist-spacing"></div>
        {song_list moduleName = "recommend" indexWidth="20" total=3 colIndex = false isDotted = false width="auto" numPluszero = false singerWidth=50 btnPos= "none" songWidth=108 colCheck= false songData=$topiclist3 funIcon=["play","add"] appendix=false colNewIcon=true colHotIcon=true}

    </div>





{/block}
