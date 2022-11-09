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

<div class="fL">

    <div class="groupArea">
        <div class="menuGbn">
            <p>
            	메뉴분류
                <span id="gubun"></span>

            </p>
        </div>

        <div class="demo-section" id="menu_tree" style="overflow-y:scroll;">
            <jsp:include page="/selectTreeMenu.do">
            <jsp:param name="menuGubun" value="MENU001" />
            </jsp:include> 
        </div> 
    </div>
    <div id="div_btn" ></div>
	<script type="text/javascript">
	var msg = ["저장"];
	
	var fn = ["saveAuthor()"];
	var div_btn = "div_btn";
	NeosUtil.makeButonType02(msg, fn, div_btn);	
	</script>
</div>
<input type="hidden" id="chkValue" name="chkValue" value="">																																
<input type="hidden" id="authorCode" name="authorCode" value="<%=request.getParameter("authorCode")%>">
<input type="hidden" id="authorTypeCode" name="authorTypeCode" value="<%=request.getParameter("authorTypeCode")%>">

	<script>

	var menuGubun ="";
	var treeViewLeft= null;
	
	$(document).ready(function(){

        var tempHtml = NeosCodeUtil.getCodeSelectFirstName("MENU", "menuGubun", "", "width:100px;" ,"sel_gubun()","","") ;
        $("#gubun").html(tempHtml);	 		
		
  
	});

 	function sel_gubun(){
 		menuGubun = $("#menuGubun").val(); 		
 		var authorCode = $("#authorCode").val();
 		
 		$.ajax({
	        type:"post",
	        url:'<c:url value="/selectTreeMenu.do" />',
	        data:{"authorCode":authorCode, "menuGubun":menuGubun},
	        datatype:"html",            
	        success:function(data){
	            $("#menu_tree").html(data);
	        }
	    });	  		 		
	} 	

	function saveAuthor(){
		

		var authorCode = $("#authorCode").val();
		var chkVal = getCheckedValue();
		var menuGubun = $("#menuGubun").val();
		
		//if(!confirm("저장하시겠습니까?")) return ;

		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/system/insertAuthorMenu.do" />',
			datatype:"json",
			data:{"authorCode":authorCode, "chkVal":chkVal, "menuGubun":menuGubun},
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

    // show checked node IDs on datasource change
    function onCheck() {
        var checkedNodes = [],
            treeView = $("#menu_tree").data("kendoTreeView"),
            message;

        checkedNodeIds(treeView.dataSource.view(), checkedNodes);

        $("#chkValue").val(checkedNodes.join(","));
    }	

    // function that gathers IDs of checked nodes
    function checkedNodeIds(nodes, checkedNodes) {
        for (var i = 0; i < nodes.length; i++) {
            if (nodes[i].checked) {
                checkedNodes.push(nodes[i].menu_no);
            }

            if (nodes[i].hasChildren) {
                checkedNodeIds(nodes[i].children.view(), checkedNodes);
            }
        }
    }	
	
	</script>
            <style>
                .demo-section {
                    display: inline-block;
                    vertical-align: top;
                    width: 280px;
                    height:300px;
                    text-align: left;
                    margin: 0 2em;
                    float:left;
                }
                
                .fLeft {
                	float:left;
                }
            </style>