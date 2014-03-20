{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}exchange-dialog exchange-fail-dialog{/block}
{block name='mod_attr'}monkey="exchange-dialog"{/block}
{block name="mod_title"}兑换失败{/block}
{block name="mod_body"}
	<p class="desc">兑换码不存在或已经失效</p>
	<p class="btns">{button str="关闭" class="exchange-close-btn" style="c" width="110"}</p>
{/block}