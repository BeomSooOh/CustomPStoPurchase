<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="main.web.BizboxAMessage"%>

<!-- jQuery plugin -->
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.mask.js"></c:url>'></script>

<!-- e나라도움 연계 참조 -->
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.ucdevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.uckeydevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.anbojo.var.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.anbojo.js"></c:url>'></script>

<script type="text/javascript">
var iCUBEOptionInfo = {
	    bojoRmk: "${ViewBag.BOJO_RMK}",
	    trRmk: "${ViewBag.TR_RMK}"
	};
	var empInfo = {
	    compSeq: "${ViewBag.compSeq}",
	    compName: "${ViewBag.compName}",
	    bizSeq: "${ViewBag.bizSeq}",
	    bizName: "${ViewBag.bizName}",
	    deptSeq: "${ViewBag.deptSeq}",
	    deptName: "${ViewBag.deptName}",
	    empSeq: "${ViewBag.empSeq}",
	    empName: "${ViewBag.empName}",
	    erpCompSeq: "${ViewBag.erpCompSeq}",
	    erpCompName: "${ViewBag.erpCompName}",
	    erpCompFrDate: "${ViewBag.erpCompFrDate}",
	    erpCompToDate: "${ViewBag.erpCompToDate}",
	    erpCompGisu: "${ViewBag.erpCompGisu}",
	    erpBizSeq: "${ViewBag.erpBizSeq}",
	    erpBizName: "${ViewBag.erpBizName}",
	    erpSectSeq: "${ViewBag.erpSectSeq}",
	    erpSectName: "${ViewBag.erpSectName}",
	    erpDeptSeq: "${ViewBag.erpDeptSeq}",
	    erpDeptName: "${ViewBag.erpDeptName}",
	    erpEmpSeq: "${ViewBag.erpEmpSeq}",
	    erpEmpName: "${ViewBag.erpEmpName}"
	};
	var gisuInfo = {};
	var topTableRowCount = 0;
	var mid1TableRowCount = -1;
	var mid2TableRowCount = -1;
	var botTableRowCount = -1;
	var anbojoValue = {};
	var anbojoInfo = {};
	var seq = {
	    selMSeq: 0,
	    maxMSeq: 0,
	    selLSeq: 0,
	    maxLSeq: 0,
	    selSSeq: 0,
	    maxSSeq: 0,
	    selDSeq: 0,
	    maxDSeq: 0
	};
	var payAllInfo = {};
	var budgetInfoSerchInfo = {
			/* 부분검색 - 예산과목명 */
			"searchBudgetName": "",
			/* 부분검색 - 예산과목코드 */
			"searchBudgetCode": "",
			/* 예산과목표시 */
			"searchType1": "1",
			/* 사용기한 */
			"searchType2": "1",
			/* 상위과목표시 */
			"searchType3": "1",
			/* 예산그룹표시 */
			"searchType4": "1"
		};
	
	$(document).ready(function () {
	    fnInit();
	    fnInitEvent();
	    //첨부파일(퍼블리싱)
	    $(".file_input_button").on("click", function () {
	        $(this).next().click();
	    });
	    return;
	});

	function fnInit() {
	    popupAutoResize();
	    fnInitVar();
	    fnInitLayout();
	    fnInitInput();
	    fnInitTable();
	    fnMakeAnbojoAbdocu(); /*e나라도움 집행등록 정보 생성*/
	    $('#resolveContent_TRDATA').find('tr:last').find('td:first input').click().focus().select();
	    return;
	}

	function fnInitVar() {
	    /*전역변수 지정*/
	    groupClassId = 'resolveContent';
	    txtHelpMsgElementId = 'spanToolTipTxt';
	    return;
	}

	function fnInitLayout() {
	    /*기본버튼*/
	    $(".controll_btn button").kendoButton();
	    return;
	}

	function fnInitInput() {
	    if ((empInfo.erpBizSeq || '') != '') {
	        /*회계단위*/
	        $('#txtErpBizName').val(empInfo.erpBizName);
	    } else {
	        alert('사용자의 iCUBE 연동정보를 확인할 수 없습니다.\r\n계속진행할 수 없습니다.');
	    }
	    if ((empInfo.erpDeptSeq || '') != '' && (empInfo.erpEmpSeq || '') != '') {
	        /*결의부서 / 작성자*/
	        $('#txtErpDeptEmpName').val([empInfo.erpDeptName, empInfo.erpEmpName].join(' / '));
	    } else {
	        alert('사용자의 iCUBE 연동정보를 확인할 수 없습니다.\r\n계속진행할 수 없습니다.');
	    }
	    /*작성일*/
	    $("#txtGisuDate").kendoDatePicker({
	        format: "yyyy-MM-dd",
	        previous: "",
	        change: function () {
	            if (this.options.previous != this._oldText.replace(/-/g, '')) {
	                /*작성일을 변경한 경우*/
	                if (confirm('작성일을 변경할 경우 현재 작성중인 내용이 모두 초기화됩니다.\r\n계속하시겠습니까?')) {
	                    this.options.previous = this._oldText.replace(/-/g, '');
	                    anbojoInfo.gisuDate = this._oldText.replace(/-/g, '');
	                    /*TODO : 초기화 프로세스 구현 필요*/
	                } else {
	                    this.options.previous = anbojoInfo.gisuDate;
	                    this.value(new Date(this.options.previous.substring(0, 4), this.options.previous.substring(4, 6), this.options.previous.substring(6, 8)))
	                }
	            }
	        }
	    });
	    /* 마스크 넣기 */
	    $('.maskDate').mask('0000/Z0/R0', {
	        placeholder: "____/__/__",
	        clearIfNotMatch: true,
	        translation: {
	            'Z': {
	                pattern: /[0-1]/,
	                optional: true
	            },
	            'R': {
	                pattern: /[0-3]/,
	                optional: true
	            }
	        }
	    });

	    $("#txtGisuDate").val(function () {
	        var today = new Date();
	        var dispToday = [today.getFullYear(), (today.getMonth() + 1) < 10 ? '0' + (today.getMonth() + 1) : (today.getMonth() + 1), (today.getDate() < 10 ? '0' + today.getDate() : today.getDate())].join('-');
	        return dispToday;
	    });

	    $('.maskDatetime').mask('0000/Z0/R0 A0:B0', {
	        placeholder: "____/__/__ __:__",
	        clearIfNotMatch: true,
	        translation: {
	            'Z': {
	                pattern: /[0-1]/,
	                optional: true
	            },
	            'R': {
	                pattern: /[0-3]/,
	                optional: true
	            },
	            'A': {
	                pattern: /[0-2]/,
	                optional: true
	            },
	            'B': {
	                pattern: /[0-5]/,
	                optional: true
	            }
	        }
	    });

	    $('.maskTime').mask('A0:B0', {
	        placeholder: "__:__",
	        clearIfNotMatch: true,
	        translation: {
	            'A': {
	                pattern: /[0-2]/,
	                optional: true
	            },
	            'B': {
	                pattern: /[0-5]/,
	                optional: true
	            }
	        }
	    });

	    $('.maskMoney').mask('0,000,000,000,000,000', {
	        reverse: true
	    });
	    $('.maskNumber').mask('0#');

	    return;
	}

	function fnInitTable() {
	    $.devTable.create(ABDOCU_0, 'resolveContent', 'Y', '2', '100', 'N', 'Y', 'N');
	    $.devTable.create(ABDOCU_1, 'authContent', 'N', '1', '45', 'N', 'N', 'N');
	    $.devTable.create(ABDOCU_B, 'bimokContent', 'N', '2', '100', 'N', 'N', 'N');
	    $.devTable.create(ABDOCU_T, 'jaewonContent', 'N', '2', '100', 'N', 'N', 'N');
	    fnSetTableRelation();
	    return;
	}

	function fnInitEvent() {
	    fnInitEventKey();
	    fnInitEventButton();
	    return;
	}

	function fnInitEventKey() {
	    /*GOLOBAL KEYEVENT BIND (ESC)*/
	    $(window).on('keydown', function (e) {
	        switch (e.keyCode) {
	            /* ESC EVENT */
	            case 27:
	                fnPopClose();
	                fnTaxPopClose();
	                fnCardDealPopClose();
	                fnBgAcctPopClose();
	                $('input.focus').click().focus();
	                break;
	        }
	    });
	    fnRegUCTableKeyEvent();
	    return;
	}

	function fnInitEventButton() {
	    /*결의내역 추가*/
	    $("#btnAddResolRow").click(
	        function () {
	            topTableRowCount = Number(topTableRowCount) + 1;
	            $.devTable.addrow('resolveContent', ABDOCU_0, '2', 'resolveContent_TRDATA', topTableRowCount);
	            fnRegUCTableKeyEvent();
	            $('#resolveContent_TRDATA').find('tr:last').find('td:first input').click().focus();
	        }
	    );
	    /*비목내역 추가*/
	    $("#btnAddBimokRow").click(
	        function () {
	            topTableRowCount = Number(topTableRowCount) + 1;
	            $.devTable.addrow('bimokContent', ABDOCU_B, '2', 'bimokContent_TRDATA', topTableRowCount);
	            fnRegUCTableKeyEvent();
	            $('#bimokContent_TRDATA').find('tr:last').find('td:first input').click().focus();
	        }
	    );
	    /*이력정보 등록*/
	    $('#btnPerCodePop').click(function () {
	        if ((seq.selMSeq || '0') == '0') { /* 결의내역 */
	            alert('결의내역이 선택되지 않았습니다.');
	            return;
	        } else if ((seq.selLSeq || '0') == '0') { /* 증빙내역 */
	            alert('증빙내역이 선택되지 않았습니다.');
	            return;
	        } else if ((seq.selSSeq || '0') == '0') { /* 비목내역 */
	            alert('비목내역이 선택되지 않았습니다.');
	            return;
	        } else if ((seq.selDSeq || '0') == '0') { /* 재원내역 */
	            alert('재원내역이 선택되지 않았습니다.');
	            return;
	        }

	        var url = "/exp/expend/angu/AnguEmpPop.do";
	        url += '?anbojoSeq=' + anbojoInfo.anbojoSeq;
	        url += '&mseq=' + seq.selMSeq;
	        url += '&lseq=' + seq.selLSeq;
	        url += '&sseq=' + seq.selSSeq;
	        url += '&dseq=' + seq.selDSeq;
	        url += '&bsnsyear=' + $('#txtGisuDate').val().toString().replace(/-/g, '').substring(0, 4);
	        url += '&mosfGisuDt=' + $('#txtGisuDate').val().toString().replace(/-/g, '');
	        url += '&baseDate=' + $('#txtGisuDate').val().toString().replace(/-/g, '');
	        url += '&erpBizSeq=' + empInfo.erpBizSeq;
	        var popupWidth = 800;
	        var popupHeight = 574;
	        var windowX = (screen.width - popupWidth) / 2;
	        var windowY = (screen.height - popupHeight) / 2;
	        window.open(url, '인력정보등록', "width=" + popupWidth + ",height=" + popupHeight + ",left=" + windowX + ",top=" + windowY);
	    });
	    /*결재상신*/
	    $('#btnApproval').click(function () {
	        var ajaxParam = {};
	        var resolve = anbojoValue['resolve'];
	        $.each(Object.keys(resolve), function (idx, item) {
	            var objKey = 'resolve' + ['|', item, '|'].join('');
	            var mSeq = item || '0';
	            ajaxParam[objKey] = {};
	            var items = {};
	            $.each(Object.keys(resolve[item]), function (itemIdx, resolveItem) {
	                $.extend(items, resolve[item][resolveItem]);
	            });
	            /* 변환 예외처리 */
	            items.mSeq = mSeq;
	            items.bsnsYear = items.BSNSYEAR;
	            items.excuteRqust = items.EXCUTERQUST.toString().replace(/\//g, '');
	            items.excutPrpos = items.EXCUTPRPOS;
	            items.gisuDt = items.GISUDT;
	            if((resolve[item]['PRUFSE']['prufseCode'] || '') == '004') {
	            	items.prufSeNo = resolve[item]['PRUFSENO']['PUCHAS_TKBAK_NO'] || '';
	            	items.ctrCd = resolve[item]['PRUFSENO']['CTR_CD'] || '';
	            	items.cardNo = resolve[item]['PRUFSENO']['CARD_NO'] || '';
	            } else if((resolve[item]['PRUFSE']['prufseCode'] || '') == '001' || (resolve[item]['PRUFSE']['prufseCode'] || '') == '002') {
	            	items.prufSeNo = items.issNumber;
	            	items.ctrCd = '';
	            	items.cardNo = '';
	            } else {
	            	items.prufSeNo = '';
	            	items.ctrCd = '';
	            	items.cardNo = '';
	            }
	            
	            /* 자계좌이체사유 */
	            if(items.transFracnutSeDCode == '002'){
	            	items.sbsAcnttrfrSnDCn = resolve[item]['SBSACNTTRFRSNCN']['SBSACNTTRFRSNCN'] || '';
	            } else {
	            	items.sbsAcnttrfrSnDCn = '';
	            }

	            ajaxParam[objKey] = JSON.stringify(items);
	        });

	        var auth = anbojoValue['auth'];
	        $.each(Object.keys(auth), function (idx, item) {
	            var objKey = 'auth' + ['|', item, '|'].join('');
	            var mSeq = item.split('|')[0] || '0';
	            var lSeq = item.split('|')[1] || '0';
	            ajaxParam[objKey] = {};
	            var items = {};
	            $.each(Object.keys(auth[item]), function (itemIdx, authItem) {
	                $.extend(items, auth[item][authItem]);
	            });
	            /*변환 예외처리*/
	            items.mSeq = mSeq;
	            items.lSeq = lSeq;
	            items.bcncCmpny = items.BCNCCMPNY || '';
	            items.bcncacnut = items.BCNCACNUT || '';
	            items.sbsidybankindict = items.SBSIDYBANKINDICT || '';
	            items.bcncbnkbindict = items.BCNCBNKBINDICT || '';
	            items.bcnclsft = items.BCNCLSFT || '';
	            items.bcncadres = items.BCNCADRES || '';
	            items.bcncrprsntv = items.BCNCRPRSNTV || '';
	            items.bcnctelno = items.BCNCTELNO || '';
	            ajaxParam[objKey] = JSON.stringify(items);
	        });

	        var bimok = anbojoValue['bimok'];
	        $.each(Object.keys(bimok), function (idx, item) {
	            var objKey = 'bimok' + ['|', item, '|'].join('');
	            var mSeq = item.split('|')[0] || '0';
	            var lSeq = item.split('|')[1] || '0';
	            var sSeq = item.split('|')[2] || '0';
	            ajaxParam[objKey] = {};
	            var items = {};
	            $.each(Object.keys(bimok[item]), function (itemIdx, bimokItem) {
	                $.extend(items, bimok[item][bimokItem]);
	            });
	            /*변환 예외처리*/
	            items.mSeq = mSeq;
	            items.lSeq = lSeq;
	            items.sSeq = sSeq;
	            items.prdlst = items.PRDLST || '';
	            ajaxParam[objKey] = JSON.stringify(items);
	        });

	        var jaewon = anbojoValue['jaewon'];
	        $.each(Object.keys(jaewon), function (idx, item) {
	            var objKey = 'jaewon' + ['|', item, '|'].join('');
	            var mSeq = item.split('|')[0] || '0';
	            var lSeq = item.split('|')[1] || '0';
	            var sSeq = item.split('|')[2] || '0';
	            var dSeq = item.split('|')[3] || '0';
	            ajaxParam[objKey] = {};
	            var items = {};
	            $.each(Object.keys(jaewon[item]), function (itemIdx, jaewonItem) {
	                $.extend(items, jaewon[item][jaewonItem]);
	            });
	            /*변환 예외처리*/
	            items.mSeq = mSeq;
	            items.lSeq = lSeq;
	            items.sSeq = sSeq;
	            items.dSeq = dSeq;
	            items.bgtCode = items.BGT_CD || '';
	            items.amount = (items.AMOUNT || '0').toString().replace(/,/g, '');
	            items.splpc = (items.SPLPC || '0').toString().replace(/,/g, '');
	            items.vat = (items.VAT || '0').toString().replace(/,/g, '');
	            ajaxParam[objKey] = JSON.stringify(items);
	        });

	        ajaxParam.anbojo = {};
	        ajaxParam.anbojo = JSON.stringify(anbojoInfo);
	        $.ajax({
	            url: domain + '/exp/expend/angu/AnguApprovalI.do',
	            async: true,
	            type: "post",
	            data: ajaxParam,
	            datatype: "json",
	            success: function (result) {
	                if (result.result.resultCode == 'SUCCESS') {
	                    fnMakeApproval();
	                } else {
	                    alert('결재문서 생성중 오류가 발생되었습니다. 다시 시도해주세요.');
	                }
	            },
	            error: function (err) {
	                console.log(err);
	            }
	        });
	    });
	    return;
	}

	function fnSetAnguEmpInfo(params) {
	    alert('인력정보등록 콜백');
	}

	function fnMakeApproval() {
	    var ajaxParam = {};
	    ajaxParam.processId = "ANGUI";
	    ajaxParam.approKey = "ANGUI_EX_" + anbojoInfo.anbojoSeq;
	    ajaxParam.docTitle = "";
	    ajaxParam.interlockUrl = "";
	    ajaxParam.interlockName = "";
	 	// 20180910 soyoung, interlockName 이전단계 영문/일문/중문 추가
	 	ajaxParam.interlockNameEn = "";
	 	ajaxParam.interlockNameJp = "";
	 	ajaxParam.interlockNameCn = "";
	    ajaxParam.docSeq = "0";
	    ajaxParam.formSeq = '${param.formSeq}';
	    ajaxParam.docContents = '';
	    ajaxParam.preUrl = [location.protocol, '//', location.hostname, ':', location.port].join('');

	    var formContentsInfo = {
	        docContents: '',
	        resolve: [],
	        auth: [],
	        bimok: [],
	        jaewon: []
	    };
	    $.each(Object.keys(anbojoValue['resolve']), function (idx, key) {
	        var mSeq = key.toString().split('|')[0];
	        var resolve = {};
	        resolve.mSeq = mSeq;
	        resolve.ddtlbzName = anbojoValue['resolve'][key]['DDTLBZ']['ddtlbzName'];
	        formContentsInfo.resolve.push(resolve);
	    });
	    $.each(Object.keys(anbojoValue['auth']), function (idx, key) {
	        var mSeq = key.toString().split('|')[0];
	        var lSeq = key.toString().split('|')[1];
	        var auth = {};
	        auth.mSeq = mSeq;
	        auth.lSeq = lSeq;
	        formContentsInfo.auth.push(auth);
	    });
	    $.each(Object.keys(anbojoValue['bimok']), function (idx, key) {
	        var mSeq = key.toString().split('|')[0];
	        var lSeq = key.toString().split('|')[1];
	        var sSeq = key.toString().split('|')[2];
	        var bimok = {};
	        bimok.mSeq = mSeq;
	        bimok.lSeq = lSeq;
	        bimok.sSeq = sSeq;
	        bimok.asstnExpitmTaxitmCode = anbojoValue['bimok'][key]['ASSTNTAXITMCD']['asstnExpitmTaxitmCode'];
	        bimok.asstnExpitmName = anbojoValue['bimok'][key]['ASSTNTAXITMCD']['asstnExpitmName'];
	        bimok.asstnTaxitmName = anbojoValue['bimok'][key]['ASSTNTAXITMCD']['asstnTaxitmName'];
	        formContentsInfo.bimok.push(bimok);
	    });
	    $.each(Object.keys(anbojoValue['jaewon']), function (idx, key) {
	        var mSeq = key.toString().split('|')[0];
	        var lSeq = key.toString().split('|')[1];
	        var sSeq = key.toString().split('|')[2];
	        var dSeq = key.toString().split('|')[3];
	        var jaewon = {};
	        jaewon.mSeq = mSeq;
	        jaewon.lSeq = lSeq;
	        jaewon.sSeq = sSeq;
	        jaewon.dSeq = dSeq;
	        if (anbojoValue['jaewon'][key]['FNRSCSE'] != undefined) {
	            jaewon.fnrscseDName = anbojoValue['jaewon'][key]['FNRSCSE']['fnrscseDName'];
	            jaewon.pjtName = anbojoValue['jaewon'][key]['MGT']['pjtName'];
	            jaewon.splpc = anbojoValue['jaewon'][key]['SPLPC']['SPLPC'];
	            jaewon.vat = anbojoValue['jaewon'][key]['VAT']['VAT'];
	            jaewon.amount = anbojoValue['jaewon'][key]['AMOUNT']['AMOUNT'];
	            formContentsInfo.jaewon.push(jaewon);
	        }
	    });

	    $.each(formContentsInfo.resolve, function (idx, item) {
	        $.each(formContentsInfo.jaewon, function (jIdx, jItem) {
	            if (item.mSeq == jItem.mSeq) {
	                jItem = $.extend(jItem, item);
	            }
	        });
	    });

	    $.each(formContentsInfo.auth, function (idx, item) {
	        $.each(formContentsInfo.jaewon, function (jIdx, jItem) {
	            if (item.mSeq == jItem.mSeq && item.lSeq == jItem.lSeq) {
	                jItem = $.extend(jItem, item);
	            }
	        });
	    });

	    $.each(formContentsInfo.bimok, function (idx, item) {
	        $.each(formContentsInfo.jaewon, function (jIdx, jItem) {
	            if (item.mSeq == jItem.mSeq && item.lSeq == jItem.lSeq && item.sSeq == jItem.sSeq) {
	                jItem = $.extend(jItem, item);
	            }
	        });
	    });


	    if('${param.eaType}'.toString().toUpperCase() == 'EA'){
	    	formContentsInfo.docContents += '<div class="mt20 mb20">';
	    	formContentsInfo.docContents += '<table width="100%" class="statement bl bt" border="0" cellpadding="0" cellspacing="0">';
	    	formContentsInfo.docContents += '	<colgroup>';
	    	formContentsInfo.docContents += '		<col />';
	    	formContentsInfo.docContents += '		<col />';
	    	formContentsInfo.docContents += '		<col />';
	    	formContentsInfo.docContents += '		<col />';
	    	formContentsInfo.docContents += '		<col />';
	    	formContentsInfo.docContents += '		<col />';
	    	formContentsInfo.docContents += '		<col />';
	    	formContentsInfo.docContents += '	</colgroup>';
	    	formContentsInfo.docContents += '	<tr>';
	    	formContentsInfo.docContents += '		<th>국고보조사업</th>';
	    	formContentsInfo.docContents += '		<th>보조비목세목</th>';
	    	formContentsInfo.docContents += '		<th>재원구분</th>';
	    	formContentsInfo.docContents += '		<th>프로젝트</th>';
	    	formContentsInfo.docContents += '		<th>공급가액</th>';
	    	formContentsInfo.docContents += '		<th>부가세</th>';
	    	formContentsInfo.docContents += '		<th>집행금액</th>';
	    	formContentsInfo.docContents += '	</tr>';
		    $.each(formContentsInfo.jaewon, function (idx, item) {
		    	formContentsInfo.docContents += '	<tr>';
		    	formContentsInfo.docContents += '		<td>' + item.ddtlbzName || '&nbsp;' + '</td>';
		    	formContentsInfo.docContents += '		<td>' + [item.asstnExpitmName, item.asstnTaxitmName].join('/'); + '</td>';
		    	formContentsInfo.docContents += '		<td>' + item.fnrscseDName || '&nbsp;' + '</td>';
		    	formContentsInfo.docContents += '		<td>' + item.pjtName || '&nbsp;' + '</td>';
		    	formContentsInfo.docContents += '		<td class="ar">' + item.splpc || '&nbsp;' + '</td>';
		    	formContentsInfo.docContents += '		<td class="ar">' + item.vat || '&nbsp;' + '</td>';
		    	formContentsInfo.docContents += '		<td class="ar">' + item.amount || '&nbsp;' + '</td>';
		    	formContentsInfo.docContents += '	</tr>';
		    });
		    formContentsInfo.docContents += '</table>';
		    formContentsInfo.docContents += '</div>';
	    } else if('${param.eaType}'.toString().toUpperCase() == 'EAP'){
	    	formContentsInfo.docContents += '<table width=\"100%\" class=\"sign_tb_pop02\" style=\"border:none;\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\"><tbody><tr height=\"25\"><td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;border-left:none;\" bgcolor=\"#f6f6f6\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\"><b>국고보조사업</b></p></td><td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\" bgcolor=\"#f6f6f6\" rowspan=\"1\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\"><b>보조비목세목</b></p></td><td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\" bgcolor=\"#f6f6f6\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\"><b>재원구분</b></p></td><td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\" bgcolor=\"#f6f6f6\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\"><b>프로젝트</b></p></td><td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\" bgcolor=\"#f6f6f6\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\"><b>공급가액</b></p></td><td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\" bgcolor=\"#f6f6f6\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\"><b>부가세</b></p></td><td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;border-right:none;\" bgcolor=\"#f6f6f6\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\"><b>집행금액</b></p></td></tr>';
		    $.each(formContentsInfo.jaewon, function (idx, item) {
		        formContentsInfo.docContents += '<tr height=\"25\"><td align=\"center\" class=\"listNum\" style=\"font-family:굴림;font-size:9pt;line-height:140%;border-left:none;\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\">' + item.ddtlbzName || '&nbsp;' + '</p></td>';
		        formContentsInfo.docContents += '<td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\">' + [item.asstnExpitmName, item.asstnTaxitmName].join('/'); + '</p></td>';
		        formContentsInfo.docContents += '<td align=\"left\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\"><p style=\"text-align:center;margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\">' + item.fnrscseDName || '&nbsp;' + '</p></td>';
		        formContentsInfo.docContents += '<td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\">' + item.pjtName || '&nbsp;' + '</p></td>';
		        formContentsInfo.docContents += '<td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\">' + item.splpc || '&nbsp;' + '</p></td>';
		        formContentsInfo.docContents += '<td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\">' + item.vat || '&nbsp;' + '</p></td>';
		        formContentsInfo.docContents += '<td align=\"center\" style=\"font-family:굴림;font-size:9pt;line-height:140%;border-right:none;\"><p style=\"margin-top:0px;margin-bottom:0px;font-family:돋움;font-size:10pt;line-height:1.2;\">' + item.amount || '&nbsp;' + '</p></td></tr>';
		    });
		    formContentsInfo.docContents += '</table>';	
	    }
	    
	    ajaxParam.docContents = formContentsInfo.docContents || '';

	    $.ajax({
	        url: domain + '/exp/ApprovalDocMake.do',
	        async: true,
	        type: "post",
	        data: ajaxParam,
	        datatype: "json",
	        success: function (result) {
	            if (result.result.resultCode == 'SUCCESS') {
	                var data = result.result;
	                if (data.docSeq != '-1' && data.eaType != '' &&
	                    data.formSeq != '0' && data.approKey != '') {
	                    popupAutoResize();

	                    /* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
	                    /* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
	                    /* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
	                    
	                    var url = '';
	                    if(data.eaType.toString().toUpperCase() == 'EA'){
	                    	// eadocPop.location.href = url+'/'+eaType+'/ea/interface/eadocpop.do?form_id='+formId+'&processId='+processId+'&approKey='+getApproKey+'&docId='+docId;
	                    	url = '/' + data.eaType + '/ea/interface/eadocpop.do?form_id=' + data.formSeq + '&docId=' + data.docSeq + '&approKey=' + data.approKey + '&processId=ANGUI';
	                    } else if(data.eaType.toString().toUpperCase() == 'EAP'){
	                    	url = '/' + data.eaType + '/ea/eadocpop/EAAppDocPop.do' + '?form_id=' + data.formSeq + '&doc_id=' + data.docSeq + '&approkey=' + data.approKey;
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
	                    if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45; // IE 6.x
	                    else if (navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75; // IE 7.x
	                    else if (navigator.userAgent.indexOf("Firefox") > 0) marginY = 50; // FF
	                    else if (navigator.userAgent.indexOf("Opera") > 0) marginY = 30; // Opera
	                    else if (navigator.userAgent.indexOf("Netscape") > 0) marginY = -2; // Netscape

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

	                    var win = window.open(url, '', "scrollbars=yes,resizable=yes,width=" + maxThisX + ",height=" + (maxThisY - 50) + ",top=" + windowY + ",left=" + windowX);
	                    if (win == null || win.screenLeft == 0) {
	                        alert("<%=BizboxAMessage.getMessage("TX000018810 ", "브라우져 팝업차단 설정을 확인해 주세요 ")%>");
	                    } else {
	                        self.close();
	                    }
	                } else {
	                    alert("<%=BizboxAMessage.getMessage("TX000018809 ", "전자결재 문서 생성 중 오류가 발생하였습니다.")%>");
	                    return;
	                }
	            } else {
	                alert('결재문서 생성중 오류가 발생되었습니다. 다시 시도해주세요.');
	            }
	        },
	        error: function (err) {
	            console.log(err);
	        }
	    });
	}

	<!-- 신규 작업 추가 -->

	//코드팝업 커스텀 : 카드사용내역 
	function fnOpenLayerCardDealPopup(bindId, item) {
	    /*증빙구분 >> 전자세금계산서(과세), 전자계산서(면세)*/
	    /*#전자세금계산서팝업*/
	    /*백그라운드 포커스 주기*/
	    document.body.focus();
	    //setTimeout (function () {document.getElementById ( 'myInput'). focus ();}, 10);
	    /*==========================*/
	    /* 데이터 호출 로직
	    /*========================== */
	    fnLoadRequestData(bindId, item);
	    /*로직 완료 후 그리기*/
	    $("#divCardDealtHelperPop").css('display', 'block');

	    /* 자바스크립트 오늘 날짜 지정 */
	    var d = new Date();
	    var month = 0;
	    var day = 0;
	    if (d.getMonth() + 1 < 9) {
	        month = '0' + Number(d.getMonth() + 1);
	    } else {
	        month = d.getMonth() + 1;
	    }

	    if (d.getDate() < 10) {
	        day = '0' + d.getDate();
	    } else {
	        day = d.getDate();
	    }
	    var todayDate = d.getFullYear() + '-' + month + '-' + day;

	    $('#txtStDt').mask('0000-00-00');
	    $('#txtStDt').val(todayDate);
	    $('#txtStDt').masked();

	    d = new Date(d.getFullYear(), d.getMonth(), d.getDate());
	    d.setDate(d.getDate() - 7);
	    if (d.getMonth() + 1 < 9) {
	        month = '0' + Number(d.getMonth() + 1);
	    } else {
	        month = d.getMonth() + 1;
	    }

	    if (d.getDate() < 10) {
	        day = '0' + d.getDate();
	    } else {
	        day = d.getDate();
	    }
	    var fromDate = d.getFullYear() + '-' + month + '-' + day;

	    $('#txEnDt').mask('0000-00-00');
	    $('#txEnDt').val(fromDate);
	    $('#txEnDt').masked();

	    /* uctable 코드팝업 그리드 헤더 생성*/
	    $.devTable.createCodeHelper(headjson, 'divCardDealPopLayer', '1', '300px', 'N');

	    /* 데이터 바인드 */
	    $.devTable.addrowCodeData(headjson, dataJson, '1', 'divCardDealPopLayer');

	    /* 코드도움창 키이벤트 등록 */
	    fnRegUCTableCodePopKeyEvent(event, 'divCardDealPopLayer', 'hdnPopupData', 'hdnInputPopupInfo', headjson, '1');

	    //TABLE KEY EVET BIND(KEYDOWN)
	    $('#divCardDealtHelperPop').on('keydown', function (e) {
	        switch (e.keyCode) {
	            /* ESC EVENT */
	            case 119:
	                //fnGetEtaxDtaAjax();
	                break;
	            default:
	                break;
	        }
	    });

	    /* 현재 코드팝업 정보 파라메터 히든값에 저장하기 */
	    item.bindId = bindId;
	    $("#hdnInputPopupInfo").val(JSON.stringify(item));
	    //현재 팝업 더에터 저장
	    $("#hdnPopupData").val(JSON.stringify(dataJson));


	    /* 포커스 키 이벤트 등록 */
	    $("#txtStDt").focus().select();

	    $('#divCardDealSelectZone').unbind();
	    //TABLE KEY EVET BIND(KEYDOWN)
	    $('#divCardDealSelectZone').on('keydown', function (e) {
	        switch (e.keyCode) {
	            /* ENTER EVENT */
	            case 13:
	                var focusNo = ['txtStDt', 'txEnDt', 'txtCardName', 'txtTotalAmt', 'txtAffiliateName'];
	                var nextId = '';
	                var curId = document.activeElement.id
	                for (var i = 0; i < focusNo.length; i++) {
	                    if (focusNo[i] == curId) {
	                        if (i == focusNo.length - 1) {
	                            nextId = focusNo[0];
	                            break;
	                        } else {
	                            if (curId == 'txtCardName') {
	                                fnGetCardInfo();
	                                break;
	                            } else {
	                                nextId = focusNo[i + 1];
	                                break;
	                            }
	                        }
	                    }
	                }

	                $("#" + nextId).focus().select();
	                break;
	                /* LEFT ARROW EVENT */
	            case 37:
	                break;
	            case 38:
	                break;
	                /* RIGHT ARROW EVENT */
	            case 39:
	                break;
	                /* DOWN ARROW EVENT */
	            case 40:
	                break;
	            case 119:
	                fnGetCardDealDataAjax();
	            default:
	                break;
	        }
	    });
	}
	/* 카드거래내역 데이터 조회 */
	function fnGetCardDealDataAjax() {
	    var item = {};
	    item.id = 'PRUFSENO';
	    var bindId = '';
	    $("#divCardDealPopLayer_TRDATA").empty();
	    /*==========================*/
	    /* 데이터 호출 로직
	    /*========================== */
	    fnLoadRequestData(bindId, item);
	    /*로직 완료 후 그리기*/
	    $("#divCardDealtHelperPop").css('display', '');
	    /* 데이터 바인드 */
	    $.devTable.addrowCodeData(headjson, dataJson, '1', 'divCardDealPopLayer');
	    //현재 팝업 더에터 저장
	    $("#hdnPopupData").val(JSON.stringify(dataJson));
	}

	/* 카드정보 불러오기 */
	function fnGetCardInfo() {
	    var item = {};
	    item.id = "CARDTR";
	    var bindId = '';
	    /*==========================*/
	    /* 데이터 호출 로직
	    /*========================== */
	    fnLoadRequestData(bindId, item);
	    /*로직 완료 후 그리기*/
	    $("#divCardSubCodeHelperPop").css('display', 'block');
	    /* uctable 코드팝업 그리드 헤더 생성*/
	    $.devTable.createCodeHelper(headjson, 'divCardSubCodePopLayer', '1', '350px', 'N');
	    /* 데이터 바인드 */
	    $.devTable.addrowCodeData(headjson, dataJson, '1', 'divCardSubCodePopLayer');
	    /* 코드도움창 키이벤트 등록 */
	    fnLayerCardSubCodePopKeyEvent(event, 'divCardSubCodePopLayer', 'hdnPopupData', '', headjson, '1');
	    //현재 팝업 더에터 저장
	    $("#hdnPopupData").val(JSON.stringify(dataJson));
	}


	/* 팝업 내 레이어 팝업 띄우기 */
	function fnLayerCardSubCodePopKeyEvent(e, pLocationId, pCodePopDataId, pInputPopDataId, pHeadJsonData, pCodeTableType) {
	    //코드도움 테이블 명 저장
	    var locationId = pLocationId + "_TABLE";
	    //히든 코드 도움창 json 정보
	    var jsonDataId = pCodePopDataId;
	    //코드그리드헤더 정보
	    var headJson = pHeadJsonData;
	    //코드테이블 타입정보
	    var codeTableType = pCodeTableType;
	    //KEY EVENT DELETE
	    $('.subCardSearch').unbind();
	    //$('.onSel').unbind();
	    $('#' + locationId).unbind();
	    //선택한 데이터에 대한  더블클릭 이벤트
	    $('#divCardSubCodePopLayer_TABLE').dblclick(function () {
	        fnCardSubSelectRow();
	    });
	    //검색버튼
	    $("#searchSubCardButton").click(function () {
	        fnSearchStr(jsonDataId, $(".subSearch").val(), locationId, headJson, codeTableType);
	    });

	    $('.subCardSearch').unbind();
	    //INPUT KEY EVET BIND(KEYDOWN)
	    $('.subCardSearch').on('keydown', function (e) {
	        switch (e.keyCode) {
	            /* ENTER EVENT */
	            case 13:
	                fnSearchStr(jsonDataId, $(".subCardSearch").val(), locationId, headJson, codeTableType);
	                $("#" + locationId).find('TR').eq(0).click().focus();
	                return false;
	                break;
	                /* LEFT ARROW EVENT */
	            case 37:
	                break;
	                /* UP ARROW EVENT */
	            case 38:
	                $("#" + locationId).find('.onSel').prev().click().focus();
	                return false;
	                break;
	                /* RIGHT ARROW EVENT */
	            case 39:

	                break;
	                /* DOWN ARROW EVENT */
	            case 40:
	                $("#" + locationId).find('.onSel').next().click().focus();
	                return false;
	                break;

	            default:
	                $('.UCSearch').focus();
	                break;
	        }
	    });

	    $("#" + locationId).unbind();
	    $("#" + locationId).on('keydown', function (e) {
	        switch (e.keyCode) {
	            /* ENTER EVENT */
	            case 13:
	                fnCardSubSelectRow();
	                return false;
	                break;
	                /* LEFT ARROW EVENT */
	            case 37:
	                break;
	                /* UP ARROW EVENT */
	            case 38:
	                $("#" + locationId).find('.onSel').prev().click().focus();
	                return false;
	                break;
	                /* RIGHT ARROW EVENT */
	            case 39:

	                break;
	                /* DOWN ARROW EVENT */
	            case 40:
	                $("#" + locationId).find('.onSel').next().click().focus();
	                return false;
	                break;
	            case 27:
	                //팝업닫기
	                //레이어팝업 정보 초기화
	                $("#divCardSubCodeHelperPop").css('display', 'none');
	                $("#" + pLocationId).empty();
	                $("#txtSubCardSearch").val('');

	                //KEY EVENT DELETE
	                $('.subCardSearch').unbind();
	                $('.onSel').unbind();
	                $('#' + locationId).unbind();
	                $("#txtStDt").focus();
	                break;
	            default:
	                $('.subCardSearch').focus();
	                break;
	        }
	    });

	    //Search json Data on hidden json value
	    function fnSearchStr(jsonDataId, searchStr, tableName, headJson, codeTableType) {
	        if (searchStr.length > 0) {
	            var data = $("#" + jsonDataId).val();
	            var jsonArr = JSON.parse(data);
	            var resultJsonArr = [];
	            for (var i = 0; i < jsonArr.length; i++) {
	                $.each(jsonArr[i], function (key, value) {
	                    if (value.indexOf(searchStr) !== -1) {
	                        resultJsonArr.push(jsonArr[i]);
	                    }
	                });
	            }
	            $("#" + tableName).empty();
	            tableName = tableName.replace('_TABLE', '');
	            $.devTable.addrowCodeData(headJson, resultJsonArr, codeTableType, tableName)

	        } else {
	            var data = $("#" + jsonDataId).val();
	            var jsonArr = JSON.parse(data);
	            $("#" + tableName).empty();
	            tableName = tableName.replace('_TABLE', '');
	            $.devTable.addrowCodeData(headJson, jsonArr, codeTableType, tableName)
	        }
	    }

	    function fnCardSubSelectRow() {
	        var eleSelect = $("#" + locationId).find('.onSel');
	        var rowData = $(eleSelect).prop('data');
	        var popInfo;
	        $("#txtCardName").val('');
	        $("#txtCardName").val(rowData.trName);
	        $("#txtCardName").data('CardName', rowData);
	        //팝업닫기
	        //레이어팝업 정보 초기화
	        $("#divCardSubCodeHelperPop").css('display', 'none');
	        $("#" + pLocationId).empty();
	        $("#txtSubCardSearch").val('');

	        //KEY EVENT DELETE
	        $('.subCardSearch').unbind();
	        $('.onSel').unbind();
	        $('#' + locationId).unbind();
	        $("#txtTotalAmt").focus();
	    }

	}

	function fnCardDealPopClose() {
	    //종속 카드정보 팝업 초기화
	    fnSubCardPopClose();
	    $("#divCardDealtHelperPop").css('display', 'none');
	    $("#divCardDealPopLayer").empty();
	    $("#hdnInputPopupInfo").val('');
	    $("#hdnPopupData").val('');
	    $("#txtCardName").val('');
	    $("#txtStDt").val('');
	    $("#txEnDt").val('');
	}

	function fnSubCardPopClose() {
	    $("#divCardSubCodeHelperPop").css('display', 'none');
	    $("#divCardSubCodePopLayer").empty();
	    $("#hdnPopupData").val('');
	    $("#txtSubCardSearch").val('');
	}


	/*국고보조 집행등록*/
	/* ---------------------------------------*/
	function fnMakeAnbojoAbdocu() {
	    /*전송 파라미터 정의*/
	    var ajaxParam = {
	        compSeq: "${ViewBag.compSeq}",
	        /* Bizbox Alpha 회사 시퀀스 */
	        compName: '',
	        /* Bizbox Alpha 회사 명칭 */
	        erpCompSeq: "${ViewBag.erpCompSeq}",
	        /* ERP 회사 코드 */
	        erpCompName: "${ViewBag.erpCompName}",
	        /* ERP 회사 명칭 */
	        bizSeq: "${ViewBag.bizSeq}",
	        /* Bizbox Alpha 사업장 시퀀스 */
	        bizName: '',
	        /* Bizbox Alpha 사업장 명칭 */
	        erpBizSeq: "${ViewBag.erpBizSeq}",
	        /* ERP 사업장 코드 */
	        erpBizName: "${ViewBag.erpBizName}",
	        /* ERP 사업장 명칭 */
	        deptSeq: "${ViewBag.deptSeq}",
	        /* Bizbox Alpha 부서 시퀀스 */
	        deptName: '',
	        /* Bizbox Alpha 부서 명칭 */
	        erpDeptSeq: "${ViewBag.erpDeptSeq}",
	        /* ERP 부서 코드 */
	        erpDeptName: "${ViewBag.erpDeptName}",
	        /* ERP 부서 명칭 */
	        empSeq: "${ViewBag.empSeq}",
	        /* Bizbox Alpha 사원 시퀀스 */
	        empName: '',
	        /* Bizbox Alpha 사원 명 */
	        erpEmpSeq: "${ViewBag.erpEmpSeq}",
	        /* ERP 사원 번호 */
	        erpEmpName: "${ViewBag.erpEmpName}",
	        /* ERP 사원 명 */
	        erpPcSeq: '',
	        /* ERP 회계단위 코드(국고보조 집행등록상 표현되는 회계단위는 사업장 개념입니다. / ERPiU 전용입니다.) */
	        erpPcName: '',
	        /* ERP 회계단위 명칭(국고보조 집행등록상 표현되는 회계단위는 사업장 개념입니다. / ERPiU 전용입니다.) */
	        erpCcSeq: '',
	        /* ERP 코스트센터 코드(ERPiU 전용입니다.) */
	        erpCcName: '',
	        /* ERP 코스트센터 명칭(ERPiU 전용입니다.) */
	        docSeq: '0',
	        /* Bizbox Alpha 전자결재 문서 고유 아이디 */
	        formSeq: "${ViewBag.formSeq}",
	        /* Bizbox Alpha 전자결재 문서 양식 아이디 */
	        anbojoStatCode: '',
	        /* Bizbox Alpha 국고보조 집행등록 상태 코드 */
	        gisuDate: $('#txtGisuDate').val().toString().replace(/-/g, ''),
	        /*  */
	        jsonStr: '',
	        /*  */
	        erpSendYN: 'N',
	        /* ERP 국고보조 집행등록 전송여부 */
	        erpSendDate: '' /* ERP 국고보조 집행등록 전송일자 */
	    };
	    ajaxParam.jsonStr = JSON.stringify(ajaxParam);

	    $.ajax({
	        url: domain + '/exp/expend/angu/AnguI.do',
	        async: true,
	        type: "post",
	        data: ajaxParam,
	        datatype: "json",
	        success: function (result) {
	            var resultValue = result.result || {};
	            if (resultValue.resultCode == 'SUCCESS') {
	                anbojoInfo = resultValue.aData;
	                /*정상적으로 국고보조 집행등록 정보가 생성될 경우 계속 진행.*/
	            } else {
	                /*정상적으로 생성되지 않았을 경우에는 작성불가. 새로고침 유도.*/
	                alert('국고보조 집행등록 문서 생성과정중 문제가 발생되었습니다.');
	            }
	        },
	        error: function (err) {
	            console.log(err);
	        }
	    });
	    return;
	}

	/* 코드 팝업 오픈  headjson과 dataJson은 전역변수 */
	function fnBudgetAcctCodePop(bindId, item) {
		$('#budgetListPop').find( 'input[type=radio]' ).unbind().change ( function ( ) {
			/* 예산과목표시 */
			/* 예산과목표시 - 모든 예산과목 표시 */
			if ( $( '#type1Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType1 = $( '#type1Radio1' ).val ( );
			}
			/* 예산과목표시 - 당기 예산편성된 과목만 표시 */
			if ( $( '#type1Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType1 = $( '#type1Radio2' ).val ( );
			}
			/* 예산과목표시 - 프로젝트기간 예산편성된 과목만 표시 */
			if ( $( '#type1Radio3' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType1 = $( '#type1Radio3' ).val ( );
			}
			/* 사용기한 */
			/* 사용기한 - 모두표시 */
			if ( $( '#type2Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType2 = $( '#type2Radio1' ).val ( );
			}
			/* 사용기한 - 사용기한 경과분 숨김 */
			if ( $( '#type2Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType2 = $( '#type2Radio2' ).val ( );
			}
			/* 상위과목표시 */
			/* 상위과목표시 - 모두표시 */
			if ( $( '#type3Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType3 = $( '#type3Radio1' ).val ( );
			}
			/* 상위과목표시 - 최하위 표시 */
			if ( $( '#type3Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType3 = $( '#type3Radio2' ).val ( );
			}
			/* 예산그룹표시 */
			/* 예산그룹표시 - 표시 */
			if ( $( '#type4Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType4 = $( '#type4Radio1' ).val ( );
			}
			/* 예산그룹표시 - 숨김 */
			if ( $( '#type4Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType4 = $( '#type4Radio2' ).val ( );
			}
			// fnGetBudgetListS();
		} );
		
		budgetInfoSerchInfo.searchType1 = '1';
		budgetInfoSerchInfo.searchType2 = '1';
		budgetInfoSerchInfo.searchType3 = '1';
		budgetInfoSerchInfo.searchType4 = '1';

		$( '#txtBudgetName' ).unbind().focusout ( function ( ) {
			/* 예산과목명 */
			budgetInfoSerchInfo.searchBudgetName = $ ( this ).val ( );
		} );
		$( '#txtBudgetCode' ).unbind().focusout ( function ( ) {
			/* 예산과목코드 */
			budgetInfoSerchInfo.searchBudgetCode = $ ( this ).val ( );
		} );
		
		$('#btnBudgetListSearch').unbind().click(function(){
			result = codeListParam.GetCode(item.id);
			fnMakeBGTCodeJson(result);
			$.devTable.addrowCodeData(headjson, dataJson, '1', 'divBudgetAcctCodePopLayer');
			fnRegUCTableCodePopKeyEvent(event, 'divBudgetAcctCodePopLayer', 'hdnPopupData', 'hdnInputPopupInfo', headjson, '1');
		});
		
	    /*백그라운드 포커스 주기*/
	    document.body.focus();

	    /* ==========================*/
	    /* 데이터 호출 로직
	    /* ========================== */
	    fnSetGridHeaderBGT(bindId, item);
	    result = codeListParam.GetCode(item.id);
	    // result = fnGetAjaxCode(item.id);
	    fnMakeBGTCodeJson(result);

	    /*로직 완료 후 그리기*/
	    $("#divBudgetAcctCodeHelperPop").css('display', 'block');
	    $("#divBudgetAcctCodeHelperPop").attr('tabindex', '0');
	    $("#divBudgetAcctCodeHelperPop").focus();

	    /* uctable 코드팝업 그리드 헤더 생성*/
	    $.devTable.createCodeHelper(headjson, 'divBudgetAcctCodePopLayer', '1', '250px', 'N');

	    /* 데이터 바인드 */
	    $.devTable.addrowCodeData(headjson, dataJson, '1', 'divBudgetAcctCodePopLayer');

	    /* 코드도움창 키이벤트 등록 */
	    fnRegUCTableCodePopKeyEvent(event, 'divBudgetAcctCodePopLayer', 'hdnPopupData', 'hdnInputPopupInfo', headjson, '1');

	    /* 현재 코드팝업 정보 파라메터 히든값에 저장하기 */
	    item.bindId = bindId;
	    item.searchText = $("#" + bindId).val();
	    //사용자 입력 검색어
	    $("#hdnInputPopupInfo").val(JSON.stringify(item));
	    //현재 팝업 더에터 저장
	    $("#hdnPopupData").val(JSON.stringify(dataJson));

	}

	function fnSetGridHeaderBGT(bindId, item) {
	    var result = codeListParam.GetCode('ABGTLEVEL');
	    head = [];
	    head.push({
	        bgtName: "예산그룹",
	        bgtCode: "GROUP_NM"
	    });
	    $.each(result, function (idx, item) {
	        var headInfo = {};
	        headInfo.bgtName = item.USER_NM || '';
	        var bgtCode = 'BGT' + ((Number(idx) + 1) < 10 ? '0' + (Number(idx) + 1) : (Number(idx) + 1)) + '_NM';
	        headInfo.bgtCode = bgtCode;
	        head.push(headInfo);
	    });
	    head.push({
	        bgtName: "코드",
	        bgtCode: "BGT_CD"
	    });
	    fnMakeBgtHeader(head);
	}

	function fnMakeBgtHeader(head) {
	    var tempInfo = {
	        no: '',
	        displayClass: '',
	        titleName: '',
	        id: '',
	        width: '100px',
	        tdClass: 'le'
	    };
	    headjson = [];
	    $.each(head, function (idx, item) {
	        //전역 변수 초기화
	        var temp = {};
	        $.extend(temp, tempInfo);
	        temp.no = idx;
	        temp.titleName = item.bgtName;
	        temp.id = item.bgtCode;
	        headjson.push(temp);
	    });
	}

	function fnMakeBGTCodeJson(data) {
	    'use strict';
	    var codeGroup = [];

	    //            var headCodeList = '';
	    //            $.each(head, function (idx, item) {
	    //                var headStr = ['|', item.bgtCode, '|'].join('');
	    //                headCodeList += headStr;
	    //            });

	    $.each(data || [], function (index, item) {
	        var headCodeList = '';
	        $.each(head, function (idx, item) {
	            var headStr = ['|', item.bgtCode, '|'].join('');
	            headCodeList += headStr;
	        });

	        var codeRow = {};
	        if (item.GROUP_NM != undefined) {
	            codeRow.GROUP_NM = item.GROUP_NM;
	        }
	        if (item.BGT01_NM != undefined) {
	            codeRow.BGT01_NM = item.BGT01_NM;
	        } else {
	            if (headCodeList.indexOf('|BGT01_NM|') > -1) {
	                codeRow.BGT01_NM = '';
	            }
	        }
	        if (item.BGT02_NM != undefined) {
	            codeRow.BGT02_NM = item.BGT02_NM;
	        } else {
	            if (headCodeList.indexOf('|BGT02_NM|') > -1) {
	                codeRow.BGT02_NM = '';
	            }
	        }
	        if (item.BGT03_NM != undefined) {
	            codeRow.BGT03_NM = item.BGT03_NM;
	        } else {
	            if (headCodeList.indexOf('|BGT03_NM|') > -1) {
	                codeRow.BGT03_NM = '';
	            }
	        }
	        if (item.BGT04_NM != undefined) {
	            codeRow.BGT04_NM = item.BGT04_NM;
	        } else {
	            if (headCodeList.indexOf('|BGT04_NM|') > -1) {
	                codeRow.BGT04_NM = '';
	            }
	        }
	        if (item.BGT05_NM != undefined) {
	            codeRow.BGT05_NM = item.BGT05_NM;
	        } else {
	            if (headCodeList.indexOf('|BGT05_NM|') > -1) {
	                codeRow.BGT05_NM = '';
	            }
	        }
	        if (item.BGT06_NM != undefined) {
	            codeRow.BGT06_NM = item.BGT06_NM;
	        } else {
	            if (headCodeList.indexOf('|BGT06_NM|') > -1) {
	                codeRow.BGT06_NM = '';
	            }
	        }
	        if (item.BGT07_NM != undefined) {
	            codeRow.BGT07_NM = item.BGT07_NM;
	        } else {
	            if (headCodeList.indexOf('|BGT07_NM|') > -1) {
	                codeRow.BGT07_NM = '';
	            }
	        }
	        if (item.BGT_CD != undefined) {
	            codeRow.BGT_CD = item.BGT_CD;
	        }
	        codeGroup.push(codeRow);
	    });
	    dataJson = codeGroup;
	}

	/* 팝업 닫기 */
	function fnBgAcctPopClose() {
	    $("#divBudgetAcctCodeHelperPop").css('display', 'none');
	    $("#divBudgetAcctCodePopLayer").empty();
	    $("#hdnPopupData").val('');
	    $("#hdnInputPopupInfo").val('');
	}

	function popupAutoResize() {
	    // var win = window.open('_blank_','',"scrollbars=yes,resizable=yes,width=10,height=10,top=1,left=1");
	    // if(win== null || win.screenLeft == 0){
	    // 	alert("브라우져 팝업차단 설정을 확인해 주세요");
	    // } else {
	    // 	win.close();
	    // }

	    var thisX = parseInt(document.body.scrollWidth);
	    var thisY = parseInt(document.body.scrollHeight);
	    var maxThisX = screen.width - 50;
	    var maxThisY = screen.height - 50;

	    if (maxThisX > 1000) {
	        maxThisX = 1000;
	    }
	    var marginY = 0;
	    // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
	    if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45; // IE 6.x
	    else if (navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75; // IE 7.x
	    else if (navigator.userAgent.indexOf("Firefox") > 0) marginY = 50; // FF
	    else if (navigator.userAgent.indexOf("Opera") > 0) marginY = 30; // Opera
	    else if (navigator.userAgent.indexOf("Netscape") > 0) marginY = -2; // Netscape

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
	    window.moveTo(windowX, windowY);
	    window.resizeTo(maxThisX, maxThisY);
	}
	
	/* [+] ## common code budget pop ################################################## */
	var budgetInfoList = [ ];
	var budgetInfoSerchInfo = {
		/* 부분검색 - 예산과목명 */
		"searchBudgetName": "",
		/* 부분검색 - 예산과목코드 */
		"searchBudgetCode": "",
		/* 예산과목표시 */
		"searchType1": "",
		/* 사용기한 */
		"searchType2": "",
		/* 상위과목표시 */
		"searchTeyp3": "",
		/* 예산그룹표시 */
		"searchType4": "",
	};
	/* 예산4단계 / 7단계 적용으로 동적 변경 */
	var gridHeaderInfo = [ {
		"title": "예산그룹",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "관",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "항",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "목",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "세",
		"format": "string",
		"align": "left",
		"width": "120px"
	}, {
		"title": "코드",
		"format": "string",
		"align": "center",
		"width": "120px"
	} ];
	
	var budgetListInit = false;
	
	function fnCommonCodeBudgetPop(){
		/*
		var url = '/exp/expend/angu/AnguBudgetListPop.do?';
		url += ('&BSNSYEAR=' + anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'BSNSYEAR' ] [ 'BSNSYEAR' ] || '');
		url += ('&ASSTN_TAXITM_CODE=' + anbojoValue [ "bimok" ] [ [ seq.selMSeq, seq.selLSeq, seq.selSSeq ].join ( '|' ) ] [ "ASSTNTAXITMCD" ] [ "asstnExpitmTaxitmCode" ] || '');
		url += ('&GISU=' + empInfo.erpCompGisu || '0');
		url += ('&FR_DT=' + empInfo.erpCompFrDate || '');
		url += ('&TO_DT=' + empInfo.erpCompToDate || '');
		url += ('&BGT_FR_DT=' + empInfo.erpCompFrDate || '');
		
		$.ajax({
			type:"post",
			url: url,
			datatype:"json",
			data: {},
			success:function(data){
				$('#divBudgetAcctCodeHelperPop').empty();
				$('#divBudgetAcctCodeHelperPop').append(data);
				$('#divBudgetAcctCodeHelperPop').show();
			}
		});
		*/
		
		fnBudgetListInit();
		$("#divBudgetAcctCodeHelperPop").show();
	}
	
	function fnBudgetListInit(){
		if(!budgetListInit){
			fnBudgetInit ( );
			budgetListInit = !budgetListInit;
		}
		fnBudgetTableInit ( );
	}
	
	function fnBudgetInit ( ) {
		fnBudgetTableEmpty ( );
		fnBudgetTableInit ( );
		fnBudgetInitInput ( );
		fnBudgetInitEvent ( );
	}
	
	function fnBudgetInitInput ( ) {
		/* 예산과목명 */
		$('#budgetListPop').find( '#txtBudgetName' ).val ( '' );
		/* 예산과목코드 */
		$('#budgetListPop').find( '#txtBudgetCode' ).val ( '' );

		$('#budgetListPop').find( 'input[type=radio]' ).prop ( 'checked', false );
		/* 예산과목표시 */
		$('#budgetListPop').find( '#type1Radio1' ).prop ( 'checked', true );
		/* 사용기한 */
		$('#budgetListPop').find( '#type2Radio1' ).prop ( 'checked', true );
		/* 상위과목표시 */
		$('#budgetListPop').find( '#type3Radio1' ).prop ( 'checked', true );
		/* 예산그룹표시 */
		$('#budgetListPop').find( '#type4Radio1' ).prop ( 'checked', true );
	}

	function fnBudgetInitEvent ( ) {
		$('#budgetListPop').find( 'input[type=radio]' ).change ( function ( ) {
			/* 예산과목표시 */
			/* 예산과목표시 - 모든 예산과목 표시 */
			if ( $('#budgetListPop').find( '#type1Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType1 = $('#budgetListPop').find( '#type1Radio1' ).val ( );
			}
			/* 예산과목표시 - 당기 예산편성된 과목만 표시 */
			if ( $('#budgetListPop').find( '#type1Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType1 = $('#budgetListPop').find( '#type1Radio2' ).val ( );
			}
			/* 예산과목표시 - 프로젝트기간 예산편성된 과목만 표시 */
			if ( $('#budgetListPop').find( '#type1Radio3' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType1 = $('#budgetListPop').find( '#type1Radio3' ).val ( );
			}
			/* 사용기한 */
			/* 사용기한 - 모두표시 */
			if ( $('#budgetListPop').find( '#type2Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType2 = $('#budgetListPop').find( '#type2Radio1' ).val ( );
			}
			/* 사용기한 - 사용기한 경과분 숨김 */
			if ( $('#budgetListPop').find( '#type2Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType2 = $('#budgetListPop').find( '#type2Radio2' ).val ( );
			}
			/* 상위과목표시 */
			/* 상위과목표시 - 모두표시 */
			if ( $('#budgetListPop').find( '#type3Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType3 = $('#budgetListPop').find( '#type3Radio1' ).val ( );
			}
			/* 상위과목표시 - 최하위 표시 */
			if ( $('#budgetListPop').find( '#type3Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType3 = $('#budgetListPop').find( '#type3Radio2' ).val ( );
			}
			/* 예산그룹표시 */
			/* 예산그룹표시 - 표시 */
			if ( $('#budgetListPop').find( '#type4Radio1' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType4 = $('#budgetListPop').find( '#type4Radio1' ).val ( );
			}
			/* 예산그룹표시 - 숨김 */
			if ( $('#budgetListPop').find( '#type4Radio2' ).is ( ":checked" ) ) {
				budgetInfoSerchInfo.searchType4 = $('#budgetListPop').find( '#type4Radio2' ).val ( );
			}
			// fnGetBudgetListS();
		} );

		$('#budgetListPop').find( '#txtBudgetName' ).focusout ( function ( ) {
			/* 예산과목명 */
			budgetInfoSerchInfo.searchBudgetName = $ ( this ).val ( );
		} );
		$('#budgetListPop').find( '#txtBudgetCode' ).focusout ( function ( ) {
			/* 예산과목코드 */
			budgetInfoSerchInfo.searchBudgetCode = $ ( this ).val ( );
		} );

		$('#budgetListPop').find( '#btnBudgetListSearch' ).click ( function ( ) {
			/* 검색 */
			fnBudgetGetBudgetListS ( );
		} );

		$('#budgetListPop').find( '#btnBudgetAccept' ).click ( function ( ) {
			/* 확인 */
		} );

		$('#budgetListPop').find( '#btnBudgetListLayerColse' ).click ( function ( ) {
			/* 예산과목 코드도움 닫기 */
			if($('.td_inp.focus').length > 0){
				fnBindCode($('.td_inp.focus').prop('id'), {});
				/* $('#divBudgetAcctCodeHelperPop').hide(); */
				/* $('.td_inp.focus').focus(); */
				$("#divBudgetAcctCodeHelperPop").css('display', 'none');
			    $("#divBudgetAcctCodePopLayer").empty();
			    $("#hdnPopupData").val('');
			    $("#hdnInputPopupInfo").val('');
			} else {
				/* $('#divBudgetAcctCodeHelperPop').hide(); */
				/* $('.td_inp.focus').focus(); */
				$("#divBudgetAcctCodeHelperPop").css('display', 'none');
			    $("#divBudgetAcctCodePopLayer").empty();
			    $("#hdnPopupData").val('');
			    $("#hdnInputPopupInfo").val('');
			}
		} );

		$("#divBudgetAcctCodeHelperPop").on ( 'keydown', function ( event ) {
			if ( event.target.id == 'txtBudgetName' || event.target.id == 'txtBudgetCode' ) {
				switch ( event.keyCode.toString ( ) ) {
					case "119": /* F8 */
						$('#budgetListPop').find( '#btnBudgetListSearch' ).click ( );
						break;
					case "13": /* ENTER */
						$('#budgetListPop').find( '#btnBudgetListSearch' ).click ( );
						break;
					case "37": /* left */
						break;
					case "38": /* up */
						if ( $('#budgetListPop').find( '.lineOn.onSel' ).prev ( 'tr' ).length > 0 ) {
							$('#budgetListPop').find( '.lineOn.onSel' ).prev ( 'tr' ).click ( );
						}
						break;
					case "39": /* right */
						break;
					case "40": /* down */
						if ( $('#budgetListPop').find( '.lineOn.onSel' ).next ( 'tr' ).length > 0 ) {
							$('#budgetListPop').find( '.lineOn.onSel' ).next ( 'tr' ).click ( );
						}
						break;
					default:
						break;
				}
			} else {
				switch ( event.keyCode.toString ( ) ) {
					case "119": /* F8 */
						$('#budgetListPop').find( '#btnBudgetListSearch' ).click ( );
						break;
					case "13": /* ENTER */
						$('#budgetListPop').find( '.lineOn.onSel' ).dblclick ( );
						break;
					case "37": /* left */
						break;
					case "38": /* up */
						if ( $('#budgetListPop').find( '.lineOn.onSel' ).prev ( 'tr' ).length > 0 ) {
							$('#budgetListPop').find( '.lineOn.onSel' ).prev ( 'tr' ).click ( );
						}
						break;
					case "39": /* right */
						break;
					case "40": /* down */
						if ( $('#budgetListPop').find( '.lineOn.onSel' ).next ( 'tr' ).length > 0 ) {
							$('#budgetListPop').find( '.lineOn.onSel' ).next ( 'tr' ).click ( );
						}
						break;
					default:
						$('#budgetListPop').find( '#txtBudgetName' ).focus ( );
						break;
				}
			}
		} );
	}
	/* [-] ## document ready ################################################## */

	/* [+] ## document function ################################################## */
	function fnBudgetGetBudgetListS ( ) {
		/* 예산과목 코드목록 조회 */
		var ajaxParam = {};
		ajaxParam.url = '/exp/expend/angu/AbgtInfoS.do';
		ajaxParam.parameters = {};
		ajaxParam.parameters.BSNSYEAR = anbojoValue['resolve'][seq.selMSeq]['BSNSYEAR']['BSNSYEAR'] || '';
		ajaxParam.parameters.ASSTN_TAXITM_CODE = anbojoValue["bimok"][[seq.selMSeq, seq.selLSeq, seq.selSSeq].join('|')]["ASSTNTAXITMCD"]["asstnExpitmTaxitmCode"] || '';
		ajaxParam.parameters.GISU = empInfo.erpCompGisu || '0';
		ajaxParam.parameters.FR_DT = empInfo.erpCompFrDate || '';
		ajaxParam.parameters.TO_DT = empInfo.erpCompToDate || '';
		ajaxParam.parameters.BGT_NM = budgetInfoSerchInfo.searchBudgetName; /* 예산과목명 */
		ajaxParam.parameters.BGT_CD = budgetInfoSerchInfo.searchBudgetName; /* 예산과목코드 */
		ajaxParam.parameters.GR_FG = '2';
		ajaxParam.parameters.OPT_01 = budgetInfoSerchInfo.searchType1 || '1'; /* 예산과목표시 */
		ajaxParam.parameters.OPT_02 = budgetInfoSerchInfo.searchType2 || '1'; /* 사용기한 */
		ajaxParam.parameters.OPT_03 = budgetInfoSerchInfo.searchTeyp3 || '1'; /* 상위과목만표시 */
		ajaxParam.parameters.BGT_FR_DT = empInfo.erpCompFrDate || '';
		ajaxParam.parameters.DIV_CDS = '';
		ajaxParam.parameters.MGT_CDS = '';
		ajaxParam.parameters.BOTTOM_CDS = '';
		ajaxParam.parameters.GROUP_CD = '';

		$.ajax ( {
			async: false,
			type: "post",
			data: ajaxParam.parameters,
			url: ajaxParam.url,
			datatype: "json",
			success: function ( resultValue ) {
				$('#budgetListPop').find( '.rightContents table tr' ).unbind ( );
				$('#budgetListPop').find( '.rightContents table' ).empty ( );
				var table = $('#budgetListPop').find( '.rightContents table' );
				var dispAttr = [ 'GROUP_NM', 'BGT01_NM', 'BGT02_NM', 'BGT03_NM', 'BGT03_NM', 'BGT_CD' ];
				$.each ( resultValue.result.aaData, function ( idx, item ) {
					var tr = document.createElement ( 'tr' );

					$.each ( dispAttr, function ( col, name ) {
						$ ( tr ).append ( ' <td style="width:' + gridHeaderInfo[col].width + ';" class="le"><span>' + ( item [ name ] != undefined ? item [ name ].toString ( ) : '' ) + '</span></td>' );
					} );

					$ ( tr ).data ( 'result', item );
					$ ( tr ).click ( function ( ) {
						$ ( this ).parent ( ).find ( 'tr' ).removeClass ( 'lineOn onSel' );
						$ ( this ).addClass ( 'lineOn onSel' );
					} );
					$ ( tr ).dblclick ( function ( ) {
						if($('.td_inp.focus').length > 0){
							fnBindCode($('.td_inp.focus').prop('id'), $ ( this ).data ( 'result' ));
							$("#divBudgetAcctCodeHelperPop").css('display', 'none');
						    $("#divBudgetAcctCodePopLayer").empty();
						    $("#hdnPopupData").val('');
						    $("#hdnInputPopupInfo").val('');
						}
					} );

					table.append ( tr );
				} );

				table.find ( 'tr:first' ).click ( );
				$('#budgetListPop').find( '#btnBudgetListSearch' ).focus ( );
			},
			error: function ( err ) {
				console.log ( err );
			}
		} );
	}
	/* [-] ## document function ################################################## */

	/* [+] ## scroll event ################################################## */
	//휠스크롤
	function fixDataOnWheel ( ) {
		if ( event.wheelDelta < 0 ) {
			DataScroll.doScroll ( 'scrollbarDown' );
		} else {
			DataScroll.doScroll ( 'scrollbarUp' );
		}
		table1Scroll ( );
	}
	//각 테이블 스크롤 동기화
	function table1Scroll ( ) {
		$('#budgetListPop').find( ".table1 .leftContents" ).scrollTop ( $('#budgetListPop').find( ".table1 .rightContents" ).scrollTop ( ) );
		$('#budgetListPop').find( ".table1 .rightHeader" ).scrollLeft ( $('#budgetListPop').find( ".table1 .rightContents" ).scrollLeft ( ) );
	}
	/* [-] ## document ready ################################################## */
	
	/* [+] ## table init ################################################## */
	function fnBudgetTableInit ( ) {
		fnBudgetTableHeadInit ( );
	}

	function fnBudgetTableHeadInit ( ) {
		$('#budgetListPop').find( '.rightHeader>table tr' ).empty ( );
		var tr = $('#budgetListPop').find( '.rightHeader>table tr' );
		$.each ( gridHeaderInfo, function ( idx, item ) {
			var th = '<th style="width:' + item.width + ';">' + item.title + '</th>';
			tr.append ( th );
		} );
	}

	function fnBudgetTableAddRow ( rowItem ) {
		var itemInfo = [ 'budgetGroup', 'gan', 'hang', 'mok', 'se', 'code' ];
		var table = $('#budgetListPop').find( 'div.rightContents>table' );
		var tr = '<tr>';
		$.each ( gridHeaderInfo, function ( idx, item ) {
			tr += '<td style="width:' + item.width + ';" class="le"><span>' + rowItem [ itemInfo [ idx ] ] + '</span></td>'
		} );
		tr += '</tr>';

		table.append ( tr );
	}

	function fnBudgetTableEmpty ( ) {
		var table = $('#budgetListPop').find( 'div.rightContents>table' );
		table.find ( 'tr' ).unbind ( );
		table.empty ( );
	}

	function fnBudgetTableSelectRow ( ) {
		var TR = $('#budgetListPop').find( '.rightContents.cus_ta table tr' );
		TR.unbind ( );
		TR.click ( function ( ) {
			TR.removeClass ( 'lineOn onSel' );
			$ ( this ).addClass ( 'lineOn onSel' );
		} );
	}
	/* [-] ## table init ################################################## */
	/* [-] ## common code budget pop ################################################## */
</script>

<!--  인력정보 정보 -->
<input type="text" id="txtPayInfoData" style="display: none;" />
<!--  팝업 데이터 -->
<input type="hidden" id="hdnPopupData" />
<!--  팝업을 띄운 input 정보 -->
<input type="hidden" id="hdnInputPopupInfo" />

<div class="pop_wrap brbn">
	<div class="pop_sign_head posi_re">
		<h1>e나라도움 결의정보등록</h1>
		<div class="psh_btnbox">

			<!-- 양식팝업 오른쪽 버튼그룹 -->
			<div class="psh_right">
				<div class="btn_cen mt8">
					<input type="button" id="btnApproval" class="psh_btn" value="결재상신" />
				</div>
			</div>
		</div>
	</div>
	<div class="pop_con posi_re pb50">
		<div class="top_box ovh">
			<dl style="min-width: 980px;">
				<dt>회계단위</dt>
				<dd style="width: 25%;">
					<input type="text" id="txtErpBizName" style="width: 90%;" disabled="disabled" />
					<!--<a href="#" class="btn_search"></a>-->
				</dd>
				<dt>결의부서 / 작성자</dt>
				<dd style="width: 25%;">
					<input type="text" id="txtErpDeptEmpName" style="width: 90%;" disabled="disabled" />
					<!--<a href="#" class="btn_search"></a>-->
				</dd>
				<dt>작성일</dt>
				<dd>
					<input id="txtGisuDate" value="2015-01-01" class="dpWid" />
				</dd>
			</dl>
		</div>
		<!-- 결의내역 ------------------------------------------------------------------------------------------------------------------------->
		<div class="clear">
			<p class="tit_p mt20 fl">결의내역</p>

			<div class="controll_btn pt15 fr">
				<button id="btnAddResolRow">추가</button>
				<button id="">삭제</button>
			</div>
		</div>

		<!-- 결의내역 테이블 -->
		<div id="resolveContent"></div>
		<!-- 증빙내역 ------------------------------------------------------------------------------------------------------------------------->
		<div class="clear">
			<p class="tit_p mt20 fl">증빙내역</p>
		</div>
		<!-- 증빙내역 테이블 -->
		<div id="authContent"></div>
		<!-- 비목내역 ------------------------------------------------------------------------------------------------------------------------->
		<div class="clear">
			<p class="tit_p mt20 fl">비목내역</p>

			<div class="controll_btn pt15 fr">
				<button id="btnAddBimokRow">추가</button>
				<button>삭제</button>
			</div>
		</div>
		<!-- 비목내역 테이블 -->
		<div id="bimokContent"></div>
		<!-- 재원내역 ------------------------------------------------------------------------------------------------------------------------->
		<div class="clear">
			<p class="tit_p mt20 fl">재원내역</p>

			<div class="controll_btn pt15 fr">
				<input type="button" id="btnPerCodePop" value="인력정보등록" class="ml2" />
				<button>삭제</button>
			</div>
		</div>
		<!-- 재원내역 테이블 -->
		<div id="jaewonContent"></div>

		<!-- 재원내역 하단box -->
		<div id="" class="mt20 bg_lightgray">
			<div class="twinbox">
				<table style="min-height: 100px;">
					<colgroup>
						<col width="50%" />
						<col />
					</colgroup>
					<tr>
						<td class="twinbox_td">
							<div class="clear">
								<span class="fl mt5 mr5">증빙공급가</span> <input id="txtAuthAmt" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 mr5 ml20">등록공급가</span> <input id="txtAppAmt" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" />
							</div>
							<div class="clear mt10">
								<span class="fl mt5 mr5">증빙부가세</span> <input id="txtAuthVat" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 mr5 ml20">등록부가세</span> <input id="txtAppVat" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" />
							</div>
							<div class="clear mt10">
								<span class="fl mt5 mr5">증빙총금액</span> <input id="txtAuthTotalAmt" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" />
							</div>
						</td>
						<td class="twinbox_td">
							<div class="clear">
								<span class="fl mt5 mr5">계획금액</span> <input id="txtPlanAmount" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" />
							</div>

							<div class="clear mt10">
								<span class="fl mt5 mr5">집행금액</span> <input type="text" id="txtSumAmount" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 ml20" style="width: 110px;">E나라도움 집행금액</span> <span id="lblExcutAmount" class="fl mt5 ml20 ar" style="width: 100px;"></span>
							</div>

							<div class="clear mt10">
								<span class="fl mt5 mr5">집행잔액</span> <input type="text" id="txtSubAmount" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 ml20" style="width: 110px;">미등록 집행금액</span> <span id="lblSumAmount" class="fl mt5 ml20 ar" style="width: 100px;"></span>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>


	</div>
	<!--// pop_con -->
</div>
<!--// pop_wrap -->
<!-- 입력팁 -->
<div class="toolTipBox">
	<span id="spanToolTipTxt">-</span>
</div>
<!-- 코드도움팝업 -->
<div id="divCodeHelperPop" class='divTopPopup' style="display: none">
	<div class="modal posi_fix" style="z-index: 101"></div>
	<div class="pop_wrap_dir posi_ab" style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 102">
		<div class="pop_head">
			<h1>코드도움</h1>
			<a href="javascript:fnPopClose()" class="clo"> <img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
		</div>
		<div class="pop_con">
			<div class="top_box">
				<dl>
					<dt>검색</dt>
					<dd class="mr0" style="width: 85%;">
						<input type="text" id="txtCodeSearch" class="UCSearch" style="width: 85%; text-indent: 4px;" /> <input type="button" id="searchButton" value="검색" />
					</dd>
				</dl>
			</div>
			<div id='divCodePopLayer'></div>
		</div>
	</div>
</div>

<!-- 전자세금 계산서 코드도움팝업 -->
<div id="divTaxCodeHelperPop" class='divTopPopup' style="display: none">
	<div class="modal posi_fix" style="z-index: 101"></div>

	<div class="pop_wrap_dir posi_ab" style="width: 800px; height: 607px; top: 50%; left: 50%; margin: -303px 0 0 -400px; z-index: 102">
		<div class="pop_head">
			<h1>전자세금계산서 자료조회</h1>
			<a href="javascript:fnTaxPopClose()" class="clo"> <img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
		</div>

		<div class="pop_con">
			<div id="divTaxCodeSelectZone" class="top_box">
				<dl>
					<dl>
						<dd class="ml20" style="width: 150px;">
							<select id="selDTFG" class="selectmenu" style="width: 148px;">
								<option value="1" selected="selected">작성일자</option>
								<option value="2">발행일자</option>
							</select>
						</dd>
						<dd>
							<div class="dal_div">
								<input type="text" id="txtFRDT" value="2015-02-01" class="w113" />

							</div>
							~
							<div class="dal_div">
								<input type="text" id="txtTODT" value="2017-02-01" class="w113" />
							</div>
						</dd>
						<dt class="ar" style="width: 94px;">세무구분</dt>
						<dd style="width: 150px;">
							<select id="selTAXTY" class="selectmenu" style="width: 148px;">
								<option value="2" selected="selected">과세</option>
								<option value="4">면세</option>
							</select>
						</dd>

					</dl>

					<dl class="next2">
						<dt class="ar" style="width: 145px;">매입거래처</dt>
						<dd style="width: 250px;">
							<select id="selTRCD" class="selectmenu" style="width: 222px;">
								<!-- 									<option value="">전체</option> -->
								<!-- 									<option value="" selected="selected">000001 정주개발</option> -->
							</select> <a href="#" class="fl btn_search" onClick="fnGetETaxPater()"></a>
						</dd>
						<dt>세금계산서분류</dt>
						<dd style="width: 150px;">
							<select id="selETAXTY" class="selectmenu" style="width: 148px;">
								<option value="" selected="selected">전체</option>
								<option value="1">일반</option>
								<option value="2">수정</option>
							</select>
						</dd>
					</dl>
				</dl>
			</div>
			<div id='divTaxCodePopLayer'></div>

			<!-- 안내문구 -->
			<p class="text_blue f11 mt20">
				* <span id="Span1">조회한 전자세금계산서가 없는 경우, ERP에서 자료수집을 실행해 주세요.</span>
			</p>

		</div>

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" value="자료수집 요청" /> <input type="button" onClick="fnGetEtaxDtaAjax()" value="조회(F8)" />
				<!--                     <input type="button" value="확인" /> -->
				<!--                     <input type="button" class="gray_btn" value="취소" /> -->
			</div>
		</div>
		<!-- //pop_foot -->

	</div>

	<!-- 코드도움팝업 -->
	<div id="divTaxSubCodeHelperPop" class='divTopPopup' style="display: none">
		<div class="modal posi_fix" style="z-index: 103"></div>

		<div class="pop_wrap_dir posi_ab" style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 104">
			<div class="pop_head">
				<h1>코드도움</h1>
				<a href="javascript:fnSubPopClose();" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
			</div>

			<div class="pop_con">
				<div class="top_box">
					<dl>
						<dt>검색</dt>
						<dd class="mr0" style="width: 85%;">
							<input type="text" id="txtSubCodeSearch" class="subSearch" style="width: 85%; text-indent: 4px;" /> <input type="button" id="searchSubButton" value="검색" />
						</dd>
					</dl>
				</div>
				<div id='divTaxSubCodePopLayer'></div>

			</div>
		</div>
	</div>
</div>



<!-- 카드거래내역 코드도움팝업 -->
<div id="divCardDealtHelperPop" class='divTopPopup' style="display: none">
	<div class="modal posi_fix" style="z-index: 101"></div>

	<div class="pop_wrap_dir posi_ab" style="width: 800px; height: 607px; top: 50%; left: 50%; margin: -303px 0 0 -400px; z-index: 102">
		<div class="pop_head">
			<h1>카드거래내역 자료조회</h1>
			<a href="javascript:fnCardDealPopClose()" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
		</div>

		<div class="pop_con">
			<div class="top_box" id="divCardDealSelectZone">
				<dl>
					<dl>
						<dt>카드거래일자</dt>
						<dd>
							<div class="dal_div">
								<input type="text" id="txtStDt" value="" class="w113" />
							</div>
							~
							<div class="dal_div">
								<input type="text" id='txEnDt' value="" class="w113" />
							</div>
						</dd>
						<dt class="ar" style="width: 60px;">신용카드</dt>
						<dd style="width: 290px;">
							<input class="input_search" id="txtCardName" type="text" value="" style="width: 256px;" readonly="readonly" /> <a href="javascript: fnGetCardInfo()" class="btn_search"></a>
						</dd>
					</dl>

					<dl class="next2">
						<dt class="ar" style="width: 78px;">총금액</dt>
						<dd style="width: 250px;">
							<input class="input_search" id="txtTotalAmt" type="text" value="" style="width: 245px;" />
						</dd>
						<dt class="ar" style="width: 58px;">가맹점명</dt>
						<dd style="width: 282px;">
							<input class="input_search" id="txtAffiliateName" type="text" value="" style="width: 280px;" />
						</dd>
					</dl>
				</dl>
			</div>

			<div id='divCardDealPopLayer'></div>

			<!-- 안내문구 -->

		</div>

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<!--<input type="button" value="자료수집" />-->
				<input type="button" onClick="fnGetCardDealDataAjax()" value="조회(F8)" />
				<!--                     <input type="button" value="확인" /> -->
				<!--                     <input type="button" class="gray_btn" value="취소" /> -->
			</div>
		</div>
		<!-- //pop_foot -->

	</div>

	<!-- 코드도움팝업 -->
	<div id="divCardSubCodeHelperPop" class='divTopPopup' style="display: none">
		<div class="modal posi_fix" style="z-index: 103"></div>

		<div class="pop_wrap_dir posi_ab" style="width: 516px; height: 640px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 104">
			<div class="pop_head">
				<h1>코드도움</h1>
				<a href="javascript:fnSubCardPopClose()" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
			</div>

			<div class="pop_con">
				<div class="top_box">
					<dl>
						<dt>검색</dt>
						<dd class="mr0" style="width: 85%;">
							<input type="text" id="txtSubCardSearch" class="subCardSearch" style="width: 85%; text-indent: 4px;" /> <input type="button" id="searchSubCardButton" value="검색" />
						</dd>
					</dl>
				</div>
				<div id='divCardSubCodePopLayer'></div>

			</div>
		</div>
	</div>
</div>

<!-- 예산과목 조회 팝업  -->
<div id="divBudgetAcctCodeHelperPop" class='divTopPopup' style="display: none">
	<!-- modal -->
	<div class="modal posi_fix" style="z-index: 101"></div>

	<div id="budgetListPop" class="pop_wrap_dir posi_ab" style="width: 800px; height: 715px; top: 50%; left: 50%; margin: -338px 0 0 -400px; z-index: 102">
		<div class="pop_head">
			<h1>예산과목 코드도움</h1>
			<a id="btnBudgetListLayerColse" href="#n" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
		</div>

		<div class="pop_con">
			<!-- 테이블 -->
			<div id="divBudgetAcctCodePopLayer"></div>

			<!-- 부분검색 -->
			<div class="top_box mt20">
				<dl>
					<dl>
						<dt style="width: 110px;">부분검색</dt>
						<dt>예산과목명</dt>
						<dd style="width: 200px;">
							<input class="input_search" id="txtBudgetName" type="text" value="" style="width: 166px;" />
							<!--<a href="#" class="btn_search"></a>-->
						</dd>
						<dt>예산과목코드</dt>
						<dd style="width: 200px;">
							<input class="input_search" id="txtBudgetCode" type="text" value="" style="width: 166px;" />
							<!--<a href="#" class="btn_search"></a>-->
						</dd>
					</dl>

					<dl class="mt-20">
						<dt style="width: 120px;">예산과목표시</dt>
						<dd>
							<input type="radio" name="type1_radio" id="type1Radio1" value="1" class="ml10" checked=""> <label for="type1Radio1">모든 예산과목 표시</label> <input type="radio" name="type1_radio" id="type1Radio2" value="2" class="ml20"> <label for="type1Radio2">당기 예산편성된 과목만 표시</label> <input type="radio" name="type1_radio" id="type1Radio3" value="3" class="ml20"> <label for="type1Radio3">프로젝트기간 예산편성된 과목만 표시</label>
						</dd>
					</dl>

					<dl class="mt-20">
						<dt style="width: 120px;">사용기한</dt>
						<dd>
							<input type="radio" name="type2_radio" id="type2Radio1" value="1" class="ml10" checked=""> <label for="type2Radio1">모두표시</label> <input type="radio" name="type2_radio" id="type2Radio2" value="2" style="margin-left: 76px;"> <label for="type2Radio2">사용기한 경과분 숨김</label>
						</dd>
					</dl>

					<dl class="mt-20">
						<dt style="width: 120px;">상위과목표시</dt>
						<dd>
							<input type="radio" name="type3_radio" id="type3Radio1" value="1" class="ml10" checked=""> <label for="type3Radio1">모두표시</label> <input type="radio" name="type3_radio" id="type3Radio2" value="2" style="margin-left: 76px;"> <label for="type3Radio2">최하위 표시</label>
						</dd>
					</dl>

					<!-- <dl class="mt-20">
                            <dt style="width:120px;">예산그룹표시</dt>
                            <dd>
                                <input type="radio" name="type4_radio" id="type4Radio1" class="ml10" checked="">
                                <label for="type4Radio1">표시</label>
                                <input type="radio" name="type4_radio" id="type4Radio2" style="margin-left:100px;">
                                <label for="type4Radio2">숨김</label>
                            </dd>
                        </dl> -->
				</dl>
			</div>

		</div>
		<!--// pop_con -->

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input id="btnBudgetListSearch" type="button" value="검색(F8)" /> <input id="btnBudgetAccept" type="button" value="확인" />
				<!-- <input type="button" class="gray_btn" value="취소" /> -->
			</div>
		</div>
		<!-- //pop_foot -->
	</div>
	<!--// pop_wrap -->
</div>
<!--// 카드거래내역 자료조회 팝업 -->