{extends file="module/module.html.tpl"}
{block name='mod_class'}hot-topic{/block}
{block name='mod_attr'}monkey="hot-topic"{/block}
{block name="mod_head"}
<h2 class="title">热门专题</h2>
{/block}
{block name="mod_body"}
<div class="hot-list-wrap">
		<ul class="hot-topic-list">
			
			{foreach $tplData.data.hotTopic as $item}
			{$urlarr = explode('/', $item.url) }
	    	{if count($urlarr) > 1}
	    		{$url = "/diyalbum/`$item.url`"}
			{else}
	    		{$url = "/topic/`$item.type`/`$item.url`"}
			{/if}

				<li><span class="index {if $item@index == 0}first{/if} ">{$item@index+1}.</span><a title="{$item.desc}" target="_blank" href="{$item.link}">{$item.desc|pixel_truncate:206 nofilter}</a> </li>
			{/foreach}
	</ul>
	</div>
{/block}
