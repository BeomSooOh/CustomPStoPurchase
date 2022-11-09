<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>



<script>
    /* 변수정의 */
    var ifSystem = '${ViewBag.ifSystem}';
    var modifyType = 'Y';

    /* 문서로드 */
    $(document).ready(function() {
        fnConfigSettingMngInit(); /* 초기화 */
        fnConfigSettingMngEventInit(); /* 이벤트 초기화 */
        $('#btnConfigSettingMngSearch').click();
    });

    /* 초기화 */
    function fnConfigSettingMngInit() {
        fnConfigSettingMngInitLayout(); /* 초기화 - Layout */
        fnConfigSettingMngInitDatepicker(); /* 초기화 - Datepicker */
        fnConfigSettingMngInitInput(); /* 초기화 - Input */
        return;
    }

    /* 초기화 - Layout */
    function fnConfigSettingMngInitLayout() {
        $('button').kendoButton(); /* 켄도버튼정의 */
        return;
    }

    /* 초기화 - Datepicker */
    function fnConfigSettingMngInitDatepicker() {
		var formInfo = ('${ViewBag.formInfo}' === '' ? [] : ${ViewBag.formInfo});
		
		/* 검색 - 양식 */
		$("#selConfigSettingMngForm").empty();
		$.each(formInfo, function(idx, item) {
			$("#selConfigSettingMngForm").append("<option value='" + item.formSeq + "'>" + item.formName + "</option>");
		});
		
		$("#selConfigSettingMngForm").selectmenu({change: function(){
			$('#btnConfigSettingMngSearch').click();
		}});
		
		if(formInfo.length > 0){
			$("#selConfigSettingMngForm").val(formInfo[0].formSeq).selectmenu('refresh');
		}
        
		/* 검색 - 차대구분 */
		var drcrGbn = ('${ViewBag.commonCodeListDrcrGbn}' === '' ? [] : ${ViewBag.commonCodeListDrcrGbn});
        $("#selConfigSettingMngDrCrGbn").empty();
		$.each(drcrGbn, function(idx, item) {
			$("#selConfigSettingMngDrCrGbn").append("<option value='" + item.commonCode + "'>" + item.commonName+ "</option>");
		});
		
		$("#selConfigSettingMngDrCrGbn").selectmenu({change: function(){
			$('#btnConfigSettingMngSearch').click();
		}});
		
		if(drcrGbn.length > 0){
			$("#selConfigSettingMngDrCrGbn").val(drcrGbn[0].commonCode).selectmenu('refresh');
		}
		
		/* 관리항목 - 차대구분 */
        $("#selConfigSettingMngInputDrCrGbn").empty();
		$.each(drcrGbn, function(idx, item) {
			$("#selConfigSettingMngInputDrCrGbn").append("<option value='" + item.commonCode + "'>" + item.commonName+ "</option>");
		});
		$("#selConfigSettingMngInputDrCrGbn").change(function(){
		});
//         $("#selConfigSettingMngInputDrCrGbn option").not(":selected").attr("disabled", "disabled");
        $("#selConfigSettingMngInputDrCrGbn").selectmenu('disable');

        
        /* 입력방식 */
        var inputType = ('${ViewBag.commonCodeListMngMapType}' === '' ? [] : ${ViewBag.commonCodeListMngMapType}); 
        $("#selConfigSettingMngInputType").empty();
        $("#selConfigSettingMngInputType").append("<option value='Default'>Default</option>");
		$.each(inputType, function(idx, item) {
			$("#selConfigSettingMngInputType").append("<option value='" + item.commonCode + "'>" + item.commonName+ "</option>");
		});
		
		$("#selConfigSettingMngInputType").selectmenu({change: function(){
			fnConfigSettingMngChangeInputType();
		}});
		
        return;
    }
    
    /* 초기화 - Input */
    function fnConfigSettingMngInitInput() {
        $('#txtConfigSettingMngSearchStr').bind('keypress', function(event) {
            /* 엔터입력 이벤트 적용 */
            if (event.keyCode == 13) {
                fnConfigSettingMngSearch(); /* 이벤트 초기화 - 버튼 - 검색 */
            }
        });
        return;
    }

    /* 이벤트 초기화 */
    function fnConfigSettingMngEventInit() {
        fnConfigSettingMngEventInitButton(); /* 이벤트 초기화 - 버튼 */
        return;
    }

    /* 이벤트 초기화 - 버튼 */
    function fnConfigSettingMngEventInitButton() {
        $('#btnConfigSettingMngSearch').click(function() { /* 검색 */
            fnConfigSettingMngSearch(); /* 이벤트 초기화 - 버튼 - 검색 */
        });

        $('#btnConfigSettingMngSave').click(function() { /* 저장 */
            fnConfigSettingMngSave(); /* 이벤트 초기화 - 버튼 - 저장 */
        });

        $('#btnConfigSettingMngDelete').click(function() { /* 삭제 */
            fnConfigSettingMngDelete(); /* 이벤트 초기화 - 버튼 - 삭제 */
        });
        return;
    }

    /* 이벤트 초기화 - 버튼 - 검색 */
    function fnConfigSettingMngSearch() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeMng);
        param.compSeq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        
        
        param.formSeq = ($("#selConfigSettingMngForm").find(':selected').val() || '0'); /* 양식 */
        param.drcrGbn = ($('#selConfigSettingMngDrCrGbn').find(':selected').val() || 'dr'); /* 차대구분 */
        param.searchStr = ($('#txtConfigSettingMngSearchStr').val() || ''); /* 검색어 */
        
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/MngListInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 반환 : ExCodeMngVO */
                /* ExCodeMngVO : comp_seq, erp_comp_seq, form_seq, mngCode, mngName, ctd_code, ctd_name, mng_type, mng_child_yn, mng_form, drcr_gbn, use_gbn, cust_set, cust_set_target, modify_yn */
                fnConfigSettingMngTblBind(data.aaData || {});
                fnConfigSettingMngResetInput();
            },
            error : function( data ) {
                alert("<%=BizboxAMessage.getMessage("TX000009567","알수 없는 오류가 발생되었습니다")%>");
            }
        });
        
        return;
    }

    /* 이벤트 초기화 - 버튼 - 검색 - 테이블 바인딩 */
    function fnConfigSettingMngTblBind( source ) {
        
        /* parameter : source */
        /* source >> ExCodeMngVO : comp_seq, erp_comp_seq, form_seq, mngCode, mngName, ctd_code, ctd_name, mng_type, mng_child_yn, mng_form, drcr_gbn, use_gbn, cust_set, cust_set_target, modify_yn */
        source = (source || {});

        $('#divConfigSettingMng').empty();
        $('#divConfigSettingMng').append('<table id="tblConfigSettingMng"></table>');

        $('#tblConfigSettingMng').DataTable({
            "fixedHeader" : true,
            "bProcessing" : true, //처리 중 표시
            "select" : true,
            /* "paging" : false, */
            "lengthMenu" : [ [ 10, -1 ], [ 10, "All" ] ],
//             "sScrollY" : 370,
            "bAutoWidth" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : source,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on("click", (function() {
                    fnConfigSettingMngSelectRow(aData);
                }));
                return nRow;
            },
            columnDefs : [ {
                "targets" : 0,
                "data" : null,
                "sWidth" : "200px",
                "render" : function( aData ) {
                    return fnFormatCodeAndName(aData.mngCode, aData.mngName);
                }
            }, {
                "targets" : 1,
                "sWidth" : ""
            }, {
                "targets" : 2,
                "sWidth" : ""
            }, {
                "targets" : 3,
                "sWidth" : ""
            }, {
                "targets" : 4,
                "data" : null,
                "sWidth" : "",
                "render" : function( aData ) {
                    if(aData.modifyYN != 'Y') {
                        return "<%=BizboxAMessage.getMessage("TX000003352","수정불가")%>";
                    } else {
                        return ''; 
                    }
                }
            } ],
            aoColumns : //컬럼과 프로퍼티 연결
            [ {
                sTitle : "${CL.ex_controlProvision}",//관리항목
                bVisible : true,
                bSortable : true,
                sWidth : "200px",
                className : "td_le"
            }, {
                sTitle : "<%=BizboxAMessage.getMessage("TX000009566","지정방식")%>",
                mDataProp : "useGbnName",
                bVisible : true,
                bSortable : true,
                sWidth : "",
                className : "td_le"
            }, {
                sTitle : "<%=BizboxAMessage.getMessage("TX000009565","사용자 정의 코드")%>",
                mDataProp : "ctdCode",
                bVisible : true,
                bSortable : true,
                className : "td_le"
            }, {
                sTitle : "<%=BizboxAMessage.getMessage("TX000009564","사용자 정의 명칭")%>",
                mDataProp : "ctdName",
                bVisible : true,
                bSortable : true,
                className : "td_le"
            }, {
                sTitle : "<%=BizboxAMessage.getMessage("TX000006468","수정가능여부")%>",
                bVisible : true,
                bSortable : true
            } ]
        });
        
        return;
    }
    
    function fnFormatCodeAndName(code, name){
    	return code + ' / ' + name;
    }

    /* 이벤트 초기화 - 버튼 - 저장 */
    function fnConfigSettingMngSave() {
        if(modifyType != 'Y') {
            alert("<%=BizboxAMessage.getMessage("TX000009563","수정불가 항목으로 저장되지 않습니다")%>");
            return;
        }
        
        /* 입력 : 회사, 차대구분, 관리항목 코드, 설정 구분, 설정 코드, 설정 명칭, 비고 (사용자 작성시 tooltip 제공) */
        /* 변수정의 */
        var param = {};
        $.extend(param, (($('#hidConfigSettingMngInfo').val() || '') == '' ? ExCodeMng : JSON.parse($('#hidConfigSettingMngInfo').val())));
        param.compSeq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        param.formSeq = ($("#selConfigSettingMngForm").find(':selected').val() || ''); /* 양식 */
        param.drcrGbn = ($("#selConfigSettingMngInputDrCrGbn").find(':selected').val() || ''); /* 차대구분 */
        param.useGbn = (($("#selConfigSettingMngInputType").find(':selected').val() == 'Default'?'':$("#selConfigSettingMngInputType").find(':selected').val()) || ''); /* 지정방식 */
        param.ctdCode = ($('#txtConfigSettingMngCtdCode').val() || ''); /* 사용자 정의 코드 */
        param.ctdName = ($('#txtConfigSettingMngCtdName').val() || ''); /* 사용자 정의 명칭 */
        param.note = ($('#txtConfigSettingMngNote').val() || ''); /* 비고 */
        
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/MngInfoUpdate.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 반환 : ExCommonResultVO, ifSystem */
                /* ExCodeMngVO : code, common_code, common_name, comp_seq, erp_comp_seq, error, expend_seq, lang_code, listS_eq, message, mng_seq, search_str, search_type, slip_seq */
                alert(data.aaData.message || "<%=BizboxAMessage.getMessage("TX000009094","저장중 오류가 발생하였습니다")%>");
                $('#btnConfigSettingMngSearch').click();
            },
            error : function( data ) {
                alert("<%=BizboxAMessage.getMessage("TX000009567","알수 없는 오류가 발생되었습니다")%>");
            }
        });
        
        return;
    }

    /* 이벤트 초기화 - 버튼 - 삭제 */
    function fnConfigSettingMngDelete() {
        if(modifyType != 'Y') {
            alert("<%=BizboxAMessage.getMessage("TX000009563","수정불가 항목으로 저장되지 않습니다")%>");
            return;
        }
        
        /* 변수정의 */
        var param = {};
        $.extend(param, (($('#hidConfigSettingMngInfo').val() || '') == '' ? ExCodeMng : JSON.parse($('#hidConfigSettingMngInfo').val())));
        param.compSeq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        param.formSeq = ($("#selConfigSettingMngForm").find(':selected').val() || ''); /* 양식 */
        param.drcrGbn = ($("#selConfigSettingMngInputDrCrGbn").find(':selected').val() || ''); /* 차대구분 */
        param.useGbn = (($("#selConfigSettingMngInputType").find(':selected').val() == 'Default'?'':$("#selConfigSettingMngInputType").find(':selected').val()) || ''); /* 지정방식 */
     
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/config/ExConfigMngInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 반환 : ExCommonResultVO, ifSystem */
                /* ExCodeMngVO : code, common_code, common_name, comp_seq, erp_comp_seq, error, expend_seq, lang_code, listS_eq, message, mng_seq, search_str, search_type, slip_seq */
                alert(data.aaData.message || "<%=BizboxAMessage.getMessage("TX000009094","저장중 오류가 발생하였습니다")%>");
                $('#btnConfigSettingMngSearch').click();
            },
            error : function( data ) {
                alert("<%=BizboxAMessage.getMessage("TX000009567","알수 없는 오류가 발생되었습니다")%>");
            }
        });
        
        return;
    }
    
    /* 기타 - 지정방식 변경시 이벤트 */
    function fnConfigSettingMngChangeInputType(){
        var type = $('#selConfigSettingMngInputType').find(':selected').val();
        
        if(type == 'UserInput') {
            $('#txtConfigSettingMngCtdCode').removeAttr('disabled'); /* 사용자 정의 코드 */
            $('#txtConfigSettingMngCtdCode').removeAttr('readonly'); /* 사용자 정의 코드 */
            $('#txtConfigSettingMngCtdName').removeAttr('disabled'); /* 사용자 정의 명칭 */
            $('#txtConfigSettingMngCtdName').removeAttr('readonly'); /* 사용자 정의 명칭 */            
        } else {
            $('#txtConfigSettingMngCtdCode').attr('disabled', 'disabled'); /* 사용자 정의 코드 */
            $('#txtConfigSettingMngCtdCode').attr('readonly', 'readonly'); /* 사용자 정의 코드 */
            $('#txtConfigSettingMngCtdName').attr('disabled', 'disabled'); /* 사용자 정의 명칭 */
            $('#txtConfigSettingMngCtdName').attr('readonly', 'readonly'); /* 사용자 정의 명칭 */
            $('#txtConfigSettingMngCtdCode').val('');
            $('#txtConfigSettingMngCtdName').val('');
        }
    }
    
    /* 기타 - 입력 초기화 */
    function fnConfigSettingMngResetInput(){
        /* 수정가능여부에 따른 처리 */
        modifyType = 'Y';
        /* 양식 */
        /* 구분 */
// 		$("#selConfigSettingMngInputDrCrGbn").val($("#selConfigSettingMngDrCrGbn").val());
// 		$("#selConfigSettingMngInputDrCrGbn").change();
// 		$("#selConfigSettingMngInputDrCrGbn").attr('disabled',true);
// 		$("#selConfigSettingMngInputDrCrGbn").val($("#selConfigSettingMngDrCrGbn").val()).selectmenu('refresh').trigger('change');
		$("#selConfigSettingMngInputDrCrGbn").val($("#selConfigSettingMngDrCrGbn").val()).selectmenu('refresh');
		$("#selConfigSettingMngInputDrCrGbn").selectmenu('disable');
		

        /* 관리항목 */
        $('#txtConfigSettingMngMngCode').val('');
        $('#txtConfigSettingMngMngName').val('');
        
        
        /* 지정방식 */
		$("#selConfigSettingMngInputType").val("Default").selectmenu('refresh');
		$("#selConfigSettingMngInputType").selectmenu('enable');
		
		
        /* 사용자 정의 코드 */
        $('#txtConfigSettingMngCtdCode').val('');
        $('#txtConfigSettingMngCtdCode').removeAttr('disabled');
        $('#txtConfigSettingMngCtdCode').removeAttr('readonly');
        /* 사용자 정의 명칭 */
        $('#txtConfigSettingMngCtdName').val('');
        $('#txtConfigSettingMngCtdName').removeAttr('disabled');
        $('#txtConfigSettingMngCtdName').removeAttr('readonly');
        /* 비고 */
        $('#txtConfigSettingMngNote').val('');
        /* JSON 문자열 */
        $('#hidConfigSettingMngInfo').val('');
    }
    
    /* 기타 - 테이블 행클릭 */
    function fnConfigSettingMngSelectRow(param){
        /* 수정가능여부에 따른 처리 */
        modifyType = param.modifyYN;
        /* 구분 */
//         $("#selConfigSettingMngInputDrCrGbn").val($("#selConfigSettingMngDrCrGbn").val());
// 		$("#selConfigSettingMngInputDrCrGbn").change();
// 		$("#selConfigSettingMngInputDrCrGbn option").not(":selected").attr("disabled", "disabled");
// 		$("#selConfigSettingMngInputDrCrGbn").attr("disabled", true);
		$("#selConfigSettingMngInputDrCrGbn").val($("#selConfigSettingMngDrCrGbn").val()).selectmenu('refresh');
		$("#selConfigSettingMngInputDrCrGbn").selectmenu('disable');
		
        /* 관리항목 */
        $('#txtConfigSettingMngMngCode').val(param.mngCode || '');
        $('#txtConfigSettingMngMngName').val(param.mngName || '');
        /* 지정방식 */
//         $("#selConfigSettingMngInputType").val(param.useGbn || 'Default');
		$("#selConfigSettingMngInputType").val((param.useGbn || 'Default')).selectmenu('refresh');
		$("#selConfigSettingMngInputType").selectmenu('enable');
        if(modifyType != 'Y') {
//             combobox.readonly(true);
            $("#selConfigSettingMngInputType").selectmenu('disable');
        } else {
            $("#selConfigSettingMngInputType").selectmenu('enable');
        }
        /* 사용자 정의 코드 */
        $('#txtConfigSettingMngCtdCode').val(param.ctdCode || '');
        if(modifyType != 'Y') {
            $('#txtConfigSettingMngCtdCode').attr('disabled', 'disabled');
            $('#txtConfigSettingMngCtdCode').attr('readonly', 'readonly');
        } else {
            $('#txtConfigSettingMngCtdCode').removeAttr('disabled');
            $('#txtConfigSettingMngCtdCode').removeAttr('readonly');
        }
        /* 사용자 정의 명칭 */
        $('#txtConfigSettingMngCtdName').val(param.ctdName || '');
        if(modifyType != 'Y') {
            $('#txtConfigSettingMngCtdName').attr('disabled', 'disabled');
            $('#txtConfigSettingMngCtdName').attr('readonly', 'readonly');
        } else {
            $('#txtConfigSettingMngCtdName').removeAttr('disabled');
            $('#txtConfigSettingMngCtdName').removeAttr('readonly');
        }
        /* 비고 */
        $('#txtConfigSettingMngNote').val(param.note);
        /* JSON 문자열 */
        $('#hidConfigSettingMngInfo').val(JSON.stringify(param));
        /* 입력 이벤트 설정 */
        fnConfigSettingMngChangeInputType();
    }

