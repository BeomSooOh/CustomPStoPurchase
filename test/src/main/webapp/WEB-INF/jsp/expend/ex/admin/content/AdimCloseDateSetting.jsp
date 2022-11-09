<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.date.js"></c:url>'></script>

<script type="text/javascript">
	
	/* 변수정의 */
	var formListInfo;
	
	var closeInfoList;
	
	$(document).ready(function() {
		fnInit();
	});
	
	function fnInit(){
		fnInitDatepicker();
		fnInitInput();
		fnInitEvent(); 
	}
	
	function fnInitInput(){
		formListInfo = ${ViewBag.formList};

		$("#tblFormList").dataTable({
            "select" : true,
            "paging" : false,
            "bSort" : false,
            "bAutoWidth" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : formListInfo,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                	dal_Box_detail();
        			
                	$("#spnSelectedForm").html(aData.formName);
                	$("#selFormSeq").val(aData.formSeq);
                	/* 양식 별 마감 정보 조회  */
                	fnCloseDateSearch();
                }));
                return nRow;
            },
            "aoColumns" : [
				{
   					"sTitle" : "${CL.ex_formNm}",
   					"mData" : "formName",
   					"bVisible" : true,
   					"bSortable" : false
//    					"sWidth" : "40px"
				}
			]
		});
		
		/* 최초 조회 시 등록된 양식이 존재하는 경우 최상단의 양식 기본으로 선택 */
		if( formListInfo && formListInfo.length > 0 ){
			$("#tblFormList tbody tr:first").addClass("selected").click();
		}else{
			$("#spnSelectedForm").html("-");
		}
	}
	
	function fnInitDatepicker(){
		// 검색 - 시작일
		setDatePicker($('#txtSrcCloseFromDT'));
		var txtSrcCloseFromDT = $("#txtSrcCloseFromDT").data("kendoDatePicker");
		var nowDate = new Date();
		var basicFromDate = (nowDate.getFullYear() - 1) + "-" + ((nowDate.getMonth() + 1) < 10 ? "0" + (nowDate.getMonth() + 1) : (nowDate.getMonth() + 1)) + "-" + (nowDate.getDate() < 10 ? "0"+nowDate.getDate() : nowDate.getDate());
		txtSrcCloseFromDT.value(basicFromDate);
		$("#txtSrcCloseFromDT").val(basicFromDate);
		
		// 검색 - 종료일
		setDatePicker($('#txtSrcCloseToDT'));
		
		// 시작일
		setDatePicker($('#txtCloseFromDT'));
		
		// 종료일
		$('#txtCloseToDT').setKendoDatePicker(function() {
			var fromDt = $("#txtCloseFromDT").val().replace(/-/g,"");
			var toDt = $("#txtCloseToDT").val().replace(/-/g,"");
			
			if(toDt == '' || toDt.indexOf("_") > -1 ){
				return false;
			}
			
			if( fromDt > toDt ){
				alert("종료일은 시작일 이후로 설정되어야 합니다.")
				$("#txtCloseToDT").val("");
				return false;
			}
			$("#txtNote").focus();
		});
		$('#txtCloseToDT').setKendoDatePickerMask();
	}
	
	function fnInitEvent(){
		// 마감 설정 버튼
		$("#btnNew").on("click",function(){
			if( formListInfo && formListInfo.length > 0 ){
				//리스트 클릭시 상세팝업 애니메이션 보여주기
				var $DALBD = $(".dal_Box_detail");
				$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
				
				/* 마감구분, 마감기간, 비고 사용 처리 */
				$("#txtCloseFromDT, #txtCloseToDT, #txtNote").prop("disabled",false);
				$("#selCloseType").selectmenu('enable');
				$('#txtCloseFromDT').data('kendoDatePicker').enable();
				$('#txtCloseToDT').data('kendoDatePicker').enable();
				
				/* 마감구분 */
// 				$("#selCloseType").val("").prop("selected",true);
				$("#selCloseType").val("").selectmenu('refresh');
				
				var txtCloseFromDT = $("#txtCloseFromDT").data("kendoDatePicker");
   				txtCloseFromDT.value("");
   				$("#txtCloseFromDT").val("");
   				/* 마감기간 종료일 */
   				var txtCloseToDT = $("#txtCloseToDT").data("kendoDatePicker");
   				txtCloseToDT.value("");
   				$("#txtCloseToDT").val("");
   				
   				$("#txtNote").val("");
				
   				/* 신규 등록 시 상단 검색조건 미사용처리 */
				$("#txtSrcCloseFromDT, #txtSrcCloseToDT, #txtModifyStr").prop("disabled",true);
				$("#selSrcCloseType, #selSrcCloseStat").selectmenu('disable');
   				
				$('#txtSrcCloseFromDT').data('kendoDatePicker').enable(false);
				$('#txtSrcCloseToDT').data('kendoDatePicker').enable(false);
				
				/* 마감버튼 숨김 */
				$("#btnClose").hide();
				/* 마감취소버튼 숨김 */
				$("#btnCloseCancel").hide();
				/* 삭제 버튼 숨김 */
				$("#btnCloseDelete").hide();
				/* 저장 버튼 표시  */
				$("#btnCloseSave").show();
				/* 모든 양식 적용 표시 */
				$("#divAllForm").show();
			}else{
				alert("양식을 선택하여 주십시오");
			}
		});
		
		/* 마감 목록 삭제 버튼 */
		$("#btnAllDelete").on("click",function(){
// 			$('#chkBox:checked').each(function() { 
// 				alert($(this).val());
// 			});
			
			var chkSels = $("input[name=inp_Chk]:checkbox:checked").map(function() {
	            if(this.value != 'on'){
	            	return this.value;	
	            }
	        }).get();
			var closeSeq = "";
			if(chkSels.length == 0){
				alert("마감 목록을 선택하여 주시길 바랍니다.");
				return false;
			}else{
				for(var i = 0 ; i < chkSels.length ; i++){
					closeSeq += chkSels[i] + ",";
				}
				closeSeq = closeSeq.substr(0,closeSeq.length - 1)
			}

			var param = {};
			param.formSeq = $("#selFormSeq").val();
// 			param.closeSeqs = JSON.stringify(chkSels);
			param.closeSeqs = closeSeq;
			param.isAllDelete = "Y";
			$.ajax({
				type : "post",
				url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseDateDelete.do" />',
				datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	            	dal_Box_detail();
	    			$("#btnSearch").click();
	    			alert("삭제되었습니다.");
	            },
	            error : function(){
	            	
	            }
			});
			$("#btnSearch").click();
		});
		
		/* 마감 삭제 버튼 */
		$("#btnCloseDelete").on("click",function(){
			var param = {};
			var tCloseData = JSON.parse($("#selectCloseListInfo").val());
			if(tCloseData.closeStat == 'Y'){
				alert("마감 중인 건은 삭제가 불가합니다. 마감 취소 후 삭제해주세요.");
				return false;
			}
			
			param.formSeq = $("#selFormSeq").val();
			param.closeType = $("#selCloseType").val();
			param.seq = tCloseData.seq;
			param.closeFromDate = tCloseData.closeFromDate;
			param.closeToDate = tCloseData.closeToDate;
			param.note = tCloseData.note;
			param.closeStat = "N";
			param.isAllDelete = "N";
			$.ajax({
				type : "post",
				url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseDateDelete.do" />',
				datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	            	dal_Box_detail();
	    			$("#btnSearch").click();
	    			alert("삭제되었습니다.");
	            },
	            error : function(){
	            	
	            }
			});
		});
		
		/* 마감 버튼 */
		$("#btnClose").on("click",function(){
			/* 필수값 체크 */
			if($("#selCloseType").val() == "" ){
				alert("마감구분이 선택되지 않았습니다. 다시 확인해주세요");
				return false;
			}
			if($("#txtCloseFromDT").val() == "" || $("#txtCloseToDT").val() == ""){
				alert("마감기간이 선택되지 않았습니다. 다시 확인해주세요.");
				return false;
			}
			
			var txtCloseFromDt = $("#txtCloseFromDT").val().replace(/-/g,"");
			var txtCloseToDT = $("#txtCloseToDT").val().replace(/-/g,"");
			var tCloseData = JSON.parse($("#selectCloseListInfo").val());
			
			var param = {};
			param.formSeq = $("#selFormSeq").val();
			param.closeType = $("#selCloseType").val();
			param.seq = tCloseData.seq;
			param.closeFromDate = txtCloseFromDt;
			param.closeToDate = txtCloseToDT;
			param.note = $("#txtNote").val();
			param.closeStat = "Y";
				
			$.ajax({
				type : "post",
				url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseDateUpdate.do" />',
				datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	    			alert("마감 되었습니다.");
	    			
	            	dal_Box_detail();
	    			$("#btnSearch").click();
	            },
	            error : function(){
	            	
	            }
			});
			
		});
		
		/* 마감 취소 버튼 */
		$("#btnCloseCancel").on("click",function(){
			var param = {};
			var tCloseData = JSON.parse($("#selectCloseListInfo").val());
			if(tCloseData.closeStat == 'N'){
				alert("이미 마감취소된 건입니다. 다시 확인해주세요.");
				return false;
			}
			
			var txtCloseFromDt = $("#txtCloseFromDT").val().replace(/-/g,"");
			var txtCloseToDT = $("#txtCloseToDT").val().replace(/-/g,"");
			
			param.formSeq = $("#selFormSeq").val();
			param.closeType = $("#selCloseType").val();
			param.seq = tCloseData.seq;
			param.closeFromDate = txtCloseFromDt;
			param.closeToDate = txtCloseToDT;
			param.note = $("#txtNote").val();
			param.closeStat = "N";
			
			$.ajax({
				type : "post",
				url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseDateUpdate.do" />',
				datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
// 	            	dal_Box_detail();
					var temp = JSON.parse($("#selectCloseListInfo").val());
					temp.closeStat = "N";
					$("#selectCloseListInfo").val(JSON.stringify(temp));
	    			$("#btnSearch").click();
	    			
	    			//마감/마감취소 버튼 보이기/숨김 처리
    				fnShowAndHideBtnClose("N");
	    			
	    			alert("마감 취소되었습니다.");
	            },
	            error : function(){
	            	
	            }
			});
		});
		
		/* 마감 저장 버튼 */
		$("#btnCloseSave").on("click",function(){
			// 마감일자 등록 시 필수값 체크
			var flag = verifyRequiredParams();

			if(flag){
				// 모든양식적용 체크 시
				if($("#allDoc").prop("checked")){
					// 모든양식적용 시 마감기간 중 등록된 내역 있는지 확인 후 등록
					checkCloseDateInAllForm();
				}else{
					// 마감일자 등록
					saveExpendCloseDate();
				}
			}
		});
		
		// 마감일자 등록 시 필수값 체크
		function verifyRequiredParams(){
			/* 필수값 체크 */
			if($("#selCloseType").val() == "" ){
				alert("마감구분이 선택되지 않았습니다. 다시 확인해주세요");
				return false;
			}
			if($("#txtCloseFromDT").val() == "" || $("#txtCloseToDT").val() == ""){
				alert("마감기간이 선택되지 않았습니다. 다시 확인해주세요.");
				return false;
			}
			
			var txtCloseFromDt = $("#txtCloseFromDT").val().replace(/-/g,"");
			var txtCloseToDT = $("#txtCloseToDT").val().replace(/-/g,"");
			var isDuplicatCloseDate = false;
			for(var i = 0 ; i < closeInfoList.length ; i++ ){
				if($("#selCloseType").val() == closeInfoList[i].closeType){
					var closeFromDate = closeInfoList[i].closeFromDate; 
					var closeToDate = closeInfoList[i].closeToDate; 
					if( ( closeFromDate <= txtCloseFromDt && txtCloseFromDt <= closeToDate ) ||
						( closeFromDate <= txtCloseToDT && txtCloseToDT <= closeToDate ) ||
						( txtCloseFromDt <= closeFromDate && closeToDate <= txtCloseToDT )
					){
						isDuplicatCloseDate = true;
						break;
					}
				}
			}
			if(isDuplicatCloseDate){
				alert("설정한 마감기간이 기존 등록 마감기간에 포함되어 있습니다. 다시 확인해주세요.");
				return false;
			}

			return true;
		}
		
		// 모든양식적용 시 마감기간 중 등록된 내역 있는지 확인
		function checkCloseDateInAllForm(){
			var param = {};
			param.closeType = $("#selCloseType").val();
			param.closeFromDate = $("#txtCloseFromDT").val().replace(/-/g,"");
			param.closeToDate = $("#txtCloseToDT").val().replace(/-/g,"");
				
			$.ajax({
				type : "post",
				url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseFormInsertChkValidate.do" />',
				datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	            	var duplicateFormSeqs = data.result.aaData; // 중복 마감등록된 폼양식 시퀀스
	            	var result = false; // 컨펌 문구 결과값
	            	
	            	// 기존 양식 리스트에서 중복된 양식명 가져오기
	            	var filteredData = formListInfo.filter(function(e){ 
            			return duplicateFormSeqs.map(function(data) { return data.formSeq }).indexOf(e.formSeq.toString()) > -1;
	            	});
	            	
	            	// 중복된 양식명
	            	var duplicateFormNames = filteredData.map(function(e) { return e.formName }).join(", ");
	            	
	            	// 다른양식에서 등록된 마감일자가 있는 경우
	            	if(duplicateFormSeqs.length > 0){
	            		result = confirm("이미 동일한 기간이 포함된 마감설정 양식이 존재합니다.\n"
	            				        + "해당 양식을 제외하고 적용 하시겠습니까?\n"
	            				        + "양식명: " + duplicateFormNames);
	            		
	            		// 확인을 누를 경우
	            		if(result){
	            			// 마감일자 등록
		     				saveExpendCloseDate(duplicateFormSeqs);
		            	}
	            	}else{
	            		// 마감일자 등록
	     				saveExpendCloseDate(duplicateFormSeqs);
	            	}
	            },
	            error : function(){
	            	
	            }
			});
		}
		
		// 마감일자 등록
		function saveExpendCloseDate(duplicateFormSeqs){
			var param = {};
			param.formSeq = $("#selFormSeq").val();
			param.closeType = $("#selCloseType").val();
			param.closeFromDate = $("#txtCloseFromDT").val().replace(/-/g,"");
			param.closeToDate = $("#txtCloseToDT").val().replace(/-/g,"");
			param.closeStat = "Y";
			param.note = $("#txtNote").val();
			if($("#allDoc").prop("checked")){
				param.isTotalInsert = 'Y';
			}else{
				param.isTotalInsert = 'N';
			}
			param.exceptFormList = (JSON.stringify(duplicateFormSeqs) || []); // 등록 시 제외할 양식 시퀀스(이미 등록된 양식 시퀀스)
			
			$.ajax({
				type : "post",
				url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseDateInsert.do" />',
				datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	            	if(data.result.resultCode == "FAIL" && data.result.resultName == '기간 중복'){
	            		alert("설정한 마감기간이 기존 등록 마감기간에 포함되어 있습니다. 다시 확인해주세요.");
	            	}else if(data.result.resultCode == "FAIL" && data.result.resultName != '실패하였습니다.'){
	            		alert("저장 중 오류가 발생하였습니다.");
	            	}else{
	            		alert("저장되었습니다.");
	            	}
	            	
	            	dal_Box_detail();
	    			$("#btnSearch").click();
	    			
	            },
	            error : function(){
	            	
	            }
			});
		}
		
		// 검색 버튼
		$("#btnSearch").on("click",function(){
			fnCloseDateSearch();
		});
		
		$("#txtSrcCloseFromDT, #txtSrcCloseToDT, #txtModifyStr").keydown(function(event){
			if(event.keyCode == 13){
				$("#btnSearch").click();	
			}
		});
		
		$("#txtCloseFromDT").keydown(function(event){
			if(event.keyCode == 13){
				if($("#txtCloseFromDT").val() != '' && $("#txtCloseFromDT").val().indexOf("_") == -1){
					$("#txtCloseToDT").focus();
				}
			}
		});
		
		$("#tblFormList tbody tr").click(function(){
			//첫번째 로우에 추가된 "selected" class를 제거하기 위해 추가
			$('#tblFormList tbody tr').removeClass('selected');
		});
		
	}
	
	/* 양식 별 마감정보 조회 */
	function fnCloseDateSearch(){
		var param = {};
		param.formSeq = $("#selFormSeq").val();
		param.fromDate = $("#txtSrcCloseFromDT").val().replace(/-/g,"");
		param.toDate = $("#txtSrcCloseToDT").val().replace(/-/g,"");
		param.closeType = $("#selSrcCloseType").val();
		param.closeStat = $("#selSrcCloseStat").val();
		param.modifyStr = $("#txtModifyStr").val();
		
		$.ajax({
			type : "post",
			url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseDateSelect.do" />',
			datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	closeInfoList = data.result.aaData;
            	$("#tblCloseList").dataTable({
                    "select" : true,
                    "paging" : true,
                    "bSort" : false,
                    "bAutoWidth" : false,
                    "destroy" : true,
                    "language" : {
                        "lengthMenu" : "보기 _MENU_",
                        "zeroRecords" : "${CL.ex_notListDeadLineList}",
                        "info" : "_PAGE_ / _PAGES_",
                        "infoEmpty" : "${CL.ex_notListDeadLineList}",
                        "infoFiltered" : "(전체 _MAX_ 중.)"
                    },
                    "data" : data.result.aaData,
                    "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                    	dal_Box_detail();
                    	$(nRow).css("cursor", "pointer");
                    	$(nRow).on('click', (function() {
		  	                    	// 선택한 값을 Index 값 가져오는곳 
		  	                    	// closeInfoList[nRow.sectionRowIndex];
		  	          				var selectedRowData = (aData || {}) 

		  	          				$("#selectCloseListInfo").val(JSON.stringify(selectedRowData));
		  	          				
		  	          				/* 마감기간 시작일 */
		  	          				var txtCloseFromDT = $("#txtCloseFromDT").data("kendoDatePicker");
		  	          				var formDt = selectedRowData.closeFromDate.substr(0,4)+"-"+selectedRowData.closeFromDate.substr(4,2)+"-"+selectedRowData.closeFromDate.substr(6,2);
		  	          				txtCloseFromDT.value(formDt);
		  	          				$("#txtCloseFromDT").val(formDt);
		  	          				/* 마감기간 종료일 */
		  	          				var txtCloseToDT = $("#txtCloseToDT").data("kendoDatePicker");
		  	          				var toDt = selectedRowData.closeToDate.substr(0,4)+"-"+selectedRowData.closeToDate.substr(4,2)+"-"+selectedRowData.closeToDate.substr(6,2);
		  	          				txtCloseToDT.value(toDt);
		  	          				$("#txtCloseToDT").val(toDt);
		  	          				
		  	          				/* 마감구분 */
		  	          				$("#selCloseType").val(selectedRowData.closeType).selectmenu('refresh');
		  	          				
		  	          				/* 비고 */
		  	          				$("#txtNote").val(selectedRowData.note);
		  	          				
		  	          				//마감/마감취소 버튼 보이기/숨김 처리
		  	          				fnShowAndHideBtnClose(selectedRowData.closeStat);
		  	          				
		  	          				/* 삭제 버튼 표시- 숨김- */
		  	          				$("#btnCloseDelete").hide();
		  	          				/* 저장 버튼 숨김  */
		  	          				$("#btnCloseSave").hide();
		  	          				/* 모든 양식 적용 숨김 */
		  	          				$("#divAllForm").hide();
		  	          				
		  	          				var $DALBD = $(".dal_Box_detail");
		  	          				$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
		  	          				$(this).parent().siblings().removeClass('on');
		  	          				$(this).parent().addClass("on");
							  
                    	 }));
                    },
                    "columnDefs" : [ 
						{
	                    	 "targets" : 0,
	                         "data" : null,
	                         "render" : function( data ) {
	                             if (data != null && data != "") {
	                             	if( data.closeStat == 'N'){
										return '<input type="checkbox" name="inp_Chk" id="inp_Chk' + data.seq + '" value="' + data.seq + '" class="k-checkbox add_chk" /><label class="k-checkbox-label bdChk" for="inp_Chk' + data.seq + '"></label>';
	                             	}else{
	                             		return '<input type="checkbox" disabled name="inp_Chk" id="inp_Chk' + data.seq + '" value="' + data.seq + '" class="k-checkbox add_chk" /><label class="k-checkbox-label bdChk" for="inp_Chk' + data.seq + '"></label>';
	                             	}
	                             	$("#inp_Chk7").attr("disabled",true);
	                             	
	                             } else {
	                                 return "";
	                             }
	                         }
	                    },
						{
	                    	 "targets" : 2,
	                         "data" : null,
	                         "render" : function( data ) {
	                             if( data.closeType == 'E' ){
	                            	 return "회계일자";
	                             }else if( data.closeType == 'A' ){
	                            	 return "증빙일자";
	                             }else{
	                            	 return "작성일자";
	                             }
	                         }
	                    },
						{
	                    	 "targets" : 3,
	                         "data" : null,
	                         "render" : function( data ) {
	                             return data.substr(0,4) + "-" +data.substr(4,2) +"-"+data.substr(6,2);
	                         }
	                    },
						{
	                    	 "targets" : 4,
	                         "data" : null,
	                         "render" : function( data ) {
	                        	 return data.substr(0,4) + "-" +data.substr(4,2) +"-"+data.substr(6,2);
	                         }
	                    },
						{
	                    	 "targets" : 5,
	                         "data" : null,
	                         "render" : function( data ) {
	                             if( data.closeStat == 'Y' ){
	                            	 return "마감";
	                             }else{
	                            	 return "마감취소";
	                             }
	                         }
	                    },
						{
	                    	 "targets" : 11,
	                         "data" : null,
	                         "render" : function( data ) {
	                        	 return data.substr(0,4) + "-" +data.substr(4,2) +"-"+data.substr(6,2);
	                         }
	                    }
                    ],
                    "aoColumns" : [
        				{
        					"sTitle" : "<label class=''><input type='checkbox' class='add_chk' id='inp_Chk' name='inp_Chk' onclick='fnChk(this)'></label>",
        		        	"bSearchable" : false,
        		        	"bSortable" : false,
        		        	"bVisible" : true,
        		        	"sWidth" : "34",
        		        	"sClass" : "center"
        				},
        				{
           					"sTitle" : "seq",
           					"mData" : "seq",
           					"bVisible" : false,
           					"bSortable" : false,
           					"sWidth" : "40px"
        				},
        				{
           					"sTitle" : "${CL.ex_deadLineDiv}",/* 마감구분 */
           					"bVisible" : true,
           					"bSortable" : false,
           					"sWidth" : "80px"
        				},
        				{
           					"sTitle" : "${CL.ex_startDate}",/* 시작일 */
           					"mData" : "closeFromDate",
           					"bVisible" : true,
           					"bSortable" : false,
           					"sWidth" : "100px"
        				},
        				{
           					"sTitle" : "${CL.ex_endDay}", /* 종료일 */
           					"mData" : "closeToDate",
           					"bVisible" : true,
           					"bSortable" : false,
           					"sWidth" : "100px"
        				},
        				{
           					"sTitle" : "${CL.ex_processStatus}",/* 상태 */
           					"bVisible" : true,
           					"bSortable" : false,
           					"sWidth" : "80px"
        				},
        				{
           					"sTitle" : "note",
           					"mData" : "note",
           					"bVisible" : false,
           					"bSortable" : false,
           					"sWidth" : "40px"
        				},
        				{
           					"sTitle" : "createSeq",
           					"mData" : "createSeq",
           					"bVisible" : false,
           					"bSortable" : false,
           					"sWidth" : "40px"
        				},
        				{
           					"sTitle" : "createDate",
           					"mData" : "createDate",
           					"bVisible" : false,
           					"bSortable" : false,
           					"sWidth" : "40px"
        				},
        				{
           					"sTitle" : "modifySeq",
           					"mData" : "modifySeq",
           					"bVisible" : false,
           					"bSortable" : false,
           					"sWidth" : "40px"
        				},
        				{
           					"sTitle" : "${CL.ex_deadLinePerson}",/* 마감자 */
           					"mData" : "modifyName",
           					"bVisible" : true,
           					"bSortable" : false,
           					"sWidth" : "80px"
        				},
        				{
           					"sTitle" : "${CL.ex_deadLineApplyDate}",/* 마감등록일자 */
           					"mData" : "modifyDate",
           					"bVisible" : true,
           					"bSortable" : false,
           					"sWidth" : "100px"
        				}
        			]
        		});
            	
            },
            error : function( data ) {
                return;
            }
		});
	}
	 
	function fnChk(){
		if($("#inp_Chk").prop("checked")){
			$("input.add_chk[type=checkbox]").not(":disabled").prop("checked",true);
		}else{
			$("input.add_chk[type=checkbox]").not(":disabled").prop("checked",false);
		}
		
	}
	
	//테이블 스크롤 동기화
	function dalBoxScroll() {
		var leftTableContentsLeft = $(".dal_BoxIn .leftContents").scrollLeft();
       	$(".dal_BoxIn .leftHeader").scrollLeft(leftTableContentsLeft);
	};
	
	//상세현황 닫기 공통
	function dal_Box_detail(){
		/* 신규 등록 시 상단 검색조건 미사용처리 */
		$("#txtSrcCloseFromDT, #txtSrcCloseToDT, #txtModifyStr").prop("disabled",false);
		$("#selSrcCloseType, #selSrcCloseStat").selectmenu('enable');
		$('#txtSrcCloseFromDT').data('kendoDatePicker').enable();
		$('#txtSrcCloseToDT').data('kendoDatePicker').enable();
		
		/* 마감취소버튼 숨김 */
		$("#btnCloseCancel").show();
		
		var $DALBD = $(".dal_Box_detail");
		$DALBD.removeClass("animated05s fadeInRight").addClass("animated05s fadeOutRight");
		$(".posi_left table td").parent().removeClass('on');
		setTimeout(function(){$DALBD.hide();},500);
	};	
	
	//마감/마감취소 버튼 보이기/숨김 처리
	function fnShowAndHideBtnClose(state){
		//마감된 상태일 경우
		if(state == "Y"){
			/* 마감취소버튼 표시 */
			$("#btnCloseCancel").show();
			/* 마감버튼 숨김 */
			$("#btnClose").hide();
			
			/* 마감구분, 마감기간, 비고 미사용 처리 */
			$("#txtCloseFromDT, #txtCloseToDT, #txtNote").prop("disabled",true);
			$("#selCloseType").selectmenu('disable');
			$('#txtCloseFromDT').data('kendoDatePicker').enable(false);
			$('#txtCloseToDT').data('kendoDatePicker').enable(false);
		}else{
			/* 마감버튼 숨김 */
			$("#btnCloseCancel").hide();
			/* 마감버튼 표시 */
			$("#btnClose").show();
			
			/* 마감구분, 마감기간, 비고 사용 처리 */
			$("#txtCloseFromDT, #txtCloseToDT, #txtNote").prop("disabled",false);
			$("#selCloseType").selectmenu('enable');
			$('#txtCloseFromDT').data('kendoDatePicker').enable();
			$('#txtCloseToDT').data('kendoDatePicker').enable();
		}
	}
