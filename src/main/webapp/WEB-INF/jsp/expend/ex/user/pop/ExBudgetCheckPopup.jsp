<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/jquery.dataTables.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.select.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.scroller.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.rowReorder.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.fixedHeader.min.js?varsion=<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMddHH"/>'></script> --%>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/jquery.maskMoney.js'></script>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/NeosUtil.js'></script> --%>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/ExAmtCommon.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/CommonEx.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/ExExpend.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.date.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.event.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.format.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.list.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.pop.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.valid.js'></script>


<script>
	/* ${budget_param} */
	/* iCUBE??? ?????? */
	var acct_code = '${budget_param.acct_code}'; // ???????????? ??????
	var acct_name = '${budget_param.acct_name}'; // ???????????? ???
	/* ERPiU??? ?????? */
	var bgacct_code = '${budget_param.bgacct_code}'; // ??????????????????(????????????) ?????? 
	var bgacct_name= '${budget_param.bgacct_name}'; // ?????????????????? ??????
	var bizplan_code = '${budget_param.bizplan_code}'; // ???????????? ??????
	var cd_bg_level = '${budget_param.cd_bg_level}'; // ???????????? ??????
	var yn_control = '${budget_param.yn_control}'; // ?????? ??????
	var tp_control = '${budget_param.tp_control}'; // ?????? ??????
	
	/* ?????? */
	var budget_code = '${budget_param.budget_code}'; //????????????
	var amt = ${budget_param.amt}; // ??????
	var budget_ym = '${budget_param.budget_ym}'; // ????????????
	var drcr_gbn =  '${budget_param.drcr_gbn}'; // ????????? ??????
	var baseListAmt = ${budget_param.basicListAmt}; // ?????? ?????? ?????? ??????
	var expendSeq = '${budget_param.expendSeq}'; // ????????????  seq
	var listSeq = '${budget_param.listSeq}'; // ?????? seq
	var isEdit = '${budget_param.isEdit}';
	
	$(document).ready(function() {
		fnBudgetCheck();
	});
	
	/* ???????????? ?????? ?????? */
	function fnBudgetCheck(){
		/* ???????????? */
		var data = {};
		/* iCUBE??? ?????? */
		data.acctCode = acct_code;
		/* ERPiU??? ?????? */
		data.bgacctCode = bgacct_code;
		data.bizplanCode = bizplan_code;
		data.cdBgLevel = cd_bg_level;
		data.ynControl = yn_control;
		data.tpControl = tp_control;
		/* ?????? */
		data.budgetCode = budget_code;
		data.amt = amt;
		data.budgetYm = budget_ym;
		data.drcrGbn = drcr_gbn;
		
		data.expendSeq = expendSeq;
		data.listSeq = listSeq;
		data.isEdit = isEdit;
	
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/ex/user/expend/ExBudgetAmtCheck2.do" />';
        ajaxParam.async = true;
        ajaxParam.data = data;
        ajaxParam.callback = function fnGetBudgetAmt(resultData){
        	if(resultData.ifSystem === 'iCUBE'){ /* iCUBE */
        		var acct_info = '('+acct_code+')'+decodeURI(acct_name);
				if(resultData.aaData.budgetControlYN === 'Y'){
					//????????????
					$("#sp_acct_code").html(acct_info);
					//????????????
					$("#sp_budget_ym").html(fnFormatStringToDate('yyyy-MM', (budget_ym || '000000')));
					//???????????????(????????????))
					var act_sum = parseInt(resultData.aaData.budgetActsum);
					$("#sp_total_amt").html(act_sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
					//??????(??????)??????
					var jsum = parseInt(resultData.aaData.budgetJsum) -  + Number(baseListAmt);
					$("#sp_use_amt").html(jsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
					//??????
					var remain_amt = Number(act_sum) - Number(jsum);
			
					$("#sp_remain_amt").html(remain_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				else if(resultData.aaData.budgetControlYN === 'N'){
					//????????????
					$("#sp_acct_code").html(acct_info);
					//????????????
					$("#sp_budget_ym").html(fnFormatStringToDate('yyyy-MM', (budget_ym || '000000')));
					//??????
					$("#sp_remain_amt").html("<%=BizboxAMessage.getMessage("TX000009272","???????????????")%>");
					
				}
				else if(resultData.aaData.budgetControlYN === 'B'){
					//????????????
					$("#sp_acct_code").html(acct_info);
					//????????????
					$("#sp_budget_ym").html(fnFormatStringToDate('yyyy-MM-dd', (budget_ym || '00000000')));
					//??????
					$("#sp_remain_amt").html("<%=BizboxAMessage.getMessage("TX000018832","???????????????")%>");
				}
	    	} else if(resultData.ifSystem === 'ERPiU'){ /* ERPiU */ 
	    		var acct_info = '('+bgacct_code+')'+decodeURI(bgacct_name);
				if(resultData.aaData.budgetControlYN === 'Y'){
					//????????????
					$("#sp_acct_code").html(acct_info);
					//????????????
					$("#sp_budget_ym").html(fnFormatStringToDate('yyyy-MM', (budget_ym || '000000')));
					//???????????????(????????????))
					var act_sum = parseInt(resultData.aaData.budgetActsum);
					$("#sp_total_amt").html(act_sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
					//??????(??????)??????
					var jsum = parseInt(resultData.aaData.budgetJsum) - Number(baseListAmt);
					$("#sp_use_amt").html(jsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
					//??????
					var remain_amt = Number(act_sum) - Number(jsum);
			
					$("#sp_remain_amt").html(remain_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				}
				else if(resultData.aaData.budgetControlYN === 'N'){
					//????????????
					$("#sp_acct_code").html(acct_info);
					//????????????
					$("#sp_budget_ym").html(fnFormatStringToDate('yyyy-MM', (budget_ym || '000000')));
					//??????
					$("#sp_remain_amt").html("<%=BizboxAMessage.getMessage("TX000009272","???????????????")%>");
				}
	    	}
        }
        fnCallAjax(ajaxParam);
	}
	function fnSelfClose(){
		window.open("about:blank", "_self").close();
	}
	
	
</script>
<div class="pop_wrap_dir" id="layerExpendBudget">
	<div class="pop_con div_form scroll_y_on">
		<div class="pop_con div_form">
			<div class="com_ta">
				<table>
					<colgroup>
						<col width="250" />
						<col width="250" />
					</colgroup>
					<tr>
						<th>${CL.ex_budgetAccount}</th>
						<td class="ri"><span id="sp_acct_code" class=""></span></td>
					</tr>
					<tr>
						<th>${CL.ex_budgetMonth}</th>
						<td class="ri"><span id="sp_budget_ym" class=""></span></td>
					</tr>
					<tr>
						<th>${CL.ex_budgetComplitationAmt}</th>
						<td class="ri"><span id="sp_total_amt" class=""></span></td>
					</tr>
					<tr>
						<th>${CL.ex_budgetExcutionAmt}</th>
						<td class="ri"><span id="sp_use_amt" class=""></span></td>
					</tr>
					<tr>
						<th class="fwb">${CL.ex_budgetBalance}</th>
						<td class="ri"><span id="sp_remain_amt" class="fwb"></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="btn_cen pt12">
			<input type="button" onClick="fnSelfClose();" value="${CL.ex_check}" /> <!--??????-->
		</div>
	</div>
</div>