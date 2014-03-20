{extends file="module/module.html.tpl"}
{block name='mod_class'} mod-song-list{/block}
{block name='mod_attr'}monkey="song-list" alog-alias="song-list"{/block}
{block name="mod_head"}
<h2 class="title">曲目( {count($songData)} )</h2> 
{/block}
{block name="mod_body"}
    {include file="sns/film/mod_fun_btn.html.tpl" playlist =json_encode(["moduleName"=>"filmlistAdd","listid"=>"`$tplData.film_info.filmtv_id`","type"=>"film","title"=>"`$tplData.film_info.title`" ,"ids"=> "`$tplData.all_song_ids`"])}    
    {include file="widget/song_list/song_list.html.tpl" inline}
    <div class="col-song-list" >
        {song_list
            moduleName = "filmSongList"
            isDisplayInedexNum = true
            indexWidth =25
            btnPos = "none"
            total=count($songData)
            songData = $songData
            colCheck =false
            funIcon = ["play","add","download"]
            songWidth = 240
            singerWidth = 200
            funIcon=["play","add","download"]
            appendix=false
            songType = "song_type"
            preAppendix=true
            colLosslessIcon = true
            songInfo=true

        }
    </div>
{/block}
  

