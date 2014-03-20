{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-album{/block}
{block name='mod_attr'}monkey="mod-alubm{$index}"{/block}
{block name="mod_body"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
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
                 {if $item@first||$item@index%10==0}		
					 <li class="item">
					 	 <ul class="pic-list singer-album-list clearfix">
				{/if}
				{if $item@index<6}{$lazyload=false}{else}{$lazyload=true}{/if}				
					          <li>
					              {album_cover moduleName = "album"|cat:$modData.parames.module_id album=$item}
					              <div class="pic-title"><a href="/album/{$item.album_id}">{$item.title|pixel_truncate:90}</a></div>
					              <div class="pub-time">{$item.publishtime}</div>
					          </li>
				{if $item@last||($item@index+1)%10==0}	
						 </ul>
					</li>
				{/if}
			{/foreach}		  
          </ul>
          </div>
		{if $modData.data|count>10}
		  <div class="page clearfix">
		    <div class="mod-page"> <a href="#" class="page-prev"></a> 
			{foreach $modData.data as $item}
				{if $item@index%10==0}
					<a class="page-index {if $item@index==0}page-active{/if}" href="#"></a>
				{/if}
		 	{/foreach}
			<a href="#" class="page-next"></a> </div>
		  </div>
		{/if}
    </div>
    {/if}
{/block}