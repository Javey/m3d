<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=7" />
		<title>歌词_百度音乐-听到极致</title>
	    <link rel="stylesheet" type="text/css" href="/static/css/base.css{*version file='/static/css/base.css' prefix='?' suffix='.css'*}" />
		<link rel="stylesheet" type="text/css" href="/static/css/lyric.css{*version file='/static/css/lyric.css' prefix='?' suffix='.css'*}" />
	</head>
	<body>
		<div class="search-lyric">
					<h2><strong>{$tplData.data.songInfo.title}</strong> <span class="singer-name">{$tplData.data.songInfo.author}</span></h2>
					{if $tplData.data.songInfo.lrcContent}
						{$songwriting = $tplData.songInfo.songwriting}
						{$compose = $tplData.songInfo.compose}
					<div id="lyric-txt" class="text">{$tplData.data.songInfo.lrcContent|nl2br}</div>
					<div class="module-dotted"></div>
					<div class="info">
						<span class="fot-logo"><a href="/"><img src="/static/images/music/baidu_logo.png" alt="百度" /></a></span>					
						<span class="lrc-opera"><span id="copyIcon" data-clipboard-target="lyric-txt"  class="link">复制歌词</span> | <a class="down-lrc-btn" href="{$tplData.data.songInfo.lrclink}">下载LRC歌词</a></span>
						{**
							{if $songwriting}<span id="song_writing">作词：{if $compose}{$songwriting|pixel_truncate:80}{else}{$songwriting|pixel_truncate:200}{/if}</span>{/if}
							{if $compose}<span id="song_compose">作曲：{if $songwriting}{$compose|pixel_truncate:80}{else}{$compose|pixel_truncate:200}{/if}</span>{/if}
						**}
					</div>
					{else}
					<div class="no-data">
                        <div class="no-data-inner">
                            <p class="no-data-tip">暂时还没有歌词</p> 
                        </div>
					</div>
					{/if}
		</div>

	</body>
	<script type="text/javascript" src="{#PASSPORT_URL#}/v2/api/?getapi&class=login&tpl=ti&tangram=false"></script>
	<script type="text/javascript" src="/static/js/base.js"></script>
	<script type="text/javascript" src="/static/js/ZeroClipboard.js"></script>	
	<script type="text/javascript">
	var clipboard = new ZeroClipboard( $('#copyIcon'), {
	  moviePath: "/static/flash/ZeroClipboard.swf"
	} );
	
	$('#copyIcon').tip({
		msg: '复制成功',
		iconClass: 'tip-success'
	})

    clipboard.on('complete', function (client, args) {
      $('#copyIcon').tip('tipup');
    });

	var pageId = "ting-music-song-lyric";
	(document.getElementsByTagName('head')[0]||body).appendChild(document.createElement('script')).src='http://img.baidu.com/hunter/musicmonkey.min.js';
	</script>
</html>
