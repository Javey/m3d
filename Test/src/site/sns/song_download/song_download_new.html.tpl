{extends file="ting.html.tpl"}

{block name='keywords'}"音乐,mp3,百度音乐,下载,高品质下载"{/block}
{block name='description'}"音乐,下载,高品质音乐。百度音乐是中国第一音乐门户，为你提供海量正版高品质音乐，最权威的音乐榜单，最快的新歌速递，最契合你的主题电台，最人性化的歌曲搜索，让你更快地找到喜爱的音乐，带给你全新音乐体验。"{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/song_download_new.css{*version file='/static/css/song_download.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="title"}下载{/block}

{block name="body"}

{include "widget/adm/adm.html.tpl" inline}
{if $tplData.error != 22232}
	<div class="download-info">
		<h1 class="music-seo">
			<strong>音乐</strong>,<strong>下载</strong>,<strong>百度音乐</strong>,<strong>流行歌曲</strong>,<strong>流行音乐</strong>,<strong>高品质音乐</strong>
		</h1>
		<div id="loginbtn" style="display:none;"></div>
		
{if preg_match('/^\d+$/', $tplData.data.song.song_id)}
		
		{************伪造数据*************}
		
			{**
		{$song = [
			'fileData' => [
				
				['rate' => 64,
					 'format'=> mp3,
					 'size'=>4992294,
					 'songLink'=>'http://zhangmenshiting2.baidu.com/data2/music/2296168/2296168.mp3?64',
					 'dataType' => 1,
					 'songShowLink' => 'http://www.zhongshenw.com/wzlf/bskyy/tgxy/201012/W020101228151430621221.mp3'
				],
				['rate' => 128,
					 'format'=> mp3,
					 'size'=>4992294,
					 'songLink'=>'http://zhangmenshiting2.baidu.com/data2/music/2296168/2296168.mp3?128',
					 'dataType' => 1,
					 'songShowLink' => 'http://www.zhongshenw.com/wzlf/bskyy/tgxy/201012/W020101228151430621221.mp3'
				],
				['rate' => 192,
					 'format'=> mp3,
					 'size'=>4992294,
					 'songLink'=>'http://zhangmenshiting2.baidu.com/data2/music/2296168/2296168.mp3?192',
					 'dataType' => 1,
					 'songShowLink' => 'http://www.zhongshenw.com/wzlf/bskyy/tgxy/201012/W020101228151430621221.mp3'
				]
				

			],
			'resource_type' => 2,
			'song_id' => '1055770',
			'title' => '爱情复兴',
			'artist_id' => '1099',
			'author' => '容祖儿',
			'album_id' => '187668',
			'album_name' => 'Jump Up 9492',
			'relate_status'=> '3',
			'copy_type' => '2'
		]}
		{$downloadInfo = $song}
		{$rateInfo = $downloadInfo.fileData}
		**}
		

		{***************真实数据替换 begin************}
			{$downloadInfo = $tplData.data.song}
			{$rateInfo = $downloadInfo.fileData}
		{***************真实数据替换 end************}


		{*************************定义常用变量********************************
		*****1. $isCharge = 0 | 1 歌曲是否收费  
		*****2. $isLogin  = 0 | 1 用户是否登录 
		*****3. $isMember = 0 | 1 用户是否是会员 
		*****4. $downReason = 'free'|'downloaded'|'quota' 歌曲可下载的原因
		*****5. $upperLimit = 0 | 1 本期下载量是否已达上限
        *****6. $defaultRate = 128 | 320 | 'ape' 默认选中的码率 
		*******************************************************************}
		{$isCharge = 0}{if $downloadInfo.is_charge}{$isCharge = $downloadInfo.is_charge}{/if}
		{$isLogin = 0}{if $loginInfo}{$isLogin = 1}{/if}
		{$downPower = $tplData.data.downPower}
		{$isMember = 0}{if $downPower}{$isMember = $downPower.service_down}{/if}
		{$downPermit = 0}{if $downPower}{$downPermit = $downPower.download}{/if}
		{$downReason = ""}{$upperLimit = 0}
		{if $downPermit == 1}
			{$downReason = $downPower.reason}
		{elseif $isCharge && $downPermit == 2}
			{$upperLimit = 1}
		{/if}

		{$defaultRate = '128'}

		{$authors = explode(',',$downloadInfo.author)}
		<div class="song"><div class="logo-grey"><a target="_blank" href="/">百度音乐</a></div><span class="label c9">歌曲：</span><span class="fwb">{song_link song=["song_id"=>{$downloadInfo.song_id},"title"=>{$downloadInfo.title nofilter}]}</span>&nbsp;&nbsp;<span class="c6">-</span>&nbsp;&nbsp;{author_list releaseStatus=$downloadInfo.relate_status ids=$downloadInfo.artist_id names=$downloadInfo.author}{if !$isCharge}<span class="nocharge-icon"><i>免费</i></span>{/if}</div>


		{****************资源类型判断*******************}
		{if $downloadInfo.resource_type ==0 || $downloadInfo.resource_type ==1}
			{$copyrightData = true}
		{*{elseif $downloadInfo.resource_type ==1}*}
			{*{$whiteData = true}*}
		{elseif $downloadInfo.resource_type ==2}
			{$grayData = true}
		{elseif $downloadInfo.resource_type ==3}
			{$blackData = true}
		{/if}
		{$isDownData = 0}
		{if $copyrightData || $whiteData}
			{$isDownData = 1}
		{/if}

		<div {if $grayData || $blackData }{if !$grayData && $downloadInfo.copy_type != 3} style="height:auto;"{else}style="height:70px;" {/if}{/if} class="rate clearfix" >

	{if $grayData || $blackData }
		{if $grayData && $downloadInfo.copy_type == 3}
			<span class="c9">提示：</span> <span class="c6">因版权原因，该歌曲暂不提供下载服务</span>
		{else}
			{foreach $rateInfo as $item}
				{$musicData = $item}
				{break}
			{/foreach}
				<ol>
					<li>品质：<span class="cont"><span class="fwb">{round($musicData.size/104857)/10}M</span> ({$musicData.format} {$musicData.rate}kbps)</span></li>
					<li class="data-link"><span class="label">链接：</span>{if $musicData.songShowLink}<div class="cont link">{$musicData.songShowLink}</div>{else}来自互联网{/if}</li>
				</ol>
		{/if}
	{else}
		<span class="label c9">品质：</span>
		
		<form action="" id="form" {if $isCharge}class="down-limit-box{if $upperLimit} upper-limit-box{/if}"{/if}>
			<ul {if $isCharge}class="down-limit-ul{if $upperLimit} upper-limit-ul{/if}"{/if}>


		{foreach $rateInfo as $key=>$item}
			{if $item.rate <=128}
				{$min[] = $item}
			{elseif $item.rate>=320}
				{$max[] = $item}
			{/if}
		{foreachelse}
			无数据
		{/foreach}

		{if count($min)}
			{$bitMin = $min[count($min)-1] }
			{$bitDefault = $bitMin}
			{$defaultRate = $bitMin.rate} {**默认选中低码率（128）**}
		{/if}

		{if count($max)}
			{if !count($min)}
				{$bitDefault = $max[0]}
			{elseif $isLogin && $isMember}
				{$bitDefault = $max[count($max)-1]}
			{/if}			
			{$defaultRate = $bitDefault.rate} {**会员用户-选中能下的最大码率（320|ape）**}
		{/if}

		{if count($min)}
			{$bitMindata = json_encode(["rate"=> $bitMin.rate , "link"=>"/data/music/file?song_id=`$bitMin.songID`&rate=`$bitMin.rate`" ]) }
			<li data-data='{$bitMindata nofilter}' {if !$isCharge && count($max)}class="low-rate-box"{/if}>
				{if count($max)}<label hidefocus="true" for="bit{$bitMin.rate}">{/if}<input type="radio" {if $defaultRate == $bitMin.rate}checked{/if}  name="chooserate" id="bit{$bitMin.rate}" class="down-radio" />标准品质 <span class="fwb">{round($bitMin.size/104857)/10}M</span> ({$bitMin.format} {$bitMin.rate}kbps){if count($max)}</label>{/if}
			</li>
		{/if}

					
		{if count($max)}
			<li class="high-rate-box{if !$isCharge} down-limit-box{/if}">
				<ul {if !$isCharge}class="down-limit-ul"{/if}>
			{foreach $max as $key=>$item}

				{$maxItemdata = json_encode(["rate"=> $item.rate , "link"=>"/data/music/file?song_id=`$item.songID`&rate=`$item.rate`" ]) }
  					
				<li {if $item.rate == "320"} class="high-rate"{/if} data-data = '{$maxItemdata nofilter}'>
					<label hidefocus="true" for="bit{$item.rate}">
						<input class="down-radio" type="radio" 
						{if $defaultRate == $item.rate}checked{/if}
						 name="chooserate" id="bit{$item.rate}" /><span class="excellent-icon"></span>{if $item.rate == "ape"}超{/if}高品质 <span class="fwb" >{round($item.size/104857)/10}M</span> ({$item.format} {$item.rate}kbps)
					</label>

					{if $item.rate == "320"}
						<span class="new-icon">新!</span>
					{/if}

				</li>
			{/foreach}

				{**显示下载权限提示-右侧**}
				{include file="sns/song_download/song_download_downpower_tips.html.tpl" inline}

				</ul>
			</li>
		{elseif $isCharge}
			{**显示下载权限提示-右侧**}
			{include file="sns/song_download/song_download_downpower_tips.html.tpl" inline}
		{/if}
		</ul>	

		</form>

	{/if}
	</div>
	{if $grayData && $downloadInfo.copy_type == 3}
	{else}
	   	{**灰色资源由于马甲问题需要判断copy_type的值 是否显示下载内容**}
			<div class="operation clearfix">
				{if $downloadInfo.listen_only == 1}
		            <span class="cl listen-only">根据版权方要求，暂时不开放该资源的下载服务。</span>
		    	{else}
				{** by sunxiangpeng **}

				{*************************************
					【切忌切忌】
						1.修改此处下载链接注意一定是通过中转页，不可以直接是mp3文件地址。加前缀/data/music/file?link=】
						2.这里不用button组件的原因是button会导致不能IE下右键另存为
				**************************************}
	            {$downText = "下载"}
	            {$downClass = "down-btn"}
	            {$showSavetip = true}
	            {$showPaytip = false}
	            {$showGetgift = false}

				{if $grayData}
		            {$downLink = "/data/music/file?link={$musicData.songLink} "}
	    		{elseif $blackData}
		            {$downLink = "{$musicData.songShowLink} "}
	            {else}
	            	{$downLink = "/data/music/file?song_id={$bitDefault.songID}&rate={$bitDefault.rate}"}
	            	{if $isLogin}
	            		{if $isCharge || $defaultRate>128}
	            			{if !$isMember}
	            				{$showSavetip = false}
 								{$showGetgift = true}
	            				{$downText = "开通特权后下载"}
	            				{$downLink = "/home/payment"}
	            				{$downClass = "down-bemember"}
	            			{elseif $upperLimit}
	            				{$showSavetip = false}
	            				{$showPaytip = true}
	            				{$downText = "去支付"}
	            				{$downLink = "javascript:;"}
	            				{$downClass = "down-pay"}
	            			{/if}
	            		{/if}
	            	{else}
	            		{if $isCharge || $defaultRate>128}
            				{$showSavetip = false}
            				{$showGetgift = true}
	            			{$downText = "特权会员登录后下载"}
	            			{$downLink = "javascript:;"}
	            			{$downClass = "down-login"}
	            		{/if}
	            	{/if}
	            {/if}

	            <a href="{$downLink}" id="download" hidefocus="true" class="{$downClass}">{$downText}</a><span class="btn-download-span"></span>
	            
	            <div id="get_gift" {if !$showGetgift}style="display:none"{/if}>
	            	<a href="/home/gift" hidefocus="true" target="_blank" class="get-gift">免费领取下载特权<i>(限时活动)</i></a><span class="btn-gift-span"></span>
	            </div>
	            
					<span class="help show-save-tip c6 clearfix" {if !$showSavetip}style="display:none"{/if}>
						如果下载有问题，请尝试用鼠标右键点击下载按钮，选择“<span id="menuTips"></span>”
					</span>

					<span class="help show-pay-tip c6" {if !$showPaytip}style="display:none"{/if}>
						<i>若想购买该音乐，需支付<b class="fwb">0.99</b>元</i>
					</span>
	    {/if}
			</div>
	{/if}


	

{else}
        {** 第三方资源 **}
			{$downloadInfo = $tplData.data.song}
		{$authors = explode(',',$downloadInfo.author)}
		<div class="song"><div class="logo-grey"><a target="_blank" href="/">百度音乐</a></div><span class="label c9">歌曲：</span><span class="fwb">{$downloadInfo.title nofilter}</span>{if $downloadInfo.author}&nbsp;&nbsp;<span class="c6">-</span>&nbsp;&nbsp;{author_list releaseStatus=$downloadInfo.relate_status ids=$downloadInfo.artist_id names=$downloadInfo.author}{/if}</div>
        {if count($downloadInfo.fileData) > 0}
        <div class="main-links clearfix">
            <span class="label c9">推荐链接：</span> 
            <ul>
            	<li>
                {$otherCount = 0}
                {foreach $downloadInfo.fileData as $key => $val}
                    {if $otherCount == 0}
                    <a class="fwb" href="{$val.songLink}">
                    	{short_link link=$val.songShowLink}</a>
                    {/if}
                    {$otherCount = $otherCount + 1}
                {/foreach}
                </li>
            </ul>
        </div>
        {/if}
        {if count($downloadInfo.fileData) > 1}
        <div class="other-links clearfix">
            <span class="label c9">其它链接：</span> 
            <ul>
                {$otherCount = 0}
                {foreach $downloadInfo.fileData as $key => $val}
                    {if $otherCount != 0 && $otherCount < 5}
                        <li>
                            <a href="{$val.songLink}">
                            	{short_link link=$val.songShowLink}</a>
                        </li>
                    {/if}
                    {$otherCount = $otherCount + 1}
                {/foreach}
            </ul>
        </div>
        {/if}
{/if}

	
	{if !$smarty.get.clearadv} {**广告位**}
	{adm 
	    id = "636"
	    class = "ad-banner ecomad-banner-loading"
	}
	{/if}
</div>
{/if}
{if $tplData.error == 22232}  {**国外ip**}
		<div class="tip-mask"></div>
		<div class="foreign-tip">
			<div class="content">
				对不起，我们的服务暂时只能提供给中国内地的用户<br /> 
			Sorry, our current licence does not allow playback in your current territory.
			</div>
		</div>
	{/if}

{**支付的弹窗**}
{include file="sns/song_download/song_download_dialog.html.tpl" inline}

{/block}

{block name="js" append}
	
<script type="text/javascript">

	getUserBar(document.getElementById("loginbtn"), "/ajax/user_bar");
	var songInfo = {
			song_id : {$downloadInfo.song_id}
		},
		isDownData = {$isDownData},
		isCharge = {$isCharge}, //是否收费
		isLogin = {$isLogin}, //是否登录
		isMember = {$isMember}, //是否是会员
		upperLimit = {$upperLimit}; //是否达上限

	$(".ecom-ad").ecomad();
</script>

<script type="text/javascript" src="/static/js/song_download.js{*version file='/static/js/song_download.js' prefix='?' suffix='.js'*}"></script>


{/block}