{if ($tplData.rqt_type==11) && $tplData.movieobject.res_array }
  {include file="search/music_result/group_top/mod_movie.tpl" inline}
{/if}
{if ($tplData.rqt_type==10) && $tplData.joyobject.res_array }
  {include file="search/music_result/group_top/mod_joy.tpl" inline}
{/if}