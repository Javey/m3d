$(function(){
        var ie6 =  $.browser.msie && $.browser.version == "6.0";


            // 记录上一焦点与下焦点的差值 -1 为后退 +1为前进
         /*rollscreenNum = 0,*/
        var focusId = $( "#focus" ),
            focus = $( ".focus-info-inner" ),
            focusWrap  = $( ".focus-info-wrap" , focus ),
            // 滚动宽度
            width = focus.width(),
            // 切换动画，如果是left或者right左右切换，item则渐隐渐显
            effect = null,
            // 当前处于焦点图的索引，默认第一张
            curIndex = 0,
            item = $( ".focus-tab li"  ),
            tab = item.parent(),
            clickType = "btn",
            // 动画时间
            clickTime = true,
            disNum =  7,
            tabCurIndex = 0,
            focusPosInfo = $(".focus-pos-info .focus-desc" , focus), 
            // 记录点击是否仍为当前元素
            e = 0,
            // 是否自动切换
            focusAuto = true,
            // 切换时间
            interval = 5000,
            // 自动切换动画函数
            autoAnimate = null;
            /*****焦点组件参数end*****/ 



        $( ".focus-scroll .focus-right-btn" ).bind("click",function(){
            clickType ="btn";
            nextFocus();
            swidthAnimate( clickType );
            return false;
        });

        $( ".focus-scroll .focus-left-btn" ).bind("click",function(){
            clickType ="btn";
            curIndex--;
            if( curIndex < 0 ){
                curIndex = item.length - 1;
                // return false;
            }


            if(curIndex > 2 && curIndex < item.length - (disNum - 3)) {
                tabCurIndex--;
            } else if(curIndex > item.length - 2) {
                tabCurIndex = item.length - disNum ;
            }
            swidthAnimate( clickType  );
            return false;
        });

        $( ".focus-tab li" ).bind("click",function( e ){
            if( $(this).find("a").hasClass("active") ){ return false;}
            e.preventDefault();
            var index = $(this).index();
            if( index > 3 && index <= ( item.length - 1 ) - parseInt( disNum - disNum /2 ) ) {
                tabCurIndex = index - 3;
            } else if(index < item.length / 2) {
                tabCurIndex = 0;
            } else if(index > item.length - item.length / 3) {
                tabCurIndex = item.length - disNum;
            }
            
            clickType ="item";
            curIndex =   index ;
            swidthAnimate( clickType  );
            
            return false;
        });

        focusId.bind("mouseover",function(){
            clearInterval( autoAnimate );
            autoAnimate = null;
        });

        focusId.bind("mouseout",function(){
            if( focusAuto ){
                autoPlay();
            }
        });

        var nextFocus = function(){
            if(curIndex >= 0 && curIndex < item.length -1) {
                    curIndex++;
                }else{
                    curIndex=0;
                }

                if(curIndex > 3 && curIndex < item.length - (disNum - 4) ) {
                    tabCurIndex++;
                } else if(curIndex == 0) {
                    tabCurIndex = 0;
                }

                if( curIndex > item.length - 1 ){
                    curIndex = item.length - 1;
                    return false;
                }
        };

        var autoPlay = function(){
            autoAnimate = setInterval(function(){
                nextFocus();
                swidthAnimate();
            },interval);
        };
        if( autoPlay ){
            autoPlay();
        }
    
        var swidthAnimate = function( clickType  ){
            var curFocus = $( $( ".focus-info" , focusWrap )[curIndex] ),
                img = $("img" , curFocus),
                img_src = img.attr("src"),
                img_org_src =  img.attr("org_src");

            var curTab = $(item[curIndex + parseInt( disNum / 2 ) ]),
                thumb  = $("img" , curTab),
                thumb_src = thumb.attr("src"),
                thumb_org_src =  thumb.attr("org_src");


            if( img_org_src != img_src ){
                // img.siblings("span").show();
                img.attr( "src" , img_org_src );
                thumb.attr( "src" , thumb_org_src );
                // img.siblings("span").hide();
            }

            var swidth = curIndex * width;
            effect = ( clickType == "btn" ) ? { left :   - swidth } : { opacity : "0.5"  };
            // effect =  ( clickType == "btn" ) ? { left : "+=" + swidth } : { left :  swidth }
            focusWrap.stop( true, true ).animate(
                effect,
                "normal",
                function() {
                    if( clickType !="btn" ){    
                        focusWrap.css( "left", -swidth );
                        focusWrap.stop( true ,true ).animate( {  opacity: '1' } ,"normal" );
                        clickTime = true;
                    }
                    $(focusPosInfo[curIndex]).siblings().hide().end().show();
                }
            );
            tab.stop( true , true ).animate(
                {left : "-" + tabCurIndex * 128 + "px"}
            );

            changeTab();
        };
        // 切换tab焦点
        var changeTab = function( ){
                $("a" , item).removeClass("active");
                $( $("a" , item)[curIndex] ).addClass("active");

        };












        // 初试化专题分类top值做备份，以计算出监听滚动条top值超过tops值的个数
        var tops = [],
            menulist =$(".cate-menu a"),
            body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'); // opera fix 
        $(".topic-cate").each(function(){
            tops.push( $(this).offset().top );
        });

        menulist.bind("click",function(e){
            var me = $(this);
            // 先卸载window滚动事件，否则在触发时会产出抖动的动画效果。回调再绑定
            /*if ( !ie6 ){
                $(window).unbind("scroll");
            }*/
            var scrollTop = $(document).scrollTop(),
                pos = parseInt( tops[ me.index() ] );
            body.stop( true , true ).animate(
                {
                    scrollTop : pos
                },
                200,
                function(){
                    // var back_scrollTop = $(document).scrollTop();
                    // var tips = me.siblings("span");

                    // 判断当前滚动条top是否等于tops ，若不等说明已经到页面底部则不切换menu
                    /*if(back_scrollTop == pos ){
                        tips.hide();
                        // firefox bug add setTimeout
                        setTimeout(function(){
                            changeMenuActive( me.index() );
                        },0);
                    }else{
                        // removeMenuActive();
                        tips.stop( true , true).animate(
                        {
                            opacity : "show"
                        },
                        500,
                        function(){
                            setTimeout(function(){
                                tips.animate(
                                {
                                    opacity : "hide"
                                },
                                500
                                );
                            },1000);
                        }
                        );

                    }*/

                    // $(window).bind("scroll" ,scroll);
                }
            );
            return false;
        });

        var scroll = function(){
                var scrollTop = $(document).scrollTop();
                // 计数器，比较滚动条的top，与tops值对比，超过N个计N个，N-1为当前cate-menu的索引值
                /*var nums = 0;
                for(var i = 0 , j = tops.length; i <= j ; i++){
                    if( scrollTop >= tops[ i ]   ){
                        nums += 1;
                    }
                }

                // 若nums <=1 则都为第一项
                // nums = nums <= 1  ? 0 : nums - 1 ;
                nums = nums == 0  ? menulist.length : nums - 1 ;

                if( nums == menulist.length ){
                    removeMenuActive();
                }
                changeMenuActive(nums);*/
                if( $.browser.msie && $.browser.version == "6.0"){
                    $(".cate-menu").css("top" , scrollTop + 100);
                    /*clearTimeout(moveMenuTime);
                    var moveMenuTime = setTimeout(function(){
                        $(".cate-menu").css("top" , scrollTop + 100);
                    },5);*/
                }
        };

        var changeMenuActive = function( index ){
            $( $(".cate-menu a")[index] ).siblings().removeClass("hover").end().addClass("hover");
        };

        var removeMenuActive = function(){
            menulist.removeClass("hover");
        }; 

        if( ie6 ){  
            $(".cate-list li").hover(
                function(){
                    $(this).addClass("hover");
                },
                function(){
                    $(this).removeClass("hover");
                }
            );
        }


  //papa related
  var papa = $('#papa-follow');
  papa.hoverShow($('.follow-target', papa),{delay:0})

        // firefox 刷新监听不了scroll 故添加 监听load事件
        $(window).bind("scroll , load ",scroll);
        // $(document).scrollTop( $(document).scrollTop + 1 );
    });