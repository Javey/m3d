{extends file="vip/mod_intro_template_with_desc.html.tpl"}
{block name="service_intro"}
	<p>VIP会员享受更高品质(320Kbps MP3)及320音效增强音乐播放权利。</p>
{/block}
{block name="service_detail"}
	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>特权体验</h2>
	</div>
	<div class="vip-privilege-block-split"></div>

	<div>
		<p>方式一: 直接试听对比</p>

		<div class="preview_list">
			<ul class="clearfix">
				<li>
					<a class="preview_super" href="javascript:void(0);"></a>
				</li>

				<li>
					<a class="preview_high" href="javascript:void(0);"></a>
				</li>

				<li>
					<a class="preview_standard" href="javascript:void(0);"></a>
				</li>

			</ul>
		</div>

		<p>方式二: 去音乐盒体验</p>
		<div class="vip-intro-pic"></div>
	</div>

{literal}
	<style>
		.vip-intro-pic {
			margin-left: 0;
			width: 733px;
			height: 510px;
			background: url(/static/images/vip/home/superplay_inner.png) no-repeat;
			_background: none;
			_filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='corp',src='/static/images/vip/home/superplay_inner.png');
		}

		.preview_list {
			width: 700px;
			margin: 20px 0 25px;
			padding: 0 0 0 8px;
		}

		.preview_list ul li {
			float: left;
			width: auto;
			height: auto;
		}

		.preview_list a {
			cursor: pointer;
			display: block;
		}
	</style>

	<script type="text/javascript">
	window.onload = function() {
		$.getScript('http://ting.baidu.com/cms/topics/tpl_topic/js/mbox_player.mini.js',
			function() {
				var links = [
						"http://ting.baidu.com/cms/vipqhc3.mp3",
						"http://ting.baidu.com/cms/vipqhc2.mp3",
						"http://ting.baidu.com/cms/vipqhc.mp3"
					],
					default_url = "",
					high_url = "",
					global_mute = false,
					index = 0;

				//首次进行高品质seek的时间点
				var firstSeek = 0; //全局
				//切换到high时是否利用了cache
				var usedCache = false; //全局
				//高品质已加载区间, 多段式存储
				var high_loaded_region = []; //全局    //seektime 1:[{start:1000,end:5000},]
				//500ms为后端默认回退时间
				var defaultBacktime = 500; //全局

				var $slider = null;


				// 初始化播放核心
				var player = window.player = initPlayer('player'); //high player//全局
				player.init();
				var pl = window.pl = initPlayer('pl'); //low player//全局
				player.setVolume(100);

				if (T.browser.chrome && T.browser.chrome < 27) {
					pl.init();
					pl.setVolume(100);
				} else { //修复chrome flash加载bug
					(function() {
						var tryTime = 3000 / 60;

						function checkFMPLoaded() {

							if (player.curEngineType !== "fmp_mp3" || player.curEngine.flashLoaded) {
								pl.init();
								pl.setVolume(100);
								//cnsole.log('player_flash_loaded')
							} else if (tryTime--) {
								setTimeout(checkFMPLoaded, 60);
							} else {
								pl.init({
									subEngines: pl.subEnginesConf.reverse()
								});
								pl.setVolume(100);
							}
							//console.log(tryTime, player.curEngine.flashLoaded);
						}
						checkFMPLoaded();
					})();
				}


				$('#play').click(function() {

					if (this.innerHTML == 'Play') {

						pl.play();

						if (!player.getUrl()) {
							player.setUrl(links[index]);
						}
						player.play();

						this.innerHTML = 'Pause';
						$('.start-btn').removeClass('tostar');
						$('.start-btn').addClass('toend');
					} else {

						pl.pause();
						player.pause();

						this.innerHTML = 'Play';
						$('.start-btn').removeClass('toend');
						$('.start-btn').addClass('tostar');

					}

				});


				//$$('stop').onclick = function() {
				//    player.stop();
				//};

				function playerControl(player, core) {

					log('============ Switch start ===========');

					//普通品质播放进展
					var playPosition = player.getCurrentPosition() << 0,
						totalTime = player.getTotalTime() << 0,
						playProgress = playPosition / totalTime;

					log("low_playPosition: " + playPosition);
					log("low_totalTime: " + totalTime);
					log("low_playProgress %" + ((playProgress * 100) << 0));

					//高品质播放进展
					var high_playPosition = pl.getCurrentPosition() << 0, //用于记录high的播放时间，因为high长度是变化的
						high_totalTime = pl.getTotalTime() << 0,
						high_playProgress = high_playPosition / high_totalTime;

					log("high_playPosition: " + high_playPosition);
					log("!!!high_totalTime: " + high_totalTime);
					log("!!!high_playProgress %" + ((high_playProgress * 100) << 0));


					//各品质加载情况
					var low_loadProgress = player.getLoadedPercent(),
						high_loadProgress = pl.getLoadedPercent();
					log("low  loadProgress %" + ((low_loadProgress * 100) << 0));
					log("!!!high loadProgress %" + ((high_loadProgress * 100) << 0));

					//高品质已加载时长，用于缓存
					var high_loadTime = (high_totalTime * high_loadProgress); //ms


					if (core == 'high') {

						log('Switched to high ===');
						//player.setUrl(encodeURI(high_url));
						//player.setMute(!player.getMute());
						//pl.setMute(!player.getMute());

						log('first seek: ' + firstSeek);

						if ((firstSeek && firstSeek > 0) || under_high_loaded_region(playPosition)) { //第一次或者是已经在范围内
							//且一个链接必须全部加载完成才算有效的缓存，否则不进行缓存,因为中断请求时浏览器不会进行缓存
							//if(high_loadProgress == 1){//0.99 //因为不需要重新setUrl，所以可以沿用之前加载的 high_url
							//log("get url: " + pl.getUrl());

							var seek_url = high_url;
							//"./files/shuipashui320/seek/4690.mp3" ，歌曲url+seektime能保证缓存区间的唯一性
							if (high_loaded_region[seek_url]) { // 覆盖end, 扩大区间范围，如果已经highloadtime ~ 99% 可跳出end覆盖
								high_loaded_region[seek_url].end = high_loaded_region[seek_url].start + high_loadTime;
							} else {
								high_loaded_region[seek_url] = {
									'start': firstSeek,
									'end': firstSeek + high_loadTime
								};
								firstSeek = 0;
							}

							//}
						}

						//log(playPosition + "!!!high url cached???: " + under_high_loaded_region(playPosition));

						if ($('#play')[0].innerHTML == 'Pause') {

							//待修复下面的 if(playProgress > plloadProgress) 后，打开此处
							//第一次切换，保存切换位置时间点，利用缓存
							if (!pl.getUrl()) {
								//pl.setUrl(encodeURI(high_url+"?seek=" + playPosition));
								//pl.setUrl(seekto(high_url, playPosition));
								//player.setCurrentPosition(loadProgress*player.getTotalTime());
								//pl.play();
								//当setURL()而且loadProgress>0之后，再进行静音内核的切换，期间为loading状态

								high_seek_handler(pl, playPosition, function() {
									$('#switch').html('Switchtolow').removeClass('blue');
									//$('#current_indicator').addClass('high');
								});

							} else if (high_loadProgress > 0 && under_high_loaded_region(playPosition)) {
								//直接读取缓存
								//命中缓存，不需要重新setUrl，所以可以沿用之前加载的 high_url
								//pl.setUrl(under_high_loaded_region(playPosition));
								player.setMute(true);
								pl.setMute(global_mute);

								//这里的high_playPosition再低到高切换时无法同步，但又不能直接用low的playPosition,因为总时间都不一样
								var cache_url = high_url /*pl.getUrl()*/ ,
									start = high_loaded_region[cache_url].start;
								//log("skip cache_url="+cache_url+", start="+start+",timeMS="+timeMS);
								//跳跃时的high进度计算，应该使用high的start时间，和当前low的position，即timeMS的差值,即为当前high对应的播放进度
								high_playPosition = playPosition - start - defaultBacktime; //
								pl.setCurrentPosition(high_playPosition);

								//pl.setCurrentPosition(high_playPosition - defaultBacktime - 1000);//额外增加命中缓存时回退时间

								usedCache = true;

								$('#switch').html('Switchtolow').removeClass('blue');
								// $('#current_indicator').addClass('high');

								log("kick switch!!!!!!!!!!");
								log("high cached url: " + under_high_loaded_region(playPosition));


							} else { //剩下情况可能是：回退或者是跨度跳跃（跨过了缓存区间），需重新请求，保存切换位置时间点

								if (totalTime - playPosition > defaultBacktime) {
									//剩余时间小于回退时间时，不再发起请求
									high_seek_handler(pl, playPosition, function() {
										$('#switch').html('Switchtolow').removeClass('blue');
										// $('#current_indicator').addClass('high');
									});
								}

							}

							if ($('#play')[0].innerHTML == 'Pause') {
								pl.play();
							} //复制暂停状态下，切换过来自动播放

						}

						//$('#switch')[0].innerHTML = 'Switch to low';
						//$('#switch').removeClass('blue');
						//$('#current_indicator').addClass('high');

					}

					if (core == 'low') {

						log('Switched to low ===');
						//player.setUrl(encodeURI(default_url));
						//高到低回放时，暂时使用一个固定时间来回退，如1000ms
						//后续可以设置为: current目前播放的时间 - 高品质的load所用时间
						var loadtime = 1500;
						if (usedCache) {
							loadtime = 1000;
							log("past time high used Cache = true, loadtime = " + loadtime);
						}
						var backtime = loadtime + defaultBacktime, //defaultBacktime=500ms为后端默认回退时间
							//ms 前端load所需时间highload + 后端默认的backtime
							//此处的backtime需要考虑客户端上次切换到high的时候是否利用了缓存，利用了缓存则3000ms可以降为1000ms之类的
							resumntime = playPosition;
						if (playPosition > backtime && (totalTime - playPosition > backtime)) {
							//在音频开头和结尾不进行回退
							resumntime = playPosition - backtime;
						}
						log("backtime = " + backtime + ", " + resumntime + ":" + playPosition);
						player.setCurrentPosition(resumntime);

						player.setMute(global_mute);
						pl.setMute(true);

						//$$('switch').value = 'high';
						//$('#play')[0].innerHTML = 'Play'
						$('#switch').html('Switchtohigh').addClass('blue');
						//$('#current_indicator').removeClass('high');

					}

					log("!!!low leave time=" + (totalTime - playPosition) + ",high leave time=" + (high_totalTime - high_playPosition));
					log('============ Switch end ===========');


				};

				function initPlayer(insname) {

					var pl;
					pl = new PlayEngine({
						subEngines: [{
							constructorName: 'PlayEngine_FMP_MP3', //子内核构造函数名
							args: {
								swfPath: 'http://play.baidu.com/player/static/flash/fmp.swf',
								instanceName: insname //当前实例名
							}
						}, {
							constructorName: 'PlayEngine_Audio' //子内核构造函数名
						}]
					});

					//pl.init();
					return pl;
				};


				function play() {
					pl.stop();
					player.stop();
					player.setUrl(links[index]);
					player.play();
				};

				function pause() {
					player.pause();
				}

				var songNma = ["青花瓷_320Kbps", "Enter Sandman_320Kbps", "加州旅馆_320Kbps"];

				function playByIndex(i) {
					index = i % links.length || 0;
					default_url = links[index]['def'];
					high_url = links[index]['eff'];
					high_loaded_region = [];
					firstSeek = 0;
					play();
					$('.music-name').show();
					$(".now-name").html(songNma[index]);
					$('.preview_list ul li').eq(index).addClass('now').siblings().removeClass('now');
					$('.start-btn').removeClass('tostar');
					$('.start-btn').addClass('toend');
					$('#play').html('Pause');
				};

				$('.preview_list ul li').click(function() {
					var Index = $(this).index();
					if ($(this).hasClass("now")) {
						pause();
						$(this).removeClass("now");
					} else {
						playByIndex(Index);
					}
				});
			}
		)
	}
	</script>
{/literal}
{/block}
