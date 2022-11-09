<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
	var budget_actsum =${budget_param.budget_actsum}; // 편성금액
	var budget_jsum =${budget_param.budget_jsum}; // 사용금액
	var req_amt = ${budget_param.req_amt}; //결의금액
	
	

	$(document).ready(function() {
		fnBudgetOver();
	});

	/* 예산확인 로직 수행 */
	function fnBudgetOver() {
		var remain_amt =  Number(budget_actsum) - Number(budget_jsum);
		var over_amt =  Number(budget_actsum) - (Number(budget_jsum) + Number(req_amt));
		$("#sp_remain_amt").html(remain_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$("#sp_req_amt").html(req_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$("#sp_over_amt").html(over_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}
	function fnSelfClose(){
		window.open("about:blank", "_self").close();
	}
</script>
<div class="pop_wrap_dir" id="layerExpendBudgetOver">
	<div class="pop_con div_form scroll_y_on">
			<div class="pop_con div_form">
				<div class="com_ta">
					<table>
						<colgroup>
							<col width="300"/>
							<col width="300"/>
						</colgroup>
						<tr>
							<th>${CL.ex_budgetBalance}</th>
							<td><span id="sp_remain_amt" class=""></span></td>
						</tr>
						<tr>
							<th>${CL.ex_amtOfResolution}</th>
							<td><span id="sp_req_amt" class="text_blue"></span></td>
						</tr>
						<tr>
							<th>${CL.ex_budgetOver}</th>
							<td><span id="sp_over_amt" class="text_red"></span></td>
						</tr>				
					</table>
				<div class="ac mt20 lh18">신청금액이 <span class="fwb">예산을 초과</span>하였습니다.<br/>다시 확인하시기 바랍니다.</div>
				</div>
		</div>
		<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" onClick="fnSelfClose();" value="확인" />
		</div>
	</div>
	</div>
</div>