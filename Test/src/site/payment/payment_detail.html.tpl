{include file="widget/tab/tab.html.tpl" inline}

<div class="payment-detail" monkey="open-vip">
<ul class="payment-from">
	<div class="payment-category-tab clearfix">
		<ul>
			{if $currentServiceLevel != "gold"}
			<li class="payment-category-comm {if $level != 'gold'}active{/if}" data-type="comm"> 
				<i class="payment-category-comm-icon"></i>
				<div class="title">普通VIP 5元/月</div>

				<div class="subtitle">高品质试听、下载、享受精彩线下特权</div>
			</li>
			{/if}

			<li class="payment-category-premium {if $level == 'gold'}active{/if}" data-type="gold">
				<i class="payment-category-premium-icon"></i>
				<div class="title">白金VIP 10元/月</div>

				<div class="subtitle">独享无损音乐下载、音乐盒去广告</div>
			</li>
		</ul>
	</div>

	{if $loginInfo}
	<li class="clearfix item">
		<span class="label">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span>

		<div class="content">
			{include file="widget/user_name/user_name.html.tpl" inline}
			{user_name loginInfo=$loginInfo href='/home/vip' level=$tplData.data.serviceinfo.cloud.service_level}
		</div>
	</li>
	{/if}
	
	<li class="clearfix item" id="payment-time">
		<span class="label">支付时长：</span>
		<div class="paytime clearfix content">
			<div class="add up paytime-item">
				<div class="time-item">
					<label hidefocus="true" for="year">
						<input class="select-month" checked  data-months = "{$tplData['data']['service_time']}" id="year" type="radio" name="buytime" value="annual">

						<div class="time-label time-label-active" id="annual-pack">
							<span class="time-text" >年费<span class="promo">48</span>元&nbsp;&nbsp;<span class="tdl">(原价<span class="original">60</span>元)</span></span>
							<i class="time-recommend"></i>
						</div>
					</label>
					{*<label hidefocus="true" for="months9"><input class="select-month" data-months = "9" id="months9"  type="radio" name="buytime"> 9个月</label>*}
					{*<label hidefocus="true" for="months6"><input class="select-month" data-months = "6" id="months6" type="radio" name="buytime"> 6个月</label>*}
					{*<label hidefocus="true" for="months3"><input class="select-month"  data-months = "3" id="months3" type="radio" name="buytime"> 3个月</label>*}
				</div> 

				<div class="time-item">
					<label hidefocus="true" for="other"><input class="select-month" data-months = "1" id="other" type="radio" name="buytime" value="other"> 其他 </label>
					<select  name="" disabled id="otherMonths">
						<option selected="selected" value="1">1个月</option>
						<option value="2">2个月</option>
						<option value="3">3个月</option>
						<option value="4">4个月</option>
						<option value="5">5个月</option>
						<option value="6">6个月</option>
						<option value="7">7个月</option>
						<option value="8">8个月</option>
						<option value="9">9个月</option>
						<option value="10">10个月</option>
						<option value="11">11个月</option>
						<option value="12">12个月</option>
					</select>
				</div>
			</div>

			<div class="upgrade paytime-item">
				<span class="">升级剩余时间 <span class="paytime-total-day"></span> 天，需 <span class="red sum">0</span> 元
			</div>
		</div>
	</li>

	{if $serviceType == "xx"}
		{$endTime = $tplData.data.serviceinfo[$serviceType].end_time}
		<li class="clearfix item">
			<span class="label">有效期至：</span>

			<div class="content">
				<span id="endtime">{$endTime|date_format:'%Y-%m-%d'}</span>
			</div>
		</li>
	{/if}

	<li class="clearfix item">
		<span class="label">应付金额：</span>

		<div class="content">
			<span class="sum red">{$amount}</span>
			元 
			{*{if $serviceType == "cloud"}*}
			{*<span class="buy-tips" style="display:none;">（ <b class="red">8折</b> ）</span>*}
			{*{elseif $serviceType == "down"}*}
			{*<span class="buy-tips">（节省 <b class="red">10</b> 元）</span>*}
			{*{/if}*}
			

			<span class="endtime">(有效期至：<span id="endtime">{$endTime|date_format:'%Y-%m-%d'}</span>)</span>
			
		</div>
	</li>
	{*{if $serviceType == "cloud"}*}
		{*{if $tplData.data.serviceinfo}*}
		{**计算问题导致不加**}
		{**<li class="clearfix">
			<span class="label">生效时间：</span>
			2012-12-12 至 2012-12-12
		</li>**}
		{*{/if}*}
	{*{/if}*}

	<li id="payment_type" class="clearfix item">
		{$tabList = [
			[
				"link" => "#",
				"title" => "网上银行",
				"active" => 1
			],
			[
				"link" => "#",
				"title" => "快捷支付"
			],
			[
				"link" => "#",
				"title" => "百付宝"
			],
			[
				"link" => "#",
				"title" => "支付宝"
			]
		]}
		<span class="label">支付方式：</span>

		<div class="content">
			{tab tablist = $tabList}

			<div class="bfb-promo-tips">8折优惠</div>
		</div>


	</li>

	<li class="clearfix payment-type-item item">
		<div id="payment-type-list content" class="payment-type-list">
			<div id="bankContent" class="bank-content ui-tab-content">
				<div class="bank-list-wrapper">
					<span class="label">选择银行：</span>
					<ul id="tradBankList" class="bank-list clearfix content"></ul>
				</div>
			</div>
			
			<div id="easyContent" class="bank-content ui-tab-content">
				<div id="easy-bank-list" class="bank-list-wrapper">
					<span class="label">选择银行：</span>

					<div class="content">
						<ul class="card-type clearfix">
							<li>
								<label hidefocus="true" for="credit-card">
									<input class="select-month" checked id="credit-card" type="radio" name="card-type" value="credit">

									<div class="card-type-label">
										<span class="">信用卡</span>
									</div>
								</label>
							</li>

							<li>
								<label hidefocus="true" for="deposit-card">
									<input class="select-month" id="deposit-card" type="radio" name="card-type" value="deposit">

									<div class="card-type-label">
										<span class="">储蓄卡</span>
									</div>
								</label>
							</li>
						</ul>

						<ul id="easyBankList" class="bank-list clearfix bank-list-easy"></ul>
					</div>
					<div id="easybank-more" class="more" style="display:block;"><a href="javascript:;">更多银行</a></div>
				</div>

				<div id="bind-bank-list" class="bank-list-wrapper" style="display: {if $easyBinded}block{else}none{/if}">
					<span class="label">选择银行：</span>

					<ul id="bindBankList" class="bank-list clearfix content"></ul>
				</div>

				<div id="easy-plugin-wrapper">
					<div class="easy-plugin-tips">
						<span class="">正在使用百付宝快捷支付插件，您还可以 <a href="javascript:;" id="easy-plugin-reselect">重新选择支付时长>></a></span>
					</div>

					<!-- <div class="easy-plugin-summary">
						<span class="easy-plugin-summary-title">结算</span>
						<span class="">(订单 <span class="amount red">48.00</span>元)</span>
					</div> -->
					<iframe id="payment-easypay" frameborder="0"></iframe>
				</div>
			</div>

			<div id="bfbContent" class="bank-content ui-tab-content">
				<div class="bank-list-wrapper">
					<span class="label">百付宝：</span>

					<ul id="" class="bank-list clearfix content">
						<li data-banktype="bfb" data-banknum="bfb" class="bank">
							<a href="javascript:;"><span class="bank-logo bank-bfb"></span><span class="status"></span></a>
						</li>
					</ul>

					
				</div>
			</div>

			<div id="zfbContent" class="bank-content ui-tab-content">
				<div class="bank-list-wrapper">
					<span class="label">支付宝：</span>

					<ul id="" class="bank-list clearfix content">
						
						<li data-banktype="zfb" data-banknum="zfb" class="bank">
							<a href="javascript:;"><span class="bank-logo bank-zfb"></span><span class="status"></span></a>
						</li>
					</ul>
				</div>
			</div>

			{**<p class="c6 platform-tips">其他银行的用户请尝试使用支付平台完成付款</p>**}
		</div>
	</li>

	<li class="clearfix item">
		<span class="label">&nbsp;</span>
		<div id="payment-btns" class="content">
			{button
				disabled = true
				str = "去付款"
				href = ""
				style = "c-disabled"
				width = 120
				class = "payment-btn f18"
				family = true
			}

			<p class="terms-service"><input type="checkbox" checked name="" id=""> 同意并接受 <a href="/doc/agreement" target="_blank">《百度音乐付费会员服务条款》</a></p>
		</div>
	</li>

	<li class="clearfix item">
		<span class="label">&nbsp;</span>

		<div id="payment-btns content">
			
		</div>
	</li>
</ul>
</div>
{*{/block}*}
