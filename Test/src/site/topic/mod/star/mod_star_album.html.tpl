{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-star-album{/block}
{block name='mod_attr'}monkey="mod-stars{$index}"{/block}
{block name="mod_body"}
{include file="widget/people_icon/people_icon.html.tpl" inline}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
{if $modData.data}
        <div class="mod-list">
          <div class="page-list-wrap">
            <ul class="page-list clearfix">
			{foreach $modData.data as $item}
                 {if $item@first||$item@index%8==0}		
					 <li class="item">
					 	 <ul class="pic-list singer-album-list clearfix">
				{/if}
				{if $item@index<6}{$lazyload=false}{else}{$lazyload=true}{/if}				
					          <li>
								  <a href="/artist/{$item.artist_id}" class="star-avatar"><img   class="lazyload"  org_src="{$item.artist_img}" src="{#PIC_PLACEHOLDER#}"    alt="{$item.artist_name}" /></a>
					              <div class="pic-title clearfix"><a href="/artist/{$item.artist_id}">{$item.nick|pixel_truncate:90}</a></div>
					              <div class="star-intro">{$item.artist_intro|pixel_truncate:120}</div>
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