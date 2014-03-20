{extends file="widget/dialog/dialog.html.tpl"}
{block name='mod_class'}receive-dialog{/block}
{block name='mod_attr'}monkey="receive-dialog"{/block}
{block name="mod_title"}
提示
{/block}
{block name="mod_body"}
	<p><span class="success-icon"></span></p>
	<p class="blue success-tips">恭喜，领取下载特权成功！</p>
	<p class="is-success">31天150首歌曲（包含超高品质）音乐下载特权，已领取成功</p>
	<p class="view-mypower"><a href="/home/usercenter">查看我的特权</a> </p>
	<p class="btns">{button class="confirm" str="确认" style="b"} </p>
{/block}