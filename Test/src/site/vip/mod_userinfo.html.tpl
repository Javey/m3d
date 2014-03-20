{$vipIconClass = ""}

{if $userStatus == "commVip"}
    {$vipIconClass = "power-icon-vipidentity-active"}
    {$vipIconTitle = "已开通VIP会员"}
{elseif $userStatus == "goldVip"}
    {$vipIconClass = "power-icon-goldvip-active"}
    {$vipIconTitle = "已开通白金VIP会员"}
{elseif $userStatus == "login"}
    {$vipIconClass = "power-icon-vipidentity"}
    {$vipIconTitle = "未开通VIP会员"}
{/if}
{if $navIndex == "usercenter"}
    {$pst = "pay_user"}
{else if $navIndex == "home"}
    {$pst = "pay_vipleft"}
{/if}
<div class="vip-user-bg"></div>
<div class="vip-user vip-user-{$userStatus}">
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
                        <i title="{$vipIconTitle}" class="power-icon-min {$vipIconClass}"></i>
                    </div>
                    {/if}
                </div>
            </div>
        </div>
        <div class="vip-homelink">
            <a href="/vip/user">音乐个人中心</a> | <a class="vip-logout" href="http://passport.baidu.com/?logout&tpl=music&u=http%3A%2F%2Fmusic.baidu.com%2Fvip%2F{$type}">退出</a>
        </div>
    </div>

    <div class="vip-privilege">
        <div class="clearfix">
            <span class="vip-privilege-label">您的特权:</span>
            <span class="vip-privilege-icons">
                <ul class="clearfix">
                    {foreach $power_list_user as $item}
                        {if strpos($item['require'], $userStatus) !== FALSE}
                            {$powerIconClass = "-color"}
                        {else}
                            {$powerIconClass = "-g"}
                        {/if}
                        <li><a href="/vip/{$item['type']}"><i title="{$item['title']}" class="power-icon-min vip-icon vip-icon-{$item['type']}{$powerIconClass}"></i></a> </li>
                    {/foreach}
                </ul>
            </span>
        </div>

        {if $userStatus != "login"}
        <div class="vip-expire">
            到期时间: {$tplData.data.serviceinfo.cloud.end_time|date_format:'%Y.%m.%d'}
        </div>
        {/if}
    </div>

    <div class="vip-purchase-btn">
        {if $userStatus == "login"}
            {button
                str = "开通VIP会员"
                style = "upgrade"
                href = "/home/payment/cloud?type=add&level=comm&pst=$pst"
                width = 260
                height = 42
                family = $button['family']|default:true
            }
        {else}
            {button
                str = "立即续费"
                style = "renew"
                href = "/home/payment/cloud?type=up&level=comm&pst=$pst"
                width = 260
                height = 42
                family = $button['family']|default:true
            }
        {/if}
        

        {if $userStatus == "commVip"}
            {button
                str = "升级白金VIP"
                style = "upgrade"
                href = "/home/payment/cloud?type=upgrade&level=gold&pst=$pst"
                width = 260
                height = 42
                family = $button['family']|default:true
            }
        {/if}
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

    <div class="vip-login-tips">
        <p>百度音乐VIP为您提供多项特权, 高品质音乐播放下载, 云端数据存储, 还有精彩纷呈的线下活动等你参加</p>

        <p class="red">让您尊享高品质音乐生活！</p>
    </div>

    <div class="vip-purchase-btn">
        {button
            str = "开通VIP会员"
            style = "upgrade"
            href = "/home/payment/cloud?type=add&level=comm&pst=$pst"
            width = 260
            height = 42
            family = $button['family']|default:true
        }
    </div>
    {/if}
</div>