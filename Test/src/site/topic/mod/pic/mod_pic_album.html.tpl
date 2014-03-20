{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-pic  {if $modData.parames.is_show_thumb==0}pic-album-nopage{/if}{/block}
{block name='mod_attr'}monkey="mod-pic{$index}"{/block}
{block name="mod_body"}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
{if $modData.data}
		{$fistData=current($modData.data)}
<div class="mod-list ">
    <div class="page-list-wrap">
        <div class="pic-album-left-btn"></div>
        <div class="pic-title">
                    <span>{$fistData.title}</span><i class="bg"></i>
                </div>
        <ul class="page-list clearfix">
            <li class="item">
                <span class="blank"></span>
                <span class="pic-img">
                    <a href=""><img  alt="{$fistData.title}" title="{$fistData.title}"  src="{$fistData.thumb_img}" /></a>
                </span>
            </li>
        </ul>
        <div class="pic-album-right-btn">
        </div>
        <div class="page-num">
            <span class="index-num">1</span>/{count($modData.data)}
        </div>
    </div>
    <div class="page-list-pic-album clearfix">
        <a href="#" class="page-prev"><i></i></a>
        <div class="page-inner">
            <ul class="clearfix">
                {foreach $modData.data as $item}
                    <li>
                        <a href="#" ><img alt="{$item.title}" title="{$item.title}" src="{$item.thumb_img}" /></a>
                    </li>
               {/foreach} 
            </ul>
        </div><a href="#" class="page-next"><i></i></a>
    </div>
</div>
{/if}
{/block}