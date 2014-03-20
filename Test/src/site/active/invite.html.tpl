{extends file="ting.html.tpl"}
{block name="head" append}
<link rel="stylesheet" type="text/css" href="/site/active/invite.css" />
{/block}
{block name="body_class"}
class="invite"
{/block}
{block name="title"}VIP会员免费领,最高可达3个月{/block}
{block name="content_main"}
{include file="active/mod_invite.html.tpl"}
{/block}



{block name="js-page"}
<script type="text/javascript" src="/static/js/ZeroClipboard.js"></script>
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004&amp;mini=1"></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript"> 
    /*初始化dialog*/
    $(".invite-dialog").dialog( {
        confirm : {
            btn : ".confirm",
            callback: function() {
                $(".invite-dialog").dialog("close");
                $('.get_vip').slideUp(1000,function(){
                    $(".step_get7").css('height','40px');
                    vipGetDialogCallback();
                });
            } 
        },
        cancel : {
            "btn": ".cancel",
            "close": true,
            callback: function() {
                vipGetDialogCallback();
            }
        },
        close: {
            callback: function() {
                vipGetDialogCallback();
            }
        }
    } );

    //活动结束
    inviteEnd();  

    $("#ac-invite-desc").bind('click', function(){
        pageScroll('invite-desc');
    });

    $("#ac-vip-power-list").bind('click', function(){
        pageScroll('vip-power-list');
    });

    var isvip = {if $loginInfo.vip}1{else}0{/if};
    if(isvip){
        $(".get_vip").remove();
        $(".step_get7").css('height','40px');

        // share
        var bdshare_txt = "3个月【百度音乐VIP会员】免费拿，快来领吧~ （分享自 @百度音乐）",    //分享内容
            bd_pic = 'http://music.baidu.com/cms/images/vip_invite.jpg',    //分享图片
            bd_desc = '百度音乐VIP会员：拥有超大云存储空间，高品质音乐播放，音频压缩等多项特权，你想要的，这里都有！',   //分享摘要
            share_url = 'http://music.baidu.com/home/vip/invite?bid=' + {if $tplData.loginInfo.ting_uid}{$tplData.loginInfo.ting_uid}{else}-1{/if};

        $("#bdshare").attr('data', "{ 'url': " + share_url +" }");
        var bds_config = { 
            'bdText': bdshare_txt,
            'bdPic': bd_pic,
            'bdDesc': bd_desc
        };
        document.getElementById('bdshell_js').src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + new Date().getHours();

        // copy
        $('.input_share .is_btn').css('cursor','pointer');



        var clipboard = new ZeroClipboard( $('.input_share .is_btn'), {
          moviePath: "/static/flash/ZeroClipboard.swf"
        } );
        
        $('.input_share .is_btn').tip({
            msg: '复制成功',
            iconClass: 'tip-success'
        })

        clipboard.on('complete', function (client, args) {
          $('.input_share .is_btn').tip('tipup');
            var opt = {
                page : "invite",
                pos : "copy"
            };
            ting.logger.log("click", opt );          
        });        

    }

    var receiveStatus = {if $tplData.data.serviceinfo}true{else}false{/if};

    function vipGetDialogCallback(){
        window.setTimeout(function(){
            window.location.reload(true);
        }, 1000);
    }

    /*login*/
    $(".login-btn").bind('click',function(){
        if (ting && ting.passport && ting.passport.checkLogin) {
            ting.passport.checkLogin(function(){
                //登录成功回写状态
                window.location.reload(true);
            },function(){},function(){},function(){} );
        }
    });
    /*领取7天VIP资格*/
    var $receiveBtn = $(".receive-btn");
    $receiveBtn.bind("click", function(){
    	var self =$(this);
        var inviteUid = {if $tplData.inviteInfo.ting_uid}{$tplData.inviteInfo.ting_uid}{else}-1{/if};

        var param = [inviteUid];

    	ting.connect.getVipSevenDays(param,false,function(result){
    		if( result.data.given == 1){
	    		$(".invite-dialog").dialog("show");
    			var opt = {
					page : "invite",
					pos : "vip_7free"
				};
				ting.logger.log("click", opt );
    		}
    		self.removeClass("link_get7,receive-btn")
			.addClass( "receive-already");
    	},function(result){
            // 已领取VIP
            window.location.reload(true);
    	});
    	
    	
    	return false;
    });

    $(document).ready(function(){
      setTimeout(function(){ window.scrollTo(0, 90); }, 100); 
    });

    $(document).bind("userbarlogined", function () {
        window.location.reload(true);
    });

    function pageScroll(el){
        var el_top = $('#' + el).offset().top;
        setTimeout(function(){ window.scrollTo(0, el_top); }, 100);
    }

    function inviteEnd(){
        var endTime =new Date();
            endTime.setFullYear(2013,4,22);
        var today = new Date();

        if (endTime < today){
            $(".invite-dialog .head .close").remove();
            $(".vip_get_success").remove();
            $(".vip_end").show();
            $(".invite-dialog").dialog("show");
            return false;
        }
    }
</script>

{/block}
{block name="body_fixed_pop"}
{include file="active/invite_dialog.html.tpl"}   
{/block}}