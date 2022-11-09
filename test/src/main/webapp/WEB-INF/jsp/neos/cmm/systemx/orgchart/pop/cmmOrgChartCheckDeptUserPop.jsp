<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script type="text/javascript">
	
 var idx = 0;	// row 복제후 id값 변경을 위해 인덱스 선언
 var strOrgList = "${param.selOrgTypeList}";
 var strSeqList = "${param.selOrgSeqList}";
 var strNmList = "${param.selOrgNmList}"; 
 var strEmpDeptList = "${param.selOrgEmpDeptList}";    

 var tempOrgList = new Array();
 var tempSeqList = new Array();
 var tempNmList = new Array();
 var tempEmpDeptList = new Array();
	
$(document).ready(function() {	
	
	$('#btnText').focus();
	
	//기본버튼
       $(".controll_btn button").kendoButton();
	
	//검색
	$(".btn_search").click(function(e){
		searchKeyword();
		
	});

	$('#btnText').on('keypress', function(e) {
		if (e.which == 13) {
			searchKeyword();
		}
	}); 

	//조직도검색 셀렉트
	$("#organ_sel").kendoComboBox({
		dataTextField: "text",
              dataValueField: "value",
		dataSource : [
			        {text:"전체", value:"0"}, 
			        {text:"이름", value:"1"},
			        {text:"아이디", value:"2"}
		],
		index: 0
	});
	
	if (strEmpDeptList != null && strEmpDeptList.length > 0 ){
		

    	tempOrgList = strOrgList.split(',');
    	tempSeqList = strSeqList.split(',');
    	tempNmList = strNmList.split(',');
    	tempEmpDeptList = strEmpDeptList.split(',');
		
    	var nodes = new Array();
    	
		for(var i=0; i<tempEmpDeptList.length; i++)
    	{
    		var obj = {};
    		obj.empSeq = tempSeqList[i];
    		obj.deptSeq = tempEmpDeptList[i];
    		
    		nodes.push(obj);
    	}
		
		setTreeViewSelect(nodes);
		
		
		
	}
	
	
	
	
	/* $("#empListChkAll").click(function(e){
		 var ischeck = $(this).is(':checked');
		 var arr = $("#empListTable").find(".empchk");
		 if (arr.length > 0) {
			for(var i = 0; i < arr.length; i++) {
				$(arr[i]).prop("checked", ischeck);			// 프로퍼티를 변경해야 이벤트가 정상적으로 동작
				if (ischeck == true) {
					selectEmp(arr[i]);
				} 
			} 
		 }
	});  */ 
	
	$("#selEmpListChkAll").click(function(e){ 
		 var ischeck = $(this).is(':checked');  
		 var arr = $("#selListTable").find(".selempchk");
		 if (arr.length > 0) {
			for(var i = 0; i < arr.length; i++) {
				$(arr[i]).prop("checked", ischeck); 		// 프로퍼티를 변경해야 이벤트가 정상적으로 동작
			}
		 }
	});	 
});  

function fnConfirm() {
		var chkValue = $("#chkValue").val();
	    var chkNm = $("#chkNm").val();
	    var chkGbn = $("#chkGbn").val();
	    opener.callBackOrgChartCheck(chkValue, chkNm, chkGbn);
	    window.close();
}
		
// 선택된 사원 목록 총개 갱신
function setCount() {
			
	var rowCount = $('#selListTable tr').length;
			
	$("#selectEmpCount").html("("+rowCount+")");
}

function onCheck() {
	
	var treeView = $("#orgTreeView").data("kendoTreeView"), message;
	var checkedNodes = [], checkedNodesNm = [], checkedNodesGbn = [], checkedNodesDeptNm = [],checkedNodesDutyCodeNm = [],checkedNodesCompNm = [];
	
    checkedNodeIds(treeView.dataSource.view(), checkedNodes, checkedNodesNm, checkedNodesGbn, checkedNodesDeptNm, checkedNodesDutyCodeNm, checkedNodesCompNm );
    
    $("#chkValue").val(checkedNodes.join(","));
    $("#chkNm").val(checkedNodesNm.join(","));
    $("#chkGbn").val(checkedNodesGbn.join(",")); 
    $("#chkDeptNm").val(checkedNodesDeptNm.join(",")); 
    $("#chkDuteCodeNm").val(checkedNodesDutyCodeNm.join(",")); 
    $("#chkCompNm").val(checkedNodesCompNm.join(",")); 
    //callbackOrgChart(seq, gbnOrg); //
    checkedNodeGrid();
    
}	

