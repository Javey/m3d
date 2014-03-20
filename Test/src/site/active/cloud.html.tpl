{extends file="ting.html.tpl"}
{block name="head" append}
<link rel="stylesheet" type="text/css" href="/site/active/cloud.css" />
{/block}
{block name="body_class"}
class="active-cloud"
{/block}
{block name="title"}免费领取VIP会员{/block}
{block name="content_main"}
{include file="vip/power_list_config.html.tpl" inline }
{include file="active/mod_cloud.html.tpl"}
{/block}



{block name="js-page"}
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
    var bds_config = { 'bdText':'免费领取百度音乐VIP会员特权！ （分享自@百度音乐）'};
    var receiveStatus = {if $tplData.data.serviceinfo}true{else}false{/if};
    document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
    /*初始化dialog*/
	$(".cloud-dialog").dialog( {
		confirm : {
			btn : ".confirm"
		}
	} );
    $(".cloud-btn").bind("click", function(){
    	var self =$(this);
    		
	    	ting.connect.getCloud(null,null,function(result){
	    		/*
	    		given : {
					-1 : 领取失败
					1 : 领取成功
					2 ： 已经领取过
	    		}
	    		 */
	    		if( result.data.given == 1){
		    		$(".cloud-dialog").dialog("show");
	    			var opt = {
						page : "cloud",
						pos : "get_cloud"
					};
					ting.logger.log("click", opt );
		    		self.removeClass("cloud-btn")
	    			.addClass( "cloud-already").unbind();
	    		}
	    	},function(result){
	    		self.tip();
	    		if( result.data.given == -1 ){
		    		self.tip("tipup", {

						msg: result.errorMessage || "领取失败",
						iconClass: "tip-error"
					});
	    			
	    		}else if( result.data.given == 3 ){
	    			self.tip("tipup", {
						msg: "抱歉！活动已经结束",
						iconClass: "tip-error"
					});
	    		}else{
					self.removeClass("cloud-btn")
	    			.addClass( "cloud-already").unbind();
	    			self.tip("tipup", {

						msg: "不要太贪哦！您已经领取过了！",
						iconClass: "tip-error"
					});
	    		}
	    	});
    	
    	
    	return false;
    });


    /*ting.passport.checkLogin(function(){
					//登录成功回写状态
					getDownPower();
				},function(){},function(){},function(){} );*/
</script>

{/block}
{block name="body_fixed_pop"}
{include file="active/cloud_dialog.html.tpl"}	
{/block}}