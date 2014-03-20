{include file="widget/focus/focus.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/album_list/album_list.html.tpl" inline}

{$url="/album/`$area`?order=`$order`&style=`$stylename`"}

<div class="ab-list-container module">
  <div class="ab-list-head head clearfix">
    <div class="ab-list-select">
      <h1 class="music-seo">
        <strong>音乐</strong>,<strong>百度音乐</strong>,<strong>流行歌曲</strong>,<strong>流行音乐</strong>,<strong>试听</strong>
      </h1>
      <span class="title">
        {if $area == "shoufa"}新碟首发
        {elseif $area == "new"}专辑首发
        {elseif $area == "all" && $stylename == "all"}全部专辑
        {else}筛选:
        {/if}
      </span>
      {if $area != "shoufa" && $area != "new"}
        {if $area != "all"}<span class="selected-item">{$areaArray[$area]}<a href="/album/all?order={$order}&style={$stylename}">×</a></span>{/if}
        {if $stylename != "all"}<span class="selected-item">{$styleArray[$stylename]}<a href="/album/{$area}?order={$order}&style=all">×</a></span>{/if}
      {/if}
    </div>
    {if $tplData.albumList.nums > 1}
    <div class="sort">
      <em>排序：</em>
      {if $order == "hot"}
        <em class="order-selected">热度</em>       
        <span class="module-line"></span>       
        <em><a href="/album/{$area}?order=time&style={$stylename}">时间</a></em>
      {else}
        <em><a href="/album/{$area}?order=hot&style={$stylename}">热度</a></em>       
        <span class="module-line"></span>
        <em class="order-selected"> 时间</em>
      {/if}
    </div>
      {/if}
    
  </div>

  {if $tplData.albumList.nums > 0} 
  {alubm_list list=$tplData.albumList.list showCreator=true subChannel = true showAlbumList = true desc_truncate = 625 showStatus=true order=$smarty.get.order|escape:'html'}
  {page_navigator total={$tplData.albumList.nums} size={$tplData.param.limit} start={$tplData.param.start} url="`$url`&start=#start#&size=#size#"}
  {else}
    <div class="no-data">
      <h4>抱歉，没有找到符合条件的专辑！查看<a href="/album/all">全部专辑</a></h4>
      <!--
      <h4>对不起！该类别组合下目前还没有内容</h4>
      <p>感谢您对“百度音乐”的支持和关注，对我们的产品和服务有任何意见和建议，</p>
      <p>您可以到<a href="http://tousu.baidu.com/music/add" target="_blank">百度音乐意见反馈</a>，给我们留言，我们会安排专人尽快处理。</p>
      -->
    </div>
  {/if}


</div><!---end ab-list-container-->

