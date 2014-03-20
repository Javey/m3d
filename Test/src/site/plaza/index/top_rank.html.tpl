{include file="widget/button/button.html.tpl" inline}
{include file="widget/music_icon/music_icon.html.tpl" inline=true}
{include file="widget/author_list/author_list.html.tpl" inline=true}

{assign var="song_width" value=72}
{assign var="singer_width" value=55}
<ul class="song-list">
{foreach $data as $item}
            {if $item.is_new == 1}
                {$status = 'new'}
            {elseif $item.rank_change > 0}
                {$status = 'up'}
            {elseif $item.rank_change < 0}
                {$status = 'down'}
            {elseif $item.rank_change == 0}
                {$status = 'fair'}
            {/if}

            {if !$item.del_status}
                {$del = false}
            {else}
                {$del = true}
            {/if}

            {$song_title = $item.title|pixel_truncate:$song_width:"tahoma_14"}
     {if $item@index <10}
        <li class="clearfix {if $item@first}first{/if}">
            <span class="num">{$item@index+1}</span>
            {if $type != "biaosheng"}
            <span class="status"><i class="{$status}"></i> </span>
            {/if}
                {if !$del}
                    <span class="song-name">
					{song_link_url_plugin song=$item linkWithNoSongId="#" songLinkUrl=theSongLink}
                    <a href="{$theSongLink}" sid="{$item.song_id}" class="song top-song-hook" title="{$item.title}{if $item.license_number}  审批文号：{$item.license_number}{/if}">{$song_title}</a>
                    </span>
                {else}
                    <em class="index-noLink" title="该歌曲已下架">{$song_title}</em>
                {/if}
                <span class="singer-name">{author_list releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid names=$item.author width=$singer_width}</span>
                {if $item.song_id}
                <span class="fun-icon">
                  {music_icon moduleName=$type|cat:"Icon"  id= {$item.song_id} icons = ["play","add"] bePlayed = $item.bePlayed }
                </span>
                {/if}
        </li>
     {/if}   
{/foreach}
</ul>
<div class="mod-opera">
    <span class="play">
        {$ids = []}
      {foreach $data as $item}
            {if $item@index <10}
                  {$tmp = array_push($ids, $item.song_id)}
            {/if}
      {/foreach}
        {button 
            style = "a"
            str = "播放榜单"
            icon = "play"
            class = "play-all-hook"
            href = "#"
            tagAtt = "data-type=$type"}
    </span>
</div>  
	
