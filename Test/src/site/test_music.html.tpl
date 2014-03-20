<!DOCTYPE HTML>
<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <meta name="application-name" content="ting！" />
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="white" />
		<link rel="stylesheet" type="text/css" href="/m/static/css/ting.css" />
	    <title>{block name='alltitle'}{block name='title'}{/block}-百度音乐{/block}</title>
		<meta content={block name='keywords'}""{/block} name="keywords"/>
		<meta content={block name='description'}"ting!（ting.baidu.com），全正版音乐资源、简单流畅的听歌体验、懂你的音乐推荐、炙手可热的歌手、志同道合的音乐知己，尽在全新的社会化音乐媒体ting!"{/block} name="description"/>
        {block name="css"}

		{/block}
    </head>
    <body>
		{block name="body"}

		{/block}
		<div id='loadingpage'></div>
		<div id='panel-mask'></div>
		<div id='panel'>
			<div id='panel-close'>
				<span id='panel-title' class='fwb'></span>
			</div>
			<div id='panel-content'>
				
			</div>
		</div>
        <div id='demo_rate' style="display: none">
            <div class='download-title'>
                请选择播放模式
            </div>
            <div class='download-content'>
                <form>
                    <div class='download-list'>
                        <div class='download-item first'>
                            <div class='radio-btn'>
                                <input type='radio' name='song' value='good' />
                            </div>
                            <div class='size-type'>
                                极速模式
                            </div>
                            <div class='size-num'>
                            </div>
                        </div>
                        <div class='download-item'>
                            <div class='radio-btn'>
                                <input type='radio' name='song' value='better' />
                            </div>
                            <div class='size-type'>
                                普通模式
                            </div>
                            <div class='size-num'>
                            </div>
                        </div>
                        <div class='download-item last cur'>
                            <div class='radio-btn'>
                                <input type='radio' name='song' value='best'/>
                            </div>
                            <div class='size-type'>
                                高质模式
                            </div>
                            <div class='size-num'>
                            </div>
                        </div>

                    </div>
                    <div class='btn-list'>
                        <span class='download-btn'>确定</span>
                        <span class='closepanel'>取消</span>
                    </div>
                </form>
            </div>
        </div>
    </body>
	{block name="js"}
		<script type="text/javascript" src="/m/static/js/jq.mobi.js"></script>
		<script type="text/javascript" src="/m/static/js/jq.css3animate.js"></script>
        <script type="text/javascript" src="/m/static/js/jq.ting.ui.js"></script>
		<script type="text/javascript" src="/m/static/js/iscroll.js"></script>
		<script type="text/javascript" src="/m/static/js/ting.js"></script>
		<script type="text/javascript" src="/m/static/js/ting.log.js"></script>
	{/block}
</html>
