<style type="text/less" target="../../song_page/song_page.css">
    #download-clients {
        width: 710px;
        height: 70px;
        border: 1px solid #E9E9E9;
        position: relative;
    }
    #info-wrapper{
        width: 200px;
        float: left;
    }
    #clients-wrapper {
        float: left;
        width: 510px;
    }
    #clients-info {
        margin: 11px 25px;

        .bd-music-logo{
            float: left;
            margin-right: 11px;
        }
        .bd-music-text{
            margin-top: 4px;
            float: left;
        }
        em{font-weight: bold;}
    }
    #clients-container{
        height: 32px;
        margin: 19px 0 19px 0px;
        padding-left: 15px;
        border-left: 1px solid #E2E2E2;
        line-height: 32px;

        a {color: #666}

        li {
            float: left;
            width: 115px;
        }

        .icon {
            float: left;
            margin-right: 10px;
        }
    }
    .css-icon-bd-music {
        width: 48px;
        height: 48px;
        background: url(/static/images/icon/bd-music.png) no-repeat;
        merge: blue;
    }
    .css-icon-pc {
        width: 44px;
        height: 30px;
        background: url(/static/images/icon/pc-icon.png) no-repeat;
    }
    .css-icon-android{
        width: 25px;
        margin-top: 1px;
        height: 28px;
        background: url(/static/images/icon/android-icon.png) no-repeat;
    }
    .css-icon-iphone {
        width: 25px;
        height: 30px;
        background: url(/static/images/icon/iphone-icon.png) no-repeat;
    }
    .css-icon-ipad {
        width: 25px;
        height: 31px;
        background: url(/static/images/icon/ipad-icon.png) no-repeat;
    }
</style>
<div id="download-clients">
    <div id="info-wrapper">
        <div id="clients-info">
            <div class="bd-music-logo css-icon-bd-music"></div>
            <div class="bd-music-text"><em>百度音乐客户端</em><br>听歌，随时随地</div>
        </div>
    </div>
    <div id="clients-wrapper">
        <ul id="clients-container">
            <li>
                <a class="clients-pc" href="http://qianqian.baidu.com/download/BaiduMusic-31000121.exe" data-log='{ "pos":"pc_down" }' target="_blank">
                    <span class="icon css-icon-pc"></span>PC版
                </a>
                <!-- 百度音乐下载浮层 -->
                <div class="pc-tips">
                    <span class="arrow-up"></span>
                    <a href="http://qianqian.baidu.com/download/BaiduMusic-12345628.exe" target="_blank">
                        <img org_src="/static/images/music/down-pc-bg.png" alt=""/>
                        <div class="pc-tips-download btn btn-a"><span class="inner">快速安装</span></div>
                    </a>
                </div>
            </li>
            <li >
                <a class="clients-android" href="http://music.baidu.com/cms/mobile/static/apk/BaiduMusic_danqu.apk" data-log='{ "pos":"android_down" }'  target="_blank" >
                    <span class="icon css-icon-android"></span>Android版
                </a>
            </li>
            <li>
                <a class="clients-iphone" data-log='{ "pos":"iphone_down" }'  href="#">
                <span class="icon css-icon-iphone"></span>
                iPhone版
                </a>
            </li>
            <li>
                <a class="clients-ipad" data-log='{ "pos":"ipad_down" }'  href="http://music.baidu.com/app/pad" target="_blank">
                <span class="icon css-icon-ipad"></span>iPad版
                </a>
            </li>
        </ul>
    </div>
    <div class="pop-tips ios-tips">
        <i class="arrow-up"></i>
        <a class="close" href="#"></a>
        <p class="tip-head">扫描下方的二维码立即安装，好音乐无处不在！</p>
        <div class="down-logo"><img width="110" height="110" org_src="/static/images/2code/app-down-danqu.png" src="{#PIC_PLACEHOLDER#}"/></div>
        <p class="tip-foot">手机访问music.baidu.com更快捷</p>
    </div>
</div>

<script type="text/javascript" target="../../song_page/song_page.js">
    /**
     * 百度音乐客户端浮层事件注册
     */
    var pcTipsTID;
    $('.clients-pc').on('mouseenter',function () {
        var obj = $('.pc-tips');
        ting.loadChildImages(obj, arguments.callee);
        obj.show();
        ting.logger.log("exposure", {
            page: ting.logger.getPage(),
            expoitem: 'pannel_dl_qianqian'
        });
    }).on('mouseleave', function () {
            pcTipsTID = setTimeout(function () {
                $('.pc-tips').hide();
            }, 100);
        });
    $('.pc-tips').on('mouseenter', function () {
        clearTimeout(pcTipsTID);
    }).on('mouseleave', function () {
            $(this).hide();
        }).on('click', function () {
            ting.logger.log('click', {
                pos: 'dl_qianqian',
                page: 'panel',
                sub: ting.logger.getPage()
            });
        });
    /**
     * 点击iPhone客户端弹出二维码
     */
    $('.clients-iphone').click(function(){
        var leftOffset = 295;
        var obj = $('.ios-tips');
        ting.loadChildImages(obj, arguments.callee);

        obj.css('display') === 'none' ? obj.css('left', leftOffset).fadeIn() : obj.fadeOut();
        return false;
    });
    $('.ios-tips .close').click(function(){
        $('.ios-tips').fadeOut();
        return false;
    });

    /**
     * 统计
     */
    $(".clients-iphone,.clients-pc,.clients-iphone,.clients-ipad",$("#download-clients")).bind('click', function  () {
        ting.logger.plogClick($(this).data("log").pos);
    });
</script>