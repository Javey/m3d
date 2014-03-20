{extends file="module/module.html.tpl"}
{block name='mod_class'}mod-other-list{/block}
{block name='mod_attr'}monkey="otherAlbum"{/block}
{block name="mod_head"}

{**模块头部**}
{if $ownerInfo}
<a class="more" href="{user_link user=$ownerInfo}/album">更多<span>&gt;&gt;</span></a>
{/if}

<h2 class="title">{$tplData.data.album.author}的其他专辑</h2>
{/block}
{block name="mod_body"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
	<ul>
	{foreach $tplData.data.other_albums as $item}
		{if $item@index<12}

		{$pubTime = ""}
            {$pubTimes = explode('-',$item.publishtime)}
            {if $pubTimes[1] == "00" || $pubTimes[2] ==  "00"}
                {$pubTime = "`$pubTimes[0]`年"}
            {else}
                {$pubTime = $item.publishtime}
            {/if}


		<li {if $item@iteration % 6 == 0} class="album-last" {/if}>		
			{album_cover moduleName = "otherAlbum" album=$item coverStyle=true showStatus=true showNew=true}
			
			<span class="album-name"><a title="{$item.title}" href="/album/{$item.album_id}">{$item.title|pixel_truncate:90 nofilter}</a></span>

			<span class="pub-time">{if $item.publishtime && $item.publishtime != "0000-00-00"}{$pubTime}{else} <span>&nbsp;</span> {/if}</span>	
		</li>		
		{/if}
	{/foreach}
	</ul>
{/block}
