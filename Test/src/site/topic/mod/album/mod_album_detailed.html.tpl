{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-album-detailed{/block}
{block name='mod_attr'}monkey="mod-album-detailed{$index}"{/block}
{block name="mod_body"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
{include file="widget/author_list/author_list.html.tpl" inline}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
{if $modData.data}
        <div class="mod-list">
          <div class="page-list-wrap">
            <ul class="page-list album-detailed-list clearfix">
			{foreach $modData.data as $item}
                 {if $item@first||$item@index%2==0}		
					 <li class="item">
					 	 <ul class=" clearfix">
				{/if}
				{if $item@index<6}{$lazyload=false}{else}{$lazyload=true}{/if}				
					          <li> 
					              {album_cover moduleName = "album"|cat:$modData.parames.module_id album=$item}
					              <div class="album-title"><a href="/album/{$item.album_id}">{$item.title|pixel_truncate:114}</a></div>
					              <div class="singer-name">{author_list  releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid names=$item.author width=110}</div>
                                  <div class="album-time">{$item.publishtime}</div>
                                  <div class="album-info">{$item.desc|pixel_truncate:1200}</div>
					          </li>
				{if $item@last||($item@index+1)%2==0}	
						 </ul>
					</li>
				{/if}
			{/foreach}		  
          </ul>
          </div>
		{if $modData.data|count>2}
		  <div class="page clearfix">
		    <div class="mod-page"> <a href="#" class="page-prev"></a> 
			{foreach $modData.data as $item}
				{if $item@index%2==0}
					<a class="page-index {if $item@index==0}page-active{/if}" href="#"></a>
				{/if}
		 	{/foreach}
			<a href="#" class="page-next"></a> </div>
		  </div>
		{/if}
    </div>
    {/if}
{/block}