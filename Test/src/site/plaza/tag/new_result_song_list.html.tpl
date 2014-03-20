{include file="widget/song_link_url/song_link_url.html.tpl"}
{include file="widget/music_icon/music_icon.html.tpl"}
{include file="widget/song_list/fun_btn.html.tpl"}
{include file="widget/author_list/author_list.html.tpl" inline=true}
{include file="widget/song_list/search_song_list.html.tpl" inline}

{function name="new_result_song_list" data=null allIDs=null}
  <style type="text/css">
    .join-container {
    }
    .join-info {
      float: left;
      width: 140px;
    }
    .join-info .play-album .inner{
      width: 100px;
    }
    .join-song{
      float: left;
      width: 570px;
    }
    .join-container .song-list{
      padding: 0;
    }
    .join-title{
      font-size: 14px;
      font-weight: bold;
    }
  </style>
  <div class="join-operation" data-ids="{$allIDs}">
  {fun_btn btnArray=["play","add", "collect","down"] btnStatus = "active"
    btnStr = [
      "play" => "播放全部歌曲",
      "add" => "加入播放列表",
      "collect" => "收藏",
      "down" => "批量下载 <i class='power-icon-min power-icon-vipidentity-active'></i>"
    ]
  }
  </div>
  {foreach $data as $album}
    {$isAlbum = $album.is_album}
    <div class="join-container{if $isAlbum} join-album{/if} clearfix">
      <div class="module-dotted"></div>
      <div class="join-info">
        {if $isAlbum}
          {if $album.album_info.title}
          <div class="join-title">{$album.album_info.title}</div>
          {else}
          <div class="join-title">专辑</div>
          {/if}
          <img src="{$album.album_info.pic_big|default:#SONGLIST_COVER_DEFAULT_150s#}" width="130" height="130" alt="{$album.album_info.title}"/>
          {* S播放专辑按钮 *}
          <span class="play-album" data-ids="{$album.song_ids}">
            <a class="btn btn-a" href="#">
              <span class="inner">
                <span class="txt">播放专辑</span>
              </span>
            </a>
          </span>
          {* E播放专辑按钮*}
        {else}
          <div class="join-title">单曲</div>
        {/if}
      </div>
      <div class="join-song">
        {search_song_list truncated=false
        colIndex=false
        colCheck=false
        colAlbum=false
        songInfo = true
        songWidth="250"
        singerWidth="120"
        funIcon=["play","add","download"]
        funBtn=false
        songData=$album.data
        moduleName="tagList"|cat:$tagStyle
        colHighRate=true
        }
      </div>
    </div>
  {/foreach}
{/function}
