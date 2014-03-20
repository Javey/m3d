{extends file="vip/mod_intro_template_with_desc.html.tpl"}
{block name="service_intro"}
	

    <p>VIP会员省份标志（V）将出现在百度音乐网站，音乐盒、PC客户端、手机客户端。全方位，全平台，彰显您的VIP会员身份。</p>

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
                <li class="vip-privilege-item-3">
                    <a class="vip-privilege-pic-wrapper" title="{$item.title}">
                        <i class="vip-privilege-pic-max vip-privilege-pic-{$item@key}-max">{$item.text}</i>
                    </a>

                    <h3 class="power-name">{$item.title}</h3>
                </li>
            {/foreach}
        </ul>
    </div>

{literal}

	<style>

	.vip-privilege-pic-pcweb-max {
		background: url(/static/images/vip/home/vipidentity_pcweb.png) no-repeat;
	}

	.vip-privilege-pic-pcnative-max {
		background: url(/static/images/vip/home/vipidentity_pcnative.png) no-repeat;
	}

	</style>

{/literal}
{/block}
