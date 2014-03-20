{extends file="ajax.tpl"}
{block name="ajax_html"}
  {extends file="module/module.html.tpl"}
  {block name='mod_class'}recommend-kr{/block}
  {block name='mod_attr'}monkey="recommend-kr"{/block}
  {block name="mod_head"}
    <a href="/topic/cooperation/smtowncjhd?pst=hyzq" class="more">明星周边礼品免费抢<span>&gt;&gt;</span></a>
    <h2 class="title">韩语</h2>
  {/block}
  {block name="mod_body"}
    {include file="widget/mv_cover/mv_cover.html.tpl" inline}
    {include file="widget/author_list/author_list.html.tpl" inline}
    {if $tplData.data}
  <div class="kr-songlist">
   {foreach $tplData.data.koreanPlaylist as $item}
   {$ids=explode(',',$item.song_ids)}
      <div class="songlist-item clearfix {if $item@index%2==1} even{/if}">
          <div class="songlist-cover">
              <div class="col-listen">
                  <span><i></i>{number_format($item.info.listen_count)}</span>
              </div>
              <a href="/songlist/{$item.info.playlist_id}">
                  <img width="130" height="130" src="{$item.pic|default:#SONGLIST_COVER_DEFAULT_150s#}"/>
              </a>

              <div class="songlist-title">
                  <h2>{$item.info.title|pixel_truncate:160|escape:"html" nofilter}</h2>
              </div> 
              <a href="#" title="播放"
                  {$logData = "hotsl_`$item.info.playlist_id`_`$item.info.title`||plazaKrBtn"}
                 data-song='{json_encode(["ids"=>$ids,"moduleName" => $logData,
                 "listid"=>$item.info.playlist_id,"logAction"=>"play_song"])}'
                 class="songlist-all-play play"></a>
          </div>
          <div class="col-list" style="width: 180px;">
              {strip}
                  <ul class="song-list">
                      {foreach $item.song_list as $song}
                          {pixel_double_truncate
                          totalWidth = 140
                          one = ["string" => $song.title, ratio => 0.6, font => "tahoma_14"]
                          two = ["string" => $song.author, ratio => 0.4, font => "tahoma_12"]
                          ret = ret
                          }
                          {if $song@index<5}
                              <li class="clearfix">
  <span class="music-icon-hook "
        data-musicicon="{json_encode(["id"=>$song.song_id,"type"=>"song","iconStr"=>"play","moduleName"=>$logData])}">
    <a class="list-micon icon-play{if $song.bePlayed==1}-disabled{/if}" data-action="play"
       title="{if $song.bePlayed==1}因版权保护，本资源不能播放{else}播放{/if}" href="#"></a>
  </span>
<span class="song-name">
    <a href="/song/{$song.song_id}" sid="{$song.song_id}" class="song top-song-hook"
       title="{$song.title}">{$song.title|pixel_truncate:$ret.oneWidth:'tahoma_14' nofilter}</a>
</span>&nbsp;-&nbsp;<span class="singer-name">
    {author_list releaseStatus=$song.relate_status ids=$song.all_artist_ting_uid  names=$song.author width=$ret.twoWidth}
</span>
                              </li>
                          {/if}
                      {/foreach}
                  </ul>
              {/strip}
          </div>
      </div>
{/foreach}
</div>
<div class="module-dotted"></div>
    {include file="widget/mv_cover/mv_cover.html.tpl" inline}
    {include file="widget/author_list/author_list.html.tpl" inline}
<div class="kr-mv clearfix">
     {foreach $tplData.data.koreanMv as $item}
  {pixel_double_truncate
  totalWidth = 150
  one = ["string" => $item.title, ratio => 0.6, font => "tahoma_14"]
  two = ["string" => $item.author, ratio => 0.4, font => "tahoma_12"]
  ret = ret
  }     
     <div class="mv-item">
             {mv_cover data = $item lazyload=false}
            <div class="song-item">
            <span class="song-title">
            {*{song_link_url_plugin song=$item linkWithNoSongId="#" songLinkUrl=theSongLink}*}
              <a href="/playmv/{$item.mv_id}" title="{$item.title}">{$item.title|pixel_truncate:$ret.oneWidth:'tahoma_14' nofilter}</a>
            </span> -
            <span class="siger-name">
              {author_list
                source='album'
                releaseStatus=$item.relate_status
                ids=$item.ting_uid
                names=$item.author
                width=$ret.twoWidth
              }
            </span>
            </div>
            {if $item.is_new == '1' || $item.is_hot == '1'}
              <div class="mv-mark">
                {if $item.is_hot == '1'}
                  <span class="mv-icon-hot"></span>
                {else if $item.is_new == '1'}
                  <span class="mv-icon-new"></span>
                {/if}
              </div>
            {/if} 
        </div>            
        {/foreach}

</div>
<div class="module-dotted"></div>
<div class="kr-artist clearfix">
 {foreach $tplData.data.koreanArtist as $item}
        <span class="kr-name">
          {author_list  ids=$item.ting_uid  names=$item.name width=120}
        </span>
 {/foreach}
</div>
    {/if}

  {/block}

{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}
  // 通过call绑定jQuery对象来成为选择器作用域
  context = this;

  // 单曲播放和添加按钮
  $(".music-icon-hook", context).musicIcon();
    // 播放影视、 歌单歌曲
    $('.songlist-all-play', context).click(function () {
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

    // 统计播放歌单 (歌单配图上播放按钮)
    $('.songlist-all-play', context).bind('click', function () {
        var listid = $(this).data("song").listid;
        $.ajax({ url: "/data/music/songlist/listen?playlistId=" + listid + "&t=" + (new Date() * 1)});
        return false;
    });
{/block}
