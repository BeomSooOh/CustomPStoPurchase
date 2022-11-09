<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%-- <%@ include file="/WEB-INF/jsp/ea/include/includeCmmOrgPop.jsp"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1,0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>

<!-- 관리자 > 회계 > 지출결의 관리 > iCUBE 연동문서 현황 -->

<script type="text/javascript">
	/* 변수 정의 */
	var isInitPage = false;
	/* 문서로드 */
	$(document).ready(function() {
		fnInit();
		$('#btniCUBEDocListSearch').click();
	});
	
	function fnInit(){
		fnEventInit();
		fnComboBoxInit();
		fnDatepickerInit();
		$("#selViewLength").css('width','85px');
		$("#selViewLength").css('height','22px');
	}
	
	function fnEventInit(){
		fnKeyEventInit();
		fnClickEventInit();
	}
	
	function fnKeyEventInit(){
		$("#txtFromDate, #txtToDate, #txtWriter, #txtDocNo, #txtDocTitle").keydown(function (event) {
            if (event.keyCode === 13) {
            	$('#btniCUBEDocListSearch').click();
            }
		});
	}
	
	function fnClickEventInit(){
		/* 검색 */
        $('#btniCUBEDocListSearch').click(function() {
        	isInitPage = false;
        	fniCUBEDocListSelect();
        });
		
        /* 삭제 */
        $('#btnDocInfoDelete').click(function() {
        	fniCUBEDocListDelete();
        });
	}
	
	function fnComboBoxInit(){
		var docStatusInfo = ('${ViewBag.commonCodeListDocStatus}' === '' ? [] : ${ViewBag.commonCodeListDocStatus});
        $("#selDocStatus").empty();
		$.each(docStatusInfo, function(idx, item) {
			$("#selDocStatus").append("<option value='" + item.commonCode + "'>" + item.commonName + "</option>");
		});
		
		$("#selDocStatus").change(function(){
			$('#btniCUBEDocListSearch').click();
		});
		
		if(docStatusInfo.length > 0){
			$("#selDocStatus").val(docStatusInfo[0].commonCode).selectmenu('refresh');
		}
		
		$("#selViewLength").selectmenu({change: function(){
			$('select[name=tbliCUBEDocList_length]').val($('#selViewLength').val());
			$('select[name=tbliCUBEDocList_length]').trigger('change');
		}});
	}
	
	function fnDatepickerInit(){
		setDatePicker($('.datepicker'));
		var dt = new Date();
        $('#txtFromDate').val([ dt.getFullYear(), ((Number(dt.getMonth()) + 1) < 10 ? [ '0', (Number(dt.getMonth()) + 1) ].join('') : (dt.getMonth() + 1)), '01' ].join('-'));
        $('#txtToDate').val([ dt.getFullYear(), ((Number(dt.getMonth()) + 1) < 10 ? [ '0', (Number(dt.getMonth()) + 1) ].join('') : (dt.getMonth() + 1)), ((dt.getDate() + '').length == 2 ? dt.getDate() : '0' + dt.getDate()) ].join('-'));
	}
	
	function fniCUBEDocListSelect(){
		var param = {};
        param.fromDt = $("#txtFromDate").val().toString().replace(/-/g, '');
        param.toDt = $("#txtToDate").val().toString().replace(/-/g, '');
        param.writer = $("#txtWriter").val();
        param.docSts = ($('#selDocStatus').val() == "전체" ? "" : $('#selDocStatus').val());
        
        param.docNo = $("#txtDocNo").val();
        param.docTitle = $("#txtDocTitle").val();
        param.formName = $("#txtFormTitle").val();
        
        
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/report/ExiCUBEDocListSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	fniCUBEDocListBind(data.result.aaData);
            },
            error : function( data ) {
                console.log("! [EX][FNREPORTEXPENDADMSEARCH] ERROR - " + JSON.stringify(data));
            }
        });
	}
	
	function fniCUBEDocListBind(result){
		var source = (result || {});
		
		$('#tbliCUBEDocList').dataTable({
        	
            "fixedHeader" : true,
            "select" : true,
            "lengthMenu" : [ [ 10, 20, 30, 40, 50 ], [ 10, 20, 30, 40, 50 ] ],
            "displayStart": 0,
            /* "sScrollY" : '590px', */
            "bAutoWidth" : false,
            "bSort" : true,
            "bStateSave" : isInitPage,
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
                $(nRow).on('click', (function() {

                }));
                $(nRow).on('dblclick', (function() {

                }));

                return nRow;
            },
            "columnDefs" : [ {
            	"targets" : 0,
                "data" : null,
                "render" : function( data ) {
                    if (data != null && data != "") {
                   		return '<input type="checkbox" name="inp_expend_Chk" id="inp_expend_chk_' + data.approkey + '" value="' + data.approkey + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_expend_chk_' + data.approkey+ '"></label>';	
                    } else {
                        return "";
                    }
                }
            }, {
            	"targets" : 1,
                "data" : null,
                "render" : function( data ) {
                	return '<a href="javascript:;" title="'+ data.docNo +'" onClick="javascript: fnAppdocPop('
					+ "'" + data.docId + "', '" + data.formId
					+ "'" + ')">' + data.docNo + '</a>';
                }
            }, {
            	"targets" : 2,
                "data" : null,
                "render" : function( data ) {
                    if (data != null && data != "" && data != "0000-00-00") {
                    	return data;
                    } else {
                        return "";
                    }
                }
            }, {
            	"targets" : 3,
                "data" : null,
                "render" : function( data ) {
                	return '<a href="javascript:;" title="'+ data.docTitle +'" onClick="javascript: fnAppdocPop('
					+ "'" + data.docId + "', '" + data.formId
					+ "'" + ')">' + data.docTitle + '</a>';
                }
            }, {
            	"targets" : 6,
                "data" : null,
                "render" : function( data ) {
                    if (data != null && data != "") {
                    	var docStsName;
                   		switch( data ){
	                   		case "10":
	                   			docStsName = "저장";
	                   			break;
	                   		case "20":
	                   			docStsName = "상신";
	                   			break;
	                   		case "30":
	                   			docStsName = "진행";
	                   			break;
	                   		case "40":
	                   			docStsName = "발신종결";
	                   			break;
	                   		case "50":
	                   			docStsName = "수신상신";
	                   			break;
	                   		case "60":
	                   			docStsName = "수신진행";
	                   			break;
	                   		case "70":
	                   			docStsName = "수신반려";
	                   			break;
	                   		case "80":
	                   			docStsName = "수신확인";
	                   			break;
	                   		case "90":
	                   			docStsName = "종결";
	                   			break;
	                   		case "100":
	                   			docStsName = "반려";
	                   			break;
	                   		case "999":
	                   			docStsName = "삭제";
	                   			break;
                   		}
                   		return docStsName;
                    } else {
                        return "";
                    }
                }
            } ],
            "aoColumns" : [{
            	"sTitle" : "<label class=''><input type='checkbox' id='inp_expend_Chk_Title' name='inp_expend_Chk' onclick='fnChk(this)'></label>",
	        	"bSearchable" : false,
	        	"bSortable" : false,
	        	"bVisible" : true,
	        	"sWidth" : "34",
	        	"sClass" : "center"
        	}, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000663","문서번호")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "250px",
                "sClass" : "td_le"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000494","기안일")%>",
                "mDataProp" : "repDt",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "150px"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000003457","문서제목")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "td_le"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("","양식 명")%>",
                "mDataProp" : "formNm",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "300px",
                "sClass" : "td_le"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000003581","상신자")%>",
                "mDataProp" : "userNm",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "160px"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("","문서상태")%>",
                "mDataProp" : "docSts",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "100px"
            }]
        });
		$('select[name=tbliCUBEDocList_length]').val($('#selViewLength').val());
		$('select[name=tbliCUBEDocList_length]').trigger('change');
	}
	
	function fnChk( obj ) {
        var name = obj.name;
        var objChked = $("input[name=inp_expend_Chk]:checkbox");
        fnAllCheckBoxChecked(obj, objChked);
    }
	
	function fniCUBEDocListDelete(){
		
		var countCk =  $("input[name=inp_expend_Chk]:checkbox:checked").map(function() {
            return this.value;
        }).get().length;
		
		if(countCk < 1) {
			alert("<%=BizboxAMessage.getMessage("TX000002223","선택된 항목이 없습니다.　항목을 선택하여 주십시오")%>");
			return;
		}
		
		if(confirm('삭제된 문서는 복원되지 않습니다.\n외부연동문서가 포함된 경우 연동데이터도 삭제 처리 됩니다.\n삭제 하시겠습니까?\n\n총 선택 건수 :'+countCk+'건')){
	    	var chkSels = $("input[name=inp_expend_Chk]:checkbox:checked").map(function() {
	            return this.value;
	        }).get();
	        var deletectChkCount = chkSels.length;
	        
	        /* 전체 선택 체크박스 제거 */
	        if(chkSels.length > 0 && chkSels[0] === 'on'){
	        	deletectChkCount--;
	        }
	        
	        var targetList = '';
	        $.each(chkSels, function( idx, item ) {
	        	if( item != 'on'){
	        		targetList += item + ',';
	        	}
	        });
	        if(targetList.length <= 0 ){
	        	alert("<%=BizboxAMessage.getMessage("TX000002223","선택된 항목이 없습니다.　항목을 선택하여 주십시오")%>");
	        	return;
	        }
	        
	        targetList = targetList.substr(0,targetList.length - 1);
	        
	        var errCount = 0;
	        /* 삭제처리 진행 */
	        var param = {};
	        param.targetList = targetList;
	        /* 서버호출 */
	        $.ajax({
	            type : 'post',
	            url : '<c:url value="/ex/expend/admin/ExiCUBEDocListDelete.do" />',
	            datatype : 'json',
	            async : false,
	            data : param,
	            success : function( data ) {
	            	errCount = countCk - data.result.count; 
	            	alert('삭제 되었습니다.\n\n- 총 선택 건수 : '+ countCk +'건\n- 정상 선택 건수 : '+ data.result.count +'건\n- 삭제 오류 건수 :'+errCount+'건');
	            	isInitPage = true;
	            	fniCUBEDocListSelect();
	            },
	            error : function( data ) {
	                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
	            }
	        });
    	}
	}
	
	/* function - fnAppdocPop */
	function fnAppdocPop(docSeq, formSeq) {
		var intWidth = '1000';
		var intHeight = screen.height - 100;
		var agt = navigator.userAgent.toLowerCase();

		if (agt.indexOf("safari") != -1) {
			intHeight = intHeight - 70;
		}

		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}
		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq
				+ "&form_id=" + formSeq + "&doc_auth=1";
		window.open(url, 'AppDoc',
				'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left='
						+ intLeft + ',top=' + intTop);
	}
