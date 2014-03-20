<div class="sidebar" monkey="sidebar" alog-alias="sidebar">
    <div class="all-mv">
        <a href="/mv/all/{$order}" {if $recommend == 'all' && $area == 'all' && $stylename == 'all' && $feature == 'all'} class="type-selected" {/if}>全部MV</a>
    </div>
    <div class="module-dotted"></div>
    <div class="select">
        {*<div class="by-recommend select-item" id="by-recommend">*}
            {*<h4>推荐</h4>*}
            {*<ul class="clearfix">*}
                {*{foreach $recommendArray as $key => $value}*}
                    {*<li><a href="/mv/{$key}?area={$area}&style={$stylename}&feature={$feature}&order={$order}" {if $recommend == $key} class="type-selected" {/if}>{$value}</a></li>*}
                {*{/foreach}*}
            {*</ul>*}
        {*</div>*}
        <div class="by-area select-item" id="by-area">
            <h4>地区</h4>
            <ul class="clearfix">
                {foreach $areaArray as $key => $value}
                    {*<li><a href="/mv/{$recommend}?area={$key}&style={$stylename}&feature={$feature}&order={$order}" {if $area == $key} class="type-selected" {/if}>{$value}</a></li>*}
                    <li><a href="/mv/{$key}/{$order}" {if $area == $key} class="type-selected" {/if}>{$value}</a></li>
                {/foreach}
            </ul>
        </div>
        <div class="by-style select-item" id="by-style">
            <h4>流派</h4>
            <ul class="clearfix">
                {foreach $styleArray as $key => $value}
                    {*<li><a href="/mv/{$recommend}?area={$area}&style={$key}&feature={$feature}&order={$order}" {if $stylename == $key} class="type-selected" {/if}>{$value}</a></li>*}
                    <li><a href="/mv/all_{$key}/{$order}" {if $stylename == $key} class="type-selected" {/if}>{$value}</a></li>
                {/foreach}
            </ul>
        </div>
        <div class="by-feature select-item" id="by_feadture">
            <h4>特色</h4>
            <ul class="clearfix">
                {foreach $featureArray as $key => $value}
                    {*<li><a href="/mv/{$recommend}?area={$area}&style={$stylename}&feature={$key}&order={$order}" {if $feature == $key} class="type-selected" {/if}>{$value}</a></li>*}
                    <li><a href="/mv/all_all_{$key}/{$order}" {if $feature == $key} class="type-selected" {/if}>{$value}</a></li>
                {/foreach}
            </ul>
        </div>
    </div>
</div>
