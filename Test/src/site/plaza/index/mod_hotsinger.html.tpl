{extends file="module/module.html.tpl"}
{block name='mod_class'}hot-singer{/block}
{block name='mod_attr'}monkey="hot-singer" id="hotSinger"{/block}
{block name="mod_head"}
{include file="widget/tab/tab.html.tpl" inline}
<a href="/artist" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">推荐歌手</h2>
{/block}
{block name="mod_body"}
<div class="music-ui-tab-body">
      {if $tplData.topArtist.zonghe}
      
            <ul class="clearfix singer-list">
            {foreach $tplData.topArtist.zonghe as $item}
                  {if $item@index <6}
                  <li>
                        <div class="cover-img singer-cover"> 
                        <a href="/artist/{$item.ting_uid}" class="cover"><img org_src="{$item.avatar_s60|default:#ARTIST_DEFAULT_60s#}" src="{#PIC_PLACEHOLDER#}"  class="lazyload" alt="{$item.name}" title="{$item.name}" /></a>
                        </div>
                        <div class="singer-name"><a title="{$item.name}" href="/artist/{$item.ting_uid}">{$item.name|pixel_truncate:50}</a></div>
                  </li>
                  {/if}
            {/foreach}
            </ul>
      
      {else}
            <p class="no-data">暂无数据</p>
      {/if}
      <div class="module-dotted-wrap">
            
      <div class="module-dotted"></div>
      </div>
      <ul class="more-list clearfix">
            <li><a href="/artist/cn/male">华语男歌手</a> </li>
            <li><a href="/artist/cn/female">华语女歌手</a> </li>
            <li><a href="/artist/cn/group">华语组合</a> </li>
            <li><a href="/artist/western/male">欧美男歌手</a> </li>
            <li><a href="/artist/western/female">欧美女歌手</a> </li>
            <li><a href="/artist/western/group">欧美组合</a> </li>
            <li><a href="/artist/jpkr/male">日韩男歌手</a> </li>
            <li><a href="/artist/jpkr/female">日韩女歌手</a> </li>
            <li><a href="/artist/jpkr/group">日韩组合</a> </li>
      </ul>



















{function name = hotsinger_list data =null type=null }
<div class="more-singer-list {$type}-list" >
      <div class="label">
            {if $type == "huayu"}
                  华语
            {elseif $type == "oumei"}
                  欧美
            {elseif $type == "rihan"}
                  日韩
            {/if}
      </div>
	<div class="singer-list-info {$type}" >
            {if $data}	
            	<p class="more-singer clearfix" >
                        {if  $type== "oumei"}
                              {$config = [
                                    "pixel"=> "55",
                                    "line"=> "2",
                                    "line_num" =>"3"
                              ]}
                        {else}
                              {$config = [
                                    "pixel"=> "45",
                                    "line"=> "2",
                                    "line_num" =>"4"
                              ]}
                        {/if}
                        {foreach $data as $item}{if $item@index<$config.line * $config.line_num}<a  title="{$item.name}" href="/artist/{$item.ting_uid}">{$item.name|pixel_truncate:$config.pixel}</a>{if $item@index != 0 && ($item@index+1) %$config.line_num == 0 }{else}<i class="module-line line"></i> {/if}
            			{if $item@index+1==$config.line_num}</p><p class="more-singer clearfix">{/if}
            		{/if}
            	{/foreach}
            	</p>

            {else}
                <p class="no-data">很抱歉，暂无{if  $type== "oumei"}{$hotSingerTab[2].title}{elseif $type=="rihan"}{$hotSingerTab[1].title}{elseif $type == "huayu"}{$hotSingerTab[0].title}{/if}数据</p>
            {/if}
	</div>
</div>
{/function}
	
</div>
{/block}

