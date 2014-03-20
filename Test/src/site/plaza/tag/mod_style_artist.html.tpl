

<h2>代表歌手</h2>

{$page = 5}
<div class="artist-focus clearfix">
     <a href="" class="left-btn"></a>
     <div class="artist-focus-page">
          {foreach $tplData.artist_list as $item}
          {if $item@index % $page  == 0}
               {if $item@first} 
                    {$className = "page-active"}
               {elseif $item@index ==  count($tplData.artist_list) - $page }
                    {$className = "page-index-last"}
               {else}
                    {$className = ""}
               {/if}
          <a href="" class="page-index {$className}"></a>
          {/if}
          {/foreach}
     </div>
     <a href="" class="right-btn"></a>
</div>

<div class="artist-list">
     <div class="wrap">
          <ul >
          {foreach $tplData.artist_list as $item}
               {if $item@index % $page  == 0 && !$item@first}
               </ul>
               <ul>
               {/if}
                    <li class="cover-item {if $item@iteration % 5 == 0}last{/if}">
                         <div class="cover-img">
                              <a class="cover" href="/artist/{$item.ting_uid}">
                                   <img title="{$item.name}" width="120" height="120"src="{$item.avatar_s130|default:#ARTIST_DEFAULT_130b#}">
                              </a>
                         </div>
                         <div>
                              <a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:120:'tahoma_14'}</a>
                         </div>
                    </li>
                    
          {/foreach}
          </ul>
     </div>
</div>

