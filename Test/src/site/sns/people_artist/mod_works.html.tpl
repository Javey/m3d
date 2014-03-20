{include file="widget/album_list/album_list.html.tpl" inline}
{include file="widget/mv_list/mv_list.html.tpl" inline}
{include file="widget/tab/tab.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/zoom_image/zoom_image.html.tpl"}
<div class="singer-works" id="singerWorks">
	{$album_cover_blank = true}
	{$photo_lazyload = true}
{$on = $tplData.tag_type|default:$smarty.get.on|escape:'html'}
{if $on == "album"}
    {$onSongTab = 0}
    {$onAlbumTab = 1}
    {$onPhotoTab = 0}
    {$onMVTab = 0}
    {$album_cover_blank = false}
{else if $on == "photo"}
    {$onSongTab = 0}
    {$onAlbumTab = 0}
    {$onPhotoTab = 1}
    {$onMVTab = 0}
	{$photo_lazyload = false}
{else if $on == "mv"}
    {$onSongTab = 0}
    {$onAlbumTab = 0}
    {$onPhotoTab = 0}
    {$onMVTab = 1}
{else}
    {$onSongTab = 1}
    {$onAlbumTab = 0}
    {$onPhotoTab = 0}
    {$onMVTab = 0}
{/if}
{$allWorksTab =[ 
	[
		"link" => "#",
		"title" => "歌曲({$tplData.artist_info.songs_total|default:0})",
		"active" => $onSongTab
	],
	[
		"link" => "#",
		"title" => "专辑({$tplData.artist_info.albums_total|default:0})",
		"active" => $onAlbumTab
	],
	[
		"link" => "#",
		"title" => "MV({$tplData.artist_info.mv_total|default:0})",
		"active" => $onMVTab
	],
	[
		"link" => "#",
		"title" => "相册({$tplData.photo_list.total|default:0})",
		"active" => $onPhotoTab
	]
]}
{**tab可传参定制**}
{$worksTab = []}
{foreach $works as $item}
	{if $item == 'songs'}
		{$a = array_push($worksTab,$allWorksTab[0])}
	{elseif $item === 'albums'}
		{$b = array_push($worksTab,$allWorksTab[1])}
	{elseif $item === 'mvs'}
		{$d = array_push($worksTab,$allWorksTab[2])}
	{elseif $item === 'photos'}
		{$c = array_push($worksTab,$allWorksTab[3])}
	{/if}
{/foreach}

{tab tablist = $worksTab style="middle"}	
{include file="widget/song_list/song_list.html.tpl" inline}  
<div class="music-ui-tab-body" monkey="songWork">
<a name="list-top"></a>

{if in_array("songs",$works)}
<div class="ui-tab-content songs-list"   id="songList" style="{if !$onSongTab}display:none;{/if}"  >
	{if $tplData.song_list}
		{if count($tplData.song_list)!=1}
			<div class="clearfix">
				<div class="sort-wrap">
					<div class="sort" type="song"><span class="label">排序：</span> <a href="#" class="on" type="hot">热度</a><i class="module-line"></i><a type="time" href="#" class="">时间</a> </div>
				</div>
			</div>
			{**<div class="module-line module-line-bottom"></div>**}
		{/if}		
	
		<div class="song-list-wrap"  >
			{song_list  moduleName="song"  colHighRate= true songInfo=ture btnPos="both" hotbarMax = $tplData.artist_info.top_song_hot songData=$tplData.song_list funIcon=$funIcon funBtn=$funBtn colAlbum=true colSinger =false hotBar = true total=20 songWidth="157" indexWidth="25" showChinaVoice=true colNewIcon=true}
		</div>
		{page_navigator
			total = {$tplData.artist_info.songs_total|default:0}
			size  = 20
			start = 0
			url   = "/data/artist/getSong?start=#start#&size=#size#"}
	{else}
		<p class="no-data">目前Ta还没有歌曲。</p>
	{/if}
