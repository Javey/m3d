<div class="user-base-info clearfix bb-dotimg">
	<div class="user-avatar">
		<img src="{avatar user=$loginInfo.pass_info}" alt="">
	</div>
	<div class="user-info">
        {include file="widget/user_name/user_name.html.tpl" inline}
        {user_name loginInfo = $loginInfo}
		<div class="desc">
			{*{if $tplData.data.serviceinfo.cloud}*}

				{*{button*}
					{*str="VIP会员续期"*}
					{*style="e"*}
					{*href = "/home/payment/cloud?pst=pay_reuserup"*}
					{*class = "renewal-btn"*}
				{*}*}
			{*{else}*}
				{*{button*}
					{*str="开通<b>VIP</b>会员"*}
					{*style="e"*}
					{*href = "/home/payment/cloud?pst=pay_userup"*}
					{*icon="vip"*}
					{*class="open-vip"*}
				{*}*}
			{*{/if}*}
            {if $userStatus != 'login'}
                <p>VIP会员到期日期：{$tplData.data.serviceinfo.cloud.end_time|date_format:'%Y.%m.%d'}</p>
            {/if}
            {$button = $userStatusConfigure[$userStatus]['button']}
            {$href = $button['href']}
            {if $href}
                {$href = $href|cat:'&pst=pay_userup'}
            {/if}
            {button
                str = $button['str']
                style = 'e'
                href = $href
                family = $button['family']|default:true
            }
            {$link = $userStatusConfigure[$userStatus]['link']}
            {if $link}
                <div><a href="{$link['href']|cat:'&pst=pay_userup'}" title="{$link['title']}">{$link['text']}</a></div>
            {/if}
		</div>
	</div>
	
	{*<p class="active-tips">*}
		{** <strong>[限时活动]</strong> **}
        {*<a href="/home/vip/invite?pst=invite_user">3个月VIP会员免费拿，点击参与 &gt;&gt;</a>*}
	{*</p>*}
</div>

