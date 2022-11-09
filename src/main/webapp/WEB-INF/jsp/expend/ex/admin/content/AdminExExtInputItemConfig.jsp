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

<!-- 관리자 > 회계 > 지출결의 설정 > 확장입력 설정 -->
<!-- 지출결의 작성시 추가적으로 입력하고자하는 항목을 설정하는 기능 -->

<script>
	// ${UserInfo}

	// ready
	$(document).ready(function() {
		fnInit();
		fnEventInit();

		return;
	});

	// init
	function fnInit() {
		fnSetFormInfo();

		return;
	}

	// event init
	function fnEventInit() {

		// 조회
		$('#btnSearch').click(function() {
			fnSearch();
			return;
		});

		// 신규
		$('#btnNew').click(function() {
			fnNew();
			return;
		});

		// 저장
		$('#btnSave').click(function() {
			fnSave();
			return;
		});

		// 삭제
		$('#btnDelete').click(function() {
			fnDelete();
			return;
		});

		return;
	}

	// 조회
	function fnSearch() {
		return;
	}

	// 양식 조회
	function fnSetFormInfo() {
		// ${FormInfo}
		var formArr = ${FormInfo};

		$("#selForm").empty();
		$.each(formArr, function(idx, item) {
			$("#selForm").append("<option value='" + item.formSeq + "'>" + item.formName + "</option>");
		});

		return;
	}
	
	// 구분 정의
	function fnSetTypeInfo() {
		return;
	}
	
	// 사용여부
	function fnSetUseInfo() {
		return;
	}

	// 신규
	function fnNew() {
		return;
	}

	// 저장
	function fnSave() {
		return;
	}

	// 삭제
	function fnDelete() {
		return;
	}
</script>

<!-- iframe wrap -->
<div class="iframe_wrap">
	<div class="sub_contents_wrap">
		<!-- 컨트롤박스 -->
		<div class="top_box">
			<dl>
				<!-- 양식 -->
				<dt>${CL.ex_form}</dt>
				<dd>
					<div class="dod_search">
						<select id="selForm" class="selectmenu" style="width: 200px;">
						</select>
					</div>
				</dd>
				<dd>
					<div class="controll_btn p0">
						<button id="btnSearch" class="btn_sc_add">${CL.ex_search}</button>
					</div>
				</dd>

			</dl>
		</div>
		<div id="" class="controll_btn">
			<!-- 신규 -->
			<button id="btnNew" class="k-button">${CL.ex_new}</button>
			<!-- 저장 -->
			<button id="btnSave" class="k-button">${CL.ex_save}</button>
			<!-- 삭제 -->
			<button id="btnDelete" class="k-button">${CL.ex_delete}</button>
		</div>
		<div class="twinbox">
			<table>
				<colgroup>
					<col width="60%" />
					<col width="40%" />
				</colgroup>
				<tr>
					<td class="twinbox_td" style="">
						<div id="divConfigSettingMng"
							class="com_ta2 bg_lightgray hover_no">
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
								<tr>
									<th>항목명</th>
									<td><input type="text" id="txtConfigSettingMngNote"
										class="k-textbox txt_box" style="width: 96%;"></input></td>
								</tr>
								<tr>
									<th>설명</th>
									<td><input type="text" id="txtConfigSettingMngNote"
										class="k-textbox txt_box" style="width: 96%;"></input></td>
								</tr>
								<tr>
									<th>구분</th>
									<td><select id="selConfigSettingMngInputType"
										class="selectmenu" style="width: 80px;">
									</select></td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td><select id="selConfigSettingMngInputType"
										class="selectmenu" style="width: 80px;">
									</select></td>
								</tr>
							</table>
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