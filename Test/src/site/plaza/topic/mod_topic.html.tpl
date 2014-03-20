{if $tplData.focusPic}
<div class="focus" monkey = "focus" id="focus">
	<div class="focus-info-inner">
		<div class="focus-pos-info">
		{foreach $tplData.focusPic as $item}
			<div class="focus-desc" {if $item@index != 0 } style="display:none;" {/if}>
			<div>
				 {$item.desc nofilter}
			</div>
			{if $item.song_lists}
			<div class="songlist">
				{include file="widget/song_list/song_list.html.tpl" inline}
				{song_list moduleName="topicfocus" total = 5 colIndex = false colCheck =false songData = $item.song_lists btnPos = "none"  funIcon=["play","add"] singerWidth=50  songWidth=100 isDotted =false appendix=false}
			</div>
			{/if}
			<div class="bg"></div>
		</div>
		{/foreach}
		</div>
		<div class="focus-info-wrap clearfix">
			{foreach $tplData.focusPic as $item}
			<div class="focus-info">
				<div class="foucs-img">
					<span class="loading"></span>
					<a href="{$item.url}"><img class="lazyload" org_src= "{$item.banner}" src="{#PIC_PLACEHOLDER#}" alt="{$item.desc}" /></a>
				</div>
			</div>
			{/foreach}
		</div>
	</div>
	<div class="focus-scroll">
		<a hidefocus=true href="" class="focus-left-btn"></a>
			<div class="focus-tab">
			<ul class="clearfix">
				{if $tplData.focusPic}
			{foreach $tplData.focusPic as $item}
				<li><a href=""  class="{if $item@index == 0} active{/if}  loading  "  ><span></span> <img class="lazyload" org_src="{$item.thumb}" src="{#PIC_PLACEHOLDER#}" alt="{$item.desc}"></a> </li>
				{/foreach}
				{/if}
			</ul>
		</div>
		<a hidefocus=true href="" class="focus-right-btn"></a>
	</div>
</div>
{/if}

{foreach $tplData.categoryList as $item}
{if count($item.data)}
<div class="topic-cate module" monkey="cate-list">
	<div class="head clearfix">
		<a href="/topic/type/{$item.special_type_eng}" class="more">更多&gt;&gt;</a>
		<h2>{$item.name}</h2>
	</div>
	<div class="cate-list">
		<ul class="clearfix">
			{foreach $item.data as $list}
			{$urlarr = explode('/', $list.url) }
          {if count($urlarr) > 1}
            {$url = "/diyalbum/`$list.url`"}
          {else}
            {$url = "/topic/`$list.type`/`$list.url`"}
          {/if}
          {if $list@index < 8 }
			 <li>
				<a href="{$url}"><img class="lazyload" org_src="{$list.thumb_img}" src ="{#PIC_PLACEHOLDER#}" alt="{$list.song_ids}"> </a>
				<a href="{$url}">{$list.song_ids|default:$list.intro|pixel_truncate:360 nofilter}</a>
			 </li>
			 {/if}
			 {/foreach}

		</ul>
	</div>
</div>
{/if}
{/foreach}
