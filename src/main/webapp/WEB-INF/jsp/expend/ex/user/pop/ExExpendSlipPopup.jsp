<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript"
	src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
<%-- <script type="text/javascript" src='<c:url value="/js/ex/CommonEx.js"></c:url>'></script> --%>
<script type="text/javascript"
	src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>

<script type="text/javascript"
	src='<c:url value="/js/ex/ExOption.js?ver=20190729"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.focus.js"></c:url>'></script>

<script>
	/* [Map] declare javascipt hashmap prototype
	========================================*/
	Map = function () {
		this.map = new Object();
	};
	Map.prototype = {
		put: function (key, value) {
			this.map[key] = value;
		},
		get: function (key) {
			return this.map[key];
		},
		containsKey: function (key) {
			return key in this.map;
		},
		containsValue: function (value) {
			for (var prop in this.map) {
				if (this.map[prop] == value) return true;
			}
			return false;
		},
		isEmpty: function (key) {
			return (this.size() == 0);
		},
		clear: function () {
			for (var prop in this.map) {
				delete this.map[prop];
			}
		},
		remove: function (key) {
			delete this.map[key];
		},
		keys: function () {
			var keys = new Array();
			for (var prop in this.map) {
				keys.push(prop);
			}
			return keys;
		},
		values: function () {
			var values = new Array();
			for (var prop in this.map) {
				values.push(this.map[prop]);
			}
			return values;
		},
		size: function () {
			var count = 0;
			for (var prop in this.map) {
				count++;
			}
			return count;
		}
	};
</script>

<script>
    /* 변수정의 */
    var ifSystem = '${ViewBag.ifSystem}';

    /* 첨부파일 임시 바인딩 변수 */
    var tmpAttchSlipBindList = '';

    /* 켄도데이트피커 트리거 한번 호출하는 변수 */
	var isFirstChange = true;

    /* 계정과목 정보 맵 */
	var acctCodeMap = new Map();

	/* 접대비 seq */
	var feeSeq = 0;

	/* 지출결의 - 사용자 */
	var expendSlipUseEmp = new kendo.data.ObservableObject(ExCodeOrg);
    /* 필수값 표시 이미지 ID 리스트 */
