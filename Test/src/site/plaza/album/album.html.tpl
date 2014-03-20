{extends file="plaza/plaza.html.tpl"}

{block name="description"}"音乐，百度音乐是中国第一音乐门户，为你提供海量正版高品质音乐，最权威的音乐榜单，最快的新歌速递，最契合你的主题电台，最人性化的歌曲搜索，让你更快地找到喜爱的音乐，带给你全新音乐体验。"{/block}
{block name="keywords"}mp3，音乐，百度音乐，音乐播放器，音乐下载{/block}

{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/albumlist.css{*version file='/static/css/albumlist.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="js" append}

<script type="text/javascript" src="/static/js/albumlist.js{*version file='/static/js/albumlist.js' prefix='?' suffix='.js'*}"></script>
{**
<script type="text/javascript" _xcompress="true">
    createClickMonkey("ting-music-plaza-album");
</script>
**}
{/block}
{block name='js-monkey-pageid'}ting-music-plaza-album{/block}

{block name="assign" append}
  {$navIndex='album'}

  {$order = $tplData.param.order}
  {$stylename = $tplData.param.stylename}
  {$area = $tplData.param.area}

  {$areaArray     = [
      "all"       => "全部",
      "cn"        => "华语",
      "western"   => "欧美",
      "jpkr"      => "日韩",
      "other"     => "其他"
  ]}
  {$styleArray    =[
      "all"       => "全部",
      "pop"       => "流行",
      "rock"      => "摇滚",
      "rb"        => "R&B",
      "hiphop"    => "嘻哈",
      "folk"      => "民谣",
      "jazz"      => "爵士",
      "electronic"=> "电子",
      "classic"   => "古典",
      "country"   => "乡村",
      "reggae"    => "雷鬼",
      "national"  => "民族",
      "newage"    => "轻音乐",
      "blues"     => "布鲁斯",
      "ost"       => "影视原声"
  ]}

  {if !array_key_exists($stylename, $styleArray)} {$stylename = "all"} {/if}
  {if !array_key_exists($area, $areaArray)} {$area = "all"} {/if}
  {if !$order || $order == "newhot" || ($order != "time" && $order != "hot")}{$order = "time"}{/if}

  

{/block}

{block name="title"}
  {if $area == "shoufa"}
    新碟首发
  {elseif $area == "new"}
    首发专辑
  {elseif $area == "all" && $stylename == "all"}
    全部专辑
  {else}
    {$areaArray[$area]}{$styleArray[$stylename]}专辑
  {/if}
{/block}

{block name="body_class_name"}
  channel
{/block}

{block name="content_main"}
	<div class="main-body" monkey="mainbody">
		{include file="plaza/album/main-body.html.tpl"}
	</div>
	<div class="sidebar" monkey="sidebar">
		{include file="plaza/album/sidebar.html.tpl" }
	</div>
{/block}
