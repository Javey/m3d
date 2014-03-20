{if $userStatus == "none" or $userStatus == "login"}
	{if $isPremium}
		{button
			str="开通白金VIP"
			style = "upgrade"
			class="intro-openvip"
			href = "/home/payment/cloud?type=add&level=gold&pst=pay_`$type`"
		}
	{else}
		{button
			str="开通VIP会员"
			style = "upgrade"
			class="intro-openvip"
			href = "/home/payment/cloud?pst=pay_`$type`"
		}
	{/if}
{else}
	{if $isPremium}
		{button
			str="升级白金VIP"
			style = "upgrade"
			class="intro-openvip"
			href = "/home/payment/cloud?type=upgrade&level=gold&pst=pay_`$type`"
		}
	{else}
		{button
			str="续费VIP"
			style = "upgrade"
			class="intro-openvip"
			href = "/home/payment/cloud?type=up&level=comm&pst=pay_`$type`"
		}
	{/if}
{/if}