<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>
<!-- NpDivBody -->
<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_enterthetaxamount}</h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

 
<div class="pop_con">	
	<div class="com_ta">
		<table>
			<colgroup>
				<col width="15%"/>
				<col width="22%"/>
				<col width="63%"/>
			</colgroup>
			
			<tr>
				<th colspan="2">${CL.ex_classifyIncome}</th>
				<td>
					<input type="text" autocomplete="off" id="incomeInfo" style="width:70%" value=""/>
					<input type="button" id="incomeGubun" value="선택"/>
				</td>
			</tr>
			<tr>
				<th colspan="2">${CL.ex_necessaryExpensesLate}</th>
				<td><input type="text" autocomplete="off" id="etcPercent" style="width:30%" value="" disabled="disabled"/>&nbsp;%</td>
			</tr>
			<tr>
				<th colspan="2">${CL.ex_necessaryExpensesAmt}</th>
				<td><input type="text" autocomplete="off" id="ndepAmt" style="width:85%" value=""/>&nbsp;${CL.ex_won}</td>
			</tr>
			<tr>
				<th colspan="2">${CL.ex_incomeAmt}</th>
				<td><input type="text" autocomplete="off" id="inadAmt" style="width:85%" value="" disabled="disabled"/>&nbsp;${CL.ex_won}</td>
			</tr>
			<tr>
				<th colspan="2">${CL.ex_incomeTaxAmt}</th>
				<td><input type="text" autocomplete="off" id="intxAmt" style="width:85%" value=""/>&nbsp;${CL.ex_won}</td>
			</tr>
			<tr>
				<th colspan="2">${CL.ex_residentTaxAmt}</th>
				<td><input type="text" autocomplete="off" id="rstxAmt" style="width:85%" value=""/>&nbsp;${CL.ex_won}</td>
			</tr>
			<tr>
				<th colspan="2">${CL.ex_reversionDate}</th>
				<td>
					<input type="text" autocomplete="off" id="etcrvrsYMYYYYY" style="width:30%" value=""/>&nbsp;${CL.ex_year}
					<input type="text" autocomplete="off" id="etcrvrsYMMMM" style="width:15%" value=""/>&nbsp;${CL.ex_month}
				</td>
			</tr>
			
		</table>
	</div>
</div><!-- //pop_con -->

	<script>
		function fnInitPopupLayout ( ) {
			thisWidth = 650;
			thisHeight = 450;
			// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
			if ( navigator.userAgent.indexOf ( "MSIE 6" ) > 0 ) { // IE 6.x
				popMWidth = 15;
				popMHeight = 80;
			} else if ( navigator.userAgent.indexOf ( "MSIE 7" ) > 0 ) { // IE 7.x
				popMWidth = 15;
				popMHeight = 80;
			} else if ( navigator.userAgent.indexOf ( "Firefox" ) > 0 ) { // FF
				popMWidth = 80;
				popMHeight = 72;
			} else if ( navigator.userAgent.indexOf ( "Netscape" ) > 0 ) { // Netscape
				popMWidth = 15;
				popMHeight = 80;
			} else if ( navigator.userAgent.toLowerCase ( ).indexOf ( "chrome" ) > 0 ) {
				popMWidth = 15;
				popMHeight = 68;
			} else if ( navigator.userAgent.indexOf ( "Trident" ) > 0 ) {
				popMWidth = 15;
				popMHeight = 90;
			}
		}

		var checkedData = '';
		function fnSetPageParam ( param ) {
			checkedData = param.checkedCardInfo;
			return param;
		}

		function fnGridCommonCodeTable() {
			return;
		}
	</script>