{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}payment-dialog-confirm{/block}
{block name='mod_attr'}monkey="payment-dialog"{/block}
{block name="mod_title"}
请在新打开的页面中完成支付
{/block}
{block name="mod_body"}
	<div class="payment-exclamation-icon"></div>
	<div class="payment-dialog-content">
		<p class="row1">请您在新打开的页面完成支付！</p>
		<p class="row2">支付完成前请不要关闭此窗口</p>
	</div>
	<p class="btns">{button str="支付成功" class="payment-success-btn" style="e"} {button class="payment-fail-btn" str="支付失败，重新下单" style="b"} </p>
{/block}