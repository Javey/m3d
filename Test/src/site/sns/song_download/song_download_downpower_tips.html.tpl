<li class="down-power-tips">
	<div class="{if $upperLimit}upper-limit-tips{else}member-tips{/if}" id="down_power_tip">
		{if $upperLimit}
			<b>您本月下载权限已达上限!</b>
		{else}
			<b>百度音乐会员专享特权</b>
			<span class="tip-txt">
			{if $isLogin && !$isMember}
				{if $isCharge || $defaultRate > 128}  
					{** 非会员下载收费或高于128码率免费歌曲的提示 **}
					<i><a href="/home/payment" target="_blank" class="tip-bemember">开通特权</a></i> 
				{/if}
			{/if}
			</span>
		{/if}
	</div>
</li>