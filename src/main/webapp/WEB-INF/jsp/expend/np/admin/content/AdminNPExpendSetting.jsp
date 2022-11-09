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

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>

<script>
	$(document).ready(function(){
		/* 최초 이벤트 정의 */
		fnEventInit();
		
		/* 최초 데이터 호출 */
		fnInit();
	});
	
	/* 최초 이벤트 정의 */
	function fnEventInit() {
		/* 저장 버튼 클릭 */
		$("#btnSave").click(function(){
			fnOptionSave();
		});
		return;
	}
	
	/* 최초 데이터 호출 */
	function fnInit() {
		/* 옵션 데이터 호출 */
		fnSelectOptionData();
		return;
	}
	
	/* 최초 옵션 데이터 호출 */
	function fnSelectOptionData() {
		var param = {};
		
		$.ajax({
			type : 'post',
            url : '<c:url value="/expend/np/admin/option/NpAdminOptionSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	console.log(JSON.stringify(data));
            	if(data.result.resultCode == "success") {
            		//fnSelectOptionDataBind();	
            	} else {
            		console.log("조회 실패");
            	}
            	
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
		});
		return;
	}
	
	/* 최초 옵션 데이터 바인딩 */
	function fnSelectOptionDataBind(data) {
		console.log("최초 옵션 데이터 : " + JSON.stringify(data));
	}
	
	/* 옵션 저장 */
	function fnOptionSave() {
		console.log("저장");
		var params = {};
		
		params.formSeq = "5";
		params.optionGbn = "common";
		params.optionCode = "7";
		params.setValue = "changeSetValue";
		params.setName = "changeSetName";
		
		$.ajax({
			type : 'post',
            url : '<c:url value="/expend/np/admin/option/NpAdminOptionUpdate.do" />',
            datatype : 'json',
            async : true,
            data : params,
            success : function( data ) {
            	console.log(JSON.stringify(data));
            	//fnSelectOptionDataBind();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
		});
		return;
	}
</script>

<input type="hidden" id="hidSelectOption"></input>

<div class="sub_contents_wrap">

	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
<%-- 			<dt><%=BizboxAMessage.getMessage("TX000000047","회사")%></dt> --%>
<!-- 			<dd> -->
<!-- 				<div class="dod_search"> -->
<!-- 					<input id="selCompany" style="width: 200px;" class="kendoComboBox" /> -->
<!-- 				</div> -->
<!-- 			</dd> -->
			<dt><%=BizboxAMessage.getMessage("TX000000177","양식")%></dt>
			<dd>
				<input id="selForm" style="width: 200px;" class="kendoComboBox" />
			</dd>
		</dl>
	</div>

	<div id="" class="controll_btn">
		<button id="btnSearch" class="k-button" style="display: none;">${CL.ex_search}  <!--검색--></button> <%--검색--%>
		<button id="btnSave" class="k-button">${CL.ex_save}  <!--저장--></button> <%-- 저장 --%>
	</div>


	<div class="tab_page">
		<div class="tab_style" id="tabStrip" style="background-color: white;">
			<ul class="mb20" style="background-color: white; border-top: none;">
				<li class="k-state-active">${CL.ex_functionalOption}  <!--기능옵션--></li><%-- 기능옵션 --%>
				<li>${CL.ex_dateOption}  <!--일자옵션--></li><%-- 일자옵션 --%>
				<li>${CL.ex_screenOption}  <!--화면옵션--></li><%-- 화면옵션 --%>
			</ul>
			<div class="tab1">
				<table style="width: 100%;">
					<colgroup>
						<col style="width: 70%;" />
						<col style="" />
					</colgroup>
					<tr>
						<td>
							<div id="divFunc" class="com_ta4 bgtable3 ova_sc"
								style="height: 408px">
								<div id="tblFunc">
									<colgroup>
										<col width="70%" />
										<col width="" />
									</colgroup>
									<tr>
										<th>${CL.ex_fnOptAttInfo}  <!--기능옵션 속성정보--></th>
										<th>${CL.ex_fnOptSetInfo}  <!--기능옵션 설정정보--></th>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">${CL.ex_noUser}  <!--미사용--></td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">${CL.ex_noUser}  <!--미사용--></td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">${CL.ex_noUser}  <!--미사용--></td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">${CL.ex_noUser}  <!--미사용--></td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">${CL.ex_noUser}  <!--미사용--></td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">${CL.ex_noUser}  <!--미사용--></td>
									</tr>
								</div>
							</div>
						</td>
						<td class="pl20">
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblFuncSub">
									<tr>
										<th>${CL.ex_fnOptSetValue}  <!--기능옵션 설정값--></th>
									</tr>
									<tr>
										<td class="le">
											<input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">${CL.ex_use}  <!--사용--></label>
										</td>
									</tr>
									<tr>
										<td class="le">
											<input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">${CL.ex_noUser}  <!--미사용--></label>
										</td>
									</tr>
								</div>
							</div>
						</td>
						<td></td>
					</tr>
				</table>

			</div>
			<!--// tab1 -->

			<div class="tab2">
				<table style="width: 100%;">
					<colgroup>
						<col style="width: 70%;" />
						<col style="" />
					</colgroup>
					<tr>
						<td>
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblDate">
								</div>
							</div>
						</td>
						<td class="pl20">
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblDateSub">
								</div>
							</div>
						</td>
						<td></td>
					</tr>
				</table>


			</div>
			<!--// tab2 -->


			<div class="tab3">
				<table style="width: 100%;">
					<colgroup>
						<col style="width: 70%;" />
						<col style="" />
					</colgroup>
					<tr>
						<td>
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblLayout">
								</div>
							</div>
						</td>
						<td class="pl20">
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblLayoutSub">
								</div>
							</div>
						</td>
						<td></td>
					</tr>
				</table>
			</div>
			<!--// tab3 -->
		</div>
		<!--// tab_style -->
	</div>
	<!--// tab_page -->
</div>
<!-- //sub_contents_wrap -->