</script>

<!-- Hidden -->
<input type="hidden" id="selFormSeq"/>
<input type="hidden" id="selectCloseListInfo"/>
	
<!-- 컨트롤박스 -->
<div class="top_box">
	<dl>
		<dt>${CL.ex_deadLineDate} <!--마감기간--></dt>
		<dd>
			<div class="dal_div">
				<input type="text" id="txtSrcCloseFromDT" class="w113"/>
			</div>
			~ 
			<div class="dal_div">
				<input type="text" id="txtSrcCloseToDT" class="w113" />
			</div>
		</dd>
		<dt>${CL.ex_deadLineDiv} <!--마감구분--></dt>
		<dd>
			<select class="selectmenu" style="width:80px;" id="selSrcCloseType">
				<option value="" selected="selected">${CL.ex_allSelect} <!--전체선택--></option>
				<option value="E">${CL.ex_accountingDate} <!--회계일자--></option>
				<option value="A">${CL.ex_evidenceDate} <!--증빙일자--></option>
				<option value="C">${CL.ex_writeDate} <!--작성일자--></option>
			</select>
		</dd>
		<dt>${CL.ex_processStatus} <!--상태--></dt>
		<dd>
			<select class="selectmenu" style="width:80px;" id="selSrcCloseStat">
				<option value="" selected="selected">${CL.ex_allSelect} <!--전체선택--></option>
				<option value="Y">${CL.ex_deadline} <!--마감--></option>
				<option value="N">${CL.ex_cancel} <!--취소--></option>
			</select>
		</dd>
		<dt>${CL.ex_deadLinePerson} <!--마감자--></dt>								
		<dd><input type="text" id="txtModifyStr" style="width:156px;" placeholder="${CL.ex_deadLinePersonSelect} " /></dd><!--마감자 선택-->
		<dd><input type="button" id="btnSearch" value="${CL.ex_search} " /></dd><!--검색-->
	</dl>
