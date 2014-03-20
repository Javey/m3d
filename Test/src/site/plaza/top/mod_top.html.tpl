{include file="widget/top/top.html.tpl" inline}
{include file="widget/song_list/song_list.html.tpl" inline}
{include file="widget/tree_navigator_top/tree_navigator.html.tpl" inline}
{include file="plaza/top/tree_navigator_source.html.tpl" inline}
{include file="plaza/top/top_title_config.html.tpl" inline}

{function name=top_song_list data =null title="" type="" isStatus =true songWidth=150 singerWidth=110}
{if $type == "billboard" || $type == "ktv" }
      {$src = "mediatop"}
{else}
    {if $type == "yingshijinqu"}
      {$src = "top_index_yingshijinqu"}
    {else}
      {$src = "top"}
    {/if}
{/if}
	<div class="module {$index}" monkey="top-{$type}">					
		<div class="head">
			<a href="/top/{$type}" class="more">更多<span>&gt;&gt;</span></a>
			<h2 class="title">{$title}</h2>
		</div>
		{if $data}
		{**{top  list=$data isStatus =$isStatus total = 10 isDotted = false isSpecial=false}**}
            
          {if $type== "yingshijinqu"}
            {$colMovie = ture}
            {$colSinger = false}
          {else}
            {$colMovie = false}
            {$colSinger = true}
          {/if}
            {song_list moduleName=$type colMovie = $colMovie colSinger = $colSinger movieWidth =60 stressFirst = true indexWidth = 20 src=$src colCheck =false songData = $data btnPos = "none" numPluszero=false funIcon=["play","add"] singerWidth=$singerWidth  songWidth=$songWidth isDotted =false appendix=false}
            <div class="play-more clearfix">
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
                              class = "play-all-hook top-index-btnall"
                              href = "javascript:;"
                              tagAtt = "data-type=`$type`"}
                  </span>
            </div>
		{else}
		<div class="no-data">暂时无该榜单数据</div>
		{/if}
	</div>
{/function}

<div class="main-body top-index">
      
      <div class="top-list-cont clearfix">
           <div class="top-index-left" monkey="hot-top">
            {top_song_list data = $tplData.hotBillboard title=$titleConfig.dayhot.title type ="dayhot" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right" monkey="new-top">
            {top_song_list data = $tplData.newBillboard title=$titleConfig.new.title type ="new" songWidth=$songW singerWidth=$singerW}
            </div> 
      </div>
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="artist-top">
                    <div class="module artist-top" monkey="top-artist">
                        <div class="head">
                          <a class="more" href="/top/artist">更多<span>&gt;&gt;</span></a>
                          <h2 class="title">歌手榜</h2>
                        </div>

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
                                            <li class="{if $item@index < 3}lead-top{/if} song-item {if $item@first}first{/if}">
                                                <span class="index-num">{$item@iteration}</span>
                                                <span class="status"><i class="{$status}"></i></span>
                                                <span class="song-title"><a href="/artist/{$item.ting_uid}">{$item.name|pixel_truncate:$artist_trun_width}</a></span>
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
                                <div class="play-more">
                                {button
                                    str="全部歌手"
                                    style="b"
                                    href="/artist"
                                }
                                </div>
                          {else}
                              <p class="no-data">很抱歉，暂无数据</p>
                          {/if}
                    </div>
            </div>
            <div class="top-index-right" monkey="oumei-top">
            {top_song_list data = $tplData.chinavoice title=$titleConfig.chinavoice2013.title type ="chinavoice2013" songWidth=$songW singerWidth=$singerW}
            </div>
      </div>
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="huayu-top">
            {top_song_list data = $tplData.huayu title=$titleConfig.huayu.title type ="huayu" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right" monkey="oumei-top">
            {top_song_list data = $tplData.oumei title=$titleConfig.oumei.title type ="oumei" songWidth=$songW singerWidth=$singerW}
            </div>            

      </div>
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="oldsong-top">
                  {top_song_list isStatus = false data = $tplData.oldsong title=$titleConfig.oldsong.title type ="oldsong" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right" monkey="yingshijinqu-top">
                  {top_song_list isStatus = false data = $tplData.yingshijinqu title=$titleConfig.yingshijinqu.title type ="yingshijinqu"  songWidth=$songW singerWidth=$singerW}
            </div>            

      </div>
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="netsong-top">
                  {top_song_list isStatus = false data = $tplData.netsong title=$titleConfig.netsong.title type ="netsong" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right" monkey="lovesong-top">
                  {top_song_list isStatus = false data = $tplData.lovesong title=$titleConfig.lovesong.title type ="lovesong" songWidth=$songW singerWidth=$singerW}
            </div>            

      </div>

	{**
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="jazz-top">
                  {top_song_list data = $tplData.jazzBillboard title=$titleConfig.jazz.title type ="jazz" songWidth=$songW singerWidth=$singerW}
            </div>

            <div class="top-index-right" monkey="folk-top">
                  {top_song_list isStatus = false data = $tplData.folkBillboard title=$titleConfig.folk.title type ="folk" songWidth=$songW singerWidth=$singerW}
            </div>
      </div>
	**}
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            {**
            <div class="top-index-left" monkey="haoshengyin-top">
                  {top_song_list isStatus = false data = $tplData.chinavoice title=$titleConfig.chinavoice.title type ="chinavoice" songWidth=$songW singerWidth=$singerW}
            </div>
            **}
            <div class="top-index-left" monkey="ktv-top">
                  {top_song_list isStatus =false data = $tplData.ktv title=$titleConfig.ktv.title type ="ktv" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right" monkey="rock-top">
                  {top_song_list data = $tplData.rockBillboard title=$titleConfig.rock.title type ="rock" songWidth=$songW singerWidth=$singerW}
            </div>             

      </div>
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="hito-top">
                  {top_song_list data = $tplData.hito title=$titleConfig.hito.title type ="hito" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right" monkey="bill-top">
                  {top_song_list data = $tplData.Billboard title=$titleConfig.billboard.title type ="billboard" songWidth=$songW singerWidth=$singerW}
            </div>            

      </div>
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="ukchart-top">
                  {top_song_list data = $tplData.ukchart title=$titleConfig.ukchart.title type ="ukchart" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right" monkey="chizha-top">
                  {top_song_list isStatus = false data = $tplData.chizha title=$titleConfig.chizha.title type ="chizha" songWidth=$songW singerWidth=$singerW}
            </div>            
      </div>
      <div class="module-line module-line-bottom"></div>
      <div class="top-list-cont clearfix">
            <div class="top-index-left" monkey="mnet-top">
                  {top_song_list data = $tplData.mnet title=$titleConfig.mnet.title type ="mnet" songWidth=$songW singerWidth=$singerW}
            </div>
            <div class="top-index-right oricon-top" monkey="oricon-top">
                  {top_song_list isStatus = false data = $tplData.oricon title=$titleConfig.oricon.title type ="oricon" songWidth=$songW singerWidth=$singerW}
            </div>            
      </div>      
</div>

<div class="sidebar" monkey="sidebar">
    {tree_navigator_top treeData=$tree}
    {include file="widget/adm/adm.html.tpl" inline}
        {adm id = "482356" width = "150" height = "220" }
    <a href="http://top.baidu.com" target="_blank" class="fengyunbang">搜索风云榜</a>
</div>

