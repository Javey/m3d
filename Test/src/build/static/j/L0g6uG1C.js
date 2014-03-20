
$(function(){
	//userVoice widget增加一个参数 {navHash：'song-comment'} 翻页用到
	//$( ".user-voice-hook" ).userVoice('option','navHash','#topic-comment');
	//$( ".user-voice-hook" ).userVoice({navHash:'#topic-comment'});
	//顶踩图片lightbox
	if($('.mod-piclist').length){
		$('.mod-piclist .topic-tab .tab-item').each(function(){
	        $(".item-img",this).lightBox();
	    });			
	}
	/* 投票数据 异步获取 ud_id：顶踩id 匆删 */
	/*例子
ting.connect.getTopicUpd(null,{'ud_id':54,'ud_only_ding':0},function(result){
    var data=result.data;
    for(var o in data.upData){
       var id="vote_"+data.ud_id+"_"+o+"_up"
       $("#"+id).text(data.upData[o].up);
}},function(result){
})
   */
	//图片上传
	if($('.mod-floatLayer').length){
		var post={},
			upd_id=null,
			photo={},
			title=$( '.upload-title-hook' );
			//投票
		function initflash(){
	        baidu.swf.create({
	            "id": "uploadFile",
	            "url": "/static/flash/topicUploader.swf",
	            "width": 95, 
	            "height": 45,
	            "ver": "9.0.28",
	            "errorMessage": "Please download the newest flash player.",
	            "bgcolor": "#ffffff",
	            "wmode": "window",
	            "allowscriptaccess": "always",
	            "vars": {
	                'uploadURL': '/upd/submit',
	                'fileType': '[{"description":"图片", "extention": "*.jpg,*.png"}]',
	                'maxNum': '1',
	                'maxSize': '3',
	                'uploadStartCallback': 'uploadStart',
	                'uploadCompleteCallback': 'uploadComplete',
	                'uploadErrorCallback': 'uploadError',
	                'fileSelectedCallback': 'fileSelected',
	                'setPostCallback': 'setPost'
	            }
	        },"selectedPhoto");					
		};
		function initFloatLayer(){
			initflash();
			title.val('');
			$('.photo-name').val('');
			$('.mod-floatLayer .error-msg').remove();
			$('.photo-submit').removeClass('disabled-btn');
			$('.mod-floatLayer').floatLayer({ animation: true,maskColor:'#000', maskOpacity:0.8,animationTime: 200 }).trigger("showFloatLayer"); 			
		}
		function tipError(str){
			return $("<span class='error-msg ci'>"+str+"</span>");
		}
		$('.upload-photo-btn').bind('click', function(event) {
			var me=this;
            ting.passport.checkLogin(function(){
            	upd_id=$.metadata.get(me).ud_id;
            	initFloatLayer();
            }, function(){}, function(){}, function(){});
			return false;		  
		});	
		$('.mod-floatLayer .close').bind('click',function(){
			$('.mod-floatLayer').trigger("hideFloatLayer"); 
			return false;
		})
		
		//message窗口关闭
		$('.mod-messageLayer .close,.mod-messageLayer .message-ok-btn,.mod-messageLayer  .message-cancel-btn').bind('click',function(){
			$('.mod-messageLayer').floatLayer("hide");
			return false;
		})		
		$('.mod-messageLayer .message-try-btn').bind('click',function(){
			//$('.mod-messageLayer').floatLayer("hide");
			initFloatLayer();
			return false;
		})		
		$('.argeement-link').bind('click',function(){
			$('.argeement-content').toggle();
			return false;
		})
		
        window.fileSelected = function( data ){
        	photo=data;
        	$('.photo-name').val( data.name );
        }	
        window.uploadStart = function(){

        }
        window.uploadComplete = function( info ){
        	$('.photo-submit').removeClass('disabled-btn');
            var data = eval( '('+ info.data +')' );
			
            if( data.error == 22000 ){
            	$('.mod-floatLayer .error-msg').remove();
            	$('.mod-messageLayer .upload-sucess').show();
            	$('.mod-messageLayer .upload-fail').hide();
				$('.mod-messageLayer').floatLayer({ animation: true,maskColor:'#000', maskOpacity:0.8,animationTime: 200 }).trigger("showFloatLayer"); 
				$('.mod-messageLayer').floatLayer("getMask");	
            }else{
            	$('.mod-messageLayer .upload-sucess').hide();
            	$('.mod-messageLayer .upload-fail').show();
				$('.mod-messageLayer').floatLayer({ animation: true,maskColor:'#000', maskOpacity:0.8,animationTime: 200 }).trigger("showFloatLayer"); 
				$('.mod-messageLayer').floatLayer("getMask");
            }
        }
        //-----------------------------------------------[上传失败]
        window.uploadError = function(){         
        }
        //-----------------------------------------------[设置需要一起post的数据, 接受一个类型为Object的返回值, flash将把object内容直接发送给后端]
        window.setPost = function(){
            post[ 'image_title' ] = $( '.upload-title-hook' ).val();
			post[ 'ud_id' ]=upd_id;
            return post;
        }        
        //
        $('.photo-submit').bind('click',function(){
        	var flag=true,uploader = baidu.swf.getMovie( "uploadFile" );
        	if($(this).hasClass('disabled-btn')){
        		return false;
        	}
        	$('.mod-floatLayer .error-msg').remove();
        	if($.trim(title.val())==""){
        		flag=false;
        		title.after(tipError('标题不能为空'));
        	}        	
        	if($.ting.byteLength($.trim(title.val()))>100){
        		flag=false;
        		title.after(tipError('输入文字已超出限制字数'));
        	}
        	if((!photo.size)||photo.width>1200||photo.height>1200||photo.width<150||photo.height<150||photo.size > 2.5 * 1048576){
        		flag=false;
        		$("#selectedPhoto").after(tipError('图片不符合要求'));
        	}      
        	if(!$("#argeementCheck").attr("checked")){
         		flag=false;
        		$(".argeement-link").after(tipError('您还没有同意图片上传协议！'));       		
        	}  	    
        	if(!flag){
        		return false;
        	} 	
        	uploader.uploadFile();
        	$(this).addClass('disabled-btn');
        	photo={};
        	return false;
        })
	}
	if ($('.mod-piclist').length) {
		var pageNavigator = $( '.mod-piclist .page-navigator-hook').pageNavigator({ hash:'#'+$('.mod-piclist')[0].id });
		pageNavigator.bind( 'pagenavigator.pagechange', function( e, data ) {
			var item=$(this).parents(".tab-item"),
				arg={},
				target=$('.pic-content',item);
				arg=$.extend($.metadata.get(target[0]), data);
				$.ting.refreshTrigger.refresh(target,'/data/topic/imagelist',arg,function(){
				},'t')
		} );		
		//显示翻页
		$('.mod-piclist .page-navigator').show();
	};

    $(".topic-up,.topic-down").tip();
    $(".topic-up,.topic-down").bind('click',function(){
        var _this=this,
             post=$.metadata.get(_this)||{};
        ting.connect.topicUpd(null,post,function(result){
            var val=parseInt($(_this).text());
            $(_this).html(++val);       
            $(_this).tip("tipup",{msg:"投票成功！",iconClass:"tip-success"});
        },function(result){
            $(_this).tip("tipup",{msg:ting.errorMap[result.errorCode]||"投票失败!",iconClass:"tip-error"}); 
        })
        return false;
    })	
	
	
	
	
	//end
	//专辑
	$(".album-cover-hook").albumCover();
		
	//播放列表
	$('.song-list-hook').songList();
	//单曲内嵌播放器
	//tab
	if( $(".topic-tab").length ){

		$(".topic-tab").tab({
			tabList : ".tab-nav .btn",
			contentList : ".tab-item",
			tabActiveClass : "btn-p",
			callBackStartEvent : function(index , me , oldindex){
				var activeTab=$($('.tab-body .tab-item', me )[index]);
				if($('.topic-lazyload',activeTab).length){
					ting.LL.add($(".topic-lazyload:not(.notlazy .topic-lazyload)",activeTab));
				}	
			}
		});
	}
	//音乐墙
	var $wallDisc=$('.mod-music-library .discriptions .discription');
	var $wallAlbum=$('.mod-music-library .music-wall div.cover');
	$('.mod-music-library .music-wall div.cover').hover(function(e){
		var index=$wallAlbum.index(this);	
		var leftpos=(index%4==0)||(index%4==3)?1:((index%4==1)?2:0);
		$($wallDisc[index]).css({left:leftpos*150,top:Math.floor(index/4)*150}).show();
	},function(e){
		var index=$wallAlbum.index(this);
		$($wallDisc[index]).hide();
	})

	$(".pic-album .mod-list").roll({
		screen:".page-list-pic-album  .page-inner",
		rollList:".page-inner>ul",
		rollNum:4.5,
		callBack:function(obj){
			var $list=$('>li',obj.rollList);
			var $view=$('.page-list .pic-img img',obj.element);	
			var $indexNum=$('.index-num',obj.element);	
			$list.bind('click',function(e){		
				var index=$list.index(this);	
				$view.attr("src",$('img',this).attr("src")).data('index',index);
				$indexNum.text(index+1);
				$('.page-list-wrap .pic-title>span',obj.element).html($('img',$list[index]).attr("title")); 
				return false;
			})		
			$('.pic-album-left-btn,.pic-album-right-btn,.page-list .pic-img img',obj.element).bind('click',function(e){
				ting.LL.add($(".pic-album .lazyload:not(.notlazy .lazyload)"));
				var dir=$(e.currentTarget).hasClass('pic-album-left-btn')?'prev':'next';
				var index=$view.data('index')||0;
				if(index<=0&&dir=='prev'){return false;}
				if(index>=$list.length-1&&dir=='next'){return false;}
				index=$list.index($($list[index])[dir]());
				$view.attr("src",$('img',$list[index]).attr("src")).data('index',index);
				$indexNum.text(index+1);
				$('.page-list-wrap .pic-title>span',obj.element).html($('img',$list[index]).attr("title"));
				return false;
			})	
		}
	});
	$(".pic-list .mod-list").roll();	
	$(".mod-album .mod-list").roll();
	$(".mod-star-album .mod-list").roll();
	$(".mod-album-detailed .mod-list").roll();
	//播放单曲
	$( '.play-btn' ).click( function() {
		ting.media.playSong( $(this).metadata().id );
		$(this).tip().tip("tipup", {
                        msg: "已开始播放",
                        iconClass: "tip-success"
                    });
		return false;
	} );
	$(".mod-video .page-list-video").roll({
		screen:".page-inner",
		rollList:".page-inner>ul",
		rollNum:4,
		callBack:function(obj){
			$(".video-index",obj.rollList).bind('click',function(e){
				$(".on",obj.rollInner).removeClass("on");
				$(e.currentTarget).addClass('on');
				var videoId = $(this).attr("rel");
	//loadvideo
		    baidu.swf.create({
	           id : "video",
			   width : "100%",
	           height : 380,
	           "ver": "9.0.28",
			   "errorMessage": "Please download the newest flash player.",
			   url : "http://www.yinyuetai.com/swf/explayer.swf?videoId=" + videoId + '&epId=1&t=' + ( new Date().getTime() ),
	           "bgcolor": "#ffffff",
               "wmode": "window",
               "allowscriptaccess": "always",
	           vars: { "autoplay":true }
	       	}, $("ul li",obj.element.prev())[0]);				

	//loadvideo			
				return false;
			})
		}
	});
	
	//图片弹出层lightbox
	$('#picLightboxList a').lightBox();
	$(".play-all-btn").click(function(e){
		var ids =  !!$(this).data("playdata")  ?   $(this).data("playdata").ids : $(this).metadata().button.data ;
		var opt = {
			moduleName : !!$(this).data("playdata") ? $(this).data("playdata").moduleName : ""
		};
		
		ting.media.playSong( ids.split(',') , opt);
		$(this).tip().tip("tipup", {
                        msg: "已开始播放",
                        iconClass: "tip-success"
                    });
		return false;
	} );
    //video pop
	$(".mod-video-right .video-pic").bind('click',function(e){
	  var name = "Height",
          popH = Math.max(document.documentElement["client" + name], document.body["scroll" + name], document.documentElement["scroll" + name], document.body["offset" + name], document.documentElement["offset" + name]),
		  popCont = "<div class='popup-mask-topic' style='height:" + popH + "px'></div>"
	               +"<div class='popup-wrapper-topic' id='popupWrapper'>"
				     +"<i class='pop-close' id='popClose'></i>"
					 +"<div id='popFlash'></div>"
				   +"</div>";
	  $(document.body).append(popCont);
	  $("#popupWrapper").css({
					 visibility: 'visible',
					 top: $( window ).height()/2 - 300 + $( document ).scrollTop() + 'px'
      })
	  baidu.swf.create({
	           id : "rightVideo",
			   width : "100%",
	           height : "600",
	           "ver": "9.0.28",
			   "errorMessage": "Please download the newest flash player.",
			   url : "http://www.yinyuetai.com/swf/explayer.swf?videoId=" + $(this).attr("rel") + '&epId=1&t=' + ( new Date().getTime() ),
	           "bgcolor": "#ffffff",
               "wmode": "window",
               "allowscriptaccess": "always",
	           vars: { "autoplay":true }
	       	}, document.getElementById("popFlash"));  
    })
	/*
	$(document).click(function(e){
		var evt = e || window.event,
		    el = evt.srcElement || evt.target;
		if($(el).hasClass("pop-close")){
		    $(".popup-mask").remove();
	        $("#popupWrapper").remove();	
		}
	});
	*/
	$('.pop-close').live('click',function(){
		    $(".popup-mask-topic").remove();
	        $("#popupWrapper").remove();			
	})


	/* 右侧分享模块 */
	var goUpDuration = 200,
		interval = 500,
		timer = null,
		isIE6 = $.browser.msie && parseFloat($.browser.version) < 7,
		goUp = function () {
			$body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'); // opera fix
			$body.stop().animate( { scrollTop: 0 }, goUpDuration);
		},
		showQr = function () {

		},
		locateShare = function () {
			var $share = $("#share"),
				$win = $(window),
				shareHeight = $share.height(),
				winHeight = $win.height(),
				shareTop = (winHeight - shareHeight) / 2;

			if (isIE6) {
				shareTop += $win.scrollTop();
			}

			if (shareTop < 0) {
				shareTop = 0;
			}	

			$share.css("top", shareTop).show();
		},
		initShare = function () {
			var $up = $("#share_up"),
				$win = $(window),
				$weixin = $("#share_weixin"),
				$weixinShare = $("#share_weixin_detail");

			$up.click(function () {
				goUp();
				return false;
			});

			$weixin.hover(function () {
				$weixinShare.show();	
			}, function () {
				$weixinShare.hide();	
			});

			$win.bind("resize", function () {
				locateShare();
			});

			if (isIE6) {
				timer = setInterval(function () {
					locateShare();
				}, interval);
			}

			locateShare();
		};
	
	initShare();
	/**/



	//图片延迟加载
	ting.LL.add(".lazyload:not(.notlazy .lazyload)");
document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();	


	$(".follow-weibo-box a").click(function(){
		ting.logger.log("click", { ref:"web",page:"c_topic_d",pos:"share_weibo" } );
	});
	$(".mobileapp-down a").bind("click",function(){
		ting.logger.log("click",{ ref:"web",page:"c_topic_d",pos:"ad_left_1" });
	});

	//收藏歌单
	$(".playlist-add").bind('click',function  () {
		$(this).collectPlaylist();
        return false;           
	});

  //papa related
  var papa = $('#papa-follow');
  papa.hoverShow($('.follow-target', papa),{delay:0});
});

