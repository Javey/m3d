{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-pic pic-list{/block}
{block name='mod_attr'}monkey="mod-pic{$index}"{/block}
{block name="mod_body"}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
{if $modData.data}
<div class="mod-list">
  <div class="page-list-wrap">
	<ul class="page-list clearfix" id="picLightboxList">
			{foreach $modData.data as $item}
                 {if $item@first||$item@index%8==0}		
					 <li class="item">
					 	 <ul class="pic-list clearfix">
				{/if}			
					          <li>
					            <div class="pic-img"><a href="{$item.thumb_img}" title="{$item.title}"><img   class="lazyload"   org_src="{$item.thumb_img}" src="{#PIC_PLACEHOLDER#}" alt="{$item.title}" /></a></div>
					            <div class="pic-title">{$item.title|pixel_truncate:100}</div>
					          </li>
				{if $item@last||($item@index+1)%8==0}	
						 </ul>
					</li>
				{/if}
			{/foreach}
	 </ul>
  </div>
{if $modData.data|count>8}
  <div class="page clearfix">
    <div class="mod-page"> <a href="#" class="page-prev"></a> 
	{foreach $modData.data as $item}
		{if $item@index%8==0}
			<a class="page-index {if $item@index==0}page-active{/if}" href="#"></a>
		{/if}
 	{/foreach}
	<a href="#" class="page-next"></a> </div>
  </div>
{/if}
</div>
{/if}
{/block}