// function that gathers IDs of checked nodes
function checkedNodeIds(nodes, checkedNodes, checkedNodesNm, checkedNodesGbn, checkedNodesDeptNm, checkedNodesDutyCodeNm, checkedNodesCompNm) {
	for (var i = 0; i < nodes.length; i++) {
		if (nodes[i].checked) {
            checkedNodes.push(nodes[i].seq);
            checkedNodesNm.push(nodes[i].name);
            checkedNodesGbn.push(nodes[i].gbn);
            checkedNodesDeptNm.push(nodes[i].deptName);
            checkedNodesDutyCodeNm.push(nodes[i].dutyCodeName);
            checkedNodesCompNm.push(nodes[i].compName);
        } else {
        	 if (nodes[i].hasChildren) {
                 checkedNodeIds(nodes[i].children.view(), checkedNodes, checkedNodesNm, checkedNodesGbn, checkedNodesDeptNm, checkedNodesDutyCodeNm, checkedNodesCompNm);
             }
        }
		if(i == nodes.length-1 && nodes[i].hasChildren == ""){
			checkedNodeGrid();
		}
    }
}

function checkedNodeGrid(){
	//$("#selectDept > tr:not(:first)").remove();
	$("#selListTable > tbody").remove();
	
	var seq = $("#chkValue").val();
    var name = $("#chkNm").val();
    var gbn = $("#chkGbn").val(); 
    var detpNm = $("#chkDeptNm").val();
    var dutyCodeNm = $("#chkDuteCodeNm").val(); 
    var compNm = $("#chkCompNm").val(); 
    
    var tempGbnList = new Array();
	var tempSeqList = new Array();
	var tempNmList = new Array();
	var tempDeptNmList = new Array();
	var tempDutyCodeList = new Array();
	var tempcompNmList = new Array();
 	
	tempGbnList = gbn.split(',');
	tempSeqList = seq.split(',');
	tempNmList = name.split(',');
	tempDeptNmList = detpNm.split(',');
	tempDutyCodeList = dutyCodeNm.split(',');
	tempcompNmList = compNm.split(',');
	
	var selElement = '';
	
	if(seq != ""){
		for(var i=0; i<tempSeqList.length; i++){
			if(tempDeptNmList[i] == ""){
				tempDeptNmList[i] = tempNmList[i]
				tempNmList[i] = tempcompNmList[i];
			}
			  
			 selElement += "<tr><td><input type='checkbox' id='"+tempSeqList[i]+"' name='seq' class='k-checkbox selempchk' value='"+tempGbnList[i]+"'>";
			 selElement += "<label class='k-checkbox-label' for='"+tempSeqList[i]+"' style='padding:0.2em 0 0 10px;'></label></td>";  
			 selElement += "<td>"+tempNmList[i]+"</td>";			
			 selElement += "<td>"+tempDeptNmList[i]+"</td>";		
			 selElement += "<td>"+tempDutyCodeList[i]+"</td>";	
			 
			 idx++;
    	}
        
        $("#selListTable").append(selElement);
		 setCount();
	}
	
}



