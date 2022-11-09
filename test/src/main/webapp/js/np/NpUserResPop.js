
/* ## 옵션조회 ## */
/* ====================================================================================================================================================== */
var Option = {
		Common : {
			/* 현재 연동된 시스템이 ERPiU인지 확인 ( ERPiU 연동의 경우 true 반환 그 외 false 반환 ) */
			ERPiU : function() {
				if (Option.Common.GetErpType() === 'ERPiU') {
					return true;
				} else {
					return false;
				}
			},
			/* 현재 연동된 시스템이 iCUBE인지 확인 ( iCUBE 연동의 경우 true 반환 그 외 false 반환 ) */
			iCUBE : function() {
				if (Option.Common.GetErpType() === 'iCUBE') {
					return true;
				} else {
					return false;
				}
			},
			
			/* 현재 연동된 ERP 시스템 구분 반환 ( ERPiU : ERPiU / iCUBE : iCUBE / iCUBE G20 : iCUBE ) */
			GetErpType : function() {
				if (typeof optionSet !== 'undefined' && optionSet.conVo && optionSet.conVo.erpTypeCode) {
					return (optionSet.conVo.erpTypeCode || '').toString();
				} else {
					return '';
				}
			},
			GetResult : function(result, type) {
				/* [ parameter ] */
				/* - result : 반환받은 result */
				/* - type : 반환받고자 하는 key [ aData, aaData ] */

				if (typeof result !== 'undefined' && result) {
					if (typeof result.result !== 'undefined' && result.result) {
						if (typeof result.result[type] !== 'undefined' && result.result[type]) {
							/* [ return ] */
							return result.result[type];
						}
					}
				}

				/* [ return ] */
				return null;
			},
			GetResultCode : function(result) {
				/* [ parameter ] */
				/* - result : 반환받은 result */

				if (typeof result !== 'undefined' && result) {
					if (typeof result.result !== 'undefined' && result.result) {
						if (typeof result.result.resultCode !== 'undefined' && result.result.resultCode) {
							return result.result.resultCode;
						}
					}
				}

				return 'FAIL';
			},
			/* 로그인 사용자 ERP 조직도 정보 조회 */
			GetErpEmpInfo : function() {
				/* ERPiU : */
				/* iCUBE (G20) : */
				if (typeof optionSet !== 'undefined' && optionSet.erpEmpInfo) {
					return (optionSet.erpEmpInfo || {});
				} else {
					return {};
				}
			},
			/* 로그인 사용자 GW 조직도 정보 조회 */
			GetGwEmpInfo : function() {
				var resultValue = {
					groupSeq : '',
					userSe : '',
					langCode : '',
					compSeq : '',
					compName : '',
					divSeq : '',
					divName : '',
					deptSeq : '',
					deptName : '',
					empSeq : '',
					empName : ''
				};

				/* Bizbox Alpha : */
				if (typeof optionSet !== 'undefined' && optionSet.loginVo) {
					var loginVo = optionSet.loginVo;

					/* 기본 */
					resultValue.groupSeq = (loginVo.groupSeq || '');
					resultValue.userSe = (loginVo.userSe || '');
					resultValue.langCode = (loginVo.langCode || '');

					/* 회사 */
					resultValue.compSeq = (loginVo.compSeq || '');
					resultValue.compName = (loginVo.organNm || '');

					/* 사업장 */
					resultValue.divSeq = (loginVo.bizSeq || '');
					resultValue.divName = ('' || '');

					/* 부서 */
					resultValue.deptSeq = (loginVo.orgnztId || '');
					resultValue.deptName = (loginVo.orgnztNm || '');

					/* 사원 */
					resultValue.empSeq = (loginVo.uniqId || '');
					resultValue.empName = (loginVo.name || '');
				}

				/* [ return ] */
				return resultValue;
			},
			/* ERP 기수 정보 조회 */
			GetErpGisuInfo : function() {
				var resultValue = {
					erpGisu : '', /* 기수 */
					gisu : '', /* 기수 */
					erpYear : '', /* 기수 년도 */
					erpExpendYear : '', /* 기수 년도 */
					erpGisuFromDate : '', /* 기수 시작일자 */
					erpGisuToDate : '', /* 기수 종료일자 */
					erpGisuDate : '', /* 발의일자 */
					expendDate : '' /* 발의일자 */
				};

				/* Bizbox Alpha : */
				if (typeof optionSet !== 'undefined' && optionSet.erpGisu) {
					resultValue.erpGisu = (optionSet.erpGisu.gisu || '');
					resultValue.gisu = (optionSet.erpGisu.gisu || '');
					resultValue.erpYear = ((optionSet.erpGisu.fromDate || '').toString().length >= 4 ? optionSet.erpGisu.fromDate.substring(0, 4) : '');
					resultValue.erpExpendYear = ((optionSet.erpGisu.fromDate || '').toString().length >= 4 ? optionSet.erpGisu.fromDate.substring(0, 4) : '');
					resultValue.erpGisuFromDate = (optionSet.erpGisu.fromDate || '');
					resultValue.erpGisuToDate = (optionSet.erpGisu.toDate || '');

					/* 발의일자 - 현재 작성된 결의정보 기준 조회 */
					if ($('#resTbl').find('table').length > 0) {
						var resInfo = $('#resTbl').dzt('getValue');
						resultValue.erpGisuDate = (resInfo.resDate || '');
						resultValue.expendDate = (resInfo.resDate || '');
					} else {
						resultValue.erpGisuDate = '';
					}
				}

				/* [ return ] */
				return resultValue;
			},
			/* 팝업 크기 자동 조정 */
			SetResize : function() {
				/* ## init - 품의서 팝업 크기 자동 조정 ## */
				var optionHeight = optionSet.formInfo.formHeight || 0;
				var optionWidth = optionSet.formInfo.formWidth || 0;
				
				if (!optionHeight) {
					optionHeight = screen.height - 200;
				}
				if (!optionWidth) {
					optionWidth = screen.width - 400;
				}
				
				if(!parseInt(optionHeight)){
					optionHeight = 950;
				}
				if(!parseInt(optionWidth)){
					optionWidth = 1250;
				}
				if(optionHeight < 950){
					optionHeight = 950;
				}
				if(optionWidth < 1250){
					optionWidth = 1250;
				}
				
				$('.pop_wrap').css("overflow", "auto");
				var isFirefox = typeof InstallTrigger !== 'undefined';
				var isIE = false || !!document.documentMode;
				var isEdge = !isIE && !!window.StyleMedia;
				var isChrome = !!window.chrome && !!window.chrome.webstore;
				var divHeight = optionHeight;

				if (isFirefox) {
					divHeight -= 79;
				}
				if (isIE || isEdge) {
					divHeight -= 70;
				}
				if (isChrome) {
					divHeight -= 67;
				}

				try {
					$('.pop_wrap').height(divHeight);
					window.resizeTo(optionWidth, optionHeight);
				} catch (exception) {
					log('   [ERROR] fail to page resize.');
				}

				try {
					var moveLeft = (screen.width - optionWidth) / 2;
					var moveTop = (screen.height - optionHeight) / 2;
					window.moveTo(moveLeft, moveTop);
				} catch (exception) {
				}

				$(window).resize(function(e, d) {
					$('.pop_wrap').height(window.innerHeight - 2);
					Option.Common.SetTradeTblResize();
				});

				/* 리사이징 최초 1회 자동 수행 */
				$('.pop_wrap').height(window.innerHeight - 2);
			},
			/* 결제내역 테이블 크기 자동 조정 */
			SetTradeTblResize : function() {
				/* ## init - 결제내역 크기조정 ## */
				var btnHeight = Number($('.btn_div.mt0').css('height').replace('px', '')) * $('.btn_div.mt0').length;
				var spaceHeight = 40;
				var titleHeight = Number($('.pop_sign_head.posi_re').css('height').replace('px', ''));
				var tblHeight = (Number($('.cus_ta_ea.scbg.posi_re').css('height').replace('px', '')) * $('.cus_ta_ea.scbg.posi_re').length) - 135

				var calcHeight = btnHeight + spaceHeight + titleHeight + tblHeight;
				var windowCalcHeight = window.innerHeight - calcHeight;

				$('#tradeTbl_right_content_div').css('height', ((windowCalcHeight - 135) < 135 ? 135 : (windowCalcHeight - 135)) + 'px');
			},
			/* 테이블 생성을 위한 columns 기준으로 특정 값 배열 반환 */
			GetArray : function(obj, key, baseValue) {
				/* [ parameter ] */
				/* - obj : 테이블 생성 시 필요한 columns 정보 */
				/* - key : 배열로 변환할 JSON key */
				/* - baseValue : 값이 없는 경우 대체할 기본 값 */

				/* ex) Option.Common.GetArray(columns, 'title', ''); */
				obj = (obj || []);
				key = (key || '');
				baseValue = (baseValue || '');

				var attrArray = [];

				if (key !== '') {
					$.each(obj, function(idx, item) {
						attrArray.push((item[key] || baseValue));
					});
				}
				return attrArray;
			},
			/* 툴팁 표시 처리 */
			SetTooltip : function(target, column) {
				/* [ parameter ] */
				/* - target : 툴팁을 표시할 element 의 jquery object */
				/* - column : 툴팁 표시를 위한 구분 값 ( switch 사용 ) */

				var msgDef = {
					docuFgName : '${CL.ex_resDiv}을 선택하세요',
					resDate : '[F2] ${CL.ex_motionDate}를 입력하세요 (이동 : CTRL + 방향키)',
					resNote : '${CL.ex_res}내역을 입력하세요',
					btrNb : '[F2] ${CL.ex_ioAccountPop}',
					causeEmpName : '[F2] ${CL.ex_employeeSelectHelper}',
					statement : '[F2] ${CL.ex_itemDeatilInputPop}',
					erpBudgetName : '[F2] ${CL.ex_budgetUnit}도움창',
					erpBizplanName : '[F2] ${CL.ex_businessPlan}도움창',
					erpBgacctName : '[F2] ${CL.ex_budgetAccount}도움창',
					erpFiacctName : '[F2] ${CL.ex_accountingAcc}도움창',
					setFgName : '${CL.ex_paymentKind}을 선택하세요',
					vatFgName : '과세${CL.ex_division}을 선택하세요',
					trFgName : '${CL.ex_creditor}유형을 선택하세요',
					budgetNote : '${CL.ex_note}를 입력하세요',
					trName : '[F2] ${CL.ex_vendor}도움창',
					businessNb : '${CL.ex_businessNumber}를 입력하세요',
					ceoName : '${CL.ex_representNm}을 입력하세요',
					tradeAmt : '${CL.ex_amount}을 입력하세요',
					tradeStdAmt : '${CL.ex_purPrice}을 입력하세요',
					tradeVatAmt : '${CL.ex_vat}를 입력하세요',
					btrName : '[F2] ${CL.ex_finCompany}도움창',
					baNb : '${CL.ex_accountNum}를 입력하세요',
					depositor : '${CL.ex_accHolder}를 입력하세요',
					tradeNote : '${CL.ex_note2}를 입력하세요',
					regDate : '[F2] ${CL.ex_reportDate}을 입력하세요 (이동 : CTRL + 방향키)',
					erpMgtName : '[F2] ${CL.ex_project}(부서)도움창',
					erpDivName : '[F2] ${CL.ex_accountingUnit}도움창',
					ctrName : '[F2] ${CL.ex_cardVendorPop}',
					bottomName : '[F2] ${CL.ex_bottomBusiness}도움창'
				};

				var tooltipMsg = '';
				tooltipMsg = (msgDef[column] || '').toString();
				target.html(tooltipMsg);
			},
			GetSaveParam : function(param) {
				/* [ parameter ] */
				/* - param : 포맷 변경을 위한 파라미터 */

				/* 금액 포맷 변경 대상 */
				var amtFormatTarget = [ 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'amt', 'budgetAmt', 'erpOpenAmt', 'erpApplyAmt', 'erpLeftAmt', 'budgetStdAmt', 'budgetTaxAmt', 'openAmt', 'applyAmt', 'tryAmt', 'balanceAmt', 'gwBalanceAmt' ];
				/* 금액 포맷 변경 대상 - 포맷 변경 */
				/* 상배 : 저장 포멧 */
				$.each(amtFormatTarget, function(idx, key) {
					if (param[key]) {
						param[key] = param[key].toString().replace(/,/g, '');
					}
				});

				/* 날짜 포맷 변경 대상 */
				var dateFormatTarget = [ 'resDate', 'regDate', 'erpGisuDate', 'expendDate', 'causeDate', 'signDate', 'inspectDate' ];
				/* 날짜 포맷 변경 대상 - 포맷 변경 */
				$.each(dateFormatTarget, function(idx, key) {
					if (param[key]) {
						param[key] = param[key].toString().replace(/-/g, '');
					}
				})

				/* [ return ] */
				return param;
			},
			/* 금액 자동 계산 ( baseAmt, amtType[amt2std, amt2vat, amt2amt], mathType[ceil, floor, round] ) */
			GetCalcAmt : function(baseAmt, amtType, mathType) {
				/* [ parameter ] */
				/* - baseAmt : 기준 금액 */
				/* - amtType : 반환 금액 [amt2std, amt2vat, amt2amt] */
				/* - mathType : 소수점 처리 [ceil, floor, round] */

				var math = {
					/* Math.ceil() : 소수점 올림, 정수형 반환 */
					ceil : function(value) {
						return Math.ceil(value);
					},
					/* Math.floor() : 소수점 버림, 정수형 반환 */
					floor : function(value) {
						return Math.floor(value);
					},
					/* Math.round() : 소수점 반올림, 정수형 반환 */
					round : function(value) {
						return Math.round(value);
					}
				}

				/* 금액 계산 */
				switch (amtType) {
				case 'amt2amt':
					return math[mathType](baseAmt); /* amt2amt : 총금액 기준 부가세 없는 공급가액 구하기 */
				case 'amt2std':
					var vat = math[mathType](baseAmt / 11);
					return (baseAmt - vat); /* amt2std : 총금액 기준 부가세 있는 공급가액 구하기 */
				case 'amt2vat':
					return math[mathType](baseAmt / 11); /* amt2vat : 총금액 기준 부가세 구하기 */
				}
			},
			GetNumeric : function(value) {
				// value NaN 및 ${CL.ex_yes}외데이터 처리.
				if (!value) {
					value = 0;
				}

				var oldValue = [];
				oldValue = value.toString().split('.');
				oldValue[0] = oldValue[0].toString().split(',').join('');
				oldValue[1] = ((value.toString().indexOf('.') > -1) ? '.' + (oldValue[1] || '').toString() : '');

				var newValue = '';
				newValue += (oldValue[0] || '').replace(/\B(?=(\d{3})+(?!\d))/g, ",").toString();
				newValue += (oldValue[1] || '').toString();

				return newValue;
			},
			SetFocusAmtUpdate: function(){
				// 람다 식 IE에서 지원 하는지 ${CL.ex_check} 필요함.
				// var reducer = (accumulator, currentValue) => accumulator + currentValue;  
				
				/* 채주 총금액 - 합계 */
				var tradeSumAmt = $('#tradeTbl').dzt('getValueAll').map(function(item){
					return Number((item.tradeAmt || '0').toString().replace(/,/g, ''));
				});
				tradeSumAmt = (tradeSumAmt || []);
				tradeSumAmt = (tradeSumAmt.length > 0 ? tradeSumAmt : [0]);
				// tradeSumAmt = tradeSumAmt.reduce(reducer);
				var tradeSumAmtTemp = 0;
				for(var i = 0 ; i < tradeSumAmt.length; i++ ){
					tradeSumAmtTemp += tradeSumAmt[i];
				}
				tradeSumAmt = tradeSumAmtTemp;
				
				/* 채주 총금액 - 공급가액 합계 */
				var tradeSumStdAmt = $('#tradeTbl').dzt('getValueAll').map(function(item){
					return Number((item.tradeStdAmt || '0').toString().replace(/,/g, ''));
				});
				tradeSumStdAmt = (tradeSumStdAmt || []);
				tradeSumStdAmt = (tradeSumStdAmt.length > 0 ? tradeSumStdAmt : [0]);
				// tradeSumStdAmt = tradeSumStdAmt.reduce(reducer);
				var tradeSumStdAmtTemp = 0;
				for(var i = 0 ; i < tradeSumStdAmt.length; i++ ){
					tradeSumStdAmtTemp += tradeSumStdAmt[i];
				}
				tradeSumStdAmt = tradeSumStdAmtTemp;
				
				/* 채주 총금액 - 부가세 합계 */
				var tradeSumVatAmt = $('#tradeTbl').dzt('getValueAll').map(function(item){
					return Number((item.tradeVatAmt || '0').toString().replace(/,/g, ''));
				});
				tradeSumVatAmt = (tradeSumVatAmt || []);
				tradeSumVatAmt = (tradeSumVatAmt.length > 0 ? tradeSumVatAmt : [0]);
				// tradeSumVatAmt = tradeSumVatAmt.reduce(reducer);
				var tradeSumVatAmtTemp = 0;
				for(var i = 0 ; i < tradeSumVatAmt.length; i++ ){
					tradeSumVatAmtTemp += tradeSumVatAmt[i];
				}
				tradeSumVatAmt = tradeSumVatAmtTemp;
				
				
				/* 채주 총금액 - 예산내역 반영 */
				var budgetUID = $('#budgetTbl').dzt('getUID');
				if(budgetUID !== ''){
					$('#budgetTbl').dzt('setValue', budgetUID, {
						budgetAmt : Option.Common.GetNumeric(tradeSumAmt),
						budgetStdAmt : Option.Common.GetNumeric(tradeSumStdAmt),
						budgetTaxAmt : Option.Common.GetNumeric(tradeSumVatAmt)
					}, false);
				}
				
				/* 예산 총금액 - 합계 */
				var budgetSumAmt = $('#budgetTbl').dzt('getValueAll').map(function(item){
					return Number((item.budgetAmt || '0').toString().replace(/,/g, ''));
				});
				budgetSumAmt = (budgetSumAmt || []);
				budgetSumAmt = (budgetSumAmt.length > 0 ? budgetSumAmt : [0]);
				// budgetSumAmt = budgetSumAmt.reduce(reducer);
				var budgetSumAmtTemp = 0;
				for(var i = 0 ; i < budgetSumAmt.length; i++ ){
					budgetSumAmtTemp += budgetSumAmt[i];
				}
				budgetSumAmt = budgetSumAmtTemp;
				
				/* 예산 총금액 - 공급가액 합계 */
				var budgetSumStdAmt = $('#budgetTbl').dzt('getValueAll').map(function(item){
					return Number((item.budgetStdAmt || '0').toString().replace(/,/g, ''));
				});
				budgetSumStdAmt = (budgetSumStdAmt || []);
				budgetSumStdAmt = (budgetSumStdAmt.length > 0 ? budgetSumStdAmt : [0]);
				// budgetSumStdAmt = budgetSumStdAmt.reduce(reducer);
				var budgetSumStdAmtTemp = 0;
				for(var i = 0 ; i < budgetSumStdAmt.length; i++ ){
					budgetSumStdAmtTemp += budgetSumStdAmt[i];
				}
				budgetSumStdAmt = budgetSumStdAmtTemp;
				
				
				/* 예산 총금액 - 부가세 합계 */
				var budgetSumVatAmt = $('#budgetTbl').dzt('getValueAll').map(function(item){
					return Number((item.budgetTaxAmt || '0').toString().replace(/,/g, ''));
				});
				budgetSumVatAmt = (budgetSumVatAmt || []);
				budgetSumVatAmt = (budgetSumVatAmt.length > 0 ? budgetSumVatAmt : [0]);
				// budgetSumVatAmt = budgetSumVatAmt.reduce(reducer);
				
				var budgetSumVatAmtTemp = 0;
				for(var i = 0 ; i < budgetSumVatAmt.length; i++ ){
					budgetSumVatAmtTemp += budgetSumVatAmt[i];
				}
				budgetSumVatAmt = budgetSumVatAmtTemp;
				
				
				/* 예산 총금액 - 결의정보 반영 */
				var resUID = $('#resTbl').dzt('getUID');
				if(resUID !== ''){
					$('#resTbl').dzt('setValue', resUID, {
						amt : Option.Common.GetNumeric(budgetSumAmt)
					}, false);
				}
			},
			SetAmtUpdate : function(resSeq, budgetSeq, tradeSeq, tradeAmt, tradeStdAmt, tradeTaxAmt, type) {
				type = (type || '');
				amtInfo = (typeof amtInfo === 'undefined' ? {} : amtInfo);

				if (type === 'delete') {
					resSeq = (resSeq || 0);
					budgetSeq = (budgetSeq || 0);
					tradeSeq = (tradeSeq || 0);

					if (resSeq != 0 && budgetSeq != 0 && tradeSeq != 0) {
						amtInfo[resSeq][budgetSeq][tradeSeq] = {};
					} else if (resSeq != 0 && budgetSeq != 0) {
						if (!amtInfo[resSeq]) {
							amtInfo[resSeq] = {};
						}
						amtInfo[resSeq][budgetSeq] = {};
					} else if (resSeq != 0) {
						amtInfo[resSeq] = {};
					}

					resSeq = (resSeq || 0);
					budgetSeq = (budgetSeq || 0);
					tradeSeq = (tradeSeq || 0);
					tradeAmt = 0;
					tradeStdAmt = 0;
					tradeTaxAmt = 0;
				}

				if (type === 'delete' || (resSeq > 0 && budgetSeq > 0 && tradeSeq > 0)) {
					if (typeof amtInfo[resSeq] === 'undefined') {
						amtInfo[resSeq] = {};
					}
					if (typeof amtInfo[resSeq][budgetSeq] === 'undefined') {
						amtInfo[resSeq][budgetSeq] = {};
					}
					if (typeof amtInfo[resSeq][budgetSeq][tradeSeq] === 'undefined') {
						amtInfo[resSeq][budgetSeq][tradeSeq] = {};
					}

					amtInfo[resSeq][budgetSeq][tradeSeq]['tradeAmt'] = Number((tradeAmt || '0').toString().replace(/,/g, ''));
					amtInfo[resSeq][budgetSeq][tradeSeq]['tradeStdAmt'] = Number((tradeStdAmt || '0').toString().replace(/,/g, ''));
					amtInfo[resSeq][budgetSeq][tradeSeq]['tradeTaxAmt'] = Number((tradeTaxAmt || '0').toString().replace(/,/g, ''));

					var amt = 0;
					var budgetAmt = 0;
					var budgetStdAmt = 0;
					var budgetTaxAmt = 0;

					$.each(Object.keys(amtInfo), function(idx, res) {
						$.each(Object.keys(amtInfo[res]), function(resIdx, budget) {
							$.each(Object.keys(amtInfo[res][budget]), function(resIdx, trade) {
								if (res == resSeq) {

									if (amtInfo[res] && amtInfo[res][budget] && amtInfo[res][budget][trade] && amtInfo[res][budget][trade]['tradeAmt']) {
										amt += (amtInfo[res][budget][trade]['tradeAmt'] || 0);

										if (res == resSeq && budget == budgetSeq) {
											budgetAmt += (amtInfo[res][budget][trade]['tradeAmt'] || 0);
											budgetStdAmt += (amtInfo[res][budget][trade]['tradeStdAmt'] || 0);
											budgetTaxAmt += (amtInfo[res][budget][trade]['tradeTaxAmt'] || 0);
										}
									}
								}
							});
						});
					});

					var resUID = $('#resTbl').dzt('getUID');
					$('#resTbl').dzt('setValue', resUID, {
						amt : Option.Common.GetNumeric(amt)
					}, false);

					var budgetUID = $('#budgetTbl').dzt('getUID');
					$('#budgetTbl').dzt('setValue', budgetUID, {
						budgetAmt : Option.Common.GetNumeric(budgetAmt),
						budgetStdAmt : Option.Common.GetNumeric(budgetStdAmt),
						budgetTaxAmt : Option.Common.GetNumeric(budgetTaxAmt)
					}, false);
				}
			}
		},
		ERPiU : {
			/* 결의구분 ( 옵션 설정에 따라서 동작 ) */
			GetDocuFg : function() {
				var docuFgArray = [ {
					'docuFgCode' : '1',
					'docuFgName' : '${CL.ex_expendResDoc}'
				}, /* 지출결의서 */
				{
					'docuFgCode' : '2',
					'docuFgName' : '${CL.ex_executeConstructionWorkDoc}'
				}, /* 공사집행지출결의서 */
				{
					'docuFgCode' : '3',
					'docuFgName' : '${CL.ex_serviceResDoc}'
				}, /* 용역과지출결의서 */
				{
					'docuFgCode' : '4',
					'docuFgName' : '${CL.ex_buyResDoc}'
				}, /* 구입과지출결의서 */
				{
					'docuFgCode' : '5',
					'docuFgName' : '${CL.ex_incomeResDoc}'
				}, /* 수입결의서 - 예산통제 안 함( -결의서 ) */
				{
					'docuFgCode' : '6',
					'docuFgName' : '${CL.ex_remainIncomeResDoc}'
				}, /* 여입결의서 - 예산통제 안 함( -결의서 ) */
				{
					'docuFgCode' : '7',
					'docuFgName' : '${CL.ex_returnResDoc}'
				}, /* 반납결의서 - 예산통제 안 함( -결의서 ) */
				{
					'docuFgCode' : '8',
					'docuFgName' : '${CL.ex_remainBgtResDoc}'
				}, /* 여비지출결의서 */
				{
					'docuFgCode' : '9',
					'docuFgName' : '${CL.ex_payExpResDoc}'
				} /* 봉급지출결의서 */
				];

				return docuFgArray;
			},
			/* 결제수단 ( 옵션 설정에 따라서 동작 ) */
			GetFg : function() {
				var fgArray = [ {
					setFgCode : '1',
					setFgName : '${CL.ex_deposit}',
					tradeChange : 'N'
				}, {
					setFgCode : '2',
					setFgName : '${CL.ex_cash}',
					tradeChange : 'N'
				}, {
					setFgCode : '3',
					setFgName : '${CL.ex_afterCharge}',
					tradeChange : 'N'
				}, {
					setFgCode : '4',
					setFgName : '${CL.ex_creditCard}' , 
					tradeChange : 'N'
				} ];

				return fgArray;
			},
			/* 과세구분 ( 옵션 설정에 따라서 동작 ) */
			GetVatFg : function() {
				var vatFgArray = [ {
					'vatFgCode' : '1',
					'vatFgName' : '${CL.ex_tax}',
					tradeChange : 'N'
				}, {
					'vatFgCode' : '2',
					'vatFgName' : '${CL.ex_noTax}',
					tradeChange : 'N'
				}, {
					'vatFgCode' : '3',
					'vatFgName' : '${CL.ex_others}',
					tradeChange : 'N'
				} ];
				
				if(optionSet){
					if(optionSet.erp) {
						if(optionSet.erp.YN_JITAX) {
							if (optionSet.erp.YN_JITAX.CD_ENV == '0'){
								vatFgArray.push({
									'vatFgCode' : '4',
									'vatFgName' : '${CL.ex_notDeduct}',
									tradeChange : 'N'
								});
							}
						}
					}
				}

				return vatFgArray;
			},
			/* 채주유형 ( 옵션 설정에 따라서 동작 ) */
			GetTrFg : function(setFgCode, vatFgCode) {
				/* [ parameter ] */
				/* - setFgCode : 결제수단 코드 */
				setFgCode = (setFgCode || '');
				/* - vatFgCode : 과세구분 코드 */
				vatFgCode = (vatFgCode || '');

				var trFgArray = [];
				var trFgSource = [ {
					'trFgCode' : '1',
					'trFgName' : '${CL.ex_vendorSign}',
					tradeChange : 'N'
				}, {
					'trFgCode' : '2',
					'trFgName' : '${CL.ex_empResi}',
					tradeChange : 'N'
				}, {
					'trFgCode' : '3',
					'trFgName' : '${CL.ex_vendorNm}',
					tradeChange : 'N'
				}, {
					'trFgCode' : '4',
					'trFgName' : '${CL.ex_othersEarner}',
					tradeChange : 'N'
				},
				/* { 'trFgCode': '5', 'trFgName': '급여', tradeChange: 'N' }, */
				{
					'trFgCode' : '6',
					'trFgName' : '${CL.ex_businessIncomeEarner}',
					tradeChange : 'N'
				} ];

				if (setFgCode === '' && vatFgCode === '') {
					/* 전체 */
					trFgArray.push(trFgSource[0]);
					trFgArray.push(trFgSource[1]);
					trFgArray.push(trFgSource[2]);
					trFgArray.push(trFgSource[3]);
					trFgArray.push(trFgSource[4]);
				} else if (setFgCode !== '' && vatFgCode !== '') {
					if (vatFgCode === '1' || vatFgCode === '2') {
						/* 과세 || 면세 */
						trFgArray.push(trFgSource[0]);
					} else if (vatFgCode === '3') {
						/* 기타 */
						trFgArray.push(trFgSource[0]);
						trFgArray.push(trFgSource[1]);
						trFgArray.push(trFgSource[2]);
						trFgArray.push(trFgSource[3]);
						trFgArray.push(trFgSource[4]);
					} else if (vatFgCode === '4') {
						trFgArray.push(trFgSource[0]);
					}
				}

				return trFgArray;
			},
			/* 원인행위 정보 표시여부 - ERP 원인행위 상요여부에 따라 컬럼 정보 숨김 처리 */
			GetCauseStat : function() {
				if (optionSet) {
					if (optionSet.erp) {
						if (optionSet.erp.YN_CAUSE_USE) {
							if (optionSet.erp.YN_CAUSE_USE.CD_ENV) {
								return optionSet.erp.YN_CAUSE_USE.CD_ENV;
							}
						}
					}
				}
				return 'N';
			},
			/* 사업계획 표시여부 - ERP 사업계획 사용여부에 따라 컬럼 정보 숨김 처리 */
			GetBizplanStat : function() {
				try{
					return (!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0'))  ? 'N' : 'Y';
				}catch (ex){
					return 'Y';
				}
			},
			/* 물품명세 표시여부 - ERP 물품명세 사용여부에 따라 컬럼 정보 숨김 처리 */
			GetStatementStat : function() {
				return 'N';
			},
			/* 예산 정보 갱신 */
			GetBudgetAmtInfo : function(key) {
				/* 기본갑 정의 */
				key = (key || '');

				var resData = $('#resTbl').dzt('getValue');
				var budgetData = $('#budgetTbl').dzt('getValue');
				var budgetChkKey = [ 'erpBudgetName', 'erpBizplanName', 'erpBgacctName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'erpBgacctName' ];

				if (((budgetData.resSeq || '') !== '') && budgetChkKey.indexOf(key) > -1) {
					/* 필수 입력 확인 후 진행 ( 예산단위, ( + 사업계획 ), 예산계정 ) */
					fnSetBudgetDisplay(); /* 예산 정보 갱신 */
				} else {
					/* 조건이 만족되지 않으며, 입력된 정보가 없는 경우에는 금액을 오무 0원으로 초기화 한다. */
					if ((budgetData.erpBudgetName || '') === '' || (budgetData.erpBizplanName || '') === '' || (budgetData.erpBgacctName || '') === '') {
						/* 예산금액 초기화 */
						$('#lbErpOpenAmt').html('0');
						$('#lbResApplyAmt').html('0');
						$('#lbConsBalanceAmt').html('0');
						$('#lbBudgetAmt').html('0');
						$('#lbGwBalanceAmt').html('0');
					}
				}
			},
			/* 결제수단, 과세구분, 채주유형에 따른 결제내역 컬럼 정의 */
			GetTradeColumns : function() {
				/* 현재 수정중인 예산내역 정보 조회 */
				var budgetData = $('#budgetTbl').dzt('getValue');

				/* 결제수단, 과세구분, 채주유형 변수 정의 */
				var setFgCode = (budgetData.setFgCode || '1');
				var vatFgCode = (budgetData.vatFgCode || '1');
				var trFgCode = (budgetData.trFgCode || '1');

				/* columns 변수 정의 */
				var title = [];
				var column = [];
				var type = [];
				var display = [];
				var req = [];

				/* Setp1. - 결제수단에 따른 분리 */
				var tradeColumns = {
					"1" : {
						/* 예금 */
						/* Setp2. - 과세구분에 따른 분리 */
						"1" : {
							/* 과세 */
							/* Setp3. - 채주유형에 따른 분리 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['사원명', '대표자명', '지출총액', '실수령액', '원천징수액', '금융기관', '계좌번호', '예금주', '비고', '신고기준일']; */
								/* column = ['trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, NO, NO, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"6" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						},
						"4" : {
							/* 불공제 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_notDeductReason}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'noTaxName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						}
					},
					"2" : {
						/* 현금 */
						"1" : {
							/* 과세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}']; */
								/* column = ['trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, NO, NO, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"6" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						},
						"4" : {
							/* 불공제 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_notDeductReason}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'noTaxName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						}
					},
					"3" : {
						/* 외상 */
						"1" : {
							/* 과세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}']; */
								/* column = ['trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, NO, NO, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"6" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						},
						"4" : {
							/* 불공제 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_notDeductReason}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'noTaxName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						}
					},
					"4" : {
						/* 신용카드 */
						"1" : {
							/* 과세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, NO, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}']; */
								/* column = ['trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, NO, NO, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"6" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_representNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO, NO, NO ];
							}
						},
						"4" : {
							/* 불공제 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_notDeductReason}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_creditCard}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'noTaxName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'cardNum', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						}
					}
				}

				/* 컬럼 정의 */
				if (tradeColumns && tradeColumns[setFgCode] && tradeColumns[setFgCode][vatFgCode] && tradeColumns[setFgCode][vatFgCode][trFgCode]) {
					if (typeof tradeColumns[setFgCode][vatFgCode][trFgCode] === 'function') {
						tradeColumns[setFgCode][vatFgCode][trFgCode]();
					} else {
						console.error('not exists column def');
					}
				} else {
					console.error('not exists column def');
				}

				/* 정의 에러 찾기 */
				if (title.length !== column.length) {
					console.error('title.length !== column.length');
				}
				if (title.length !== type.length) {
					console.error('title.length !== type.length');
				}
				if (title.length !== display.length) {
					console.error('title.length !== display.length');
				}
				if (title.length !== req.length) {
					console.error('title.length !== req.length');
				}

				/* 기본값 추가 ( resDocSeq : 결의서 문서 시퀀스 / resSeq : 결의서 시퀀스 / budgetSeq : 예산 시퀀스 / tradeSeq : 채주 시퀀스 ) */
				var defaultKey = [ 'resDocSeq', 'resSeq', 'budgetSeq', 'tradeSeq', 'trSeq', 'btrSeq' ];
				$.each(defaultKey, function(idx, item) {
					title.push(item);
					column.push(item);
					type.push('readonly');
					display.push(NO);
					req.push(NO);
				});

				/* 결제내역 columns 생성 */
				var columns = [];
				$.each(title, function(idx, item) {
					var columnDef = {
						title : '',
						column : '',
						type : '',
						display : '',
						req : '',
						tooltip : function() {
							Option.Common.SetTooltip($('#tradeTooltip'), this.column);
						}
					};

					/* title 지정 */
					columnDef.title = (title[idx] || '');
					/* column 지정 */
					columnDef.column = (column[idx] || '');
					/* type 지정 */
					columnDef.type = (type[idx] || '');
					/* display 지정 */
					columnDef.display = (display[idx] || '');
					/* req 지정 */
					columnDef.req = (req[idx] || '');

					/* 기타 이벤트 정의 ( 코드 팝업, 기타 속성 ) */
					switch ((column[idx] || '')) {
					case 'tradeAmt':
						/* 금액 */
						columnDef.isNumeric = YES;
						break;
					case 'tradeStdAmt':
						/* 공급가액 */
						columnDef.isNumeric = YES;
						break;
					case 'tradeVatAmt':
						/* 부가세 */
						columnDef.isNumeric = YES;
						break;
					case 'trName':
						/* 거래처 */
						columnDef.keyEvent = [ 'F2', 'Enter' ];
						columnDef.methods = {
							keyEventF2 : function(keyName, searchStr) {
								keyName = (keyName || 'F2');
								searchStr = (searchStr || '');
								var resData = $('#resTbl').dzt('getValue');
								var budgetData = $('#budgetTbl').dzt('getValue');
								var tradeData = $('#tradeTbl').dzt('getValue');
								fnCommonCode('trName', keyName, searchStr, resData, tradeData);
								return false;
							},
							keyEventEnter : function() {
								var tradeData = $('#tradeTbl').dzt('getValue');
								if ((tradeData.trSeq || '') === '') {
									var keyName = 'Enter';
									var searchStr = $('#tradeTbl').dzt('getInputValue');
									this.keyEventF2(keyName, searchStr);
								} else {
									$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
								}
								return false;
							},
							keyEventBackspace : function() {
								return this.keyEventDelete();
							},
							keyEventDefault: function (keyName, searchStr) {
		                        return this.keyEventDelete();
		                    },
							keyEventDelete : function() {
								/* 현재 행 정보 조회 */
								var uid = $('#tradeTbl').dzt('getUID');
								/* 입력된 거래처 정보 삭제 ( 거래처코드, 금융기관코드, 사업자등록번호, 대표자명, 금융기관명, 계좌번호, 예금주 ) */
								$('#tradeTbl').dzt('setValue', uid, {
									trSeq : '',
									btrSeq : '',
									businessNb : '',
									ceoName : '',
									btrName : '',
									baNb : '',
									depositor : ''
								}, true);
							} 
						}
						break;
					case 'btrName':
						/* 금융기관 */
						columnDef.keyEvent = [ 'F2', 'Enter' ];
						columnDef.methods = {
							keyEventF2 : function(keyName, searchStr) {
								keyName = (keyName || 'F2');
								searchStr = (searchStr || '');
								var resData = $('#resTbl').dzt('getValue');
								var budgetData = $('#budgetTbl').dzt('getValue');
								var tradeData = $('#tradeTbl').dzt('getValue');
								fnCommonCode('btrName', keyName, searchStr, resData, tradeData);
								return false;
							},
							keyEventEnter : function() {
								var tradeData = $('#tradeTbl').dzt('getValue');
								if ((tradeData.btrSeq || '') === '') {
									var keyName = 'Enter';
									var searchStr = $('#tradeTbl').dzt('getInputValue');
									this.keyEventF2(keyName, searchStr);
								} else {
									$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
								}
								return false;
							},
							keyEventBackspace : function() {
								return this.keyEventDelete();
							},
							keyEventDefault: function (keyName, searchStr) {
		                        return this.keyEventDelete();
		                    },
							keyEventDelete : function() {
								/* 현재 행 정보 조회 */
								var uid = $('#tradeTbl').dzt('getUID');
								/* 입력된 거래처 정보 삭제 ( 금융기관, 금융기관 코드 ) */
								$('#tradeTbl').dzt('setValue', uid, {
									btrSeq : ''
								}, false);
							}
						}
						break;
					case 'cardNum':
						/* 신용카드 */
						columnDef.keyEvent = [ 'F2', 'Enter' ];
						columnDef.methods = {
							keyEventF2 : function(keyName, searchStr) {
								keyName = (keyName || 'F2');
								searchStr = (searchStr || '');
								var resData = $('#resTbl').dzt('getValue');
								var budgetData = $('#budgetTbl').dzt('getValue');
								var tradeData = $('#tradeTbl').dzt('getValue');
								fnCommonCode('cardNum', keyName, searchStr, resData, tradeData);
								return false;
							},
							keyEventEnter : function() {
								var tradeData = $('#tradeTbl').dzt('getValue');
								if ((tradeData.a || '') === '') {
									var keyName = 'Enter';
									var searchStr = $('#tradeTbl').dzt('getInputValue');
									this.keyEventF2(keyName, searchStr);
								} else {
									$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
								}
								return false;
							},
							keyEventBackspace : function() {
								return this.keyEventDelete();
							},
							keyEventDefault: function (keyName, searchStr) {
		                        return this.keyEventDelete();
		                    },
							keyEventDelete : function() {
								/* 현재 행 정보 조회 */
								var uid = $('#tradeTbl').dzt('getUID');
								/* 입력된 불공제 사유 코드 삭제 */
								$('#tradeTbl').dzt('setValue', uid, {
									noTaxCode : ''
								}, false);
							}
						}
						break;
					case 'noTaxName':
						/* 불공제 사유 */
						columnDef.keyEvent = [ 'F2', 'Enter' ];
						columnDef.methods = {
								keyEventF2 : function(keyName, searchStr) {
									keyName = (keyName || 'F2');
									searchStr = (searchStr || '');
									var resData = $('#resTbl').dzt('getValue');
									var budgetData = $('#budgetTbl').dzt('getValue');
									var tradeData = $('#tradeTbl').dzt('getValue');
									fnCommonCode('notax', keyName, searchStr, resData, tradeData);
									return false;
								},
								keyEventEnter : function() {
									var tradeData = $('#tradeTbl').dzt('getValue');
									if ((tradeData.a || '') === '') {
										var keyName = 'Enter';
										var searchStr = $('#tradeTbl').dzt('getInputValue');
										this.keyEventF2(keyName, searchStr);
									} else {
										$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
									}
									return false;
								}
							}
						break;
					case 'regDate':
						/* 신고기준일 - 마지막 입력 이벤트 */
						columnDef.lastCallback = function() {
							/* console.log(this.column + ' - lastCallback [ERPiU][tradeTbl]'); */

							/* 현재 행 정보 조회 */
							var tradeData = $('#tradeTbl').dzt('getValue');

							/* 필수값 입력 확인 */
							var reqChkTrade = fnTradeChkValue();

							console.log('tradeData.tradeNote' + tradeData.tradeNote);
							/* 저장될 데이터 사이즈 확인 */
							if (tradeData.tradeNote.length > 79) {
								alert('${CL.ex_note}는 80자 이내로 작성가능합니다.');
								return;
							}

							if (reqChkTrade.sts) {
								/* 데이터 저장여부 확인 */
								if (typeof tradeData.tradeSeq === 'undefined' || tradeData.tradeSeq === '') {
									fnTradeInsert();

									/* 정상처리여부 확인 */
									tradeData = $('#tradeTbl').dzt('getValue');
									if ((tradeData.insertStat || '') === 'SUCCESS') {
										$('#tradeTbl').dzt('setCommit', false); /* commit 처리 */
										$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

										var tradeDataArray = $('#tradeTbl').dzt('getValueAll');
										var tradeSaveCount = $('#tradeTbl').dzt('getValueAll').filter(function(item) {
											return ((item.tradeSeq || '') != '')
										}).length;

										if (tradeDataArray.length !== tradeSaveCount) {
											/* 마지막 행으로 이동 */
											$('#tradeTbl').dzt('setCommit', false);
											$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
											$('#tradeTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
										} else {
											/* 신규 행 추가 */
											$('#btnTradeAdd').click();
										}
									} else {
										$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), {
											insertStat : '',
											insertMsg : ''
										});
										$('#tradeTbl').dzt('setCommit', false);

										if ((tradeData.insertMsg || '') !== '') {
											alert(tradeData.insertMsg);
										}
									}
								}
							} else {
								/* 미입력 항목 포커스 지정 */
								var uid = $('#budgetTbl').dzt('getUID');
								$('#budgetTbl').dzt('setFocus', uid, reqChkTrade.key);

								/* 사용자 알림 처리 */
								alert(reqChkTrade.msg);
							}

							/* 포커스 지정이 존재하지 않는 경우에는 현재 포커스 유지처리 */
							if (($('#budgetTbl').find('.colOn').length + $('#tradeTbl').find('.colOn').length) === 0) {
								$('#resTbl').dzt('setFocus', $('#resTbl').dzt('getUID'), this.column);
							} else {
								if (($('#tradeTbl').dzt('getValueAll').tradeSeq || '0') !== '0') {
									$('#btnTradeAdd').click();
								} else {
									$('#btnTradeAdd').dzt('setDefaultFocus', 'LAST');
								}
							}

							return false;
						}
						break;
					}

					/* columnDef 추가 */
					columns.push(columnDef);
				});

				/* [ return ] */
				return columns;
			}
		},
		iCUBE : {
			/* 원인행위 정보 표시여부 - ERP 원인행위 상요여부에 따라 컬럼 정보 숨김 처리 */
			GetCauseStat : function() {
				if(optionSet){
					if(optionSet.erp){
						if(optionSet.erp['4']){
							if(optionSet.erp['4']['05']){
								if(optionSet.erp['4']['05']['USE_YN']){
									if(optionSet.erp['4']['05']['USE_YN'] === '1') {
										return 'Y';
									}
								}	
							}
						}	
					}
				}
				
				return 'N';
			},
			/* 명세서 표시여부 - ERP 물품명세 사용여부에 따라 컬럼 정보 숨김 처리 */
			GetStatementStat : function() {
				/* console.log('GetStatementStat - 서비스 준비중입니다.'); */
				return 'N';
			},
			GetDocuFg : function() {

				var docuFgArray = [ {
					'docuFgCode' : '1',
					'docuFgName' : '${CL.ex_expendResDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '2',
					'docuFgName' : '${CL.ex_executeConstructionWorkDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '3',
					'docuFgName' : '${CL.ex_serviceResDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '4',
					'docuFgName' : '${CL.ex_buyResDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '5',
					'docuFgName' : '${CL.ex_incomeResDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '6',
					'docuFgName' : '${CL.ex_remainIncomeResDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '7',
					'docuFgName' : '${CL.ex_returnResDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '8',
					'docuFgName' : '${CL.ex_remainBgtResDoc}',
					tradeChange : 'N'
				}, {
					'docuFgCode' : '9',
					'docuFgName' : '${CL.ex_payExpResDoc}',
					tradeChange : 'N'
				} ];
				return docuFgArray;
			},
			/* 결제수단 ( 옵션 설정에 따라서 동작 ) */
			GetFg : function() {
				var fgArray = [ {
					setFgCode : '1',
					setFgName : '${CL.ex_deposit}',
					tradeChange : 'N'
				}, {
					setFgCode : '2',
					setFgName : '${CL.ex_cash}',
					tradeChange : 'N'
				}, {
					setFgCode : '3',
					setFgName : '${CL.ex_afterCharge}',
					tradeChange : 'N'
				}, {
					setFgCode : '4',
					setFgName : '${CL.ex_creditCard}',
					tradeChange : 'N'
				} ];

				return fgArray;
			},
			/* 부가세 포함여부 
			 * return ['1' : '${CL.ex_vat} 포함', '0' : '${CL.ex_vat} 미포함']
			 * */
			GetIsVatControl : function () {
				//상배
				if(typeof optionSet == 'undefined'){
					console.log('! [ERROR] optionSet is not defined - GetIsVatControl');
					return 'ERROR';
				}else if (!optionSet.conVo){
					console.log('! [ERROR] connectionVo is not defined - GetIsVatControl');
					return 'ERROR';
				}else if(!optionSet.conVo.erpTypeCode){
					console.log('! [ERROR] erpTypeCode is not defined - GetIsVatControl');
					return 'ERROR';
				}

				if(optionSet.conVo.erpTypeCode == 'ERPiU'){
					if( optionSet.erp["YN_JITAX"].CD_ENV == 'Y' ){
						return '1'
					}else {
						if(budgetData.vatFgCode == 4){
							return '1'
						}
						return '0'
					}
				}else if(optionSet.conVo.erpTypeCode == 'iCUBE'){
					if (optionSet.erpEmpInfo.vatControl){
						return '1'
					}else {
						return '0'
					}
				}
			} , 
			/* 과세구분 ( 옵션 설정에 따라서 동작 ) */
			GetVatFg : function() {
				var vatFgArray = [ {
					'vatFgCode' : '1',
					'vatFgName' : '${CL.ex_tax}',
					tradeChange : 'N'
				}, {
					'vatFgCode' : '2',
					'vatFgName' : '${CL.ex_noTax}',
					tradeChange : 'N'
				}, {
					'vatFgCode' : '3',
					'vatFgName' : '${CL.ex_others}',
					tradeChange : 'N'
				} ];

				return vatFgArray;
			},
			/* 채주유형 ( 옵션 설정에 따라서 동작 ) */
			GetTrFg : function(setFgCode, vatFgCode) {
				/* [ parameter ] */
				/* - setFgCode : 결제수단 코드 */
				setFgCode = (setFgCode || '');
				/* - vatFgCode : 과세구분 코드 */
				vatFgCode = (vatFgCode || '');

				var trFgArray = [];

				if (vatFgCode === '3') {
					trFgArray = [ {
						'trFgCode' : '1',
						'trFgName' : '${CL.ex_vendorSign}',
						tradeChange : 'N'
					}, {
						'trFgCode' : '2',
						'trFgName' : '${CL.ex_empResi}',
						tradeChange : 'N'
					}, {
						'trFgCode' : '3',
						'trFgName' : '${CL.ex_vendorNm}',
						tradeChange : 'N'
					}, {
						'trFgCode' : '4',
						'trFgName' : '${CL.ex_othersEarner}',
						tradeChange : 'N'
					},
					/* { 'trFgCode': '5', 'trFgName': '기금', tradeChange: 'N' }, */
					{
						'trFgCode' : '6',
						'trFgName' : '운영비',
						tradeChange : 'N'
					},
					/* { 'trFgCode': '7', 'trFgName': '결연자', tradeChange: 'N' }, */
					/* { 'trFgCode': '8', 'trFgName': '급여', tradeChange: 'N' }, */
					{
						'trFgCode' : '9',
						'trFgName' : '${CL.ex_businessIncomeEarner}',
						tradeChange : 'N'
					} ];
				} else {
					trFgArray = [ {
						'trFgCode' : '1',
						'trFgName' : '${CL.ex_vendorSign}',
						tradeChange : 'N'
					} ];
				}

				return trFgArray;
			},
			/* 하위사업 사용 여부 ( USE_YN ) */
			GetBottomUseYN : function() {
				if (optionSet && optionSet.erp && optionSet.erp['4'] && optionSet.erp['4']['14'] && optionSet.erp['4']['14']['USE_YN']) {
					return (optionSet.erp['4']['14']['USE_YN'].toString() === '1' ? 'Y' : 'N')
				} else {
					return 'N';
				}
			},
			/* 예산 정보 갱신 */
			GetBudgetAmtInfo : function(key) {
				/* 기본갑 정의 */
				key = (key || '');

				var resData = $('#resTbl').dzt('getValue');
				var budgetData = $('#budgetTbl').dzt('getValue');
				var budgetChkKey = [ 'erpMgtName', 'erpBudgetName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'erpBgacctName' ];

				if (((budgetData.resSeq || '') !== '') && budgetChkKey.indexOf(key) > -1) {
					/* 필수 입력 확인 후 진행 ( 프로젝트, ( + 하위사업 ), 예산과목 ) */
					if ((resData.erpMgtSeq || '') !== '' && (Option.iCUBE.GetBottomUseYN() === 'Y' ? (budgetData.bottomSeq || '') : Option.iCUBE.GetBottomUseYN()) !== '' && (budgetData.erpBudgetSeq || '') !== '') {
						fnSetBudgetDisplay(); /* 예산 정보 갱신 */
					}
				} else {
					/* 조건이 만족되지 않으며, 입력된 정보가 없는 경우에는 금액을 모두 0원으로 초기화 한다. */
					if ((resData.erpMgtSeq || '') === '' || (Option.iCUBE.GetBottomUseYN() === 'Y' ? (budgetData.bottomSeq || '') : Option.iCUBE.GetBottomUseYN()) === '' || (budgetData.erpBudgetSeq || '') === '') {
						/* 예산금액 초기화 */
						$('#lbErpOpenAmt').html('0');
						$('#lbResApplyAmt').html('0');
						$('#lbConsBalanceAmt').html('0');
						$('#lbBudgetAmt').html('0');
						$('#lbGwBalanceAmt').html('0');
					}
				}
			},
			/* 결제수단, 과세구분, 채주유형에 따른 결제내역 컬럼 정의 */
			GetTradeColumns : function() {
				/* 현재 수정중인 예산내역 정보 조회 */
				var budgetData = $('#budgetTbl').dzt('getValue');

				/* 결제수단, 과세구분, 채주유형 변수 정의 */
				var setFgCode = (budgetData.setFgCode || '1');
				var vatFgCode = (budgetData.vatFgCode || '1');
				var trFgCode = (budgetData.trFgCode || '1');

				/* columns 변수 정의 */
				var title = [];
				var column = [];
				var type = [];
				var display = [];
				var req = [];

				/* Setp1. - 결제수단에 따른 분리 */
				var tradeColumns = {
					"1" : {
						/* 예금 */
						/* Setp2. - 과세구분에 따른 분리 */
						"1" : {
							/* 과세 */
							/* Setp3. - 채주유형에 따른 분리 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'readonly', 'readonly', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 기금 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"6" : function() {
								/* 운영비 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"7" : function() {
								/* 결연자 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"8" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['${CL.ex_employeeNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}']; */
								/* column = ['trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, YES, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"9" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						}
					},
					"2" : {
						/* 현금 */
						"1" : {
							/* 과세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 기금 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"6" : function() {
								/* 운영비 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"7" : function() {
								/* 결연자 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"8" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['${CL.ex_employeeNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}']; */
								/* column = ['trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, YES, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"9" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						}
					},
					"3" : {
						/* 외상 */
						"1" : {
							/* 과세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 기금 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"6" : function() {
								/* 운영비 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"7" : function() {
								/* 결연자 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO ];
							},
							"8" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['${CL.ex_employeeNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}']; */
								/* column = ['trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, YES, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"9" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, YES, NO, NO, NO, NO, NO ];
							}
						}
					},
					"4" : {
						/* 신용카드 */
						"1" : {
							/* 과세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						},
						"2" : {
							/* 면세 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_businessNumber}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'businessNb', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, NO, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						},
						"3" : {
							/* 기타 */
							"1" : function() {
								/* 거래처등록 */
								title = [ '${CL.ex_vendor}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO, NO ];
							},
							"2" : function() {
								/* 사원등록 */
								title = [ '${CL.ex_employeeNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"3" : function() {
								/* 거래처명 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"4" : function() {
								/* 기타소득자 */
								title = [ '${CL.ex_othersEarner}'
								, '${CL.ex_giveTotalPay}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, NO, NO, NO, NO, NO, NO, NO ];
							},
							"5" : function() {
								/* 기금 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"6" : function() {
								/* 운영비 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, NO, NO, NO, NO, NO, NO, NO, NO ];
							},
							"7" : function() {
								/* 결연자 */
								title = [ '${CL.ex_vendorNm}'
								, '${CL.ex_representNm}'
								, '${CL.ex_amount}'
								, '${CL.ex_purPrice}'
								, '${CL.ex_vat}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'ceoName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, NO, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							},
							"8" : function() {
								/* 급여 */
								/* 급여의 경우 사용자 급여 노출 문제로 인하여 개발하지 않음 */
								/* title = ['${CL.ex_employeeNm}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}']; */
								/* column = ['trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'tradeNote', 'regDate']; */
								/* type = ['text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker']; */
								/* display = [YES, YES, YES, YES, YES, YES, YES, YES, YES]; */
								/* req = [YES, YES, YES, NO, NO, NO, NO, NO, NO]; */
							},
							"9" : function() {
								/* 사업소득자 */
								title = [ '${CL.ex_businessIncomeEarner}'
								, '${CL.ex_expendTotalAmt}'
								, '${CL.ex_realPay}'
								, '${CL.ex_sourceCollectPay}'
								, '${CL.ex_finCompany}'
								, '${CL.ex_accountNum}'
								, '${CL.ex_accHolder}'
								, '${CL.ex_cardVendor}'
								, '${CL.ex_note2}'
								, '${CL.ex_reportDate}' ];
								column = [ 'trName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'btrName', 'baNb', 'depositor', 'ctrName', 'tradeNote', 'regDate' ];
								type = [ 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'text', 'datepicker' ];
								display = [ YES, YES, YES, YES, YES, YES, YES, YES, YES, YES ];
								req = [ YES, YES, YES, YES, NO, NO, NO, NO, NO, NO ];
							}
						}
					}
				}

				/* 컬럼 정의 */
				if (tradeColumns && tradeColumns[setFgCode] && tradeColumns[setFgCode][vatFgCode] && tradeColumns[setFgCode][vatFgCode][trFgCode]) {
					if (typeof tradeColumns[setFgCode][vatFgCode][trFgCode] === 'function') {
						tradeColumns[setFgCode][vatFgCode][trFgCode]();
					} else {
						console.error('not exists column def');
					}
				} else {
					console.error('not exists column def');
				}

				/* 정의 에러 찾기 */
				if (title.length !== column.length) {
					console.error('title.length !== column.length');
				}
				if (title.length !== type.length) {
					console.error('title.length !== type.length');
				}
				if (title.length !== display.length) {
					console.error('title.length !== display.length');
				}
				if (title.length !== req.length) {
					console.error('title.length !== req.length');
				}

				/* 기본값 추가 ( resDocSeq : 결의서 문서 시퀀스 / resSeq : 결의서 시퀀스 / budgetSeq : 예산 시퀀스 / tradeSeq : 채주 시퀀스 ) */
				var defaultKey = [ 'resDocSeq', 'resSeq', 'budgetSeq', 'tradeSeq', 'trSeq', 'btrSeq' ];
				$.each(defaultKey, function(idx, item) {
					title.push(item);
					column.push(item);
					type.push('readonly');
					display.push(NO);
					req.push(NO);
				});

				/* 결제내역 columns 생성 */
				var columns = [];
				$.each(title, function(idx, item) {
					var columnDef = {
						title : '',
						column : '',
						type : '',
						display : '',
						req : '',
						tooltip : function() {
							Option.Common.SetTooltip($('#tradeTooltip'), this.column);
						}
					};

					/* title 지정 */
					columnDef.title = (title[idx] || '');
					/* column 지정 */
					columnDef.column = (column[idx] || '');
					/* type 지정 */
					columnDef.type = (type[idx] || '');
					/* display 지정 */
					columnDef.display = (display[idx] || '');
					/* req 지정 */
					columnDef.req = (req[idx] || '');

					/* 기타 이벤트 정의 ( 코드 팝업, 기타 속성 ) */
					switch ((column[idx] || '')) {
					case 'tradeAmt':
						/* 금액 */
						columnDef.isNumeric = YES;
						break;
					case 'tradeStdAmt':
						/* 공급가액 */
						columnDef.isNumeric = YES;
						break;
					case 'tradeVatAmt':
						/* 부가세 */
						columnDef.isNumeric = YES;
						break;
					case 'trName':
						/* 거래처 */
						columnDef.keyEvent = [ 'F2', 'Enter' ];
						columnDef.methods = {
							keyEventF2 : function(keyName, searchStr) {
								keyName = (keyName || 'F2');
								searchStr = (searchStr || '');
								var resData = $('#resTbl').dzt('getValue');
								var budgetData = $('#budgetTbl').dzt('getValue');
								var tradeData = $('#tradeTbl').dzt('getValue');
								fnCommonCode('trName', keyName, searchStr, resData, tradeData);
								return false;
							},
							keyEventEnter : function() {
								var tradeData = $('#tradeTbl').dzt('getValue');
								if ((tradeData.trSeq || '') === '') {
									var keyName = 'Enter';
									var searchStr = $('#tradeTbl').dzt('getInputValue');
									this.keyEventF2(keyName, searchStr);
								} else {
									$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
								}
								return false;
							},
							keyEventBackspace : function() {
								return this.keyEventDelete();
							},
							keyEventDefault: function (keyName, searchStr) {
		                        return this.keyEventDelete();
		                    },
							keyEventDelete : function() {
								/* 현재 행 정보 조회 */
								var uid = $('#tradeTbl').dzt('getUID');
								/* 입력된 거래처 정보 삭제 ( 거래처코드, 금융기관코드, 사업자등록번호, 대표자명, 금융기관명, 계좌번호, 예금주 ) */
								$('#tradeTbl').dzt('setValue', uid, {
									trSeq : '',
									btrSeq : '',
									businessNb : '',
									ceoName : '',
									btrName : '',
									baNb : '',
									depositor : ''
								}, false);
							}
						}
						break;
					case 'btrName':
						/* 금융기관 */
						columnDef.keyEvent = [ 'F2', 'Enter' ];
						columnDef.methods = {
							keyEventF2 : function(keyName, searchStr) {
								keyName = (keyName || 'F2');
								searchStr = (searchStr || '');
								var resData = $('#resTbl').dzt('getValue');
								var budgetData = $('#budgetTbl').dzt('getValue');
								var tradeData = $('#tradeTbl').dzt('getValue');
								fnCommonCode('btrName', keyName, searchStr, resData, tradeData);
								return false;
							},
							keyEventEnter : function() {
								var tradeData = $('#tradeTbl').dzt('getValue');
								if ((tradeData.btrSeq || '') === '') {
									var keyName = 'Enter';
									var searchStr = $('#tradeTbl').dzt('getInputValue');
									this.keyEventF2(keyName, searchStr);
								} else {
									$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
								}
								return false;
							},
							keyEventBackspace : function() {
								return this.keyEventDelete();
							},
							keyEventDefault: function (keyName, searchStr) {
		                        return this.keyEventDelete();
		                    },
							keyEventDelete : function() {
								/* 현재 행 정보 조회 */
								var uid = $('#tradeTbl').dzt('getUID');
								/* 입력된 거래처 정보 삭제 ( 금융기관, 금융기관 코드 ) */
								$('#tradeTbl').dzt('setValue', uid, {
									btrSeq : ''
								}, false);
							}
						}
						break;
					case 'ctrName':
						/* 신용카드 */
						columnDef.keyEvent = [ 'F2', 'Enter' ];
						columnDef.methods = {
							keyEventF2 : function(keyName, searchStr) {
								keyName = (keyName || 'F2');
								searchStr = (searchStr || '');
								var resData = $('#resTbl').dzt('getValue');
								var budgetData = $('#budgetTbl').dzt('getValue');
								var tradeData = $('#tradeTbl').dzt('getValue');
								fnCommonCode('card', keyName, searchStr, resData, tradeData);
								return false;
							},
							keyEventEnter : function() {
								var tradeData = $('#tradeTbl').dzt('getValue');
								if ((tradeData.a || '') === '') {
									var keyName = 'Enter';
									var searchStr = $('#tradeTbl').dzt('getInputValue');
									this.keyEventF2(keyName, searchStr);
								} else {
									$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
								}
								return false;
							}
						}
						break;
					case 'regDate':
						/* 신고기준일 - 마지막 입력 이벤트 */
						columnDef.lastCallback = function() {
							/* console.log(this.column + ' - lastCallback [ERPiU][tradeTbl]'); */

							/* 현재 행 정보 조회 */
							var tradeData = $('#tradeTbl').dzt('getValue');

							/* 필수값 입력 확인 */
							var reqChkTrade = fnTradeChkValue();

							console.log('tradeData.tradeNote' + tradeData.tradeNote);
							/* 저장될 데이터 사이즈 확인 */
							if (tradeData.tradeNote.length > 79) {
								alert('${CL.ex_note}는 80자 이내로 작성가능합니다.');
								return;
							}

							if (reqChkTrade.sts) {
								/* 데이터 저장여부 확인 */
								if (typeof tradeData.tradeSeq === 'undefined' || tradeData.tradeSeq === '') {
									fnTradeInsert();

									/* 정상처리여부 확인 */
									tradeData = $('#tradeTbl').dzt('getValue');
									if ((tradeData.insertStat || '') === 'SUCCESS') {
										$('#tradeTbl').dzt('setCommit', false); /* commit 처리 */
										$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

										var tradeDataArray = $('#tradeTbl').dzt('getValueAll');
										var tradeSaveCount = $('#tradeTbl').dzt('getValueAll').filter(function(item) {
											return ((item.tradeSeq || '') != '')
										}).length;

										if (tradeDataArray.length !== tradeSaveCount) {
											/* 마지막 행으로 이동 */
											$('#tradeTbl').dzt('setCommit', false);
											$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
											$('#tradeTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
										} else {
											/* 신규 행 추가 */
											$('#btnTradeAdd').click();
										}
									} else {
										$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), {
											insertStat : '',
											insertMsg : ''
										});
										$('#tradeTbl').dzt('setCommit', false);

										if ((tradeData.insertMsg || '') !== '') {
											alert(tradeData.insertMsg);
										}
									}
								}
							} else {
								/* 미입력 항목 포커스 지정 */
								var uid = $('#budgetTbl').dzt('getUID');
								$('#budgetTbl').dzt('setFocus', uid, reqChkTrade.key);

								/* 사용자 알림 처리 */
								alert(reqChkTrade.msg);
							}

							/* 포커스 지정이 존재하지 않는 경우에는 현재 포커스 유지처리 */
							if (($('#budgetTbl').find('.colOn').length + $('#tradeTbl').find('.colOn').length) === 0) {
								$('#resTbl').dzt('setFocus', $('#resTbl').dzt('getUID'), this.column);
							} else {
								if (($('#tradeTbl').dzt('getValueAll').tradeSeq || '0') !== '0') {
									$('#btnTradeAdd').click();
								} else {
									$('#btnTradeAdd').dzt('setDefaultFocus', 'LAST');
								}
							}

							return false;
						}
						break;
					}

					/* columnDef 추가 */
					columns.push(columnDef);
				});

				/* [ return ] */
				return columns;
			}
		}
};

