{extends file="module/module.html.tpl"}
{block name='mod_class'}recommend-mv{/block}
{block name='mod_attr'}monkey="recommend-mv" alog-alias="mv-list"{/block}
{block name='mod_head_class'}clearfix{/block}
{block name="mod_head"}
<h2 class="title">《{$mvNname}》的MV</h2>
{$page = 4}
{if count($tplData.mv_list) > $page}
    <div class="mv-focus clearfix">
        <a href="" class="left-btn"></a>
        <div class="mv-focus-page">
            {foreach $tplData.mv_list as $item}
                {if $item@index % $page  == 0}
                    {if $item@first}
                        {$className = "page-active"}
                    {else}
                        {$className = ""}
                    {/if}
                    <a href="" class="page-index {$className}"></a>
                {/if}
            {/foreach}
        </div>
        <a href="" class="right-btn"></a>
    </div>
{/if}
{/block}
{block name="mod_body"}
{include file="widget/mv_cover/mv_cover.html.tpl" inline}
{if $tplData.mv_list}
    <div class="recommend-mv-cover wrap">
        <ul class="clearfix">
        {foreach $tplData.mv_list as $item}
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
				{mv_cover data = $item}
    			<div class="song-item">
    				<span class="song-title">
						{song_link_url_plugin song=$item linkWithNoSongId="#" songLinkUrl=theSongLink}
    					<a href="{$theSongLink}" title="{$item.title}">{$item.title|pixel_truncate:$ret.oneWidth:'tahoma_14' nofilter}</a>
    				</span>
            <span class="module-line hor-line"></span>
    				<span class="siger-name">
    					{author_list source='song' releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid  names=$item.author width=$ret.twoWidth}
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
		{/foreach}
    	</ul>
    </div>

{/if}

{/block}
