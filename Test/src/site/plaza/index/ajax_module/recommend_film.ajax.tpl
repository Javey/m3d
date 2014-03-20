{extends file="ajax.tpl"}
{block name="ajax_html"}
  {extends file="module/module.html.tpl"}
  {block name='mod_class'}film{/block}
  {block name='mod_attr'}monkey="film"{/block}
  {block name="mod_head"}
  {** 暂时没有更多
  <a class="more"   href="/topic">更多<span>&gt;&gt;</span></a>
  **}
    <h2 class="title">热映大戏原声</h2>
    {$page = 4}
    <div class="film-focus clearfix">
      <a href="" class="left-btn"></a>
      <div class="film-focus-page">
        {include file="widget/slider_indicator/slider_indicator.html.tpl" inline}
        {slider_indicator count=floor(count($tplData.data) / $page )}
      </div>
      <a href="" class="right-btn"></a>
    </div>
  {/block}
  {block name="mod_body"}
    {include file="widget/song_list/song_list.html.tpl"}
    {if $tplData.data}
      {$lastIndex = 20}
      <div class="recommend-film-cover wrap">
        {foreach $tplData.data as $item}
          {if $item@index<20 && $item@index<floor(count($tplData.data)/$page)*$page}
            {if $item@index%4==0}
              <ul class="clearfix film-page">
              <li>
              <div class="clearfix">
            {/if}


          {if $item@index < $lastIndex}
          {if $item@index %2 == 0 && $item@index%4!=0}
            </div>
            <div class="module-dotted"></div>
            <div class="clearfix">
          {/if}
            {if $item@index % 2 == 1}{$filmListEvenClass = "even"}{else}{$filmListEvenClass = ""}{/if}
            {$filmids=explode(',',$item.all_song_ids)}
            <div class="film-list clearfix {$filmListEvenClass}">
              <div class="film-list-pic">
                {*影视入口URL迁移，有film_id则使用film/id, 没有则使用film/title/film_word 2013.9.4 wy*}
                {if $item.film_id}
                  {$filmURL = "/film/{$item.film_id}"}
                {else}
                  {$filmURL = "/film/title/{$item.film_word|escape:'url' nofilter}"}
                {/if}
                {* end *}
                <a href={$filmURL}>
                  {if $item.index < $page }
                   <img src="{$item.pic}"/>
                  {else}
                   <img org_src="{$item.pic}" src="{#PIC_PLACEHOLDER#}"  class="lazyload" />
                  {/if}
                  <a href="#" title="播放" data-song = '{json_encode(["ids"=>$filmids,"moduleName" => "plazaFilmBtn","logAction"=>"play_film"])}' class="film-all-play play"></a>
                </a>
              </div>
              <div class="film-list-title"><a href="{$filmURL}">{$item.title nofilter}</a></div>
              {song_list moduleName = "plazaFilmList" indexWidth="20" total=3 colIndex = false colSinger = false isDotted = false numPluszero = false btnPos= "none" songWidth=142 colCheck= false songData=$item.song_list funIcon=["play"] appendix=false preAppendix=true}
            </div>　　
          {/if}
            {if $item@index%4==3||$item@last}
              </div>
              </li>
              </ul>
            {/if}
          {/if}
        {/foreach}
      </div>
    {else}
      <p class="no-data">很抱歉，暂无影视数据</p>
    {/if}
  {/block}
{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}
  // 通过call绑定jQuery对象来成为选择器作用域
  context = this;

  // 初始化Slider
  new ting.Slider( $(".recommend-film-cover"), $(".film-focus") )

  // 单曲播放和添加按钮
  $(".music-icon-hook", context).musicIcon();

  //影视模块脚本
  // 播放影视、 歌单歌曲
  $('.film-all-play', context).click(function () {
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
{/block}
