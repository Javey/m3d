{extends file="ting.html.tpl"}
{block name="head" append}
<link rel="stylesheet" type="text/css" href="/static/css/user_center.css{*version file='/static/css/user_center.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="body_class"}
class="receive"
{/block}
{block name="title"}免费领取{/block}
{block name="content_main"}
{include file="usercenter/mod_receive.html.tpl"}
{/block}



{block name="js-page"}
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
    var bds_config = { 'bdText':'免费领取百度音乐音乐下载特权！ （分享自@百度音乐）'};
    var receiveStatus = {if $tplData.data.serviceinfo}true{else}false{/if};
    document.getElementById("bdshell_js").src = "http://share.baidu.com/static/js/shell_v2.js?t=" + new Date().getHours();
    /*初始化dialog*/
	$("body").dialog( {
		confirm : {
			btn : ".confirm"
		}
	} );
    $(".receive-btn").bind("click", function(){
    	var self =$(this);
    		
	    	ting.connect.getReceive(null,null,function(result){
	    		/*
	    		given : {
					0 : 领取失败
					1 : 领取成功
					2 ： 已经领取过1
	    		}
	    		 */
	    		if( result.data.given == 1){
		    		$("body").dialog("show");
	    			var opt = {
						page : "gift",
						pos : "get_gift"
					};
					ting.logger.log("click", opt );
	    		}
	    		self.removeClass("receive-btn")
    			.addClass( "receive-already");
	    	},function(result){

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
{include file="usercenter/receive_dialog.html.tpl"}	
{/block}}