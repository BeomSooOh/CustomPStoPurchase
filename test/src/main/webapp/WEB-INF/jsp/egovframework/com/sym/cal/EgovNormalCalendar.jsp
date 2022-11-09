<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
 /**
  * @Class Name  : EgovNormalCalendar.jsp
  * @Description : EgovNormalCalendar 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *
  */
%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="ko">
<head>
<title>일반달력</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/sym/cal/cal.css' />" />
<script type="text/javaScript" language="javascript">
<!--

/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
	var varParam        = window.dialogArguments;
	//var varForm			= document.all["Form"];
	var varForm			= document.getElementsByName("Form")[0];
	var pForm			= parent.document.all["pForm"];
	if (varParam.sDate) {
		var sDate = varParam.sDate;
		if(sDate.length == 10) {
			if(pForm.init.value != "OK") {
				pForm.init.value  = "OK";
				varForm.action      = "<c:url value='/sym/cal/EgovselectNormalCalendar.do'/>";
				varForm.year.value  = sDate.substr(0,4);
				varForm.month.value = sDate.substr(5,2);
				varForm.submit();
			}
		}
	}
}

/* ********************************************************
 * 연월변경
 ******************************************************** */
function fnChangeCalendar(year, month){
	//var varForm			= document.all["Form"];
	var varForm			=  document.getElementsByName("Form")[0];
	varForm.action      = "<c:url value='/sym/cal/EgovselectNormalCalendar.do'/>";
	varForm.year.value  = year;
	varForm.month.value = month;
	varForm.submit();
}

/* ********************************************************
 * 결과연월일 반환
 ******************************************************** */
function fnReturnDay(day){
	var retVal   = new Object();
	var sYear    = "0000"+document.Form.year.value;
	var sMonth   = "00"+document.Form.month.value;
	var sDay     = "00"+day;
	retVal.year  = sYear.substr(sYear.length-4,4);
	retVal.month = sMonth.substr(sMonth.length-2,2);
	retVal.day   = sDay.substr(sDay.length-2,2);
	retVal.sDate = retVal.year + retVal.month + retVal.day;
	retVal.vDate = retVal.year + "-" + retVal.month + "-" + retVal.day;
	parent.window.returnValue = retVal;
	parent.window.close();
}
-->
</script>
</head>
<body topmargin="0" leftmargin="0">
<form name="Form" action ="<c:url value='/sym/cal/EgovselectNormalCalendar.do'/>" method="post">
<input type="hidden" name="init" value="${init}" />
<input type="hidden" name="year" value="${resultList[0].year}" />
<input type="hidden" name="month" value="${resultList[0].month}" />
<input type="hidden" name="day" />
<div class="popupWarp">
    <div class="popHead clearfx">
        <h1>휴일선택</h1>
        <a href="javascript:window.close();" class="close"><img src="<c:url value='/images/popup/btn_close.gif'/>" width="60" height="27" alt="닫기" /></a>
    </div>
    
    <div class="popContents clearfx">
       <div class="select_sign" >
	      <table width="100%" class="defaultTable longTable">
	       <col width="40" />
            <col width="40" />
            <col width="" />
            <col width="40" />
            <col width="40" />
	  <tr>
	    <th >
	    	<a href="javascript:fnChangeCalendar(${resultList[0].year-1},${resultList[0].month});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="<c:url value='/images/index/btn_Date_prev.gif' />" alt="이전년도"></a>
	    </th>
	    <th>
	    	<a href="javascript:fnChangeCalendar(${resultList[0].year},${resultList[0].month-1});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="<c:url value='/images/common/ico_pagePrev.gif' />" alt="이전달"></a>
	    </th>
	    <th  width=""  colspan=3><strong>${resultList[0].year}년${resultList[0].month}월</strong></th>
	    <th>
	    	<a href="javascript:fnChangeCalendar(${resultList[0].year},${resultList[0].month+1});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="<c:url value='/images/common/ico_pageNext.gif' />" alt="다음달"></a>
	    </th>
	    <th>
	    	<a href="javascript:fnChangeCalendar(${resultList[0].year+1},${resultList[0].month});"  style="selector-dummy:expression(this.hideFocus=false);cursor:pointer;cursor:hand;"><img src="<c:url value='/images/index/btn_Date_next.gif' />" alt="다음년도"></a>
	    </th>
	  </tr>
	  </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="signTable_th">
	  <tr>
        <td width="36" nowrap>일</td>
        <td width="36" nowrap>월</td>
        <td width="36" nowrap>화</td>
        <td width="36" nowrap>수</td>
        <td width="36" nowrap>목</td>
        <td width="36" nowrap>금</td>
        <td width="36" nowrap>토</td>
      </tr>
	  </table>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="signTable_td">

		<tr>
	 		<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:choose>
				<c:when test='${result.day == ""}'>
			 		<c:choose>
			 		<c:when test='${result.weeks != 6}'>
						<td></td>
					</c:when>
					</c:choose>
				</c:when>
				<c:otherwise>
			 		<c:choose>
			 		<c:when test='${result.restAt == "Y" }'>
					    <td class="lt_text3" nowrap STYLE="color:red;cursor:pointer;cursor:hand" onClick="javascript:fnReturnDay(${result.day});">
					    	${result.day}
					    </td>
					</c:when>
					<c:otherwise>
					    <td class="lt_text3" nowrap STYLE="color:black;cursor:pointer;cursor:hand" onClick="javascript:fnReturnDay(${result.day});">
					    	${result.day}
					    </td>
					</c:otherwise>
					</c:choose>
			 		<c:choose>
			 		<c:when test='${result.week == 7}'>
					    <c:out value="</tr>" escapeXml="false"/>
					    <c:out value="<tr>" escapeXml="false"/>
					</c:when>
					</c:choose>
				</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
	</table>
	   </div>
    </div>
</div>
</form>
</body>
</html>
