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
 * @title 권한부여관리 화면
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 6. 29.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2015. 6. 04.  송준석        최초 생성
 *
 */
%>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/plugins/jquery.alphanumeric.js'/>"></script>
<script>
$(function(){
												
	//  Short Title Set									
	shoutCutTitleChange('<spring:message code="authorAssign.menu.title" />'/*권한부여관리*/);
	
    $("#tabstrip").kendoTabStrip({
        animation:  {
            open: {
                effects: "fadeIn"
            }
        },
        select : tabSelect
    });
    
    initView("codeType");
    
});


function tabSelect(e) {
	type = $(e.item).attr('id');

    initView(type);						        
}

function initView(tabType) {
	type = tabType;
	
    var url ="/gw/cmm/system/authorAssignManageContent.do";
    
    $.ajax({
        type:"post",
        url:url,
        data:{"viewType":type},
        datatype:"html",            
        success:function(data){
            $("#contentlist").html(data);
        }
    });							        
}

</script>

<form id="listform">							


<div id="tabstrip">
    <ul class="clearfx">
        <li id="codeType" class="k-state-active"><span>코드별</span></li>
        <li id="menuType"><span>메뉴별</span></li>
    </ul>
</div>      							

<div id="contentlist"></div>
								
	<style> 
                #fieldlist
                {
                    margin:0;
                    padding:0;
                } 
                #fieldlist li
                {
                    list-style:none;
                    padding:10px 0;
                }
                #treeview-left,
                #treeview-right
                {
                    float: left;
                    width: 450px;
                    overflow: visible;
                }               
                
	</style>								
								
</form>
