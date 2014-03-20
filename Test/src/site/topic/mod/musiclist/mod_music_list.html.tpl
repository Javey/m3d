{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-music-list{/block}
{block name='mod_attr'}monkey="mod-music-list{$index}"{/block}
{block name="mod_body"}
{include file="widget/song_list/song_list.html.tpl" inline}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{if $modData.parames.column_img}<img   class="lazyload"   org_src="{$modData.parames.column_img}" src="{#PIC_PLACEHOLDER#}" />{/if}
            {$modData.parames.column_content nofilter}
    	</div>
{/if}
        <div class="music-list">
        	{if $modData.mid =='10003'}
				{song_list moduleName = "songList"|cat:$modData.parames.module_id total= "100" songData=$modData.data funBtn=["play","add","collect"] 	singerWidth='70' songWidth='130' funIcon=['play','add','download']}
            {else}
				{song_list moduleName = "songList"|cat:$modData.parames.module_id total= "100" songData=$modData.data funBtn=["play","add","collect",'mobile'] funIcon=['play','add','download']}
				
			{/if}
        </div>
{if $modData.parames.column_content_buttom}
<div class="mod-info-bottom clearfix">
            {$modData.parames.column_content_buttom}
    	</div>
{/if}        
{/block}