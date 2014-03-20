{extends file="module/module.html.tpl"}
{block name='mod_class'}intro{/block}
{block name='mod_attr'}monkey="intro"{/block}
{block name='mod_head_class'}bb-dotimg{/block}
{block name="mod_head"}
<div class="vip-detail-banner">
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
{block name="mod_body"}
{include file="vip/mod_intro_`$type`.html.tpl"}
{/block}
