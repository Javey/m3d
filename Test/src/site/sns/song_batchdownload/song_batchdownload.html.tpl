{extends file="ting.html.tpl"}

{**************** 资源类型判断 end *******************}
{block name="assign" append}
	{** 用户状态 **}
	{if $loginInfo}
		{$serviceLevel = $loginInfo.vip.cloud.service_level}
		{if $serviceLevel == 'gold'}
			{$userStatus = 'goldVip'}
		{elseif $serviceLevel == 'comm'}
			{$userStatus = 'commVip'}
		{else}
			{$userStatus = 'login'}
		{/if}
	{else}
		{$userStatus = 'none'}
	{/if}

	{$ids = $tplData.data.ids}
	{$count = $tplData.data.count}
	{$achTitle = $tplData.data.title}

	{$rates = array('128', '320', '1000')}

	{$defaultRate = '128'}
	{if in_array($tplData.data.rate, $rates)}
		{$defaultRate = $tplData.data.rate}
	{/if}

	{*{$covers = array("http://c.hiphotos.baidu.com/ting/pic/item/80cb39dbb6fd52666d8417abaa18972bd50736e5.jpg", "http://c.hiphotos.baidu.com/ting/pic/item/80cb39dbb6fd52666d8417abaa18972bd50736e5.jpg", "http://c.hiphotos.baidu.com/ting/pic/item/80cb39dbb6fd52666d8417abaa18972bd50736e5.jpg", "http://c.hiphotos.baidu.com/ting/pic/item/80cb39dbb6fd52666d8417abaa18972bd50736e5.jpg")}*}

	{$ttplayerLink = "http://qianqian.baidu.com/download/BaiduMusic-12345615.exe"}
	{$ttplayerWeb = "http://music.baidu.com/pc/"}

	{$covers = $tplData.data.pics}
{/block}

{block name='keywords'}"音乐,mp3,百度音乐,下载,高品质下载"{/block}
{block name='description'}"音乐,下载,高品质音乐。百度音乐是中国第一音乐门户，为你提供海量正版高品质音乐，最权威的音乐榜单，最快的新歌速递，最契合你的主题电台，最人性化的歌曲搜索，让你更快地找到喜爱的音乐，带给你全新音乐体验。"{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/song_batchdownload.css{*version file='/static/css/song_batchdownload.css' prefix='?' suffix='.css'*}" />
{/block}

{block name='js-monkey-pageid'}ting-muisc-songbatchdownload{/block}

{block name="title"}下载{/block}

{block name="body"}
{*{$userStatus}*}
{*{var_dump($ids)}*}
{*{var_dump($tplData)}*}
{include file="sns/song_batchdownload/access_configure.html.tpl" inline}

{** 当前权限 **}

{$userAccess = $accessConfigure[$userStatus]}
<div class="download-info">
	<div class="song">
		<div class="logo-grey">
			<a target="_blank" href="/">百度音乐</a>
		</div>
		<span class="c3">您正在使用批量下载服务：</span>
	</div>

	<div class="album-info">
		<ul class="cover-list">
			{foreach $covers as $cover}
				<li><img src="{$cover}" /></li>
			{/foreach}
		</ul>
		<div class="c3 album-count">共{if $count > 50}<span class="red">{$count}</span>{else}{$count}{/if}首歌曲</div>
		<div class="clearfix"></div>
	</div>

	<div style="height:auto;" class="rate clearfix" >
		<form action="" id="form">
			<div class="ul">
				{foreach $rates as $rate}
					{$data = ["rate" => $rate]}

					{** radio checked最佳匹配资源 **}
					{if $rate == $defaultRate}
						{$checked = true}
					{/if}
				
					<div data-data='{json_encode($data)}' class="li clearfix">
						<label hidefocus="true" for="bit{$rate}">
							<input class="down-radio" type="radio" {if $checked} checked{$checked = false}{/if} name="chooserate" id="bit{$rate}" />
							<span>
								优先{$title[$rate]['rate']}
							</span>
							<span class="c9">（{$title[$rate]['desc']}）</span>
							{if $rate == '1000'}
							<a class="red" href="{$ttplayerWeb}" target="_blank">百度音乐PC版专享</a>
							{/if}
						</label>
					</div>
				{/foreach}
			</div>
		</form>
	</div>

	<div class="module-dotted"></div>

	<div class="addtion-tips" id="addtion-tips"></div>

	<div class="operation">
		{if $count lte 50}
			{foreach $userAccess as $key => $item}
				{$button = $buttons[$item.button]}
				{$class = $button['class']}
				{$href = $button['href']|default:"#"}
				{if $href == 'link'}
	                {$downloadLink = "http://songfile.baidu.com/songs/file?method=batchdownload&songs={$ids}&rate={$key}&title={$achTitle|escape:"url"}"}
	                {$href = $downloadLink}
	            {/if}
				{button
					style = $button['style']|default:"c"
					class = $class
					data = ['ids'=>$downloadInfo.song_id,'type'=>"song"]
					str = $button['text']
					icon = $button['icon']
					href = $href
					id = $item@key
					tagAtt = $button['target']
				}
			{/foreach}
		{/if}

		{button
			style = 'g'
			id = 'btnTTPlayer'
			class = 'actived btn-download'
			str = '用PC版高速下载'
			href = '#'
			tagAtt = 'target="_blank"'
		}
	</div>

</div>

{/block}

{block name="js" append}
	{$song = $tplData.data.song}
	<script src="/static/js/song_batchdownload.js" type="text/javascript" _xbuilder="true" _xcompress="true"></script>

	<script type="text/javascript">
	$(function() {
		ting.initBatchDownload({
			downloadInfo: {
				count: {$count},
                songIds: '{$tplData.data.ids}'
			},
			get: {json_encode($smarty.get) nofilter},
			loginInfo: {json_encode($tplData.loginInfo) nofilter}
		})
	})
	</script>
{/block}

{block name="body_fixed_pop"}
{include file="sns/song_batchdownload/song_batchdownload_dialog.html.tpl"}	
{/block}