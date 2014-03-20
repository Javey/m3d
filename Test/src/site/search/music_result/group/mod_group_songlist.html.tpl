{extends file="module/module.html.tpl"}
{block name='mod_class'}group-songlist{/block}
{block name='mod_attr'}monkey="group-songlist"{/block}
{block name="mod_head"}
<h2 class="title">歌单</h2>
{/block}

{block name="mod_body"}
<ul class="group-list">
{foreach $tplData.listobject.res_array as $item}
{if $item@index<5}
<li class="group-item {if $item@index==4}group-last-item {/if}">
    {$ids = []}
    {foreach $item.song_list as $songid}
        {$idsArr = array_push($ids, $songid.song_id)}
    {/foreach}
    <div class="songlist-cover">
        <div class="col-listen">
            <span><i></i>{number_format($item.listen_count)}</span>
        </div>
        <a target="_blank"  href="/songlist/{$item.playlist_id}">
            <img width="130" height="130" org_src="{$item.cover|default:#SONGLIST_COVER_DEFAULT_150s#}" src="{#PIC_PLACEHOLDER#}" class="lazyload"/>
        </a>

        <div class="songlist-title">
            <h2>{$item.title|pixel_truncate:160|escape:"html" nofilter}</h2>
        </div>
        <a href="#" title="播放"
            {$logData = "hotsl_`$item.playlist_id`_`$item.title`||searchGroupSonglistBtn"}
           data-song='{json_encode(["ids"=>$item.song_ids,"moduleName" => $logData,
           "listid"=>$item.playlist_id,"logAction"=>"play_song"])}'
           class="songlist-all-play play"></a>
    </div>
                        　　
 </li>
 {/if}
{/foreach}
</ul>

{/block}