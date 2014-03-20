
 <h2 class="name group-name">
  <span class="song-count">曲目：{count(explode(",",$tplData.all_song_ids))}首</span>  {$tplData.header_film_info.type}《{$tplData.header_film_info.title}》</h2>

    {include file="sns/film/mod_fun_btn.html.tpl" playlist =json_encode(["moduleName"=>"filmlistAdd","listid"=>"`$tplData.header_film_info.filmtv_id`","type"=>"film","title"=>"`$tplData.header_film_info.title`" ,"ids"=> "`$tplData.all_song_ids`"])}    
    {include file="widget/song_list/song_list.html.tpl" inline}
    <div class="group-list" >   
        {foreach $tplData.film_info as $item}
        {$itemTitle=$item.title|cat:$item.versions|cat:$item.session}
        <div class="list-item clearfix">
            <div class="film-cover">
                <a href="/film/{$item.filmtv_id}"  title="{$itemTitle}"  class="cover-link">
                    <img width=90 height=120 src="{$item.thumbnail|default:#FILM_COVER_DEFAULT#}"/>
                </a>
                <a href="#" title="播放" data-song = '{json_encode(["ids"=>$item.all_song_ids,"moduleName" => "filmSongBtn","listid"=>$item.filmtv_id,"logAction"=>"film_song"])}'  class="film-all-play play">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                <a href="/film/{$item.filmtv_id}" title="{$itemTitle}" class="c3">{$itemTitle|pixel_truncate:98}</a>
            </div>        
            <div class="col-song-list">
            {song_list moduleName = "filmSongList" isDisplayInedexNum = true indexWidth =35 btnPos = "none" total=count($item.song_list) songData = $item.song_list colCheck =false funIcon = ["play","add","download"] songWidth = 280  funIcon=["play","add","download"] appendix=false songType = "song_type" preAppendix=true} 

            </div>   
        </div>   
        {/foreach}                                  
    </div>


