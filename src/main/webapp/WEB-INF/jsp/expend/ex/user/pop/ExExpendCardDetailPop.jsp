<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" style="overflow:hidden">
<jsp:useBean id="currentTime" class="java.util.Date" />

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <style>
		html {overflow:hidden}
	</style>    
    
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.format.js'></script>
	<script id="treeview-template" type="text/kendo-ui-template">
            #: item.text #
	</script>
    
	<script type="text/javascript">
		$(document).ready(function() {
			
			// 팝업창 크기 조절
			//initWindowSize();
			
			// 휴폐업일 날짜
			var closedBusinessDay = '${ViewBag.closedBusinessDay}';
			if(closedBusinessDay != ''){
				$("#closedBusinessDay").text(closedBusinessDay.substr(0,4) + "-" + closedBusinessDay.substr(4,2) + "-" + closedBusinessDay.substr(6,2));
			}
			
			var date = '${ViewBag.authDate}';
			var time = '${ViewBag.authTime}';
			
			var year = date.substr(0,4);
			var month = date.substr(4,2) - 1;
			var day = date.substr(6,2);
			var h = time.substr(0,2);
			var m = time.substr(2,2);
			var s = time.substr(4,2);
			var inputDate = new Date(year, month, day, h, m, s);
			$("#date").html(fnFormatDate('yyyy-MM-dd HH:mm:ss', inputDate));
			
			var vatAmount = '${ViewBag.vatMdAmount}';
			var amtAmount = '${ViewBag.amtMdAmount}';
			var reqAmount = '${ViewBag.requestAmount}';
			
			/* 부가세만 존재하고 공급가액이 존재하지 않는 경우 */
			if(amtAmount == '' || amtAmount == '0'){
				amtAmount = Number(reqAmount) - Number(vatAmount);
			}
			
			$("#amt").html(fnAddComma(amtAmount));
			$("#vat").html(fnAddComma(vatAmount));
			$("#ser").html(fnAddComma('${ViewBag.serAmount}'));
			$("#req").html(fnAddComma(reqAmount));
			var cardNum = '${ViewBag.cardNum}';
			
			var isDisplayFullNumber = '${ViewBag.isDisplayFullNumber}';

			if (isDisplayFullNumber == 'false') {
			    $("#cardNum").html(cardNum.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/,"$1-****-****-$4"));
			}
			else {
				$("#cardNum").html(cardNum.substr(0,4) + '-' + cardNum.substr(4,4) + '-' + cardNum.substr(8,4) + '-' + cardNum.substr(12,4));
			}
			
			var auth = '[' + '${ViewBag.authCode}' + ']' + '${ViewBag.authName}';
			$("#auth").html((auth === '[]' ? '' : auth));
			var summary = '[' + '${ViewBag.summaryCode}' + ']' + '${ViewBag.summaryName}';
			$("#summary").html((summary === '[]' ? '' : summary));
			var project = '[' + '${ViewBag.projectCode}' + ']' + '${ViewBag.projectName}';
			$("#project").html((project === '[]' ? '' : project));
			var budget = '[' + '${ViewBag.budgetCode}' + ']' + '${ViewBag.budgetName}';
			$("#budget").html((budget === '[]' ? '' : budget));
			var bizplan = '[' + '${ViewBag.bizplanCode}' + ']' + '${ViewBag.bizplanName}';
			$("#bizplan").html((bizplan === '[]' ? '' : bizplan));
			var bgacct = '[' + '${ViewBag.bgacctCode}' + ']' + '${ViewBag.bgacctName}';
			$("#bgacct").html((bgacct === '[]' ? '' : bgacct));
			
			$("#btnClose").on('click',function(){
				window.close();
			});
		}); 
		
		// 팝업창 크기 조절
		function initWindowSize(){
			var winHeight = $(window).height(); // 팝업창 높이
			var originTopTableHeight = 408; // 기존 상단 테이블 높이
			var addHeight = ($(".com_ta > table").height() - originTopTableHeight) + 45; // 추가할 높이((현재 테이블 높이 - 기존 테이블 높이) + 보정값)
			
			window.resizeTo($(window).width(), winHeight + addHeight);
		}
	</script>

</head>

