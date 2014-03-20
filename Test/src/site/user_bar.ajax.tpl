{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/user_link/user_link.html.tpl" inline}   
{/block}
<script>
{block name="ajax_js"}
		{if $loginInfo}
	  var tingUserInfo={
			userName:"{$loginInfo.user_bdname}",
			userId:"{$loginInfo.ting_uid}",
			nickName:"{$loginInfo.nick}",
			userType:"{$loginInfo.is_musicer}",
	        bdName:"{$loginInfo.pass_info.un}",
	        bdEmail:"{$loginInfo.pass_info.secureemail}",
	        bdMobile:"{$loginInfo.pass_info.securemobil}",
	        bdNameInvalid:{if $loginInfo.user_bdname_badword}true{else}false{/if},
			avatarSmall:"{$loginInfo.avatar_small}",
			active:{if $loginInfo.active}true{else}false{/if},
			playlist_count:"{$loginInfo.playlist_count}",
			login:true
	  };
	  window.ting = window.ting || {};
	  ting.userInfo = tingUserInfo;
	{else}
	  var tingUserInfo=null;
	  ting.userInfo = tingUserInfo;
	{/if}
{/block}
</script>
