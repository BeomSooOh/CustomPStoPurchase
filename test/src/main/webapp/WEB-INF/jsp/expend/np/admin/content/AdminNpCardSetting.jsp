<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%-- <%@ include file="/WEB-INF/jsp/ea/include/includeCmmOrgPop.jsp"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/jquery.mask.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCodePop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.focus.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<script>
	/* 변수정의 */
	var ifSystem = '${ViewBag.erpTypeCode}';
	var baseUrl = '<c:url value="/" />'; /* 팝업 호출시 사용 */
	var searchCompSeq = ''; /* 팝업 호출시 사용 */
	var empInfo = {
	    erpEmpSeq : "${ViewBag.empInfo.erpEmpSeq}",
	    langCode : "${ViewBag.empInfo.langCode}",
	    erpCompSeq : "${ViewBag.empInfo.erpCompSeq}",
	    groupSeq : "${ViewBag.empInfo.groupSeq}",
	    empSeq : "${ViewBag.empInfo.empSeq}",
	    compSeq : "${ViewBag.empInfo.compSeq}",
	    userSe : "${ViewBag.empInfo.userSe}",
	    deptSeq : "${ViewBag.empInfo.deptSeq}",
	    bizSeq : "${ViewBag.empInfo.bizSeq}"
	};
	
    /* 문서로드 */
    $(document).ready(function() {
        fnConfigCardInit();
        fnConfigCardInitEvent();
        $('#btnConfigCardSearch').click();
        if(ifSystem != 'ERPiU'){
        	$('.ERPiU').hide();	
        }
    });
    
    /* 초기화 */
    function fnConfigCardInit() {
    	
        $('#devMode_forCmPop').val(empInfo.groupSeq);
        $('#langCode_forCmPop').val(empInfo.langCode);
        $('#groupSeq_forCmPop').val(empInfo.groupSeq);
        $('#compSeq_forCmPop').val(empInfo.compSeq);
        $('#deptSeq_forCmPop').val(empInfo.deptSeq);
        $('#empSeq_forCmPop').val(empInfo.empSeq);
        
        $('#compFilter_forCmPop').val("${ViewBag.empInfo.compSeq}");
        $('#selectedItems_forCmPop').val("");
		
        /* 연동 모듈에 따른 아이템 출력 선택 */
    	if(ifSystem == 'BizboxA'){
    		// 자체예산의 경우 
            /* ERP에서 가져오기 기능 지우기 */
            $('#btnConfigCardFromErp').hide();
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE의 경우.
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
    		$("#trBank").hide();
 
            /* ERP에서 가져오기 기능 출력 */
            $('#btnConfigCardFromErp').show();
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU의 경우. 
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
            
            /* ERP에서 가져오기 기능 출력 */
            $('#btnConfigCardFromErp').show();
    	}else{
    		// 기타 시스템의 경우
    	}
        
        // 최초 접근 포커스 위치 조정 
        $('#searchCardName').focus();
        return;
    }

    /* 이벤트 초기화 */
    function fnConfigCardInitEvent() {
        /* 변수정의 */
        var param = {};
        /* 이벤트 정의 */
        /* 이벤트 정의 - ERP가져오기 */
        $('#btnConfigCardFromErp').click(function() {
            fnConfigCardFromErp();
            return;
        });
        
        /* 이벤트 정의 - 조회 엔터입력*/
        $('#txtSearchStr').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#btnConfigCardSearch').click();
            }
        });
        
        /* 이벤트 정의 - 조회 */
        $('#btnConfigCardSearch').click(function() {
            fnConfigCardSearch();
            return;
        });
        /* 이벤트 정의 - 신규 */
        $('#btnConfigCardNew').click(function() {
            fnConfigCardNew();
            $('#txtCardName').focus();
            return;
        });
        /* 이벤트 정의 - 저장 */
        $('#btnConfigCardSave').click(function() {
            fnConfigCardSave();
            return;
        });
        /* 이벤트 정의 - 삭제 */
        $('#btnConfigCardDelete').click(function() {
            fnConfigCardDelete();
            return;
        });
        /* 이벤트 정의 - 공개범위 */
        $('#btnOrgChart').click(function() {

            var url = "<c:url value='/gw/systemx/orgChart.do'/>";
            var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

            frmPop2.target = "cmmOrgPop";
            frmPop2.method = "post";
            frmPop2.action = url.replace("/exp", "");
            frmPop2.submit();
            frmPop2.target = "";
            pop.focus();
            return;
        });
        /* 이벤트 정의 - 금융거래처 */
        $('#btnPartnerPop').click(function() {
            fnConfigCardPartnerPop();
            return;
        });
        /* 이벤트 정의 - 공개범위 초기화 */
        $('#btnPublicReload').click(function(event){
        	fnCardPublicReload();
        })
        
        /* 공개범위 포커스 트리거 등록 - 공개범위 선택 조직도 팝업 */
        $('#txtCardPublic').focus(function(){
        	if(!$('#txtCardPublic').val()){
        		$('#btnOrgChart').click();	
        	}
        });
        
        /* 이벤트 정의 - 엔터입력시 포커스 이동 jQuery.exp.expend.focus.js 참조 */
        focus_fnSetFocusEvent(
       		['txtCardName', 'txtCardNum', 'cardPublic']
       		, fnConfigCardSave
     	);
        return;
    }

    /* 버튼클릭 이벤트 - 공개범위 초기화 */
    function fnCardPublicReload(param){
        $('#selectedItems_forCmPop').val('');
        $('#hidCardPublic').val('');
        $('#txtCardPublic').val('');
    }
    
    /* 버튼클릭 이벤트 - 조회 */
    var autoSync = false;
    function fnConfigCardSearch( param ) {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        searchCompSeq = "${ViewBag.empInfo.compSeq}"; /* 팝업 호출시 사용 */
        param.codeType = "CARD";
        param.searchType = 'IN';
        param.useYN = $("#selUseYN").val();
		param.searchCardName = ($("#searchCardName").val() || '');
		param.searchCardNum = ($("#searchCardNum").val() || '');
		param.searchPartnerCode = ($("#searchPartnerCode").val() || '');
		param.searchPartnerName = ($("#searchPartnerName").val() || '');
		param.selPublic = ($("#selPublic").val() || '');
		param.eaType = 'ea';
		
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	console.log(data);
            	if(!data.result.aaData.length && !autoSync && ifSystem != 'BizboxA'){
            		// 데이터 없는 경우 자동 연동 진행
           			$('#btnConfigCardFromErp').click();
            	}else{
	                if (typeof data.result.aaData != 'undefined') {
	                    /* 테이블 데이터 바인딩 */
	                    fnConfigCardSetTable(data.result.aaData);
	                } else {
	                    /* 테이블 데이터 바인딩 */
	                    fnConfigCardSetTable('');
	                }
	                /* 신규 버튼 클릭이벤트 발생 */
	                $('#btnConfigCardNew').click();
	                
	                /* 조회의 경우 포커스 고정 */
	                if($('#txtCardName').val()){
	                	$('#txtCardName').focus();
	                	isSearchFlag = false;
	                }
	                
	                $('#cardCount').html(data.result.aaData.length);
	                
            	}
            	
            	autoSync = true;
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 테이블 데이터 바인딩 */
    function fnConfigCardSetTable( data ) {
        data = (data || '');
        $('#divConfigCardList').empty();
        $('#divConfigCardList').append('<table id="tblConfigCardList"></table>');

        $('#tblConfigCardList').DataTable({
            "select" : true,
            "paging" : false,
            "bAutoWidth" : false,
            "destroy" : true,
            "sScrollY" : '350px',
            'bSort' : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    fnConfigCardSelectRow(aData);
                }));
            },
            /* { "targets" : 0, "data" : null, "render" : function( aData ) { if (aData != null && aData != "") { return "<input type='checkbox' id='chkSel' name='chkSel' value='" + aData.compSeq + "|" + aData.cardNum + "'/>"; } else { return ""; } } }, */
            columnDefs : [ {
                "targets" : 2,
                "data" : null,
                "render" : function( aData ) {
                    if ((aData.partnerCode || '') != '' && (aData.partnerName || '') != '') {
                        return '[' + (aData.partnerCode || '') + '] ' + (aData.partnerName || '');
                    } else {
                        return '';
                    }
                }
            }, {
                "targets" : 3,
                "data" : null,
                "render" : function( aData ) {
                    if (aData != null && aData != "") {
                        var useLabel = "";
                        if (aData.useYN == "0" || aData.useYN == "N") {
                        	useLabel = "<%=BizboxAMessage.getMessage("TX000001243","미사용")%>";

                        } else {
                        	useLabel = "<%=BizboxAMessage.getMessage("TX000000180","사용")%>";

                        }
                        return useLabel;

                    } else {
                        return "";
                    }
                }
            }, {
            	"targets" : 4
            	, "data" : null
	           	, "render" : function (aData){
    				var data = '' + (aData.cardPublicJson || '"returnObj":[]');
    				if( data.indexOf('"returnObj":[]') > -1  ){
    					return '<span class="text_red">${CL.ex_notSetting}</span>';
    				} else {
    					return '<span>${CL.ex_setting}</span>';
    				}
            		return "";
            	}
            } ],
            /* { sTitle : "<input type='checkbox' id='chkSels' name='chkSels' onclick='fnAllCheckBoxChecked(this, " + '"' + "chkSel" + '"' + " )'/>", bSearchable : false, bSortable : false, sWidth : "34", sClass : "center" }, */
            aoColumns : //컬럼과 프로퍼티 연결
            [ {
                sTitle : "<%=BizboxAMessage.getMessage("TX000000527","카드명")%>",
                mDataProp : "cardName",
                bVisible : true,
                bSortable : true,
                className : "td_le"
            }, {
                sTitle : "${CL.ex_cardNumber}",
                mData : function (source, type, val){
                	var cardNum = source.cardNum.replace(/-/gi,'') || '';
                	cardNum = cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, "-")
                	return cardNum;
                },
                //mDataProp : "cardNum",
                bVisible : true,
                bSortable : true,
                sWidth : ""
            }, {
                sTitle : "${CL.ex_financeClient}",
                bVisible : true,
                bSortable : true,
                className : "td_le"
            }, {
                sTitle : "${CL.ex_inUseYN}",
                bVisible : true,
                bSortable : true
            }, {
                sTitle : "<%=BizboxAMessage.getMessage("TX000018746","공개범위 설정여부")%>",
                bVisible : true,
                bSortable : true
            } ]
        });

        if (ifSystem != 'BizboxA') {
            $('#btnConfigCardNew').hide(); /* ERP연동인 경우, 카드 신규 생성 기능 제외 - ERP 기준 카드만 바라봐야 하기 때문 */
            $('#btnConfigCardDelete').hide(); /* ERP연동인 경우, 카드 삭제 기능 제외 - ERP 기준 카드만 바라봐야 하기 때문 */
            $('#btnConfigCardFromErp').show(); /* ERP연동인 경우, ERP가져오기기능 활성 - ERP 기준 카드만 바라봐야 하기 때문 */
        } else {
            $('#btnConfigCardNew').show(); /* ERP 연동이 아닌경우, 카드 직접 관리 */
            $('#btnConfigCardDelete').show(); /* ERP 연동이 아닌경우, 카드 직접 관리 */
            $('#btnConfigCardFromErp').hide(); /* ERP 연동이 아닌경우, 데이터 조회 불가 */
        }
    }

    /* 행클릭 이벤트 */
    function fnConfigCardSelectRow( data ) {
    	var displayPartner = "";
    	var useYN = "";
        if (data.cardPublicJson != undefined && data.cardPublicJson != '') {
            fnCallbackSel(JSON.parse(data.cardPublicJson)); /* 공개범위 */
        } else {
        	fnCallbackSel({"returnObj":[]});
            $('#selectedItems_forCmPop').val('');
            $('#hidCardPublic').val('');
            $('#txtCardPublic').val('');
        }

        if(data.useYN == "Y") {
        	useYN = "사용";
        } else {
        	useYN = "미사용";
        }
        
        displayPartner = "[ " + data.partnerCode + " ] " + data.partnerName;  
        $('#txtCardCode').val(data.card_code); /* 카드코드 */
        $('#txtCardName').val(data.cardName); /* 카드명칭 */
        $('#txtCardNum').val(data.cardNum); /* 카드번호 */
        $('#cardUseYN').text(useYN); /* 사용여부 */
        $('#txtPartnerCode').val(data.partnerCode); /* 금융거래처 */
        $('#txtPartnerName').val(data.partnerName); /* 금융거래처 */
        $('#txtPartnerDisplay').val(displayPartner); /* 금융거래처 */
        
    	if(ifSystem == 'BizboxA'){
    		// 자체예산의 경우 
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerDisplay').attr('disabled', 'disabled');
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE의 경우. 
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
    		$("#trBank").hide();
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU의 경우. 
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
    	}else{
    		// 기타 시스템의 경우
    	}
        
        return;
    }

    /* 버튼클릭 이벤트 - 엑셀다운로드 */
    function fnConfigCardInitEventButton_ConfigCardExcelDownload( param ) {
        alert("<%=BizboxAMessage.getMessage("TX000009615","서비스 준비중입니다")%>" + '...');
        return;
    }

    /* 버튼클릭 이벤트 - ERP에서가져오기 */
    function fnConfigCardFromErp( param ) {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000018747","ERP와 카드정보 연동을 진행할까요?")%>")){
    		return;
    	}
    	
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = $('#selCompany').val();
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoFromErpCopy.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 조회 버튼 클릭이벤트 발생 */
                $('#btnConfigCardSearch').click();
                alert("<%=BizboxAMessage.getMessage("TX000018749","성공적으로 동기화하였습니다.")%>");
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 버튼클릭 이벤트 - 신규 */
    function fnConfigCardNew( param ) {

    	if(ifSystem == 'BizboxA'){
    	} else if(ifSystem == 'iCUBE'){
    	} else if(ifSystem == 'ERPiU'){
    	} else{
    		// 기타 시스템의 경우
    	}

        // 데이터 초기화 진행
        $('#selectedItems_forCmPop').val('');
        $('#hidCardPublic').val('');
        $('#txtCardPublic').val('');
        $('#txtCardCode').val('');
        $('#txtPartnerCode').val('');
        $('#txtPartnerDisplay').val('');
        $('#txtCardPublic').val('');
        return;
    }
    /* 버튼클릭 이벤트 - 저장 */
    function fnConfigCardSave( param ) {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        param.cardCode = $('#txtCardCode').val();
        if (param.cardCode == '') {
            param.cardCode = ($('#txtCardNum').val()).toString().replace(/-/g, '');
        }
        param.cardNum = $('#txtCardNum').val();
        param.cardName = $('#txtCardName').val();
        param.partnerCode = $('#txtPartnerCode').val();
        param.partnerName = $('#txtPartnerName').val();
        param.useYn = $('#selUseYN').val();
        param.searchStr = '';
        param.cardPublicJson = ($('#hidCardPublic').val() || '');

        /* 파라미터 검증 부분 */
        if(!param.cardName){
        	$('#txtCardName').focus();
        	alert("<%=BizboxAMessage.getMessage("TX000009613","카드명을 입력하세요")%>");
        	return;
        }
        if(!param.cardNum){
        	alert("<%=BizboxAMessage.getMessage("TX000018751","카드번호를 입력하세요")%>");
        	console.log('open org pop');
        	$('#txtCardNum').focus();
        	return;
        }
        
        
        var public_json_str = JSON.parse(($('#hidCardPublic').val() || '{}'));
        var temp = [];

        if( !public_json_str.returnObj){
        	alert("<%=BizboxAMessage.getMessage("TX000009611","공개범위를 입력하세요")%>");
        	$('#btnOrgChart').click();
        	return ;
        }
        
        $.each(public_json_str.returnObj, function( idx, item ) {
            var cardPublic = {};
            $.extend(cardPublic, ExCodeCardPublic);
            cardPublic.compSeq = item.compSeq;
            cardPublic.cardNum = $('#txtCardNum').val();
            cardPublic.orgDiv = item.empDeptFlag;

            if (item.empDeptFlag == 'c') {
                cardPublic.orgId = item.compSeq;
            } else if (item.empDeptFlag == 'd') {
                cardPublic.orgId = item.deptSeq;
            } else if (item.empDeptFlag == 'u') {
                cardPublic.orgId = item.empSeq;
            }
            temp.push(cardPublic);
        });
        param.cardPublic = JSON.stringify(temp);
        
        /* URL 정의 */
        var url = '';
        var attr = $('#txtCardNum').attr('disabled');
        
        url = '<c:url value="/ex/admin/config/CardInfoUpdate.do" />';
        
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                // console.log("! [EX] SUCCESS - " + JSON.stringify(data));
                /* 조회 버튼 클릭이벤트 발생 */
                $('#btnConfigCardSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 버튼클릭 이벤트 - 삭제 */
    function fnConfigCardDelete( param ) {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000015635","정말 삭제하시겠습니까 ?")%>")){
    		return;
    	}
    	
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        param.cardNum = $('#txtCardNum').val();
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                // console.log("! [EX] SUCCESS - " + JSON.stringify(data));
                /* 조회 버튼 클릭이벤트 발생 */
                $('#btnConfigCardSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 버튼클릭 이벤트 - 금융거래처 */
    function fnConfigCardPartnerPop( param ) {
        param = (param || '');
        if( param == ''){ // 공통 코드 팝업 호출
        	var Popresult = fnOpenCodePop({
        		codeType : 'Partner'
        		, callback : 'fnConfigCardPartnerPop'
        		, searchStr : ''
        		, acct_type : ''
        		, search_type : '002'
        		/* ERPiU  "" ( 공백 > 전체 ) / 001 ( 주요 ) / 002 ( 금융 ) / 003 ( 개인 ) / 004 ( 신용 ) / 005 ( 기타 ) */
       			/* iCUBE "" ( 공백 > 전체 ) / 1.일반 / 2.수출 / 3.주민 / 4.기타 / 5.금융기관 / 6.정기예금 / 7.정기적금 / 8.카드사 / 9.신용카드 */
        	});	
        }else{ // 리턴 후 데이터 바인딩
        	var displayPartner = "[ " + param.obj.partnerCode + " ]" + param.obj.partnerName;  
        	//$('#txtPartnerCode').val(param.obj.partnerCode);
        	$('#txtPartnerCode').val(param.obj.partnerCode);
        	$('#txtPartnerName').val(param.obj.partnerName);
        	$('#txtPartnerDisplay').val(displayPartner);
        }
        
        return;
    }

    /* 공통사용 */
    /* 공통사용 - 팝업호출 파라미터 */
    function fnMakePopParam( getParam ) {
        var param = {};
        param.url = '';
        param.title = '';
        param.width = 650;
        param.height = 689;
        param.opener = '1';
        param.parentId = '';
        param.childerenId = '';
        param.getParam = getParam;
        return param;
    }

    /* 공통사용 */
    /* 공통사용 - 공통팝업 콜백 함수 */
    function fnCallbackSel( params ) {
        var returnObj = params.returnObj;
        var length = returnObj.length;
        var showSelectedNames = '';
        var selectedItems = '';
		
        console.log(returnObj);
        
        $("#authCount").html(returnObj.length);
        
        
        $("#cardAuthTable").empty();
        
        var colGroup = '<colgroup>';
        colGroup += '<col width="35%"/>';
        colGroup += '<col width="30%"/>';
        colGroup += '<col width=""/>';
        
        $("#cardAuthTable").append(colGroup);
        
        var emptyTable = function () {
        	$("#authCount").text("0");
        	var tr = document.createElement("tr");
        	$ ( tr ).append ( '<td colspan="' + $ ( "#cardAuthTable colgroup col" ).length + '">${CL.ex_dataDoNotExists}</td>' );
			$ ( "#authCount" ).append ( tr );
        };
        
        var resultCount = 0;
        $.each(returnObj, function(idx, val){
        	resultCount++;
        	var tr = document.createElement("tr");
        	$(tr).data('data', val);
        	if(!val.compName) {
        		$(tr).append('<td></td>');
        	} else {
        		$(tr).append('<td>' + val.compName + '</td>');
        	}
        	if(!val.deptName) {
        		$(tr).append('<td></td>');
        	} else {
        		$(tr).append('<td>' + val.deptName + '</td>');
        	}
        	if(!val.empName) {
        		$(tr).append('<td></td>');
        	} else {
        		$(tr).append('<td>' + val.empName + '</td>');
        	}
        	
        	$("#cardAuthTable").append(tr);
        });
        
        for (var i = 0; i < length; i++) {
            var item = returnObj[i];
            selectedItems += ',' + item.superKey;
            showSelectedNames += '/' + (item.empName || item.deptName || item.compName);
        }

        selectedItems = selectedItems.substring(1);
        showSelectedNames = showSelectedNames.substring(1);

        // 선택된 아이템 변경
        $('#selectedItems_forCmPop').val(selectedItems);
        // 리턴 객체 저장.
        $('#hidCardPublic').val(JSON.stringify(params));
        // 표기용 선택된 아이템 		
        $('#txtCardPublic').val(showSelectedNames);

        return;
    }
  
  
</script>

<!-- 컨트롤박스 -->
<div class="top_box">
	<dl>
		<input id="txtCardCode" type="hidden" /> 
		<dt>${CL.ex_cardNm}  <!--카드명--></dt>
		<dd><input id="searchCardName" type="text" style="width:173px;"/></dd>
		<dt>${CL.ex_cardNumber}  <!--카드번호--></dt>
		<dd><input id="searchCardNum" type="text" style="width:170px;"/></dd>
		<dt>${CL.ex_openTo}  <!--공개범위--></dt>
		<dd>
			<select id="selPublic" class="selectmenu" style="width:120px;">
				<option value="A" selected="selected">${CL.ex_all}  <!--전체--></option>
				<option value="Y">${CL.ex_setting}  <!--설정--></option>
				<option value="N">${CL.ex_notSetting}  <!--미설정--></option>
			</select>
		</dd>
		<dd><input id="btnConfigCardSearch" type="button" value="${CL.ex_search}"/></dd><!--검색-->
	</dl>
	<span class="btn_Detail">${CL.ex_detailSearch}  <!--상세검색--> <img id="all_menu_btn" src='../../../Images/ico/ico_btn_arr_down01.png'/></span>
</div>

<div class="SearchDetail">
	<dl>
		<dt>${CL.ex_financialAccCode}  <!--금융거래처 코드--></dt>
		<dd><input id="searchPartnerCode" type="text" style="width:120px;" /></dd>
		<dt style="width:100px;">${CL.ex_financialAccNm}  <!--금융거래처명--></dt>
		<dd>
			<input id="searchPartnerName" type="text" style="width:148px;" />
		</dd>
		<dt style="width:76px;">${CL.ex_inUseYN}  <!--사용여부--></dt>
		<dd>
			<select id="selUseYN" class="selectmenu" style="width:120px;">
				<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
				<option value="Y">${CL.ex_use}  <!--사용--></option>
				<option value="N">${CL.ex_noUser}  <!--미사용--></option>
			</select>
		</dd>
	</dl>
</div>

<div class="sub_contents_wrap">		
	<!-- 버튼 -->
    <div class="btn_div cl">
    	<div class="left_div mt5">
        	<p class="tit_p m0">${CL.ex_cardResiComment1} <!-- 카드 등록 및 설 -->   (<span id="cardCount" class="">10</span>) <span class="fwn f11 ml20">${CL.ex_cardResiComment2}  <!--카드정보를 등록하고 공개범위를 설정합니다.--></span></p> 
        </div>
		<div class="right_div">							
			<div class="controll_btn p0">
				<button id="btnConfigCardFromErp">${CL.ex_erpInfoPull}  <!--ERP 정보 가져오기--></button>
                <button id="btnConfigCardSave">${CL.ex_save}  <!--저장--></button>
            </div>
		</div>
	</div>

	<div class="twinbox">
 	
		<table>
			<colgroup>
				<col width="50%"/>
				<col width=""/>
			</colgroup>
			<tr>
				<td class="twinbox_td" style="">
					<div id="divConfigCardList" class="com_ta2 sc_head mt10">
						<table id="tblConfigCardList">
						</table>
					</div>
				</td>
				<td class="twinbox_td" style="">
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="140"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th><img src="../../../Images/ico/ico_check01.png" alt=""> ${CL.ex_cardNm}  <!--카드명--></th>
								<td><input id="txtCardName" type="text" readonly="readonly"/></td>
							</tr>
							<tr>
								<th><img src="../../../Images/ico/ico_check01.png" alt=""> ${CL.ex_cardNumber}  <!--카드번호--></th>
								<td><input id="txtCardNum" type="text" readonly="readonly"/></td>
							</tr>
							<tr id="trBank">
								<th>${CL.ex_financeClient}  <!--금융거래처--></th>
								<td>
									<div>
										<input id="txtPartnerCode" type="hidden" style="width:170px" readonly="readonly" />
										<input id="txtPartnerName" type="hidden" style="width:170px" readonly="readonly" />
										<input id="txtPartnerDisplay" type="text" style="width:170px" readonly="readonly" />
										<input id="btnPartnerPop" type="button" value="${CL.ex_select}" /><!--선택-->
										<div class="controll_btn p0">
											<button class="reload_btn"></button>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>${CL.ex_inUseYN}  <!--사용여부--></th>
								<td id="cardUseYN"></td>
							</tr>
						</table>
					</div>
					<div class="btn_div mt20">
							<div class="left_div">							
								<p class="tit_p mt7 mb0">${CL.ex_openTo}  <!--공개범위--> (<span id="authCount">0</span>)</p>
							</div>
							<div class="right_div">
								<input id="hidCardPublic" type="hidden" style="width: 19%" />
								<div id="" class="controll_btn p0" style="">
									<button id="btnOrgChart" onclick="">${CL.ex_select}  <!--선택--></button>
								</div>	
							</div>
						</div>
						<div class="com_ta2 sc_head">
							<table>
								<colgroup>
									<col width="35%"/>
									<col width="30%"/>
									<col width=""/>
								</colgroup>
								<tr>
									<th>${CL.ex_company}  <!--회사--></th>
									<th>${CL.ex_department}  <!--부서--></th>
									<th>${CL.ex_fullName}  <!--이름--></th>
								</tr>
							</table>
						</div>
						<div class="com_ta2 ova_sc2 bg_lightgray" style="height:317px;">
							<table id="cardAuthTable">
								<colgroup>
									<col width="35%"/>
									<col width="30%"/>
									<col width=""/>
								</colgroup>
							</table>
						</div>
				</td>
			</tr>
		</table>
	</div><!-- twinbox -->
</div><!-- //sub_contents_wrap -->

<!-- 공통팝업 위한 기능옵션 전달 폼 -->

<form id="frmPop2" name="frmPop2">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="" /> 
	<input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" /> 
	<input type="hidden" id="langCode_forCmPop" name="langCode" width="500" /> 
	<input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" /> 
	<input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" /> 
	<input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" /> 
	<input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" /> 
	<input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" /> 
	<input type="hidden" name="selectMode" width="500" value="ud" /> 
	<input type="hidden" name="selectItem" width="500" value="m" /> 
	<input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> 
	<input type="hidden" name="callback" width="500" value="fnCallbackSel"/> 
	<input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
</form>
