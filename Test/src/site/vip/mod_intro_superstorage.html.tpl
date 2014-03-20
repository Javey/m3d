{extends file="vip/mod_intro_template_with_desc.html.tpl"}
{block name="service_intro"}
    <p>百度音乐为VIP会员提供 超高品质 音乐下载服务，最高可达320kbps。（说明：部分歌曲根据版权方要求仅提供最高256Kbps MP3音乐下载）</p>
	<p>同时我们还为VIP用户提供贴心便捷的批量下载功能，白金VIP用户还能享受媲美CD音质的flac无损音乐下载服务。</p>
{/block}
{block name="service_detail"}
	{$list = [
        "pcweb" => [
            "title" => "百度音乐网站",
            "type" => "pcweb"
        ],

        "pcnative" => [
            "title" => "百度音乐PC客户端",
            "type" => "pcnative"
        ],

        "mobilenative" => [
            "title" => "百度音乐手机客户端",
            "type" => "mobilenative"
        ]
    ]}

	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>使用说明</h2>
	</div>
	<div class="vip-privilege-block-split"></div>

	<div class="clearfix">
        <ul>
            {foreach $list as $item}
                <li class="vip-privilege-item-{count($list)} {if $item@last}vip-privilege-item-last{/if}">
                    <a class="vip-privilege-pic-wrapper" title="{$item.title}">
                        <i class="vip-privilege-pic-max vip-privilege-pic-{$item@key}-max">{$item.text}</i>
                    </a>

                    <h3 class="power-name">{$item.title}</h3>
                </li>
            {/foreach}
        </ul>
    </div>

    <div class="module-a-title">
		<h2 class="title"><i class="icon"></i>常见问题</h2>
	</div>
	<div class="vip-privilege-block-split"></div>

	

	<p>Q：哪些歌曲提供高品质下载？</p>
	<p>A：百度音乐网站、PC客户端、手机客户端中带有高品质标识的音乐，均提供高品质下载服务。</p>

	<p>Q：为什么有些歌曲VIP不能下载320品质？</p>
	<p>A：根据版权方要求，部分歌曲对VIP用户仅提供最高256kbps MP3音乐下载，您可以收藏歌曲后进入云音乐空间下载；或直接安装百度音乐PC客户端、手机客户端，专享高品质音乐免费下载。</p>


{literal}

	<style>

	.vip-privilege-pic-pcweb-max {
		background: url(/static/images/vip/home/superstorage_pcweb.png) no-repeat;
	}

	.vip-privilege-pic-pcnative-max {
		background: url(/static/images/vip/home/superstorage_pcnative.png) no-repeat;
	}

	.vip-privilege-pic-mobilenative-max {
		background: url(/static/images/vip/home/superstorage_mobilenative.png) no-repeat;
	}

	</style>

{/literal}
{/block}
