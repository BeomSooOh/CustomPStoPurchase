<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%@ page import="neos.cmm.util.code.CommonCodeSpecific" %>
<%
/**
 * 
 * @title 화면 레이아웃의 Bottom 부분
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 4. 24.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 4. 24.  박기환        최초 생성
 *
 */
%>
<script>
$(function(){
	var linkNm = '${BOT}';
	if(linkNm=='N'){
	    $(".messenger").css("display","none");
	}
var html = getList();
$("#code_td").html(html);


});

getList = function() {
	var list = this.getFamilySiteList();
	var html = "" ;
	var rowNum = 0 ;

	if( list != "" && list != undefined) {
		rowNum = list.length ;
	}

	for(var inx = 0 ; inx < rowNum; inx++) {

		html += "<dt><a href='"+list[inx].url+"' target=\"_blank\">" + list[inx].title +"</a></dt>";
	}
	return html ;
}

getFamilySiteList = function() {
	var list = "" ;
	var data = {};
	
	try {
		var url = "<c:url value='/portal/cfg/familySiteLinkList.do'/>";
        $.ajax({
            type: "POST",
            url: url,
            async: false,
            datatype: "text",
            data: data,
            success: function (data) {
            	list =  data.list;
            },
            error: function (XMLHttpRequest, textStatus) {
            }
        });
    }
    catch (e) {

    }
	return list ;
};

function move_system_menu(){
	$(".treeMenuArea").show();
	search_tree_menu('990000000', '시스템설정');
	
	$(".menuList .active").removeClass("active").show();
	$("#menuArea").css({marginLeft:0}); //메뉴Area를 복원한다.
	$(".btnOpen").hide();				//메뉴가 열렸으므로 열기 버튼을 안보이게 한다.
}

// 바로가기 선택시 이동 
function quickLink(menuId,menuLink){
	var form = document.createElement('form');
	form.name = "move";
	form.method = "post";
	form.action = '<c:url value="/NeosMain.do" />';
	
	var element = document.createElement('input');	
	element.type = 'hidden';
	element.name = 'menu';
	element.value = menuLink;
	form.appendChild(element);
	
	document.body.appendChild(form);
	form.submit();
	document.body.removeChild(form);	
}

function readyMenu(){
	alert('준비중입니다.');
}

/*	조직도 보기	*/
function open_organogram(){
	

		//var rootId = '<spring:message code="neos.organ_id" />';
		
		//window.open('<c:url value="/cmm/system/selectMemberViewPopup.do?rootId='+rootId+'&popupTitle=organogram.title.name" />', "selectMemberView", 'toolbar=no, scrollbar=no, width=290, height=560, resizable=no, status=no');
		window.open('<c:url value="/cmm/system/memberViewPopup.do"/>', "selectMemberView", 'toolbar=no, scrollbar=no, width=750, height=490, resizable=no, status=no');
		
						
													
}

/*		동호회 이동	*/
function club_move()
{
//	새 메뉴이동(패키지) 2013.03.14 박민우
	var arrParam = new Array();
	arrParam[0] = new Param("menuNm", "selectClubList");	
	top.goto_menuDirect(arrParam);
}

</script>

    <!-- footer -->
    <div id="footer" class="clearfx" style="marginBotton:0;">
        <ul class="menuLeft clearfx">
            <li class="setup"><a href="javascript:move_system_menu();">시스템설정</a></li>
            <li class="group"><a href="javascript:open_organogram();">조직도</a></li>
            <li class="messenger"><a href="<spring:message code="Globals.messenger.url" />">메신저 다운로드</a></li>
            <li class="neors"><a href="http://neors.net/Newturns" target="_blank" > 원격지원</a></li>
        </ul>
        <div class="menuRight clearfx">
        	<div class="family"  <c:if test = "${ not empty footerID  }" > style = "margin-top:3px;" </c:if> >
                <p><a href="javascript:;" class="btn_family"><img src="<c:url value='/images/kohi/btn_family.gif'/>" alt="family site" /></a>
                 <span class="mL10" ><img src="<c:url value='/images/logo/footer_logo.jpg'/>"/></span>
                </p>
                <dl class="familyList">
                	<dt class="hide">패밀리사이트</dt>
                	<dt id="code_td"></dt>
					<!-- dd></dd-->
                </dl>
            </div>
<!--             <ul class="footRightMenu"> -->
                               
<%--                 <li class="first quickLink"><a href="<spring:message code="Globals.messenger.url" />">메신저 다운로드</a></li> --%>
                
<!--             </ul> -->
            
        </div>
    </div>
    <!-- //footer -->     
