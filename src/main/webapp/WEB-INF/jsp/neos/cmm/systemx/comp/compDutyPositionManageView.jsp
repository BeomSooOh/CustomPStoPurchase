<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script>

</script>

<form id="form" name="form">
	<div id="example">
		<div class="demo-section k-header">
			<h2>직급직책관리</h2>
				<div>
	               <div id="tabstrip">
	              		<ul>
		                  <li id="POSITION">
		                      직급관리
		                  </li>
		                  <li id="DUTY">
		                      직책관리
		                  </li>
		               	</ul>
	               </div>	
	               <p style="padding-top:30px">
	                <input id="appendNodeText" value="" class="k-textbox"/>
	                <button type="button" class="k-button" id="appendNodeToSelected">추가</button>
	               	<button type="button" class="k-button" id="removeNode" >삭제</button>
	               	<button type="button" class="k-button" id="sortSave" >순서저장</button>
	               </p>
	               <div>
		               <div id="treeview-left"></div>
	                
	                   <div id="treeview-right"></div>
                   </div> 
	          </div>
		</div> 
	</div>

</form>


<script>

	var type = "POSITION";
	$(document).ready(function() {
		
		var homogeneous = new kendo.data.HierarchicalDataSource({
            transport: {
                read: {
                    url: "compDutyPositionData.do",
                    dataType: "jsonp"
                },
                parameterMap: function(options, operation) {
                    options.dpType = type;
                    if (operation !== "read" && options.models) {
                        return {models: kendo.stringify(options.models)};
                    }
                    return options; 
                }
            },
            schema: {
                model: {
                    children: "nodes"
                } 
            }
            
        }); 
		
		$("#treeview-left").kendoTreeView({
            dataSource: homogeneous,
            loadOnDemand: false,
            dataTextField: ["dpName"],
            dataValueField: ["dpSeq"],
            select: onSelect,
            dragAndDrop: true
        }); 
		
		//추가
		var append = function(e) {
			var text = $("#appendNodeText").val();
            var selectedNode = $("#treeview-left").data("kendoTreeView").select();

            if (selectedNode.length == 0) {
                selectedNode = null;
            }

            var nodeData = {dpName: text, dpSeq : null};
            
            $("#treeview-left").data("kendoTreeView").append(nodeData, selectedNode);
            
            addNode(nodeData);
        }; 

   		$("#appendNodeToSelected").click(append);
   		
   		$("#sortSave").click(function(){
   			
   			var treeview = $("#treeview-left").data("kendoTreeView");
 			var jsonData = CommonKendo.getTreeToJson(treeview);
 			
   			$.ajax({
    			type:"post",
    			url:"compDutyPositionSortSaveProc.do",
    			datatype:"json",
    			data: {list:jsonData},
    			success:function(data){
    				alert(data.result);
    			},			
    			error : function(e){	//error : function(xhr, status, error) {
    				alert("error");	
    			}
    		});	 
   			
   		});
    	
    	function addNode(nodeData) {
    		$.ajax({
    			type:"post",
    			url:"compDutyPositionSaveProc.do",
    			datatype:"text",
    			data: {dpType:type, dpName:nodeData.dpName},
    			success:function(data){
    				
    				if(data.isnew) {
    					
    					// var selectedNode = $("#treeview-left").data("kendoTreeView").select();
    			         //var item = $("#treeview-left").data("kendoTreeView").dataItem(selectedNode);	
    			         nodeData.dpSeq = data.dpSeq;
    					 
    			         compDutyPositionInfo(data.dpSeq);
    			         $("#appendNodeText").val("");
    				}
    				
    			},			
    			error : function(e){	//error : function(xhr, status, error) {
    				alert("error");	
    			}
    		});	
    	}
    	

		//삭제
        $("#removeNode").click(function() {
            var selectedNode = $("#treeview-left").data("kendoTreeView").select();

            var item = $("#treeview-left").data("kendoTreeView").dataItem(selectedNode);

            if (item.dpSeq == '0') {
            	alert("최상위는 삭제할 수 없습니다.");
            	return;
            }
            
            compDutyPositionRemove(item.dpSeq);
            
            $("#treeview-left").data("kendoTreeView").remove(selectedNode);
            
            
        });

		function onSelect(e) {
			var item = e.sender.dataItem(e.node);
			var id = item.dpSeq;
			
			compDutyPositionInfo(id);
		}
		
		function compDutyPositionInfo(seq) {
			$.ajax({
				type:"post",
				url:"compDutyPositionInfo.do",
				data:{dpSeq:seq},
				datatype:"text",			
				success:function(data){								
					$('#treeview-right').html(data);
				}
			});
		}

        $("#tabstrip").kendoTabStrip({
            animation:  {
                open: {
                    effects: "fadeIn"
                }
            },
            select : tabSelect
        });
        
        function compDutyPositionRemove(seq) {
        	$.ajax({
				type:"post",
				url:"compDutyPositionRemoveProc.do",
				data:{dpSeq:seq},
				datatype:"text",			
				success:function(data){								
					$('#treeview-right').html("");
					alert(data.result);
					
				}
			});
        }

	});
	 
	function tabSelect(e) {
		type = $(e.item).attr('id');
		
		var treeViewLeft = $("#treeview-left").data("kendoTreeView");
		treeViewLeft.dataSource.read();
		treeViewLeft.refresh();
		
		  
	}


</script>


	<style> 
                .demo-section2 {
                    width: 500px;
                } 

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

                #fieldlist label {
                    display: inline-block; 
                    width: 150px;
                    margin-right: 5px;
                    text-align: right;
                }
                
                #treeview-left,
                #treeview-right
                {
                    float: left;
                    width: 300px;
                    overflow: visible;
                }
                .demo-section:after {
                    content: ".";
                    display: block;
                    height: 0;
                    clear: both;
                    visibility: hidden;
                }

                
                
	</style>