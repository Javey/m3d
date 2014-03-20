{extends file="ting.html.tpl"}
{block 'title'}您访问的页面不存在{/block}
{block 'css'}
	<style type="text/css">
		.state-404 { background:url(/static/images/404.png{*version file='/static/images/404.png' prefix='?' type='static'*}) center 0 no-repeat; height:368px; font-size: 14px;padding: 196px 0 0 236px; }
		.music-body{ background: none;}
	</style>
{/block}
{block 'js'}
	<script type="text/javascript">
		(function(){
			var countDown = document.getElementById("countDown");
			var t =5;
			for (var i = 0; i < t; i++) {
				setTimeout(function () {
                    countDown.innerHTML = --t;
                    if (t == 0) {
                        window.location.href = "/"; 
                    }
                }, 1000 * i);
			};
		})();
	</script>
{/block}
{block 'content_main'}
	<div class="state-404 c9"><strong id="countDown">5</strong> 秒后返回 <a href="/">首页</a> 	 ...</div>
{/block}
