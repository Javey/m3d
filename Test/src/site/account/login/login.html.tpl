{extends file="ting.html.tpl"}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/mv_login.css" />
{/block}

{block name="js" append}
	<script type="text/javascript">
        ting.passport.render( "login", "login_form" );
	</script>
{/block}

{block name="title"}登录{/block}

{block name="content_main"}
	{include file="account/login/mod_login.html.tpl"}
{/block}

