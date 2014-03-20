/**
 * Created with JetBrains PhpStorm.
 * Description: 创建iQiyi MV播放器，并发送各种日志信息
 * User: zoujiawei
 * Date: 12-11-26
 * Time: 下午2:06
 * Depends： ting.logger.js
 *           (baidu.)swf.js
 */

var lib = lib || {}; // iQiyi flash依赖lib库
lib.swf = lib.swf || {};

(function ($){

    $.widget('ui.mv', {
        options: {
            width: '100%',
            height: '100%',
            chainDataElem: null,
            data: {}
        },
        eventsMap: {
            dataready: 'loadstart',
            ready: 'load',
            startplay: 'playstart',
            loadcomplete: 'loaded',
            stoped: 'playend'
        },
        // 当前播放索引, 单独拿出来，可以继承
        index: -1,

        _create: function () {
            // 当前连播mv dom
//            this.curChainMv = null;
            // 统计信息
            this.log = {};
            // 当前播放索引
//            this.index = index || -1;
            // 播放器
            this.player = null;

            this.statsRecorder();
            this.setLogInfo();
            this.bindEvent();
            this.bindLogEvent();
            this.autoPlayNextMv();
            this.createFlash();
            this.addVideoList();
            this.playerEvent();
        },

        // 创建flash
        createFlash: function (options) {
            options = options || this.options.data[0];
            if ($.swf.version) {
                $.swf.create({
                    'id': "mvFlash",
                    'width': this.options.width,
                    'height': this.options.height,
                    'url': 'http://dispatcher.video.qiyi.com/disp/shareplayer.swf',
                    'allowscriptaccess': 'always',
                    'wmode': 'opaque',
                    'allowfullscreen': true,
                    'bgcolor': '#000000',
                    'vars': {
                        vid: options.vid,
                        tvid: options.tvid,
                        autoPlay: '1',
                        autoChainPlay: '1',
                        showSearch: '0',
                        showSearchBox: '0',
                        autoHideControl: '1',
                        showFocus: '0',
                        showShare: '0',
                        showLogo: '0',
                        coop: 'coop_baidump3',
                        cid: 'qc_100001_300089',
                        bd: '1',
                        showDock: 0
                    }
                }, this.element.get(0));
            } else {
                $('.dialog-box').dialog().show();
            }
            this.player = $.swf.getMovie('mvFlash');
            this._trigger('createflashsuccess');
        },

        playerEvent: function () {
            var self = this,
                startPlay = false,
                // 用于标识是否是手动拖动进度条，用于判断是否卡断
                // 只有出现Waiting事件，并且上一次不是Seeking才认为是卡断
                isSeeking = false;

            //iQiyi player传递播放状态的函数
            if (lib.swf.notice) {
                return;
            }
            lib.swf.notice = function (obj) {
                if ($.type(obj) === 'string') {
                    obj = $.parseJSON(obj);
                }
                if (obj.type === 'playerStateChange') {
                    var state = obj.data.state;
                    self._trigger(self.getStandardEventType(state));
                    if (state === 'Seeking') {
                        isSeeking = true;
                    } else {
                        if (state === 'StartPlay') {
                            startPlay = true;
                        } else if (state === 'Playing' && startPlay) {
                            startPlay = false;
                            self._trigger('play100ms');
                        } else if (state === 'Waiting' && !isSeeking) {
//                            console.log('卡断');
                            self._trigger('speedslow');
                        }
                        isSeeking = false;
                    }
                } else if (obj.type !== 'playStateChange') {
                    self._trigger(self.getStandardEventType(obj.type));
                }
            }
        },

        // 得到标准的事件名称
        getStandardEventType: function(str) {
            str = str.toLowerCase();
            return (this.eventsMap[str] || str);
        },

        //播放状态切换时间统计
        statsRecorder: function () {
            var playStartTime = 0, //准备加载时间点
                loadTime = 0, //数据准备好
                playTime = 0, //正式播放
                bufEndTime = 0, //缓冲完成
                isNewStart = false, // 记录是新的开始，还是循环播放开始
                self = this;


            this._on({
                mvloadstart: function() {
                    playStartTime = new Date().getTime();
                    self.resetRecorder();
                    this.recorder.timestamp = new Date().getTime();
                    isNewStart = true;
                },
                mvload: function() {
                    if (isNewStart) {
                        loadTime = new Date().getTime();
                    }
                },
                mvloaded: function() {
                    if (isNewStart) {
                        bufEndTime = new Date().getTime();
                        self.recorder.buftotal = bufEndTime - playStartTime;
                    }
                },
                mvplay100ms: function () {
                    if (isNewStart) {
                        playTime = new Date().getTime();
                        self.recorder.fromstart = playTime - playStartTime;
                        self.recorder.fromload = playTime - loadTime;
                    }
                },
                mvplayend: function() {
                    isNewStart = false;
                },
                mvspeedslow: function() {
                    this.recorder.buffct++;
                }
            });
        },

        resetRecorder: function() {
            this.recorder = {
                fromload        : -1,  // 发送该统计到实际播放间的时长(从load到playsong100ms) 单位：毫秒
                fromstart       : -1,  // 发送该统计到可以播放间的时长(从playstart到playsong100ms) 单位：毫秒
                buftotal        : -1,  // 缓冲总时间(毫秒)
                buffct          :  0,  // 卡断次数
                timestamp       : -1   // 时间戳，用于日志关联
            };
        },

        // 设置播放列表
        addVideoList: function() {
            var list = [];
            $.each(this.options.data, function(index, val) {
                list.push({
                    tvid: val.tvid,
                    vid: val.vid
                });
            });
            this._on({
                mvplayerloadsuccess: function() {
                    this._callPlayer('addVideoList', {index: 0, list: list});
                }
            });
        },

        // 调用播放器方法
        _callPlayer: function(method, param) {
            if (param === undefined) {
                this.player[method]();
            } else {
                param = JSON.stringify(param);
                this.player[method](param);
            }
        },

        // 设置log信息
        setLogInfo: function(options) {
            options = options || this.options.data[0];
            this.log = {
                ref: 'mv',
                vid: options.vid,
                tvid: options.tvid,
                mvid: options.mvid,
                song_id: options.songId,
                song_title: options.title,
                singer_id: options.authorId,
                singer_name: options.author,
                album_id: options.albumId,
                album_name: options.albumTitle,
                time: options.time,
                source: options.source
            }
        },

        bindEvent: function() {
            var opt = this.options,
                $elem = opt.chainDataElem,
                self = this;
            $elem.find('.mv-cover a').on('click', function() {
                var $parent = $(this).parents('li'),
                    index = $elem.index($parent);
                self.playIndex(index);
                return false;
            })
        },

        //针对各种播放状态发送日志
        bindLogEvent: function () {
            if (!(ting && ting.logger && ting.logger.log)) {
                return;
            }

            var opt = this.log,
                self = this;

            this._on({
                mvchangemv: function() {
                    opt = self.log;
                },
                mvplaystart: function () {
                    var log = {
                        timestamp: self.recorder.timestamp
                    };
                    $.extend(log, opt);
                    ting.logger.log("playstart", log);
                },
                mvplay100ms: function () {
                    var log = {
                        fromload: self.recorder.fromload,
                        fromstart: self.recorder.fromstart,
                        timestamp: self.recorder.timestamp
                    };
                    $.extend(log, opt);
                    ting.logger.log("playsong100ms", log);
                },
                mvloaded: function() {
                    var log = {
                        buftotal: self.recorder.buftotal,
                        timestamp: self.recorder.timestamp
                    };
                    $.extend(log, opt);
                    ting.logger.log('loaded', log);
                },
                mvplayend: function () {
                    var log = {};
                    $.extend(log, self.recorder, opt);
                    ting.logger.log("playend", log);
                },
                mverror: function() {
                    var log = {};
                    $.extend(log, self.recorder, opt);
                    ting.logger.log('playerror', opt);
                },
                mvspeedslow: function() {
                    if (self.recorder.buffct === 1) {
                        var log = {
                            timestamp: self.recorder.timestamp
                        };
                        $.extend(log, opt);
                        ting.logger.log('firsthalt', log);
//                        console.log('第一次卡断');
                    }
                }
            });
        },

        // 自动连播mv
        autoPlayNextMv: function() {
            // _on包含了this上下文
            this._on({
                mvloadstart: function() {
                    this.playNext();
                }
            });
        },

        // 播放mv
        playMv: function(mvData) {
            this.setLogInfo(mvData);
            this._trigger('changemv');
            this.refreshHtml(mvData);
        },

        setIndex: function(index) {
            var opt = this.options,
                data = opt.data;
            if (index < 0 || index >= data.length) {
                return;
            }
            this.animateIndex(index);
            this.index = index;
            this.playMv(opt.data[index]);
        },

        animateIndex: function(index) {
            var opt = this.options,
                oldElem = opt.chainDataElem.eq(this.index),
                newElem = opt.chainDataElem.eq(index);
            oldElem.removeClass('actived');
            oldElem.find('.play-tip').remove();
            newElem.addClass('actived');
            newElem.find('.mv-cover').append('<div class="play-tip"><div class="bg"></div><div class="tip-text">正在播放...</div></div>');
        },

        playIndex: function(index) {
            var opt = this.options,
                data = opt.data[index];

            this._callPlayer('loadQiyiVideo', {
                tvid: data.tvid,
                vid: data.vid
            });
            // animateIndex运行了两次，因为区分不了是手动切换还是自动切换
            this.animateIndex(index);
            this.index = index - 1;
//            this.setIndex(index);
        },

        getPlayer: function() {
            return this.player;
        },

        playNext: function() {
            this.setIndex(this.index + 1);
        },

        // 切换MV后，重新渲染html
        refreshHtml: function(mvData) {
            // 改变分享内容
            bdShare.fn.conf.bdText = '推荐' + mvData.author + '的MV《' + mvData.title + '》 （分享自@百度音乐）';
            $('#mv_title').html('[MV]' + mvData.author + '-' + mvData.title);
//            $('#add_to_player').attr('class', "mv-add-song { songid: '" + mvData.songId + "' }");

            var info = '<li>歌曲：' + songLink(mvData) + '</li> \
                        <li>歌手：' + authorLink(mvData) + '</li> \
                        <li>时长：' + formatTime(mvData.time) + '</li> \
                        <li>发行时间：' + mvData.publishTime + '</li>';
            $('#info').html(info);
        }
    });

    // 格式化时间
    var formatTime = function(time) {
        var minute = Math.floor(time / 60),
            second = time % 60;
        if (minute < 10) {
            minute = '0' + minute;
        }
        if (second < 10) {
            second = '0' + second;
        }
        return minute + ':' + second;
    };

    // 歌曲链接
    var songLink = function(data) {
        var ret = '<a href="';
        if (data.songId) {
            ret += '/song/' + data.songId;
        } else {
            ret += '/search?key=' + encodeURIComponent(data.title);
        }
        ret += '" title="' + data.title +'" target="_blank">' + data.title + '</a>';
        return ret;
    };

    // 歌手链接
    var authorLink = function(data) {
        var ret = '<span class="author_list" title="' + data.author + '">',
            ids = data.authorId.split(','),
            authors = data.author.split(','),
            length = ids.length;

        $.each(ids, function(index, val) {
            if ((data.relateStatus == 0 || data.relateStatus == 1) && val > 0) {
                ret += '<a target="_blank" href="/artist/' + val + '" title="' + authors[index] + '">' + authors[index] + '</a>';
            } else {
                ret += '<a target="_blank" href="/search?key=' + encodeURIComponent(authors[index]) + '" title="' + authors[index] + '">' + authors[index] + '</a>';
            }
            if (index < length - 1) {
                ret += '<span class="artist-line">&nbsp;/&nbsp;</span>';
            }
        });

        ret += '</span>';

        return ret;
    };

    // 专辑链接
    var albumLink = function(data) {
        if (!data.albumTitle) {
            return '未知';
        }

        var ret = '<a target="_blank" ';

        if (data.relateStatus == 0 || data.relateStatus == 2) {
            ret += 'href="/album/' + data.albumId + '" title="' + data.albumTitle + '">';
        } else {
            ret += 'href="/search?key=' + encodeURIComponent(data.albumTitle) + '" title="' + data.albumTitle + '">';
        }
        ret += '《' + data.albumTitle + '》</a>';

        return ret;
    };

})(jQuery);