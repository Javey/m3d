{extends file="ajax.tpl"}
{block 'ajax_html'}
	{include file="widget/song_list/search_song_list.html.tpl" inline}
    {include file="widget/song_list/song_list.html.tpl" inline}
	{if $tplData.songList|@count > 10}
		{$btnPos = "both"}
	{else}
		{$btnPos = "bottom"}
	{/if}
	{if $smarty.get.hotbar == 1}
		{**热度条策略有问题，暂时注释掉，rochappy**}
		{$hotbar = true}
		{$colAlbum = false}
	{else}
		{$colAlbum = true}
		{$horbar = false}
	{/if}
	{if $smarty.get.moduleName}
		{$moduleName = $smarty.get.moduleName|escape:'html'}
	{else}
		{$moduleName = ""}
	{/if}
	{if $smarty.get.noAlbum}
		{$colAlbum = false}
	{/if}
	{block name="songlist"}
        {* 来自无损专区的展开列表 *}
        {if $smarty.get.from === 'lossless'}
            {song_list
                moduleName = "song"
                colHighRate = true
                songInfo = true
                songData = $tplData.songList
                funIcon = ["download","play","add"]
                funBtn = ["down"]
                songWidth = "415"
                colAlbum = false
                colSinger = false
                hotBar = false
                total = 20
                colNewIcon = false
                showChinaVoice = false
                colHotIcon = false
                colIndex = false
                showIconLine = true
                colLosslessIcon = true
                appendix = false
            }
        {else}
            {search_song_list
                colHighRate= true
                songInfo=true
                moduleName = $moduleName
                total="200"
                hotBar = $hotbar
                colIndex=true
                indexWidth="25"
                songWidth=195
                singerWidth=120
                albumWidth="100"
                btnPos=$btnPos
                selectAll=false
                colAlbum=$colAlbum
                funBtn=["play","add","collect","down"]
                funIcon=["play","add","download"]
                songData=$tplData.songList
                 target=true
            }
        {/if}
	{/block} 
{/block}
<script>
{block 'ajax_js'}

{/block}
</script>
