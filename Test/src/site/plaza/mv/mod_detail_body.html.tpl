{include file="widget/mv_cover/mv_cover.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/mv_list/mv_list.html.tpl" inline}

{$url="/mv/`$area`_`$stylename`_`$feature`/`$order`"}

<div class="main-body" monkey="mainbody" alog-alias="mainbody">
    <div class="ab-list-container module">
        <div class="ab-list-head head clearfix">
            <div class="ab-list-select">
                <h1 class="music-seo">
                    <strong>音乐</strong>,<strong>百度音乐</strong>,<strong>流行歌曲</strong>,<strong>流行音乐</strong>,<strong>试听</strong>
                </h1>
                <span class="title">
                    {if $recommend == 'new'}
                        最新发布
                    {elseif $recommend == 'hot'}
                        最热MV
                    {elseif $recommend == 'all' && $area == 'all' && $stylename == 'all' && $feature == 'all'}
                        全部MV
                    {elseif $area != 'all'}
                        {$areaArray[$area]}
                    {elseif $stylename != 'all'}
                        {$styleArray[$stylename]}
                    {elseif $feature != 'all'}
                        {$featureArray[$feature]}
                    {else}
                        {$showSelected = true}
                        刷选：
                    {/if}
                </span>
                {*{if $showSelected}*}
                    {*{if $area != "all"}<span class="selected-item">{$areaArray[$area]}<a href="/mv/all?area=all&style={$stylename}&feature={$feature}&order={$order}">×</a></span>{/if}*}
                    {*{if $stylename != "all"}<span class="selected-item">{$styleArray[$stylename]}<a href="/mv/all?area={$area}&style=all&feature={$feature}&order={$order}">×</a></span>{/if}*}
                    {*{if $feature != "all"}<span class="selected-item">{$featureArray[$feature]}<a href="/mv/all?area={$area}&style={$stylename}&feature=all&order={$order}">×</a></span>{/if}*}
                {*{/if}*}
            </div>
            <div class="sort">
                <em>排序：</em>
                {if $order == "hot"}
                    <em class="order-selected">热度</em>
                    <span class="module-line"></span>
                    <em><a href="/mv/{$area}_{$stylename}_{$feature}/time">时间</a></em>
                {else}
                    <em><a href="/mv/{$area}_{$stylename}_{$feature}/hot">热度</a></em>
                    <span class="module-line"></span>
                    <em class="order-selected"> 时间</em>
                {/if}
            </div>
        </div>
            {mv_list list=$tplData.mvList.list showPlayIcon=false showNumber=true target=false className='mv-list-body' perLine=false}
            {if !empty($tplData.mvList.list)}
                {page_navigator total={$tplData.mvList.nums} size={$tplData.param.limit} start={$tplData.param.start} url="`$url`/#start#"}
            {/if}
    </div>
</div>