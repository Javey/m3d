<style type="text/css" target="../../../search.css">
  #search-rec-movie {
    position: relative;
    width: 100%;
    overflow: hidden;
    padding-bottom: 20px;
  }
  #rec-movie-list {
    position: relative;
    width: 5000px;
  }
  #rec-movie-list .group{
    float: left;
    width: 710px;
  }
  #film-change .right-btn{
    margin-right: 5px;
  }
  .film-list {
    display: inline-block;
    float: left;
    width: 328px;
    height: 120px;
    overflow: hidden;
  }
  .film-list.even{
    float: right;
  }
  .film-list img {
    width: 90px;
    height: 120px;
    display: inline-block;
  }
  .film-list-pic {
    float: left;
    position: relative;
    width: 90px;
    height: 120px;
    margin-right: 20px;
  }
  .film-list-title {
    float: left;
    margin-bottom: 10px;
    font-size: 14px;
    font-weight: bold;
  }
  .film-list-title a {
    color: #333;
  }

  .film-list-pic .play{
    position: absolute;z-index:2; right:8px;bottom: 8px; width:32px;height:31px; cursor: pointer;
	  background:url(/static/images/music/album-cover-play.png) no-repeat;
    merge:bg;
	  _background: none;
	  _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='corp',src='/static/images/music/album-cover-play.png');
  }
  .film-list-pic .play:hover{
    bottom:7px;right:7px;width:34px;height:33px;
	  background:url(/static/images/music/album-cover-play-hover.png) no-repeat;
    merge:blue;
	  _background: none;
	  _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='corp',src='/static/images/music/album-cover-play-hover.png');
  }

  #rec-movie-list .song-list {
    float: left;
    width: 210px;
    padding-top: 0;
    clear: none;
  }
  #rec-movie-list .song-list ul li {
    padding: 2px 0;
  }
  #rec-movie-list .song-list .song-item{
    padding-left: 0;
  }
</style>
<script type="text/javascript" target="../../../search.js">
  $('#film-change').on('click', function(){
    require.config({
      baseUrl: '/static/js/require',
//      urlArgs: "bust=" + (new Date()).getTime(),
      paths: {
        'slider': 'slider/slider'
      }
    });

    require(['slider'], function(Slider){
      new Slider($('#rec-movie-list'), $('#film-change'), 250 ,'changeRight');
    });

    // remove init event
    $(this).off('click');
  });

  // 单曲播放和添加按钮
  $(".music-icon-hook").musicIcon();

  // 全部播放 播放影视
  $('.rec-film-all-play').click(function () {
    var self = $(this),
      conf = self.data("song"),
      ids = conf.ids,
      opt = {
        moduleName: conf.moduleName
      },
      action = conf.logAction;

    ting.media.playSong(ids, opt);
    self.tip().tip("tipup", {
      msg: "已开始播放",
      iconClass: "tip-success"
    });

    /* 点击统计 start by lutaining */
    if (ting && ting.logger && ting.logger.plogClick) {
      ting.logger.plogClick(action);
    }

    /* 点击统计 end by lutaining */
    //bdbrowser effect
    if (ting.browser.isSpecial()) {
      ting.browser.add2box('play');
    }
    return false;
  });
</script>
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