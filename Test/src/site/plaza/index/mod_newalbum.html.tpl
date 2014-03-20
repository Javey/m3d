{extends file="module/module.html.tpl"}
{block name='mod_class'}new-album{/block}
{block name='mod_attr'}monkey="new-album" id="newAlbum"{/block}
{block name="mod_head"}
{include file="widget/album_cover/album_cover.html.tpl" inline}

{**模块头部**}
<h2 class="title">新碟<strong>首发</strong></h2>
{**{$newAlbumTab =[ 
	[
		"link" => "/album/recommend?order=time&style=all",
		"title" => "推荐",
          "active" => true
	],
	[
		"link" => "/album/cn?order=time&style=all",
		"title" => "华语"
	],
	[
		"link" => "/album/jpkr?order=time&style=all",
		"title" => "日韩"
	],
	[
		"link" => "/album/western?order=time&style=all",
		"title" => "欧美"
	]
]}
{tab tablist = $newAlbumTab}**}
{$page = 6}
<div class="newalbum-focus clearfix">
     <a href="" class="left-btn"></a>
     <div class="newalbum-focus-page">
          {foreach $tplData.firstRelease as $item}
          {if $item@index % $page  == 0}
               {if $item@first} 
                    {$className = "page-active"}
               {elseif $item@index ==  count($tplData.firstRelease) - $page }
                    {$className = "page-index-last"}
               {else}
                    {$className = ""}
               {/if}
          <a href="" class="page-index {$className}"></a>
          {/if}
          {/foreach}
     </div>
     <a href="" class="right-btn"></a>
</div>
{*{adm id="652790" width="200" height="20" class="new-album-ad"}*}
  <div class="new-album-ad" style="width: 200px;height: 20px;" id="adm-new-album"></div>
  <a href="/album/shoufa?order=time&style=all" class="more">更多<span>&gt;&gt;</span></a>
{/block}


{block name="mod_body"}
{include file="widget/author_list/author_list.html.tpl" inline}
  <div class="new-album-list">
    <ul>
      {foreach $tplData.firstRelease as $item}
      {if $item@index % $page  == 0 && !$item@first}
    </ul>
    <ul>
      {/if}
      {if $item@index  < $page }{$lazyload = false}{else}{$lazyload = true}{/if}
      <li {if $item@index % $page  == $page-1}class="last-album"{/if}>
        {album_cover moduleName = "newAlbum" album=$item showStatus=true lazyload = $lazyload  coverStyle=true imgisBlank = true}
        <div class="album-name"><a title="{$item.title}" href="/album/{$item.album_id}"><span>{$item.title|pixel_truncate:83 nofilter}</span></a>
        </div>
        <div class="singer-name"
             data-title="{$item.author}">{author_list source='album' releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid  names=$item.author width=75}</div>
      </li>
      {/foreach}
    </ul>
  </div>
{**
{album_cover album=$item showStatus=true lazyload=$lazyload type='large' coverStyle=true}
**}
{**
{author_list ids=$item.all_artist_ting_uid  names=$item.author width=100}
**}
{/block}
