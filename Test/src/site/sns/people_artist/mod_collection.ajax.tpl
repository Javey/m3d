{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/album_cover/album_cover.html.tpl" inline}
{include file="widget/diy_cover/diy_cover.html.tpl" inline}
{include file="widget/song_column/song_column.html.tpl" inline}
{include file="widget/people_name/people_name.html.tpl" inline}
{if  $tplData.collection_song_list}
<h4>单曲</h4>
{song_column songList=$tplData.collection_song_list}
{/if}
{if  $tplData.collection_album_list}
<div class="collection-split bb-dotimg"></div>
<h4>专辑</h4>

<ul class="collection-album-list clearfix">
{foreach $tplData.collection_album_list as $album}
    <li class="album-list {if $album@last}last-item{/if}">
    	{if $album.fav_type=='album'}
    	{album_cover album=$album}<p  class="tac"><a href="/album/{$album.album_id}">《{$album.title|pixel_truncate:78}》</a></p><p  class="tac">{people_name people=["is_musicer"=>1,"nick"=>$album.author,"ting_uid"=>$album.artist_ting_uid]}</p>
		{/if}
		</li>
{/foreach}
</ul>
{/if}
{if $tplData.collection_song_list||$tplData.collection_album_list}
<div>
<a class="fr mb10p" href="/artist/{$tplData.owner_user_id}/collection">更多收藏&nbsp;&nbsp;>></a>
</div>
{else}
<div class="no-data">
                    Ta还没收藏过。
</div>
{/if}
{/block}

{block name="ajax_css"}

{/block}


{block name="ajax_js"}
var me=this;
$(".music-icon-hook",me).musicIcon();
$(".diy-cover-hook",me).diyCover();
$(".album-cover-hook",me).albumCover();
ting.LL.add($(".lazyload",this));	
{/block}
