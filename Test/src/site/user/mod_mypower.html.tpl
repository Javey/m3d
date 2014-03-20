{extends file="module/module.html.tpl"}
{block name='mod_class'}mypower module-a {/block}
{block name='mod_attr'}monkey="mypower" {/block}
{block name="mod_head"}
{**模块头部**}
<a href="/home/vip" class="more">查看特权说明<span>&gt;&gt;</span></a>
<h4 class="title">我的特权</h4>
{/block}

{block name="mod_body"}

<div class="mypower-list">
	{if $tplData.data.serviceinfo.cloud}
	    <p class="tips c9">您是{if $userStatus == 'goldVip'}白金{/if}VIP会员，具有以下特权</p>
	{/if}
	<ul class="clearfix">
		{if $tplData.data.serviceinfo.cloud}
			{foreach $power_list_config.vip.list as $item}
				<li>
					<a href="{$item.href}"><i title="{$item.title}" class="power-icon-max power-icon-{$item@key}-max"></i></a>
					<div class="power-name">
						<a href="/home/vip/{$item@key}">{$item.title}</a>
					</div>
				</li>
			{/foreach}
            {if $userStatus == 'goldVip'}
                {foreach $power_list_config.gold.list as $item}
                    <li>
                        <a href="{$item.href}"><i title="{$item.title}" class="power-icon-max power-icon-{$item@key}-max"></i></a>
                        <div class="power-name">
                            <a href="/home/vip/{$item@key}">{$item.title}</a>
                        </div>
                    </li>
                {/foreach}
            {/if}
            {foreach $more as $item}
                <li>
                    <i title="{$item.title}" class="power-icon-max power-icon-{$item@key}-max"></i>
                    <div class="power-name">
                        {$item.title}
                    </div>
                </li>
            {/foreach}
		{else}
			{foreach $power_list_config.free.list as $item}
				<li><a href="/home/vip/{$item@key}"><i title="{$item.title}" class="power-icon-max power-icon-{$item@key}-max"></i> 
					<div class="power-name">
						<a href="/home/vip/{$item@key}">{$item.title}</a>
						
					</div>
				</li>
			{/foreach}
		{/if}
		
	</ul>
	{if $tplData.data.serviceinfo.cloud}
	<div class="opera">
        {$button = $userStatusConfigure[$userStatus]['button']}
        {$href = $button['href']}
        {if $href}
            {$href = $href|cat:'&pst=pay_userbelow'}
        {/if}
        {button
            str = $button['str']
            style = $button['style']|default:'f'
            href = $href
            class = $button['class']|default:'f20'
            width = $button['width']|default:155
            family = $button['family']|default:true
        }
        {$link = $userStatusConfigure[$userStatus]['link']}
        {if $link}
            <div><a href="{$link['href']|cat:'&pst=pay_userup'}" title="{$link['title']}">{$link['text']}</a></div>
        {/if}
	</div>
	{/if}
</div>

{if !$tplData.data.serviceinfo.cloud}
	<div class="vip-wrap">
	<div class="t clearfix">
		<div class="tl"></div>
		<div class="tr"></div>
		<div class="x  tx"></div>
	</div>
	<div class="body">
		<div class="content">
			<div class="mypower-list">
				{if !$tplData.data.serviceinfo.cloud}
					<p class="tips"><a href="/home/payment/cloud?pst=pay_usermiddle">开通VIP会员</a> 获得以下更高权利使用权</p>
				{/if}
				<ul class="clearfix">
                    {foreach $power_list_config.vip.list as $item}
                        <li>
                            <a href="{$item.href}"><i title="{$item.title}" class="power-icon-max power-icon-{$item@key}-max"></i></a>
                            <div class="power-name">
                                <a href="/home/vip/{$item@key}">{$item.title}</a>
                            </div>
                        </li>
                    {/foreach}
                    {foreach $power_list_config.gold.list as $item}
                        <li>
                            <a href="{$item.href}"><i title="{$item.title}" class="power-icon-max power-icon-{$item@key}-max"></i></a>
                            <div class="power-name">
                                <a href="/home/vip/{$item@key}">{$item.title}</a>
                            </div>
                        </li>
                    {/foreach}
                    {foreach $more as $item}
                        <li>
                            <i title="{$item.title}" class="power-icon-max power-icon-{$item@key}-max"></i>
                            <div class="power-name">
                                {$item.title}
                            </div>
                        </li>
                    {/foreach}
			    </ul>
                {if !$tplData.data.serviceinfo.cloud}
                    <div class="opera">
                        {$button = $userStatusConfigure[$userStatus]['button']}
                        {$href = $button['href']}
                        {if $href}
                            {$href = $href|cat:'&pst=pay_userbelow'}
                        {/if}
                        {button
                            str = $button['str']
                            style = $button['style']|default:'f'
                            href = $href
                            class = $button['class']|default:'f20'
                            width = $button['width']|default:155
                            family = $button['family']|default:true
                        }
                        {$link = $userStatusConfigure[$userStatus]['link']}
                        {if $link}
                            <div><a href="{$link['href']|cat:'&pst=pay_userup'}" title="{$link['title']}">{$link['text']}</a></div>
                        {/if}
                    </div>
                {/if}
			</div>
		</div>
	</div>
	<div class="b clearfix">
		<div class="bl"></div>
		<div class="br"></div>
		<div class="x bx"></div>
	</div>

</div>
{/if}




{/block}
