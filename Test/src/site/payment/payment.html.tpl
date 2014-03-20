{extends file="vip/vip.html.tpl"}

{block name="assign" append}
    
    {* currentServiceLevel: 用户当前的VIP级别 *}
    {$currentServiceLevel = $tplData.data.serviceinfo.cloud.service_level}

    {* serviceType: "down": 为下载付费, "cloud": 为音乐云付费 *}
    {$serviceType = $tplData.data.serveType}
    {$dataType = $tplData.data.type|default:"add"}
    {if $dataType == "upgrade"}
        {$level = "gold"}
    {else}
        {$level = $tplData.data.level|default:"comm"}
    {/if}
    {$amount = $tplData.data.amount}
    {$serviceName = $tplData.data.goodinfo.services[$tplData.data.serveType]}
    {include file="payment/vip_configure.html.tpl"}

    {if $tplData.data.bind_info.bank_cards}
        {$easyBinded = true}
    {else}
        {$easyBinded = false}
    {/if}

    {$endTime = $tplData.data.serviceinfo[$serviceType].end_time}

    {$navIndex = "payment"}
{/block}

{block name="body_class" append}
class="pay-page"
{/block}
{block name="title"}{$vipConfigure[$dataType][$level].title}{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/payment.css{*version file='/static/css/payment.css' prefix='?' suffix='.css'*}" />
<link rel="stylesheet" type="text/css" href="/site/vip/vip_icon.css{*version file='/site/vip/vip_icon.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="js-page"}
<script type="text/javascript">
    var currentServiceLevel = "{$currentServiceLevel}",
        dataType = "{$dataType}",
        serviceType = "{$tplData.data.serveType}" || "down",
        islogin = {if $loginInfo} true {else} false {/if},
        needBindRealInfo = {if $loginInfo["pass_info"]["secureemail"] != "" || $loginInfo["pass_info"]["securemobil"] != ""} false {else} true {/if},
        pst = "{$smarty.get.pst}",
        endTime = "{$tplData.data.serviceinfo[$serviceType].end_time * 1000}",
        serviceLevel = "{$level}",
        bankBindedList = {json_encode($tplData.data.bind_info.bank_cards) nofilter};

	$(document).bind("logined", function () {
 	    window.location.reload();
	});
</script>
<script src="/site/payment/payment.js" type="text/javascript" _xbuilder="true" _xcompress="true"></script>
{/block}
{block name='js-monkey-pageid'}ting-music-payment{/block}


{block name="body_class"}
class="payment vip-page"
{/block}
{block name="content_main"}
    <div class="payment-wrapper">
        <div class="payment-inner">
            {include file="payment/payment_detail.html.tpl"}
            {include file="payment/mod_sidebar.html.tpl" inline}
        </div>

        <div class="payment-result-wrapper">
            <div class="loading result-loading" style="display:none;"></div>
            {include file="payment/payment_result_fail.html.tpl" inline}
            {include file="payment/payment_result_success.html.tpl" inline}
        </div>
    </div>
{/block}

{block name="body_fixed_pop"}
{include file="payment/payment_dialog_confirm.html.tpl"}
{include file="payment/payment_dialog_banklist.html.tpl"}
{/block}