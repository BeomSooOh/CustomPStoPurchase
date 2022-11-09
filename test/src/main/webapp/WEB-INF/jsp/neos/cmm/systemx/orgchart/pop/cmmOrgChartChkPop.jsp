<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

	<script type="text/javascript">
	
	 var idx = 0;	// row 복제후 id값 변경을 위해 인덱스 선언
	
		$(document).ready(function() {	
			
			$('#btnText').focus();
			
			//기본버튼
	        $(".controll_btn button").kendoButton();
			
			//검색
			$(".btn_search").click(function(e){
				search();
				
			});

			$('#btnText').on('keypress', function(e) {
				if (e.which == 13) {
					search();
				}
			}); 

			//조직도검색 셀렉트
			$("#organ_sel").kendoComboBox({
				dataTextField: "text",
                dataValueField: "value",
				dataSource : [
					        {name:"전체", value:"0"}, 
					        {name:"이름", value:"1"},
					        {name:"아이디", value:"2"}
				],
				index: 0
			}); 
			
			$("#removeSelEmpBtn").click(function(e){
				 var arr = $("#selEmpListTable").find("input:checked");
				 if (arr.length > 0) {
					for(var i = 0; i < arr.length; i++) {
						$(arr[i]).parents("tr").remove();
					}
				 }
				 setCount();
			}); 
			
			$("#empListChkAll").click(function(e){
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
			});  
			
			$("#selEmpListChkAll").click(function(e){ 
				 var ischeck = $(this).is(':checked');  
				 var arr = $("#selEmpListTable").find(".selempchk");
				 if (arr.length > 0) {
					for(var i = 0; i < arr.length; i++) {
						$(arr[i]).prop("checked", ischeck); 		// 프로퍼티를 변경해야 이벤트가 정상적으로 동작
					}
				 }
			}); 
			
			$("#okBtn").click(function(e){ 
				
				var formdata = $("#selectForm").serializeArray();
				var data = [];
				var obj = {};
				
				for(var i = 0; i < formdata.length; i++) {
					var item = formdata[i];
					if (item.name == 'deptSeq' && i != 0) {
						data.push(obj);
						obj = {};
					}
					obj[item.name] = item.value;
				}
				
				data.push(obj); 
				 
				opener.callbackSelectUser(data);
				 
				window.close(); 
			}); 
			
			
			var totalCount = "${fn:length(selectEmpList)}";
			
			
			$("#selectEmpCount").html("("+totalCount+")");
			
			idx = parserInt(totalCount); 
				 
		});  
		
		// 선택된 사원 목록 총개 갱신
		function setCount() {
					
			var rowCount = $('#selEmpListTable tr').length;
					
			$("#selectEmpCount").html("("+rowCount+")");
		}
		
		function search() {
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
				
				$.ajax({
					type:"post",
					url:'<c:url value="/cmm/systemx/cmmOrgChartInnerEmpList.do" />',
					data:data,
					datatype:"json",			
					success:function(data){
						$("#empListDiv").html(data);
					} 
				});
			
			
		}
		
		
		function checkboxTemplate(e) {
        	var id = e.item.seq + "_" +e.item.gbn;
        	  if(e.item.checked == 'true') {
        	    return "<input type='checkbox' name='treeCheck' checked='checked' value='"+e.item.seq+"'/>";
        	  } 
        	  else {
        	    return "<input type='checkbox' name='treeCheck'  value='"+e.item.seq+"'/>";
        	  }
        }	
		
		function onCheck(e) {
			
			alert(this.text(e.node));
						
        	/* var treeView = $("#treeview").data("kendoTreeView"), message;
        	var checkedNodes = [], checkedNodesNm = [], checkedNodesGbn = [];
        	var $nodes = treeView.dataSource.view();
            var row ;
        	for (var i = 0; i < $nodes.length; i++) {
                if ($nodes[i].checked) {
                	var row = $(this).parent().parent();
                	
                }

                if ($nodes[i].hasChildren) {
                    checkedNodeIds($nodes[i].children.view(), checkedNodes, checkedNodesNm, checkedNodesGbn);
                }
            } */
        	
        	/* checkedNodeIds(treeView.dataSource.view(), checkedNodes, checkedNodesNm, checkedNodesGbn);
            
            $("#chkValue").val(checkedNodes.join(","));
            $("#chkNm").val(checkedNodesNm.join(","));
            $("#chkGbn").val(checkedNodesGbn.join(",")); 
            
            ;
			var e = $("#selEmpListTable").find("input[value="+empSeq+"]").val();
			if (e != null && e != '') {
				//alert("선택된 사원입니다.");	
				return;
			} 
			
			var row = $(inp).parent().parent();
			// row 복제
			var newRow = row.clone(true);
			
			// id와 for 어티리뷰트 값 변경
			$(newRow).find(".empchk").attr("id","selchk_"+idx);
			$(newRow).find(".empchk").attr("class","k-checkbox selempchk");
			$(newRow).find(".k-checkbox-label").attr("for", "selchk_"+idx);
			
			//html 생성
			var h = "<tr>"+$(newRow).html()+"</tr>";
			 // 추가
			$("#selEmpListTable").append(h); 
			// 인덱스 증가
			idx++;
			// 선택된 사원 목록 총개 변경
			setCount(); */

            //callbackOrgChart(seq, gbnOrg); //
        }
		
		
	

        // function that gathers IDs of checked nodes
        function checkedNodeIds(nodes, checkedNodes, checkedNodesNm, checkedNodesGbn) {
            for (var i = 0; i < nodes.length; i++) {
                if (nodes[i].checked) {
                    checkedNodes.push(nodes[i].seq);
                    checkedNodesNm.push(nodes[i].name);
                    checkedNodesGbn.push(nodes[i].gbn);
                }

                if (nodes[i].hasChildren) {
                    checkedNodeIds(nodes[i].children.view(), checkedNodes, checkedNodesNm, checkedNodesGbn);
                }
            }
        }	             	    		
		
        // 선택된 체크박스 value 값 리턴 ( a01,a02,a03... )
        function getCheckedValue(){
       		var arrCheckedValue = checkBoxSelectedValue(document.getElementsByName("treeCheck"));

           	var rowNum = arrCheckedValue.length;
     
    		var chkValue = "";
     	    for(var inx = 0 ; inx < rowNum; inx++) {
     	    	if(inx == 0 )
     	    		chkValue =arrCheckedValue[inx] ;
     	    	else 
     	    		chkValue = chkValue+","+arrCheckedValue[inx] ; 	    	
     	    }	
     	    return chkValue;
        }
		
	</script>


