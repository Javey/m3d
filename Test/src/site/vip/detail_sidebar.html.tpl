{$vipIconClass = ""}
{if $userStatus == "commVip"}
    {$vipIconClass = "power-icon-vipidentity-active"}
{elseif $userStatus == "goldVip"}
    {$vipIconClass = "power-icon-goldvip-active"}
{elseif $userStatus == "login"}
    {$vipIconClass = "power-icon-vipidentity"}
{/if}
<div class="vip-detail-sidebar-top"></div>

<div class="vip-detail-sidebar-mid">
    <div class="vip-detail-sidebar-mid-bg"></div>
    <div class="vip-user">
        {if $loginInfo}
        <div class="vip-userinfo">
            <div class="vip-avatar-wrapper">
                <img class="vip-avatar" src="{avatar user=$loginInfo.pass_info type='big'}" />
            </div>
            <div class="vip-username-wrapper clearfix">
                <div class="vip-username-mid">
                    <div class="vip-username-inner">
                        <div class="vip-username">{$loginInfo.pass_info.displayname}</div>
                        {if $userStatus != "none"}
                        <div class="vip-usericon">
                            <i title="已开通VIP会员" class="power-icon-min {$vipIconClass}"></i>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
            <div class="vip-homelink">
                <a href="/vip/user">音乐个人中心</a> | <a class="vip-logout" href="http://passport.baidu.com/?logout&tpl=music&u=http%3A%2F%2Fmusic.baidu.com%2Fvip%2F{$type}">退出</a>
            </div>

        </div>

        {else}
        <div class="vip-userlogin">
            {button
                str = ""
                class = "login-btn"
                style = "login"
                href = ""
                width = 172
                height = 41
                family = $button['family']|default:true
            }
        </div>
        {/if}
    </div>

    <div class="vip-detail-sidebar-privileges">
        <div>
            <ul>
                {foreach $privilege_list_show_config as $item}
                    {if $item@key != "premium"}
                    <li class="vip-detail-sidebar-privilege-item" data-menuid="{$item@key}">
                        <div class="vip-detail-sidebar-privilege-item-block">
                            
                            <a class="vip-detail-sidebar-privilege-item-title">{$item['name']}</a>

                            <span class="vip-detail-sidebar-privilege-item-icon vip-icon-{$item@key}-grey"></span>
                        </div>

                        <ul class="vip-detail-sidebar-privilege-subs">
                            {foreach $item['list'] as $subItem}
                                <li class="{if $subItem['type'] == $type}active{/if}">
                                    <a href="{$subItem['href']}">{$subItem['title']}</a>
                                </li>
                            {/foreach}
                        </ul>
                    </li>
                    {/if}
                {/foreach}
            </ul>
        </div>
    </div>
</div>

<div class="vip-detail-sidebar-bottom"></div>