<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExAmtCommon.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEx.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.format.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.list.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.pop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.valid.js"></c:url>'></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">

/* 문서로드 */
$(document).ready(function() {
	fnGetiCUBEBudgetInfo();
	return;
});

function fnGetiCUBEBudgetInfo(){
// 	var param = {};
// 	param.budget_code = '';
// 	param.amt = '';
// 	param.budget_ym = '';
// 	param.acct_code = '';
// 	param.drctr_gbn = '';
	
	$.ajax({
		type : 'post',
		url : '<c:url value="/ex/user/expend/iCUBEBudgetChk.do" />',
		datatype : 'json',
		async : true,
		data : '${ViewBag}',
		success : function(data) {
			console.log(data);
		},
		error : function(data) {
			alert("<%=BizboxAMessage.getMessage("TX000012041","알수없는 오류가 발생하였습니다")%>");
		}
	});
}
</script>
<body>
<div id = "divBudget">
	<label>${CL.ex_budgetInfo2} <!--예산정보--></label>
	<label>${CL.ex_budgetInfo2} <!--예산정보--></label>
	<label>${CL.ex_budgetInfo2} <!--예산정보--></label>
	<label>${CL.ex_budgetInfo2} <!--예산정보--></label>
	<label>${CL.ex_budgetInfo2} <!--예산정보--></label>
	<label>${CL.ex_budgetInfo2} <!--예산정보--></label>
</div>
</body>
</html>
