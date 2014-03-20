{extends file="vip/mod_intro_template_with_desc.html.tpl"}
{block name="service_intro"}
	<p>VIP会员享受20000首歌曲的超大云音乐存储空间，可以存储大概2000张专辑。</p>
{/block}

{block name="service_detail"}
	{$spaceUsed = $tplData['data']['cloud_detail']['used']}
	{$spaceAvail = $tplData['data']['cloud_detail']['all']}

	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>我的云音乐空间</h2>
	</div>
	<div class="vip-privilege-block-split"></div>

	<div class="">
		{if $userStatus != 'none'}
		<div class="">
			<p>当前云音乐空间使用量:</p>
		</div>
		<div class="clearfix">
			<div class="space-progress">
				<div class="progress-track">
					<div class="progress-track-l"></div>
					<div class="progress-track-m"></div>
					<div class="progress-track-r"></div>
				</div>

				<div class="progress-unavail" style="display: {if $userStatus == 'login'}block{else}none{/if};"></div>

				<div class="progress-fill">
					<div class="progress-fill-l"></div>
					<div class="progress-fill-m" style="width:{$spaceUsed / $spaceAvail * 528}px"></div>
					<div class="progress-fill-r"></div>
				</div>
			</div>
			<div class="space-tips">
				<span class="space-tips-usage"><p>{$spaceUsed}首/{$spaceAvail}首</p></span>
				<span class="space-tips-ctrl">
				{if $userStatus == 'login'}
					<a href="/home/payment/cloud?type=up&level=comm&pst=pay_superspace">扩容</a>
				{else}
					<a href="/home/payment/cloud?type=up&level=comm&pst=pay_superspace">续期</a>
				{/if}
				 <a href="http://yinyueyun.baidu.com/">管理</a></span>
			</div>
		</div>

		{if $userStatus == 'login'}
		<div class="">
			<p>立即加入VIP,享受超大存储空间，个人专属，永不下架</p>
		</div>
		{/if}
		{else}
		<div class="">
			<p><a class="blue login-btn">登入</a> 后立即查看我的云音乐空间容量</p>
		</div>
		{/if}
	</div>

	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>使用说明</h2>
	</div>
	<div class="vip-privilege-block-split"></div>

    <div class="vip-intro-pic"></div>

{literal}
	<style>
		.vip-intro-pic {
			margin-left: 0;
			width: 733px;
			height: 510px;
			background: url(/static/images/vip/home/superspace_inner.png) no-repeat;
			_background: none;
		    _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='corp',src='/static/images/vip/home/superspace_inner.png');
		}
	</style>
{/literal}
{/block}

