{extends file="vip/vip.html.tpl"}

{block name="head" append}
{include file="vip/power_list_config.html.tpl" inline }
{/block}
{block name="body_class"}
class="vip-page"
{/block}
{block name="title"}VIP特权{/block}
{block name="assign" append}
	{$navIndex = "privileges"}
{/block}

{block name="content_main"}
	<div class="main-body">
		<div class="vip-power-list">
			{include file="vip/mod_privileges_table.html.tpl" inline}

			{if $userStatus == 'none' || $userStatus == 'login'}
			<div class="vip-enable-vip">
				<a href="/home/payment/cloud?type=add&level=comm&pst=pay_premium"></a>
			</div>
			{/if}

			<div class="vip-privilege-block">
				<div class="module-a-title">
					<h2 class="title"><i class="icon"></i>特权对比</h2>
				</div>

				{include file="vip/mod_privileges.html.tpl"}
			</div>
		</div>
	</div>
{/block}

{block name='js-monkey-pageid'}ting-music-vip-privileges{/block}
