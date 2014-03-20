
{include "widget/adm/adm.html.tpl" inline}
{if !$smarty.get.clearadv}
<div class="downpage-adbanner">
	{if $tplData.data.song.song_id}

		{$extraArgs = ["downloadsongid" => $tplData.data.song.song_id,"songid" => $tplData.data.song.song_id, "downloadartistname" =>$downloadInfo.author , "downloadartistid"=>$downloadInfo.artist_id , "downloadsongname"=> $downloadInfo.title ]}
	{else}
		{$extraArgs = []}
	{/if}
	{if $tplData.data.song.song_id==72624708}
	{adm 
		id = "776445"
		class = "ad-banner ecomad-banner-loading"
		width = 728
		extraArgs = $extraArgs
	}
	{else}
	{adm 
		id = "636"
		class = "ad-banner ecomad-banner-loading"
		width = 728
		extraArgs = $extraArgs
	}
	{/if}
</div>
{/if}
