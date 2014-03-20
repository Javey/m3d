{extends file="ting.html.tpl"}
 
 {block name="assign"}{**用来放assign数据**} 
 {**$navIndex="tag"**}
 {/block}
 {block name="body_class"}
class="tag-body explore-detail"
{/block}
 {block name="title"}{$tplData.keyword}歌曲试听，mp3下载-音乐分类{/block}
 {block name='keywords'}{$tplData.keyword}，音乐分类，歌曲试听，mp3下载，百度音乐{/block}
 {block name='description'}百度音乐音乐歌曲分类，为你提供最全的{$tplData.keyword}的歌曲列表，mp3试听，音乐下载，歌词下载{/block}

{block name="import" append}

{include file="widget/song_list/song_list.html.tpl" inline}
{include file="widget/album_list/album_list.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/path_navigator/path_navigator.html.tpl" inline}
{include file="widget/tab/tab.html.tpl" inline}
{/block}

{block name="css"}

<link rel="stylesheet" type="text/css" href="/static/css/mv_tag.css{*version file='/static/css/mv_tag.css' prefix='?' suffix='.css'*}" />
 {/block}	

{block name="js" append}
<script type="text/javascript" src="/static/js/tag.js{*version file='/static/js/tag.js' prefix='?' suffix='.js'*}"></script>

<script type="text/javascript">
  {if $tplData.param.start}{$start = $tplData.param.start}{else}{$start = 0}{/if}
  $('.song-list-hook').songList({
      start:{$start}
  });
    $(".ecom-ad").ecomad();
    // createClickMonkey("ting-music-plaza-tag-style");
</script>
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-explore-style{/block}

{block name="content_main"}
    <h1 class="music-seo">{$tplData.keyword}音乐</h1>
    {**<div class="ad-banner ecom-ad ecomad-banner-loading" data-isnewad = 0 data-id ="631"></div>**}

    {include file="widget/adm/adm.html.tpl" inline}

    
    <div class="main-body">
    	<div class="main-body-cont">
          <div class="target-tag">     
             <span class="title">{$tplData.keyword}</span> 
             <span class="line"></span>
          </div>
      	  <div class="tag-main">

                        <div class="song-list-wrap">
                          {song_list 
                            btnPos="both"
                            colIndex=true 
                            colAlbum=true 
              songInfo=true
                            indexWidth="25" 
                            songWidth="162" 
                            singerWidth="120" 
                            albumWidth="130" 
                            funIcon=["play","add","download"]
                            funBtn=["play","add", "collect","down"] 
                            songData=$tplData.songList
                            total = 50
                            colHighRate = true
                          }
                        </div>
                        {page_navigator
                          total = {$tplData.param.total|default:0}
                          size  = $tplData.param.size
                          start = $tplData.param.start
                          url   = "/explore/{$tplData.keyword}?start=#start#&size=#size#"}                        
          </div>
       </div>
    </div>

    <div class="sidebar">   	   
        {include file="widget/adm/adm.html.tpl" inline}
        <div class="ad">{adm id = "599132" width = "200" height = "200" tagAtt=" style='margin:0 auto;width:200px;'" }</div>
        <div class="ad">{adm id = "622957" width = "200" height = "200" tagAtt=" style='margin:0 auto;width:200px;'" }</div>
        <div class="ad">{adm id = "600777" width = "200" height = "130" tagAtt=" style='margin:0 auto;width:200px;'" }</div>
        {if $tplData.tagLinks|@count > 0}
        {include file="plaza/tag/mod_topic.html.tpl" inline}
        {/if}
        {**
        <div class="mobile-guide clearfix">
            <div class="mobile-icon"></div>
            <p class="c9">手机或Pad访问更快捷 <br />music.baidu.com</p>
        </div>
        **}
    </div>

{/block}
