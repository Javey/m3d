/**
 * Created with JetBrains PhpStorm.
 * Description: 创建音悦台MV
 * User: zoujiawei
 * Date: 13-6-9
 * Time: 下午1:55
 * To change this template use File | Settings | File Templates.
 */

(function($) {
    var area = ['ML', 'HT', 'US', 'KR', 'JP'];

    $.widget('ui.mvYinyuetai', $.ui.mv, {
        _create: function() {
            this.widgetEventPrefix = 'mv';
            this.index = 0;
            this._super();
            this._custom();
            this.animateIndex(0);
        },

        createFlash: function(options) {
            options = options || this.options.data[0];
            this.element.empty();
            if ($.swf.version) {
                $.swf.create({
                    'id': "mvFlash",
                    'width': this.options.width,
                    'height': this.options.height,
//                    'url': 'http://s.yytcdn.com/swf/common/mvplayer.$48541.swf',
                    'url': 'http://player.yinyuetai.com/video/swf/696809/a.swf',
                    'allowscriptaccess': 'always',
                    'wmode': 'opaque',
                    'allowfullscreen': true,
                    'bgcolor': '#000000',
                    'vars': {
                        videoId: options.tvid,
                        showlyrics: false,
                        local: true,
                        refererdomain: 'yinyuetai.com',
                        capturevideoavailable: true,
                        sendsnaplog: true,
                        usepromptbar: true,
                        popupwin: false,
                        amovid: '5f4ffbc12418024'
                    }
                }, this.element.get(0));
            } else {
                $('.dialog-box').dialog().show();
            }
            this.player = $.swf.getMovie('mvFlash');
            this._trigger('createflashsuccess');
        },

        playerEvent: function() {
            var self = this,
                playStart = false,
                // 用于标识是否是手动拖动进度条，用于判断是否卡断
                // 理论上playing -> buffering的状态变化都是卡断，但有时也会出现拖动的时候短暂地出现该状态
                isSeeking = false;

            window.playerState = function(oldState, newState) {
//                console.log(oldState, newState);
                oldState = oldState.toLowerCase();
                newState = newState.toLowerCase();
                if (oldState === 'seek') {
                    isSeeking = true;
                } else {
                    if (oldState === 'idle' && newState === 'buffering') {
                        self._trigger('load');
                        playStart = true;
                    } else if (playStart && oldState === 'buffering' && newState === 'playing') {
                        // buffering -> playing 当网速慢时，可能会触发多次playstart，所以不能真实统计playstart量
                        // 只在第一次时统计，加入playStart变量
                        self._trigger('play100ms');
                        playStart = false;
                    } else if (oldState === 'playing' && newState === 'idle') {
                        self._trigger('playend');
                    } else if (oldState === 'playing' && newState === 'buffering' && !isSeeking) {
//                        console.log('卡断');
                        self._trigger('speedslow');
                    } else if (newState === 'playerError') {
                        self._trigger('error');
                    }
                    isSeeking = false;
                }
            };
            window.flashPlayerEventFunc = function(obj) {
                self._trigger('loadstart');
                self._trigger('playstart');
                if (obj.type == "mvplayerReady") {
                    self.player.addStateListener('mvplayerPlayerState', 'playerState');
                }
            };
        },

        // 自动连播mv
        autoPlayNextMv: function() {
            // _on包含了this上下文
            this._on({
                mvplayend: function() {
                    this.playNext();
                }
            });
        },

        playIndex: function(index) {
            this.setIndex(index)
        },

        // 播放mv
        playMv: function(mvData) {
            this.createFlash(mvData);
            this._super(mvData);
        },

        // 与播放器无关的逻辑写在这里，之所以不写在widget外面，是因为只有创建该widget时这些代码才执行
        _custom: function() {
            var self = this;
            function renderMv(data) {
                var template = $('#yinyuetai_list_template').html(),
                    $list = $('#yinyuetai_list');

                template = _.template(template, {data: data});
                $list.html(template);

                $list.find('li').hover(
                    function() {
                        $(this).addClass('actived');
                    },
                    function() {
                        $(this).removeClass('actived');
                    }
                );

                // 自定义滚动条
                $('#yinyuetai_scroll').tinyscrollbar();
            }

            function getYinyuetaiRecommend() {
                $.ajax({
                    url: 'http://api.yinyuetai.com/api/baidu/vchart-data',
                    data: {
                        area: area[self.options.data[0].area] || 'ML',
                        json: true
                    },
                    dataType: 'jsonp',
                    success: function(data) {
                        renderMv(data.videos);
                    }
                });
            }

            getYinyuetaiRecommend();
        }
    });
})(jQuery);