<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page
	import="egovframework.com.cmm.service.EgovProperties,egovframework.com.cmm.EgovMessageSource"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%
	/**
	 * 
	 * @title 프로그램 목록 관리 View
	 * @author 공공사업부 포털개발팀 박기환
	 * @since 2012. 8. 3.
	 * @version 1.0
	 * @dscription 
	 * 
	 *
	 * << 개정이력(Modification Information) >>
	 *  수정일                수정자        수정내용  
	 * -----------  -------  --------------------------------
	 * 2012. 8. 3.  박기환        최초 생성
	 *
	 */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>로그인로그현황</title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/util/jquery.urlParam.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/plugins/jquery.alphanumeric.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function() {

		/*  var pickerOpts = {
		            buttonImageOnly : false,
		            buttonText      : '<spring:message code="search.dateSelect" />',
		            changeMonth     : true,
		            changeYear      : true,
		            duration        : 'normal',
		            onSelect        : function(dateText, inst)
		            {
		                var id = $(inst).attr('id');
		            }
		        };

		    $('#searchBgnDeView').datepicker(pickerOpts);
		    //$('#searchBgnDeView').val('${schFromDate}');
		    $('#schFromDateImg').css('cursor','pointer').click(function(){
		        $('#searchBgnDeView').trigger('focus');
		    });

		    $('#searchEndDeView').datepicker(pickerOpts);
		    //$('#searchEndDeView').val('${schToDate}');
		    $('#schToDateImg').css('cursor','pointer').click(function(){
		        $('#searchEndDeView').trigger('focus');
		    }); */
		
		    shoutCutTitleChange('${menu_nm}'); /* 타이틀 변경 함수 */
		setStartDatePicker();
		setEndDatePicker();
		selectedText("searchWrd", "${searchWrd}");
	});

	/* 달력초기화 start */
	function setStartDatePicker() {
		var pickerOpts = {
			showOn : 'button',
			buttonImage : "<c:url value='/images/popup/btn_callender.gif' />",
			buttonImageOnly : false,
			changeMonth : true,
			changeYear : true,
			buttonText : "<spring:message code='search.dateSelect' />",
			duration : "normal",
			onSelect : function(dateText, inst) {
				var id = $(inst).attr("id");
			}
		};

		$("input[name=searchEndDe]").datepicker(pickerOpts);
		$(".ui-datepicker-trigger img").attr("align", "absmiddle");
	}

	/* 달력초기화 end */
	function setEndDatePicker() {
		var pickerOpts = {
			showOn : 'button',
			buttonImage : "<c:url value='/images/popup/btn_callender.gif' />",
			buttonImageOnly : false,
			changeMonth : true,
			changeYear : true,
			buttonText : "<spring:message code='search.dateSelect' />",
			duration : "normal",
			onSelect : function(dateText, inst) {
				var id = $(inst).attr("id");
			}
		};

		$("input[name=searchBgnDe]").datepicker(pickerOpts);
		$(".ui-datepicker-trigger img").attr("align", "absmiddle");
	}

	function fn_egov_select_loginLog(pageNo) {
		var fromDate = document.frm.searchBgnDe.value;
		var toDate = document.frm.searchEndDe.value;

		if (fromDate > toDate) {
			alert("종료일자는 시작일자보다  이후날짜로 선택하세요.");
			//return false;
		} else {
			document.frm.pageIndex.value = pageNo;
			document.frm.action = "<c:url value='/sym/log/clg/SelectLoginLogList.do'/>";
			document.frm.submit();
		}
	}
	
	/* 셀렉트박스 해당 값 선택 */
    function selectedText (select, string) {

        $("#"+select+" > option").each(function () {

            if($(this).text()==string)

        $(this).attr("selected", "true");

        });
	}

	function fn_egov_inqire_loginLog(logId) {
		var url = "<c:url value='/sym/log/clg/InqireLoginLog.do' />?logId="
				+ logId;

		var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=750,height=240,left=0,top=0";
		window.open(url, "p_loginLogInqire", openParam);
	}
</script>
<body>
<form name="frm"
	action="<c:url value='/sym/log/clg/SelectLoginLogList.do'/>"
	method="post">
	<div class="searchArea clearfx" id="" >
		<span class="mR10"> 기간 <input name="searchBgnDe" type="text" style="width: 75px;"
					value="<c:out value='${searchVO.searchBgnDe}'/>"> ~ &nbsp;
					<input name="searchEndDe" type="text" style="width: 75px;"
					value="<c:out value='${searchVO.searchEndDe}'/>"></td>
		</span>
		<span class="mR10"> 사용자명 <input name="loginNm" type="text" size="15"   value="<c:out value='${searchVO.loginNm}'/>" maxlength="15"  title=C"검색단어입력"> </span>
		<span>구분  <select name="searchWrd" id="searchWrd" style="width: 100px;">
                            <option value="<c:out value=""/>" selected="selected">전체</option>
                            <option value="LOGI" <c:if test="${searchVO.searchWrd == 'LOGI'}">selected</c:if> >로그인</option>
                            <option value="LOGO" <c:if test="${searchVO.searchWrd == 'LOGO'}">selected</c:if> >로그아웃</option>
                    </select> &nbsp;&nbsp;
         </span>
		 <a href="javascript:fn_egov_select_loginLog('1');"><img src="<c:url value='/images/btn/btn_search.gif' />" alt="검색" width="55" height="26" /> </a>
	</div>

	<div class="board_table mT25" style="" id="board_table">
		<table id="list" width="100%" cellpadding="0" cellspacing="0" class="mT5 defaultTable ">
			<thead>
				<tr>
					<!-- th class="title" width="3%" nowrap><input type="checkbox" name="all_check" class="check2"></th-->
					<th class="title" width="5%" nowrap="nowrap">번호</th>
					<th class="title" width="18%" nowrap="nowrap">사용자ID</th>
					<th class="title" width="18%" nowrap="nowrap">요청자</th>
					<th class="title" width="18%" nowrap="nowrap">요청자IP</th>
					<th class="title" width="18%" nowrap="nowrap">로그유형</th>
					<th class="title"  width="23%" >로그인(로그아웃)시간</th>
				</tr>
			</thead>
			<tbody>
				<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td align="center" colspan="7"><spring:message
								code="common.nodata.msg" />
						</td>
					</tr>
				</c:if>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<!--td class="lt_text3" nowrap><input type="checkbox" name="check1" class="check2"></td-->
						<td align="center"><c:out
								value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}" />
						</td>
						<td align="center"><c:out value="${result.userId}" /></td>
						<td align="center"><c:out value="${result.loginNm}" /></td>
						<td align="center"><c:out value="${result.loginIp}" /></td>
						<td align="center"><c:out value="${result.loginMthd}" /></td>
						<td align="center"><c:out value="${result.creatDt}" />
						</td>
					</tr>
				</c:forEach>

			</tbody>
			<!--tfoot>
      <tr class="">
       <td colspan=6 align="center"></td>
      </tr>
     </tfoot -->
		</table>
	</div>
	<div style="height: 12px;"></div>

	<div align="center" class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="image"
			jsFunction="fn_egov_select_loginLog" />
	</div>

	<input name="pageIndex" type="hidden"
		value="<c:out value='${searchVO.pageIndex}'/>" />

</form>
</body>
</head>
</html>
