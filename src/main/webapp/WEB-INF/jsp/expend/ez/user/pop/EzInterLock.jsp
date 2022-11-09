<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<script type="text/javascript"
	src='<c:url value="/js/jquery-1.9.1.min.js"></c:url>'></script>

<!--  css 파일 모음 -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.common.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.dataviz.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.mobile.all.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.silver.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/common.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/reKendo.css"></c:url>'>


<script type="text/javascript">
var TASK_DT = '';
var TASK_SQ = '';
var CO_CD = '';

	$(document).ready(function() {			
		//var jsonData  = JSON.stringify('${resolData}');
		var bindData = {};
		bindData = JSON.parse('${resolData}');
		
		$("#txtResoldate").html(bindData.resoldate);
		$("#txtProject").html(bindData.project);
		$("#txtG20Project").html(bindData.G20Project);
		$("#txtG20abgt").html(bindData.G20abgt);
		$("#txtDetails").html(bindData.bmcode);
		$("#txtUse").html(bindData.use);
		$("#txtExecmtd").html(bindData.execmtd);
		$("#txtExecReqGb").html(bindData.execreqdiv);
		$("#txtG20Partner").html(bindData.partner);
		$("#txtResolNote").html();
		$("#txtCardnum").html(bindData.cardnum);
		$("#txtApprNum").html(bindData.approNum);
		$("#txtSerialNum").html(bindData.serialNum);
		$("#txtTrdate").html(bindData.trdate);
		$("#txtBelong").html(bindData.belong);
		$("#txtNm").html(bindData.nm);
		$("#txtEntrant").html(bindData.entrant);
		$("#txtBank").html(bindData.bank);
		$("#txtBankAccNum").html(bindData.bankaccount);
		$("#txtBankAccHolder").html(bindData.accholder);
		$("#txtRecip").html(bindData.recip);
		$("#txtTaxapprno").html(bindData.taxapprno);
		$("#txtSupperson").html(bindData.supperson);
		$("#txtSupbizno").html(bindData.supbizno);
		$("#txtConsiorg").html(bindData.consiorg);
		$("#txBizno").html(bindData.bizno);
		$("#txtSupplyamt").html(bindData.supplyamt);
		$("#txtTaxamt").html(bindData.taxamt);
		$("#txtResolamt").html(bindData.resolamt);
		
		TASK_DT = bindData.TASK_DT;
		TASK_SQ = bindData.TASK_SQ;
		CO_CD = bindData.CO_CD;
		
	});
	/* 데이터 콜백 바인드 */
	function fnOpenPopup(callBackData){
		window.open('/exp/expend/ez/user/EzInspectInterlockPopDatailList.do?TASK_DT=' + TASK_DT +'&TASK_SQ='+ TASK_SQ + '&CO_CD='+ CO_CD,"",'width=1024', 'height=300' );
	}
	
	function fnClose(){
		self.close();
	}
</script>

<div class="pop_wrap" id="layerCommonCode" style="width: 698px;">
	<div class="pop_head">
			<h1>상세보기</h1>
			<a href="#n" onclick="fnClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
		</div>	

	<div class="pop_con">
		<div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("","결의일자")%></th>
							<td class="le"><span  id="txtResoldate" style="width: 99%"></td>
							<th>G20<%=BizboxAMessage.getMessage("","연구과제")%></th>
							<td class="le"><span  id="txtProject" style="width: 99%"></td>
						</tr>
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("TX000000519","프로젝트")%></th>
							<td class="le"><span  id="txtG20Project" style="width: 99%"></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000003622","예산과목")%></th>
							<td class="le"><span  id="txtG20abgt" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009965","세목")%></th>
							<td class="le"><span  id="txtDetails" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009964","사용용도")%></th>
							<td class="le"><span  id="txtUse" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009963","집행방법")%></th>
							<td class="le"><span  id="txtExecmtd" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009962","집행요청구분")%></th>
							<td class="le"><span  id="txtExecReqGb" style="width: 99%"></td>
						</tr>
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le"><span  id="txtG20Partner" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></th>
							<td class="le"><span  id="txtResolNote" style="width: 99%"></td>
						</tr>
						
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("","카드번호")%></th>
							<td class="le"><span  id="txtCardnum" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("","승인번호")%></th>
							<td class="le"><span  id="txtApprNum" style="width: 99%"></td>
						</tr>
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("","청구일련번호")%></th>
							<td class="le"><span  id="txtSerialNum" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("","거래일")%></th>
							<td class="le"><span  id="txtTrdate" style="width: 99%"></td>
						</tr>
						<tr>
							<th>G20<%=BizboxAMessage.getMessage("","소속")%></th>
							<td class="le"><span  id="txtBelong" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("","성명")%></th>
							<td class="le"><span  id="txtNm" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000011204","출장자")%></th>
							<td class="le"><span  id="txtEntrant" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le"><span  id="txtBank" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le"><span  id="txtBankAccNum" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le"><span  id="txtBankAccHolder" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("","지급처")%></th>
							<td class="le"><span  id="txtRecip" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("","세금계산서 승인번호")%></th>
							<td class="le"><span  id="txtTaxapprno" style="width: 99%"></td>
							
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("","세금계산서 공급자명")%></th>
							<td class="le"><span  id="txtSupperson" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("","세금계산서 사업자번호")%></th>
							<td class="le"><span  id="txtSupbizno" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("","위탁기관")%></th>
							<td class="le"><span  id="txtConsiorg" style="width: 99%"></td>
							<th><%=BizboxAMessage.getMessage("","위탁사업자번호")%></th>
							<td class="le"><span  id="txBizno" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="ri" colspan="3" ><span  id="txtSupplyamt" style="width: 99%"></td>							
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="ri" colspan="3" ><span  id="txtTaxamt" style="width: 99%"></td>							
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="ri" colspan="3" ><span  id="txtResolamt" style="width: 99%"></td>							
						</tr>
						
						<tr>
							<th><%=BizboxAMessage.getMessage("","품목상세 리스트")%></th>
							<td class="le" colspan="3"> <a onclick="fnOpenPopup()" class="text_blue" href="#" >[품목상세 리스트 보기]</a></td>							
						</tr>
                    </table>
                </div>
	</div>
	<!--// pop_con -->
</div>