</div>
{/if}
{if in_array("albums",$works)}
<div  id="albumList" class="ui-tab-content albums-list" style="{if !$onAlbumTab}display:none;{/if}  {if !$tplData.album_list || count($tplData.album_list) ==1 }padding-top:0;{/if} ">
	{if $tplData.album_list}
	{if count($tplData.album_list)>1}
	<div class="sort" type="album"><span class="label">排序：</span><a href="#" type="hot">热度</a><i class="module-line"></i><a type="time" href="#" class="on">时间</a> </div>
	<div class="module-line module-line-bottom"></div>
	{/if}
	<div class="album-list-wrap">

		{alubm_list list=$tplData.album_list subChannel = true total =10 album_cover_blank = $album_cover_blank showAlbumList =true showStatus=true order="time"}
	</div>
	{page_navigator
		total = {$tplData.artist_info.albums_total|default:0}
		size  = 10
		start = 0
		url   = "/data/artist/getAlbum?start=#start#&size=#size#"}
	{else}
	<p class="no-data">目前Ta还没有专辑。</p>
	{/if}
</div>
{/if}
{if in_array("mvs",$works)}
<div  id="mvList" class="ui-tab-content mvs-list" style="{if !$onMVTab}display:none;{/if}  {if !$tplData.mv_list || count($tplData.mv_list) ==1 }padding-top:0;{/if} ">
	{if $tplData.mv_list}
	{if count($tplData.mv_list)>1}
	<div class="sort" type="mv"><span class="label">排序：</span><a href="#" type="hot">热度</a><i class="module-line"></i><a type="time" href="#" class="on">时间</a> </div>
	<div class="module-line module-line-bottom"></div>
	{/if}
	<div class="mv-list-wrap">
		{mv_list list=$tplData.mv_list perLine=4 total=20 titleParam="title" titleTruncate=140 showSinger=false}
	</div>
	{page_navigator
		total = {$tplData.artist_info.mv_total|default:0}
		size  = 20
		start = 0
		url   = "/data/artist/getmvlist?start=#start#&size=#size#"}
	{else}
	<p class="no-data">目前Ta还没有MV。</p>
	{/if}
</div>
{/if}
{if in_array("photos",$works)}
<div class="ui-tab-content photos-list" id="photoList" style="{if !$onPhotoTab}display:none;{/if}">
	{if  $tplData.photo_list.list}
	<div class="photos-info">
		<div class="photo-list photo-list-wrap" >	
			<ul class="list clearfix {if (!$tplData.star_photo_list)&&$tplData.fans_photo_list}on{/if}">
				
			{foreach $tplData.photo_list.list as $photo}
				{if $photo@index<12}
				<li class="photo-item">
					<a class="photo-border"  href="{user_link user=$ownerInfo}/photo/fans#{$photo.photo_id}-{$photo@index}">
						{zoom_image lazyload = $photo_lazyload imgBlank = true url=$photo.photo_url zoomWidth=160 zoomHeight=160 imgWidth=$photo.photo_width imgHeight=$photo.photo_height}				
					</a>
				</li>
				{/if}
			{/foreach}	
			</ul>		
		</div>
	{page_navigator
		total = {$tplData.photo_list.total|default:0}
		size  = 12
		start = 0
		url   = "/data/user/getPhotos?start=#start#&size=#size#"}
	</div>	
	<div class="phpto-view">
		<div class="head">
			{if $tplData.photo_list.total > 1}
			<span class="view-button">
				<a href="javascript:void(0);" class="photo-pre" >上一张</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);" class="photo-next">下一张</a>
			</span>
			{/if}
			<a href="#" class="back">返回相册列表</a>
			<div class="page-num">
				<span class="photo-order">1</span>/<span class="photo-num">{$tplData.photo_list.total|default:0}</span>
			</div>
		</div>
		<a class="photo-view-hook" total="{$tplData.photo_list.total}" ting_uid="{$tplData.artist_info.ting_uid}" href="#">
			<img src=""/>
		</a>
	</div>
		
	{else}
	<p class="no-data">目前Ta还没有照片。</p>
	{/if}
</div>
{/if}
</div>
</div>

