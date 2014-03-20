{extends file="ting.html.tpl"}
 
 {block name="assign"}{**用来放assign数据**} 
 {$navIndex="tag"}
 {/block}
 {block name="body_class"}
class="tag-body style-detail"
{/block}
 {block name="title"}{$tplData.title}歌曲试听，mp3下载-音乐分类{/block}
 {block name='keywords'}{$tplData.query}，音乐分类，歌曲试听，mp3下载，百度音乐{/block}
 {block name='description'}百度音乐音乐歌曲分类，为你提供最全的{$tplData.query}的歌曲列表，mp3试听，音乐下载，歌词下载{/block}

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
{block name='js-monkey-pageid'}ting-music-plaza-tag-style{/block}

{block name="content_main"}
    <h1 class="music-seo">{$tplData.query}音乐</h1>
    {**<div class="ad-banner ecom-ad ecomad-banner-loading" data-isnewad = 0 data-id ="631"></div>**}

    {include file="widget/adm/adm.html.tpl" inline}

    <div class="path_navigator">
    {path_navigator pathList=[["label"=>"音乐分类", "link"=>"/tag"], ["label"=>"{$tplData.title}"]]}
    </div>
    
    <div class="main-body">
    	<div class="main-body-cont">
          <div class="target-tag">     
             <span class="title">{$tplData.title}</span> 
             
             {button 
                str ="收听该分类电台"
                style="b"
                tagAtt ="target='_blank'"
                isRightIcon =true
                icon ="fm"
                href="{$tplData.param.fm_host}/#/channel/public_tag_{$tplData.title|escape:url}"
              }
             <span class="line"></span>
          </div>
      	  <div class="tag-main">
              <div class="mod-info">
                <p class="style-desc c6"><span class="description">{$tplData.info|gbk_truncate:200|replace:"\n":'<br />' nofilter}</span>{if strlen($tplData.info)>200}<span class="description-all">{$tplData.info|replace:"\n":'<br />'}</span> <a class="des-more-hook" href="#"><span>展开</span><i class="icon"></i></a>{/if}</p>
              </div>

              <div class="mod-artist" id="artistList">
                {include file="plaza/tag/mod_style_artist.html.tpl" inline}
              </div>

              <div class="mod-works" id="mod_works">
                  <h2 class="tilte">代表作品</h2>
                  {$worksTab =[ 
                    [
                      "link" => "#",
                      "title" => "歌曲({$tplData.song_total|default:0})",
                      "active" => 1
                    ],
                    [
                      "link" => "#",
                      "title" => "专辑({$tplData.album_total|default:0})",
                      "active" => 0
                    ]
                  ]}
                  {tab tablist = $worksTab style="middle"}  

                  <div class="music-ui-tab-body" monkey="songWork">
                      <a name="list-top"></a>
                      <div class="ui-tab-content songs-list"   id="songList">
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
                            songData=$tplData.song_list
                            total = 20
                            colHighRate = true
                          }
                        </div>
                        {page_navigator
                          total = {$tplData.song_total|default:0}
                          size  = 20
                          start = 0
                          url   = "/data/style/getsongs?title=`$tplData.title`&start=#start#&size=#size#"}
                      </div>
                      <div class="ui-tab-content albums-list" monkey="albumWork" id="albumList" style="display:none;">
                        <div class="album-list-wrap">
                        {alubm_list list=$tplData.album_list showCreator=true subChannel = true total =10 showAlbumList =true showStatus=true}
                        </div>
                        {page_navigator
                          total = {$tplData.album_total|default:0}
                          size  = 10
                          start = 0
                          url   = "/data/style/getalbums?title=`$tplData.title`&start=#start#&size=#size#"}
                      </div>
                  </div>
              </div>
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