</script>

<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt><%=BizboxAMessage.getMessage("TX000000938","기안일자")%></dt>
			<dd>
				<input id="txtFromDate" class="dpWid datepicker" /> ~ <input id="txtToDate" class="dpWid datepicker" />
			</dd>
			<dt><%=BizboxAMessage.getMessage("TX000000499","기안자")%></dt>
			<dd>
				<input id="txtWriter" type="text" style="width: 120px;" />
			</dd>
			<dt><%=BizboxAMessage.getMessage("TX000005832","문서상태")%></dt>
			<dd>
				<select id="selDocStatus" style="width: 100px;" class="selectmenu">
				</select>
			</dd>
					
			<dd>
				<div class="controll_btn p0">
					 <button id="btniCUBEDocListSearch" class="btn_sc_add">${CL.ex_search}</button>
				</div>
			</dd>						
		</dl>
		<span class="btn_Detail"><%=BizboxAMessage.getMessage("TX000005724","상세검색")%> <img id="all_menu_btn" src='<c:url value="/Images/ico/ico_btn_arr_down01.png"/>' /></span>
	</div>

	<!-- 상세검색박스 -->
	<div class="SearchDetail">
		<dl>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000000663","문서번호")%></dt>
			<dd class="mr5">
				<input id="txtDocNo" data-bind="value: appDocNo" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000000493","제목")%></dt>
			<dd class="mr5">
				<input id="txtDocTitle" data-bind="value: appDocTitle" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000000492", "문서분류")%></dt>
			<dd class="mr5">
				<input id="txtFormTitle" type="text" value="" style="width: 300px">
			</dd>
		</dl>
	</div>

	<div id="" class="controll_btn cl">
		<button id="btnDocInfoDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424","삭제")%></button>
		<select class="selectmenu" id ="selViewLength" style="width: 66px;height: 22px;"><!-- 공통코드 처리 필요 -->
			<option value="10">10<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="20">20<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="30">30<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="40">40<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="50">50<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
		</select>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2 bg_lightgray">
		<table id="tbliCUBEDocList">

		</table>
	</div>
</div>
<!-- //sub_contents_wrap -->