/* function onCheck(e) {

	    e.preventDefault();
	    
	    
	    var item = e.sender.dataItem(e.node);   
	      	
	      	// 중복체크
		var seq = item.seq;
		var $findSeqObj = $("#selListTable").find("input[value="+seq+"]");
		var r = $findSeqObj.val();
	
		if (r != null && r != '') {
			$findSeqObj.parents("tr").remove();
			return;
		} 
	    var checkbox = $(e.node).find(":checkbox");
	    var checked = checkbox.prop("checked");
	    
	    var compName = "";
	    var name = "";
	    var deptName = "";
	    var dutyName = "";
	    var loginId = "";
	    		    
	    if (item.nodes != null && item.nodes.length != 0) { 
	    	//회사&부서 선택시 rootfoler명 가져오기 
	    	name = $("#orgTreeView").find(".rootfolder").parent().text();
	    	deptName = item.name;
	    	loginId = "";
	    }
	    else {
	    	name = item.name;
	    	loginId = "("+item.loginId+")";
	    	deptName = item.deptName;
	    	dutyName = item.dutyCodeName;		    	
	    }
	    
		
		if(checked){				 
		 
			 var selElement = "<tr><td><input type='checkbox' id='selchk_"+idx+"' name='seq' class='k-checkbox selempchk' value='"+item.seq+"'>";
				 selElement += "<label class='k-checkbox-label' for='selchk_"+idx+"' style='padding:0.2em 0 0 10px;'></label></td>";  
				 selElement += "<td>"+name+""+loginId+"</td>";			
				 selElement += "<td>"+deptName+"</td>";		
				 selElement += "<td>"+dutyName+"</td>";		
				 selElement += "<input type='hidden' name='gbn' value='"+item.gbn+"'/>";
				 selElement += "<input type='hidden' name='name' value='"+name+"'/></tr>";
			 
	     	 $("#selListTable").append(selElement);
	     	 
	     	 $("#selchk_"+idx).prop("checked",true);
		}
		//idx증가
		idx++ ;
		//선택된 부서/사원 count
		setCount();
} */
			

	function setChecked(e){
	    var item = e.sender.dataItem(e.node);
	    var seq = item.seq;
	    var gbn = item.gbn;
	   
	    var item = e.sender.dataItem(e.node);
        var seq = item.seq;
        var gbn = item.gbn;
        var name = item.name;
        
        if(strOrgList != null && strOrgList.length > 0)
        {
        	
        	tempOrgList = strOrgList.split(',');
        	tempSeqList = strSeqList.split(',');
        	tempNmList = strNmList.split(',');
        	
        	for(var i=0; i<tempSeqList.length; i++)
        	{
        		if (seq == tempSeqList[i] && gbn == tempOrgList[i] ) {
        			var cb = e.node.find(".k-checkbox input");
        			if (cb) {
         				//$(cb.selector).prop('checked', true);
        				$(cb).prop('checked', true);
        			}
        		}        		
        	}
        }
        else{
        	for(var i=0; i<tempSeqList.length; i++)
        	{    
        		if (seq == tempSeqList[i] && gbn == tempOrgList[i] ) {
        			
        			var cb = e.node.find(".k-checkbox input");
        			if (cb) {
         				//$(cb.selector).prop('checked', true);
        				$(cb).prop('checked', true);
        			}
        		}
        	}
        }
}
              
		
     //조직도 callback 구현
   	function callbackOrgChart(item) {
   	//	var empDeptInfo = $('#empDeptInfo').html();
   		
   		var treeview = $("#orgTreeView").data("kendoTreeView");
   		var selectedNode = treeview.select();
   	
		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/systemx/getEmpListNodes.do" />',
			data:{groupSeq:item.groupSeq, compSeq:item.compSeq, bizSeq:item.bizSeq, deptSeq : item.seq},
			datatype:"json",			
			success:function(data){
				if (data.list) {
					var list = data.list;
					for(var i = 0 ; i < list.length; i++) {
						
						selectedNode = treeview.select();
						
                         if (selectedNode.length == 0) {
                             selectedNode = null;
                         } 
                                                  
                         list[i].hasChildren = false;
                         treeview.append(list[i], selectedNode);
 
                         //row.addClass("k-state-selected");
					}
				}
				 
			}
		});
   		
   	}
    	
   	function setEmpList(item) {
   		var treeview = $("#orgTreeView").data("kendoTreeView");
   		var selectedNode = treeview.select();
   		
   			$.ajax({
   				type:"post",
   				url:'<c:url value="/cmm/systemx/getEmpListNodes.do" />',
   				data:{groupSeq:item.groupSeq, compSeq:item.compSeq, bizSeq:item.bizSeq, deptSeq : item.seq},
   				datatype:"json",			
   				success:function(data){
   					if (data.list) {
   						var list = data.list;
   						for(var i = 0 ; i < list.length; i++) {
   							
   	                         if (selectedNode.length == 0) {
   	                             selectedNode = null;
   	                         } 
   	                                                  
   	                         list[i].hasChildren = false;
   	                         treeview.append(list[i], selectedNode);
   	                         
   	         				// row.addClass("k-state-selected");
   						}
   					}
   					 
   				}
   			});
   	}
    	
   	function searchKeyword() {
   		
   		var type = $("#organ_sel").val();
		
		var data = {};
		
		var keyword = $("#btnText").val();
		
		switch (type) { 
			case 0 : 
				data.nameAndLoginId = keyword; 
				break;
			case 1 : data.empName = keyword; 
				break;
			case 2 : data.loginId = keyword; 
				break;
			default: 
				data.nameAndLoginId = keyword; 
				break;
		} 
		
		data.mainDeptYn = $("#mainDeptYn").val();
		data.compSeq = '${params.compSeq}';
   		var searchKeyword = $("#searchKeyword").val();
   		 
   		$.ajax({
   			type:"post",
   			url:'<c:url value="/cmm/systemx/getEmpListNodes.do" />',
   			data:data,
   			datatype:"json",			
   			success:function(data){
   				if (data.list) {
   					var list = data.list;
   					setTreeViewSelect(list); 
   				}
   				
   			}
   		});
   	}
    	
   	function setTreeViewSelect(nodes) {
   		var treeview = $("#orgTreeView").data("kendoTreeView");
   		var datasource = treeview.dataSource;
   		for(var i = 0; i < nodes.length; i++) {
   			var dataItem = datasource.get(nodes[i].deptSeq);
   			if (dataItem != null) {
   				var node = treeview.findByUid(dataItem.uid);
   				if (node != null && dataItem.nodes.length == 0){
   					treeview.select(node);
   					setEmpList(dataItem);
   					treeview.select($());/* 
   					var cb = $(node).find(".k-checkbox input");
		    			if (cb) {
		     				//$(cb.selector).prop('checked', true);
		    				$(cb).prop('checked', true);
		    			} */
   				}
   			}
   		}
   	} 
   	
   	function deleteSelectList() {
   			
		 	tempOrgList = new Array();
	    	tempSeqList = new Array();
	    	
			strOrgList = "";
		    strSeqList = "";
		    strNmList = "";
		    
			var arrChkBox = document.getElementsByName("seq");
			var arrChkBoxId = new Array();
			var idx = 0;
			var chkIdx = 0;
			for(var i=0; arrChkBox != null , i<arrChkBox.length; i++)
			{   
				if(arrChkBox[i].checked == true)
				{
					chkIdx++;
					
				}else{
					tempSeqList[idx] = arrChkBox[i].id;
					tempOrgList[idx] = arrChkBox[i].value;
					idx++;
				}
				
			}
			if(chkIdx > 0){

			}
			if(idx == 0){
				$("#treeview .k-checkbox input").prop("checked", false).trigger("change");
			}
			
			inline.read();
			$("#treeview").data("kendoTreeView").dataSource.view();
		    var arr = $("#selListTable").find("input:checked");
			 if (arr.length > 0) {
				for(var i = 0; i < arr.length; i++) {
					$(arr[i]).parents("tr").remove();
				}
			 }
		 setCount();
   	}
		
	</script>



