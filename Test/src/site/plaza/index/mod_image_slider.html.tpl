{$focusList = $tplData.focusList}
{if $focusList}
    {include file="widget/focus/focus.html.tpl" inline}
    <div id="sliderFrame" monkey="slider-frame"  log-alias="slider-frame" class="clearfix">
        {function name=newFocus data=null isImage=false width=670 height=230 target=true}
            <div id="focus-hook" class="focus-hook music-ui-focus loading">
                <p class="prevp arrowp" style="height:{$height}px;">
                    <a href="#" hidefocus="true" title="上一张" id="prev" class="arrow prev"></a>
                </p>
                <p class="nextp arrowp" style="height:{$height}px;">
                    <a href="#" hidefocus="true" title="下一张" id="next" class="arrow next"></a>
                </p>
                <div class="focus-cover" style="height:{$height}px;">
                    <ul class="list">
                        {foreach $data as $item}
                            <li data-song="{$item.song_ids}" {if $item.type=="playlist"} data-module="jiaodian_{$item.entity}_{$item.entity_title}" {/if}>
                                <a href="{$item.link}" data-stats="{$item.desc|default:'focus'}" target="_blank" title="{$item.desc}">
                                    {if $item@first}
                                        <img src="{$item.pic}" width="{$width}" height="{$height}" alt="{$item.desc}" />
                                    {else}
                                        <img src="{#PIC_PLACEHOLDER#}" org_src="{$item.pic}" width="{$width}" height="{$height}" alt="{$item.desc}" />
                                    {/if}
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
                <div class="focus-page clearfix">
                    <div class="page-inner clearfix">
                        <div class="page windowslider">
                            {foreach $data as $item}
                                <div class="windowslider-item">
                                    <a href="" class="windowslider-trigger page-index {if $item@first}page-active{/if}"></a>
                                    {*<div class="windowslider-content">*}
                                    {*<img alt="{$item.desc}" src="{#PIC_PLACEHOLDER#}" org_src="{$item.thumb}"/>*}
                                    {*<span class="arrow-down"></span>*}
                                    {*</div>*}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
                <a href="#" class="focus-play"></a>
            </div>
        {/function}

        {newFocus data=$focusList width=560 height=230}

        <div class="focus-ad clearfix">
            <div class="btn-list">
                <a href="http://qianqian.baidu.com/download/BaiduMusic-12345630.exe" title="无损歌曲免费体验">下载PC版</a>
                <a href="http://music.baidu.com/cms/mobile/static/apk/BaiduMusic_musicsybutton.apk" title="下载Android版">下载Android版</a>
                <a href="http://itunes.apple.com/cn/app/id468623917" title="下载iPhone版" target="_blank">下载iPhone版</a>
            </div>
        </div>
    </div>
{/if}
