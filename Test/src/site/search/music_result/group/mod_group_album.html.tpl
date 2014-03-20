{extends file="module/module.html.tpl"}
{block name='mod_class'}group-album{/block}
{block name='mod_attr'}monkey="group-album"{/block}
{block name="mod_head"}
<h2 class="title">专辑</h2>
{/block}

{block name="mod_body"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
<ul class="group-list">
{foreach $tplData.albumobject.res_array as $item}
{if $item@index<6}
<li class="group-item {if $item@index==5}group-last-item {/if}">
        {album_cover moduleName = "newAlbum" linkBlank=true album=$item showStatus=true  lazyload = $lazyload  coverStyle=true}
        <div class="album-name"><a title="{$item.title}" target="_blank" href="/album/{$item.album_id}"><span>{$item.title|pixel_truncate:83 nofilter}</span></a>
        </div>
        <div class="singer-name"
             data-title="{$item.author}">{author_list source='album' releaseStatus=$item.relate_status   target="_blank" redirect=true  ids=$item.all_artist_ting_uid  names=$item.author width=75}</div>
 </li>
 {/if}
{/foreach}
</ul>

{/block}