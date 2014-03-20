{***************真实数据替换 begin************}
{$downloadInfo = $tplData.data.song}
{$rateInfo = $downloadInfo.fileData}
{$pageId = '' scope='global'}
{***************真实数据替换 end************}

{**************** 资源类型判断 start *******************}
{if $downloadInfo.resource_type == 0 || $downloadInfo.resource_type == 1}
	{$copyrightData = true}
{elseif $downloadInfo.resource_type ==2}
	{$grayData = true}
{elseif $downloadInfo.resource_type ==3}
	{$blackData = true}
{/if}
{**************** 资源类型判断 end *******************}

{include file="sns/song_download/access_configure.html.tpl" inline}

{** 当前权限 **}
{$userAccess = $accessConfigure[$userStatus][$three]}

<div class="song">
    <div class="logo-grey">
        <a target="_blank" href="/">百度音乐</a>
    </div>
    <span class="label c9">歌曲：</span>
    <span class="fwb">{song_link song=["song_id"=>{$downloadInfo.song_id},"title"=>{$downloadInfo.title nofilter}] target=true}</span>&nbsp;&nbsp;<span class="c6">-</span>&nbsp;&nbsp;{author_list target='_blank' releaseStatus=$downloadInfo.relate_status ids=$downloadInfo.artist_id names=$downloadInfo.author}
</div>
		
