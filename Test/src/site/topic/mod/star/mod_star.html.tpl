<div monkey="mod-star{$index}"  id="mod_{$modData.parames.module_id}"  class="module mod-star ">
    <div class="mod-body clearfix">
          <a href="/artist/{$modData.parames.artist_id}"><!--<img class='star-photo' alt=""  org_src="{$modData.parames.artist_img}" src="{#PIC_PLACEHOLDER#}" />--><img class='star-photo' alt="{$modData.parames.nick}"  src="{$modData.parames.artist_img}" /></a>
        <div class="clearfix">
            <a href="/artist/{$modData.parames.artist_id}" class="star-name">{$modData.parames.nick}</a>
        </div>
        <div class="star-intro">
            {$modData.parames.artist_intro nofilter} <a href="/artist/{$modData.parames.artist_id}">更多 &gt;&gt;</a>
        </div>
    </div>
</div>
