{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-other-topics{/block}
{block name='mod_attr'}monkey="mod-other-topics{$index}"{/block}
{block name="mod_body"} 
			<div class="other-list-wrap">
				<ul class="other-list">
				{foreach $modData.data as $item}
					
					{if $item@index<3 && $item.special_img}
							{$imglist = true}
							{$truncate = 160}
					{else}
							{$imglist = false}
							{$truncate = 210}
					{/if}	

					<li class=" {if $imglist} img-list {/if} "><a href="{$item.link}">{if $imglist}<img class="lazyload" org_src="{$item.special_img}" src="{#PIC_PLACEHOLDER#}"  />{/if}{$item.title|pixel_truncate:$truncate nofilter}</a> </li>
				{/foreach}
				</ul>

			</div>










            {**
			<div class="longitudinal-list">
              {foreach $modData.data as $item}
              <dl class="clearfix item ">
                <dt><a href="{$item.link}" title="{$item.title}"><img   class="lazyload"  org_src="{$item.special_img}" src="{#PIC_PLACEHOLDER#}"  alt="{$item.title}" /></a></dt>
                <dd> <a href="{$item.link}">{$item.title}</a> </dd>
                <dd>{$item.desc}</dd>
              </dl>
              {/foreach}
            </div>
            **}
{/block}