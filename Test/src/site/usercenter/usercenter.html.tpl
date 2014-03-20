{extends file="ting.html.tpl"}
{block name="head" append}
<link rel="stylesheet" type="text/css" href="/static/css/user_center.css{*version file='/static/css/user_center.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="body_class"}
class="user-center"
{/block}
{block name="title"}音乐个人中心{/block}
{block name="content_main"}
{$serviceinfo = $tplData.data.serviceinfo}
{include file="usercenter/mod_user_info.html.tpl"}
{include file="usercenter/mod_service.html.tpl"}
{/block}



{block name="js-page"}
<script type="text/javascript" _xcompress="true">
	var renewals = $(".renewals"),
		openvip = $(".open-vip"),
		receiveBtn = $(".receive-btn");

	!!openvip.length && openvip.bind("click" , function(){
		var opt = {
			page : "usercenter",
			pos : "open_vip"
		};
		ting.logger.log("click", opt );
		// return false;
	});

	!!renewals.length && renewals.bind("click" , function(){
		var opt = {
			page : "usercenter",
			pos : "renewal"
		};
		ting.logger.log("click", opt );
		// return false;
	});

	!!receiveBtn.length && receiveBtn.bind("click" , function(){
		var opt = {
			page : "usercenter",
			pos : "get_gift"
		};
		ting.logger.log("click", opt );
		// return false;
	});
</script>
{/block}