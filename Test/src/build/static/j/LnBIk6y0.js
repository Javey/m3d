$(function() {
    var expandAlbum = function(root) {
        this.element = root;
        this.albumItem = root.find('.album-item');
        this.cover = root.find('.cover');
        this.expander = root.find('.album-songs');
        this.albumInfo = this.expander.find('.album-info');
        this.songList = this.expander.find('.album-songlist');
        this.arrow = this.expander.find('.arrow-up');
        this.pos = {row: -1, col: -1}; // 记录弹层在第几行 第几列
        this.songListBg=this.expander.find('.img-bg-wrapper');
        this.showed = false;
        this.padding = parseInt(this.element.css('paddingLeft'), 10);
        this.width = this.albumItem.width();
        this.domMap = []; // 已展开的歌曲列表缓存
        this.imgBg = root.find('.img-bg');
        this.curCover = null;

        this.init();
    };

    expandAlbum.prototype = {
        init: function() {
            this._bindEvent();
        },

        _bindEvent: function() {
            var self = this;
            this.cover.hover(
                function() {
                    $(this).addClass('hover');
                },
                function() {
                    $(this).removeClass('hover');
                }
            );
            this.cover.on('click', function(e) {
                e.preventDefault();
                var $this = $(this),
                    pos = self.getPosition($this);

                if (!self.showed || self.pos.row !== pos.row) {
                    self.showContent($this, pos);
                } else if (self.pos.row === pos.row) {
                    if (self.pos.col === pos.col) {
                        self.hideContent($this);
                    } else {
                        self.slideContent($this, pos);
                    }
                }

                $.extend(self.pos, pos);

                return false;
            });
        },

        _getDom: function(pos) {
            return this.domMap[pos.row] && this.domMap[pos.row][pos.col];
        },
        _setDom: function(pos, $dom) {
            if (!this.domMap[pos.row]) {
                this.domMap[pos.row] = [];
            }
            this.domMap[pos.row][pos.col] = $dom;
        },

        updateSongList: function($this, pos) {
            var $parent = $this.parents('.album-item'),
                id = $parent.find('.album-cover').data('albumdata').id,
                self = this;

            this.songList.addClass('loading');

            $.ajax({
                url: '/data/music/songlist?from=lossless',
                type: 'post',
                data: {
                    id: id,
                    type: 'album'
                },
                dataType: 'json',
                success: function(data) {
                    var $songList = $(data.data.html);
                    self.songList.removeClass('loading');
                    $songList.songList({
                        rate: 1000
                    });
                    $songList.find('.music-icon-hook').musicIcon();
                    if ($songList.find('.song-item-hook').length>1){
                        self.songListBg.show();
                    }else{
                         self.songListBg.hide();
                    }
                    self.setSonglistBg($songList);
                    self._setDom(pos, $songList);
                    self.songList.append($songList);

                    if (self.pos.col !== pos.col || self.pos.row !== pos.row) {
                        // 点的太快，回调回来时，世界改变了
                        $songList.hide();
                    } else {
                        self.songList.animate({
                            height: $songList.height()
                        });
                    }
                }
            });
        },
        setSonglistBg:function($wrap){
            var len=$wrap.find('.song-item-hook').length,
                ie6 = $.browser.msie && ($.browser.version == "6.0");
            if (len>2 && !ie6){
                //34为列表行高
                /*背景图垂直居中
                var bottom;
                bottom=(34*len-250)/2;
                if(bottom>10){
                    bottom=bottom+47;
                    this.songListBg.css("bottom",bottom+"px");
                }else{
                    this.songListBg.css("bottom",0)
                }
                */
                this.songListBg.show();
            }else{
                 this.songListBg.hide();
            }
        },
        updateInfo: function($this) {
            var $parent = $this.parents('.album-item'),
                $albumName = $parent.find('.album-name').clone(),
                $singerName = $parent.find('.singer-name').clone();

            this.albumInfo.empty().append($albumName).append('<div class="line">-</div>').append($singerName);
        },

        getPosition: function($this) {
            var $ul = $this.parents('ul'),
                $li = $this.parents('li'),
                row = $ul.index(),
                col = $li.index();

            return {
                row: row,
                col: col
            }
        },

        getLeft: function($this) {
            return $this.parents('li').position().left + this.padding;
        },

        _initContent: function($this, pos) {
            var left = this.getLeft($this),
                $ul = $this.parents('ul');
            this.expander.appendTo($ul);
            this.updateInfo($this);

            this.arrow.css({
                left: left + this.width / 2
            });

            this.imgBg.attr('src', $this.find('img').attr('org_src'));
            this.songList.removeClass('loading');
            this.curCover && this.curCover.removeClass('actived');
            $this.addClass('actived');
            this.curCover = $this;
        },

        showContent: function($this, pos) {
            this._initContent($this, pos);
            var curDom = this._getDom(pos),
                prevDom = this._getDom(this.pos);
            prevDom && prevDom.hide();
            if (curDom) {
                curDom.show();
                this.expander.css({
                    position: 'absolute',
                    visibility: 'hidden',
                    display: 'block'
                });
                this.songList.height(curDom.height());
                this.expander.css({
                    position: 'relative',
                    visibility: 'visible',
                    display: 'none'
                });
                this.expander.slideDown();
            } else {
                this.expander.slideDown();
                this.updateSongList($this, pos);
            }

            this.showed = true;
        },

        hideContent: function($this) {
            this.expander.slideUp();
            this.curCover.removeClass('actived');
            this.showed = false;
        },

        slideContent: function($this, pos) {
            this._initContent($this, pos);
            var curDom = this._getDom(pos),
                prevDom = this._getDom(this.pos);
            prevDom && prevDom.hide();
            if (curDom) {
                this.setSonglistBg(curDom);
                curDom.show();
                this.songList.animate({
                    height: curDom.height()
                })
            } else {
                this.updateSongList($this, pos);
            }
        }
    };

    $(".album-cover-hook").albumCover();

    new expandAlbum($('.content-body'));

    var songExpander = $('.album-songs');
    songExpander.on('mouseenter', 'li', function() {
        $(this).addClass('hover');
    });
    songExpander.on('mouseleave', 'li', function() {
        $(this).removeClass('hover');
    })
});