<div id="search-rec-movie">
  {$items = $tplData.movieobject.res_array}
  {if count($items) > 2}
    <div class="clearfix" id="film-change"><a href="javascript:void(0)" class="pull-right right-btn">换一批</a></div>
  {/if}
  <div id="rec-movie-list">
    <ul class="group">
      <div class="clearfix">
        {foreach from=$tplData.movieobject.res_array key=i item=item}
        {if $i%2==0 && $i!=0}
      </div>
    </ul>
    <ul class="group">
      <div class="clearfix">
        {/if}
        <div class="film-list clearfix{if $i%2==1} even{/if}">
          <div class="film-list-pic">
            <a href="/film/{$item.filmtv_id}" target="_blank">
              <img src="{$item.pic1|default:#FILM_COVER_DEFAULT#}"/>
            </a>
            <a href="#" title="播放" data-song = '{json_encode(["ids"=>$item.song_ids,"moduleName" => "plazaFilmBtn","logAction"=>"play_film"])}' class="rec-film-all-play play"></a>
          </div>
          <div class="film-list-title">
            <a href="/film/{$item.filmtv_id}" title="{$item.title}">{$item.title|pixel_truncate:170}</a>
          </div>
          {include file="widget/song_list/song_list.html.tpl"}
          {song_list moduleName = "plazaFilmList" indexWidth="20" total=3 colIndex = false colSinger = false isDotted = false numPluszero = false btnPos= "none" songWidth=122 colCheck= false songData=$item.songs funIcon=["play"] appendix=false preAppendix=true}
        </div>
        {/foreach}
      </div>
    </ul>
  </div>
</div>