<script>
	//조직도 callback 구현
	function callbackOrgChart(item) {
		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/systemx/cmmOrgChartInnerEmpList.do" />',
			data:{groupSeq:item.groupSeq, compSeq:item.compSeq, bizSeq:item.bizSeq, deptSeq : item.seq, mainDeptYn : $("#mainDeptYn").val()},
			datatype:"json",			
			success:function(data){
				$("#empListDiv").html(data);
			}
		});
	} 
	  
</script>

<input type="hidden" id="mainDeptYn" value="${params.mainDeptYn}" />
<input type="hidden" id="chkValue" name="chkValue" value="">
<input type="hidden" id="chkNm" name="chkNm" value="">
<input type="hidden" id="chkGbn" name="chkGbn" value="">

<div class="pop_wrap organ_wrap" style="width:580px;">
	<div class="pop_head">
		<h1>조직도</h1>
		<a href="#n" class="clo" onclick="javascript:window.close();"><img src="<c:url value='/Images/btn/btn_pop_clo01.png' />" alt="" /></a>
	</div>
					
	<div class="pop_con">
		<div class="box_left">
			

			<p class="record_tabSearch">
				<input id="organ_sel" style="width:66px;" />
				<input class="k-textbox input_search" id="btnText" type="text" value="" style="width:120px;" placeholder="">
				<a href="#" class="btn_search" id=""></a>
			</p>

			<!-- 조직도-->
			<div class="treeCon" >									
				<div id="treeview" class="tree_icon" style="height:221px;"></div>
			</div> 		
			
			<!-- 사원목록 -->
			<div class="emp_list">
				<p class="tit">사원목록</p>
				<div class="com_ta2">
					<table>
						<colgroup>
							<col width="120"/>
							<col width="75"/>
							<col />
						</colgroup>
						<tr>
							<th class="le">
								<input type="checkbox" name="inp_chk" id="empListChkAll" class="k-checkbox">
								<label class="k-checkbox-label" for="empListChkAll" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;">
								이름/아이디
							</th>
							<th class="">부서</label></th> 
							<th class="">직급</label></th>
						</tr>
					</table>
				</div>	
		
		<div class="com_ta2"style="height:128px;" id="empListDiv">
			
		</div>
			
			</div>

			<!-- //사원목록 -->
							
		</div><!-- //box_left -->	

		<div class="box_right2">
		<div class="option_top">
			<ul>
				<li>선택된 사원 목록<span id="selectEmpCount">(0)</span></li>
			</ul>
			
			<div id="" class="controll_btn" style="padding:0px;float:right;">
				<button id="removeSelEmpBtn">삭제</button>
			</div>
		</div>

		<div class="com_ta2">
			<table>
				<colgroup>
					<col width="120"/>
					<col width="75"/>
					<col />
				</colgroup>
				<tr>
					<th class="le">
						<input type="checkbox" name="inp_chk" id="selEmpListChkAll" class="k-checkbox">
						<label class="k-checkbox-label" for="selEmpListChkAll" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;">
						이름/아이디
					</th>
					<th class="">부서</label></th>
					<th class="">직급</label></th> 
				</tr>
			</table>
		</div>	
		
		<div class="com_ta2"style="height:387px;margin-top:0px;" >
			<form id="selectForm" name="selectForm">
				<table id="selEmpListTable">
					<colgroup>
						<col width="120"/>
						<col width="75"/>
						<col />
					</colgroup>
	
					<c:forEach items="${selectEmpList}" var="list" varStatus="c">
						<tr>
							<td class="le">
								<input type="checkbox" id="selchk_${c.count}" name="empSeq" class="k-checkbox selempchk" value="${list.empSeq}">
								<label class="k-checkbox-label" for="selchk_${c.count}" style="margin:0 0 0 10px; padding:0.2em 0 0 1.5em;">
								${list.empName}(${list.loginId})
								<input type="hidden" name="deptSeq" value="${list.deptSeq}">
							</td>  
							<td class="">${list.deptName}</label></td>
							<td class="">${list.dutyCodeName}</label></td>
						</tr>  
					</c:forEach>
				
				</table>
			</form>
		</div>
		
		</div><!-- //box_right2 -->

	</div><!-- //pop_con -->	

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" value="확인" id="okBtn"/>
			<input type="button" class="gray_btn" value="취소" onclick="javascript:window.close();" />
		</div> 
	</div><!-- //pop_foot -->
	</div><!-- //pop_wrap -->


