$(function(){

	$(".play-all-hook").click(function(){
		/*如果RD没有top50数据则从当前的20首歌曲取id*/
		var ids =$(this).data("ids") ? $(this).data("ids").toString().split(",") : $(this).data("playdata").ids,
			opt = {
				moduleName : $(this).data("playdata").moduleName
			};
		ting.media.playSong(ids,opt);
		$(this).tip().tip("tipup", {
                        msg: "已开始播放",
                        iconClass: "tip-success"
                    });
        /* 点击统计 start by lutaining */
        if (ting && ting.logger && ting.logger.plogClick) {
            ting.logger.plogClick("play_all");
        }
        /* 点击统计 end by lutaining */

        //bdbrowser effect
        if(ting.browser.isSpecial()){
            ting.browser.add2box('play');
        }
		return false;
	});	
});
