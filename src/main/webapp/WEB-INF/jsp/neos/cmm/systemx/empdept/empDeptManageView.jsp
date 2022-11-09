<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script>
	var empDeptGrid = null;
	var item = null;
	
	
	function initData() {
		$("#empSeq").val("");
        $("#deptSeq").val("");
        $("#deptSeqNew").val("");
        $("#compSeq").val("");
        $("#groupSeq").val("");
    	$("#telNum").val("");
    	$("#zipCode").val("");
    	$("#addr").val("");
    	$("#detailAddr").val("");
    	$("#orgchartDisplayYn").val("Y");
    	$("#messengerDisplayYn").val("Y");
	}

	function getEmpInfo(obj) {
		item = obj;
		if (empDeptGrid == null) {
			loadEmpDeptGrid();
		} else {
			gridRefresh();
		}
	} 
	
	
	
	function gridRefresh() {
		var grid = $("#empDeptGrid").data("kendoGrid");
		grid.dataSource.read({groupSeq:item.groupSeq, compSeq:item.compSeq, empSeq:item.seq});
		grid.refresh(); 
	}
	
	var mainDeptYnData = [{mainDeptYn : "Y", name : "주부서"}, {mainDeptYn : "N", name : "부부서"}];
	var dutyCodeData = ${dutyList};
	var positionCodeData = ${positionList};
	
	function loadEmpDeptGrid() {
		
		var dataSource = new kendo.data.DataSource({
			transport: {
                read:  {
                    url: '<c:url value="/cmm/systemx/empDeptData.do" />',
                    dataType: "json"
                },
                parameterMap: function(options, operation) {
                	options.groupSeq = item.groupSeq;
                	options.compSeq = item.compSeq;
                	options.empSeq = item.seq;
                    
                     
                    if (operation !== "read" && options.models) {
                        return {models: kendo.stringify(options.models)};
                    }
                    
                    return options;
                }
            }, 
            batch: true,
            schema: {
                model: {
                    id: "deptSeq",
                    fields: {
                    	chkbox : {editable:false},
                    	mainDeptYn: { editable: true, nullable: true },
                    	deptName: { editable: true, nullable: true }, 
                    	deptDutyCode: { editable: true, nullable: true},
                    	deptPositionCode: { editable: true, nullable: true}
                    }
                }
            }
    	});

		empDeptGrid = $("#empDeptGrid").kendoGrid({
	        dataSource: dataSource,
	        pageable: false,
	        selectable: true,
	        change: onChange,
	        columns: [  
 				{ field: "chkbox", title: "선택" , align:"center" , width: "40px", filterable: false, sortable: false, template: "<input type=\"checkbox\" name =\"chkEmp\"  class=\"checkbox\" value = \"#=data.deptSeq#\"/>"  },
	            { field: "mainDeptYn", title: "구분", width: "80px", template: "#=getMainYnName(data.mainDeptYn)#",
 					editor: function(container, options) {
 		                var input = $('<input required data-text-field="mainDeptYn" data-value-field="mainDeptYn" data-bind="value:' + options.field + '"/>'); 
 		                input.appendTo(container);
 		                input.kendoDropDownList({
 		                    dataTextField: "name",
 		                    dataValueField: "mainDeptYn",
 		                    dataSource: mainDeptYnData
 		                }).appendTo(container);
 		            }	
	            },
	            
	            { field: "deptName", title:"부서명", width: "160px", template: "#=data.deptName#",
	            	editor: function(container, options) {
	            		var input = $('<input type="text" style="width:75%" name="deptName" value="' + options.field + '" readonly= readonly/>');
	                	var tooltipElement = $('<button type="button" class="search-Event-B"></button>');
	                	tooltipElement.kendoButton({
		           	    	 imageUrl: _g_contextPath_ + "/images/erp/btn_search.gif" ,
		        	         click: function(e) { 
		        	        	 rowOpions = options;
		        	        	 $("#window").data("kendoWindow").open();
		        	         }
	                	});
	                	input.appendTo(container);
	                	tooltipElement.appendTo(container);
	                } 
	            },
	            
	            { field: "deptDutyCode", title:"직급", width: "100px", template: "#=data.deptDutyCodeName#",
	            	editor: function(container, options) {
 		                $('<input required data-text-field="deptDutyCodeName" data-value-field="deptDutyCode" data-bind="value:' + options.field + '"/>') 
 		                .appendTo(container)
	                	.kendoDropDownList({
 		                    dataTextField: "deptDutyCodeName",
 		                    dataValueField: "deptDutyCode",
 		                    dataSource: dutyCodeData,
 		                   change: function (e) {
 		    			        var dataItem = e.sender.dataItem();
 		    			        if (dataItem.deptDutyCodeName != null && dataItem.deptDutyCodeName != '') {
 		    			        	options.model.set("deptDutyCodeName", dataItem.deptDutyCodeName);
 		    			        	$("#dutyCode").val(dataItem.deptDutyCode);
 		    			        }
 		    			   }
 		                });
 		            }	
	            },
	            { field: "deptPositionCode", title:"직책", width: "100px", template: "#=data.deptPositionCodeName#",
	            	editor: function(container, options) {
 		                var input = $('<input required data-text-field="deptPositionCodeName" data-value-field="deptPositionCode" data-bind="value:' + options.field + '"/>'); 
 		                input.appendTo(container);
 		                input.kendoDropDownList({
 		                    dataTextField: "deptPositionCodeName",
 		                    dataValueField: "deptPositionCode",
 		                    dataSource: positionCodeData,
  		                   change: function (e) {
		    			        var dataItem = e.sender.dataItem(); 
		    			        if (dataItem.deptPositionCodeName != null && dataItem.deptPositionCodeName != '') {
		    			        	options.model.set("deptPositionCodeName", dataItem.deptPositionCodeName);
		    			        	$("#positionCode").val(dataItem.deptPositionCode);
		    			        }
		    			   }
 		                }).appendTo(container);
 		            }	
	            } 
	            ],
	        refresh:true,
	        editable: true
	    });
		
		$("#empDeptGrid").data("kendoGrid").table.on("click", ".checkbox" , selectRow);
	}
	
	var rowOpions = null;
	
	/*  function deptInfoPop(seq) {
		 var grid = $("#empDeptGrid").data("kendoGrid");
		 rowIndex = grid.select().index();
	     $("#window").data("kendoWindow").open();
     } */
	
	function getMainYnName(mainDeptYn) {
		if (mainDeptYn != null && mainDeptYn != '') {
			for (var i = 0; i < mainDeptYnData.length; i++) {
	            if (mainDeptYnData[i].mainDeptYn == mainDeptYn || mainDeptYnData[i].mainDeptYn == mainDeptYn.mainDeptYn) {
	            	$("#mainDeptYn").val(mainDeptYnData[i].mainDeptYn);
	                return mainDeptYnData[i].name;
	            }
	        } 
		}
		return "";
	}
	
	function selectRow(grid) {
   	 	CommonKendo.setChecked($("#empDeptGrid").data("kendoGrid"), this);	 
    }
	
	function getChkEmp() {
		var grid = $("#empDeptGrid").data("kendoGrid");
		var checkList = CommonKendo.getChecked(grid);
		if (checkList.length == 0) {
			alert("겸직을 선택하세요.");
			return -1;
		}
		else if (checkList.length > 1) {
			alert("겸직은 1개 이상 선택될 수 없습니다.");
			return -1;
		} 
		else {
			/* if (type == "loginId") {
				return checkList[0].loginId;
			} else if(type == "empSeq") {
				return checkList[0].empSeq;
			}  */
			
			return checkList[0];
			  
		}
	 }
	
	function onChange(e) {
		var item = e != null ? e.sender.dataItem(e.sender.select()) : null;
		if (item.empSeq != null && item.empSeq != '') {
			$("#empSeq").val(item.empSeq);
	        $("#deptSeq").val(item.deptSeq);
	        $("#deptSeqNew").val(item.deptSeq);
	        $("#compSeq").val(item.compSeq);
	        $("#groupSeq").val(item.groupSeq);
	    	$("#telNum").val(item.telNum);
	    	$("#zipCode").val(item.deptZipCode);
	    	$("#addr").val(item.deptAddr);
	    	$("#detailAddr").val(item.deptDetailAddr);
	    	$("#orgchartDisplayYn").val(item.orgchartDisplayYn);
	    	$("#messengerDisplayYn").val(item.messengerDisplayYn);
		}
    	
    }
	
	function saveBtn() {
		var formData = $("#empDeptInfoForm").serialize();
		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/systemx/empDeptInfoSaveProcAjax.do" />',
			datatype:"json",
			data: formData,
			success:function(data){
				alert(data.result);
				gridRefresh();
				initData();
			},			
			error : function(e){	//error : function(xhr, status, error) {
				alert("error");	
			}
		});	
		
	}
		
	function removeBtn() {
		var selectRowData = getChkEmp();
		
		if (selectRowData != -1) {
	
			$.ajax({
				type:"post",
				url:'<c:url value="/cmm/systemx/empDeptRemoveProc.do" />',
				datatype:"text",
				data: {compSeq:selectRowData.compSeq, deptSeq:selectRowData.deptSeq, empSeq:selectRowData.empSeq},
				success:function(data){
					alert(data.msg);
					gridRefresh();
					initData();
				},			
				error : function(e){	//error : function(xhr, status, error) {
					alert("error");	
				}
			});	
		}
	}
		
	function addBtn() {
		var grid = $("#empDeptGrid").data("kendoGrid");
	    grid.addRow();
	    $(".k-grid-edit-row").appendTo("#grid tbody");
	    
	    $("#empSeq").val(item.seq);
        $("#compSeq").val(item.compSeq);
        $("#groupSeq").val(item.groupSeq);
        $("#bizSeq").val(item.bizSeq);
	    
	}
	
	

