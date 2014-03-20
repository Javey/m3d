{extends file="ajax.tpl"}
{block name="ajax_html"}
  {extends file="module/module.html.tpl"}
  {block name='mod_class'}topic{/block}
  {block name='mod_attr'}monkey="topic"{/block}
  {block name="mod_head"}
    <a class="more"   href="/topic">更多<span>&gt;&gt;</span></a>
    <h2 class="title">精彩专题</h2>
  {/block}
  {block name="mod_body"}
    {include file="widget/song_list/song_list.html.tpl"}
    {if $tplData.data}
      {$lastIndex = 3}
      {foreach $tplData.data as $item}
        {$urlarr = explode('/', $item.url) }
        {if count($urlarr) > 1}
          {$url = "/diyalbum/`$item.url`"}
        {else}
          {$url = "/topic/`$item.type`/`$item.url`"}
        {/if}
        {if $item@index < $lastIndex}
          <div class="topic-list{if $item@first} topic-list-first{/if}">
            <div class="topic-cont clearfix">
              <div class="topic-cover loading"><a target="_blank" href="{$url}"><img src="{$item.pic}" alt="{$item.title}" title="{$item.title}" /></a><a target="_blank" title="播放专题" class="play { 'songIds': '{$item.all_song_ids}' }"></a> </div>
              <div class="topic-info">
                <h2 class="topic-title"><a target="_blank" href="{$url}" title="{$item.title}">{$item.title|pixel_truncate:440:'tahoma_14'}</a> </h2>
                <p class="desc topic-desc">{$item.intro|pixel_truncate:800 nofilter} <a target="_blank" href="{$url}">查看详情&gt;&gt;</a></p>
              </div>
            </div>
            {$topiclist1 = []}
            {$topiclist2 = []}
            {$topiclist3 = []}
            {foreach $item.songList as $list}
              {if $list@index < 3}
                {$a = array_push( $topiclist1, $list)}
              {elseif $list@index >= 3 &&  $list@index < 6}
                {$b = array_push( $topiclist2, $list)}
              {elseif $list@index >= 6 && $list@index < 9}
                {$c = array_push( $topiclist3, $list)}
              {/if}
            {/foreach}
            <div class="topic-song-list clearfix">
              {song_list moduleName = "topic" indexWidth="20" total=3 colIndex = false isDotted = false width="auto" numPluszero = false singerWidth=50 btnPos= "none" songWidth=108 colCheck= false songData=$topiclist1 funIcon=["play","add"] appendix=false}
              <div class="module-line songlist-spacing"></div>
              {song_list moduleName = "topic" indexWidth="20" total=3 colIndex = false isDotted = false width="auto" numPluszero = false singerWidth=50 btnPos= "none" songWidth=108 colCheck= false songData=$topiclist2 funIcon=["play","add"] appendix=false}
              <div class="module-line songlist-spacing"></div>
              {song_list moduleName = "topic" indexWidth="20" total=3 colIndex = false isDotted = false width="auto" numPluszero = false singerWidth=50 btnPos= "none" songWidth=108 colCheck= false songData=$topiclist3 funIcon=["play","add"] appendix=false}
            </div>
          </div>
          {if $item@index < $lastIndex - 1}
            <div class="module-dotted"></div>
          {/if}
        {/if}
      {/foreach}
    {else}
      <p class="no-data">很抱歉，暂无专题数据</p>
    {/if}
  {/block}
{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}
  // 通过call绑定jQuery对象来成为选择器作用域
  context = this;

  // 播放整个专题按钮
  var topicPlayBtns = $(".topic-cover .play", context);
  topicPlayBtns.click(function () {
    var me = $(this),
      metadata = me.metadata(),
      songIdsStr = metadata.songIds || "",
      songIds = songIdsStr.split(",");

     if (!songIdsStr || songIds.length <= 0)  return true;

     ting.media.playSong(songIds, {
       moduleName: "homeTopic"
     });

    return false;
  });

  // 单曲播放和添加按钮
  $(".music-icon-hook", context).musicIcon();

{/block}
