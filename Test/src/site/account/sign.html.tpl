{**
 * 邀请登录、注册通用模板
 **}

{extends file="ting.html.tpl"}

{block name="assign"}
	{$useSimpleTop = true}
{/block}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/mv_sign.css{*version file="/static/css/mv_sign.css" prefix="?" suffix=".css"*}" />
{/block}

{block name="content_main"}
<div class="sign_holder {block name='mod_class'}{/block}">
	<div class="sign_main">
		{if $invite == true}
		{$userInfo = $tplData.userInfo}
		<div class="sign-info clearfix">
			<div class="sign-info-icon">
				<img src="{avatar user=$userInfo}" />
			</div>
			<div class="sign-info-des">
				Hi，我是 <span>{$userInfo.nick}</span><br />
				快来跟我一起加入ting!，随时随地分享好音乐。
			</div>
		</div>
		{/if}

		{block name="sign_contant"}{/block}
	</div>
</div>
{/block}
