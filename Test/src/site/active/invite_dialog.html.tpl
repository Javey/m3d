{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}invite-dialog{/block}
{block name='mod_attr'}monkey="invite-dialog"{/block}
{block name="mod_title"}
提示
{/block}
{block name="mod_body"}
<div class="vip_get_success">
	<p><span class="success-icon"></span></p>
    <p class="yellow success-tips">恭喜，领取VIP会员特权成功！</p>
    <p><a href="/home/user" target="_blank">查看我的会员特权&gt;&gt;</a>  </p>
    <p class="btns">
        {button class="confirm" str="" style=""}
        {button class="cancel" str="" style=""}
    </p>
</div>
<div class="vip_end">
    <p class="yellow success-tips">非常抱歉！我们的活动已经结束！</p>
    <p><a href="/home/vip?pst=free7d">了解更多</a></p>
</div>
{/block}