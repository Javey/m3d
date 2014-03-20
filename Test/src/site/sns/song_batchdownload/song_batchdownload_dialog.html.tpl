{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}batchdown-dialog{/block}
{block name='mod_attr'}monkey="batchdown-dialog"{/block}
{block name="mod_title"}是否成功开通VIP？{/block}
{block name="mod_body"}
	<p><span class="money-icon"></span></p>
	<p class="btns">{button str="成功开通" class="vip-success-btn" style="e"} {button class="vip-fail-btn" str="开通失败" style="b"} </p>
{/block}