</script>

<h4>사원선택 </h4>
<div id="orgChartList" style="float: left">
	<jsp:include page='/systemx/orgChartEmpList.do'>
		<jsp:param name="compSeq" value='<%=request.getAttribute("compSeq")%>' />
	</jsp:include>
</div> 


<div style="float:left;margin-top:20px">
	<form id="empDeptInfoForm" name="empDeptInfoForm">
	
		<input type="hidden" id="empSeq" name="empSeq" value="" />
		<input type="hidden" id="deptSeq" name="deptSeq" value="" />
		<input type="hidden" id="bizSeq" name="bizSeq" value="" />
		<input type="hidden" id="groupSeq" name="groupSeq" value="" />
		<input type="hidden" id="compSeq" name="compSeq" value="" />
		<input type="hidden" id="deptSeqNew" name="deptSeqNew" value="" />
		<input type="hidden" id="mainDeptYn" name="mainDeptYn" value="" />
		<input type="hidden" id="dutyCode" name="dutyCode" value="" />
		<input type="hidden" id="positionCode" name="positionCode" value="" />
		
		
		<div style="text-align:right">
			<button id="" class="k-button k-primary" onclick="addBtn()" type="button">추가</button>
			<button id="" class="k-button k-primary" onclick="removeBtn()" type="button">삭제</button>
		</div>	
		<h4>사원부서정보 </h4> 
		<div id="empDeptGrid"></div>
		
		<h4>기본정보 </h4>
		<ul>
			<li> 
		        <label for="telNum">전화번호(회사)</label>
		        <input class="k-textbox"  id="telNum" name="telNum" value="" />
		    </li>
		    <li>
		        <label for="zipCode">회사주소</label>
		    	<input class="k-textbox"  id="zipCode" name="zipCode" value="" /> <button id="findZip" class="saveBtn">찾기</button>
		        <input class="k-textbox"  id="addr" name="addr" value="" /></p>
		        <p style="padding-left:50px"><input class="k-textbox"  id="detailAddr" name="detailAddr" value="" style="width:300px" /></p>
		    </li> 
		</ul>
		
		<h4>그룹웨어 설정정보 </h4>
		<ul id="fieldlist">
		    <li> 
		        <label for="orgchartDisplayYn">조직도표시여부</label>
		        <input type="radio" id="orgchartDisplayYn" name="orgchartDisplayYn" value="Y" checked />사용 <input type="radio" name="orgchartDisplayYn" value="N" />미사용
		    </li> 
		    <li> 
		        <label for="messengerDisplayYn">메신저표시여부</label>
		        <input type="radio" id="messengerDisplayYn" name="messengerDisplayYn" value="Y" checked />사용 <input type="radio" name="messengerDisplayYn" value="N" />미사용
		    </li>
		</ul>
	</form>	
	<div style="width:100%;text-align:right"> 
          	<button class="k-button k-primary" type="button" onclick="saveBtn();" >저장</button>
	 </div> 
	 
	 <div id="window">
	 	<h4>부서선택 </h4>
		<div id="orgTreeViewWindow"></div>
	 </div>
</div> 

<script>
	$("#window").kendoWindow({
		 width: "300px",
	     title: "조직리스트",
	     visible: false,
	     actions: [
	         "Close"
	     ]
	 });
	
	var inline = new kendo.data.HierarchicalDataSource({
        data: [${orgChartList}],
        schema: {
            model: {
                children: "nodes"
            } 
        }
    });

    $("#orgTreeViewWindow").kendoTreeView({
        dataSource: inline,
        select: onSelect,
        dataTextField: ["name"],
        dataValueField: ["seq", "gbn"]
    }); 
    
    function onSelect(e) {
    	var item = e.sender.dataItem(e.node);
       	
       	selectDept(item);	// 반드시 구현
    }
    
    function selectDept(item) {
    	rowOpions.model.set("deptName", item.name);
    	$("#deptSeqNew").val(item.deptSeq);
    	$("#window").data("kendoWindow").close();
    }
</script>



                
  