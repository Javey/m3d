{extends file="vip/vip.html.tpl"}
{block name="title"}会员权利说明{/block}
{block name="assign" append}
	{$navIndex = "privileges"}

	{include file="vip/power_list_config.html.tpl" inline }
	{foreach $privilege_list_show_config as $item}
		{foreach $item.list as $sub}
			{if $item@first}
				{if $sub@first}
					{**当url与配置项不等 设置默认值**}
					{$type = $sub.type}
					{$title = $sub.title}
					{$desc = $sub.desc}
					{$isPremium = $sub.isPremium}
				{/if}
			{/if}
			{if $tplData.type == $sub@key}
				{$type = $sub.type}
				{$title = $sub.title}
				{$desc = $sub.desc}
				{$isPremium = $sub.isPremium}
			{/if}
		{/foreach}
	{/foreach}
{/block}
{block name="title"}会员{/block}
{block name="body_class"}
class="vip-page"
{/block}

{block name="content_main"}
	<div class="main-body">
		<div class="vip-power-detail">
			<div class="vip-power-bread">
				<a href="/vip">首页</a> > <a href="/vip/privileges">特权介绍</a> > {$title}
			</div>
			<div class="vip-power-intro">
				<div class="power-intro-box">
					
					{include file="vip/mod_intro_`$type`.html.tpl"}

					<div class="vip-power-bottom">
						<div class="vip-privilege-block-split"></div>
						{include file="vip/mod_payment_btn.html.tpl"}
					</div>
				</div>
			</div>

			<div class="vip-detail-sidebar sidebar">
				<div class="sidebar-box">
					{include file="vip/detail_sidebar.html.tpl" }
				</div>
			</div>
		</div>
	</div>
{/block}



{block name="js-page"}
<script type="text/javascript" src="/static/js/ZeroClipboard.js"></script>
<script type="text/javascript" _xcompress="true">
	$(function(){
		var type = "{$tplData.type}" ;		
		var $openvip = $(".intro-openvip");

		$(document).bind("logined", function() {
			window.location.reload();
		});

		$(".login-btn").bind("click", function(){
			ting.passport.checkLogin(function(){
				//登录成功回写状态
			},function(){},function(){},function(){} );
			return false;
		});

		!!$openvip.length && $openvip.bind("click" , function(){
			var opt = {
				page : type,
				pos : "open_vip"
			};
			ting.logger.log("click", opt );
			// return false;
		});

		var copyHook = $('.copy-link-hook'),
			$text = $('#inviteContent');
		var clipboard = new ZeroClipboard( copyHook[0], {
			moviePath: "/static/flash/ZeroClipboard.swf"
		} );
		clipboard.on('load', function () {
			copyHook.show();
		});
		copyHook.tip({
			msg: '复制成功',
			iconClass: 'tip-success'
		});

		clipboard.on('mousedown', function() {
			clipboard.setText($text.val());
		});

		clipboard.on('complete', function (client, args) {
			copyHook.tip('tipup');
		});
	});
</script>
{/block}
{block name='js-monkey-pageid'}ting-music-vip-detail-{$type}{/block}