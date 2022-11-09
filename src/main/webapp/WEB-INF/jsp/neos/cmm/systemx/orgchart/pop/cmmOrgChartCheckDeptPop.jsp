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
 * @title 기관/부서 선택 팝업
 * @version
 * @dscription
 */
%>	
<script>
$(document).ready(function(){
		
	$("#inp_chk").click(function(){
        if($("#inp_chk").prop("checked")){
            $("input[name=department]").prop("checked",true);
        }else{
            $("input[name=department]").prop("checked",false);
        }
    })
});
    /**
     *   트리 검색
     */
     function keywordSearch(){
         var treeSearch = $("#searchKeyword").val();
         
         if(treeSearch !== "") {
             $("#treeview .k-group .k-group .k-in").closest("li").hide();
             $("#treeview .k-group .k-group .k-in:contains(" + treeSearch + ")").each(function() {
                 $(this).parents("ul, li").each(function () {
                     $(this).show();
                 });
             });
         } else {
             $("#treeview .k-group").find("ul").show();
             $("#treeview .k-group").find("li").show();
             
         }                                     
     }
    
    //콜백 함수 호출      
    function callbackOrgChart(data) { 
   	 
   	 $("#btnConfirm").click(function () {
       	 opener.callBackDeptItems(data);  
		 window.close();   		 
   	 })
    }   
       
	
	var strOrgList = "${param.deptOrgList}";
    var strSeqList = "${param.deptSeqList}";
    var strNmList = "${param.deptNmList}";
    
    var tempOrgList = new Array();
	var tempSeqList = new Array();
	var tempNmList = new Array();
	
 	function setChecked(e){
 		
        var item = e.sender.dataItem(e.node);
        var seq = item.seq;
        var gbn = item.gbn;
        var name = item.name;
        
        var tree = $("#treeview").data("kendoTreeView");
        
        var cb = tree.findByUid(item.uid);
		tree.dataItem(cb).set("checked", false);
		
        if(strOrgList != null && strOrgList.length > 0)
        {
        	
        	tempOrgList = strOrgList.split(',');
        	tempSeqList = strSeqList.split(',');
        	tempNmList = strNmList.split(',');
        	
        	for(var i=0; i<tempSeqList.length; i++)
        	{
        		if (seq == tempSeqList[i] && gbn == tempOrgList[i] ) {
//         			var cb = e.node.find(".k-checkbox input");
//         			if (cb) {
//          				//$(cb.selector).prop('checked', true);
//         				$(cb).prop('checked', true);
//         			}
        			tree.dataItem(cb).set("checked", true);
        		}        		
        	}
        }
        else{
        	for(var i=0; i<tempSeqList.length; i++)
        	{    
        		if (seq == tempSeqList[i] && gbn == tempOrgList[i] ) {
//         			var cb = e.node.find(".k-checkbox input");
//         			if (cb) {
//          				//$(cb.selector).prop('checked', true);
//         				$(cb).prop('checked', true);
//         			}
        			tree.dataItem(cb).set("checked", true);
        		}
        	}
        }
	}
 	

    
 	function fnConfirm() {
 		var chkValue = $("#chkValue").val();
 	    var chkNm = $("#chkNm").val();
 	    var chkGbn = $("#chkGbn").val();
 	    opener.callBackOrgChartCheck(chkValue, chkNm, chkGbn);
 	    window.close();
	}
 	

    function onSelect(e) {
    	var item = e.sender.dataItem(e.node);
       	var seq = item.seq;
       	var gbnOrg = item.gbn;
       	console.log("DataBound", seq +  " : " + gbnOrg);
       	callbackOrgChart(seq, gbnOrg);	// 반드시 구현
       	
       	
       	
    }

    // show checked node IDs on datasource change
    
    function onCheck() {
    	var treeView = $("#treeview").data("kendoTreeView"), message;
    	var checkedNodes = [], checkedNodesNm = [], checkedNodesGbn = [];
    	//var checkedParentValeu = [], checkedParentNm = [], checkedParentValeu =[];
        checkedNodeIds(treeView.dataSource.view(), checkedNodes, checkedNodesNm, checkedNodesGbn);
        
        $("#chkValue").val(checkedNodes.join(","));
        $("#chkNm").val(checkedNodesNm.join(","));
        $("#chkGbn").val(checkedNodesGbn.join(",")); 
        //callbackOrgChart(seq, gbnOrg); //
        var nm = $("#chkNm").val();
        //alert("체크:"+nm);
        checkedNodeGrid();
        
    }	

    // function that gathers IDs of checked nodes
    function checkedNodeIds(nodes, checkedNodes, checkedNodesNm, checkedNodesGbn) {
    	for (var i = 0; i < nodes.length; i++) {
    		if (nodes[i].checked == true){
                checkedNodes.push(nodes[i].seq);
                checkedNodesNm.push(nodes[i].name);
                checkedNodesGbn.push(nodes[i].gbn);
            } else {
            	 if (nodes[i].hasChildren) {
                     checkedNodeIds(nodes[i].children.view(), checkedNodes, checkedNodesNm, checkedNodesGbn);
                 }
            }
    		if(i == nodes.length-1 && nodes[i].hasChildren == ""){
    			checkedNodeGrid();
    		}
        }
    }
    
    function checkedNodeGrid(){
    	
    	//$("#selectDept > tr:not(:first)").remove();
    	$("#selectDept > tbody").remove();
    	
    	var deptSeq = $("#chkValue").val();
        var deptNm = $("#chkNm").val();
        var deptOrg = $("#chkGbn").val(); 
        var tempOrgList = new Array();
		var tempSeqList = new Array();
		var tempNmList = new Array();
		
		tempOrgList = deptOrg.split(',');
    	tempSeqList = deptSeq.split(',');
    	tempNmList = deptNm.split(',');
    	var org = '';
    	if(deptSeq != ""){
    		for(var i=0; i<tempSeqList.length; i++){
        		org += '<tr class="'+tempSeqList[i]+'" name="'+tempSeqList[i]+'">';
                org += '<td>';
                org += '<input type="checkbox" name="department" class="k-checkbox" value="'+tempOrgList[i]+'" id="'+tempSeqList[i]+'"/><label class="k-checkbox-label" for="'+tempSeqList[i]+'" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;">';
                org += '</td>';
                org += '<td>';
                org += '<input type="hidden" class="le" id="orgName" name="orgName" value="'+tempNmList[i]+'">'+tempNmList[i];
                org += '</td>';
                org += '</tr>';
        	}
    		$("#selectLen").html('('+tempSeqList.length+')');
            
            $("#selectDept").append(org);
    	}
    	
    }
    
    function deleteOrganSelect(){
    	
     	$("#treeview").data("kendoTreeView").expand(".k-item"); //삭제 전 모든 노드 확장.
    	
        tempOrgList = new Array(); //삭제안 할 부서 Org
    	tempSeqList = new Array(); //삭제안 할 부서 Seq
    	tempNmList = new Array(); //삭제안 할 부서 Name
    	
    	delDeptList = new Array(); //삭제할 부서 리스트
    	
		strOrgList = "";
	    strSeqList = "";
	    strNmList = "";
	    
		var arrChkBox = document.getElementsByName("department");
		var arrChkNm = document.getElementsByName("orgName");
		var idx = 0;
		var chkIdx = 0;
		
		for(var i=0; arrChkBox != null , i<arrChkBox.length; i++)
		{   
			if(arrChkBox[i].checked == true)
			{
				delDeptList[chkIdx] = arrChkBox[i].value + arrChkBox[i].id;
				chkIdx++;
			}else{
				tempSeqList[idx] = arrChkBox[i].id;
				tempOrgList[idx] = arrChkBox[i].value;
				tempNmList[idx] = arrChkNm[i].value;
				
				idx++;
			}
			
		}
        
	 	/* if(chkIdx > 0){

		}
		if(idx == 0){
			$("#treeview .k-checkbox input").prop("checked", false).trigger("change");
		}
 		*/		
		var treeView = $("#treeview").data("kendoTreeView").dataSource.view();
		
		delNodeSync(treeView, delDeptList);
    	inline.sync();
		
		onCheck();
        
		document.getElementById('inp_chk').checked = false; 
		$("#selectLen").html('('+tempSeqList.length+')');
    }
    
    //treeView의 dataSource와 Sync
    function delNodeSync(nodes, obj) {
    	for (var i = 0; i < nodes.length; i++) {
    		
    		for(var j=0;j<obj.length;j++){
    			var deptGbn = obj[j].substring(0,1);
    			var deptSeq = obj[j].substring(1);
    			if(nodes[i].seq == deptSeq && nodes[i].gbn == deptGbn){
    				nodes[i].checked = 'false';
    			}
    			
    			if(nodes[i].hasChildren){
    				delNodeSync(nodes[i].children.view(), obj);
    			}
    		}
        }
    }
       
    	   
       
	</script>

	<input type="hidden" id="selectItems" value="">
