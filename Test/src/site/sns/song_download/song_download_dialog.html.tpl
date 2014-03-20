{extends file="widget/dialog/dialog.html.tpl"}
{block name="mod_class"}songdownload-dialog{/block}
{block name="mod_attr"}monkey="songdownload-dialog"{/block}
{block name="mod_title"}
支付结果
{/block}
{block name="mod_body"}
	<div class="pay-confirm-tip">
		<p><span class="money-icon"></span></p>
		<p>请在新打开的页面中完成支付。</p>
		<p class="is-success">是否支付成功？</p>
		<p class="btns">{button str="支付成功" class="pay-success-btn" style="a"} {button str="支付失败" class="pay-fail-btn" style="b"} </p>
	</div>
	<div class="pay-fail-tip payment-result">
		<h2 class="title">支付失败</h2>
		<ul class="payment-result-from">
			<li class="clearfix">
				<div class="label">购买类型：</div>付费音乐下载
			</li>
			<li class="clearfix">
				<div class="label">待付金额：</div><span class="red"><b>0.99</b> 元</span>
			</li>
		</ul>
	{button str="重新支付" class="pay-again" style="a"}
	</div>
{/block}