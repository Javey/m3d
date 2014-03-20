{if !$loginInfo ||$loginInfo.status==1}
	<a href="#" class="user-bar-mbox" id='user-bar-mbox'><span><i class="play-icon"></i>音乐盒</span></a><a href="/login" id="login-hook" class="user-login"><span>登录</span></a><span class="line"></span><a href="/register" class="user-reg" ><span>注册</span></a> 
{elseif !$loginInfo.active}
{$un = $tplData.loginInfo.pass_info.un}
{if !$un}
{$un = $tplData.loginInfo.pass_info.secureemail}
{/if}
{if !$un}
{$un = $tplData.loginInfo.pass_info.securemobil}
{/if}
{if !$tplData.loginInfo.active}<span>{$un}</span>&nbsp;&nbsp;{/if}<a href="/activate">激活ting!</a>&nbsp;&nbsp;<a href="http://passport.baidu.com/?logout" id="logout-hook">退出</a>
{else}

{$un = $tplData.loginInfo.pass_info.un}
{if !$un}
{$un = $tplData.loginInfo.pass_info.secureemail}
{/if}
{if !$un}
{$un = $tplData.loginInfo.pass_info.securemobil}
{/if}

<ul class="user-info">
  <li><a href="/mail/inbox" class="user-msg" title="ting信"><span><em class="user-msg-icon"></em>{if $loginInfo.message_count}<em class="msg-num">{if $loginInfo.message_count>99}99+{else}{$loginInfo.message_count|default:0}{/if}</em>{/if}</span></a></li>
  
  <li class="account" id="accountMenu"><span class="account-link"><span class="icon"></span><i class="tl"></i><i class="tr"></i></span>
    <div class="account-menu">
      <ul>
      <li class="menu-center"><a href="/account/profile">账号设置</a></li>
      <li class="menu-logout"><a href="http://passport.baidu.com/?logout" id="logout-hook">退出</a></li>
    </ul><i class="tl"></i><i class="bl"></i><i class="br"></i>
    </div>
  </li>
</ul>
{/if}