// 	var requiredIdList = ['AuthDate', 'DrCrGbn','Acct','VatType','VatReason','NoTax','Note','Emp','Budget','Bizplan','BgAcct','Project','Card','Partner','Amt','SubStdAmt','SubTaxAmt'];
// 	var visibleObject = ['txtSlipAuthDate'];

	/* 종결문서 수정인 경우 기존 분개의 금액 정보 저장 */
	var basicSlipAmt = '0';

    /* 지출결의 - 항목 분개 */
    var expendSlip = new kendo.data.ObservableObject(ExExpendSlip);
    expendSlip.bind("change", function( e ) {
        if (e.field == 'amt') { /* 금액 */
            this.set('amt', (this.get('amt')).toString().replace(/,/g, '').replace('.00', ''));
            $('#txtSlipAmt').val(this.get('amt').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        }
        if (e.field == 'subStdAmt') { /* 과세표준액 */
            this.set('subStdAmt', (this.get('subStdAmt')).toString().replace(/,/g, '').replace('.00', ''));
            $('#txtSlipSubStdAmt').val(this.get('subStdAmt').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        }
        if (e.field == 'subTaxAmt') { /* 세액 */
            this.set('subTaxAmt', (this.get('subTaxAmt')).toString().replace(/,/g, '').replace('.00', ''));
            $('#txtSlipSubTaxAmt').val(this.get('subTaxAmt').toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        }

        /* 증빙일자 */
        if (this.get('authDate') != '') {
            var authDate = this.get('authDate').toString().replace(/-/g, '');
            $('#txtSlipAuthDate').val([ authDate.substring(0, 4), authDate.substring(4, 6), authDate.substring(6, 8) ].join('-'));
        }

        /* 구분 */
        if (this.get('drcrGbn') != '') {
            if (this.get('drcrGbn') == 'dr' || this.get('drcrGbn') == 'vat') {
                $('#division1').attr("checked", true);
                $('#division2').attr("checked", false);
            } else if (this.get('drcrGbn') == 'cr') {
                $('#division2').attr("checked", true);
                $('#division1').attr("checked", false);
            }
        }

        /* 계정과목 */
        if (this.get('acctCode') != '') {
            $('#txtSlipAcctCode').val(this.get('acctCode'));
            $('#txtSlipAcctName').val(this.get('acctName'));
        }

        /* 적요 */
        if (this.get('note') != '') {
            $('#txtSlipNote').val(this.get('note'));
        }
    });

    /* 지출결의 - 계정과목 */
    var expendSlipAcct = new kendo.data.ObservableObject(ExCodeAcct);
    expendSlipAcct.bind("change", function( e ) {
        if (e.field == 'acctCode') {
        	/* 계정과목에 따른 필수입력 값 조횐 */
        	fnGetNecessaryOption(this.get('acctCode'));
            expendSlip.set('acctCode', this.get('acctCode'));
        }
        if (e.field == 'acctName') {
            expendSlip.set('acctName', this.get('acctName'));
        }
        if (e.field == 'vatYN') {
            expendSlip.set('vatYN', this.get('vatYN'));
        }
    });

    /* 지출결의 - 표준적요 */
    var expendSlipSummary = new kendo.data.ObservableObject(ExCodeSummary);
    expendSlipSummary.bind("change", function( e ) {
        if (e.field == 'summaryCode') { /* 표준적요 코드 화면 표현 */
            $('#txtSlipSummaryCode').val(this.get('summaryCode'));
        }
        if (e.field == 'drAcctName') { /* 차변 계정과목 화면 표현 */
            $('#txtSlipDrAcctName').val(this.get('drAcctName'));
        }
        if (e.field == 'summaryName') { /* 표준적요 명칭 화면 표현 */
            $('#txtSlipSummaryName').val(this.get('summaryName'));
        }
        if (this.get('summaryCode') != '' && this.get('drAcctName') != '' && this.get('drAcctCode') != '' && this.get('drAcctName') != '' && this.get('crAcctCode') != '' && this.get('crAcctName') != '') { /* 적요 기본문구 적용 */
        }
    });

    /* 지출결의 - 증빙유형 */
    var expendSlipAuth = new kendo.data.ObservableObject(ExCodeAuth);
    expendSlipAuth.bind("change", function( e ) {
        /* 증빙유형 코드 화면 표현 */
        if (e.field == 'authCode') {
            $('#txtSlipAuthCode').val(this.get('authCode'));
        }
        /* 증빙유형 명칭 화면 표현 */
        if (e.field == 'authName') {
            $('#txtSlipAuthName').val(this.get('authName'));
        }
        /* 부가세 코드 화면 표현 */
        if (e.field == 'vatTypeCode') {
            $('#txtSlipVatTypeCode').val(this.get('vatTypeCode'));
        }
        /* 부가세 명칭 화면 표현 */
        if (e.field == 'vatTypeName') {
            $('#txtSlipVatTypeName').val(this.get('vatTypeName'));
        }
        /* 사유구분 코드 화면 표현 */
        if (e.field == 'vaTypeCode') {
            $('#txtSlipVaCode').val(this.get('vaTypeCode'));
        }
        /* 사유구분 명칭 화면 표현 */
        if (e.field == 'vaTypeName') {
            $('#txtSlipVaTypeName').val(this.get('vaTypeName'));
        }
        /* 불공제구분 코드 화면 표현 */
        if (e.field == 'noTaxCode') {
            $('#txtSlipNoTaxCode').val(this.get('noTaxCode'));
        }
        /* 불공제구분 명칭 화면 표현 */
        if (e.field == 'noTaxName') {
            $('#txtSlipNoTaxName').val(this.get('noTaxName'));
        }

        /* 적요 필수입력 처리 */
        if (e.field == 'noteRequiredYN') {
            if (this.get('noteRequiredYN') == 'Y') {
                $('#reqNote').show();
            } else {
                $('#reqNote').hide();
            }
        }
        /* 증빙일자 필수입력 처리 */
        if (e.field == 'authRequiredYN') {
            if (this.get('authRequiredYN') == 'Y') {
                $('#reqAuthDate').show();
            } else {
                $('#reqAuthDate').hide();
            }
        }
        /* 프로젝트 필수입력 처리 */
        if (e.field == 'projectRequiredYN') {
            if (this.get('projectRequiredYN') == 'Y') {
                $('#reqProject').show();
            } else {
                $('#reqProject').hide();
            }
        }
        /* 거래처 필수입력 처리 */
        if (e.field == 'partnerRequiredYN') {
            if (this.get('partnerRequiredYN') == 'Y') {
                $('#reqPartner').show();
            } else {
                $('#reqPartner').hide();
            }
        }
        /* 카드 필수입력 처리 */
        if (e.field == 'cardRequiredYN') {
            if (this.get('cardRequiredYN') == 'Y') {
                $('#reqCard').show();
            } else {
                $('#reqCard').hide();
            }
        }
        return;
    });

    /* 지출결의 - 프로젝트 */
    var expendSlipProject = new kendo.data.ObservableObject(ExCodeProject);
    expendSlipProject.bind("change", function( e ) {
        /* 프로젝트 코드 반영 */
        $('#txtSlipProjectCode').val(this.get('projectCode'));
        /* 프로젝트 명칭 반영 */
        $('#txtSlipProjectName').val(this.get('projectName'));
    });

    /* 지출결의 - 거래처 */
    var expendSlipPartner = new kendo.data.ObservableObject(ExCodePartner);
    expendSlipPartner.bind("change", function( e ) {
        /* 프로젝트 코드 반영 */
        $('#txtSlipPartnerCode').val(this.get('partnerCode'));
        /* 프로젝트 명칭 반영 */
        $('#txtSlipPartnerName').val(this.get('partnerName'));
    });

    /* 지출결의 - 카드 */
    var expendSlipCard = new kendo.data.ObservableObject(ExCodeCard);
    expendSlipCard.bind("change", function( e ) {
        $('#txtSlipCardName').val(this.get('cardName'));
        if(!isDisplayFullNumber){
            $('#txtSlipCardCode').val(this.get('cardNum').replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-****-****-$4"));
            }else{
            	$('#txtSlipCardCode').val(this.get('cardNum'));
            }
    });

    /* 지출결의 - 예산 */
    var expendSlipBudget = new kendo.data.ObservableObject(ExCodeBudget);
    expendSlipBudget.bind("change", function( e ) {
    	$('#txtSlipBudgetCode').val(this.get('budgetCode'));
		$('#txtSlipBudgetName').val(this.get('budgetName'));
		$('#txtSlipBizplanCode').val(this.get('bizplanCode'));
		$('#txtSlipBizplanName').val(this.get('bizplanName'));
		$('#txtSlipBgAcctCode').val(this.get('bgacctCode'));
		$('#txtSlipBgAcctName').val(this.get('bgacctName'));

		var inputChk = '';
		var actSum = Math.floor(Number(this.get('budgetActsum') || '0'));
		var jSum = Math.floor(Number(this.get('budgetJsum') || '0'));

		if (this.get('budgetCode') == '') {
			inputChk += '["<%=BizboxAMessage.getMessage("TX000009523","예산단위 미입력")%>"]';
		}

		if (this.get('bizplanCode') == '') {
			inputChk += '["<%=BizboxAMessage.getMessage("TX000009522","사업계획 미입력")%>"]';
		}

		if (this.get('bgacctCode') == '') {
			inputChk += '["<%=BizboxAMessage.getMessage("TX000009521","예산계정 미입력")%>"]';
		}

		if (inputChk == '') {
			if (this.get('budgetControlYN') == 'Y') {
				$('#divBudgetInfo').text(
						"[<%=BizboxAMessage.getMessage("TX000016494","예산통제")%> / ${CL.ex_budgetBalance} : "
						  // 예산잔액
								+ (actSum - jSum).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ']');
			} else {
				$('#divBudgetInfo').text('["<%=BizboxAMessage.getMessage("TX000009519","예산미통제")%>"]');
			}
		}
    });

    /* 외화계정인지 체크 */
	var isForeignCurrency = false;
	/* 외화정보 담는 변수(분개정보 수정 시 사용) */
    var foreignCurrencyInfo = {}

    /* 문서로드 */
    $(document).ready(function() {
    	/* 회계단위 설정 */
    	if(ifSystem == "ERPiU"){
    		expendSlipUseEmp.set('erpPcSeq', $('#txtExpendPcCode').val())
    		expendSlipUseEmp.set('erpPcName', $('#txtExpendPcName').val())
    	}
    	/*팝업 위치설정*/
		pop_position();
		$(window).resize(function() {
		    pop_position();
		});
    	$('#reqProject').hide();
        $('#reqPartner').hide();
        $('#reqCard').hide();

        fnExpendSlipEventInit();
        fnExpendSlipInit();
        fnSetExOption(option,'slip'); // 지출결의 옵션 설정
        if ('${slipVo.slipSeq}' != '' && '${slipVo.slipSeq}' != '0') {
//             fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.slip}') || '{}')), expendSlip);
//             fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.summary}') || '{}')), expendSlipSummary);
//             fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.auth}') || '{}')), expendSlipAuth);
//             fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.project}') || '{}')), expendSlipProject);
//             fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.partner}') || '{}')), expendSlipPartner);
//             fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.card}') || '{}')), expendSlipCard);
//             fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.emp}') || '{}')),expendSlipUseEmp);
            <c:if test = "${ViewBag.slip ne '' && ViewBag.slip ne null}">
            	fnCopyToBOservalbe(${ViewBag.slip}, expendSlip);
            </c:if>
            <c:if test = "${ViewBag.summary ne '' && ViewBag.summary ne null}">
            	fnCopyToBOservalbe(${ViewBag.summary}, expendSlipSummary);
            </c:if>
            <c:if test = "${ViewBag.auth ne '' && ViewBag.auth ne null}">
            	fnCopyToBOservalbe(${ViewBag.auth}, expendSlipAuth);
            </c:if>
            <c:if test = "${ViewBag.project ne '' && ViewBag.project ne null}">
            	fnCopyToBOservalbe(${ViewBag.project}, expendSlipProject);
            </c:if>
            <c:if test = "${ViewBag.partner ne '' && ViewBag.partner ne null}">
            	fnCopyToBOservalbe(${ViewBag.partner}, expendSlipPartner);
            </c:if>
            <c:if test = "${ViewBag.card ne '' && ViewBag.card ne null}">
            	fnCopyToBOservalbe(${ViewBag.card}, expendSlipCard);
            </c:if>
            <c:if test = "${ViewBag.emp ne '' && ViewBag.emp ne null}">
            	fnCopyToBOservalbe(${ViewBag.emp}, expendSlipUseEmp);
            </c:if>
            // ERPiU인경우에는 budget 정보를 조회한다. (예산정보가 들어가있으므로)
            <c:if test = "${ViewBag.budget ne '' && ViewBag.budget ne null}">
	        	fnCopyToBOservalbe(${ViewBag.budget}, expendSlipBudget);
	        </c:if>
            if(expendSlip.interfaceType == 'card' && expendSlip.interfaceMId != '' && !updateCardAmt){
            	$('#txtSlipAmt, #txtSlipTaxAmt, #txtSlipSubTaxAmt, #txtSlipStdAmt, #txtSlipSubStdAmt').attr('disabled', 'disabled');
            	$('.reqSubAmt').hide();
            }else if(expendSlip.interfaceType == 'etax' && expendSlip.interfaceMId != '' && isInsertSlipMode ){
            	$('#txtSlipAmt, #txtSlipTaxAmt, #txtSlipSubTaxAmt, #txtSlipStdAmt, #txtSlipSubStdAmt').attr('disabled', 'disabled');
            	$('.reqSubAmt').hide();
            }
            feeSeq = expendSlip.feeSeq;
            basicSlipAmt = expendSlip.amt;

			foreignCurrencyInfo.exchangeUnitCode = expendSlip.exchangeUnitCode;
			foreignCurrencyInfo.exchangeUnitName = expendSlip.exchangeUnitName;
			foreignCurrencyInfo.exchangeRate = expendSlip.exchangeRate;
			foreignCurrencyInfo.foreignCurrencyAmount = expendSlip.foreignCurrencyAmount;
			foreignCurrencyInfo.foreignAcctYN = expendSlip.foreignAcctYN;

			if(expendSlip.foreignAcctYN == "Y"){ // 외화계정인 경우
				isForeignCurrency = true;
			}
			$("#hidExpendSlipForeignCurrencyInfo").val(JSON.stringify(foreignCurrencyInfo)); // 외화정보
        } else {
        	<c:if test = "${ViewBag.emp ne '' && ViewBag.emp ne null}">
	        	fnCopyToBOservalbe(${ViewBag.emp}, expendSlipUseEmp);
	        </c:if>
        	<c:if test = "${ViewBag.slip ne '' && ViewBag.slip ne null}">
	        	fnCopyToBOservalbe(${ViewBag.slip}, expendSlip);
	        </c:if>
			<c:if test = "${ViewBag.summary ne '' && ViewBag.summary ne null}">
				fnCopyToBOservalbe(${ViewBag.summary}, expendSlipSummary);
			</c:if>
			<c:if test = "${ViewBag.auth ne '' && ViewBag.auth ne null}">
				fnCopyToBOservalbe(${ViewBag.auth}, expendSlipAuth);
			</c:if>
            expendSlip.set('expendSeq', '${slipVo.expendSeq}');
            expendSlip.set('listSeq', '${slipVo.listSeq}');
            expendSlipUseEmp.set('seq', 0);

            $("#hidExpendSlipForeignCurrencyInfo").val(""); // 외화정보
        }
		/* 계정과목에 따른 필수입력 조회 */
    	fnGetNecessaryOption(expendSlip.acctCode);

		fnSetFocusPrimary(expendSlipAuth);

      	//기본적요 적용()
        fnSetNote();

      	//분개 신규 생성의 경우 사용  ERP Type에 따라 프로젝트, 거래처, 예산단위 표시를 해준다(옵션과 상관없음)
      	if ('${slipVo.slipSeq}' == '' || '${slipVo.slipSeq}' == '0') {
        	fnExpendSlipSetLayout();
      	}else{
      		fnExpendSlipInfoBind();
      	}

      	/* 분개 기본 정보 바인딩 */
      	fnDataSet();

      	/* 첨부파일 바인딩*/
    	fnLoadFileList(JSON.parse('${ViewBag.attach}' || '[]')); /* 첨부파일 바인딩*/
    	/* 기존 첨부파일 정보 바인딩 */
		$("#hidExpendSlipAttachInfo").val( '${ViewBag.expendAttachList}' );
    	//$('#txtSlipAuthDate').focus();

    	/* 테스트 코드 배포 금지 */
   	   	/* 차,대변 합계 금액 산정 */
   		fnSlipShowAdvAmtArea();
   		/* 계속 작성 버튼 이벤트 설정 */
   		fnSetContinusSaveEvent();

		/* 레이어 팝업 사이즈 조절 */
		// fnResizelayer();

		fnSeSlipEmpDeptOptionSet();

        return;
    });

	function fnSetFocusPrimary(obj){
		focus_fnSetprimary('txtSlipAuthDate', obj.authRequiredYN == 'Y');
		focus_fnSetprimary('txtSlipCardName', obj.cardRequiredYN == 'Y');
		focus_fnSetprimary('txtSlipPartnerName', obj.partnerRequiredYN == 'Y');
		focus_fnSetprimary('txtSlipProjectName', obj.projectRequiredYN == 'Y');
	}

    function fnSeSlipEmpDeptOptionSet() {
    	if(expendEmpChange) {
			$('#txtSlipEmpName').removeAttr('disabled');
			$('#btnSlipEmpSearch').show();
    	} else {
			$('#txtSlipEmpName').attr('disabled', 'disabled');
			$('#btnSlipEmpSearch').hide();
    	}

    	if(expendDeptChange) {
			$('#txtSlipDeptName').removeAttr('disabled');
			$('#btnSlipDeptSearch').show();
    	} else {
			$('#txtSlipDeptName').attr('disabled', 'disabled');
			$('#btnSlipDeptSearch').hide();
    	}

    	if(expendEmpDeptLink) {
			$('#txtSlipDeptName').attr('disabled', 'disabled');
			$('#btnSlipDeptSearch').hide();
    	}

    	return;
    }

    /* 레이어 팝업 사이즈 조절 */
    function fnResizelayer(){

        var w = $(document).width() - 100;
        var h = $(document).height() - 100;
    }

    /* 계속작성을 위한 뷰 초기화 */
    function fnViewInitForContinus(){
    	/* 적요 초기화 */
    	$("#txtSlipNote").val(parent.$("#txtExpendBaseNote").val());
    	expendSlip.set('note', '');
    	$('#txtSlipAuthDate').focus();

    	/* 금액 초기화 */
    	$('#txtSlipAmt').val('0');

    	/* 스크롤 초기화 */
    	$('.scroll_y_on').scrollTop(0);
    }

    /* 계속작성 이벤트 구현 */
    function fnSetContinusSaveEvent(){
    	$('#btnSlipContinusSave').click(function(){
    		fnExpendSlipInfoInsert(true); /* 이어서 저장 */
    	});
    }
    /* [테스트] 회사 EXP_iCUBE의 경우 안분상신 테스트 기능 추가 */
    function fnSlipShowAdvAmtArea(){
    	var amtObj = fnGetMasterAMTInfo(0);
    	$('#div_advSlipAmtArea').show();
    	$('#btnSlipContinusSave').show();
    	$('.scroll_y_on').height('297px');
    	$('#txt_slipPop_totalDrAmt').text(amtObj.getDrAmt());
    	$('#txt_slipPop_totalCrAmt').text(amtObj.getCrAmt());
    	$('#txt_slipPop_Difference').text(amtObj.getDrCrDifference());

    	/* 차대변 비교 금액 */
    	if(amtObj.getDrCrMoreItem(true) == 'DR'){
    		$('#txt_drCrMoreItem').text('>').removeClass('text_blue').addClass('text_red');
    		$('#txt_slipPop_Difference').removeClass('text_blue').addClass('text_red');
    	}else if(amtObj.getDrCrMoreItem(true) == 'CR'){
    		$('#txt_drCrMoreItem').removeClass('text_blue').text('<').addClass('text_red');
    		$('#txt_slipPop_Difference').removeClass('text_blue').addClass('text_red');
    	}else{
    		$('#txt_drCrMoreItem').text('=').removeClass('text_red').addClass('text_blue');
    		$('#txt_slipPop_Difference').removeClass('text_red').addClass('text_blue');
    	}
    }


    /* 초기화 */
    function fnExpendSlipInit() {
    	$('#txtSlipAmt, #txtSlipSubStdAmt, #txtSlipSubTaxAmt').maskMoney({
            precision : 0,
            allowNegative: isNegativeAmt
        });

        fnExpendSlipInitLayout();
        fnExpendSlipInitDatepicker();
        return;
    }

    /* 초기화 - layout */
    function fnExpendSlipInitLayout() {
        $('.ExpendSlipBizboxA, .ExpendSlipiCUBE, .ExpendSlipERPiU').hide();
        /* 개발범위 제한으로, [증빙일자, 구분, 계정과목, 부가세구분(세무구분), 프로젝트, 거래처, 카드, 금액] 만 노출 */
        $('.ExpendSlip' + '${ViewBag.ifSystem}' + '.ExpendSlipVatType').hide();
        $('.ExpendSlip' + '${ViewBag.ifSystem}' + '.ExpendSlipProject').show();
        $('.ExpendSlip' + '${ViewBag.ifSystem}' + '.ExpendSlipCard').show();
        $('.ExpendSlip' + '${ViewBag.ifSystem}' + '.ExpendSlipPartner').show();
        $('.ExpendSlipTax').hide();
        return;
    }

    /* 분개 신규 생성 시 초기화 - layout */
    function fnExpendSlipSetLayout() {
    	if(ifSystem == "ERPiU"){
    		$('.ExpendSlipProject').show();
    		$('.ExpendSlipPartner').show();
    		$('.ExpendSlipCard').show();
    		fnSetGridERPiUBudgetObject();
    	}else if(ifSystem == "iCUBE"){
    		$('.ExpendSlipProject').show();
    		$('.ExpendSlipPartner').show();
    		$('.ExpendSlipCard').show();
    	}
        return;
    }

    /* 분개 수정 시 초기화 - layout, Info */
    function fnExpendSlipInfoBind(){

    	if(expendSlip.drcrGbn === 'vat'){
    		$('#txtSlipVatTypeCode').val(expendSlipAuth.vatTypeCode);
    		$('#txtSlipVatTypeName').val(expendSlipAuth.vatTypeName);

    		/* 부가세인 경우 과세표준액과 세액을 입력 가능하게 변경한다. */
    		if(expendSlip.interfaceType == '' || expendSlip.interfaceType == '-' || (expendSlip.interfaceType == 'etax' && isInsertSlipMode == false) || ( expendSlip.interfaceType == 'card' && expendSlip.interfaceMId != '' && updateCardAmt ) ){
    			$('#txtSlipSubTaxAmt').attr("disabled",false);
    			$('#txtSlipSubStdAmt').attr("disabled",false);
        		$('.reqSubAmt').show();
            }


    		$('.ExpendSlipVatType').show();
    		$('#reqVatType').show();
    		if(ifSystem == "iCUBE"){
    			/* 금액 필수값 표시 여부 설정 */
				switch (expendSlipAuth.vatTypeCode) {
					case '24':
						/* 금액 필수 X, 과세표준액, 세액 필수 */
						$("#reqSubAmt, #reqTaxAmt").show();
						$("#reqAmt").hide();
						break;
					case '22':
					case '23':
					case '41':
						/* 금액, 세액 필수 X, 과세표준액 필수 */
						$("#reqSubAmt").show();
						$("#reqAmt, #reqTaxAmt").hide();
						break;
					case '21':
					case '25':
					case '26':
					case '27':
					case '28':
					case '29':
						/* 전부 다 필수 필수 X*/
						$("#reqAmt, #reqSubAmt, #reqTaxAmt").show();
						break;
					default:
						/* 전부 다 필수 필수 X*/
						$("#reqAmt, #reqSubAmt, #reqTaxAmt").hide();
						break;
				}

    			switch (expendSlipAuth.vatTypeCode) {
					case '23':
					case '24':
					case '26':
						// 사유구분 표시
						$('#txtSlipVaCode').val(expendSlipAuth.vaTypeCode);
						$('#txtSlipVaName').val(expendSlipAuth.vaTypeName);
						$(".ExpendVatReason").show();
						$("#expendSlipReqVa").show();
						break;
					default:
						$('#txtSlipVaCode').val('');
						$('#txtSlipVaName').val('');
						$('.ExpendVatReason').hide();
						$("#expendSlipReqVa").hide();
// 						$("#expendListReqVaType").hide();

						break;
				}
    			/* 전자세금계산서 발행 여부 선택 표시 */
				switch (expendSlipAuth.vatTypeCode) {
				/*
					21 : 과세매입
					22 : 영세매입
					23 : 면세매입
					24 : 불공(세금계산서)
					25 : 수입
					위의 경우 전자세금계산서 발행여부 항목을 표시해준다
				*/
					case '21':
					case '22':
					case '23':
					case '24':
					case '25':
						$('.ExpendSlipTax').show();
						$("#divEtaxSendYN").hide();
						/* 전자세금계산서여부 체크 */
						if(expendSlipAuth.etaxYN == 'Y'){
							$("#etaxYN").prop("checked", true);
						}else{
							$("#etaxYN").prop("checked", false);
						}
						break;
					default:
						$('.ExpendSlipTax').hide();
						break;
				}
    		}else if(ifSystem == "ERPiU"){
    			/* 금액 필수값 표시 여부 설정 */
				switch (expendSlipAuth.vatTypeCode) {
					case '22':
					case '50':
						/* 금액 필수 X, 과세표준액, 세액 필수 */
						$("#reqSubAmt, #reqTaxAmt").show();
						$("#reqAmt").hide();
						break;
					case '23':
					case '25':
					case '26':
					case '37':
					case '39':
					case '99':
						/* 금액, 세액 필수 X, 과세표준액 필수 */
						$("#reqSubAmt").show();
						$("#reqAmt, #reqTaxAmt").hide();
						break;
					case '21':
					case '24':
					case '31':
					case '38':
					case '43':
						/* 전부 다 필수 필수 */
						$("#reqAmt, #reqSubAmt, #reqTaxAmt").show();
						break;
					default:
						/* 전부 다 필수 필수 X */
						$("#reqAmt, #reqSubAmt, #reqTaxAmt").hide();
						break;
				}
    			/* 불공인경우 처리 */
				switch (expendSlipAuth.vatTypeCode) {
						case '22':
						case '50':
						// 불공제구분 표시
						$('#txtSlipNoTaxCode').val(expendSlipAuth.noTaxCode);
						$('#txtSlipNoTaxName').val(expendSlipAuth.noTaxName);
						$(".ExpendSlipNoTax").show();
						$("#expendSlipReqNoTax").show();
						break;
					default:
						$('#txtSlipNoTaxCode').val('');
						$('#txtSlipNoTaxName').val('');
						$(".ExpendSlipNoTax").hide();
// 						$('.ExpendListNoTax').hide();
						$("#expendSlipReqNoTax").hide();
						break;
					}

				/*
					21 : 과세(세금계산서)
					22 : 불공(세금계산서)
					23 : 영세(세금계산서)
					26 : 면세(계산서)
					27 : 의제(계산서 2/102)
					29 : 의제(계산서 3/103)
					32 : 의제(계산서 5/105)
					38 : 수입(세금계산서)
					40 : 의제(계산서 6/106)
					43 : 매입자발행세금계산서
					44 : 재활용(계산서 6/106)
					46 : 재활용(계산서 10/110)
					48 : 의제(계산서 8/108)
					51 : 의제(계산서 4/104)
					54 : 재활용(계산서 9/109)
					65 : 재활용(계산서 3/103)
					위의 경우 전자세금계산서 여부 및 11일 전송 여부를 표시한다.
				*/
				switch (expendSlipAuth.vatTypeCode) {
					case '21':
					case '22':
					case '23':
					case '26':
					case '27':
					case '29':
					case '32':
					case '38':
					case '40':
					case '43':
					case '44':
					case '46':
					case '48':
					case '51':
					case '54':
					case '65':
						$('.ExpendSlipTax').show();
						/* 전자세금계산서여부 체크 */
						if(expendSlipAuth.etaxYN == 'Y'){
							$("#etaxYN").prop("checked", true);
						}else{
							$("#etaxYN").prop("checked", false);
						}
						/* 전자세금11일내전송여부 체크 */
						if(expendSlipAuth.etaxSendYN == 'Y' ){
							$("#etaxSendYN").prop("checked", true);
						}else{
							$("#etaxSendYN").prop("checked", false);
						}
						break;
					default:
						$('.ExpendSlipTax').hide();
						break;
				}
				$('.ExpendSlipReqBudget').hide();
				$('.ExpendSlipReqBizplan').hide();
				$('.ExpendSlipReqBgAcct').hide();
    		}


    	}else if(expendSlip.drcrGbn === 'cr'){
    		$('.ExpendSlipReqBudget').hide();
			$('.ExpendSlipReqBizplan').hide();
			$('.ExpendSlipReqBgAcct').hide();
    	}

    	/* 카드사용내역인 경우 카드번호는 무조건 변경 불가, 거래처는 거래처 코드가 없는 경우에만 변경 가능 */
    	if (expendSlip.interfaceType == 'card'){
			$('#txtSlipCardCode, #txtSlipCardName').attr('disabled', 'disabled');
			$('#btnSlipCardSearch').hide();
			/* 카드사용내역인 경우 전자세금계산서 여부가 표시되지 않는다.*/
			$('.ExpendSlipTax').hide();
		}
    	/* 매입전자세금계산서인 경우 거래처는 거래처 코드가 없는 경우에만 변경 가능 */
    	if (expendSlip.interfaceType == 'etax'){
			if(expendSlipPartner.partnerCode != ''){
				$('#txtSlipPartnerCode, #txtSlipPartnerName').attr('disabled', 'disabled');
				$('#btnSlipPartnerSearch').hide();
			}
		}
    	$('.ExpendSlipProject').show();
		$('.ExpendSlipPartner').show();
		$('.ExpendSlipCard').show();

		/* 저장 후 계속 기능 삭제 */
		$('#btnSlipContinusSave').remove();

		type = 'emp';
		target = $('#txtSlipEmpCode, #txtSlipEmpName, #txtSlipDeptCode, #txtSlipDeptName, #txtSlipCcCode, #txtSlipCcName');
		fnSetExpendDispValue(target, expendSlipUseEmp, type); /* 데이터 바인딩 */

		/* 접대비 버튼 노출 처리 */
		if(ifSystem == "ERPiU" && '${ViewBag.isReceptYN}' == 'Y' && ('${ViewBag.empInfo.groupSeq}' == 'visang' || '${ViewBag.empInfo.groupSeq}' == 'demo' || '${ViewBag.empInfo.groupSeq}' == 'portal')){
			$("#btnSlipReceptSearch").parent().show();
		}else{
			$("#btnSlipReceptSearch").parent().hide();
		}
    }

    /* 초기화 - datepicker */
    function fnExpendSlipInitDatepicker() {
        $("#txtSlipAuthDate").kendoDatePicker({
            culture : "ko-KR",
            format : "yyyy-MM-dd",
            change : function() {
            	if(isFirstChange){
	            	/* 날짜 형식 체크 (예를들어 4월 30일 까지 밖에 없는데 4월 31일 입력한 경우)
		     		   예산 사용인 경우 항목이 한 개 이상 존재하면서 년도와 월이 다른 경우는 변경 안됨.
		     		   예산 미사용인 경우 날짜 형식만 맞으면 상관없음.
		     		*/
		     		var authDate = $("#txtSlipAuthDate").val().replace(/-/g, '');
					var year = Number(authDate.substr(0,4));
					var month = Number(authDate.substr(4,2));
					var day = Number(authDate.substr(6,2));
					var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
					var maxDay = maxDaysInMonth[month-1];
					// 윤년 체크
					if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
						maxDay = 29;
					}
					if( day<=0 || day>maxDay || month <= 0 || month > 12){
						var tAuthDate = expendSlip.authDate;
		       	        if(tAuthDate.length == 8 ){
		       	        	tAuthDate = tAuthDate.substr(0,4) + '-' + tAuthDate.substr(4,2) + '-' + tAuthDate.substr(6,2);
		       	        }
		       			$('#txtSlipAuthDate').val(tAuthDate);
					}else{
						/* 증빙일자 마감일 확인 진행 */
						var isClosed = false;
						for( var i = 0 ; i < authDateList.length ; i++){
							var tDate = authDateList[i];
							// 마감 시작일과 종료일 사이에 선택한 회계일자가 있는 경우 입력 제한한다.
							if( tDate.closeFromDate <= authDate && authDate <= tDate.closeToDate ){
								isClosed = true;
								break;
							}
						}

						/* 날짜가 정상인 경우 입력한 회계일자로 설정 */
						if( !isClosed ){
							if(authDate.length == 8){
								focus_fnMoveFocus('txtSlipAuthDate', true);
							}
			                expendSlip.set('authDate', authDate);
						}else{
							alert("등록된 증빙일자가 지출결의 작성 마감 기간에 포함되어 있어 선택이 제한됩니다.");
							var tAuthDate = expendSlip.authDate;
			    	        if(tAuthDate.length == 8 ){
			    	        	tAuthDate = tAuthDate.substr(0,4) + '-' + tAuthDate.substr(4,2) + '-' + tAuthDate.substr(6,2);
			    	        }
			    			$('#txtSlipAuthDate').val(tAuthDate);
						}
		        	}
            	}else{
            		/* 증빙일자 마감일 확인 진행 */
            		var authDate = $("#txtSlipAuthDate").val().replace(/-/g, '');
					var isClosed = false;
					for( var i = 0 ; i < authDateList.length ; i++){
						var tDate = authDateList[i];
						// 마감 시작일과 종료일 사이에 선택한 회계일자가 있는 경우 입력 제한한다.
						if( tDate.closeFromDate <= authDate && authDate <= tDate.closeToDate ){
							isClosed = true;
							break;
						}
					}

					/* 날짜가 정상인 경우 입력한 회계일자로 설정 */
					if( isClosed ){
						alert("등록된 증빙일자가 지출결의 작성 마감 기간에 포함되어 있어 선택이 제한됩니다.");
						var tAuthDate = expendSlip.authDate;
		    	        if(tAuthDate.length == 8 ){
		    	        	tAuthDate = tAuthDate.substr(0,4) + '-' + tAuthDate.substr(4,2) + '-' + tAuthDate.substr(6,2);
		    	        }
		    			$('#txtSlipAuthDate').val(tAuthDate);
					}
            	}
				isFirstChange = false;
            }
        });
        var datePicker = $("#txtSlipAuthDate");
        datePicker.kendoMaskedTextBox({
            mask : '0000-00-00'
        });
        datePicker.closest(".k-datepicker").add(datePicker).removeClass('k-textbox');

        return;
    }

    /* 이벤트 초기화 */
    function fnExpendSlipEventInit() {
        fnExpendSlipEventInitButton();
        fnExpendSlipEventInitFocus();
        fnBindFocusEvent();
        return;
    }

    /* 인풋 포커스 이벤트 바인드 */
    function fnBindFocusEvent(){
    	var datas = [{
	 		id : 'txtSlipAuthDate'
			, isPrimary : true
			, type : 'date'
			, name : ''
   		}, {
   			id : 'division'
			, isPrimary : true
			, type : 'radio'
			, name : 'division'
    	}, {
    		id : 'txtSlipAcctName'
    		, keyId : 'txtSlipAcctCode'
    		, isPrimary : true
    		, type : 'code'
			, code : 'Acct'
    	}, {
    		id : 'txtSlipVatTypeName'
    		, keyId : 'txtSlipVatTypeCode'
    		, isPrimary : true
    		, type : 'code'
   			, code : 'VatType'
    	}, {
    		id : 'txtSlipNoTaxName'
       		, isPrimary : true
       		, type : 'code'
     		, code : 'NoTax'
    	},{
    		id : 'txtSlipVaName'
    		, keyId : 'txtSlipVaCode'
    		, isPrimary : true
    		, type : 'code'
   			, code : 'Va'
    	},{
    		id : 'txtSlipNote'
    	}, {
    		id : 'txtSlipEmpName'
   			, keyId : 'txtSlipEmpCode'
   			, isPrimary : true
   			, type : 'code'
   			, code : 'Emp'
    	},
		/* {
	  		id : 'txtSlipPcName'
  			, keyId : 'txtSlipPcCode'
			, isPrimary : true
			, type : 'code'
			, code : 'Pc'
      	}, */
      	{
	  		id : 'txtSlipCcName'
	  		, keyId : 'txtSlipCcCode'
			, isPrimary : true
			, type : 'code'
			, code : 'Cc'	// 코스트 센터
      	},{
	  		id : 'txtSlipBudgetName'
	  		, keyId : 'txtSlipBudgetCode'
			, isPrimary : isUseBudget
			, type : 'code'
			, code : 'Budget'	// 예산단위
      	},{
	  		id : 'txtSlipBizplanName'
	  		, keyId : 'txtSlipBizplanCode'
			, isPrimary : false
			, type : 'code'
			, code : 'Bizplan'	// 사업계획
      	},{
	  		id : 'txtSlipBgAcctName'
	  		, keyId : 'txtSlipBgAcctCode'
			, isPrimary : isUseBudget
			, type : 'code'
			, code : 'BgAcct'	// 예산 계정
      	},{
    		id : 'txtSlipProjectName'
       		, isPrimary : false
       		, type : 'code'
       		, code : 'Project'
    	}, {
    		id : 'txtSlipCardName'
    		, isPrimary : false
    		, type : 'code'
    		, code : 'Card'
    	}, {
    		id : 'txtSlipPartnerName'
    		, isPrimary : false
    		, type : 'code'
    	    , code : 'Partner'
    	}, {
			id : 'txtSlipAmt'
    	}];
    	focus_fnSetFocusAction(datas);
    }

    /* 이벤트 초기화 - 버튼 */
    function fnExpendSlipEventInitButton() {

    	/* [닫기] 분개 추가 팝업 esc 키 이벤트 */
    	$(document).keydown(function(event){
    		if(event.which == 27) {
    			$('#btnSlipClose').click();
    		}
    	});

    	/* [저장] shift + enter 이어서 저장, enter 저장 이벤트 등록  */
    	$('#txtSlipAmt').keydown(function(event){

    		if(event.shiftKey && event.keyCode == 13) {
                if ($(this).val()) {
                	$('#btnSlipContinusSave').click();
                }
            }
            /* 엔터입력 이벤트 적용 */
            if ((!event.shiftKey) && event.keyCode == 13) {
                if ($(this).val()) {
                	$('#btnSlipSave').click();
                }
            }
            return;
        }); /* 증빙일자 */

        /* [데이트 피커] 데이트 피커 엔터 이벤트 등록 */
        $('#txtSlipAuthDate').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.keyCode == 13 || event.keyCode == 113) {
                if ($(this).val() == '____-__-__' || $(this).val() == '') {
                    $(this).next('.k-select').click();
                } else {
                	isFirstChange = true;
                	$('#txtSlipAuthDate').data("kendoDatePicker").trigger("change");
                	fnSetFocus();
                }
            }
            return;
        }); /* 증빙일자 */

        $('#division1').change(function() {
            if ($(this).is(':checked')) {
                if (expendSlip.get('vatYN') == 'Y') {
                    expendSlip.set('drcrGbn', 'vat');
                    $('.ExpendSlipReqBudget').hide();
					$('.ExpendSlipReqBizplan').hide();
					$('.ExpendSlipReqBgAcct').hide();
                } else {
                    expendSlip.set('drcrGbn', 'dr');
                }

                /* 차대변별 필수 입력 변경 */
                fnGetNecessaryOption();
            }
        });
        $('#division1').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.keyCode == 13) {
                if ($(this).is(':checked')) {
                    expendSlip.set('drcrGbn', 'dr');
                }
                fnSetFocus();
            }
            return;
        }); /* 구분 - 차변 */

        $('#division2').change(function() {
            if ($(this).is(':checked')) {
                expendSlip.set('drcrGbn', 'cr');
                $('.ExpendSlipReqBudget').hide();
				$('.ExpendSlipReqBizplan').hide();
				$('.ExpendSlipReqBgAcct').hide();
            }

            /* 차대변별 필수 입력 변경 */
            fnGetNecessaryOption();
        });
        $('#division2').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.keyCode == 13) {
                if ($(this).is(':checked')) {
                    expendSlip.set('drcrGbn', 'cr');
                }
                fnSetFocus();
            }
            return;
        }); /* 구분 - 대변 */

        /* 계정과목, 세무구분, 사유구분, 불공제구분, 프로젝트, 카드, 거래처, 예산단위, 사업계획, 예산단위 */
        $('#btnSlipAcctSearch, #btnSlipVatTypeSearch, #btnSlipVaSearch, #btnSlipNoTaxSearch, #btnSlipProjectSearch, #btnSlipCardSearch'
        		+ ', #btnSlipPartnerSearch, #btnSlipBudgetSearch, #btnSlipBizplanSearch, #btnSlipBgAcctSearch, #btnSlipEmpSearch'
        		+ ', #btnSlipDeptSearch,#btnSlipPcSearch,#btnSlipCcSearch').click(function() {
   			var btnType = $(this).attr('id').replace('btnSlip','').replace('Search','');
           	fnOpenCommonCodePop(false, btnType);
        });
        $('#txtSlipAcctName, #txtSlipVatTypeName, #txtSlipVaName, #txtSlipNoTaxName, #txtSlipProjectName, #txtSlipCardName'
        		+ ', #txtSlipPartnerName, #txtSlipBudgetName, #txtSlipBizplanName, #txtSlipBgAcctName, #txtSlipEmpName, #txtSlipDeptName'
        		+ ', #txtSlipCcName').keydown(function(event){
            /* f2입력 이벤트 적용 */
            if (event.keyCode == 113) {
            	var txtType = $(this).attr('id').replace('txtSlip','').replace('Name','');
    			fnOpenCommonCodePop(true, txtType);
            }else if( (event.keyCode == 8) || ( ( event.keyCode != 13 ) && (event.keyCode > 45 ) ) ){
            	/* 뷰모델 정보 변경 감지 */
            	var id = $(this).attr('id');
            	if(id == 'txtSlipAcctName'){
            		isForeignCurrency = false;
            		// maskMoney 다시 활성화
            		$('#txtSlipAmt').maskMoney({
			            precision : 0,
			            allowNegative: isNegativeAmt
			        });
            	}

            	/* ERPiU 00 거래처인 경우 거래처 명만 변경되야함. 2018. 03. 29 - 신재호 수정 */
            	if(!(ifSystem == 'ERPiU' && id == 'txtSlipPartnerName' && $("#txtSlipPartnerCode").val() == '00')){
            		id = id.replace('Name', 'Code');
                	$('#' + id).val('');
            	}
            }
            return;
        });

        /* 저장 */
        $('#btnSlipSave').click(function() {
            fnExpendSlipInfoInsert(false); /* 저장 */
        });

        /* 취소 */
        $('#btnSlipClose').click(function() {
            fnExpendSlipPopClose(); /* 취소 */
        });

        /* 접대비 등록 팝업 */
        $("#btnSlipReceptSearch").click(function(){
        	fnOpenEntertainmentFeePop( );
        });

     	// 외화입력 팝업 오픈
		$("#txtSlipAmt").click(function(){
			if(isForeignCurrency){
		 		fnExForeignCurrencyInputPopup();
		 	}
		});

		$("#txtSlipNote").keyup(function(e){
			var NoteContent = $(this).val();
			if(NoteContent.length >= 100){
				alert('글자수 제한(100byte)을 초과하였습니다.');
				return  $(this).val(NoteContent.substring(0, 100));
			}
		});

        return;
    }

    function fnExpendSlipEventInitFocus(){
    	$('#txtSlipAcctName, #txtSlipVatTypeName, #txtSlipVaName, #txtSlipNoTaxName, #txtSlipProjectName, #txtSlipCardName'
        		+ ', #txtSlipPartnerName, #txtSlipBudgetName, #txtSlipBizplanName, #txtSlipBgAcctName').focusout(function(event){
			var txtType = $(this).attr('id').replace('txtSlip','').replace('Name','').toLowerCase();
			fnIsDeleteItem(txtType);
   		});
    }

    /* 분개 추가 시 기본 데이터 매핑 */
    function fnDataSet(){
    	/* 사용자 분개단위 입력인 경우 기본 로그인한 사용자의 정보 표시 */
      	$('#txtSlipEmpCode').val(expendSlipUseEmp.erpEmpSeq);
      	$('#txtSlipEmpName').val(expendSlipUseEmp.erpEmpName);
      	$('#txtSlipDeptCode').val(expendSlipUseEmp.erpDeptSeq);
      	$('#txtSlipDeptName').val(expendSlipUseEmp.erpDeptName);
      	/* $('#txtSlipPcCode').val(expendSlipUseEmp.erpPcSeq); */
      	/* $('#txtSlipPcName').val(expendSlipUseEmp.erpPcName); */
      	$('#txtSlipCcCode').val(expendSlipUseEmp.erpCcSeq);
      	$('#txtSlipCcName').val(expendSlipUseEmp.erpCcName);
      	if(expendSlip.slipSeq == '0'){
	      	/* 프로젝트 문서단위 입력인 경우 문서에 있는 프로젝트 정보를 기본값으로 설정 */
	      	if( expendProject.projectCode && expendProject.projectCode != '' && expendProject.projectCode != '0'
	      			&& $(".ExpendProject").css("display") != 'none'){
	      		expendSlipProject = expendProject;
	      		$('#txtSlipProjectCode').val(expendSlipProject.projectCode);
	      		$('#txtSlipProjectName').val(expendSlipProject.projectName);
	      	}
	      	/* 거래처 문서단위 입력인 경우 문서에 있는 거래처 정보를 기본값으로 설정 */
	      	if( expendPartner.partnerCode && expendPartner.partnerCode != '' && expendPartner.partnerCode != '0'
	      		&& $(".ExpendPartner").css("display") != 'none'){
	      		expendSlipPartner = expendPartner;
	      		$('#txtSlipPartnerCode').val(expendPartner.partnerCode);
	      		$('#txtSlipPartnerName').val(expendPartner.partnerName);
	      	}
	      	/* 카드 문서단위 입력인 경우 문서에 있는 카드 정보를 기본값으로 설정 */
	      	if( expendCard.cardCode && expendCard.cardCode != '' && expendCard.cardCode != '0' && $(".ExpendCard").css("display") != 'none'){
	      		expendSlipCard = expendCard;
	      		$('#txtSlipCardCode').val(expendSlipCard.cardCode);
	      		$('#txtSlipCardName').val(expendSlipCard.cardName);
	      	}
      	}
    }

    /* 팝업 호출 */
    function fnOpenCommonCodePop(input, codeType){
    	var searchStr = $("#txtSlip" + codeType + "Name").val();
		if(codeType === 'Notax'){
			codeType = 'NoTax';
		}
		if(input){
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnExpendSlipCallback',
				searchStr : searchStr,
				erp_emp_seq : (expendSlipUseEmp.erpEmpSeq || 0),
				budget_code : ($("#txtSlipBudgetCode").val() || ''),
				bizplan_code : ($('#txtSlipBizplanCode').val() || '***'),
				acct_code : ($('#txtSlipAcctCode').val() || ''),
				vat_type : ($('#txtSlipVatTypeCode').val() || ''),
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				formSeq : expend.formSeq,
				codeSortType : codeSortType
			});
		}else{ // 찾기 버튼으로 호출하는 경우
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnExpendSlipCallback',
				searchStr : '',
				erp_emp_seq : (expendSlipUseEmp.erpEmpSeq || 0),
				budget_code : ($("#txtSlipBudgetCode").val() || ''),
				bizplan_code : ($('#txtSlipBizplanCode').val() || '***'),
				acct_code : ($('#txtSlipAcctCode').val() || ''),
				vat_type : ($('#txtSlipVatTypeCode').val() || ''),
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				formSeq : expend.formSeq,
				codeSortType : codeSortType
			});
		}
	}

    /* 공통코드 팝업 콜백 */
    function fnExpendSlipCallback(param) {
    	var target;
		var type = param.type;
		var elemId = '';
		switch (type) {
			case "acct":
				elemId = 'txtSlipAcctName';
				fnCopyToBOservalbe(param.obj, expendSlipAcct);
				$('#txtSlipAcctName').val(param.obj.acctName);
				$('#txtSlipAcctCode').val(param.obj.acctCode);
				expendSlip.acctCode = param.obj.acctCode;
				expendSlip.acctName = param.obj.acctName;
				fnGetNecessaryOption(param.obj.acctCode);
				if(param.obj.vatYN === 'Y'){
					$('.ExpendSlipVatType').show();
					$('#reqVatType').show();
					$('.ExpendSlipReqBudget').hide();
					$('.ExpendSlipReqBizplan').hide();
					$('.ExpendSlipReqBgAcct').hide();

					expendSlip.drcrGbn = 'vat';
					expendSlipAuth.vatAcctCode = param.obj.acctCode;
					expendSlipAuth.vatAcctName = param.obj.acctName;
					/* 부가세인 경우 과세표준액과 세액을 입력 가능하게 변경한다. */
					$('#txtSlipSubTaxAmt').attr("disabled",false);
					$('#txtSlipSubStdAmt').attr("disabled",false);
					$('.reqSubAmt').show();
					if (expendSlip.interfaceType != 'card'){
						/* 카드사용내역인 경우 전자세금계산서 여부가 표시되지 않는다.*/
						$('.ExpendSlipTax').show();
					}else{
						$('.ExpendSlipTax').hide();
					}
					if( ifSystem === 'ERPiU' ){
						$("#divEtaxSendYN").show();
					}else{
						$("#divEtaxSendYN").hide();
					}
				}else{
// 					console.log('param.obj.vatYN : ' + param.obj.vatYN);
					$('.ExpendSlipVatType').hide();
					$('#reqVatType').hide();

					$('.ExpendSlipNoTax').hide();
					$('#expendSlipReqNoTax').hide();
					$('.ExpendSlipTax').hide();
					if($('#division1').is(':checked')){ // 차변 체크인 경우
						if( ifSystem === 'ERPiU' ){
							fnSetGridERPiUBudgetObject();

							/* 사유구분 초기화 */
							$('#txtSlipNoTaxCode').val('');
							$('#txtSlipNoTaxName').val('');
							$('.ExpendSlipNoTax').hide();
							$("#expendSlipReqNoTax").hide();

							/* 세무구분 초기화 */
							$('#txtSlipVatTypeCode').val('');
							$('#txtSlipVatTypeName').val('');

						}else if( ifSystem === 'iCUBE' ){
							expendSlipAuth.bgacctCode = '';
							expendSlipAuth.bgacctName = '';
							expendSlipBudget.bgacctCode = param.obj.acctCode;
							expendSlipBudget.bgacctName = param.obj.acctName;

							/* 세무구분 초기화 */
							$('#txtSlipVatTypeCode').val('');
							$('#txtSlipVatTypeName').val('');

							/* 사유구분 초기화 */
							$('#txtSlipVaCode').val('');
							$('#txtSlipVaName').val('');
							$('.ExpendVatReason').hide();
							$("#expendSlipReqVa").hide();
						}
					}
					/* 부가세를 제외하면 과세표준액과 세액은 입력을 막는다. */
					$('#txtSlipSubTaxAmt').attr("disabled",true);
					$('#txtSlipSubStdAmt').attr("disabled",true);
					$('.reqSubAmt').hide();
				}

				if(expendSlip.interfaceType == 'etax' && expendSlip.interfaceMId != '' && isInsertSlipMode == true){
	            	$('#txtSlipAmt, #txtSlipTaxAmt, #txtSlipSubTaxAmt, #txtSlipStdAmt, #txtSlipSubStdAmt').attr('disabled', 'disabled');
	            	$('.reqSubAmt').hide();
	            }

				/* 접대비 유무 확인 */
				/* ERPiU에서 해당 계정과목이 접대비인지 아닌지 확인 진행 */
				if (ifSystem === 'ERPiU'){
					var ajaxParam = {};
					ajaxParam.acctCode = param.obj.acctCode;
					$.ajax({
						type : 'post',
						url : '<c:url value="/ex/expend/user/ChkAcctReceptYN.do" />',
			            datatype : 'json',
			            async : false,
			            data : ajaxParam,
						success: function(data){
							 if(data.result.resultCode == "SUCCESS"){
								 if( ('${ViewBag.empInfo.groupSeq}' == 'visang' || '${ViewBag.empInfo.groupSeq}' == 'demo' || '${ViewBag.empInfo.groupSeq}' == 'portal') && data.result && data.result.aaData && data.result.aaData.size > 0 && data.result.aaData[0].receptYN == 'Y' ){
									 $("#btnSlipReceptSearch").parent().show();
								 }else{
									 $("#btnSlipReceptSearch").parent().hide();
									 feeSeq = 0;
								 }
							 }else{
								$("#btnSlipReceptSearch").parent().hide();
								feeSeq = 0;
							 }
						},
						error : function(data){

						}
					});
				}else{
					$("#btnListReceptSearch").parent().hide();
					feeSeq = 0;
				}

				// 외화계정인지 확인
				fnCheckForeignCurrencyAcctCode();

				break;
			case "vattype":
				elemId = 'txtSlipVatTypeName';
				$('#txtSlipVatTypeName').val(param.obj.vatTypeName);
				$('#txtSlipVatTypeCode').val(param.obj.vatTypeCode);
				fnCopyToBOservalbe(param.obj, expendSlipAuth);

				/* 불공 처리 */
				if(ifSystem == "iCUBE"){
					/* 금액 필수값 표시 여부 설정 */
					switch (param.obj.vatTypeCode) {
						case '24':
							/* 금액 필수 X, 과세표준액, 세액 필수 */
							$("#reqSubAmt, #reqTaxAmt").show();
							$("#reqAmt").hide();
							break;
						case '22':
						case '23':
						case '41':
							/* 금액, 세액 필수 X, 과세표준액 필수 */
							$("#reqSubAmt").show();
							$("#reqAmt, #reqTaxAmt").hide();
							break;
						case '21':
						case '25':
						case '26':
						case '27':
						case '28':
						case '29':	
							/* 전부 다 필수 필수 X*/
							$("#reqAmt, #reqSubAmt, #reqTaxAmt").show();
							break;
						default:
							/* 전부 다 필수 필수 X*/
							$("#reqAmt, #reqSubAmt, #reqTaxAmt").hide();
							break;
					}

					switch (param.obj.vatTypeCode) {
						case '23':
						case '24':
						case '26':
							// 사유구분 표시
							$('#txtSlipVaCode').val(param.obj.vaTypeCode);
							$('#txtSlipVaName').val(param.obj.vaTypeName);
							$(".ExpendVatReason").show();
							$("#expendSlipReqVa").show();
							break;
						default:
							$('#txtSlipVaCode').val('');
							$('#txtSlipVaName').val('');
							$('.ExpendVatReason').hide();
							$("#expendSlipReqVa").hide();
							break;
					}

	    			/* 전자세금계산서 발행 여부 선택 표시 */
					switch (param.obj.vatTypeCode) {
					/*
						21 : 과세매입
						22 : 영세매입
						23 : 면세매입
						24 : 불공(세금계산서)
						25 : 수입
						위의 경우 전자세금계산서 발행여부 항목을 표시해준다
					*/
						case '21':
						case '22':
						case '23':
						case '24':
						case '25':
							if (expendSlip.interfaceType != 'card'){
								/* 카드사용내역인 경우 전자세금계산서 여부가 표시되지 않는다.*/
								$('.ExpendSlipTax').show();
							}else{
								$('.ExpendSlipTax').hide();
							}
							$("#divEtaxSendYN").hide();
							$("#etaxYN").prop("checked", true);
							break;
						default:
							$('.ExpendSlipTax').hide();
							break;
					}
	    		}else if(ifSystem == "ERPiU"){
	    			/* 금액 필수값 표시 여부 설정 */
					switch (param.obj.vatTypeCode) {
						case '22':
						case '50':
							/* 금액 필수 X, 과세표준액, 세액 필수 */
							$("#reqSubAmt, #reqTaxAmt").show();
							$("#reqAmt").hide();
							break;
						case '23':
						case '25':
						case '26':
						case '37':
						case '39':
						case '99':
							/* 금액, 세액 필수 X, 과세표준액 필수 */
							$("#reqSubAmt").show();
							$("#reqAmt, #reqTaxAmt").hide();
							break;
						case '21':
						case '24':
						case '31':
						case '38':
						case '43':
							/* 전부 다 필수 필수 */
							$("#reqAmt, #reqSubAmt, #reqTaxAmt").show();
							break;
						default:
							/* 전부 다 필수 필수 X */
							$("#reqAmt, #reqSubAmt, #reqTaxAmt").hide();
							break;
					}

	    			/* 불공인경우 처리 */
					switch (param.obj.vatTypeCode) {
						case '22':
						case '50':
						// 불공제구분 표시
						$('#txtSlipNoTaxCode').val(param.obj.noTaxCode);
						$('#txtSlipNoTaxName').val(param.obj.noTaxName);
						$(".ExpendSlipNoTax").show();
						$("#expendSlipReqNoTax").show();
						break;
					default:
						$('#txtSlipNoTaxCode').val('');
						$('#txtSlipNoTaxName').val('');
						$('.ExpendSlipNoTax').hide();
						$("#expendSlipReqNoTax").hide();
						break;
					}

					/*
						21 : 과세(세금계산서)
						22 : 불공(세금계산서)
						23 : 영세(세금계산서)
						26 : 면세(계산서)
						27 : 의제(계산서 2/102)
						29 : 의제(계산서 3/103)
						32 : 의제(계산서 5/105)
						38 : 수입(세금계산서)
						40 : 의제(계산서 6/106)
						43 : 매입자발행세금계산서
						44 : 재활용(계산서 6/106)
						46 : 재활용(계산서 10/110)
						48 : 의제(계산서 8/108)
						51 : 의제(계산서 4/104)
						54 : 재활용(계산서 9/109)
						65 : 재활용(계산서 3/103)
						위의 경우 전자세금계산서 여부 및 11일 전송 여부를 표시한다.
					*/
					switch (param.obj.vatTypeCode) {
						case '21':
						case '22':
						case '23':
						case '26':
						case '27':
						case '29':
						case '32':
						case '38':
						case '40':
						case '43':
						case '44':
						case '46':
						case '48':
						case '51':
						case '54':
						case '65':
							if (expendSlip.interfaceType != 'card'){
								/* 카드사용내역인 경우 전자세금계산서 여부가 표시되지 않는다.*/
								$('.ExpendSlipTax').show();
							}else{
								$('.ExpendSlipTax').hide();
							}
							$("#etaxYN").prop("checked", true);
							$("#etaxSendYN").prop("checked", true);
							break;
						default:
							$('.ExpendSlipTax').hide();
							break;
					}
	    		}
				break;
			case "va":
				elemId = 'txtSlipVaName';
				expendSlipAuth.vaTypeCode = param.obj.vaTypeCode;
				expendSlipAuth.vaTypeName = param.obj.vaTypeName;
				fnCopyToBOservalbe(param.obj, expendSlipAuth);
				$('#txtSlipVaCode').val(param.obj.vaTypeCode);
				$('#txtSlipVaName').val(param.obj.vaTypeName);
				break;
			case "notax":
				elemId = 'txtSlipNoTaxName';
				expendSlipAuth.noTaxCode = param.obj.noTaxCode;
				expendSlipAuth.noTaxName = param.obj.noTaxName;
				fnCopyToBOservalbe(param.obj, expendSlipAuth);
				$('#txtSlipNoTaxCode').val(param.obj.noTaxCode);
				$('#txtSlipNoTaxName').val(param.obj.noTaxName);
				break;
			case "project":
				elemId = 'txtSlipProjectName';
				fnCopyToBOservalbe(param.obj, expendSlipProject);
				expendProject.projectCode = param.obj.projectCode;
				expendProject.projectName = param.obj.projectName;
				$('#txtSlipProjectCode').val(param.obj.projectCode);
				$('#txtSlipProjectName').val(param.obj.projectName);
				break;
			case "card":
				elemId = 'txtSlipCardName';
				fnCopyToBOservalbe(param.obj, expendSlipCard);
				$('#txtSlipCardCode').val(param.obj.cardCode);
				$('#txtSlipCardName').val(param.obj.cardName);
				break;
			case "partner":
				elemId = 'txtSlipPartnerName';
				fnCopyToBOservalbe(param.obj, expendSlipPartner);
				$('#txtSlipPartnerCode').val(param.obj.partnerCode);
				$('#txtSlipPartnerName').val(param.obj.partnerName);
				break;
			case "budget":
				elemId = 'txtSlipBudgetName';
				fnCopyToBOservalbe(param.obj, expendSlipBudget);
				if( ifSystem === 'ERPiU' ){
					expendSlipBudget.budgetCode = param.obj.budgetCode;
					expendSlipBudget.budgetName = param.obj.budgetName;

					/* 2019-01-09 김상겸 : 예산단위 선택 시 사업계획 및 예산계정 초기화 ( ERPiU만 해당 ) */
					expendSlipBudget.bizplanCode = '';
					expendSlipBudget.bizplanName = '';
					$('#txtSlipBizplanCode').val('');
					$('#txtSlipBizplanName').val('');

					expendSlipBudget.bgacctCode = '';
					expendSlipBudget.bgacctName = '';
					$('#txtSlipBgAcctCode').val('');
					$('#txtSlipBgAcctName').val('');
				}
				$('#txtSlipBudgetCode').val(param.obj.budgetCode);
				$('#txtSlipBudgetName').val(param.obj.budgetName);
				break;
			case "bizplan":
				elemId = 'txtSlipBizplanName';
				fnCopyToBOservalbe(param.obj, expendSlipBudget);
				if( ifSystem === 'ERPiU' ){
					expendSlipBudget.bizplanCode = param.obj.bizplanCode;
					expendSlipBudget.bizplanName = param.obj.bizplanName;

					/* 2019-01-09 김상겸 : 사업계획 예산단위 선택 시 예산계정 초기화 ( ERPiU만 해당 ) */
					expendSlipBudget.bgacctCode = '';
					expendSlipBudget.bgacctName = '';
					$('#txtSlipBgAcctCode').val('');
					$('#txtSlipBgAcctName').val('');
				}
				$('#txtSlipBizplanCode').val(param.obj.bizplanCode);
				$('#txtSlipBizplanName').val(param.obj.bizplanName);
				break;
			case "bgacct":
				elemId = 'txtSlipBgAcctName';
				fnCopyToBOservalbe(param.obj, expendSlipBudget);
				if( ifSystem === 'ERPiU' ){
					expendSlipBudget.bgacctCode = param.obj.bgacctCode;
					expendSlipBudget.bgacctName = param.obj.bgacctName;
				}
				$('#txtSlipBgAcctCode').val(param.obj.bgacctCode);
				$('#txtSlipBgAcctName').val(param.obj.bgacctName);
				break;
			case "emp":
				elemId = 'txtSlipEmpName';
				$('#txtSlipEmpCode').val(param.obj.erpEmpSeq);
		      	$('#txtSlipEmpName').val(param.obj.erpEmpName);
		      	$('#txtSlipDeptCode').val(param.obj.erpDeptSeq);
		      	$('#txtSlipDeptName').val(param.obj.erpDeptName);
		      	/* $('#txtSlipPcCode').val(param.obj.erpPcSeq); */
		      	/* $('#txtSlipPcName').val(param.obj.erpPcName); */
		      	$('#txtSlipCcCode').val(param.obj.erpCcSeq);
		      	$('#txtSlipCcName').val(param.obj.erpCcName);
				fnCopyToBOservalbe(param.obj, expendSlipUseEmp);
				// 사업장, 부서, 코스트센터, 회계단위
	            if( expendSlipUseEmp.erpBizSeq === '0' || expendSlipUseEmp.erpBizSeq === '' ){
	            	alert("<%=BizboxAMessage.getMessage("TX000018785","작성자의 사업장이 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
	            }
	            if( expendSlipUseEmp.erpDeptSeq === '0' || expendSlipUseEmp.erpDeptSeq === '' ){
	            	alert("<%=BizboxAMessage.getMessage("TX000018788","작성자의 부서가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
	            }
	            if( ifSystem === 'ERPiU'){
	            	if( expendSlipUseEmp.erpCcSeq === '0' || expendSlipUseEmp.erpCcSeq === '' ){
	            		alert("<%=BizboxAMessage.getMessage("TX000018789","작성자의 코스트센터가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
	                }
	            	<%-- if( expendSlipUseEmp.erpPcSeq === '0' || expendSlipUseEmp.erpPcSeq === '' ){
	            		alert("<%=BizboxAMessage.getMessage("TX000018790","작성자의 회계단위가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
	                } --%>
	            }
				expendSlipUseEmp.seq = 0;
				break;
			/* case "pc":
				elemId = 'txtSlipPcName';
				$('#txtSlipPcCode').val(param.obj.erpPcSeq);
		      	$('#txtSlipPcName').val(param.obj.erpPcName);
				fnCopyToBOservalbe(param.obj, expendSlipUseEmp);
				break; */
			case "cc":
				elemId = 'txtSlipCcName';
				$('#txtSlipCcCode').val(param.obj.erpCcSeq);
		      	$('#txtSlipCcName').val(param.obj.erpCcName);
				fnCopyToBOservalbe(param.obj, expendSlipUseEmp);
				break;
				/*
				2021-10-13 정성일 수정
				예산연동 여부 상관없이 분개정보 부서수정가능하도록 수정
				*/
			case "dept": 
				$('#txtSlipDeptName').val(param.obj.erpDeptName);
				$('#txtSlipDeptCode').val(param.obj.erpDeptSeq);
				expendSlipUseEmp.set('erpDeptName', $('#txtSlipDeptName').val());
				expendSlipUseEmp.set('erpDeptSeq', $('#txtSlipDeptCode').val());
				break;
		}
		// fnSetFocus();
		focus_fnMoveFocus(elemId, true);
    }

    function fnChekInputDate(){
		if($("#reqAuthDate").css("display")!= 'none'){
			if($("#txtSlipAuthDate").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018792","증빙일자가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		if($("#reqDrCrGbn").css("display")!= 'none'){
			if(!$('#division1').is(':checked') && !$('#division2').is(':checked')){
				alert("<%=BizboxAMessage.getMessage("TX000018793","차대변 구분을 선택하지 않았습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		if($("#reqAcct").css("display")!= 'none'){
			if($("#txtSlipAcctCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018794","계정과목이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		if($("#reqVatType").css("display")!= 'none' && $('.ExpendSlipVatType').css("display") != 'none'){
			if($("#txtSlipVatTypeCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018795","세무구분이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		if($("#expendSlipReqVa").css("display")!= 'none' && $('.ExpendVatReason').css("display") != 'none'){
			if($("#txtSlipVaCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018796","사유구분이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		if($("#expendSlipReqNoTax").css("display")!= 'none' && $('.ExpendSlipNoTax').css("display") != 'none'){
			if($("#txtSlipNoTaxCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018797","불공제구분이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		if($("#reqProject").css("display")!= 'none'){
			if($("#txtSlipProjectCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018800","프로젝트가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#reqCard").css("display")!= 'none'){
			if($("#txtSlipCardCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018801","카드가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#reqPartner").css("display")!= 'none'){
			if($("#txtSlipPartnerCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018802","거래처가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		/* iCUBE인 경우 세무구분이 존재하면 무조건 0원 입력 안되게 설정. */
		if( ifSystem == 'iCUBE' && expendSlip.drcrGbn == 'vat' ){
			if( $("#reqAmt").css("display")!= 'none'){
				if( $("#txtSlipAmt").val() === '0' || $("#txtSlipAmt").val() === '' ){
					alert("<%=BizboxAMessage.getMessage("TX000018803","금액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#reqSubAmt").css("display")!= 'none'){
				if($("#txtSlipSubStdAmt").val() === '' || $("#txtSlipSubStdAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("","과세표준액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#reqTaxAmt").css("display")!= 'none'){
				if($("#txtSlipSubTaxAmt").val() === '' || $("#txtSlipSubTaxAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("","세액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
		}
		/* ERPiU의 경우 0원 입력이 불가 */
		if(ifSystem == 'ERPiU'){
			if( expendSlip.drcrGbn == 'vat' ){
				if( $("#reqAmt").css("display")!= 'none'){
					if( $("#txtSlipAmt").val() === '0' || $("#txtSlipAmt").val() === '' ){
						alert("<%=BizboxAMessage.getMessage("TX000018803","금액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
						return false;
					}
				}
				if($("#reqSubAmt").css("display")!= 'none'){
					if($("#txtSlipSubStdAmt").val() === '' || $("#txtSlipSubStdAmt").val() === '0'){
						alert("<%=BizboxAMessage.getMessage("","과세표준액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
						return false;
					}
				}
				if($("#reqTaxAmt").css("display")!= 'none'){
					if($("#txtSlipSubTaxAmt").val() === '' || $("#txtSlipSubTaxAmt").val() === '0'){
						alert("<%=BizboxAMessage.getMessage("","세액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
						return false;
					}
				}
			}else{
				if( $("#txtSlipAmt").val() === '0' || $("#txtSlipAmt").val() === '' ){
					alert("<%=BizboxAMessage.getMessage("TX000018803","금액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
		}


		if(ifSystem === 'ERPiU'){
			if($("#expendSlipReqBudget").css("display")!= 'none' && $(".ExpendSlipReqBudget").css("display") != 'none'){
				if($("#txtSlipBudgetCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018804","예산단위가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendSlipReqBizplan").css("display")!= 'none' && $(".ExpendSlipReqBizplan").css("display") != 'none'){
				if($("#txtSlipBizplanCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018805","사업정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendSlipReqBgAcct").css("display")!= 'none' && $(".ExpendSlipReqBgAcct").css("display") != 'none'){
				if($("#txtSlipBgAcctCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018806","예산계정이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
		}
		return true;
	}

    /* 이벤트 초기화 - 버튼 - 저장 */
    function fnExpendSlipInfoInsert(continus) {
    	//유효성 검사
    	/* 필수값 체크 */
		if(!fnChekInputDate()){
			fnSetFocus();
			return false;
		}

    	/* 분개 차변 예산정보 체크 */
		if (skipBudgetCheck != "1") {
			if (!fnExpendBudgetCheck()) {
				return false;
			}
		}
		continus = continus || false;

		/* 안분상신 최종 컨펌 */
    	var amtObj = fnGetMasterAMTInfo(expendSlip.amt);
    	if($('#division1').is(":checked", true)){
    		amtObj.addDrAmt($('#txtSlipAmt').val().toString().replace(/,/g,''));
    	}else {
    		amtObj.addCrAmt($('#txtSlipAmt').val().toString().replace(/,/g,''));
    	}
    	if(!continus && (amtObj.getDrCrMoreItem() != '')){
			if(!confirm(amtObj.getDrCrDifferenceCopy())){
				return;
			}
    	}

		var deleteFileInfo =[];
		/* 첨부파일 업로드 및 콜백 */
	    if($("#uploaderView")[0].contentWindow.hasOwnProperty('fnAttFileUpload')) //GW가 서버에 올라가 있지 않으면 패스.. 첨부 불가
		{
       		if(!$("#uploaderView")[0].contentWindow.fnAttFileUpload())
       		{
    	  	 	$("#uploaderView")[0].contentWindow.UploadCallback = "fnCallbackFileIdList("+continus+")";
    	   		return;
      	 	}

       		var modify_file_list = {};
       		modify_file_list = $("#uploaderView")[0].contentWindow.fnAttFileList();
       		//삭제여부 확인
       		if(modify_file_list.deletefilelist.length > 0)
       		{
       			var del_file_name = new Array();
           		var del_file_key = new Array();

	       		del_file_name = modify_file_list.deletefilelist.split('|');
	       		del_file_key = modify_file_list.deletekeylist.split('|');

	       		for(var i = 0; i <del_file_name.length; i++){
	       			var delFile = {};
	       			delFile.file_name = del_file_name[i];
	       			delFile.file_seq = del_file_key[i];
	       			deleteFileInfo.push(delFile);
	       		}
       		}

		}



        /* 파라미터 : ExExpendSlipVO */
        var param = {};
    	if($("#txtSlipNote").val() != ''){
    		expendSlip.note = $("#txtSlipNote").val();
    	}
    	//금액 처리
    	expendSlip.amt = ( $('#txtSlipAmt').val().replace(/,/g,'') || '0');
   		expendSlip.subStdAmt = ($('#txtSlipSubStdAmt').val().replace(/,/g,'')|| '0');
		expendSlip.subTaxAmt = ($('#txtSlipSubTaxAmt').val().replace(/,/g,'')|| '0');
		expendSlip.feeSeq = feeSeq;
        param.slip = JSON.stringify(expendSlip.toJSON());

       	param.org = JSON.stringify(expendSlipUseEmp.toJSON());

        param.acct = JSON.stringify(expendSlipAcct.toJSON());
        param.summary = JSON.stringify(expendSlipSummary.toJSON());


        if( $('input:checkbox[id="etaxYN"]').is(":checked") ){ /* 전자세금계산서발행여부 체크 */
        	expendSlipAuth.etaxYN = 'Y';
        	expendSlipAuth.etaxSendYN = 'N';
		}else{
			expendSlipAuth.etaxYN = 'N';
			expendSlipAuth.etaxSendYN = 'N';
		}
		if(ifSystem == "ERPiU"){
			if( $('input:checkbox[id="etaxSendYN"]').is(":checked") ){ /* 전자세금계산서 11이내 전송여부 */
				expendSlipAuth.etaxSendYN = 'Y';

			}else{
				expendSlipAuth.etaxSendYN = 'N';
			}
		}


        param.auth = JSON.stringify(expendSlipAuth.toJSON());
        param.project = JSON.stringify(expendSlipProject.toJSON());

        if(ifSystem == 'ERPiU' && expendSlipPartner.get('partnerCode') == '00'){
        	expendSlipPartner.set('partnerName',$("#txtSlipPartnerName").val());
        }
        param.partner = JSON.stringify(expendSlipPartner.toJSON());
        param.card = JSON.stringify(expendSlipCard.toJSON());
        param.isSlipMode = isInsertSlipMode;
        expendSlipBudget.set('budgetYm', ( expendSlipBudget.budgetYm || '' ) );

        /* 예산 정보 */
        if (ifSystem == "ERPiU") {
			expendSlipBudget.set('erpCompSeq', expendSlipUseEmp.erpCompSeq);
			expendSlipBudget.set('budgetYm', ( expendSlipBudget.budgetYm || ( $("#budget_ym").val() || ( expend.expendDate || '' ) ) ) );
			expendSlipBudget.set('budgetControlYN', 'Y');//
			/* 준성 - 상위 예산 통제레벨 수정 */ 
			expendSlipBudget.set('cdBgLevel', (expendSlipBudget.cdBgLevel ||'') );
			expendSlipBudget.set('ynControl', (expendSlipBudget.ynControl ||'') );
			expendSlipBudget.set('tpControl', (expendSlipBudget.tpControl ||'') );
			
			
		}
		//iCUBE 사용자 다시 넣기
		else if (ifSystem === "iCUBE" && isUseBudget) {
			expendSlipBudget.set('erpEmpSeq',  expendSlipUseEmp.erpEmpSeq);
			expendSlipBudget.set('erpDeptSeq', expendSlipUseEmp.erpDeptSeq);
			expendSlipBudget.set('erpCompSeq', expendSlipUseEmp.erpCompSeq);
// 			expendSlipBudget.set('budYm', $("#budget_ym").val());//귀속년월 추가
			expendSlipBudget.set('budgetYm', ( expendSlipBudget.budgetYm || ( $("#budget_ym").val() || ( expend.expendDate || '' ) ) ) );
			expendSlipBudget.set('budgetJsum', '');//귀속년월 추가
			expendSlipBudget.set('budgetActsum', '');//귀속년월 추가
			expendSlipBudget.set('budgetControlYN', 'Y');//
			expendSlipBudget.set('budgetGbn',expendBudgetInfo.budgetType);
			expendSlipBudget.set('budgetType',expendBudgetInfo.erpType);
			if(expendSlipBudget.bgacctCode === ''){
				expendSlipBudget.set('bgacctCode', expendSlipAcct.drAcctCode);
				expendSlipBudget.set('bgacctName', expendSlipAcct.drAcctName);
			}
			if(expendSlipBudget.budgetCode === ''){
				if (expendBudgetInfo.budgetType === "D") {
					expendSlipBudget.set('budgetCode', expendSlipUseEmp.erpDeptSeq);
					expendSlipBudget.set('budgetName', expendSlipUseEmp.erpDeptName);
				} else if (expendBudgetInfo.budgetType === "P") {
					if(expendProject.projectCode && expendProject.projectCode != '' && expendProject.projectCode != '0'){
						expendSlipBudget.set('budgetCode', expendProject.projectCode);
						expendSlipBudget.set('budgetName', expendProject.projectName);
					}else{
						if(expendSlipProject.projectCode == '' || expendSlipProject.projectCode == '0' ){
							alert("<%=BizboxAMessage.getMessage("TX000018811","프로젝트를 선택 후 진행하여 주십시오.")%>");
							return false;
						}
						expendSlipBudget.set('budgetCode', expendSlipProject.projectCode);
						expendSlipBudget.set('budgetName', expendSlipProject.projectName);
					}
				} else {
					alert("<%=BizboxAMessage.getMessage("TX000018813","예산편성 타입이 잘못되었습니다.")%>");
					return process;
				}
			}
		}
        param.budget = JSON.stringify(expendSlipBudget.toJSON());
		/* 예산 정보 끝*/

        /* 항목 첨부파일 */
		param.attach = ($('#hidExpendSlipAttachInfo').val() || '{}');
		/* 항목 첨부파일 삭제 */
		if(deleteFileInfo.length > 0 ){
			param.delAttachList = JSON.stringify(deleteFileInfo);
		}

     	// 예산 사용 여부 옵션
        param.isUseBudget = isUseBudget;
//         continus = false;
		// 외화정보
		param.foreignCurrency = $("#hidExpendSlipForeignCurrencyInfo").val();

        var url = '';
        if( expend.get('expendStatCode') != ''){ /* 결재 진행중 수정 */
			if( expend.get('erpSendYN') === 'Y' ){
				alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
				return false;
			}
			else if( expend.get('expendStatCode') == '100' || expend.get('expendStatCode') == '999' ){
				alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
				return false;
			}
			else if( isUseBudget ){ // 예산 사용인 경우에는 별도의 프로세스로 진행
				if (expendSlip.get('slipSeq') != 0) {
					param.modify = 'Y';
				}else{
					param.modify = 'N';
				}
				param.formInfo = JSON.stringify(formInfo);
				url = '<c:url value="/ex/user/expend/SlipInfoSingleMakeApproval.do" />';
			}else{ // 예산 미사용인 경우에는 기존 프로세스로 진행
				if (expendSlip.get('slipSeq') != 0) {
		            /* 지출결의 항목 분개 수정 */
		        	param.modify = 'Y';
		        } else {
		            /* 지출결의 항목 분개 신규 */
		            param.modify = 'N';
		        }
				param.formInfo = JSON.stringify(formInfo);
				param.isUseBudget = isUseBudget;
				url = '<c:url value="/ex/user/expend/SlipInfoSingleMakeApproval.do" />';
// 				url = '<c:url value="/ex/user/expend/SlipInfoSingleMake.do" />';
			}
		}else{
	        if (expendSlip.get('slipSeq') != 0) {
	            /* 지출결의 항목 분개 수정 */
	        	param.modify = 'Y';
	        	url = '<c:url value="/ex/user/expend/SlipInfoSingleMake.do" />';
	        } else {
	            /* 지출결의 항목 분개 신규 */
	            param.modify = 'N';
	            url = '<c:url value="/ex/user/expend/SlipInfoSingleMake.do" />';
	        }
		}
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                window['${slipVo.callback}']({ continus : continus });
                if(continus){
                	expendSlip.amt = 0;
                	fnSlipShowAdvAmtArea();
                }
            },
            error : function( data ) {
                console.log("[slipPop] ! [EX][FNEXPENDLISTINFOINSERT] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 이벤트 초기화 - 버튼 - 취소 */
    function fnExpendSlipPopClose() {
//         layerPopClose('');
		fnExCloseLayPop();
        return;
    }

    /* 콜백 - 포커스 이동 */
    function fnSetFocus() {
    	return;
		if ($('#reqAuthDate').css('display') != 'none' && $('#txtSlipAuthDate').val() == '') {
            $('#txtSlipAuthDate').focus();
        } else if ($('#reqDrCrGbn').css('display') != 'none' && $('#division1').is(':checked') == false && $('#division2').is(':checked') == false) {
            $('#division1').focus();
        } else if ($('#reqAcct').css('display') != 'none' && $('#txtSlipAcctCode').val() == '') {
            $('#txtSlipAcctName').focus();
        } else if ($('#reqVatType').css('display') != 'none' && $('#txtSlipVatTypeCode').val() == '') {
            $('#txtSlipVatTypeName').focus();
        } else if ($('#reqBudget').css('display') != 'none' && $('#txtSlipBudgetCode').val() == ''
        		&& $('.ExpendSlipReqBudget').css('display') != 'none') {// 예산단위
            $('#txtSlipBudgetName').focus();
        } else if ($('#reqBizplan').css('display') != 'none' && $('#txtSlipBizplanCode').val() == ''
        	 && $('.ExpendSlipReqBizplan').css('display') != 'none') {// 사업계획
            $('#txtSlipBizplanName').focus();
        } else if ($('#reqBgAcct').css('display') != 'none' && $('#txtSlipBgAcctCode').val() == ''
        	 && $('.ExpendSlipReqBgAcct').css('display') != 'none') {// 예산계정
            $('#txtSlipBgAcctName').focus();
        } else if ($('#reqProject').css('display') != 'none' && $('#txtSlipProjectCode').val() == '') {
            $('#txtSlipProjectName').focus();
        } else if ($('#reqCard').css('display') != 'none' && $('#txtSlipCardCode').val() == '') {
            $('#txtSlipCardName').focus();
        } else if ($('#reqPartner').css('display') != 'none' && $('#txtSlipPartnerCode').val() == '') {
            $('#txtSlipPartnerName').focus();
        } else if ($('#reqAmt').css('display') != 'none' && ($('#txtSlipAmt').val() == '0' || $('#txtSlipAmt').val() == '')) {
            $('#txtSlipAmt').focus();
        }
        return;
    }

    // 적요 설정(분개 신규 생성 시 기본적용 적요 있으면 반영)
    function fnSetNote(){
    	if($("#txtSlipNote").val() == ""){
    		if($("#txtExpendBaseNote").val() != ""){
    			$("#txtSlipNote").val(parent.$("#txtExpendBaseNote").val());
    		}
    	}
    }

    /* 공통사용 */
	/* 첨부파일 콜백 함수  */
	function fnCallbackFileIdList(continus)
	{
	     var formData = new FormData();
	     for (var x = 0; x < $("#uploaderView")[0].contentWindow.attachFile.length; x++)
	     {
	         formData.append("file" + x, $("#uploaderView")[0].contentWindow.attachFile[x]);
	     }
	     formData.append("pathSeq", "1400"); //이미지 폴더
	     formData.append("relativePath", "list"); // 상대 경로
	     formData.append("empSeq", expendSlipUseEmp.empSeq);
	     formData.append("attFileCnt", $("#uploaderView")[0].contentWindow.attachFile.length); /* 신규 첨부파일 수 */

	     $.ajax({  url : "/gw/cmm/file/fileUploadProc.do",
	               type: "post",
	               dataType: "json",
	               data: formData,
	               processData: false,
	               contentType: false,
	               async:false,
	               success: function(data)
	               {
						var fileInfo ={};
						fileInfo.file_seq =(data.fileId || '');
						fileInfo.type = 'slip';
						fileInfo.expend_seq = expend.expend_seq;
						fileInfo.create_seq = empInfo.empSeq;
						fileInfo.modify_seq = empInfo.empSeq;
						fileInfo.list_seq = expendSlip.get('list_seq');
						fileInfo.slip_seq = expendSlip.get('slip_seq');

						var  listAttachInfo = new Array();

						if( $("#hidExpendSlipAttachInfo").val() != '' ){
						   listAttachInfo = JSON.parse($("#hidExpendSlipAttachInfo").val());
						}
						listAttachInfo.push(fileInfo);
						$("#hidExpendSlipAttachInfo").val(JSON.stringify(listAttachInfo));

// 						$("#hidExpendSlipAttachInfo").val(JSON.stringify(fileInfo));
						/* 항목 저장 */
						fnExpendSlipInfoInsert(continus);
	               },
	               error: function (result)
	               {
		               alert("<%=BizboxAMessage.getMessage("TX000006510", "실패")%>");
		               return false;
	      		   }
	     });
	}



	/* 문서 수정시 첨부파일 바인딩 함수 */
	function fnLoadFileList(resultData){
		if(resultData.length > 0 )
		{
			var list = [];
	        $.each(resultData, function( idx, item ) {
	        	var data = {};
	        	data.fileId = item.file_seq;
	        	data.fileNm = item.file_name;
	        	data.fileThumUrl = item.file_thum;
	        	//data.fileUrl = item.file_absol_path;
	        	data.fileThumUrl = "/gw/cmm/file/fileDownloadProc.do?fileId=" + item.file_seq+'&fileSn='+item.file_sn;
	        	data.fileUrl = '/gw/cmm/file/fileDownloadProc.do?fileId='+item.file_seq+'&fileSn='+item.file_sn;
	        	list.push(data);
	        });
	        tmpAttchSlipBindList = list;
	        fniframeLoadEvent();
		}
	}

	//로드시까지 반복 호출
	function fniframeLoadEvent(){
		var iframe = document.getElementById('uploaderView');
	    var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

	   	if (  iframeDoc.readyState  == 'complete' && $("#uploaderView")[0].contentWindow.fnAttFileListBinding != null) {
	    	$("#uploaderView")[0].contentWindow.fnAttFileListBinding(tmpAttchSlipBindList);
	     	return;
	    }
	    else
	    {
	    	window.setTimeout('fniframeLoadEvent();', 100);
	    }
	}

	/* ERPiU 예산정보 표시 설정 */
	function fnSetGridERPiUBudgetObject(){
		if(isUseBudget){
   			$.each(op_slip.func_code, function(idx,tOption){
   				if(tOption.code == '003302'){
   					if(tOption.value == '1'){ // 예산단위 + 사업계획 + 예산계정 ( 필수 )
						$(".ExpendSlipReqBudget").show();
						$(".ExpendSlipReqBizplan").show();
						$(".ExpendSlipReqBgAcct").show();
						$("#expendSlipReqBudget").show();
						$("#expendSlipReqBizplan").show();
						$("#expendSlipReqBgAcct").show();

						focus_fnSetprimary('txtSlipBudgetName', true);
						focus_fnSetprimary('txtSlipBizplanName', true);
						focus_fnSetprimary('txtSlipBgAcctName', true);

   					}else if(tOption.value == '2'){ // 예산단위 + 사업계획 + 예산계정 ( 필수아님 )
						$(".ExpendSlipReqBudget").show();
						$(".ExpendSlipReqBizplan").show();
						$(".ExpendSlipReqBgAcct").show();
						$("#expendSlipReqBudget").hide();
						$("#expendSlipReqBizplan").hide();
						$("#expendSlipReqBgAcct").hide();

						focus_fnSetprimary('txtSlipBudgetName', false);
						focus_fnSetprimary('txtSlipBgAcctName', false);

   					}else if(tOption.value == '3'){ // 예산단위 + 예산계정 ( 필수 )
						$(".ExpendSlipReqBudget").show();
						$(".ExpendSlipReqBgAcct").show();
						$("#expendSlipReqBudget").show();
						$("#expendSlipReqBgAcct").show();
						$(".ExpendSlipReqBizplan").hide();

						focus_fnSetprimary('txtSlipBudgetName', true);
						focus_fnSetprimary('txtSlipBgAcctName', true);

   					}else if(tOption.value == '4'){ // 예산단위 + 예산계정 ( 필수아님 )
						$(".ExpendSlipReqBudget").show();
						$(".ExpendSlipReqBgAcct").show();
						$("#expendSlipReqBudget").hide();
						$("#expendSlipReqBgAcct").hide();
						$(".ExpendSlipReqBizplan").hide();

						focus_fnSetprimary('txtSlipBudgetName', false);
						focus_fnSetprimary('txtSlipBgAcctName', false);
   					}else{
						$(".ExpendSlipBudget").hide();

						focus_fnSetprimary('txtSlipBudgetName', false);
						focus_fnSetprimary('txtSlipBgAcctName', false);
   					}
   					return false;
   				}
   			});
		}
	}

	/* [필수 항목] 계정과목 선택종류에 따른 필수입력 옵션 조회 */
	function fnGetNecessaryOption(acctCode){
		/* 계정과목 코드 */
		acctCode = acctCode || $('#txtSlipAcctCode').val();
		/* 차대구분 */
		var drcrGbn = $('#division1').is(':checked') ? 'D' : 'C' ;
		/* acctCode 없으면 리턴. */
		if(!acctCode){
			return;
		}

		/* 기존정보 없으면 신규 조회, 혹은 기본정보 사용하여 처리 */
		acctCodeMap.containsKey(acctCode) ?
			fnSetNecessaryOption(acctCodeMap.get(acctCode), drcrGbn) :
			$.ajax({
	            type : 'post',
	            url : '<c:url value="/ex/user/expend/slip/ExExpendMngNecessaryOptionInfoSelect.do" />',
	            datatype : 'json',
	            async : true,
	            data : {
	            	acctCode : acctCode
	            },
	            success : function( data ) {
	            	if(data.result.resultCode == 'SUCCESS'){
	            		acctCodeMap.put(acctCode, data.result.aaData);
	            		/* 필수 입력항목 설정 */
	            		fnSetNecessaryOption(data.result.aaData, drcrGbn);
	            	}else{
	            		console.log('서버 에러 발생, : ' + data.result.resultName);
	            	}
	            },
	            error : function( data ) {
	                console.log("[slipPop] ! [EX][FNEXPENDLISTINFOINSERT] ERROR - " + JSON.stringify(data));
	            }
	        });
	}

	/* [필수 항목] 계정과목에 따른 입력 필수 셋팅*/
	function fnSetNecessaryOption(aaData, drcrGbn){
		var length = aaData.length;
		var isPartnerNeed = false;
		var isRegNoNeed = false;
		for(var i = 0 ; i < length ; i++){
			var item = aaData[i];
			var isNecessary = ( item.mngStat == drcrGbn ) || ( item.mngStat == 'A' );
			var id = '';

			if(ifSystem == "ERPiU"){
				if(item.mngCode == 'C18'){
					/* 불공제구분 */
					fnSetNecessaryView('NoTax', isNecessary);
				}else if(item.mngCode == 'A03'){
					/* 사용부서 */
					fnSetNecessaryView('Dept', isNecessary);
				}else if(item.mngCode == 'A02'){
					/* 코스트센터 */
					fnSetNecessaryView('Cc', isNecessary);
				}else if(item.mngCode == 'A05'){
					/* 프로젝트 */
					fnSetNecessaryView('Project', isNecessary);
				}else if(item.mngCode == 'A08'){
					/* 카드 */
					fnSetNecessaryView('Card', isNecessary);
				}else if( ( item.mngCode == 'A06' ) || ( item.mngCode == 'C01' )){
					/* 거래처, 사업자 등록번호 */
					if( item.mngCode == 'A06' ){
						isPartnerNeed = isNecessary;
					}else if ( item.mngCode == 'C01' ){
						isRegNoNeed = isNecessary;
					}
					if( isPartnerNeed || isRegNoNeed ){
						fnSetNecessaryView('Partner', true);
					}
					else if( isPartnerNeed == false && isRegNoNeed == false ){
						fnSetNecessaryView('Partner', false);
					}
				}
			}else if(ifSystem == "iCUBE"){
				if(item.mngCode == 'D4'){
					/* 사용자 */
					fnSetNecessaryView('EmpName', isNecessary);
				} else if(item.mngCode == 'C1'){
					/* 사용부서 */
					fnSetNecessaryView('Dept', isNecessary);
				}  else if(item.mngCode == 'D9'){
					/* 코스트센터 */
					fnSetNecessaryView('Cc', isNecessary);
				}  else if(item.mngCode == 'D1'){
					/* 프로젝트 */
					fnSetNecessaryView('Project', isNecessary);
				}  else if(item.mngCode == 'A1'){
					/* 거래처 */
					fnSetNecessaryView('Partner', isNecessary);
				} else if( item.mngCode.indexOf("L") != -1 || item.mngCode.indexOf("M") != -1) {
					/* 사용자 정의 항목 중 연동 관리항목인 경우 */
					if(item.realMngCode == 'D4'){
						/* 사용자 */
						fnSetNecessaryView('EmpName', isNecessary);
					} else if(item.realMngCode == 'C1'){
						/* 사용부서 */
						fnSetNecessaryView('Dept', isNecessary);
					}  else if(item.realMngCode == 'D9'){
						/* 코스트센터 */
						fnSetNecessaryView('Cc', isNecessary);
					}  else if(item.realMngCode == 'D1'){
						/* 프로젝트 */
						fnSetNecessaryView('Project', isNecessary);
					}  else if(item.realMngCode == 'A1'){
						/* 거래처 */
						fnSetNecessaryView('Partner', isNecessary);
					}
				}
			}
		}
	}

	/* 필수입력, 비 필수입력 설정에 따른 뷰 정보 설정 */
	function fnSetNecessaryView(id, isNecessary){
		if(isNecessary){
			$('#req' + id).show();
			focus_fnSetprimary('txtSlip' + id + 'Name', true );
		}else {
			$('#req' + id).hide();
			focus_fnSetprimary('txtSlip' + id + 'Name', false );
		}
	}

	// 지출결의 정보 삭제 여부 판단 함수
	function fnIsDeleteItem(itemType){
       		switch(itemType){
   			case 'acct':
   				if( $("#txtSlipAcctName").val() == '' ){
   					$("#txtSlipAcctCode").val('');
   					$("#txtSlipVatTypeName").val('');
   					$("#txtSlipVatTypeCode").val('');
   					$("#txtSlipNoTaxName").val('');
   					$("#txtSlipNoTaxCode").val('');
   					$("#txtSlipVaName").val('');
   					$("#txtSlipVaCode").val('');
					expendSlipAcct = new kendo.data.ObservableObject(ExCodeAcct);
					expendSlipAuth = new kendo.data.ObservableObject(ExCodeAuth);
					expendSlip.acctCode = '';
					expendSlip.acctName = '';
					expendSlip.authSeq = 0;
					$(".ExpendSlipVatType").hide();
					$(".ExpendVatReason").hide();
					$(".ExpendSlipNoTax").hide();
					$(".ExpendSlipTax").hide();
   				}
   				break;
   			case 'vattype':
   				if( $("#txtSlipVatTypeName").val() == '' ){
   					$("#txtSlipVatTypeCode").val('');
   					expendSlipAuth.vatTypeCode = '';
   					expendSlipAuth.vatTypeName = '';
   				}
   				break;
   			case 'notax':
   				if( $("#txtSlipNoTaxName").val() == '' ){
   					$("#txtSlipNoTaxCode").val('');
   					expendSlipAuth.noTaxCode = '';
   					expendSlipAuth.noTaxName = '';
   				}
   				break;
   			case 'va':
   				if( $("#txtSlipVaName").val() == '' ){
   					$("#txtSlipVaCode").val('');
   					expendSlipAuth.vaTypeCode = '';
   					expendSlipAuth.vaTypeName = '';
   				}
   				break;
   			case 'project':
   				if( $("#txtSlipProjectName").val() == '' ){
   					$("#txtSlipProjectCode").val('');
   					expendSlip.projectSeq = 0;
   					expendSlipProject = new kendo.data.ObservableObject(ExCodeProject);
   				}
   				break;
   			case 'card' :
   				if( $("#txtSlipCardName").val() == '' ){
   					$("#txtSlipCardCode").val('');
   					expendSlip.cardSeq = 0;
   					expendSlipCard = new kendo.data.ObservableObject(ExCodeCard);
   				}
   				break;
   			case 'partner':
   				/* ERPiU의 00거래처는 사용자가 거래처 명 입력 가능 2018. 03. 29 - 신재호 */
   				if(ifSystem == 'ERPiU' && $("#txtSlipPartnerCode").val() == '00'){
   					expendSlipPartner.partnerName = $("#txtSlipPartnerName").val();
   				}else if( $("#txtSlipPartnerName").val() == '' ){
   					$("#txtSlipPartnerCode").val('');
   					expendSlip.partnerSeq = 0;
   					expendSlipPartner = new kendo.data.ObservableObject(ExCodePartner);
				}
   				break;
   			case 'budget':
   				if( $("#txtSlipBudgetName").val() == '' ){
   					$("#txtSlipBudgetCode").val('');
   					$("#txtSlipBizplanName").val('');
   					$("#txtSlipBizplanCode").val('');
   					$("#txtSlipBgAcctName").val('');
   					$("#txtSlipBgAcctCode").val('');
   					expendSlip.budgetSeq = 0;
   					expendSlipBudget = new kendo.data.ObservableObject(ExCodeBudget);
   					expendSlipBudget.set('budgetYm', $('#txtExpendDate').val().toString().replace(/-/g, '').substring(0, 6));
   				}
   				break;
   			case 'bizplan':
   				if( $("#txtSlipBizplanName").val() == '' ){
   					$("#txtSlipBizplanCode").val('');
   					expendSlipBudget.bizplanCode = '';
   					expendSlipBudget.bizplanName = '';
   				}
   				break;
   			case 'bgacct':
   				if( $("#txtSlipBgAcctName").val() == '' ){
   					$("#txtSlipBgAcctCode").val('');
   					expendSlipBudget.bgacctCode = '';
   					expendSlipBudget.bgacctName = '';
   				}
   				break;
   			default :
   				break;
   		}
	}

	/* 저장 전 예산금액 확인 */
	function fnExpendBudgetCheck(){
		var process = false;

		if(expendBudgetInfo.useYN ==='Y' && isUseBudget==true && expendSlip.drcrGbn == 'dr' ){
// 			var acctInfo = JSON.parse($("#hidExpendListSummaryInfo").val());
			var data = {};
			if(ifSystem === 'iCUBE'){
				data.acctCode = (expendSlip.acctCode || 0);
				if (expendBudgetInfo.budgetType === "D") {
					data.budgetCode = expendSlipUseEmp.erpDeptSeq;
				} else if (expendBudgetInfo.budgetType === "P") {
					if(expendProject.projectCode && expendProject.projectCode != '' && expendProject.projectCode != '0'){
						_budget_code = expendProject.projectCode;
					}else{
						if( expendSlipProject.projectCode === '' ){
							alert("<%=BizboxAMessage.getMessage("TX000007086", "프로젝트를 선택하여 주십시요.")%>");
							return false;
						}
						_budget_code = expendSlipProject.projectCode;
					}
					data.budgetCode = _budget_code;
				} else {
					alert("<%=BizboxAMessage.getMessage("TX000018818", "예산편성 타입이 잘못되었습니다")%>");
					return process;
				}
			}
			else if(ifSystem === 'ERPiU'){
				data.bgacctCode = (expendSlipBudget.get('bgacctCode') || 0);
				data.budgetCode = (expendSlipBudget.get('budgetCode') || 0 );
				data.bizplanCode = (expendSlipBudget.get('bizplanCode') || '***' );
				data.bgacctCode = (expendSlipBudget.get('bgacctCode') || 0 );
				data.cdBgLevel = (expendSlipBudget.get('cdBgLevel') || '' );
				data.ynControl = (expendSlipBudget.get('ynControl') || '' );
				data.tpControl = (expendSlipBudget.get('tpControl') || '' );
				data.isEdit = (slipIsEdit|| false); 
			}
			data.amt = $("#txtSlipAmt").val().toString().replace(/,/g, '');
			data.budgetYm = expend.expendDate;
			data.drcrGbn = 'dr';
			data.expendSeq = expendSlip.get("expendSeq");
			data.listSeq = expendSlip.get("listSeq");
			data.slipSeq = expendSlip.get("slipSeq");
		 	var ajaxParam = {};
		        ajaxParam.url = '<c:url value="/ex/user/expend/ExBudgetAmtCheck2.do" />';
		        ajaxParam.async = false;
		        ajaxParam.data = data;
		        ajaxParam.callback = function fnGetBudgetAmt(resultData){
		        	var popupWidth = 500;
				    var popupHeight = 280;
					var windowX = (screen.width - popupWidth)/2;
				    var windowY = (screen.height - popupHeight)/2;
		        	if(resultData.ifSystem === 'iCUBE'){
// 		        		var acctInfo = JSON.parse($("#hidExpendListSummaryInfo").val());

		        		var acct_info = '('+expendSlip.acctCode+')'+expendSlip.acctName;
						if(resultData.aaData.budgetControlYN === 'Y'){
							//전체 사용 가능금액
							// 결재 종결문서인 경우 사용 가능 금액에 기존 금액을 더해준다.
							var act_sum = parseInt(resultData.aaData.budgetActsum) + Number(basicSlipAmt);
							//승인(결의)진행
							var jsum = parseInt(resultData.aaData.budgetJsum);
							//잔액
							var remain_amt = Number(act_sum) - (Number(jsum) + Number(data.amt));
							if(remain_amt < 0 ){
								//예산초과 팝업 띄우기
								var bgParam = "?callback=''&budget_actsum='"+ act_sum+"'&acct_code='"+expendSlip.acctCode +"'&acct_name='"+ escape(encodeURIComponent(expendSlip.acctName)) + "'&budget_jsum='"+ jsum+ "'&req_amt='"+ data.amt+ "'";
								var popParam = {};
								popParam.title = "<%=BizboxAMessage.getMessage("TX000007562", "예산초과")%>";
								popParam.width = '';
								popParam.height = '';
								popParam.opener = '3';
								popParam.parentId = '';
								popParam.childId = '';
								popParam.getParam = bgParam;
								var url = "<c:url value='/ex/user/expend/ExBudgetOverPopup.do'/>"+ popParam.getParam;
								window.open(url,"<%=BizboxAMessage.getMessage("TX000007562", "예산초과")%>","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
								process = false;
							}
							else{
								process = true;
							}
						}
						else if(resultData.aaData.budgetControlYN === 'N'){
							process = true;
						}
						else if(resultData.aaData.budgetControlYN === 'B'){
							alert("<%=BizboxAMessage.getMessage("TX000018819", "표준적요 차변계정에 대한 예산정보가 미편성 상태이므로 전표를 생성할 수 없습니다")%>");
							process = false;
						}
			    	}else if(resultData.ifSystem === 'ERPiU'){
			    		var acctInfo = expendSlipBudget;
		        		var acct_info = '('+expendSlipBudget.get("bgacctCode")+')'+expendSlipBudget.get("bgacctName");
						if(resultData.aaData.budgetControlYN === 'Y'){
							//전체 사용 가능금액
							// 결재 종결문서인 경우 사용 가능 금액에 기존 금액을 더해준다.
							var act_sum = parseInt(resultData.aaData.budgetActsum) + Number(basicSlipAmt);
							//승인(결의)진행
							var jsum = parseInt(resultData.aaData.budgetJsum);
							//잔액
							var remain_amt = Number(act_sum) - (Number(jsum) + Number(data.amt));
							if(remain_amt < 0 ){
								//예산초과 팝업 띄우기
								var bgParam = "?callback=''&budget_actsum='"+ act_sum+"'&bgacctCode='"+acctInfo.get("bgacctCode")
										+"'&bgacct_name='"+ escape(encodeURIComponent(acctInfo.get("bgacctName") ))
										+ "'&budget_jsum='"+ jsum+ "'&req_amt='"+ data.amt+ "'";
								var popParam = {};
								popParam.title = "<%=BizboxAMessage.getMessage("TX000007562", "예산초과")%>";
								popParam.width = '';
								popParam.height = '';
								popParam.opener = '3';
								popParam.parentId = '';
								popParam.childId = '';
								popParam.getParam = bgParam;
								var url = "<c:url value='/ex/user/expend/ExBudgetOverPopup.do'/>"+ popParam.getParam;
								window.open(url,"<%=BizboxAMessage.getMessage("TX000007562", "예산초과")%>","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
								process = false;
							}
							else{
								process = true;
							}
						}
						else if(resultData.aaData.budgetControlYN === 'N'){
							process = true;
						}
			    	}
		        }
		        fnCallAjax(ajaxParam);
		}
		else{
			process = true;
		}
		return process;
	}

	function fnOpenEntertainmentFeePop( ){
		var url = "<c:url value='/expend/ex/user/userEntertainmentFee.do'/>";

    	var popupWidth = 700;
	    var popupHeight = 496;
	    var windowX = (screen.width - popupWidth)/2;
	    var windowY = (screen.height - popupHeight)/2;

	    url += "?feeSeq=" + (feeSeq || 0);
	    url += "&callback=" +"fnExpendSlipEntertainmentFee";

		var win = window.open(url,"접대비등록(ERPiU)","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);

        if(win== null || win.screenLeft == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018810", "브라우져 팝업차단 설정을 확인해 주세요")%>");
        }
	}

	/* 접대비 등록 팝업 콜백 */
	function fnExpendSlipEntertainmentFee(param){
		feeSeq = param.feeSeq;
		if(feeSeq == ''){
			feeSeq = 0;
		}
	}

	// 외화입력 팝업
	function fnExForeignCurrencyInputPopup(){
	    var getParam = "?callback=fnApplyResultAmountCallback&type=slip";
		var popParam = {};
		popParam.title = "${CL.ex_foreignCurrencyInput}";
		popParam.width = '';
		popParam.height = '';
		popParam.opener = '3';
		popParam.parentId = '';
		popParam.childId = '';
		popParam.getParam = getParam;
		var url = "<c:url value='/ex/user/expend/ExForeignCurrencyInputPopup.do'/>"+ popParam.getParam;

		var popupWidth = 500;
	    var popupHeight = 275;
	    var windowX = (screen.width - popupWidth)/2;
	    var windowY = (screen.height - popupHeight)/2;

		window.open(url,'ExForeignCurrencyInputPopup',"width=" + popupWidth + ", height=" + popupHeight + ", left=" + windowX + ",top=" + windowY);
	}

	// 외화입력 팝업 오픈 조건 조회
    function fnCheckForeignCurrencyAcctCode(){
    	var param = {}

    	param.drAcctCode = expendSlipAcct.acctCode;

    	$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/user/expend/foreigncurrency/CheckForeignCurrencyAcctCode.do" />',
	        datatype : 'json',
	        async : true,
	        data : param,
	        success : function( data ) {
	        	if(data.aData.resultAcctCount > 0){
	        		isForeignCurrency = true;

	        		$("#txtSlipAmt").maskMoney('destroy').prop('readonly', true);
				}else{
					isForeignCurrency = false;

					$('#txtSlipAmt').maskMoney({
			            precision : 0,
			            allowNegative: isNegativeAmt
			        });
				}
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}

    // 금액 값 항목금액에 반영
	function fnApplyResultAmountCallback(value){
		$("#txtSlipAmt").val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}
</script>

<!-- 첨부파일 정보 -->
<input id="hidExpendSlipAttachInfo" class="ExpendSlip" type="hidden" />
<!-- 외화 정보 -->
<input id="hidExpendSlipForeignCurrencyInfo" class="ExpendSlip" type="hidden" />

<div class="pop_wrap_dir pop_auto_hei pop_wrap_dir_expend" style = "position:fixed;" id="layerExpendSlip">
	<div class="pop_con" style="height:;">
		<div class="com_ta" style="height:">
			<table>
				<colgroup>
					<col width="25%" />
					<col width="" />
				</colgroup>

				<tr>
					<th><img id="reqAuthDate"
						src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_evidenceDate}</th>
					<!-- 증빙일자 -->
					<td>
						<div class="dal_div">
							<input id="txtSlipAuthDate" value="" class="dpWid slipDate" />
						</div>
					</td>
					<th><img id="reqDrCrGbn" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_division}</th>
					<!-- 구분 -->
					<td><input type="radio" name="division" id="division1" class="k-radio" />
					<label class="k-radio-label radioSel" for="division1"> ${CL.ex_debit}<!-- 차변 -->
					</label> <input type="radio" name="division" id="division2" class="k-radio" />
						<label class="k-radio-label radioSel" for="division2" style="margin: 0 0 0 10px;"> ${CL.ex_credit}<!-- 대변 -->
					</label></td>
				</tr>

				<tr class="slipTrAcct">
					<th>
						<img id="reqAcct" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> ${CL.ex_account}
					</th>
					<!-- 계정과목 -->
					<td colspan="3">
						<input id="txtSlipAcctCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipAcctName" type="text" style="width: 60%;ime-mode:active" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnSlipAcctSearch" class="slipButton" id=""><%=BizboxAMessage.getMessage( "TX000001702", "찾기" )%></button>
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipVatType" style="display: none;">
					<th>
						<img id="reqVatType" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> 세무구분
					</th>
					<td colspan="3">
						<input id="txtSlipVatTypeCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipVatTypeName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnSlipVatTypeSearch" class="slipButton" id="">찾기</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipiCUBE ExpendVatReason slipTrVa" style="display: none;">
					<th>
						<img id="expendSlipReqVa" style='display: none;' src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_reasonType}
					</th>
					<!-- 사유구분 -->
					<td class="dod_search" colspan="3">
						<input id="txtSlipVaCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipVaName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" "/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnSlipVaSearch">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipERPiU ExpendSlipNoTax slipTrNoTax" style="display: none;">
					<th>
						<img id="expendSlipReqNoTax" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />${CL.ex_noType}<!-- 불공제구분 -->
					</th>
					<td colspan="3">
						<input id="txtSlipNoTaxCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipNoTaxName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipNoTaxSearch">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipNote slipTrNote">
					<th>
						<!-- <img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />  -->
						${CL.ex_note}<!-- 적요 -->
					</th>
					<td colspan="3"><input type="text" id="txtSlipNote" style="width: 81%;ime-mode:active;" />
						<div class="controll_btn" style="padding: 0px; display: none;">
							<button class="slipButton" id="btnSlipReceptSearch">접대비</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipiCUBE ExpendSlipERPiU ExpendSlipUser slipTrEmp" style="display: none;">
					<th>
						<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> ${CL.ex_user} <!-- 사용자 -->
					</th>
					<td colspan="3">
						<input type="text" style="width: 20%;" id="txtSlipEmpCode" disabled="disabled" />
						<input type="text" style="width: 60%;" id="txtSlipEmpName" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipEmpSearch">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipiCUBE ExpendSlipERPiU ExpendSlipUser" style="display: none;">
					<th>
						<!-- <img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />  -->
						${CL.ex_useDepartment}<!-- 사용부서 -->
					</th>
					<td colspan="3">
						<input type="text" style="width: 20%;" id="txtSlipDeptCode" disabled="disabled" />
						<input type="text" style="width: 60%;" id="txtSlipDeptName" disabled="disabled" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipDeptSearch"
								style="display: none;">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<%-- <tr class="ExpendSlipERPiU ExpendSlipUser ExpendSlipCCPC" style="display: none;">
					<th>
						<img id="reqPc" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_accountingUnit}
					</th>
					<td colspan="3">
						<input type="text" style="width: 20%;" id="txtSlipPcCode" disabled="disabled" />
						<input type="text" style="width: 60%;" id="txtSlipPcName" placeholder="코드도움 [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipPcSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr> --%>
				<tr class="ExpendSlipERPiU ExpendSlipUser ExpendSlipCCPC" style="display: none;">
					<th>
						<img id="reqCc" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_costCenter}<!-- 코스트센터 -->
					</th>
					<td colspan="3">
						<input type="text" style="width: 20%;" id="txtSlipCcCode" disabled="disabled" />
						<input type="text" style="width: 60%;" id="txtSlipCcName" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipCcSearch">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipERPiU ExpendSlipBudget ExpendSlipReqBudget slipTrBudget" style="display: none;">
					<th>
						<img id="expendSlipReqBudget" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_budgetUnit}<!-- 예산단위 -->
					</th>
					<td colspan="3">
						<input id="txtSlipBudgetCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipBudgetName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipBudgetSearch">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipERPiU ExpendSlipBudget ExpendSlipReqBizplan slipTrBizplan" style="display: none;">
					<th>
						<img id="expendSlipReqBizplan" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_businessPlan}<!-- 사업계획 -->
					</th>
					<td colspan="3">
						<input id="txtSlipBizplanCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipBizplanName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipBizplanSearch">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipiCUBE ExpendSlipERPiU ExpendSlipBudget ExpendSlipReqBgAcct slipTrBgAcct" style="display: none;">
					<th>
						<img id="expendSlipReqBgAcct" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_budgetAccount} <!-- 예산계정 -->
					</th>
					<td colspan="3">
						<input id="txtSlipBgAcctCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipBgAcctName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="btnSlipBgAcctSearch">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipiCUBE ExpendSlipERPiU ExpendSlipProject slipTrProject">
					<th>
						<img id="reqProject" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_project}<!-- 프로젝트 -->
					</th>
					<td colspan="3">
						<input id="txtSlipProjectCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipProjectName" type="text" style="width: 60%;ime-mode:active;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnSlipProjectSearch" class="slipButton" id="">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipiCUBE ExpendSlipERPiU ExpendSlipCard slipTrCard">
					<th>
						<img id="reqCard" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_card}
					</th>
					<!-- 카드 -->
					<td colspan="3">
						<input id="txtSlipCardCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipCardName" type="text" style="width: 60%;ime-mode:active;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnSlipCardSearch" class="slipButton" id="">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipiCUBE ExpendSlipERPiU ExpendSlipPartner slipTrPartner">
					<th>
						<img id="reqPartner" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_vendor}
					</th>
					<!-- 거래처 -->
					<td colspan="3">
						<input id="txtSlipPartnerCode" type="text" style="width: 20%;" disabled="disabled" />
						<input id="txtSlipPartnerName" type="text" style="width: 60%;ime-mode:active;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnSlipPartnerSearch" class="slipButton" id="">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div>
					</td>
				</tr>
				<tr class="ExpendSlipTax">
					<c:choose>
						<c:when test="${ViewBag.ifSystem == 'ERPiU'}">
							<th><%=BizboxAMessage.getMessage( "", "전자(세금)계산서" )%></th>
							<td colspan="3"><input type="checkbox" name="tax"
								id="etaxYN" class="k-checkbox" /> <label
								class="k-checkbox-label" for="etaxYN" style="margin: 0px;"><%=BizboxAMessage.getMessage( "", "전자(세금)계산서 여부" )%></label>
								<span class="ml10" id="divEtaxSendYN"> <input
									type="checkbox" name="etaxSendYN" id="etaxSendYN"
									class="k-checkbox" /> <label class="k-checkbox-label"
									for="etaxSendYN" style="margin: 0 0 0 10px;"><%=BizboxAMessage.getMessage( "TX000007526", "국세청 전송 11일 이내" )%></label>
							</span></td>
						</c:when>
						<c:when test="${ViewBag.ifSystem == 'iCUBE'}">
							<th><%=BizboxAMessage.getMessage( "TX000007529", "전자세금계산서" )%></th>
							<td colspan="3"><input type="checkbox" name="tax"
								id="etaxYN" class="k-checkbox" /> <label
								class="k-checkbox-label" for="etaxYN" style="margin: 0px;"><%=BizboxAMessage.getMessage( "TX000007540", "전자세금계산서 여부" )%></label>
								<span class="ml10" id="divEtaxSendYN"> <input
									type="checkbox" name="etaxSendYN" id="etaxSendYN"
									class="k-checkbox" /> <label class="k-checkbox-label"
									for="etaxSendYN" style="margin: 0 0 0 10px;"><%=BizboxAMessage.getMessage( "TX000007526", "국세청 전송 11일 이내" )%></label>
							</span></td>
						</c:when>
					</c:choose>

				</tr>

				<tr class="slipTrAmt">
					<th rowspan="2">
						<img id="reqAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_amount}
					</th>
					<!-- 금액 -->
					<td rowspan="2">
						<input id="txtSlipAmt" type="text" style="width: 81%; text-align: right;" placeholder="0" />
					</td>
					<th>
						<img id="reqSubAmt" class="reqSubAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""/>
						${CL.ex_standardImposition}
						<!-- 과세표준액 -->
					</th>
					<td>
						<input id="txtSlipSubStdAmt" type="text" style="width: 81%; text-align: right;" disabled="disabled" placeholder="0" />
					</td>
				</tr>
				<tr class="">
					<th>
						<img id="reqTaxAmt" class="reqTaxAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""/>
						${CL.ex_taxAmount}
						<!-- 세액 -->
					</th>
					<td>
						<input id="txtSlipSubTaxAmt" type="text" style="width: 81%; text-align: right;" disabled="disabled" placeholder="0" />
					</td>
				</tr>
				<tr class="ExpendSlipERPiU">
					<th>
						<!-- <img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />  -->${CL.ex_evidence}<!-- 증빙 -->
					</th>
					<td colspan="3"><input type="text" style="width: 20%;" />
						<input type="text" style="width: 60%;" />
						<div class="controll_btn" style="padding: 0px;">
							<button class="slipButton" id="">${CL.ex_find}</button>
							<!-- 찾기 -->
						</div></td>
				</tr>
			</table>
		</div>

		<div class="blue_box mt15" style="display: none"
			id="div_advSlipAmtArea">
			<dl>
				<dt>
					<!-- 빨강 class="text_red" / 파랑 class="text_blue" -->
					(<span class="fwb">${CL.ex_debit}<!-- 차변 --></span>) <span
						class="fwb" id="txt_slipPop_totalDrAmt">0</span>
					<%=BizboxAMessage.getMessage( "TX000000626", "원" )%>
					<span class="fwb f13" id="txt_drCrMoreItem"> = </span> <span
						class="fwb" id="txt_slipPop_totalCrAmt">0</span>
					<%=BizboxAMessage.getMessage( "TX000000626", "원" )%>
					(<span class="fwb">${CL.ex_credit}<!-- 대변 --></span>)
				</dt>
				<dd>
					[<strong>차액 <span class="" id="txt_slipPop_Difference">0</span></strong>
					<%=BizboxAMessage.getMessage( "TX000000626", "원" )%>]
				</dd>
			</dl>
		</div>

		<!-- 첨부파일 -->
		<div class="write_addfile mt10">
			<!-- 첨부파일 버튼영역 -->
			<!-- 첨부파일 -->
			<iframe id="uploaderView"
				src="/gw/ajaxFileUploadProcView.do?uploadMode=U&pathSeq=1400"
				style="width: 100%; height: 181px;"></iframe>
		</div>
	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<!-- 			<input id="btnSlipSave" type="button" class="slipButton" value="저장" title="enter"/>  -->
			<!-- 			<input id="btnSlipClose" type="button" class="gray_btn" value="취소" title="esc"/> -->
			<%-- 			<input id="btnSlipContinusSave" type="button" class="slipButton" value="${CL.ex_saveContinus}" title="shift + enter" style="display:none;"/> --%>

			<button id="btnSlipSave" class="slipButton">${CL.ex_save}</button>
			<button id="btnSlipClose" class="gray_btn">${CL.ex_cancel}</button>
			<button id="btnSlipContinusSave" class="slipButton">${CL.ex_saveContinus}</button>
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!--// pop_wrap -->