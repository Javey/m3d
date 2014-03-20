<div class="sidebar" monkey="sidebar" alog-alias="sidebar">
    <h2 class="title">按地区/流派筛选</h2>
    <div class="select">
        <div class="by-area select-item" id="by-area">
            <h4>地区</h4>
            <ul class="clearfix">
                {foreach $areaArray as $key => $value}
                    <li><a href="/lossless/{$view}/{$key}_{$stylename}/{$order}" {if $area == $key} class="type-selected" {/if}>{$value}</a></li>
                {/foreach}
            </ul>
        </div>
        <div class="by-style select-item" id="by-style">
            <h4>流派</h4>
            <ul class="clearfix">
                {foreach $styleArray as $key => $value}
                {*<li><a href="/mv/{$recommend}?area={$area}&style={$key}&feature={$feature}&order={$order}" {if $stylename == $key} class="type-selected" {/if}>{$value}</a></li>*}
                    <li><a href="/lossless/{$view}/{$area}_{$key}/{$order}" {if $stylename == $key} class="type-selected" {/if}>{$value}</a></li>
                {/foreach}
            </ul>
        </div>
    </div>
    <h2 class="title">按歌手筛选</h2>
    <div class="select">
        <div class="by-artist select-item">
            <ul class="clearfix">
                {foreach $artistArray as $key => $value}
                    <li><a href="/lossless/{$view}/{$key}/{$order}" {if $artist == $key} class="type-selected"{/if}>{$value}</a></li>
                {/foreach}
            </ul>
        </div>
    </div>
</div>
