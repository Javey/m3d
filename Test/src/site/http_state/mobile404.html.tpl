{extends file="ting.html.tpl"}
{block 'title'}您访问的页面不存在{/block}
{block 'css'}
	<style type="text/css">
		.state-404 { font-family: Microsoft YaHei,"幼圆";
font-weight: 500;
font-size: 22px;
line-height: 24px; background:url(/static/images/error404-mobile.png) center 0 no-repeat; height:368px; font-size: 14px;padding: 160px 0 0 160px; }
h2{ font-size: 24px; line-height: 26px; margin-bottom: 20px;}
p{ line-height: 36px;font-size: 16px}
.music-body{ background: none;}
a{ text-decoration:underline;}
	</style>
{/block}
{block 'js'}{/block}
{block 'content_main'}
	<div class="state-404">
		<h2>亲爱的用户：</h2>
		<p>该专题是手机版独享内容</p>
		<p style="margin-bottom:20px;">欢迎使用手机版发现更多精彩～</p>
		<p><a href="/mobile?fr=motopic" target="_blank">下载百度音乐手机版</a></p>
	</div>
{/block}
