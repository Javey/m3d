{extends file="module/mod_left/mod_left.html.tpl"}
{block name='mod_class'} mod-album{/block}
{block name='mod_attr'}monkey="album"{/block}

{block name="mod_body"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
{foreach $tplData.album_list as $item}
	{if $item@index<10}
		<dl class="{if ($item@index+1)%5==0}last{/if}">
			<dt>{album_cover album=$item showStatus=true lazyload=$lazyload}</dt>
			<dd><a href="/album/{$item.album_id}" title="{$item.title}">《{$item.title|pixel_truncate:75}》</a></dd>
			<dd class="cl">{$item.publishtime}</dd>
		</dl>
		
	{/if}
{/foreach}
{/block}
