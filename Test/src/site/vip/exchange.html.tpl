{extends file="vip/vip.html.tpl"}
{block name="head" append}
<link rel="stylesheet" type="text/css" href="/site/vip/vip_exchange.css" />
{block name="extra_css"}{/block}
{include file="vip/power_list_config.html.tpl" inline }
{/block}
{block name="body_class"}
class="exchange-page vip-page"
{/block}

{block name="title"}兑换VIP{/block}
{block name="assign" append}
	{$navIndex = "exchange"}
	{$exchangeCode = $tplData.data.code}
{/block}
{block name="content_main"}
<div class="main-body">
	<div class="vip-power-list">
		<div class="exchange-banner">
			<form id="exchange-form">
				<input type="text" id="exchange-code" autocomplete="off" data-default="请输入兑换码, 不区分大小写" onsubmit="return false" value="{$exchangeCode}" />
			</form>

			<span id="exchange-submit"></span>

			<div class="exchange-getcode ">
				<div class="exchange-getcode-bg"></div>
				<div class="exchange-getcode-content clearfix">
					<div class="exchange-getcode-icon"></div>
					<div class="fwb">如何获得？</div>

					<div>
						<a href="/vip/invite" target="_blank">邀请好友加入VIP, 兑换码免费领</a>
					</div>
				</div>
			</div>
		</div>

		{include file="vip/mod_privileges_table.html.tpl" inline}
		
	</div>
</div>
{/block}

{block name="js-page"}
<script type="text/javascript" _xcompress="true">
	$(function() {
		var $btnSubmit = $("#exchange-submit"),
			$formExchange = $("#exchange-form"),
			$txtExchange = $("#exchange-code"),
			$dialogSuccess = $(".exchange-success-dialog"),
			$dialogFail = $(".exchange-fail-dialog"),

			inputDefaultValue = $txtExchange.data("default"),

			mapMsg = {
				"22000": "恭喜", 
				"23111": "过期",
				"23112": "无效",
				"23113": "已使用",
				"23114": "已使用类似的兑换卷"
			},

			pending = false,

			init = function() {
				$txtExchange.bind("focus", function() {
					if ($.trim($txtExchange.val()) == inputDefaultValue) {
						$txtExchange.val("");
						$txtExchange.removeClass("input-default");
					};
				}).bind("blur", function() {
					if ($txtExchange.val() == "") {
						$txtExchange.val(inputDefaultValue);
						$txtExchange.addClass("input-default");
					};
				}).bind("keydown", function(e) {
					if (e.keyCode != 13) {
						return true;
					}

					//pending = true;

					//$formExchange.submit();
				});

				if (!$txtExchange.val() || $txtExchange.val() == "") {
					$txtExchange.val(inputDefaultValue);
					$txtExchange.addClass("input-default");
				};

				$formExchange.bind("submit", function(e) {
					e.preventDefault();

					var code = $txtExchange.val();

					if (inputDefaultValue == $txtExchange.val()) {
						code = "";
					}

					if (pending) {
						return;
					};

					ting.connect.paymentExchange({
						code: code
					}, null, function (result) {
						handleResult(result);
					}, function (result) {
						handleResult(result);
					})
				});

				$btnSubmit.bind("click", function(e) {
					$formExchange.submit();
				});

				$dialogSuccess.dialog({
					cancel: {
						btn: ".exchange-close-btn",
						callback: function() {
							$txtExchange.removeAttr("disabled");
							$dialogSuccess.dialog("hide");
						}
					},

					close: {
						callback: function() {
							$txtExchange.removeAttr("disabled");
						}
					},

					bgiframe: true,

					width: 300
				});

				$dialogFail.dialog({
					cancel: {
						btn: ".exchange-close-btn",
						callback: function() {
							$txtExchange.removeAttr("disabled");
							$dialogFail.dialog("hide");
						}
					},

					close: {
						callback: function() {
							$txtExchange.removeAttr("disabled");
						}
					},

					bgiframe: true,

					width: 300
				});
			},

			handleResult = function (obj) {
				pending = false;

				msg = obj.data.msg;

				$txtExchange.attr("disabled", "");

				switch (obj.errorCode) {
					case 22000:
						$dialogSuccess.find(".desc").text(msg);
						$dialogSuccess.dialog("show");
						break;

					default:
						$dialogFail.find(".desc").text(msg);
						$dialogFail.dialog("show");
						break;
				}
			};

		init();
	});

</script>
{/block}

{block name='js-monkey-pageid'}ting-music-vip-exchange{/block}

{block name="body_fixed_pop"}
{include file="vip/exchange_success_dialog.html.tpl"}
{include file="vip/exchange_fail_dialog.html.tpl"}
{/block}