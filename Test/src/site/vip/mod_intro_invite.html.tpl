{extends file="vip/mod_intro_template.html.tpl"}

{block name="detail_banner"}
	{$shareText = "我正在使用#百度音乐#VIP会员服务，高品质音乐播放下载，海量云存储空间。送你7天免费体验，小伙伴们快来领吧～{"http://music.baidu.com/duihuan?code=`$tplData['data']['code']`"}（分享自@百度音乐）"}
	{$inviteCode = "http://music.baidu.com/duihuan?code=`$tplData['data']['code']`"}
	<div class="vip-detail-banner-invite">
		<div class="vip-detail-banner-desc">
			<h3>邀请特权</h3>

			<div class="desc">邀请朋友开通VIP, 免费得续期 

			{if $userStatus == "none" or $userStatus == "login"}
				<a href="/home/payment/cloud?pst=pay_{$type}" class="yellow pay-link" target="_blank">直接开通VIP>></a></div>
			{else}
				<a href="/home/payment/cloud?type=up&level=comm&pst=pay_{$type}" class="yellow pay-link" target="_blank">直接续期>></a></div>
			{/if}
		</div>

		<div class="vip-detail-banner-desc-more">
			<div class="">
				<span class="vip-detail-banner-desc-more-title">[方法一]</span>
				<span class="vip-detail-banner-desc-more-subtitle">分享到社交网站</span>
			</div>

			<div class="music-share clearfix">
				<!-- Baidu Button BEGIN -->
				<div id="bdshare" class="bdshare_t bds_tools_32 get-codes-bdshare">
					<a class="bds_qzone"></a>
					<a class="bds_tsina"></a>
					<a class="bds_renren"></a>
					<a class="bds_tqq"></a>
					<span class="bds_more"></span>
				</div>
				<!-- Baidu Button END -->			
			</div>

			<div class="">
				<span class="vip-detail-banner-desc-more-title">[方法二]</span>
				<span class="vip-detail-banner-desc-more-subtitle">直接发送邀请链接</span>
			</div>

			<div class="">
				<span class="vip-detail-banner-desc-more-content" id="inviteContent">{"http://music.baidu.com/duihuan?code=`$tplData['data']['code']`"}</span> <a href="javascript:void(0);" onclick="return false;" data-clipboard-target="inviteContent" class="yellow intro-copy-hook copy-link-hook">复制链接</a>
			</div>
		</div>
	</div>
{/block}

{block name="detail_body"}

	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>邀请规则</h2>
	</div>
	<div class="vip-privilege-block-split"></div>

	<div>
		<p>1、仅限VIP用户发送邀请。</p>
		<p>2、只能邀请未开通VIP的好友，每位好友仅能领取一次免费体验资格。</p>
		<p>3、每成功邀请1位好友开通VIP，即获得一个月免费续期。（好友在被邀请7天内付费则视为邀请成功） </p>
		<p>4、每月有获得三次续期的机会</p>
	</div>

	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>邀请记录</h2>
	</div>
	<div class="vip-privilege-block-split"></div>

	<div class="">
		{if $loginInfo}
			{if $tplData['data']['records']}
				<p>您已成功邀请以下好友，请前往<a href="/vip/user">个人中心</a>查看获赠的VIP兑换码。</p>

				<div class="invited-list">
				{foreach $tplData['data']['records'] as $item}
					{$item} 
				{/foreach}
				</div>
			{else}
				<p>亲爱的用户，你还没有邀请记录！</p>
			{/if}
		{else}
			<p>请先<a id="loginbtn">登入</a></p>
		{/if}
	</div>

	<style>
		.white {
			color: #fff;
		}

		.yellow {
			color: #f3c122;
		}

		.pay-link {
			margin-left: 5px;
		}

		.vip-detail-header {
			height: 320px;
		}

		.vip-detail-banner-desc-more {
			position: absolute;
			top: 150px;
			left: 30px;
			color: #fff;
		}

		.vip-detail-banner-desc-more .vip-detail-banner-desc-more-title {
			font-size: 18px;
		}

		.vip-detail-banner-desc-more .vip-detail-banner-desc-more-subtitle {
			font-size: 14px;
		}

		.vip-detail-banner-desc-more .vip-detail-banner-desc-more-content {
			font-size: 12px;
		}

		.music-share {
			margin-left: -3px;
		}

		.vip-invite-box-wrapper {
			margin-left: 3px;
		}
		.vip-invite-box {
			float: left;
			height: 173px;
			position: relative;
		}

		.vip-invite-box-1 {
			width: 412px;
			background: url(/static/images/vip/home/invite_bg1.png) no-repeat;
		}

		.vip-invite-box-1 textarea {
			position: absolute;
			left: 25px;
			top: 62px;
			width: 360px;
			height: 60px;
			border: none;
			resize: none;
		}

		.vip-invite-box-2 {
			width: 313px;
			background: url(/static/images/vip/home/invite_bg2.png) no-repeat;
		}

		.vip-invite-box-2 input {
			position: absolute;
			left: 28px;
			top: 69px;
			width: 250px;
			border: none;
		}

		.vip-invite-box-2 .btn {
			position: absolute;
			left: 162px;
			top: 110px;
			width: 102px;
		}

		.vip-invite-box-2 .btn .inner {
			width: 87px;
		}

		.invited-list {
			margin-left: 4px;
		}
	</style>

	<script type="text/javascript">
	var bds_config = {
		'bdText':'{$shareText}'
	};

	</script>

	<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004" src="http://bdimg.share.baidu.com/static/js/bds_s_v2.js?cdnversion=382838"></script>
{/block}