<!-- rate start -->
<div class="download-wrapper">
    <div class="rate" >
        {if $copyrightData && $downloadInfo.beDownloaded == 1}
        {*** 正版不可下载资源 **}
            <span class="c9">该歌曲暂不提供下载服务</span>
        {elseif !$copyrightData && $downloadInfo.beDownloaded == 1}
        {*** 非正版不可下载资源 **}
            <span class="c9">来源链接：</span> <span class="c6">暂无</span>
        {elseif !$copyrightData && $downloadInfo.beDownloaded == 0}
        {*** 非正版可下载资源 **}
        {**用个字段标示**}
            {$notCopyButDown = true}
        {*优先获取pan.baidu.com资源，否则取最后一条数据*}
            {foreach $rateInfo as $item}
                {if (strpos($item.songShowLink, "pan.baidu.com") !== false)}
                    {$musicData = $item}
                    {break}
                {else}
                    {$musicData = $item}
                {/if}
            {/foreach}
            <span class="c9" style="float: left">来源链接：</span>
            <span class="c6" style="float: left; width: 430px; word-break: break-all; word-wrap:break-word; ">
            {if $musicData.songShowLink}
                <a target="_blank" href="{$musicData.songShowLink}">{$musicData.songShowLink}</a>
            {else}
                来自互联网
            {/if}
        </span>
        {else}
        {*** 正版可下载资源 **}
            {$copyAndDown = true}
            <span class="label c9">品质：</span>
            <form action="" id="form">
                {$ret = ksort($rateInfo)}
                {foreach $rateInfo as $item}
                    {if $item.rate <=128}
                    {*标准品质，取一个*}
                        {$levelOne[$item.rate] = $item}
                    {elseif $item.rate > 128 && $item.rate <= 256}
                    {*高品质，取一个*}
                        {$levelTwo[$item.rate] = $item}
                    {elseif $item.rate > 256 && $item.rate <= 320}
                    {*320取一个*}
                        {$levelThree[$item.rate] = $item}
                    {else}
                    {*flac取一个*}
                        {$levelFour[$item.rate] = $item}
                    {/if}
                    {foreachelse}
                    无数据
                {/foreach}

                {*每种等级各取一个*}
                {if count($levelOne)}
                    {$song = array_pop($levelOne)}
                    {$songs[128] = $song}
                {/if}
                {if count($levelTwo)}
                    {$song = array_pop($levelTwo)}
                    {$songs[256] = $song}
                {/if}
                {if count($levelThree)}
                    {$song = array_pop($levelThree)}
                    {*统一码率标示为320，竟然还有269kbps*}
                    {$songs[320] = $song}
                {/if}
                {if count($levelFour)}
                    {*统一码率标示为1000，这个码率太多了*}
                    {$song = array_pop($levelFour)}
                    {*{$song.rate = 1000}*}
                    {$songs[1000] = $song}
                {/if}
                {*{var_dump($songs)}*}

                <div class="ul {if $three == 'isThree'}is-three{/if}">
                    {$checkLow = false}
                    {$checkHigh = false}
                    {foreach $songs as $key => $item}
                        {$data = ["rate" => $key]}
                        {if $item.rate <= 256 && !$checkLow}
                            <div class="low-rate">
                            {$checkLow = true}
                        {elseif $item.rate > 256 && !$checkHigh}
                            {if $checkLow}</div>{/if}
                            <div class="high-rate">
                            {$checkHigh = true}
                        {/if}
                        {** radio checked最佳匹配资源 **}
                        {$nextSong = next($songs)}
                        {$nextKey = array_search($nextSong, $songs)}
                        {if $item@first && $userAccess[$key].button != 'download'}
                            {$checked = true}
                        {elseif $userAccess[$key].button == 'download' && $userAcess[$nextKey].button != 'download'}
                            {$checked = true}
                        {/if}
                        <div data-data='{json_encode($data)}' class="li clearfix">
                            <label hidefocus="true" for="bit{$key}">
                                <input class="down-radio" type="radio" {if $checked} checked{$checked = false}{/if} name="chooserate" id="bit{$key}" />
                                <span class="rate-title">
                                    {$title[$key]}
                                    {*<i class="{if $item.rate > 256 && $item.rate <= 320}hq{elseif $item.rate > 320}hq-plus{/if}"></i>*}
                                </span>
                                <span class="c9">{round($item.size/104857)/10}M / {if $item.rate < 1000}{$item.rate}kbps{else}无损{/if} / {$item.format}</span>
                            </label>
                            <div class="description">
                                {$description = $buttons[$userAccess[$key]['button']]['description']}
                                {$description nofilter}
                                {*{if $three == 'isThree' && !$description}*}
                                    {*{if $item.rate <= 256}*}
                                        {*<i class="power-icon-min power-icon-vipidentity-active"></i>*}
                                        {*VIP会员特权{if $tplData.gift_now != 0}，免费试用2个月{/if}*}{** 试用活动代码 **}
                                    {*{else}*}
                                        {*<i class="power-icon-min power-icon-goldvip-active"></i>*}
                                        {*白金VIP会员特权*}
                                    {*{/if}*}
                                {*{/if}*}
                            </div>
                        </div>
                    {/foreach}
                    </div>
                </div>
            </form>
        {/if}
    </div>

    {*pageId*}
    {if $copyAndDown}
        {$pageId = "-`$three`" scope='global'}
    {elseif $notCopyButDown}
        {$pageId = '-pan' scope='global'}
    {/if}

    {** 试用活动代码 **}
    {if $three == 'isThree' && $userStatus == 'none'}
        <div class="try-tip">
            您已获赠2个月<i class="power-icon-min power-icon-vipidentity-active"></i>VIP会员资格！<a href="javascript:;" title="登录" class="try-vip-login">登录</a>后免费体验高品质歌曲下载！
        </div>
    {elseif $tplData.gift_now != 0}
        <div class="try-tip">
            您已获赠2个月<i class="power-icon-min power-icon-vipidentity-active"></i>VIP会员资格！即刻免费体验高品质歌曲下载！
        </div>
    {/if}


    <!-- rate end -->
    <div class="operation clearfix {if !$copyAndDown}operation-notcopy{/if}">
        {if $copyAndDown}
            {foreach $userAccess as $item}
                {$button = $buttons[$item.button]}
                {$class = $button['class']}
                {$href = $button['href']|default:"#"}
                {if $href == 'link'}
                    {if $copyrightData}
                        {$downloadLink = "/data/music/file?link={$songs[$item@key].songLink}&song_id={$downloadInfo.song_id}"}
                    {else}
                        {$downloadLink = "{$musicData.songShowLink}"}
                    {/if}
                    {$href = $downloadLink}
                {/if}
                {button
                    style = $button['style']|default:"h"
                    class = $class
                    data = ['ids'=>$downloadInfo.song_id,'type'=>"song"]
                    str = $button['text']
                    icon = $button['icon']
                    href = $href
                    id = $item@key
                    tagAtt = $button['target']
                }
            {/foreach}
        {elseif $notCopyButDown}
            {button
                style = 'h'
                class = 'actived download btn-download'
                data = ['ids'=>$downloadInfo.song_id,'type'=>"song"]
                str = '下载'
                icon = 'download-small'
                href = $musicData.songShowLink
                tagAtt = 'target="_blank"'
            }
        {/if}

      {if $copyAndDown || $notCopyButDown}
        {button
          style = 'i'
          id = 'pcDownloadBtn'
          class = 'actived btn-download'
          str ='高速下载'
          href = '#'
          icon = 'download-pc'
          tagAtt = 'target="_blank"'
        }
      {/if}
      {if $copyAndDown}
        {button
          style = 'i'
          id = 'telDownloadBtn'
          class = 'actived btn-download'
          str = '下载到手机'
          icon = 'download-mobile'
          href = '/app'
          tagAtt = 'target="_blank"'
        }
      {/if}
    </div>
</div>