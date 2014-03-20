$(function(){
    $(".ecom-ad").ecomad();
    $('.play-all-hook').click(function(){
            var type = $(this).data("type"),
                opt = {
                    moduleName : type
                },
            no=$(this).data("no")||"";
            if(no){
                type=type+"_"+no;
            }   
            ting.media.playTop( type ,opt );
            $(this).tip().tip("tipup", {
                        msg: "已开始播放",
                        iconClass: "tip-success"
                    });

            //bdbrowser effect
            if(ting.browser.isSpecial()){
                ting.browser.add2box('play');
            }
        return false;
    })

    var $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'); // opera fix  
    
    var topList = $(".top-list");
    var topScrollTo = topList.offset().top;
    var selectSongList = function (x, scope) {
        var wrapper = $(".song-list-wrap" ,scope);
        var songListArray = [];
        var songListTextAreaArray = [];
        var tas, firstPage;
        var offset = -1;
            /* 先获取dom中的songList */
            firstPage = wrapper.find(".song-list");
            firstPage = $(firstPage[0]);
            firstPage.songList();
            songListArray.push(firstPage); 
            /* 获取其他的songList */
            tas = $(".rest-page textarea" ,scope);

            for (var i = 0, len = tas.length; i < len; i += 1) {
                songListTextAreaArray.push($(tas[i]));
            }



            var fn = arguments.callee;
            var songList;
            if (x > songListTextAreaArray.length || x == offset) {
                return false;
            }

            offset = x; 
            songList = songListArray[x];
            $(".song-list" , scope).hide();
            if (!songList) {
                songListTextArea = songListTextAreaArray[x - 1];
                songList = $(songListTextArea.val() || "");
                songListArray[x] = songList;
                scope.find(wrapper).append(songList);
                songList.songList();
                songList.find(".music-icon-hook").musicIcon();

    			// 设置批量操作的悬浮
    			songList.songList("floatBar");
            }

            songList.show();

        
    };
    function initTopPageNav(scope){
        var pageNavigator = $('.top-list .page-navigator-hook').pageNavigator();      
        pageNavigator.bind('pagenavigator.pagechange',function(e, data){
             $content=scope.length?scope:$(this).parents(".top-list-item");
            selectSongList(data.page - 1 , $content);
            $body.stop().animate({ scrollTop: topScrollTo}, 200);
            return false;
        });        
    }
    initTopPageNav($("#songList"));    
    if( $(".select-list").length ){
        var selectPage = $(".select-list a");
        selectPage.bind("click",function(){
            if( $(this).hasClass("active") ){
                return false;
            }
            var index = selectPage.index($(this));
            $(".top-list-item").hide();
            $(".song-list" , $($(".top-list-item")[index])).songList();
            $($(".top-list-item")[index]).show();
            $(this).siblings().removeClass("active")
                            .end()
                            .addClass("active");
            return false;
        });
    }
    // initSongList();
    // var listindex = ( window.location.pathname.indexOf("dayhot") != -1 ) ? 1 : 0; 

    //新歌榜TAB
    var $datepicker=$( "#datepicker" ),
        typeIndex={"day":0,"week":1,"month":2},
        $new=$("#topnew"),
        new_type=$new.data("newtype");
	 var firstSongList = $(".song-list").songList().songList("floatBar");

    
    function initCal (opt) {
        // opt 参数  new_type 新歌榜类型 no榜单日期 latestno 最新榜单日期
        // 初始日期显示区域的状态
        var $dateContent=$("#topnew .top-date")[typeIndex[opt.new_type]],
        $cal=$(".top-calendar",$dateContent),
        maxNo,minNo;  
        noArr=opt.no.split("-");   
        $(".cal-num",$dateContent).each(function(i,el){
            $(el).text(noArr[i]);
        })
        $(".play-newtop-all-hook",$dateContent).data('songids',opt.newTopIds);
        if(!$cal.data("max")){
            $cal.data("max",opt.maxNo);
        }
        maxNo=$cal.data("max");
        minNo=$cal.data("min");
        if(opt.no==minNo){
            $(".pre",$dateContent).addClass("pre-disabled");
        }else{
            $(".pre",$dateContent).removeClass("pre-disabled");
        }
        if(opt.no==maxNo){
            $(".next",$dateContent).addClass("next-disabled");
        }else{
            $(".next",$dateContent).removeClass("next-disabled");
        } 
    };  
    function calDate (type,flag) {
        // 计算日月周+1-1；
        var output,
            curDate,
            $dateContent=$("#topnew .top-date")[typeIndex[type]],
            modNum={"week":52,"month":12}
            date=[];
            $(".cal-num",$dateContent).text(function  (i,v) {
                date.push(v)
            });
        if(type=="day"){
            output=new Date(date[0],date[1]-1,date[2])*1 +flag*24*60*60*1000;
            output=$.datepicker.formatDate(  "yy-mm-dd" ,new Date(output) );
        }else if(type=="week"||type=="month"){
            date[1]=date[1]*1+flag;
            if(date[1]>modNum[type]){
                date[0]=date[0]*1+1;
                date[1]=1;
            }else if(date[1]==0){
                date[0]=date[0]*1-1;
                date[1]=modNum[type];
            }
            date[1]=date[1]>9?date[1]:"0"+date[1];
            output=date.join("-");
        }
        return output;
    };  
    function changeURL (opt) {
        window.location.href="/top/new/"+opt.new_type+"/"+(opt.no||"");
    }
if($new.length){     
    initCal({"new_type":$new.data("newtype"),"no":$new.data("no")})
    $("#topnew .music-ui-tab-middle .list").bind('click',function  () {
        var opt={};
        opt.new_type=$(this).data("newtype");
        changeURL(opt);        
        return false;
    })
    $datepicker.datepicker({ 
        dateFormat:'yy-mm-dd',
        minDate: new Date(2013, 1 - 1, 1), 
        maxDate: $("#topCalDay").data("max")||0,
        onSelect:function  (dataText,inst) {
            var opt={"new_type":"day","no":dataText};
            changeURL(opt);
            // initCal(opt);            
        },
        beforeShow:function  () {
            $( "#datepicker" ).css("top",$( "#datepicker" ).css("top")+50);

        }
    });
    // .datepicker( 'setDate' , date ) 
    $( "#topCalDay" ).bind('click',function  () {
        var method=$datepicker.css("display"),
            date=[];
            $("#songList .cal-num").text(function  (i,v) {
                date.push(v)
            });        
        $( "#datepicker" ).datepicker( 'setDate' , date.join("-"));
        if(method=="none"){
            $( "#datepicker" ).datepicker("show");
        }
        return false;
    })  
    $("#topCalWeek").bind("click",function  () {
        var $week=$("#topnew  .top-week-list .top-date-week"),
            liHTML="",
            layerHTML="",
            data=$(this).data("max").split("-"),
            year=data[0],
            cur=$week.text()*1,
            week=data[1]*1,
            $weekLayer=$("#top-week-layer");        
        if(!$("#top-week-layer").length){
            for (var i = 1; i <= week; i++) {
                liHTML+='<li class="'+(i==cur?'on':'')+'"><a href="#"  data-no="'+year+'-'+(i>9?i:'0'+i)+'">第'+i+'周</a></li>'
            };
            layerHTML='<div id="top-week-layer" class="top-cal-layer">'
                        +'<h2 class="bb-dotimg">'+year+'</h2>'
                        +'<ul>'+liHTML+'</ul>'
                        +'</div>';
            $("#topnew .top-week-list .top-date").append(layerHTML);
            $weekLayer=$("#top-week-layer");
            $weekLayer.bind('click',function  () {
                return false;
            })
            $weekLayer.delegate("li a",'click',function(){
                var no=$(this).data("no"),
                    opt={"new_type":"week","no":no};
                $("#top-week-layer").toggle();
                changeURL(opt);
                return false;
            })
        }else{
            $("li.on",$weekLayer).removeClass("on");
            $("li",$weekLayer).eq(cur-1).addClass("on");
            $("#top-week-layer").toggle();
        }
        return false;
    });
    $("#topCalMonth").bind("click",function  () {
        var $month=$("#topnew  .top-month-list .top-date-month"),
            liHTML="",
            layerHTML="",
            data=$(this).data("max").split("-"),
            cur=$month.text()*1,
            year=data[0],
            maxMonth=data[1]*1,
            $monthLayer=$("#top-month-layer");        
        if(!$("#top-month-layer").length){
            for (var i = 1; i <= 12 ; i++) {
                liHTML+='<li class="'+(i==cur?'on':'')+'">'+(i<=maxMonth?'<a href="#" data-no="'+year+'-'+(i>9?i:'0'+i)+'">'+i+'月</a>':i+'月')+'</li>';
            };
            layerHTML='<div id="top-month-layer" class="top-cal-layer">'
                        +'<h2 class="bb-dotimg">'+year+'</h2>'
                        +'<ul>'+liHTML+'</ul>'
                        +'</div>';
            $("#topnew .top-month-list .top-date").append(layerHTML);
            $monthLayer=$("#top-month-layer");
            $monthLayer.bind('click',function  () {
                return false;
            })            
            $("#top-month-layer").delegate("li a",'click',function(){
                var no=$(this).data("no"),
                    opt={"new_type":"month","no":no};                
                $("#top-month-layer").toggle();
                changeURL(opt);              
                return false;
            })
        }else{
            $("li.on",$monthLayer).removeClass("on");
            $("li",$monthLayer).eq(cur-1).addClass("on");            
            $("#top-month-layer").toggle();
        }
        return false;
    });

    $(".top-date-ctr").delegate("a.date-arrow",'click',function(){
        var me=$(this),
            flag=me.hasClass("pre")?-1:1,
            type=me.parent().data("type"),
            output=calDate(type,flag),
            opt={};
        if(me.hasClass("pre-disabled")||me.hasClass("next-disabled")){
            return false;
        }
        opt.no=output;
        opt.new_type=type;
        initCal(opt);
        changeURL(opt)
        return false;
    })
    $(document).bind("click",function  () {
        $("#top-month-layer,#top-week-layer").hide();
    })
    $(".top-mv-hook").bind("click",function  () {
        var vid=$(this).data("vid"),
        tvid=$(this).data("tvid");
        if(!$("#topMVWrapper").length){
          var name = "Height",
              popH = Math.max(document.documentElement["client" + name], document.body["scroll" + name], document.documentElement["scroll" + name], document.body["offset" + name], document.documentElement["offset" + name]),
              popCont = "<div class='popup-mask-topic' style='height:" + popH + "px'></div>"
                       +"<div class='popup-wrapper-topic' id='topMVWrapper'>"
                         +"<i class='pop-close' id='popClose'></i>"
                         +"<div id='popFlash'></div>"
                       +"</div>";
          $(document.body).append(popCont);
          $("#topMVWrapper").css({
                         visibility: 'visible',
                         top: $( window ).height()/2 - 300 + $( document ).scrollTop() + 'px'
          })
        }
        if (baidu.swf.getVersion) {
            baidu.swf.create({
                'id': "mvFlash",
                'width': '100%',
                'height': '520px',
                'url': 'http://dispatcher.video.qiyi.com/disp/shareplayer.swf',
                'allowscriptaccess': 'always',
                'wmode': 'opaque',
                'allowfullscreen': true,
                'bgcolor': '#000000',
                'vars': {
                    vid: vid,
                    tvid: tvid,
                    autoPlay: '1',
                    autoChainPlay: '0',
                    showSearch: '0',
                    showSearchBox: '0',
                    autoHideControl: '1',
                    showFocus: '0',
                    showShare: '0',
                    showLogo: '0',
                    coop: 'coop_baidump3',
                    cid: 'qc_100001_300089',
                    bd: '1'
                }
            }, $('#popFlash')[0]);
        } else {
            this.element.html("请安装flash");
        }
    })  
    $('.pop-close').live('click',function(){
            $(".popup-mask-topic").remove();
            $("#topMVWrapper").remove();            
    })      

  }  
});

