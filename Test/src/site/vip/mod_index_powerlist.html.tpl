<div class="vip-power-list">
    <h2>会员特权</h2>
    <a class="vip-more" href="/vip/privileges">更多>></a>
    <hr />

    {$privilegeBlocks = []}

    {foreach $privilege_list_show_config as $privilegeBlock}
        {if $privilegeBlock['onIndex']}
            {append var='privilegeBlocks' value=$privilegeBlock index=$privilegeBlock@key}
        {/if}
    {/foreach}

    {foreach $privilegeBlocks as $privilegeBlock}
    <div class="vip-privilege-block">
        <div class="module-a-title">
            <h3 class="title"><i class="icon"></i>{$privilegeBlock.name}</h3>
        </div>
        <ul class="clearfix">
            {$tmpList = []}
            {foreach $privilegeBlock.list as $item}
                {if !array_key_exists("onIndex", $item) or $item['onIndex'] != false}
                    {append var='tmpList' value=$item index=$item@key}
                {/if}
            {/foreach}

            {foreach $tmpList as $item}
                {if !array_key_exists("onIndex", $item) or $item['onIndex'] != false}
                <li class="vip-privilege-item-{count($tmpList)} {if $item@last}vip-privilege-item-last{/if}">
                    <a class="vip-privilege-pic-wrapper" href="{$item.href}" title="{$item.title}">
                        <i class="vip-privilege-pic-max vip-privilege-pic-{$item@key}-max">{$item.text}</i>
                        {if $item.isPremium}
                            <div class="vip-privilege-premium"></div>
                        {/if}
                    </a>

                    <a class="power-name" href="{$item.href}" title="{$item.title}">{$item.title}</a>
                </li>
                {/if}
            {/foreach}
        </ul>

        {if !$privilegeBlock@last}
        <div class="vip-privilege-block-split"></div>
        {/if}
    </div>
    {/foreach}
</div>

<div class="vip-power-list vip-offline-parties">
    <h2>精彩活动</h2>
    <hr />

    <div class="vip-offline-parties-content">
        <ul class="clearfix">
            {foreach $tplData.data.opr_focus as $item}
            <li class="{if $item@last}last{/if}">
                <a href="{$item.link}" target="_blank">
                    <img org_src="{$item.pic}" src="/static/images/blank.gif" class="lazyload"/>
                </a>
            </li>
            {/foreach}
        </ul>
    </div>
</div>
