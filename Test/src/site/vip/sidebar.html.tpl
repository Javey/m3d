{if $loginInfo}
    {include file="widget/user_name/user_name.html.tpl" inline}
    {$vipIcon = $vipIconConf[$userStatus]}
    <div class="vip-userinfo">
        <div class="user-info">
            <div class="user-base-info clearfix bb-dotimg">
                <div class="user-avatar">
                    <img src="{avatar user=$loginInfo.pass_info}" alt="头像">
                </div>
                {user_name loginInfo = $loginInfo truncate = 72}
                <p> <a href="/home/user">音乐个人中心&gt;&gt;</a> </p>
            </div>
            <div class="my-power-list bb-dotimg">
                <h3>您享有的特权：</h3>
                <ul class="clearfix">
                    {if $userStatus == 'login'}
                        {foreach $power_list_config.free.list as $item}
                            <li><a href="{$item.href}"><i title="{$item.title}" class="power-icon-min power-icon-{$item@key}-active"></i></a> </li>
                        {/foreach}
                    {else}
                        {foreach $power_list_config.vip.list as $item}
                            {if $item@key == 'more'}
                                {break}
                            {/if}
                            <li><a href="{$item.href}"><i title="{$item.title}" class="power-icon-min power-icon-{$item@key}-active"></i></a> </li>
                        {/foreach}
                        {if $userStatus == 'goldVip'}
                            {foreach $power_list_config.gold.list as $item}
                                <li><a href="{$item.href}"><i title="{$item.title}" class="power-icon-min power-icon-{$item@key}-active"></i></a> </li>
                            {/foreach}
                        {/if}
                    {/if}
                </ul>
            </div>
        </div>
        <div class="open-vip desc">
            {if $userStatus != 'login'}
                到期时间：{$tplData.data.serviceinfo.cloud.end_time|date_format:'%Y.%m.%d'}
            {/if}
            {$button = $userStatusConfigure[$userStatus]['button']}
            {$href = $button['href']}
            {if $href}
                {$href = $href|cat:'&pst=pay_vipleft'}
            {/if}
            {button
                str = $button['str']
                style = 'e'
                href = $href
                family = $button['family']|default:true
            }

            <div>
            <a href="/duihuan">使用VIP会员兑换券</a>
            </div>

            {$link = $userStatusConfigure[$userStatus]['link']}
            {if $link}
                <div><a href="{$link['href']|cat:'&pst=pay_vipleft'}" title="{$link['title']}">{$link['text']}</a></div>
            {/if}

        </div>
    </div>
{else}
    <div class="vip-userinfo">
        <div class="opera-btn login bb-dotimg">
            {$button = $userStatusConfigure[$userStatus]['button']}
            {$href = $button['href']}
            {if $href}
                {$href = $href|cat:'&pst=pay_viplogin'}
            {/if}
            {button
                str = $button['str']
                style = $button['style']|default:'f'
                href = $href
                class = $button['class']|default:'f20'
                width = $button['width']|default:155
                family = $button['family']|default:true
            }
        </div>
        <div class="open-vip desc">
            登录后开通百度音乐VIP会员，享受超值音乐特权
        </div>

        <a href="/duihuan">使用VIP会员兑换券</a>
    </div>
{/if}


