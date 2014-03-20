{extends file="module/module.html.tpl"}
{block name='mod_class'} mod-song-list{/block}
{block name='mod_attr'}monkey="song-list" alog-alias="song-list"{/block}
{block name="mod_head"}
<h2 class="title">曲目</h2> ( {count($songData)} )
{/block}
{block name="mod_body"}
    {include file="widget/song_list/song_list.html.tpl" inline}
    {song_list
        moduleName="filmSongList"
        colHighRate = true
        songInfo = true
        songData=$songData
        btnPos ="both"
        total = 200
        hotBar=true
        songWidth="170"
        singerWidth="140"
        indexWidth="25"
        funIcon = ["play","add","download"]
        showPic = true
        appendix = false
        colAlbum = true
        width = "auto"
        truncated = false
        albumWidth = "200"
        preAppendix = true
        songType = "song_type"
    }
{/block}


