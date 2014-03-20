{include file="widget/song_list/search_song_list.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{* 在显示专辑的位置显示歌曲流行度 colAlbum=false searchPopular=true *}
{search_song_list colHighRate= true checked = false truncated=false colIndex=true songInfo=true selectAll=false colAlbum=false searchPopular=true indexWidth="33" songWidth="170" singerWidth="120" albumWidth="130" funIcon=$funIcon funBtn=$funBtn songData=$tplData.songobject.res_array colHotIcon=false target=true}

{page_navigator total=$tplData.param.total size=$tplData.param.size start=$tplData.param.start 			url="/search/song?key={$tplData.query|escape:'url' nofilter}&start=#start#&size=#size#"}
