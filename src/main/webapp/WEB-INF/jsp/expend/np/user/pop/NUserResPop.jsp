

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="currentTime" class="java.util.Date" />
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/dzt-1.0.0.js'></script>
<script type="text/javascript" src= '${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>
<link rel="stylesheet" type="text/css" href= '${pageContext.request.contextPath}/css/pudd.css' />




<jsp:include page="../include/UserOptionMap.jsp" flush="false" />
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />
<jsp:include page="../include/NpUserResPop.jsp" flush="false" />

<!-- [+] 커스터마이징 옵션 페이지 적용 [+] -->
	<c:if test="${not empty EXNP_CUST_001}">
	<!--
		## [CUST_001] 회계단위 - 사업계획 연동
		기능 : 사업계획 선택시 회계단위에 포함되어 있는지 검사 기능.
		적용 고객사 : 한국경영자총협회
		관련 WIKI : http://wiki.duzon.com:8080/display/UCDEV1/CUST_001
	-->
	<jsp:include page="../customize/cust001.jsp" flush="false" />
	</c:if>

	<c:if test="${not empty EXNP_CUST_002}">
	<!--
		## [CUST_002] [TODO] 추가 커스터마이징 기능 개발시 이곳에 추가하시오.
		기능 :
		적용 고객사 :
		관련 WIKI :
	-->
	</c:if>
<!-- [-] 커스터마이징 옵션 페이지 적용 [-] -->


<script>
		// include polyfill
		if (!String.prototype.includes) {
		String.prototype.includes = function(search, start) {
			'use strict';
			if (typeof start !== 'number') {
				start = 0;
			}

			if (start + search.length > this.length) {
				return false;
			} else {
				return this.indexOf(search, start) !== -1;
			}
		};
	}

	// 결의서 작성
	// outProcessInterfaceId : ${outProcessInterfaceId}
	// outProcessInterfaceMId : ${outProcessInterfaceMId}
	// outProcessInterfaceDId : ${outProcessInterfaceDId}
	// eaBaseInfo : ${eaBaseInfo}
	// conVo : ${conVo}
	// loginVo : ${loginVo}
	// erp_optionSet : ${erp_optionSet}
	// gw_optionSet : ${gw_optionSet}
	// erpBaseInfo : ${erpBaseInfo}
	// erpAbsDocu : ${erpAbsDocu}
	// erpAbsDocu : ${erpAbsDocu}
	// erpGisu : ${erpGisu}
	// approBefore : ${approBefore}
	// consHeadInfo : ${consHeadInfo}
	// consBudgetInfo : ${consBudgetInfo}
	// consTradeInfo : ${consTradeInfo}
	// resHeadInfo : ${resHeadInfo}
	// resBudgetInfo : ${resBudgetInfo}
	// resTradeInfo : ${resTradeInfo}
	// consDocInfo : ${consDocInfo}
	// consHeadInfo : ${consHeadInfo}
	// consBudgetInfo : ${consBudgetInfo}
	// consTradeInfo : ${consTradeInfo}
	// resDocInfo : ${resDocInfo}
	// resHeadInfo : ${resHeadInfo}
	// resBudgetInfo : ${resBudgetInfo}
	// resTradeInfo : ${resTradeInfo}
	// param : ${param}
	var mode = 'dev';
	var domain = '/CustomPStoPurchase';
	var formSeq = '${param.formSeq}';
	var approKey = '${param.approKey}';
	var approvalBack = false;
	var consReferYN = 'N';
	var trFgNameIndex = 0;
	var YES = 'Y';
	var NO = 'N';
	var preDocSeq = '';
	var confferFlag = 0;
	var useFavorites = 0;
	var flagFavorites = false;
	var checkDocStatus = 'N';
	var resetBudgetSize = 0;
	let resCustomProcess = ('${resCustomProcess}' === 'true'); // 경남 결의 커스텀 프로세스일 경우 true
	let consDocSeq = '${consDocSeq}'; // 경남 커스텀 소스 품의서 있는 경우 품의서 키 전달.
	const gntpKey = '${gntpKey}'; // 경남 커스텀 소스에서 전달된 결의서 키. 새로 만들어질 결의서 키로 부여될 예정.
	const formType = '${formType}'; // 경남 커스텀 프로세스일 경우 gntpResFormTyp의 값들 중 하나가 부여됨.
	const gntpResFormType = {
		EXNPRESCONU: 'EXNPRESCONU',
		EXNPRESCUSTOM: 'EXNPRESCUSTOM'
	}; // 경남 커스텀 결의 폼 타입 열거형.


	/* ## 변수정의 ## */
	/* ====================================================================================================================================================== */
    /* SSL 적용관련 */
    if (!window.location.origin) {
        window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
    }
    var origin = document.location.origin;
	var resDocSeq = ''; /* 결의문서 시퀀스 */
	var resGrid = {
		ERPiU : {
			columns : [ {
				/* 테이블 헤더 표시 정보 */
				title : '${CL.ex_resDiv}',
				/* 테이블 컬럼 구분 정보 */
				column : 'docuFgName',
				/* 사용자 입력 형태 정의 [ 2018.04.11 : text, readonly, combobox, datepicker ] */
				type : 'combobox',
				/* 화면 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
				display : YES,
				/* 필수 입력 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
				req : YES,
				/* combobox 처리 시 더미 정보 ( "type: 'combobox'" 인 경우 필수 ) */
				combobox : {
					/* combobox 표시 내용 ( combobox.data 기준으로 key가 존재할 경우 대체, key가 없을 경우 그대로 표시 ) */
					display : [ 'docuFgCode', '.', 'docuFgName' ],
					/* combobox 표시 array */
					data : Option.ERPiU.GetDocuFg()
				},
				/* 툴팁 표시 호출 이벤트 정의 */
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_motionDate}',
				column : 'resDate',
				type : 'datepicker',
				display : YES,
				req : YES,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '결의내역',
				column : 'resNote',
				type : 'text',
				display : YES,
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_causeDate}',
				column : 'causeDate',
				type : 'datepicker',
				display : Option.ERPiU.GetCauseStat(),
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_contractDate}',
				column : 'signDate',
				type : 'datepicker',
				display : Option.ERPiU.GetCauseStat(),
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_checkDate}',
				column : 'inspectDate',
				type : 'datepicker',
				display : Option.ERPiU.GetCauseStat(),
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '지출/수입예정일',   // 20210928 지출/수입예정일 IU 추가 (고객사 티비씨 요청) -> 패키지로 추가
				column : 'payplanDate', // DT_PAYPLAN
				type : 'datepicker',
				display : Option.ERPiU.GetCauseStat(),
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_causePerson}',
				column : 'causeEmpName',
				type : 'text',
				display : Option.ERPiU.GetCauseStat(),
				req : NO,
				keyEvent : [ 'F2', 'Enter' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* [ parameter ] */
						/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
						keyName = (keyName || 'F2');
						/*   - searchStr : 사용자 입력 검색어 */
						searchStr = (searchStr || '');

						/* 현재 행 정보 조회 */
						var resData = $('#resTbl').dzt('getValue');

						/* 코드 팝업 호출 */
						fnCommonCode('causeEmp', keyName, searchStr, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var budgetData = $('#resTbl').dzt('getValue');
						if ((budgetData.causeEmpSeq || '') === '') {
							/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							var keyName = 'Enter';
							/* searchStr : 사용자 입력 검색어 */
							var searchStr = $('#resTbl').dzt('getInputValue');
							/* F2 입력 이벤트 호출 */
							this.keyEventF2(keyName, searchStr);
						} else {
							$('#resTbl').dzt('setKeyIn', 'RIGHT');
						}
						/* [ return ] */
						return false;
					},
					keyEventBackspace : function() {
						return this.keyEventDelete();
					},
					keyEventDefault: function (keyName, searchStr) {
						if(!!$('#budgetTbl').dzt('getValue').causeEmpSeq){
							return this.keyEventDelete();
						}
                    },
					keyEventDelete : function() {
						/* 현재 행 정보 조회 */
						var uid = $('#resTbl').dzt('getUID');
						/* 입력된 프로젝트/부서 정보 삭제 ( 프로젝트/부서 코드 ) */
						$('#resTbl').dzt('setValue', uid, {
							causeEmpSeq : ''
						}, FALSE);
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : 'causeEmpSeq',
				column : 'causeEmpSeq',
				type : 'text',
				display : 'N',
				req : NO,
				tooltip : function() {
				}
			}, {
				title : '${CL.ex_ioAccount2}',
				column : 'btrNb',
				type : 'text',
				display : YES,
				req : NO,
				/* 키입력 이벤트 키 정의 [ 2018.04.11 : F2, Enter ] */
				keyEvent : [ 'F2', 'Enter' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* [ parameter ] */
						/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
						keyName = (keyName || 'F2');
						/*   - searchStr : 사용자 입력 검색어 */
						searchStr = (searchStr || '');

						/* 현재 행 정보 조회 */
						var resData = $('#resTbl').dzt('getValue');

						/* 코드 팝업 호출 */
						fnCommonCode('btrNb', keyName, searchStr, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var budgetData = $('#resTbl').dzt('getValue');
						if ((budgetData.btrSeq || '') === '') {
							/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							var keyName = 'Enter';
							/* searchStr : 사용자 입력 검색어 */
							var searchStr = $('#resTbl').dzt('getInputValue');
							/* F2 입력 이벤트 호출 */
							this.keyEventF2(keyName, searchStr);
						} else {
							$('#resTbl').dzt('setKeyIn', 'RIGHT');
						}
						/* [ return ] */
						return false;
					},
					keyEventDefault: function (keyName, searchStr) {
						if(!!$('#budgetTbl').dzt('getValue').btrSeq){
							return this.keyEventDelete();
						}
                    },
					keyEventBackspace : function() {
						return this.keyEventDelete();
					},
					keyEventDelete : function() {
						/* 현재 행 정보 조회 */
						var uid = $('#resTbl').dzt('getUID');
						/* 입력된 계좌 정보 삭제 ( 입출금계좌, 입출금 계좌 코드, 입출금 계좌 명칭 ) */
						$('#resTbl').dzt('setValue', uid, {
							btrSeq : ''
						}, false);
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				},
				/* 마지막 컬럼인 경우 별도 이벤트 처리 */
				lastCallback : function() {
					/* 현재 행 정보 조회 */
					var resData = $('#resTbl').dzt('getValue');

					/* 필수값 입력 ${CL.ex_check} */
					var reqChkRes = fnResChkValue();

					var special_pattern = /[\']/gi;

					/* 저장될 데이터 사이즈 ${CL.ex_check} */
					if (resData.resNote.length > 59) {
						alert('적요는 60자 이내로 작성가능합니다.');
						return;
					}

					if(special_pattern.test(resData.resNote)){
						alert('적요는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
						return ;
					}

					if (reqChkRes.sts) {
						/* 데이터 저장여부 ${CL.ex_check} */
						if (typeof resData.resSeq === 'undefined' || resData.resSeq === '') {
							fnResInsert();

							/* 정상처리여부 ${CL.ex_check} */
							resData = $('#resTbl').dzt('getValue');
							if ((resData.insertStat || '') === 'SUCCESS') {
								$('#resTbl').dzt('setCommit', false); /* commit 처리 */
								$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

								if ($('#budgetTbl').dzt('getValueAll').length < 1) {
									$('#btnBudgetAdd').click();
								} else {
									$('#resTbl').dzt('setCommit', false);
									$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
									$('#budgetTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
								}
							} else {
								$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
									insertStat : '',
									insertMsg : ''
								});
								$('#resTbl').dzt('setCommit', false);

								if ((resData.insertMsg || '') !== '') {
									alert(resData.insertMsg);
								}
							}
						} else {
							/* 저장도 되었으며 마지막 행이므로 결제내역으로 이동 */
							var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
							var budgetSaveCount = $('#budgetTbl').dzt('getValueAll').filter(function(item) {
								return ((item.budgetSeq || '') != '')
							}).length;

							if (budgetDataArray.length !== budgetSaveCount) {
								/* 마지막 행으로 이동 */
								$('#budgetTbl').dzt('setCommit', false);
								$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								$('#budgetTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
							} else {
								/* 신규 행 추가 */
								$('#btnBudgetAdd').click();
							}
						}
					} else {
						/* 미입력 항목 포커스 지정 */
						var uid = $('#budgetTbl').dzt('getUID');
						$('#budgetTbl').dzt('setFocus', uid, reqChkRes.key);

						/* 사용자 알림 처리 */
						alert(reqChkRes.msg);
					}

					/* 포커스 지정이 존재하지 않는 경우에는 현재 포커스 유지처리 */
					if (($('#budgetTbl').find('.colOn').length + $('#tradeTbl').find('.colOn').length) === 0) {
						$('#resTbl').dzt('setFocus', $('#resTbl').dzt('getUID'), this.column);
					}

					return false;
				}
			}, {
				title : '${CL.ex_amount}',
				column : 'amt',
				type : 'readonly',
				/* 3자리 콤마 표시여부 [ 2018.04.11 : 숫자만 입력 미구현 ] */
				isNumeric : YES,
				display : YES,
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '결의서 문서 시퀀스',
				column : 'resDocSeq',
				type : 'readonly',
				display : NO
			}, {
				title : '결의서 시퀀스',
				column : 'resSeq',
				type : 'readonly',
				display : NO
			}, {
				title : '입출금 계좌 코드',
				column : 'btrSeq',
				type : 'readonly',
				display : NO
			}, {
				title : '입출금 계좌 명칭',
				column : 'btrName',
				type : 'readonly',
				display : NO
			} ]
		},
		iCUBE : {
			columns : [ {
				/* 테이블 헤더 표시 정보 */
				title : '${CL.ex_resDiv} ',/*결의구분*/
				/* 테이블 컬럼 구분 정보 */
				column : 'docuFgName',
				/* 사용자 입력 형태 정의 [ 2018.04.11 : text, readonly, combobox, datepicker ] */
				type : 'combobox',
				/* 화면 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
				display : YES,
				/* 필수 입력 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
				req : YES,
				/* combobox 처리 시 더미 정보 ( "type: 'combobox'" 인 경우 필수 ) */
				combobox : {
					/* combobox 표시 내용 ( combobox.data 기준으로 key가 존재할 경우 대체, key가 없을 경우 그대로 표시 ) */
					display : [ 'docuFgCode', '.', 'docuFgName' ],
					/* combobox 표시 array */
					data : Option.iCUBE.GetDocuFg()
				},
				/* 툴팁 표시 호출 이벤트 정의 */
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_motionDate} ',/*발의일자*/
				column : 'resDate',
				type : 'datepicker',
				display : YES,
				req : YES,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : GetErpMgtIsProject() ? '${CL.ex_project} '/*프로젝트*/ : '${CL.ex_department}' /*부서*/,
				column : 'erpMgtName',
				type : 'text',
				display : YES,
				req : YES,
				keyEvent : [ 'F2', 'Enter' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* [ parameter ] */
						/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
						keyName = (keyName || 'F2');
						/*   - searchStr : 사용자 입력 검색어 */
						searchStr = (searchStr || '');

						/* 현재 행 정보 조회 */
						var resData = $('#resTbl').dzt('getValue');

						/* 코드 팝업 호출 */
						fnCommonCode('erpMgtName', keyName, searchStr, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var budgetData = $('#resTbl').dzt('getValue');
						if ((budgetData.erpMgtSeq || '') === '') {
							/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							var keyName = 'Enter';
							/* searchStr : 사용자 입력 검색어 */
							var searchStr = $('#resTbl').dzt('getInputValue');
							/* F2 입력 이벤트 호출 */
							this.keyEventF2(keyName, searchStr);
						} else {
							$('#resTbl').dzt('setKeyIn', 'RIGHT');
						}
						/* [ return ] */
						return false;
					},
					keyEventDefault: function (keyName, searchStr) {
						/* 프로젝트 코드가 선택된 경우에만 동작 */
						if(!!$('#resTbl').dzt('getValue').erpMgtSeq){
                        	return this.keyEventDelete();
						}
                    },
					keyEventBackspace : function() {
						return this.keyEventDelete();
					},
					keyEventDelete : function() {
						/* 현재 행 정보 조회 */
						var uid = $('#resTbl').dzt('getUID');
						/* 입력된 프로젝트/부서 정보 삭제 ( 프로젝트/부서 코드 ) */
						$('#resTbl').dzt('setValue', uid, {
							erpMgtSeq : ''
						}, false);
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_bottomBussines}',/*하위사업*/
				column : 'bottomName',
				type : 'text',
				req : YES,
				display : Option.iCUBE.GetBottomUseYN(),
				keyEvent : [ 'F2', 'Enter' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* [ parameter ] */
						/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
						keyName = (keyName || 'F2');
						/*   - searchStr : 사용자 입력 검색어 */
						searchStr = (searchStr || '');

						/* 현재 행 정보 조회 */
						var resData = $('#resTbl').dzt('getValue');

						/* 코드 팝업 호출 */
						fnCommonCode('erpBottomName', keyName, searchStr, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var budgetData = $('#resTbl').dzt('getValue');
						if ((budgetData.erpBottomSeq || '') === '') {
							/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							var keyName = 'Enter';
							/* searchStr : 사용자 입력 검색어 */
							var searchStr = $('#resTbl').dzt('getInputValue');
							/* F2 입력 이벤트 호출 */
							this.keyEventF2(keyName, searchStr);
						} else {
							$('#resTbl').dzt('setKeyIn', 'RIGHT');
						}
						/* [ return ] */
						return false;
					},
					keyEventDefault: function (keyName, searchStr) {
						if(!!$('#resTbl').dzt('getValue').bottomSeq){
							return this.keyEventDelete();
						}
                    },
					keyEventBackspace : function() {
						return this.keyEventDelete();
					},
					keyEventDelete : function() {
						/* 현재 행 정보 조회 */
						var uid = $('#resTbl').dzt('getUID');
						/* 입력된 프로젝트/부서 정보 삭제 ( 프로젝트/부서 코드 ) */
						$('#resTbl').dzt('setValue', uid, {
							bottomSeq : ''
						}, false);
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_note} ',/*적요*/
				column : 'resNote',
				type : 'text',
				display : YES,
				req : ((optionSet.gw[1][11]||{'setValue':'1'}).setValue == '0' ? YES : NO),
				keyEvent : [ 'F2' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* [ parameter ] */
						/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
						keyName = (keyName || 'F2');
						/*   - searchStr : 사용자 입력 검색어 */
						searchStr = (searchStr || '');

						/* 현재 행 정보 조회 */
						var resData = $('#resTbl').dzt('getValue');
						var code = 'resNote';
						/* 코드 팝업 호출 */
						document.getElementById("resNoteStr").focus();
						resNoteInsert(code, keyName, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var resData = $('#resTbl').dzt('getValue');

						$('#resTbl').dzt('setKeyIn', 'RIGHT');
						$('#resNoteStr').val(resData.resNote);

						/* [ return ] */
						return false;
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_causeDate} ',/*원인행위일*/
				column : 'causeDate',
				type : 'datepicker',
				display : Option.iCUBE.GetCauseStat(),
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_contractDate} ',/*계약일*/
				column : 'signDate',
				type : 'datepicker',
				display : Option.iCUBE.GetCauseStat(),
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_checkDate}',/*검수일*/
				column : 'inspectDate',
				type : 'datepicker',
				display : Option.iCUBE.GetCauseStat(),
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_causePerson}',/*원인행위자*/
				column : 'causeEmpName',
				type : 'text',
				display : Option.iCUBE.GetCauseStat(),
				req : NO,
				keyEvent : [ 'F2', 'Enter' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* [ parameter ] */
						/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
						keyName = (keyName || 'F2');
						/*   - searchStr : 사용자 입력 검색어 */
						searchStr = (searchStr || '');

						/* 현재 행 정보 조회 */
						var resData = $('#resTbl').dzt('getValue');

						/* 코드 팝업 호출 */
						fnCommonCode('causeEmp', keyName, searchStr, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var budgetData = $('#resTbl').dzt('getValue');
						if ((budgetData.causeEmpSeq || '') === '') {
							/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							var keyName = 'Enter';
							/* searchStr : 사용자 입력 검색어 */
							var searchStr = $('#resTbl').dzt('getInputValue');
							/* F2 입력 이벤트 호출 */
							this.keyEventF2(keyName, searchStr);
						} else {
							$('#resTbl').dzt('setKeyIn', 'RIGHT');
						}
						/* [ return ] */
						return false;
					},
					keyEventDefault: function (keyName, searchStr) {
						if(!!$('#resTbl').dzt('getValue').causeEmpSeq){
							return this.keyEventDelete();
						}
                    },
					keyEventBackspace : function() {
						return this.keyEventDelete();
					},
					keyEventDelete : function() {
						/* 현재 행 정보 조회 */
						var uid = $('#resTbl').dzt('getUID');
						/* 입력된 프로젝트/부서 정보 삭제 ( 프로젝트/부서 코드 ) */
						$('#resTbl').dzt('setValue', uid, {
							causeEmpSeq : ''
						}, false);
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : 'causeEmpSeq',
				column : 'causeEmpSeq',
				type : 'text',
				display : 'N',
				req : NO,
				tooltip : function() {
				}
			},  {
				title : '${CL.ex_ioAccount2}',/*입출금계좌*/
				column : 'btrNb',
				type : 'text',
				display : YES,
				req : NO,
				/* 키입력 이벤트 키 정의 [ 2018.04.11 : F2, Enter ] */
				keyEvent : [ 'F2', 'Enter' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* [ parameter ] */
						/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
						keyName = (keyName || 'F2');
						/*   - searchStr : 사용자 입력 검색어 */
						searchStr = (searchStr || '');

						/* 현재 행 정보 조회 */
						var resData = $('#resTbl').dzt('getValue');

						if(optionSet.gw[3][17].setValue == '1'){
							return false;
						}
						/* 코드 팝업 호출 */
						fnCommonCode('btrNb', keyName, searchStr, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var budgetData = $('#resTbl').dzt('getValue');
						if ((budgetData.btrSeq || '') === '') {
							/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							var keyName = 'Enter';
							/* searchStr : 사용자 입력 검색어 */
							var searchStr = $('#resTbl').dzt('getInputValue');
							/* F2 입력 이벤트 호출 */
							this.keyEventF2(keyName, searchStr);
						} else {
							$('#resTbl').dzt('setKeyIn', 'RIGHT');
						}
						/* [ return ] */
						return false;
					},
					keyEventDefault: function (keyName, searchStr) {
						if(!!$('#resTbl').dzt('getValue').btrSeq){
							return this.keyEventDelete();
						}
                    },
					keyEventBackspace : function() {
						return this.keyEventDelete();
					},
					keyEventDelete : function() {
						/* 현재 행 정보 조회 */
						var uid = $('#resTbl').dzt('getUID');
						/* 입력된 계좌 정보 삭제 ( 입출금계좌, 입출금 계좌 코드, 입출금 계좌 명칭 ) */
						$('#resTbl').dzt('setValue', uid, {
							btrSeq : ''
						}, false);
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				},
				/* 마지막 컬럼인 경우 별도 이벤트 처리 */
				lastCallback : function() {
					/* 현재 행 정보 조회 */
					var resData = $('#resTbl').dzt('getValue');

					/* 필수값 입력 ${CL.ex_check} */
					var reqChkRes = fnResChkValue();

					var special_pattern = /[\']/gi;

					/* 저장될 데이터 사이즈 ${CL.ex_check} */
					if (resData.resNote.length > 59) {
						alert('${CL.ex_note}는 60자 이내로 작성가능합니다.'); /*적요*/
						return;
					}

					/*적요 특수문자 체크*/
					if(special_pattern.test(resData.resNote)){
						alert('${CL.ex_note}는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
						return ;
					}

					/* 하위사업 필수값 체크 */
					if(Option.iCUBE.GetBottomUseYN() == 'Y' && (resData.bottomSeq||'') == ''){
						alert('하위사업을 입력 해주세요.');
						return;
					}

					if (reqChkRes.sts) {
						/* 데이터 저장여부 ${CL.ex_check} */
						if (typeof resData.resSeq === 'undefined' || resData.resSeq === '') {
							fnResInsert();

							/* 정상처리여부 ${CL.ex_check} */
							resData = $('#resTbl').dzt('getValue');
							if ((resData.insertStat || '') === 'SUCCESS') {
								$('#resTbl').dzt('setCommit', false); /* commit 처리 */
								$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
									erpGisuDt : optionSet.erpGisu.gisu||'',
									erpGisuFromDate : optionSet.erpGisu.fromDate||'',
									erpGisuToDate : optionSet.erpGisu.toDate||''
								});
								$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

								if ($('#budgetTbl').dzt('getValueAll').length < 1) {
									$('#btnBudgetAdd').click();
								} else {
									$('#resTbl').dzt('setCommit', false);
									$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
									$('#budgetTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
								}
							} else {
								$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
									insertStat : '',
									insertMsg : ''
								});
								$('#resTbl').dzt('setCommit', false);

								if ((resData.insertMsg || '') !== '') {
									alert(resData.insertMsg);
								}
							}
						} else {
							/* 저장도 되었으며 마지막 행이므로 결제내역으로 이동 */
							var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
							var budgetSaveCount = $('#budgetTbl').dzt('getValueAll').filter(function(item) {
								return ((item.budgetSeq || '') != '')
							}).length;

							if (budgetDataArray.length !== budgetSaveCount) {
								/* 마지막 행으로 이동 */
								$('#budgetTbl').dzt('setCommit', false);
								$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								$('#budgetTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
							} else {
								/* 신규 행 추가 */
								$('#btnBudgetAdd').click();
							}
						}
					} else {
						/* 미입력 항목 포커스 지정 */
						var uid = $('#budgetTbl').dzt('getUID');
						$('#budgetTbl').dzt('setFocus', uid, reqChkRes.key);

						/* 사용자 알림 처리 */
						alert(reqChkRes.msg);
					}

					/* 포커스 지정이 존재하지 않는 경우에는 현재 포커스 유지처리 */
					if (($('#budgetTbl').find('.colOn').length + $('#tradeTbl').find('.colOn').length) === 0) {
						$('#resTbl').dzt('setFocus', $('#resTbl').dzt('getUID'), this.column);
					}

					return false;
				}
			}, {
				title : ' ${CL.ex_ioAccountNm} ',/*입출금 계좌 명칭*/
				column : 'btrName',
				type : 'readonly',
				display : YES,
				req : NO,
			} , {
				title : '${CL.ex_amount}',/*금액*/
				column : 'amt',
				type : 'readonly',
				isNumeric : YES,
				display : YES,
				req : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			},{
                title: '${CL.ex_goodsSpecification}',
                column: 'itemAmt',
                isNumeric : YES,
                type: 'readonly',
                display: GetItemSpecResGridUseYN(),
                req: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? NO : NO)),
                tooltip: function () {
                    Option.Common.SetTooltip($('#spanConsTooltip'), this.column);
                },
                keyEvent : [ 'F2', 'Enter' ],
				methods : {
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventF2 : function(keyName, searchStr) {
						/* 코드 팝업 호출 */
						fnEventItemSpecPop();
						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						/* 코드 팝업 호출 */
						fnEventItemSpecPop();
						/* [ return ] */
						return false;
					},
				}
            }, {
				title : '${CL.ex_statement} ',/*명세서*/
				column : 'statement',
				type : 'text',
				display : Option.iCUBE.GetStatementStat(),
				req : NO,
				keyEvent : [ 'F2', 'Enter' ],
				methods : {
					keyEventF2 : '',
					keyEventEnter : ''
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : '${CL.ex_resDocSeq2} ',/*결의서 문서 시퀀스*/
				column : 'resDocSeq',
				type : 'readonly',
				display : NO
			}, {
				title : '${CL.ex_resDocSeq}  ',/*결의서 시퀀스*/
				column : 'resSeq',
				type : 'readonly',
				display : NO
			}, {
				title : '${CL.ex_projectCode}',/*프로젝트 코드*/
				column : 'erpMgtSeq',
				type : 'text',
				display : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : ' ${CL.ex_bottomBussinesCd} ',/*하위사업 코드*/
				column : 'bottomSeq',
				type : 'text',
				display : NO,
				tooltip : function() {
					Option.Common.SetTooltip($('#resTooltip'), this.column);
				}
			}, {
				title : ' ${CL.ex_ioAccountCd} ',/*입출금 계좌 코드*/
				column : 'btrSeq',
				type : 'readonly',
				display : NO
			}]
		}
	};

	var budgetGrid = {
			ERPiU : {
				columns : [ {
					title : '${CL.ex_budgetUnit}',/*예산단위*/
					column : 'erpBudgetName',
					type : 'text',
					display : YES,
					req : YES,
					keyEvent : [ 'F2', 'Enter' ],
					methods : {
						keyEventF2 : function(keyName, searchStr) {
							/* [ parameter ] */
							/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							keyName = (keyName || 'F2');
							/*   - searchStr : 사용자 입력 검색어 */
							searchStr = (searchStr || '');

							/* 현재 행 정보 조회 */
							var resData = $('#resTbl').dzt('getValue');
							var budgetData = $('#budgetTbl').dzt('getValue');

							/* 코드 팝업 호출 */
							fnCommonCode('erpBudgetName', keyName, searchStr, resData, budgetData);

							/* [ return ] */
							return false;
						},
						keyEventEnter : function() {
							var budgetData = $('#budgetTbl').dzt('getValue');
							if ((budgetData.erpBudgetSeq || '') === '') {
								/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
								var keyName = 'Enter';
								/* searchStr : 사용자 입력 검색어 */
								var searchStr = $('#budgetTbl').dzt('getInputValue');
								/* F2 입력 이벤트 호출 */
								this.keyEventF2(keyName, searchStr);
							} else {
								$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
							}
							/* [ return ] */
							return false;
						},
						keyEventDefault: function (keyName, searchStr) {
							if(!!$('#budgetTbl').dzt('getValue').erpBudgetSeq){
								return this.keyEventDelete();
							}
	                    },
						keyEventBackspace : function() {
							return this.keyEventDelete();
						},
						keyEventDelete : function() {
							/* 현재 행 정보 조회 */
							var uid = $('#budgetTbl').dzt('getUID');
							/* 입력된 계좌 정보 삭제 ( 예산단위, 예산단위코드 ) */
							$('#budgetTbl').dzt('setValue', uid, {
								erpBudgetSeq : ''
							}, false);
						}
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_businessPlan}', /*사업계획*/
					column : 'erpBizplanName',
					type : 'text',
					display : Option.ERPiU.GetBizplanStat(),
					req : Option.ERPiU.GetBizplanStat(),
					keyEvent : [ 'F2', 'Enter' ],
					methods : {
						keyEventF2 : function(keyName, searchStr) {
							/* [ parameter ] */
							/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							keyName = (keyName || 'F2');
							/*   - searchStr : 사용자 입력 검색어 */
							searchStr = (searchStr || '');

							/* 현재 행 정보 조회 */
							var resData = $('#resTbl').dzt('getValue');
							var budgetData = $('#budgetTbl').dzt('getValue');

							/* 코드 팝업 호출 */
							fnCommonCode('erpBizplanName', keyName, searchStr, resData, budgetData);

							/* [ return ] */
							return false;
						},
						keyEventEnter : function() {
							var budgetData = $('#budgetTbl').dzt('getValue');
							if ((budgetData.erpBizplanSeq || '') === '') {
								/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
								var keyName = 'Enter';
								/* searchStr : 사용자 입력 검색어 */
								var searchStr = $('#budgetTbl').dzt('getInputValue');
								/* F2 입력 이벤트 호출 */
								this.keyEventF2(keyName, searchStr);
							} else {
								$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
							}
							/* [ return ] */
							return false;
						},
						keyEventDefault: function (keyName, searchStr) {
							if(!!$('#budgetTbl').dzt('getValue').erpBizplanSeq){
								return this.keyEventDelete();
							}
	                    },
						keyEventBackspace : function() {
							return this.keyEventDelete();
						},
						keyEventDelete : function() {
							/* 현재 행 정보 조회 */
							var uid = $('#budgetTbl').dzt('getUID');
							/* 입력된 계좌 정보 삭제 ( 사업계획, 사업계획코드 ) */
							$('#budgetTbl').dzt('setValue', uid, {
								erpBizplanSeq : ''
							}, false);
						}
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_budgetAccount}', /*예산계정*/
					column : 'erpBgacctName',
					type : 'text',
					display : YES,
					req : YES,
					keyEvent : [ 'F2', 'Enter' ],
					methods : {
						keyEventF2 : function(keyName, searchStr) {
							/* [ parameter ] */
							/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							keyName = (keyName || 'F2');
							/*   - searchStr : 사용자 입력 검색어 */
							searchStr = (searchStr || '');

							/* 현재 행 정보 조회 */
							var resData = $('#resTbl').dzt('getValue');
							var budgetData = $('#budgetTbl').dzt('getValue');

							/* 코드 팝업 호출 */
							fnCommonCode('erpBgacctName', keyName, searchStr, resData, budgetData);

							/* [ return ] */
							return false;
						},
						keyEventEnter : function() {
							var budgetData = $('#budgetTbl').dzt('getValue');
							if ((budgetData.erpBgacctSeq || '') === '') {
								/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
								var keyName = 'Enter';
								/* searchStr : 사용자 입력 검색어 */
								var searchStr = $('#budgetTbl').dzt('getInputValue');
								/* F2 입력 이벤트 호출 */
								this.keyEventF2(keyName, searchStr);
							} else {
								$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
							}

							/* [ return ] */
							return false;
						},
						keyEventDefault: function (keyName, searchStr) {
							if(!!$('#budgetTbl').dzt('getValue').erpBgacctSeq){
								return this.keyEventDelete();
							}
	                    },
						keyEventBackspace : function() {
							return this.keyEventDelete();
						},
						keyEventDelete : function() {
							/* 현재 행 정보 조회 */
							var uid = $('#budgetTbl').dzt('getUID');
							/* 입력된 계좌 정보 삭제 ( 예산계정, 예산계정코드 ) */
							$('#budgetTbl').dzt('setValue', uid, {
								erpBgacctSeq : ''
							}, false);
						}
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_accountingAcc}',/*회계계정*/
					column : 'erpFiacctName',
					type : 'text',
					display : YES,
					req : NO,
					keyEvent : [ 'F2', 'Enter' ],
					methods : {
						keyEventF2 : function(keyName, searchStr) {
							/* [ parameter ] */
							/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							keyName = (keyName || 'F2');
							/*   - searchStr : 사용자 입력 검색어 */
							searchStr = (searchStr || '');

							/* 현재 행 정보 조회 */
							var resData = $('#resTbl').dzt('getValue');
							var budgetData = $('#budgetTbl').dzt('getValue');

							/* 코드 팝업 호출 */
							fnCommonCode('erpFiacctName', keyName, searchStr, resData, budgetData);

							/* [ return ] */
							return false;
						},
						keyEventEnter : function() {
							var budgetData = $('#budgetTbl').dzt('getValue');
							if ((budgetData.erpFiacctSeq || '') === '') {
								/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
								var keyName = 'Enter';
								/* searchStr : 사용자 입력 검색어 */
								var searchStr = $('#budgetTbl').dzt('getInputValue');
								/* F2 입력 이벤트 호출 */
								this.keyEventF2(keyName, searchStr);
							} else {
								$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
							}

							/* [ return ] */
							return false;
						},
						keyEventDefault: function (keyName, searchStr) {
							if(!!$('#budgetTbl').dzt('getValue').erpFiacctSeq){
								return this.keyEventDelete();
							}
	                    },
						keyEventBackspace : function() {
							return this.keyEventDelete();
						},
						keyEventDelete : function() {
							/* 현재 행 정보 조회 */
							var uid = $('#budgetTbl').dzt('getUID');
							/* 입력된 계좌 정보 삭제 ( 회계계정, 회계계정코드 ) */
							$('#budgetTbl').dzt('setValue', uid, {
								erpFiacctSeq : ''
							}, false);
						}
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_paymentKind} ',/*결제수단*/
					column : 'setFgName',
					type : 'combobox',
					display : YES,
					req : YES,
					combobox : {
						display : [ 'setFgCode', '.', 'setFgName' ],
						data : Option.ERPiU.GetFg()
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_taxDivision} ',/*과세구분*/
					column : 'vatFgName',
					type : 'combobox',
					display : YES,
					req : YES,
					combobox : {
						display : [ 'vatFgCode', '.', 'vatFgName' ],
						data : Option.ERPiU.GetVatFg()
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_creditorType} ',/*채주유형*/
					column : 'trFgName',
					type : 'combobox',
					display : YES,
					req : YES,
					combobox : {
						display : [ 'trFgCode', '.', 'trFgName' ],
						data : Option.ERPiU.GetTrFg()
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_note} ',/*적요*/
					column : 'budgetNote',
					type : 'text',
					display : YES,
					req : NO,
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					},
					/* 마지막 컬럼인 경우 별도 이벤트 처리 */
					lastCallback : function() {
						/* 현재 행 정보 조회 */
						var budgetData = $('#budgetTbl').dzt('getValue');

						/* 필수값 입력 ${CL.ex_check} */
						var reqChkBudget = fnBudgetChkValue();

						var special_pattern = /[\']/gi;

						/* 저장될 데이터 사이즈 ${CL.ex_check} */
						if (budgetData.budgetNote.length > 79) {
							alert('${CL.ex_note2}는 80자 이내로 작성가능합니다.'); /*적요*/
							return;
						}

						/*비고(예산) 특수문자 체크*/
						if(special_pattern.test(budgetData.budgetNote)){
							alert('${CL.ex_note2}는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
							return ;
						}

						if (Option.Common.ERPiU()) {
							var budgetAllData = $('#budgetTbl').dzt('getValueAll');
							var trFgCode = [];
							for(var i=0;i<budgetAllData.length;i++){
								trFgCode.push(budgetAllData[i].trFgCode);
							}
							if( (trFgCode.indexOf('4') != -1 || trFgCode.indexOf('9') != -1) && (trFgCode.indexOf('1') != -1 || trFgCode.indexOf('2') != -1 || trFgCode.indexOf('3') != -1) ){
								alert('기타소득자, 사업소득자는 거래처등록, 사원등록, 거래처명과 같이 처리 할 수 없습니다.');
								return;
							}
						}

						if (reqChkBudget.sts) {
							/* 데이터 저장여부 ${CL.ex_check} */
							if (typeof budgetData.budgetSeq === 'undefined' || budgetData.budgetSeq === '') {
								fnBudgetInsert();

								/* 정상처리여부 ${CL.ex_check} */
								budgetData = $('#budgetTbl').dzt('getValue');
								if ((budgetData.insertStat || '') === 'SUCCESS') {
									$('#budgetTbl').dzt('setCommit', false); /* commit 처리 */
									$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

									if ($('#tradeTbl').dzt('getValueAll').length < 1) {
										$('#btnTradeAdd').click();
									} else {
										$('#budgetTbl').dzt('setCommit', false);
										$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
										$('#tradeTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
									}
								} else {
									$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
										insertStat : '',
										insertMsg : ''
									});
									$('#budgetTbl').dzt('setCommit', false);

									if ((budgetData.insertMsg || '') !== '') {
										alert(budgetData.insertMsg);
									}
								}
							} else {
								/* 저장도 되었으며 마지막 행이므로 결제내역으로 이동 */
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
							}
						} else {
							/* 미입력 항목 포커스 지정 */
							var uid = $('#budgetTbl').dzt('getUID');
							$('#budgetTbl').dzt('setFocus', uid, reqChkBudget.key);

							/* 사용자 알림 처리 */
							if ((reqChkBudget.msg || '') !== '') {
								alert(reqChkBudget.msg);
							}
						}

						return false;
					}
				}, {
					title : '${CL.ex_amount}', /*금액*/
					column : 'budgetAmt',
					type : 'readonly',
					isNumeric : YES,
					display : YES,
					req : NO,
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title: '${CL.ex_goodsSpecification}',
	                column: 'itemAmt',
	                isNumeric : YES,
	                type: 'text',
	                display: GetItemSpecBudgetGirdUseYN(),
	                req: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? NO : NO)),
	                tooltip: function () {
	                    Option.Common.SetTooltip($('#spanConsTooltip'), this.column);
	                },
	                keyEvent : [ 'F2', 'Enter' ],
					methods : {
						/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
						keyEventF2 : function(keyName, searchStr) {
							/* 코드 팝업 호출 */
							fnEventItemSpecPop();
							/* [ return ] */
							return false;
						},
						/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
						keyEventEnter : function() {
							/* 코드 팝업 호출 */
							fnEventItemSpecPop();
							/* [ return ] */
							return false;
						},
					}
				}, {
					title : '${CL.ex_resDocSeq2}', /*결의서 문서 시퀀스*/
					column : 'resDocSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_resDocSeq} ',/*결의서 시퀀스*/
					column : 'resSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budgetSeq} ',/*예산 시퀀스*/
					column : 'budgetSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budgetUniCode}  ',/*예산단위 코드*/
					column : 'erpBudgetSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_businessPlanCode}',/*사업계획 코드*/
					column : 'erpBizplanSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budgetAccountCode}', /*예산계정 코드*/
					column : 'erpBgacctSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_accountingAccCode}',/*회계계정 코드*/
					column : 'erpFiacctSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_paymentKindCd}', /*결제수단 코드*/
					column : 'setFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_taxDivCd} ',/*과세구분 코드*/
					column : 'vatFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_creditorTypeCode}',/*채주유형 코드*/
					column : 'trFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erplinkConsKey}', /*ERP 연동 품의서 키*/
					column : 'erpBqSeq',
					type : 'readonly',
					display : NO
				}, {
					title : ' ${CL.ex_erplinkConsAmtKey}',/*ERP 연동 품의 예산 키*/
					column : 'erpBkSeq',
					type : 'readonly',
					display : NO
				},
				{
					title : '${CL.ex_budget1Nm}',/*관 명칭*/
					column : 'erpBgt1Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget1Cd}',/*관 코드*/
					column : 'erpBgt1Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget2Nm}', /*항 명칭*/
					column : 'erpBgt2Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget2Cd}',/*항 코드*/
					column : 'erpBgt2Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget3Nm} ',/*목 명칭*/
					column : 'erpBgt3Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget3Cd}', /*목 코드*/
					column : 'erpBgt3Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget4Nm} ',/*세 명칭*/
					column : 'erpBgt4Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget4Cd}',/*세 코드*/
					column : 'erpBgt4Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erpBudgetAmt}', /*ERP 예산 편성 금액*/
					column : 'erpOpenAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erpExecutionMoney}',/*ERP 집행액*/
					column : 'erpApplyAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erpBalance}', /*ERP 잔액*/
					column : 'erpLeftAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_purPrice} ',/*공급가액*/
					column : 'budgetStdAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_vat} ',/*부가세*/
					column : 'budgetTaxAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '미사용? 코드',
					column : 'ctlFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '미사용? 명칭',
					column : 'ctlFgName',
					type : 'readonly',
					display : NO
				} ]
			},
			iCUBE : {
				columns : [ {
					title : '${CL.ex_budgetSub}', /*예산과목*/
					column : 'erpBudgetName',
					type : 'text',
					display : YES,
					req : YES,
					keyEvent : [ 'F2', 'Enter' ],
					methods : {
						keyEventF2 : function(keyName, searchStr) {
							/* [ parameter ] */
							/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							keyName = (keyName || 'F2');
							/*   - searchStr : 사용자 입력 검색어 */
							searchStr = (searchStr || '');

							/* 현재 행 정보 조회 */
							var resData = $('#resTbl').dzt('getValue');
							var budgetData = $('#budgetTbl').dzt('getValue');

							/* 코드 팝업 호출 */
							fnCommonCode('erpBudgetName', keyName, searchStr, resData, budgetData);

							/* [ return ] */
							return false;
						},
						keyEventEnter : function() {
							var budgetData = $('#budgetTbl').dzt('getValue');
							if ((budgetData.erpBudgetSeq || '') === '') {
								/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
								var keyName = 'Enter';
								/* searchStr : 사용자 입력 검색어 */
								var searchStr = $('#budgetTbl').dzt('getInputValue');
								/* F2 입력 이벤트 호출 */
								this.keyEventF2(keyName, searchStr);
							} else {
								$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
							}
							/* [ return ] */
							return false;
						},
						keyEventDefault: function (keyName, searchStr) {
							if(!!$('#budgetTbl').dzt('getValue').erpBudgetSeq){
								return this.keyEventDelete();
							}
	                    },
						keyEventBackspace : function() {
							return this.keyEventDelete();
						},
						keyEventDelete : function() {
							/* 현재 행 정보 조회 */
							var uid = $('#budgetTbl').dzt('getUID');
							/* 입력된 계좌 정보 삭제 ( 예산과목 코드, 관 명칭, 관 코드, 항 명칭, 항 코드, 목 명칭, 목 코드, 세 명칭, 세 코드 ) */
							$('#budgetTbl').dzt('setValue', uid, {
								erpBudgetSeq : '',
								erpBgt1Name : '',
								erpBgt1Seq : '',
								erpBgt2Name : '',
								erpBgt2Seq : '',
								erpBgt3Name : '',
								erpBgt3Seq : '',
								erpBgt4Name : '',
								erpBgt4Seq : ''
							}, false);
						}
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_paymentKind}', /*결제수단*/
					column : 'setFgName',
					type : 'combobox',
					display : YES,
					req : YES,
					combobox : {
						display : [ 'setFgCode', '.', 'setFgName' ],
						data : Option.iCUBE.GetFg()
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_taxDivision}', /*과세구분*/
					column : 'vatFgName',
					type : 'combobox',
					display : YES,
					req : YES,
					combobox : {
						display : [ 'vatFgCode', '.', 'vatFgName' ],
						data : Option.iCUBE.GetVatFg()
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_creditorType}', /*채주유형*/
					column : 'trFgName',
					type : 'combobox',
					display : YES,
					req : YES,
					combobox : {
						display : [ 'trFgCode', '.', 'trFgName' ],
						data : Option.iCUBE.GetTrFg()
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_accountingUnit}', /*회계단위*/
					column : 'erpDivName',
					type : 'text',
					display : YES,
					req : ( function (){
						if( !optionSet ){
							return NO;
						} else if( !optionSet.gw ){
							return NO;
						} else if(!optionSet.gw[3]){
							return NO;
						} else if(!optionSet.gw[3][10]){
							return NO;
						} else if( optionSet.gw[3][10].setValue == '0' ){
							return YES;
						} else {
							return NO;
						}
					} ) (),
					keyEvent : [ 'F2', 'Enter' ],
					methods : {
						keyEventF2 : function(keyName, searchStr) {
							/* [ parameter ] */
							/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							keyName = (keyName || 'F2');
							/*   - searchStr : 사용자 입력 검색어 */
							searchStr = (searchStr || '');

							/* 현재 행 정보 조회 */
							var resData = $('#resTbl').dzt('getValue');
							var budgetData = $('#budgetTbl').dzt('getValue');

							/* 코드 팝업 호출 */
							fnCommonCode('erpDivName', keyName, searchStr, resData, budgetData);

							/* [ return ] */
							return false;
						},
						keyEventEnter : function() {
							var budgetData = $('#budgetTbl').dzt('getValue');
							if ((budgetData.erpDivSeq || '') === '') {
								/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
								var keyName = 'Enter';
								/* searchStr : 사용자 입력 검색어 */
								var searchStr = $('#budgetTbl').dzt('getInputValue');
								/* F2 입력 이벤트 호출 */
								this.keyEventF2(keyName, searchStr);
							} else {
								$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
							}
							/* [ return ] */
							return false;
						},
						keyEventDefault: function (keyName, searchStr) {
							if(!!$('#budgetTbl').dzt('getValue').erpDivSeq){
								return this.keyEventDelete();
							}
	                    },
						keyEventBackspace : function() {
							return this.keyEventDelete();
						},
						keyEventDelete : function() {
							/* 현재 행 정보 조회 */
							var uid = $('#budgetTbl').dzt('getUID');
							/* 입력된 계좌 정보 삭제 ( 예산단위, 예산단위코드 ) */
							$('#budgetTbl').dzt('setValue', uid, {
								erpDivSeq : ''
							}, false);
						}
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_note2} ',/*비고*/
					column : 'budgetNote',
					type : 'text',
					display : YES,
					req : NO,
					keyEvent : [ 'F2' ],
					methods : {
						/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
						keyEventF2 : function(keyName, searchStr) {
							/* [ parameter ] */
							/*   - keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							keyName = (keyName || 'F2');
							/*   - searchStr : 사용자 입력 검색어 */
							searchStr = (searchStr || '');

							/* 현재 행 정보 조회 */
							var budgetData = $('#budgetTbl').dzt('getValue');
							var code = 'budgetNote';
							/* 코드 팝업 호출 */
							document.getElementById("budgetNoteStr").focus();
							budgetNoteInsert(code, keyName, budgetData);

							/* [ return ] */
							return false;
						},
						/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
						keyEventEnter : function() {
							var budgetData = $('#budgetTbl').dzt('getValue');

							$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
							$('#budgetNoteStr').val(budgetData.budgetNote);

							/* [ return ] */
							return false;
						}
					},
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					},
					/* 마지막 컬럼인 경우 별도 이벤트 처리 */
					lastCallback : function() {
						/* 현재 행 정보 조회 */
						var budgetData = $('#budgetTbl').dzt('getValue');

						/* 필수값 입력 ${CL.ex_check} */
						var reqChkBudget = fnBudgetChkValue();

						var special_pattern = /[\']/gi;

						/* 저장될 데이터 사이즈 ${CL.ex_check} */
						if (budgetData.budgetNote.length > 59) {
							alert('${CL.ex_note2}는 60자 이내로 작성가능합니다.');/*적요*/
							return;
						}

						/*비고(예산) 특수문자 체크*/
						if(special_pattern.test(budgetData.budgetNote)){
							alert('${CL.ex_note2}는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
							return ;
						}

						if (reqChkBudget.sts) {
							/* 데이터 저장여부 ${CL.ex_check} */
							if (typeof budgetData.budgetSeq === 'undefined' || budgetData.budgetSeq === '') {
								fnBudgetInsert();

								/* 정상처리여부 ${CL.ex_check} */
								budgetData = $('#budgetTbl').dzt('getValue');
								if ((budgetData.insertStat || '') === 'SUCCESS') {
									$('#budgetTbl').dzt('setCommit', false); /* commit 처리 */
									$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

									if ($('#tradeTbl').dzt('getValueAll').length < 1) {
										$('#btnTradeAdd').click();
									} else {
										$('#budgetTbl').dzt('setCommit', false);
										$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
										$('#tradeTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
									}
								} else {
									$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
										insertStat : '',
										insertMsg : ''
									});
									$('#budgetTbl').dzt('setCommit', false);

									if ((budgetData.insertMsg || '') !== '') {
										alert(budgetData.insertMsg);
									}
								}
							} else {
								/* 저장도 되었으며 마지막 행이므로 결제내역으로 이동 */
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
							}
						} else {
							/* 미입력 항목 포커스 지정 */
							var uid = $('#budgetTbl').dzt('getUID');
							$('#budgetTbl').dzt('setFocus', uid, reqChkBudget.key);

							/* 사용자 알림 처리 */
							/* 사용자 알림 처리 */
							if ((reqChkBudget.msg || '') !== '') {
								alert(reqChkBudget.msg);
							}
						}

						return false;
					}
				}, {
					title : '${CL.ex_amount} ',/*금액*/
					column : 'budgetAmt',
					type : 'readonly',
					isNumeric : YES,
					display : YES,
					req : NO,
					tooltip : function() {
						Option.Common.SetTooltip($('#budgetTooltip'), this.column);
					}
				}, {
					title : '${CL.ex_resDocSeq2} ',/*결의서 문서 시퀀스*/
					column : 'resDocSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_resDocSeq} ',/*결의서 시퀀스*/
					column : 'resSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budgetSeq}',/*예산 시퀀스*/
					column : 'budgetSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budgetSubCode} ',/*예산과목 코드*/
					column : 'erpBudgetSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_accountUnitCode} ',/*회계단위 코드*/
					column : 'erpDivSeq',
					type : 'text',
					display : NO,
				}, {
					title : '${CL.ex_paymentKindCd}',/*결제수단 코드*/
					column : 'setFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_taxDivCd}', /*과세구분 코드*/
					column : 'vatFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_creditorTypeCode}', /*채주유형 코드*/
					column : 'trFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erplinkConsKey} ',/*ERP 연동 품의서 키*/
					column : 'erpBqSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL. ex_erplinkConsAmtKey} ',/*ERP 연동 품의 예산 키*/
					column : 'erpBkSeq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget1Nm}',/*관 명칭*/
					column : 'erpBgt1Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget1Cd}',/*관 코드*/
					column : 'erpBgt1Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget2Nm}', /*항 명칭*/
					column : 'erpBgt2Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget2Cd}',/*항 코드*/
					column : 'erpBgt2Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget3Nm} ',/*목 명칭*/
					column : 'erpBgt3Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget3Cd}', /*목 코드*/
					column : 'erpBgt3Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget4Nm} ',/*세 명칭*/
					column : 'erpBgt4Name',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_budget4Cd}',/*세 코드*/
					column : 'erpBgt4Seq',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erpBudgetAmt}', /*ERP 예산 편성 금액*/
					column : 'erpOpenAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erpExecutionMoney} ',/*ERP 집행액*/
					column : 'erpApplyAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_erpBalance} ',/*ERP 잔액*/
					column : 'erpLeftAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_purPrice} ',/*공급가액*/
					column : 'budgetStdAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '${CL.ex_vat} ',/*부가세*/
					column : 'budgetTaxAmt',
					type : 'readonly',
					display : NO
				}, {
					title : '미사용? 코드',
					column : 'ctlFgCode',
					type : 'readonly',
					display : NO
				}, {
					title : '미사용? 명칭',
					column : 'ctlFgName',
					type : 'readonly',
					display : NO
				} ]
			}
		};

	/* 결제수단[setFg] ( 예금 : 1 / 현금 : 2 / 외상 : 3 / 신용카드 : 4 ) */
	/* 과세구분[vatFg] ( 과세 : 1 / 면세 : 2 / 기타 : 3 / (iU) 불공제 : 4) */
	/* 채주유형[trFg] ( 거래처등록 : 1 / 사원등록 : 2 / 거래처명 : 3 / 기타소득자 : 4 / 급여 : 5 / 사업소득자 : 6 ) */

    /* 	## window unload 	##
    *	양식 수정정보 임시저장 문서의 경우 INTER갱신 이벤트 호출
    * ====================================================================================================================================================== */
    $( window ).unload(function() {
    	/* ${param.newConsDocSeq} -- 재기안 문서의 경우  */
    	/* approKey -- 이전단계 기능 수행 문서의 경우 */
    	var devMode = false;
    	if(!devMode){
	    	optionSet.resDocInfo = optionSet.resDocInfo || { resDocSeq : '${param.resDocSeq}' };
	    	var isRefreshInter = (!!'${param.newResDocSeq}') || (!!approKey);
	    	if( isRefreshInter ){
				$.ajax({
					type : 'post',
					url : domain + '/expend/np/user/res/UpdateResInterlock.do',
					datatype : 'json',
					async : false,
					data : {
						resDocSeq : optionSet.resDocInfo.resDocSeq
						, formSeq : optionSet.formInfo.formSeq
						, formDTp : optionSet.formInfo.formDTp
						, processId : optionSet.formInfo.formDTp
					},
					success : function(result) {

					},
					error : function(result) {
						console.error(result);
					}
				});
	    	}
    	}
   	});


	/* ## ready ## */
	/* ====================================================================================================================================================== */
	$(document).ready(function() {
		Option.Common.SetResize();
		fnInit();
		fnEventInit();
		if (resCustomProcess && gntpResFormType.hasOwnProperty(formType)) { // 백상휘 수정.
			switch (formType) {
				case gntpResFormType.EXNPRESCONU:
					optionSet.consDocSeq = {"consDocSeq": consDocSeq};
					setDocReady = Option.Common.CheckDraftInfo(optionSet.consDocSeq);
					break;
				case gntpResFormType.EXNPRESCUSTOM:
					optionSet.resDocInfo = {"resDocSeq": resDocSeq};
					setDocReady = Option.Common.CheckDraftInfo(optionSet.resDocInfo);
					break;
				default:
					alert("결재 체크 오류.");
			}
		} else {
			setDocReady = Option.Common.CheckDraftInfo(optionSet.resDocInfo);
		}
		checkDocStatus = setDocReady.hasDraftInfo;
		if((setDocReady.aaData.length || 0) > 0){
			resetBudgetSize = setDocReady.aaData.length;
		}

		/* 결의정보 조회 처리 */
		if ((approKey || '') !== '' && resCustomProcess === false) {
			approvalBack = !approvalBack;
			fnResSelect(); /* 결의정보 조회 및 반영 */
			fnResAllInfo(); /* 결의문서 금액 갱신 ( 자동계산 처라 ) */
			Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
			approvalBack = !approvalBack;
		} else if('' != '${param.newResDocSeq}'){
			/* 재기안 */
			var isReRes = true;
			approvalBack = !approvalBack;
			fnResSelectForReRes(); /* 결의정보 조회 및 반영 */
			fnResAllInfo(); /* 결의문서 금액 갱신 ( 자동계산 처라 ) */
			Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
			approvalBack = !approvalBack;
		} else if( ('${param.tripDocSeq}' != '') && ('${param.resDocSeq}' != '') ){
        	/* 출장 결의 내용 수정 */
        	approvalBack = !approvalBack;
        	fnResSelect(); /* 품의서 정보 조회 및 반영 */
        	fnResAllInfo(); /* 품의서 전체 정보를 기준으로 자동계산 금액 반영 */
        	Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
		} else if( ( ('${param.tripDocSeq}' != '') && ('${param.confferDocSeq}' != '') )
				|| ( resCustomProcess ) )
		{
        	/* 결의정보 add */
			// $('#btnResAdd').click();
			// fnTableFocus($('#resTbl'), $('#resTbl').dzt('getUID'), 'docuFgName');
			// var param = { consDocSeq : '${param.confferDocSeq}' };
			// var param = optionSet.consDocSeq // optionSet.consDocSeq 는 객체입니다.
			let param = {};
			if (resCustomProcess) { // TODO : 백상휘 수정.
				param.consDocSeq = String(optionSet.hasOwnProperty("consDocSeq") ? optionSet.consDocSeq.consDocSeq : '');
				param.resDocSeq = String(optionSet.hasOwnProperty("resDocSeq") ? optionSet.resDocSeq.resDocSeq : '');
			} else {
				param.consDocSeq = '${param.confferDocSeq}';
			}
			
			if (formType === gntpResFormType.EXNPRESCUSTOM) {
				fnCallbackConfferGNTP(param);
			} else {
        		fnCallbackConffer(param);
        	}
		}
		else {
			/* 결의정보 add */
			$('#btnResAdd').click();
			fnTableFocus($('#resTbl'), $('#resTbl').dzt('getUID'), 'docuFgName');
		}
		setTimeout(function(){
			$('#resTblAutoComplete').offset({top: $('.inpTextBox').offset().top + 20, left:$('.inpTextBox').offset().left-1});
			$('#resTblAutoComplete').css('width', $('.inpTextBox').parents('td:first').css('width'))
		}, 500);

		resetBudgetSize = 0;
		/* 카드 / 세금계산서 버튼 표시 처리 */
		fnOtherInterfaceBtnReset();

        /********************************************************************
						2차 외부 시스템 연동 (출장 복명)
		*********************************************************************/
		if( (	!!optionSet.formInfo.formDTp2)
				&& (
						((optionSet.formInfo.formDTp2 == 'EXNPTRIPCONI') || (optionSet.formInfo.formDTp2 == 'EXNPTRIPRESI') )
						||
						((optionSet.formInfo.formDTp2 == 'EXNPTRIPCONU') || (optionSet.formInfo.formDTp2 == 'EXNPTRIPRESU') )
					)
			){
			/* 결재 작성 버튼 삭제 */
			$('#btnApproval').remove();

			/* 출장복명 이전단계 버튼 */
			$('#btnTripInfo').show().click(function (){
				fnAdvBtnActionTripSave();
			});
		}

		Option.Common.SetResize();
		
		$(".pop_wrap").show();
	});

    /* ## 출장복명 작성완료 버튼 기능 구현 ## */
    /* ====================================================================================================================================================== */
    function fnAdvBtnActionTripSave(){
    	var callbackData = {
    		'tripResDocSeq' : '${tripDocSeq}'
    		, 'resDocSeq' : optionSet.resDocInfo.resDocSeq
    		, 'mgtAaData' : $('#resTbl').dzt('getValueAll')
       		, 'budgetAaData' : $('#resTbl').dzt('getValueAll')
    	};
    	console.log(callbackData);

    	// 콜백 함수 호출
    	typeof opener['fnResDocPopCallback'](callbackData);
    	this.close();
    }

	/* ## init ## */
	/* ====================================================================================================================================================== */
	function fnInit() {
		
		//CustomPStoPurchase_code
		<c:if test="${conclusionPaymentDocInfo != null}">
		$("#payType").val("${conclusionPaymentDocInfo.pay_type}");
		$("#payCnt").val("${conclusionPaymentDocInfo.pay_cnt}");
		</c:if>		

		// TODO : 백상휘 수정.
		// if (resCustomProcess && consDocSeq === 'none') {
		if (formType === gntpResFormType.EXNPRESCUSTOM && consDocSeq == 'none') {
			approKey = '';
		}

		if('' != '${param.newResDocSeq}'){
			/* [CASE 1. ] 지출 결의서 재기안. */
			console.log(' [EXNP new docu case 1. ] resolution redraft. ');

			resDocSeq = '${param.newResDocSeq}';
			optionSet.resDocInfo = {'resDocSeq' : resDocSeq};
			$('#h1_resDocTitle').html($('#h1_resDocTitle').text() + ' / ' + resDocSeq);
			/* 문서 기수 정보 출력 */
			fnShowGisuInfo();

		} else if ((approKey || '') != '') {
			/* [CASE 3. ] 일반 결의서 데이터 수정 */
			console.log(' [EXNP new docu case 3. ] resolution info change ');

			/* 수정 모드일 경우 approKey를 통하여 resDocSeq 처리 */
			var approKeyArray = [];
			approKeyArray = (approKey || '').split('_');
			if (approKeyArray.length === 3) {
				/* [0] formDTp ( 양식 상세 구분 ) */
				/* [1] NP ( 영리 비영리 구분 ) */
				/* [2] resDocSeq ( 결의문서 시퀀스 ) */
				resDocSeq = approKeyArray[2].toString();
				optionSet.resDocInfo = optionSet.resDocInfo || { resDocSeq : resDocSeq };
				$('#h1_resDocTitle').html($('#h1_resDocTitle').text() + ' / ' + resDocSeq);

				/* 문서 기수 정보 출력 */
				fnShowGisuInfo();
			} else {
				alert('문서작성에 필요한 정보가 전달되지 않았습니다.\r\n더 이상 진행할 수 없습니다.');
			}
		} else if(  ('${param.tripDocSeq}' != '') && ('${param.resDocSeq}' != '')  ){

			/* [CASE 4. ] 출장 결의서 내용 수성. */
			console.log(' [EXNP new docu case 4. ] trip doc info change. ');

			resDocSeq = '${param.resDocSeq}';
			optionSet.resDocInfo = {'resDocSeq' : resDocSeq};
			$('#h1_consDocTitle').html($('#h1_consDocTitle').text() + ' / ' + resDocSeq);

			/* 문서 기수 정보 출력 */
			fnShowGisuInfo();

		} else if((approKey || '') === '' && '' == '${param.newResDocSeq}'){

			/* [CASE 2. ] 지출결의서 신규 생성. */
			console.log(' [EXNP new docu case 2. ] new resolution. ');
			fnResDocInsert();

		}

		/* 조건 1. 작성자의 ERP 사원정보 및 조직도 정보를 ${CL.ex_check}할 수 없는 경우 작성 불가. */
		optionSet.erpEmpInfo = optionSet.erpEmpInfo || {erpDivSeq : ''}
		if (optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ICUBE' && (optionSet.erpEmpInfo.erpDivSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 회계단위 ${CL.ex_check} ## */
			alert('작성자의 회계단위 정보를 ${CL.ex_check}할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}
		if (optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ERPIU' && (optionSet.erpEmpInfo.erpPcSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 회계단위 ${CL.ex_check} ## */
			alert('작성자의 회계단위 정보를 ${CL.ex_check}할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}
		if ((optionSet.erpEmpInfo.erpDeptSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 부서 ${CL.ex_check} ## */
			alert('작성자의 부서 정보를 ${CL.ex_check}할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}
		if ((optionSet.erpEmpInfo.erpEmpSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 사원번호 ${CL.ex_check} ## */
			alert('작성자의 사원번호 정보를 ${CL.ex_check}할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}

		/* [I] erpDivName : optionSet.erpEmpInfo.erpDivName >> 회계단위 명 */
		/* [U]  >> 회계단위 명 */
		/* element : lbErpDivName */
		var erpDivName = (optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ICUBE' ? (optionSet.erpEmpInfo.erpDivName || '') : (optionSet.erpEmpInfo.erpPcName || ''));
		$('#lbErpDivName').val(erpDivName);

		/* [I] erpDivSeq >> optionSet.erpEmpInfo.erpDivSeq 회계단위 코드 */
		/* [U]  >> 회계단위 코드 */
		/* element : lbErpDivName.attr('seq') */
		var erpDivSeq = (optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ICUBE' ? (optionSet.erpEmpInfo.erpDivSeq || '') : (optionSet.erpEmpInfo.erpPcSeq || ''));
		$('#lbErpDivName').attr('seq', erpDivSeq);

		/* [I] erpDeptName >> optionSet.erpEmpInfo.erpDeptName 사용부서 명 */
		/* [U]  >> 사용부서 명 */
		/* element : lbErpDeptName */
		var erpDeptName = (optionSet.erpEmpInfo.erpDeptName || '');
		$('#lbErpDeptName').empty();
		$('#lbErpDeptName').html(erpDeptName);

		/* [I] erpDeptSeq >> optionSet.erpEmpInfo.erpDeptSeq 사용부서 코드 */
		/* >> 사용부서 코드 */
		/* element : lbErpDeptName.attr('seq') */
		var erpDeptSeq = (optionSet.erpEmpInfo.erpDeptSeq || '');
		$('#lbErpDeptName').attr('seq', erpDeptSeq);

		/* [I] erpEmpName >> optionSet.erpEmpInfo.erpEmpName 사원 명 */
		/* [U] >> 사원 명 */
		/* element : lbErpEmpName */
		var erpEmpName = (optionSet.erpEmpInfo.erpEmpName || '');
		$('#lbErpEmpName').empty();
		$('#lbErpEmpName').html(erpEmpName);

		/* [I] erpEmpSeq >> optionSet.erpEmpInfo.erpEmpSeq 사원 코드 */
		/* [U] >> 사원 코드 */
		/* element : lbErpEmpSeq */
		var erpEmpSeq = (optionSet.erpEmpInfo.erpEmpSeq || '');
		$('#lbErpEmpSeq').empty();
		$('#lbErpEmpSeq').html(erpEmpSeq);

		/* 결의정보 테이블 그리기 */
		var resColumns = (resGrid[Option.Common.GetErpType()].columns || []);
		$('#resTbl').dzt({
			/* 테이블 컬럼 제목 */
			title : Option.Common.GetArray(resColumns, 'title', ''),
			/* 테이블 컬럼 표시 */
			display : Option.Common.GetArray(resColumns, 'display', NO),
			/* 테이블 컬럼 너비 */
			width : Option.Common.GetArray(resColumns, 'width', ''),
			/* 테이블 컬럼 필수 입력 */
			req : Option.Common.GetArray(resColumns, 'req', NO),
			/* 테이블 기본 높이 지정 */
			height : '135px',
			/* 데이터 변경 시 콜백 ( edit ) */
			changeCallback : function(uid, key) {
				/* [ parameter ] */
				/*   - uid : 행 고유 ID */
				/*   - key : 현재 컬럼 ID */

				/* 예산체크 */
				Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);

				/* 현재 행 정보 조회 */
				var resData = $('#resTbl').dzt('getValue');


				if('itemAmt'==key){
					if(!!resData.resDocSeq && !!resData.resSeq){
						fnEventItemSpecPop();
					}
					else{
						alert("결의정보를 입력해주세요");
					}
					return false;
				}


				/* 연결된 예산내역 정보 조회 */
				if ((resData.resSeq || '') !== '') {
					fnBudgetSelect(resData.resDocSeq, resData.resSeq);
					/* 결제내역 바인딩 */
					var budgetData = $('#budgetTbl').dzt('getValue');
					console.log('call fnTradeSelect case 2.');
					fnTradeSelect(budgetData.resDocSeq, budgetData.resSeq, budgetData.budgetSeq);
				}

				/* 예산내역 input 제거 */
				if ($('#budgetTbl').dzt('getValueAll').length > 0) {
					$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#budgetTooltip').html(''); /* 툴팁제거 */
				}

				/* 결제내역 input 제거 */
				if ($('#tradeTbl').dzt('getValueAll').length > 0) {
					$('#tradeTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#tradeTooltip').html(''); /* 툴팁제거 */
				}

				if(confferFlag > 0 || useFavorites > 0){
					confferFlag -= 1;
					useFavorites -= 1;
					return false;
				}

				/* 기 저장된 경우에는 사용자 알림 처리 후 데이터 삭제 진행 */
				if ((resData.resSeq || '') !== '') {
					if (Option.Common.ERPiU()) {
						/* 결의구분 */
						// 'docuFgName'
						var tradeResetTarget = [ 'erpMgtName'];
						var traderReserName = [ '프로젝트' ];

						if (tradeResetTarget.indexOf(key) > -1) {
							//var msg = '예산내역이 존재하여, 결의정보 내역을 수정할 수 없습니다.';
							//alert(msg);
							//return false;

							if(!!optionSet.confferInfo){
								alert('품의참조된 결의서는 '+traderReserName[tradeResetTarget.indexOf(key)]+'를 변경할 수 없습니다.');
								$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return false;
							}

							var msg = traderReserName[tradeResetTarget.indexOf(key)] + ' 변경 시 예산내역 & 결제내역이 초기화됩니다. 계속 진행하시겠습니까?';
							if ((checkDocStatus || "N") == "Y"){
								var msg = traderReserName[tradeResetTarget.indexOf(key)] + ' 변경 시 예산내역 & 결제내역이 초기화되며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
							}
							if (!approvalBack && confirm(msg)) {
								/* 하위 예산내역 모두 조회 */
								var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
								/* 예산내역 삭제 진행 */
								$.each(budgetDataArray, function(idx, item) {
									fnEventBudgetDelete(item.resDocSeq, item.resSeq, item.budgetSeq);
								});
								/* 기초행 생성 */
								$('#btnBudgetAdd').click();
								$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
								$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return true;
							} else {
								$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return false;
							}
						}
					} else if (Option.Common.iCUBE()) {
						if(key == 'resDate'){
							console.log('발의일자 선택');
							// return;
						}


						/* 결의구분 */
						// 'docuFgName' '결의구분'
						var tradeResetTarget = [ 'erpMgtName'];
						var traderReserName = [ '프로젝트' ];

						if (tradeResetTarget.indexOf(key) > -1) {
							//var msg = '예산내역이 존재하여, 결의정보 내역을 수정할 수 없습니다.';
							//alert(msg);
							//return false;

							if(!!optionSet.confferInfo){
								alert('품의참조된 결의서는 '+traderReserName[tradeResetTarget.indexOf(key)]+'를 변경할 수 없습니다.');
								$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return false;
							}
							var msg = traderReserName[tradeResetTarget.indexOf(key)] + ' 변경 시 예산내역 & 결제내역이 초기화됩니다. 계속 진행하시겠습니까?';
							if ((checkDocStatus || "N") == "Y"){
								var msg = traderReserName[tradeResetTarget.indexOf(key)] + ' 변경 시 예산내역 & 결제내역이 초기화되며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
							}

							if (!approvalBack && confirm(msg)) {
								/* 하위 예산내역 모두 조회 */
								var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
								/* 예산내역 삭제 진행 */
								$.each(budgetDataArray, function(idx, item) {
									fnEventBudgetDelete(item.resDocSeq, item.resSeq, item.budgetSeq);
								});
								/* 기초행 생성 */
								$('#btnBudgetAdd').click();
								$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
								$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return true;
							} else {
								$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return false;
							}
						}
					}
				} else {
					if ((resData.resSeq || '') != '') {
						/* 결제내역 테이블 초기화 */
						$('#tradeTbl').dzt('setReset');

						/* 예산내역 테이블 초기화 */
						$('#budgetTbl').dzt('setReset');

						/* 기초행 생성 */
						$('#btnBudgetAdd').click();

						/* 현재행의 uid 조회 */
						var uid = $('#resTbl').dzt('getUID');

						/* 결의서 시퀀스 반영 ( resSeq ) */
						$('#resTbl').dzt('setValue', uid, {
							resSeq : (resData.resSeq || '').toString()
						}, false);
					} else {
						/* 결제내역 테이블 초기화 */
						$('#tradeTbl').dzt('setReset');

						/* 예산내역 테이블 초기화 */
						$('#budgetTbl').dzt('setReset');
					}
				}

				return true;
			},
			/* 데이터 변경 후 콜백 ( commit ) */
			commitCallback : function(uid, key) {
				/* 현재 행 정보 조회 */
				/* callback 기초 데이터 */
				var resData = $('#resTbl').dzt('getValue');
				var budgetData = $('#budgetTbl').dzt('getValue');

				/* 데이터 업데이트 */
				if ((resData.resSeq || '') !== '') {
					if (Option.Common.ERPiU()) {
						/* ERPiU 처리 */
						fnResUpdate();
					} else if (Option.Common.iCUBE()) {
						/* iCUBE 처리 */
						fnResUpdate();
					}
				}


				/* 결의 일자 검증 진행 */
				if( Option.Common.iCUBE() && ( key == 'resDate' )){

					/* 결의 정보 데이터 보정 */
					if(resData.resDate.replace(/[0-9]/g, '') == '--'){
						var year = parseInt(resData.resDate.split('-')[0] || '1' ) ;
						var month = parseInt(resData.resDate.split('-')[1] || '1' ) ;
						var day = parseInt(resData.resDate.split('-')[2] || '1' ) ;
						year = year < 10 ? '0' + year : '' + year;
						month = month < 10 ? '0' + month : '' + month;
						day = day < 10 ? '0' + day : '' + day;
						resData.resDate = year + '-' + month + '-' + day;
					}


					var date = resData.resDate.replace(/-/gi, '');
					if( ( date < optionSet.erpGisu.fromDate ) || (date > optionSet.erpGisu.toDate)){
						/* erp 기수 정보 재조회 */
						$.ajax({
							type : 'post',
							/*   - url : /ex/np/user/cons/ConsDocInsert.do */
							url : domain + '/expend/np/admin/code/ExProcDataSelect.do',
							datatype : 'json',
							async : false,
							data : {
								procType : 'commonGisuInfo'
								, erpCompSeq : optionSet.erpEmpInfo.erpCompSeq
								, erpType : optionSet.conVo.erpTypeCode
								, baseDate : date.replace(/-/gi, '')
							},
							success : function(result) {
								if(result.result.resultCode == 'SUCCESS'){
									var item = result.result.aaData[0];
									optionSet.erpGisu.gisu = item.gisu;
									optionSet.erpGisu.fromDate = item.fromDate;
									optionSet.erpGisu.toDate = item.toDate;

									var tempData = {};
									tempData.gisu = item.gisu;
									tempData.erpGisu = item.gisu;
									tempData.erpGisuFromDate = item.fromDate;
									tempData.erpGisuToDate = item.toDate;
									tempData.erpExpendYear = item.fromDate.substring(0,4);
									tempData.erpYear = item.fromDate.substring(0,4);

									var uid = $('#resTbl').dzt('getUID');
									$('#resTbl').dzt('setValue', uid, tempData, false);

									fnShowGisuInfo();
								}else{
									alert('기수 정보 조회 실패');
								}
							},
							error : function(result) {
								console.error(result);
							}
						});
					}
				}

				/* 예산체크 */
				Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);
				// Option.Common.SetFocusAmtUpdate();
			},
			/* 테이블 컬럼 정보 */
			columns : resColumns,
			/* datepicker 옵션 적용 */
			configDatepicker: function(input, uid, key){
				if( (!!optionSet.confferInfo) && (!!optionSet.confferInfo.consDocSeq) ){
					if(key === 'resDate') {
						if (Option.Common.iCUBE()) {
							$(input).datepicker('option', 'minDate', optionSet.erpGisu.fromDate.replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3'));
							$(input).datepicker('option', 'maxDate', optionSet.erpGisu.toDate.replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3'));
							return input;
						}
					}
				}

				return input;
			},
			configDatepickerClose: function(input, uid, key){
				if(key === 'resDate') {
					$('#resTbl').dzt('setValue', uid, {resDate : input.value}, false);
					var resData = $('#resTbl').dzt('getValue');
					if ((resData.resSeq || '') !== '') {
						if (Option.Common.iCUBE()) {
							/* iCUBE 처리 */
							setTimeout(function(){fnResUpdate();}, 500);
						}
					}
				}
			}
		});

		/* 예산내역 테이블 그리기 */
		var budgetColumns = (budgetGrid[Option.Common.GetErpType()].columns || []);
		$('#budgetTbl').dzt({
			title : Option.Common.GetArray(budgetColumns, 'title', ''),
			display : Option.Common.GetArray(budgetColumns, 'display', NO),
			width : Option.Common.GetArray(budgetColumns, 'width', ''),
			req : Option.Common.GetArray(budgetColumns, 'req', NO),
			height : '135px',
			changeCallback : function(uid, key) {
				/* 예산체크 */
				Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);

				/* 현재 행 정보 조회 */
				var budgetData = $('#budgetTbl').dzt('getValue');
				var resData = $('#resTbl').dzt('getValue');

				/* 연결된 예산내역 정보 조회 */
				if ((budgetData.budgetSeq || '') !== '') {
					console.log('call fnTradeSelect case 1.');
					fnInitTradeTbl();
					fnTradeSelect(budgetData.resDocSeq, budgetData.resSeq, budgetData.budgetSeq);
				} else {
					/* 결제내역 테이블 초기화 */
					$('#tradeTbl').dzt('setReset');
				}

				/* 결의정보 input 제거 */
				if ($('#resTbl').dzt('getValueAll').length > 0) {
					$('#resTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#resTooltip').html(''); /* 툴팁제거 */
				}

				/* 결제내역 input 제거 */
				if ($('#tradeTbl').dzt('getValueAll').length > 0) {
					$('#tradeTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#tradeTooltip').html(''); /* 툴팁제거 */
				}

				/* 카드 내역 버튼 활성화 */
				/* 카드 / 세금계산서 버튼 표시 처리 */
				if(budgetData.trFgCode == '4' || budgetData.trFgCode == '9'){
					$('#btnTradeCard').hide();
					$('#btnTradeETax').hide();
				} else{

					setTimeout(fnOtherInterfaceBtnReset, 300);
				}


				if('itemAmt'==key){
					if(!!budgetData.resDocSeq && !!budgetData.resSeq && !!budgetData.budgetSeq){
						fnEventItemSpecPop();
					}
					else{
						alert("예산정보를 입력해주세요");
					}
					return false;
				}

				if(key=='erpBudgetName' && !!budgetData.confferDocSeq ){
					return false;
				}


				/* 기 저장된 경우에는 사용자 알림 처리 후 데이터 삭제 진행 */
				if (($('#tradeTbl').dzt('getValueAll').map(function(item) {
					return (item.tradeSeq || '')
				}).join('')) !== '') {
					if ((budgetData.budgetSeq || '') !== '') {
						/* 예산단위, 사업계획, 예산계정, 결제수단, 과세구분, 채주유형 */
						var tradeResetTarget = [];
						var traderReserName = [];
						if (Option.Common.ERPiU()) {
							tradeResetTarget = [ 'erpBudgetName', 'erpBizplanName', 'erpBgacctName', 'setFgName', 'vatFgName', 'trFgName' ];
							traderReserName = [ '예산단위', '사업계획', '예산계정', '결제수단', '과세구분', '채주유형' ];
						}
						if (Option.Common.iCUBE()) {
							tradeResetTarget = [ 'erpBudgetName', 'setFgName', 'vatFgName', 'trFgName', 'erpDivName' ];
							traderReserName = [ '예산과목', '결제수단', '과세구분', '채주유형', '회계단위' ];
						}

						if (tradeResetTarget.indexOf(key) > -1) {
							//var msg = '결제내역이 존재하여, 예산내역을 수정할 수 없습니다.';
							//alert(msg);
							//return false;

							var msg = traderReserName[tradeResetTarget.indexOf(key)] + ' 변경 시 결제내역이 초기화됩니다. 계속 진행하시겠습니까?';
							if ((checkDocStatus || "N") == "Y"){
								var msg = traderReserName[tradeResetTarget.indexOf(key)] + ' 변경 시 결제내역이 초기화되며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
							}
							if (!approvalBack && confirm(msg)) {
								/* 하위 결제내역 모두 조회 */
								var tradeDataArray = $('#tradeTbl').dzt('getValueAll');
								/* 결제내역 삭제 진행 */
								$.each(tradeDataArray, function(idx, item) {
									fnEventTradeDelete(item.resDocSeq, item.resSeq, item.budgetSeq, item.tradeSeq);
								});
								/* 기초행 생성 */
								$('#btnTradeAdd').click();
								$('#tradeTbl').dzt('setCommit', false); /* 그리드 input 제거 */
								$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return true;
							} else {
								return false;
							}
						}
					}
				} else {

				}

				return true;
			},
			commitCallback : function(uid, key) {
				if(  !(uid || key)  ){
					return;
				}

				/* callback 기초 데이터 */
				var resData = $('#resTbl').dzt('getValue');
				var budgetData = $('#budgetTbl').dzt('getValue');
				var tradeData = $('#tradeTbl').dzt('getValue');

				/* 상배 : 임시 성능 수정 비고에서만 저장 진행 */
				/* 채주 정보 변경 처리 */
				var trFgChangeKey = [ 'setFgName', 'vatFgName', 'trFgName' ];
				if (trFgChangeKey.indexOf(key) > -1) {
					if ((budgetData.setFgCode || '') !== '' && (budgetData.vatFgCode || '') !== '') {
						$.fn.dzt.options['budgetTbl'].columns[trFgNameIndex].combobox.data = Option[Option.Common.GetErpType()].GetTrFg((budgetData.setFgCode || ''), (budgetData.vatFgCode || ''));
					}

					/* 저장된 trade 정보 삭제 */
					$.each($('#tradeTbl').dzt('getValueAll'), function(tradeIdx, tradeItem) {
						fnEventTradeDelete(tradeItem.resDocSeq, tradeItem.resSeq, tradeItem.budgetSeq, tradeItem.tradeSeq);
					});

					/* tradeTbl 생성 */
					fnInitTradeTbl();
				}

				if(budgetData.trFgCode == '4' || budgetData.trFgCode == '9'){
					$('#btnTradeCard').hide();
					$('#btnTradeETax').hide();
				} else{
					setTimeout(fnOtherInterfaceBtnReset, 300);
				}


				/* 데이터 업데이트 */
				if (fnBudgetChkValue().sts === true && (budgetData.budgetSeq || budgetData.bgacctSeq || '') !== '') {
					if (Option.Common.ERPiU()) {
						/* ERPiU 처리 */
						fnBudgetUpdate(key);
					} else if (Option.Common.iCUBE()) {
						/* iCUBE 처리 */
						fnBudgetUpdate(key);
					}
				}

				/* 예산체크 */
				if (key === 'erpBudgetName' || key === 'erpBgacctName') {
					Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);
				}

				/* 채주 정보 변경 처리 */
				var trFgChangeKey = [ 'setFgName', 'vatFgName', 'trFgName' ];
				if (trFgChangeKey.indexOf(key) > -1) {
					if ((budgetData.setFgCode || '') !== '' && (budgetData.vatFgCode || '') !== '') {
						$.fn.dzt.options['budgetTbl'].columns[trFgNameIndex].combobox.data = Option[Option.Common.GetErpType()].GetTrFg((budgetData.setFgCode || ''), (budgetData.vatFgCode || ''));
						/* tradeTbl 생성 */
						fnInitTradeTbl();
					}
				}



				/* 채주 정보 변경에 따른 결제내역 초기화 */
				var tradeTblChangeKey = [ 'setFgName', 'vatFgName', 'trFgName' ];

				if (tradeTblChangeKey.indexOf(key) > -1) {
					if ((budgetData.setFgCode || '') !== '' && (budgetData.vatFgCode || '') !== '' && (budgetData.trFgCode || '') !== '' && (budgetData.tradeChange || 'Y') === 'N' && (budgetData.budgetSeq || '') !== '') {
						/* tradeTbl 초기화 */
						$('#tradeTbl').dzt('setTableRemove');

						/* 저장된 trade 정보 삭제 */
						$.each($('#tradeTbl').dzt('getValueAll'), function(tradeIdx, tradeItem) {
							fnEventTradeDelete(tradeItem.resDocSeq, tradeItem.resSeq, tradeItem.budgetSeq, tradeItem.tradeSeq);
						});

						/* tradeTbl 생성 */
						fnInitTradeTbl();

						/* tradeTbl 기초 행 생성 */
						var tradeDetaultValue = {
							resDocSeq : budgetData.resDocSeq,
							resSeq : budgetData.resSeq,
							budgetSeq : budgetData.budgetSeq,
							tradeChange : 'Y'
						};
						$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('setAddRow'), tradeDetaultValue); /* 행 추가 */
						$('#tradeTbl').dzt('setCommit', false); /* 그리드 input 제거 */
						$('#tradeTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					}


				}

			},
			columns : budgetColumns
		});

		/* 채주유형 index 정의 */
		$.each(budgetColumns, function(idx, item) {
			if (item.column === 'trFgName') {
				trFgNameIndex = idx;
				return false;
			}
		});
		trFgNameIndex = (trFgNameIndex || 0);

		/* 결제내역 테이블 그리기 */
		fnInitTradeTbl();

		/* 팝업위치 설정 */
		fnLayerResize();
		$(window).resize(function() {
			fnLayerResize();
		});

		return;
	}

	function fnLayerResize() {
		var pwd_head_Hei = $(".pop_auto_hei > .pop_head").height();
		var pwd_foot_Hei = $(".pop_auto_hei > .pop_foot").height();
		var pwd_con_Hei = $(".pop_auto_hei > .pop_con").height();

		$(".pop_auto_hei > .pop_con").css("overflow-y", "auto");
		if ($(".pop_auto_hei > .pop_con").height() >= $(window).height() - pwd_head_Hei - pwd_foot_Hei - 200) {
			$(".pop_auto_hei > .pop_con").css("height", $(window).height() - pwd_head_Hei - pwd_foot_Hei - 200);
		} else {
			$(".pop_auto_hei > .pop_con").css("height", "auto");
		}

		for (i = 0; i <= $(".pop_wrap2").size(); i++) {
			var popWid = $(".pop_wrap_dir").eq(i).outerWidth();
			var popHei = $(".pop_wrap_dir").eq(i).outerHeight();
			$(".pop_wrap_dir").eq(i).css("top", "50%").css("left", "50%").css("marginLeft", -popWid / 2).css("marginTop", -popHei / 2);

			var popWid2 = $(".pop_auto_hei").eq(i).outerWidth();
			var popHei2 = $(".pop_auto_hei").eq(i).outerHeight();
			$(".pop_auto_hei").eq(i).css("top", "50%").css("left", "50%").css("marginLeft", -popWid2 / 2).css("marginTop", -popHei2 / 2);
		}
	}

	/* 결제내역 테이블 그리기 - 테이블의 입력 정보가 동적으로 변하기 때문에 별도 분리 개발 */
	function fnInitTradeTbl() {
		/* 결제내역 테이블 그리기 */
		var tradeColumns = Option[Option.Common.GetErpType()].GetTradeColumns()
		$('#tradeTbl').dzt({
			title : Option.Common.GetArray(tradeColumns, 'title', ''),
			display : Option.Common.GetArray(tradeColumns, 'display', NO),
			width : Option.Common.GetArray(tradeColumns, 'width', ''),
			req : Option.Common.GetArray(tradeColumns, 'req', NO),
			height : '135px',
			changeCallback : function(uid, key) {
				/* 결의정보 input 제거 */
				if ($('#resTbl').dzt('getValueAll').length > 0) {
					$('#resTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#resTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#resTooltip').html(''); /* 툴팁제거 */
				}

				/* 예산내역 input 제거 */
				if ($('#budgetTbl').dzt('getValueAll').length > 0) {
					$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#budgetTooltip').html(''); /* 툴팁제거 */
				}
				var tradeData = $('#tradeTbl').dzt('getValue');
				var budgetData = $('#budgetTbl').dzt('getValue');



				/* [+] 카드승인내역(CMS)사용 예외 처리  */
				/*
					1. 법인카드 승인내역이 아니면 해다 로직 진입하지 않음.
					2. 법인카드 승인내역은 이 구역내에서 모든 케이스에 대한 return이 이루어 져야함.
				*/
				if( ( (budgetData.setFgCode || '') == '4' ) && ( tradeData.interfaceType == 'card' )){
					var modifyKey = ['trName','tradeNote','ceoName','btrName','baNb','depositor','noTaxName','regDate'];
					if((optionSet.gw[3][18]||{setValue:'0'}).setValue=='1'){
						modifyKey = ['trName','tradeNote','ceoName','noTaxName','regDate'];
					}
					if((budgetData.vatFgCode || '') =='3' && optionSet.loginVo.groupSeq != 'CJ' ){
						modifyKey.push('tradeAmt');
						modifyKey.push('tradeStdAmt');
						modifyKey.push('tradeVatAmt');
					}
					if( modifyKey.indexOf(key) > -1 ){
						return true;
					}else{
						return false;
					}
				}
				/* [-] 카드승인내역(CMS)사용 예외 처리  */

				/* [+] 세금계산서 사용 예외 처리  */
				if( ( (budgetData.setFgCode || '') != '4' ) && ( tradeData.interfaceType == 'etax') ){
					var modifyKey = ['trName','tradeNote','ceoName','btrName','baNb','depositor','noTaxName','regDate'];
					if( (optionSet.gw[3][18]||{setValue:'0'}).setValue=='1'){
						modifyKey = ['trName','tradeNote','ceoName','noTaxName','regDate'];
					}
					if((budgetData.vatFgCode || '') =='3' && optionSet.loginVo.groupSeq != 'CJ'){
						modifyKey.push('tradeAmt');
						modifyKey.push('tradeStdAmt');
						modifyKey.push('tradeVatAmt');
					}
					if( modifyKey.indexOf(key) > -1 ){
						return true;
					}else{
						return false;
					}
				}
				/* [-] 세금계산서 사용 예외 처리  */


				/* [+] 기타소득자 & 사업소득자 처리 */
				if ( ['tradeAmt', 'tradeStdAmt', 'tradeVatAmt'].indexOf(key) > -1) {
					if (($('#budgetTbl').dzt('getValue').trFgCode || '') === '4') {
						/* 기타소득자 처리 */
						if(Option.Common.iCUBE()){
							fnSetHpMetic();
							return false;
						}
						else if(Option.Common.ERPiU()){
							fnSetHpMetic();
							return false;
						}
					} else if (($('#budgetTbl').dzt('getValue').trFgCode || '') === '9') {
						/* iCUBE G20 사업 소득자 처리 (사업소득자 팝업) */
						if(Option.Common.ERPiU()){
							fnSetHpMetic();
							return false;
						}

						/* iCUBE G20 사업 소득자 처리 (사업소득자 팝업) */
						if(Option.Common.iCUBE()){
							fnSetBizMetic();
							return false;
						}
					}
				}
				/* [-] 기타소득자 & 사업소득자 처리 */

				/* [+] 급여 입력 처리 */
				if ( ['tradeAmt', 'tradeStdAmt', 'tradeVatAmt'].indexOf(key) > -1) {
					if (($('#budgetTbl').dzt('getValue').trFgCode || '') === '8') {
						/* 급여 입력 팝업 처리 */
						if(Option.Common.iCUBE()){
							fnSetSalary();
							return false;
						}
					}
				}
				/* [-] 급여 입력 처리 */

				if((optionSet.gw[3][18]||{setValue:'0'}).setValue=='1'){
					modifyKey = ['trName','tradeNote','tradeAmt','tradeStdAmt','tradeVatAmt','noTaxName','regDate'];

					if( modifyKey.indexOf(key) > -1 ){
						return true;
					}else{
						return false;
					}

				}

				return true;
			},
			commitCallback : function(uid, key) {
				/* callback 기초 데이터 */
				var resData = $('#resTbl').dzt('getValue');
				var budgetData = $('#budgetTbl').dzt('getValue');
				var tradeData = $('#tradeTbl').dzt('getValue');



				/* 금액 재계산 */
				var tradeAmtKey = [ 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt' ];
				if (tradeAmtKey.indexOf(key) > -1 && (tradeData.interfaceType || '') === '') {
					/* 과세구분 */
					var vatFgCode = (budgetData.vatFgCode || '');
					var trFgCode = (budgetData.trFgCode || '');

					if(!optionSet.gw['1']['6']){
						optionSet.gw['1']['6'] = {'setValue' : '0'};
					}

					/* 과세 구분 기타 자동입력 미사용 */
					if( (optionSet.gw['1']['6'].setValue == '0') && ( vatFgCode === '3' ) ){
						var tradeAmt = Number((tradeData.tradeAmt || '0').toString().replace(/,/g, ''));
						var tradeStdAmt = Number((tradeData.tradeStdAmt || '0').toString().replace(/,/g, ''));
						var tradeVatAmt = Number((tradeData.tradeVatAmt || '0').toString().replace(/,/g, ''));

						/* 사업소득자 / 기타소득자의 경우 무시 */
						if(['4','9'].indexOf(('' + trFgCode)) == -1){
							if(key == 'tradeAmt'){
								tradeStdAmt = tradeAmt;
								tradeVatAmt = tradeAmt - tradeStdAmt;
							} else if(key == 'tradeStdAmt'){
								tradeVatAmt = tradeAmt - tradeStdAmt;
							} else if(key == 'tradeVatAmt'){
								tradeStdAmt = tradeAmt - tradeVatAmt;
							}
						}
						/* 금액 반영 */
						var resultValue = {
							tradeStdAmt : Option.Common.GetNumeric(tradeStdAmt),
							tradeVatAmt : Option.Common.GetNumeric(tradeVatAmt),
							tradeAmt : Option.Common.GetNumeric(tradeAmt),
							beforeTradeAmt : Option.Common.GetNumeric(tradeAmt)
						};
						$('#tradeTbl').dzt('setValue', uid, resultValue, false);
					} else if( (optionSet.gw['1']['6'].setValue == '1') && ( vatFgCode === '3' ) ){
						var tradeAmt = Number((tradeData.tradeAmt || '0').toString().replace(/,/g, ''));
						var tradeStdAmt = Number((tradeData.tradeStdAmt || '0').toString().replace(/,/g, ''));
						var tradeVatAmt = Number((tradeData.tradeVatAmt || '0').toString().replace(/,/g, ''));

						/* 금액 반영 */
						var resultValue = {
							tradeStdAmt : Option.Common.GetNumeric(tradeStdAmt),
							tradeVatAmt : Option.Common.GetNumeric(tradeVatAmt),
							tradeAmt : Option.Common.GetNumeric(tradeAmt),
							beforeTradeAmt : Option.Common.GetNumeric(tradeAmt)
						};
						$('#tradeTbl').dzt('setValue', uid, resultValue, false);
					} else if(optionSet.gw['1']['6'].setValue == '0'){
						/* 금액 */
						var beforeTradeAmt = Number((tradeData.beforeTradeAmt || '0').toString().replace(/,/g, ''));
						var tradeAmt = Number((tradeData.tradeAmt || '0').toString().replace(/,/g, ''));
						var tradeStdAmt = Number((tradeData.tradeStdAmt || '0').toString().replace(/,/g, ''));
						var tradeVatAmt = Number((tradeData.tradeVatAmt || '0').toString().replace(/,/g, ''));

						if (vatFgCode === '2') {
							/* 면세의 경우 */
							if (key === 'tradeAmt') {
								tradeStdAmt = tradeAmt;
								tradeAmt = tradeAmt;
							} else if (key !== 'tradeAmt') {
								tradeStdAmt = tradeStdAmt;
								tradeAmt = tradeStdAmt;
							} else {
								tradeStdAmt = 0;
								tradeAmt = 0;
							}
							tradeVatAmt = 0;
						} else {
							/* 면세가 아닐경우 */
							if(vatFgCode == '1'){
								if (key === 'tradeAmt') {
									tradeAmt = tradeAmt;
									tradeStdAmt = Option.Common.GetCalcAmt(tradeAmt, 'amt2std', 'floor');
									tradeVatAmt = Option.Common.GetCalcAmt(tradeAmt, 'amt2vat', 'ceil');
								} else if (key !== 'tradeAmt') {
									tradeStdAmt = tradeStdAmt;
									tradeVatAmt = tradeVatAmt;
									tradeAmt = tradeStdAmt + tradeVatAmt;
								}
							}
							else{
								if(vatFgCode=='3' && (trFgCode =='1' || trFgCode =='2' || trFgCode =='3')){
									if (key === 'tradeAmt') {
										tradeAmt = tradeAmt;
										tradeStdAmt = tradeAmt;
									} else if (key !== 'tradeAmt') {
										tradeStdAmt = tradeAmt;
										tradeAmt = tradeAmt;
									}
								}
								else if(vatFgCode=='3' && trFgCode =='9'){
									if (key === 'tradeAmt') {
										tradeAmt = tradeAmt;
										tradeVatAmt =  Math.floor(tradeAmt*0.03) + Math.floor(tradeAmt*0.003);
										tradeStdAmt =  tradeAmt-tradeVatAmt;
									} else if (key !== 'tradeAmt') {
										tradeStdAmt = tradeStdAmt;
										tradeVatAmt = tradeVatAmt;
										tradeAmt = tradeStdAmt + tradeVatAmt;
									}
								}
								else if(vatFgCode=='3' && trFgCode =='4'){
									if (key !== 'tradeAmt') {
										tradeStdAmt = tradeStdAmt;
										tradeVatAmt = tradeVatAmt;
										tradeAmt = tradeStdAmt + tradeVatAmt;
									}
								}
							}
						}

						/* 금액 반영 */
						var resultValue = {
							tradeStdAmt : Option.Common.GetNumeric(tradeStdAmt),
							tradeVatAmt : Option.Common.GetNumeric(tradeVatAmt),
							tradeAmt : Option.Common.GetNumeric(tradeAmt),
							beforeTradeAmt : Option.Common.GetNumeric(tradeAmt)
						};
						$('#tradeTbl').dzt('setValue', uid, resultValue, false);

						/* 예산체크 */
						if (beforeTradeAmt !== tradeAmt) {
							Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);
						}
					}
					else {
						/* 기타 - 기타소득자의 경우 자동계산 처리 안함. */
						if ( !(vatFgCode == 3 || trFgCode == 4 )) {
							/* 금액 */
							var beforeTradeAmt = Number((tradeData.beforeTradeAmt || '0').toString().replace(/,/g, ''));
							var tradeAmt = Number((tradeData.tradeAmt || '0').toString().replace(/,/g, ''));
							var tradeStdAmt = Number((tradeData.tradeStdAmt || '0').toString().replace(/,/g, ''));
							var tradeVatAmt = Number((tradeData.tradeVatAmt || '0').toString().replace(/,/g, ''));

							if (vatFgCode === '2') {
								/* 면세의 경우 */
								if (key === 'tradeAmt') {
									tradeStdAmt = tradeAmt;
									tradeAmt = tradeAmt;
								} else if (key !== 'tradeAmt') {
									tradeStdAmt = tradeStdAmt;
									tradeAmt = tradeStdAmt;
								} else {
									tradeStdAmt = 0;
									tradeAmt = 0;
								}
								tradeVatAmt = 0;
							} else {
								/* 면세/기타가 아닐 경우 */
								if (key === 'tradeAmt') {
									tradeAmt = tradeAmt;
									tradeStdAmt = Option.Common.GetCalcAmt(tradeAmt, 'amt2std', 'floor');
									tradeVatAmt = Option.Common.GetCalcAmt(tradeAmt, 'amt2vat', 'ceil');
								} else if (key !== 'tradeAmt') {
									tradeStdAmt = tradeStdAmt;
									tradeVatAmt = tradeVatAmt;
									tradeAmt = tradeStdAmt + tradeVatAmt;
								}
							}

							/* 금액 반영 */
							var resultValue = {
								tradeStdAmt : Option.Common.GetNumeric(tradeStdAmt),
								tradeVatAmt : Option.Common.GetNumeric(tradeVatAmt),
								tradeAmt : Option.Common.GetNumeric(tradeAmt),
								beforeTradeAmt : Option.Common.GetNumeric(tradeAmt)
							};
							$('#tradeTbl').dzt('setValue', uid, resultValue, false);

							/* 예산체크 */
							if (beforeTradeAmt !== tradeAmt) {
								Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);
							}
						}
					}
				}
				else if((tradeData.interfaceType || '') != ''){
					var reqChkTrade = fnTradeChkValue();
					if(!reqChkTrade.sts){
						/* 미입력 항목 포커스 지정 */
						var uid = $('#tradeTbl').dzt('getUID');
						$('#tradeTbl').dzt('setFocus', uid, reqChkTrade.key);
						/* 사용자 알림 처리 */
						alert(reqChkTrade.msg);
					}
				}

				/* 데이터 업데이트 */

				if (fnTradeChkValue().sts && (tradeData.tradeSeq || '') !== '') {
					if (Option.Common.ERPiU()) {
						/* ERPiU 처리 */
						fnTradeUpdate(key);
					} else if (Option.Common.iCUBE()) {
						/* iCUBE 처리 */
						fnTradeUpdate(key);
					}
				}
				else{

				}

				// Option.Common.SetFocusAmtUpdate();
			},
			columns : tradeColumns
		});

		Option.Common.SetTradeTblResize();
	}
	
	function msgSnackbar(type, msg, callback){
		Pudd.puddSnackBar({
			 
			type	: type		// success, error, warning, info
		,	message : msg
		,	duration : 3000			// 1초 = 1000
			// snackbar show 완료 후 callback
		,	showDoneCallback : function() {
				if(callback != ""){
					eval(callback);
				}
			}
		});			
	}	

	/* ## event init ## */
	/* ====================================================================================================================================================== */
	function fnEventInit() {
		/* 미사용 버튼 미표현 처리 */
		$('#btnResUp').hide(); /* 결의정보 위 */
		$('#btnResDown').hide(); /* 결의정보 아래 */
		$('#btnResRefer').hide(); /* 지난결의서 */
		$('#btnBudgetUp').hide(); /* 예산내역 위 */
		$('#btnBudgetDown').hide(); /* 예산내역 아래 */
		$('#btnTradeUp').hide(); /* 결제내역 위 */
		$('#btnTradeDown').hide(); /* 결제내역 아래 */

		/* 결의서 */
		$('#btnApproval').click(function() {
			
			var reqParam = {};
			
			reqParam.resDocSeq = resDocSeq;
			reqParam.payType = $('#payType').val();
			reqParam.payCnt = $('#payCnt').val();
			reqParam.tryAmt = 0;
			
			$.each($('#resTbl').dzt('getValueAll'), function( idx, resDocInfo ) {
				reqParam.tryAmt += parseInt(resDocInfo.amt.replaceAll(",",""));
			});				
			
			//중복 지급구분/차수 체크 및 결의 금액 초과여부 체크
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/ConclutionPaymentDocInfoCheck.do" />',
				datatype : 'json',
				data : reqParam,
				async : true,
				success : function(result) {
					
					if(result.resultCode == "SUCCESS"){
						
						try{
							$('#tradeTbl').dzt('setCommit', true);
							var _tradeData = $('#tradeTbl').dzt('getValue');
							if ((_tradeData.insertStat || 'SUCCESS') != 'SUCCESS') {
								return;
							}

							fnEventApprovalPrevCheck();
							
						}
						catch(e){
							console.log(e);
						}						
						
					}else if(result.resultCode == "FAIL_DUPLICATE"){
						msgSnackbar("error", "지급구분/차수 중복건이 존재합니다.");
					}else if(result.resultCode == "FAIL_RES_AMT_OVER"){
						msgSnackbar("error", "신청 가능한 결의금액이 초과되었습니다.");
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "데이터 요청에 실패했습니다.");
				}
			});			

		});

		/* 결의정보 버튼 이벤트 연결 */
		$('#btnConsRefer').click(function() {
			fnEventConsRefer();
		});
		$('#btnResRefer').click(function() {
			fnEventResRefer();
		});
		$('#btnResReset').click(function() {
			fnEventResReset();
		});
		$('#btnResAdd').click(function() {
			fnEventResAdd();
		});
		$('#btnResDelete').click(function() {
			var msg = '${CL.ex_delInfoNotRecoveredMessage}';
			if ((checkDocStatus || "N") == "Y"){
				var msg = '삭제된 정보는 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
			}
			if (confirm(msg)) {
				fnEventResDelete();
			}
		});
		$('#btnResUp').click(function() {
			fnEventResUp();
		});
		$('#btnResDown').click(function() {
			fnEventResDown();
		});
		$('#btnBringFavorites').click(function() {
			fnEvenBringFavorites();
		});

		/* 예산내역 버튼 이벤트 연결 */
		$('#btnBudgetAdd').click(function() {
			fnEventBudgetAdd();
		});
		$('#btnBudgetDelete').click(function() {
			var msg = '${CL.ex_delInfoNotRecoveredMessage}';
			if ((checkDocStatus || "N") == "Y"){
				var msg = '삭제된 정보는 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
			}
			if (confirm(msg)) {
				fnEventBudgetDelete();
			}
		});
		$('#btnBudgetReset').click(function() {
			fnEventBudgetReset();
		});
		$('#btnBudgetUp').click(function() {
			fnEventBudgetUp();
		});
		$('#btnBudgetDown').click(function() {
			fnEventBudgetDown();
		});

		/* 결제내역 버튼 이벤트 연결 */
		$('#btnTradeReset').click(function() {
			fnEventTradeReset();
		});
		$('#btnTradeCard').click(function() {
			fnEventTradeCard();
		});
		$('#btnTradeETax').click(function() {
			fnEventTradeETax();
		});
		$('#btnTradeAdd').click(function() {
			fnEventTradeAdd();
		});
		$('#btnTradeDelete').click(function() {
			var msg = '${CL.ex_delInfoNotRecoveredMessage}';
			if ((checkDocStatus || "N") == "Y"){
				var msg = '삭제된 정보는 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
			}
			if (confirm(msg)) {
				fnEventTradeDelete();
				if($('#tradeTbl').dzt('getValueAll').length > 0) {
					$('#tradeTbl').dzt('setDefaultFocus', 'LAST');
				}
			}
		});
		$('#btnTradeUp').click(function() {
			fnEventTradeUp();
		});
		$('#btnTradeDown').click(function() {
			fnEventTradeDown();
		});

		/* 예산 회계딴위 변경 */
		$('#btnErpDivChoice').click(function() {
			if(optionSet.customOption && optionSet.customOption["CUST_001"]){
				if ($('#resTbl').dzt('getValueAll').filter(function(item) {
					return ((item.resSeq || '') != '')
				}).length && Option.Common.ERPiU()) {
					alert('결의 정보가 입력되면 회계단위를 변경할 수 없습니다.');
					return;
				}
			}

			if ($('#resTbl').dzt('getValueAll').filter(function(item) {
				return ((item.resSeq || '') != '')
			}).length) {
				alert('결의 정보가 입력되면 회계단위를 변경할 수 없습니다.');
				return;
			}

			/* 상배 추가 */
			code = 'div';
			param = {
				isBudgetDiv : true
			};
			fnCommonCode_div(code, param);
			return;
		});

		/* 사업소득자 */
		$('#layerBizMetic').hide();
		$('#divModal').hide();
		$('#btnBizLayerOk').click(function() {
			/* 입력 누락 ${CL.ex_check} */
			/* 입력 항목 반영 */
			fnSetBizMetic_Callback();
			/* 창 닫기 */
			$('#btnBizLayerCancel').click();
		});
		$('#btnBizClose').click(function() {
			$('#btnBizLayerCancel').click();
		});
		$('#btnBizLayerCancel').click(function() {
			/* 창닫기 - 입력 내용 무시 */
			$('#layerBizMetic').hide();
			$('#divModal').hide();
		});

		/* 기타소득자 */
		$('#layerHpMetic').hide();
		$('#divModal').hide();
		$('#btnLayerOk').click(function() {
			/* 입력 누락 ${CL.ex_check} */
			/* 입력 항목 반영 */
			if(Option.Common.ERPiU()){
				var budgetInfo = $('#budgetTbl').dzt('getValue');
				if(!$('#txtERPiUCdPc').val()){
					alert("귀속사업장코드를 선택하여 주십시오.");
					return;
				}
				if(!$('#txtERPiUNmPc').val()){
					alert("귀속사업장명을 입력하여 주십시오.");
					return;
				}
				if( budgetInfo.trFgCode =='4' && !$('#txtERPiUIncomeGbnCode').val() && !$('#txtERPiUIncomeGbnName').val() ){
					alert("소득구분을 선택하여 주십시오.");
					return;
				}
				if($('#txtERPiUTotalAmt').val() == '0'){
					alert("지급금액을 입력하여 주십시오.");
					return;
				}
				if($('#txtERPiUHPPayDate').val() == ''){w
					alert("지급일자를 입력하여 주십시오.");
					return;
				}
				if($('#txtERPiUHPPayDateYearMonth').val() == ''){
					alert("귀속년월을 입력하여 주십시오.");
					return;
				}
			}
			fnSetHpMetic_Callback();

			/* 창 닫기 */
			$('#btnLayerCancel').click();
		});
		$('#btnClose').click(function() {
			$('#btnLayerCancel').click();
		});
		$('#btnLayerCancel').click(function() {
			/* 창닫기 - 입력 내용 무시 */
			$('#layerHpMetic').hide();
			$('#divModal').hide();
		});

		/* 급여 입력 레이어 팝업 */
		$('#layerSalary').hide();
		$('#divModal').hide();
		$('#btnSalaryLayerOk').click(function() {
			/* 입력 누락 ${CL.ex_check} */
			/* 입력 항목 반영 */
			fnSetSalary_Callback();
			/* 창 닫기 */
			$('#btnSalaryClose').click();
		});
		$('#btnSalaryClose').click(function() {
			$('#btnSalaryLayerCancel').click();
		});
		$('#btnSalaryLayerCancel').click(function() {
			/* 창닫기 - 입력 내용 무시 */
			$('#layerSalary').hide();
			$('#divModal').hide();
		});

		/* 소득구분 조회 팝업 */
		/* [상배] 기타소득자 필요경비율 고도화 */
		if (Option.Common.iCUBE()) {
			$('#btnEtcIncome').click(function() {
				fnCommonCode('income', 'income', '', {}, {}, {});
			});
		} else if (Option.Common.ERPiU()){
			$('#btnERPiUDiv').click(function() {
				fnCommonCode('biz', 'biz', '', {}, {}, {});
			});
			$('#btnEtcIncome').click(function() {
				fnCommonCode('incomegbn', 'incomegbn', '', {}, {}, {});
			});
		}

		/* 사업소득자 소득구분 조회 팝업 */
		if (Option.Common.iCUBE()) {
			$('#btnBizIncome').click(function() {
				fnCommonCode('income', 'income', '', {}, {}, {});
			});
		}

		$('#txtEtcIncomeName').keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '113' || keyCode.toString() === '13') {
				fnCommonCode('income', 'income', '', {}, {}, {});
			}
		});
		return;
	}

	/* ## event ## */
	/* ====================================================================================================================================================== */
	/* ## event - 회계단위 선택 ## */
	function fnEvntPcSelect() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## 공통코드 - 회계단위(기타소득자) ============================== ## */
	function fnCommonCode_div2(code, param) {
		code = 'div';
		param.callback = 'fnCommonCode_div2_callback';
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	function fnCommonCode_div2_callback(param){
		if (Option.Common.ERPiU()) {
			// 회계단위 코드 (CD_PC)
			$('#txtERPiUCdPc').val(param.CD_PC);
			// 회계단위 명칭 (NM_PC)
			$('#txtERPiUNmPc').val(param.NM_PC);
		}

		return;
	}

	/* ## 공통코드 - 사업장(IU) ============================== ## */
	function fnCommonCode_biz(code, param) {
		code = 'biz';
		param.callback = 'fnCommonCode_biz_callback';
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	function fnCommonCode_biz_callback(param){
		if (Option.Common.ERPiU()) {
			// 회계단위 코드 (ERPBIZSEQ)
			$('#txtERPiUCdPc').val(param.ERPBIZSEQ);
			// 회계단위 명칭 (BIZ_NM)
			$('#txtERPiUNmPc').val(param.ERPBIZNAME);
		}

		return;
	}

	/* ## 공통코드 - 회계단위 ============================== ## */
	function fnCommonCode_div(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});

		/* 예산회계단위의 경우 다른 콜백 함수 사용 */
		if (!param.isBudgetDiv) {
			param.callback = 'fnCommonCode_div_callback';
		} else if (param.isBudgetDiv) {
			param.callback = 'fnCommonCode_budgetDiv_callback';
		}
		/* 팝업 호출 */
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	/* 예산 회계단위 조회 콜백 */
	function fnCommonCode_budgetDiv_callback(param) {
        if (Option.Common.iCUBE()) {
            optionSet.erpEmpInfo.erpDivSeq = (param.divSeq || '');
            optionSet.erpEmpInfo.erpDivName = (param.divName || '');
            optionSet.erpEmpInfo.vatControl = (param.vatControl || '');
        }
        else if (Option.Common.ERPiU()) {
            optionSet.erpEmpInfo.erpDivSeq = (param.CD_PC || '');
            optionSet.erpEmpInfo.erpDivName = (param.NM_PC || '');
            optionSet.erpEmpInfo.erpPcSeq = (param.CD_PC || '');
            optionSet.erpEmpInfo.erpPcName = (param.NM_PC || '');
        }
        $('#lbErpDivName').val(optionSet.erpEmpInfo.erpDivName);
        $('#lbErpDivName').attr('seq', optionSet.erpEmpInfo.erpDivSeq);

		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResDocUpdate.do',
			datatype : 'json',
			async : false,
			data : {
				resDocSeq : resDocSeq,
				empSeq : optionSet.loginVo.empSeq,
            	erpDivSeq : optionSet.erpEmpInfo.erpDivSeq,
            	erpDivName : optionSet.erpEmpInfo.erpDivName,
            	erpPcSeq : optionSet.erpEmpInfo.erpDivSeq,
            	erpPcName : optionSet.erpEmpInfo.erpDivName,
            	formSeq : optionSet.formInfo.formSeq,
				outProcessInterfaceId : '${outProcessInterfaceId}',
				outProcessInterfaceMId : '${outProcessInterfaceMId}',
				outProcessInterfaceDId : '${outProcessInterfaceDId}'
			},
			success : function(result) {
				// TODO:
			}
		});
	}

	/* 예산 회계단위 조회 콜백 */
	function fnCopyInterlock() {
		$.ajax({
			type : 'post',
			url : domain + '/expend/np/user/res/CopyInterlock.do',
			datatype : 'json',
			async : false,
			data : {
				empSeq : optionSet.loginVo.empSeq,
				formSeq : optionSet.formInfo.formSeq
			},
			success : function(result) {
			}
		});
	}

	function fnEventApprovalPrevCheck() {
		/* [ parameter ] */
		var parameter = {};

		parameter.resDocSeq = resDocSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/res/ResDocAllinfo.do */
			url : domain + '/ex/np/user/res/ResDocAllinfo.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq(결의문서 시퀀스) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				preDocSeq = result.result.aData.resDocInfo[0].docSeq;
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);


				if (resultCode === 'SUCCESS') {
					var docInfo = aData.resDocInfo;
					var headInfo = aData.resHeadInfo;
					var budgetInfo = aData.budgetInfo;
					var tradeInfo = aData.tradeInfo;

					var tradeValue  = $('#tradeTbl').dzt('getValueAll');
					var budgetValue = $('#budgetTbl').dzt('getValueAll');
					var headValue  = $('#resTbl').dzt('getValueAll');

					var special_pattern = /[\']/gi;

					if(docInfo[0].compSeq!=aData.loginCompInfo){
						alert('작성 도중 회사 정보가 변경되어 재작성이 필요합니다.');
						return;
					}

					if(tradeInfo.length < 1){
						alert('입력되지 않은 결제내역이 있습니다.');
						return;
					}


					for(var i =0; i<headValue.length; i++){
						/*적요 특수문자 체크*/
						if(special_pattern.test(headValue[i].resNote)){
							alert('적요는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
							return ;
						}
					}

					for(var i =0; i<tradeValue.length; i++){
						if (tradeValue[i].tradeNote.length > 79) {
							alert('${CL.ex_note3}는 80자 이내로 작성가능합니다.');
							return;
						}

						/*비고(채주) 특수문자 체크*/
						if(special_pattern.test(tradeValue[i].tradeNote)){
							alert('${CL.ex_note3}는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
							return ;
						}

						/* 예금주 입력 글자수 제한 */
						if( ( tradeValue[i].depositor || '' ).length > 30){
							alert("예금주 입력은 최대 30자 제한입니다.");
							return;
						}

						/* 대표자명 입력 글자수 제한 */
						if( ( tradeValue[i].ceoName || '' ).length > 30){
							alert("대표자명 입력은 최대 30자 제한입니다.");
							return;
						}

						if(!!(tradeValue[i].tradeNote||'').match(/_[0-9a-zA-Z]+_/gi)){
							alert(tradeValue[i].tradeNote + '문자는 사용할 수 없습니다.');
							return;
						}
					}

					for(var i =0; i<budgetValue.length; i++){
						if(!!(budgetValue[i].budgetNote||'').match(/_[0-9a-zA-Z]+_/gi)){
							alert(budgetValue[i].budgetNote + '문자는 사용할 수 없습니다.');
							return;
						}

						/*비고(예산) 특수문자 체크*/
						if(special_pattern.test(budgetValue[i].budgetNote)){
							alert('${CL.ex_note2}는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
							return ;
						}
					}

					if( (optionSet.gw[3][13]||{'setValue':'0'}).setValue == '0' ){
						var j=0;
						var btrCheck = 0;
						for(var i=0; i<headInfo.length ; i++){
							for(; j<budgetInfo.length ; j++){
								if(headInfo[i].resSeq != budgetInfo[j].resSeq){
									break;
								}
								if(budgetInfo[j].setFgCode =='1' && headInfo[i].btrSeq ==''){
									btrCheck = 1;
								}
							}
						}
						if(btrCheck){
							alert("결제수단이 예금일때 입출금계좌는 필수입력항목입니다.");
							return;
						}
					}

					if( (optionSet.gw[3][20]||{'setValue':'1'}).setValue == '1' ){
						for(var i=0; i<tradeInfo.length ; i++) {
							if (tradeInfo[i].tradeStdAmt == '0') {
								alert("공급가액 0원을 허용하지 않습니다.");
								return;
							}
						}
					}


					/* Step 1. 입력 누락 ${CL.ex_check} [간단] */
					var inputValidationChecker = docInfo.length * headInfo.length * budgetInfo.length;
					if (!inputValidationChecker) {
						alert('데이터 입력을 ${CL.ex_check}하세요.');
						return;
					}

					/* Step 2. 입력 누락 ${CL.ex_check} [결재정보] */
					var tradeValueAll = $('#tradeTbl').dzt('getValueAll');
					for(var i = 0; i < tradeValueAll.length; i++ ){
						var item = tradeValueAll[i];
						if( ( !item.tradeSeq ) && (!!item.trName) ){
							if( !!item.trName && !!item.tradeAmt && !!item.tradeStdAmt && !!item.tradeVatAmt && (Option.Common.GetErpType() === 'ERPiU'?item.businessNb:'1') ){
								fnTableFocus($('#tradeTbl'), item.uid, 'trName');
								fnTradeInsert();
							}
							else{
								alert('입력이 완료되지 않은 결재정보가 있습니다.');
								return;
							}
						}

						if(Option.Common.GetErpType() === 'ERPiU' && (optionSet.gw[3][15]||{'setValue':'0'}).setValue == '0' && item.setFgName == '예금' ){
							if(item.regDate == ''){
								alert("결제수단이 예금일때 신고기준일 필수입력항목입니다.");
								return;
							}
						}
					}

					/* Step 3. 입력 누락 ${CL.ex_check} [예산정보] */
					if(optionSet.conVo.erpTypeCode == 'iCUBE'){
						var budgetValueAll = $('#budgetTbl').dzt('getValueAll');
						for(var i = 0; i < budgetValueAll.length; i++ ){
							var item = budgetValueAll[i];
							if( ( !item.budgetAmt ) && (!!item.erpBudgetSeq) ){
								alert('입력이 완료되지 않은 예산정보가 있습니다.');
								return;
							}
						}
					}
					fnCopyInterlock();
					fnEventApproval();
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}


	/* ## event - 결재작성 ## */
	function fnEventApproval() {

		/* [ parameter ] */
		var parameter = {};

		parameter.processId = optionSet.formInfo.formDTp;
		parameter.approKey = (approKey || optionSet.formInfo.formDTp + '_NP_' + resDocSeq);
		parameter.resDocSeq = resDocSeq;
		parameter.interlockName = '정보수정';
		// 20180910 soyoung, interlockName 정보수정 영문/일문/중문 추가
		parameter.interlockNameEn = "Edit information";
		parameter.interlockNameJp = "情報修正";
		parameter.interlockNameCn = "信息修改";
		parameter.docSeq = preDocSeq;
		parameter.formSeq = optionSet.formInfo.formSeq;
		parameter.groupSeq = optionSet.loginVo.groupSeq;
		parameter.erpDivSeq = optionSet.erpEmpInfo.erpDivSeq;
		parameter.header = '';
		parameter.content = '';
		parameter.footer = '';
		parameter.reDraftUrl = location.protocol + '//' + location.host + "<c:url value='/ExpendReUsePop.do' />";

		parameter.oriApproKey = '${param.oriApproKey}';
		parameter.oriDocId = '${param.oriDocId}';
		parameter.form_gb = '${param.form_gb}';
		parameter.copyApprovalLine = '${param.copyApprovalLine}';
		parameter.copyAttachFile = '${param.copyAttachFile}';
		parameter.eapCallDomain = ( origin || '' );
		parameter.formType = "RES";
		if(optionSet.conVo.erpTypeCode=='ERPiU'){
			parameter.gisuFromDate = optionSet.erpGisu.gisuFromDate;
			parameter.gisuToDate = optionSet.erpGisu.gisuToDate;
		}

		if (resCustomProcess) { // 백상휘 수정.
			parameter.resCustomProcess = true;
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/interlock/ExDocMake.do */
			url : domain + '/ex/np/user/cons/interlock/ExDocMake.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				if (result != null || result == undefined) {
					fnDocPopOpen(result);
				} else {
					alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
					return;
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}

	function fnDocPopOpen(data) {
		var url = '/';
		url += data.result.eaType;

		if (data.result.eaType == "eap") {
			url += '/ea/interface/eadocpop.do';
		} else if (data.result.eaType == "ea") {
			if('' != '${param.oriApproKey}'){
				url += '/ea/interface/eadocRedraftPop.do';
			} else {
				url += '/ea/interface/eadocpop.do';
			}
		} else {
			alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
			return;
		}


		if (data.result.eaType == "eap") {
			if (data.result.docSeq != '0' && data.result.eaType != '' && data.result.formSeq != '0' && data.result.approKey != '') {
				url = url + '?form_id=' + optionSet.formInfo.formSeq;
				url = url + '&docId=' + data.result.docSeq;
				url = url + '&approKey=' + data.result.approKey;
				url = url + '&processId=' + optionSet.formInfo.formDTp;
			} else {
				alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
				return;
			}
		} else if (data.result.eaType == "ea") {
			if (data.result.docSeq != '-1' && data.result.eaType != '' && data.result.formSeq != '0' && data.result.approKey != '') {
 				if('' != '${param.oriApproKey}'){
					url += '?oriApproKey=${param.oriApproKey}';
					url += '&approKey=' + data.result.approKey;
					url += '&oriDocId=${param.oriDocId}';
					url += '&tiFormGb=${param.form_gb}';
					url += '&form_gb=${param.form_gb}';
					url += '&copyApprovalLine=${param.copyApprovalLine}';
					url += '&copyAttachFile=${param.copyAttachFile}';
				} else {
					// 비영리 결재 template_key 파라미터 사용하지 않음.
					// url += '?template_key=' + optionSet.formInfo.formSeq;
					url += '?form_id=' + optionSet.formInfo.formSeq;
					url += '&docId=' + data.result.docSeq;
					url += '&approKey=' + data.result.approKey;
					url += '&processId=' + optionSet.formInfo.formDTp;
				}
			} else {
				alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
				return;
			}
		}

		var thisX = parseInt(document.body.scrollWidth);
		var thisY = parseInt(document.body.scrollHeight);
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 50;

		if (maxThisX > 1000) {
			maxThisX = 1000;
		}
		var marginY = 0;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if (navigator.userAgent.indexOf("MSIE 6") > 0)
			marginY = 45; // IE 6.x
		else if (navigator.userAgent.indexOf("MSIE 7") > 0)
			marginY = 75; // IE 7.x
		else if (navigator.userAgent.indexOf("Firefox") > 0)
			marginY = 50; // FF
		else if (navigator.userAgent.indexOf("Opera") > 0)
			marginY = 30; // Opera
		else if (navigator.userAgent.indexOf("Netscape") > 0)
			marginY = -2; // Netscape

		if (thisX > maxThisX) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}
		if (thisY > maxThisY - marginY) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}

		// 센터 정렬
		var windowX = (screen.width - (maxThisX + 10)) / 2;
		var windowY = (screen.height - (maxThisY)) / 2 - 20;
		/* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
		/* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
		/* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
		var win = window.open(url, '', "scrollbars=yes,resizable=yes,width=" + maxThisX + ",height=" + (maxThisY - 50) + ",top=" + windowY + ",left=" + windowX);
		if (win == null || win.screenLeft == 0) {
			alert("브라우져 팝업차단 설정을 ${CL.ex_check}해 주세요");
		} else {
			self.close();
		}
	}

	/* ## event - 결의정보 초기화 ## */
	function fnEventResReset() {
		var msg = '${CL.ex_delInfoNotRecoveredMessage}';
		if ((checkDocStatus || "N") == "Y"){
			var msg = '삭제된 정보는 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
		}
		if (confirm(msg)) {
			/* 결의정보 삭제 */
			var resData = $('#resTbl').dzt('getValueAll');
			$.each(resData, function(resIdx, res) {
				fnEventResDelete(res.resDocSeq, res.resSeq);
			});

			/* 결제내역 테이블 초기화 */
			$('#tradeTbl').dzt('setReset');

			/* 예산내역 테이블 초기화 */
			$('#budgetTbl').dzt('setReset');

			/* 결의정보 테이블 초기화 */
			$('#resTbl').dzt('setReset');

			/* 결의정보 기본행 추가 */
			$('#btnResAdd').click();

			/* 예산정보 초기화 */
			$('#lbErpOpenAmt').html('0');
			$('#lbResApplyAmt').html('0');
			$('#lbConsBalanceAmt').html('0');
			$('#lbBudgetAmt').html('0');
			$('#lbGwBalanceAmt').html('0');

			/* 참조품의 데이터가 모두 삭제처리 되므로, 추가 버튼 활성화 */
			$('#btnResReset').show();
			$('#btnResAdd').show();
			$('#btnResDelete').show();
			$('#btnConsRefer').show();
		}

		/* [ return ] */
		return;
	}

	/* ## event - 결의정보 추가 ## */
	function fnEventResAdd(addType) {

		addType = (typeof addType === 'undefined' ? true : addType);

		/* 결의정보 누락 정보 ${CL.ex_check} */
		var reqChkRes = fnResChkValue(addType);

		/* 결의정보 입력 여부 ${CL.ex_check} */
		if (addType && $('#resTbl').dzt('getValueAll').length > 0) {
			/* 예산내역 생성 여부 ${CL.ex_check} */
			var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
			var budgetSeqArray = [];

			budgetDataArray.map(function(item) {
				if ((item.budgetSeq || '') !== '') {
					budgetSeqArray.push(item.budgetSeq);
				}
				return item.budgetSeq;
			});

			if (budgetSeqArray.length === 0) {
				alert('${CL.ex_noBudgetDetailMessage}');
				return;
			}

			/* 결제내역 생성 여부 ${CL.ex_check} */
			var tradeDataArray = $('#tradeTbl').dzt('getValueAll');
			var tradeSeqArray = [];
			tradeDataArray.map(function(item) {
				if ((item.tradeSeq || '') !== '') {
					tradeSeqArray.push(item.tradeSeq);
				}
				return item.tradeSeq;
			});

			if (tradeSeqArray.length === 0) {
				budgetDataArray[0]
				return;
			}
		}

		if (reqChkRes.sts) {
			/* 현재행이 저장되지 않았다면, 저장 진행 */
			if ((($('#resTbl').dzt('getValue') || {}).resSeq || '') === '' && $('#resTbl').dzt('getValueAll').length > 0) {
				fnResInsert();
			}

			/* 행 추가 */
			var uid = fnTableAdd($('#resTbl'));

			/* 기본값 설정 ( resDocSeq ) */
			$('#resTbl').dzt('setValue', uid, {
				resDocSeq : resDocSeq,
				uid : uid
			}, false);

			/* 예산내역 테이블 초기화 */
			$('#budgetTbl').dzt('setReset');

			/* 결제내역 테이블 초기화 */
			$('#tradeTbl').dzt('setReset');

			/* 기본 포커스 지정 */
			if (Option.Common.ERPiU()) {
				/* ERPiU 기본 포커스 정의 */
				fnTableFocus($('#resTbl'), uid, 'docuFgName');
			} else if (Option.Common.iCUBE()) {
				/* iCUBE 기본 포커스 정의 */
				fnTableFocus($('#resTbl'), uid, 'docuFgName');
			}
		} else {
			/* 사용자 알림 표시 */
			alert(reqChkRes.msg);

			/* 포커스 이동 */
			$('#resTbl').dzt('setFocus', $('#resTbl').dzt('getUID'), reqChkRes.key);
		}

		return;
	}

	/* ## event - 결의정보 삭제 ## */
	function fnEventResDelete(resDocSeq, resSeq) {
		/* [ parameter ] */
		/*   - resDocSeq : 삭제 대상 결의문서 키 */
		resDocSeq = (resDocSeq || '');
		/*   - resSeq : 삭제 대상 결의서 키 */
		resSeq = (resSeq || '');

		/* [ ajax parameter ] */
		var parameter = {};

		if (resDocSeq !== '' && resSeq !== '') {
			/* 파라미터 정의 */
			parameter.resDocSeq = resDocSeq;
			parameter.resSeq = resSeq;
		} else {
			/* 현재 행 정보 조회 */
			var resData = $('#resTbl').dzt('getValue');
			/* 파라미터 정의 */
			parameter.resDocSeq = resData.resDocSeq;
			parameter.resSeq = resData.resSeq;
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResHeadDelete.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : parameter.resDocSeq,
			resSeq : parameter.resSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				if (Option.Common.GetResultCode(result) === 'SUCCESS') {
					var resDataArray = $('#resTbl').dzt('getValueAll');
					var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
					var resDocSeq = this.resDocSeq;
					var resSeq = this.resSeq;

					/* 화면상의 결의정보를 삭제한다. */
					$.each(resDataArray, function(resIdx, res) {
						if (res.resDocSeq === resDocSeq && res.resSeq === resSeq) {
							$('#resTbl').dzt('setRemoveRow', $('#resTbl div.rightContents table tr:eq(' + resIdx + ')'));
							return false;
						}
					});

					/* 메인 테이블이므로, 행이 없을경우 기본행 추가 */
					if ($('#resTbl').dzt('getValueAll').length === 0) {
						$('#btnResAdd').click();
					} else {
						/*행이 있는 경우 맨 마지막행의 금액 포커스하여 헤더,예산,채주 업데이트*/
						$('#resTbl').dzt('setDefaultFocusKey', 'LAST', 'amt');
						$('#budgetTbl').dzt('setDefaultFocusKey', 'LAST', 'budgetAmt');
						$('#btnTradeAdd').click();
					}
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}

	/* ## event - 결의정보 위 ## */
	function fnEventResUp() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## event - 결의정보 아래 ## */
	function fnEventResDown() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## event - 예산내역 초기화 ## */
	function fnEventBudgetReset() {
		var msg = '${CL.ex_delInfoNotRecoveredMessage}';
		if ((checkDocStatus || "N") == "Y"){
			var msg = '삭제된 정보는 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
		}
		if (confirm(msg)) {
			/* 예산내역 삭제 */
			var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
			$.each(budgetDataArray, function(budgetIdx, budgetItem) {
				fnEventBudgetDelete(budgetItem.resDocSeq, budgetItem.resSeq, budgetItem.budgetSeq);
			});

			/* 결제내역 테이블 초기화 */
			$('#tradeTbl').dzt('setReset');

			/* 예산내역 테이블 초기화 */
			$('#budgetTbl').dzt('setReset');

			/* 예산내역 기본행 추가 */
			$('#btnBudgetAdd').click();

			/* 예산정보 초기화 */
			$('#lbErpOpenAmt').html('0');
			$('#lbResApplyAmt').html('0');
			$('#lbConsBalanceAmt').html('0');
			$('#lbBudgetAmt').html('0');
			$('#lbGwBalanceAmt').html('0');

			/* 카드, 계산서 버튼 처리 */
			fnOtherInterfaceBtnReset();
		}
	}

	/* ## event - 예산내역 추가 ## */
	function fnEventBudgetAdd(addType) {
		addType = (typeof addType === 'undefined' ? true : addType);

		/* 결의정보 입력 여부 ${CL.ex_check} */
		var resData = $('#resTbl').dzt('getValue');
		if ((resData.resSeq || '') === '') {
			if(Option.Common.ERPiU()){
				if(!!resData.resDate && !!resData.docuFgCode ){
					fnResInsert();
					$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
						erpGisuDt : optionSet.erpGisu.gisu||'',
						erpGisuFromDate : optionSet.erpGisu.fromDate||'',
						erpGisuToDate : optionSet.erpGisu.toDate||''
					});
				}
				else{
					alert('${CL.ex_noInfoMessage2}');
					return;
				}
			}
			else{
				if((optionSet.gw[1][11]||{'setValue':'1'}).setValue == '0' && (resData.resNote || '') === ''){
					alert('적요가 입력되지 않았습니다.');
					return;
				}
				if(!!resData.erpMgtSeq && !!resData.resDate && !!resData.docuFgCode){
					fnResInsert();
					$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
						erpGisuDt : optionSet.erpGisu.gisu||'',
						erpGisuFromDate : optionSet.erpGisu.fromDate||'',
						erpGisuToDate : optionSet.erpGisu.toDate||''
					});
				}
				else{
					alert('${CL.ex_noInfoMessage2}');
					return;
				}
			}
		}

		/* 예산내역 필수값 입력 ${CL.ex_check} */
		var reqChkBudget = fnBudgetChkValue(addType);

		/* 결의정보 입력 여부 ${CL.ex_check} */
		if (addType && $('#budgetTbl').dzt('getValueAll').length > 0) {
			/* 결제내역 생성 여부 ${CL.ex_check} */
			var tradeDataArray = $('#tradeTbl').dzt('getValueAll');
			var tradeSeqArray = [];
			tradeDataArray.map(function(item) {
				if ((item.tradeSeq || '') !== '') {
					tradeSeqArray.push(item.tradeSeq);
				}
				return item.tradeSeq;
			});

			if (tradeSeqArray.length === 0) {
				if (($('#budgetTbl').dzt('getValue').confferBudgetSeq || '') !== '') {
					$('#budgetTbl').dzt('setDefaultFocus', 'LAST');
				} else {
					alert('${CL.ex_noPaymentDetailMessage}');
					return;
				}
			}
		}

		if (reqChkBudget.sts) {
			/* 현재행이 저장되지 않았다면, 저장 진행 */
			if ((($('#budgetTbl').dzt('getValue') || {}).budgetSeq || '') === '' && $('#budgetTbl').dzt('getValueAll').length > 0) {
				fnBudgetInsert();
				$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
					erpGisuDt : optionSet.erpGisu.gisu||'',
					erpGisuFromDate : optionSet.erpGisu.fromDate||'',
					erpGisuToDate : optionSet.erpGisu.toDate||''
				});
			}

			var uid = fnTableAdd($('#budgetTbl'));
			var defaultData = {};
			defaultData.resDocSeq = resDocSeq;
			defaultData.uid = uid;

			if (Option.Common.iCUBE()) {
				defaultData.erpDivSeq = ($('#lbErpDivName').attr('seq') || '');
				defaultData.erpDivName = ($('#lbErpDivName').val() || '');
			}

			defaultData.budgetNote = $('#resTbl').dzt('getValue').resNote;

			/* 기본값 설정 ( resDocSeq ) */
			$('#budgetTbl').dzt('setValue', uid, defaultData, false);

			/* 결제내역 테이블 초기화 */
			$('#tradeTbl').dzt('setReset');

			if (Option.Common.ERPiU()) {
				/* ERPiU 기본 포커스 정의 */
				fnTableFocus($('#budgetTbl'), uid, 'erpBudgetName');
			} else if (Option.Common.iCUBE()) {
				/* iCUBE 기본 포커스 정의 */
				fnTableFocus($('#budgetTbl'), uid, 'erpBudgetName');
			}
		} else {
			/* 사용자 알림 표시 */
			/* 사용자 알림 처리 */
			if ((reqChkBudget.msg || '') !== '') {
				alert(reqChkBudget.msg);
			}

			/* 포커스 이동 */
			$('#budgetTbl').dzt('setFocus', $('#budgetTbl').dzt('getUID'), reqChkBudget.key);
		}

		fnOtherInterfaceBtnReset();

		return;
	}

	/* ## event - 예산내역 삭제 ## */
	function fnEventBudgetDelete(resDocSeq, resSeq, budgetSeq) {
		/* [ parameter ] */
		/*   - resDocSeq : 삭제 대상 결의문서 키 */
		resDocSeq = (resDocSeq || '');
		/*   - resSeq : 삭제 대상 결의서 키 */
		resSeq = (resSeq || '');
		/*   - budgetSeq : 삭제 대상 예산 키 */
		budgetSeq = (budgetSeq || '');

		/* [ ajax parameter ] */
		var parameter = {};

		if (resDocSeq !== '' && resSeq !== '' && budgetSeq !== '') {
			/* 파라미터 정의 */
			parameter.resDocSeq = resDocSeq;
			parameter.resSeq = resSeq;
			parameter.budgetSeq = budgetSeq;
		} else {
			/* 현재 행 정보 조회 */
			var budgetData = $('#budgetTbl').dzt('getValue');
			/* 파라미터 정의 */
			parameter.resDocSeq = budgetData.resDocSeq;
			parameter.resSeq = budgetData.resSeq;
			parameter.budgetSeq = budgetData.budgetSeq;
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResBudgetDelete.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : parameter.resDocSeq,
			resSeq : parameter.resSeq,
			budgetSeq : parameter.budgetSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
					var resDocSeq = this.resDocSeq;
					var resSeq = this.resSeq;
					var budgetSeq = this.budgetSeq;

					$('#lbBudgetAmt').html(Option.Common.GetNumeric(aData.tryAmt || '0'));

					/* 화면상의 예산내역을 삭제한다. */
					$.each(budgetDataArray, function(budgetIdx, budget) {
						if (budget.resDocSeq === resDocSeq && budget.resSeq === resSeq && budget.budgetSeq === budgetSeq) {
							$('#budgetTbl').dzt('setRemoveRow', $('#budgetTbl div.rightContents table tr:eq(' + budgetIdx + ')'));
							return false;
						}
					});

					/* 결제내역은 서버에서 일괄로 삭제되므로, 화면상에서 삭제를 동시에 진행한다. */
					$.each($('#tradeTbl div.rightContents table tr'), function(tradeIdx, trade) {
						$('#tradeTbl').dzt('setRemoveRow', $(trade));
					});

					/* Layer 강제 삭제 */
					$('#budgetTblAutoComplete').hide();

					// Option.Common.SetAmtUpdate(this.resSeq, this.budgetSeq, 0, 0, 0, 0, 'delete');
					Option.Common.SetFocusAmtUpdate();

					// 기본행 선택
					if($('#budgetTbl').dzt('getValueAll').length > 0) {
						$('#budgetTbl').dzt('setDefaultFocusKey', 'FIRST', 'budgetNote');
					}
				} else {
					alert('삭제처리중 판단되지 않은 상태가 ${CL.ex_check}되었습니다. 지속적으로 발생될 경우 관리자에게 문의해주세요.');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## event - 예산내역 위 ## */
	function fnEventBudgetUp() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## event - 예산내역 아래 ## */
	function fnEventBudgetDown() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## event - 결제내역 초기화 ## */
	function fnEventTradeReset() {
		var msg = '${CL.ex_delInfoNotRecoveredMessage}';
		if ((checkDocStatus || "N") == "Y"){
			var msg = '삭제된 정보는 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다. 계속 진행하시겠습니까?';
		}
		if (confirm(msg)) {
			/* 예산내역 삭제 */
			var tradeDataArray = $('#tradeTbl').dzt('getValueAll');
			$.each(tradeDataArray, function(tradeIdx, tradeItem) {
				fnEventTradeDelete(tradeItem.resDocSeq, tradeItem.resSeq, tradeItem.budgetSeq, tradeItem.tradeSeq);
			});

			/* 결제내역 테이블 초기화 */
			$('#tradeTbl').dzt('setReset');

			/* 결제내역 기본행 추가 */
			$('#tradeTbl').click();

			/* 예산정보 갱신 */
			Option[Option.Common.GetErpType()].GetBudgetAmtInfo('tradeAmt');
		}
	}

	/* ## event - 결제내역 카드사용내역 ## */
	function fnEventTradeCard() {

		var budgetData = $('#budgetTbl').dzt('getValue');
		if ((budgetData.budgetSeq || '') !== '') {
			/* 결제내역 마지막 행 선택 */
			$('#tradeTbl').dzt('setDefaultFocus', 'LAST');

			var winHeight = document.body.clientHeight; // 현재창의 높이
			var winWidth = document.body.clientWidth; // 현재창의 너비
			var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
			var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표

			var popX = winX + (winWidth - 908) / 2;
			var popY = winY + (winHeight - 500) / 2;

			/* 결의정보 */
			var resData = $('#resTbl').dzt('getValue');
			/* 예산내역 */
			var budgetData = $('#budgetTbl').dzt('getValue');

			var url = '<c:url value="/expend/np/user/CardUseHistoryPop.do" />';
			url += '?resDocSeq=' + budgetData.resDocSeq;
			url += '&resSeq=' + budgetData.resSeq;
			url += '&budgetSeq=' + budgetData.budgetSeq;
			url += '&callbackName=fnAddInterfaceHistoryCallback';
			url += '&vatFgCode=' + budgetData.vatFgCode;
			url += '&trFgCode=' + budgetData.trFgCode;
			url += '&formSeq=' + optionSet.formInfo.formSeq;


			var pop = window.open(url, "카드 사용내역", "width=960, height=550, left=" + popX + ", top=" + popY);
		} else {
			alert('${CL.ex_noBudgetDetailMessage}');
		}

		return;
	}

	function fnAddInterfaceHistoryCallback(data) {
		/* example : [{"trName":"삼성전자서비스（주）강남센터","trSeq":"","empSeq":"","empName":"","etcCode":"","etcName":"","bizIncomCode":"","bizIncomName":"","ceoName":"","tradeAmt":"25,000","payAmt":0,"tradeStdAmt":"22,727","realPayAmt":0,"tradeVatAmt":"2,273","payTaxAmt":0,"btrName":" 보조금카드","btrSeq":"91000","baNb":"","depositor":"","tradeNote":"","regDate":"2018-04-02","resDocSeq":23,"resSeq":14,"budgetSeq":9,"tradeSeq":0,"businessNb":"","interfaceType":"card","interfaceSeq":81257}] */

		/* 현재 수정중인 예산내역 정보 조회 */
		var resData = $('#resTbl').dzt('getValue');
		var budgetData = $('#budgetTbl').dzt('getValue');

		/* 결제수단, 과세구분, 채주유형 변수 정의 */
		var setFgCode = (budgetData.setFgCode || '1');
		var vatFgCode = (budgetData.vatFgCode || '1');
		var trFgCode = (budgetData.trFgCode || '1');

		/* 지급거래처 사용 결의구분 */
		/* 1.지출결의서 2.공사집행 3.용역 4.구입 8.여비 9.봉급 */
		var payTrDocuFgCodeList = ['1','2','3','4','8','9'];

		/* 입력할 행 존재여부 ${CL.ex_check} */
		var addType = true;
		$.each($('#tradeTbl').dzt('getValueAll'), function(idx, item) {
			if ((item.tradeSeq || '') === '') {
				addType = false;
			}
		});

		if (addType) {
			$('#btnTradeAdd').click(); /* 행 추가  */
		}

		var autoStdAmt = ( optionSet.gw['1']['6'] || {'setValue' : '0'} ).setValue;
		for (var i = 0; i < data.length; i++) {
			var tradeUid = $('#tradeTbl').dzt('getUID');
			var param = {};

			param.trName = (data[i].trName || '');
			param.cardNum = (data[i].cardNum || '');
			param.trSeq = (data[i].trSeq || "");
			param.businessNb = (data[i].businessNb || '').trim();
			param.ceoName = (data[i].ceoName || '');
			param.tradeAmt = (data[i].tradeAmt || 0);

			if($('#budgetTbl').dzt('getValue').vatFgCode == '3'){
				param.tradeStdAmt = Number(autoStdAmt)?0:(data[i].tradeStdAmt || 0);
				param.tradeVatAmt = Number(autoStdAmt)?0:(data[i].tradeVatAmt || 0);
			}else{
				param.tradeStdAmt = (data[i].tradeStdAmt || 0);
				param.tradeVatAmt = (data[i].tradeVatAmt || 0);
			}
			if( payTrDocuFgCodeList.indexOf(resData.docuFgCode)!=-1  ){
				if( trFgCode=='1' || trFgCode =='3' ){
					param.payTrName = (data[i].payTrName || '');
					param.payTrSeq = (data[i].payTrSeq || '');
				}
			}

			param.btrName = (data[i].btrName || '');
			param.btrSeq = (data[i].btrSeq || "");
			param.baNb = (data[i].baNb || '');
			param.depositor = (data[i].depositor || '');
			param.a = (data[i].cardName || ''); // 지훈
			param.tradeNote = (data[i].tradeNote || '');
			param.regDate = (data[i].regDate || '');
			param.interfaceSeq = (data[i].interfaceSeq || 0);
			param.interfaceType = (data[i].interfaceType || '');
			param.resSeq = (data[i].resSeq || '');
			param.budgetSeq = (data[i].budgetSeq || '');
			param.tradeSeq = (data[i].tradeSeq || '');
			param.ctrName = (data[i].ctrName || '');
			param.ctrSeq = (data[i].ctrSeq || '');
			param.noTaxName = (data[i].noTaxName || '');
			param.noTaxCode = (data[i].noTaxCode || '');
			param.addr = (data[i].addr || '');


			if(optionSet.conVo.erpTypeCode == 'ERPiU'){
				/* [IU] 과세유형 [3.기타]일 경우 신고기준일 자동입력 옵션 여부에 따른 신고기준일 미입력 */
				if( (optionSet.gw[3][19]||{setValue:0}).setValue=='1' && budgetData.vatFgCode=='3' ){
					param.regDate = ''
				}
			}



			/* 데이터 채우기 */
			$('#tradeTbl').dzt('setValue', tradeUid, param, false);

			/* 행 추가  */
			$('#btnTradeAdd').click();

			/* 데이터 추가 */
			/* fnTradeInsert(); */
		}
	}

	/* ## event - 결제내역 매입전자세금계산서 ## */
	function fnEventTradeETax() {

		var budgetData = $('#budgetTbl').dzt('getValue');
		if ((budgetData.budgetSeq || '') !== '') {
			/* 결제내역 마지막 행 선택 */
			$('#tradeTbl').dzt('setDefaultFocus', 'LAST');

			var winHeight = document.body.clientHeight; // 현재창의 높이
			var winWidth = document.body.clientWidth; // 현재창의 너비
			var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
			var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표

			var popX = winX + (winWidth - 908) / 2;
			var popY = winY + (winHeight - 500) / 2;

			/* 결의정보 */
			var resData = $('#resTbl').dzt('getValue');
			/* 예산내역 */
			var budgetData = $('#budgetTbl').dzt('getValue');

			var url = '<c:url value="/expend/np/user/ETaxUseHistoryPop.do" />';
			url += '?resDocSeq=' + budgetData.resDocSeq;
			url += '&resSeq=' + budgetData.resSeq;
			url += '&budgetSeq=' + budgetData.budgetSeq;
			url += '&callbackName=fnAddInterfaceETaxCallback';
			url += '&taxTy=' + (budgetData.vatFgCode || '');
			url += '&vatFgCode=' + (budgetData.vatFgCode || '');
			url += '&trFgCode=' + (budgetData.trFgCode || '');
			url += '&erpDivSeq=' + ((optionSet.erpEmpInfo.erpDivSeq || '') || optionSet.erpEmpInfo.erpBizSeq);
			url += '&useEtaxOpt=' + (optionSet.gw[1][7].setValue || '');
			url += '&erpDivSeq=' + ((optionSet.erpEmpInfo.erpDivSeq || '') || optionSet.erpEmpInfo.erpBizSeq);

			var pop = window.open(url, "매입전자세금계산서", "width=960, height=550, left=" + popX + ", top=" + popY);
		} else {
			alert('${CL.ex_noBudgetDetailMessage}');
		}

		return;
	}

	function fnAddInterfaceETaxCallback(data) {
		/* example : */
		fnAjaxLog(data);
	}

	/* ## event - 결제내역 추가 ## */
	function fnEventTradeAdd(addType) {

		addType = (typeof addType === 'undefined' ? true : addType);

		/* 입력중인 채주 정보 ${CL.ex_check} */
		var tradeDataList = $('#tradeTbl').dzt('getValueAll');
		var tradeData = $('#tradeTbl').dzt('getValue');
		for(var i = 0; i < tradeDataList.length; i++){
			var item = tradeDataList[i];

			if( (!!item) ) {
				if( (item.trName == '') || (item.tradeAmt == '') ){
					var uid = tradeData.uid;
					for(var i=0;i<tradeDataList.length;i++){
						if(uid == tradeDataList[i].uid){
							uid = (tradeDataList[i+1]||{uid:''}).uid
							if(uid==''){
								if( (item.trName == '') || (item.tradeAmt == '') ){
									alert('${CL.ex_existPayMentDetailMessage}');
									return;
								}
							}
							fnTableFocus($('#tradeTbl'), uid, 'trName');
							return;
						}
					}
				}
			}
		}


		/* 결의정보 입력 여부 ${CL.ex_check} */
		var resData = $('#resTbl').dzt('getValue');
		if ((resData.resSeq || '') === '') {
			alert('${CL.ex_noInfoMessage2}');
			return;
		}

		/* 예산내역 입력 여부 ${CL.ex_check} */
		var budgetData = $('#budgetTbl').dzt('getValue');
		var budgetDataList = $('#budgetTbl').dzt('getValueAll');

		if (Option.Common.ERPiU()){
			var trFgCode = [];
			for(var i=0;i<budgetDataList.length;i++){
				trFgCode.push(budgetDataList[i].trFgCode);
			}
			if( (trFgCode.indexOf('4') != -1 || trFgCode.indexOf('9') != -1) && (trFgCode.indexOf('1') != -1 || trFgCode.indexOf('2') != -1 || trFgCode.indexOf('3') != -1) ){
				alert('기타소득자, 사업소득자는 거래처등록, 사원등록, 거래처명과 같이 처리 할 수 없습니다.');
				return;
			}
			if (addType && (budgetData.budgetSeq || '') === '') {
				if(!!budgetData.erpBudgetSeq && !!budgetData.erpBgacctSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					if(Option.ERPiU.GetBizplanStat()=='Y' && !!budgetData.erpBizplanSeq){
						fnBudgetInsert();
					}
					else{
						alert('${CL.ex_noBudgetDetailMessage}');
						return;
					}
				}
				else{
					alert('${CL.ex_noBudgetDetailMessage}');
					return;
				}

			} else if ((budgetData.setFgCode || '') === '') {
				/* 결제수단 */
				if(!!budgetData.erpBudgetSeq && !!budgetData.erpBgacctSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					if(Option.ERPiU.GetBizplanStat()=='Y' && !!budgetData.erpBizplanSeq){
						fnBudgetInsert();
					}
					else{
						alert('${CL.ex_noPaymentMessage}');
						return;
					}
				}
				else{
					alert('${CL.ex_noPaymentMessage}');
					return;
				}
			} else if ((budgetData.vatFgCode || '') === '') {
				if(!!budgetData.erpBudgetSeq && !!budgetData.erpBgacctSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					if(Option.ERPiU.GetBizplanStat()=='Y' && !!budgetData.erpBizplanSeq){
						fnBudgetInsert();
					}
					else{
						alert('과세구분이 입력되지 않았습니다.');
						return;
					}
				}
				else{
					/* 과세구분 */
					alert('과세구분이 입력되지 않았습니다.');
					return;
				}
			} else if ((budgetData.trFgCode || '') === '') {
				if(!!budgetData.erpBudgetSeq && !!budgetData.erpBgacctSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					if(Option.ERPiU.GetBizplanStat()=='Y' && !!budgetData.erpBizplanSeq){
						fnBudgetInsert();
					}
					else{
						alert('${CL.ex_noCollectionTypeMessage}');
						return;
					}
				}
				else{
					/* 채주유형 */
					alert('${CL.ex_noCollectionTypeMessage}');
					return;
				}
			}
		}
		else{
			if (addType && (budgetData.budgetSeq || '') === '') {
				if(!!budgetData.erpBudgetSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					fnBudgetInsert();
				}
				else{
					alert('${CL.ex_noBudgetDetailMessage}');
					return;
				}

			} else if ((budgetData.setFgCode || '') === '') {
				/* 결제수단 */
				if(!!budgetData.erpBudgetSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					fnBudgetInsert();
				}
				else{
					alert('${CL.ex_noPaymentMessage}');
					return;
				}
			} else if ((budgetData.vatFgCode || '') === '') {
				if(!!budgetData.erpBudgetSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					fnBudgetInsert();
				}
				else{
					/* 과세구분 */
					alert('과세구분이 입력되지 않았습니다.');
					return;
				}
			} else if ((budgetData.trFgCode || '') === '') {
				if(!!budgetData.erpBudgetSeq && !!budgetData.setFgCode && !!budgetData.vatFgCode && !!budgetData.trFgCode ){
					fnBudgetInsert();
				}
				else{
					/* 채주유형 */
					alert('${CL.ex_noCollectionTypeMessage}');
					return;
				}
			}
		}

		var tradeDatas = $('#tradeTbl').dzt('getValueAll');
		var reqChkTrade = {};
		$.each(tradeDatas, function(idx, item) {
			if ((item.tradeSeq || '') === '') {
				reqChkTrade = fnTradeChkValue();
			}
		});

		if (Object.keys(reqChkTrade).length === 0) {
			reqChkTrade.sts = true;
		}

		if (reqChkTrade.sts) {
			/* 현재행이 저장되지 않았다면, 저장 진행 */
			if ((($('#tradeTbl').dzt('getValue') || {}).tradeSeq || '') === '' && $('#tradeTbl').dzt('getValueAll').length > 0) {

					fnTradeInsert();
			}

			var uid = fnTableAdd($('#tradeTbl'));

			/* 기본값 설정 ( resDocSeq ) */
			$('#tradeTbl').dzt('setValue', uid, {
				resDocSeq : resDocSeq,
				uid : uid
			}, false);

			if (Option.Common.ERPiU()) {
				/* ERPiU 기본 포커스 정의 */
				fnTableFocus($('#tradeTbl'), uid, 'trName');
			} else if (Option.Common.iCUBE()) {
				/* iCUBE 기본 포커스 정의 */
				fnTableFocus($('#tradeTbl'), uid, 'trName');
			}
		} else {
			/* 사용자 알림 표시 */
			alert(reqChkTrade.msg);

			/* 포커스 이동 */
			$('#tradeTbl').dzt('setFocus', $('#tradeTbl').dzt('getUID'), reqChkTrade.key);
		}

		return;
	}

	/* ## event - 결제내역 삭제 ## */
	function fnEventTradeDelete(resDocSeq, resSeq, budgetSeq, tradeSeq) {
		/* 선행 선택 예산정보 초기화 */
		// preBudgetSeq = '';

		/* [ parameter ] */
		/*   - resDocSeq : 삭제 대상 결의문서 키 */
		resDocSeq = (resDocSeq || '');
		/*   - resSeq : 삭제 대상 결의서 키 */
		resSeq = (resSeq || '');
		/*   - budgetSeq : 삭제 대상 예산 키 */
		budgetSeq = (budgetSeq || '');
		/*   - budgetSeq : 삭제 대상 채주 키 */
		tradeSeq = (tradeSeq || '');

		/* [ ajax parameter ] */
		var parameter = {};

		if (resDocSeq !== '' && resSeq !== '' && budgetSeq !== '' && tradeSeq !== '') {
			/* 파라미터 정의 */
			parameter.resDocSeq = resDocSeq;
			parameter.resSeq = resSeq;
			parameter.budgetSeq = budgetSeq;
			parameter.tradeSeq = tradeSeq;
		} else {
			/* 현재 행 정보 조회 */
			var tradeData = $('#tradeTbl').dzt('getValue');
			if (tradeData === null || JSON.stringify(tradeData) == '{}' || (!tradeData.trName) ) {
				return false;
			}
			/* 파라미터 정의 */
			parameter.resDocSeq = tradeData.resDocSeq;
			parameter.resSeq = tradeData.resSeq;
			parameter.budgetSeq = tradeData.budgetSeq;
			parameter.tradeSeq = tradeData.tradeSeq;
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResTradeDelete.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : parameter.resDocSeq,
			resSeq : parameter.resSeq,
			budgetSeq : parameter.budgetSeq,
			tradeSeq : parameter.tradeSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);
				var btnId = 'btnTradeDelete'

				if (resultCode === 'SUCCESS') {
					var tradeDataArray = $('#tradeTbl').dzt('getValueAll');
					var resDocSeq = this.resDocSeq;
					var resSeq = this.resSeq;
					var budgetSeq = this.budgetSeq;
					var tradeSeq = this.tradeSeq;

					$('#lbBudgetAmt').html(Option.Common.GetNumeric(aData.tryAmt || '0'));

					/* 화면상의 결제내역을 삭제한다. */
					$.each(tradeDataArray, function(tradeIdx, trade) {
						if (trade.resDocSeq === resDocSeq && trade.resSeq === resSeq && trade.budgetSeq === budgetSeq && trade.tradeSeq == tradeSeq) {
							$('#tradeTbl').dzt('setRemoveRow', $('#tradeTbl div.rightContents table tr:eq(' + tradeIdx + ')'));
							return false;
						}
					});

					if ((this.tradeSeq || '') !== '') {
						// Option.Common.SetAmtUpdate(this.resSeq, this.budgetSeq, this.tradeSeq, 0, 0, 0, 'delete');
					}

					Option.Common.SetFocusAmtUpdate();
					fnSetBudgetDisplay(btnId);
					//Option[Option.Common.GetErpType()].GetBudgetAmtInfo('tradeAmt');
				} else {
					alert('삭제처리중 판단되지 않은 상태가 ${CL.ex_check}되었습니다. 지속적으로 발생될 경우 관리자에게 문의해주세요.');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		})

		var targetTr = $('#tradeTbl').dzt('getSelectedRow');
		$(targetTr).dzt('setRemoveRow', $(targetTr));

		return;
	}

	/* ## event - 결제내역 위 ## */
	function fnEventTradeUp() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## event - 결제내역 아래 ## */
	function fnEventTradeDown() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## doc ## */
	/* ====================================================================================================================================================== */
	/* ## doc - 결의서 문서 연동정보 생성 ## */
	function fnResDocInsert() {
		/* [ parameter ] */
		var parameter = {};
		// Option.Common.SetFocusAmtUpdate();

		parameter.resNote = ''; /* 결의문서 적요 */
		parameter.erpCompSeq = ''; /* ERP 회사 코드 */
		parameter.erpDivSeq = ''; /* ERP 사업장 명칭 */
		parameter.erpDivName = ''; /* ERP 사업장 명칭 */
		parameter.erpDeptSeq = ''; /* ERP 부서 코드 */
		parameter.erpEmpSeq = ''; /* ERP 사원 코드 */
		parameter.erpGisu = ''; /* ERP 기수 */
		parameter.erpExpendYear = ''; /* ERP 회계 연도 */
		parameter.compSeq = ''; /* GW 회사 코드 */
		parameter.compName = ''; /* GW 회사 명칭 */
		parameter.deptSeq = ''; /* GW 부서 코드 */
		parameter.deptName = ''; /* GW 부서 명칭 */
		parameter.empSeq = ''; /* GW 사용자 코드 */
		parameter.empName = ''; /* GW 사용자 명칭 */
		parameter.formSeq = formSeq; /* 전자결재 양식 코드 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

        if (Option.Common.ERPiU()) {
        	/* iU원인행위 회계단위 명칭통일 pc -> div */
        	parameter.erpDivSeq = (parameter.erpPcSeq || ''); /* ERP 회계단위 코드 */
            parameter.erpDivName = (parameter.erpPcName || ''); /* ERP 회계단위 명칭 */
            parameter.erpPcSeq = optionSet.erpEmpInfo.erpDivSeq;
            parameter.erpPcName = optionSet.erpEmpInfo.erpDivName;

        }

		/* 외부연동 ( 전용개발 또는 내부 개발 항목 - 근태 등 ) */
		parameter.outProcessInterfaceId = '${outProcessInterfaceId}';
		parameter.outProcessInterfaceMId = '${outProcessInterfaceMId}';
		parameter.outProcessInterfaceDId = '${outProcessInterfaceDId}';

		if (resCustomProcess) { // 백상휘 수정.
			parameter.confferDocSeq = gntpKey;
			optionSet.confferInfo = {consDocSeq: gntpKey};
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResDocInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				/* 결의 정보 저장 */
				var aData = Option.Common.GetResult(result, 'aData');
				optionSet.resDocInfo = aData;

				if (aData) {
					resDocSeq = aData.resDocSeq;
					$('#h1_resDocTitle').html($('#h1_resDocTitle').text() + ' / ' + resDocSeq);

					/* 문서 기수 정보 출력 */
					fnShowGisuInfo();
				} else {
					resDocSeq = '';
					alert('결의서가 정상적으로 생성되지 않았습니다.\r\n문서를 새로고침합니다.\r\n지속적으로 문제가 발생될 경우 관리자에게 문의해주세요.');
					location.reload();
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## doc - 기수정보 출력 */
	function fnShowGisuInfo(){
		if(optionSet.conVo.erpTypeCode == 'iCUBE'){
			$('#h1_gisuInfo').show();

			var gisuInfo = Option.Common.GetErpGisuInfo();
			var fromDate = gisuInfo.erpGisuFromDate;
			var toDate = gisuInfo.erpGisuToDate;
			fromDate = fromDate.substring(0, 4) + '-' + fromDate.substring(4, 6) + '-' + fromDate.substring(6, 8);
			toDate = toDate.substring(0, 4) + '-' + toDate.substring(4, 6) + '-' + toDate.substring(6, 8);
			$('#h1_gisuInfo').html('${CL.ex_accountPeriod} : ' + gisuInfo.erpGisu + '${CL.ex_accountingYear} '+ fromDate + ' ~ ' + toDate);
		}else{
			$('#h1_gisuInfo').hide();
		}
	}

	/* ## doc - 결의서 문서 정보 조회 ## */
	function fnResAllInfo() {
		/* [ parameter ] */
		var parameter = {};

		parameter.resDocSeq = resDocSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/res/ResDocAllinfo.do */
			url : domain + '/ex/np/user/res/ResDocAllinfo.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq(결의문서 시퀀스) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				preDocSeq = result.result.aData.resDocInfo[0].docSeq;

				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					if (aData.tradeInfo.length > 0) {
						$.each(aData.tradeInfo, function(tradeIdx, tradeItem) {
							var resSeq = (tradeItem.resSeq || ''); /* 결의정보 시퀀스 */
							var budgetSeq = (tradeItem.budgetSeq || ''); /* 예산내역 시퀀스 */
							var tradeSeq = (tradeItem.tradeSeq || ''); /* 결제내역 시퀀스 */
							var tradeAmt = (tradeItem.tradeAmt || '').toString().replace(/,/g, ''); /* 금액 */
							var tradeStdAmt = (tradeItem.tradeStdAmt || '').toString().replace(/,/g, ''); /* 공급가액 */
							var tradeTaxAmt = (tradeItem.tradeTaxAmt || '').toString().replace(/,/g, ''); /* 부가세 */
						});

						/* 금액 정보 갱신 */
						// Option.Common.SetAmtUpdate(resSeq, budgetSeq, tradeSeq, tradeAmt, tradeStdAmt, tradeTaxAmt, '');
						if('' != '${param.newResDocSeq}') {
							Option.Common.SetFocusAmtUpdate();
						}
					}

					if(!!(aData.resDocInfo[0].confferDocSeq||'')){
						optionSet.confferInfo = {
								consDocSeq : aData.resDocInfo[0].confferDocSeq
						};
						/* 결의정보 추가 버튼 미표시 처리 */
						$('#btnResReset').hide();
						$('#btnResAdd').hide();
						$('#btnResDelete').hide();
						$('#btnConsRefer').hide();
						$('#btnBringFavorites').hide();
					}
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## res (결의정보) ## */
	/* ====================================================================================================================================================== */
	/* ## res (결의정보) - 생성 ## */
	function fnResInsert() {
		/* [ parameter ] */
		var parameter = {};
		// Option.Common.SetFocusAmtUpdate();

		parameter.resDocSeq = ''; /* [*]결의문서 키 */
		parameter.resDate = ''; /* [*]결의일자(발의일자) */
		parameter.erpMgtSeq = ''; /* [*]부서/프로젝트 코드 */
		parameter.erpMgtName = ''; /* [*]부서/프로젝트 명칭 */
		parameter.docuFgCode = ''; /* [*]결의구분코드 */
		parameter.docuFgName = ''; /* [*]결의구분명칭 */
		parameter.resNote = ''; /* [*]결의서적요(결의내역) */
		parameter.erpCompSeq = ''; /* ERP 회사코드 */
		parameter.erpCompName = ''; /* ERP 회사명칭 */
		parameter.erpPcSeq = ''; /* ERP PC코드 */
		parameter.erpPcName = ''; /* ERP PC명칭 */
		parameter.erpEmpSeq = ''; /* ERP 사원코드 */
		parameter.erpEmpName = ''; /* ERP 사원명 */
		parameter.erpDivSeq = ''; /* ERP 회계단위코드 */
		parameter.erpDivName = ''; /* ERP 회계단위명칭 */
		parameter.erpDeptSeq = ''; /* GW 부서코드 */
		parameter.erpDeptName = ''; /* GW 부서명칭 */
		parameter.erpGisu = ''; /* ERP 기수 */
		parameter.erpGisuFromDate = ''; /* ERP 기수시작일 */
		parameter.erpGisuToDate = ''; /* ERP 기수종료일 */
		parameter.erpYear = ''; /* ERP 회계연도 */
		parameter.btrSeq = ''; /* [*]입출금계좌코드 */
		parameter.bottomSeq = ''; /* [*]하위사업코드 */
		parameter.btrNb = ''; /* [*]입출금계좌 */
		parameter.btrName = ''; /* [*]입출금계좌명칭 */
		parameter.bottomName = ''; /* [*]하위사업명칭 */
		parameter.empSeq = ''; /* GW 사용자코드 */

		var resData = $('#resTbl').dzt('getValue');

		/* 결의 정보 데이터 보정 */
		if(resData.resDate.replace(/[0-9]/g, '') == '--'){
			var year = parseInt(resData.resDate.split('-')[0] || '1' ) ;
			var month = parseInt(resData.resDate.split('-')[1] || '1' ) ;
			var day = parseInt(resData.resDate.split('-')[2] || '1' ) ;
			year = year < 10 ? '0' + year : '' + year;
			month = month < 10 ? '0' + month : '' + month;
			day = day < 10 ? '0' + day : '' + day;
			resData.resDate = year + '-' + month + '-' + day;
		}

		parameter = JSON.parse(JSON.stringify($.extend(parameter, resData))); /* 작성중인 결의 정보 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		if (Option.Common.ERPiU()) {
			parameter.erpPcSeq = optionSet.erpEmpInfo.erpDivSeq || optionSet.erpEmpInfo.erpPcSeq;
			parameter.erpPcName = optionSet.erpEmpInfo.erpDivName || optionSet.erpEmpInfo.erpPcName;
			parameter.erpDivSeq = optionSet.erpEmpInfo.erpPcSeq||''; /* ERP 사업장 명칭 */
			parameter.erpDivName = optionSet.erpEmpInfo.erpPcName||''; /* ERP 사업장 명칭 */
			parameter.expendDate = parameter.resDate;

			if((!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0'))){
				parameter.erpBizplanSeq = ''
			}
			var uid = $('#resTbl').dzt('getUID');
			$('#resTbl').dzt('setValue', uid, parameter, false);
		}


		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResHeadInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resDate, erpMgtSeq, erpMgtName, docuFgCode, docuFgName, resNote, erpCompSeq, erpCompName, erpPcSeq, erpPcName, erpEmpSeq, erpEmpName, erpDivSeq, erpDivName, erpDeptSeq, erpDeptName, erpGisu, erpGisuFromDate, erpGisuToDate, erpYear, btrSeq, bottomSeq, btrNb, btrName, bottomName, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 결의서 시퀀스 반영 ( resSeq ) */
					$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
						resSeq : (aData.resSeq || '').toString(),
						insertStat : resultCode,
						insertMsg : ''
					}, false);
				} else if(resultCode == 'GISU_CLOSE'){
					alert('기수 마감되어 결의서를 입력할 수 없습니다.');
				} else {
					$('#resTbl').dzt('setValue', $('#resTbl').dzt('getUID'), {
						resSeq : '',
						insertStat : resultCode,
						insertMsg : ''
					}, false);
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## res (결의정보) - 수정 ## */
	function fnResUpdate() {
		/* [ parameter ] */
		var parameter = {};
		// Option.Common.SetFocusAmtUpdate();

		parameter.resDocSeq = ''; /* [*]결의문서 키 */
		parameter.resDate = ''; /* [*]결의일자(발의일자) */
		parameter.resSeq = ''; /* [*]결의서 키 */
		parameter.erpMgtSeq = ''; /* [*]부서/프로젝트 코드 */
		parameter.erpMgtName = ''; /* [*]부서/프로젝트 명칭 */
		parameter.docuFgCode = ''; /* [*]결의구분코드 */
		parameter.docuFgName = ''; /* [*]결의구분명칭 */
		parameter.resNote = ''; /* [*]결의서적요(결의내역) */
		parameter.erpCompSeq = ''; /* ERP 회사코드 */
		parameter.erpCompName = ''; /* ERP 회사명칭 */
		parameter.erpPcSeq = ''; /* ERP PC코드 */
		parameter.erpPcName = ''; /* ERP PC명칭 */
		parameter.erpEmpSeq = ''; /* ERP 사원코드 */
		parameter.erpEmpName = ''; /* ERP 사원명 */
		parameter.erpDivSeq = ''; /* ERP 회계단위코드 */
		parameter.erpDivName = ''; /* ERP 회계단위명칭 */
		parameter.erpDeptSeq = ''; /* GW 부서코드 */
		parameter.erpDeptName = ''; /* GW 부서명칭 */
		parameter.erpGisu = ''; /* ERP 기수 */
		parameter.erpGisuFromDate = ''; /* ERP 기수시작일 */
		parameter.erpGisuToDate = ''; /* ERP 기수종료일 */
		parameter.erpYear = ''; /* ERP 회계연도 */
		parameter.btrSeq = ''; /* [*]입출금계좌코드 */
		parameter.bottomSeq = ''; /* [*]하위사업코드 */
		parameter.btrNb = ''; /* [*]입출금계좌 */
		parameter.btrName = ''; /* [*]입출금계좌명칭 */
		parameter.bottomName = ''; /* [*]하위사업명칭 */
		parameter.empSeq = ''; /* GW 사용자코드 */

		var resData = $('#resTbl').dzt('getValue');

		/* 결의 정보 데이터 보정 */
		if(resData.resDate.replace(/[0-9]/g, '') == '--'){
			var year = parseInt(resData.resDate.split('-')[0] || '1' ) ;
			var month = parseInt(resData.resDate.split('-')[1] || '1' ) ;
			var day = parseInt(resData.resDate.split('-')[2] || '1' ) ;
			year = year < 10 ? '0' + year : '' + year;
			month = month < 10 ? '0' + month : '' + month;
			day = day < 10 ? '0' + day : '' + day;
			resData.resDate = year + '-' + month + '-' + day;
		}
		parameter = JSON.parse(JSON.stringify($.extend(parameter, resData))); /* 작성중인 결의 정보 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = (parameter.erpPcSeq || ''); /* ERP 사업장 명칭 */
			parameter.erpDivName = (parameter.erpPcName || ''); /* ERP 사업장 명칭 */
			parameter.expendDate = parameter.resDate;
			if((!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0'))){
				parameter.erpBizplanSeq = ''
			}

			var uid = $('#resTbl').dzt('getUID');
			$('#resTbl').dzt('setValue', uid, parameter, false);
		}else{

			/* G20 이면서 기수 정보가 변경된 경우 */
			if( ( resData.resDate < optionSet.erpGisu.fromDate ) || (resData.resDate > optionSet.erpGisu.toDate)){
				/* erp 기수 정보 재조회 */
				$.ajax({
					type : 'post',
					/*   - url : /ex/np/user/cons/ConsDocInsert.do */
					url : domain + '/expend/np/admin/code/ExProcDataSelect.do',
					datatype : 'json',
					async : false,
					data : {
						procType : 'commonGisuInfo'
						, erpCompSeq : optionSet.erpEmpInfo.erpCompSeq
						, erpType : optionSet.conVo.erpTypeCode
						, baseDate : resData.resDate.replace(/-/gi, '')
					},
					success : function(result) {
						if(result.result.resultCode == 'SUCCESS'){
							var item = result.result.aaData[0];
							optionSet.erpGisu.gisu = item.gisu;
							optionSet.erpGisu.fromDate = item.fromDate;
							optionSet.erpGisu.toDate = item.toDate;

							parameter.gisu = item.gisu;
							parameter.erpGisu = item.gisu;
							parameter.erpGisuFromDate = item.fromDate;
							parameter.erpGisuToDate = item.toDate;
							parameter.erpExpendYear = item.fromDate.substring(0,4);
							parameter.erpYear = item.fromDate.substring(0,4);

							var uid = $('#resTbl').dzt('getUID');
							$('#resTbl').dzt('setValue', uid, parameter, false);

							fnShowGisuInfo();
						}else{
							alert('기수 정보 조회 실패');
						}
					},
					error : function(result) {
						console.error(result);
					}
				});
			}
		}


		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResHeadUpdate.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resDate, resSeq, erpMgtSeq, erpMgtName, docuFgCode, docuFgName, resNote, erpCompSeq, erpCompName, erpPcSeq, erpPcName, erpEmpSeq, erpEmpName, erpDivSeq, erpDivName, erpDeptSeq, erpDeptName, erpGisu, erpGisuFromDate, erpGisuToDate, erpYear, btrSeq, bottomSeq, btrNb, btrName, bottomName, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## res (결의정보) - 조회 ## */
	function fnResSelect() {
		/* [ parameter ] */
		var parameter = {};

		parameter.resDocSeq = resDocSeq; /* 결의문서 시퀀스 */

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResHeadList.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq ( 결의문서 시퀀스 ), resSeq ( 결의정보 시퀀스 - 선택 ) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {

				fnAjaxLog(this.url, result);
				var aaData = Option.Common.GetResult(result, 'aaData');
				/* 참조 품의 반영여부 ${CL.ex_check} */
				if(aaData.length > 0){
					if(!!aaData[0].confferDocSeq){
						$('#btnResReset').hide();
						$('#btnResAdd').hide();
						$('#btnResDelete').hide();
						$('#btnConsRefer').hide();
					}
				}

				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* erpDivSeq 저장된 정보 우선 적용 */

					if (Option.Common.iCUBE()) {
						if ((!(!aaData[0])) && aaData[0].erpDivSeq) {
							$('#lbErpDivName').val(aaData[0].erpDivName);
							$('#lbErpDivName').attr('seq', aaData[0].erpDivSeq);

							optionSet.erpEmpInfo.erpDivName = aaData[0].erpDivName;
							optionSet.erpEmpInfo.erpDivSeq = aaData[0].erpDivSeq;
						}
					}else if(Option.Common.ERPiU()){
						if ((!(!aaData[0])) && aaData[0].erpDivSeq) {
							$('#lbErpDivName').val(aaData[0].erpPcName);
							$('#lbErpDivName').attr('seq', aaData[0].erpPcSeq);

							optionSet.erpEmpInfo.erpPcName = aaData[0].erpPcName;
							optionSet.erpEmpInfo.erpPcSeq = aaData[0].erpPcSeq;
						}
					}

					$.each(aaData, function(resIdx, resItem) {

						if (resItem.inspectDate != "" && resItem.inspectDate != null) {
							resItem.inspectDate = resItem.inspectDate.substr(0, 4) + '-' + resItem.inspectDate.substr(4, 2) + '-' + resItem.inspectDate.substr(6, 2);
						}

						if (resItem.payplanDate != "" && resItem.payplanDate != null) {
							resItem.payplanDate = resItem.payplanDate.substr(0, 4) + '-' + resItem.payplanDate.substr(4, 2) + '-' + resItem.payplanDate.substr(6, 2);
						}

						if (resItem.signDate != "" && resItem.signDate != null) {
							resItem.signDate = resItem.signDate.substr(0, 4) + '-' + resItem.signDate.substr(4, 2) + '-' + resItem.signDate.substr(6, 2);
						}

						if (resItem.causeDate != "" && resItem.causeDate != null) {
							resItem.causeDate = resItem.causeDate.substr(0, 4) + '-' + resItem.causeDate.substr(4, 2) + '-' + resItem.causeDate.substr(6, 2);
						}

						/* 물품명세액 포맷 수정 */
						if (resItem.itemAmt != "" && resItem.itemAmt != null) {
							resItem.itemAmt = resItem.itemAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						}

						if (resItem.itemAmt != "" && resItem.itemAmt != null) {
							resItem.resDate = resItem.resDate.substr(0, 4) + '-' + resItem.resDate.substr(4, 2) + '-' + resItem.resDate.substr(6, 2);
						}

						/* 결의정보 반영 */
						$('#resTbl').dzt('setValue', $('#resTbl').dzt('setAddRow'), resItem);
						/* 즐겨찾기 아닌 경우 */
						if (!flagFavorites) {
							/* 결의정보 마지막 행 선택 */
							if (!approKey) {
								/* 일반 작성의 경우 */
								$('#resTbl').dzt('setDefaultFocus', 'LAST');
							} else {
								/* 전자결재 문서에서 뒤로가기로 돌아온경우 */
								$('#resTbl').dzt('setDefaultFocusReRes', 'LAST');
							}
						}
						/* 금액 갱신 */
						Option.Common.SetFocusAmtUpdate();
					});

					/* 즐겨찾기인 경우 */
					if(flagFavorites) {
                        $('#resTbl').dzt('setDefaultFocus', 'LAST');
					} else {
						/* 예산정보 마지막 행 선택 */
                        $('#budgetTbl').dzt('setDefaultFocus', 'LAST');
                    }
				} else {
					alert('저장된 정보 조회중 오류가 발생되었습니다.');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		// Option.Common.SetFocusAmtUpdate();

		/* [ return ] */
		return;
	}

	/* ## res (결의정보) - 조회 ## */
	function fnResSelectForReRes() {
		/* [ parameter ] */
		var parameter = {};

		parameter.resDocSeq = resDocSeq; /* 결의문서 시퀀스 */

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResHeadList.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq ( 결의문서 시퀀스 ), resSeq ( 결의정보 시퀀스 - 선택 ) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aaData = Option.Common.GetResult(result, 'aaData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* erpDivSeq 저장된 정보 우선 적용 */

					if (Option.Common.iCUBE()) {
						if ((!(!aaData[0])) && aaData[0].erpDivSeq) {
							$('#lbErpDivName').val(aaData[0].erpDivName);
							$('#lbErpDivName').attr('seq', aaData[0].erpDivSeq);

							optionSet.erpEmpInfo.erpDivName = aaData[0].erpDivName;
							optionSet.erpEmpInfo.erpDivSeq = aaData[0].erpDivSeq;
						}
					}else if(Option.Common.ERPiU()){
						if ((!(!aaData[0])) && aaData[0].erpDivSeq) {
							$('#lbErpDivName').val(aaData[0].erpPcName);
							$('#lbErpDivName').attr('seq', aaData[0].erpPcSeq);

							optionSet.erpEmpInfo.erpPcName = aaData[0].erpPcName;
							optionSet.erpEmpInfo.erpPcSeq = aaData[0].erpPcSeq;
						}
					}

					$.each(aaData, function(resIdx, resItem) {

						if(resItem.inspectDate != "" && resItem.inspectDate != null) {
							resItem.inspectDate = resItem.inspectDate.substr(0,4) + '-' + resItem.inspectDate.substr(4,2) + '-' + resItem.inspectDate.substr(6,2);
						}

						if(resItem.payplanDate != "" && resItem.payplanDate != null) {
							resItem.payplanDate = resItem.payplanDate.substr(0,4) + '-' + resItem.payplanDate.substr(4,2) + '-' + resItem.payplanDate.substr(6,2);
						}

						if(resItem.signDate != "" && resItem.signDate != null) {
							resItem.signDate = resItem.signDate.substr(0,4) + '-' + resItem.signDate.substr(4,2) + '-' + resItem.signDate.substr(6,2);
						}

						if(resItem.causeDate != "" && resItem.causeDate != null) {
							resItem.causeDate = resItem.causeDate.substr(0,4) + '-' + resItem.causeDate.substr(4,2) + '-' + resItem.causeDate.substr(6,2);
						}

						/* 물품명세액 포맷 수정 */
						if(resItem.itemAmt != "" && resItem.itemAmt != null) {
							resItem.itemAmt = resItem.itemAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						}

						if(resItem.itemAmt != "" && resItem.itemAmt != null) {
							resItem.resDate = resItem.resDate.substr(0,4) + '-' + resItem.resDate.substr(4,2) + '-' + resItem.resDate.substr(6,2);
						}

						/* 결의정보 반영 */
						$('#resTbl').dzt('setValue', $('#resTbl').dzt('setAddRow'), resItem);
						/* 결의정보 마지막 행 선택 */
						/* 재기안의 경우 */
						$('#resTbl').dzt('setDefaultFocusReRes', 'LAST');
						/* 금액 갱신 */
						Option.Common.SetFocusAmtUpdate();
					});

					/* 예산정보 마지막 행 선택 */
					$('#budgetTbl').dzt('setDefaultFocus', 'LAST');
				} else {
					alert('저장된 정보 조회중 오류가 발생되었습니다.');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		// Option.Common.SetFocusAmtUpdate();

		/* [ return ] */
		return;
	}

	/* ## res (결의정보) - 필수값 ${CL.ex_check} ## */
	function fnResChkValue(chkType) {

		chkType = (typeof chkType === 'undefined' ? true : chkType);

		/* 반환 변수 정의 */
		var resultValue = {
			/* 필수값 점검 결과 [true, false] */
			sts : false,
			key : '',
			msg : ''
		};

		/* 최초 입력 여부 ${CL.ex_check} */
		if ($('#resTbl').dzt('getValueAll').length === 0) {
			resultValue.sts = true;
			return resultValue;
		}

		var resData = $('#resTbl').dzt('getValue');

		if (Option.Common.ERPiU()) {
			/* ERPiU 필수값 점검 */
			/* Step1. 결의구분 ( 결의구분 코드 ) */
			if (chkType && ((resData.docuFgCode || '') === '' || (resData.docuFgName || '') === '')) {
				resultValue.sts = false;
				resultValue.key = 'docuFgName';
				resultValue.msg = '${CL.ex_noInfoMessage}';
			} else if (chkType && (resData.resDate || '') === '') {
				resultValue.sts = false;
				resultValue.key = 'resDate';
				resultValue.msg = '${CL.ex_noExpendDateMessage}';
			}  else {
				resultValue.sts = true;
			}
		} else if (Option.Common.iCUBE()) {
			/* iCUBE 필수값 점검 */
			/* Step1. 결의구분 ( 결의구분 코드 ) */
			if (chkType && ((resData.docuFgCode || '') === '' || (resData.docuFgName || '') === '')) {
				resultValue.sts = false;
				resultValue.key = 'docuFgName';
				resultValue.msg = '${CL.ex_noInfoMessage}';
			} else if (chkType && (resData.resDate || '') === '') {
				resultValue.sts = false;
				resultValue.key = 'resDate';
				resultValue.msg = '${CL.ex_noExpendDateMessage}';
			} else if (chkType && ((resData.erpMgtName || '') === '' || (resData.erpMgtSeq || '') === '')) {
				resultValue.sts = false;
				resultValue.key = 'erpMgtName';
				resultValue.msg = '${CL.ex_noProjectMessage}';
			} else if (chkType && ((optionSet.gw[1][11]||{'setValue':'1'}).setValue == '0' && (resData.resNote || '') === '' )) {
				resultValue.sts = false;
				resultValue.key = 'resNote';
				resultValue.msg = '적요가 입력되지 않았습니다.';
			} else {
				resultValue.sts = true;
			}
		} else {
			console.error('연동 ERP 정보를 ${CL.ex_check}할 수 없습니다. [ERPiU, iCUBE]');
			resultValue.sts = false;
			resultValue.key = '';
			resultValue.msg = '연동 ERP 정보를 ${CL.ex_check}할 수 없습니다. [ERPiU, iCUBE]';
			return false;
		}

		return resultValue;
	}

	/* ## budget (예산내역) ## */
	/* ====================================================================================================================================================== */
	/* ## budget (예산내역) - 생성 ## */
	function fnBudgetInsert() {
		/* [ parameter ] */
		var parameter = {};
		// Option.Common.SetFocusAmtUpdate();

		parameter.resDocSeq = ''; /* [*]결의문서 키 */
		parameter.resSeq = ''; /* [*]결의서 키 */
		parameter.erpBqSeq = ''; /* [*]ERP 연동 품의서 키 */
		parameter.erpBkSeq = ''; /* [*]ERP 연동 품의 예산 키 */
		parameter.erpBudgetSeq = ''; /* [*]ERP 예산과목 코드 (예산단위 코드) */
		parameter.erpBudgetName = ''; /* [*]ERP 예산과목 명칭 (예산단위 명칭) */
		parameter.erpBizplanSeq = ''; /* [*]ERP 사업계획 코드 */
		parameter.erpBizplanName = ''; /* [*]ERP 사업계획 명칭 */
		parameter.erpFiacctName = ''; /* [*]ERP 회계계정 코드 */
		parameter.erpFiacctSeq = ''; /* [*]ERP 회계계정 명칭 */
		parameter.erpBgt1Name = ''; /* [*]관 명칭 */
		parameter.erpBgt1Seq = ''; /* [*]관 코드 */
		parameter.erpBgt2Name = ''; /* [*]항 명칭 */
		parameter.erpBgt2Seq = ''; /* [*]항 코드 */
		parameter.erpBgt3Name = ''; /* [*]목 명칭 */
		parameter.erpBgt3Seq = ''; /* [*]목 코드 */
		parameter.erpBgt4Name = ''; /* [*]세 명칭 */
		parameter.erpBgt4Seq = ''; /* [*]세 코드 */
		parameter.erpOpenAmt = ''; /* [*]ERP 예산 편성 금액 */
		parameter.erpApplyAmt = ''; /* [*]ERP 집행액 */
		parameter.erpLeftAmt = ''; /* [*]ERP 잔액 */
		parameter.budgetStdAmt = ''; /* [*]공급가액 */
		parameter.budgetTaxAmt = ''; /* [*]부가세 */
		parameter.budgetAmt = ''; /* [*]총금액 */
		parameter.erpBgacctSeq = ''; /* [*]예산 계정 코드 */
		parameter.erpBgacctName = ''; /* [*]예산 계정 명칭 */
		parameter.setFgCode = ''; /* [*]결제수단 코드 */
		parameter.setFgName = ''; /* [*]결제수단 명칭 */
		parameter.vatFgCode = ''; /* [*]과세구분 코드 */
		parameter.vatFgName = ''; /* [*]과세구분 명칭 */
		parameter.trFgCode = ''; /* [*]채주유형 코드 */
		parameter.trFgName = ''; /* [*]재추유형 명칭 */
		parameter.ctlFgCode = ''; /* [*]미사용? */
		parameter.ctlFgName = ''; /* [*]미사용? */
		parameter.budgetNote = ''; /* [*]예산 적요 */
		parameter.erpDivSeq = ''; /* ERP 회계단위 코드 */
		parameter.erpDivName = ''; /* ERP 회계단위 명칭 */
		parameter.empSeq = ''; /* GW 사용자코드 */

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var resData = $('#resTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, resData))); /* 작성중인 결의정보 정보 */
		parameter.erpGisuDate = (resData.resDate || '').toString().replace(/-/g, '');
		parameter.expendDate = (resData.resDate || '').toString().replace(/-/g, '');

		var budgetData = $('#budgetTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 정보 */

		/* 예산 회계단위 조정 */
		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = (parameter.erpPcSeq || ''); /* ERP 사업장 명칭 */
			parameter.erpDivName = (parameter.erpPcName || ''); /* ERP 사업장 명칭 */
		} else if (Option.Common.iCUBE()) {
			parameter.erpBudgetDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpBudgetDivName = $('#lbErpDivName').val();
		}

		/* 부가세 통제 여부 체크 */
		if(Option.Common.ERPiU()){
			if( optionSet.erp["YN_JITAX"].CD_ENV == 'Y' ){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'U_YN_JITAX_Y';
			}else {
				if(budgetData.vatFgCode == 4){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_4';
				} else if(budgetData.vatFgCode == 3){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_3';
				} else{
					parameter.ctlFgCode = '0';
					parameter.ctlFgName = 'U_YN_JITAX_N';
				}
			}
		}else if(Option.Common.iCUBE()){
			if (optionSet.erpEmpInfo.vatControl == '1' || (budgetData.trFgCode=='4' || budgetData.trFgCode=='8' || budgetData.trFgCode=='9')){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'I_IN_TAX_Y';
			}else {
				parameter.ctlFgCode = '0';
				parameter.ctlFgName = 'I_IN_TAX_N';
			}
		}

		/* [DB] INT 형 파라미터 데이터 보정 */
		parameter = fnBudgetDataCurrection(parameter);


		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResBudgetInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, erpBqSeq, erpBkSeq, erpBudgetSeq, erpBudgetName, erpBizplanSeq, erpBizplanName, erpBgt1Name, erpBgt1Seq, erpBgt2Name, erpBgt2Seq, erpBgt3Name, erpBgt3Seq, erpBgt4Name, erpBgt4Seq, erpOpenAmt, erpApplyAmt, erpLeftAmt, budgetStdAmt, budgetTaxAmt, budgetAmt, erpBgacctSeq, erpBgacctName, setFgCode, setFgName, vatFgCode, vatFgName, trFgCode, trFgName, ctlFgCode, ctlFgName, budgetNote, erpDivSeq, erpDivName, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 예산정보 갱신 ( 금회집행 ) */
					$('#lbBudgetAmt').html(Option.Common.GetNumeric(aData.tryAmt || '0'));

					/* 결의서 시퀀스 반영 ( resSeq ) */
					$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
						budgetSeq : (aData.budgetSeq || '').toString(),
						insertStat : resultCode,
						insertMsg : '',
						confferDocSeq : aData.confferDocSeq ||''
					}, false);

					//if (this.insertOnly) {
					//    $('#budgetTbl').dzt('setCommit', false);
					//    $('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					//    if ($('#tradeTbl').dzt('getValueAll').length < 1) {
					//        $('#btnTradeAdd').click();
					//    } else {
					//        $('#budgetTbl').dzt('setCommit', false);
					//        $('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					//        $('#tradeTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
					//    }
					//}

					fnSetBudgetDisplay();
				} else if (resultCode === 'EXCEED') {
					alert('${CL.ex_exceedMesage}');

					$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
						insertStat : resultCode,
						insertMsg : '${CL.ex_exceedMesage}'
					}, false);
					// throw '사용자 예산 입력 초과';
				} else {
					console.log('##### 서버 오류 발생 #####');
					console.log(result.result);
					$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), {
						insertStat : resultCode
					}, false);
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## budget (예산내역) - 수정 ## */
	var preBudgetInfo = null;
	function fnBudgetUpdate(key) {
		if (resetBudgetSize > 1){
			resetBudgetSize = resetBudgetSize - 1;
			return;
		}

		key = (key || '');
		// Option.Common.SetFocusAmtUpdate();

		/* [ parameter ] */
		var parameter = {};

		parameter.resDocSeq = ''; /* [*]결의문서 키 */
		parameter.resSeq = ''; /* [*]결의서 키 */
		parameter.budgetSeq = ''; /* [*]예산 키 */
		parameter.erpBqSeq = ''; /* [*]ERP 연동 품의서 키 */
		parameter.erpBkSeq = ''; /* [*]ERP 연동 품의 예산 키 */
		parameter.erpBudgetSeq = ''; /* [*]ERP 예산과목 코드 (예산단위 코드) */
		parameter.erpBudgetName = ''; /* [*]ERP 예산과목 명칭 (예산단위 명칭) */
		parameter.erpBizplanSeq = ''; /* [*]ERP 사업계획 코드 */
		parameter.erpBizplanName = ''; /* [*]ERP 사업계획 명칭 */
		parameter.erpFiacctName = ''; /* [*]ERP 회계계정 코드 */
		parameter.erpFiacctSeq = ''; /* [*]ERP 회계계정 명칭 */
		parameter.erpBgt1Name = ''; /* [*]관 명칭 */
		parameter.erpBgt1Seq = ''; /* [*]관 코드 */
		parameter.erpBgt2Name = ''; /* [*]항 명칭 */
		parameter.erpBgt2Seq = ''; /* [*]항 코드 */
		parameter.erpBgt3Name = ''; /* [*]목 명칭 */
		parameter.erpBgt3Seq = ''; /* [*]목 코드 */
		parameter.erpBgt4Name = ''; /* [*]세 명칭 */
		parameter.erpBgt4Seq = ''; /* [*]세 코드 */
		parameter.erpOpenAmt = ''; /* [*]ERP 예산 편성 금액 */
		parameter.erpApplyAmt = ''; /* [*]ERP 집행액 */
		parameter.erpLeftAmt = ''; /* [*]ERP 잔액 */
		parameter.budgetStdAmt = ''; /* [*]공급가액 */
		parameter.budgetTaxAmt = ''; /* [*]부가세 */
		parameter.budgetAmt = ''; /* [*]총금액 */
		parameter.erpBgacctSeq = ''; /* [*]예산 계정 코드 */
		parameter.erpBgacctName = ''; /* [*]예산 계정 명칭 */
		parameter.setFgCode = ''; /* [*]결제수단 코드 */
		parameter.setFgName = ''; /* [*]결제수단 명칭 */
		parameter.vatFgCode = ''; /* [*]과세구분 코드 */
		parameter.vatFgName = ''; /* [*]과세구분 명칭 */
		parameter.trFgCode = ''; /* [*]채주유형 코드 */
		parameter.trFgName = ''; /* [*]재추유형 명칭 */
		parameter.ctlFgCode = ''; /* [*]미사용? */
		parameter.ctlFgName = ''; /* [*]미사용? */
		parameter.budgetNote = ''; /* [*]예산 적요 */
		parameter.erpDivSeq = ''; /* ERP 회계단위 코드 */
		parameter.erpDivName = ''; /* ERP 회계단위 명칭 */
		parameter.empSeq = ''; /* GW 사용자코드 */

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var resData = $('#resTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, resData))); /* 작성중인 결의정보 정보 */
		parameter.erpGisuDate = (resData.resDate || '').toString().replace(/-/g, '');
		parameter.expendDate = (resData.resDate || '').toString().replace(/-/g, '');

		var budgetData = $('#budgetTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 정보 */

		/* 예산회계단위 보정 */
		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = (parameter.erpPcSeq || ''); /* ERP 사업장 명칭 */
			parameter.erpDivName = (parameter.erpPcName || ''); /* ERP 사업장 명칭 */
		} else if (Option.Common.iCUBE()) {
			parameter.erpBudgetDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpBudgetDivName = $('#lbErpDivName').val();
		}

		/* 부가세 통제 여부 체크 */
		if(Option.Common.ERPiU()){
			if( optionSet.erp["YN_JITAX"].CD_ENV == 'Y' ){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'U_YN_JITAX_Y';
			}else {
				if(budgetData.vatFgCode == 4){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_4';
				} else if(budgetData.vatFgCode == 3){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_3';
				} else{
					parameter.ctlFgCode = '0';
					parameter.ctlFgName = 'U_YN_JITAX_N';
				}
			}
		}else if(Option.Common.iCUBE()){
			if (optionSet.erpEmpInfo.vatControl == '1' || (budgetData.trFgCode=='4' || budgetData.trFgCode=='8' || budgetData.trFgCode=='9')){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'I_IN_TAX_Y';
			}else {
				parameter.ctlFgCode = '0';
				parameter.ctlFgName = 'I_IN_TAX_N';
			}
		}

		/*
			예산금액 보전이 필요한 경우 (뒤로가기 등.)
			서버에 금액 정보 null 전송시 금액 정보 업데이트 하지 않음.
		 */
		if ((parameter.erpBudgetSeq != '') && (parameter.erpOpenAmt == '')) {
			parameter.erpOpenAmt = null;
			parameter.erpApplyAmt = null;
			parameter.erpLeftAmt = null;
		}

		if(JSON.stringify(preBudgetInfo) == JSON.stringify(parameter)){
			return;
		}else{
			preBudgetInfo = clone(parameter);
		}

		parameter.budgetNote = parameter.budgetNote.replaceAll('\\','');
		parameter = fnBudgetDataCurrection(parameter);


		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResBudgetUpdate.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, budgetSeq, erpBqSeq, erpBkSeq, erpBudgetSeq, erpBudgetName, erpBizplanSeq, erpBizplanName, erpBgt1Name, erpBgt1Seq, erpBgt2Name, erpBgt2Seq, erpBgt3Name, erpBgt3Seq, erpBgt4Name, erpBgt4Seq, erpOpenAmt, erpApplyAmt, erpLeftAmt, budgetStdAmt, budgetTaxAmt, budgetAmt, erpBgacctSeq, erpBgacctName, setFgCode, setFgName, vatFgCode, vatFgName, trFgCode, trFgName, ctlFgCode, ctlFgName, budgetNote, erpDivSeq, erpDivName, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			extendParam : {
				key : key
			},
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				/* resultCode : EXCEED >> 예산초과 */
				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 예산정보 갱신 ( 금회집행 ) */
					$('#lbBudgetAmt').html(Option.Common.GetNumeric(aData.tryAmt || '0'));

					$('#budgetTbl').dzt('setCommit', false);
					$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#tradeTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */

					var budgetRefresh = [ 'erpBudgetName', 'erpBizplanName', 'erpBgacctName', 'erpMgtName', 'erpBudgetName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt' ];

					// TODO : this.extendParam가 undefined인 경우가 있음.
					if ((!this.extendParam) || budgetRefresh.indexOf(this.extendParam.key) > -1) {
						fnSetBudgetDisplay();
					}

				} else if (resultCode === 'EXCEED') {
					alert('${CL.ex_exceedMesage}');
					// throw 'Auto commit error';
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	function clone(obj) {
	  if (obj === null || typeof(obj) !== 'object')
	  return obj;

	  var copy = obj.constructor();

	  for (var attr in obj) {
	    if (obj.hasOwnProperty(attr)) {
	      copy[attr] = obj[attr];
	    }
	  }

	  return copy;
	}

	/* ## budget (예산내역) - 조회 ## */
	function fnBudgetSelect(resDocSeq, resSeq, budgetSeq) {
		// Option.Common.SetFocusAmtUpdate();
		/* [ parameter ] */
		/*   - resDocSeq : 조회 대상 결의문서 키 */
		resDocSeq = (resDocSeq || '');
		/*   - resSeq : 조회 대상 결의서 키 */
		resSeq = (resSeq || '');
		/*   - budgetSeq : 조회 대상 예산 키 */
		budgetSeq = (budgetSeq || '');

		if (resDocSeq === '' || resSeq === '') {
			console.error('fnBudgetSelect - not exists ( resDocSeq, resSeq )');
			return;
		}

		/* [ ajax parameter ] */
		var parameter = {};
		parameter.resDocSeq = resDocSeq;
		parameter.resSeq = resSeq;
		parameter.budgetSeq = budgetSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResBudgetList.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, budgetSeq */
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : resDocSeq,
			resSeq : resSeq,
			budgetSeq : budgetSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				/* 예산내역 테이블 초기화 */
				$('#budgetTbl').dzt('setReset');

				/* 반환 데이터 기준으로 행 추가 및 값 반영 */
				var aaData = Option.Common.GetResult(result, 'aaData');
				$.each(aaData, function(idx, item) {
					fnEventBudgetAdd(false);
					var uid = $('#budgetTbl').dzt('getUID');
					$('#budgetTbl').dzt('setValue', uid, item, false);
				});

				/* 2018. 07. 17. 참조품의의 경우 예산정보 강제 조회 처리 */
				if (aaData.length > 0) {
					fnSetBudgetDisplay();
				}

				/* 행이 존재하지 않는 경우 기본 행 추가 */
				if (aaData.length < 1) {
					$('#btnBudgetAdd').click();
				}

				if (Option.Common.iCUBE()){
					optionSet.erpGisu.gisu = $('#resTbl').dzt('getValue').erpGisu
					optionSet.erpGisu.fromDate = $('#resTbl').dzt('getValue').erpGisuFromDate
					optionSet.erpGisu.toDate = $('#resTbl').dzt('getValue').erpGisuToDate
				}
				/* 기수정보 재출력 */
				fnShowGisuInfo();
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		// Option.Common.SetFocusAmtUpdate();

		/* [ return ] */
		return;
	}

	/* ## budget (예산내역) - 필수값 ${CL.ex_check} ## */
	function fnBudgetChkValue(addType) {
		addType = (typeof addType === 'undefined' ? true : addType);

		/* 반환 변수 정의 */
		var resultValue = {
			/* 필수값 점검 결과 [true, false] */
			sts : false,
			key : '',
			msg : ''
		};

		/* 최초 입력 여부 ${CL.ex_check} */
		if ($('#budgetTbl').dzt('getValueAll').length === 0) {
			resultValue.sts = true;
			return resultValue;
		}

		var budgetData = $('#budgetTbl').dzt('getValue');

		if (Option.Common.ERPiU()) {
			/* ERPiU 필수값 점검 */
			if (addType && ((budgetData.erpBudgetName || '') === '' || (budgetData.erpBudgetSeq || '') === '')) {
				/* Step1. 예산단위 ( 예산단위 코드 ) - erpBudgetName, erpBudgetSeq */
				resultValue.sts = false;
				resultValue.key = 'erpBudgetName';
				resultValue.msg = '예산단위가 입력되지 않았습니다.';
			} else if (addType && (Option.ERPiU.GetBizplanStat() === 'Y' && ((budgetData.erpBizplanName || '') === '' || (budgetData.erpBizplanSeq || '') === ''))) {
				/* Step2. 사업계획 ( 사업계획 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'erpBizplanName';
				resultValue.msg = '사업계획이 입력되지 않았습니다.';
			} else if (addType && ((budgetData.erpBgacctName || '') === '' || (budgetData.erpBgacctSeq || '') === '')) {
				/* Step3. 예산계정 ( 예산계정 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'erpBgacctName';
				resultValue.msg = '예산계정이 입력되지 않았습니다.';
			} else if (addType && ((budgetData.setFgCode || '') === '' || (budgetData.setFgName || '') === '')) {
				/* Step4. 결제수단 ( 결제수단 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'setFgName';
				if ((budgetData.confferBudgetSeq || '') !== '') {
					resultValue.msg = '';
				} else {
					resultValue.msg = '${CL.ex_noPaymentMessage}';
				}
			} else if (addType && ((budgetData.vatFgCode || '') === '' || (budgetData.vatFgName || '') === '')) {
				/* Step5. 과세구분 ( 과세구분 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'vatFgName';
				resultValue.msg = '${CL.ex_noClassMessagee}';
			} else if (addType && ((budgetData.trFgCode || '') === '' || (budgetData.trFgName || '') === '')) {
				/* Step6. 채주유형 ( 채주유형 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'trFgName';
				resultValue.msg = '${CL.ex_noCollectionTypeMessage}';
			} else {
				resultValue.sts = true;
			}
		} else if (Option.Common.iCUBE()) {
			/* iCUBE 필수값 점검 */
			if (addType && ((budgetData.erpBudgetName || '') === '' || (budgetData.erpBudgetSeq || '') === '')) {
				/* Step1. 예산과목 ( 예산과목 코드 ) - erpBudgetName, erpBudgetSeq */
				resultValue.sts = false;
				resultValue.key = 'erpBudgetName';
				resultValue.msg = '${CL.ex_noBudgetItemMessage}';
			} else if (addType && ((budgetData.setFgCode || '') === '' || (budgetData.setFgName || '') === '')) {
				/* Step4. 결제수단 ( 결제수단 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'setFgName';
				if ((budgetData.confferBudgetSeq || '') !== '') {
					resultValue.msg = '';
				} else {
					resultValue.msg = '${CL.ex_noPaymentMessage}';
				}
			} else if (addType && ((budgetData.vatFgCode || '') === '' || (budgetData.vatFgName || '') === '')) {
				/* Step5. 과세구분 ( 과세구분 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'vatFgName';
				resultValue.msg = '${CL.ex_noClassMessagee}';
			} else if (addType && ((budgetData.trFgCode || '') === '' || (budgetData.trFgName || '') === '')) {
				/* Step6. 채주유형 ( 채주유형 코드 ) */
				resultValue.sts = false;
				resultValue.key = 'trFgName';
				resultValue.msg = '${CL.ex_noCollectionTypeMessage}';
			} else if(addType && ((budgetData.erpDivName || '') === '' || (budgetData.erpDivSeq || '') === '')){
				/* Step7. 회계단위 ( 회계단위 코드 ) */
				if(optionSet.gw['3']['10'].setValue == '1' ){
					/* 회계단위 코드 필수 미사용의 경우 */
					resultValue.sts = true;
				} else {
					resultValue.sts = false;
					resultValue.key = 'erpDivName';
					resultValue.msg = '${CL.ex_noAccountingUnitMessage}';
				}
			}
			else {
				resultValue.sts = true;
			}

		} else {
			console.error('연동 ERP 정보를 ${CL.ex_check}할 수 없습니다. [ERPiU, iCUBE]');
			resultValue.sts = false;
			resultValue.key = '';
			resultValue.msg = '연동 ERP 정보를 ${CL.ex_check}할 수 없습니다. [ERPiU, iCUBE]';
			return false;
		}

		return resultValue;
	}

	/* ## trade ## */
	/* ====================================================================================================================================================== */
	/* ## trade (결제내역) - 생성 ## */
	function fnTradeInsert() {
		/* [ parameter ] */
		var parameter = {};
		// Option.Common.SetFocusAmtUpdate();

		parameter.resDocSeq = ''; /* [*]결의문서 키 */
		parameter.resSeq = ''; /* [*]결의서 키 */
		parameter.budgetSeq = ''; /* [*]예산 키 */
		parameter.erpIsuDt = ''; /* G20 연동 키 */
		parameter.erpIsuSq = ''; /* G20 연동 키 */
		parameter.erpInSq = ''; /* G20 연동 키 */
		parameter.erpBqSq = ''; /* G20 연동 키 */
		parameter.itemName = ''; /* [*]물품명 */
		parameter.itemCnt = ''; /* [*]수량 */
		parameter.empName = ''; /* GW 사용자 명칭 */
		parameter.trSeq = ''; /* [*]거래처 코드 */
		parameter.trName = ''; /* [*]거래처 명칭 */
		parameter.ceoName = ''; /* [*]대표자 명칭 */
		parameter.tradeAmt = ''; /* [*]금액 */
		parameter.tradeStdAmt = ''; /* [*]공급가액 */
		parameter.tradeVatAmt = ''; /* [*]부가세 */
		parameter.jiroSeq = ''; /* 미사용? */
		parameter.jiroName = ''; /* 미사용? */
		parameter.baNb = ''; /* [*]계좌 번호 */
		parameter.btrSeq = ''; /* [*]금융기관 코드 */
		parameter.btrName = ''; /* [*]금융기관 명 */
		parameter.depositor = ''; /* [*]예금주 */
		parameter.tradeNote = ''; /* [*]채주 비고 */
		parameter.ctrSeq = ''; /* 법인카드 - 카드거래처 */
		parameter.ctrName = ''; /* 법인카드 - 카드거래처 */
		parameter.regDate = ''; /* [*]신고 기준일 */
		parameter.interfaceType = ''; /* 미사용? */
		parameter.interfaceSeq = ''; /* 미사용? */
		parameter.empSeq = ''; /* GW 사용자 코드 */

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var budgetData = $('#budgetTbl').dzt('getValue');
		/* 중복예산 상신 데이터 보정 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 정보 */

		var resData = $('#resTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, resData))); /* 작성중인 결의정보 정보 */
		parameter.erpGisuDate = (resData.resDate || '').toString().replace(/-/g, '');
		parameter.expendDate = (resData.resDate || '').toString().replace(/-/g, '');

		var tradeData = $('#tradeTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, tradeData))); /* 작성중인 결제내역 정보 */

		var special_pattern = /[\']/gi;

		/* 채주 데이터 검증 진행 [validate] */
		/* 대표자명 입력 글자수 제한 */
		if( ( tradeData.ceoName || '' ).length > 30){
			alert("대표자명 입력은 최대 30자 제한입니다.");
			return;
		}

		if(tradeData.tradeNote.length > 80){
			alert('${CL.ex_note3}는 80자를 초과하여 입력할 수 없습니다.');
			return;
		} else if(special_pattern.test(resData.resNote)){
			/*비고(채주) 특수문자 체크*/
			alert('${CL.ex_note3}는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
			return ;
		} else if( Option.Common.ERPiU() ){
			if( Option.ERPiU.GetTradeNoteReqYN() == YES ){
				if(!tradeData.tradeNote){
					alert('${CL.ex_note2}를 입력 하세요.');
					return;
				}
			}
		}

		if(
				( budgetData.trFgCode != '2' )
				&& ( budgetData.trFgCode != '3' )
				&& ( budgetData.trFgCode != '4' )
				&& ( budgetData.trFgCode != '8' )
				&& ( budgetData.trFgCode != '9' )
				&& ( tradeData.trSeq == '' )
				&& (!tradeData.interfaceType)
		){
			alert('거래처 정보를 ${CL.ex_check}해주세요.');
			return;
		}

		/* 회계단위 통제 */
		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = (parameter.erpBizSeq || ''); /* ERP 사업장 명칭 */
			parameter.erpDivName = (parameter.erpBizName || ''); /* ERP 사업장 명칭 */
			parameter.divSeq = (parameter.erpBizSeq || ''); /* ERP 사업장 명칭 */
			parameter.divName = (parameter.erpBizName || ''); /* ERP 사업장 명칭 */

			if(!parameter.etcBelongDate) { parameter.etcBelongDate = ''; }
			if(!parameter.etcBelongYearmonth) { parameter.etcBelongYearmonth = ''; }
		} else if (Option.Common.iCUBE()) {
			parameter.erpBudgetDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpBudgetDivName = $('#lbErpDivName').val();
			parameter.divSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.divName = $('#lbErpDivName').val();
			parameter.noTaxCode = '';
			parameter.noTaxName = '';
			if(!parameter.etcBelongDate) { parameter.etcBelongDate = ''; }
			if(!parameter.etcBelongYearmonth) { parameter.etcBelongYearmonth = ''; }
		}

		/* 부가세 통제 여부 체크 */
		if(Option.Common.ERPiU()){
			if( optionSet.erp["YN_JITAX"].CD_ENV == 'Y' ){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'U_YN_JITAX_Y';
			}else {
				if(budgetData.vatFgCode == 4){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_4';
				} else if(budgetData.vatFgCode == 3){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_3';
				} else{
					parameter.ctlFgCode = '0';
					parameter.ctlFgName = 'U_YN_JITAX_N';
				}
			}
		}else if(Option.Common.iCUBE()){
			if (optionSet.erpEmpInfo.vatControl == '1' || (budgetData.trFgCode=='4' || budgetData.trFgCode=='8' || budgetData.trFgCode=='9')){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'I_IN_TAX_Y';
			}else {
				parameter.ctlFgCode = '0';
				parameter.ctlFgName = 'I_IN_TAX_N';
			}
		}

		parameter.tradeNote = parameter.tradeNote.replaceAll('\\','');
		if((parameter.interfaceType||'')=='etax'){
			parameter.trSeq = '';
		}

		/* int파라미터 데이터 보정 진행 */
		parameter = fnTradeDataCurrection(parameter);
		parameter.baNb = parameter.baNb.replace("'","");
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResTradeInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, budgetSeq, erpIsuDt, erpIsuSq, erpInSq, erpBqSq, itemNm, itemCnt, empNm, trSeq, trName, ceoName, tradeAmt, tradeStdAmt, tradeVatAmt, jiroSeq, jiroName, baNb, btrSeq, btrName, depositor, tradeNote, ctrSeq, ctrName, regDate, interfaceType, interfaceSeq, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			extendParam : {
				resSeq : parameter.resSeq,
				budgetSeq : parameter.budgetSeq,
				tradeAmt : parameter.tradeAmt,
				tradeStdAmt : parameter.tradeStdAmt,
				tradeVatAmt : parameter.tradeVatAmt
			},
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);
				var btnId = 'btnTradeInsert'

				if (resultCode === 'SUCCESS') {
					/* 예산정보 갱신 ( 금회집행 ) */
					$('#lbBudgetAmt').html(Option.Common.GetNumeric(aData.tryAmt || '0'));
					/* 예산정보 갱신 ( 예산잔액 = 예산잔액 - 금회집행) */
					var resUid = $('#resTbl').dzt('getUID');
					var confferBalanceAmt = $('#resTbl').dzt('getValue', resUid).confferBalanceAmt;
					var confferResultBalanceAmt = $('#resTbl').dzt('getValue', resUid).confferResultBalanceAmt;
					var balanceAmt = $('#resTbl').dzt('getValue', resUid).balanceAmt;
					if (confferBalanceAmt !== undefined) {
						$('#lbGwBalanceAmt').html(Option.Common.GetNumeric((confferResultBalanceAmt || '0') - aData.budgetAmt));
					} else {
						$('#lbGwBalanceAmt').html(Option.Common.GetNumeric((balanceAmt || '0') - aData.budgetAmt));
					}

					/* 현재행의 uid 조회 */
					var uid = $('#tradeTbl').dzt('getUID');

					/* 결의서 시퀀스 반영 ( resSeq ) */
					$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), {
						tradeSeq : (aData.tradeSeq || '').toString(),
						insertStat : resultCode
					}, false);

					/* 카드 연동인 경우 별도 거래처 코드 반영 필요 */
					if ((aData.nTr || '') === 'Y') {
						var trInfo = {
							trSeq : aData.trSeq,
							trFgCode : aData.trFgCode,
							trFgName : aData.trFgName,
							businessNb : aData.businessNb,
							depositor : aData.depositor,
							ceoName : aData.ceoName,
							jiroSeq : aData.jiroSeq,
							jiroName : aData.jiroName,
							baNb : aData.baNb,
							btrSeq : aData.btrSeq,
							btrName : aData.btrName,
						};

						var tradeUid = $('#tradeTbl').dzt('getUID');
						$('#tradeTbl').dzt('setValue', tradeUid, trInfo, false);

						delete aData['trSeq'];
						delete aData['trFgCode'];
						delete aData['trFgName'];
						delete aData['businessNb'];
						delete aData['depositor'];
						delete aData['ceoName'];
						delete aData['jiroSeq'];
						delete aData['jiroName'];
						delete aData['btrSeq'];
						delete aData['btrName'];
						delete aData['baNb'];
					}

					$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), {
						insertStat : resultCode
					}, false);

					$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
						insertStat : resultCode,
					}, false);
					Option.Common.SetFocusAmtUpdate();

					// Option.Common.SetAmtUpdate(this.extendParam.resSeq, this.extendParam.budgetSeq, aData.tradeSeq, this.extendParam.tradeAmt, this.extendParam.tradeStdAmt, this.extendParam.tradeVatAmt);
					fnSetBudgetDisplay(btnId);

				} else if (resultCode === 'EXCEED') {
					alert('${CL.ex_exceedMesage}');

					$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
						insertStat : resultCode,
						insertMsg : '${CL.ex_exceedMesage}'
					}, false);

					var exceedTradeInfo = $('#tradeTbl').dzt('getValue');
					if(!! ( exceedTradeInfo.interfaceType || '' ) ){
						var exceedTargetTr = $('#tradeTbl').dzt('getSelectedRow');
						$(exceedTargetTr).dzt('setRemoveRow', $(exceedTargetTr));
					}
				} else {
					$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), {
						insertStat : resultCode
					}, false);
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## trade (결제내역) - 수정 ## */
	function fnTradeUpdate(key) {
		key = (key || '');
		// Option.Common.SetFocusAmtUpdate();

		/* [ parameter ] */
		var parameter = {};
		Option.Common.SetFocusAmtUpdate();

		parameter.resDocSeq = ''; /* [*]결의문서 키 */
		parameter.resSeq = ''; /* [*]결의서 키 */
		parameter.budgetSeq = ''; /* [*]예산 키 */
		parameter.tradeSeq = ''; /* [*]채주 키 */
		parameter.erpIsuDt = ''; /* G20 연동 키 */
		parameter.erpIsuSq = ''; /* G20 연동 키 */
		parameter.erpInSq = ''; /* G20 연동 키 */
		parameter.erpBqSq = ''; /* G20 연동 키 */
		parameter.itemName = ''; /* [*]물품명 */
		parameter.itemCnt = ''; /* [*]수량 */
		parameter.empName = ''; /* GW 사용자 명칭 */
		parameter.trSeq = ''; /* [*]거래처 코드 */
		parameter.trName = ''; /* [*]거래처 명칭 */
		parameter.ceoName = ''; /* [*]대표자 명칭 */
		parameter.tradeAmt = ''; /* [*]금액 */
		parameter.tradeStdAmt = ''; /* [*]공급가액 */
		parameter.tradeVatAmt = ''; /* [*]부가세 */
		parameter.jiroSeq = ''; /* 미사용? */
		parameter.jiroName = ''; /* 미사용? */
		parameter.baNb = ''; /* [*]계좌 번호 */
		parameter.btrSeq = ''; /* [*]금융기관 코드 */
		parameter.btrName = ''; /* [*]금융기관 명 */
		parameter.depositor = ''; /* [*]예금주 */
		parameter.tradeNote = ''; /* [*]채주 비고 */
		parameter.ctrSeq = ''; /* [*]법인카드 - 카드거래처 */
		parameter.ctrName = ''; /* [*]법인카드 - 카드거래처 */
		parameter.regDate = ''; /* [*]신고 기준일 */
		parameter.interfaceType = ''; /* 미사용? */
		parameter.interfaceSeq = ''; /* 미사용? */
		parameter.empSeq = ''; /* GW 사용자 코드 */

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var resData = $('#resTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, resData))); /* 작성중인 결의정보 정보 */
		parameter.erpGisuDate = (resData.resDate || '').toString().replace(/-/g, '');
		parameter.expendDate = (resData.resDate || '').toString().replace(/-/g, '');

		var budgetData = $('#budgetTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 정보 */

		var tradeData = $('#tradeTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, tradeData))); /* 작성중인 결제내역 정보 */

		/* 대표자명 입력 글자수 제한 */
		if( ( tradeData.ceoName || '' ).length > 30){
			alert("대표자명 입력은 최대 30자 제한입니다.");
			return;
		}
		// 채주데이터 검증 전 오류 값이 없을 경우에 대한 대처 추가 (2022-02-21)
		if(tradeData.tradeNote == null){
			tradeData.tradeNote = '';
			parameter.tradeNote = '';
		}
		/* 채주 데이터 검증 진행 [validate] */
		if(tradeData.tradeNote.length > 80){
			alert('${CL.ex_note3}는 80자를 초과하여 입력할 수 없습니다.');
			return;
		} else if( Option.Common.ERPiU() ){
			if( Option.ERPiU.GetTradeNoteReqYN() == YES ){
				if(!tradeData.tradeNote){
					alert('${CL.ex_note3}를 입력 하세요.');
					return;
				}
			}
		}

		if(
				( budgetData.trFgCode != '2' )
				&& ( budgetData.trFgCode != '3' )
				&& ( budgetData.trFgCode != '4' )
				&& ( budgetData.trFgCode != '8' )
				&& ( budgetData.trFgCode != '9' )
				&& ( tradeData.trSeq == '' )
				&& (!tradeData.interfaceType)
		){
			alert('거래처 정보를 ${CL.ex_check}해주세요.');
			return;
		}

		/* 회계단위 데이터 보정 */
		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = (parameter.erpBizSeq || ''); /* ERP 사업장 명칭 */
			parameter.erpDivName = (parameter.erpBizName || ''); /* ERP 사업장 명칭 */
			parameter.divSeq = (parameter.erpBizSeq || ''); /* ERP 사업장 명칭 */
			parameter.divName = (parameter.erpBizName || ''); /* ERP 사업장 명칭 */
			if(!parameter.etcBelongDate) { parameter.etcBelongDate = ''; }
			if(!parameter.etcBelongYearmonth) { parameter.etcBelongYearmonth = ''; }
		} else if (Option.Common.iCUBE()) {
			parameter.erpBudgetDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpBudgetDivName = $('#lbErpDivName').val();
			parameter.erpDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.divSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.divName = $('#lbErpDivName').val();
			parameter.noTaxCode = '';
			parameter.noTaxName = '';
			if(!parameter.etcBelongDate) { parameter.etcBelongDate = ''; }
			if(!parameter.etcBelongYearmonth) { parameter.etcBelongYearmonth = ''; }
			if(parameter.trFgCode=='4' && !parameter.etcDataCd){
				parameter.etcDataCd = 'G';
			}
			if(parameter.trFgCode=='9' && !parameter.etcDataCd){
				parameter.etcDataCd = 'F';
			}
		}

		/* 부가세 통제 여부 체크 */
		if(Option.Common.ERPiU()){
			if( optionSet.erp["YN_JITAX"].CD_ENV == 'Y' ){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'U_YN_JITAX_Y';
			}else {
				if(budgetData.vatFgCode == 4){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_4';
				} else if(budgetData.vatFgCode == 3){
					parameter.ctlFgCode = '1';
					parameter.ctlFgName = 'U_VAT_FG_3';
				} else{
					parameter.ctlFgCode = '0';
					parameter.ctlFgName = 'U_YN_JITAX_N';
				}
			}
		}else if(Option.Common.iCUBE()){
			if (optionSet.erpEmpInfo.vatControl == '1' || (budgetData.trFgCode=='4' || budgetData.trFgCode=='8' || budgetData.trFgCode=='9')){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'I_IN_TAX_Y';
			}else {
				parameter.ctlFgCode = '0';
				parameter.ctlFgName = 'I_IN_TAX_N';
			}
		}



		parameter.tradeNote = parameter.tradeNote.replaceAll('\\','');

		if(tradeData.etcDataCd=='BI'){
			tradeData.etcEmploymentAmt = '0';
			tradeData.etcEmploymentInsuranceAmt = '0';
		}

		/* int파라미터 데이터 보정 진행 */
		parameter = fnTradeDataCurrection(parameter);

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResTradeUpdate.do',
			datatype : 'json',
			async : false,
			data : Option.Common.GetSaveParam(parameter),
			extendParam : {
				resSeq : parameter.resSeq,
				budgetSeq : parameter.budgetSeq,
				tradeSeq : parameter.tradeSeq,
				tradeAmt : parameter.tradeAmt,
				tradeStdAmt : parameter.tradeStdAmt,
				tradeVatAmt : parameter.tradeVatAmt,
				key : key
			},
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 예산정보 갱신 ( 금회집행 ) */
					$('#lbBudgetAmt').html(Option.Common.GetNumeric(aData.tryAmt || '0'));
					/* 예산정보 갱신 ( 예산잔액 = 예산잔액 - 금회집행) */
					var resUid = $('#resTbl').dzt('getUID');
					var confferBalanceAmt = $('#resTbl').dzt('getValue', resUid).confferBalanceAmt;
					var balanceAmt = 0;
					if(!result.result.aData.balanceAmt){
						balanceAmt = $('#resTbl').dzt('getValue', resUid).balanceAmt;
					}else{
						balanceAmt = result.result.aData.balanceAmt;
					}


					if (confferBalanceAmt !== undefined) {
						$('#lbGwBalanceAmt').html(Option.Common.GetNumeric((confferBalanceAmt || '0') - aData.tryAmt));
					} else {
						$('#lbGwBalanceAmt').html(Option.Common.GetNumeric((balanceAmt || '0')));
					}


					/*if (confferBalanceAmt !== undefined) {
						$('#lbGwBalanceAmt').html(Option.Common.GetNumeric( parseInt(confferBalanceAmt || '0') - aData.tryAmt));
					} else {
						$('#lbGwBalanceAmt').html(Option.Common.GetNumeric( parseInt(balanceAmt || '0') ) );
					}*/

					var budgetRefresh = [ 'erpBudgetName', 'erpBizplanName', 'erpBgacctName', 'erpMgtName', 'erpBudgetName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt' ];

					// TODO : this.extendParam가 undefined인 경우가 있음.
					if ((!this.extendParam) || budgetRefresh.indexOf(this.extendParam.key) > -1) {
						fnSetBudgetDisplay();
					}

					/* 금액 갱신 */
					// Option.Common.SetAmtUpdate(this.extendParam.resSeq, this.extendParam.budgetSeq, aData.tradeSeq, this.extendParam.tradeAmt, this.extendParam.tradeStdAmt, this.extendParam.tradeVatAmt);
					// Option.Common.SetFocusAmtUpdate();
					fnSetBudgetDisplay();

				} else if (resultCode === 'EXCEED') {
					alert('${CL.ex_exceedMesage}');

					$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
						insertStat : resultCode,
						insertMsg : '${CL.ex_exceedMesage}'
					}, false);
					// throw 'Auto commit error';
				} else {
					$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), {
						insertStat : resultCode
					}, false);
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	var preBudgetSeq = null;
	/* ## trade (결제내역) - 조회 ## */
	function fnTradeSelect(resDocSeq, resSeq, budgetSeq, tradeSeq) {
		/* 상배 / 임시 최적화 포커스 되어있는 예산이면 조회하지 않음. */
		if (preBudgetSeq == budgetSeq && $('#tradeTbl').dzt('getValueAll').length > 0) {
			return;
		}

		/* [ parameter ] */
		/*   - resDocSeq : 조회 대상 결의문서 키 */
		resDocSeq = (resDocSeq || '');
		/*   - resSeq : 조회 대상 결의서 키 */
		resSeq = (resSeq || '');
		/*   - budgetSeq : 조회 대상 예산 키 */
		budgetSeq = (budgetSeq || '');
		/*   - budgetSeq : 조회 대상 채주 키 */
		tradeSeq = (tradeSeq || '');

		if (resDocSeq === '' || resSeq === '' || budgetSeq === '') {
			console.error('fnBudgetSelect - not exists ( resDocSeq, resSeq, budgetSeq )');
			return;
		}

		/* [ ajax parameter ] */
		var parameter = {};
		parameter.resDocSeq = resDocSeq;
		parameter.resSeq = resSeq;
		parameter.budgetSeq = budgetSeq;
		parameter.tradeSeq = tradeSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResTradeList.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : resDocSeq,
			resSeq : resSeq,
			budgetSeq : budgetSeq,
			tradeSeq : tradeSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				/* 결제내역 테이블 초기화 */
				$('#tradeTbl').dzt('setReset');

				/* 반환 데이터 기준으로 행 추가 및 값 반영 */
				var aaData = Option.Common.GetResult(result, 'aaData');
				$.each(aaData, function(idx, item) {
					$('#btnTradeAdd').click();
					var uid = $('#tradeTbl').dzt('getUID');
					console.log('ResTradeList.do / uid : ' + uid + 'item' + item);
					$('#tradeTbl').dzt('setValue', uid, item);
				});

				/* 예산조회 */
				fnSetBudgetDisplay();
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		// Option.Common.SetFocusAmtUpdate();

		/* [ return ] */
		return;
	}

	/* ## trade (결제내역) - 필수값 ${CL.ex_check} ## */
	function fnTradeChkValue() {
		/* 반환 변수 정의 */
		var resultValue = {
			/* 필수값 점검 결과 [true, false] */
			sts : false,
			key : '',
			msg : ''
		};

		/* 최초 입력 여부 ${CL.ex_check} */
		if ($('#tradeTbl').dzt('getValueAll').length === 0) {
			resultValue.sts = true;
			return resultValue;
		}

		var budgetData = $('#budgetTbl').dzt('getValue');
		var tradeData = $('#tradeTbl').dzt('getValue');

		/* [ERPiU] : 결제수단 [예금(1), 현금(2), 외상(3), 신용카드(4)] */
		/* [iCUBE] : 결제수단 [예금(1), 현금(2), 외상(3), 신용카드(4)] */
		var setFgCode = (budgetData.setFgCode || '');
		/* [ERPiU] : 과세구분 [과세(1), 면세(2), 기타(3)] */
		/* [iCUBE] : 과세구분 [과세(1), 면세(2), 기타(3)] */
		var vatFgCode = (budgetData.vatFgCode || '');
		/* [ERPiU] : 채주유형 [거래처등록(1), 사원등록(2), 거래처명(3), 기타소득자(4), 사업소득자(6)] */
		/* [iCUBE] : 채주유형 [거래처등록(1), 사원등록(2), 거래처명(3), 기타소득자(4), 기금(5), 운영비(6), 결연자(7), 급여(8), 사업소득자(9)] */
		var trFgCode = (budgetData.trFgCode || '');

		if (Option.Common.ERPiU()) {
			/* ERPiU 필수값 점검 */
			if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '1' && trFgCode === '1') {
				/* (예금 or 현금 or 외상 or 신용카드) && 과세 && 거래처등록 */
				if ((tradeData.trName || '') === '' || (tradeData.trSeq || tradeData.interfaceSeq || tradeData.issNo || '') === '' ) {
					/* Step1. 거래처 */                                   /* 법인카드 승인건 예외    전자세금계산서 예외*/
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				} else if ((tradeData.businessNb || '') === '') {
					/* Step2. 사업자번호 */
					resultValue.sts = false;
					resultValue.key = 'businessNb';
					resultValue.msg = '사업자번호가 입력되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeVatAmt || '') === '') {
					/* Step5. 부가세 */
					resultValue.sts = false;
					resultValue.key = 'tradeVatAmt';
					resultValue.msg = '부가세가 입력되지 않았습니다.';
				} else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0' ) {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			} else if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '2' && trFgCode === '1') {
				/* (예금 or 현금 or 외상 or 신용카드) && 면세 && 거래처등록 */
				if ((tradeData.trName || '') === '' || (tradeData.trSeq || tradeData.interfaceSeq || tradeData.issNo || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				} else if ((tradeData.businessNb || '') === '') {
					/* Step2. 사업자번호 */
					resultValue.sts = false;
					resultValue.key = 'businessNb';
					resultValue.msg = '사업자번호가 입력되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0') {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			} else if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '3' && trFgCode === '1') {
				/* (예금 or 현금 or 외상 or 신용카드) && 기타 && 거래처등록 */

				if ((tradeData.trName || '') === '' || (tradeData.trSeq || tradeData.interfaceSeq || tradeData.issNo || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				} else if ((tradeData.businessNb || '') === '') {
					/* Step2. 사업자번호 */
					resultValue.sts = false;
					resultValue.key = 'businessNb';
					resultValue.msg = '사업자번호가 입력되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0') {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			} else if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '3' && (trFgCode === '2' || trFgCode === '9')) {
				/* (예금 or 현금 or 외상 or 신용카드) && 기타 && (사원등록 or 운영비) */
				if ((tradeData.trName || '') === '' || (tradeData.trSeq || tradeData.interfaceSeq || tradeData.issNo || '') === '') {
					/* Step1. 사원명 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '사원이 선택되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step2. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0') {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			} else if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '3' && trFgCode === '3') {
				/* (예금 or 현금 or 외상 or 신용카드) && 기타 && 거래처명 */
				if ((tradeData.trName == '')) {
					/* Step1. 거래처명 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step2. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				}  else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0') {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			} else if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '3' && trFgCode === '4') {
				/* (예금 or 현금 or 외상 or 신용카드) && 기타 && 기타소득자 */
				if ((tradeData.trName || '') === '' || (tradeData.trSeq || tradeData.interfaceSeq || tradeData.issNo || '') === '') {
					/* Step1. 기타소득자 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '기타소득자가 선택되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step2. 지급총액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '지급총액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step3. 실수령액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '실수령액이 입력되지 않았습니다.';
				} else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0') {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			} else if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '3' && trFgCode === '9') {
				/* (예금 or 현금 or 외상 or 신용카드) && 기타 && 사업소득자 */
				if ((tradeData.trName || '') === '' || (tradeData.trSeq || tradeData.interfaceSeq || tradeData.issNo || '') === '') {
					/* Step1. 사업소득자 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '사업소득자가 선택되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step2. 지급총액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '지급총액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step3. 실수령액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '실수령액이 입력되지 않았습니다.';
				} else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0' ) {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			} else if ((setFgCode === '1' || setFgCode === '2' || setFgCode === '3' || setFgCode === '4') && vatFgCode === '4' && trFgCode === '1') {
				/* (예금 or 현금 or 외상 or 신용카드) && 불공제 && 거래처등록 */
				if ((tradeData.trName || '') === '' || (tradeData.trSeq || tradeData.interfaceSeq || tradeData.issNo || '') === '') {
					/* Step1. 사업소득자 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '사업소득자가 선택되지 않았습니다.';
				} else if ((tradeData.noTaxName || '') === '') {
					/* Step2. 금액 */
					resultValue.sts = false;
					resultValue.key = 'noTaxCode';
					resultValue.msg = '불공제 사유가 입력되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step2. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeVatAmt || '') === '') {
					/* Step5. 부가세 */
					resultValue.sts = false;
					resultValue.key = 'tradeVatAmt';
					resultValue.msg = '부가세가 입력되지 않았습니다.';
				} else if ((tradeData.regDate || '') === '' && (optionSet.gw[3][15]||{'setValue':'1'}).setValue == '0') {
					/* Step5. 신고기준일 */
					if(setFgCode=='1'){
						resultValue.sts = false;
						resultValue.key = 'regDate';
						resultValue.msg = '신고기준일이 입력되지 않았습니다.';
					}
					else{
						resultValue.sts = true;
					}
				} else {
					resultValue.sts = true;
				}
			}
		} else if (Option.Common.iCUBE()) {
			/* iCUBE 필수값 점검 */
			var chkFlag = [ setFgCode, vatFgCode, trFgCode ].join('_');

			switch (chkFlag) {
			case '1_1_1': /* 예금_과세_거래처등록 */
			case '1_3_2': /* 예금_기타_사원등록 */
			case '1_3_5': /* 예금_기타_기금 */
			case '1_3_7': /* 예금_기타_결연자 */
			case '2_1_1': /* 현금_과세_거래처등록 */
			case '2_3_2': /* 현금_기타_사원등록 */
			case '2_3_3': /* 현금_기타_거래처명 */
				if ((tradeData.trName || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '세금계산서 거래처에 오류가 있습니다.';
				}else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '세금계산서 금액에 오류가 있습니다.';
				}else {
					resultValue.sts = true;
				}
				break;
			case '2_3_5': /* 현금_기타_기금 */
			case '2_3_7': /* 현금_기타_결연자 */
			case '3_1_1': /* 외상_과세_거래처등록 */
			case '3_3_2': /* 외상_기타_사원등록 */
			case '3_3_3': /* 외상_기타_거래처명 */
				if ((tradeData.trName || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '세금계산서 거래처에 오류가 있습니다.';
				}else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '세금계산서 금액에 오류가 있습니다.';
				}else {
					resultValue.sts = true;
				}
				break;
			case '3_3_5': /* 외상_기타_기금 */
			case '3_3_7': /* 외상_기타_결연자 */
			case '4_1_1': /* 신용카드_과세_거래처등록 */
			case '4_3_2': /* 신용카드_기타_사원등록 */
			case '4_3_3': /* 신용카드_기타_거래처명 */
				if ((tradeData.trName || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '법인카드 승인내역 거래처에 오류가 있습니다.';
				}else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '법인카드 승인내역 금액에 오류가 있습니다.';
				}else {
					resultValue.sts = true;
				}
				break;
			case '4_3_5': /* 신용카드_기타_기금 */
			case '4_3_7': /* 신용카드_기타_결연자 */
				if((tradeData.trName || '') === '' || (tradeData.trSeq || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				}
				else{
					resultValue.sts = true;
				}
				if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeVatAmt || '') === '') {
					/* Step5. 부가세 */
					resultValue.sts = false;
					resultValue.key = 'tradeVatAmt';
					resultValue.msg = '부가세가 입력되지 않았습니다.';
				} else {
					resultValue.sts = true;
				}
				break;
			case '1_3_3': /* 예금_기타_거래처명 */
				if ((tradeData.trName || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeVatAmt || '') === '') {
					/* Step5. 부가세 */
					resultValue.sts = false;
					resultValue.key = 'tradeVatAmt';
					resultValue.msg = '부가세가 입력되지 않았습니다.';
				} else {
					resultValue.sts = true;
				}
				break;
			case '1_3_8': /* 예금_기타_사업소득자 */
			case '2_3_8': /* 현금_기타_사업소득자 */
			case '3_3_8': /* 외상_기타_사업소득자 */
			case '4_3_8': /* 신용카드_기타_사업소득자 */
			case '1_3_9': /* 예금_기타_사업소득자 */
			case '2_3_9': /* 예금_기타_사업소득자 */
			case '3_3_9': /* 예금_기타_사업소득자 */
			case '4_3_9': /* 예금_기타_사업소득자 */
				if((tradeData.trName || '') === '' || (tradeData.trSeq || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				}
				else{
					resultValue.sts = true;
				}
				if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeVatAmt || '') === '') {
					/* Step5. 부가세 */
					resultValue.sts = false;
					resultValue.key = 'tradeVatAmt';
					resultValue.msg = '부가세가 입력되지 않았습니다.';
				} else {
					resultValue.sts = true;
				}
				break;
			case '1_2_1': /* 예금_면세_거래처등록 */
			case '1_3_7': /* 예금_기타_급여 */
			case '2_2_1': /* 현금_면세_거래처등록 */
			case '2_3_7': /* 현금_기타_급여 */
			case '3_2_1': /* 외상_면세_거래처등록 */
			case '3_3_7': /* 외상_기타_급여 */
			case '4_2_1': /* 신용카드_면세_거래처등록 */
			case '4_3_7': /* 신용카드_기타_급여 */
				if((tradeData.trName || '') === '' || (tradeData.trSeq || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				}
				else{
					resultValue.sts = true;
				}
				if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else {
					resultValue.sts = true;
				}
				break;
			case '1_3_4': /* 예금_기타_기타소득자 */
				if ((tradeData.trName || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				} else if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else if ((tradeData.tradeStdAmt || '') === '') {
					/* Step4. 공급가액 */
					resultValue.sts = false;
					resultValue.key = 'tradeStdAmt';
					resultValue.msg = '공급가액이 입력되지 않았습니다.';
				} else {
					resultValue.sts = true;
				}
				break;
			case '1_3_1': /* 예금_기타_거래처등록 */
			case '1_3_6': /* 예금_기타_운영비 */
			case '2_3_1': /* 현금_기타_거래처등록 */
			case '2_3_6': /* 현금_기타_운영비 */
			case '3_3_1': /* 외상_기타_거래처등록 */
			case '3_3_6': /* 외상_기타_운영비 */
			case '4_3_1': /* 신용카드_기타_거래처등록 */
			case '4_3_6': /* 신용카드_기타_운영비 */
				if((tradeData.trName || '') === '' || (tradeData.trSeq || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				}
				else{
					resultValue.sts = true;
				}

				if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else {
					resultValue.sts = true;
				}
				break;
			case '2_3_4': /* 현금_기타_기타소득자 */
			case '3_3_4': /* 외상_기타_기타소득자 */
			case '4_3_4': /* 신용카드_기타_기타소득자 */
				if((tradeData.trName || '') === '' || (tradeData.trSeq || '') === '') {
					/* Step1. 거래처 */
					resultValue.sts = false;
					resultValue.key = 'trName';
					resultValue.msg = '거래처가 선택되지 않았습니다.';
				}
				else{
					resultValue.sts = true;
				}

				if ((tradeData.tradeAmt || '') === '') {
					/* Step3. 금액 */
					resultValue.sts = false;
					resultValue.key = 'tradeAmt';
					resultValue.msg = '금액이 입력되지 않았습니다.';
				} else {
					resultValue.sts = true;
				}
				break;
			}
		} else {
			console.error('연동 ERP 정보를 ${CL.ex_check}할 수 없습니다. [ERPiU, iCUBE]');
			resultValue.sts = false;
			resultValue.key = '';
			resultValue.msg = '연동 ERP 정보를 ${CL.ex_check}할 수 없습니다. [ERPiU, iCUBE]';
			return false;
		}

		return resultValue;
	}

	/* ## 예산 ## */
	/* ====================================================================================================================================================== */
	/* ## 예산 - 예산초과 ${CL.ex_check} ## */
	function fnBudgetAmtOverChk() {
		/* [ parameter ] */
		var parameter = {};
		/*   - resDocSeq : 결의서 문서 고유 ID */
		parameter.resDocSeq = '';

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url :  */
			url : '/exp/',
			datatype : 'json',
			async : false,
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## 예산 - 품의금액 초과 ${CL.ex_check} ## */
	function fnConsAmtOverChk() {
		/* [ parameter ] */
		var parameter = {};
		/*   - resDocSeq : 결의서 문서 고유 ID */
		parameter.resDocSeq = '';

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url :  */
			url : '/exp/',
			datatype : 'json',
			async : false,
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## 테이블 ## */
	/* ====================================================================================================================================================== */
	/* ## 테이블 - 선택 ## */
	function fnTableFocus(target, uid, key) {
		/* [ parameter ] */
		/*   - target : table div jquery object */
		/*   - uid : 테이블 행의 고유 ID */
		/*   - key : 컬럼을 표시하는 유일한 ID */

		/* grid 포커스 지정 */
		target.dzt('setFocus', uid, key);

		/* [ return ] */
		return;
	}

	/* ## 테이블 - 추가 ## */
	function fnTableAdd(target) {
		/* [ parameter ] */
		/*   - target : table div jquery object */

		/* grid 행 추가 */
		var id = target.prop('id');
		var uid = target.dzt('setAddRow');

		/* 예산내역 예외처리 */
		if (id === 'budgetTbl') {
			/* 결의정보 조회 */
			var resData = $('#resTbl').dzt('getValue');

			/* 결의서 시퀀스 키, 결의정보 키 반영 */
			var resultValue = {
				resDocSeq : (resData.resDocSeq || ''),
				resSeq : (resData.resSeq || '')
			}
			$('#budgetTbl').dzt('setValue', uid, resultValue, false);
		}

		/* 결제내역 예외처리 */
		if (id === 'tradeTbl') {
			/* 예산내역 조회 */
			var budgetData = $('#budgetTbl').dzt('getValue');

			/* 결의서 시퀀스 키, 결의정보 키, 예산내역 키 반영 */
			var resultValue = {
				resDocSeq : (budgetData.resDocSeq || ''),
				resSeq : (budgetData.resSeq || ''),
				budgetSeq : (budgetData.budgetSeq || '')
			}
			$('#tradeTbl').dzt('setValue', uid, resultValue, false);
		}

		/* [ return ] */
		/*   - uid : 테이블 행의 고유 ID */
		return uid;
	}

	/* ## 테이블 - 위 ## */
	function fntableUp(target) {
		/* [ parameter ] */
		/*   - target : table div jquery object */

		/* [ return ] */
		return;
	}

	/* ## 테이블 - 아래 ## */
	function fnTableDown(target) {
		/* [ parameter ] */
		/*   - target : table div jquery object */

		/* [ return ] */
		return;
	}

	/* ## 공통코드 ## */
	/* ====================================================================================================================================================== */
	function fnCommonCode(code, keyName, searchStr, resData, budgetData, tradeData) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - keyName : 사용자 입력 키이름 ( F2 와 Enter 의 동작 이벤트가 다르므로 별도 처리 ) */
		keyName = (keyName || '');
		/*   - searchStr : 사용자 입력 검색어 ( Enter 입력시에만 사용 ) */
		searchStr = (searchStr || '');
		/*   - resData : 현재 수정 진행중인 결의정보 행의 정보 */
		resData = (resData || {});
		/*   - budgetData : 현재 수정 진행중이 예산내역 행의 정보 */
		budgetData = (budgetData || {});
		/*   - tradeData : 현재 수정 진행중인 결제내역 행의 정보 */
		tradeData = (tradeData || {});

		/* 파라미터 정의 */
		var param = {};
		/* ERP 사용자 정보 저장 */
		resData = JSON.parse(JSON.stringify($.extend(resData, Option.Common.GetErpEmpInfo())));
		/* GW 사용자 정보 저장 */
		resData = JSON.parse(JSON.stringify($.extend(resData, Option.Common.GetGwEmpInfo())));
		/* ERP 기수 정보 저장 */
		resData = JSON.parse(JSON.stringify($.extend(resData, Option.Common.GetErpGisuInfo())));
		/* searchStr 파라미터 추가 정의 ( searchStr은 무조건 resData에서 추출 사용 ) */
		param.searchStr = (keyName === 'Enter' ? searchStr : '');
		/* 결의정보 */
		param = JSON.parse(JSON.stringify($.extend(param, resData)));
		/* 예산내역 */
		param = JSON.parse(JSON.stringify($.extend(param, budgetData)));
		/* 결제내역 */
		param = JSON.parse(JSON.stringify($.extend(param, tradeData)));

		/* 포맷변환 */
		param = Option.Common.GetSaveParam(param);

		/* 공통코드 함수 호출 */
		if (window['fnCommonCode_' + code] && typeof window['fnCommonCode_' + code] === 'function') {
			/* 공통코드 기본 설정 */

			/* 공통코드 전용 함수 수행 */
			window['fnCommonCode_' + code](code, param);
		} else {
			console.log('정의되지 않은 공통코드입니다. ( ' + code + ' / fnCommonCode_' + code + ' )');
		}
	}

	/* ## 공통코드 - 적요 ## */
	function fnCommonCode_resNote(code, param) {
		var resultValue = {};

		resultValue.resNote = (param.resNote || '');

		var uid = $('#resTbl').dzt('getUID');
		$('#resTbl').dzt('setValue', uid, resultValue, false);

		/* 오른쪽으로 이동 */
		$('#resTbl').dzt('setKeyIn', 'RIGHT');

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 비고(예산) # */
	function fnCommonCode_budgetNote(code, param) {
		var resultValue = {};

		resultValue.budgetNote = (param.budgetNote || '');

		var uid = $('#budgetTbl').dzt('getUID');
		$('#budgetTbl').dzt('setValue', uid, resultValue, false);

		/* 오른쪽으로 이동 */
		$('#budgetTbl').dzt('setKeyIn', 'RIGHT');

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 비고(채주) # */
	function fnCommonCode_tradeNote(code, param) {
		var resultValue = {};

		resultValue.tradeNote = (param.tradeNote || '');

		var uid = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		/* 오른쪽으로 이동 */
		$('#tradeTbl').dzt('setKeyIn', 'RIGHT');

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 불공제 사유 ## */
	function fnCommonCode_notax(code, param) {
		param = (param || {});
		param.callback = 'fnCommonCode_notax_callback';
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	function fnCommonCode_notax_callback(param){
		var resultValue = {};

		resultValue.noTaxCode = (param.stMutualSeq || '');
		resultValue.noTaxName = (param.stMutualName || '');

		var uid = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		/* 오른쪽으로 이동 */
		$('#tradeTbl').dzt('setKeyIn', 'RIGHT');

		/* [ return ] */
		return;
	}


	/* ## 공통코드 - 원인행위자 ## */
	function fnCommonCode_causeEmp(code, param) {
		code = 'emp';
		param = (param || {});
		param.callback = 'fnCommonCode_causeEmp_callback';
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	function fnCommonCode_causeEmp_callback(param){
		/* 원인행위자 변경 */
		/* iCUBE G20 : {"erpDivSeq":"2000","deposit":"신동욱","korName":"신동욱","erpDivName":"유네스코한국위원회(특별)","enlsName":"신동욱","USE_FG":1,"erpEmpSeq":"07621-2205","htypSeq":"003","btrSeq":"200","erpDeptSeq":"7731","btrName":"우리","CO_CD":"1000","baNb":"531-140461-02001","erpDeptName":"경영지원팀","prttSeq":"","causeEmpSeq":"07621-2205","causeEmpName":"신동욱","code":"emp","dummy":"{}"} */

		var resultValue = {};

		if (Option.Common.ERPiU()) {
			resultValue.causeEmpSeq = param.NO_EMP;
			resultValue.causeEmpName = param.NM_KOR;
		} else if (Option.Common.iCUBE()) {
			resultValue.causeEmpSeq = param.causeEmpSeq;
			resultValue.causeEmpName = param.causeEmpName;
		}

		var uid = $('#resTbl').dzt('getUID');
		$('#resTbl').dzt('setValue', uid, resultValue, false);

		/* 오른쪽으로 이동 */
		$('#resTbl').dzt('setKeyIn', 'RIGHT');

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 소득구분 - ERPiU ## */
	function fnCommonCode_incomegbn(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.yyyyMM = $('#txtERPiUHPPayDateYearMonth').val().replace(/-/g, '');
		param.callback = 'fnCommonCode_incomegbn_callback';

		fnCommonCodePop(code, param, param.callback);

		return;
	}

	function fnCommonCode_incomegbn_callback(param){

		// 소득세율 지방세율 계산
		var incomeRate = fnSetEtcRateCal(param.CODE);

		// 소득구분 코드
		$('#txtERPiUIncomeGbnCode').val(param.CODE);
		// 소득구분 명칭
		$('#txtERPiUIncomeGbnName').val(param.NAME);

		// 소득세율
		$('#txtERPiUIncomTaxPer').val(incomeRate.incomeTaxRate||'0');
		// 지방소득세율
		$('#txtERPiUResidTaxPer').val(incomeRate.residentTaxRate||'0');


		if( (Number(param.CODE) >= 60 && Number(param.CODE) <= 69 ) || Number(param.CODE) == 78 ) {
			$('#txtERPiUTransPer').val('0');
		} else if(Number(param.CODE) == 71 || Number(param.CODE) == 74 ) {
			$('#txtERPiUTransPer').val('80');
		} else if(Number(param.CODE) == 72 || Number(param.CODE) == 73 || Number(param.CODE) == 75 || Number(param.CODE) == 76 || Number(param.CODE) == 79 || Number(param.CODE) == 80) {
			$('#txtERPiUTransPer').val('60');
		}

		fnCalcERPiUEtcAmt();

		return;
	}

	function fnCalcERPiUEtcAmt(){
		var resData = $('#resTbl').dzt('getValue');
		if($('#budgetTbl').dzt('getValue').vatFgCode == '3' && $('#budgetTbl').dzt('getValue').trFgCode == '9'){
			/* 사업소득자 */
			$('#txtERPiUTotalAmt').val( (resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.abs(Number($('#txtERPiUTotalAmt').val().replace(/,/g, ''))):Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) );

			if(Math.abs(Number($('#txtERPiUTotalAmt').val().replace(/,/g, ''))) > 33333){
				$('#txtERPiUIncomTaxAmt').val((resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.abs(Math.floor(Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUIncomTaxPer').val().replace(/,/g, '')) / 100))):Math.floor(Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUIncomTaxPer').val().replace(/,/g, '')) / 100)));
				$('#txtERPiUResidTaxAmt').val((resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.floor(Math.abs(Math.floor(Number($('#txtERPiUIncomTaxAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUResidTaxPer').val().replace(/,/g, '')) / 100)))/10)*10:Math.floor(Math.abs(Math.floor(Number($('#txtERPiUIncomTaxAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUResidTaxPer').val().replace(/,/g, '')) / 100)))/10)*10)
			} else {
				$('#txtERPiUIncomTaxAmt').val('0');
				$('#txtERPiUResidTaxAmt').val('0');
			}
		} else {

			$('#txtERPiUTotalAmt').val( (resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.abs(Number($('#txtERPiUTotalAmt').val().replace(/,/g, ''))):Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) );
			// 필요경비
			$('#txtERPiUTransAmt').val( (resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.abs(Math.floor(Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUTransPer').val()) / 100))) :Math.floor(Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUTransPer').val()) / 100)));

			// 소득금액
			$('#txtERPiUAmt').val((resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.abs(Math.floor(Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) - Number($('#txtERPiUTransAmt').val().replace(/,/g, '')))):Math.floor(Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')) - Number($('#txtERPiUTransAmt').val().replace(/,/g, ''))));

			if(Math.abs(Number($('#txtERPiUAmt').val().replace(/,/g, ''))) > 50000) {
				// 소득세
				var IncomTaxAmt = Math.floor(Number($('#txtERPiUAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUIncomTaxPer').val().replace(/,/g, '')) / 100));
				$('#txtERPiUIncomTaxAmt').val((resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.abs(Math.floor(IncomTaxAmt - (IncomTaxAmt % 10))):Math.floor(IncomTaxAmt - (IncomTaxAmt % 10)));

				// 지방소득세
				$('#txtERPiUResidTaxAmt').val((resData.docuFgCode == '6' || resData.docuFgCode == '7')? -1 * Math.floor(Math.abs(Math.floor(Number($('#txtERPiUIncomTaxAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUResidTaxPer').val().replace(/,/g, '')) / 100)))/10)*10:Math.floor(Math.abs(Math.floor(Number($('#txtERPiUIncomTaxAmt').val().replace(/,/g, '')) * (Number($('#txtERPiUResidTaxPer').val().replace(/,/g, '')) / 100)))/10)*10)
			} else {
				$('#txtERPiUIncomTaxAmt').val('0');
				$('#txtERPiUResidTaxAmt').val('0');
			}
		}

		fnCalcComma();
		return;
	}

	function fnCalcComma(){
		$('#txtERPiUTotalAmt').val(($('#txtERPiUTotalAmt').val() == '' ? '0' : $('#txtERPiUTotalAmt').val()));
		$('#txtERPiUTransPer').val(($('#txtERPiUTransPer').val() == '' ? '0' : $('#txtERPiUTransPer').val()));
		$('#txtERPiUTransAmt').val(($('#txtERPiUTransAmt').val() == '' ? '0' : $('#txtERPiUTransAmt').val()));
		$('#txtERPiUAmt').val(($('#txtERPiUAmt').val() == '' ? '0' : $('#txtERPiUAmt').val()));
		$('#txtERPiUIncomTaxAmt').val(($('#txtERPiUIncomTaxAmt').val() == '' ? '0' : $('#txtERPiUIncomTaxAmt').val()));
		$('#txtERPiUIncomTaxPer').val(($('#txtERPiUIncomTaxPer').val() == '' ? '0' : $('#txtERPiUIncomTaxPer').val()));
		$('#txtERPiUResidTaxAmt').val(($('#txtERPiUResidTaxAmt').val() == '' ? '0' : $('#txtERPiUResidTaxAmt').val()));
		$('#txtERPiUResidTaxPer').val(($('#txtERPiUResidTaxPer').val() == '' ? '0' : $('#txtERPiUResidTaxPer').val()));

		$('#txtERPiUTotalAmt').val(Number($('#txtERPiUTotalAmt').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#txtERPiUTransPer').val(Number($('#txtERPiUTransPer').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#txtERPiUTransAmt').val(Number($('#txtERPiUTransAmt').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#txtERPiUAmt').val(Number($('#txtERPiUAmt').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#txtERPiUIncomTaxAmt').val(Number($('#txtERPiUIncomTaxAmt').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#txtERPiUIncomTaxPer').val(Number($('#txtERPiUIncomTaxPer').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#txtERPiUResidTaxAmt').val(Number($('#txtERPiUResidTaxAmt').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('#txtERPiUResidTaxPer').val(Number($('#txtERPiUResidTaxPer').val().replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

		return;
	}

	/* ## 공통코드 - 소득구분 - iCUBE ## */
	function fnCommonCode_income(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_income_callback';
		if (Option.Common.iCUBE()) {
			param.dataCd  = $('#tradeTbl').dzt('getValue').etcDataCd;
			param.residence  = $('#tradeTbl').dzt('getValue').etcDataCd;
		}
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	/* [callback] 기타 소득자 관리내역 팝업 콜백 */
	function fnCommonCode_income_callback(param) {

		/* 기타소득 코드 */
		$('#txtEtcIncomeSeq').val((param.CTD_CD || ''));
		$('#txtBizIncomeSeq').val((param.CTD_CD || ''));
		/* 기타소득 명칭 */
		$('#txtEtcIncomeName').val((param.CTD_NM || ''));
		$('#txtBizIncomeName').val((param.CTD_NM || ''));

		/* 기타소득자 거주구분 코드*/
		var dataCd = $('#tradeTbl').dzt('getValue').etcDataCd || 'G';
		/* 소득구분 코드 */
		var cdtCd = param.CTD_CD || 0;
		/* #. 거주자 기타소득 #. [dataCd : G] */
		/* +---------------+--------------+--------------+--------------+--------------+ */
		/* +--소득 구분----+-필요경비율---+----소득세율--+---주민세율---+-----비고-----+ */
		/* +---------------+--------------+--------------+--------------+--------------+ */
		/* +         61,68 +	0%		  +		0%		 +		0%		+			   + */
		/* +         	63 +	0%		  +		15%		 +		10%		+			   + */
		/* +60,64,65,69,78 +	0%		  +		20%		 +		10%		+			   + */
		/* +72,73,75,76,79 +	70%(60%)  +		20%		 +		10%		+			   + */
		/* +         71,74 +	80%		  +		20% 	 +		10%		+			   + */
		/* +         	62 +	직접입력  +		20%	 	 +		10%		+			   + */
		/* +---------------+--------------+--------------+--------------+--------------+ */
		/* #. 비거주자 기타소득 #. [dataCd : BI]*/
		/* +---------------+--------------+--------------+--------------+--------------+ */
		/* +--소득 구분----+-필요경비율---+----소득세율--+---주민세율---+-----비고-----+ */
		/* +---------------+--------------+--------------+--------------+--------------+ */
		/* +         40,41 +		0%	  +		2%		 +		10%	    +			   + */
		/* +         42,62 +		0%	  +		20%		 +		10%	    +			   + */
		/* +			61 +		0%	  +		0%		 +		0%	    +			   + */
		/* +---------------+--------------+--------------+--------------+--------------+ */
		var needRate = 0;
		var incomeTaxRate = 0;
		var residentTaxRate = 0;
		$('#txtEtcRequiredAmt').attr('readonly', true);

		/* 거주 소득자 */
		if(dataCd == 'G'){
			switch(cdtCd) {
			    case '61' :
			    case '68' :
					needRate = 0;
					incomeTaxRate = 0;
					residentTaxRate = 0;
			        break;
			    case '63' :
			    	needRate = 0;
					incomeTaxRate = 15;
					residentTaxRate = 10;
			        break;
			    case '60' :
			    case '64' :
			    case '65' :
			    case '69' :
			    case '78' :
			    	needRate = 0;
					incomeTaxRate = 20;
					residentTaxRate = 10;
			        break;
			    case '72' :
			    case '73' :
			    case '75' :
			    case '76' :
			    case '79' :
			    	var resDate = ($('#resTbl').dzt('getValue').resDate || '20180101').replaceAll('-', '');
			    	if(resDate > '20190100'){
			    		needRate = 60;
			    	}else if(resDate > '20180331'){
			    		needRate = 70;
			    	}else{
			    		needRate = 80;
			    	}
					incomeTaxRate = 20;
					residentTaxRate = 10;
			        break;
			    case '71' :
			    case '74' :
					needRate = 80;
					incomeTaxRate = 20;
					residentTaxRate = 10;
			        break;
			    case '62' :
			    	$('#txtEtcRequiredAmt').removeAttr('readonly');
			    	$('#txtEtcRequiredAmt').attr('readonly', false);
			    	$('#txtEtcRequiredRate').removeAttr('readonly');
			    	$('#txtEtcRequiredRate').attr('readonly', false);
					needRate = 60;
					incomeTaxRate = 20;
					residentTaxRate = 10;
			        break;
			    default:
			    	needRate = 0;
				incomeTaxRate = 0;
				residentTaxRate = 0;
			}
		} else if(dataCd == 'BI'){
			switch(cdtCd) {
			    case '40' :
			    case '41' :
					needRate = 0;
					incomeTaxRate = 2;
					residentTaxRate = 10;
			        break;
			    case '42' :
			    case '62' :
					needRate = 0;
					incomeTaxRate = 20;
					residentTaxRate = 10;
			        break;
			    case '61' :
					needRate = 0;
					incomeTaxRate = 0;
					residentTaxRate = 0;
			        break;
			    default:
			    	needRate = 0;
					incomeTaxRate = 0;
					residentTaxRate = 0;
			}
		}

		var etcTaxRates = {
			needRate : needRate
			, incomeTaxRate : incomeTaxRate
			, residentTaxRate : residentTaxRate
		};
		$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), etcTaxRates, false);

		$('#txtEtcAmt').val(0);
		$('#txtEtcRequiredRate').val( needRate );
		$('#txtEtcRequiredAmt').val(0);
		$('#txtEtcIncomeAmt').val(0);
		$('#txtEtcIncomeVatAmt').val(0);
		$('#txtEtcResidentVatAmt').val(0);
		$('#txtEtcEmploymentAmt').val(0);
		$('#txtEtcEmploymentInsuranceAmt').val(0);

		/* 지급총액  */
		$('#txtEtcAmt').focus().select();
		return;
	}

	/* ## 공통코드 - 입출금계좌 ## */
	function fnCommonCode_btrNb(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_btrNb_callback';

		/* 팝업 호출 */
		var code = '';
		if (Option.Common.ERPiU()) {
			code = 'btr';
		} else if (Option.Common.iCUBE()) {
			code = 'tr';
			param.trType = '2';
		} else {
			return;
		}

		fnCommonCodePop(code, param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_btrNb_callback(param) {
		/* ERPiU example : {"NM_BANK":"신한은행(대흥역)","NM_DEPOSIT":"장부통장(경단협)","NO_DEPOSIT":"379-03-003632","CD_DEPOSIT":"205","code":"btr","dummy":"{}"} */
		/* iCUBE example : {"erpCompSeq":"7070","trFg":"5","trName":"테스트","addr":" ","trRegNumber":"2218101847","useYN":"1","btrSeq":"260","btrName":"신한","atTrName":"테스트","trSeq":"3000","trFgName":"금융기관","baNb":"110267117872","depositor":"장지훈","code":"tr","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */
		var resultValue = {
			btrNb : '',
			btrSeq : '',
			btrName : ''
		};

		if (Option.Common.ERPiU()) {
			/* 입출금 계좌 코드 */
			resultValue.btrSeq = (param.CD_DEPOSIT || '');
			/* 입출금 계좌 */
			resultValue.btrNb = (param.NO_DEPOSIT || '');
			/* 입출금 계좌 명칭 */
			resultValue.btrName = (param.NM_DEPOSIT || '');
		} else if (Option.Common.iCUBE()) {
			/* 입출금 계좌 거래처 코드 */
			resultValue.btrSeq = (param.trSeq || '');
			/* 입출금 계좌 은행 코드 */
			resultValue.bankSeq = (param.btrSeq || '');
			/* 입출금 계좌 */
			resultValue.btrNb = (param.baNb || '');
			/* 입출금 계좌 명칭 */
			resultValue.btrName = (param.trName || '').replace("'", '`');
		}

		/* 예산단위 반영 */
		var uid = $('#resTbl').dzt('getUID');
		$('#resTbl').dzt('setValue', uid, resultValue, false);

		/* 오른쪽으로 이동 */
		$('#resTbl').dzt('setKeyIn', 'RIGHT');

		/* [ return ] */
		return;
	}


	/* ## 공통코드 - 원인행위자 ## */
	function fnCommonCode_causeEmpName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
	}

	/* ## 공통코드 - 물품명세 ## */
	function fnCommonCode_statement(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
	}

	/* ## 공통코드 - 예산단위 ## */
	function fnCommonCode_erpBudgetName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_erpBudgetName_callback';

		/* 파라미터 가공 */
		param.widthSize = "628";
		param.heightSize = "546";

		/* 팝업 호출 */
		var code = '';
		if (Option.Common.ERPiU()) {
			code = 'budget';
		} else {
			code = 'budgetlist';
			param.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
			param.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
			param.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
			param.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
			param.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
			param.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
			if (Option.Common.iCUBE()) {
				param.erpDivSeq = ($('#lbErpDivName').attr('seq') || '') + "|"; /* 회계통제단위 구분값 '|' */
			} else {
				param.erpDivSeq = optionSet.erpEmpInfo.erpDivSeq + "|"; /* 회계통제단위 구분값 '|' */
			}
			param.erpMgtSeq = (($('#resTbl').dzt('getValue') || {}).erpMgtSeq || '') + "|"; /* 예산통제단위 구분값 '|' */
			param.opt01 =  optionSet.gw[1][8].setValue; //'2'; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
			param.opt02 =  optionSet.gw[1][10].setValue; /* 1: 모두표시, 2: 사용기한결과분 숨김 */
			param.opt03 = '2'; /* 1: 예산그룹 전체, 2: 예산그룹 숨김 */

			if (Option.Common.iCUBE()) {
				/* 수입, 지출 예산과목 조회 분기 */
				var resData = $('#resTbl').dzt('getValue');
				var incomeCode = [ '5', '7' ]; /* 수입 구분 코드 */
				var expenseCode = [ '1', '2', '3', '4', '6', '8', '9' ]; /* 지출 구분 코드 */

				if (expenseCode.indexOf(resData.docuFgCode) > -1) {
					param.grFg = '2'; /* 1 : 수입, 2 : 지출 */
				} else if (incomeCode.indexOf(resData.docuFgCode) > -1) {
					param.grFg = '1'; /* 1 : 수입, 2 : 지출 */
				} else {
					param.grFg = ''; /* 1 : 수입, 2 : 지출 */
				}
			}
		}

		fnCommonCodePop(code, param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_erpBudgetName_callback(param) {
		/* ERPiU example :  */
		/* iCUBE example : {"BGT02_CD":"A500010000","TO_DT":"99999999","GROUP_NM":"예산과목체계","GROUP_CD":"1000","DRCR_FG":"1","GR_FG":"2","DIV_FG":"3","LEVEL01_NM":"장","BGT01_CD":"A500000000","LAST_YN2":"Y","LEVEL01_CD":"LV001","BGT03_NM":"A5목-일반제경비","USE_YN":"1","LEVEL02_CD":"LV002","BGT_CD":"A500010100","LEVEL02_NM":"관","BGT03_CD":"A500010100","CTL_FG":"9","HBGT_CD":"A500010000","SYS_CD":"2A500000000A500010000A5000101000000000000","BGT01_NM":"A5관지출","BGT_NM":"A5목-일반제경비","GROUP_NMK":"예산과목체계","HBGT_CD3":"","BIZ_FG":"0","BGT02_NM":"A5항 일반관리비","HBGT_CD2":"A500010000","HBGT_CD1":"A500000000","erpBudgetSeq":"A500010100","erpBudgetName":"A5목-일반제경비","erpBgt1Seq":"A500000000","erpBgt2Seq":"A500010000","erpBgt3Seq":"A500010100","erpBgt4Seq":"","erpBgt1Name":"A5관지출","erpBgt2Name":"A5항 일반관리비","erpBgt3Name":"A5목-일반제경비","erpBgt4Name":"","code":"budgetlist","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			erpBudgetName : '',
			erpBudgetSeq : '',
			bottomName : '',
			bottomSeq : '',
			erpFiacctName : '',
			erpFiacctSeq : ''
		};

		var resData = $('#resTbl').dzt('getValue');

		if (Option.Common.ERPiU()) {
			/* 예산단위 명칭 */
			resultValue.erpBudgetName = (param.NM_BUDGET || '');
			/* 예산단위 코드 */
			resultValue.erpBudgetSeq = (param.CD_BUDGET || '');
		} else if (Option.Common.iCUBE()) {
			/* iCUBE 반영 */
			resultValue = $.extend(resultValue, param);
			/* 예산과목 명칭 */
			resultValue.erpBudgetName = param.BGT_NM;
			/* 예산과목 코드 */
			resultValue.erpBudgetSeq = param.BGT_CD;
			/* 하위사업 코드 */
			resultValue.bottomSeq = resData.bottomSeq
			/* 하위사업 명 */
			resultValue.bottomName = resData.bottomName

			/* 관항목세 재 처리 */
			resultValue.erpBgt1Name = param.BGT01_NM;
			resultValue.erpBgt1Seq = param.BGT01_CD;
			resultValue.erpBgt2Name = param.BGT02_NM;
			resultValue.erpBgt2Seq = param.BGT02_CD;
			resultValue.erpBgt3Name = param.BGT03_NM;
			resultValue.erpBgt3Seq = param.BGT03_CD;
			resultValue.erpBgt4Name = param.BGT04_NM;
			resultValue.erpBgt4Seq = param.BGT04_CD;

			/* ERP 예산 7단계 옵션 대응 */
			resultValue.erpLevel01Seq = param.LEVEL01_CD  || '';
			resultValue.erpLevel01Name = param.LEVEL01_NM || '';
			resultValue.erpLevel02Seq = param.LEVEL02_CD  || '';
			resultValue.erpLevel02Name = param.LEVEL02_NM || '';
			resultValue.erpLevel03Seq = param.LEVEL03_CD  || '';
			resultValue.erpLevel03Name = param.LEVEL03_NM || '';
			resultValue.erpLevel04Seq = param.LEVEL04_CD  || '';
			resultValue.erpLevel04Name = param.LEVEL04_NM || '';
			resultValue.erpLevel05Seq = param.LEVEL05_CD  || '';
			resultValue.erpLevel05Name = param.LEVEL05_NM || '';
			resultValue.erpLevel06Seq = param.LEVEL06_CD  || '';
			resultValue.erpLevel06Name = param.LEVEL06_NM || '';

			/* 예산계정 저장 대응 */
			resultValue.erpFiacctName = param.ACCT_NM || '';
			resultValue.erpFiacctSeq = param.ACCT_CD || '';

		}

		/* 예산과목(예산단위) 반영 */
		var uid = $('#budgetTbl').dzt('getUID');
		$('#budgetTbl').dzt('setValue', uid, resultValue, false);

		///* iCUBE 예산 표시 */
		//if (Option.Common.iCUBE()) {
		//    fnSetBudgetDisplay();
		//}

		if (resultValue.erpBudgetSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 사업계획 ## */
	function fnCommonCode_erpBizplanName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_erpBizplanName_callback';

		/* 파라미터 가공 */
		param.widthSize = "728";
		param.heightSize = "580";

		/* 팝업 호출 */
		fnCommonCodePop('bizplan', param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_erpBizplanName_callback(param) {
		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */
		var resultValue = {
			erpBizplanName : '',
			erpBizplanSeq : ''
		};

		/* 예산계정 명칭 */
		resultValue.erpBizplanName = (param.NM_BIZPLAN || '');
		/* 예산계정 코드 */
		resultValue.erpBizplanSeq = (param.CD_BIZPLAN || '');

		/* 예산계정 반영 */
		var uid = $('#budgetTbl').dzt('getUID');
		$('#budgetTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpBudgetSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 예산계정 ## */
	function fnCommonCode_erpBgacctName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		if (param.docuFgCode == '5' || param.docuFgCode == '7') { // 수입
			param.grFg = '2';
		}
		else { //지출
			param.grFg = '1';
		}
		param.callback = 'fnCommonCode_erpBgacctName_callback';

		/* 파라미터 가공 */
		param.widthSize = "728";
		param.heightSize = "580";

		/* 팝업 호출 */
		fnCommonCodePop('bgacct', param, param.callback);

		/* [ return ] */
		return;
	}

	function sortObject(o)	{
	    var sorted = {},
	    key, a = [];
	    // 키이름을 추출하여 배열에 집어넣음
	    for (key in o) {
	        if (o.hasOwnProperty(key)) a.push(key);
	    }
	    // 키이름 배열을 정렬
	    a.sort();
	    // 정렬된 키이름 배열을 이용하여 object 재구성
	    for (key=0; key<a.length; key++) {
	        sorted[a[key]] = o[a[key]];
	    }
	    return sorted;
	}

	function fnCommonCode_erpBgacctName_callback(param) {
		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			erpBgacctName : '',
			erpBgacctSeq : ''
		};

		/* 예산계정 명칭 */
		resultValue.erpBgacctName = (param.NM_BGACCT || '');
		/* 예산계정 코드 */
		resultValue.erpBgacctSeq = (param.CD_BGACCT || '');


		var nmArr = [param.NM_LEVEL3, param.NM_LEVEL2, param.NM_LEVEL, param.NM_BGACCT, '', '', ''];
		var level = 1;

		if( (param.NM_5LEVEL||' ') != ' ') level = 5;
		else if( (param.NM_LEVEL3||' ') != ' ') level = 4;
		else if( (param.NM_LEVEL2||' ') != ' ') level = 3;
		else if( (param.NM_LEVEL||' ') != ' ') level = 2;


		if(level == 5){
			var budgetList = {};
			var budgetCount = 0;
			for(budgetLevelItem in param){
				if(budgetLevelItem.indexOf('LEVEL') != -1 && budgetLevelItem.indexOf('NM_') != -1 && budgetLevelItem.indexOf('NM_LEVEL') == -1 ){
					budgetList[budgetLevelItem] = param[budgetLevelItem];
					budgetCount++;
				}
			}

			budgetList = sortObject(budgetList);

			resultValue.erpBgt4Name = budgetList['NM_' + budgetCount + 'LEVEL'];
			resultValue.erpBgt3Name = budgetList['NM_' + (budgetCount-1) + 'LEVEL'];
			resultValue.erpBgt2Name = budgetList['NM_' + (budgetCount-2) + 'LEVEL'];
			resultValue.erpBgt1Name = budgetList['NM_' + (budgetCount-3) + 'LEVEL'];

			for(var i=1; i<budgetCount -3;i++){
				resultValue['erpLevel0' + i + 'Name'] = budgetList['NM_' + i + 'LEVEL'];
			}
		}
		else{
			resultValue.erpBgt1Name = nmArr[4 - level];
			resultValue.erpBgt2Name = nmArr[5 - level];
			resultValue.erpBgt3Name = nmArr[6 - level];
			resultValue.erpBgt4Name = nmArr[7 - level];
		}

		/* 예산계정 반영 */
		var uid = $('#budgetTbl').dzt('getUID');
		$('#budgetTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpBudgetSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 회계계정 ## */
	function fnCommonCode_erpFiacctName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_erpFiacctName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 파라미터 가공 */
		param.widthSize = "487";
		param.heightSize = "580";

		/* 팝업 호출 */
		fnCommonCodePop('fiacct', param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_erpFiacctName_callback(param) {
		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			erpFiacctName : '',
			erpFiacctSeq : ''
		};

		/* 회계계정 명칭 */
		resultValue.erpFiacctName = (param.NM_ACCT || '');
		/* 회계계정 코드 */
		resultValue.erpFiacctSeq = (param.CD_ACCT || '');

		/* 회계계정 반영 */
		var uid = $('#budgetTbl').dzt('getUID');
		$('#budgetTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpFiacctSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 신용카드 (iU) ## */
	function fnCommonCode_cardNum(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');

		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_cardNum_callback';

		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		var code = 'cardNum';
		fnCommonCodePop(code, param, param.callback);

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 신용카드 (iU) ## */
	function fnCommonCode_cardNum_callback(code, param) {
		/* 카드 거래처 반영 */
		var uid = $('#tradeTbl').dzt('getUID');
		var resultValue = {
			cardName : '',
			cardNum : '',
			cardCode : ''
		};
		resultValue.ctrName = (code.cardName || '').replace("'", '`');
		resultValue.ctrNum = code.cardNum;
		resultValue.ctrSeq = code.cardNum;
		resultValue.cardNum = code.cardName;

		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpFiacctSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 카드 거래처 (iCube) ## */
	function fnCommonCode_card(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');

		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_ctr_callback';

		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		var code = 'ctr';
		fnCommonCodePop(code, param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_ctr_callback(param) {
		/* 카드 거래처 반영 */
		var uid = $('#tradeTbl').dzt('getUID');
		var resultValue = {
			ctrName : '',
			ctrSeq : '',
			ctrNum : '',
			payTrName : '',
			payTrSeq : ''
		};
		resultValue.ctrName = (param.cardName || '').replace("'", '`');
		resultValue.ctrSeq = param.cardCode;
		resultValue.ctrNum = param.cardNum;
		resultValue.payTrName = param.payTrName||'';
		resultValue.payTrSeq = param.payTrSeq||'';
		if(resultValue.payTrSeq){
			resultValue.depositor = param.payTrDepositor||'';
			resultValue.baNb = param.payTrBaNb||'';
			resultValue.btrName = param.payTrBtrName||'';
			resultValue.btrSeq  = param.payTrBtrSeq||'';
		}

		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpFiacctSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	function fnCommonCode_card_callback(param) {
		/* 카드 거래처 반영 */
		var uid = $('#tradeTbl').dzt('getUID');
		var resultValue = {
			ctrName : '',
			ctrSeq : '',
		};
		resultValue.ctrName = (param.cardName || '').replace("'", '`');
		resultValue.ctrSeq = param.cardCode;

		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpFiacctSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 거래처 ## */
	function fnCommonCode_trName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		if (Option.Common.iCUBE()) {
			param.trOpt = optionSet.gw[3][16].setValue
			/* 기타/사업소득자 조회 기준 일자 */
			param.trOpt2 = (optionSet.gw[3][22]||{'setValue':'1'}).setValue ;
		}

		param.callback = 'fnCommonCode_trName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		var code = '';

		if (Option.Common.ERPiU()) {
			var budgetData = $('#budgetTbl').dzt('getValue');
			var trFgCode = (budgetData.trFgCode || '');

			switch(trFgCode) {
				case '2': /* 사원등록 */
					code = 'emp';
					break;
				case '4': /* 기타소득자 */
					code = 'tretc';
					break;
				case '9': /* 사업소득자 */
					code = 'trbus';
					break;
				default:
					code = 'tr';
					break;
			}
		} else if (Option.Common.iCUBE()) {
			var budgetData = $('#budgetTbl').dzt('getValue');
			/* 결제수단 */
			/* var setFgCode = (budgetData.setFgCode || ''); */
			/* 과세구분 */
			/* var vatFgCode = (budgetData.vatFgCode || ''); */
			/* 채주유형 */
			var trFgCode = (budgetData.trFgCode || '');

			switch (trFgCode) {
			case '1': /* 거래처등록 */
			case '3': /* 거래처명 */
				code = 'tr';
				break;
			case '2':
			case '8':
				/* 사원등록 */
				code = 'emp';
				param.empEmpSeq = '';
				break;
			case '4': /* 기타소득자 */
				code = 'erphpmeticlist';
				break;
			case '5':
				/* 급여 - 사용자 급요 노출 위험 문제로 미구현 */
				code = '-';
				break;
			case '9': /* 사업소득자 */
				code = 'erphincomeiclist';
				break;
			}
		}

		fnCommonCodePop(code, param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_trName_callback(param) {
		/* iCUBE example - tr : {"erpCompSeq":"7070","tel":"02 _518_0012","trFg":"1","trName":"전문건설공제조합2","ceoName":"이건영","addr":"충남 공주시 신관동 ","bankName":"국민","trRegNumber":"6028505389","bankNumber":"32165431321","useYN":"1","atTrName":"전문건설공제조합2","trSeq":"000003","trFgName":"일반","depositor":"ㅇ러날","giroSeq":"040","code":"tr","dummy":"{}"} */
		/* iCUBE example - emp : {"erpEmpSeq":"2000","erpDivSeq":"1000","htypSeq":"","dpstSeq":"임꺽정","acctNo":"113113","erpDeptSeq":"2000","CO_CD":"7070","korName":"임꺽정","erpDivName":"Ezbaro 연구원본사","enlsName":"","USE_FG":1,"erpDeptName":"연구관리부서","prttSeq":"","causeEmpSeq":"2000","causeEmpName":"임꺽정","code":"emp","dummy":"{}"} */
		/* iCUBE example - erphpmeticlist : {"ACCT_NM":"","PER_CD":"0001","PER_NM":"KIM","REG_NO":"6101015!@1@!PnRQrTZMjF5hHma+oazObw==","ACCT_NO":"","BANK_CD":"","CO_CD":"3585","CORP_CD":"2","DATA_CD":"BI","code":"erphpmeticlist","dummy":"{}"} */
		/* iCUBE example - erphincomeiclist : { PER_CD: '사업소득자코드', PER_NM: '사업소득자명', REG_NO: '사업소득자번호', DATA_CD: '사업소득자구분', CO_CD: '회사코드', CORP_CD: '사업소득자회사구분', BANK_CD: '은행코드', ACCT_NO: '계좌번호', ACCT_NM: '예금주', BANK_NM: '은행명', BANK_NMK: '은행명' } */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */
		var tradeInfo =$('#tradeTbl').dzt('getValue');
		var resultValue = {
			addr : '',
			trSeq : '',
			trName : '',
			businessNb : '',
			ceoName : '',
			btrSeq : '',
			btrName : '',
			baNb : '',
			depositor : '',
			depositno : ''
		};

		if (Option.Common.ERPiU()) {
			if(param.code === 'tr') {

				/* 거래처 코드 */
				resultValue.trSeq = (param.CD_PARTNER || '');
				/* 거래처 명칭 */
				resultValue.trName = (param.LN_PARTNER || '');
				/* 사업자번호 */
				resultValue.businessNb = (param.NO_COMPANY || '');
				/* 대표자명 */
				resultValue.ceoName = (param.NM_CEO || '');
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.CD_BANK || '');
				/* 금융기관 명칭 */
				resultValue.btrName = (param.NM_BANK || '');
				/* 계좌번호 */
				resultValue.baNb = (param.NO_DEPOSIT || '');
				/* 예금주 */
				resultValue.depositor = (param.NM_DEPOSIT || '');
				/* 계좌코드 */
				resultValue.depositno = (param.CD_DEPOSITNO || '');
			} else if(param.code === 'emp') {
				/* 사원등록 */
				resultValue.trSeq = (param.NO_EMP || '');
				resultValue.ctrSeq = (param.NO_EMP || '');
				/* 거래처 명칭 */
				resultValue.trName = (param.NM_KOR || '');
				/* 사업자번호 */
				resultValue.businessNb = '';
				/* 대표자명 */
				resultValue.ceoName = '';
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.CD_BANK2 || '');
				/* 금융기관 명칭 */
				resultValue.btrName =  (param.NM_BANK2 || '');
				/* 계좌번호 */
				resultValue.baNb = (param.NO_BANK2 || '');
				/* 예금주 */
				resultValue.depositor = '';
				console.log(JSON.stringify(param));
			} else if(param.code === 'tretc') {
				console.log(JSON.stringify(param));
				/* 사원등록 */
				resultValue.trSeq = (param.PER_CD || '');
				/* 거래처 명칭 */
				resultValue.trName = (param.PER_NM || '');
				/* 예금주 */
				resultValue.depositor = (param.ACCT_NM || '');
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.BANK_CD || '');
				/* 금융기관 명칭 */
				resultValue.btrName = (param.BANK_NM || '');
				/* 계좌번호 */
				resultValue.baNb = (param.ACCT_NO || '');
			} else if(param.code === 'trbus') {
				/* 소득자 코드 */
				resultValue.trSeq = (param.PER_CD || '');
				/* 소득자 명칭 */
				resultValue.trName = (param.PER_NM || '');
				/* 사업자 번호 */
				resultValue.businessNb = (param.REG_NO || '');
				/* 예금주 */
				resultValue.depositor = (param.ACCT_NM || '');
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.BANK_CD || '');
				/* 금융기관 명칭 */
				resultValue.btrName = (param.BANK_NM || '');
				/* 계좌번호 */
				resultValue.baNb = (param.ACCT_NO || '');
			}
		} else if (Option.Common.iCUBE()) {
			if (param.code === 'tr') {
				/* 거래처 주소 */
				resultValue.addr = (param.addr || '');
				/* 거래처 코드 */
				resultValue.trSeq = (param.trSeq || '');
				resultValue.ctrSeq = (tradeInfo.ctrSeq || ''); /* 2018. 06. 25. 결의서 전표처리 시 미지급금 거래처가 공백으로 처리되는 문제점 보완 */
				/* 거래처 명칭 */
				resultValue.trName = (param.trName || '');
				/* 사업자번호 */
				resultValue.businessNb = (param.trRegNumber || '');
				/* 대표자명 */
				resultValue.ceoName = (param.ceoName || '');
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.btrSeq || '');
				/* 금융기관 명칭 */
				resultValue.btrName = (param.btrName || '');
				/* 계좌번호 */
				resultValue.baNb = (param.baNb || '');
				/* 예금주 */
				resultValue.depositor = (param.depositor || '');
			} else if (param.code === 'emp') {
				/* 사원등록 */
				/* 거래처 주소 */
				resultValue.addr = (param.addr || '');
				/* 거래처 코드 */
				resultValue.trSeq = (param.erpEmpSeq || '');
				resultValue.ctrSeq = (tradeInfo.ctrSeq || ''); /* 2018. 06. 25. 결의서 전표처리 시 미지급금 거래처가 공백으로 처리되는 문제점 보완 */
				/* 거래처 명칭 */
				resultValue.trName = (param.korName || '');
				/* 사업자번호 */
				resultValue.businessNb = '';
				/* 대표자명 */
				resultValue.ceoName = '';
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.PYTB_CD || '');
				/* 금융기관 명칭 */
				resultValue.btrName = (param.btrName || '');
				/* 계좌번호 */
				resultValue.baNb = (param.ACCT_NO || '');
				/* 예금주 */
				resultValue.depositor = (param.DPST_NM || '');
			} else if (param.code === 'erphpmeticlist') {
				/* 기타소득자 */
				/* 거래처 주소 */
				resultValue.addr = (param.addr || '');
				/* 거래처 코드 */
				resultValue.trSeq = (param.PER_CD || '');
				resultValue.ctrSeq = (tradeInfo.ctrSeq || ''); /* 2018. 06. 25. 결의서 전표처리 시 미지급금 거래처가 공백으로 처리되는 문제점 보완 */
				/* 거래처 명칭 */
				resultValue.trName = (param.PER_NM || '');
				/* 사업자번호 */
				resultValue.businessNb = '';
				/* 대표자명 */
				resultValue.ceoName = '';
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.BANK_CD || '');
				/* 금융기관 명칭 */
				resultValue.btrName = (param.BANK_NM || '');
				/* 계좌번호 */
				resultValue.baNb = (param.ACCT_NO || '');
				/* 예금주 */
				resultValue.depositor = (param.ACCT_NM || 'G');
				/* 거주 소득자 : G / 비거주 소득자 : BI */
				resultValue.etcDataCd = (param.DATA_CD || '');
			} else if (param.code === 'erphincomeiclist') {
				/* 거래처 주소 */
				resultValue.addr = (param.addr || '');
				/* 거래처 코드 */
				resultValue.trSeq = (param.PER_CD || '');
				resultValue.ctrSeq = (tradeInfo.ctrSeq || ''); /* 2018. 06. 25. 결의서 전표처리 시 미지급금 거래처가 공백으로 처리되는 문제점 보완 */
				/* 거래처 명칭 */
				resultValue.trName = (param.PER_NM || '');
				/* 사업자번호 */
				resultValue.businessNb = '';
				/* 대표자명 */
				resultValue.ceoName = '';
				/* 금융기관 코드 */
				resultValue.btrSeq = (param.BANK_CD || '');;
				/* 금융기관 명칭 */
				resultValue.btrName = (param.BANK_NM || '');
				/* 계좌번호 */
				resultValue.baNb = (param.ACCT_NO || '');
				/* 예금주 */
				resultValue.depositor = (param.ACCT_NM || '');
				/* 거주 사업 소득자 : G / 비거주 사업 소득자 : BI */
				resultValue.etcDataCd = (param.DATA_CD || 'G');
				/* 학자금상환공제자 : '0' / 학자금상환 비 공제자 : '1' */
				resultValue.ynBuempiclMan = (param.YN_BUEMPICLMAN || '');
			}
		}

		/* 거래처 반영 */
		var uid = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpFiacctSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 금융기관 ## */
	function fnCommonCode_btrName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_btrName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		fnCommonCodePop('bank', param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_btrName_callback(param) {
		/* iCUBE example : {"BANK_NM":"외환(구)","BANK_CD":"050","code":"bank","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			btrSeq : '',
			btrName : ''
		};

		if (Option.Common.ERPiU()) {
			/* 금융기관 코드 */
			resultValue.btrSeq = (param.CD_SYSDEF || '');
			/* 금융기관 명칭 */
			resultValue.btrName = (param.NM_SYSDEF || '');
		} else if (Option.Common.iCUBE()) {
			/* 금융기관 코드 */
			resultValue.btrSeq = (param.BANK_CD || '');
			/* 금융기관 명칭 */
			resultValue.btrName = (param.BANK_NM || '');
		}

		/* 금융기관 반영 */
		var uid = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpFiacctSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 계좌코드 ## */
	function fnCommonCode_baNb(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_baNb_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		fnCommonCodePop('baNb', param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_baNb_callback(param) {
		/* iCUBE example : {"BANK_NM":"외환(구)","BANK_CD":"050","code":"bank","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			btrSeq : '',
			btrName : '',
			depositor : '',
			baNb : '',
			depositno : ''
		};

		if (Option.Common.ERPiU()) {
			/* 금융기관 코드 */
			resultValue.btrSeq = (param.CD_BANK || '');
			/* 금융기관 명칭 */
			resultValue.btrName = (param.NM_BANK || '');
			/* 계좌코드 */
			resultValue.depositno = (param.CD_DEPOSITNO || '');
			/* 계좌번호 */
			resultValue.baNb = (param.NO_DEPOSIT || '');
			/* 예금주 */
			resultValue.depositor = (param.NM_DEPOSIT || '');

		} else if (Option.Common.iCUBE()) {
			return;
		}

		/* 금융기관 반영 */
		var uid = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpFiacctSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 프로젝트 / 부서 ## */
	function fnCommonCode_erpMgtName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_erpMgtName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		if(!GetErpMgtIsProject()){
			/* 프로젝트 통제 팝업 호출 */
			/* 팝업 호출 */
			fnCommonCodePop('dept', param, param.callback);
		}else if(GetErpMgtIsProject()){
			/* 프로젝트 통제 팝업 호출 */
			/* 팝업 호출 */
			fnCommonCodePop('project', param, param.callback);
		}


		/* [ return ] */
		return;
	}

	function fnCommonCode_erpMgtName_callback(param) {
		/* iCUBE example : {"progFg":"1","itBusinessLink":0,"pjtToDate":"2018-12-31","atTrName":"상배","pjtSeq":"1000","trSeq":"8203","pjtFromDate":"2010-01-01","bankNumber":"110434349254","pjtName":"최소유전체 합성 및 DNA Scaffold 기반 지능형","erpMgtSeq":"1000","erpMgtName":"최소유전체 합성 및 DNA Scaffold 기반 지능형","code":"project","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			erpMgtName : '',
			erpMgtSeq : ''
		};

		/* 프로젝트 / 부서 명칭 */
		resultValue.erpMgtName = (param.pjtName || param.deptName || '').replace("'", '`');
		/* 프로젝트 / 부서 코드 */
		resultValue.erpMgtSeq = (param.pjtSeq || param.deptSeq || '');

		if (Option.Common.iCUBE()) {
			/* 입출금 계좌 거래처 코드 */
			resultValue.btrSeq = (param.trSeq || '');
			/* 입출금 계좌 은행 코드 */
			resultValue.bankSeq = '';
			/* 입출금 계좌 */
			resultValue.btrNb = (param.bankNumber || '');
			/* 입출금 계좌 명칭 */
			resultValue.btrName = (param.atTrName || '').replace("'", '`');
			/* 프로젝트 시작 기간 */
			resultValue.pjtToDate = (param.pjtToDate || '');
			/* 프로젝트 종료 기간 */
			resultValue.pjtFromDate = (param.pjtFromDate || '');
		}

		/* 프로젝트 / 부서 반영 */
		var uid = $('#resTbl').dzt('getUID');
		$('#resTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpMgtSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#resTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 하위사업 / 부서 ## */
	function fnCommonCode_erpBottomName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.erpMgtSeq = $('#resTbl').dzt('getValue').erpMgtSeq;
		param.callback = 'fnCommonCode_erpBottomName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		fnCommonCodePop('bottom', param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_erpBottomName_callback(param) {
		/* iCUBE example : {"progFg":"1","itBusinessLink":0,"pjtToDate":"2018-12-31","atTrName":"상배","pjtSeq":"1000","trSeq":"8203","pjtFromDate":"2010-01-01","bankNumber":"110434349254","pjtName":"최소유전체 합성 및 DNA Scaffold 기반 지능형","erpMgtSeq":"1000","erpMgtName":"최소유전체 합성 및 DNA Scaffold 기반 지능형","code":"project","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			erpBottomName : '',
			erpBottomSeq : ''
		};

		/* 프로젝트 / 부서 명칭 */
		resultValue.bottomName = (param.bottomName || '');
		/* 프로젝트 / 부서 코드 */
		resultValue.bottomSeq = (param.bottomSeq || '');

		if (Option.Common.iCUBE()) {
			/* 입출금 계좌 거래처 코드 */
			resultValue.btrSeq = (param.trSeq || '');
			/* 입출금 계좌 은행 코드 */
			resultValue.bankSeq = '';
			/* 입출금 계좌 */
			resultValue.btrNb = (param.btrSeq || '');
			/* 입출금 계좌 명칭 */
			resultValue.btrName = (param.btrName || '').replace("'", '`');
		}

		/* 프로젝트 / 부서 반영 */
		var uid = $('#resTbl').dzt('getUID');
		$('#resTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.bottomSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#resTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}



	/* ## 공통코드 - 회계단위 ## */
	function fnCommonCode_erpDivName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_erpDivName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		fnCommonCodePop('div', param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_erpDivName_callback(param) {
		/* iCUBE example : {"divName":"Ezbaro 연구원본사","divSeq":"1000","erpDivSeq":"1000","erpDivName":"Ezbaro 연구원본사","code":"div","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		var resultValue = {
			erpDivName : '',
			erpDivSeq : ''
		};

		/* iCUBE 회계단위 명칭 */
		resultValue.erpDivName = (param.divName || '');
		/* iCUBE 회계단위 코드 */
		resultValue.erpDivSeq = (param.divSeq || '');

		/* iCUBE 회계단위 반영 */
		var uid = $('#budgetTbl').dzt('getUID');
		$('#budgetTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpMgtSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 팝업호출 ## */
	function fnCommonCodePop(code, obj, callback, data) {
		/* [ parameter ] */
		/*   - obj : 전송할 파라미터 */
		obj = (obj || {});
		/*   - callback : 코백 호출할 함수 명 */
		callback = (callback || '');
		/*   - data : 더미 */
		data = (data || {});

		if (optionSet.conVo.erpTypeCode == 'ERPiU') {
			let ynbizplanfilter = optionSet.erp.YN_BIZPLANFILTER;

			if (ynbizplanfilter === undefined) {
				obj['YN_BIZPLANFILTER'] = false
			} else if (ynbizplanfilter.CD_ENV == "Y") {
				obj['YN_BIZPLANFILTER'] = true
			} else {
				obj['YN_BIZPLANFILTER'] = false
			}

			let ynbgdeptfilter = optionSet.erp.YN_BGDEPTFILTER;

			if (ynbgdeptfilter === undefined) {
				obj['YN_BGDEPTFILTER'] = false
			} else if (ynbgdeptfilter.CD_ENV == "Y") {
				obj['YN_BGDEPTFILTER'] = true
			} else {
				obj['YN_BGDEPTFILTER'] = false
			}
		}

		/* 팝업 호출 */
		obj.widthSize = 780;
		obj.heightSize = 582;

		fnCallCommonCodePop({
			code : code,
			popupType : 2,
			param : JSON.stringify(obj),
			callbackFunction : callback,
			dummy : JSON.stringify(data)
		});
	}

	/* ## 예산처리 ## */
	/* ====================================================================================================================================================== */
	/* ## 예산처리 - 예산 금액 표시 ## */
	var preErpBudgetSeq = null;
	var advPreErpBudgetSeq = null;
	function fnSetBudgetDisplay(btnId) {
		/* [ parameter ] */
		var parameter = {};

		parameter.erpDivSeq = '';
		parameter.erpMgtSeq = '';
		parameter.erpCompSeq = '';
		parameter.erpBudgetSeq = '';
		parameter.erpBudgetName = '';
		parameter.gisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '');
		parameter.formSeq = (optionSet.formInfo.formSeq || '');

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var resData = $('#resTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, resData))); /* 작성중인 품의정보 */

		var budgetData = $('#budgetTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 */

		parameter.erpGisuDate = (resData.resDate || '').toString().replace(/-/g, '');
		parameter.expendDate = (resData.resDate || '').toString().replace(/-/g, '');
		/* 전자결재 -> 정보수정 시 예산잔액 정상조회되지 않아 일단 추가,삭제 시에만 최적화 코드 안돌도록 처리 */
		if (btnId == 'btnTradeDelete' || btnId == 'btnTradeInsert'){
			preBudgetSeq = budgetData.budgetSeq;
			if (Option.Common.GetErpType() == 'ERPiU') {
				preErpBudgetSeq = budgetData.erpBgacctSeq;
			} else if (Option.Common.GetErpType() == 'iCUBE') {
				preErpBudgetSeq = budgetData.erpBudgetSeq;
			}
		} else {
			if ((preBudgetSeq == budgetData.budgetSeq) && (preErpBudgetSeq == budgetData.erpBudgetSeq) && !optionSet.confferInfo) {
				preErpBudgetSeq = budgetData.erpBudgetSeq;
				preBudgetSeq = budgetData.budgetSeq;
				return;
			} else {
				preBudgetSeq = budgetData.budgetSeq;
				if (Option.Common.GetErpType() == 'ERPiU') {
					preErpBudgetSeq = budgetData.erpBgacctSeq;
				} else if (Option.Common.GetErpType() == 'iCUBE') {
					preErpBudgetSeq = budgetData.erpBudgetSeq;
				}
			}
		}
		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = (parameter.erpBizSeq || ''); /* ERP 사업장 명칭 */
			parameter.erpDivName = (parameter.erpBizName || ''); /* ERP 사업장 명칭 */
		} else if (Option.Common.iCUBE()) {
			parameter.erpDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpDivName = $('#lbErpDivName').val();
			parameter.erpBudgetDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpBudgetDivName = $('#lbErpDivName').val();
		}

		/**
			runBudgetInfoFlag ] 작성창 최적화를 위한 플래그
			'0' / 예산 정보조회 실행
			'1' / 예산 정보 초기화
			'2' / 예산정보 로직 무시(성능 최적화 용도)
		*/
		var runBudgetInfoFlag = false;
		switch (Option.Common.GetErpType()) {
		case 'ERPiU':
			if (	(parameter.erpCompSeq || '') !== ''
					&& (parameter.erpBudgetSeq || '') !== ''
					&& (parameter.erpBizplanSeq || '') !== ( (!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0'))  ? '1' : '' )
					&& (parameter.erpBgacctSeq || '') !== ''
					&& (parameter.expendDate || '') !== ''
			) {
				if(advPreErpBudgetSeq != (parameter.erpCompSeq + '|' + parameter.erpBudgetSeq + '|' + parameter.erpBizplanSeq + '|' + parameter.erpBgacctSeq + '|' + parameter.expendDate + '|' + budgetData.budgetSeq) ){
					runBudgetInfoFlag = '0';
					parameter.erpDivSeq = ($('#lbErpDivName').attr('seq') || '');
					parameter.erpDivName = ($('#lbErpDivName').val() || '');
					advPreErpBudgetSeq = parameter.erpCompSeq + '|' + parameter.erpBudgetSeq + '|' + parameter.erpBizplanSeq + '|' + parameter.erpBgacctSeq + '|' + parameter.expendDate + '|' + budgetData.budgetSeq;
				}else{
					runBudgetInfoFlag = '0';
				}
			} else {
				runBudgetInfoFlag = '1';
			}
			break;
		case 'iCUBE':
			if ((parameter.erpMgtSeq || '') !== '' /* 프로젝트 */
					&& (parameter.erpBudgetSeq || '') !== '' /* 예산과목 */
					&& (parameter.erpGisuDate || '') !== '' /* 품의일자 */
					&& (parameter.resDocSeq || '') !== '') { /* 품의서 시퀀스 */
				if(advPreErpBudgetSeq != (parameter.erpMgtSeq + '|' + parameter.erpBudgetSeq + '|' + parameter.erpGisuDate + '|' + parameter.resDocSeq + '|' + budgetData.budgetSeq) ){
					runBudgetInfoFlag = '0';
					parameter.erpDivSeq = ($('#lbErpDivName').attr('seq') || '');
					parameter.erpDivName = ($('#lbErpDivName').val() || '');
					advPreErpBudgetSeq = parameter.erpMgtSeq + '|' + parameter.erpBudgetSeq + '|' + parameter.erpGisuDate + '|' + parameter.resDocSeq + '|' + budgetData.budgetSeq;
				}else{
						runBudgetInfoFlag = '0';
				}

			} else {
				runBudgetInfoFlag = '1';
			}
			break;
		}

		if (runBudgetInfoFlag == '0') {
			/* [ ajax ] */
			$.ajax({
				type : 'post',
				/*   - url : /ex/np/user/res/resBudgetInfoSelect.do */
				url : domain + '/ex/np/user/res/resBudgetInfoSelect.do',
				datatype : 'json',
				async : false,
				/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
				data : Option.Common.GetSaveParam(parameter),
				/*   - success :  */
				success : function(result) {
					fnAjaxLog(this.url, result);

					var aData = Option.Common.GetResult(result, 'aData');
					var resultCode = Option.Common.GetResultCode(result);

					if (resultCode === 'SUCCESS') {
						/* iCUBE example : {"openAmt":0,"erpApplyAmt":-1100000000000,"budgetTableResAmt":0,"balanceAmt":1100000000000,"resApplyAmt":-1100000000000,"consBalanceAmt":0,"erpLeftAmt":1100000000000,"budgetTableConsAmt":0,"tryAmt":0,"applyAmt":-1100000000000} */
						/* ERPiU example : {"openAmt":0,"balanceAmt":-729291,"amt":659291,"budgetTableConsAmt":70000,"tryAmt":0,"applyAmt":729291} */

						/* 반환값 정의 */
						var erpOpenAmt = 0, erpApplyAmt = 0, budgetTableResAmt = 0, gwBalanceAmt = 0, resApplyAmt = 0, consBalanceAmt = 0, erpLeftAmt = 0, budgetTableConsAmt = 0, budgetAmt = 0;

						if (typeof aData.confferConsAmt !== 'undefined') {
							/* 참조품의 결의서의 경우 TODO : 상배 추가*/
							$('#lblBudgetAmt').html('${CL.ex_budgetAmount}');
							$('#lblConsAmt').html('${CL.ex_consMoney}');
							$('#lblResAmt').html('${CL.ex_excutionConsAmount}');
							$('#lblTryAmt').html('${CL.ex_thisTimeExecution}');
							$('#lblBalanceAmt').html('${CL.ex_consBal}');
						} else {
							/* 일반 결의서의 경우 TODO : 상배 추가*/
							$('#lblBudgetAmt').html('${CL.ex_budgetAmount}');
							$('#lblConsAmt').html('${CL.ex_consBal}');
							$('#lblResAmt').html('${CL.ex_budgetExcutionAmt}');
							$('#lblTryAmt').html('${CL.ex_thisTimeExecution}');
							$('#lblBalanceAmt').html('${CL.ex_budgetBalance}');
						}

						erpOpenAmt = Number((aData.openAmt || '').toString().replace(/,/g, ''));
						erpApplyAmt = Number((aData.applyAmt || '').toString().replace(/,/g, ''));
						budgetTableResAmt = Number((aData.budgetTableResAmt || '').toString().replace(/,/g, ''));
						gwBalanceAmt = Number((aData.balanceAmt || '').toString().replace(/,/g, ''));
						resApplyAmt = Number((aData.resApplyAmt || '').toString().replace(/,/g, ''));
						consBalanceAmt = Number((aData.consBalanceAmt || '').toString().replace(/,/g, ''));
						erpLeftAmt = Number((aData.erpLeftAmt || '').toString().replace(/,/g, ''));
						budgetTableConsAmt = Number((aData.budgetTableConsAmt || '').toString().replace(/,/g, ''));
						budgetAmt = Number((aData.tryAmt || '').toString().replace(/,/g, ''));
						itemAmt = (aData.itemAmt || '').toString().replace(/,/g, '');
						aData.itemAmt = itemAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						itemAmt = itemAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						/* 예산금액 */
						$('#lbErpOpenAmt').html(Option.Common.GetNumeric(erpOpenAmt || '0'));
						aData.erpOpenAmt = erpOpenAmt;
						/* 품의잔액 / 품의금액 */
						if (typeof aData.confferConsAmt !== 'undefined') {
							$('#lbConsBalanceAmt').html(Option.Common.GetNumeric(Number((aData.confferConsAmt || '0').toString().replace(/,/g, ''))));
						} else {
							$('#lbConsBalanceAmt').html(Option.Common.GetNumeric(consBalanceAmt || '0'));
						}
						/* 집행금액 / 품의집행 */
						if (typeof aData.confferConsAmt !== 'undefined') {
							$('#lbResApplyAmt').html(Option.Common.GetNumeric(Number((aData.confferResAmt || '0').toString().replace(/,/g, ''))));
						} else {
							$('#lbResApplyAmt').html(Option.Common.GetNumeric(resApplyAmt || '0'));
						}
						/* 금회집행 */
						$('#lbBudgetAmt').html(Option.Common.GetNumeric(budgetAmt || '0'));
						aData.budgetAmt = budgetAmt;
						/* 예산잔액 / 품의잔액 */
						if (typeof aData.confferConsAmt !== 'undefined') {
							$('#lbGwBalanceAmt').html(Option.Common.GetNumeric(Number((aData.confferResultBalanceAmt || '0').toString().replace(/,/g, ''))));
						} else {
							$('#lbGwBalanceAmt').html(Option.Common.GetNumeric(gwBalanceAmt || '0'));
						}
						aData.gwBalanceAmt = gwBalanceAmt;

						/* 예산정보 반영 */
						if (formType !== gntpResFormType.EXNPRESCUSTOM) {
							delete aData['budgetAmt'];
						}
						var resUid = $('#resTbl').dzt('getUID');
						$('#resTbl').dzt('setValue', resUid, aData, false);

						var budgetUid = $('#budgetTbl').dzt('getUID');
						$('#budgetTbl').dzt('setValue', budgetUid, aData, false);
					} else {
						alert('예산 조회 중 알 수 없는 오류가 발생되었습니다.');
					}

					/* 예산내역 반영 */
					/* 현재행의 uid 조회 */
					var uid = $('#budgetTbl').dzt('getUID');

					/* 결의서 시퀀스 반영 ( resSeq ) */
					$('#budgetTbl').dzt('setValue', uid, aData, false);
				},
				/*   - error :  */
				error : function(result) {
					console.error(result);
				}
			});
		} else if(runBudgetInfoFlag == '1') {
			advPreErpBudgetSeq = ''
			/* 예산금액 초기화 */
			$('#lbErpOpenAmt').html('0');
			$('#lbResApplyAmt').html('0');
			$('#lbConsBalanceAmt').html('0');
			$('#lbBudgetAmt').html('0');
			$('#lbGwBalanceAmt').html('0');
		} else if(runBudgetInfoFlag == '2'){
			// 성능 최적화를 위한 실행 무시
		}

		// Option.Common.SetFocusAmtUpdate();

		/* [ return ] */
		return;
	}
	/* ## 결의서 즐겨찾기 ## */
	/* ====================================================================================================================================================== */
	/* ## event - 결의서 즐겨찾기 팝업 ## */
	function fnEvenBringFavorites() {
		/* 입력된 정보 ${CL.ex_check} ( 결의정보가 입력된 경우 참조품의 진행 시 모두 초기화 되므로, 사용자 ${CL.ex_check} 진행 ) */
		var resDataArray = $('#resTbl').dzt('getValueAll');
		if (resDataArray.length > 0 && (resDataArray[0].resSeq || '') !== '') {
			var msg = '${CL.ex_favoriteDeleteMsg}' // '즐겨찾기 가져오기 기능은 기존 작성 내역을 삭제하고 덮어쓰기 합니다.\r\n계속 진행하시겠습니까?';

			if (!confirm(msg)) {
				return false;
			}
		}

		/* 결의정보 삭제 */
		var resData = $('#resTbl').dzt('getValue');

		if ((resData.resSeq || '') !== '') {
			fnEventResDelete();
		}

		/* 결제내역 테이블 초기화 */
		$('#tradeTbl').dzt('setReset');

		/* 예산내역 테이블 초기화 */
		$('#budgetTbl').dzt('setReset');

		/* 결의정보 테이블 초기화 */
		$('#resTbl').dzt('setReset');

		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserResFavoritesPop.do'/>";
		var height = 450;

		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		if (isFirefox) {
			height += 4;
		}
		if (isIE) {
			height += 0;
		}
		if (isEdge) {
			height -= 26;
		}
		if (isChrome) {
			height -= 6;
		}

		window.open('', "UserBringFavoritesPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		USER_confferPop.target = "UserBringFavoritesPop";
		USER_confferPop.method = "post";
		USER_confferPop.action = url;
		USER_confferPop.submit();
		USER_confferPop.target = "";

		return;
	}

	/* ## 품의서참조 ## */
	/* ====================================================================================================================================================== */
	/* ## event - 결의정보 품의서 참조 ## */
	function fnEventConsRefer() {
		/* 입력된 정보 ${CL.ex_check} ( 결의정보가 입력된 경우 참조품의 진행 시 모두 초기화 되므로, 사용자 ${CL.ex_check} 진행 ) */
		var resDataArray = $('#resTbl').dzt('getValueAll');
		if (resDataArray.length > 0 && (resDataArray[0].resSeq || '') !== '') {
			var msg = '${CL.ex_confferDeleteMsg}' //'품의서 참조 가져오기 기능은 기존 작성 내역을 삭제하고 덮어쓰기 합니다. 계속 진행하시겠습니까?';

			if (!confirm(msg)) {
				return false;
			}
		}

		/* 결의정보 삭제 */
		var resData = $('#resTbl').dzt('getValue');

		if ((resData.resSeq || '') !== '') {
			fnEventResDelete();
		}

		/* 결제내역 테이블 초기화 */
		$('#tradeTbl').dzt('setReset');

		/* 예산내역 테이블 초기화 */
		$('#budgetTbl').dzt('setReset');

		/* 결의정보 테이블 초기화 */
		$('#resTbl').dzt('setReset');

		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserConfferPop.do'/>" + '?formSeq=' + formSeq;
		var height = 450;

		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		if (isFirefox) {
			height += 4;
		}
		if (isIE) {
			height += 0;
		}
		if (isEdge) {
			height -= 26;
		}
		if (isChrome) {
			height -= 6;
		}

		window.open('', "UserConfferPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		USER_confferPop.target = "UserConfferPop";
		USER_confferPop.method = "post";
		USER_confferPop.action = url;
		USER_confferPop.submit();
		USER_confferPop.target = "";

		return;
	}

	/* ## event - 즐겨찾기 결의서 반영 ## */
	function fnCallbackFavorites(param) {
		flagFavorites = true;
		/* [ ajax parameter ] */
		var parameter = {};
		parameter.resDocSeq = resDocSeq;
		parameter.favoriteResDocSeq = param.resDocSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResFavoriteInfoUpdate.do',
			datatype : 'json',
			async : false,
			/*   - data : consDocSeq(참조 품의서 시퀀스), resDocSeq(작성중인 결의문서 시퀀스) */
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : parameter.resDocSeq,
			resSeq : parameter.resSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);
				useFavorites = result.result.aData.resHeadInfo.length;

				if (Option.Common.GetResultCode(result) === 'SUCCESS') {
					approvalBack = !approvalBack;
					var aData = Option.Common.GetResult(result, 'aData');

					/* 회계단위 정보 반영 */
					if (Option.Common.iCUBE()) {
						if (aData.resDocInfo) {
							if (aData.resDocInfo.length > 0) {
								/* ERP 기수정보 처리 */
								optionSet.erpGisu.gisu = result.result.aData.resHeadInfo[0].erpGisu;
								optionSet.erpGisu.fromDate = result.result.aData.resHeadInfo[0].erpGisuFromDate;
								optionSet.erpGisu.toDate = result.result.aData.resHeadInfo[0].erpGisuToDate;
								fnShowGisuInfo();
								optionSet.confferInfo = {
									consDocSeq : result.result.aData.resDocInfo[0].confferDocSeq
								};
								if (aData.resDocInfo[0].erpDivSeq && aData.resDocInfo[0].erpDivName) {
									$('#lbErpDivName').val(aData.resDocInfo[0].erpDivName);
									$('#lbErpDivName').attr('seq', aData.resDocInfo[0].erpDivSeq);

									optionSet.erpEmpInfo.vatControl = aData.budgetInfo[0].ctlFgCode;
									optionSet.erpEmpInfo.erpDivName = aData.resDocInfo[0].erpDivName;
									optionSet.erpEmpInfo.erpDivSeq = aData.resDocInfo[0].erpDivSeq;
								}
							}
						}
					}else if(Option.Common.ERPiU()){
						if (aData.resDocInfo) {
							if (aData.resDocInfo.length > 0) {
								if (aData.resDocInfo[0].erpDivSeq && aData.resDocInfo[0].erpDivName) {
									$('#lbErpDivName').val(aData.resHeadInfo[0].erpPcName);
									$('#lbErpDivName').attr('seq', aData.resHeadInfo[0].erpPcSeq);

									optionSet.erpEmpInfo.erpDivName = aData.resHeadInfo[0].erpPcName;
									optionSet.erpEmpInfo.erpDivSeq = aData.resHeadInfo[0].erpPcSeq;
									optionSet.erpEmpInfo.erpPcName = aData.resHeadInfo[0].erpPcName;
									optionSet.erpEmpInfo.erpPcSeq = aData.resHeadInfo[0].erpPcSeq;
								}
							}
						}
					}

					fnResSelect(); /* 결의정보 조회 및 반영 */
					//fnResAllInfo(); /* 결의문서 금액 갱신 ( 자동계산 처라 ) */
					//Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
					$('#btnTradeAdd').click();

				} else if(resultCode == 'GISU_CLOSE'){
					alert('기수 마감되어 품의서를 입력할 수 없습니다.');
				} else{
					alert('품의서 반영 실패');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});
	}

	/* ## event - 참조 품의서 반영 ## */
	function fnCallbackConffer(param) {
		/* iCUBE example : {"deptName":"팀장","balanceAmt":10000,"docSeq":"200000000000924","docNo":"테스트부서2-18","confferReturnYN":"N","compSeq":"707010010252","expendDate":"2018-04-13","compName":"상배 비영리(G20)","consDocSeq":464,"deptSeq":"707010010252","empName":"장지훈","amt":0,"consDocNote":"","empSeq":"707010012080","docTitle":"104,500원 품의서","amt":10000} */
		// Option.Common.SetFocusAmtUpdate();

		/* [ ajax parameter ] */
		var parameter = {};
		parameter.consDocSeq = param.consDocSeq;
		parameter.docSeq = param.docSeq;
		parameter.resDocSeq = resDocSeq;
		parameter.formSeq = formSeq;
		parameter.erpDeptSeq = optionSet.erpEmpInfo.erpDeptSeq||'';
		parameter.erpDeptName = optionSet.erpEmpInfo.erpDeptName||'';

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/res/ResConfferInfoUpdate.do',
			datatype : 'json',
			async : false,
			/*   - data : consDocSeq(참조 품의서 시퀀스), resDocSeq(작성중인 결의문서 시퀀스) , docSeq(참조 품의서 문서번호)*/
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : parameter.resDocSeq,
			resSeq : parameter.resSeq,
			docSeq : parameter.docSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);
				if (Option.Common.GetResultCode(result) === 'GISU_CLOSE') {
					alert(' 품의서의 기수가 마감되어 참조할 수 없습니다. ');
					return;
				}

				if (Option.Common.GetResultCode(result) === 'SUCCESS') {
					approvalBack = !approvalBack;

					var aData = Option.Common.GetResult(result, 'aData');

					/* 회계단위 정보 반영 */
					if (Option.Common.iCUBE()) {
						if (aData.resDocInfo) {
							if (aData.resDocInfo.length > 0) {
								/* ERP 기수정보 처리 */
								optionSet.erpGisu.gisu = result.result.aData.resHeadInfo[0].erpGisu;
								optionSet.erpGisu.fromDate = result.result.aData.resHeadInfo[0].erpGisuFromDate;
								optionSet.erpGisu.toDate = result.result.aData.resHeadInfo[0].erpGisuToDate;
								fnShowGisuInfo();
								optionSet.confferInfo = {
									consDocSeq : result.result.aData.resDocInfo[0].confferDocSeq
								};
								if (aData.resDocInfo[0].erpDivSeq && aData.resDocInfo[0].erpDivName) {
									$('#lbErpDivName').val(aData.resDocInfo[0].erpDivName);
									$('#lbErpDivName').attr('seq', aData.resDocInfo[0].erpDivSeq);

									//optionSet.erpEmpInfo.vatControl = aData.budgetInfo[0].ctlFgCode;
									optionSet.erpEmpInfo.erpDivName = aData.resDocInfo[0].erpDivName;
									optionSet.erpEmpInfo.erpDivSeq = aData.resDocInfo[0].erpDivSeq;
								}
							}
						}
					}else if(Option.Common.ERPiU()){
						if (aData.resDocInfo) {
							if (aData.resDocInfo.length > 0) {
								if (aData.resDocInfo[0].erpDivSeq && aData.resDocInfo[0].erpDivName) {
									$('#lbErpDivName').val(aData.resHeadInfo[0].erpPcName);
									$('#lbErpDivName').attr('seq', aData.resHeadInfo[0].erpPcSeq);

									optionSet.erpEmpInfo.erpDivName = aData.resHeadInfo[0].erpPcName;
									optionSet.erpEmpInfo.erpDivSeq = aData.resHeadInfo[0].erpPcSeq;
									optionSet.erpEmpInfo.erpPcName = aData.resHeadInfo[0].erpPcName;
									optionSet.erpEmpInfo.erpPcSeq = aData.resHeadInfo[0].erpPcSeq;
								}
							}
						}
					}

					/* 결의정보 - resHeadInfo */
					$.each(aData.resHeadInfo, function(idx, resItem) {
						fnEventResAdd(false);
						var resUID = $('#resTbl').dzt('getUID');

						/* 헤더 정보 생성, 수정 시 포멧 변환 별도 처리 진행하므로 포맷 지정해도 문제가 발생되지 않음 */
						resItem.resDate = (resItem.resDate || '').toString().replace(/-/g, '');
						if (resItem.resDate.length === 8) {
							resItem.resDate = [ resItem.resDate.substring(0, 4), resItem.resDate.substring(4, 6), resItem.resDate.substring(6, 8) ].join('-').toString();
						}
						$('#resTbl').dzt('setValue', resUID, resItem, false);

						setTimeout(function() {
							/* 결의정보 마지막 행 선택 */
							$('#resTbl').dzt('setDefaultFocus', 'LAST');
						}, 300);

						/* 금액 갱신 */
						Option.Common.SetFocusAmtUpdate();
					});

					confferFlag = result.result.aData.resHeadInfo.length;
					approvalBack = !approvalBack;
					consReferYN = 'Y';
					Option[Option.Common.GetErpType()].GetBudgetAmtInfo('tradeAmt'); /* 예산금액 조회 */

					/* 결의정보 추가 버튼 미표시 처리 */
					$('#btnResReset').hide();
					$('#btnResAdd').hide();
					$('#btnResDelete').hide();
					$('#btnConsRefer').hide();
					$('#btnBringFavorites').hide();
				} else if(resultCode == 'GISU_CLOSE'){
					alert('기수 마감되어 품의서를 입력할 수 없습니다.');
				} else{
					alert('품의서 반영 실패');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});
	}

	/* ## event - GNTP 커스텀 결의서 데이터 셋팅. */
	function fnCallbackConfferGNTP(param) {

		var parameter = {};
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */
		parameter.consDocSeq = param.consDocSeq;
		parameter.resDocSeq = resDocSeq;
		parameter.formSeq = formSeq;
		parameter.erpDeptSeq = optionSet.erpEmpInfo.erpDeptSeq||'';
		parameter.erpDeptName = optionSet.erpEmpInfo.erpDeptName||'';
		parameter.resCustomProcess = true;

		parameter.resDocInfo = '${resDocInfo}';
		parameter.resHeadInfo = '${resHeadInfo}';
		parameter.resBudgetInfo = '${resBudgetInfo}';
		parameter.resTradeInfo = '${resTradeInfo}';

		let headInfoStr = parameter.resHeadInfo;

		if (headInfoStr !== undefined || headInfoStr !== "") {
			//console.log('HERE1 :: headInfo :: ', headInfoStr);
			let headInfo = JSON.parse(headInfoStr)[0];
			parameter.erpDivSeq = headInfo.erpDivSeq;
			parameter.erpDivName = headInfo.erpDivName;
		} else {
			//console.log('HERE2 :: headInfo :: ', headInfo);
			parameter.erpDivSeq = String($("#lbErpDivName").attr("seq"))
			parameter.erpDivName = String($("#lbErpDivName").val());
		}

		/* [ ajax ] */
		$.ajax({
			type: 'post',
			url: domain + '/ex/np/user/res/ResConfferInfoUpdate.do',
			data: parameter,
			success: function (result) {
				let resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'GISU_CLOSE') {
					alert(' 품의서의 기수가 마감되어 참조할 수 없습니다. ');
				}

				approvalBack = !approvalBack;

				const aData = Option.Common.GetResult(result, 'aData');

				if (Option.Common.iCUBE()) {
					// if (aData.resDocInfo) {
					if (aData.resDocInfo.length > 0) {
						/* ERP 기수정보 처리 */
						optionSet.erpGisu.gisu = result.result.aData.resHeadInfo[0].erpGisu;
						optionSet.erpGisu.fromDate = result.result.aData.resHeadInfo[0].erpGisuFromDate;
						optionSet.erpGisu.toDate = result.result.aData.resHeadInfo[0].erpGisuToDate;
						fnShowGisuInfo();
						optionSet.confferInfo = {consDocSeq : gntpKey};
						if (aData.resDocInfo[0].erpDivSeq && aData.resDocInfo[0].erpDivName) {
							$('#lbErpDivName').val(aData.resDocInfo[0].erpDivName);
							$('#lbErpDivName').attr('seq', aData.resDocInfo[0].erpDivSeq);

							//optionSet.erpEmpInfo.vatControl = aData.budgetInfo[0].ctlFgCode;
							optionSet.erpEmpInfo.erpDivName = aData.resDocInfo[0].erpDivName;
							optionSet.erpEmpInfo.erpDivSeq = aData.resDocInfo[0].erpDivSeq;
						}
					}
					// }
				}else if(Option.Common.ERPiU()){

					optionSet.confferInfo = {consDocSeq : gntpKey};
					if (aData.resDocInfo.length > 0) {
						if (aData.resDocInfo[0].hasOwnProperty("erpDivName") && aData.resDocInfo[0].hasOwnProperty("erpDivSeq")) {
							$('#lbErpDivName').val(aData.resHeadInfo[0].erpDivName);
							$('#lbErpDivName').attr('seq', aData.resHeadInfo[0].erpDivSeq);

							optionSet.erpEmpInfo.erpDivName = aData.resHeadInfo[0].erpDivName;
							optionSet.erpEmpInfo.erpDivSeq = aData.resHeadInfo[0].erpDivSeq;
							optionSet.erpEmpInfo.erpPcName = aData.resHeadInfo[0].erpDivName;
							optionSet.erpEmpInfo.erpPcSeq = aData.resHeadInfo[0].erpDivSeq;
						}
					}
					// }
				}

				/* 결의정보 - resHeadInfo */
				$.each(aData.resHeadInfo, function(idx, resItem) {
					fnEventResAdd(false);
					var resUID = $('#resTbl').dzt('getUID');

					/* 헤더 정보 생성, 수정 시 포멧 변환 별도 처리 진행하므로 포맷 지정해도 문제가 발생되지 않음 */
					resItem.resDate = (resItem.resDate || '').toString().replace(/-/g, '');
					if (resItem.resDate.length === 8) {
						resItem.resDate = [ resItem.resDate.substring(0, 4), resItem.resDate.substring(4, 6), resItem.resDate.substring(6, 8) ].join('-').toString();
					}
					$('#resTbl').dzt('setValue', resUID, resItem, false);

					setTimeout(function() {
						/* 결의정보 마지막 행 선택 */
						$('#resTbl').dzt('setDefaultFocus', 'LAST');
					}, 300);

					/* 금액 갱신 */
					Option.Common.SetFocusAmtUpdate();
				});

				confferFlag = aData.resHeadInfo.length;
				approvalBack = !approvalBack;
				consReferYN = 'Y';
				Option[Option.Common.GetErpType()].GetBudgetAmtInfo('tradeAmt'); /* 예산금액 조회 */

				/* 결의정보 추가 버튼 미표시 처리 */
				$('#btnResReset').hide();
				$('#btnResAdd').hide();
				$('#btnResDelete').hide();
				$('#btnConsRefer').hide();
				$('#btnBringFavorites').hide();
			},
			error: function (error) {

			}
		});

		// if (Option.Common.GetResultCode(result) === 'SUCCESS') {


			// var aData = Option.Common.GetResult(result, 'aData');


			/* 회계단위 정보 반영 */

		// } else if(resultCode == 'GISU_CLOSE'){
		// 	alert('기수 마감되어 품의서를 입력할 수 없습니다.');
		// } else{
		// 	alert('품의서 반영 실패');
		// }
	}

	/* ## 지난결의서 ## */
	/* ====================================================================================================================================================== */
	/* ## event - 결의정보 지난 결의서 ## */
	function fnEventResRefer() {
		/* console.error('서비스 준비중입니다.'); */
		alert('서비스 준비중입니다.');
		return;
	}

	/* ## 카드사용내역 ## */
	/* ====================================================================================================================================================== */

	/* ## 매입전자세금계산서 ## */
	/* ====================================================================================================================================================== */

	/* ## 기타 ## */
	/* ====================================================================================================================================================== */
	function fnDatepickerOnSelect() {
		/* 결제내역 */
		if ($('#tradeTbl').dzt('getInputValue') != null) {
			if ($('#tradeTbl').dzt('getKEY') === 'regDate') {
				$('#tradeTbl').dzt('setKeyIn', 'RIGHT');
				return false;
			}
		}
	}

	/* ## Log ${CL.ex_check} ## */
	/* ====================================================================================================================================================== */
	function fnAjaxLog(url, result) {
		return;
		console.error('[+]' + url + ' ====================================================================================================')
		console.error(Option.Common.GetResultCode(result));
		console.error(JSON.stringify(Option.Common.GetResult(result, 'aData')));
		console.error(JSON.stringify(Option.Common.GetResult(result, 'aaData')));
		console.error('[-]' + url + ' ====================================================================================================')
	}

	/* ## 급여상세 입력 팝업 ## */
	/* ====================================================================================================================================================== */
	function fnSetSalary(){
		/*----- [0] 기본 사용 변수 수정 -----*/
		var resData = $('#resTbl').dzt('getValue');
		var budgetData = $('#budgetTbl').dzt('getValue');
		var tradeData = $('#tradeTbl').dzt('getValue');

		/*----- [1] 팝업 기본 레이아웃 조정 -----*/
		$('#layerSalary').show();
		$('#divModal').show();

		/*----- [2] 기존 데이터 입력 내역 자동 반영 -----*/
		var date = new Date();
		$('#txtSalaryBelongMonth').val(tradeData.salaryBelongMonth || ( date.getMonth() + 1 ));
		$('#txtSalaryBelongYear').val(tradeData.salaryBelongYear || date.getFullYear());

		var _txtSalaryAmt = ( '' + (tradeData.salaryAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var _txtSalaryStdAmt = ( '' + (tradeData.salaryStdAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var _txtSalaryIncomeVatAmt = ( '' + (tradeData.salaryIncomeVatAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var _txtSalaryResidentVatAmt = ( '' + (tradeData.salaryResidentVatAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var _txtSalaryEtcAmt = ( '' + (tradeData.salaryEtcAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");

		var docuFgMode = '0' /* 0: 수입,지출 1: 여입,반납 */
		if(resData.docuFgCode == '6' || resData.docuFgCode == '7'){
			docuFgMode = '1';
		}
		$('#txtSalaryAmt').val(_txtSalaryAmt);
		$('#txtSalaryStdAmt').val(_txtSalaryStdAmt);
		$('#txtSalaryIncomeVatAmt').val(_txtSalaryIncomeVatAmt);
		$('#txtSalaryResidentVatAmt').val(_txtSalaryResidentVatAmt);
		$('#txtSalaryEtcAmt').val(_txtSalaryEtcAmt);

		/*----- [3] 팝업 인풋 이벤트 지정 -----*/
		/* 금액 컬럼 키입력 이벤트 지정 */
		$('#txtSalaryAmt').focus().select();
		$('#txtSalaryAmt').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#txtSalaryIncomeVatAmt').focus().select();
			} else{
				docuFgMode=='0'?$(this).val($(this).val().replace(/[^-0-9]/g, '').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")):$(this).val( (Math.abs(Number($(this).val().replace(/[^-0-9]/g, '')))*-1).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
			}

			fnSetSalaryStdAmt();
		});
		$('#txtSalaryIncomeVatAmt').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#txtSalaryResidentVatAmt').focus().select();
			} else{
				docuFgMode=='0'?$(this).val($(this).val().replace(/[^-0-9]/g, '').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")):$(this).val( (Math.abs(Number($(this).val().replace(/[^-0-9]/g, '')))*-1).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
			}
			fnSetSalaryStdAmt();
		});
		$('#txtSalaryResidentVatAmt').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#txtSalaryEtcAmt').focus().select();
			} else{
				docuFgMode=='0'?$(this).val($(this).val().replace(/[^-0-9]/g, '').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")):$(this).val( (Math.abs(Number($(this).val().replace(/[^-0-9]/g, '')))*-1).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
			}

			fnSetSalaryStdAmt();
		});
		$('#txtSalaryEtcAmt').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#txtSalaryBelongYear').focus().select();
			} else{
				docuFgMode=='0'?$(this).val($(this).val().replace(/[^-0-9]/g, '').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")):$(this).val( (Math.abs(Number($(this).val().replace(/[^-0-9]/g, '')))*-1).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
			}
			fnSetSalaryStdAmt();
		});
		$('#txtSalaryBelongYear').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#txtSalaryBelongMonth').focus().select();
			}
		});
		$('#txtSalaryBelongMonth').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#btnSalaryLayerOk').click();
			}
		});
	}

	/* 급여 실수령액 자동 계산 */
	function fnSetSalaryStdAmt(){
		var _txtSalaryAmt = $('#txtSalaryAmt').val();
		var _txtSalaryIncomeVatAmt = $('#txtSalaryIncomeVatAmt').val();
		var _txtSalaryResidentVatAmt = $('#txtSalaryResidentVatAmt').val();
		var _txtSalaryEtcAmt = $('#txtSalaryEtcAmt').val();

		_txtSalaryAmt = parseInt(_txtSalaryAmt.replace(/[^-0-9]/g, '') || '0');
		_txtSalaryIncomeVatAmt = parseInt(_txtSalaryIncomeVatAmt.replace(/[^-0-9]/g, '') || '0');
		_txtSalaryResidentVatAmt = parseInt(_txtSalaryResidentVatAmt.replace(/[^-0-9]/g, '') || '0');
		_txtSalaryEtcAmt = parseInt(_txtSalaryEtcAmt.replace(/[^-0-9]/g, '') || '0');


		var _txtSalaryStdAmt = _txtSalaryAmt - _txtSalaryIncomeVatAmt - _txtSalaryResidentVatAmt - _txtSalaryEtcAmt;
		_txtSalaryStdAmt = _txtSalaryStdAmt || '0';

		$('#txtSalaryStdAmt').val(_txtSalaryStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}


	/* ## 사업소득자 입력 팝업 ## */
	/* ====================================================================================================================================================== */
	function fnSetBizMetic(){

		/*----- [0] 기본 사용 변수 수정 -----*/
		var resData = $('#resTbl').dzt('getValue');
		var budgetData = $('#budgetTbl').dzt('getValue');
		var tradeData = $('#tradeTbl').dzt('getValue');

		/*----- [1] 팝업 기본 레이아웃 조정 -----*/
		$('#layerBizMetic').show();
		$('#layerHpMetic').find('table.ERPiU').hide();
		$('#layerHpMetic').find('table.iCUBE').show();
		$('.trBizGbnInfo').show();
		$('.trYNBuempiclMan').show();
		$('#divModal').show();
		$('.trYNBuempiclMan').hide();
		$('.bizIncomeTxt').val('');

		if( tradeData.etcDataCd == 'BI' || Number(resData.resDate.replaceAll('-','')) < 20210801 ){
			$('#employmentInsuranceBizArea').hide();
		}else{
			$('#employmentInsuranceBizArea').show();
		}

		if( (tradeData.etcDataCd || 'F') == 'F'){
			/* 거주 사업 소득자 소득 구분 미노출 */
			$('.trBizGbnInfo').hide();
			$('#employmentBizArea').show();
			if(tradeData.ynBuempiclMan == '0' || (!!tradeData.etcSchoolAmt)){
				/* 학자금 상환 비대상자 학자금 상환액 미노출 처리 */
				$('.trYNBuempiclMan').show();
			}
		} else {
			$('#employmentBizArea').hide();
			/* 비거주자 사업소득 소득 구분 기본 값 적용 */
			if( ( $('#txtBizIncomeSeq').val() || '' ) == '' ){
				var etcTaxRates = {
					needRate : 0
					, incomeTaxRate : 2
					, residentTaxRate : 10
					, etcIncomeName : '비거주자의 사업소득'
					, etcIncomeSeq : '40'
				};
				$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), etcTaxRates, false);
			}
		}

		/*----- [2] 기존 데이터 입력 내역 자동 반영 -----*/
		var date = new Date();
		$('#txtBizBelongMonth').val( tradeData.bizBelongMonth || ( resData.resDate.substr('5','2') ) );
		$('#txtBizBelongYear').val(tradeData.bizBelongYear || date.getFullYear());
		$('#txtBizIncomeName').val(tradeData.etcIncomeName || '');
		$('#txtBizIncomeSeq').val(tradeData.etcIncomeSeq || '');

		var _txtBizIncomeAmt = ( '' + (tradeData.etcIncomeAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#txtBizIncomeAmt').val(_txtBizIncomeAmt);
		var _txtBizIncomeVatAmt = ( '' + (tradeData.etcIncomeVatAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#txtBizIncomeVatAmt').val(_txtBizIncomeVatAmt);
		var _txtBizResidentVatAmt = ( '' + (tradeData.etcResidentVatAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#txtBizResidentVatAmt').val(_txtBizResidentVatAmt);
		var _txtBizSchoolAmt = ( '' + (tradeData.etcSchoolAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#txtBizSchoolAmt').val(_txtBizSchoolAmt);
		var _txtBizEmploymentAmt = ( '' + (tradeData.etcEmploymentAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#txtBizEmploymentAmt').val(_txtBizEmploymentAmt);
		var _txtBizEmploymentInsuranceAmt = ( '' + (tradeData.etcEmploymentInsuranceAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#txtBizEmploymentInsuranceAmt').val(_txtBizEmploymentInsuranceAmt);

		/*----- [3] 팝업 인풋 이벤트 지정 -----*/
		/* 학자금대출 키입력 이벤트 지정 */
		$('#txtBizSchoolAmt').unbind().keyup(function (){
			if ($(this).val() != '-' && $(this).val() != '-0') {
				$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			}
		});
		/* 주민세액 키입력 이벤트 지정 */
		$('#txtBizResidentVatAmt').unbind().keyup(function (){
			if ($(this).val() != '-' && $(this).val() != '-0') {
				$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			}
		});
		/* 소득세액 키입력 이벤트 지정 */
		$('#txtBizIncomeVatAmt').unbind().keyup(function (){
			if ($(this).val() != '-' && $(this).val() != '-0') {
				$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			}
		});
		/* 소득금액 키입력 이벤트 지정 */
		$('#txtBizIncomeAmt').unbind().keyup(function (){
			console.log( 'user input ] biz income Amt : ' + $(this).val() );
			if( ( tradeData.etcDataCd || 'F' ) == 'F'){
				/* 거주 소득자 계산식 */
				var maxAmt = 33333;
				var thisVal = (resData.docuFgCode =='6' || resData.docuFgCode=='7') ? -1 * parseInt( ( $(this).val() || '' ).replace(/[^0-9-]/gi, '') || '0' ) :parseInt( ( $(this).val() || '' ).replace(/[^0-9-]/gi, '') || '0' );
				if(Math.abs(thisVal) <= Math.abs(maxAmt)){
					// 소득 세액
					$('#txtBizIncomeVatAmt').val('0');
					// 주민 세액
					$('#txtBizResidentVatAmt').val('0');
				}else{
					var incomeVat = parseInt( thisVal * 0.03 );
					incomeVat = parseInt( incomeVat / 10 ) * 10;
					var residentVat = parseInt( incomeVat * 0.1 );
					residentVat = parseInt( residentVat / 10 ) * 10;
					$('#txtBizIncomeVatAmt').val(   ( incomeVat || '0' ).toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
					$('#txtBizResidentVatAmt').val( ( residentVat  || '0' ).toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
				}
			}else if (tradeData.etcDataCd == 'BI'){
				/* 비거주 소득자 계산식 */
				var maxAmt = optionSet.erpAbsdocu.mtaxAmt;

				var thisVal = (resData.docuFgCode =='6' || resData.docuFgCode=='7') ? -1 * parseInt( ( $(this).val() || '' ).replace(/[^0-9-]/gi, '') || '0' ) :parseInt( ( $(this).val() || '' ).replace(/[^0-9-]/gi, '') || '0' );
				if(Math.abs(thisVal) <= Math.abs(maxAmt)){
					// 소득 세액
					$('#txtBizIncomeVatAmt').val('');
					// 주민 세액
					$('#txtBizResidentVatAmt').val('');
				}else{
					var incomeSeq = '' + $('#txtBizIncomeSeq').val();
					var incomeVat = 0;
					var residentVat = 0;
					switch(incomeSeq){
						case '40' :
						case '41' :
							incomeVat = parseInt( parseInt( thisVal * 0.02 ) / 10 ) * 10 ;
							residentVat = parseInt( parseInt( incomeVat * 0.1 ) / 10 ) * 10 ;
						break;
						case '42' :
						case '62' :
							incomeVat = parseInt( parseInt( thisVal * 0.2 ) / 10 ) * 10 ;
							residentVat = parseInt( parseInt( incomeVat * 0.1 ) / 10 ) * 10 ;
						break;
					}
					$('#txtBizIncomeVatAmt').val(   ( incomeVat || '0' ).toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
					$('#txtBizResidentVatAmt').val( ( residentVat  || '0' ).toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ",") );
				}
			}

			if ($(this).val() == '0-') {
				$(this).val('-');
			}

			if ($(this).val() != '-' && $(this).val() != '-0') {
				$(this).val(thisVal.toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			}

			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				if(parseInt($(this).val()) != 0){
					$('#txtBizBelongYear').focus().select();
				}
			}
		});
		$('#txtBizSchoolAmt').unbind().keyup(function (){
			/* 학자금 상환액 키입력 이벤트 지정 */
			if ($(this).val() != '-' && $(this).val() != '-0') {
				$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			}

			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				if(parseInt($(this).val()) != 0){
					$('#txtBizBelongYear').focus().select();
				}
			}
		});
		$('#txtBizEmploymentAmt').unbind().keyup(function (){
			/* 예술인 고용보험액 키입력 이벤트 지정 */
			if ($(this).val() != '-' && $(this).val() != '-0') {
				$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			}

			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				if(parseInt($(this).val()) != 0){
					if(Number($('#txtBizEmploymentAmt').val().replace(',','')) > 0){
						alert("'고용보험료'는 고용보험이 적용되는 예술인(문화예술용역)의 월 평균소득이 50만원 이상인 경우 입력합니다.잘못된 공제를 받지 않도록 소득자가 고용보험이 적용되는 예술인에 해당하는지 확인 후 입력하시기 바랍니다.");
						$('#txtBizBelongYear').focus().select();
					}
				}
			}
		});
		$('#txtBizEmploymentInsuranceAmt').unbind().keyup(function (){
			/* 산재보험료 키입력 이벤트 지정 */
			if ($(this).val() != '-' && $(this).val() != '-0') {
				$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			}

			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				if(Number($('#txtBizEmploymentInsuranceAmt').val().replace(',','')) > 0){
					alert("'산재보험료'는 산재보험이 적용되는 업종(특수형태근로종사자 중 일부 업종 및 무급가족종사자 포함)인 경우 입력합니다. 잘못된 공제를 받지 않도록 소득자가 산재보험이 적용되는 업종에 해당하는지 확인 후 입력하시기 바랍니다.");
					$('#txtBizBelongYear').focus().select();
				}
			}
		});

		/* 귀속 년도  biz_belong_year */
		$('#txtBizBelongYear').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#txtBizBelongMonth').focus().select();
			}
		});
		/* 귀속 월  biz_belong_month */
		$('#txtBizBelongMonth').unbind().keyup(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#btnBizLayerOk').click();
			}
		});

		/*----- [4] 소득 금액 포커스 -----*/
		$('#txtBizIncomeAmt').focus();
	}

	function fnSetEtcRateCal(rate){
		switch(rate){
			case '60':
			case '65':
			case '69':
			case '71':
			case '72':
			case '73':
			case '74':
			case '75':
			case '76':
			case '78':
			case '79':
			case '80':
				var etcRate = {
					incomeTaxRate : 20
					, residentTaxRate : 10
				}
				break;
			case '63':
				var etcRate = {
					incomeTaxRate : 15
					, residentTaxRate : 10
				}
				break;
			case '61':
			case '62':
			case '68':
				var etcRate = {
					incomeTaxRate : 0
					, residentTaxRate : 0
				}
				break;
		}
		return etcRate;
	}

	/* ## 기타소득자 ## */
	/* ====================================================================================================================================================== */
	function fnSetHpMetic() {
		var resData = $('#resTbl').dzt('getValue');
		var budgetData = $('#budgetTbl').dzt('getValue');
		var tradeData = $('#tradeTbl').dzt('getValue');

		/* 비거주자의 사업소득 : 필요경비율 공백 (수정불가), 필요경비금액 ( 사용자 입력 ), 소득금액 ( 사용자 입력 ), 소득세액 ( 사용자 입력 ), 주민세액 ( 소득세액의 1/10, 사용자 입력 가능 ), 귀속년월 ( 사용자 입력 ), 신고귀속 ( 귀속년월의 년 ) */
		/* 선박등 입대소득 : 필요경비율 공백 (수정불가), 필요경비금액 ( 사용자 입력 ), 소득금액 ( 사용자 입력 ), 소득세액 ( 사용자 입력 ), 주민세액 ( 소득세액의 1/10, 사용자 입력 가능 ), 귀속년월 ( 사용자 입력 ), 신고귀속 ( 귀속년월의 년 ) */
		/* 인적용역소득 : 필요경비율 공백 (수정불가), 필요경비금액 ( 사용자 입력 ), 소득금액 ( 사용자 입력 ), 소득세액 ( 사용자 입력 ), 주민세액 ( 소득세액의 1/10, 사용자 입력 가능 ), 귀속년월 ( 사용자 입력 ), 신고귀속 ( 귀속년월의 년 ) */
		/* 사용료소득 : 필요경비율 공백 (수정불가), 필요경비금액 ( 사용자 입력 ), 소득금액 ( 사용자 입력 ), 소득세액 ( 사용자 입력 ), 주민세액 ( 소득세액의 1/10, 사용자 입력 가능 ), 귀속년월 ( 사용자 입력 ), 신고귀속 ( 귀속년월의 년 ) */
		/* 기타소득 : 필요경비율 공백 (수정불가), 필요경비금액 ( 사용자 입력 ), 소득금액 ( 사용자 입력 ), 소득세액 ( 사용자 입력 ), 주민세액 ( 소득세액의 1/10, 사용자 입력 가능 ), 귀속년월 ( 사용자 입력 ), 신고귀속 ( 귀속년월의 년 ) */


		$('#layerHpMetic').show();
		if (Option.Common.ERPiU()){
			$('#layerHpMetic').find('table.ERPiU').show();
			$('#layerHpMetic').find('table.iCUBE').hide();
		} else {
			$('#employmentEtcArea').show();
			$('#employmentInsuranceEtcArea').show();
			if( tradeData.etcDataCd == 'BI' || Number(resData.resDate.replaceAll('-','')) < 20201201 ){
				$('#employmentEtcArea').hide();
			}
			if( tradeData.etcDataCd == 'BI' || Number(resData.resDate.replaceAll('-','')) < 20210801 ){
				$('#employmentInsuranceEtcArea').hide();
			}

			$('#layerHpMetic').find('table.ERPiU').hide();
			$('#layerHpMetic').find('table.iCUBE').show();
		}
		$('#divModal').show();

		if (Option.Common.ERPiU()){
			var resData = $('#resTbl').dzt('getValue');
			var tradeData = $('#tradeTbl').dzt('getValue');

			if($('#budgetTbl').dzt('getValue').vatFgCode == '3' && $('#budgetTbl').dzt('getValue').trFgCode == '9'){
				/* 사업소득자 */
				$('#layerHpMetic table tr:eq(2)').hide();
				$('#layerHpMetic table tr:eq(3) th:eq(1)').hide();
				$('#layerHpMetic table tr:eq(3) td:eq(1)').hide();
				$('#layerHpMetic table tr:eq(3) td:eq(0)').attr('colspan', '3');
				$('#layerHpMetic table tr:eq(4)').hide();

				// 지급일자
				$('#txtERPiUHPPayDate').val($('#resTbl').dzt('getValue').resDate);
				// 귀속년월
				$('#txtERPiUHPPayDateYearMonth').val($('#resTbl').dzt('getValue').resDate.substring(0, 7));

				$('#txtERPiUCdPc').val(tradeData.etcBizSeq||''); /* 사업장 코드 */
				$('#txtERPiUNmPc').val(tradeData.etcBizName||''); /* 사업장 이름 */

				// 지급금액
				$('#txtERPiUTotalAmt').val(tradeData.etcIncomeAmt||'0');
				// 소득세
				$('#txtERPiUIncomTaxAmt').val(tradeData.etcIncomeVatAmt||'0');
				// 지방소득세
				$('#txtERPiUResidTaxAmt').val(tradeData.etcResidentVatAmt||'0');

				// 소득세율
				$('#txtERPiUIncomTaxPer').val('3');
				// 지방소득세율
				$('#txtERPiUResidTaxPer').val('10');
			} else {
				/* 기타소득자 */
				$('#layerHpMetic table tr:eq(2)').show();
				$('#layerHpMetic table tr:eq(3) th:eq(1)').show();
				$('#layerHpMetic table tr:eq(3) td:eq(1)').show();
				$('#layerHpMetic table tr:eq(3) td:eq(0)').removeAttr('colspan');
				$('#layerHpMetic table tr:eq(4)').show();

				$('#txtERPiUCdPc').val(tradeData.etcBizSeq||''); /* 사업장 코드 */
				$('#txtERPiUNmPc').val(tradeData.etcBizName||''); /* 사업장 이름 */

				// 지급일자
				$('#txtERPiUHPPayDate').val(tradeData.etcBelongDate||$('#resTbl').dzt('getValue').resDate);
				// 귀속년월
				$('#txtERPiUHPPayDateYearMonth').val(tradeData.etcBelongYearmonth||$('#resTbl').dzt('getValue').resDate.substring(0, 7));
				// 소득구분
				$('#txtERPiUIncomeGbnCode').val(tradeData.etcIncomeSeq||'');
				// 필요경비율
				$('#txtERPiUTransPer').val(tradeData.etcRequiredRate||'0');
				// 소득세율
				var incomeRate = fnSetEtcRateCal(tradeData.etcIncomeSeq||'62');
				$('#txtERPiUIncomTaxPer').val(incomeRate.incomeTaxRate||'0');
				// 지방소득세율
				$('#txtERPiUResidTaxPer').val(incomeRate.residentTaxRate||'0');

				// 지급금액
				$('#txtERPiUTotalAmt').val(tradeData.tradeAmt||'0');
				// 필요경비
				$('#txtERPiUTransAmt').val(tradeData.etcRequiredAmt||'0');
				// 소득금액
				$('#txtERPiUAmt').val(tradeData.etcIncomeAmt||'0');
				// 소득세
				$('#txtERPiUIncomTaxAmt').val(tradeData.etcIncomeVatAmt||'0');
				// 지방소득세
				$('#txtERPiUResidTaxAmt').val(tradeData.etcResidentVatAmt||'0');
			}

			// 이벤트 적용
			$('#txtERPiUTotalAmt, #txtERPiUTransPer, #txtERPiUIncomTaxPer, #txtERPiUResidTaxPer').unbind();
			$('#txtERPiUTotalAmt, #txtERPiUTransPer, #txtERPiUIncomTaxPer, #txtERPiUResidTaxPer').keyup(function(){
				fnCalcERPiUEtcAmt();
			});
		}
		else {
			var resData = $('#resTbl').dzt('getValue');
			var tradeData = $('#tradeTbl').dzt('getValue');
			$('#txtEtcIncomeSeq').val(tradeData.etcIncomeSeq||'');
			/* 소득자 구분 팝업 최초 오픈 */
			if( ( $('#txtEtcIncomeSeq').val() || '' ) == ''){
				if(tradeData.etcDataCd == 'BI'){
					/* 비거주 기타 소득자 기본 값 적용 */
					var etcTaxRates = {
							needRate : 0
							, incomeTaxRate : 20
							, residentTaxRate : 10
							, etcIncomeName : '기타소득'
							, etcIncomeSeq : '62'
							, etcRequiredRate : 0
						};
						$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), etcTaxRates, false);
				} else if( (tradeData.etcDataCd || 'G') == 'G'){
					/* 거주 기타 소득자 기본 값 적용 */
					var etcTaxRates = {
						needRate : 60
						, incomeTaxRate : 20
						, residentTaxRate : 10
						, etcIncomeName : '강연료 등'
						, etcIncomeSeq : '76'
						, etcRequiredRate : 60
					};
					$('#tradeTbl').dzt('setValue', $('#tradeTbl').dzt('getUID'), etcTaxRates, false);
				}
			}

			/* 기타소득자 - 기타소득상세 입력 팝업 데이터 초기화 */
			$('#txtEtcIncomeSeq').val((tradeData.etcIncomeSeq || ''));
			$('#txtEtcIncomeName').val((tradeData.etcIncomeName || ''));
			$('#txtEtcAmt').val((tradeData.tradeAmt || '0'));
			$('#txtEtcRequiredRate').val((tradeData.etcRequiredRate || '0'));
			$('#txtEtcEmploymentAmt').val((tradeData.etcEmploymentAmt || '0'));
			$('#txtEtcEmploymentInsuranceAmt').val((tradeData.etcEmploymentInsuranceAmt || '0'));
			$('#txtEtcBelongYear').val((tradeData.etcBelongYear || ((resData.resDate || '').length > 4 ? (resData.resDate || '').toString().replace(/-/g, '').substring(0, 4) : '')));
			$('#txtEtcBelongMonth').val((tradeData.etcBelongMonth || ((resData.resDate || '').length > 6 ? (resData.resDate || '').toString().replace(/-/g, '').substring(4, 6) : '')));

			/* 기타소득자 - 기타소득상세 입력 팝업 금액 초기화 */
			var _txtEtcRequiredAmt = ( '' + (tradeData.etcRequiredAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#txtEtcRequiredAmt').val( _txtEtcRequiredAmt );
			var _txtEtcIncomeAmt = ( '' + (tradeData.etcIncomeAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#txtEtcIncomeAmt').val( _txtEtcIncomeAmt );
			var _txtEtcIncomeVatAmt = ( '' + (tradeData.etcIncomeVatAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#txtEtcIncomeVatAmt').val( _txtEtcIncomeVatAmt );
			var _txtEtcResidentVatAmt = ( '' + (tradeData.etcResidentVatAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#txtEtcResidentVatAmt').val( _txtEtcResidentVatAmt );
			var _txtEtcEmploymentAmt = ( '' + (tradeData.etcEmploymentAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#txtEtcEmploymentAmt').val( _txtEtcEmploymentAmt );
			var _txtEtcEmploymentInsuranceAmt = ( '' + (tradeData.etcEmploymentInsuranceAmt || '0')).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#txtEtcEmploymentInsuranceAmt').val( _txtEtcEmploymentInsuranceAmt );


			/* 소득구분 코드 etc_income_seq */
			/* 소득구분 명 etc_income_name */
			/* 필요 경비율  etc_required_rate */

			/* 지급총액 이벤트 바인딩 */
			$('#txtEtcAmt').unbind().keyup(function() {

				if( $('#resTbl').dzt('getValueAll')[0].docuFgCode == '6' || $('#resTbl').dzt('getValueAll')[0].docuFgCode == '7' ){
					var orgnVal = $(this).val().replace(/[^0-9-]/gi, '');
					if(!orgnVal.includes('-')){
						orgnVal = orgnVal * -1;
					}
					$(this).val(orgnVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				else{
					var orgnVal = $(this).val().replace(/[^0-9-]/gi, '');
				}
				$(this).val(orgnVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {

					if(parseInt(orgnVal) != 0){
						$('#txtEtcBelongYear').focus().select();
					}
				}
				orgnVal = orgnVal || 0;
				var tradeData = $('#tradeTbl').dzt('getValue');
				var needRate = tradeData.needRate || 0;
				var incomeTaxRate = tradeData.incomeTaxRate || 0;
				var residentTaxRate = tradeData.residentTaxRate || 0;



				/* 필요경비금액 */
				var needAmt = parseInt( parseFloat( orgnVal ) / 100  *  needRate  );
					$('#txtEtcRequiredAmt').val(Number(needAmt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				/* 소득금액 */
				var incomeAmt = parseInt( orgnVal - needAmt );
					$('#txtEtcIncomeAmt').val(Number(incomeAmt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

				/* G20 과세최저한 옵션 대응 처리 ( 소득금액 금액 < 과세최저한 -> 소득,주민세액 0원 처리 ) */
				if( incomeAmt <=  optionSet.erpAbsdocu.mtaxAmt){
					incomeTaxRate = 0;
					residentTaxRate = 0;
				}

				/* 소득세액 */
				var incomeTaxAmt = parseInt( ( parseFloat( incomeAmt ) / 100 *  incomeTaxRate )  );
				incomeTaxAmt = parseInt(incomeTaxAmt / 10 ) * 10; // 원단위 절사  이재문 수정
				$('#txtEtcIncomeVatAmt').val(Number(incomeTaxAmt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				/* 주민세액 */
				var  residentTaxAmt = parseInt( ( parseFloat(incomeTaxAmt) / 100 * residentTaxRate ) );
				residentTaxAmt = parseInt(residentTaxAmt / 10 ) * 10; // 원단위 절사  이재문 수정
				$('#txtEtcResidentVatAmt').val(Number(residentTaxAmt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

			});
			$('#txtEtcRequiredRate').unbind().keyup(function() {
				if( $('#resTbl').dzt('getValueAll')[0].docuFgCode == '6' || $('#resTbl').dzt('getValueAll')[0].docuFgCode == '8' ){
					$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				else{
					var tradeUID = $('#tradeTbl').dzt('getUID');
					$('#tradeTbl').dzt('setValue', tradeUID, { needRate : $(this).val().replace(/,/g, '') }, false);
				}
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					$('#txtEtcAmt').focus().select();
				}
			});
			/* 필요 경비 금액  etc_required_amt */
			$('#txtEtcRequiredAmt').unbind().keyup(function() {
				if ($(this).val() != '-' && $(this).val() != '-0') {
					$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					$('#txtEtcIncomeAmt').focus().select();
				}
			});
			/* 소득 금액 etc_income_amt */
			$('#txtEtcIncomeAmt').unbind().keyup(function() {
				if ($(this).val() != '-' && $(this).val() != '-0') {
					$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					$('#txtEtcIncomeVatAmt').focus().select();
				}
			});
			/* 소득 세액 etc_income_vat_amt */
			$('#txtEtcIncomeVatAmt').unbind().keyup(function() {
				if ($(this).val() != '-' && $(this).val() != '-0') {
					$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					$('#txtEtcResidentVatAmt').focus().select();
				}
			});
			/* 주민 세액 etc_resident_vat_amt */
			$('#txtEtcResidentVatAmt').unbind().keyup(function() {
				if ($(this).val() != '-' && $(this).val() != '-0') {
					$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					$('#txtEtcBelongYear').focus().select();
				}
			});
			/* 고용보험료 etc_employment_amt */
			$('#txtEtcEmploymentAmt').unbind().keyup(function() {
				if ($(this).val() != '-' && $(this).val() != '-0') {
					$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					alert("'고용보험료'는 고용보험이 적용되는 예술인(문화예술용역)의 월 평균소득이 50만원 이상인 경우 입력합니다.잘못된 공제를 받지 않도록 소득자가 고용보험이 적용되는 예술인에 해당하는지 확인 후 입력하시기 바랍니다.");
					$('#txtEtcBelongYear').focus().select();
				}
			});
			/* 산재보험료 etc_employment_insurance_amt */
			$('#txtEtcEmploymentInsuranceAmt').unbind().keyup(function() {
				if ($(this).val() != '-' && $(this).val() != '-0') {
					$(this).val(Number($(this).val().replace(/,/g, '').replace(/,/g, '')).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					alert("'산재보험료'는 산재보험이 적용되는 업종(특수형태근로종사자 중 일부 업종 및 무급가족종사자 포함)인 경우 입력합니다. 잘못된 공제를 받지 않도록 소득자가 산재보험이 적용되는 업종에 해당하는지 확인 후 입력하시기 바랍니다.");
					$('#txtEtcBelongYear').focus().select();
				}
			});
			/* 귀속 년도  etc_belong_year */
			$('#txtEtcBelongYear').unbind().keyup(function() {
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					$('#txtEtcBelongMonth').focus().select();
				}
			});
			/* 귀속 월  etc_belong_month */
			$('#txtEtcBelongMonth').unbind().keyup(function() {
				var keyCode = event.keyCode ? event.keyCode : event.which;
				if (keyCode.toString() === '13') {
					$('#btnLayerOk').click();
				}
			});

			$('#txtEtcAmt').focus().select();
		}
	}

	function fnSetSalary_Callback(){
		var resultValue = {
			'salaryBelongMonth' :  $('#txtSalaryBelongMonth').val()
			, 'salaryBelongYear' : $('#txtSalaryBelongYear').val()
			, 'salaryAmt' : $('#txtSalaryAmt').val()
			, 'salaryStdAmt' : $('#txtSalaryStdAmt').val()
			, 'salaryIncomeVatAmt' : $('#txtSalaryIncomeVatAmt').val()
			, 'salaryResidentVatAmt' : $('#txtSalaryResidentVatAmt').val()
			, 'salaryEtcAmt' : $('#txtSalaryEtcAmt').val()
		};

		/* 월정보 두자리로 맞추기 */
		resultValue.salaryBelongMonth = parseInt(resultValue.salaryBelongMonth) < 10 ? '0' + parseInt(resultValue.salaryBelongMonth) : parseInt(resultValue.salaryBelongMonth);
		resultValue.tradeAmt = resultValue.salaryAmt;
		resultValue.tradeVatAmt = (
				Number((resultValue.salaryEtcAmt || '0').replace(/,/g, ''))
				+ Number((resultValue.salaryIncomeVatAmt || '0').replace(/,/g, ''))
				+ Number((resultValue.salaryResidentVatAmt || '0').replace(/,/g, ''))
			).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); /* 소득세액 + 주민세액 + 학자금상환액*/
		resultValue.tradeStdAmt = resultValue.salaryStdAmt;

		resultValue.salaryAmt = ('' + resultValue.salaryAmt).replace(/,/gi, '');
		resultValue.salaryStdAmt = ('' + resultValue.salaryStdAmt).replace(/,/gi, '');
		resultValue.salaryIncomeVatAmt = ('' + resultValue.salaryIncomeVatAmt).replace(/,/gi, '');
		resultValue.salaryResidentVatAmt = ('' + resultValue.salaryResidentVatAmt).replace(/,/gi, '');
		resultValue.salaryEtcAmt = ('' + resultValue.salaryEtcAmt).replace(/,/gi, '');

		var tradeUID = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', tradeUID, resultValue, false);
		$('#tradeTbl').dzt('setFocus', tradeUID, 'btrName');
	}

	function fnSetBizMetic_Callback() {
		var resultValue = {};

		if(Option.Common.ERPiU()){
			/* iU사업 소득자 개선 예정 */
		} else if(Option.Common.iCUBE()){
			resultValue.etcIncomeSeq = $('#txtBizIncomeSeq').val();			/* 소득 구분 코드 */
			resultValue.etcIncomeName = $('#txtBizIncomeName').val();		/* 소득 구분 명칭 */
			resultValue.etcIncomeAmt  = $('#txtBizIncomeAmt').val();		/* 소득 금액 */
			resultValue.etcIncomeVatAmt  = $('#txtBizIncomeVatAmt').val();	/* 소득 세액 */
			resultValue.etcResidentVatAmt  = $('#txtBizResidentVatAmt').val()	/* 지방 소득 세액 */
			resultValue.etcSchoolAmt = $('#txtBizSchoolAmt').val()			/* 학자금 상환 액 */
			resultValue.etcEmploymentAmt = $('#txtBizEmploymentAmt').val() /* 고용보험액 */
			resultValue.etcEmploymentInsuranceAmt = $('#txtBizEmploymentInsuranceAmt').val() /* 산재보험료 */
			resultValue.bizBelongYear = $('#txtBizBelongYear').val().replace(/[^0-9]/gi, '') ;
			resultValue.bizBelongMonth =  parseInt($('#txtBizBelongMonth').val().replace(/[^0-9]/gi, '')) < 10 ?  '0' + parseInt($('#txtBizBelongMonth').val().replace(/[^0-9]/gi, '')) : parseInt($('#txtBizBelongMonth').val().replace(/[^0-9]/gi, '')) ;
			resultValue.etcBelongYearmonth = resultValue.bizBelongYear + resultValue.bizBelongMonth;
			resultValue.etcBelongYear = $('#txtBizBelongYear').val();
			resultValue.etcBelongMonth = parseInt($('#txtBizBelongMonth').val().replace(/[^0-9]/gi, '')) < 10 ?  '0' + parseInt($('#txtBizBelongMonth').val().replace(/[^0-9]/gi, '')) : parseInt($('#txtBizBelongMonth').val().replace(/[^0-9]/gi, '')) ;
			resultValue.tradeAmt = resultValue.etcIncomeAmt;
			resultValue.tradeVatAmt =
					(
						Number((resultValue.etcIncomeVatAmt || '0').replace(/,/g, ''))
						+ Number((resultValue.etcResidentVatAmt || '0').replace(/,/g, ''))
						+ Number((resultValue.etcSchoolAmt || '0').replace(/,/g, ''))
						+ Number((resultValue.etcEmploymentAmt || '0').replace(/,/g, ''))
						+ Number((resultValue.etcEmploymentInsuranceAmt || '0').replace(/,/g, ''))
					).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); /* 소득세액 + 주민세액 + 학자금상환액 + 고용보험액 */
			resultValue.tradeStdAmt = (Number((resultValue.tradeAmt || '0').replace(/,/g, '')) - Number((resultValue.tradeVatAmt || '0').replace(/,/g, ''))).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		resultValue.etcIncomeAmt = ('' + resultValue.etcIncomeAmt).replace(/,/gi, '');
		resultValue.etcIncomeVatAmt = ('' + resultValue.etcIncomeVatAmt).replace(/,/gi, '');
		resultValue.etcResidentVatAmt = ('' + resultValue.etcResidentVatAmt).replace(/,/gi, '');
		resultValue.etcSchoolAmt = ('' + resultValue.etcSchoolAmt).replace(/,/gi, '');
		resultValue.etcEmploymentAmt = ('' + resultValue.etcEmploymentAmt).replace(/,/gi, '');
		resultValue.etcEmploymentInsuranceAmt = ('' + resultValue.etcEmploymentInsuranceAmt).replace(/,/gi, '');

		var tradeUID = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', tradeUID, resultValue, false);
		$('#tradeTbl').dzt('setFocus', tradeUID, 'btrName');
	}

	function fnSetHpMetic_Callback() {
		var resultValue = {};

		if (Option.Common.ERPiU()){
			if($('#budgetTbl').dzt('getValue').vatFgCode == '3' && $('#budgetTbl').dzt('getValue').trFgCode == '9'){
				/* 사업소득자 */
				resultValue.etcIncomeAmt = $('#txtERPiUTotalAmt').val(); /* 지급금액 */
				resultValue.etcIncomeVatAmt = $('#txtERPiUIncomTaxAmt').val(); /* 소득세 */
				resultValue.etcResidentVatAmt = $('#txtERPiUResidTaxAmt').val(); /* 지방소득세 */
				resultValue.etcBelongDate = '';
				resultValue.etcBelongYearmonth = '';
				var etcBelongDateSplitArray = $('#txtERPiUHPPayDate').val().toString().split('-'); /* 지급일자 */

				if(etcBelongDateSplitArray.length != 3){
					alert('지급요청일을 정상적으로 입력해주세요.');
					return;
				}
				for(var i=0; i<etcBelongDateSplitArray.length ; i++){
					resultValue.etcBelongDate += '-' + (Number(etcBelongDateSplitArray[i])<10? '0'+ Number(etcBelongDateSplitArray[i]) : etcBelongDateSplitArray[i]);
				}

				resultValue.etcBelongDate = resultValue.etcBelongDate.substr(1);

				var etcBelongYearmonthSplitArray = $('#txtERPiUHPPayDateYearMonth').val().toString().split('-'); /* 귀속년월 */

				if(etcBelongYearmonthSplitArray.length != 2){
					alert('귀속년월을 정상적으로 입력해주세요.');
					return;
				}
				const MONTH = '1'
				const YEAR = '0'

				resultValue.etcBelongYearmonth = etcBelongYearmonthSplitArray[YEAR] + '-' + (Number(etcBelongYearmonthSplitArray[MONTH])<10? '0'+ Number(etcBelongYearmonthSplitArray[MONTH]) : etcBelongYearmonthSplitArray[MONTH]);

				resultValue.etcBizBelongYear = $('#txtBizBelongYear').val();
				resultValue.etcBizBelongMonth = $('#txtBizBelongMonth').val();
				resultValue.etcBizSeq = $('#txtERPiUCdPc').val(); /* 사업장 코드 */
				resultValue.etcBizName = $('#txtERPiUNmPc').val(); /* 사업장 이름 */

				resultValue.etcRequiredAmt = '0';
				resultValue.etcAmt = resultValue.etcIncomeAmt;
				resultValue.tradeAmt = resultValue.etcIncomeAmt;
				resultValue.tradeVatAmt = (Number((resultValue.etcIncomeVatAmt || '0').replace(/,/g, '')) + Number((resultValue.etcResidentVatAmt || '0').replace(/,/g, ''))).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); /* 소득세 + 지방소득세 */
				resultValue.tradeStdAmt = (Number((resultValue.tradeAmt || '0').replace(/,/g, '')) - Number((resultValue.tradeVatAmt || '0').replace(/,/g, ''))).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			} else {
				/* 기타소득자 */
				resultValue.etcIncomeSeq = $('#txtERPiUIncomeGbnCode').val(); /* 소득구분 코드 */
				resultValue.etcIncomeName = $('#txtERPiUIncomeGbnName').val(); /* 소득구분 명칭 */
				resultValue.etcRequiredRate = $('#txtERPiUTransPer').val(); /* 필요경비율 */
				resultValue.etcRequiredAmt = $('#txtERPiUTransAmt').val(); /* 필요경비금액 */
				resultValue.etcIncomeAmt = $('#txtERPiUAmt').val(); /* 소득금액 */
				resultValue.etcIncomeVatAmt = $('#txtERPiUIncomTaxAmt').val(); /* 소득세 */
				resultValue.etcResidentVatAmt = $('#txtERPiUResidTaxAmt').val(); /* 지방소득세 */
				resultValue.etcBelongDate = $('#txtERPiUHPPayDate').val(); /* 지급일자 */

				var etcBelongYearmonthSplitArray = $('#txtERPiUHPPayDateYearMonth').val().toString().split('-'); /* 귀속년월 */

				if(etcBelongYearmonthSplitArray.length != 2){
					alert('귀속년월을 정상적으로 입력해주세요.');
					return;
				}
				const MONTH = '1'
				const YEAR = '0'

				if(Number(etcBelongYearmonthSplitArray[MONTH])>12){
					alert('귀속년월을 정상적으로 입력해주세요.');
					return;
				}

				resultValue.etcBelongYearmonth = etcBelongYearmonthSplitArray[YEAR] + '-' + (Number(etcBelongYearmonthSplitArray[MONTH])<10? '0'+ Number(etcBelongYearmonthSplitArray[MONTH]) : etcBelongYearmonthSplitArray[MONTH]);


				resultValue.etcBizBelongYear = $('#txtBizBelongYear').val();
				resultValue.etcBizBelongMonth = $('#txtBizBelongMonth').val();
				resultValue.etcBizSeq = $('#txtERPiUCdPc').val(); /* 사업장 코드 */
				resultValue.etcBizName = $('#txtERPiUNmPc').val(); /* 사업장 이름 */

				resultValue.etcAmt = resultValue.etcIncomeAmt;
				resultValue.tradeAmt = (Number((resultValue.etcRequiredAmt || '0').replace(/,/g, '')) + Number((resultValue.etcIncomeAmt || '0').replace(/,/g, ''))).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				resultValue.tradeVatAmt = (Number((resultValue.etcIncomeVatAmt || '0').replace(/,/g, '')) + Number((resultValue.etcResidentVatAmt || '0').replace(/,/g, ''))).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); /* 소득세 + 지방소득세 */
				resultValue.tradeStdAmt = (Number((resultValue.tradeAmt || '0').replace(/,/g, '')) - Number((resultValue.tradeVatAmt || '0').replace(/,/g, ''))).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
		}
		else {
			resultValue.etcIncomeSeq = $('#txtEtcIncomeSeq').val(); /* 소득구분 코드 */
			resultValue.etcIncomeName = $('#txtEtcIncomeName').val(); /* 소득구분 명칭 */
			resultValue.etcRequiredRate = $('#txtEtcRequiredRate').val(); /* 필요경비율 */
			resultValue.etcAmt = $('#txtEtcAmt').val(); /* 지급총액 */
			resultValue.etcRequiredAmt = $('#txtEtcRequiredAmt').val(); /* 필요경비금액 */
			resultValue.etcIncomeAmt = $('#txtEtcIncomeAmt').val(); /* 소득금액 */
			resultValue.etcIncomeVatAmt = $('#txtEtcIncomeVatAmt').val(); /* 소득세액 */
			resultValue.etcResidentVatAmt = $('#txtEtcResidentVatAmt').val(); /* 주민세액 */
			resultValue.etcEmploymentAmt = $('#txtEtcEmploymentAmt').val(); /* 고용보험료 */
			resultValue.etcEmploymentInsuranceAmt = $('#txtEtcEmploymentInsuranceAmt').val(); /* 산재보험료 */
			resultValue.etcBelongYear = $('#txtEtcBelongYear').val().replace(/[^0-9]/g,''); /* 귀속년 */
			resultValue.etcBelongMonth = $('#txtEtcBelongMonth').val().replace(/[^0-9]/g,''); /* 귀속월 */
			resultValue.etcBelongMonth = Number(resultValue.etcBelongMonth)<10? '0'+Number(resultValue.etcBelongMonth) : resultValue.etcBelongMonth;

			resultValue.tradeAmt = resultValue.etcAmt;
			resultValue.tradeVatAmt = (Number((resultValue.etcIncomeVatAmt || '0').replace(/,/g, '')) + Number((resultValue.etcResidentVatAmt || '0').replace(/,/g, '')) + Number((resultValue.etcEmploymentAmt || '0').replace(/,/g, '')) + Number((resultValue.etcEmploymentInsuranceAmt || '0').replace(/,/g, '')) ).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); /* 소득세액 + 주민세액 */
			resultValue.tradeStdAmt = (Number((resultValue.tradeAmt || '0').replace(/,/g, '')) - Number((resultValue.tradeVatAmt || '0').replace(/,/g, ''))).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		resultValue.etcAmt = resultValue.etcAmt.replace(/,/gi, '');
		resultValue.etcRequiredAmt = resultValue.etcRequiredAmt.replace(/,/gi, '');
		resultValue.etcIncomeAmt = resultValue.etcIncomeAmt.replace(/,/gi, '');
		resultValue.etcIncomeVatAmt = resultValue.etcIncomeVatAmt.replace(/,/gi, '');
		resultValue.etcResidentVatAmt = resultValue.etcResidentVatAmt.replace(/,/gi, '');
		if(optionSet.conVo.erpTypeCode == 'iCUBE'){
			resultValue.etcEmploymentAmt = resultValue.etcEmploymentAmt.replace(/,/gi, '');
			resultValue.etcEmploymentInsuranceAmt = resultValue.etcEmploymentInsuranceAmt.replace(/,/gi, '');
		}



		var tradeUID = $('#tradeTbl').dzt('getUID');
		$('#tradeTbl').dzt('setValue', tradeUID, resultValue, false);
		$('#tradeTbl').dzt('setFocus', tradeUID, 'btrName');
	}

	/* ## 연동 기능 Callback ## */
	/* ====================================================================================================================================================== */
	function fnOtherInterfaceCallback(data) {

		var autoStdAmt = ( optionSet.gw['1']['6'] || {'setValue' : '0'} ).setValue;
		var autoEtaxNote = ( optionSet.gw['3']['11'] || {'setValue' : '0'} ).setValue;
		/* data : Array */

		/* https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/isArray */
		if (!Array.isArray(data)) {
			/* Array.isArray() 메서드는 인자 객체가 배열이면  true, 그렇지 않으면 false 를 반환한다. */
			$.error('data is not array..')
			alert('잘못된 정보가 수신되었습니다.');
			return;
		}

		$.each(data, function(idx, item) {
			var tradeData = $('#tradeTbl').dzt('getValue');

			if(!item.businessNb) {
				if(item.trRegNb) {
					item.businessNb = item.trRegNb;
				}
			}

			if($('#budgetTbl').dzt('getValue').vatFgCode == '3'){
				item.tradeStdAmt = Number(autoStdAmt)?'0':item.tradeStdAmt;
				item.tradeVatAmt = Number(autoStdAmt)?'0':item.tradeVatAmt;
			}

			/* 매입전자세금계산서 자동 비고 입력기능 미사용 */
			if(autoEtaxNote == '1'){
				item.tradeNote = '';
			}

			if ($('#tradeTbl').dzt('getValueAll').length === 0) {
				$('#btnTradeAdd').click();
			}

			if ((tradeData.tradeSeq || '') === '') {
				var tradeUID = $('#tradeTbl').dzt('getUID');
				$('#tradeTbl').dzt('setValue', tradeUID, item, false);
				$('#btnTradeAdd').click();
			} else {
				$('#btnTradeAdd').click();
				var tradeUID = $('#tradeTbl').dzt('getUID');
				$('#tradeTbl').dzt('setValue', tradeUID, item, false);
			}
		});

		return;
	}

	/* ## 연동 버튼 관리 ## */
	/* ====================================================================================================================================================== */
	function fnOtherInterfaceBtnReset() {

		if (($('#budgetTbl').dzt('getValue').setFgCode || '') === '4') {
			$('#btnTradeCard').show();
			$('#btnTradeETax').hide();
		} else {
			$('#btnTradeCard').hide();
			$('#btnTradeETax').show();
		}
		if(!(!optionSet.gw[3][6])){
			if(optionSet.gw[3][6].setValue == '1'){
				$('#btnTradeETax').remove();
			}
		}

		if(!(!optionSet.gw[3][5])){
			if(optionSet.gw[3][5].setValue == '1'){
				$('#btnTradeCard').remove();
			}
		}

		return;
	}

	function GetErpMgtIsProject(){
		if(optionSet.conVo.erpTypeCode == 'ERPiU'){
			return true;
		}else if(optionSet.conVo.erpTypeCode == 'iCUBE'){
			if(optionSet.erp[4]['01'].FG_TY == '2'){
				return true;
			}else{
				return false;
			}
		}
	}

	/*	[데이터 보정]	DB자료형 int 대응, 기본 값 처리
	-------------------------------------------- */
	function fnTradeDataCurrection(parameter){
		parameter.etcRequiredAmt = parameter.etcRequiredAmt || '0';
		parameter.etcIncomeAmt = parameter.etcIncomeAmt || '0';
		parameter.etcIncomeVatAmt = parameter.etcIncomeVatAmt || '0';
		parameter.etcResidentVatAmt = parameter.etcResidentVatAmt || '0';
		parameter.etcEmploymentAmt = parameter.etcEmploymentAmt || '0';
		parameter.etcEmploymentInsuranceAmt = parameter.etcEmploymentInsuranceAmt || '0';
		parameter.etcSchoolAmt = parameter.etcSchoolAmt || '0';
		parameter.salaryAmt = parameter.salaryAmt || '0';
		parameter.salaryStdAmt = parameter.salaryStdAmt || '0';
		parameter.salaryIncomeVatAmt = parameter.salaryIncomeVatAmt || '0';
		parameter.salaryResidentVatAmt = parameter.salaryResidentVatAmt || '0';
		parameter.salaryEtcAmt = parameter.salaryEtcAmt || '0';
		parameter.erpInSq = parameter.erpInSq || '0';
		parameter.erpBqSq = parameter.erpBqSq || '0';
		parameter.tradeAmt = parameter.tradeAmt || '0';
		parameter.tradeStdAmt = parameter.tradeStdAmt || '0';
		parameter.tradeVatAmt = parameter.tradeVatAmt || '0';

		return parameter;
	}

	/*	[데이터 보정]	DB자료형 int 대응, 기본 값 처리
	-------------------------------------------- */
	function fnBudgetDataCurrection(parameter){
		parameter.budgetNote = parameter.budgetNote.replaceAll('\\','');
		parameter.erpBqSeq = parameter.erpBqSeq || '0';
		parameter.erpBkSeq = parameter.erpBkSeq || '0';
		parameter.budget_std_amt = parameter.budget_std_amt || '0';
		parameter.budgetStdAmt = parameter.budgetStdAmt || '0';
		parameter.budgetVatAmt = parameter.budgetVatAmt || '0';
		parameter.budget_tax_amt = parameter.budget_tax_amt || '0';
		parameter.budgetTaxAmt = parameter.budgetTaxAmt || '0';
		parameter.budgetAmt = parameter.budgetAmt || '0';
		parameter.amt = parameter.amt || '0';
		parameter.itemAmt = parameter.itemAmt || '0';
		parameter.confferDocSeq = parameter.confferDocSeq || undefined;
		return parameter;
	}

	function GetItemSpecResGridUseYN() {
		if(optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ICUBE'){
			if (optionSet && optionSet.gw && optionSet.gw['1'] && optionSet.gw['1']['9'] && optionSet.gw['1']['9']['setValue']) {
				return (optionSet.gw['1']['9']['setValue'].toString() === '0' ? 'Y' : 'N')
			} else {
				return 'N';
			}
		}
		else{
			return 'N'
		}
	}

	/*	## 적요 다이얼로그 ## */
	function resNoteInsert(code, keyName, resData){

		let resNoteContent = document.getElementById("resNoteContent");
		let resNoteStr = '';

		// puddDialog 함수
		Pudd.puddDialog({

			width : 650
			,	height : 20

			,	modal : true		// 기본값 true
			,	draggable : true	// 기본값 true
			,	resize : false		// 기본값 false

			,	header : {

				title : "적요를 입력하세요."
				,	align : "left"	// left, center, right

				,	minimizeButton : false	// 기본값 false
				,	maximizeButton : false	// 기본값 false

				,	closeButton : true	// 기본값 true
				,	closeCallback : function( puddDlg ) {

					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}

			,	body : {

				//	iframe : true
				//,	url : "/ui/pudding/Views/p_comp/iframe_gridtable.jsp"

				// dialog content 문자열
				content : resNoteContent
				,	contentCallback : function( contentDiv ) {
					//  content 내용에 입력 컨트롤 등을 추가하여 제어가 필요한 경우 이 부분에서 처리
					$('#resNoteStr').attr('tabindex', '0').focus();
					$('#resNoteStr').keydown(function(e) {
						if(e.keyCode == 13) {
							$('#btnConfirm.submit').click();
						} else if(e.keyCode == 27) {
							$('#btnCancel').click();
						}
					})
				}
			}

			,	footer : {

				buttons : [
					{
						attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : "확인"
						,	clickCallback : function( puddDlg ) {

							puddDlg.showDialog( false );
							var uid = $('#resTbl').dzt('getUID');
							$('#' + uid + '_resNote.inpTextBox').attr('tabindex', '0').focus();
							resNoteStr = document.getElementById("resNoteStr").value;
							resData.resNote = resNoteStr;
							fnCommonCode(code, keyName, '', resData);
						}
					}
					,	{
						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : "취소"
						,	clickCallback : function( puddDlg ) {

							puddDlg.showDialog( false );
							var uid = $('#resTbl').dzt('getUID');
							$('#' + uid + '_resNote.inpTextBox').attr('tabindex', '0').focus();
						}
					}
				]
			}
		});
	};

	/*	## 비고(예산) 다이얼로그 ## */
	function budgetNoteInsert(code, keyName, budgetData){

		let budgetNoteContent = document.getElementById("budgetNoteContent");
		let budgetNoteStr = '';

		// puddDialog 함수
		Pudd.puddDialog({

			width : 650
			,	height : 20

			,	modal : true		// 기본값 true
			,	draggable : true	// 기본값 true
			,	resize : false		// 기본값 false

			,	header : {

				title : "비고를 입력하세요."
				,	align : "left"	// left, center, right

				,	minimizeButton : false	// 기본값 false
				,	maximizeButton : false	// 기본값 false

				,	closeButton : true	// 기본값 true
				,	closeCallback : function( puddDlg ) {

					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}

			,	body : {

				//	iframe : true
				//,	url : "/ui/pudding/Views/p_comp/iframe_gridtable.jsp"

				// dialog content 문자열
				content : budgetNoteContent
				,	contentCallback : function( contentDiv ) {
					//  content 내용에 입력 컨트롤 등을 추가하여 제어가 필요한 경우 이 부분에서 처리
					$('#budgetNoteStr').attr('tabindex', '0').focus();
					$('#budgetNoteStr').keydown(function(e) {
						if(e.keyCode == 13) {
							$('#btnConfirm.submit').click();
						} else if(e.keyCode == 27) {
							$('#btnCancel').click();
						}
					})
				}
			}

			,	footer : {

				buttons : [
					{
						attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : "확인"
						,	clickCallback : function( puddDlg ) {

							puddDlg.showDialog( false );
							var uid = $('#budgetTbl').dzt('getUID');
							$('#' + uid + '_budgetNote.inpTextBox').attr('tabindex', '0').focus();
							budgetNoteStr = document.getElementById("budgetNoteStr").value;
							budgetData.budgetNote = budgetNoteStr;
							fnCommonCode(code, keyName, '', budgetData);
						}
					}
					,	{
						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : "취소"
						,	clickCallback : function( puddDlg ) {

							puddDlg.showDialog( false );
							var uid = $('#budgetTbl').dzt('getUID');
							$('#' + uid + '_budgetNote.inpTextBox').attr('tabindex', '0').focus();
						}
					}
				]
			}
		});
	};

	/*	## 비고(채주) 다이얼로그 ## */
	function tradeNoteInsert(code, keyName, tradeData){

		let tradeNoteContent = document.getElementById("tradeNoteContent");
		let tradeNoteStr = '';

		// puddDialog 함수
		Pudd.puddDialog({

			width : 650
			,	height : 20

			,	modal : true		// 기본값 true
			,	draggable : true	// 기본값 true
			,	resize : false		// 기본값 false

			,	header : {

				title : "비고를 입력하세요."
				,	align : "left"	// left, center, right

				,	minimizeButton : false	// 기본값 false
				,	maximizeButton : false	// 기본값 false

				,	closeButton : true	// 기본값 true
				,	closeCallback : function( puddDlg ) {

					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}

			,	body : {

				//	iframe : true
				//,	url : "/ui/pudding/Views/p_comp/iframe_gridtable.jsp"

				// dialog content 문자열
				content : tradeNoteContent
				,	contentCallback : function( contentDiv ) {
					//  content 내용에 입력 컨트롤 등을 추가하여 제어가 필요한 경우 이 부분에서 처리
					$('#tradeNoteStr').attr('tabindex', '0').focus();
					$('#tradeNoteStr').keydown(function(e) {
						if(e.keyCode == 13) {
							$('#btnConfirm.submit').click();
						} else if(e.keyCode == 27) {
							$('#btnCancel').click();
						}
					})
				}
			}

			,	footer : {

				buttons : [
					{
						attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : "확인"
						,	clickCallback : function( puddDlg ) {

							puddDlg.showDialog( false );
							var uid = $('#tradeTbl').dzt('getUID');
							$('#' + uid + '_tradeNote.inpTextBox').attr('tabindex', '0').focus();
							tradeNoteStr = document.getElementById("tradeNoteStr").value;
							tradeData.tradeNote = tradeNoteStr;
							fnCommonCode(code, keyName, '', tradeData);
						}
					}
					,	{
						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : "취소"
						,	clickCallback : function( puddDlg ) {

							puddDlg.showDialog( false );
							var uid = $('#tradeTbl').dzt('getUID');
							$('#' + uid + '_tradeNote.inpTextBox').attr('tabindex', '0').focus();
						}
					}
				]
			}
		});
	};

	function GetItemSpecBudgetGirdUseYN() {
		if(optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ERPIU'){
			if (optionSet && optionSet.gw && optionSet.gw['1'] && optionSet.gw['1']['9'] && optionSet.gw['1']['9']['setValue']) {
				return (optionSet.gw['1']['9']['setValue'].toString() === '0' ? 'Y' : 'N')
			} else {
				return 'N';
			}
		}
		else{
			return 'N'
		}
	}

	/* ## 물품명세 팝업 ## */
	/* ====================================================================================================================================================== */
	/* ## event - 물품명세 팝업 ## */
	function fnEventItemSpecPop() {
		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserItemSpecPop.do'/>";
		var height = 450;

		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		if (isFirefox) {
			height += 4;
		}
		if (isIE) {
			height += 0;
		}
		if (isEdge) {
			height -= 26;
		}
		if (isChrome) {
			height -= 6;
		}

		var resData = $('#resTbl').dzt('getValue');
		var budgetData = $('#budgetTbl').dzt('getValue');

		window.open('', "UserItemSpecPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		USER_itemSpecPop.target = "UserItemSpecPop";
		USER_itemSpecPop.method = "post";
		if(optionSet.conVo.erpTypeCode == "ERPiU"){
			USER_itemSpecPop.resDocSeq.value = budgetData.resDocSeq;
			USER_itemSpecPop.resSeq.value = budgetData.resSeq;
			USER_itemSpecPop.budgetSeq.value = budgetData.budgetSeq||'';
		}
		else{
			USER_itemSpecPop.resDocSeq.value = resData.resDocSeq;
			USER_itemSpecPop.resSeq.value = resData.resSeq;
			USER_itemSpecPop.budgetSeq.value = resData.budgetSeq||'';
		}


		USER_itemSpecPop.action = url;
		USER_itemSpecPop.submit();
		USER_itemSpecPop.target = "";

		return;
	}

	/* ## event - 물품명세 품의서 반영 ## */
	function fnCallbackItemSpec(params){
		var amt = 0;
		for(var i = 0; i<params.length; i++){
			 amt = amt + params[i].itemAmt.replace(/,/g, '') * 1;
		}

		if(optionSet.conVo.erpTypeCode == "ERPiU"){
			var resUID = $('#budgetTbl').dzt('getUID');
	        $('#budgetTbl').dzt('setValue', resUID, { itemAmt: Option.Common.GetNumeric(amt) }, false);
		}
		else{
			var resUID = $('#resTbl').dzt('getUID');
	        $('#resTbl').dzt('setValue', resUID, { itemAmt: Option.Common.GetNumeric(amt) }, false);
		}
	}

</script>

<div class="pop_wrap" style="display:none;">
	<div class="pop_sign_head posi_re">
		<h1 id="h1_resDocTitle">${CL.ex_resDocWrite}  <!--품의서 작성--></h1>
        <h1 id="h1_gisuInfo" style="display:none;">${CL.ex_accountPeriod} : 2기 2019.01.01 ~ 2019.12.31</h1>

		<div class="psh_btnbox">
			<!-- 양식팝업 오른쪽 버튼그룹 -->
			<div class="psh_right">
				<div class="btn_cen mt8">
					<input type="button" class="psh_btn" value="${CL.ex_approvalComplete}" id="btnApproval">
					<input type="button" class="psh_btn" value="작성완료" id="btnTripInfo" style="display:none;"/>
				</div>
			</div>
		</div>
	</div>
	<div class="pop_con">
		<!-- 로그인 사용자 정보 ( ERP ) -->
		<div class="top_box gray_box">
			<dl>
			
				<dt class="fwn">지급구분 :</dt>
				<dd class="mt15 fwb" style="margin-right:0px;text-align:center;">			
					<select id="payType" style="width:auto;min-width:70px;height: 23px;">
						<option value="A">선금</option>
						<option value="B">중도금</option>
						<option value="C">잔금</option>
					</select>
				</dd>
				
				<dt class="fwn">지급차수 :</dt>
				<dd class="mt15 fwb" style="margin-right: 0px;">			
					<input class="fl input_search mr5" id="payCnt" type="number" value="1" style="width:40px;text-align:center;height:22px;" />
				</dd>
				<dt style="margin-left: 0px;">차</dt>								
			
				<dt class="fwn">${CL.ex_accountingUnit}  <!--회계단위--> :</dt>
				<dd class="mt15 fwb" style="margin-right: 20px;">
					<input class="fl input_search mr5" id="lbErpDivName" type="text" value="" style="width:auto;" disabled /> <a href="#" class="fl btn_search" id="btnErpDivChoice"></a>
				</dd>
				
				<dt class="fwn">${CL.ex_useDepartment}  <!--사용부서--> :</dt>
				<dd class="mt20 fwb" style="margin-right: 20px;" id="lbErpDeptName"></dd>
				
				<dt class="fwn">${CL.ex_empSeq}  <!--사번--> :</dt>
				<dd class="mt20 fwb" style="margin-right: 20px;" id="lbErpEmpSeq"></dd>
				
				<dt class="fwn">${CL.ex_user}  <!--사용자--> :</dt>
				<dd class="mt20 fwb" id="lbErpEmpName"></dd>
				
			</dl>
		</div>
		<!-- // 로그인 사용자 정보 ( ERP ) -->

		<div class="btn_div mt20">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">
					${CL.ex_resInfo}  <!--결의정보--><span class="text_red fwn ml10" id="resTooltip"></span>
				</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnBringFavorites"/>${CL.ex_favorite}</button>
					<button id="btnConsRefer">${CL.ex_consDocReffer}  <!--품의서참조--></button>
					<button id="btnResRefer"${CL.ex_beforeResDoc}  <!--지난 결의서--></button>
					<button id="btnResReset">${CL.ex_reset}  <!--초기화--></button>
					<button id="btnResAdd">${CL.ex_add}  <!--추가--></button>
					<button id="btnResDelete">${CL.ex_remove}  <!--삭제--></button>
					<button id="btnResUp" class="ud up" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_up}  <!--위--></button>
					<button id="btnResDown" class="ud down" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_down}  <!--아래--></button>
				</div>
			</div>
		</div>
		<div id="resTbl"></div>
		<div style="height: 20px;"></div>
		<div class="btn_div mt0">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">
					${CL.ex_detailBudget}  <!--예산내역--><span class="text_red fwn ml10" id="budgetTooltip"></span>
				</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnBudgetReset">${CL.ex_reset}  <!--초기화--></button>
					<button id="btnBudgetAdd">${CL.ex_add}  <!--추가--></button>
					<button id="btnBudgetDelete">${CL.ex_remove}  <!--삭제--></button>
					<button id="btnBudgetUp" class="ud up" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_up}  <!--위--></button>
					<button id="btnBudgetDown" class="ud down" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_down}  <!--아래--></button>
				</div>
			</div>
		</div>
		<div id="budgetTbl"></div>
		<div class="com_ta mt20" id="erpBudgetInfo">
			<table>
				<colgroup>
					<col width="120">
					<col width="10%">
					<col width="120">
					<col width="10%">
					<col width="120">
					<col width="10%">
					<col width="120">
					<col width="10%">
					<col width="120">
					<col width="10%">
				</colgroup>
				<tr>
					<th id="lblBudgetAmt">${CL.ex_budgetAmount}  <!--예산금액--></th>
					<td class="ri pr5" id="lbErpOpenAmt">0</td>
					<th id="lblConsAmt">${CL.ex_consBal}  <!--품의잔액--></th>
					<td class="ri pr5" id="lbConsBalanceAmt">0</td>
					<th id="lblResAmt">${CL.ex_budgetExcutionAmt}  <!--집행금액--></th>
					<td class="ri pr5" id="lbResApplyAmt">0</td>
					<th id="lblTryAmt">${CL.ex_thisTimeExecution}  <!--금회집행--></th>
					<td class="ri pr5" id="lbBudgetAmt">0</td>
					<th id="lblBalanceAmt">${CL.ex_budgetBalance}  <!--예산잔액--></th>
					<td class="ri pr5" id="lbGwBalanceAmt">0</td>
				</tr>
			</table>
		</div>
		<div style="height: 20px;"></div>
		<div class="btn_div mt0">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">
					${CL.ex_paymentList}  <!--결제내역--><span class="text_red fwn ml10" id="tradeTooltip"></span>
				</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnTradeReset">${CL.ex_reset}  <!--초기화--></button>
					<button id="btnTradeCard">${CL.ex_cardUseHistory}  <!--카드사용내역--></button>
					<button id="btnTradeETax">${CL.ex_electronicInvoice}  <!--매입전자세금계산서--></button>
					<button id="btnTradeAdd">${CL.ex_add}  <!--추가--></button>
					<button id="btnTradeDelete">${CL.ex_remove}  <!--삭제--></button>
					<button id="btnTradeUp" class="ud up" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_up}  <!--위--></button>
					<button id="btnTradeDown" class="ud down" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_down}  <!--아래--></button>
				</div>
			</div>
		</div>
		<div id="tradeTbl"></div>
	</div>
	<!-- //pop_con -->
</div>

<!-- 기타소특상세 시작 -->
<c:if test="${conVo.erpTypeCode == 'iCUBE'}">
<div class="pop_wrap_dir" style="width: 420px;display:none;" id="layerHpMetic">
</c:if>
<c:if test="${conVo.erpTypeCode == 'ERPiU'}">
<div class="pop_wrap_dir" style="width: 530px;display:none;" id="layerHpMetic">
</c:if>
	<div class="pop_head">
		<h1>${CL.ex_othersIncomeDetail}  <!--기타소득상세--></h1>
		<a href="#n" class="clo" id="btnClose"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<c:if test="${conVo.erpTypeCode == 'iCUBE'}">
			<table class="iCUBE">
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th>${CL.ex_classifyIncome}  <!--소득구분--></th>
					<td><input class="input_search fl" id="txtEtcIncomeSeq" type="text" value="" style="width: 65px;" placeholder="" readonly="readonly" /> <a href="#" class="btn_search fl" id="btnEtcIncome" style="margin-left: -1px;"></a> <input class="fl ml30" id="txtEtcIncomeName" type="text" value="" style="width: 118px;" /></td>
				</tr>
				<tr>
					<th>${CL.ex_necessaryExpensesLate}  <!--필요경비율--></th>
					<td><input type="text" autocomplete="off" id="txtEtcRequiredRate" class="ri" value="" style="width: 60px;" readonly /> %</td>
				</tr>
				<tr>
					<th>${CL.ex_giveTotalPay}</th>
					<td><input type="text" autocomplete="off" id="txtEtcAmt" class="ri" value="" style="width: 210px;" /> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_necessaryExpensesAmt}  <!--필요경비금액--></th>
					<td><input type="text" autocomplete="off" id="txtEtcRequiredAmt" class="ri etcAutoAmts" value="" style="width: 210px;" readonly/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_incomeAmt}  <!--소득금액--></th>
					<td><input type="text" autocomplete="off" id="txtEtcIncomeAmt" class="ri etcAutoAmts" value="" style="width: 210px;" readonly/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_incomeTaxAmt}  <!--소득세액--></th>
					<td><input type="text" autocomplete="off" id="txtEtcIncomeVatAmt" class="ri etcAutoAmts" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_residentTaxAmt}  <!--주민세액--></th>
					<td><input type="text" autocomplete="off" id="txtEtcResidentVatAmt" class="ri etcAutoAmts" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr id="employmentEtcArea">
					<th>${CL.ex_employeeAmt}  <!--고용보험료--></th>
					<td><input type="text" autocomplete="off" id="txtEtcEmploymentAmt" class="ri etcAutoAmts" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr id="employmentInsuranceEtcArea">
					<th>산재보험료  <!--산재보험료--></th>
					<td><input type="text" autocomplete="off" id="txtEtcEmploymentInsuranceAmt" class="ri etcAutoAmts" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_reversionDate}  <!--귀속년월--></th>
					<td><input type="text" autocomplete="off" class="ri" id="txtEtcBelongYear" value="" style="width: 60px;" /> ${CL.ex_year} <input type="text" autocomplete="off" id="txtEtcBelongMonth" class="ri" value="" style="width: 30px;" /> ${CL.ex_month}  <!--월--></td>
				</tr>
				<!-- <tr><th>귀속신고</th><td><input type="text" autocomplete="off" class="ri" value="" style="width:60px;" /> 년</td></tr> -->
			</table>
			</c:if>
			<c:if test="${conVo.erpTypeCode == 'ERPiU'}">
			<table class="ERPiU">
				<colgroup>
					<col width="120" />
					<col width="" />
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th>${CL.ex_belongingPlace}  <!--귀속사업장--></th>
					<td colspan="3"><input class="input_search fl" id="txtERPiUCdPc" type="text" value="" style="width: 65px;" placeholder="" readonly="readonly" /> <a href="#" class="btn_search fl" id="btnERPiUDiv" style="margin-left: -1px;"></a> <input class="fl ml30" id="txtERPiUNmPc" type="text" value="" style="width: 118px;" /></td>
				</tr>
				<tr>
					<th>${CL.ex_paymentDate}  <!--지급일자--></th>
					<td><input class="fl" id="txtERPiUHPPayDate" type="text" value="" style="width: 118px;" /></td>
					<th>${CL.ex_reversionDate}  <!--귀속년월--></th>
					<td><input class="fl" id="txtERPiUHPPayDateYearMonth" type="text" value="" style="width: 118px;" /></td>
				</tr>
				<tr>
					<th>${CL.ex_classifyIncome}  <!--소득구분--></th>
					<td colspan="3"><input class="input_search fl" id="txtERPiUIncomeGbnCode" type="text" value="" style="width: 65px;" placeholder="" readonly="readonly" /> <a href="#" class="btn_search fl" id="btnEtcIncome" style="margin-left: -1px;"></a> <input class="fl ml30" id="txtERPiUIncomeGbnName" type="text" value="" style="width: 118px;" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>${CL.ex_giveAmt}  <!--지급금액--></th>
					<td><input type="text" autocomplete="off" id="txtERPiUTotalAmt" class="ri" value="" style="width: 80%;" /></td>
					<th>${CL.ex_necessaryExpensesLate}  <!--필요경비율--></th>
					<td><input type="text" autocomplete="off" id="txtERPiUTransPer" class="ri" value="" style="width: 80%;" /> %</td>
				</tr>
				<tr>
					<th>필요경비</th>
					<td><input type="text" autocomplete="off" id="txtERPiUTransAmt" class="ri" value="" style="width: 80%;" readonly /></td>
					<th>${CL.ex_incomeAmt}  <!--소득금액--></th>
					<td><input type="text" autocomplete="off" id="txtERPiUAmt" class="ri" value="" style="width: 80%;" readonly /></td>
				</tr>
				<tr>
					<th>${CL.ex_incomeTax}  <!--소득세--></th>
					<td><input type="text" autocomplete="off" id="txtERPiUIncomTaxAmt" class="ri" value="" style="width: 80%;" /></td>
					<th>${CL.ex_incomeTaxLate}  <!--소득세율--></th>
					<td><input type="text" autocomplete="off" id="txtERPiUIncomTaxPer" class="ri" value="" style="width: 80%;" /> %</td>
				</tr>
				<tr>
					<th>${CL.ex_areaIncomeTax}  <!--지방소득세--></th>
					<td><input type="text" autocomplete="off" id="txtERPiUResidTaxAmt" class="ri" value="" style="width: 80%;" /></td>
					<th>${CL.ex_areaIncomeTaxLate}  <!--지방소득세율--></th>
					<td><input type="text" autocomplete="off" id="txtERPiUResidTaxPer" class="ri" value="" style="width: 80%;" /> %</td>
				</tr>
			</table>
			</c:if>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnLayerOk" value="${CL.ex_check}" /> <input type="button" id="btnLayerCancel" class="gray_btn" value="${CL.ex_cancel}" />  <!--취소-->
		</div>
	</div>
</div>
<!-- 기타소득상세 종료 -->

<!-- 사업소특상세 시작 -->
<div class="pop_wrap_dir" style="width: 420px; top: 50%; left: 50%; margin-left: -210px; margin-top: -212.5px; display: none;" id="layerBizMetic">
	<div class="pop_head">
		<h1>사업소득입력  <!--사업소득상세--></h1>
		<a href="#n" class="clo" id="btnBizClose"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table class="iCUBE">
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr class="trBizGbnInfo">
					<th>${CL.ex_classifyIncome}  <!--소득구분--></th>
					<td><input class="input_search fl bizIncomeTxt" id="txtBizIncomeSeq" type="text" value="" style="width: 65px;" placeholder="" readonly="readonly" /> <a href="#" class="btn_search fl" id="btnBizIncome" style="margin-left: -1px;"></a> <input class="fl ml30 bizIncomeTxt" id="txtBizIncomeName" type="text" value="" style="width: 118px;" /></td>
				</tr>
				<tr>
					<th>${CL.ex_incomeAmt}  <!--소득금액--></th>
					<td><input type="text" autocomplete="off" id="txtBizIncomeAmt" class="ri etcAutoAmts bizIncomeTxt" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_incomeTaxAmt}  <!--소득세액--></th>
					<td><input type="text" autocomplete="off" id="txtBizIncomeVatAmt" class="ri etcAutoAmts bizIncomeTxt" value="" style="width: 210px;" /> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_residentTaxAmt}  <!--주민세액--></th>
					<td><input type="text" autocomplete="off" id="txtBizResidentVatAmt" class="ri etcAutoAmts bizIncomeTxt" value="" style="width: 210px;" /> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr class="trYNBuempiclMan">
					<th>학자금상환액  <!--학자금 상환액--></th>
					<td><input type="text" autocomplete="off" id="txtBizSchoolAmt" class="ri etcAutoAmts bizIncomeTxt" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr id="employmentBizArea">
					<th>${CL.ex_employeeAmt}  <!--고용보험료--></th>
					<td><input type="text" autocomplete="off" id="txtBizEmploymentAmt" class="ri etcAutoAmts bizIncomeTxt" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr id="employmentInsuranceBizArea">
					<th>산재보험료  <!--산재보험료--></th>
					<td><input type="text" autocomplete="off" id="txtBizEmploymentInsuranceAmt" class="ri etcAutoAmts" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_reversionDate}  <!--귀속년월--></th>
					<td><input type="text" autocomplete="off" class="ri bizIncomeTxt" id="txtBizBelongYear" value="" style="width: 60px;" /> 년 <input type="text" autocomplete="off" id="txtBizBelongMonth" class="ri bizIncomeTxt" value="" style="width: 30px;" /> ${CL.ex_month}  <!--월--></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnBizLayerOk" value="${CL.ex_check}" /> <input type="button" id="btnBizLayerCancel" class="gray_btn" value="${CL.ex_cancel}" />  <!--취소-->
		</div>
	</div>
</div>

<!-- 급여 레이어 시작 -->
<div class="pop_wrap_dir" style="width: 420px; top: 50%; left: 50%; margin-left: -210px; margin-top: -212.5px; display: none;" id="layerSalary">
	<div class="pop_head">
		<h1>지급금액 <!--지급금액--></h1>
		<a href="#n" class="clo" id="btnSalaryClose"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table class="iCUBE">
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th>${CL.ex_giveTotalPay}</th>
					<td><input type="text" autocomplete="off" id="txtSalaryAmt" class="ri etcAutoAmts salaryIncomeTxt" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_realPay}</th>
					<td><input type="text" autocomplete="off" id="txtSalaryStdAmt" class="ri etcAutoAmts salaryIncomeTxt" value="" style="width: 210px;" disabled/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_incomeTaxAmt}</th>
					<td><input type="text" autocomplete="off" id="txtSalaryIncomeVatAmt" class="ri etcAutoAmts salaryIncomeTxt" value="" style="width: 210px;" /> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_residentTaxAmt}</th>
					<td><input type="text" autocomplete="off" id="txtSalaryResidentVatAmt" class="ri etcAutoAmts salaryIncomeTxt" value="" style="width: 210px;" /> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr class="trYNBuempiclMan">
					<th>${CL.ex_otherDeductions}</th>
					<td><input type="text" autocomplete="off" id="txtSalaryEtcAmt" class="ri etcAutoAmts salaryIncomeTxt" value="" style="width: 210px;"/> ${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th>${CL.ex_reversionDate}  <!--귀속년월--></th>
					<td><input type="text" autocomplete="off" class="ri bizIncomeTxt" id="txtSalaryBelongYear" value="" style="width: 60px;" /> 년 <input type="text" autocomplete="off" id="txtSalaryBelongMonth" class="ri bizIncomeTxt" value="" style="width: 30px;" /> ${CL.ex_month}  <!--월--></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnSalaryLayerOk" value="${CL.ex_check}" /> <input type="button" id="btnSalaryLayerCancel" class="gray_btn" value="${CL.ex_cancel}" />  <!--취소-->
		</div>
	</div>
</div>

<!-- 급여 레이어 종료 -->
<div class="modal" style="display: none;" id="divModal"></div>


<form id="USER_confferPop" name="frmPop" method="post"></form>


<!-- 지출결의서 즐겨찾기 저장 레이어 팝업 영역 -->
<div class="modal" style="z-index: 103; display:none;" id="favoritesDivModal" ></div>
<div id="favoritesDivMain" class="resources_reservation_wrap Pop_border pop_wrap_dir" style="width: 443px; left: 50%; top: 50%; margin: -105px 0px 0px -222px; z-index: 104; position: fixed; display:none;">
	<div class="pop_head">
		<h1 id="PLP_textTitle">즐겨찾기 저장</h1>
		<a href="#n" class="clo">
			<img onclick="javascript:fnAddFavoritesClose();" id="" src="/exp/Images/btn/btn_pop_clo02.png" value="" alt="" style="display: inline;">
		</a>
	</div><!-- //pop_head -->

	<div class="pop_con">
		<p class="gle">결의서 제목을 입력하세요.</p>
		<div class="gra_set">
			<input id="txtFavoritesTitle" type="text" style="width: 100%;">
		</div>
	</div><!-- //pop_con -->
	<div class="pop_foot" style="display: block;" id="">
		<div class="btn_cen pt12">
			<input class="blue_btn  PLP_advBtn" value="저장" type="button" onclick="javascript:fnAddFavoritesCallback();" style="display: inline-block;">
		</div>
	</div><!-- //pop_foot -->
</div>

<form id="USER_itemSpecPop" name="frmPop" method="post">
	<input type="hidden" name="resDocSeq" id="resDocSeq" value="0"/>
	<input type="hidden" name="resSeq" id="resSeq" value="0"/>
	<input type="hidden" name="budgetSeq" id="budgetSeq" value="0"/>
</form>

<div id="resNoteContent" style="display: none;">
	<input type="text" id="resNoteStr" value="" style="width:614px; padding-left: 5px;" />
</div>

<div id="budgetNoteContent" style="display: none;">
	<input type="text" id="budgetNoteStr" value="" style="width:614px; padding-left: 5px;" />
</div>

<div id="tradeNoteContent" style="display: none;">
	<input type="text" id="tradeNoteStr" value="" style="width:614px; padding-left: 5px;" />
</div>