</div>

<div class="sub_contents_wrap pt10 posi_re">
	<div class="twinbox atCloseSet">
		<table style="table-layout:fixed;min-height:inherit;">
			<colgroup>
				<col style="width:200px;"/>
				<col />
			</colgroup>
			<tr>
				<td class="twinbox_td p0">										
					<div class="tb_borderB pl15 pr15 clear bg_lightgray">
						<div class="btn_div mt0 pt10">
							<div class="left_div">
								<p class="tit_p m0 mt5 mb5">${CL.ex_expendResFormList} <!--지출결의 양식목록--></p>
							</div>
						</div>
					</div>
					
					<div class="p15">
<!-- 						<div class="com_ta2 sc_head" style=""> -->
<!-- 							<table> -->
<!-- 								<tr> -->
<!-- 									<th>그룹명</th> -->
<!-- 								</tr> -->
<!-- 							</table> -->
<!-- 						</div> -->

						<div class="com_ta2 ova_sc2 cursor_p bg_lightgray atCloseSetDocList">
							<table id="tblFormList">
							</table>
						</div>
					</div>
				</td>
				
				<td class="twinbox_td p0">
					<div class="tb_borderB pl15 pr15 clear bg_lightgray">
						<div class="btn_div m0 pt10 pb10">
							<div class="left_div">
								<p class="tit_p m0 mt5">${CL.ex_deadLineList} <!--마감 목록--> ( ${CL.ex_SelectForm} : <span class="text_blue" id="spnSelectedForm"></span> )</p>
							</div>
							<div class="right_div">
								<div class="controll_btn p0">
									<button id="btnNew">${CL.ex_new} <!--신규--></button>
									<button id="btnAllDelete">${CL.ex_remove} <!--삭제--></button>
								</div>
							</div>
						</div>
					</div>
					<div class="dal_Box atCloseSet p15">	
						<!-- 근태구분 -->
						<div class="dal_BoxIn posi_re">
							<div class="posi_left" style="width:60%;">
								<div class="com_ta2 sc_head2 rowHeight ovh leftHeader" style="display: none;">
									<table style="table-layout:fixed;">
										<colgroup>
											<col width="34"/>
											<col width="80"/>
											<col width="100"/>
											<col width="100"/>
											<col width="80"/>
											<col width="80"/>
											<col width="100"/>		
										</colgroup>
										<thead>
											<tr class="borderR">
												<th><input type="checkbox" name="all_chk" id="allChk"/>&nbsp;<label for="allChk"></label></th>
												<th>${CL.ex_deadLineDiv} <!--마감구분--></th>
												<th>${CL.ex_startDate} <!--시작일--></th>
												<th>${CL.ex_endDay} <!--종료일--></th>
												<th>${CL.ex_processStatus} <!--상태--></th>
												<th>${CL.ex_deadLinePerson} <!--마감자--></th>
												<th>${CL.ex_deadLineApplyDate} <!--마감등록일자--></th>
											</tr>
										</thead>
									</table>
								</div>
								<div class="com_ta2 rowHeight cursor_p bg_lightgray ova_sc2 leftContents" onScroll="dalBoxScroll()">
									<table class="brtn" id="tblCloseList">
