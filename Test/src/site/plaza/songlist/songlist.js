(function($,undefined){
	var tagName=encodeURIComponent($(".content").data("tag")||"");
     $(".songlist-collection").songCollection({tag:tagName});
     $("#nav-more-link").bind("click",function  () {
     	$(".nav-more").show();
     	$(this).hide();
     	return false;
     });
     $("#nav-fold").bind("click",function  () {
     	$(".nav-more").hide();
     	$("#nav-more-link").show();
     	return false;
     });
    var isIE6 = ($.browser.msie && parseFloat($.browser.version) < 7),//判断是否ie6
    isIE7 = ($.browser.msie && parseFloat($.browser.version) == 7),
    	$nav=$("#songlistNav"),
    	loading=true,
	    fixTop=$(".songlist-content ").offset().top||180,
	    $streamCont=$(".songlist-stream .content"),
	    $stream=$(".stream-item"),
	    $loading=$(".songlist-stream .loading"),
	    noresult=false;
	    star=$streamCont.data("count");
	$(window).scroll(function(){
		// 被卷去的高度
		var scrollTop = document.body.scrollTop||document.documentElement.scrollTop;
		// 页面高度
		var pageHeight = $(document).height();
		// 可视区域高度
		var viewHeight = $(window).height();
		if(isIE6){
			if(scrollTop>fixTop){
				$nav.css("top",(scrollTop-fixTop)+"px");
			}else{
				$nav.css("top","0px");
			}
		}else{

			if(scrollTop>fixTop){
				if(isIE7){
					$nav.css("left",$(".songlist-content ").offset().left+"px");
				}
				$nav.addClass("nav-fixed");

			}else{
				$nav.removeClass("nav-fixed");
				if(isIE7){				
					$nav.css("left","0px");
				}
			}			
		}

		//当滚动到底部时
		if((scrollTop+viewHeight)>(pageHeight-200)){
			//
			var loadStar=0;
			if((!loading)||noresult){
				return false;
			}
			$loading.show();
			
			// 收起展开的歌单列表
			if($.ting.songCollection.$upWidget){
				$.ting.songCollection.$upWidget.songCollection("foldList");
				$.ting.songCollection.$upWidget=null;
			}			
			var streamContHeight=$streamCont.height(),
				pushStreamCont=[],
				minStream=0;
				//功能1：计算每个瀑布流的高度，取出最短的那列 loadStar
				//功能2：取出高度差大于300PX的列进行补全策略
				$stream.each(function(i,v){
					var _h=$(v).height();
					if(i==0){
						minStream=_h;
					}else{
						if(_h<minStream){
							loadStar=i;
						}
					}
					if(streamContHeight-_h>300){
						pushStreamCont.push(i);
					}
				});
			var opt={},
				sizeNum=8;
			opt.start=star;
			opt.size=sizeNum+pushStreamCont.length;	
			star=star+sizeNum+pushStreamCont.length;	
			opt.tagname=$streamCont.data("tag");
			ting.connect.getSonglistCollect(opt,null,function(result){
				var cols=result.data.collectList,
					l=cols.length,
					aColEl=[],
					$colEl;
				
				if(l==0){
					noresult=true;
					$loading.hide();		
					loading=true;					
					return;
				}
				for(var i = 0,k=0; i < Math.ceil(l/4) ; i++){
					for(m=loadStar;m<4+loadStar;m++){
						if(k<sizeNum){  
							$colEl=$(cols[k++]);
							if(!isIE6){
								$colEl.hide();
							}
							$colEl.appendTo($stream[m%4]).songCollection({tag:tagName});
							aColEl.push($colEl);
							 $(".music-icon-hook",$colEl).musicIcon();
						}
					}
					if(aColEl.length&&(!isIE6)){
						$(aColEl).each(function  () {
							$(this).slideDown(300);
						})
					}
				}		
				if(pushStreamCont.length>0){
					aColEl=[];
					for(var i = 0; i <l-sizeNum ; i++){
						$colEl=$(cols[sizeNum+i]);
						$colEl.appendTo($stream[pushStreamCont[i]]).songCollection({tag:tagName});
						aColEl.push($colEl);
						$(".music-icon-hook",$colEl).musicIcon();						
					}
					if(aColEl.length){
						$(aColEl).each(function  () {
							$(this).slideDown(300);
						})
					}					
				}
				$loading.hide();		
				loading=true;

			},function  (result) {
			});		
			loading=false;	
		}
	});

})(jQuery);
