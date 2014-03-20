
var ting = ting || {};

ting.initDownload = function(options) {
    var curButton = null, // 记录当前显示的button
        downloadInfo = options.downloadInfo,
        get = options.get,
        loginInfo = options.loginInfo,
        $vipDialog = $(".batchdown-dialog");

    /**
     * 设置哪个按钮显示
     * @param rate 码率，将会对应button id
     */
    function showButton(rate) {
        if (curButton) {
            curButton.removeClass('actived');
        }
        curButton = $('#' + rate);
        curButton.addClass('actived');
    }

    /**
     * 得到radio对应的data
     * @param $dom
     * @returns {*|{}}
     */
    function getCheckedData($dom) {
        $dom = $dom || $('.down-radio:checked');
        return $dom.parents('.li').data('data') || {};
    }

    /**
     * 初始化
     */
    function init() {
        var data = getCheckedData();
        showButton(data.rate);
        onRadioClick();
        onLoginClick();
        onDownloadClick();
        urlDownRate();
        urlCheckRate()
        tryVip();
        onPcDownloadEvent();
        onMobileDownloadClick();

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
    }

    var $mobileDownBtn = $('#telDownloadBtn');
    /**
     * radio绑定点击事件
     */
    function onRadioClick() {
        $(".down-radio").bind("click",function(){
            var data = getCheckedData($(this));

            if (data.rate == 1000) {
                $mobileDownBtn.hide();
            } else {
                $mobileDownBtn.show();
            }
            showButton(data.rate);
        });
    }

    /**
     * 登录，包括登录按钮，和登录链接
     */
    function onLoginClick() {
        $('.login-btn, .login-vip-download').on('click', function() {
            login();
            return false;
        });

        $('.login-download').on('click', function() {
            login(loginCallback);
            return false;
        });

        $('.not-vip-download').on('click', function() {
            $vipDialog.dialog("show");
        });
    }

    function loginCallback() {
        var lo = window.location,
            url = lo.protocol + '//' + lo.host + lo.pathname,
            search = lo.search,
            rate = getCheckedData().rate;
        if (search != '') {
            var reg = new RegExp('[\?&]down=(\d*)');
            if (reg.test(search)) {
                search.replace(reg, function(str) {
                    return str.split('=')[0] + '=' + rate;
                });
            } else {
                search += '&down=' + rate;
            }
        } else {
            search = '?down=' +rate;
        }
        url += search;

        window.location.replace(url);
    }

    /**
     * 登陆后刷新页面
     */
    function login(callback) {
        ting.passport.checkLogin(function(){
            if (callback) {
                callback();
            } else {
                window.location.reload();
            }
        }, function(){}, function(){}, function(){} );
    }

    /**
     * 下载事件，主要用于统计
     */
    function onDownloadClick() {
        var resourceTypeMap = ["copyrightData", "copyrightData", "grayData", "blackData"];


        $('.add-vip').bind("click",function  () {
             
             return false
        })
        $('.download').on('click', function() {
            var userInfo = ting.userInfo || {},
				userName = userInfo.userName || "",
				userId = userInfo.userId || 0,
				opt = {
					song_id: downloadInfo.song_id || 0,
					song_title: downloadInfo.title || "",
					singer_id: downloadInfo.artist_id || "",
					singer_name: downloadInfo.author || "",
					album_id: downloadInfo.album_id || "",
					ablum_name: downloadInfo.album_name || "",
					username: userName,
					ting_uid: userId,
					ref: get.from || "site",
					rate: getCheckedData().rate
				};
			if (loginInfo) {
				opt.action='loginUserClick'; //统计登录用户点击量
			}

			if (getCheckedData().rate > 128) {
				//如果登录进行统计高品质且统计所有下载量 而且在异步登录回调进行统计
				if (loginInfo)	opt.quality = 'all';
			} else {
				opt.quality = 'all';   //如果有高品质的全部下载量
			}

			opt.resource_type = resourceTypeMap[downloadInfo.resource_type];

			ting.logger.log("downmusic", opt );
//            return false;
            var $this = $(this);
            setTimeout(function() {
                location.href = $this.attr('href');
            }, 0);
            return false;
        });
    }

    /**
     * 分析url，用于登陆后刷新页面下载指定歌曲
     */
    function urlDownRate() {
        if (location.hash.indexOf('down') > -1) {
            return;
        }
        var action = location.search.substring(1).split('&');
        for (var i in action) {
            var item = action[i].split('=');
            if (item[0] == 'down') {
                location.hash = 'down';
                $('#bit' + item[1])[0].click();
                var btn = $('#' + item[1]);

                btn[0].click();
                // chrome浏览器触发a的click事件，会阻止后续页面渲染
                var adIframe = $('.downpage-adbanner .adm-iframe');
                adIframe.contents()[0].location.reload();

                break;
            }
        }
    }

    function urlCheckRate() {
        if (location.hash.indexOf('rate') > -1) {
            var action = location.hash.substring(1).split('&');
            for (var i in action) {
                var item = action[i].split('=');
                if (item[0] === 'rate') {
                    $('#bit' + item[1]).trigger('click');
                }
            }
        }
    }


    function getBtnData($dom) {
        var data = $dom.data('btndata');
        if (data) {
            data = {
                total: 1,
                songlist: [{
                    'song_title': data.songName,
                    'song_artist': data.artistName,
                    'file_url': data.songLink,
                    'file_size': data.size,
                    'file_extension': data.format,
                    'song_appendix': data.appendix
                }]
            }
        }
        return data;
    }

    function onPcDownloadEvent() {
        var $btn = $('#pcDownloadBtn'),
            $loading = $('<i class="openapp-loading loading"></i>');

        ting.openApp.init({
            appUrl: 'http://music.baidu.com/pc/download/BaiduMusic-12345643.exe'
        });
        $loading.insertAfter($btn).hide();
        $btn.on('click', function(e) {
            $loading.show();
            e.preventDefault();
            var data = getBtnData($btn);
            data = data || {
                songIds: downloadInfo.song_id,
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
    }

    // 下载到手机
    function onMobileDownloadClick() {
        $mobileDownBtn.on('click', function(e) {
            e.preventDefault();
            ting.connect.getSong({
                song_id: downloadInfo.song_id,
                rate: getCheckedData().rate
            }, null, function(data) {
                data = data.data.songList[0];
                var result = {
                    'download_url': data.songLink,
                    'from': '1001490z',
                    icon: data.songPicSmall,
                    package: '',
                    restype: 'music',
                    size: data.size,
                    sname: data.songName,
                    versioncode: '',
                    versionname: '',
                    annexation: {
                        icon: data.songPicSmall,
                        name: '百度音乐',
                        package: 'com.ting.mp3.android',
                        size: 6828251,
                        type: 'apk',
                        url: "http://music.baidu.com/cms/mobile/static/apk/BaiduMusic_pcbdshoujizhushou.apk",
                        versionname: '3.8.1'
                    }
                };
                bdRes2Exe.bdAppDownload(result);
            });
        });
//        $mobileDownBtn.tooltip({
//            str: '一键导入到手机，还能免费下载高品质音乐。',
//            pos: 'top'
//        }).tooltip('show');
//        $mobileDownBtn.tip();
    }

    init();

    // 试用代码
    function tryVip() {
        $('.try-vip-login').on('click', function() {
            login();
        });
    }
};