<%-- 										<colgroup> --%>
<%-- 											<col width="34"/> --%>
<%-- 											<col width="80"/> --%>
<%-- 											<col width="100"/> --%>
<%-- 											<col width="100"/> --%>
<%-- 											<col width="80"/> --%>
<%-- 											<col width="80"/> --%>
<%-- 											<col width="100"/>			 --%>
<%-- 										</colgroup> --%>
									</table>								
								</div>
							</div>
							
							<!-- 오른쪽 default -->
							<div class="posi_right disInfoBox" style="left:60%;">
								<div class="text01">${CL.ex_deadLineDetailSet} <!--마감 상세 설정--></div>
								<div class="text02">
									<ul>
										<li>- 마감 목록 추가는 상단 [마감] 버튼을 클릭해주세요.</li>
										<li>- 기존 등록 마감 내역 삭제는 상태가 '마감취소'인 경우에만 가능합니다.</li>
										<li>- 왼쪽 마감 목록에서 내역 클릭 시 상세 설정 확인이 가능합니다.</li>
										<li><br/></li>
										<li>※ Bizbox Alpha 회계 모듈에서는 '회계일자','증빙일자','작성일자' 기준 별로 마감 기간을 각기 설정할 수 있습니다. 마감 설정 시 사용자는 설정된 기간 동안 지출결의 작성 및 상신을 할 수 없습니다. </li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 레이어 -->
	<div class="dal_Box_detail scroll_on boxHeight atCloseSet" style="top:10px;left:60%;">
		<div class="btn_div posi_re">
			<div class="left_div">							
				<h5>${CL.ex_detailSetting} <!--상세 설정--></h5>
			</div>
			<div class="controll_btn p0 mr30">
				<!-- 아래버튼은 화면상황에 따라 사용해주세요. -->
				<span id="divAllForm"><input type="checkbox" name="inp_chk_form" id="allDoc" class="" />&nbsp;<label class="mr10" for="allDoc"><span>${CL.ex_allFormApply} <!--모든양식적용--></span></label></span>
				<button id="btnClose" type="button">${CL.ex_deadline} <!--마감--></button>
				<button id="btnCloseCancel" type="button">${CL.ex_deadLineCancel} <!--마감취소--></button>
				<button id="btnCloseSave" type="button">${CL.ex_save} <!--저장--></button>
				<button id="btnCloseDelete" type="button">${CL.ex_remove} <!--삭제--></button>
			</div>
			<a href="#n" class="close" onclick="dal_Box_detail()"></a>
		</div>
		
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="100"/>
					<col width="80"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th colspan="2"><img src="../../../Images/ico/ico_check01.png" alt=""> ${CL.ex_deadLineDiv} <!--마감구분--></th>
					<td>
						<select class="selectmenu" style="width:113px;" id="selCloseType">
							<option value="" selected="selected">${CL.ex_notSelect} <!--미선택--></option>
							<option value="E">${CL.ex_accountingDate} <!--회계일자--></option>
							<option value="A">${CL.ex_evidenceDate} <!--증빙일자--></option>
							<option value="C">${CL.ex_writeDate} <!--작성일자--></option>
						</select>
					</td>
				</tr>
				<tr>
					<th rowspan="2"><img src="../../../Images/ico/ico_check01.png" alt=""> ${CL.ex_deadLineDate} <!--마감기간--></th>
					<th>${CL.ex_startDate} <!--시작일--></th>
					<td>
						<div class="dal_div">
							<input type="text" id="txtCloseFromDT" class="w113"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>${CL.ex_endDay} <!--종료일--></th>
					<td>
						<div class="dal_div">
							<input type="text" id="txtCloseToDT" class="w113"/>
						</div>
					</td>
				</tr>
				<tr>
					<th colspan="2">${CL.ex_note2} <!--비고--></th>
					<td><textarea id="txtNote" style="width:96%;height:60px;padding:2%;" placeholder="${CL.ex_note2}  ${CL.ex_Please}"><!--비고--></textarea></td>
				</tr>
			</table>
		</div>
	</div>
	
</div><!-- //sub_contents_wrap -->
