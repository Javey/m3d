{extends file="vip/vip.html.tpl"}

{block name="head" append}
{include file="vip/power_list_config.html.tpl" inline }
{/block}
{block name="body_class"}
class="vip-page"
{/block}
{block name="title"}白金VIP{/block}
{block name="assign" append}
	{$navIndex = "premium"}
{/block}

{block name="content_main"}
	<div class="main-body">
		<div class="vip-premium-inner">
			<div class="vip-premium-header">
				<a class="vip-premium-btn" href="/home/payment/cloud?type=upgrade&level=gold&pst=pay_premium"></a>
			</div>
		</div>

		<div class="vip-power-list vip-power-list-premium">
			<div class="vip-privilege-block">
				<div class="module-a-title">
					<h2 class="title"><i class="icon"></i>白金VIP尊享更多特权</h2>
				</div>
				<ul class="clearfix">
					{foreach $privilege_list_show_config.premium.list as $item}
						<li class="vip-privilege-item-3  {if $item@last}vip-privilege-item-last{/if}">
							<a class="vip-privilege-pic-wrapper" href="{$item.href|default:'javascript:void(0)'}" title="{$item.title}">
								<i class="vip-privilege-pic-max vip-privilege-pic-{$item@key}-max">{$item.text}</i>
							</a>

							<a class="power-name" href="{$item.href}" title="{$item.title}">{$item.title}</a>
							<div class="power-desc">白金VIP专属特权</div>
						</li>
					{/foreach}
				</ul>
			</div>
		</div>

		<div class="vip-premium-inner">
			<div class="vip-premium-footer">
				<a class="vip-premium-btn-footer" href="/home/payment/cloud?type=upgrade&level=gold&pst=pay_premium"></a>
			</div>
		</div>
	</div>
{/block}

{block name='js-monkey-pageid'}ting-music-vip-premium{/block}
