{extends file="ting.html.tpl"}

{**By Javey
{block name="import" append}{/block}
**}

{block name='keywords'}"{$tplData.query},歌曲大全，mp3下载,免费下载,高品质音乐"{/block}
{block name='description'}"搜索‘{$tplData.query}’歌曲、歌手、专辑、歌词资源，尽在百度音乐。百度音乐为你提供最人性化的歌曲搜索，网罗全网最全的包含‘{$tplData.query}’的歌曲、歌手、专辑、歌词，歌曲下载,MP3下载，免费试听，海量正版高品质音乐，让你更快地找到喜爱的音乐，带给你全新音乐体验。"{/block}

{block name="body_class" append}
class="search-page"
{/block}

{block name='op_monitor'}
{if !$tplData.noData == true}
<!--STATUS OK--><!--status OK--><!--xxx OK-->
{/if}
{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/mv_search.css{*version file='/static/css/mv_search.css' prefix='?' suffix='.css'*}" />
{/block}

{block name="assign" append}
  {$curpage='search'}
{/block}

{block name="js" append}
{if !isset($tplData.param) || !isset($tplData.param.start) || !isset($tplData.param.size)}
    {$page_num = 0}
{else}
    {$page_num = $tplData.param.start / $tplData.param.size + 1}
{/if}
{if $page_num <= 1}
    {$page_type = "first"}
{else}
    {$page_type = "pageturn"}
{/if}
<script type="text/javascript">
var subpage=$('#query_type').val();
ting.logger.log("clicksearch", {
    ref: 'music_web',
    key: '{$tplData.query|escape:javascript nofilter}',
    search_res: {if $tplData.noData}0{else}1{/if},
    page_type: '{$page_type}',
    page_num: '{$page_num}',
    sub: subpage
});
</script>
{/block}

{block name="content_main"}
	{if $tplData.beatle_song_id}
		{$extraArgs = ["songid" => $tplData.beatle_song_id , "musicquery"=> $tplData.query]}
	{else}
		{$extraArgs = ["musicquery"=> $tplData.query]}
	{/if}


	{if $tplData.query=='杨宗纬' || $tplData.query=='闪耀'}
		{adm
		    id = "776437"
		    class = "ad-banner ecomad-banner-loading"
		    width = 960
			extraArgs = $extraArgs
		}
	{else}
		{adm
		    id = "623"
		    class = "ad-banner ecomad-banner-loading"
		    width = 960
			extraArgs = $extraArgs
		}
	{/if}	

	{block name="search-left"}
	<div class="main-body">
		<div class="search-body main-body-cont">
                            <h1 class="music-seo">
                                搜索<strong>{$tplData.query}</strong>,<strong>{$tplData.hilight}</strong>,歌曲试听，免费下载，MP3下载，体验百度音乐高品质享受。
                            </h1>

			{block name="main-body"}{/block}
		</div>
	</div>
	{/block}<!--end search-left-->
	
	{block name="search-right"}
	<div class="sidebar">
		{block name="search-right-body"}

		{/block}
        {include file="widget/adm/adm.html.tpl" inline}
		{block name="sidebar"}{/block}
        <div class="ad">{adm id = "434556" width="224" height="130" }</div>
        <div class="ad">{adm id = "652845" width="224" height="130" }</div>
        <div class="mobile-guide clearfix">
	        <div class="mobile-icon"></div>
	        <p class="c9">手机或Pad访问更快捷 <br />music.baidu.com</p>
    	</div>
	</div>
	{/block}
	<!--end search_right-->
	
{/block}

