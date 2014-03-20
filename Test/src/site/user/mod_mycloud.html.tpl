{extends file="module/module.html.tpl"}
{block name='mod_class'}mycloud module-a {/block}
{block name='mod_attr'}monkey="mycloud" {/block}
{block name="mod_head"}
{**模块头部**}
<a href="http://yinyueyun.baidu.com" target="_blank"  class="more">管理我的云<span>&gt;&gt;</span></a>
<h4 class="title">我的云</h4>
{/block}

{block name="mod_body"}
	{**
		used 用户下载的歌曲总数
		quota 系统自动分配的固定空间大小 默认500
	**}
	{$max = 660}
	{$min = 2 }
	{$user_size = $tplData.data.cloud_detail.used}
	{$fixed_size = $tplData.data.cloud_detail.all}

	{if $user_size <  $fixed_size}
		{$barWidth = ($max / $fixed_size) * $user_size}

	{else}
		{$barWidth = $max}
	{/if}
	{if $barWidth < $min}
		{if $barWidth == 0 }
			{$barWidth = 0}
		{else}
			{$barWidth = $min}
		{/if}
	{/if}
<div class="space-size clearfix  {if $user_size >= $fixed_size}exceeding{/if}  ">
	<div class="label c9">当前使用容量</div>
	<div class="user-progress ">
		<div class="t clearfix">
			<div class="tl"></div>
			<div class="tr"></div>
			<div class="tm"></div>
		</div>
		<div class="progress-body">
			<div class="progress-content">
				<div class="progress-bar">
			<div class="progress" style="width:{$barWidth}px;"></div>
			<div class="progress-line"></div>
		</div>
			</div>
		</div>
		<div class="b clearfix">
			<div class="bl"></div>
			<div class="br"></div>
			<div class="bm"></div>
		</div>
	</div>
	<div class="progress-text"><em>{$user_size}</em> / {$fixed_size}</div>
</div>
	{if $user_size >= $fixed_size}
	<p class="tips exceeding-tips">您的云空间已满！</p>
	{/if}
{if !$tplData.data.serviceinfo.cloud}
	<p class="tips">
        <a href="/home/payment/cloud?type=add&level=comm&pst=pay_userclould">升级成为VIP会员</a>，即可享有20000首存储容量
    </p>
{/if}
{/block}
