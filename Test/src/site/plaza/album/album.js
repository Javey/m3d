$(function(){

		$(".focus-hook").anyfocus();
		$('.album-list .songlist-fold-hook').songlistExpand({
			hotBar :true,
			moduleName : "albumlist"
		});
		$(".album-cover-hook").albumCover();

		var $slide = $(".slide-hook");
		var ul = $("ul",$slide);
		var $inner = $(".slide-inner",$slide);
		var $action = $(".slide-action",$slide);
		var currentTop=0, outHeight=ul.outerHeight(), maxHeight = 305, inHeight; 
		
		if( outHeight > maxHeight ){
			$slide.height(350);
			$inner.height(maxHeight);
			$inner.addClass("over-wrap");
			ul.addClass("overtop");
			$action.show();
		}

		inHeight=$inner.outerHeight();
		
		$action.click(function(){

			var oriTop=currentTop, changeTop = currentTop, _this=this , step=150;

			if($(this).hasClass('slide-down')){
				currentTop-=step;
				changeTop = currentTop;
				if(inHeight+Math.abs(currentTop)>outHeight){
						currentTop=inHeight-outHeight;
				}
			}
			else{
				currentTop+=step;
				changeTop = currentTop;
				if(currentTop>0){
						currentTop=0;
				}
			}

			ul.animate({ top : currentTop },'fast',function(){		
				//some handler
			});
			
			return false;

		});

    $(".sort-btn .order-select").bind("change",function(){
      window.location.href = this.value;
    });

});
/*
$(function(){
	var $selectedArea, $selectedType;
	var $itemArea = $("#by-area a"),
		$itemType = $("#by-type a");

	$itemArea.click(function () {
		if ($selectedArea) {
			$selectedArea.removeClass();
		}
		$selectedArea = $(this);
		$selectedArea.addClass("selected");
	});
	$itemType.click(function () {
		if ($selectedType) {
			$selectedType.removeClass();
		}
		$selectedType = $(this);
		$selectedType.addClass("selected");
	})
});
*/