<body>
<div class="pop_wrap" style="height: 100%; overflow: scroll; ">
	<div class="pop_head">
		<h1><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con">		
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="25%"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>${CL.ex_businessNumber}</th>
					<td>${ViewBag.mercSaupNo}</td>
				</tr>
				<tr>
					<th><%=BizboxAMessage.getMessage("TX000005309","가맹점명")%></th>
					<td>${ViewBag.mercName}</td>
				</tr>
				<!-- iCUBE 일때만 표시 -->
				<c:if test="${ViewBag.ifSystem eq 'iCUBE'}">
					<!-- 가맹점업종, 공제여부, 과세유형, 휴폐업일 각각 내용이 없을 경우 화면에 표시하지 않음 -->
					<c:if test="${ViewBag.mccName ne ''}">
						<tr>
							<th>${CL.ex_store}${CL.ex_typeOfBusiness}</th> <!-- 가맹점업종 -->
							<td>${ViewBag.mccName}</td>
						</tr>
					</c:if>
					<!-- 공제여부 주석처리 : VAN사에서 직접 데이터를 받는 업체 중 값이 반대로 들어오는 경우가 있어 주석처리함. -->
<%-- 					<c:if test="${ViewBag.gongjeName ne ''}"> --%>
<!-- 						<tr> -->
<%-- 							<th>${CL.ex_deductionStatus}</th> <!-- 공제여부 --> --%>
<%-- 							<td>${ViewBag.gongjeName}</td> --%>
<!-- 						</tr> -->
<%-- 					</c:if> --%>
					<c:if test="${ViewBag.taxTypeName ne ''}">
						<tr>
							<th>${CL.ex_taxType}</th> <!-- 과세유형 -->
							<td>${ViewBag.taxTypeName}</td>
						</tr>
					</c:if>
					<c:if test="${fn:trim(ViewBag.closedBusinessDay) ne ''}">
						<tr>
							<th>${CL.ex_closedBusinessDay}</th> <!-- 휴폐업일 -->
							<td id="closedBusinessDay"></td>
						</tr>
					</c:if>
				</c:if>
			
				<!-- iU 일때만 표시 -->
				<c:if test="${ViewBag.ifSystem eq 'ERPiU'}">
				<!-- 가맹점업종 각각 내용이 없을 경우 화면에 표시하지 않음 -->
					<c:if test="${ViewBag.mccName ne ''}">
						<tr>
							<th>${CL.ex_store}${CL.ex_typeOfBusiness}</th> <!-- 가맹점업종 -->
							<td>${ViewBag.mccName}</td>
						</tr>
					</c:if>
					<c:if test="${ViewBag.taxTypeName ne ''}">
						<tr>
							<th>${CL.ex_taxType}</th> <!-- 과세유형 -->
							<td>${ViewBag.taxTypeName}</td>
						</tr>
					</c:if>
				</c:if>
				
				
				<tr>
					<th><%=BizboxAMessage.getMessage("TX000000073","전화번호")%></th>
					<td>${ViewBag.mercTel}</td>
				</tr>
				<tr>
					<th><%=BizboxAMessage.getMessage("TX000000375","주소")%></th>
					<td>${ViewBag.mercAddr}</td>
				</tr>
				<tr>
					<th>${CL.ex_dateApproval}</th>
					<td id="date"></td>
				</tr>
				<tr>
					<th>${CL.ex_purPrice}</th>
					<td id="amt"></td>
				</tr>
				<tr>
					<th>${CL.ex_vat}</th>
					<td id="vat"></td>
				</tr>
				<tr>
					<th>${CL.ex_serviceAmount}</th>
					<td id="ser"></td>
				</tr>
				<tr>
					<th>${CL.ex_amount}</th>
					<td id="req"></td>
				</tr>
				<tr>
					<th>${CL.ex_cardNumber}</th>
					<td id="cardNum"></td>
				</tr>
				<tr>
					<th>${CL.ex_confirmationNumber}</th>
					<td>${ViewBag.authNum}</td>
				</tr>
			</table>
			
			<table class="mt14">
				<colgroup>
					<col width="25%"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>${CL.ex_evidenceType}</th>
					<td id="auth"></td>
				</tr>
				<tr>
					<th>${CL.ex_standardOutline}</th>
					<td id="summary"></td>
				</tr>
				<tr>
					<th>${CL.ex_project}</th>
					<td id="project"></td>
				</tr>
				<tr>
					<th>${CL.ex_budgetUnit}</th>
					<td id="budget"></td>
				</tr>
				<tr>
					<th>${CL.ex_businessPlan}</th>
					<td id="bizplan"></td>
				</tr>
				<tr>
					<th>${CL.ex_budgetAccount}</th>
					<td id="bgacct"></td>
				</tr>
				<tr>
					<th>${CL.ex_note}</th>
					<td>${ViewBag.detail}</td>
				</tr>
			</table>
		</div>
	

	</div><!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" value="${CL.ex_check}" id="btnClose"/> <!--확인-->
<!-- 			<input type="button" class="gray_btn" value="취소" /> -->
		</div>
	</div><!-- //pop_foot -->

</div><!--// pop_wrap -->
</body>
</html>