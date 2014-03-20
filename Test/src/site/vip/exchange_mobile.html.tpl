<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<meta name="application-name" content="ting！" />
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="white" />  
		<title>兑换VIP_百度音乐</title>
		<meta content={block name='description'}"ting!（ting.baidu.com），全正版音乐资源、简单流畅的听歌体验、懂你的音乐推荐、炙手可热的歌手、志同道合的音乐知己，尽在全新的社会化音乐媒体ting!"{/block} name="description"/>
		<link rel="stylesheet" type="text/css" href="/site/vip/vip_exchange_mobile.css" />

		<script type="text/javascript">
			var ting = ting || {};
			{if $smarty.server.HTTP_X_BDTIP_TAG}ting.sample = "{$smarty.server.HTTP_X_BDTIP_TAG}"{/if}
		</script>
		<script type="text/javascript" _xbuilder="true" _xcompress="true">
			var ting = ting || {};
			var httpSuccess = function( xhr ) {
				try {
					// IE error sometimes returns 1223 when it should be 204 so treat it as success, see #1450
					return !xhr.status && location.protocol === "file:" ||
						// Opera returns 0 when status is 304
						( xhr.status >= 200 && xhr.status < 300 ) ||
						xhr.status === 304 || xhr.status === 1223 || xhr.status === 0;
				} catch(e) {}

				return false;
			};	
			var parseJSON = function( data ) {
				if ( typeof data !== "string" || !data ) {
					return null;
				}
				// Make sure leading/trailing whitespace is removed (IE can't handle it)
				var rtrim = /^(\s|\u00A0)+|(\s|\u00A0)+$/g,
					data1 = data.replace( rtrim, "" );
				// Make sure the incoming data is actual JSON
				// Logic borrowed from http://json.org/json2.js
				if ( /^[\],:{}\s]*$/.test(data1.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])/g, "@")
					.replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]")
					.replace(/(?:^|:|,)(?:\s*\[)+/g, "")) ) {
					// Try to use the native JSON parser first
					return window.JSON && window.JSON.parse ?
						window.JSON.parse( data1 ) :
						(new Function("return " + data1))();

				} else {
					throw "Invalid JSON: " + data1 ;
				}
			};			
			var httpData = function( xhr, type ) {
				var data = xhr.responseText;
				// The filter can actually parse the response
				if ( typeof data === "string" ) {
					// Get the JavaScript object, if JSON is used.
					if ( type === "json" ) {
						data = parseJSON( data );
					} 
				}
				return data;
			};				
			//发送ajax请求拉取user_bar
			function getUserBar (content, url) {
				var requestDone =false;
				var getXhr = window.XMLHttpRequest && (window.location.protocol != 'file' || window.ActiveXObject) ?　
					function() {
						return new window.XMLHttpRequest();
					} :
					function() {
						try {
							return new window.ActiveXObject("Microsoft.XMLHTTP");
						} catch(e) {}
					};
				var xhr = getXhr();

				if ( !xhr ) {
					return;
				}


				url += '?_t=' + (new Date).getTime();
				xhr.open('get', url, true);
				xhr.setRequestHeader("Accept","application/json, text/javascript, */*");
				xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				// Wait for a response to come back
				var onreadystatechange = xhr.onreadystatechange = function() {
					var status = false;
					// The request was aborted
					if ( !xhr || xhr.readyState === 0 ) {

						requestDone = true;
						if ( xhr ) {
							xhr.onreadystatechange = {};
						}

					// The transfer is complete and the data is available, or the request timed out
					} else if ( !requestDone && xhr && xhr.readyState === 4 ) {
						requestDone = true;
						xhr.onreadystatechange = {};

						status = !httpSuccess( xhr ) ?
								"error" :
									"success";

						var errMsg;
						if ( status === "success" ) {
							// Watch for, and catch, XML document parse errors
							try {
								// process the data (runs the xml through httpData regardless of callback)
								data = httpData( xhr, 'json' );
							} catch(err) {
								status = "parsererror";
								errMsg = err;
							}
						}
						// Make sure that the request was successful or notmodified
						if ( status === "success") {
							content.innerHTML = data.data.html;
							if (!!window.$){
								(new Function(data.data.js)).call(data.data.html);
							} else{
								ting.userBarInit = new Function(data.data.js);
							}
							

						} else {
						}
						// Stop memory leaks
						xhr = null;

					}
				};
				
				// Send the data
				try {
					xhr.send( null );
				} catch(e) {
				}					
			}	
			try { document.execCommand('BackgroundImageCache', false, true); } catch(e) { }
			// function _xbg(o,e){ 		
			// 	if(e==='f'){
			// 		o.style.fontSize = "16px";
			// 		o.style.color = "#000"; 
			// 		if(o.value == $(o).data('default')){ o.value = '';}
			// 	} 
			// 	if(e === 'b' && !o.value){ o.style.color = "#999"; o.style.fontSize = "14px"; o.value = $(o).data('default'); }
			// }			
	    </script> 
	</head>

	<body>
		<div class="wrapper">
			<div class="header">
				<div class="login-btn">
					<a href="http://wappass.baidu.com/passport/?login&u=http://music.baidu.com/duihuan">{$tplData.loginInfo.user_bdname|default:"登录"}</a>
				</div>
			</div>

			<div class="content">
				<div class="main-content">
					<div class="banner">
						<img src="/static/images/vip/exchange_banner_mobile.png" />
					</div>

					<div class="form">
						<form id="exchange-form">
							<input type="text" id="exchange-code" autocomplete="off" data-default="请输入兑换码, 不区分大小写" onsubmit="return false" value="{$tplData.data.code}" />

							<span id="exchange-submit">
								<img src="/static/images/vip/exchange_btn_mobile.png" />
							</span>
						</form>
					</div>
				</div>

				
			</div>

			<div class="footer">
				<h3>温馨提示:</h3>
				<p>1. 请在有效期内进行兑换, 逾期兑换码将失效</p>
				<p>2. 兑换前请先登入百度帐号, 兑换的VIP时长将计入您当前登录的帐号中</p>
				<p>3. 您还可以通过电脑访问该网页进行VIP兑换</p>
			</div>
		</div>
	</body>

	<script type="text/javascript" src="/static/js/base.js"></script>

	<script type="text/javascript">
	$(function() {
		var $btnSubmit = $("#exchange-submit"),
			$formExchange = $("#exchange-form"),
			$txtExchange = $("#exchange-code"),
			logined = {if $tplData.loginInfo} true {else} false {/if},

			inputDefaultValue = $txtExchange.data("default"),

			mapMsg = {
				"22000": "恭喜", 
				"23111": "过期",
				"23112": "无效",
				"23113": "已使用",
				"23114": "已使用类似的兑换卷"
			},

			pending = false,

			init = function() {
				$txtExchange.bind("focus", function() {
					if ($.trim($txtExchange.val()) == inputDefaultValue) {
						$txtExchange.val("");
						$txtExchange.removeClass("input-default");
					};
				}).bind("blur", function() {
					if ($txtExchange.val() == "") {
						$txtExchange.val(inputDefaultValue);
						$txtExchange.addClass("input-default");
					};
				}).bind("keydown", function(e) {
					if (e.keyCode != 13) {
						return true;
					}

					//pending = true;

					//$formExchange.submit();
				});

				if (!$txtExchange.val() || $txtExchange.val() == "") {
					$txtExchange.val(inputDefaultValue);
					$txtExchange.addClass("input-default");
				};

				$formExchange.bind("submit", function(e) {
					e.preventDefault();

					var code = $txtExchange.val();

					if (inputDefaultValue == $txtExchange.val()) {
						code = "";
					}

					if (pending) {
						return;
					};

					if (!logined) {
						window.location = "http://wappass.baidu.com/passport/?login&u=http://music.baidu.com/duihuan?code=" + code;
					};

					ting.connect.paymentExchange({
						code: code
					}, null, function (result) {
						handleResult(result);
					}, function (result) {
						handleResult(result);
					})
				});

				$btnSubmit.bind("click", function(e) {
					$formExchange.submit();
				});
			},

			handleResult = function (obj) {
				pending = false;

				if (obj.errorCode == 22005) {
					return;
				};

				msg = mapMsg[obj.errorCode + ""] || "兑换码不存在或已经失效";
				msg = obj.data.msg;

				alert(msg);
			};

		init();
	});

</script>
</html>