<input type="hidden" id="chkValue" name="chkValue" value="">
<input type="hidden" id="chkCompNm" name="chkCompNm" value="">
<input type="hidden" id="chkNm" name="chkNm" value="">
<input type="hidden" id="chkGbn" name="chkGbn" value="">
<input type="hidden" id="chkDeptNm" name="chkDeptNm" value="">
<input type="hidden" id="chkDuteCodeNm" name="chkDuteCodeNm" value="">
<input type="hidden" id="allValue" name="chkParentValue" value="">
<input type="hidden" id="allNm" name="chkParentNm" value="">
<input type="hidden" id="allGbn" name="chkParentGbn" value="">
<div class="pop_wrap organ_wrap" style="width:670px;">
	<div class="pop_head">
		<h1>조직도</h1>
		<a href="#n" class="clo" onclick="javascript:window.close();"><img src="<c:url value='/Images/btn/btn_pop_clo01.png' />" alt="" /></a>
	</div>
					
	<div class="pop_con">
		<div class="box_left">
			

			<p class="record_tabSearch">
				<input id="organ_sel" style="width:66px;" />
				<input class="k-textbox input_search" id=btnText type="text" value="" style="width:120px;" placeholder="">
				<a href="#" class="btn_search" id=""></a>
			</p>

			<!-- 조직도-->
			<div class="treeCon" >									
				<div id="orgTreeView" class="tree_icon" style="height:417px !important;">              
           		</div>
			</div> 		
		</div><!-- //box_left -->	

		<div class="box_right2" style="width:330px;">
			<div class="option_top">
				<ul>
					<li>선택된 부서/사원 목록<span id="selectEmpCount"></span></li>
				</ul>
				
				<div id="" class="controll_btn" style="padding:0px;float:right;">
					<button onclick="deleteSelectList();">삭제</button>
				</div>
			</div>

			<div class="com_ta2">
				<table>
					<colgroup>
						<col width="35"/>
						<col width="120"/>
						<col width="85"/>
						<col />
					</colgroup>
					<tr>
						<th>
							<input type="checkbox" name="inp_chk" id="selEmpListChkAll" class="k-checkbox">
							<label class="k-checkbox-label" for="selEmpListChkAll" style="padding:0.2em 0 0 10px;"></label>
						</th>
						<th class="le">회사/이름(아이디)</th>
						<th class="">부서</th>
						<th class="">직급</th>
					</tr>
				</table>
			</div>	
			
			<div class="com_ta2 ova_sc"style="height:387px;margin-top:0px;">			
			<form id="selectForm" name="selectForm">
				<table id="selListTable">
					<colgroup>
						<col width="35"/>
						<col width="120"/>
						<col width="85"/>
						<col />
					</colgroup>					
				</table>
			</form>
			</div>
			
		
		</div><!-- //box_right2 -->

	</div><!-- //pop_con -->	

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" value="확인" onclick="fnConfirm()"/>
			<input type="button" class="gray_btn" value="취소" onclick="javascript:window.close();" />
		</div> 
	</div><!-- //pop_foot -->
	</div><!-- //pop_wrap -->
