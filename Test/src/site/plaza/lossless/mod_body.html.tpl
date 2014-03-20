<div class="main-body" monkey="content" alog-alias="content">
    <div class="content-head clearfix">
        <div class="filter clearfix">
            {if $area === 'all' && $stylename === 'all'}
                {if $artist === 'all'}
                    {$title = '全部'}
                    {$hideDelete = true}
                {else}
                    {$title = $artistArray[$artist]}
                {/if}
            {elseif $area !== 'all' && $stylename === 'all'}
                {$title = $areaArray[$area]}
            {elseif $stylename !== 'all' && $area === 'all'}
                {$title = $styleArray[$stylename]}
            {else}
                {$title = "`$areaArray[$area]``$styleArray[$stylename]`"}
            {/if}
            <h1>{$title}专辑</h1>
            {if !$hideDelete}
                <a class="delete" href="/lossless/{$view}/all/{$order}" title="删除">x</a>
            {/if}
            {*<div class="view">*}
                {*<a href="#" class="view-item"><span class="icon album-icon"></span>专辑</a>*}
                {*<a href="#" class="view-item select"><span class="icon song-icon"></span>歌曲</a>*}
            {*</div>*}
        </div>
        <div class="sort">
            <em>排序：</em>
            {if $order == "hot"}
                <em class="order-selected">热度</em>
                <span class="module-line"></span>
                <em><a href="/lossless/{$view}/{$urlType}/time">时间</a></em>
            {else}
                <em><a href="/lossless/{$view}/{$urlType}/hot">热度</a></em>
                <span class="module-line"></span>
                <em class="order-selected"> 时间</em>
            {/if}
        </div>
    </div>
    <div class="content-body clearfix">
        {include file="plaza/lossless/mod_album_body.html.tpl"}
        {*{include file="plaza/lossless/mod_song_body.html.tpl"}*}
    </div>
</div>