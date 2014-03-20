{extends file="ting.html.tpl"}

{block name="head" append}
<link rel="stylesheet" type="text/css" href="/site/vip/vip_new.css" />
<link rel="stylesheet" type="text/css" href="/site/vip/vip_icon.css" />
{include file="vip/power_list_config.html.tpl" inline }
{/block}
{block name="body_class"}
class="vip-page"
{/block}
{block name="title"}百度音乐VIP{/block}
{block name="assign" append}
	{** 用户状态 **}
	{if $loginInfo}
		{$serviceLevel = $loginInfo.vip.cloud.service_level}
		{if $serviceLevel == 'gold'}
			{$userStatus = 'goldVip'}
		{elseif $serviceLevel == 'comm'}
			{$userStatus = 'commVip'}
		{else}
			{$userStatus = 'login'}
		{/if}
	{else}
		{$userStatus = 'none'}
	{/if}

	{$navIndex = "home"}
{/block}

{block name="go-top"}{/block}

{block name="top_main"}
<div class="backtomusic backtomusic-{$navIndex}">
	<a class="backtomusic-inner" href="/"></a>
</div>
<div class="vip-head">
	<div class="vip-head-mid">
		<div class="vip-logo-wrapper">
			<a href="/vip/" id="vip-logo">百度音乐VIP</a>
		</div>

		<div class="vip-nav">
			<ul>
				<li class="vip-home {if $navIndex==='home'}nav-current{/if}">
					<a href="/vip">会员首页</a>
				</li>

				<li class="vip-nav-split"></li>

				<li class="vip-privileges {if $navIndex==='privileges'}nav-current{/if}">
					<a href="/vip/privileges">特权介绍</a>
				</li>

				<li class="vip-nav-split"></li>

				<li class="vip-premium {if $navIndex==='premium'}nav-current{/if}">
					<a href="/vip/premium">白金VIP</a>
				</li>

				<li class="vip-nav-split"></li>

				<li class="vip-exchange {if $navIndex==='exchange'}nav-current{/if}">
					<a href="/duihuan">兑换VIP</a>
				</li>

				<li class="vip-nav-split"></li>

				<li class="vip-uc {if $navIndex==='payment'}nav-current{/if}">
					<a href="/vip/payment">支付中心</a>
				</li>

				<li class="vip-nav-split"></li>

				<li class="vip-uc {if $navIndex==='usercenter'}nav-current{/if}">
					<a href="/vip/user">个人中心</a>
				</li>
			</ul>
		</div>
	</div>
</div>
{/block}

{block name="content_main"}
	<div class="main-body">
		{include file="vip/main_body.html.tpl" }
	</div>
{/block}

{block name="music-foot"}
	<div class="music-foot-wrapper">
		<div class="music-foot" monkey="music-foot" alog-alias="music-foot-alog">
			{include file="mod_foot.html.tpl"}
		</div>
	</div>
{/block}

{block name="js-page"}
<script type="text/javascript">
	$(function() {
		$(document).bind("logined", function() {
			window.location.reload();
		});
		$(".login-btn").bind("click", function() {
			ting.passport.checkLogin(function() {
				//登录成功回写状态
			}, function() {}, function() {}, function() {});
			return false;
		});

		$(".login-vip").click(function() {

		})

		var focusBgs = [
			{foreach $tplData.data.main_focus as $item}
				"#{$item.bgcolor}"

				{if !$item@last}, {/if}
			{/foreach}
		];

		var $openvip = $(".open-vip"),
			$renewalBtn = $(".renewal-btn"),
			$banner = $(".banner img");

		!! $openvip.length && $openvip.bind("click", function() {
			var opt = {
				page: "vip",
				pos: "open_vip"
			};
			ting.logger.log("click", opt);
			// return false;
		});

		!! $renewalBtn.length && $renewalBtn.bind("click", function() {
			var opt = {
				page: "vip",
				pos: "renewal"
			};
			ting.logger.log("click", opt);
			// return false;
		});

		!! $banner.length && $banner.bind("click", function() {
			var opt = {
				page: "vip",
				pos: "banner"
			};
			ting.logger.log("click", opt);
			// return false;
		});

		// 轮播图
		var focusHook = $('#focus-hook'),
			focusNav = focusHook.find('.focus-page');
		focusHook.anyfocus({
			effect: 'fade',
			interTime: 5000,
			callback: function() {
				focusNav.show();
			}
		}).bind('anyfocus.runafter', function(e, obj) {
			$(".page-active", focusNav).removeClass("page-active");
			$($(".page-index", focusNav)[obj.index]).addClass("page-active");

			$(".vip-focus-bg").animate({
				"background-color": focusBgs[obj.index]
			}, "slow");
		});


		$(".page-index", focusNav).bind('click', function(e) {
			if ($(this).hasClass("page-active")) {
				return false;
			}
			var index = $(this).index();

			$("#focus-hook").anyfocus("stop").anyfocus("switchTo", index);

			return false;
		});

		$(".vip-focus-bg").css("background-color", focusBgs[0]);
	});
</script>
{/block}
{block name='js-monkey-pageid'}ting-music-vip-index{/block}
