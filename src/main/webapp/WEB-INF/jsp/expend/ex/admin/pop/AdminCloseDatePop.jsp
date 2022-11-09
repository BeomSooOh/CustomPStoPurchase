<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.date.js"></c:url>'></script>

<script type="text/javascript">
	$(document).ready(function() {
		window.resizeTo(460, 500); /* 2019-09-20 / 김상겸 : 데이트피커 선택의 문제로 인한 팝업크기 강제 조정 */
		
		fnInit();
	});
	
	function fnInit(){
		fnInitDatepicker();
		fnInitEvent(); 
	}
	
	
	function fnInitDatepicker(){
		// 시작일
		$('#txtCloseFromDt').setKendoDatePicker(function() {
			if($("#txtCloseFromDt").val() != '' && $("#txtCloseFromDt").val().indexOf("_") == -1){
				$("#txtCloseToDt").focus();
			}
		});
		$('#txtCloseFromDt').setKendoDatePickerMask();
		
		// 종료일
		$('#txtCloseToDt').setKendoDatePicker(function() {
			var fromDt = $("#txtCloseFromDt").val().replace(/-/g,"");
			var toDt = $("#txtCloseToDt").val().replace(/-/g,"");
			
			if(toDt == '' || toDt.indexOf("_") > -1 ){
				return false;
			}
			
			if( fromDt > toDt ){
				alert("종료일은 시작일 이후로 설정되어야 합니다.")
				$("#txtCloseToDt").val("");
				return false;
			}
			$("#txtNote").focus();
		});
		$('#txtCloseToDt').setKendoDatePickerMask();
	}
	
	function fnInitEvent(){
		/* 마감 저장 버튼 */
		$("#btnCloseSave").on("click",function(){
			/* 필수값 체크 */
			if($("#selCloseType").val() == "" ){
				alert("마감구분이 선택되지 않았습니다. 다시 확인해주세요");
			}
			if($("#txtCloseFromDt").val() == "" || $("#txtCloseToDt").val() == ""){
				alert("마감기간이 선택되지 않았습니다. 다시 확인해주세요.");
			}
			
			var txtCloseFromDt = $("#txtCloseFromDt").val().replace(/-/g,"");
			var txtCloseToDT = $("#txtCloseToDt").val().replace(/-/g,"");
			
			var param = {};
			param.formSeq = $("#selFormSeq").val();
			param.closeType = $("#selCloseType").val();
			param.closeFromDate = txtCloseFromDt;
			param.closeToDate = txtCloseToDT;
			param.closeStat = "Y";
			param.note = $("#txtNote").val();
			param.isTotalInsert = 'Y';
				
			$.ajax({
				type : "post",
				url : '<c:url value="/ex/expend/admin/ExAdminExpendCloseDateInsert.do" />',
				datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	            	if(data.result.resultCode == "fail" && data.result.resultName != '실패하였습니다.'){
	            		alert("일부 양식중에 설정한 마감기간이 기존 등록마감기간에 포함되어 있습니다. 다시 확인해주세요.");
	            	}else{
	            		alert("저장되었습니다.");	            		
	            		self.close();
	            	}
	    			
	            },
	            error : function(){
	            	
	            }
			});
			
		});
		
		/* 취소 버튼 */
		$("#btnCancel").on("click",function(){
			this.close();
		});
		
	}
	
</script>

	<div class="pop_wrap" style="width:458px; height:445px;">
		<div class="pop_head">
			<h1>${CL.ex_deadLineSet} <!--마감설정--></h1>
			<a href="#n" class="clo"><img src="../Images/btn/btn_pop_clo01.png" alt="" /></a>
		</div>

		<div class="pop_con pt0" style="height: 341px;">
			<div class="btn_div">
				<div class="left_div">							
					<h5>${CL.ex_deadLineDetailSet} <!--마감 상세 설정--></h5>
				</div>
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
								<input type="text" id="txtCloseFromDt" class="w113" />
							</div>
						</td>
					</tr>
					<tr>
						<th>${CL.ex_endDay} <!--종료일--></th>
						<td>
							<div class="dal_div">
								<input type="text" id="txtCloseToDt" class="w113" />
							</div>
						</td>
					</tr>
					<tr>
						<th colspan="2">비고</th>
						<td><textarea id="txtNote" style="width:96%;height:60px;padding:2%;"></textarea></td>
					</tr>
				</table>
			</div>
			<div class="text_blue mt10">※ 상세 설정 저장 시 모든 양식에 대해 설정 값이 일괄 적용됩니다.<br/>양식 별 설정의 경우, [지출결의 설정 > 마감설정] 페이지에서 가능합니다.</div>
		</div>
		<!-- //pop_con -->

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" id="btnCloseSave" value="확인" id="btnCommit" />
				<input type="button" id="btnCancel" class="gray_btn" value="취소" id="btnRollback" />
			</div>
		</div>
		<!-- //pop_foot -->
	</div>
	<!-- //pop_wrap -->