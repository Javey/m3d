{extends file="module/module.html.tpl"}
{block name='mod_class'}group-mv{/block}
{block name='mod_attr'}monkey="group-mv"{/block}
{block name="mod_head"}
<h2 class="title">MV</h2>
{/block}

{block name="mod_body"}
{include file="widget/mv_cover/mv_cover.html.tpl" inline}
<ul class="group-list">
{foreach $tplData.mvobject.res_array as $item}
{if $item@index<4}
  {pixel_double_truncate
  totalWidth = 142
  one = ["string" => $item.title, ratio => 0.6, font => "tahoma_14"]
  two = ["string" => $item.author, ratio => 0.4, font => "tahoma_12"]
  ret = ret
  }
<li class="group-item {if $item@index==3}group-last-item {/if}">
    {mv_cover data=$item showMvData=true showPlayIcon=false showMVIcon=false}
    <div class="song-item">
				{song_link_url_plugin song=$item linkWithNoSongId="#" songLinkUrl=theSongLink}
      <a href="{$theSongLink}"  target="_blank"  title="{$item.title}">{$item.title|pixel_truncate:$ret.oneWidth:'tahoma_14' nofilter}</a>
      -
				{author_list source='album' releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid  target="_blank"   names=$item.author width=$ret.twoWidth}
    </div>
 </li>
 {/if}
{/foreach}
</ul>

{/block}