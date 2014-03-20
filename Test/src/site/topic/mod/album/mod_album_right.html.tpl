{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-other-albums{/block}
{block name='mod_attr'}monkey="mod-other-albums{$index}"{/block}
{block name="mod_body"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
{if $modData.data}
<div class="longitudinal-list">
{foreach $modData.data as $item}
<dl class="clearfix item">
    <dt>
        {album_cover moduleName = "album"|cat:$modData.parames.module_id album=$item}
    </dt>
    <dd>
        <a href="/album/{$item.album_id}">{$item.title}</a>
    </dd>
    <dd>发行时间：{$item.publishtime}</dd>
</dl>
{/foreach}
</div>
{/if}
{/block}