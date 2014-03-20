{extends file="ting.html.tpl"}
 
 {block name="assign"}{**用来放assign数据**} 
 {$navIndex="tag"}
 {/block}
 {block name="body_class"}
class="tag-body tag-detail"
{/block}
 {block name="title"}{$tplData.query}歌曲试听，mp3下载-音乐分类{/block}
 {block name='keywords'}{$tplData.query}，音乐分类，歌曲试听，mp3下载，百度音乐{/block}
 {block name='description'}百度音乐音乐歌曲分类，为你提供最全的{$tplData.query}的歌曲列表，mp3试听，音乐下载，歌词下载{/block}

{block name="import" append}

{include file="widget/song_list/search_song_list.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/path_navigator/path_navigator.html.tpl" inline}
{/block}

{block name="css"}

<link rel="stylesheet" type="text/css" href="/static/css/mv_tag.css{*version file='/static/css/mv_tag.css' prefix='?' suffix='.css'*}" />
 {/block}	

{block name="js" append}
<script type="text/javascript" src="/static/js/tag.js{*version file='/static/js/tag.js' prefix='?' suffix='.js'*}"></script>
<script type="text/javascript" src="/static/js/click_monkey.js{*version file='/static/js/click_monkey.js' prefix='?' suffix='.js'*}"></script>
<script type="text/javascript">
  {if $tplData.param.start}{$start = $tplData.param.start}{else}{$start = 0}{/if}
  $('.song-list-hook').songList({
      start:{$start}
  }).songList("floatBar");
    $(".ecom-ad").ecomad();
    // createClickMonkey("ting-music-plaza-tag-detail");
</script>
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-tag-detail{/block}



{block name="content_main"}
  <h1 class="music-seo">{$tplData.query}音乐</h1>
    {**<div class="ad-banner ecom-ad ecomad-banner-loading" data-isnewad = 0 data-id ="631"></div>**}
    {include file="widget/adm/adm.html.tpl" inline}
    <div class="path_navigator">
    {path_navigator pathList=[["label"=>"音乐分类", "link"=>"/tag"], ["label"=>"{$tplData.query}"]]}
    </div>


    
    
    <div class="main-body">
	<div class="main-body-cont">
       <div class="target-tag">     
         <span class="title">{$tplData.query}</span> 
         <span class="total">共<span class="nums">{$tplData.nums.tag|default:0}</span>首歌</span>
         {button 
            str ="收听该分类电台"
            style="b"
            tagAtt ="target='_blank'"
            isRightIcon =true
            icon ="fm"
            href="{$tplData.param.fm_host}/#/channel/public_tag_{$tplData.query|escape:url}"
        }
        
        {**tagStyle 标签页分类 _1 无二级标签的一级标签页 _2 有二级标签的一级标签页 _3 二级标签页 **}
        {$tagStyle="_1"}
        {if $tplData.son_tag_list}
          {$tagStyle="_2"}
          <div id="rec_tag" class="rec-tag">
            <span class="item-tag {if $tplData.father_tag==$tplData.query}first-tag{/if}"><a href="/tag/{$tplData.father_tag}">{$tplData.father_tag}</a></span>
            {foreach $tplData.son_tag_list as $item}
              <span class="item-tag {if $item.tag_name==$tplData.query}first-tag{/if}">
              <a href="/tag/{$item.tag_name}?tag={$tplData.father_tag}">{$item.tag_name}</a>
              </span>
            {/foreach}
          </div>  
        {/if} 
        {if $smarty.get.tag}
          {$tagStyle="_3"}
        {/if}         
         <span class="line"></span>
      </div>



	  <div class="tag-main"  data-tagstyle="tag{$tagStyle}" >

      {if $tplData.join_result}
	      {include file="plaza/tag/new_result_song_list.html.tpl" inline}
        {new_result_song_list
          data=$tplData.resultList
          allIDs=$tplData.song_ids
          funIcon=["play","add","download"]
          funBtn=["play","add", "collect","down"]
        }
      {else}
        {search_song_list truncated=false
        colIndex=true
        selectAll=false
        colAlbum=true
		songInfo = true
        indexWidth="25"
        songWidth="190"
        singerWidth="120"
        albumWidth="150"
        funIcon=["play","add","download"]
        funBtn=["play","add", "collect","down"]
        songData=$tplData.resultList
        moduleName="tagList"|cat:$tagStyle
        colHighRate=true
        total = 50
      }
      {/if}
		{page_navigator total=$tplData.param.total 
			size=$tplData.param.size 
			start=$tplData.param.start 			
			url="/tag/{$tplData.query|escape:'url' nofilter}?{if $smarty.get.tag}tag={$tplData.father_tag}&{/if}start=#start#&size=#size#"}
	   </div>
   </div>
   </div>
   <div class="sidebar">   	   
        
        {include file="widget/adm/adm.html.tpl" inline}
        <div class="ad">{adm id = "599132" width = "200" height = "200" tagAtt=" style='margin:0 auto;width:200px;'" }</div>
        <div class="ad">{adm id = "622957" width = "200" height = "200" tagAtt=" style='margin:0 auto;width:200px;'" }</div>
        <div class="ad">{adm id = "600777" width = "200" height = "130" tagAtt=" style='margin:0 auto;width:200px;'"}</div>
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

		{adm 
			id = "652830"
			class = "ad-banner ecomad-banner-loading bottom-ad-banner"
			width = "960"
		}
{/block}
