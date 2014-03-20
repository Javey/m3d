{extends file="module/module.html.tpl"}
{block name='mod_class'}intro vip-detail-intro-{$type}{/block}
{block name='mod_attr'}monkey="intro"{/block}
{block name='mod_head_class'}bb-dotimg{/block}

{block name="mod_head"}
	<div class="vip-detail-header">
		{block name="detail_banner"}{/block}
	</div>
{/block}
{block name="mod_body"}
<div class="vip-privilege-block">

	{block name="detail_body"}
	<p></p>
	{/block}
</div>
{/block}