<body>
<div class="pop_wrap organ_wrap" style="height: width:670px;">
    <div class="pop_head">
		<h1>회사/부서 선택</h1>
		<a href="javascript:window.close();" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo01.png'/>" alt="" /></a>
	</div>
	
    <div class="pop_con">
		<div class="box_left" style="width:270px;">
            <p class="borderB" style="height:24px; padding:15px;">
                <input class="k-textbox input_search" id="searchKeyword" type="text" value="" style="width:184px;" placeholder="조직검색"  onKeyDown="javascript:if (event.keyCode == 13) { keywordSearch(); }">
                <a href="javascript:keywordSearch();" class="btn_search"></a>
            </p>
                                            
            <div id="treeview" class="tree_icon" style="height:417px;">
                <%-- <jsp:include page='/systemx/include/orgChartListChkBox.do?compSeq=59'></jsp:include> --%>
                <jsp:include page='/systemx/include/orgChartListChkBox.do?compSeq=${params.compSeq }'></jsp:include>
            </div>
        </div>
        
		<div class="box_right2" style="width:330px;">
	        	<div class="option_top">
					<ul>
						<li>선택된 부서 목록<span id="selectLen"></span></li>
					</ul>
					
					<div id="" class="controll_btn" style="padding:0px;float:right; ">
						<button id="" onclick="deleteOrganSelect();">삭제</button>
					</div>
				</div>
				
				<div class="com_ta2">
					<table>
						<colgroup>
							<col width="35"/>
							<col width="205"/>
							<col />
						</colgroup>
						<tr>
							<th>
								<input type="checkbox" name="inp_chk" id="inp_chk" class="k-checkbox">
								<label class="k-checkbox-label" for="inp_chk" style="padding:0.2em 0 0 10px;"></label>
							</th>
							<th class="">부서명</th>
						</tr>
					</table>
				</div>
				
				<div class="com_ta2 ova_sc"style="height:387px;margin-top:0px;">
					<table id="selectDept">
						<colgroup>
							<col width="35"/>
							<col width="205"/>
							<col />
						</colgroup>
						<tbody></tbody>
					</table>
				</div>
	        </div>
   		</div>
	    <div class="pop_foot">
	        <div class="btn_cen pt12">
	            <input type="button" id="btnConfirm" onclick="fnConfirm();"  value="확인" />
	            <input type="button" onclick="javascript:window.close();" class="gray_btn" value="취소" />
	        </div>
	    </div><!-- //pop_foot -->
	</div>
</body>