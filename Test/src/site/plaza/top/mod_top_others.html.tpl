{include file="plaza/top/top_title_config.html.tpl" inline}
{include file="widget/song_list/song_list.html.tpl" inline}
{include file="widget/tree_navigator_top/tree_navigator.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="plaza/top/tree_navigator_source.html.tpl" inline}
{include file="widget/top/top_title.html.tpl" inline}
{include file="widget/top/top_newlist.html.tpl" inline}
{include file="widget/top/top_others.html.tpl" inline}  
{$type = $tplData.type}
{$arrNo = split('-',$tplData.no)}
    <div class="main-body module top-list" {if $type=="new"} data-no="{$tplData.no}" data-newtype="{$tplData.new_type}" {/if} id="top{$type}" monkey ="top-{$type}">
		{$cName = $titleConfig[$type].cName}
		{** 标题 **}
		{capture assign=title}
			{top_title titleConfig=$titleConfig type=$type}
		{/capture}
		<div class="head clearfix">
			{if $type != 'new'}
				{foreach $tplData.result as $dateItem}
					{if strlen($dateItem.date_desc)}
						{$updateDate = $dateItem.date_desc}
					{else if strlen($dateItem.update_date)}
						{$updateDate = "榜单更新至：`$dateItem.update_date`"}
					{else if strlen($dateItem.update_time)}
						{$updateDate = "榜单更新至：`$dateItem.update_time`"}
					{/if}
					{break}	
				{/foreach}
				{if $updateDate}
					<div class="top-update-date">{$updateDate}</div>
				{/if}
			{/if}
			<h2 class="title">{$title}</h2>
			{if  !($type == 'artist' || $type == 'new')}
				{if $tplData.result}
				<span class="play-all">
				{button 
					style = "a"
					str = "播放榜单"
					icon = "play"
					class = "play-all-hook"
					href = "javascript:;"
					tagAtt = "data-type=`$type`"}
				</span>
				{/if}
			{/if}
			{if $type=='new'}
				<div class="new-top-desc">{$titleConfig.new.info}</div>	
			{/if}	
		</div>	

		{if $tplData.result}
			{if $type == "new"}
                  {$DiffMonthDay=ceil(($smarty.now-strtotime($tplData.month_latest))/3600/24)}
                  {$DiffWeekDay=ceil(($smarty.now-strtotime($tplData.week_latest))/3600/24)}
                  		
				<div class="music-ui-tab music-ui-tab-middle">
					<ul class="tab-list">
						<li class="{if $tplData.new_type=='day'}ui-tab-active{/if}">
							<a class="list" data-newtype="day" {if $tplData.new_type=='day'}data-ajax=1{/if}   hidefocus="true" href="#">日榜</a>
						</li>
						<li class="week-tab {if $tplData.new_type=='week'}ui-tab-active{/if}">
							<a class="list" data-newtype="week" {if $tplData.new_type=='week'}data-ajax=1{/if}  hidefocus="true" href="#">周榜</a>
							{if $DiffWeekDay<=3}
							 <i class="top-new-pub"></i>
							{/if} 
						</li>
						<li class="{if $tplData.new_type=='month'}ui-tab-active{/if}">
							<a class="list" {if $tplData.new_type=='month'}data-ajax=1{/if}   data-newtype="month" hidefocus="true" href="#">月榜</a>
							{if $DiffMonthDay<=4}
							 <i class="top-new-pub"></i>
							{/if} 
						</li>
					</ul>
				</div>							
			{else}
				<p class="desc">{$titleConfig[$type].info}</p>
			{/if}
		{/if}

		{if $tplData.result}
		  	{if $type == "artist"}
				<div class="module-line module-line-bottom"></div>
				<div class="artist-top">
				  <ul class="artist-head song-list clearfix bb-dotimg">
				  {foreach $tplData.result as $item}
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
					<li class="song-item {if $item@first}first{/if}">
					  <span class="index-num">{$item@iteration}</span>
					  <span class="status"><i class="{$status}"></i></span>
					  {if $item@index < $COLUMN}
						<span class="cover-item">
						  <span class="cover-img">
							<a class="over" href="/artist/{$item.ting_uid}">
							  <img src="{$item.avatar_s60|default:#ARTIST_DEFAULT_60s#}" alt="{$item.name}"/>
							</a>
						  </span>
						<div class="artist-name"><a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:$TRUNCATE}</a></div>
						</span>
					  {else}
						<span class="artist-name"><a href="/artist/{$item.ting_uid}">{$item.name|pixel_truncate:$TRUNCATE_L}</a></span>
					  {/if}
					</li>
					{if $item@index == $COLUMN-1}
					  </ul><ul class="artist-body song-list clearfix">
					{/if}
					{if $item@iteration > $COLUMN && ($item@iteration - $COLUMN) % $ITEMS == 0}
					  <li class="line-space"></li>
					{/if}
				  {/foreach}
				  </ul>
				</div>
			{elseif $type == "new"}
				<div class="top-list-item" >
						<div class="music-ui-tab-body">
							<div class="ui-tab-content {if $tplData.new_type=='day'}ui-tab-content-active{/if} top-day-list" id="songList">
								<div class="top-date">
									<div class="top-date-ctr" data-type="day">
										<a href="#" class=" pre date-arrow"></a>
										<span class="cal-num top-date-year">{if $tplData.new_type=='day'}{$arrNo[0]}{/if}</span>
										<span class="cal-txt ">年</span>
										<span class="cal-num top-date-month ci">{if $tplData.new_type=='day'}{$arrNo[1]}{/if}</span>
										<span class="cal-txt ci">月</span>
										<span class="cal-num top-date-day ci">{if $tplData.new_type=='day'}{$arrNo[2]}{/if}</span>
										<span class="cal-txt-end cal-txt ci">日</span>
										<input type="text" id="datepicker" style="float:left;display:none;"/>
										<a href="#" data-min="2013-01-01" {if $tplData.new_type=='day'} data-max="{$tplData.latestno}"{/if} class="top-calendar " id="topCalDay"></a>

										<a href="#" class="next date-arrow"></a>
									</div>
									<span class="play-all">
									{button 
										style = "a"
										str = "播放榜单"
										icon = "play"
										class = "play-all-hook"
										href = "javascript:;"
										tagAtt = "data-type='`$tplData.new_type`' data-no='`$tplData.no`'"}
									</span>									
								</div>
								<div class="top-song-list-wrap">	
									{if $tplData.new_type=='day'}
										{top_others total = 50 songData=$tplData.result type=$type}
									{else}
										<div class="loading-content"></div>
									{/if}
								</div>
							</div>
							<div  class="ui-tab-content {if $tplData.new_type=='week'}ui-tab-content-active{/if} top-week-list">
								<div class="top-date" >
									<div class="top-date-ctr" data-type="week">
										<a href="#" class="pre date-arrow"></a>
										<span class="cal-num top-date-year">{if $tplData.new_type=='week'}{$arrNo[0]}{/if}</span>
										<span class="cal-txt ">年</span>
										<span class="cal-num top-date-week ci">{if $tplData.new_type=='week'}{$arrNo[1]}{/if}</span>
										<span class="cal-txt-end cal-txt ci">周</span>
										<a href="#"  data-min="2013-01" {if $tplData.new_type=='week'} data-max="{$tplData.latestno}"{/if}  class="top-calendar" id="topCalWeek"></a>
										<a href="#" class="next date-arrow"></a>
									</div>
									<span class="play-all">
									{button 
										style = "a"
										str = "播放榜单"
										icon = "play"
										class = "play-all-hook"
										href = "javascript:;"
										tagAtt = "data-type='`$tplData.new_type`' data-no='`$tplData.no`'"}
									</span>				
								{if $tplData.mv_info}
									{button 
					style = "b"
					str = "视频播榜"
					class = "top-mv-hook"
					href = "javascript:;"
					tagAtt = "data-tvid='`$tplData.mv_info.mv_tvid`'  data-vid='`$tplData.mv_info.mv_vid`'"}	
								{/if}
								</div>	

								<div id="newWeekSongListWrapper" class="top-song-list-wrap">		
								{if $tplData.new_type=='week'}
								{top_new_song_list colHighRate= true colMovie = $colMovie movieWidth = "150"  btnPos ="both" colAlbum =false topStatusWidth = 30 isSpecial = true total = 20 stressFirst = true indexWidth = 30 songData = $tplData.result  numPluszero=false singerWidth= $singerWidth  songWidth = $songWidth topNewIds=$topNewIds src =$src funIcon=$funIcon funBtn=$funBtn}
								{else}
									<div class="loading-content"></div>
								{/if}
								</div>

							</div>
							<div class="ui-tab-content {if $tplData.new_type=='month'}ui-tab-content-active{/if} top-month-list" >
								<div class="top-date" >
									<div class="top-date-ctr" data-type="month">
										<a href="#" class="pre date-arrow"></a>
										<span class="cal-num top-date-year">{if $tplData.new_type=='month'}{$arrNo[0]}{/if}</span>
										<span class="cal-txt ">年</span>
										<span class="cal-num top-date-month ci">{if $tplData.new_type=='month'}{$arrNo[1]}{/if}</span>
										<span class="cal-txt-end cal-txt ci">月</span>
										<a href="#" data-min="2013-01" class="top-calendar" {if $tplData.new_type=='month'} data-max="{$tplData.latestno}"{/if}   id="topCalMonth"></a>
										<a href="#" class="next date-arrow"></a>
									</div>
									<span class="play-all">
									{button 
										style = "a"
										str = "播放榜单"
										icon = "play"
										class = "play-all-hook"
										href = "javascript:;"
										tagAtt = "data-type='`$tplData.new_type`' data-no='`$tplData.no`'"}
									</span>	
									{if $tplData.mv_info}
									{button 
									style = "b"
									str = "视频播榜"
									class = "top-mv-hook"
									href = "javascript:;"
									tagAtt = "data-tvid='`$tplData.mv_info.mv_tvid`'  data-vid='`$tplData.mv_info.mv_vid`'"}					
									{/if}							
								</div>
								<div id="newMonthSongListWrapper" class="top-song-list-wrap ">	
								{if $tplData.new_type=='month'}	
								{top_new_song_list colHighRate= true colMovie = $colMovie movieWidth = "150"  btnPos ="both" colAlbum =false topStatusWidth = 30 isSpecial = true total = 20 stressFirst = true indexWidth = 30 songData = $tplData.result  numPluszero=false singerWidth= $singerWidth  songWidth = $songWidth src =$src funIcon=$funIcon funBtn=$funBtn}	
								{else}
									<div class="loading-content"></div>							
								{/if}
								</div>				
							</div>
						</div>	                	
				</div>
		  	{else}
				<div class="top-list-item">
	            	{top_others total = 50 songData=$tplData.result type=$type}
				</div>
		  	{/if}

	    {else}
	    <p class="desc no-data">非常抱歉，暂无该榜单数据。</p>
	    {/if}
    </div>
    <div class="sidebar">        
        <div class="tree_top" monkey="nav-{$type}">
        {tree_navigator_top  treeData=$tree selected=$tplData.type}
        {include file="widget/adm/adm.html.tpl" inline}
        {adm id = "482356" width = "150" height = "220" }
            <a href="http://top.baidu.com" target="_blank" class="fengyunbang">搜索风云榜</a>
        </div>
    </div>
