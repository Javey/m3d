{include file="widget/songlist_collection/songlist_collection.html.tpl"}
{$nav1=["全部","励志","经典","摇滚","中国风","午后","想哭","寂寞","爱情","性感","DJ"]}
{$nav2=["毕业","伤感","思念","安静","浪漫","喜悦","怀旧","激情","夜晚","咖啡厅","感动"]}
<div id="songlistNav" class="songlist-nav">
    <!-- <i class="bg-opacity"></i> -->
    <div class="nav-on">{$tplData.data.tag|default:"全部"}</div>
    <a href="#" id="nav-more-link">更多</a>
    <a href="#" id="nav-fold" class="fold-up">收起</a>
    <ul>
        {foreach $nav1 as $item}
        <li>
            <a class="nav-item {if $tplData.data.tag==$item}on{/if}" href="/songlist/{if $item!='全部'}{$item}{/if}">{$item}</a>
        </li>
        {/foreach}
    </ul>
    <ul class="clearfix nav-more">
        {foreach $nav2 as $item}
        <li>
            <a class="nav-item {if $tplData.data.tag==$item}on{/if}" href="/songlist/{$item}">{$item}</a>
        </li>
        {/foreach}
    </ul>
</div>
<div class="songlist-stream" >
    <div class="content" data-tag="{$tplData.data.tag}" data-count="12">

        <div class="stream-item">
            {foreach $tplData.data.playlist as $item}
            {if $item@index%4==0}
                {songlist_collection data=$item}
            {/if}
            {/foreach}
        </div>
        <div class="stream-item">
            {foreach $tplData.data.playlist as $item}
            {if $item@index%4==1}
                {songlist_collection data=$item}
            {/if}
            {/foreach}
        </div>
        <div class="stream-item">
            {foreach $tplData.data.playlist as $item}
            {if $item@index%4==2}
                {songlist_collection data=$item}
            {/if}
            {/foreach}
        </div>
        <div class="stream-item stream-last">
            {foreach $tplData.data.playlist as $item}
            {if $item@index%4==3}
                {songlist_collection data=$item}
            {/if}
            {/foreach}
        </div>

    </div>
    <div class="bottom">
        <div class="loading"></div>
    </div>
</div>