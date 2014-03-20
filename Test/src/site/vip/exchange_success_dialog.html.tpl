{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}exchange-dialog exchange-success-dialog{/block}
{block name='mod_attr'}monkey="exchange-dialog"{/block}
{block name="mod_title"}兑换成功{/block}
{block name="mod_body"}
	<p class="desc"></p>
	<p><a href="/vip/user">查看个人中心</a></p>
	<p class="btns">{button str="关闭" class="exchange-close-btn" style="c" width="110"}</p>
{/block}