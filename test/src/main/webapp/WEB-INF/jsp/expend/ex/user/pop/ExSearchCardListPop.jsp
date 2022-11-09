<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">

</script>

<div class="pop_wrap" style="width: 568px;">
	<!-- 윈도우팝업 사이즈 570*530 -->
	<div class="pop_head">
		<h1>${CL.ex_proofTypeSelect} <!--증빙유형 선택--></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>

	<div class="pop_con div_form">
		<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_keyWord} <!--검색어--></dt>
				<dd>
					<input id="txtSearch" type="text" style="width: 200px;" value="" />
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}" /> <!--검색-->
				</dd>
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta2 mt14">
			<table>
				<colgroup>
					<col width="34" />
					<col width="200" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkCardItem" id="chkCardItem_All" /> <label for="chkCardItem_All"></label></th>
						<th>${CL.ex_cardNm} <!--카드명--></th>
						<th>${CL.ex_cardNumber} <!--카드번호--></th>
					</tr>

				</thead>
			</table>
		</div>
		<div class="com_ta2 ova_sc cursor_p bg_lightgray" style="height: 296px;">
			<table id="tblCardList">
				<colgroup>
					<col width="34" />
					<col width="200" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td><input type="checkbox" name="" id="" /> <label for=""></label></td>
						<td>UC개발카드 001</td>
						<td>1598-5684-5623-1234</td>
					</tr>
				</tbody>
			</table>
		</div>


	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnSubmit" value="확인" /> <input type="button" id="btnCancel" class="gray_btn" value="취소" />
		</div>
	</div>
	<!-- //pop_foot -->

</div>
<!--// pop_wrap -->