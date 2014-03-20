{include file="widget/button/button.html.tpl" inline}
{include file="widget/song_list/song_list.html.tpl"}

<div id="similar-content" alog-alias="artist-similar">
    <h2>{$ownerInfo.realname|default:$ownerInfo.nick}的相似歌手</h2>
    <ul>
        {foreach $tplData.artist_list as $item}
        <li class="item-list">
            <div class="item-content {if !$item@last}bb-dotimg{/if}">
                <div class="cover-img">
                    <span class="cover">
                        <a href="/artist/{$item.ting_uid}">
                        <img width=130 height=130 alt="{$item.name}" title="{$item.name}" src="{$item.avatar_s130|default:#ARTIST_DEFAULT_130b#}"></a></span>
                </div>
                <div class="info-content">
                    <ul>
                    <li>
                        <span class="play-all-hook" data-ids="{$item.box_song_ids}" data-playdata = '{json_encode(["ids"=> $item.box_song_ids, "moduleName"=> "similiarplayhot" , "ting_uid"=>$item.ting_uid , "artist_id"=> $item.artist_id])}'>
                    {button 
                    style = "a"
                    str = "播放 <b>Ta</b> 的热门歌曲"
                    icon = "play"
                    class = " "
                    href = "#"}
                        </span>
                        <a href="/artist/{$item.ting_uid}" class="artist-name">{$item.name}</a>
                    </li>
                    <li class="c9">热度：{number_format($item.hot)}</li>
                    <li>单曲：<a href="/artist/{$item.ting_uid}">{$item.songs_total}</a> 首 {if $item.albums_total}<i class="module-line vline"></i>专辑： <a href="/artist/{$item.ting_uid}/album">{$item.albums_total}</a> 张{/if}{if $item.country}<i class="module-line vline"></i>地区：{$item.country}{/if}
                    </li>
                    <li class="info-hot-song">
                        <span class="hot-song-label">热门歌曲：</span><div class="hot-songs">
                        {song_list moduleName = "smiliar-hot-top" indexWidth="20" total=4 colIndex = false colSinger = false isDotted = false numPluszero = false btnPos= "none" songWidth=130 colCheck= false songData=$item.song_list funIcon=["play","add"] appendix=false preAppendix=true}
                        </div>
                    </li>
                    </ul>
                </div>
            </div>
        </li>
        {/foreach}
    </ul>
</div>