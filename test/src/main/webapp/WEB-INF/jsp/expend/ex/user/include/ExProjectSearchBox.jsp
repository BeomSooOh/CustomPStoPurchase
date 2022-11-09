<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--  프로젝트 도움창 검색박스 -->
<div class="top_box">
	<dl>
		<!-- iCUBE일때만 노출 -->
		<c:if test="${ifSystem == 'iCUBE'}">
			<dt>${CL.ex_category} <!--구분--></dt>
			<dd class ="mr0" style="width: 60px;">
				<select id="selProjectStatus" class="selectmenu" style="width: 65px;">
					<option value="USE">${CL.ex_use} <!--사용--></option>
					<option value="ING">${CL.ex_onGoing} <!--진행중--></option>
					<option value="DONE">${CL.ex_completion} <!--완료--></option>
				</select>
			</dd>
		</c:if>
		<dt>${CL.ex_keyWord}</dt> <!--검색어-->
		<dd>
			<div class="posi_re">
				<input id="cmmTxtSearchStr" type="text" style="width: 150px;ime-mode:active" value=""/>
				<a id="btn_removeFilter" href="#n" style="display:none;position:absolute;right:4px; top:2px;" onClick="javascript:fnClearFilter();">
					<img src="<c:url value="/Images/ico/ico_sear_clo.png"/>"  width="20" height="20"/>
				</a>
			</div>
		</dd>
		<dd class="mr10">
			<input type="button" id="btnSearch" value="${CL.ex_search}" /> <!--검색-->
		</dd>
	</dl>	
</div>
