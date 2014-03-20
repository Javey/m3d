{function name=tag_left_mod data=null}
    {foreach $data as $key => $item}
    <dl class="tag-mod" monkey="t{$key}">
        <dt><div>{$item.title}</div></dt>  
        <dd class="tag-items clearfix">
        	{foreach $item.item as $subitem} 
        		<span class="tag-list clearfix">
        			{**去掉不同字体颜色 By Javey**}
        			<a href="/tag/{$subitem.title|escape:'url' nofilter}" class="tag-item {if $subitem.title_class == 'bold'}bold{/if}{if $subitem.title_class == "hot"}has-icon{/if}">{$subitem.title|pixel_truncate:80}</a>
                    {if $subitem.title_class == "hot"}<i class="icon-hot"></i>{/if}
                </span> 
        	{/foreach}
        </dd>
    </dl>
    {if !$item@last}<div class="module-dotted"></div>{/if}
    {/foreach}
{/function}
<div class="tag-main">
    <div class="mod-style clearfix">
     <h2 class="tag-cat">流派</h2><i class="icon-new"></i>

        <div class="tag-items">
            {foreach $tplData.genresList as $key=>$item}
            <span class="tag-list clearfix">
                <a href="/style/{$item.title|escape:'url' nofilter}"> {$item.title}</a>
            </span>
            {/foreach}
        </div>

    </div>
    <div class="mod-tag clearfix">
    <h2 class="tag-cat">标签</h2>
      {tag_left_mod data=$tplData.data}  
    </div>
 </div>