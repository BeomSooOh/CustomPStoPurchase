<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
/**
 * 
 * @title 메뉴관리 화면
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 5. 23.
 * @version 
 * @dscription 메뉴를 관리 하는 화면
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 5. 23.  박기환        최초 생성
 *
 */
%>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>조직도</title>
	
	<%@ include file="/WEB-INF/jsp/neos/include/IncludeJstree.jsp" %>
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/ccm/zip/EgovZipPopup.js' />" ></script>
	<script>
	$(document).ready(function(){
		
	});
		
	function saveAuthor(){

		var authorCode = $("#authorCode").val();
		var authGroup = getCheckedValue();
		
		//if(!confirm("저장하시겠습니까?")) return ;

		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/system/insertGrpAuth.do" />',
			datatype:"json",
			data:{"authorCode":authorCode, "authGroup":authGroup},
			success:function(data){
				var result = data.result;
				
				if(result == "insert"){		
					//기관을 저장 하였습니다.
					alert('<spring:message code="userAuthor.regist.success.msg" />');
					//grp_tree();
				}else{
					//sql 에러가 발생했습니다! error code: {0}, error msg: {1}
					alert('<spring:message code="fail.common.sql" />');
					//grp_tree();
				}																		 
			}
		});	
	}

	
	//조직도 callback 구현
	function callbackOrgChart(seq, gbnOrg) {
	}	
	
	</script>
</head>

<body>
<input type="hidden" id="authorCode" name="authorCode" value="<%=request.getParameter("authorCode")%>">


<div class="fL">
	<!-- 
    <div class="groupArea" id="orgChartList">
		<div>
 			조직도
		</div>        
        <div class="groupUserArea" style="overflow-y:scroll;">
            <div class="tree_con" id="grp_tree"></div>
        </div>        
    </div>
    -->
	<div id="orgChartList" style="float:left;">
		<jsp:include page='/system/orgChartListChk.do'></jsp:include> 
	
		<div id="div_btn" ></div>
			<script type="text/javascript">
			var msg = ["저장"];
			
			var fn = ["saveAuthor()"];
			var div_btn = "div_btn";
			NeosUtil.makeButonType02(msg, fn, div_btn);																																	
			</script> 	
	</div>    
    
    
   
    
</div>



</body>
<html>
