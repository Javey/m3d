{extends file="module/module.html.tpl"}
{block name='mod_class'}fm{/block}
{block name='mod_attr'}monkey="fm"{/block}
{block name="mod_head"}

{**模块头部**}
<a class="more" target="_blank" href="http://fm.baidu.com/#/view/channels">更多频道<span>&gt;&gt;</span></a>
<h2 class="title">百度随心听</h2>
{/block}

{block name="mod_body"}
<div class="module-fm">
		<div class="fm-info"  {if $tplData.radioLink.pic} style="background:none;" {/if}>
			<a class="open-fm" target="_blank" href="http://fm.baidu.com/?from=music_bn">
				{if $tplData.radioLink.pic}<img class="lazyload" src="{#PIC_PLACEHOLDER#}" org_src="{$tplData.radioLink.pic}">{/if}
			</a>
			<p class="fm-list">{foreach $tplData.radioLink.data as $item}<a target="_blank" href="{$item.link}">{$item.title|pixel_truncate:48}</a>{if !$item@last}<i class="module-line"></i>{/if}{/foreach}</p>

			{**
			<ul class="fm-list clearfix">
				{foreach $tplData.radioLink.data as $item}
				<li><a target="_blank" href="{$item.link}">{$item.title|pixel_truncate:48}</a> {if !$item@last}<i class="module-line"></i> {/if}</li>
				{/foreach}
			</ul>
			**}
		</div>
</div>

{/block}








