<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="currentTime" class="java.util.Date" />
<jsp:include page="../include/UserOptionMap.jsp" flush="false" />
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/dzt-1.0.0.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/cons-1.0.0.js'></script>

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

<script type="text/javascript">

    /* ## 프로세스 설명 및 개발 관련 설명 ## */
    /*
     * 1. 테이블 명칭 설명
     *     1.1. 품의정보 : id >> consTbl / selector >> $('#consTbl')
	 *     1.2. 예산내역 : id >> budgetTbl / selector >> $('#budgetTbl')
     *  2. 버튼 설명
     *     2.1. 품의정보 - 품의서 불러오기
     *     2.2. 품의정보 - 초기화
     *     2.3. 품의정보 - 추가
     *     2.4. 품의정보 - 삭제
     *     2.5. 품의정보 - 위
     *     2.6. 품의정보 - 아래
     *     2.7. 예산내역 - 초기화
     *     2.8. 예산내역 - 추가
     *     2.9. 예산내역 - 삭제
     *     2.10. 예산내역 - 위
     *     2.11. 예산내역 - 아래
     * 3. 코드 정리
     *     3.1. ERPiU
     *          3.1.1. 품의정보
     *          3.1.2. 예산내역
     *     3.2. iCUBE
     *          3.2.1. 품의정보
     *                 3.2.1.1. 품의구분(docuFgName, docuFgSeq), 품의일자(consDate), 프로젝트(erpMgtName), 적요, 금액
     *          3.2.2. 예산내역
     *                 3.2.2.1. 예산과목, 회계단위, 비고, 금액
     *          3.2.3. 키
     *                 3.2.3.1. 품의서 키(consDocSeq) / 품의정보 키(consSeq) / 예산내역 키(budgetSeq)
     */

 	// 품의서 작성
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
     
    /* ## 변수정의 ## */
    /* ====================================================================================================================================================== */
    var mode = 'dev';
    var domain = '/exp';
    var formSeq = '${param.formSeq}';
    var approKey = '${param.approKey}';
    var consDocSeq = 0;
    var YES = 'Y';
    var NO = 'N';
    var approvalBack = false;
    var preDocSeq = '';
    var useFavorite = false;
    var checkDocStatus = 'N';
    var resetBudgetSize = 0;
    
    /* SSL 적용관련 */
    if (!window.location.origin) {
        window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
    }
    var origin = document.location.origin;
      
    /* ## 옵션조회 ## */
    /* ====================================================================================================================================================== */
    var Option = {
        Common: {
            /* 현재 연동된 시스템이 ERPiU인지 확인 ( ERPiU 연동의 경우 true 반환 그 외 false 반환 ) */
            ERPiU: function () {
                if (Option.Common.GetErpType() === 'ERPiU') { return true; }
                else { return false; }
            },
            /* 현재 연동된 시스템이 iCUBE인지 확인 ( iCUBE 연동의 경우 true 반환 그 외 false 반환 ) */
            iCUBE: function () {
                if (Option.Common.GetErpType() === 'iCUBE') { return true; }
                else { return false; }
            },
            /* 현재 연동된 ERP 시스템 구분 반환 ( ERPiU : ERPiU / iCUBE : iCUBE / iCUBE G20 : iCUBE ) */
            GetErpType: function () {
                if (typeof optionSet !== 'undefined' && optionSet.conVo && optionSet.conVo.erpTypeCode) { return (optionSet.conVo.erpTypeCode || '').toString(); }
                else { return ''; }
            },
            GetResult: function (result, type) {
                /* [ parameter ] */
                /*   - result : 반환받은 result */
                /*   - type : 반환받고자 하는 key [ aData, aaData ] */

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
            GetResultCode: function (result) {
                /* [ parameter ] */
                /*   - result : 반환받은 result */

                if (typeof result !== 'undefined' && result) {
                    if (typeof result.result !== 'undefined' && result.result) {
                        if (typeof result.result.resultCode !== 'undefined' && result.result.resultCode) { return result.result.resultCode; }
                    }
                }

                return 'FAIL';
            },
            /* 로그인 사용자 ERP 조직도 정보 조회 */
            GetErpEmpInfo: function () {
                /* ERPiU       :  */
                /* iCUBE (G20) :  */
                if (typeof optionSet !== 'undefined' && optionSet.erpEmpInfo) { return (optionSet.erpEmpInfo || {}); }
                else { return {}; }
            },
            /* 로그인 사용자 GW 조직도 정보 조회 */
            GetGwEmpInfo: function () {
                var resultValue = { groupSeq: '', userSe: '', langCode: '', compSeq: '', compName: '', divSeq: '', divName: '', deptSeq: '', deptName: '', empSeq: '', empName: '' };

                /* Bizbox Alpha :  */
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
            GetErpGisuInfo: function () {
                var resultValue = {
                    erpGisu: '0', /* 기수 */
                    gisu: '', /* 기수 */
                    erpYear: '', /* 기수 년도 */
                    erpExpendYear: '', /* 기수 년도 */
                    erpGisuFromDate: '', /* 기수 시작일자 */
                    erpGisuToDate: '', /* 기수 종료일자 */
                    erpGisuDate: '', /* 발의일자 */
                    expendDate: '' /* 발의일자 */
                };

                /* Bizbox Alpha :  */
                if (typeof optionSet !== 'undefined' && optionSet.erpGisu) {
                    resultValue.erpGisu = (optionSet.erpGisu.gisu || '0');
                    resultValue.gisu = (optionSet.erpGisu.gisu || '');
                    resultValue.erpYear = ((optionSet.erpGisu.fromDate || '').toString().length >= 4 ? optionSet.erpGisu.fromDate.substring(0, 4) : '');
                    resultValue.erpExpendYear = ((optionSet.erpGisu.fromDate || '').toString().length >= 4 ? optionSet.erpGisu.fromDate.substring(0, 4) : '');
                    resultValue.erpGisuFromDate = (optionSet.erpGisu.fromDate || '');
                    resultValue.erpGisuToDate = (optionSet.erpGisu.toDate || '');

                    /* 발의일자 - 현재 작성된 결의정보 기준 조회 */
                    if ($('#consTbl').find('table').length > 0) {
                        var resInfo = $('#consTbl').dzt('getValue');
                        resultValue.erpGisuDate = (resInfo.resDate || '');
						resultValue.expendDate = (resInfo.resDate || '');
						resultValue.gisu = (resInfo.erpGisu || resultValue.gisu);
						resultValue.erpGisu = (resInfo.erpGisu || resultValue.erpGisu);
                    } else {
                        resultValue.erpGisuDate = '';
                    }
                }

                /* [ return ] */
                return resultValue;
            },
            /* 팝업 크기 자동 조정 */
            SetResize: function () {
                /* ## init - 품의서 팝업 크기 자동 조정 ## */
                var optionHeight = optionSet.formInfo.formHeight;
                var optionWidth = optionSet.formInfo.formWidth;
                if (!optionHeight) { optionHeight = screen.height - 200; }
                if (!optionWidth) { optionWidth = screen.width - 400; }
                
				if(!parseInt(optionHeight)){
					optionHeight = 850;
				}
				if(!parseInt(optionWidth)){
					optionWidth = 1250;
				}
				if(optionHeight < 850){
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

                if (isFirefox) { divHeight -= 79; }
                if (isIE || isEdge) { divHeight -= 70; }
                if (isChrome) { divHeight -= 67; }

                try {
                    $('.pop_wrap').height(divHeight); window.resizeTo(optionWidth, optionHeight);
                }
                catch (exception) {
                    console.error('   [ERROR] fail to page resize.');
                }

                try { var moveLeft = (screen.width - optionWidth) / 2; var moveTop = (screen.height - optionHeight) / 2; window.moveTo(moveLeft, moveTop); }
                catch (exception) { }

                $(window).resize(function (e, d) { $('.pop_wrap').height(window.innerHeight - 2); Option.Common.SetBudgetTblResize(); });

                /* 리사이징 최초 1회 자동 수행 */
                $('.pop_wrap').height(window.innerHeight - 2);
            },
            /* 예산내역 테이블 크기 자동 조정 */
            SetBudgetTblResize: function () {
                /* ## init - 결제내역 크기조정 ## */

                if ($('#BudgetTbl_right_content_div').length > 0) {
                    var btnHeight = Number($('.btn_div.mt0').css('height').replace('px', '')) * $('.btn_div.mt0').length;
                    var spaceHeight = 40;
                    var titleHeight = Number($('.pop_sign_head.posi_re').css('height').replace('px', ''));
                    var tblHeight = (Number(($('#consTbl_right_content_div').css('height') || '0').toString().replace('px', '')) * $('.cus_ta_ea.scbg.posi_re').length);

                    var calcHeight = btnHeight + spaceHeight + titleHeight + tblHeight;
                    var windowCalcHeight = window.innerHeight - calcHeight;

                    $('#budgetTbl_right_content_div').css('height', ((windowCalcHeight - 140) < 135 ? 135 : (windowCalcHeight - 140)) + 'px');
                }
            },
            GetArray: function (obj, key, baseValue) {
                /* [ parameter ] */
                /*   - obj : 테이블 생성 시 필요한 columns 정보 */
                /*   - key : 배열로 변환할 JSON key */
                /*   - baseValue : 값이 없는 경우 대체할 기본 값 */

                /* ex) Option.Common.GetArray(columns, 'title', ''); */
                obj = (obj || []);
                key = (key || '');
                baseValue = (baseValue || '');

                var attrArray = [];

                if (key !== '') { $.each(obj, function (idx, item) { attrArray.push((item[key] || baseValue)); }); }
                return attrArray;
            },
            /* 툴팁 표시 처리 */
            SetTooltip: function (target, column) {
                /* [ parameter ] */
                /*   - target : 툴팁을 표시할 element 의 jquery object */
                /*   - column : 툴팁 표시를 위한 구분 값 ( switch 사용 ) */
                var msgDef = {
                    docuFgName: '${CL.ex_consDefMsg1}',
                    consDate: '${CL.ex_consDefMsg2}',
                    erpMgtName: '${CL.ex_consDefMsg3}',
                    consNote: '${CL.ex_consDefMsg4}',
                    erpDivName: (Option.Common.ERPiU() ? '${CL.ex_consDefMsg5}'/*회계계정*/ : (Option.Common.iCUBE() ? '${CL.ex_consDefMsg6}' : '')),
                    budgetNote: '${CL.ex_consDefMsg7}',
                    budgetAmt: '${CL.ex_consDefMsg8}',
                   	causeEmpName : '${CL.ex_consDefMsg9}',
   					statement : '${CL.ex_consDefMsg10}',
   					erpBudgetName : '${CL.ex_consDefMsg11}',
   					erpBizplanName : '${CL.ex_consDefMsg12}',
   					erpBgacctName : '${CL.ex_consDefMsg13}'
                };

                var tooltipMsg = '';
                tooltipMsg = (msgDef[column] || '').toString();
                target.html(tooltipMsg);
            },
            /* 임시저장 체크 */
			CheckDraftInfo : function(parameter) {
				var returnObject = {};
				returnObject.hasDraftInfo = 'N';
				$.ajax({
					type : 'post',
					url : domain + '/ex/np/user/res/CheckDraftInfo.do',
					datatype : 'json',
					async : false,
					data : Option.Common.GetSaveParam(parameter),
					resDocSeq : parameter.resDocSeq,
					/*   - success :  */
					success : function(result) {
						fnAjaxLog(this.url, result);
						if((result.result.aData.appr_status || '') != '' || (result.result.aData.c_distatus || '') == '001'){
							returnObject.hasDraftInfo = 'Y';
						}
						returnObject.aaData = result.result.aaData;
					},
					/*   - error :  */
					error : function(result) {
						console.error(result);
					}
				});
				return returnObject;
			},
            GetSaveParam: function (param) {
                /* [ parameter ] */
                /*   - param : 포맷 변경을 위한 파라미터 */

                /* 금액 포맷 변경 대상 */
                var amtFormatTarget = ['tradeAmt', 'tradeStdAmt', 'tradeVatAmt', 'amt', 'budgetAmt', 'erpOpenAmt', 'erpApplyAmt', 'erpLeftAmt', 'budgetStdAmt', 'budgetTaxAmt', 'openAmt', 'applyAmt', 'tryAmt', 'balanceAmt', 'gwBalanceAmt'];
                /* 금액 포맷 변경 대상 - 포맷 변경 */
                $.each(amtFormatTarget, function (idx, key) { if (param[key]) { param[key] = param[key].toString().replace(/,/g, ''); } })

                /* 날짜 포맷 변경 대상 */
                var dateFormatTarget = ['resDate', 'regDate', 'erpGisuDate', 'expendDate', 'consDate', 'causeDate', 'inspectDate', 'signDate', 'pjtToDate', 'pjtFromDate', 'erpGisuFromDate', 'erpGisuToDate'];
                /* 날짜 포맷 변경 대상 - 포맷 변경 */
                $.each(dateFormatTarget, function (idx, key) { if (param[key]) { param[key] = param[key].toString().replace(/-/g, ''); } })

                /* [ return ] */
                return param;
            },
            /* 금액 format 변환 */
            GetNumeric: function (value) {
            	// value NaN 및 예외데이터 처리. 
            	if(!value){
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
            SetAmtUpdate: function (consSeq, budgetSeq, budgetAmt, type) {
                type = (type || '');
                amtInfo = (typeof amtInfo === 'undefined' ? {} : amtInfo);
                if(!!useFavorite){
                	if (typeof amtInfo[consSeq] === 'undefined') {  amtInfo[consSeq] = {}; }
                    if (typeof amtInfo[consSeq][budgetSeq] === 'undefined') { amtInfo[consSeq][budgetSeq] = {}; }	
                }
                
                

                if (type === 'delete') {
                    consSeq = (consSeq || 0);
                    budgetSeq = (budgetSeq || 0);

                    if (consSeq != 0 && budgetSeq != 0) {
                    	return;
                        amtInfo[consSeq][budgetSeq] = {};
                    } else if (consSeq != 0) {
                        amtInfo[consSeq] = {};
                    }

                    consSeq = (consSeq || 0);
                    budgetSeq = (budgetSeq || 0);
                    budgetAmt = 0;
                }

                if (type === 'delete' || (consSeq > 0 && budgetSeq > 0)) {
                    if (typeof amtInfo[consSeq] === 'undefined') {  amtInfo[consSeq] = {}; }
                    if (typeof amtInfo[consSeq][budgetSeq] === 'undefined') { amtInfo[consSeq][budgetSeq] = {}; }

                    amtInfo[consSeq][budgetSeq]['budgetAmt'] = Number((budgetAmt || '0').toString().replace(/,/g, ''));

                    var amt = 0;
                    var budgetAmt = 0;

                    $.each(Object.keys(amtInfo), function (consIdx, cons) {
                        $.each(Object.keys(amtInfo[cons]), function (budgetIdx, budget) {
                            if (cons == consSeq) {
                                if (amtInfo[cons]) {
                                    if (amtInfo[cons][budget]) {
                                        if (amtInfo[cons][budget]['budgetAmt']) {
                                            amt += (amtInfo[cons][budget]['budgetAmt'] || 0);
                                        }
                                    }
                                }
                            }
                        });
                    });

                    var consUID = $('#consTbl').dzt('getUID');
                    // $('#consTbl').dzt('setValue', consUID, { amt: Option.Common.GetNumeric(amt) }, false);
                    fnFocusAmtUpdate();
                }
            }
        },
        ERPiU: {
            /* 결의구분 ( 옵션 설정에 따라서 동작 ) */
            GetDocuFg: function () {
                var docuFgArray = [
                    /* 지출품의서 */
                    { docuFgCode: '1', docuFgName: '지출품의서' },
                    /* 구매품의서 */
                    { docuFgCode: '2', docuFgName: '구매품의서' },
                    /* 용역품의서 */
                    { docuFgCode: '3', docuFgName: '용역품의서' },
                    /* 세입세출외 */
                    { docuFgCode: '4', docuFgName: '세입세출외' }
                ];
                
				if(!optionSet.gw){
					return docuFgArray;
				} else if( !optionSet.gw[2] ){
					return docuFgArray;
				} else if( !optionSet.gw[2][9] ){
					return docuFgArray;
				} else {
					var returnArr = [];
					for( var i=0; i < docuFgArray.length; i++ ){
						var item = docuFgArray[i];
						if(optionSet.gw[2][9].setValue.indexOf(item.docuFgCode) > -1){
							returnArr.push(item);
						}
					}
					return returnArr;
				}

                return docuFgArray;
            },
            GetBudgetAmtInfo: function (key) {
                /* 기본값 정의 */
                key = (key || '');

                var budgetData = $('#budgetTbl').dzt('getValue');
                var budgetChkKey = ['erpBudgetName', 'erpBizplanName', 'erpBgacctName', 'budgetAmt'];

                if (((budgetData.budgetSeq || '') !== '') || (budgetChkKey.indexOf(key) > -1)) {
                    /* 필수 입력 확인 후 진행 ( 예산단위, ( + 사업계획 ), 예산계정 ) */
                    fnSetBudgetDisplay(); /* 예산 정보 갱신 */
                } else {
                    /* 조건이 만족되지 않으며, 입력된 정보가 없는 경우에는 금액을 모두 0원으로 초기화 한다. */
                    if ((budgetData.erpBudgetName || '') === ''
                        || ( ((!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0'))  ? false : true ) && ((budgetData.erpBizplanName || '') === '') ) 
                        || (budgetData.erpBgacctName || '') === '') {
                        /* 예산금액 초기화 */
                        $('#lbErpOpenAmt').html('0');
                        $('#lbResApplyAmt').html('0');
                        $('#lbConsBalanceAmt').html('0');
                        $('#lbBudgetAmt').html('0');
                        $('#lbGwBalanceAmt').html('0');
                    }
                }
            }
        },
        iCUBE: {
            /* 결의구분 ( 옵션 설정에 따라서 동작 ) */
            GetDocuFg: function () {
                var docuFgArray = [
					/* 품의구분 정책이 정해지지 않은 상태로, ERPiU 기준으로 우선 처리 */
                    /* 지출품의서 */
                    { docuFgCode: '1', docuFgName: '${CL.ex_expendCons}' }, /*지출품의서*/
                    /* 구매품의서 */
                    { docuFgCode: '2', docuFgName: '${CL.ex_purchaseCons}' }, /*구매품의서*/
                    /* 용역품의서 */
                    { docuFgCode: '3', docuFgName: '${CL.ex_serviceCons}' }, /*용역품의서*/
                    /* 지출품의서 */
                    /* { docuFgCode: '1', docuFgName: '지출품의서' }, */
                    /* 구매품의서 */
                    /* { docuFgCode: '2', docuFgName: '구매품의서' }, */
                    /* 용역품의서 */
                    /* { docuFgCode: '3', docuFgName: '용역품의서' } */
                    /* 구매 */
                    /* { docuFgCode: '1', docuFgName: '구매' }, */
                    /* 제조 */
                    /* { docuFgCode: '2', docuFgName: '제조' }, */
                    /* 수리 */
                    /* { docuFgCode: '3', docuFgName: '수리' }, */
                    /* 외부거래처용 */
                    /* { docuFgCode: '4', docuFgName: '외부거래처용' }, */
                    /* 내부직원용 */
                    /* { docuFgCode: '5', docuFgName: '내부직원용' }, */
                    /* 기타소득자용 */
                    /* { docuFgCode: '6', docuFgName: '기타소득자용' }, */
                    /* 기타 */
                    /* { docuFgCode: '7', docuFgName: '기타' }, */
                    /* 수입 */
                     { docuFgCode: '8', docuFgName: '수입품의서' }
                ];

				if(!optionSet.gw){
					return docuFgArray;
				} else if( !optionSet.gw[2] ){
					return docuFgArray;
				} else if( !optionSet.gw[2][9] ){
					return docuFgArray;
				} else {
					var returnArr = [];
					for( var i=0; i < docuFgArray.length; i++ ){
						var item = docuFgArray[i];
						if(optionSet.gw[2][9].setValue.indexOf(item.docuFgCode) > -1){
							returnArr.push(item);
						}
					}
					return returnArr;
				}
                
                return docuFgArray;
            },
            /* 예산통제 구분 ( FG_TY ) */
            GetMgtStat: function () {
                /* key : 4 / value : 01 */
                /* 0 : 미사용 / 1 : 사용부서(부서) / 2 : 프로젝트(프로젝트)(기본값) */
                if (optionSet &&
                    optionSet.erp &&
                    optionSet.erp['4'] &&
                    optionSet.erp['4']['01'] &&
                    optionSet.erp['4']['01']['FG_TY']) {
                    return (optionSet.erp['4']['01']['FG_TY'] || '2');
                } else {
                    return '0';
                }
            },
            /* 원인행위 사용 여부 ( USE_YN ) */
            GetCauseStat: function () {
                /* key : 4 / value : '05' */
                return 'N'; /* 현재 옵션 미개발 */
            },
            /* 하위사업 사용여부 ( USE_YN ) */
            GetBottomStat: function () {
                /* key : 4 / value : 14 */
                /* 0: 미사용 / 1 : 적용 */
                if (optionSet &&
                    optionSet.erp &&
                    optionSet.erp['4'] &&
                    optionSet.erp['4']['14'] &&
                    optionSet.erp['4']['14']['USE_YN']
                ) {
                    return (((optionSet.erp['4']['14']['USE_YN'] || '0') === '1') ? 'Y' : 'N');
                } else {
                    return 'N';
                }
            },
            GetBudgetAmtInfo: function (key) {
                /* 기본값 정의 */
                key = (key || '');

                var consData = $('#consTbl').dzt('getValue');
                var budgetData = $('#budgetTbl').dzt('getValue');
                var budgetChkKey = ['erpMgtName', 'erpBudgetName', 'erpDivName', 'budgetAmt'];
                if (((budgetData.budgetSeq || '') !== '') || (budgetChkKey.indexOf(key) > -1)) {
                    /* 필수 입력 확인 후 진행 ( 예산단위, ( + 사업계획 ), 예산계정 ) */
                    fnSetBudgetDisplay(); /* 예산 정보 갱신 */
                } else {
                    /* 조건이 만족되지 않으며, 입력된 정보가 없는 경우에는 금액을 모두 0원으로 초기화 한다. */
                    if ((consData.erpMgtSeq || '') === ''
                        || (budgetData.erpBudgetSeq || '') === '') {
                        /* 예산금액 초기화 */
                        $('#lbErpOpenAmt').html('0');
                        $('#lbResApplyAmt').html('0');
                        $('#lbConsBalanceAmt').html('0');
                        $('#lbBudgetAmt').html('0');
                        $('#lbGwBalanceAmt').html('0');
                    }
                }
            }
        }
    };

    /* ## 테이블 변수정의 ## */
    /* ====================================================================================================================================================== */
    var consGrid = {
        columns: [
            {
            	/* 테이블 헤더 표시 정보 */
                title: '${CL.ex_confDivide}', /*품의구분*/
                /* 테이블 컬럼 구분 정보 */
                column: 'docuFgName',
                /* 사용자 입력 형태 정의 [ 2018.04.11 : text, readonly, combobox, datepicker ] */
                type: 'combobox',
                /* 화면 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                /* 필수 입력 표시여부 [ 2018.04.11 : Y(표시), N(미표시) ] */
                req: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                /* combobox 처리 시 더미 정보 ( "type: 'combobox'" 인 경우 필수 ) */
                combobox: {
                    /* combobox 표시 내용 ( combobox.data 기준으로 key가 존재할 경우 대체, key가 없을 경우 그대로 표시 ) */
                    display: ['docuFgCode', '.', 'docuFgName'],
                    /* combobox 표시 array */
                    data: Option[Option.Common.GetErpType()].GetDocuFg()
                },
                /* tooltip 연동 */
                tooltip: function () {
                    Option.Common.SetTooltip($('#spanConsTooltip'), this.column);
                }
            },
            {
                title: '${CL.ex_consDate}', /*품의일자*/
                column: 'consDate',
                type: 'datepicker',
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                req: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                tooltip: function () {
                    Option.Common.SetTooltip($('#spanConsTooltip'), this.column);
                }
            },
            {
                title: GetErpMgtIsProject() ? '${CL.ex_project}' : '${CL.ex_department}', /*부서*/ /*프로젝트*/
                column: 'erpMgtName',
                type: 'text',
                display: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? YES : NO)),
                req: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? YES : NO)),
                keyEvent: ['F2', 'Enter', 'Backspace', 'Delete'],
                methods: {
                    keyEventF2: function (keyName, searchStr) {
                        keyName = (keyName || 'F2');
                        searchStr = (searchStr || '');

                        var consData = $('#consTbl').dzt('getValue');
                        var code = 'project';
                        fnCommonCode(code, keyName, searchStr, consData);

                        return false;
                    },
                    keyEventEnter: function (keyName, searchStr) {
                        var consData = $('#consTbl').dzt('getValue');
                        if ((consData.erpMgtSeq || '') === '') {
                            var keyName = 'Enter';
                            var searchStr = $('#consTbl').dzt('getInputValue');
                            this.keyEventF2(keyName, searchStr);
                        } else {
                            $('#consTbl').dzt('setKeyIn', 'RIGHT');
                        }

                        return false;
                    },
                    keyEventBackspace: function (keyName, searchStr) {
                        return this.keyEventDelete();
                    },
                    keyEventDefault: function (keyName, searchStr) {
                    	if(!!$('#consTbl').dzt('getValue').erpMgtSeq){
                    		return this.keyEventDelete();
                    	}
                    },
                    keyEventDelete: function (keyName, searchStr) {
                        /* 현재 행 정보 조회 */
                        var uid = $('#consTbl').dzt('getUID');
                        /* 입력된 계좌 정보 삭제 ( 입출금계좌, 입출금 계좌 코드, 입출금 계좌 명칭 ) */
                        $('#consTbl').dzt('setValue', uid, {
                            erpMgtSeq: ''
                        }, false);
                    }
                },
                tooltip: function () {
                    Option.Common.SetTooltip($('#spanConsTooltip'), this.column);
                }
            },{
				title : '${CL.ex_bottomBussines}',/*하위사업*/
				column : 'bottomName',
				type : 'text',
				req : YES,
				display : GetBottomUseYN(),
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
						var resData = $('#consTbl').dzt('getValue');

						/* 코드 팝업 호출 */
						fnCommonCode('erpBottomName', keyName, searchStr, resData);

						/* [ return ] */
						return false;
					},
					/* 키입력 이벤트 동작 시 대체 호출 함수 정의 [ 2018.04.11 : keyEvent + keyEvent ] */
					keyEventEnter : function() {
						var budgetData = $('#consTbl').dzt('getValue');
						if ((budgetData.erpBottomSeq || '') === '') {
							/* keyName : 사용자 입력 키이름 ( Enter 로 넘어온 경우를 구분하기 위함 ) */
							var keyName = 'Enter';
							/* searchStr : 사용자 입력 검색어 */
							var searchStr = $('#consTbl').dzt('getInputValue');
							/* F2 입력 이벤트 호출 */
							this.keyEventF2(keyName, searchStr);
						} else {
							$('#consTbl').dzt('setKeyIn', 'RIGHT');
						}
						/* [ return ] */
						return false;
					},
					keyEventDefault: function (keyName, searchStr) {
						if(!!$('#consTbl').dzt('getValue').bottomSeq){
							return this.keyEventDelete();
						}
                    },
					keyEventBackspace : function() {
						return this.keyEventDelete();
					},
					keyEventDelete : function() {
						/* 현재 행 정보 조회 */
						var uid = $('#consTbl').dzt('getUID');
						/* 입력된 프로젝트/부서 정보 삭제 ( 프로젝트/부서 코드 ) */
						$('#consTbl').dzt('setValue', uid, {
							bottomSeq : ''
						}, false);
					}
				},
				tooltip : function() {
					Option.Common.SetTooltip($('#consTooltip'), this.column);
				}
			}, {
                title: (Option.Common.ERPiU() ? '품의내역' : (Option.Common.iCUBE() ? '${CL.ex_note}' : '')),/*적요*/
                column: 'consNote',
                type: 'text',
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                req: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() && (optionSet.gw[1][11]||{'setValue':'1'}).setValue == '0' ? YES : NO)),
                lastCallback: function () {
                    /* console.error(this.column + ' - lastCallback [' + Option.Common.GetErpType() + '][consTbl]'); */

                    /* 현재 행 정보 조회 */
                    var consData = $('#consTbl').dzt('getValue');
                    
                    /* 필수값 입력 확인 */
                    var reqChkCons = fnConsChkValue();

                    /* 저장될 데이터 사이즈 확인 */
                    if(consData.consNote.length > 79){
                    	alert('적요는 80자 이내로 작성가능합니다.');
                    	return;
                    }
                    var special_pattern = /[\']/gi;

                    if(special_pattern.test(consData.consNote)){
                        alert('적요는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
                        return ;
                    }
                    
                    /* 하위사업 필수값 체크 */
					if(GetBottomUseYN() == 'Y' && (consData.bottomSeq||'') == ''){
						alert('하위사업을 입력 해주세요.');
						return;
					}
                    
                    if (reqChkCons.sts) {
                        /* 데이터 저장여부 확인 */
                        if (typeof consData.consSeq === 'undefined' || consData.consSeq === '') {
                            fnConsInsert();

                            /* 정상처리여부 확인 */
                            consData = $('#consTbl').dzt('getValue');
                            if ((consData.insertStat || '') === 'SUCCESS') {
                                $('#consTbl').dzt('setCommit', false); /* commit 처리 */
                                $('#consTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

                                if ($('#budgetTbl').dzt('getValueAll').length < 1) {
                                    $('#btnBudgetAdd').click();
                                } else {
                                    $('#consTbl').dzt('setCommit', false);
                                    $('#consTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
                                    $('#budgetTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
                                }
                            } else {
                                if ((consData.insertMsg || '') !== '') {
                                    alert(consData.insertMsg);
                                }

                                $('#consTbl').dzt('setValue', $('#consTbl').dzt('getUID'), { insertStat: '', insertMsg: '' }, false);
                                $('#consTbl').dzt('setCommit', false);
                            }
                        } else {
                            /* 저장도 되었으며 마지막 행이므로 예산내역으로 이동 */
                            var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
                            var budgetSaveCount = $('#budgetTbl').dzt('getValueAll').filter(function (item) { return ((item.budgetSeq || '') != '') }).length;

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
                        var uid = $('#consTbl').dzt('getUID');
                        $('#consTbl').dzt('setFocus', uid, reqChkCons.key);

                        /* 사용자 알림 처리 */
                        alert(reqChkCons.msg);
                    }

                    /* 포커스 지정이 존재하지 않는 경우에는 현재 포커스 유지처리 */
                    if ($('#budgetTbl').find('.colOn').length === 0) {
                        $('#consTbl').dzt('setFocus', $('#consTbl').dzt('getUID'), this.column);
                    }

                    return false;
                },
                tooltip: function () {
                    Option.Common.SetTooltip($('#spanConsTooltip'), this.column);
                }
            },
            {
                title: '${CL.ex_amount}',/*금액*/
                column: 'amt',
                type: 'readonly',
                isNumeric: YES,
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                req: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? NO : NO)),
                tooltip: function () {
                    Option.Common.SetTooltip($('#spanConsTooltip'), this.column);
                }
            },
            {
                title: '${CL.ex_goodsSpecification}',
                column: 'itemAmt',
                type: 'text',
                isNumeric: YES,
                display: GetItemSpecConsGridUseYN(),
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
            },
            { title: 'consSeq', column: 'consSeq', type: 'readonly', display: NO },
            { title: 'consDocSeq', column: 'consDocSeq', type: 'readonly', display: NO }
        ]
    };

    var budgetGrid = {
        columns: [
            {
                title: (Option.Common.ERPiU() ? '예산단위' : (Option.Common.iCUBE() ? '${CL.ex_budgetSub}' : '')),/*예산과목*/
                column: 'erpBudgetName',
                type: 'text',
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                req: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                tooltip : function() {
					Option.Common.SetTooltip($('#budgetTooltip'), this.column);
				},
                keyEvent: ['F2', 'Enter', 'Backspace', 'Delete'],
                methods: {
                    keyEventF2: function (keyName, searchStr) {
                        keyName = (keyName || 'F2');
                        searchStr = (searchStr || '');
                        var consData = $('#consTbl').dzt('getValue');
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        fnCommonCode('budgetlist', keyName, searchStr, consData, budgetData);
                        return false;
                    },
                    keyEventEnter: function (keyName, searchStr) {
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        if ((budgetData.erpBudgetSeq || '') === '') {
                            var keyName = 'Enter';
                            var searchStr = $('#budgetTbl').dzt('getInputValue');
                            this.keyEventF2(keyName, searchStr);
                        } else {
                            $('#budgetTbl').dzt('setKeyIn', 'RIGHT');
                        }

                        return false;
                    },
                    keyEventBackspace: function (keyName, searchStr) {
                        return this.keyEventDelete();
                    },
                    
                    keyEventDefault: function (keyName, searchStr) {
                    	if(!!$('#budgetTbl').dzt('getValue').erpBudgetSeq){
                    		return this.keyEventDelete();
                    	}
                    },
                    keyEventDelete: function (keyName, searchStr) {
                        var uid = $('#budgetTbl').dzt('getUID');

                        if (Option.Common.ERPiU()) {
                            $('#budgetTbl').dzt('setValue', uid, {
                                erpBudgetSeq: ''
                            }, false);
                        } else if (Option.Common.iCUBE()) {
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
                    }
                }
            },
            {
                title: '사업계획',
                column: 'erpBizplanName',
                type: 'text',
                display: fnGetUseBizplanERPiU(),
                req: fnGetUseBizplanERPiU(),
                keyEvent: ['F2', 'Enter', 'Backspace', 'Delete'],
                methods: {
                    keyEventF2: function (keyName, searchStr) {
                        keyName = (keyName || 'F2');
                        searchStr = (searchStr || '');
                        var consData = $('#consTbl').dzt('getValue');
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        fnCommonCode('bizplan', keyName, searchStr, consData, budgetData);
                        return false;
                    },
                    keyEventEnter: function () {
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        if ((budgetData.erpBizplanSeq || '') === '') {
                            var keyName = 'Enter';
                            var searchStr = $('#budgetTbl').dzt('getInputValue');
                            this.keyEventF2(keyName, searchStr);
                        } else {
                            $('#budgetTbl').dzt('setKeyIn', 'RIGHT');
                        }

                        return false;
                    },
                    keyEventBackspace: function () {
                        return this.keyEventDelete();
                    },
                    keyEventDefault: function (keyName, searchStr) {
                    	/* 프로젝트 코드가 선택된 경우에만 동작 */
                    	if(!!$('#budgetTbl').dzt('getValue').erpBizplanSeq){
                    		return this.keyEventDelete();
                    	}
                    },
                    keyEventDelete: function () {
                        var uid = $('#budgetTbl').dzt('getUID');
                        $('#budgetTbl').dzt('setValue', uid, {
                            erpBizplanSeq: ''
                        }, false);
                    }
                },
                tooltip: function () {
                    Option.Common.SetTooltip($('#budgetTooltip'), this.column);
                }
            },
            {
                title: '예산계정',
                column: 'erpBgacctName',
                type: 'text',
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? NO : NO)),
                req: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? NO : NO)),
                keyEvent: ['F2', 'Enter', 'Backspace', 'Delete'],
                methods: {
                    keyEventF2: function (keyName, searchStr) {
                        keyName = (keyName || 'F2');
                        searchStr = (searchStr || '');
                        var consData = $('#consTbl').dzt('getValue');
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        fnCommonCode('bgacct', keyName, searchStr, consData, budgetData);
                        return false;
                    },
                    keyEventEnter: function () {
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        if ((budgetData.erpBgacctSeq || '') === '') {
                            var keyName = 'Enter';
                            var searchStr = $('#budgetTbl').dzt('getInputValue');
                            this.keyEventF2(keyName, searchStr);
                        } else {
                            $('#budgetTbl').dzt('setKeyIn', 'RIGHT');
                        }

                        return false;
                    },
                    keyEventBackspace: function () {
                        return this.keyEventDelete();
                    },
                    keyEventDefault: function (keyName, searchStr) {
                    	if(!!$('#budgetTbl').dzt('getValue').erpBgacctSeq){
                    		return this.keyEventDelete();
                    	}
                    },
                    keyEventDelete: function () {
                        var uid = $('#budgetTbl').dzt('getUID');
                        $('#budgetTbl').dzt('setValue', uid, {
                            erpBgacctSeq: ''
                        }, false);
                    }
                },
                tooltip: function () {
                    Option.Common.SetTooltip($('#budgetTooltip'), this.column);
                }
            },
            {
                title: (Option.Common.ERPiU() ? '${CL.ex_accountingAcc}'/*회계계정*/ : (Option.Common.iCUBE() ? '${CL.ex_accountingUnit}' : '')),/*회계단위*/
                column: 'erpDivName',
                type: 'text',
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                req: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? YES : NO)),
                tooltip : function() {
					Option.Common.SetTooltip($('#budgetTooltip'), this.column);
				},
                keyEvent: ['F2', 'Enter', 'Backspace', 'Delete'],
                methods: {
                    keyEventF2: function (keyName, searchStr) {
                        keyName = (keyName || 'F2');
                        searchStr = (searchStr || '');
                        var consData = $('#consTbl').dzt('getValue');
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        fnCommonCode('div', keyName, searchStr, consData);
                        return false;
                    },
                    keyEventEnter: function (keyName, searchStr) {
                        var budgetData = $('#budgetTbl').dzt('getValue');
                        if ((budgetData.erpDivSeq || '') === '') {
                            var keyName = 'Enter';
                            var searchStr = $('#budgetTbl').dzt('getInputValue');
                            this.keyEventF2(keyName, searchStr);
                        } else {
                            $('#budgetTbl').dzt('setKeyIn', 'RIGHT');
                        }

                        return false;
                    },
                    keyEventBackspace: function (keyName, searchStr) {
                        return this.keyEventDelete();
                    },
                    keyEventDefault: function (keyName, searchStr) {
                    	if(!!$('#budgetTbl').dzt('getValue').erpDivSeq){
                    		return this.keyEventDelete();
                    	}
                    },
                    keyEventDelete: function (keyName, searchStr) {
                        var uid = $('#budgetTbl').dzt('getUID');
                        $('#budgetTbl').dzt('setValue', uid, {
                            erpDivSeq: ''
                        }, false);
                    }
                }
            },
            {
                title: '${CL.ex_note}', /*비고*/
                column: 'budgetNote',
                type: 'text',
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                req: (Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? NO : NO)),
                tooltip : function() {
					Option.Common.SetTooltip($('#budgetTooltip'), this.column);
				},
            },
            {
                title: '${CL.ex_amount}',/*금액*/
                column: 'budgetAmt',
                type: 'text',
                isNumeric: YES,
                display: (Option.Common.ERPiU() ? YES : (Option.Common.iCUBE() ? YES : NO)),
                req: YES,//(Option.Common.ERPiU() ? NO : (Option.Common.iCUBE() ? NO : NO)),
                tooltip : function() {
					Option.Common.SetTooltip($('#budgetTooltip'), this.column);
				},
                lastCallback: function () {
                    /* console.error(this.column + ' - lastCallback [' + Option.Common.GetErpType() + '][budgetTbl]'); */

                    /* 현재 행 정보 조회 */
                    var budgetData = $('#budgetTbl').dzt('getValue');

                    /* 필수값 입력 확인 */
                    var reqChkBudget = fnBudgetChkValue();

                    /* 저장될 데이터 사이즈 확인 */
                    if(budgetData.budgetNote.length > 79){
                    	alert('적요는 80자 이내로 작성가능합니다.');
                    	return;
                    }
                    var special_pattern = /[\']/gi;

                    if(special_pattern.test(budgetData.budgetNote)){
                        alert('적요는 특수문자 ' + "'" + ' 를 사용할 수 없습니다.');
                        return ;
                    }
                    
                    if (reqChkBudget.sts) {
                        if (typeof budgetData.budgetSeq === 'undefined' || budgetData.budgetSeq === '') {
                            fnBudgetInsert();

                            /* 예산체크 */
                            Option[Option.Common.GetErpType()].GetBudgetAmtInfo(this.column);

                            /* 정상처리여부 확인 */
                            budgetData = $('#budgetTbl').dzt('getValue');
                            if ((budgetData.insertStat || '') === 'SUCCESS') {
                                $('#budgetTbl').dzt('setCommit', false); /* commit 처리 */
                                $('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */

                                var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
                                var budgetSaveCount = $('#budgetTbl').dzt('getValueAll').filter(function (item) { return ((item.budgetSeq || '') != '') }).length;

                                if (budgetDataArray.length !== budgetSaveCount) {
                                    /* 마지막 행으로 이동 */
                                    $('#budgetTbl').dzt('setCommit', false);
                                    $('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
                                    $('#budgetTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
                                } else {
                                    /* 신규 행 추가 */
                                    $('#btnBudgetAdd').click();
                                }
                            } else {
                                if ((budgetData.insertMsg || '') !== '') {
                                    alert(budgetData.insertMsg);
                                }

                                $('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), { insertStat: '', insertMsg: '' }, false);
                                $('#budgetTbl').dzt('setCommit', false);
                            }
                        } else {
                            /* 예산체크 */
                            Option[Option.Common.GetErpType()].GetBudgetAmtInfo(this.column);

                            /* 저장도 되었으며 마지막 행이므로 결제내역으로 이동 */
                            var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
                            var budgetSaveCount = $('#budgetTbl').dzt('getValueAll').filter(function (item) { return ((item.budgetSeq || '') != '') }).length;

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
                        /* 예산체크 */
                        Option[Option.Common.GetErpType()].GetBudgetAmtInfo(this.column);

                        /* 미입력 항목 포커스 지정 */
                        var uid = $('#budgetTbl').dzt('getUID');
                        $('#budgetTbl').dzt('setFocus', uid, reqChkBudget.key);

                        /* 사용자 알림 처리 */
                        alert(reqChkBudget.msg);
                    }

                    return false;
                }
            },{
                title: '${CL.ex_goodsSpecification}',
                column: 'itemAmt',
                type: 'text',
                isNumeric: YES,
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
            },
            { title: 'consSeq', column: 'consSeq', type: 'readonly', display: NO },
            { title: 'consDocSeq', column: 'consDocSeq', type: 'readonly', display: NO },
            { title: 'budgetSeq', column: 'budgetSeq', type: 'readonly', display: NO }
        ]
    };

    /* 	## window unload 	##
    *	양식 수정정보 임시저장 문서의 경우 INTER갱신 이벤트 호출
    * ====================================================================================================================================================== */
    $( window ).unload(function() {
    	/* ${param.newConsDocSeq} -- 재기안 문서의 경우  */
    	/* approKey -- 이전단계 기능 수행 문서의 경우 */
    	var devMode = false;
    	if(!devMode){
	    	optionSet.consDocInfo = optionSet.consDocInfo || { consDocSeq : '${param.consDocSeq}' }; 
	    	var isRefreshInter = (!!'${param.newConsDocSeq}') || (!!approKey);
	    	if( isRefreshInter ){
				$.ajax({
					type : 'post',
					url : domain + '/expend/np/user/cons/UpdateConsInterlock.do',
					datatype : 'json',
					async : false,
					data : {
						consDocSeq : optionSet.consDocInfo.consDocSeq
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
    
    /* ## document ready ## */
    /* ====================================================================================================================================================== */
    $(document).ready(function () {
    	Option.Common.SetResize();
        fnInit(); /* init */
        fnEventInit(); /* event init */
        setDocReady = Option.Common.CheckDraftInfo(optionSet.consDocInfo);
		checkDocStatus = setDocReady.hasDraftInfo;
		if((setDocReady.aaData.length || 0) > 0){
			resetBudgetSize = setDocReady.aaData.length;
		}

        if ((approKey || '') !== '') {
        	/* 품의정보 조회 처리 */
            approvalBack = !approvalBack;
            fnConsSelect(); /* 품의서 정보 조회 및 반영 */
            fnConsAllInfo(); /* 품의서 전체 정보를 기준으로 자동계산 금액 반영 */
            Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
            approvalBack = !approvalBack;
        } else if('' != '${param.newConsDocSeq}'){
        	/* 재기안 */
        	approvalBack = !approvalBack;
        	fnConsSelect(); /* 품의서 정보 조회 및 반영 */
        	fnConsAllInfo(); /* 품의서 전체 정보를 기준으로 자동계산 금액 반영 */
        	Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
        	approvalBack = !approvalBack;
        } else if( ('${param.tripDocSeq}' != '') && ('${param.consDocSeq}' != '') ){
        	/* 출장 품의 내용 수정 */
        	approvalBack = !approvalBack;
        	fnConsSelect(); /* 품의서 정보 조회 및 반영 */
        	fnConsAllInfo(); /* 품의서 전체 정보를 기준으로 자동계산 금액 반영 */
        	Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
        } else {
            /* 최초 수행 프로세스 - 품의정보 행 추가 */
            $('#btnConsAdd').click();
        }
        // $('#consTbl').dzt('setDefaultFocus', 'first');

        /* 예산내역 높이 갱신 */
        Option.Common.SetBudgetTblResize();
        resetBudgetSize = 0;
        
        /********************************************************************
        				2차 외부 시스템 연동 (출장 복명)
        *********************************************************************/
        if( (!!optionSet.formInfo.formDTp2) && ( (optionSet.formInfo.formDTp2 == 'EXNPTRIPCONI') || (optionSet.formInfo.formDTp2 == 'EXNPTRIPCONU')  ) ){
        	/* 결재 작성 버튼 삭제 */
        	$('#btnApproval').remove();
        	
        	/* 출장복명 이전단계 버튼 */
        	$('#btnTripInfo').show().click(function (){
        		fnAdvBtnActionTripSave();
        	});
        }
    });
    
    /* ## init ## */
    /* ====================================================================================================================================================== */
    function fnInit() {
        /* 미개발 버튼 숨기기 */
        $('#btnConsRefer').hide();
        $('#btnConsUp').hide();
        $('#btnConsDown').hide();
        $('#btnBudgetUp').hide();
        $('#btnBudgetDown').hide();
        /* ---------------------------------------- */
        /* 비영리 전결 연동 여부 확인 */
        var eaType = getParam("eaType");

        if(eaType != null && eaType == "ea"){
            fnConsPopResize(); /* 팝업 크기 조정 */
        }
        fnConsEmpInit(); /* 작성자 정보 설정 */
        /* 품의서 생성 */
       	if('' != '${param.newConsDocSeq}'){
       		/* [CASE 1. ] 지출 품의서 재기안. */
			console.log(' [EXNP new docu case 1. ] con redraft. ');
       		
        	/* 재기안 모드일 경우 newConsDocSeq로 처리 */
        	consDocSeq = '${param.newConsDocSeq}';
        	optionSet.consDocInfo = {'consDocSeq' : consDocSeq};
        	$('#h1_consDocTitle').html($('#h1_consDocTitle').text() + ' / ' + consDocSeq);
        	
        	/* 문서 기수 정보 출력 */
			fnShowGisuInfo();	
        }else if ((approKey || '') != '') {
			/* [CASE 3. ] 일반 품의서 데이터 수정 */
			console.log(' [EXNP new docu case 3. ] cons info change ');
			
			/* 수정 모드일 경우 approKey를 통하여 consDocSeq 처리 */
			var approKeyArray = [];
			approKeyArray = (approKey || '').split('_');

			if (approKeyArray.length === 3) {
				/* [0] formDTp ( 양식 상세 구분 ) */
				/* [1] NP ( 영리 비영리 구분 ) */
				/* [2] consDocSeq ( 결의문서 시퀀스 ) */
				consDocSeq = approKeyArray[2].toString();
				optionSet.consDocInfo = optionSet.consDocInfo || { consDocSeq : consDocSeq }; 
				$('#h1_consDocTitle').html($('#h1_consDocTitle').text() + ' / ' + consDocSeq);
				
				/* 문서 기수 정보 출력 */
				fnShowGisuInfo();	
			} else {
				alert('문서작성에 필요한 정보가 전달되지 않았습니다.\r\n더 이상 진행할 수 없습니다.');
			}
		} else if ( ('${param.tripDocSeq}' != '') && ('${param.consDocSeq}' != '') ){
			
			/* [CASE 4. ] 출장 결의서 내용 수성. */
			console.log(' [EXNP new docu case 4. ] trip doc info change. ');
			
			consDocSeq = '${param.consDocSeq}';
			optionSet.consDocInfo = {'consDocSeq' : consDocSeq};
			$('#h1_consDocTitle').html($('#h1_consDocTitle').text() + ' / ' + consDocSeq);
			
			/* 문서 기수 정보 출력 */
			fnShowGisuInfo();
		} else if ((approKey || '') === '' && '' == '${param.newConsDocSeq}'){
			/* [CASE 2. ] 지출품의서 신규 생성. */
			console.log(' [EXNP new docu case 2. ] new cons. ');
            fnConsDocMake();
		} 
		fnConsTableInit(); /* 품의정보 테이블 생성 */
		fnBudgetTableInit(); /* 예산내역 테이블 생성 */
		Option[Option.Common.GetErpType()].GetBudgetAmtInfo(''); /* 예산정보 표시 */
		return;
	}

    // ie 호환성을위해 변경
    function getParam(param)
    {
        var curr_url = location.search.substr(location.search.indexOf("?") + 1);
        var eaType = "";
        curr_url = curr_url.split("&");
        for (var i = 0; i < curr_url.length; i++)
        {
            temp = curr_url[i].split("=");
            if ([temp[0]] == param) { eaType = temp[1]; }
        }
        return eaType;
    }

    /* ## 출장복명 작성완료 버튼 기능 구현 ## */
    /* ====================================================================================================================================================== */
    function fnAdvBtnActionTripSave(){
    	var consAllData = $('#consTbl').dzt('getValueAll');
    	var budgetAllData = $('#budgetTbl').dzt('getValueAll');
    	var callbackData = {
    		'tripConsDocSeq' : '${tripDocSeq}'
    		, 'consDocSeq' : optionSet.consDocInfo.consDocSeq
    		, 'mgtAaData' : consAllData
    		, 'budgetAaData' : budgetAllData
    	};
    	
    	/* for(var budgetData of budgetAllData){
    		if(optionSet.conVo.erpTypeCode=='ERPiU'){
    			if( ( (budgetData.erpBudgetSeq||'')!='' || (budgetData.erpBgacctSeq||'')!='' ) && budgetData.budgetSeq=='' ) {
    				alert('예산 데이터 입력을 확인해주세요');
    				return;
    			}
    		}
    		else{
    			if( (budgetData.erpBudgetSeq||'')!='' && budgetData.budgetSeq=='' ) {
    				alert('예산 데이터 입력을 확인해주세요');
    				return;
    			}	
    		}
    		
    	} */
    	
    	
    	
    	// 콜백 함수 호출
    	typeof opener['fnConsDocPopCallback'](callbackData);
    	this.close();
    }
    
	function fnConsEmpInit() {
		/* ## init - 사용자 정보 설정 ## */

		/* 조건 1. 작성자의 ERP 사원정보 및 조직도 정보를 확인할 수 없는 경우 작성 불가. */
		optionSet.erpEmpInfo = optionSet.erpEmpInfo || {erpDivSeq : ''} 
		if (optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ICUBE' && (optionSet.erpEmpInfo.erpDivSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 회계단위 확인 ## */
			alert('작성자의 회계단위 정보를 확인할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}
		
		if (optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ERPIU' && (optionSet.erpEmpInfo.erpPcSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 회계단위 확인 ## */
			alert('작성자의 회계단위 정보를 확인할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}
		if ((optionSet.erpEmpInfo.erpDeptSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 부서 확인 ## */
			alert('작성자의 부서 정보를 확인할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}
		if ((optionSet.erpEmpInfo.erpEmpSeq || '') == '') {
			/* ## init - 사용자 정보 설정 - 사원번호 확인 ## */
			alert('작성자의 사원번호 정보를 확인할 수 없습니다. 품의서를 작성할 수 없습니다.');
			self.close();
		}

		/* [I] erpDivName : optionSet.erpEmpInfo.erpDivName >> 회계단위 명 */
		/* [U]  >> 회계단위 명 > 전표 회계단위 기본노출 값 지정*/
		/* element : lbErpDivName */
		var erpDivName = (optionSet.conVo.erpTypeCode.toString().toUpperCase() === 'ICUBE' ? (optionSet.erpEmpInfo.erpDivName || '') : (optionSet.erpEmpInfo.erpPcName || ''));
		/* 상배수정
			$('#lbErpDivName').empty();
			$('#lbErpDivName').html(erpDivName);
		 */
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

		return;
	}

	function fnConsTableInit() {
		/* ## init - 품의서 테이블 정의 ## */
		var consColumns = (consGrid.columns || []);

		$('#consTbl').dzt({
			/* 테이블 컬럼 제목 */
			title : Option.Common.GetArray(consColumns, 'title', ''),
			/* 테이블 컬럼 표시 */
			display : Option.Common.GetArray(consColumns, 'display', NO),
			/* 테이블 컬럼 너비 */
			width : Option.Common.GetArray(consColumns, 'width', ''),
			/* 테이블 컬럼 필수 입력 */
			req : Option.Common.GetArray(consColumns, 'req', NO),
			/* 테이블 기본 높이 지정 */
			height : '135px',
			/* 데이터 변경 시 콜백 ( edit ) */
			changeCallback : function(uid, key) {
				/* console.error('changeCallback [consTbl]'); */

				var consData = $('#consTbl').dzt('getValue');

				if('itemAmt'==key){
					if(!!consData.consDocSeq && !!consData.consSeq){
						fnEventItemSpecPop();	
					}
					else{
						alert("품의정보를 입력해주세요");	
					}
					return false;
				}
				
				/* 연결된 예산내역 정보 조회 */
				if ((consData.consSeq || '') !== '') {
					fnBudgetSelect(consData.consDocSeq, consData.consSeq);
				} else {
					/* 예산내역 테이블 초기화 */
					$('#budgetTbl').dzt('setReset');
				}

				/* 예산내역 input 제거 */
				if ($('#budgetTbl').dzt('getValueAll').length > 0 && ($('#budgetTbl').dzt('getUID') || '') !== '') {
					$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#budgetTooltip').html(''); /* 툴팁제거 */
				}
				
				var budgetValue = $('#budgetTbl').dzt('getValueAll')[0];
				
				
				/* 기 저장된 경우에는 사용자 알림 처리 후 데이터 삭제 진행 */
				if ((consData.consSeq || '') !== '') {
					if (Option.Common.ERPiU()) {
						/* 품의구분, 품의일자 */
						var budgetResetTarget = [ 'docuFgName', 'erpMgtName', 'consDate' ];
						var budgetResetName = [ '결의구분', '프로젝트(부서)', '품의일자' ];

						if (budgetResetTarget.indexOf(key) > -1 && !useFavorite && (budgetValue['erpBudgetName'] || '') !== '') {
							var msg = budgetResetName[budgetResetTarget.indexOf(key)] + '를 변경하면 작성중인 내용이 초기화 됩니다.\r\n계속 진행하시겠습니까?';
							if ((checkDocStatus || "N") == "Y"){
								var msg = budgetResetName[budgetResetTarget.indexOf(key)] + '를 변경하면 작성중인 내용이 초기화 되며 임시저장 문서의 회계데이터도 삭제 됩니다. 계속 진행하시겠습니까?';
							}
							/* 정보수정으로 접근시에는 수정모드로 진입하지 않음. */
							if (!approvalBack && confirm(msg)) {
								/* 하위 예산내역 모두 조회 */
								var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
								/* 하위 예산내역 삭제 */
								$.each(budgetDataArray, function(budgetIdx, budgetItem) {
									fnBudgetDelete(budgetItem.consDocSeq, budgetItem.consSeq, budgetItem.budgetSeq);
								});

								/* 기초행 생성 */
								$('#btnBudgetAdd').click();
								$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
								$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								
								/* 기초행 생성 */
								// $('#btnBudgetAdd').click();
								$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
								$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return true;
							} else {
								$('#consTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return false;
							}
						} else {
						}
					} else if (Option.Common.iCUBE()) {
						/* 품의일자, 프로젝트(부서) */
						var budgetResetTarget = [ 'docuFgName', 'erpMgtName', 'consDate' ];
						var budgetResetName = [ '결의구분', '프로젝트(부서)', '품의일자' ];

						if (budgetResetTarget.indexOf(key) > -1 && !useFavorite && (budgetValue['erpBudgetName'] || '') !== '') {
							var msg = budgetResetName[budgetResetTarget.indexOf(key)] + '를 변경하면 작성중인 내용이 초기화 됩니다.\r\n계속 진행하시겠습니까?';
							if ((checkDocStatus || "N") == "Y"){
								var msg = budgetResetName[budgetResetTarget.indexOf(key)] + '를 변경하면 작성중인 내용이 초기화 되며 임시저장 문서의 회계데이터도 삭제 됩니다. 계속 진행하시겠습니까?';
							}
							/* 정보수정으로 접근시에는 수정모드로 진입하지 않음. */
							if (!approvalBack && confirm(msg)) {
								/* 하위 예산내역 모두 조회 */
								var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
								/* 하위 예산내역 삭제 */
								$.each(budgetDataArray, function(budgetIdx, budgetItem) {
									fnBudgetDelete(budgetItem.consDocSeq, budgetItem.consSeq, budgetItem.budgetSeq);
								});

								/* 기초행 생성 */
								// $('#btnBudgetAdd').click();
								$('#budgetTbl').dzt('setCommit', false); /* 그리드 input 제거 */
								$('#budgetTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return true;
							} else {
								$('#consTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
								return false;
							}
						} else {
						}
					}
				} else {
					if ((consData.consSeq || '') !== '') {
						/* 기초행 생성 */
						$('#btnBudgetAdd').click();

						/* 현재행의 uid 조회 */
						var uid = $('#consTbl').dzt('getUID');

						/* 결의서 시퀀스 반영 ( consSeq ) */
						$('#consTbl').dzt('setValue', uid, {
							consSeq : (consData.consSeq || '').toString()
						}, false);
					} else {
						/* 현재행의 uid 조회 */
						var uid = $('#consTbl').dzt('getUID');

						/* 결의서 시퀀스 반영 ( consSeq ) */
						//$('#consTbl').dzt('setValue', uid, {
						//    consSeq: (consData.consSeq || '').toString()
						//}, false);
					}

					/* 예산내역 테이블 초기화 */
					$('#budgetTbl').dzt('setReset');
				}

				return true;
			},
			/* 데이터 변경 후 콜백 ( commit ) */
			commitCallback : function(uid, key) {
				/* console.error('commitCallback [consTbl]'); */

				/* callback 기초 데이터 */
				var consData = $('#consTbl').dzt('getValue');

				/* 데이터 업데이트 */
				if ((consData.consSeq || '') !== '') {
					if (Option.Common.ERPiU()) {
						/* ERPiU 처리 */
						fnConsUpdate();
					} else if (Option.Common.iCUBE()) {
						/* iCUBE 처리 */
						fnConsUpdate();
					}

					/* 정상처리여부 확인 */
					consData = $('#consTbl').dzt('getValue');
					if ((consData.updateStat || '') !== 'SUCCESS') {
						if ((consData.updateMsg || '') !== '') {
							alert(consData.updateMsg);
						}
					}
				}

				/* 품의일자 검증 진행 */
				if( Option.Common.iCUBE() && ( key == 'consDate' )){
					var date = consData.consDate.replace(/-/gi, '');
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
								, baseDate : date 
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
									
									var uid = $('#consTbl').dzt('getUID');
									$('#consTbl').dzt('setValue', uid, tempData, false);
									
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

				return true;
			},
			/* 테이블 컬럼 정보 */
			columns : consColumns
		});

		return;
	}

	function fnBudgetTableInit() {
		/* ## init - 품의서 테이블 정의 ## */
		var budgetColumns = (budgetGrid.columns || []);

		$('#budgetTbl').dzt({
			/* 테이블 컬럼 제목 */
			title : Option.Common.GetArray(budgetColumns, 'title', ''),
			/* 테이블 컬럼 표시 */
			display : Option.Common.GetArray(budgetColumns, 'display', NO),
			/* 테이블 컬럼 너비 */
			width : Option.Common.GetArray(budgetColumns, 'width', ''),
			/* 테이블 컬럼 필수 입력 */
			req : Option.Common.GetArray(budgetColumns, 'req', NO),
			/* 테이블 기본 높이 지정 */
			height : '135px',
			/* 데이터 변경 시 콜백 ( edit ) */
			changeCallback : function(uid, key) {
				/* console.error('changeCallback [consTbl]'); */

				/* 품의내역 input 제거 */
				if ($('#consTbl').dzt('getValueAll').length > 0) {
					$('#consTbl').dzt('setCommit', false); /* 그리드 input 제거 */
					$('#consTbl').dzt('setColRemoveSelect'); /* colOn 제거 */
					$('#consTooltip').html(''); /* 툴팁제거 */
					$('#spanConsTooltip').html(''); /* 툴팁제거 */
				}
				
				var budgetData = $('#budgetTbl').dzt('getValue');
				
				if('itemAmt'==key){
					if(!!budgetData.consDocSeq && !!budgetData.consSeq && !!budgetData.budgetSeq){
						fnEventItemSpecPop();	
					}
					else{
						alert("예산정보를 입력해주세요");	
					}
					return false;
				}

				var uid = $('#budgetTbl').dzt('getUID');
				$('#budgetTbl').dzt('setValue', uid, {'uid':uid}, false);

				
				/* 예산체크 */
				Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);

				return true;
			},
			/* 데이터 변경 후 콜백 ( commit ) */
			commitCallback : function(uid, key) {
				/* console.error('commitCallback [budgetTbl]'); */

				/* callback 기초 데이터 */
				var budgetData = $('#budgetTbl').dzt('getValue');

				/* 데이터 업데이트 */
				if ((budgetData.consSeq || '') !== '' && (budgetData.budgetSeq || '') !== '') {
					if (Option.Common.ERPiU()) {
						/* ERPiU 처리 */
						fnBudgetUpdate();
					} else if (Option.Common.iCUBE()) {
						/* iCUBE 처리 */
						fnBudgetUpdate();
					}

					/* 정상처리여부 확인 */
					budgetData = $('#budgetTbl').dzt('getValue');
					if ((budgetData.updateStat || '') !== 'SUCCESS') {
						if ((budgetData.updateMsg || '') !== '') {
							alert(budgetData.updateMsg);
						}
					}
				}
				

				/* 예산체크 */
				Option[Option.Common.GetErpType()].GetBudgetAmtInfo(key);

				return true;
			},
			/* 테이블 컬럼 정보 */
			columns : budgetColumns
		});

		return;
	}

	function fnConsPopResize() {
		/* ## init - 품의서 팝업 크기 자동 조정 ## */
		var optionHeight = eval(optionSet.formInfo.formHeight);
		var optionWidth = eval(optionSet.formInfo.formWidth);
		if (!optionHeight) {
			optionHeight = screen.height - 200;
		}
		if (!optionWidth) {
			optionWidth = screen.width - 400;
		}
		$('.pop_wrap').css("overflow", "auto");
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		var divHeight = optionHeight;

		if (isFirefox) {
			divHeight -= 79;
		}
		if (isIE) {
			divHeight -= 70;
		}
		if (isEdge) {
			divHeight -= 70;
		}
		if (isChrome) {
			divHeight -= 67;
		}

		try {
			$('.pop_wrap').height(divHeight);
			window.resizeTo(optionWidth, optionHeight);
		} catch (exception) {
			console.error('   [ERROR] fail to page resize.');
		}

		try {
			var moveLeft = (screen.width - optionWidth) / 2;
			var moveTop = (screen.height - optionHeight) / 2;
			window.moveTo(moveLeft, moveTop);
		} catch (exception) {
		}

		$(window).resize(function(e, d) {
			fnConsPopWrapResize();
			$('#consTbl').dzt('setResize');
			Option.Common.SetBudgetTblResize();
		});

		fnConsPopWrapResize(); /* 리사이징 최초 1회 자동 수행 */
		Option.Common.SetBudgetTblResize();
		return;
	}

	function fnConsPopWrapResize() {
		/* ## init - pop_wrap 크기조정 ## */
		$('.pop_wrap').height(window.innerHeight - 2);
		return;
	}

	function fnConsDocMake() {

		/* [ parameter ] */
		var parameter = {};
		fnFocusAmtUpdate();

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
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		if (Option.Common.ERPiU()) {
			/* iU원인행위 회계단위 명칭통일 pc -> div */
			parameter.erpDivSeq = (parameter.erpPcSeq || optionSet.erpEmpInfo.erpPcSeq); /* ERP 회계단위 코드 */
			parameter.erpDivName = (parameter.erpPcName || optionSet.erpEmpInfo.erpPcName); /* ERP 회계단위 명칭 */
			parameter.erpPcSeq = optionSet.erpEmpInfo.erpDivSeq;
            parameter.erpPcName = optionSet.erpEmpInfo.erpDivName;
		}

		parameter.outProcessInterfaceId = '${outProcessInterfaceId}';
		parameter.outProcessInterfaceMId = '${outProcessInterfaceMId}';
		parameter.outProcessInterfaceDId = '${outProcessInterfaceDId}';

		/* 품의서 문서 생성 */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsDocInsert.do */
			url : domain + '/ex/np/user/cons/ConsDocInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : consNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			success : function(result) {
				fnAjaxLog(this.url, result);

				/* 품의 정보 저장 */
				var aData = Option.Common.GetResult(result, 'aData');
				optionSet.consDocInfo = aData;
				
				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					if (aData.consDocSeq) {
						consDocSeq = (aData.consDocSeq || '0').toString();
						$('#h1_consDocTitle').html($('#h1_consDocTitle').text() + ' / ' + consDocSeq);
						
						/* 문서 기수 정보 출력 */
						fnShowGisuInfo();	
					}
				} else {
					/* console.error('[/exp/ex/np/user/cons/ConsDocInsert.do] ' + JSON.stringify(data)); */
					alert('품의서 기초정보가 생성되지 않았습니다. 페이지를 새로고침(F5) 진행해 주세요.\r\n지속적으로 알림이 나타날 경우 관리자에게 문의해주세요.');
				}
			},
			error : function(result) {
				console.error(result);
			}
		});
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
	
	/* ## doc - 결의서 문서 정보 조회 */
	function fnConsAllInfo() {
		/* [ parameter ] */
		var parameter = {};

		parameter.consDocSeq = consDocSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsAllinfo.do */
			url : domain + '/ex/np/user/cons/ConsAllinfo.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq(품의문서 시퀀스) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				preDocSeq = result.result.aData.consDocInfo[0].docSeq;
				
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					//if (aData.tradeInfo.length > 0) {
					//    $.each(aData.tradeInfo, function (tradeIdx, tradeItem) {
					//        var resSeq = (tradeItem.resSeq || ''); /* 결의정보 시퀀스 */
					//        var budgetSeq = (tradeItem.budgetSeq || ''); /* 예산내역 시퀀스 */
					//        var tradeSeq = (tradeItem.tradeSeq || ''); /* 결제내역 시퀀스 */
					//        var tradeAmt = (tradeItem.tradeAmt || '').toString().replace(/,/g, ''); /* 금액 */
					//        var tradeStdAmt = (tradeItem.tradeStdAmt || '').toString().replace(/,/g, ''); /* 공급가액 */
					//        var tradeTaxAmt = (tradeItem.tradeTaxAmt || '').toString().replace(/,/g, ''); /* 부가세 */

					//        /* 금액 정보 갱신 */
					//        Option.Common.SetAmtUpdate(resSeq, budgetSeq, tradeSeq, tradeAmt, tradeStdAmt, tradeTaxAmt, '');
					//    });
					//}
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

	/* ## event init ## */
	/* ====================================================================================================================================================== */
	function fnEventInit() {
		/* 즐겨찾기 팝업 */
		$('#btnBringFavorites').click(function() {
			fnEvenBringFavorites();
		});
		
		/* 결재작성 */
		$('#btnApproval').click(function() {
			
			var consData = $('#consTbl').dzt('getValue');
            
            /* 하위사업 필수값 체크 */
			if(GetBottomUseYN() == 'Y' && (consData.bottomSeq||'') == ''){
				alert('하위사업을 입력 해주세요.');
				return;
			}
            if(consData.consNote.length > 79){
                alert('적요는 80자 이내로 작성가능합니다.');
                return;
            }
			$('#consTbl').dzt('setCommit', true);
			$('#budgetTbl').dzt('setCommit', true);

			fnEventApprovalPrevCheck();
			//fnEventApproval();
		});

		/* 품의서 불러오기 */
		$('#btnConsRefer').click(function() {
			alert('기능 준비중입니다.');
			return;
		});

		
		/* 예산 회계딴위 변경 */
		$('#btnErpDivChoice').click(function() {
			if ($('#consTbl').dzt('getValueAll').filter(function(item) {
				return ((item.consSeq || '') != '')
			}).length && Option.Common.iCUBE()) {
				alert('품의 정보가 입력되면 회계단위를 변경할 수 없습니다.');
				return;
			}
			code = 'div';
			param = {
				isBudgetDiv : true
			};
			/* 상배 추가 */
			if (optionSet.conVo.erpTypeCode == "iCUBE") {

			} else if (optionSet.conVo.erpTypeCode == "ERPiU") {
				var nowDate = new Date();
				param.stdDate = nowDate.getFullYear() + ((nowDate.getMonth() + 1) < 10 ? '0' + (nowDate.getMonth() + 1) : (nowDate.getMonth() + 1)) + ((nowDate.getDate()) < 10 ? '0' + (nowDate.getDate()) : (nowDate.getDate()));
				param.pcName = '';
			}
			fnCommonCode_div(code, param);
			return;
		});

		/* 품의정보 초기화 */
		$('#btnConsReset').click(function() {
			var msg = '${CL.ex_deleteRowMessage3}';
			if ((checkDocStatus || "N") == "Y"){
				var msg = '삭제된 내역은 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다.';
			}
			if (confirm(msg)) {
				/* 저장 정보 삭제 */
				var consDataArray = $('#consTbl').dzt('getValueAll');
				$.each(consDataArray, function(idx, item) {
					fnConsDelete((item.consDocSeq || ''), (item.consSeq || ''));
				});

				/* 예산내역 테이블 초기화 */
				$('#budgetTbl').dzt('setReset');

				/* 품의정보 테이블 초기화 */
				$('#consTbl').dzt('setReset');

				/* 기초행 추가 */
				$('#btnConsAdd').click();

				/* 예산금액 초기화 */
				$('#lbErpOpenAmt').html('0');
				$('#lbResApplyAmt').html('0');
				$('#lbConsBalanceAmt').html('0');
				$('#lbBudgetAmt').html('0');
				$('#lbGwBalanceAmt').html('0');
			}

			return;
		});

		/* 품의정보 추가 */
		$('#btnConsAdd').click(function() {

			/* 품의정보 입력 여부 확인 */
			if ($('#consTbl').dzt('getValueAll').length > 0) {
				/* 예산내역 생성 여부 확인 */
				var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
				var budgetSaveCount = $('#budgetTbl').dzt('getValueAll').filter(function(item) {
					return ((item.budgetSeq || '') != '')
				}).length;

				/* 작성중인 행이 존재하고, 저장된 내역이 1건도 없는 경우 */
				/* 작성된 내역이 1건도 없는 경우 ( budgetSaveCount < 1 ) */
				if (budgetSaveCount < 1) {
					alert('${CL.ex_noBudgetDetailMessage}');
					return;
				}
			}

			/* 품의정보 저장 확인 */
			var consDataArray = $('#consTbl').dzt('getValueAll');
			var consSaveCount = $('#consTbl').dzt('getValueAll').filter(function(item) {
				return ((item.consSeq || '') != '')
			}).length;
			if (consDataArray.length === consSaveCount) {
				/* 행 추가 */
				var uid = $('#consTbl').dzt('setAddRow');
				$('#consTbl').dzt('setValue', uid, {
					consDocSeq : consDocSeq
				}, false);

				/* 예산내역 테이블 리셋 */
				$('#budgetTbl').dzt('setReset');

				/* 포커스 지정 */
				$('#consTbl').dzt('setFocus', uid, 'docuFgName');
			} else {
				alert('저장되지 않은 품의정보가 있습니다.');
			}

			Option.Common.SetBudgetTblResize();

			return;
		});

		/* 품의정보 삭제 */
		$('#btnConsDelete').click(function() {
			if ($('#consTbl').find('tr.rowOn').length > 0) {
				var msg = '${CL.ex_deleteRowMessage3}';
				if ((checkDocStatus || "N") == "Y"){
					var msg = '삭제된 행은 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다.';
				}
				if (confirm(msg)) {
					/* 저장 정보 삭제 */
					var consData = $('#consTbl').dzt('getValue');
					fnConsDelete((consData.consDocSeq || ''), (consData.consSeq || ''));

					/* 행이 존재하지 않는 경우 기본 행 추가 */
					if ($('#consTbl').find('tr').length === 1) {
						$('#btnConsAdd').click();
					}

					Option[Option.Common.GetErpType()].GetBudgetAmtInfo();
				}
			} else {
				alert('${CL.ex_deleteRowMessage2}');
			}

			return;
		});

		/* 예산내역 추가 */
		$('#btnBudgetAdd').click(function() {
			var consData = $('#consTbl').dzt('getValue');
			/* 품의정보 저장 확인 */
			if (Option.Common.ERPiU()) {
				if(!consData.consDate && !consData.erpMgtSeq){
					alert('품의정보가 입력되지 않았습니다.');
					return;
				}
				if(!consData.consSeq){
					fnConsInsert();
				}
			}
			else{
				if(!consData.consDate){
					alert('품의정보가 입력되지 않았습니다.');
					return;
				}
                if(!consData.erpMgtSeq){
                    alert('프로젝트코드가 입력되지 않았습니다. 코드도움창을 통해 입력해주세요.');
                    return;
                }
                if((optionSet.gw[1][11]||{'setValue':'1'}).setValue == '0' && (consData.consNote || '') === ''){
                    alert('적요가 입력되지 않았습니다.');
                    return;
                }
				if(!consData.consSeq){
					fnConsInsert();
				}
			}
			
			/* 예산내역 생성 여부 확인 */
			var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
			var budgetSaveCount = $('#budgetTbl').dzt('getValueAll').filter(function(item) {
				return ((item.budgetSeq || '') != '')
			}).length;

			if (budgetDataArray.length !== budgetSaveCount) {
				alert('${CL.ex_noBudgetDetailMessage}');
				return;
			}

			/* 신규 행 생성 */
			
			var uid = $('#budgetTbl').dzt('setAddRow');
			$('#budgetTbl').dzt('setValue', uid, {
				consDocSeq : (consData.consDocSeq || ''),
				consSeq : (consData.consSeq || '')
			}, false);
			
			var defaultData = {
				budgetNote : $('#consTbl').dzt('getValue').consNote
			};
			
			if (Option.Common.iCUBE()) {
				defaultData.erpDivSeq = ($('#lbErpDivName').attr('seq') || '');
				defaultData.erpDivName = ($('#lbErpDivName').val() || '');
			}
			
			/* 기본값 설정 ( resDocSeq ) */
			$('#budgetTbl').dzt('setValue', uid, defaultData, false);
			
			/* 포커스 지정 */
			$('#budgetTbl').dzt('setFocus', uid, 'erpBudgetName');

			return;
		});

		/* 예산내역 삭제 */
		$('#btnBudgetDelete').click(function() {

			if ($('#budgetTbl').find('tr.rowOn').length > 0) {
				var msg = '${CL.ex_deleteRowMessage3}';
				if ((checkDocStatus || "N") == "Y"){
					var msg = '삭제된 행은 복구할 수 없으며 임시저장 문서의 회계데이터도 삭제됩니다.';
				}
				if (confirm(msg)) {
					/* 저장 정보 삭제 */
					var budgetData = $('#budgetTbl').dzt('getValue');
					fnBudgetDelete((budgetData.consDocSeq || ''), (budgetData.consSeq || ''), (budgetData.budgetSeq || ''));

					/* 행 삭제 */
	//				var tr = $('#budgetTbl').dzt('getSelectedRow');
	//				$('#budgetTbl').dzt('setRemoveRow', $(tr));

					/* 행이 존재하지 않는 경우 기본 행 추가 */
					if ($('#budgetTbl').find('tr').length === 1) {
						$('#btnBudgetAdd').click();
					}

					Option[Option.Common.GetErpType()].GetBudgetAmtInfo();
				}
			} else {
				alert('${CL.ex_deleteRowMessage2}');
			}

			return;
		});

		return;
	}
	
	/* 예산 회계단위 조회 콜백 */
	function fnCopyInterlock() {
		$.ajax({
			type : 'post',
			url : domain + '/expend/np/user/cons/CopyInterlock.do',
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

	/* ## 결재작성 ## */
	/* 결재 작성 사전체크 진행	*/
	/* ====================================================================================================================================================== */
	function fnEventApprovalPrevCheck() {
		/* [ parameter ] */
		var parameter = {};

		parameter.consDocSeq = consDocSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/res/ResDocAllinfo.do */
			url : domain + '/ex/np/user/cons/ConsAllinfo.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq(결의문서 시퀀스) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				preDocSeq = result.result.aData.consDocInfo[0].docSeq;
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					var docInfo = aData.consDocInfo;
					var headInfo = aData.consHeadInfo;
					var budgetInfo = aData.budgetInfo;

					var headValue  = $('#consTbl').dzt('getValueAll');
					var budgetValue  = $('#budgetTbl').dzt('getValueAll');				
					
					if(docInfo[0].compSeq!=aData.loginCompInfo){
						alert('작성 도중 회사 정보가 변경되어 재작성이 필요합니다.');
						return;
					}
					
					/* Step 1. 입력 누락 확인 [간단] */
					var inputValidationChecker = docInfo.length * headInfo.length * budgetInfo.length;
					if (!inputValidationChecker) {
						alert('${CL.ex_dataCheckMessage}');
						return;
					}

					/* if(Option.Common.ERPiU()){
						for(var i=0; i<budgetValue.length ;i++){
							if(budgetValue[i].budgetSeq == '' && budgetValue[i].erpBudgetSeq && budgetValue[i].erpBgacctName && budgetValue[i].budgetAmt){
								$('#budgetTbl').dzt('setFocus', budgetValue[i].uid, 'erpBudgetName');
								fnBudgetInsert();
							}
							else if(budgetValue[i].budgetSeq == ''){
								$('#budgetTbl').dzt('setFocus', budgetValue[i].uid, 'erpBudgetName');
								alert("데이터 입력을 확인하세요");
								return;
							}
						}	
					}
					else{
						for(var i=0; i<budgetValue.length ;i++){
							if(budgetValue[i].budgetSeq == '' && budgetValue[i].erpBudgetSeq && budgetValue[i].erpDivSeq && budgetValue[i].budgetAmt){
								$('#budgetTbl').dzt('setFocus', budgetValue[i].uid, 'erpBudgetName');
								fnBudgetInsert();
							}
							else if(budgetValue[i].budgetSeq == ''){
								$('#budgetTbl').dzt('setFocus', budgetValue[i].uid, 'erpBudgetName');
								alert("데이터 입력을 확인하세요");
								return;
							}
						}	
					} */
					
					
					
										
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

	/* ## 결재작성 ## */
	/* ====================================================================================================================================================== */
	function fnEventApproval() {

		/* [ parameter ] */
		var parameter = {};

		parameter.processId = optionSet.formInfo.formDTp;
		parameter.approKey = optionSet.formInfo.formDTp + '_NP_' + consDocSeq;
		parameter.consDocSeq = consDocSeq;
		parameter.interlockName = "정보수정";
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
		parameter.formType = "CONS";
		if(optionSet.conVo.erpTypeCode=='ERPiU'){
			parameter.gisuFromDate = optionSet.erpGisu.gisuFromDate;
			parameter.gisuToDate = optionSet.erpGisu.gisuToDate;
		}
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/interlock/ExDocMake.do */
			url : domain + '/ex/np/user/cons/interlock/ExDocMake.do',
			datatype : 'json',
			async : false,
			/*   - data : consNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : parameter,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
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
				// url += '/edoc/eapproval/docCommonDrafWrite.do';
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
			alert("브라우져 팝업차단 설정을 확인해 주세요");
		} else {
			self.close();
		}
	}

	/* ## 품의정보 ## */
	/* ====================================================================================================================================================== */
	/* ## 품의정보 - 생성 ## */
	function fnConsInsert() {
		
		/* [ parameter ] */
		var parameter = {};
		fnFocusAmtUpdate();
		
		parameter.erpDivSeq = '';
		parameter.erpDivName = '';
		parameter.erpGisu = '';
		parameter.erpMgtName = '';
		parameter.erpMgtSeq = '';
		parameter.consDate = '';
		parameter.causeDate = '';
		parameter.inspectDate = '';
		parameter.signDate = '';
		parameter.pjtToDate = '';
		parameter.pjtFromDate = '';
		parameter.gisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '0');
		parameter.erpGisuFromDate = (Option.Common.iCUBE() ? optionSet.erpGisu.fromDate : '');
		parameter.erpGisuToDate = (Option.Common.iCUBE() ? optionSet.erpGisu.toDate : '');
		parameter.erpYear = ((parameter.consDate || '').length >= 4 ? parameter.consDate.substring(0, 4) : '')

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */
		
		var consData = $('#consTbl').dzt('getValue');
		/* 품의 정보 데이터 보정 */
		if(consData.consDate.replace(/[0-9]/g, '') == '--'){
			var year = parseInt(consData.consDate.split('-')[0] || '1' ) ;
			var month = parseInt(consData.consDate.split('-')[1] || '1' ) ;
			var day = parseInt(consData.consDate.split('-')[2] || '1' ) ;
			year = year < 10 ? '0' + year : '' + year;
			month = month < 10 ? '0' + month : '' + month;
			day = day < 10 ? '0' + day : '' + day;
			consData.consDate = year + '-' + month + '-' + day;
		}
		parameter = JSON.parse(JSON.stringify($.extend(parameter, consData))); /* 작성중인 품의 정보 */

        if(parameter.consNote.length > 79){
            alert('적요는 80자 이내로 작성가능합니다.');
            return;
        }
		if (Option.Common.ERPiU()) {
			parameter.erpPcSeq = optionSet.erpEmpInfo.erpDivSeq || optionSet.erpEmpInfo.erpPcSeq;
			parameter.erpPcName = optionSet.erpEmpInfo.erpDivName || optionSet.erpEmpInfo.erpPcName;
			parameter.erpDivSeq = optionSet.erpEmpInfo.erpDivSeq||''; /* ERP 사업장 명칭 */
			parameter.erpDivName = optionSet.erpEmpInfo.erpDivName||''; /* ERP 사업장 명칭 */
			parameter.expendDate = parameter.resDate;
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsHeadInsert.do */
			url : domain + '/ex/np/user/cons/ConsHeadInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : - */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 결의서 시퀀스 반영 ( consSeq ) */
					$('#consTbl').dzt('setValue', $('#consTbl').dzt('getUID'), {
						consSeq : (aData.consSeq || '').toString(),
						insertStat : resultCode,
						insertMsg : ''
					}, false);
				}  else if(resultCode == 'GISU_CLOSE'){
					alert('기수 마감되어 품의서를 입력할 수 없습니다.');
				} else {
					$('#consTbl').dzt('setValue', $('#consTbl').dzt('getUID'), {
						consSeq : '',
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

		return;
	}

	/* ## 품의정보 - 수정 ## */
	function fnConsUpdate() {

		/* [ parameter ] */
		var parameter = {};
		fnFocusAmtUpdate();

		parameter.erpDivSeq = '';
		parameter.erpDivName = '';
		parameter.erpGisu = '';
		parameter.erpMgtName = '';
		parameter.erpMgtSeq = '';
		parameter.consDate = '';
		parameter.causeDate = '';
		parameter.inspectDate = '';
		parameter.signDate = '';
		parameter.pjtToDate = '';
		parameter.pjtFromDate = '';
		parameter.gisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '');
		parameter.erpGisuFromDate = (Option.Common.iCUBE() ? optionSet.erpGisu.fromDate : '');
		parameter.erpGisuToDate = (Option.Common.iCUBE() ? optionSet.erpGisu.toDate : '');
		parameter.erpYear = ((parameter.consDate || '').length >= 4 ? parameter.consDate.substring(0, 4) : '')

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var consData = $('#consTbl').dzt('getValue');
		/* 품의 정보 데이터 보정 */
		if(consData.consDate.replace(/[0-9]/g, '') == '--'){
			var year = parseInt(consData.consDate.split('-')[0] || '1' ) ;
			var month = parseInt(consData.consDate.split('-')[1] || '1' ) ;
			var day = parseInt(consData.consDate.split('-')[2] || '1' ) ;
			year = year < 10 ? '0' + year : '' + year;
			month = month < 10 ? '0' + month : '' + month;
			day = day < 10 ? '0' + day : '' + day;
			consData.consDate = year + '-' + month + '-' + day;
		}
		parameter = JSON.parse(JSON.stringify($.extend(parameter, consData))); /* 작성중인 품의 정보 */

		if (Option.Common.ERPiU()) {
			parameter.expendDate = parameter.resDate;
			parameter.erpDivSeq = parameter.erpPcSeq;
			parameter.erpDivName = parameter.erpPcName;
		}
		
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsHeadInsert.do */
			url : domain + '/ex/np/user/cons/ConsHeadUpdate.do',
			datatype : 'json',
			async : false,
			/*   - data : - */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 결의서 시퀀스 반영 ( consSeq ) */
					$('#consTbl').dzt('setValue', $('#consTbl').dzt('getUID'), {
						updateStat : resultCode,
						updateMsg : ''
					}, false);
				} else {
					$('#consTbl').dzt('setValue', $('#consTbl').dzt('getUID'), {
						updateStat : resultCode,
						updateMsg : ''
					}, false);
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}

	/* ## res (품의정보) - 조회 ## */
	function fnConsSelect() {
		/* [ parameter ] */
		var parameter = {};

		if ('${param.newConsDocSeq}' != '') {
			parameter.consDocSeq = '${param.newConsDocSeq}';
		} else {
			parameter.consDocSeq = consDocSeq; /* 품의문서 시퀀스 */
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsHeadList.do */
			url : domain + '/ex/np/user/cons/ConsHeadList.do',
			datatype : 'json',
			async : false,
			/*   - data : consDocSeq ( 품의문서 시퀀스 ), consSeq ( 품의정보 시퀀스 - 선택 ) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aaData = Option.Common.GetResult(result, 'aaData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* erpDivSeq 저장된 정보 우선 적용 */
					if ((!(!aaData[0])) && aaData[0].erpDivSeq) {
						$('#lbErpDivName').val(aaData[0].erpDivName);
						$('#lbErpDivName').attr('seq', aaData[0].erpDivSeq);

						optionSet.erpEmpInfo.erpDivName = aaData[0].erpDivName;
						optionSet.erpEmpInfo.erpDivSeq = aaData[0].erpDivSeq;
					}

					$.each(aaData, function(consIdx, consItem) {
						/* 물품명세액 포맷 수정 */
						consItem.itemAmt = consItem.itemAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						/* 품의 정보 데이터 보정 */
							var year = consItem.consDate.substr(0,4);
							var month = consItem.consDate.substr(4,2);
							var day = consItem.consDate.substr(6,2);
							consItem.consDate = year + '-' + month + '-' + day;
						
						/* 품의정보 반영 */
						$('#consTbl').dzt('setValue', $('#consTbl').dzt('setAddRow'), consItem, false);
						/* 품의정보 마지막 행 선택 */
						$('#consTbl').dzt('setDefaultFocus', 'LAST');	
						/* 금액 정보 업데이트 */
						fnFocusAmtUpdate();
					});
					
					$('#budgetTbl').dzt('setDefaultFocus', 'LAST'); /* 예산내역 마지막 행 포커스 지정 */
					
				} else {
					alert('저장된 정보 조회중 오류가 발생되었습니다.');
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

	/* ## 품의정보 - 삭제 ## */
	function fnConsDelete(consDocSeq, consSeq) {
		/* [ parameter ] */
		/*   - consDocSeq : 조회 대상 품의문서 키 */
		consDocSeq = (consDocSeq || '');
		/*   - consSeq : 조회 대상 품의서 키 */
		consSeq = (consSeq || '');

		if (consDocSeq === '' || consSeq === '') {
			console.error('fnConsDelete - not exists ( consDocSeq, consSeq )');
			return;
		}

		/* [ ajax parameter ] */
		var parameter = {};
		parameter.consDocSeq = consDocSeq;
		parameter.consSeq = consSeq;
		
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsHeadDelete.do */
			url : domain + '/ex/np/user/cons/ConsHeadDelete.do',
			datatype : 'json',
			async : false,
			/*   - data : - */
			data : Option.Common.GetSaveParam(parameter),
			consDocSeq : parameter.consDocSeq,
			consSeq : parameter.consSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					var consDataArray = $('#consTbl').dzt('getValueAll');
					var consDocSeq = this.consDocSeq;
					var consSeq = this.consSeq;

					/* 화면상의 결의정보를 삭제한다. */
					$.each(consDataArray, function(consIdx, cons) {
						if (cons.consDocSeq === consDocSeq && cons.consSeq === consSeq) {
							$('#consTbl').dzt('setRemoveRow', $('#consTbl div.rightContents table tr:eq(' + consIdx + ')'));
							return false;
						}
					});

					/* 예산내역은 서버에서 일괄로 삭제되므로, 화면상에서 삭제를 동시에 진행한다. */
					$.each($('#budgetTbl div.rightContents table tr'), function(tradeIdx, trade) {
						$('#tradeTbl').dzt('setRemoveRow', $(trade));
					});

					Option.Common.SetAmtUpdate(this.consSeq, 0, 0, 'delete');
					fnFocusAmtUpdate();
				} else {
					alert('삭제 중 오류가 발생되었습니다.');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}

	/* ## 예산내역 ## */
	/* ====================================================================================================================================================== */
	/* ## 예산내역 - 생성 ## */
	function fnBudgetInsert() {
		/* [ parameter ] */
		var parameter = {};

		parameter.budgetAmt = '0';
		parameter.erpMgtSeq = '';
		parameter.expendDate = '';
		parameter.erpBottomSeq = '';
		parameter.erpGisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '');
		parameter.gisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '');
		parameter.erpGisuFromDate = (Option.Common.iCUBE() ? optionSet.erpGisu.fromDate : '');
		parameter.erpGisuToDate = (Option.Common.iCUBE() ? optionSet.erpGisu.toDate : '');

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var budgetData = $('#budgetTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 */

		var consData = $('#consTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, consData))); /* 작성중인 품의정보 */
		
		parameter.expendDate = (parameter.consDate || '').toString().replace(/-/g, '');
		parameter.erpDivSeq = budgetData.erpDivSeq;
		parameter.erpDivName = budgetData.erpDivName;

		/* 예산 회계단위 조정 */
		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = ''; 
			parameter.erpDivName = ''; 
			if((!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0'))){
				parameter.erpBizplanSeq = ''
			}
		} else if (Option.Common.iCUBE()) {
			parameter.erpBudgetDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpBudgetDivName = $('#lbErpDivName').text();
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
			if (optionSet.erpEmpInfo.vatControl == '1'){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'I_IN_TAX_Y';
			}else {
				parameter.ctlFgCode = '0';
				parameter.ctlFgName = 'I_IN_TAX_N';
			}
		}

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsBudgetInsert.do */
			url : domain + '/ex/np/user/cons/ConsBudgetInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : - */
			data : Option.Common.GetSaveParam(parameter),
			extendParam : {
				consSeq : parameter.consSeq,
				budgetSeq : parameter.budgetSeq,
				budgetAmt : parameter.budgetAmt
			},
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 결의서 시퀀스 반영 ( budgetSeq ) */
					$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
						budgetSeq : (aData.budgetSeq || '').toString(),
						insertStat : resultCode,
						insertMsg : ''
					}, false);

					/* 금회집행 금액 변경 */
					/* $('#lbBudgetAmt').html(Option.Common.GetNumeric((aData.tryAmt || '0'))); */
					fnSetBudgetDisplay();

					/* 총 금액 갱신 */
					Option.Common.SetAmtUpdate(this.extendParam.consSeq, aData.budgetSeq, this.extendParam.budgetAmt);
				} else {
					if (resultCode === 'EXCEED') {
						$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
							budgetSeq : '',
							insertStat : resultCode,
							insertMsg : '${CL.ex_exceedMesage}'
						}, false);
					} else {
						$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
							budgetSeq : '',
							insertStat : resultCode,
							insertMsg : '예산내역 생성중 오류가 확인되었습니다.'
						}, false);
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

	/* ## 예산내역 - 조회 ## */
	function fnBudgetSelect(consDocSeq, consSeq, budgetSeq) {
		/* [ parameter ] */
		/*   - consDocSeq : 조회 대상 품의문서 키 */
		consDocSeq = (consDocSeq || '');
		/*   - consSeq : 조회 대상 품의서 키 */
		consSeq = (consSeq || '');
		/*   - budgetSeq : 조회 대상 예산 키 */
		budgetSeq = (budgetSeq || '');

		if (consDocSeq === '' || consSeq === '') {
			console.error('fnBudgetSelect - not exists ( consDocSeq, consSeq )');
			return;
		}

		/* [ ajax parameter ] */
		var parameter = {};
		parameter.consDocSeq = consDocSeq;
		parameter.consSeq = consSeq;
		parameter.budgetSeq = budgetSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsBudgetList.do */
			url : domain + '/ex/np/user/cons/ConsBudgetList.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, budgetSeq */
			data : Option.Common.GetSaveParam(parameter),
			consDocSeq : consDocSeq,
			consSeq : consSeq,
			budgetSeq : budgetSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aaData = Option.Common.GetResult(result, 'aaData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					$('#budgetTbl').dzt('setReset');

					$.each(aaData, function(idx, item) {
						var uid = $('#budgetTbl').dzt('setAddRow')
						$('#budgetTbl').dzt('setValue', uid, item, false);
					});

					/* 행이 존재하지 않는 경우 기본 행 추가 */
					if (aaData.length < 1) {
						$('#btnBudgetAdd').click();
					}
				} else {
					alert('예산내역을 조회하던 중 오류가 발생되었습니다.');
				}
				
				/* 기수정보 재출력 */
				fnShowGisuInfo();
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		/* [ return ] */
		return;
	}

	/* ## 예산내역 - 수정 ## */
	function fnBudgetUpdate() {
		if (resetBudgetSize > 1){
			resetBudgetSize = resetBudgetSize - 1;
			return;
		}
		
		/* [ parameter ] */
		var parameter = {};
		fnFocusAmtUpdate();

		parameter.budgetAmt = '0';
		parameter.erpMgtSeq = '';
		parameter.expendDate = '';
		parameter.erpBottomSeq = '';
		parameter.erpGisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '');
		parameter.gisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '');
		parameter.erpGisuFromDate = (Option.Common.iCUBE() ? optionSet.erpGisu.fromDate : '');
		parameter.erpGisuToDate = (Option.Common.iCUBE() ? optionSet.erpGisu.toDate : '');

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		var budgetData = $('#budgetTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 */
		
		var consData = $('#consTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, consData))); /* 작성중인 품의정보 */

		parameter.expendDate = (parameter.consDate || '').toString().replace(/-/g, '');
		parameter.erpDivSeq = budgetData.erpDivSeq;
		parameter.erpDivName = budgetData.erpDivName;
		
		/* 예산 회계단위 조정 */
		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = ''; /* ERP 사업장 명칭 */
			parameter.erpDivName = ''; /* ERP 사업장 명칭 */
			if(fnGetUseBizplanERPiU()!='Y'){
				parameter.erpBizplanSeq = '';
				parameter.erpBizplanName = '';
			}
			
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
			if (optionSet.erpEmpInfo.vatControl == '1'){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'I_IN_TAX_Y';
			}else {
				parameter.ctlFgCode = '0';
				parameter.ctlFgName = 'I_IN_TAX_N';
			}
		}
		
		parameter = fnBudgetDataCurrection(parameter);
		
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsBudgetUpdate.do */
			url : domain + '/ex/np/user/cons/ConsBudgetUpdate.do',
			datatype : 'json',
			async : false,
			/*   - data : - */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 결의서 시퀀스 반영 ( budgetSeq ) */
					$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
						updateStat : resultCode,
						updateMsg : ''
					}, false);

					/* 금회집행 금액 변경 */
					/* $('#lbBudgetAmt').html(Option.Common.GetNumeric((aData.tryAmt || '0'))); */
					var budgetRefresh = [ 'erpBudgetName', 'erpBizplanName', 'erpBgacctName', 'erpMgtName', 'erpBudgetName', 'tradeAmt', 'tradeStdAmt', 'tradeVatAmt' ];

					// TODO : this.extendParam가 undefined인 경우가 있음.
					if ((!this.extendParam) || budgetRefresh.indexOf(this.extendParam.key) > -1) {
						fnSetBudgetDisplay();
					}
				} else {
					if (resultCode === 'EXCEED') {
						$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
							updateStat : resultCode,
							updateMsg : '${CL.ex_exceedMesage}'
						}, false);
					} else {
						$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), {
							updateStat : resultCode,
							updateMsg : '예산내역 생성중 오류가 확인되었습니다.'
						}, false);
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

	/* ## 예산내역 - 삭제 ## */
	function fnBudgetDelete(consDocSeq, consSeq, budgetSeq) {
		/* [ parameter ] */
		/*   - consDocSeq : 조회 대상 품의문서 키 */
		consDocSeq = (consDocSeq || '');
		/*   - consSeq : 조회 대상 품의서 키 */
		consSeq = (consSeq || '');
		/*   - budgetSeq : 조회 대상 예산 키 */
		budgetSeq = (budgetSeq || '');

		if (consDocSeq === '' || consSeq === '' || budgetSeq === '') {
			console.error('fnBudgetSelect - not exists ( consDocSeq, consSeq, budgetSeq )');
			return;
		}

		/* [ ajax parameter ] */
		var parameter = {};
		parameter.consDocSeq = consDocSeq;
		parameter.consSeq = consSeq;
		parameter.budgetSeq = budgetSeq;
		
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/ConsBudgetDelete.do */
			url : domain + '/ex/np/user/cons/ConsBudgetDelete.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, budgetSeq */
			data : Option.Common.GetSaveParam(parameter),
			consDocSeq : consDocSeq,
			consSeq : consSeq,
			budgetSeq : budgetSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					var budgetDataArray = $('#budgetTbl').dzt('getValueAll');
					
					/* 화면상의 예산내역을 삭제한다. */
					$.each(budgetDataArray, function(budgetIdx, budget) {
						if (budget.consDocSeq === consDocSeq && budget.consSeq === consSeq && budget.budgetSeq === budgetSeq) {
							$('#budgetTbl').dzt('setRemoveRow', $('#budgetTbl div.rightContents table tr:eq(' + budgetIdx + ')'));
							return false;
						}
					});
					
					$('#lbBudgetAmt').html(Option.Common.GetNumeric((aData.tryAmt || '0')));
					
					/* Layer 강제 삭제 */
					$('#budgetTblAutoComplete').hide();
					
					Option.Common.SetAmtUpdate(this.consSeq, this.budgetSeq, 0, 'delete');
					
					fnFocusAmtUpdate();
					
					// 기본행 선택
					if($('#budgetTbl').dzt('getValueAll').length > 0) {
						$('#budgetTbl').dzt('setDefaultFocusKey', 'FIRST', 'budgetNote');
					}
					
				} else {
					alert('예산내역을 삭제 중 오류가 발생되었습니다.');
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}

	/* ## 필수 입력 점검 ## */
	/* ====================================================================================================================================================== */
	/* ## 필수 입력 점검 - 품의정보 ## */
	function fnConsChkValue(chkType) {

		chkType = (typeof chkType === 'undefined' ? true : chkType);

		/* 반환 변수 정의 */
		var resultValue = {
			/* 필수값 점검 결과 [true, false] */
			sts : false,
			key : '',
			msg : ''
		};

		var consData = $('#consTbl').dzt('getValue');

		if (Option.Common.iCUBE() && ((consData.docuFgName || '') === '' || (consData.docuFgCode || '') === '')) {
			/* iCUBE - 품의구분 */
			resultValue.sts = false;
			resultValue.key = 'docuFgName';
			resultValue.msg = '품의구분이 선택되지 않았습니다.';
		} else if (Option.Common.ERPiU() && ((consData.docuFgName || '') === '' || (consData.docuFgCode || '') === '')) {
			/* ERPiU - 품의구분 */
			resultValue.sts = false;
			resultValue.key = 'docuFgName';
			resultValue.msg = '품의구분이 선택되지 않았습니다.';
		} else if (Option.Common.iCUBE() && (consData.consDate || '') === '') {
			/* iCUBE - 품의일자 */
			resultValue.sts = false;
			resultValue.key = 'consDate';
			resultValue.msg = '품의일자가 입력되지 않았습니다.';
		} else if (Option.Common.ERPiU() && (consData.consDate || '') === '') {
			/* ERPiU - 품의일자 */
			resultValue.sts = false;
			resultValue.key = 'consDate';
			resultValue.msg = '품의일자가 입력되지 않았습니다.';
		} else if (Option.Common.iCUBE() && ((consData.erpMgtName || '') === '' || (consData.erpMgtSeq || '') === '')) {
			/* iCUBE - 프로젝트(부서) */
			resultValue.sts = false;
			resultValue.key = 'erpMgtName';
			resultValue.msg = '프로젝트코드가 입력되지 않았습니다. 코드도움창을 통해 입력해주세요.';
		} else if (Option.Common.iCUBE() && (optionSet.gw[1][11]||{'setValue':'1'}).setValue == '0' && (consData.consNote || '') === '') {
            /* iCUBE - 품의정보 적요 */
            resultValue.sts = false;
            resultValue.key = 'consNote';
            resultValue.msg = '적요가 입력되지 않았습니다.';
        } else {
			/* 조건 만족 */
			resultValue.sts = true;
		}

		return resultValue;
	}

	/* ## 필수 입력 점검 - 예산내역 ## */
	function fnBudgetChkValue(chkType) {

		chkType = (typeof chkType === 'undefined' ? true : chkType);

		/* 반환 변수 정의 */
		var resultValue = {
			/* 필수값 점검 결과 [true, false] */
			sts : false,
			key : '',
			msg : ''
		};
		var budgetData = $('#budgetTbl').dzt('getValue');

		if (Option.Common.iCUBE() && ((budgetData.erpBudgetSeq || '') === '' || (budgetData.erpBudgetName || '') === '')) {
			/* iCUBE - 예산과목 */
			resultValue.sts = false;
			resultValue.key = 'erpBudgetName';
			resultValue.msg = '${CL.ex_noBudgetItemMessage}'
		} else if (Option.Common.ERPiU() && ((budgetData.erpBudgetSeq || '') === '' || (budgetData.erpBudgetName || '') === '')) {
			/* ERPiU - 예산과목 */
			resultValue.sts = false;
			resultValue.key = 'erpBudgetName';
			resultValue.msg = '예산단위가 입력되지 않았습니다.'
		} else if (fnGetUseBizplanERPiU() === 'Y' && ((budgetData.erpBizplanSeq || '') === '' || (budgetData.erpBizplanName || '') === '')) {
			/* ERPiU - 사업계획 */
			resultValue.sts = false;
			resultValue.key = 'erpBizplanName';
			resultValue.msg = '사업계획이 입력되지 않았습니다.'
		} else if (Option.Common.ERPiU() && ((budgetData.erpBgacctSeq || '') === '' || (budgetData.erpBgacctName || '') === '')) {
			/* ERPiU - 예산계정 */
			resultValue.sts = false;
			resultValue.key = 'erpBgacctName';
			resultValue.msg = '예산계정이 입력되지 않았습니다.'
		} else if (Option.Common.iCUBE() && ((budgetData.erpDivSeq || '') === '' || (budgetData.erpDivName) === '')) {
			/* iCUBE - 회계단위 */
			resultValue.sts = false;
			resultValue.key = 'erpDivName';
			resultValue.msg = '${CL.ex_noAccountingUnitMessage}'
		} else if (Option.Common.iCUBE() && (budgetData.budgetAmt || '') === '') {
			/* iCUBE - 금액 */
			resultValue.sts = false;
			resultValue.key = 'budgetAmt';
			resultValue.msg = '금액이 입력되지 않았습니다.'
		} else {
			/* 조건 만족 */
			resultValue.sts = true;
		}

		return resultValue;
	}

	/* ## 공통코드 ## */
	/* ====================================================================================================================================================== */
	function fnCommonCode(code, keyName, searchStr, consData, budgetData) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - keyName : 사용자 입력 키이름 ( F2 와 Enter 의 동작 이벤트가 다르므로 별도 처리 ) */
		keyName = (keyName || '');
		/*   - searchStr : 사용자 입력 검색어 ( Enter 입력시에만 사용 ) */
		searchStr = (searchStr || '');
		/*   - consData : 현재 수정 진행중인 품의정보 행의 정보 */
		consData = (consData || {});
		/*   - budgetData : 현재 수정 진행중이 예산내역 행의 정보 */
		budgetData = (budgetData || {});

		/* 파라미터 정의 */
		var param = {};
		/* ERP 사용자 정보 저장 */
		consData = JSON.parse(JSON.stringify($.extend(consData, Option.Common.GetErpEmpInfo())));
		/* GW 사용자 정보 저장 */
		consData = JSON.parse(JSON.stringify($.extend(consData, Option.Common.GetGwEmpInfo())));
		/* ERP 기수 정보 저장 */
		consData = JSON.parse(JSON.stringify($.extend(consData, Option.Common.GetErpGisuInfo())));
		/* searchStr 파라미터 추가 정의 ( searchStr은 무조건 consData에서 추출 사용 ) */
		param.searchStr = (keyName === 'Enter' ? searchStr : '');
		/* 결의정보 */
		param = JSON.parse(JSON.stringify($.extend(param, consData)));
		/* 예산내역 */
		param = JSON.parse(JSON.stringify($.extend(param, budgetData)));

		/* 공통코드 함수 호출 */
		if (window['fnCommonCode_' + code] && typeof window['fnCommonCode_' + code] === 'function') {
			/* 공통코드 기본 설정 */

			/* 공통코드 전용 함수 수행 */
			window['fnCommonCode_' + code](code, param);
		} else {
			console.error('정의되지 않은 공통코드입니다. ( ' + code + ' / fnCommonCode_' + code + ' )');
		}
	}

	/* ## 공통코드 - 프로젝트 ============================== ## */
	function fnCommonCode_project(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_project_callback';
		
		/* 팝업 호출 */
		// fnCommonCodePop(code, param, param.callback);
		if(!GetErpMgtIsProject()){
			/* 프로젝트 통제 팝업 호출 */
			/* 팝업 호출 */
			fnCommonCodePop('dept', param, param.callback);
		}else if(GetErpMgtIsProject()){
			/* 프로젝트 통제 팝업 호출 */
			/* 팝업 호출 */
			fnCommonCodePop('project', param, param.callback);	 
		}
		return;
	}

	function fnCommonCode_project_callback(param) {
		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */

		/* iCUBE example : {"progFg":"1","itBusinessLink":0,"pjtToDate":"2018-12-31","atTrName":"상배","pjtSeq":"1000","trSeq":"8203","pjtFromDate":"2010-01-01","bankNumber":"110434349254","pjtName":"최소유전체 합성 및 DNA Scaffold 기반 지능형","erpMgtSeq":"1000","erpMgtName":"최소유전체 합성 및 DNA Scaffold 기반 지능형","code":"project","dummy":"{}"} */

		var resultValue = {
			erpMgtSeq : '',
			erpMgtName : '',
			btrSeq : '',
			btrNb : '',
			btrName : ''
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

		/* 프로젝트 반영 */
		$('#consTbl').dzt('setValue', $('#consTbl').dzt('getUID'), resultValue, false);
		if ((Option.iCUBE.GetMgtStat() === '2' ? (param.pjtSeq || '') : '') !== '') {
			$('#consTbl').dzt('setKeyIn', 'RIGHT');
		}
	}

	/* ## 공통코드 - 하위사업 ============================== ## */
	function fnCommonCode_erpBottomName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.erpMgtSeq = $('#consTbl').dzt('getValue').erpMgtSeq;
		param.callback = 'fnCommonCode_erpBottomName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = param.searchStr.toString();

		/* 팝업 호출 */
		fnCommonCodePop('bottom', param, param.callback);

		/* [ return ] */
		return;
	}
	
	/* ## 공통코드 - 하위사업 콜백 ============================== ## */
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
		/* 프로젝트 / 부서 명칭 */
		resultValue.erpBottomName = (param.bottomName || '');
		/* 프로젝트 / 부서 코드 */
		resultValue.erpBottomSeq = (param.bottomSeq || '');

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
		var uid = $('#consTbl').dzt('getUID');
		$('#consTbl').dzt('setValue', uid, resultValue, false);
		if (resultValue.bottomSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#consTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}
	
	/* ## 공통코드 - 예산과목 ============================== ## */
	function fnCommonCode_budgetlist(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_budgetlist_callback';

		if (Option.Common.ERPiU()) {
			code = 'budget'
		} else if (Option.Common.iCUBE()) {

			/* 품의서 중복에산 조회 방지 기능 추가 */
			var selectedBudgetSeqs = '';
			var budgetRows = $('#budgetTbl').dzt('getValueAll');
			for (var i = 0; i < budgetRows.length; i++) {
				var item = budgetRows[i];
				selectedBudgetSeqs += '|' + item.erpBudgetSeq + '|';
			}
			var thisBudgetSeq = $('#budgetTbl').dzt('getValue').erpBudgetSeq;
            if(thisBudgetSeq === null || thisBudgetSeq == "") { thisBudgetSeq = 'undefined'; }

			param.selectedBudgetSeqs = selectedBudgetSeqs.replace('|' + thisBudgetSeq + '|', '');
			param.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
			param.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
			param.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
			param.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
			param.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
			param.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
			param.erpDivSeq = optionSet.erpEmpInfo.erpDivSeq + "|"; /* 회계통제단위 구분값 '|' */
			param.erpMgtSeq = (param.erpMgtSeq || '') + "|"; /* 예산통제단위 구분값 '|' */
			param.opt01 =  optionSet.gw[1][8].setValue; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
            param.opt02 =  optionSet.gw[1][10].setValue; /* 1: 모두표시, 2: 사용기한결과분 숨김 */
			param.opt03 = '2'; /* 1: 예산그룹 전체, 2: 예산그룹 숨김 */
			param.bottomSeq = !!param.bottomSeq?param.bottomSeq+'|':'';
			param.erpBottomSeq = param.erpBottomSeq?param.erpBottomSeq + '|':'';

			/* 수입, 지출 예산과목 조회 분기 */
			var consData = $('#consTbl').dzt('getValue');
			var incomeCode = [ '8' ]; /* 수입 구분 코드 */
			var expenseCode = [ '1', '2', '3', '4', '5', '6', '7' ]; /* 지출 구분 코드 */

			if (expenseCode.indexOf(consData.docuFgCode) > -1) {
				param.grFg = '2'; /* 1 : 수입, 2 : 지출 */
			} else if (incomeCode.indexOf(consData.docuFgCode) > -1) {
				param.grFg = '1'; /* 1 : 수입, 2 : 지출 */
			} else {
				param.grFg = ''; /* 1 : 수입, 2 : 지출 */
			}
		}

		/* 팝업 호출 */
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	function fnCommonCode_budgetlist_callback(param) {

		/* ERPiU example : {"CD_BUDGET":"BG002","NM_BUDGET":"영업부문","code":"budget","dummy":"{}"} */
		/* iCUBE example : {"BGT02_CD": "A500010000","TO_DT": "99999999","GROUP_NM": "예산과목체계","GROUP_CD": "1000","DRCR_FG": "1","GR_FG": "2","DIV_FG": "3","LEVEL01_NM": "장","BGT01_CD": "A500000000","LAST_YN2": "Y","LEVEL01_CD": "LV001","BGT03_NM": "품의금 테스트 과목","USE_YN": "1","LEVEL02_CD": "LV002","BGT_CD": "A500010300", AS erpBudgetSeq"LEVEL02_NM": "관","BGT03_CD": "A500010300","CTL_FG": "9","HBGT_CD": "A500010000","SYS_CD": "2A500000000A500010000A5000103000000000000","BGT01_NM": "A5관지출","BGT_NM": "품의금 테스트 과목", AS erpBudgetName"GROUP_NMK": "예산과목체계","HBGT_CD3": "","BIZ_FG": "0","BGT02_NM": "A5항 일반관리비","HBGT_CD2": "A500010000","HBGT_CD1": "A500000000","code": "budgetlist","dummy": "\"\""} */

		var resultValue = {};
		resultValue = $.extend(resultValue, param);

		if (Option.Common.ERPiU()) {
			resultValue.erpBudgetName = (param.NM_BUDGET || ''); /* 예산단위 명칭 */
			resultValue.erpBudgetSeq = (param.CD_BUDGET || ''); /* 예산단위 코드 */
		} else if (Option.Common.iCUBE()) {
			resultValue.erpBudgetName = param.BGT_NM; /* 예산과목 명칭 */
			resultValue.erpBudgetSeq = param.BGT_CD; /* 예산과목 코드 */
			
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

		/* 예산과목 반영 */
		$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), resultValue, false);

		/* 예산단위 || 예산과목 반영 */
		if ((resultValue.erpBudgetName || '') !== '') {
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
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

			/* ERPiU 전용 로직 */
			if (Option.Common.ERPiU()) {
				code = "fiacct";
				param.erpBudgetSeq = ($('#budgetTbl').dzt('getValue').erpBudgetSeq || '');
				param.erpBizplanSeq = ($('#budgetTbl').dzt('getValue').erpBizplanSeq || '');
				param.erpBgacctSeq = ($('#budgetTbl').dzt('getValue').erpBgacctSeq || '');
			}
		} else if (param.isBudgetDiv) {
			param.callback = 'fnCommonCode_budgetDiv_callback';
		}

		/* 팝업 호출 */
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	/* 예산 회계단위 조회 콜백 */
	function fnCommonCode_budgetDiv_callback(param) {
		console.log(param);
		if (Option.Common.iCUBE()) {
			optionSet.erpEmpInfo.erpDivSeq = (param.divSeq || '');
			optionSet.erpEmpInfo.erpDivName = (param.divName || '');
			optionSet.erpEmpInfo.vatControl = (param.vatControl || '');
		} else if (Option.Common.ERPiU()) {
			optionSet.erpEmpInfo.erpDivSeq = (param.CD_PC || '');
			optionSet.erpEmpInfo.erpDivName = (param.NM_PC || '');
            optionSet.erpEmpInfo.erpPcSeq = (param.CD_PC || '');
            optionSet.erpEmpInfo.erpPcName = (param.NM_PC || '');
		}

		$('#lbErpDivName').val(optionSet.erpEmpInfo.erpDivName);
		$('#lbErpDivName').attr('seq', optionSet.erpEmpInfo.erpDivSeq);
		

		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/cons/ConsDocUpdate.do',
			datatype : 'json',
			async : false,
			data : {
				consDocSeq : consDocSeq,
				empSeq : optionSet.loginVo.empSeq,
				erpDivSeq : param.CD_PC||param.divSeq,
				erpDivName : param.NM_PC||param.divName,
				erpPcSeq : param.CD_PC,
				erpPcName : param.NM_PC,
				outProcessInterfaceId : '${outProcessInterfaceId}',
				outProcessInterfaceMId : '${outProcessInterfaceMId}',
				outProcessInterfaceDId : '${outProcessInterfaceDId}'
			},
			success : function(result) {
				// TODO:
			}
		});
	}

	/* 전표 회계단위 조회 콜백 */
	function fnCommonCode_div_callback(param) {

		/* ERPiU 전용 로직 */
		if (Option.Common.ERPiU()) {
			param.code = 'div';
		}

		/* ERPiU example : {"TP_DRCR1":"1","TP_ACLEVEL":"1","NM_ACCT":"현금","CD_ACITEM":"10100","CD_ACCT":"10100","code":"div","dummy":"{}"} */
		/* iCUBE example : {"divName":"Ezbaro 연구원본사","divSeq":"1000","erpDivSeq":"1000","erpDivName":"Ezbaro 연구원본사","code":"div","dummy":"{}"} */

		var resultValue = {
			erpDivSeq : '',
			erpDivName : ''
		};

		if (Option.Common.iCUBE()) {
			resultValue.erpDivSeq = (param.divSeq || ''); /* 회계단위 코드 */
			resultValue.erpDivName = (param.divName || '');/* 회계단위 명칭 */
		} else if (Option.Common.ERPiU()) {
			resultValue.erpFiacctSeq = (param.CD_ACCT || ''); /* 회계계정 코드 */
			resultValue.erpFiacctName = (param.NM_ACCT || '');/* 회계계정 명칭 */
			resultValue.erpDivSeq = (param.CD_ACCT || ''); /* 회계계정 코드 */
			resultValue.erpDivName = (param.NM_ACCT || '');/* 회계계정 명칭 */
		}

		/* 회계단위 반영 */
		$('#budgetTbl').dzt('setValue', $('#budgetTbl').dzt('getUID'), resultValue, false);

		if ((resultValue.erpDivSeq || '') !== '') {
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
		}

		return;
	}

	/* ## 공통코드 - 사업계획 ============================== ## */
	function fnCommonCode_bizplan(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_erpBizplanName_callback';

		/* 팝업 호출 */
		fnCommonCodePop(code, param, param.callback);
		return;
	}

	function fnCommonCode_erpBizplanName_callback(param) {
		var resultValue = {
			erpBizplanName : '',
			erpBizplanSeq : ''
		};

		/* 사업계획 명칭 */
		resultValue.erpBizplanName = (param.NM_BIZPLAN || '');
		/* 사업계획 코드 */
		resultValue.erpBizplanSeq = (param.CD_BIZPLAN || '');

		/* 사업계획 반영 */
		var uid = $('#budgetTbl').dzt('getUID');
		$('#budgetTbl').dzt('setValue', uid, resultValue, false);

		if (resultValue.erpBizplanSeq !== '') {
			/* 오른쪽으로 이동 */
			$('#budgetTbl').dzt('setKeyIn', 'RIGHT');
		}

		/* [ return ] */
		return;
	}

	/* ## 공통코드 - 예산계정 ============================== ## */
	function fnCommonCode_bgacct(code, param) {
		
 		/* 중복 예산계정 제외 코드 */
		var selectedBudgetSeqs = '';
		var budgetRows = $('#budgetTbl').dzt('getValueAll');
		for (var i = 0; i < budgetRows.length; i++) {
			var item = budgetRows[i];
			selectedBudgetSeqs += ',( |' + (item.erpBudgetSeq||'') + '|' + (item.erpBizplanSeq||'***') + '|' + (item.erpBgacctSeq||'') + '| )';
		}
		var thisBudgetSeq = $('#budgetTbl').dzt('getValue').erpBudgetSeq;

		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		
		param.selectedBudgetSeqs = selectedBudgetSeqs.substr(1,selectedBudgetSeqs.length);
		
		param.callback = 'fnCommonCode_bgacct_callback';
		param.grFg = '1';  
		
		/* 팝업 호출 */
		fnCommonCodePop(code, param, param.callback);
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
	
	function fnCommonCode_bgacct_callback(param) {
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

		if (resultValue.erpBgacctSeq !== '') {
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
	/* ## 예산처리 - 조회 ## */
	var preErpBudgetSeq = null;
	var preBudgetSeq = null;
	function fnSetBudgetDisplay() {

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

		var consData = $('#consTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, consData))); /* 작성중인 품의정보 */

		var budgetData = $('#budgetTbl').dzt('getValue');
		parameter = JSON.parse(JSON.stringify($.extend(parameter, budgetData))); /* 작성중인 예산내역 */

		parameter.erpGisuDate = (consData.consDate || '').toString().replace(/-/g, '');
		parameter.expendDate = (consData.consDate || '').toString().replace(/-/g, '');

		if (Option.Common.ERPiU()) {
			parameter.erpDivSeq = (parameter.erpPcSeq || ''); /* ERP 사업장 명칭 */
			parameter.erpDivName = (parameter.erpPcName || ''); /* ERP 사업장 명칭 */
		} else if (Option.Common.iCUBE()) {
			parameter.erpDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpDivName = $('#lbErpDivName').text();
			parameter.erpBudgetDivSeq = ($('#lbErpDivName').attr('seq') || '');
			parameter.erpBudgetDivName = $('#lbErpDivName').text();
		}

		if ((preBudgetSeq == budgetData.budgetSeq) && (preErpBudgetSeq == budgetData.erpBudgetSeq)) {
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

		var runBudgetInfoFlag = false;

		switch (Option.Common.GetErpType()) {
		case 'ERPiU':
			var bizplanCode = parameter.erpBizplanSeq;
			if(!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0')){
				parameter.erpBizplanSeq = '';
				bizplanCode = '1'
			}
			if ((parameter.erpCompSeq || '') !== '' && (parameter.erpBudgetSeq || '') !== '' && ( bizplanCode || '') !== '' && (parameter.erpBgacctSeq || '') !== '' && (parameter.expendDate || '') !== '') {
				runBudgetInfoFlag = true;
			} else {
				runBudgetInfoFlag = false;
			}
			break;
		case 'iCUBE':
			if ((parameter.erpMgtSeq || '') !== '' /* 프로젝트 */
					&& (parameter.erpBudgetSeq || '') !== '' /* 예산과목 */
					&& (parameter.erpGisuDate || '') !== '' /* 품의일자 */
					&& (parameter.consDocSeq || '') !== '') { /* 품의서 시퀀스 */
				runBudgetInfoFlag = true;
			} else {
				runBudgetInfoFlag = false;
			}
			break;
		}

		if (runBudgetInfoFlag) {
			/* [ ajax ] */
			$.ajax({
				type : 'post',
				/*   - url : /ex/np/user/cons/consBudgetInfoSelect.do */
				url : domain + '/ex/np/user/cons/consBudgetInfoSelect.do',
				datatype : 'json',
				async : false,
				/*   - data : - */
				data : Option.Common.GetSaveParam(parameter),
				/*   - success :  */
				success : function(result) {
					fnAjaxLog(this.url, result);

					var aData = Option.Common.GetResult(result, 'aData');
					var resultCode = Option.Common.GetResultCode(result);

					if (resultCode === 'SUCCESS') {
						/* iCUBE example : {"openAmt":1000000000,"balanceAmt":999248350,"budgetTableResAmt":0,"Amt":100,"tryAmt":0,"applyAmt":751650} */
						/* ERPiU example : {"openAmt":0,"balanceAmt":-729291,"budgetTableResAmt":659291,"Amt":70000,"tryAmt":0,"applyAmt":729291} */

						/* 반환값 정의 */
						var erpOpenAmt = Number((aData.openAmt || '').toString().replace(/,/g, '')), erpApplyAmt = Number((aData.applyAmt || '').toString().replace(/,/g, '')), budgetTableResAmt = Number((aData.budgetTableResAmt || '').toString().replace(/,/g, '')), gwBalanceAmt = Number((aData.balanceAmt || '').toString().replace(/,/g, '')), resApplyAmt = Number((aData.resApplyAmt || '').toString().replace(/,/g, '')), consBalanceAmt = Number((aData.consBalanceAmt || '').toString().replace(/,/g, '')), erpLeftAmt = Number((aData.erpLeftAmt || '').toString().replace(/,/g, '')), budgetTableConsAmt = Number((aData.budgetTableConsAmt || '').toString().replace(/,/g, '')), budgetAmt = Number((aData.tryAmt || '').toString().replace(/,/g, ''));
						itemAmt = (aData.itemAmt || '').toString().replace(/,/g, '');
						aData.itemAmt = itemAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						itemAmt = itemAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						/* 예산금액 */
						$('#lbErpOpenAmt').html(Option.Common.GetNumeric(erpOpenAmt || '0'));
						aData.erpOpenAmt = erpOpenAmt;
						/* 품의잔액 */
						$('#lbConsBalanceAmt').html(Option.Common.GetNumeric(consBalanceAmt || '0'));
						/* 집행금액 */
						$('#lbResApplyAmt').html(Option.Common.GetNumeric(resApplyAmt || '0'));
						/* 금회집행 */
						$('#lbBudgetAmt').html(Option.Common.GetNumeric(budgetAmt || '0'));
						aData.budgetAmt = budgetAmt;
						/* 예산잔액 */
						$('#lbGwBalanceAmt').html(Option.Common.GetNumeric(gwBalanceAmt || '0'));
						aData.gwBalanceAmt = gwBalanceAmt;

						/* 예산정보 반영 */
						delete aData['budgetAmt'];
						var consUid = $('#consTbl').dzt('getUID');
						$('#consTbl').dzt('setValue', consUid, aData, false);

						var budgetUid = $('#budgetTbl').dzt('getUID');
						$('#budgetTbl').dzt('setValue', budgetUid, aData, false);
					} else {
						alert('예산 조회 중 알 수 없는 오류가 발생되었습니다.');
					}
				},
				/*   - error :  */
				error : function(result) {
					console.error(result);
				}
			});
		} else {
			/* 예산금액 초기화 */
			$('#lbErpOpenAmt').html('0');
			$('#lbResApplyAmt').html('0');
			$('#lbConsBalanceAmt').html('0');
			$('#lbBudgetAmt').html('0');
			$('#lbGwBalanceAmt').html('0');
		}

		return;
	}

	/* ## Log 확인 ## */
	/* ====================================================================================================================================================== */
	function fnAjaxLog(url, result) {
		/* console.error('[+]' + url + ' ====================================================================================================') */
		/* console.error(Option.Common.GetResultCode(result)); */
		/* console.error(JSON.stringify(Option.Common.GetResult(result, 'aData'))); */
		/* console.error(JSON.stringify(Option.Common.GetResult(result, 'aaData'))); */
		/* console.error('[-]' + url + ' ====================================================================================================') */
	}
	
	function fnFocusAmtUpdate(){
		/* 예산 총금액 - 합계 */
		var budgetAmt = $('#budgetTbl').dzt('getValueAll').map(function(item){
			return Number((item.budgetAmt || '0').toString().replace(/,/g, ''));
		});
		
		budgetAmt = (budgetAmt || []);
		budgetAmt = (budgetAmt.length > 0 ? budgetAmt : [0]);
		
		var budgetAmtTemp = 0;
		for(var i = 0 ; i < budgetAmt.length; i++ ){
			budgetAmtTemp += budgetAmt[i];
		}
		budgetAmt = budgetAmtTemp;
		$('#consTbl').dzt('setValue', $('#consTbl').dzt('getUID'), { amt: budgetAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") }, false);
	}
	
	function fnGetUseBizplanERPiU(){
		try{
			return (!!(optionSet.erp['TP_BUDGETMNG'].CD_ENV == '0'))  ? 'N' : 'Y'
		}catch(e){
			return 'N'
		}
	}
	
	function GetBottomUseYN() {
		if(optionSet.conVo.erpTypeCode == 'iCUBE'){
			if (optionSet && optionSet.erp && optionSet.erp['4'] && optionSet.erp['4']['14'] && optionSet.erp['4']['14']['USE_YN']) {
				return (optionSet.erp['4']['14']['USE_YN'].toString() === '1' ? 'Y' : 'N')
			} else {
				return 'N';
			}
		}else{
			return 'N';
		}
	}
	
	function GetItemSpecConsGridUseYN() {	
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

		var consData = $('#consTbl').dzt('getValue');
		var budgetData = $('#budgetTbl').dzt('getValue');

		window.open('', "UserItemSpecPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		USER_itemSpecPop.target = "UserItemSpecPop";
		USER_itemSpecPop.method = "post";
		USER_itemSpecPop.consDocSeq.value = consData.consDocSeq;
		USER_itemSpecPop.consSeq.value = consData.consSeq;
		if(optionSet.conVo.erpTypeCode == "ERPiU"){
			USER_itemSpecPop.consDocSeq.value = budgetData.consDocSeq;
			USER_itemSpecPop.consSeq.value = budgetData.consSeq;
			USER_itemSpecPop.budgetSeq.value = budgetData.budgetSeq||'';	
		}
		else{
			USER_itemSpecPop.consDocSeq.value = consData.consDocSeq;
			USER_itemSpecPop.consSeq.value = consData.consSeq;
			USER_itemSpecPop.budgetSeq.value = consData.budgetSeq||'';
		}
		
		USER_itemSpecPop.action = url;
		USER_itemSpecPop.submit();
		USER_itemSpecPop.target = "";

		return;
	}
	
		
	/* ## 품의서 물품명세 등록  ## */
	/* ====================================================================================================================================================== */
	/* ## event - 품의서 즐겨찾기 팝업 ## */
	function fnEvenBringFavorites() {
		/* 입력된 정보 확인 ( 품의정보가 입력된 경우 참조품의 진행 시 모두 초기화 되므로, 사용자 확인 진행 ) */
		var consDataArray = $('#consTbl').dzt('getValueAll');
		if (consDataArray.length > 0 && (consDataArray[0].consSeq || '') !== '') {
			var msg = '${CL.ex_favoriteDeleteMsg}' // '즐겨찾기 가져오기 기능은 기존 작성 내역을 삭제하고 덮어쓰기 합니다.\r\n계속 진행하시겠습니까?';

			if (!confirm(msg)) {
				return false;
			}
		}

		/* 결의정보 삭제 */
		var consData = $('#consTbl').dzt('getValue');

		if ((consData.consSeq || '') !== '') {
			$('#btnConsReset').click();
		}

		/* 결제내역 테이블 초기화 */
		$('#tradeTbl').dzt('setReset');

		/* 예산내역 테이블 초기화 */
		$('#budgetTbl').dzt('setReset');

		/* 결의정보 테이블 초기화 */
		$('#consTbl').dzt('setReset');

		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserConsFavoritesPop.do'/>";
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
			var consUID = $('#consTbl').dzt('getUID');
	        $('#consTbl').dzt('setValue', consUID, { itemAmt: Option.Common.GetNumeric(amt) }, false);	
		}
	}
	
	/* ## event - 즐겨찾기 품의서 반영 ## */
	function fnCallbackFavorites(param) {

		/* [ ajax parameter ] */
		var parameter = {};
		parameter.consDocSeq = consDocSeq;
		parameter.favoriteConsDocSeq = param.consDocSeq;

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : domain + '/ex/np/user/cons/ConsFavoriteInfoUpdate.do',
			datatype : 'json',
			async : false,
			/*   - data : consDocSeq(참조 품의서 시퀀스), resDocSeq(작성중인 결의문서 시퀀스) */
			data : Option.Common.GetSaveParam(parameter),
			resDocSeq : parameter.resDocSeq,
			resSeq : parameter.resSeq,
			/*   - success :  */
			success : function(result) {
				fnAjaxLog(this.url, result);

				if (Option.Common.GetResultCode(result) === 'SUCCESS') {
					approvalBack = !approvalBack;
					useFavorite = true;
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
					
					fnConsSelect(); /* 결의정보 조회 및 반영 */
					fnConsAllInfo(); /* 결의문서 금액 갱신 ( 자동계산 처라 ) */
					Option[Option.Common.GetErpType()].GetBudgetAmtInfo(); /* 예산금액 조회 */
					
					
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
	
	/*	[데이터 보정]	DB자료형 int 대응, 기본 값 처리
	-------------------------------------------- */
	function fnBudgetDataCurrection(parameter){
		parameter.erpBqSeq = parameter.erpBqSeq || '0';
		parameter.erpBkSeq = parameter.erpBkSeq || '0';
		return parameter;
	}
	
</script>

<div class="pop_wrap">
    <div class="pop_sign_head posi_re">
        <h1 id="h1_consDocTitle">${CL.ex_consWrite}  <!--품의서 작성--></h1>
        <h1 id="h1_gisuInfo" style="display:none;">회계기간 : 2기 2019.01.01 ~ 2019.12.31</h1>
        <div class="psh_btnbox">

            <!-- 양식팝업 오른쪽 버튼그룹 -->
            <div class="psh_right">
                <div class="btn_cen mt8">
                    <input type="button" class="psh_btn" value="${CL.ex_approvalComplete}" id="btnApproval" />
                    <input type="button" class="psh_btn" value="작성완료" id="btnTripInfo" style="display:none;"/>
                </div>
            </div>
        </div>
    </div>

    <div class="pop_con">

        <!-- 로그인 사용자 정보 ( ERP ) -->
        <div class="top_box gray_box">
            <dl>
                <dt class="fwn">${CL.ex_accountingUnit}  <!--회계단위--> :</dt>
                <dd class="mt15 fwb" style="margin-right: 100px;">
                    <input class="fl input_search mr5" id="lbErpDivName" type="text" value="" style="width:200px;" disabled />
                    <a href="#" class="fl btn_search" id="btnErpDivChoice"></a>
                </dd>
                <!-- <dd class="mt20 fwb" style="margin-right: 100px;" id="lbErpDivName"></dd>  -->

                <dt class="fwn">${CL.ex_useDepartment}  <!--사용부서--> :</dt>
                <dd class="mt20 fwb" style="margin-right: 100px;" id="lbErpDeptName"></dd>
                <dt class="fwn">${CL.ex_empSeq}  <!--사번--> :</dt>
                <dd class="mt20 fwb" style="margin-right: 100px;" id="lbErpEmpSeq"></dd>
                <dt class="fwn">${CL.ex_user}  <!--사용자--> :</dt>
                <dd class="mt20 fwb" id="lbErpEmpName"></dd>
            </dl>
        </div>
        <!-- // 로그인 사용자 정보 ( ERP ) -->
        <!-- 품의서 품의정보 테이블 기능 -->
        <div class="btn_div mt20">
            <div class="left_div">
                <p class="tit_p fl mt5 mb0">
                    ${CL.ex_consInfo}  <!--품의정보--><span class="text_red fwn ml10" id="spanConsTooltip"></span>
                </p>
            </div>
            <div class="right_div">
                <div class="controll_btn p0 fr ml10">
                	<button id="btnBringFavorites"/>${CL.ex_favorite}</button>
                    <button id="btnConsRefer">${CL.ex_consPull}  <!--품의서 불러오기--></button>
                    <button id="btnConsReset">${CL.ex_reset}  <!--초기화--></button>
                    <button id="btnConsAdd">${CL.ex_add}  <!--추가--></button>
                    <button id="btnConsDelete">${CL.ex_remove}  <!--삭제--></button>
                    <button id="btnConsUp" class="ud up" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_up}  <!--위--></button>
                    <button id="btnConsDown" class="ud down" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_down}  <!--아래--></button>
                </div>
            </div>
        </div>
        <!-- // 품의서 품의정보 테이블 기능 -->
        <!-- 품의서 품의정보 테이블 -->
        <div id="consTbl"></div>
        <!-- // 품의서 품의정보 테이블 -->
        <!-- 품의서 예산정보 테이블 기능 -->
        <div style="height: 20px;"></div>
        <div class="btn_div mt0">
            <div class="left_div">
                <p class="tit_p fl mt5 mb0">
                    ${CL.ex_detailBudget}  <!--예산내역--><span class="text_red fwn ml10" id="budgetTooltip"></span>
                </p>
            </div>
            <div class="right_div">
                <div class="controll_btn p0 fr ml10">
                    <button id="btnBudgetAdd">${CL.ex_add}  <!--추가--></button>
                    <button id="btnBudgetDelete">${CL.ex_remove}  <!--삭제--></button>
                    <button id="btnBudgetUp" class="ud up" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_up}  <!--위--></button>
                    <button id="btnBudgetDown" class="ud down" style="background-position: 10px 8px; padding-left: 28px; padding-right: 12px;">${CL.ex_down}  <!--아래--></button>
                </div>
            </div>
        </div>
        <!-- // 품의서 예산정보 테이블 기능 -->
        <!-- 품의서 예산정보 테이블 -->
        <div id="budgetTbl"></div>
        <!-- // 품의서 예산정보 테이블 -->
        <!-- 품의서 예산 표시 -->
        <div class="com_ta mt20">
            <table>
                <colgroup>
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                </colgroup>
                <tr>
                    <th>${CL.ex_budgetAmt}  <!--예산금액--></th>
                    <td class="ri pr5" id="lbErpOpenAmt">0</td>
                    <th>${CL.ex_consBal}  <!--품의잔액--></th>
                    <td class="ri pr5" id="lbConsBalanceAmt">0</td>
                    <th>${CL.ex_budgetExcutionAmt}  <!--집행금액--></th>
                    <td class="ri pr5" id="lbResApplyAmt">0</td>
                    <th>${CL.ex_thisTimeExecution}  <!--금회집행--></th>
                    <td class="ri pr5" id="lbBudgetAmt">0</td>
                    <th>${CL.ex_budgetBalance}  <!--예산잔액--></th>
                    <td class="ri pr5" id="lbGwBalanceAmt">0</td>
                </tr>
            </table>
        </div>
        <!-- // 품의서 예산 표시 -->
    </div>
    <!-- //pop_con -->
</div>
<!-- //pop_wrap -->

<form id="tripConsDocPop" name="tripConsDocPop" method="post">
	<input type="hidden" name="consDocSeq" id="consDocSeq" value="1"/>
	<input type="hidden" name="tripConsDocSeq" id="tripConsDocSeq" value=""/>
</form>	

<form id="USER_itemSpecPop" name="frmPop" method="post">
	<input type="hidden" name="consDocSeq" id="consDocSeq" value="0"/>
	<input type="hidden" name="consSeq" id="consSeq" value="0"/>
	<input type="hidden" name="budgetSeq" id="budgetSeq" value="0"/>
</form>
<form id="USER_confferPop" name="frmPop" method="post"></form>
