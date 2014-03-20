{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}payment-dialog-banklist{/block}
{block name='mod_attr'}monkey="payment-dialog"{/block}
{block name="mod_title"}选择银行{/block}
{block name="mod_body"}
	<div class="payment-dialog-banklist-inner" >
		<ul id="payment-dialog-banklist" class="bank-list clearfix"></ul>
	</div>
	<div class="btns">
		{button
			str="确定"
			class="f18 payment-dialog-banklist-confirm"
			style="f"
			width = 120
		}
	</div>
{/block}