{include file="widget/song_list/search_song_list.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}

{search_song_list colHighRate= true checked = false truncated=false colIndex=true songInfo=true selectAll=false colAlbum=true indexWidth="33" songWidth="190" singerWidth="120" albumWidth="130" funIcon=$funIcon moduleName="songList"|cat:$tagStyle funBtn=$funBtn songData=$tplData.tagobject.res_array  target=true}

{page_navigator total=$tplData.param.total size=$tplData.param.size start=$tplData.param.start 			url="/search/song?key={$tplData.query|escape:'url' nofilter}&{if $smarty.get.tag}tag={$tplData.father_tag}&{/if}start=#start#&size=#size#"}