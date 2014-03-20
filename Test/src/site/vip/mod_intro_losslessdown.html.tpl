{extends file="vip/mod_intro_template_with_desc.html.tpl"}
{block name="service_intro"}
    <p>百度音乐为白金VIP会员提供媲美CD音质的flac无损音乐下载服务。</p>
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
        ]
    ]}

	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>使用说明</h2>
	</div>
	<div class="vip-privilege-block-split"></div>
	
    <div class="clearfix">
        <ul>
            {foreach $list as $item}
                <li class="vip-privilege-item-3 {if $item@last}vip-privilege-item-last{/if}">
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

	<p>Q：为什么有些歌曲没有无损品质？</p>
	<p>A：部分歌曲由于录制或授权提供等原因，暂时无法提供无损品质下载，百度音乐会尽力进行无损资源的补充。</p>

{literal}

	<style>

	.vip-privilege-pic-pcweb-max {
		background: url(/static/images/vip/home/lossless_pcweb.png) no-repeat;
	}

	.vip-privilege-pic-pcnative-max {
		background: url(/static/images/vip/home/lossless_pcnative.png) no-repeat;
	}

	</style>

{/literal}
{/block}