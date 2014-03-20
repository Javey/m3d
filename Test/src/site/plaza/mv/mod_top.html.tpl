<div class="focus" id="focus" monkey="focus" alog-alias="focus">
    <div class="focus-info-inner focus-animate">
        {foreach $tplData.focus as $item}
            <div class="focus-img loading" {*style="background: {if substr($item.bgcolor,0,1)!="#"}#{/if}{$item.bgcolor}" *}data-background="{if substr($item.bgcolor,0,1)!="#"}#{/if}{$item.bgcolor}">
                <a href="/mv/{$item.mv_id}"><img class="lazyload" org_src="{$item.banner}" src="{#PIC_PLACEHOLDER#}" alt="{$item.desc}" /></a>
            </div>
        {/foreach}
    </div>
    <div class="focus-banner">
        <div class="focus-banner-bg"></div>
        <div class="focus-banner-wrapper clearfix">
            <div class="focus-info">
                {foreach $tplData.focus as $item}
                    <div class="focus-desc" {if $item@index != 0 } style="display:none;" {/if}>
                        <div class="mv-cover">
                            <a class="play" href="/mv/{$item.mv_id}" title="播放MV"></a>
                        </div>
                        <a class="focus-title" href="/mv/{$item.mv_id}" title="{$item.desc nofilter}">{$item.desc nofilter}</a>
                    </div>
                {/foreach}
            </div>
            <div class="focus-scroll">
                <a hidefocus=true href="" class="focus-left-btn"></a>
                <div class="focus-tab">
                    <ul class="clearfix">
                        {foreach $tplData.focus as $item}
                            <li>
                                <a href=""  class="{if $item@index == 0} active{/if}  loading">
                                    <img src="{$item.thumb}" alt="{$item.desc}">
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
                <a hidefocus=true href="" class="focus-right-btn"></a>
            </div>
        </div>
    </div>
</div>