</script>

<input type="hidden" id="hidConfigSettingMngInfo" />

<!-- iframe wrap -->
<div class="iframe_wrap">
	<div class="sub_contents_wrap">
		<!-- 컨트롤박스 -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000000177","양식")%></dt>
				<dd>
					<div class="dod_search">
						<select id="selConfigSettingMngForm" class="selectmenu" style="width: 200px;">
						</select>
					</div>
				</dd>
 				<dt>${CL.ex_division}</dt> <%-- 구분 --%>
				<dd>
<!-- 					<div class="dod_search"> -->
						<select id="selConfigSettingMngDrCrGbn" class="selectmenu" style="width: 150px;">
						</select>
<!-- 					</div> -->
				</dd>
				<dt>${CL.ex_name}</dt> <!-- 명칭 -->
				<dd>
					<div class="dod_search">
						<input type="text" id="txtConfigSettingMngSearchStr" class="kendoComboBox" style="width: 150px;" />
					</div>
				</dd>
				<dd>
					<div class="controll_btn p0">
						 <button id="btnConfigSettingMngSearch" class="btn_sc_add">${CL.ex_search}</button>
					</div>
				</dd>
								
			</dl>
		</div>
		<div id="" class="controll_btn">
			<!-- <button id="" class="k-button">추가</button> -->
			<button id="btnConfigSettingMngSave" class="k-button">${CL.ex_save}</button><!-- 저장 -->
			<button id="btnConfigSettingMngDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424","삭제")%></button>
		</div>
		<div class="twinbox">
			<table>
				<colgroup>
					<col width="50%" />
					<col width="50%" />
				</colgroup>
				<tr>
					<td class="twinbox_td" style="">
						<p class="tit_p"><%=BizboxAMessage.getMessage("TX000009557","관리항목 정의")%></p>
						<div id="divConfigSettingMng" class="com_ta2 bg_lightgray hover_no">
							<table id="tblConfigSettingMng">
							</table>
						</div>
					</td>
					<td class="twinbox_td" style="">
						<div class="com_ta mt27">
							<table>
								<colgroup>
									<col width="140" />
									<col width="" />
								</colgroup>
								<tr style="display: none;">
									<th><%=BizboxAMessage.getMessage("TX000000047","회사")%></th>
									<td>
										<input id="selConfigSettingMngInputCompany" class="selectmenu" style="width: 150px;" />
									</td>
								</tr>
								<tr style="display: none;">
									<th><%=BizboxAMessage.getMessage("TX000000177","양식")%></th>
									<td>
										<input id="selConfigSettingMngInputForm" class="selectmenu" style="width: 150px;" />
									</td>
								</tr>
								<tr style="display: none;">
									<th>${CL.ex_division}</th><!-- 구분 -->
									<td>
										<select id="selConfigSettingMngInputDrCrGbn" class="selectmenu" style="width: 150px;">
										</select>
									</td>
								</tr>
								<tr>
									<th>${CL.ex_controlProvision}</th><!-- 관리항목 -->
									<td>
										<input id="txtConfigSettingMngMngCode" type="text" style="width: 20%" disabled="disabled" readonly="readonly" /> <input id="txtConfigSettingMngMngName" type="text" style="width: 75%" disabled="disabled" readonly="readonly" />
										<!-- <div class="controll_btn p0"> -->
										<!-- <button>선택</button> -->
										<!-- <button class="reload_btn"></button> -->
										<!-- </div> -->
									</td>
								</tr>
								<tr>
									<th><%=BizboxAMessage.getMessage("TX000009566","지정방식")%></th>
									<td>
										<select id="selConfigSettingMngInputType" class="selectmenu" style="width: 80px;">
										</select>
									</td>
								</tr>
								<tr>
									<th><%=BizboxAMessage.getMessage("TX000009565","사용자 정의 코드")%></th>
									<td>
										<input id="txtConfigSettingMngCtdCode" type="text" style="width: 96%" />
									</td>
								</tr>
								<tr>
									<th><%=BizboxAMessage.getMessage("TX000009564","사용자 정의 명칭")%></th>
									<td>
										<input id="txtConfigSettingMngCtdName" type="text" style="width: 96%" />
									</td>
								</tr>
								<tr>
									<th><%=BizboxAMessage.getMessage("TX000000644","비고")%></th>
									<td>
										<textarea id="txtConfigSettingMngNote" class="k-textbox txt_box" style="width: 96%;"></textarea>
									</td>
								</tr>
							</table>
						</div>
						<p class="fwb mt20 mb7">※ <%=BizboxAMessage.getMessage("TX000009556","사용자 정의란?")%></p>
						<div class="lh18">
							<%=BizboxAMessage.getMessage("TX000016480","지출결의 작성 시 계정과목에 설정된 관리항목 중 설정이 적용된 관리항목이 있는 경우,<br />사용자지정방식에 따라서 입력된 코드와 명칭이 고정적용 되는 기능입니다.")%>
						</div>
						<p class="fwb mt20 mb7">※ <%=BizboxAMessage.getMessage("TX000009555","수정불가란?")%></p>
						<div class="lh18">
							<%=BizboxAMessage.getMessage("TX000016510","구축시 추가 개발된 내용 또는 특정한 경우에 관리자에 의해서 내용이 변질될 경우 시스템에 문제가 발생되는 건<br /> 수정 불가라 표현되어 시스템 사용에 영향을 주지 않도록 예외 처리된 건입니다.")%>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- twinbox -->
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->