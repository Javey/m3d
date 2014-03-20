{extends file="vip/mod_intro_template_with_desc.html.tpl"}
{block name="service_intro"}
    <p>百度音乐为VIP会员可以优先体验</p>

    <div class="newfeatures">
	    <ul>
			<li><span>最新版本的百度音乐产品</span></li>
			<li><span>最新推出的VIP功能</span></li>
			<li><span>最火的独家资源</span></li>
			<li><span>最精彩的会员活动</span></li>
	    </ul>
	</div>
{/block}

{block name="service_detail"}
	{$imgs = [
		[
			"img" => "newfeature_musicpc.png"
		],
		[
			"img" => "newfeature_musicmobile.png"
		],
		[
			"img" => "newfeature_newfeature.png"
		],
		[
			"img" => "newfeature_download.png"
		]
	]}

    <div class="module-a-title">
        <h2 class="title"><i class="icon"></i>立即体验</h2>
    </div>
    <div class="vip-privilege-block-split"></div>

    <div class="vip-newfeature-list"></div>

{literal}
	<style>
		.newfeatures ul li {
			float: none;
			width: auto;
			height: auto;
			margin: 0;
			font-size: 14px;
			margin: 0 0 0 24px;
			list-style-type: disc;
    		color: #c53a39;
    		line-height: 25px;
		}

		.newfeatures ul li span {
			color: #333;
		}

		.vip-newfeature-list {
			margin-left: -6px;

			width: 744px;
			height: 454px;
			background: url(/static/images/vip/home/newfeature_inner.png) no-repeat;
			_background: none;
		    _filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='corp',src='/static/images/vip/home/newfeature_inner.png');
		}
	</style>
{/literal}
{/block}


