{extends file="vip/mod_intro_template_without_desc.html.tpl"}
{block name="service_detail"}
	<div class="yinxiao-top">
		<div class="music-box">

			<div class="start-btn toend"><button class="button large" id="play" value="Play">Pause</button></div>
			<div class="main-bd">
				<div id="indicator">
					<div class="ui-slider-range ui-widget-header ui-slider-range-min" style="width: 0%;"></div>
					<div class="ui-slider-progressbar ui-widget-header" style="width: 0%;"></div>
					<a class="ui-slider-handle ui-state-default ui-corner-all ui-state-focus ui-slider-handle-focus" hidefocus="true" style="left: 0%;"><span></span></a>
				</div>
			</div>
			<div class="vosie-box">
				<div id="vol">
					<a id="mute" class="mute"></a>
					<div id="volume" class="volume ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all">
						<div class="ui-slider-range ui-widget-header ui-slider-range-min" style="width: 0%; overflow: hidden;"></div>
						<a class="ui-slider-handle ui-state-default ui-corner-all" hidefocus="true" style="left: 100%;"><span></span></a>
					</div>
				</div>
			</div>	
			<div class="tab-yinxiao low"><button class="button large blue left big" id="switch" value="high">Switchtohigh</button></div>
			<div class="text-turn"><span class="turn-on">开</span>/<span class="turn-off red">关</span></div>
			<div class="music-time"><p id="time"><span id="current_time">00:00</span> / <span id="total_time">00:00</span></p></div>
			<div class="music-name">正在播放：<span class="now-name"></span><span class="kbps">_音效增强</span></div>


		</div>
		<div class="yinxiao-list">
			<ul>
				<li>01 流行：青花瓷 </li>
				<li>02 摇滚：Enter Sandman </li>
				<li>03 民谣：加州旅馆</li>
				<li>04 舞曲：江南Style</li>
				<li>05 爵士：Fly Me To The Moon </li>				
				<li>06 古典：贝多芬第五交响曲</li>
			</ul>
		</div>

		<div class="music-share">
			<span style="float:left;line-height:28px;">分享到：</span>
			<!-- Baidu Button BEGIN -->
			<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
			<a class="bds_qzone"></a>
			<a class="bds_tsina"></a>
			<a class="bds_renren"></a>
			<a class="bds_tqq"></a>
			<span class="bds_more"></span>
			</div>
			<!-- Baidu Button END -->			
		</div>
	</div>
	<div class="yinxiao-intro">
		<div class="yinxiao-mid">
			<div class="tiyanbtn1"><a href="http://play.baidu.com/" target="_blank"></a></div>
			<div class="tiyanbtn2"><a href="http://music.baidu.com/app/android" target="_blank"></a></div>
		</div>
		<div class="yinxiao-bot"></div>
	</div>
{literal}
	<style>
		/*.music-main-body {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao_bg.jpg) no-repeat center 0 #e3e3e3;
		  height:2200px;
		}*/
		.yinxiao-top {
		  width:724px;
		  height:180px;
		  margin:25px 0 0;
		  padding: 9px 0 0 20px;
		  position:relative;
		  overflow: hidden;
		  background: url(/static/images/vip/home/playbackenhance_player_bg.png);
		}
		.yinxiao-mid {
		  width:790px;
		  height:90px;
		  padding:418px 0 0 84px;
		  overflow:hidden;
		}
		.yinxiao-bot {
		  width:345px;
		  height:500px;
		  margin:255px 0 0 315px;
		}

		.yinxiao-intro {
			margin-top: 63px;
			height: 1725px;
			background: url(/static/images/vip/home/playbackenhance_intro_bg.png) no-repeat;
			_background: none;
    		_filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='corp',src='/static/images/vip/home/playbackenhance_intro_bg.png');
		}
		.tiyanbtn1 {
		  width:131px;
		  height:34px;
		  float:left;
		  margin:0;
		}
		.tiyanbtn1 a {
		  display:block;
		  width:131px;
		  height:34px;
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-btn1.jpg) no-repeat;
		}
		.tiyanbtn1 a:hover {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-btn2.jpg) no-repeat;
		}
		.tiyanbtn2 {
		  width:130px;
		  height:34px;
		  float:left;
		  margin:0 0 0 92px;
		  display:inline;
		}
		.tiyanbtn2 a {
		  display:block;
		  width:130px;
		  height:34px;
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-btn3.jpg) no-repeat;
		}
		.tiyanbtn2 a:hover {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-btn4.jpg) no-repeat;
		}
		.desgin-sm1 {
		  width:345px;
		  height:36px;
		  line-height:18px;
		  overflow:hidden;
		  color:#000;
		}
		.desgin-sm2 {
		  width:345px;
		  height:36px;
		  line-height:18px;
		  overflow:hidden;
		  color:#000;
		  margin-top:410px;
		}
		.music-box {
		  width:800px;
		  height:80px;
		  float:left;
		  position:relative;
		  
		}
		.yinxiao-list {
		  width:700px;
		  height:60px;
		  float:left;
		  margin-top:21px;
		  overflow:hidden;
		}
		.yinxiao-list ul {
		  width:700px;
		  overflow:hidden;
		  height:60px;
		  margin:10px 0 0 0;
		}
		.yinxiao-list ul li {
		  width:200px;
		  float:left;
		  cursor:pointer;
		  margin-right:30px;
		  height:24px;
		  line-height:24px;
		  color:#fff;
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-list2.png) right no-repeat;
		  _background:none;
		}
		.yinxiao-list ul li.now {
		  color:#aa89bd;
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-list1.png) right no-repeat;
		  _background:none;
		}
		.topic-right {
		  display:none;
		}
		.kbps {
		  display:none;
		}
		/**/
		.start-btn {
		  width:65px;
		  height:65px;
		  float:left;
		  margin:15px 0 0 4px;
		  overflow:hidden;
		  cursor:pointer;
		  display:inline;
		}
		.start-btn.tostar {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-startbtn.jpg) no-repeat;
		}
		.start-btn.toend {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-stopbtn.jpg) no-repeat;
		}
		.main-bd {
		  width:295px;
		  height:25px;
		  float:left;
		  margin:35px 0 0 15px;
		  display:inline;
		}
		.vosie-box {
		  width:85px;
		  height:18px;
		  float:left;
		  margin:38px 0 0 15px;
		  display:inline;
		  overflow:hidden;
		}
		.tab-yinxiao {
		  width:130px;
		  height:52px;
		  float:left;
		  margin:19px 0 0 20px;
		  display:inline;
		  overflow:hidden;
		}
		.tab-yinxiao.low {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-switch1.png) no-repeat;
		  _background:none;
		  _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod="crop",src="http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-switch1.png");
		}
		.tab-yinxiao.mid {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-switch3.png) no-repeat;
		  _background:none;
		  _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod="crop",src="http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-switch3.png");
		}
		.tab-yinxiao.high {
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-switch2.png) no-repeat;
		  _background:none;
		  _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod="crop",src="http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-switch2.png");
		}
		.text-turn {
		  width:44px;
		  height:18px;
		  line-height:18px;
		  font-size:16px;
		  color:#535353;
		  float:left;
		  margin:37px 0 0 20px;
		  display:inline;
		  font-weight:bold;
		}
		.text-turn.red {
		  color:#ff0036;
		}
		.music-time {
		  width:90px;
		  height:16px;
		  color:#535353;
		  position:absolute;
		  top:60px;
		  left:298px;
		}
		.music-name {
		  position:absolute;
		  top:0;
		  left:0;
		  text-align:center;
		  width:100%;
		  font-size:14px;
		  font-weight:bold;
		  color:#000;
		  display:none;
		}




		#indicator {
		    position: relative;
		    height: 5px;
		    width: 100%;
		    cursor: pointer;
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-indicator.jpg) no-repeat;
		  margin:10px auto;
		}
		#indicator .ui-slider-progressbar{
		    position: absolute;
		    top: 0;
		    left: 0;
		    height: 5px;
		    background-color: #CCC;
		    font-size: 0;
		}
		#indicator .ui-slider-range {
		    position: absolute;
		    top: 0;
		    left: 0;
		    height: 5px;  
		  background:url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-ui-slider.jpg) repeat-x;
		    z-index: 2;
		}
		#indicator .ui-slider-handle{
		    height: 24px;
		    width: 24px;
		    position: absolute;
		    z-index: 3;
		    margin: -10px 0 0 -10px;
		    background: url(http://ting.baidu.com/cms/topics/tpl_topic/images/list-radio.png);
		    _background:none;_filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod="corp",src="http://ting.baidu.com/cms/topics/tpl_topic/images/list-radio.png");
		}
		/*.high {*/
		  /*background:#2187e7; */
		/*}*/
		#set_time_indicate {
		    position: absolute;
		    display: none;
		    text-align: center;
		    border: 1px solid #2187e7;
		    padding: 1px 4px;
		    background-color: #fff;
		    color: #2187e7;
		    border-radius: 2px;
		  box-shadow:0px 0px 2px #2187e7;
		}
		.button{
		background: none;
		border:none;
		cursor: pointer;
		padding: 0;
		margin: 0;
		float: left;
		}
		.button.large{
		  width: 65px;
		  height: 65px;
		  text-indent: 100px;
		  overflow: hidden;
		}
		.button.large:active{
		  top: 2px;
		}
		.button.big{
		  width: 130px;
		  height: 52px;
		  text-indent: 500px;
		  position: relative;
		  z-index: 999;
		}
		.button.red{
		  color: #fff;
		  text-shadow: 0 1px 0 rgba(0,0,0,.2);
		  background-color: #c43c35;
		  border-color: #c43c35;
		}

		.button.red:hover{
		  background-color: #ee5f5b;
		}

		.button.red:active{
		  background: #c43c35;
		}
		#vol {
		    width: 116px;
		    height: 20px;
		    overflow: hidden;
		}
		#time {
			font-size: 12px;
		}
		.mute{
		    display: block;
		    cursor: pointer;
		    margin-top: 2px;
		    height: 13px;
		    width: 14px;
		    float: left;
		    background: url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-mute.jpg) no-repeat;
		}
		.muted{ /**静音*/
		    background: url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-muteon.jpg) no-repeat;
		}
		.volume {
		    position: relative;
		    margin-top: 7px;
		    width: 47px;
		    height: 3px;
		    background:#c1c0c0;
		    left: 26px;
		}
		#volume  .ui-slider-range {
		    position: absolute;
		    top: 0;
		    left: 0;
		    height: 3px;
		  background:#4c98df;
		    z-index: 2;
		    font-size: 0;
		}
		#volume  .ui-slider-handle{
		    height: 14px;
		    width: 14px;
		    position: absolute;
		    cursor: pointer;
		    z-index: 3;
		    margin: -5px 0 0 -5px;
		    background: url(http://ting.baidu.com/cms/topics/tpl_topic/images/yinxiao-volurido.jpg) no-repeat;
		}
		.mod-info{
			overflow: visible;
		}
		.music-share{
			position: absolute;
			top:33px;
			right: -70px;
			overflow: hidden;
		}
	</style>


	<script type="text/javascript">

	var log = function() {}

	window.onload = function() {
	    $.getScript('http://ting.baidu.com/cms/topics/tpl_topic/js/mbox_player.mini.js',
	        function() {
	            var links = [{
	                def: "http://s0.musiccdn.baidu.com/sq/demo?mid=0",
	                eff: "http://s0.musiccdn.baidu.com/sq/demo?mid=1"
	            }, {
	                def: "http://s0.musiccdn.baidu.com/sq/demo?mid=10",
	                eff: "http://s0.musiccdn.baidu.com/sq/demo?mid=11"
	            }, {
	                def: "http://s0.musiccdn.baidu.com/sq/demo?mid=6",
	                eff: "http://s0.musiccdn.baidu.com/sq/demo?mid=7"
	            }, {
	                def: "http://s0.musiccdn.baidu.com/sq/demo?mid=2",
	                eff: "http://s0.musiccdn.baidu.com/sq/demo?mid=3"
	            }, {
	                def: "http://s0.musiccdn.baidu.com/sq/demo?mid=8",
	                eff: "http://s0.musiccdn.baidu.com/sq/demo?mid=9"
	            }, {
	                def: "http://s0.musiccdn.baidu.com/sq/demo?mid=4",
	                eff: "http://s0.musiccdn.baidu.com/sq/demo?mid=5"
	            }],
	                curType = "def", //def 普通， eff 增强
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
	                        player.setUrl(links[index][curType]);
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

	            $('#switch').on('click', function() {
//	                if (this.innerHTML == 'Loading...') {
//	                    return false;
	                if (this.innerHTML == 'Switchtohigh') {
	                    $('.tab-yinxiao').removeClass('mid');
	                    $('.tab-yinxiao').removeClass('low');
	                    $('.tab-yinxiao').addClass('high');
	                    playerControl(player, 'high');
	                    $('.turn-on').addClass('red');
	                    $('.turn-off').removeClass('red');
	                } else {
	                    $('.tab-yinxiao').removeClass('high');
	                    $('.tab-yinxiao').removeClass('mid');
	                    $('.tab-yinxiao').addClass('low');
	                    playerControl(player, 'low');
	                    $('.turn-off').addClass('red');
	                    $('.turn-on').removeClass('red');
	                }
	            });

	            // 设置播放时间进度（由一系列响应函数组成）
	            (function() {
	                var slideup = function(e, timeMS_INT) {
	                    //if ($('#play')[0].innerHTML == 'Pause') {

	                    if ($('#switch')[0].innerHTML == 'Switchtohigh') {
	                        pl.setMute(true); //low playing
	                    } else {
	                        player.setMute(true);
	                        //timeMS_INT = timeMS << 0;
	                        if (under_high_loaded_region(timeMS_INT)) { //跳跃的时候命中缓存
	                            var cache_url = under_high_loaded_region(timeMS_INT),
	                                start = high_loaded_region[cache_url].start;
	                            //log("skip cache_url=" + cache_url + ", start=" + start + ",timeMS=" + timeMS);
	                            //跳跃时的high进度计算，应该使用high的start时间，和当前low的position，即timeMS的差值,即为当前high对应的播放进度
	                            pl.setCurrentPosition(timeMS_INT - start);
	                            usedCache = true;
	                            log("kick skip !!!!!!!!!!"); //命中跳转缓存
	                            log("high cached url: " + under_high_loaded_region(timeMS_INT));
	                        } else {
	                            //pl.setUrl(seekto(high_url, timeMS_INT));
	                            high_seek_handler(pl, timeMS_INT, function() {
	                                $('#switch').html('Switchtolow');
	                            }, true); //第四个参数true，表示不需要切换静音内核，即为高品质到高品质的跳转
	                        }
	                        pl.play();
	                    }
	                    //低质的必须同步滚动，高质的不需要，因为每次都重头seek
	                    //但加了缓存控制之后，不是每次都重新seek的，所以也需要high: pl.setCurr...()
	                    player.setCurrentPosition(timeMS_INT); //每次切都回退1.5s，与动态请求的MP3保持同步

	                    //}

	                };
	                $slider = $('#indicator').slider({
	                    animate: 175,
	                    max: 10000,
	                    min: 0,
	                    orientation: "horizontal",
	                    progressbar: true,
	                    progress: 0,
	                    constraintProgress: true,
	                    range: 'min',
	                    value: 0
	                }).bind('slidestart', function() {
	                    this.isSliding = true;
	                }).bind('slidestop', function(e, data) {
	                    this.isSliding = false;
	                    //self.trigger('change:position', this, data.value * self.get('totalTime') / 10)
	                    slideup(e, data.value * player.getTotalTime() / 10000); //单位ms
	                });
	                var setMute = function(mute) {
	                    global_mute = mute;
	                    if (mute) {
	                        pl.setMute(mute);
	                        player.setMute(mute);
	                    } else {
	                        if (curType === "eff") {
	                            pl.setMute(false);
	                        } else {
	                            player.setMute(false);
	                        }
	                    }
	                };

	                $('#volume').slider({
	                    animate: true,
	                    max: 100,
	                    min: 0,
	                    orientation: 'horizental',
	                    progressbar: false,
	                    range: 'min',
	                    value: 100
	                }).bind('slide', function(e, data) {
	                    pl.setVolume(data.value);
	                    player.setVolume(data.value);
	                });

	                $('#mute').bind('click', function() {
	                    var bol = $(this).hasClass('muted');
	                    setMute(!bol);
	                    $(this)[bol ? "removeClass" : "addClass"]('muted');

	                });

	            })();
	            player.setEventListener(player.EVENTS.PROGRESS, function(e) {

	                $slider.slider('progress', e.progress * 10000);
	            });

	            player.setEventListener(player.EVENTS.POSITIONCHANGE, function(e) {
	                $('#current_time')[0].innerHTML = player.getCurrentPositionString();
	                $('#total_time')[0].innerHTML = player.getTotalTimeString();
	                if (!$slider[0].isSliding) {
	                    $slider.slider('option', 'value', e.position / player.getTotalTime() * 10000);
	                }
	            });
	            player.setEventListener(player.EVENTS.STATECHANGE, function(e) {
	                if (e.newState === "end") {
	                    playByIndex(index + 1);
	                }
	            })

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
	                            curType = "eff";

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
	                    curType = "def";
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

	            //检查切换时间点是否在缓存区间内

	            function under_high_loaded_region(current) {
	                var current = current || 0;
	                //log("current: "+ current +", high_loaded_region:");
	                //log(high_loaded_region);
	                var bingo_regions = [], //用于排序返回最大区间
	                    max_end = 0,
	                    max_url = '';
	                //for(var i = 0, len = high_loaded_region.length; i<len; i++){
	                for (var i in high_loaded_region) { //此时的 high_loaded_region == Object

	                    //擦!!这里竟然把i++;和i<len;位置搞反了，结果导致i直接从1开始循环，汗。。。。
	                    var start = high_loaded_region[i].start << 0,
	                        end = high_loaded_region[i].end << 0;
	                    //log(start);
	                    //log(end);
	                    if (current >= start && current < end) {
	                        //如果命中缓存，则返回缓存链接
	                        //log("kick!!!!!!!!!!");
	                        //return seekto(high_url, start);
	                        //return i; //key i is a url
	                        bingo_regions.push({
	                            'url': i,
	                            'end': end
	                        });
	                        //这里可以进一步优化，假如多个区间满足时，返回end最大的点之类，让缓存更有效的利用
	                    }
	                }

	                var len = bingo_regions.length;
	                if (len === 0) {
	                    return false; //没有命中缓存区间，无缓存
	                }

	                //返回排序最大的end，利用最佳的缓存区间
	                for (var j = 0; j < len; j++) {
	                    if (bingo_regions[j].end > max_end) {
	                        max_end = bingo_regions[j].end;
	                        max_url = bingo_regions[j].url;
	                    }
	                }

	                return max_url;
	            }

	            //切换到高品质是缓存没命中，需要重新请求seek的时候
	            //第四个参数表示不切换静音内核, 用于从高品质跳到高品质时的处理，默认 unSwitch = false, 即默认会进行切换
	            //貌似从高品质到高品质不可避免的需要停顿，因为无法存在两个高品质同时播放，除非用低品质来替换，但也不合适

	            function high_seek_handler(pl, playPosition, callback, unSwitch) {

	                var playPosition = playPosition || 0;

	                if (!pl) {
	                    return false;
	                }
	                pl.setUrl(seekto(high_url, playPosition));

	                //当setURL()而且loadProgress>0之后，再进行静音内核的切换，期间为loading状态
	                $('#switch')[0].innerHTML = 'Loading...';


	                var loop_high_load = 0,
	                    loop_time = 10000 / 250; //ms = 10s / 0.25 = 40次
	                (function() {
	                    loop_high_load = pl.getLoadedPercent();
	                    if (loop_high_load > 0) {
	                        if (!unSwitch) { //默认的unSwich == false时，进行静音内核切换
	                            player.setMute(true);
	                            pl.setMute(global_mute);
	                        }
	                        callback();
	                        curType = "eff";
	                    }
	                    log("loop_high_load =" + loop_high_load);

	                    loop_time-- && !loop_high_load && setTimeout(arguments.callee, 250);
	                })();

	                firstSeek = playPosition;
	                usedCache = false;
	            }


	            //根据时间点生成动态请求url地址

	            function seekto(url, ms, key) {
	                /* var key = key || '.mp3', seek = '';
	        //alert(key + "=="+url.indexOf(key))
	        if (url.indexOf(key) === -1) {
	            seek = url + '?seek=' + ms;
	        } else {
	            var urls = url.split(key);
	            seek = urls[0] + '/seek/' + ms + key;
	        }*/

	                return encodeURI(url + "&seek=" + ms);
	            }

	            function play() {
	                pl.stop();
	                player.stop();
	                if (curType === "eff") {
	                    pl.setUrl(links[index]['eff']);
	                    pl.play();
	                }
	                player.setUrl(links[index]['def']);
	                player.play();
	            };
	            var songNma = ["青花瓷_320Kbps", "Enter Sandman_320Kbps", "加州旅馆_320Kbps", "江南Style_320Kbps", "Fly Me To The Moon_320Kbps", "贝多芬第五交响曲_320Kbps"];

	            function playByIndex(i) {
	                index = i % links.length || 0;
	                default_url = links[index]['def'];
	                high_url = links[index]['eff'];
	                high_loaded_region = [];
	                firstSeek = 0;
	                play();
	                $('.music-name').show();
	                $(".now-name").html(songNma[index]);
	                $('.yinxiao-list ul li').eq(index).addClass('now').siblings().removeClass('now');
	                $('.start-btn').removeClass('tostar');
	                $('.start-btn').addClass('toend');
	                $('#play').html('Pause');

	            };
	            $('.yinxiao-list ul li').click(function() {
	                var Index = $(this).index();
	                playByIndex(Index);
	                $(this).tip().tip("tipup", {
	                    msg: "使用耳机或音响试听体验更完美"
	                })
	            });
	            playByIndex(0);


	        }
	    )
	}
	</script>
{/literal}
{/block}
