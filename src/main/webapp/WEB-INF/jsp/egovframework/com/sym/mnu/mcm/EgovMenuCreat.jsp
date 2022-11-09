<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMenuCreat.jsp
  * @Description : 메뉴생성 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.10    이용          최초 생성
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */

  /* Image Path 설정 */
//  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mcm/icon/";
//  String imagePath_button = "/images/egovframework/com/sym/mnu/mcm/button/";
%>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/neos/layout.css' />" />
<script type="text/javascript">
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/egovframework/com/sym/mnu/mcm/EgovMenuCreat.js' />"></script>
<script language="javascript1.2" type="text/javaScript">
<!--
$(function(){
	$("#shoutCutTitle").html('<spring:message code="system.menu.manage.create.menu" />');
});

/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectMenuCreatTmp() {
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 멀티입력 처리 함수
 ******************************************************** */
function fInsertMenuCreat() {
    var checkField = document.menuCreatManageForm.checkField;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {
    	if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + checkField[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = checkField.value;
            }
        }
    }
    if(checkedCount == 0){
		alert("<spring:message code='valid.input.form.checkNone' />");  //선택된 메뉴가 없습니다.
        return false;
    }
    document.menuCreatManageForm.checkedMenuNoForInsert.value=checkMenuNos;
    document.menuCreatManageForm.checkedAuthorForInsert.value=document.menuCreatManageForm.authorCode.value;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatInsert.do'/>";
    document.menuCreatManageForm.submit();
}
/* ********************************************************
 * 메뉴사이트맵 생성 화면 호출
 ******************************************************** */
function fMenuCreatSiteMap() {
	id = document.menuCreatManageForm.authorCode.value;
	window.open("<c:url value='/sym/mnu/mcm/EgovMenuCreatSiteMapSelect.do'/>?authorCode="+id,'Pop_SiteMap','scrollbars=yes, width=550, height=700');
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>

<form name="menuCreatManageForm" action ="<c:url value='/sym/mnu/mcm/EgovMenuCreatSiteMapSelect.do' />" method="post">
<input name="checkedMenuNoForInsert" type="hidden" >
<input name="checkedAuthorForInsert"  type="hidden" >
<input name="req_menuNo" type="hidden" >
<c:forEach var="result1" items="${list_menulist}" varStatus="status" >
	<input type="hidden" name="tmp_menuNmVal" value="${result1.menuNo}|${result1.upperMenuId}|${result1.menuNm}|${result1.progrmFileNm}|${result1.chkYeoBu}|">
</c:forEach>

	<div id="div_btn"></div>
	<script type="text/javascript">
		var msg = ["<spring:message code='system.menu.manage.create.menu' />"/*메뉴생성 */, "<spring:message code='system.menu.manage.create.sitemap' />"/*사이트맵생성 */];
		var fn = ["fInsertMenuCreat()","fMenuCreatSiteMap()"];
		var div_btn = "div_btn";
		NeosUtil.makeButonType02(msg, fn, div_btn);
	</script>							
	
	<div style="height:7px;"></div>	
		
	<div class="table_board2" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<th><spring:message code='system.menu.manage.rule.code' /></th>
				<td><input name="authorCode" type="text" size="30"  maxlength="30" title="<spring:message code='system.menu.manage.rule.code' />" value="${resultVO.authorCode}" readonly></td>
			</tr>	
			<tr>
			<th></th>
			<td>
				<script language="javascript" type="text/javaScript">
				    var chk_Object = true;
				    var chk_browse = "";
					if (eval(document.menuCreatManageForm.authorCode)=="[object]") chk_browse = "IE";
					if (eval(document.menuCreatManageForm.authorCode)=="[object NodeList]") chk_browse = "Fox";
					if (eval(document.menuCreatManageForm.authorCode)=="[object Collection]") chk_browse = "safai";
		
					var Tree = new Array;
					if(chk_browse=="IE"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object]"){
						alert("<spring:message code='system.menu.manage.list.none' />");  //메뉴 목록 데이타가 존재하지 않습니다.
					    chk_Object = false;
					}
					if(chk_browse=="Fox"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object NodeList]"){
						alert("<spring:message code='system.menu.manage.list.none' />");  //메뉴 목록 데이타가 존재하지 않습니다.
					    chk_Object = false;
					}
					if(chk_browse=="safai"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object Collection]"){
						alert("<spring:message code='system.menu.manage.list.none' />");  //메뉴 목록 데이타가 존재하지 않습니다.
						chk_Object = false;
					}
					if( chk_Object ){
						for (var j = 0; j < document.menuCreatManageForm.tmp_menuNmVal.length; j++) {
							Tree[j] = document.menuCreatManageForm.tmp_menuNmVal[j].value;
					    }
					    createTree(Tree);
		            }else{
						alert("<spring:message code='system.menu.manage.sitemap.list.none' />");  //메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.
		                window.close();
		            }
				</script>					
			</td>
			</tr>				
		</table>
	</div>
	<div style="height:12px;"></div>			

</form>

