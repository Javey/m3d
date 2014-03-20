/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-7-24
 * Time: 下午3:03
 * To change this template use File | Settings | File Templates.
 */

(function(window, undefined) {
    /**
     * ie6 postion: fixed;
     */
    $.widget('ui.fixed', {
        options: {
            // 是否一直固定（有抖动），还是延迟动画展示
            animation: true,
            // 距离顶部高度
            top: 100
        },

        _create: function() {
            var isIE6 = $.browser.msie && parseInt($.browser.version, 10) < 7;
            if (isIE6) {
                var options = this.options,
                    $elem = this.element;

                $elem.css({
                    position: 'absolute'
                });
                this[options.animation ? '_fixedAnimate' : '_fixed']();
            }
        },

        // 延迟动画展示
        _fixedAnimate: function() {
            var options = this.options,
                $elem = this.element,
                $win = $(window),
                time = null;

            $win.on('scroll.fixed', function() {
                if (time) {
                    clearTimeout(time);
                    time = null;
                }
                time = setTimeout(function() {
                    var top = $win.scrollTop() + options.top;
                    $elem.animate({
                        top: top
                    });
                },300);
            });
        },

        // 实时渲染
        _fixed: function() {
            var options = this.options,
                $elem = this.element,
                $win = $(window);

            $win.on('scroll.fixed', function() {
                var top = $win.scrollTop() + options.top;
                $elem.css({
                    top: top
                });
            });
        }
    });

    /**
     * 焦点图
     */
    $.widget('ui.mvFocus', {
        options: {
            tabClass: '.focus-tab',
            imgClass: '.focus-img',
            prevClass: '.focus-left-btn',
            nextClass: '.focus-right-btn',
            duration: 'normal',
            interval: '5000',
            auto: true,
            // 每页显示多少个tab，用于滚动
            tabsOnePage: 5
        },

        _create: function() {
            var $elem = this.element,
                options = this.options;
            this.widgetEventPrefix = 'mvfocus.';
            this.width = $elem.width();
            this.curIndex = 0;

            var $tab = $elem.find(options.tabClass);
            this.$tab = $tab.find('a');
            this.$tabUl = $tab.find('ul');
            this.$tabLiWidth = this.$tabUl.find('li').outerWidth(true);

            this.$img = $elem.find(options.imgClass);
            this.length = this.$img.length;
            this.autoTime = null;
            this._bindEvent();
            this.setIndex(0);
            if (options.auto) {
                this._startPlay();
            }
        },

        _animate: function(options) {
            var $prev = this.$img.eq(options.prev),
                $next = this.$img.eq(options.next),
                img = $("img" , $next),
                imgSrc = img.attr("src"),
                imgOrgSrc = img.attr("org_src"),
                $animate = this.element.find('.focus-animate');

            if( imgOrgSrc != imgSrc ){
                img.attr("src", imgOrgSrc);
            }

            var self = this;

//            $prev.show().stop(true, true).animate({
//                opacity: 0
//            }, function() {
                $prev.hide();
                $animate.removeClass('hover');
                $next.show().stop(true, true).animate({
                    opacity: 1
                }, 'slow', function() {
                    $prev.css({
                        opacity: 0
                    })
                });
                self.element.css({
                    //backgroundColor: $prev.data('background'),
                    backgroundImage: 'url(' + $prev.find('img').attr('src') + ')',
                    backgroundRepeat: 'no-repeat',
                    backgroundPosition: 'center center'
                });

                $animate.addClass('hover');
//            });
        },

        _changeTab: function(options) {
            var $prev = this.$tab.eq(options.prev),
                $next = this.$tab.eq(options.next);

            $prev.removeClass('active');
            $next.addClass('active');

            var middleIndex = Math.ceil((5 - 1) / 2),
                left = 0;
            if (options.next > middleIndex && options.next < (this.length - middleIndex)) {
                left = -this.$tabLiWidth * (options.next - middleIndex);
            } else if (options.next >= (this.length - middleIndex)) {
                left = -this.$tabLiWidth * (this.length - 5);
            }
            this.$tabUl.stop(true, true).animate({
                left: left
            });
        },

        _startPlay: function() {
            var self = this;
            this._stopPlay();
            this.autoTime = setInterval(function() {
                self.setIndex(self.curIndex + 1);
            }, self.options.interval);
        },

        _stopPlay: function() {
            if (this.autoTime) {
                clearInterval(this.autoTime);
                this.autoTime = null;
            }
        },

        _bindEvent: function() {
            var $elem = this.element,
                options = this.options,
                self = this;
            $elem.find(options.prevClass).on('click', function() {
                self.setIndex(self.curIndex - 1);
                return false;
            });
            $elem.find(options.nextClass).on('click', function() {
                self.setIndex(self.curIndex + 1);
                return false;
            });

            this.$tab.on('click', function() {
                var index = $(this).parent().index();
                self.setIndex(index);
                return false;
            });

            // if autoPlay
            if (options.auto) {
                $elem.on('mouseenter', function() {
                    self._stopPlay();
                });
                $elem.on('mouseleave', function() {
                    self._startPlay();
                })
            }

            // index:change
            $elem.on('change:index', function(event, options) {
                self._animate(options);
                self._changeTab(options);
                self._trigger('changeindex', null, options);
            });
        },

        setIndex: function(index) {
            var prev = this.curIndex,
                length = this.length;
            index = (index % length + length) % length;
            this.curIndex = index;
            this.element.trigger('change:index', {
                prev: prev,
                next: this.curIndex
            });
        }
    });

    $('.mv-index').fixed();
    var $desc = $('.focus-desc');
    $('.focus').mvFocus().on('mvfocus.changeindex', function(event, options) {
        $desc.eq(options.prev).hide();
        $desc.eq(options.next).show();
    });
})(window);