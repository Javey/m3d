<div class="vip-detail-sidebar sidebar">
    <div class="sidebar-box">
        <div class="vip-detail-sidebar-top"></div>

        <div class="vip-detail-sidebar-mid">
            <div class="vip-detail-sidebar-mid-bg"></div>
            <dl class="description">
                <dt>VIP特权介绍:</dt>
                {foreach $power_list_config.vip.list as $item}
                    <dd>
                        <a href="{$item.href}">
                            <i class="vip-icon vip-icon-{$item@key}"></i>
                            <span>{$item.title}</span>
                        </a>
                    </dd>
                {/foreach}
                <a class="more-link" href="/vip/privileges" title="查看更多">查看更多>></a>
            </dl>
            
        </div>

        <div class="vip-detail-sidebar-bottom"></div>
    </div>
</div>
