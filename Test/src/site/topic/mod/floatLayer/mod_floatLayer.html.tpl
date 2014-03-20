{include file="widget/button/button.html.tpl" inline}
<div class="mod-floatLayer" monkey="mod-floatLayer{$index}" id="mod_{$modData.parames.module_id}">
	<div class="mod-head">
		<a href="#" class="close"></a>
		<h2 class="mod-title">{$modData.parames.title}</h2>
		<a href="layer-close"></a>
	</div>
	<div class="body clearfix">
			<div>
				<h3 class="">输入标题：</h3>
				<div>
					<input  name="title" class='input-text upload-title-hook'></input>
				</div>
				<p class="cl mb15p">最多50个汉字</p>
			</div>
			<div>
				<h3>选择文件：</h3>
				<div>
					<div class="select-file">
					<input type="text" name="title" class='input-text photo-name'  disabled="" /><span  id="selectedPhoto"></span>
					</div>
					<p class="cl mb10p">
						图片尺寸范围在：150px*150px ~ 1200px*1200px<br/>
						文件大小不超过：2.5mb<br/>
						一次只能上传一张图片		<br/>			
					</p>
				</div>
			</div>		
			<div class="separated"></div>
			<div class="photo-argeement">
				<input type="checkbox" checked id="argeementCheck" /> 我已同意<a href="#" class="argeement-link" target="_blank">《ting首发图片上传协议》</a>
			<p class="argeement-content">
以下是您与〔BAIDU〕（“百度公司”）达成的法律协议，协议条款对您参与林俊杰We Together”派对照片秀活动并上传照片、图片的有关权利事宜进行了规定。若您完全理解并接受这些条款，请点击“同意”。若不接受这些条款，请不要点击“同意”，并且关闭或退出本页面。

作为照片、图片的上传者，您承诺拥有上传照片、图片的著作权，照片中所包含人物的肖像权使用许可以及其它必要的许可，同时须保证上传的照片、图片不侵犯任何第三人的著作权、肖像权、名誉权、隐私权、商标权、商号权等其他合法权益。

在满足上述权利保证的前提下，百度有权将您上传的照片、图片用于林俊杰We Together派对照片秀大赛活动。

因上传的照片、图片侵犯任何第三方的知识产权、肖像权、名誉权等合法权益使百度遭受损失的，您承诺愿意独自承担相关责任并赔偿百度所遭受的损失。				
			</p>				
			</div>

			{button style="b" class='photo-submit' width=110 str = '上    传' href = '#' isShadow = false}
	</div>
</div>
<div class="mod-messageLayer">
	<div class="mod-head">
		<a href="#" class="close"></a>
		<h2 class="mod-title">{$modData.parames.title}</h2>
		<a href="layer-close"></a>
	</div>
	<div class="body clearfix">
		<div class="upload-sucess">
			<div class="info">
			    <h3>上传成功！</h3>
			    <p class="desc">您的图片在审核后会出现在展示区。</p>
			</div>
			<div class="message-btns">
			{button style="f" class='message-ok-btn' width=100 str = '知道了' href = '#' isShadow = false}
			</div>
		</div>
		<div class="upload-fail">
			<div class="info">
			    <h3>上传失败！</h3>
			    <p class="desc">请您确认上传的图片是否符合要求。</p>
			</div>
			<div class="message-btns">
			{button style="f" class='message-try-btn' width=100 str = '重试' href = '#' isShadow = false}
			{button style="f" class='message-cancel-btn' width=100 str = '取消' href = '#' isShadow = false}
			</div>
		</div>		
	</div>
</div>