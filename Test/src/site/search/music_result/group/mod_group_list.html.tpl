
{if $tplData.rqt_type==2 && $tplData.albumobject.res_array}
	{include file="search/music_result/group/mod_group_album.html.tpl"}
{/if}
{if $tplData.rqt_type==6 &&  $tplData.listobject.res_array}
	{include file="search/music_result/group/mod_group_songlist.html.tpl"}
{/if}
{if $tplData.rqt_type==3 && $tplData.mvobject.res_array}
	{include file="search/music_result/group/mod_group_mv.html.tpl"}
{/if}
{if ($tplData.rqt_type==4||$tplData.rqt_type==1) &&  $tplData.artistobject.res_array}
	{include file="search/music_result/group/mod_group_artist.html.tpl"}
{/if}