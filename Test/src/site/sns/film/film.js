/**
 * Created with JetBrains PhpStorm.
 * User: zoujiawei
 * Date: 13-4-25
 * Time: 下午9:15
 * To change this template use File | Settings | File Templates.
 */

(function($, undefined) {
    // MV滚动
    var isie6 = ($.browser.msie && $.browser.version == "6.0") ? true : false;

    var focusRoll = function (rootClass, focusClass, focusPageClass, _interval) {
        var newAlbum = $( rootClass ),
            focus = $( focusClass ),
            focusWrap  = $( ".wrap" , focus ),
            list = $("li" , focusWrap),
        // 滚动宽度
            width = parseInt( $("ul" , focus ).width() ),
        // 切换动画，如果是left或者right左右切换，item则渐隐渐显
            effect = null,
        // 当前处于焦点图的索引，默认第一张
            curIndex = 0,
            item = $( focusPageClass + " a"  ),
            tab = item.parent(),
            clickType = isie6 ? "btn" : "item",
        // 动画时间
            clickTime = true,

        // 记录点击是否仍为当前元素
            e = 0,
        // 是否自动切换
            focusAuto = true,
        // 切换时间
            interval = _interval || 5000,
        // 自动切换动画函数
            autoAnimate = null;
        /*****焦点组件参数end*****/

        $( " .right-btn" , newAlbum ).bind("click",function(){
            // clickType ="btn";
            nextFocus();
            swidthAnimate( clickType );
            return false;
        });

        $( " .left-btn"  , newAlbum).bind("click",function(){
            // clickType ="btn";
            curIndex--;
            if( curIndex < 0 ){
                curIndex = item.length - 1;
            }

            swidthAnimate( clickType  );
            return false;
        });

        item.bind("click",function( e ){
            if( $(this).hasClass("page-active") ){ return false;}
            e.preventDefault();
            curIndex = $(this).index();

            // clickType ="item";
            swidthAnimate( clickType  );
            return false;
        });

        newAlbum.bind("mouseover",function(){
            clearInterval( autoAnimate );
            autoAnimate = null;
        });

        newAlbum.bind("mouseout",function(){
            if( focusAuto ){
                autoPlay();
            }
        });

        var nextFocus = function(){
            if (item.length === 0) {
                return;
            }
            if(curIndex >= 0 && curIndex < item.length -1) {
                curIndex++;
            }else{
                curIndex=0;
            }

            if( curIndex > item.length - 1 ){
                curIndex = item.length - 1;
                return false;
            }
        };

        var autoPlay = function(){
            if (width > focus.width()) {
                autoAnimate = setInterval(function(){
                    nextFocus();
                    swidthAnimate();
                },interval);
            }
        };

        if( autoPlay ){
            autoPlay();
        }

        var swidthAnimate = function( clickType  ){

            var curFocus = $( $( "ul" , focusWrap)[curIndex] ),
                img = $("img" , curFocus);

            img.each(function(i,v){
                var img_src = $(v).attr("src"),
                    img_org_src =  $(v).attr("org_src");

                if( img_org_src != img_src ){
                    $(v).attr( "src" , img_org_src );
                }
            });
            // alert(width)
            var clickType = "btn";
            var swidth = curIndex * width;
            effect = ( clickType == "btn" ) ? { left :   - swidth } : { opacity : "0.3"  };
            // effect =  ( clickType == "btn" ) ? { left : "+=" + swidth } : { left :  swidth }
            focusWrap.stop( true, true ).animate(
                effect,
                "100",
                function() {
                    if( clickType !="btn" ){
                        focusWrap.css( "left", -swidth );
                        focusWrap.stop( true ,true ).animate( {  opacity: '1' } ,"normal" );
                        clickTime = true;
                    }

                }
            );

            changeTab();
        };
        // 切换tab焦点
        var changeTab = function( ){
            item.removeClass("page-active");
            $(item[curIndex] ).addClass("page-active");

        };
    };

    focusRoll(".recommend-mv", ".recommend-mv", ".mv-focus-page", 9000);

    // 播放全部歌曲
    $('.play-all').click(function(){
        var ids = $(this).data("song").ids,
            opt = {
                moduleName : $(this).data("song").moduleName
            };
        ting.media.playSong(ids, opt);
        $(this).tip().tip("tipup", {
            msg: "已开始播放",
            iconClass: "tip-success"
        });
        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("play_film");
        }
        /* 点击统计 end by lutaining */

        //bdbrowser effect
        if(ting.browser.isSpecial()){
            ting.browser.add2box('play');
        }
        return false;
    });

    // 添加歌曲
    $('.add-all').click(function(){
        var ids = $(this).data("song").ids,
            opt = {
                moduleName : $(this).data("song").moduleName
            };
        ting.media.addSong(ids, opt);
        $(this).tip().tip("tipup", {
            msg: "添加成功！",
            iconClass: "tip-success"
        });
        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("add_film");
        }
        /* 点击统计 end by lutaining */

        //bdbrowser effect
        if(ting.browser.isSpecial()){
            ting.browser.add2box('play');
        }
        return false;
    });

    // 歌曲列表
    $('.song-list-hook').songList()

})(jQuery);