<div class="main-body-cont">
<div class="mod-song-info  album-detail ">
{include file="sns/album_detail/mod_album_info.html.tpl"  albumInfo="{$tplData.data.album}"}
{include file="sns/album_detail/mod_songlist.html.tpl" songData="{$tplData.data.album.songList}" title="专辑曲目({count($tplData.data.album.songList)})" funIcon=$funIcon funBtn=$funBtn}
{if $tplData.data.album.relate_status==0}
    {if is_array($tplData.data.other_albums) && count($tplData.data.other_albums) > 0}
        {include file="sns/album_detail/mod_other_album.html.tpl"}
    {/if}
{/if}
</div>

{block name="comment"}
{include file="sns/album_detail/mod_comment.html.tpl"}
{/block}
</div>
