{extends file="ting.html.tpl"}
{block name="head" append}
<link rel="stylesheet" type="text/css" href="/site/user/user.css" />
{/block}
{block name="body_class"}
class="user-center"
{/block}
{block name="title"}音乐会员中心{/block}

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

    {include file="vip/power_list_config.html.tpl" inline}
{/block}

{block name="content_main"}
<div class="page-title bb-dotimg clearfix">
	<h2 class="title">会员中心</h2>
</div>
{$serviceinfo = $tplData.data.serviceinfo}
{include file="user/mod_user_info.html.tpl"}
<div class="module-a-title mypower-title">
	<i class="icon"></i> <h3 class="title">百度音乐会员特权</h3>
</div>	
{include file= "user/mod_mycloud.html.tpl" inline}
{include file= "user/mod_mypower.html.tpl" inline}

{/block}



{block name="js-page"}
<script type="text/javascript" _xcompress="true">
	var openvip = $(".open-vip"),
		renewalBtn = $(".renewal-btn");

	!!openvip.length && openvip.bind("click" , function(){
		var opt = {
			page : "user",
			pos : "open_vip"
		};
		ting.logger.log("click", opt );
		// return false;
	});

	!!renewalBtn.length && renewalBtn.bind("click" , function(){
		var opt = {
			page : "user",
			pos : "renewal"
		};
		ting.logger.log("click", opt );
		// return false;
	});
</script>
{/block}

{block name='js-monkey-pageid'}ting-music-user{/block}