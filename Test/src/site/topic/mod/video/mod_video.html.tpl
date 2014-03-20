{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-video{/block}
{block name='mod_attr'}monkey="mod-video{$index}"{/block}
{block name="mod_body"}
{if $modData.parames.column_content}
<div class="mod-info clearfix">
    		{$modData.parames.column_content nofilter}
    	</div>
{/if}
{if $modData.data}
	{$fistData=current($modData.data)}
<div class="mod-list video-list">
  <ul>
    <li>
      <object width="100%" height="380" align="middle" id="video" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000">
        <param value="#ffffff" name="bgcolor" />
        <param value="window" name="wmode" />
        <param value="always" name="allowscriptaccess" />
        <param value="http://www.yinyuetai.com/swf/explayer.swf?videoId={$fistData.link}&amp;epId=1&amp;t=1320304216366" name="movie" />
        <param value="autoplay=true" name="flashvars" />
        <embed width="100%" height="380" align="middle" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" name="video" src="http://www.yinyuetai.com/swf/explayer.swf?videoId={$fistData.link}&amp;epId=1&amp;t=1320304216366" flashvars="autoplay=true" allowscriptaccess="always" wmode="window" bgcolor="#ffffff" errormessage="Please download the newest flash player." ver="9.0.28" ></embed>
      </object>
    </li>
  </ul>
</div>
{if $modData.data|@count >1}
<div class="page-list-video clearfix">{if $modData.data|@count >5} <a class="page-prev" href="#"><i></i></a>{/if}
  <div class="page-inner">
    <ul class="clearfix">
      {foreach $modData.data as $item}
          <li><a class="video-index" href="#" rel="{$item.link}" title="{$item.title}"><i></i><img org_src="{$item.prevue_img}" src="{#PIC_PLACEHOLDER#}"   class="lazyload"    alt="" /></a></li>	
      {/foreach}  
    </ul>
  </div>
 {if $modData.data|@count >5} <a class="page-next" href="#"><i></i></a> {/if}
  </div>
  {/if}
   {/if}
{/block}