<script>
  var inline = new kendo.data.HierarchicalDataSource({
      data: [${orgChartList}],
      schema: {
             model: {
             	id: "seq",
                 children: "nodes"
             } 
         }
  });

  $("#orgTreeView").kendoTreeView({
  	checkboxes: {
          checkChildren: true ,
          template: checkboxTemplate
      },
         dataSource: inline,
         select: onSelect,
         check:onCheck,
         dataTextField: ["name"],
         dataValueField: ["seq", "gbn"],
         dataBound: function(e) {
         	var item = e.sender.dataItem(e.node);
//              var seq = item.seq;
//              var gbnOrg = item.gbn;
          	
          	if(item != null){
          		setChecked(e);
          		console.log("DataBound", item.name +  " : " + item.gbn);	
          	}
         	
           }
     }); 
  
  function onSelect(e) {
  	var item = e.sender.dataItem(e.node);
     	
     	callbackOrgChart(item);	// 반드시 구현
  }
  
  function checkboxTemplate(e) {
  	var id = e.item.seq + "_" +e.item.gbn;
  	  if(e.item.checked == 'true') {
  	    return "<input type='checkbox' name='treeCheck' checked='checked' value='"+e.item.seq+"'/>";
  	  } 
  	  else {
  	    return "<input type='checkbox' id='"+e.item.gbn + e.item.seq+"' name='treeCheck' value='"+e.item.seq+"'/>";
  	  }
  }	    
  
  
  
 </script>

</div>




