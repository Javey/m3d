{extends file="module/mod_plaza/mod_plaza.html.tpl"}
{block name='mod_class'}new-single{/block}
{block name='mod_attr'}monkey="new-single"{/block}
{block name='mod_shadow'}{/block}
{block name="mod_head"}
{include file="widget/music_icon/music_icon.html.tpl" inline=true}

{**模块头部**}
<h2 class="mod-title">最新单曲</h2>
<div class="rool-nav-item">
			<span class='nav-num'><span class="num-index">01</span><span class="nav-num-split">/</span>05</span>
			<a href="#" class="page-dot-prev"></a>	
			<a href="#" class="page-dot-next"></a>		
</div>
{/block}

{block name="mod_body"}
<div class="new-single-list-wrap">
<ul class="new-single-list clearfix">
  <li class="item">
      <ul>
      {foreach $tplData.latestSongs as $item}
        {if $item@index < 25}
        {if $item@index%5 == 0 && $item@index !=0}
          </ul>
        </li>
        <li class="item">
          <ul>
          {/if}
            <li class="list">
              <div class="music-info">
                {if $item.is_recommend_mis == 1}<sup class="recommend-icon"></sup>{/if}
                {if $item.is_first_publish == 1}<sup class="first-publish"></sup>{/if}
                {song_link song=["song_id"=>{$item.song_id},"title"=>{$item.title},"del_status"=>{$item.del_status}] width=200}
               - {author_list ids=$item.all_artist_ting_uid names=$item.author width=120}<span class="recomm-reason">{$item.reason}</span>

              </div>
              {music_icon   id= {$item.song_id}
                    icons = ["play", "add"] bePlayed = $item.bePlayed beDownloaded = $item.beDownloaded}
                <span class="time">{$item.publishtime}</span></li>
        {/if}
      {/foreach}
      </ul>
    </li>
  
</ul>
</div>
{/block}