<!-- <div>
	<label for="searchKeyword">사원검색</label> <span	class="k-textbox k-space-right" style="width:200px;"> 
		<input type="text" id="searchKeyword" name="searchKeyword" value="" /> 
		<a href="#"	class="k-icon k-i-search" onclick="searchKeyword();">&nbsp;</a>
	</span>
</div> -->



<script>
	        /*     var inline = new kendo.data.HierarchicalDataSource({
	                data: [${orgChartList}],
	                schema: {
                        model: {
                        	id: "seq",
                            children: "nodes"
                        } 
                    }
	            }); */
	            
	           /*  var checkChildren = '${checkChildren}';
	            
	            if (checkChildren == null || checkChildren == '' || checkChildren == 'false') {
	            	checkChildren = false;
	            } else {
	            	checkChildren = true;
	            } */ 
	
	            $("#treeview").kendoTreeView({
	            	/* checkboxes: {
	                    checkChildren: checkChildren
	                }, */
	                dataSource: [{
	                	seq: 1, name: "그룹", expanded: true, spriteCssClass: "rootfolder", items: [
							{
								seq: 2, name: "마케팅부", expanded: true, spriteCssClass: "file", items: [
									{ id: 3, name: "마케팅사업부", spriteCssClass: "file" },
									{ id: 4, name: "커뮤니케이션부", spriteCssClass: "file" },
									{ id: 5, name: "전략마케팅본부", spriteCssClass: "file" }
								]
							},
							{
								seq: 6, name: "전략마케팅본부", expanded: true, spriteCssClass: "folder", items: [
										{ id: 7, name: "디자인센터", spriteCssClass: "folder" ,items: [
											{ id: 8, name: "디자인1팀", spriteCssClass: "folder"},
											{ id: 9, name: "디자인2팀", spriteCssClass: "folder"}
										]
									}
								]
							},
							{
								seq: 10, name: "디자인센터", expanded: true, spriteCssClass: "folder"
							},
							{
								seq: 11, name: "지식서비스부문", expanded: true, spriteCssClass: "folder", items: [
										{ id: 12, name: "지식서비스1팀", spriteCssClass: "folder" ,items: [
										{ id: 13, name: "지식서비스2팀", spriteCssClass: "folder"},
										{ id: 14, name: "지식서비스3팀", spriteCssClass: "folder"}
										]
									}
								]
							},
							{
								seq: 15, name: "TS부문", expanded: true, spriteCssClass: "folder"
							},
							{
								seq: 16, name: "2014", expanded: true, spriteCssClass: "folder", items: [
										{ seq: 17, name: "2014s", spriteCssClass: "folder" ,items: [
										{ seq: 18, name: "10", spriteCssClass: "folder"},
										{ seq: 19, name: "10", spriteCssClass: "folder"},
										{ seq: 20, name: "10", spriteCssClass: "folder"},
										{ seq: 21, name: "10", spriteCssClass: "folder"},
										{ seq: 22, name: "10", spriteCssClass: "folder"},
										{ seq: 23, name: "10", spriteCssClass: "folder"},
										{ seq: 24, name: "10", spriteCssClass: "folder"},
										{ seq: 25, name: "10", spriteCssClass: "folder"},
										{ seq: 26, name: "10", spriteCssClass: "folder"},
										{ seq: 27, name: "10", spriteCssClass: "folder"},
										{ seq: 28, name: "10", spriteCssClass: "folder"},
										{ seq: 29, name: "10", spriteCssClass: "folder"},
										{ seq: 30, name: "10", spriteCssClass: "folder"},
										{ seq: 31, name: "10", spriteCssClass: "folder"},
										{ seq: 32, name: "11", spriteCssClass: "folder"}
										]
									}
								]
							},
							{
								id: 33, name: "2014ss", expanded: true, spriteCssClass: "folder"
							}
						]
					}],
                    select: onSelect,
                    checkboxes: {
                        checkChildren: true,  // 상위항목 체크 시 하위항목 모두 선책
                        template: checkboxTemplate
                    },            
                    check: onCheck, 
                    dataTextField: ["name"],
                    dataValueField: ["seq", "gbn"]
                }); 
	            
	            function onSelect(e) {
	            	var item = e.sender.dataItem(e.node);
	               	
	               	callbackOrgChart(item);	// 반드시 구현
	            }
	            
            </script>

</div>




