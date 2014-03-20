{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}cloud-dialog{/block}
{block name='mod_attr'}monkey="cloud-dialog"{/block}
{block name="mod_title"}
提示
{/block}
{block name="mod_body"}
	<p><span class="success-icon"></span></p>
	<p class="blue success-tips">恭喜，领取VIP会员特权成功！</p>
	<p><a href="/home/user">查看我的会员特权&gt;&gt;</a>  </p>
	<p class="btns">{button class="confirm" str="确认" style="a"} </p>
{/block}