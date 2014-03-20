{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-music-library{/block}
{block name='mod_attr'}monkey="mod-music-library{$index}"{/block}
{block name="mod_body"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content}
    	</div>
{/if}
{if $modData.data}
<div class="music-wall">
    <ul class="covers">
        {foreach $modData.data as $item}
        	{if $item@index<12}
		        <li>
		            <div class="cover">
		                {album_cover moduleName = "album"|cat:$modData.parames.module_id album=$item  type='large' coverStyle=true}
		            </div>
		        </li>
			{/if}
		{/foreach}
    </ul>
    <ul class="discriptions">
        {foreach $modData.data as $item}
        	 {if $item@index<12}
        <li>
            <div class="discription">
                <h3 class="title">《{$item.title}》-- {$item.author}</h3>
                <p class="content">
                    {$item.desc|gbk_truncate:190}
                </p>
            </div>
        </li>
		{/if}
		{/foreach}
    </ul>
</div>
{/if}
{/block}