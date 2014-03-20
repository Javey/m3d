<div class="mod-cloud">
	<div class="desc">普通会员用户（即注册登录用户）可免费领取使用一个月VIP会员特权</div>
	
	<div class="cloud-info">
		{if $tplData.data.given != 2 }
			<a href="javascript:;" class="cloud-btn"></a>
		{else}
			<span class="cloud-already"></span>
		{/if}
		<div class="share">
			<div class="share-label">分享到： </div>

			<div id="bdshare" class="bds_tools bdshare_t" >
				<a class="bds_qzone"></a>
				<a class="bds_renren"></a>	
				<a class="bds_tqq"></a>	
				<a class="bds_tsina"></a>
				<span class="bds_more"></span>	
			</div>
		</div>
	</div>
</div>
<div class="cloud-intro clearfix">
	<div class="cloud-list">
		<div class="head">
			<div class="title clearfix">
				<i class="icon"></i>
				<b>VIP</b>会员特权
			</div>
		</div>
		<ul class="clearfix">

			{foreach $power_list_config.vip.list as $item}
			{if $item@key !="more"}
				<li>
					<a href="{$item.href}"><i class="power-icon power-icon-max power-icon-{$item@key}-max"></i></a>
					<div class="power-info">
						<h3 class="title"><a href="{$item.href}">{$item.title}</a></h3>
						<p class="desc">{$item.desc}</p>
					</div>
				</li>
				{if ($item@index+1) % 2 == 0}
					{if $item@index+2 !=  count($power_list_config.vip.list) }
					</ul>
					<div class="module-dotted"></div>
					<ul class="clearfix">
					{/if}
				{else}

				{/if}
			{/if}
		      {/foreach}
		</ul>
	</div>
	<div class="active-info clearfix">
		<div class="head">
			<div class="title clearfix">
				<i class="icon"></i>
				<b>活动</b>规则
			</div>
		</div>
	<ul class="c6">
		<li class="clearfix bb-dotimg"><i class="icon">1</i> <p>活动期间，每个账号仅限领一次，已经在活动期间领取过VIP会员特权用户，请不要重复领取。</p></li>
		<li class="clearfix bb-dotimg"><i class="icon ">2</i> <p>VIP会员特权生效时间：在活动页面领取VIP会员特权的当天即可生效。</p></li>
		<li class="clearfix bb-dotimg last"><i class="icon">3</i> <p>VIP会员特权试用期：自领取VIP会员特权的当天算起，共计31天。</p></li>
	</ul>	
	</div>
	
</div>
