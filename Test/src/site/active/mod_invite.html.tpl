<div class="mod-invite">
<div class="invite_content">
	<div class="top_banner">
		<div class="link">
			<span class="link_row">&gt;&gt;&nbsp;<a id="ac-invite-desc" name="invite-desc">活动规则</a></span>
			<span class="link_row">&gt;&gt;&nbsp;<a id="ac-vip-power-list" name="vip-power-list">VIP会员特权</a></span>
		</div>
		<div class="user_panel">
			<p class="label">我的会员信息</p>
			{if $loginInfo}
				<div class="user_info">
					<div class="user_avatar"><img src="{$loginInfo.pass_info.avatar_small}"/></div>
					<div class="user_detail">
						<p class="user_title">
							<span class="username">
								{$loginInfoUserName}
							</span>
							{if $loginInfo.vip}
							<i title="已开通会员" class="power-icon-min power-icon-vipidentity-active"></i>
							{else}
							<i title="未开通会员" class="power-icon-min power-icon-vipidentity"></i>
							{/if}
							<span class="usertag"></span>
						</p>
						{if $loginInfo.vip}
						<div class="vip_info">
							<p>VIP会员到期日期：{$loginInfo.vip.cloud.end_time|date_format:"%Y-%m-%d"}</p>
							<p>已获得免费续期<span>{$tplData.total}</span>个月</p>	
						</div>
						{else}
						<div class="vip_info">
							<p>您还不是VIP会员</p>
							<p>马上领取吧</p>	
						</div>
						{/if}
					</div>			
				</div>
			{else}
				<div class="user_info">
					<div class="user_avatar"><img src="http://himg.bdimg.com/sys/portraitn/item/d8493406.jpg"/></div>
					<div class="user_detail">
						<p class="user_title">
							<span class="lbl_login">您尚未登录，请<a class="login-btn">登录</a></span>
						</p>
					</div>			
				</div>
			{/if}
		</div>
		<div class="invite_info"></div>
		{if $loginInfo.vip}
			<p class="lbl_vip">我已是VIP会员</p>
		{else}
			{if $tplData.inviteInfo}
			<p class="friend_desc">
			<span>
				{if $tplData.inviteInfo.user_bdname eq ""}
					{$tplData.inviteInfo.email}
				{else}
					{$tplData.inviteInfo.user_bdname}
				{/if}
			</span> 邀请您免费体验7天百度音乐VIP特权</p>
			{else}
			{/if}
		{/if}
	</div>
	<div class="step_get7">
		<div class="get_vip">
			<div class="get_panel">
				<a class="link_get7 receive-btn" id="get-vip"></a>
				<div class="vip_intro">
					<a href="/home/vip/superplay?pst=free7d" target="_blank" class="item_01"></a>
					<a href="/home/vip/superspace?pst=free7d" target="_blank" class="item_02"></a>
					<a href="/home/vip/vipidentity?pst=free7d" target="_blank" class="item_03"></a>
				</div>
			</div>
		</div>
	</div>
	<div class="line_dot"></div>
	<div class="mod-addmonth">
		<div class="addmonth_left">
			<div class="title"></div>
			<div class="invite_record">
				<div class="invite_process 
					{if $tplData.total eq 0}
						no0
					{elseif $tplData.total eq 1}
						no1
					{elseif $tplData.total eq 2}
						no2
					{elseif $tplData.total >=3 }
						no3
					{/if}">
				</div>
				<div class="record_title">邀请记录：</div>
				<div class="record_detail">
					{if $tplData.record}
						{foreach $tplData.record as $key=>$item}
							<span>您已成功邀请{if $item.user_bdname}{$item.user_bdname}{else}{$item.email}{/if}</span>
						{/foreach}
					{else}
						<span>您目前还没有好友被邀请</span>
					{/if}
				</div>
			</div>
		</div>
		<div class="addmonth_right">
			<div class="addmonth_intro">
				{if $loginInfo}
					{if $loginInfo.vip}
						<p class="lbl_xu">亲爱的百度音乐VIP会员，<br/>		邀请好友参与活动就能免费获得最多三个月的VIP续期。</p>
					{else}
						<p class="lbl_nologin">您还不是会员，暂时不能参与该活动哦~</p>
						<p class="lbl_xu">邀请好友参与活动就能免费获得最多三个月的VIP续期。</p>
					{/if}
				{else}
					<p class="lbl_nologin">您还未登录，VIP用户请登录参与活动</p>
					<p class="lbl_xu">邀请好友参与活动就能免费获得最多三个月的VIP续期。</p>
				{/if}
			</div>
			<div class="method_01">
				<p class="title"><span class="stren">邀请方法1：</span><span>点击按钮直接分享，邀请好友</span></p>
				<p class="ta_share"><textarea id="ta-bdshare">3个月【百度音乐VIP会员】免费拿，立即领取：http://music.baidu.com/home/vip/invite/?bid={if $loginInfo.ting_uid}{$loginInfo.ting_uid}{else}-1{/if} （分享自 @百度音乐）</textarea></p>
				<div class="share">
					<div id="bdshare" class="bdshare_t bds_tools_32 get-codes-bdshare">
						<a class="bds_qzone"></a>
						<a class="bds_tsina"></a>
						<a class="bds_tqq"></a>	
						<a class="bds_renren"></a>	
						<span class="bds_more"></span>	
					</div>
				</div>	
			</div>
			<div class="method_02">
				<p class="title"><span class="stren">邀请方法2：</span><span>发送邀请链接</span></p>
				<div class="input_share">
					<span class="is_input"><input id="txt-share" type="text" value="{if $loginInfo.vip}http://music.baidu.com/home/vip/invite/?bid={if $loginInfo.ting_uid}{$loginInfo.ting_uid}{else}-1{/if}{/if}"/></span>
					<span data-clipboard-target="txt-share"  class="clipinner is_btn">复&nbsp;制</span>
				</div>
			</div>
			{if $loginInfo.vip}
			{else}
				<div class="mask mask_ta"></div>
				<div class="mask mask_input"></div>
			{/if}

		</div>
	</div>

	<div class="vip-power-list" id="vip-power-list">
		<div class="head">
			<div class="title clearfix">VIP会员特权介绍</div>
		</div>
		<ul class="clearfix">
			<li>
				<a href="/home/vip/superspace?pst=free3m" target="_blank">
					<i class="power-icon-max power-icon-superspace-max"></i>
					<h3 class="power-name">超大存储空间</h3>
					<div class="desc power-desc">VIP会员享受20000首歌曲的超大音乐云存储空间</div>
				</a>
			</li>
			<li>
				<a href="/home/vip/superplay?pst=free3m" target="_blank">
					<i class="power-icon-max power-icon-superplay-max"></i>
					<h3 class="power-name">高品质音乐播放</h3>
					<div class="desc power-desc">VIP会员享192Kbps MP3格式高品质播放服务</div>
				</a>
			</li>
			<li>
				<a href="/home/vip/superstorage?pst=free3m" target="_blank">
					<i class="power-icon-max power-icon-superstorage-max"></i>
					<h3 class="power-name">高品质音乐存储</h3>
					<div class="desc power-desc">VIP会员可存储百度音乐提供的最高品质的歌曲</div>
				</a>
			</li>
			<li>
				<a href="/home/vip/compression?pst=free3m" target="_blank">
					<i class="power-icon-max power-icon-compression-max"></i>
					<h3 class="power-name">音频压缩</h3>
					<div class="desc power-desc">VIP会员可将高品质资源压缩成更小的文件</div>
				</a>
			</li>
			<li>
				<a href="/home/vip/vipidentity?pst=free3m" target="_blank">
					<i class="power-icon-max power-icon-vipidentity-max"></i>
					<h3 class="power-name">VIP会员身份标识</h3>
					<div class="desc power-desc">VIP会员尊享高贵身份标识</div>
				</a>
			</li>
			<li>
				<a href="/home/vip/superspace?pst=free3m" target="_blank">
					<i class="power-icon-max power-icon-more-max"></i>
					<h3 class="power-name blue_link">更多权利!</h3>
					<div class="desc power-desc">更多权利正在努力上线中！敬请期待...</div>
				</a>
			</li> 
		</ul>
	</div>

	<div class="mod-invite-desc" id="invite-desc">
		<h2 class="title">活动规则：</h2>
		<ul class="c6">
			<li>1、百度音乐注册用户可参与「免费体验7天VIP」活动；百度音乐VIP会员用户可参与「免费得3个月VIP」活动。</li>
			<li>2、每成功邀请一名好友体验百度音乐VIP会员，邀请者可免费获得1个月VIP续期，最多可累计获得3个月VIP续期。</li>
			<li>3、获得免费续期的条件：邀请成功，即普通用户通过您的邀请链接参与免费体验7天VIP活动；邀请成功时你的状态是VIP会员。</li>
			<li>4、您获得的VIP会员资格将在当天进行发放，详细信息可在活动右上角及会员中心查看。</li>
			<li>5、活动时间：2013.03.22-2013.5.22</li>
		</ul>
	</div>
</div>
</div>