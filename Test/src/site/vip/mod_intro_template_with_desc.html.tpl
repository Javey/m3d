{extends file="vip/mod_intro_template.html.tpl"}

{block name="detail_banner"}
<div class="vip-detail-banner vip-detail-banner-common">
	<div class="vip-detail-banner-desc">
		<h3>{$title}</h3>

		<div class="desc">{$desc nofilter}</div>
	</div>

	<div class="vip-detail-banner-btns">
		{include file="vip/mod_payment_btn.html.tpl"}
	</div>

	<div class="vip-detail-banner-pic">
		<i class="vip-privilege-pic-mid vip-privilege-pic-{$type}-mid">{$item.text}</i>
	</div>
</div>
{/block}

{block name="detail_body"}
	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>特权说明</h2>
	</div>
	<div class="vip-privilege-block-split"></div>
	
	{block name="service_intro"}
	<p></p>
	{/block}

	{block name="service_detail"}
	<p></p>
	{/block}
{/block}