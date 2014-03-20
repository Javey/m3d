{extends file="plaza/plaza.html.tpl"}

 {block name="assign"}{**用来放assign数据**}
    {$navIndex='songlist'}
 {/block}
{block name="title"}歌单{/block}

{block name='keywords'}歌单，精选集，百度音乐{/block}
{block name='description'}百度音乐歌单，为你提供不同“曲风流派、心情感受、主题场合“的歌曲精选集，正能量、经典、摇滚、中国风、感动、爱情、伤感、DJ，尽在百度音乐-中国第一音乐门户{/block}

{block name="css"}
<link rel="stylesheet" type="text/css" href="/static/css/plaza_songlist.css{*version file='/static/css/plaza_songlist.css' prefix='?' suffix='.css'*}" />
 {/block}	


{block name="js-page"}
<script type="text/javascript" src="/static/js/plaza_songlist.js"></script>
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-songlist-index{/block}

{block name="content_main"} 
  <!-- music seo begin -->
  <div><h1 class="music-seo">歌单</h1></div>
  <!-- music seo end-->


  <div class="songlist-content ">
      {include file="plaza/songlist/mod_body.html.tpl"}
    
  </div>
{/block}
