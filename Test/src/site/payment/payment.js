$(function() {
	var $body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body'),

		$sum = $(".sum"),
		$upgradeMoney = $('#upgrade_money'),
		$paymentBtn = $(".payment-btn").button(),
		$selectOtherMonth = $("#otherMonths"),
		$agreement = $(".terms-service input"),
		$from = $(".payment-from"),

		$paymentSuccess = $(".payment-success"),
		$paymentFail = $(".payment-fail"),

		$paymentConfirmDialog = $(".payment-dialog-confirm"),
		$paymentBanklistDialog = $(".payment-dialog-banklist"),

		$endtime = $('#endtime'),
		$daysRemain = $('.paytime-total-day'),
		$easyMoreBank = $("#easybank-more"),
		$bindBankReselect = $("#bindbank-reselect"),
		$paymentCategoryTabs = $(".payment-from .payment-category-tab li"),
		$paymentTypeTabs = $("#payment_type"),
		$pageBanks = $(".payment-from .bank-list .bank"),
		$dialogBanks = $(".payment-dialog-banklist-inner .bank-list .bank"),

		months = 12,

		serviceName = "",
		money = 0,

		bankEasyType = {
			CREDIT: "credit",
			DEPOSIT: "deposit"
		},

		dataType = window.dataType,
		endTime = parseInt(window.endTime, 10),
		pagelog = "vip_payment",
		bankSelectStatus = false,

		bankType,
		bankNo,

		dialogBankType,
		dialogBankNo,

		fullAccount = true,
		inEasyPay = false,
		needCreateEasyPay = false,
		checkSumInterval,
		fr = window.pst || ((ting.traceSource.getFrom() == -1) ? "web" : ting.traceSource.getFrom()),

		tabIndex = 0,

		bankTpl = '<li class="bank #{active}" data-banktype="#{bankType}" data-banknum="#{bankNo}"><a href="javascript:;"><span class="bank-logo bank-#{bank}"></span><span class="status"></span></a></li>',

		bankBindTpl = '<li class="bank bank-with-account #{active}" data-banktype="#{bankType}" data-banknum="#{bankNo}"><a href="javascript:;"><span class="bank-logo bank-#{bank}"></span><span class="bank-split">|</span><span class="bank-card-number">尾号: #{cardNo}</span><span class="status"></span></a></li>',

		bankList = [{
			bankNo: "101",
			bankEasyCredit: "3001",
			bankEasyDeposit: "4002",
			bankName: "工商银行",
			bank: "gongshang"
		}, {
			bankNo: "201",
			bankEasyCredit: "3011",
			bankEasyDeposit: "4004",
			bankName: "招商银行",
			isIe: true,
			bank: "zhaoshang"
		}, {
			bankNo: "301",
			bankEasyCredit: "3002",
			bankEasyDeposit: "4003",
			bankName: "中国建设银行",
			isIe: true,
			bank: "jianshe"
		}, {
			bankNo: "401",
			bankEasyCredit: "3003",
			bankEasyDeposit: "4001",
			bankName: "中国农业银行",
			bank: "nongye"
		}, {
			bankNo: "701",
			bankEasyCredit: "3008",
			bankName: "中国光大银行",
			bank: "guangda"
		}, {
			bankNo: "601",
			bankEasyCredit: "3017",
			bankName: "浦发银行",
			isIe: true,
			bank: "pufa"
		}, {
			bankNo: "1101",
			bankEasyCredit: "3006",
			bankName: "交通银行",
			isIe: true,
			bank: "jiaotong"
		}, {
			bankNo: "1201",
			bankEasyCredit: "3004",
			bankEasyDeposit: "4009",
			bankName: "中国银行",
			bank: "zhongguo"
		}, {
			bankNo: "501",
			bankEasyCredit: "3007",
			bankName: "中信银行",
			bank: "zhongxin"
		}, {
			bankNo: "1902",
			bankEasyCredit: "3005",
			bankName: "中国邮政储蓄银行",
			bank: "youzheng"
		}, {
			bankNo: "1903",
			bankEasyCredit: "3010",
			bankName: "民生银行",
			isIe: true,
			bank: "mingsheng"
		}, {
			bankNo: "801",
			bankEasyCredit: "3019",
			bankName: "平安银行",
			isIe: true,
			bank: "pingan"
		}, {
			bankNo: "1909",
			bankEasyCredit: "3013",
			bankName: "北京银行",
			isIe: true,
			bank: "beijing"
		}, {
			bankNo: "1910",
			bankName: "北京农商银行",
			bank: "beijingnongshang"
		}, {
			bankNo: "1904",
			bankEasyCredit: "3009",
			bankName: "华夏银行",
			bank: "huaxia"
		}, {
			bankNo: "1905",
			bankEasyCredit: "3015",
			bankEasyDeposit: "4007",
			bankName: "兴业银行",
			isIe: true,
			bank: "xingye"
		}, {
			bankNo: "1906",
			bankName: "上海银行",
			bankEasyCredit: "3012",
			isIe: true,
			bank: "shanghai"
		}, {
			bankNo: "1907",
			bankEasyCredit: "3049",
			bankName: "上海农商银行",
			bank: "shanghainongshang"
		}, {
			bankNo: "1901",
			bankEasyCredit: "3018",
			bankName: "广发银行",
			isIe: true,
			bank: "guangfa"
		}, {
			bankEasyCredit: "3014",
			bankName: "东亚银行",
			isIe: true,
			bank: "bea"
		}, {
			bankEasyCredit: "3016",
			bankName: "宁波银行",
			isIe: true,
			bank: "ningbo"
		}, {
			bankEasyCredit: "3020",
			bankName: "包商银行",
			isIe: true,
			bank: "baoshang"
		}, {
			bankEasyCredit: "3021",
			bankName: "长沙银行",
			isIe: true,
			bank: "changsha"
		}, {
			bankEasyCredit: "3022",
			bankName: "承德银行",
			isIe: true,
			bank: "chengde"
		}, {
			bankEasyCredit: "3023",
			bankName: "成都农商银行",
			isIe: true,
			bank: "chengdunongshang"
		}, {
			bankEasyCredit: "3024",
			bankName: "重庆农村商业银行",
			isIe: true,
			bank: "chongqingnongchun"
		}

		// , {
		// 	bankEasyCredit: "3025",
		// 	bankName: "重庆银行",
		// 	isIe: true,
		// 	bank: "chongqing"
		// }, 
		// {
		// 	bankEasyCredit: "3026",
		// 	bankName: "大连银行",
		// 	isIe: true,
		// 	bank: "dalian"
		// }, {
		// 	bankEasyCredit: "3027",
		// 	bankName: "东营市商业银行",
		// 	isIe: true,
		// 	bank: "dongying"
		// }

		],

		getBankClassName = function(bankNo, easyBankType) {
			var bankEasyTypes = {
				credit: "bankEasyCredit",
				deposit: "bankEasyDeposit"
			}

			return _.find(bankList, function(item, index) {
				return item[bankEasyTypes[easyBankType]] + "" == bankNo + "";
			})
		},

		checkPayment = function() {
			var annualPack = {
				promo: 0,
				original: 0
			};

			switch (serviceLevel) {
				case "gold":
					if (currentServiceLevel == "comm") {
						dataType = "upgrade";
					} else if (currentServiceLevel == "gold") {
						dataType = "up";
					} else {
						dataType = "add";
					}

					annualPack.promo = 96;
					annualPack.original = 120;

					break;

				case "comm":
				default:
					if (currentServiceLevel == "comm") {
						dataType = "up";
					} else if (currentServiceLevel == "gold") {
						dataType = "up";
					} else {
						dataType = "up";
					}

					annualPack.promo = 48;
					annualPack.original = 60;

					break;
			}

			$(".paytime .paytime-item").hide();
			$(".paytime ." + dataType).show();

			$("#annual-pack .promo").text(annualPack.promo);
			$("#annual-pack .original").text(annualPack.original);

			checkSum();
		},

		/*更新有效期*/
		//endTime = parseInt(endTime, 10) || +(new Date()),

		showSum = function(result) {
			money = result.data.sum;
			serviceName = (serviceType == "down" ? result.data.goodinfo.down.name : result.data.goodinfo.cloud.name);

			$sum.html(money);
			if ($upgradeMoney.length) {
				$upgradeMoney.html(money);
			}
			
			updateEndTime(result.data.time, result.data.days_left);
		},

		/*获取当前form选择月份*/
		getMonth = function() {
			var selectRadio = $(".select-month:checked");

			months = selectRadio.data("months");
			return months;
		},

		updateEndTime = function(date, expire) {
			// var time = new Date(endTime);
			// time.setMonth(time.getMonth() + parseInt(months, 10));
			// $endtime.html(time.getFullYear() + '-' + (time.getMonth() + 1) + '-' + time.getDate());

			$endtime.text(date)

			//var diff = time.getTime() - (new Date()).getTime();

			$(".paytime-total-day").text(expire); 

			$(".months").text(date);
		},

		requestDataWithLogin = function (url, paramsGet, paramsPost, onSuccess, onFail, onCancel, isOperation, needBdName ,async) {
			ting.passport.checkLogin(
				function () {
					requestData(url, paramsGet, paramsPost, onSuccess, onFail, onCancel, isOperation, needBdName ,async);
				},
				function () {
	                /*
					var result = {};
					result.query = paramsGet;
					result.errorCode = -2;
					result.errorMessage = "登陆失败";
					onFail(result);
	                */
				},
				function () {
					var result = {};
					result.query = paramsGet;
					onCancel && onCancel(result);
				},
				function () {
					//转移到ting.passport.checkLogin中全局实现
					//$.ting.refreshTrigger.refresh($(".user-bar"),"/ajax/user_bar");
				},
	            {ref: "pop_web", operation: !!isOperation, needBdName: !!needBdName}
			);
		},

		/*异步调用金额*/
		checkSum = function(noPop) {
			var opt = {
					serveTime: getMonth(),
					serveType: serviceType,
					dataType: dataType,
					serveLevel: serviceLevel
				},

				url = "/data/service/sum",

				onSuccess = function(result) {
					showSum(result);

					if (!noPop) {
						if (months == 12) {
							$(".buy-tips").show();
						} else {
							$(".buy-tips").hide();
						}
					};

					if (result.errorCode == 22706) {
						fullAccount = false;

						setTimeout(function() {
							checkSum(true);
						}, 3000);

						if (!noPop) {
							ting.passport.popup("realizeUser");
						};

						return;
					}
				},

				onFail = function() {},

				onCancel = function() {},

				isOperation = false,

				needBdName = false,

				paramsGet = null,

				paramsPost = opt;

			if (noPop && !islogin) {
				return;
			};

			$.ajax({
				url: "/data/service/sum",
				cache: false,
				type: "post",
				dataType: "json",
				data: opt,
				success: function(result) {
					onSuccess(result);

					var errorCode = result.errorCode;

					if (errorCode == 22452 || errorCode == 22453) {
						//先重置全局用户信息
						if (errorCode == 22452) {
							ting.userInfo = null;
						} else if (errorCode == 22453) {
							if (ting.userInfo) {
								ting.userInfo.active = false;
							}
						}
						// 
						requestDataWithLogin(url, paramsGet, paramsPost, onSuccess, onFail, onCancel, isOperation, needBdName);
					} else {
						//返回的数据errorCode标识为成功时才认为是success，否则仍然是fail
						if (errorCode == 22000 || errorCode == 22706) {
							onSuccess(result);
						} else {
							result.errorMessage = ting.errorMap[errorCode];
							onFail(result);
						}
					}
				}
			})

			/*
			ting.connect.paymentSum(null, opt, function(result) {
				console.log(result);

				showSum(result);

				if (!noPop) {
					if (months == 12) {
						$(".buy-tips").show();
					} else {
						$(".buy-tips").hide();
					}
				};

				if (result.errorCode == 22706) {
					fullAccount = false;

					setTimeout(function() {
						checkSum(true);
					}, 3000);

					if (!noPop) {
						ting.passport.popup("realizeUser");
					};

					return;
				}

			}, function(result) {
				console.log(result);
			});
			*/

			//计算有效期
			//updateEndTime(opt.serveTime);

			if (tabIndex == 1 && inEasyPay) {
				createEasyPayPlugin();
			} else {
				needCreateEasyPay = true;
			}
		},

		bankSelected = function(callback, fnGetBankList, btn) {
			var btnBankType = btn.data("banktype"),
				btnBankNo = btn.data("banknum");

			fnGetBankList().removeClass("active");

			btn.addClass("active");

			//console.log("BANK_SELECTED", btnBankType, btnBankNo)

			callback(btnBankType, btnBankNo);

			updatePaymentBtnStatus();
		},

		pageBankSelected = _.partial(bankSelected, function(btnBankType, btnBankNo) {
			//console.log("pageBankSelected", btnBankType, btnBankNo)

			bankType = btnBankType;
			bankNo = btnBankNo;
		}, function() {
			return $(".payment-from .bank-list .bank");
		}),

		/*发起支付请求*/
		paymentEvent = function(pos) {
			if (islogin && needBindRealInfo) {
				ting.passport.popup("bindRealInfo");

				needBindRealInfo = false;

				return;
			};

			if (islogin) {
				if (!fullAccount) {
					ting.passport.popup("realizeUser");
				} else {
					$paymentConfirmDialog.dialog("show");
					window.open("/data/service/buy?dataType=" + dataType + "&serveLevel=" + serviceLevel + "&serveType=" + serviceType + "&serveTime=" + months + "&alertpay=" + bankType + "&bank_no=" + bankNo + "&fr=" + fr);
				}
			} else {
				ting.passport.checkLogin(function() {

					//登录成功回写状态
					//window.location.href = window.location.href;
					window.location.reload();
				}, function() {}, function() {}, function() {});
			}

			var opt = {
				page: pagelog,
				pos: !! pos ? pos : "pay"
			};

			ting.logger.log("click", opt);
			return false;
		},

		showResult = function(result) {
			var $months = $(".months"),
				$money = $(".money"),
				$serviceName = $(".service-name");

			$(".payment-inner").css("visibility", "hidden");
			$(".payment-result-wrapper").show();

			$money.html(money);

			$serviceName.html(serviceName);

			$(".payment-result").hide();

			if (result) {
				$paymentSuccess.show();
			} else {
				$paymentFail.show();
			}

			//$("body").scrollTop(0);

			topScrollTo = $(".music-main").offset().top;
			setTimeout(function() {
				$body.stop().animate({
					scrollTop: topScrollTo
				}, 200);
			}, 1000);
		},

		hideResult = function() {
			$(".payment-result-wrapper").hide();
			$(".payment-inner").show();
			$(".payment-inner").css("visibility", "visible");
		},

		// 检测支付状态
		checkPaymentStatus = function() {
			var resultLoading = $(".result-loading");
			resultLoading.css("height", $paymentSuccess.outerHeight()).show();

			ting.connect.paymentCheckStatus(null, null, function(result) {
				resultLoading.hide();
				showResult(result.pay_result);
			}, function(result) {
				resultLoading.hide();
				showResult(result.pay_result);
			});
		},

		/*更换支付按钮状态*/
		updatePaymentBtnStatus = function() {
			var agreementStatus = $agreement.attr("checked") ? true : false,
				tabSelectConfig = [
					["bank"],
					["easy_bank"],
					["bfb"],
					["zfb"]
				];

			bankSelectStatus = ($.inArray(bankType, tabSelectConfig[tabIndex]) != -1);

			if (bankSelectStatus && agreementStatus) {
				$paymentBtn.addClass("btn-f").removeClass("btn-c-disabled")
					.button("active");
			} else {
				$paymentBtn.removeClass("btn-f").addClass("btn-c-disabled")
					.button("disable");

			}
		},

		showEasyBankList = function() {
			$("#easy-bank-list").show();
			$("#bind-bank-list").hide();
		},

		showBindBankList = function() {
			$("#easy-bank-list").hide();
			$("#bind-bank-list").show();
		},

		renderBankList = function($targetDom, bankList, bankTpl, formatOptFn) {
			var bankhtml = [],
				eachBank = function(list) {
					var html = "",
						formatOpt;

					_.each(list, function(item, index) {
						formatOpt = formatOptFn(item);

						if (!formatOpt) {
							return "";
						};

						bankhtml.push($.format(bankTpl, formatOpt));
					});

					html = bankhtml.join("");

					return html;
				};

			$targetDom.html(eachBank(bankList)).removeClass("loading");

			selectDefaultBank();
		},

		createTraditionalBankList = function() {
			var $bankContent = $("#tradBankList"),
				bankhtml = [],
				chromeBankHtml = []
				ieBankHtml = [],

				tmpBankList = _.filter(bankList, function(item) {
					return item.bankNo
				}),

				eachBank = function() {
					var html = "",

						i = tmpBankList.length,
						ieBrowser = $.browser.msie,
						formatOpt,
						firstBank = false;

					if (ieBrowser) {
						_.each(tmpBankList, function(item, index) {
							formatOpt = {
								bank: item.bank,
								bankNo: item.bankNo,
								bankType: "bank"
							};

							bankhtml.push($.format(bankTpl, formatOpt));
						});
					} else {
						var chromeBankList = _.filter(tmpBankList, function(item) {
								return item.isIe;
							}),

							ieBankList = _.filter(tmpBankList, function(item) {
								return !item.isIe;
							});

						_.each(chromeBankList, function(item, index) {
							formatOpt = {
								bank: item.bank,
								bankNo: item.bankNo,
								bankType: "bank"
							};

							chromeBankHtml.push($.format(bankTpl, formatOpt));
						});

						_.each(ieBankList, function(item, index) {
							formatOpt = {
								bank: item.bank,
								bankNo: item.bankNo,
								bankType: "bank",
								active: ""
							};

							ieBankHtml.push($.format(bankTpl, formatOpt));
						});
					}

					if (ieBrowser) {
						html = bankhtml.join("");
					} else {
						html += chromeBankHtml.join("");
						html += '<li class="browser-tips">' + '<div class="module-line-bottom module-dotted"></div>' + '<p class="tips red">经检测，以下网银支付暂不支持您当前浏览器，建议您使用IE内核浏览器完成付款</p>' + '</li>';
						html += ieBankHtml.join("");
					}
					return html;
				},

				createBankHtml = function() {
					// var $listContent = $("<ul>").addClass("bank-list clearfix");

					// $bankContent.append($listContent)
					// 	.removeClass("loading");

					// $listContent.html(eachBank());
					// $(".payment-type .platform-tips").show();

					$bankContent.append(eachBank());
				};

			createBankHtml();
		},

		createEasyBankList = function(cardType) {
			var easyBankList = [],
				easyKey = "";

			if (cardType == bankEasyType.DEPOSIT) {
				easyBankList = _.filter(bankList, function(item) {
					return item.bankEasyDeposit;
				});

				easyKey = "bankEasyDeposit";
			} else {
				easyBankList = _.filter(bankList, function(item) {
					return item.bankEasyCredit;
				});

				easyKey = "bankEasyCredit";
			};

			renderBankList($("#easyBankList"), easyBankList.slice(0, 12), bankTpl, function(item) {
				return {
					bank: item.bank,
					bankNo: item[easyKey],
					bankType: "easy_bank"
				}
			});

			renderBankList($("#payment-dialog-banklist"), _.filter(bankList, function(item) {
					return item.bankEasyCredit;
				}), bankTpl, function(item) {
				return {
					bank: item.bank,
					bankNo: item["bankEasyCredit"],
					bankType: "easy_bank"
				}
			});
		},

		createSelectedBankList = function(selectedBankList) {
			renderBankList($("#bindBankList"), selectedBankList, bankBindTpl, function(item) {
				// item.bank_code = "4004";
				// item.card_type = "2"; 

				var bank = getBankClassName(item.bank_code, item.card_type == 1 ? "credit" : "deposit");

				if (bank) {
					return {
						bank: getBankClassName(item.bank_code, item.card_type == 1 ? "credit" : "deposit").bank,
						bankNo: item.bank_code,
						bankType: "easy_bank",
						cardNo: item.account_no ? item.account_no.substring(item.account_no.length - 4) : ""
					}
				} else {
					bankBindedList = null;

					return null;
				}
			});

			$("#bindBankList").append('<li id="bindbank-reselect" class="more"><a href="javascript:;">更换银行</a></li>');
		},

		createBindBankList = _.partial(createSelectedBankList, bankBindedList),

		createSelectedEasyBankList = function() {
			if (!dialogBankNo) {
				return;
			};

			showBindBankList();

			renderBankList($("#bindBankList"), _.filter(bankList, function(item) {
					return item.bankEasyCredit == dialogBankNo
				}), bankTpl, function(item) {
				return {
					bank: item.bank,
					bankNo: item["bankEasyCredit"],
					bankType: "easy_bank"
				}
			});

			bankType = dialogBankType;

			$("#bindBankList").append('<li id="bindbank-reselect" class="more"><a href="javascript:;">更换银行</a></li>');
		},

		createEasyPayPlugin = function() {
			var params = {
					"dataType": dataType,
					"serveLevel": serviceLevel,
					"serveType": serviceType,
					"serveTime": months,
					"alertpay": bankType,
					"bank_no": bankNo,
					"fr": fr
				},

				init = function(payInfo) {
					//console.log(payInfo);
					$("#payment-time").hide();

					payInfo.bankno = bankNo + "";
					payInfo.cardtype = ((bankNo + "").substring(0, 1) == "4") ? "2" : "1";

					inEasyPay = true;
					needCreateEasyPay = false;

					var page_url = payInfo.page_url;

					delete payInfo.page_url;

					if (tabIndex == 1 && inEasyPay) {
						$("#easyContent .bank-list-wrapper").hide();
						$("#payment-btns").hide();

						$("#easy-plugin-wrapper").show();
					};

					baifubaoEasyPay('payment-easypay', payInfo, {
						initFail: function(error_code) {
							// 接口调用出现异常 
							//console.log("initFail")
						},

						success: function() {
							// 支付成功 
							showResult(true)
							window.location.href = page_url;
						}
					});
				};

			ting.connect.paymentEasy(params, null, function(result) {
				init(result);
			}, function(result) {
				//console.log("fail connect");
				//console.log(result);
			});


			/*
			var payInfo = {
				//币种，默认人民币  
				"currency": "1",
				//商户自定义数据  
				"extra": "",
				// 商品的描述信息，可以使用商品的名称。  
				// 按照input_charset编码并使用 urlencode转义后的结果  
				"goods_desc": "this+is+%0D%0Ashangpin+%C2%E8%C2%E8%CB%B5%BA%DC%B3%A4%B5%C4%BA%BA%D7%D6%D2%B2%C4%DC%CF%D4%CA%BE%B3%F6%C0%B4+%0D%0A",
				//请求参数的字符编码，默认GBK  
				"input_charset": "1",
				//创建订单的时间 YYYYMMDDHHMMSS  
				"order_create_time": "20130531154457",
				//订单号，商户须保证订单号在商户系统内部唯一。  
				"order_no": "121001000210016127",
				//默认支付方式  
				"pay_type": "2",
				//商品在商户网站上的URL。  
				"goods_url": "http://jx-testing-eb18.jx.baidu.com:8666/success.html",
				//百付宝通知商户支付结果的URL，URL的host部分推荐使用IP  
				"return_url": "http://jx-testing-eb18.jx.baidu.com:8666/success.html",
				// 服务编号 目前必须为1  
				"service_code": "1",
				// 签名方式 MD5  
				"sign_method": "1",
				//百付宝商户号  
				"sp_no": "1210010002",
				//总金额，以分为单位  
				"total_amount": "1",
				//运费  
				"transport_amount": "0",
				//商品单价，以分为单位  
				"unit_amount": "1",
				//商品数量  
				"unit_count": "1",
				// 由签名规则生成的签名  
				"sign": "75b61d11d43d5edf80600851a921241c",
				// 卡类型信用卡  
				"cardtype": "1",
				// 银行id招商银行  
				"bankno": "3011"
			};
			*/
		},

		destroyEasyPayPlugin = function() {
			inEasyPay = false;

			$("#payment-time").show();

			resetEasyBankSection();

			$("#payment-btns").show();

			$("#easy-plugin-wrapper").hide();
		},

		resetEasyBankSection = function() {
			if (bankBindedList) {
				$("#easy-bank-list").hide();
				$("#bind-bank-list").show();
			} else {
				$("#easy-bank-list").show();
				$("#bind-bank-list").hide();
			}

			selectDefaultBank();
			
			//$("#easyContent .bank-list-wrapper").show();
		},

		baifubaoEasyPay = function(tarId, obj, events) {
			var apiURL = 'http://baifubao.baidu.com/jump?uri=';
			var str = [];
			var obj = obj || {};
			var events = events || {};
			for (var key in obj) {
				if (obj.hasOwnProperty(key)) {
					if (key !== 'goods_desc') {
						str.push(key + '=' + encodeURIComponent(obj[key]));
					}
				}
			}
			str = str.join('&');
			str += '&goods_desc=' + obj.goods_desc;
			var target = document.getElementById(tarId);
			target.src = apiURL + encodeURIComponent('/api/0/pay/0/iframedirect/0?' + str);

			events.resize = function(data) {
				target.height = data.height + 'px';
				target.style.height = data.height + 'px';
			}
			events.success = events.success || function(data) {
				if (obj.return_url) {
					location.href = obj.return_url;
				}
			}

			function handleReady() {
				typeof events['load'] == 'function' && events['load']();
			}
			if (target.attachEvent) {
				var IS_IE = true;
				target.attachEvent('onload', handleReady);
			} else {
				target.onload = handleReady;
			}

			if (window.postMessage) { // Modern browser
				window.onmessage = function(e) {
					e = e || window.event;
					if (e.origin != 'https://www.baifubao.com') {
						return;
					}
					var data = eval('(' + e.data + ')');

					if (typeof events[data.type] == 'function') {
						events[data.type](data.data);
					}
				};
			} else if (IS_IE) { // ie 6 7
				window.navigator.sendNotice = function(type, data) {
					if (typeof events[type] == 'function') {
						events[type](data);
					}
				};
			} else {
				alert('not support');
			}
		},

		selectDefaultBank = function() {
			//console.log("tabIndex", tabIndex)
			//$(".bank-content").eq(tabIndex).find(".bank-list .bank").eq(0).click();

			pageBankSelected($(".bank-content").eq(tabIndex).find(".bank-list .bank:visible").eq(0))
		};

	/*初始化金额*/
	checkPayment();

	/*单选框操作*/
	$(".select-month").bind("click", function() {
		var self = $(this);

		if (self[0].id == "other") {
			$selectOtherMonth.attr("disabled", false);
			$selectOtherMonth.addClass("active");
		} else {
			$selectOtherMonth.attr("disabled", true);
			$selectOtherMonth.removeClass("active");
		}
		months = getMonth();
		checkSum();
	});

	/*其他选择框操作*/
	$selectOtherMonth.bind("change", function() {
		months = $(this).val();
		$("#other").data("months", months);
		checkSum();
	});

	/*初始化dialog*/
	$paymentConfirmDialog.dialog({
		confirm: {
			btn: ".payment-success-btn",
			callback: function() {
				checkPaymentStatus();
				var opt = {
					page: "floatlayer",
					sub: pagelog,
					pos: "paid_succ"
				};
				ting.logger.log("click", opt);
			}
		},

		cancel: {
			btn: ".payment-fail-btn",
			callback: function() {
				checkPaymentStatus();
				var opt = {
					page: "floatlayer",
					sub: pagelog,
					pos: "paid_fail"
				};
				ting.logger.log("click", opt);
			}
		},

		bgiframe: true,

		close: {
			callback: function() {
				checkPaymentStatus();
			}
		},

		width: 385
	});

	$paymentBanklistDialog.dialog({
		confirm: {
			btn: ".payment-dialog-banklist-confirm",
			callback: function() {
				createSelectedEasyBankList();
			}
		},

		bgiframe: true,

		close: {
			callback: function() {
				
			}
		},

		width: 745
	});

	$("input:radio[name=buytime]").change(function() {
		switch ($(this).val()) {
			case "annual":
				$(".time-label").addClass("time-label-active");
				break;

			default:
				$(".time-label").removeClass("time-label-active");
				break;
		}
	});

	$("input:radio[name=card-type]").change(function() {
		switch ($(this).val()) {
			case "deposit":
				createEasyBankList(bankEasyType.DEPOSIT);
				$("#easybank-more").hide();
				break;

			default:
				createEasyBankList(bankEasyType.CREDIT);
				$("#easybank-more").show();
				break;
		}
	});



	/*协议勾选框*/
	$agreement.bind("click", function() {
		updatePaymentBtnStatus();
	});

	$easyMoreBank.bind("click", function() {
		$paymentBanklistDialog.dialog("show");

		$dialogBanks.live("click", function() {
			_.partial(bankSelected, function(btnBankType, btnBankNo) {
				dialogBankNo = btnBankNo;
				dialogBankType = btnBankType;
			}, function() {
				return $(".payment-dialog-banklist-inner .bank-list .bank");
			})($(this));
		});
	});

	$("#bindbank-reselect").live("click", function() {
		showEasyBankList();

		selectDefaultBank();
	});

	$paymentBtn.bind("button.click", function() {
		var pos = "pay_bank";

		if (bankType == "easy_bank") {
			createEasyPayPlugin();
			return;
		};

		if (bankType == "zfb") {
			pos = "pay_zfb"
		} else if (bankType == "bfb") {
			pos = "pay_bfb"
		}

		paymentEvent(pos);
	});

	$("#easy-plugin-reselect").bind("click", function() {
		destroyEasyPayPlugin();
	});

	$(".invite-buy").bind("click", function() {
		window.open("/vip/invite");
	});

	$(".continue-buy").bind("click", function() {
		var opt = {
			page: pagelog,
			pos: "continue_buy"
		};

		ting.logger.log("click", opt);

		window.location.reload();
	});

	/*重新支付*/
	$(".restart-payment").bind("click", function() {
		//hideResult();
		//paymentEvent("re_pay");

		window.location.reload();
	});

	createEasyBankList();
	createBindBankList();
	resetEasyBankSection();
	createTraditionalBankList();
	selectDefaultBank();


	// tab
	$paymentTypeTabs.tab({
		contentList: ".bank-content",

		callBackHideEvent: function(index) {
			_.each($(".bank-content"), function(item, i) {
				if (index == i) {
					$(item).show();
				} else {
					$(item).hide();
				}
			})

			var paymentBtns = $("#payment-btns"),
				paymentTypeList = $("#payment-type-list");

			tabIndex = index;

			selectDefaultBank();

			updatePaymentBtnStatus();


			if (index == 1) {
				$("#easybank-more").hide();
				$("#easybank-more").show();
			};

			if (index == 1 && inEasyPay) {
				paymentBtns.hide();
				//paymentTypeList.removeClass("payment-type-list").addClass("payment-type-list-expand");

				if (needCreateEasyPay) {
					createEasyPayPlugin();
				};
			} else {
				paymentBtns.show();
				//paymentTypeList.removeClass("payment-type-list-expand").addClass("payment-type-list");
			}

			$("#payment-time").show();
		}
	});

	$paymentTypeTabs.tab("triggerTab", 0);

	$pageBanks.live("click", function() {
		pageBankSelected($(this));
	});

	$paymentCategoryTabs.bind("click", function(e) {
		_.each($paymentCategoryTabs, function(item, index) {
			if (item == e.currentTarget) {
				$(item).addClass("active");
			} else {
				$(item).removeClass("active");
			}
		});

		serviceLevel = $(e.currentTarget).data("type");

		checkPayment();
	})

	$(".vip-title-icon, .power-icon-min, .view-vip").bind("click", function() {
		var opt = {
			pos: "priv_afford",
			page: pagelog
		};

		ting.logger.log("click", opt);
	});

	
});