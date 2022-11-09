<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<script>
    /* 변수정의 */
    var ifSystem = '${ViewBag.ifSystem}';

    var baseUrl = '<c:url value="/" />'; /* 팝업 호출시 사용 */
    var searchCompSeq = ''; /* 팝업 호출시 사용 */

    /* 문서로드 */
    $(document).ready(function() {
        fnConfigSummaryInit();
        fnConfigSummaryInitEvent();
        $('#btnConfigSummarySearch').click();
    });

    /* 초기화 */
    function fnConfigSummaryInit() {
        $('button').kendoButton(); /* 켄도버튼정의 */
        
        setComboBox($("#selCompany"), JSON.parse('${ViewBag.compListInfo}'), function( event ) {
            $('#btnConfigSummarySearch').click();
        });/* 회사 설정 */
        
        setComboBox($("#selSummaryType"), JSON.parse('${ViewBag.commonCodeListSummaryType}'), '');/* 적요 구분 */
        setComboBox($("#selSummaryTypeInput"), JSON.parse('${ViewBag.commonCodeListSummaryType}'), '');/* 적요 구분 입력 */

        var combobox = $("#selSummaryType").data("kendoComboBox");
        combobox.enable(false); /* 적요 구분 비활성화 */
        combobox = $("#selSummaryTypeInput").data("kendoComboBox");
        combobox.enable(false); /* 적요 구분 입력 비활성화 */
    }

    /* 이벤트 초기화 */
    function fnConfigSummaryInitEvent() {
        /* 변수정의 */
        var param = {};
        /* 이벤트 정의 */
        /* 이벤트 정의 - 검색 */
        $('#btnConfigSummarySearch').click(function() {
            fnConfigSummarySearch();
        });
        /* 이벤트 정의 - 신규 */
        $('#btnConfigSummaryNew').click(function() {
            fnConfigSummaryNew();
        });
        /* 이벤트 정의 - 저장 */
        $('#btnConfigSummarySave').click(function() {
            fnConfigSummarySave();
        });
        /* 이벤트 정의 - 삭제 */
        $('#btnConfigSummaryDelete').click(function() {
            fnConfigSummaryDelete();
        });
        /* 이벤트 정의 - 부가세계정과목 */
        $('#btnConfigSummaryVatAcctPopup').click(function() {
//             fnConfigSummaryVatAcctPopup();
        	var Popresult = fnOpenCodePop({
        		codeType : 'Acct'
        		, callback : 'fnConfigSummaryVatAcctPopup'
        		, searchStr : ($("#txtVatAcctName").val() || '')
        		, acct_type : 'VAT'
        	});
        });
        /* 이벤트 정의 - 차변계정과목 */
        $('#btnConfigSummaryDrAcctPopup').click(function() {
//             fnConfigSummaryDrAcctPopup();
        	var Popresult = fnOpenCodePop({
        		codeType : 'Acct'
        		, callback : 'fnConfigSummaryDrAcctPopup'
        		, searchStr : ($("#txtDrAcctName").val() || '')
        		, acct_type : 'DR'
        	});
        });
        /* 이벤트 정의 - 대변계정과목 */
        $('#btnConfigSummaryCrAcctPopup').click(function() {
//             fnConfigSummaryCrAcctPopup();
        	var Popresult = fnOpenCodePop({
        		codeType : 'Acct'
        		, callback : 'fnConfigSummaryCrAcctPopup'
        		, searchStr : ($("#txtCrAcctName").val() || '')
        		, acct_type : 'CR'
        	});
        });

        /* 초기화 버튼클릭 이벤트 정의 */
        $('.reload_btn').click(function( event ) {
            /* 대상자 찾기 */
            var par = $(this).parent();
            var input = $(par).prevAll('.txt_reset');
            /* 초기화 진행 */
            $.each(input, function( idx, target ) {
                $(target).val('');
            });
        });
        return;
    }

    /* 버튼클릭 이벤트 - 검색 */
    function fnConfigSummarySearch() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeSummary);
        
        param.comp_seq = $('#selCompany').val();
        searchCompSeq = $('#selCompany').val(); /* 팝업 호출시 사용 */
        param.codeType = 'SUMMARY'
        param.summary_div = $('#selSummaryType').val();
        param.search_str = $('#txtSearchStr').val();
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex/user/code/ExCodeInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
//                 ifSystem = (data.ifSystem || 'BizboxA');

                if (typeof data.result.aaData != 'undefined') {
                    /* 테이블 데이터 바인딩 */
                    fnConfigSummarySetTable(data.result.aaData);
                } else {
                    /* 테이블 데이터 바인딩 */
                    fnConfigSummarySetTable('');
                }
                /* 신규 버튼 클릭이벤트 발생 */
                $('#btnConfigSummaryNew').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    function fnConfigSummarySetTable( data ) {
        data = (data || '');
        $('#divSummaryList').empty();
        $('#divSummaryList').append('<table id="tblSummaryList"></table>');
        
        $('#tblSummaryList').dataTable({
            "fixedHeader" : true,
            "select" : true,
            "pageLength" : 7,
            // "sScrollY" : param.scrollY,
            "bAutoWidth" : false,
            "destroy" : true,
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
                    fnConfigSummary_SelectRow(aData);
                }));
            },
            "columnDefs" : [ {
                "targets" : 2,
                "data" : null,
                "render" : function( aData ) {
                    if (aData.dr_acct_code && aData.dr_acct_code != '' && aData.dr_acct_name && aData.dr_acct_name != '') {
                        return aData.dr_acct_code + ' / ' + aData.dr_acct_name
                    } else {
                        return '';
                    }
                }
            }, {
                "targets" : 3,
                "data" : null,
                "render" : function( aData ) {
                    if (aData.vat_acct_code && aData.vat_acct_code != '' && aData.vat_acct_name && aData.vat_acct_name != '') {
                        return aData.vat_acct_code + ' / ' + aData.vat_acct_name
                    } else {
                        return '';
                    }
                }
            }, {
                "targets" : 4,
                "data" : null,
                "render" : function( aData ) {
                    if (aData.cr_acct_code && aData.cr_acct_code != '' && aData.cr_acct_name && aData.cr_acct_name != '') {
                        return aData.cr_acct_code + ' / ' + aData.cr_acct_name
                    } else {
                        return '';
                    }
                }
            } ],
            "aoColumns" : [ {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000344","적요코드")%>",
                "mDataProp" : "summary_code",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "10%"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000345","적요명")%>",
                "mDataProp" : "summary_name",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "td_le"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000003517","차변계정과목")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "15%",
                "sClass" : "td_le"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000005730","부가세계정과목")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "15%",
                "sClass" : "td_le"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000003518","대변계정과목")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "15%",
                "sClass" : "td_le"
            }, ]
        });
    }

    /* 버튼클릭 이벤트 - 신규 */
    function fnConfigSummaryNew() {
        /* 초기화 */
        $('#txtSummaryCode').val(''); /* 적요코드 초기화 */
        $('#txtSummaryName').val(''); /* 적요명 초기화 */
        $('#txtDrAcctCode').val(''); /* 차변계정과목 초기화 */
        $('#txtDrAcctName').val(''); /* 차변계정과목 초기화 */
        $('#txtCrAcctCode').val(''); /* 대변계정과목 초기화 */
        $('#txtCrAcctName').val(''); /* 대변계정과목 초기화 */
        $('#txtVatAcctCode').val(''); /* 부가세계정과목 초기화 */
        $('#txtVatAcctName').val(''); /* 부가세계정과목 초기화 */
        /* 비활성화 해제 */
        $('#txtSummaryCode').removeAttr('disabled'); /* 적요코드 */
        return;
    }

    /* 버튼클릭 이벤트 - 저장 */
    function fnConfigSummarySave() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeSummary);
        
        param.comp_seq = $('#selCompany').val();
        
        param.summary_code = $('#txtSummaryCode').val();
        param.summary_name = $('#txtSummaryName').val();
        param.summary_div = $('#selSummaryTypeInput').val();
        param.dr_acct_code = $('#txtDrAcctCode').val();
        param.dr_acct_name = $('#txtDrAcctName').val();
        param.cr_acct_code = $('#txtCrAcctCode').val();
        param.cr_acct_name = $('#txtCrAcctName').val();
        param.vat_acct_code = $('#txtVatAcctCode').val();
        param.vat_acct_name = $('#txtVatAcctName').val();
        /* 호출 URL 지정 */
        var url = '';
        var attr = $('#txtSummaryCode').attr('disabled');
        if (typeof attr !== typeof undefined && attr !== false) {
            url = '<c:url value="/ex/master/config/SummaryInfoUpdate.do" />';
        } else {
            url = '<c:url value="/ex/master/config/SummaryInfoInsert.do" />';
        }
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 조회버튼 클릭 */
                $('#btnConfigSummarySearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 버튼클릭 이벤트 - 삭제 */
    function fnConfigSummaryDelete() {
        var param = {};
        $.extend(param, ExCodeSummary);
        
        param.comp_seq = $('#selCompany').val();
        
        param.summary_code = $('#txtSummaryCode').val();
        param.summary_div = $('#selSummaryTypeInput').val();
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/SummaryInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 조회버튼 클릭 */
                $('#btnConfigSummarySearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 버튼클릭 이벤트 - 엑셀업로드 */
    function fnConfigSummaryExcelUpload() {
        alert("<%=BizboxAMessage.getMessage("TX000009615","서비스 준비중입니다")%>" + '..');
        return;
    }

    /* 버튼클릭 이벤트 - 엑셀다운로드 */
    function fnConfigSummaryExcelDownload() {
    	alert("<%=BizboxAMessage.getMessage("TX000009615","서비스 준비중입니다")%>" + '..');
        return;
    }

    /* 버튼클릭 이벤트 - 차변계정과목 */
    function fnConfigSummaryDrAcctPopup( param ) {
		$('#txtDrAcctCode').val(param.obj.acct_code || '');
		$('#txtDrAcctName').val(param.obj.acct_name || '');
        return;
    }

    /* 버튼클릭 이벤트 - 대변계정과목 */
    function fnConfigSummaryCrAcctPopup( param ) {
        $('#txtCrAcctCode').val(param.obj.acct_code || '');
        $('#txtCrAcctName').val(param.obj.acct_name || '');
        return;
    }

    /* 버튼클릭 이벤트 - 부가세계정과목 */
    function fnConfigSummaryVatAcctPopup( param ) {
        $('#txtVatAcctCode').val(param.obj.acct_code || '');
        $('#txtVatAcctName').val(param.obj.acct_name || '');
        return;
    }

    /* 행클릭 이벤트 */
    function fnConfigSummary_SelectRow( data ) {
        /* 선택값 적용 */
        $('#txtSummaryCode').val(data.summary_code); /* 적요코드 */
        $('#txtSummaryName').val(data.summary_name); /* 적요명 */
        $('#txtDrAcctCode').val(data.dr_acct_code); /* 차변계정과목 */
        $('#txtDrAcctName').val(data.dr_acct_name); /* 차변계정과목 */
        $('#txtCrAcctCode').val(data.cr_acct_code); /* 대변계정과목 */
        $('#txtCrAcctName').val(data.cr_acct_name); /* 대변계정과목 */
        $('#txtVatAcctCode').val(data.vat_acct_code); /* 부가세계정과목 */
        $('#txtVatAcctName').val(data.vat_acct_name); /* 부가세계정과목 */
        /* 비활성화 처리 */
        $('#txtSummaryCode').attr('disabled', 'disabled');
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
</script>

<div class="modal" style="display: none;"></div>
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt><%=BizboxAMessage.getMessage("TX000000047","회사")%></dt>
			<dd>
				<input type="text" id="selCompany" class="kendoComboBox" style="width: 200px;" />
			</dd>
			<dt><%=BizboxAMessage.getMessage("TX000000214","구분")%></dt>
			<dd>
				<input type="text" id="selSummaryType" class="kendoComboBox" style="width: 100px;" />
			</dd>
			<dt>검색어</dt>
			<dd>
				<div class="dod_search">
					<!-- <input id="selSummarySearchType" style="width: 120px;" /> -->
					<input id="txtSearchStr" type="text" style="width: 200px;" /> <input id="btnConfigSummarySearch" type="button" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" />
				</div>
			</dd>
		</dl>
	</div>
	<div id="" class="controll_btn">
		<button id="btnConfigSummaryNew" class="k-button"><%=BizboxAMessage.getMessage("TX000003101","신규")%></button>
		<button id="btnConfigSummarySave" class="k-button"><%=BizboxAMessage.getMessage("TX000001256","저장")%></button>
		<button id="btnConfigSummaryDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424","삭제")%></button>
		<button id="btnConfigSummaryExcelUpload" class="k-button" style="display: none;"><%=BizboxAMessage.getMessage("TX000003519","엑셀업로드")%></button>
		<button id="btnConfigSummaryExcelDownload" class="k-button" style="display: none;"><%=BizboxAMessage.getMessage("TX000009553","엑셀다운로드")%></button>
	</div>
	<div id=divSummaryList " class="com_ta2 bg_lightgray ova_sc_all" style="height: 334px;">
		<table id="tblSummaryList">
		</table>
	</div>
	<div class="com_ta mt20">
		<table>
			<colgroup>
				<col width="140" />
				<col width="" />
				<col width="140" />
				<col width="" />
			</colgroup>
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000344","적요코드")%></th>
				<td>
					<input id="txtSummaryCode" type="text" style="width: 66%" class="txt_reset" />
				</td>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000345","적요명")%></th>
				<td>
					<input id="txtSummaryName" type="text" style="width: 66%" class="txt_reset" />
				</td>
			</tr>
			<tr>
				<%-- <th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> 공개범위</th>
				<td>
					<input type="text" style="width: 19%" class="txt_reset txt_readonly" /> <input type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnPublicPopup">선택</button>
						<button class="reload_btn"></button>
					</div>
				</td> --%>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000214","구분")%></th>
				<td>
					<input id="selSummaryTypeInput" style="width: 45%" />
				</td>
				<th><%=BizboxAMessage.getMessage("TX000005730","부가세계정과목")%></th>
				<td>
					<input id="txtVatAcctCode" type="text" style="width: 19%" class="txt_reset txt_readonly" /> <input id="txtVatAcctName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnConfigSummaryVatAcctPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000003517","차변계정과목")%></th>
				<td>
					<input id="txtDrAcctCode" type="text" style="width: 19%" class="txt_reset txt_readonly" /> <input id="txtDrAcctName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnConfigSummaryDrAcctPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000003518","대변계정과목")%></th>
				<td>
					<input id="txtCrAcctCode" type="text" style="width: 19%" class="txt_reset txt_readonly" /> <input id="txtCrAcctName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnConfigSummaryCrAcctPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
			<!-- <tr>
				<th>부가세계정과목</th>
				<td>
					<input id="txtVatAcctCode" type="text" style="width: 19%" class="txt_reset txt_readonly" /> <input id="txtVatAcctName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnVatAcctPopup">선택</button>
						<button class="reload_btn"></button>
					</div>
				</td>
				<th>
					금융거래처 (ERP-IU)
				</th>
				<td>
					<input type="text" style="width: 19%" /> <input type="text" style="width: 46%" />
					<div class="controll_btn p0">
						<button>선택</button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr> -->
		</table>
	</div>
</div>
<!-- //sub_contents_wrap -->