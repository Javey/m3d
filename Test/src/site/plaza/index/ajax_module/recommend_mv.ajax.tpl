{extends file="ajax.tpl"}
{block name="ajax_html"}
  {extends file="module/module.html.tpl"}
  {block name='mod_class'}recommend-mv{/block}
  {block name='mod_attr'}monkey="recommend-mv"{/block}
  {block name="mod_head"}
    <a href="/mv" class="more">更多<span>&gt;&gt;</span></a>
    <h2 class="title">推荐MV</h2>
    {$page = 8}
    <div class="mv-focus clearfix">
      <a href="" class="left-btn js-slider-left"></a>
      <div class="mv-focus-page js-slider-indicator">
        {include file="widget/slider_indicator/slider_indicator.html.tpl" inline}
        {$count = ceil(count($tplData.data) / $page )}
        {slider_indicator count=$count}
      </div>
      <a href="" class="right-btn js-slider-right"></a>
    </div>
  {/block}
  {block name="mod_body"}
    {include file="widget/mv_cover/mv_cover.html.tpl" inline}
    {include file="widget/author_list/author_list.html.tpl" inline}
    {if $tplData.data}
      <div class="recommend-mv-cover wrap">
        <ul class="clearfix">
          {foreach $tplData.data as $item}
          {if $item@index < $count * $page }
          {if $item@index % $page  == 0 && !$item@first}
        </ul>
        <ul>
          {/if}

          {pixel_double_truncate
          totalWidth = 142
          one = ["string" => $item.title, ratio => 0.6, font => "tahoma_14"]
          two = ["string" => $item.author, ratio => 0.4, font => "tahoma_12"]
          ret = ret
          }
          <li>
            {mv_cover data = $item lazyload=!($item@index < $page)}
            <div class="song-item">
    				<span class="song-title">
						{song_link_url_plugin song=$item linkWithNoSongId="/search?key=`$item.title`"  songLinkUrl=theSongLink}
              <a href="{$theSongLink}" title="{$item.title}">{$item.title|pixel_truncate:$ret.oneWidth:'tahoma_14' nofilter}</a>
    				</span>
              <span class="module-line hor-line"></span>
    				<span class="siger-name">
    					{author_list source='album' releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid  names=$item.author width=$ret.twoWidth}
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

          </li>
          {/if}{/foreach}
        </ul>
      </div>

    {/if}

  {/block}

{/block}

{block name="ajax_css"}

{/block}

{block name="ajax_js"}
  // 通过call绑定jQuery对象来成为选择器作用域
  context = this;

  // 初始化Slider
  new ting.Slider($(".recommend-mv-cover"), $(".mv-focus"))

  // 单曲播放和添加按钮
  //$(".music-icon-hook", context).musicIcon();

{/block}
