var ting = ting || {};

ting.initBatchDownload = function(options) {
	var curButton = null,
		downloadInfo = options.downloadInfo,
		loginInfo = options.loginInfo,
		pagelog = "batchdown",

		$btnTTPlayer = $("#btnTTPlayer"),
		$vipDialog = $(".batchdown-dialog"),

		init = function() {
			var data = getCheckedData();

			// console.log(loginInfo)

			showButton(data.rate);
			showAddtionalTips(data.rate, downloadInfo.count);

			bindRadioClick();
			bindLoginClick();

			urlDownRate();
            urlCheckRate();

            onPcDownloadEvent();

			$btnTTPlayer.bind("click", function() {
				var opt = {
					page: pagelog,
					pos: "install_qianqian"
				};

				ting.logger.log("click", opt);
			});

			$vipDialog.dialog({
				confirm: {
					btn: ".vip-success-btn",
					callback: function() {
						loginCallback();
					}
				},

				cancel: {
					btn: ".vip-fail-btn",
					callback: function() {
						
					}
				},

				bgiframe: false,

				close: {
					callback: function() {
						
					}
				},

				width: 240
			});
		},

		showButton = function(rate) {
			if (curButton) {
				curButton.removeClass('actived');
			}
			curButton = $('#' + rate);
			curButton.addClass('actived');
		},

		getCheckedData = function($dom) {
			$dom = $dom || $('.down-radio:checked');
			return $dom.parents('.li').data('data') || {};
		},

		showAddtionalTips = function(checkRate, count) {
			var str = "";
			if (+checkRate == 1000) {
				str = "无损品质文件较大，建议您使用百度音乐PC版进行下载，支持断点续传、速度更快、更稳定。<br />";
			} else {
				str = "推荐使用百度音乐PC版进行批量下载，支持断点续传、速度更快、更稳定。"
			}

			if (count > 50) {
				str = "您选择的歌曲数目较多，请减少到<span class='red'>50首以内</span>；或安装百度音乐PC版进行批量下载。"
			}

			if (str == "") {
				$("#addtion-tips").hide();
			} else {
				$("#addtion-tips").show();
			}

			$("#addtion-tips").html(str);
        },

		/**
		 * radio绑定点击事件
		 */
		bindRadioClick = function() {
			$(".down-radio").bind("click", function() {
				var data = getCheckedData($(this));

				showButton(data.rate);

				showAddtionalTips(data.rate, downloadInfo.count);
			});
		},

		/**
		 * 登录，包括登录按钮，和登录链接
		 */
		bindLoginClick = function() {
			$('.login-btn, .login-vip-download, .login-download').on('click', function() {
				var opt = {
					page: pagelog,
					pos: "viplogin"
				};

				ting.logger.log("click", opt);

				login(loginCallback);
				return false;
			});

			$('.not-vip-download').on('click', function() {
				$vipDialog.dialog("show");

				var opt = {
					page: pagelog,
					pos: "bevip"
				};

				ting.logger.log("click", opt);

				
			});

			$('.download').on('click', function() {
				var opt = {
					sub: getCheckedData().rate,
					page: pagelog,
					pos: "multi_down"
				};
				//记录用户的下载记录
				ting.connect.recorddown({song_id:opt.downloadInfo.songIds},null,function(result){});
				ting.logger.log("click", opt);
			})
		},

		loginCallback = function() {
			var lo = window.location,
				url = lo.protocol + '//' + lo.host + lo.pathname,
				search = lo.search,
				rate = getCheckedData().rate;

			if (search != '') {
				var reg = new RegExp('[\?&]rate=(\d*)');
				if (reg.test(search)) {
					search.replace(reg, function(str) {
						return str.split('=')[0] + '=' + rate;
					});
				} else {
					search += '&rate=' + rate;
				}
			} else {
				search = '?rate=' + rate;
			}

			url += search;

			url += "#download";

			window.location.replace(url);
		},

		/**
		 * 登陆后刷新页面
		 */
		login = function(callback) {
			ting.passport.checkLogin(function() {
				if (callback) {
					callback();
				} else {
					//window.location.reload();
				}
			}, function() {}, function() {}, function() {});
		},

		/**
		 * 分析url，用于登陆后刷新页面下载指定歌曲
		 */

		urlDownRate = function () {
			var action = location.search.substring(1).split('&');
			for (var i in action) {
				var item = action[i].split('=');
				if (item[0] == 'rate' && location.hash == "#download") {
					location.hash = "";
					$('#bit' + item[1])[0].click();
					var btn = $('#' + item[1]);

					btn[0].click();

					break;
				}
			}
        },

        urlCheckRate = function() {
            if (location.hash.indexOf('rate') > -1) {
                var action = location.hash.substring(1).split('&');
                for (var i in action) {
                    var item = action[i].split('=');
                    if (item[0] === 'rate') {
                        $('#bit' + item[1]).trigger('click');
                    }
                }
            }
        },

        onPcDownloadEvent = function () {
            var $btn = $('#btnTTPlayer'),
                $loading = $('<i class="openapp-loading loading"></i>');

            ting.openApp.init({
                appUrl: 'http://music.baidu.com/pc/download/BaiduMusic-12345644.exe'
            });
            $loading.insertAfter($btn).hide();
            $btn.on('click', function(e) {
                $loading.show();
                e.preventDefault();
                var data = {
                    songIds: downloadInfo.songIds,
                    rate: getCheckedData().rate
                };
                openApp.dowloadSong(data, {
                    success: function() {
                        $btn.tip("tipup", {msg:"添加任务成功！", iconClass:"tip-success"});
                    },
                    error: function() {
                        $btn.tip("tipup", {msg:"添加任务失败！", iconClass:"tip-error"});
                    },
                    complete: function() {
                        $loading.hide();
                    }
                });
            });
            $btn.tooltip({
                str: '专享高品质音乐免费下载，速度更快、更稳定。'
            }).tooltip('show');
            $btn.tip();
        };

	init();
};