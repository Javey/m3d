{include file="widget/album_cover/album_cover.html.tpl" inline}
{include file="widget/author_list/author_list.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{if $tplData.param.start}{$start = $tplData.param.start}{else}{$start = 0}{/if}

<div class="album-list " id="album_list" monkey="album-list">
    <ul class="clearfix">
    	{foreach $tplData.resultList as $item}
    	<li class="clearfix bb item {if $item@last}album-last{/if}" {if $start == 0 && $item@index == 0} id="first_album_li" {/if}>
            <div class="info">
        		<div class="album-face">
                    {album_cover album = $item showStatus=true}
                </div>
                <div class="album-info">
                	<div class="title clearfix">
                        <h4><a href="/album/{$item.album_id}" title="{$item.album|replace:'<em>':''|replace:'</em>':'' nofilter}">{$item.album|html_pixel_truncate:294 nofilter}</a></h4>
                       	<span class="creator"> - {author_list filter=false ids=$item.artist_id  names=$item.singer redirect=true width=135 releaseStatus=$item.relate_status source='album'}</span>
                        
                    </div>
                    <div class="album-active">
                        {if $item.time=='0000-00-00'}{$item.time=''}{/if}
                        {if !$item.company && !$item.time}
                            {$descTrun = 880}{else}{$descTrun = 440}
                        {/if}
                        {if $item.time}
                            <span class="time">{$item.time}</span>
                            <span class="module-line"></span>
                        {/if}
                        {if $item.styles}
                            <span class="styles">{$item.styles}</span>
                            <span class="module-line"></span>
                        {/if}
                    	{if $item.company}
                            <span class="company {if $item.time} has-split{/if}">{$item.company|pixel_truncate:228}</span>
                        {/if}
                        
                        {if $item.album_desc && $item.album_desc!=='None'}
                            <span class="desc">{$item.album_desc|pixel_truncate:$descTrun nofilter}</span>
                        {/if}
                    </div>
                    <div class="album-fold search-folder">
                    	<a href="javascript:void(0)"  class="songlist-fold-hook fold" data-songlistexpand='{json_encode(["type"=>"album",id=>$item.album_id])}' albumId='{$item.album_id}'><span class="action-hook">展开</span>专辑<i></i></a>
                    </div>
                </div>
            </div>
            <div class="songlist-expand"></div>
    	</li>
		{/foreach}
    </ul>
</div>

{page_navigator total=$tplData.param.total size=$tplData.param.size start=$tplData.param.start 			url="/search/album?key={$tplData.query|escape:'url' nofilter}&start=#start#&size=#size#"}
