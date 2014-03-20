{extends file="module/module.html.tpl"}
{block name='mod_class'}artist-top{/block}
{block name='mod_attr'}monkey="artist-top"{/block}
{block name="mod_head"}
<a href="/top/artist" class="more">更多<span>&gt;&gt;</span></a>
<h2 class="title">歌手榜 <span>TOP200</span></h2>
{/block}
{block name="mod_body"}
{$data = $tplData.artistBillboard}
{if $data}
    <ul class="song-list left-column">
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
            <li {if $item@first}class="first"{/if}>
              <span class="num">{$item@iteration}</span>
              <span class="status"><i class="{$status}"></i></span>
              <span class="artist-name"><a href="/artist/{$item.ting_uid}">{$item.name|pixel_truncate:55}</a></span>
            </li>
            {if $item@iteration == 10}
                </ul>
                <ul class="song-list right-column">
            {/if}
            {if $item@iteration > 19}
                {break}
            {/if}
      {/foreach}
    </ul>
    <a href="/artist" class="more all-artist">全部歌手<span>&gt;&gt;</span></a>
{else}
  <p class="no-data">很抱歉，暂无数据</p>
{/if}
{/block}
