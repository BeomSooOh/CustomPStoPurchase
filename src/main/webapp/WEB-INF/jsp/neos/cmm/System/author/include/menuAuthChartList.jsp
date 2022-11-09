<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

	<div id="example">
            <div id="treeview" class="treecontents"></div>
            <script>

	            var inline = new kendo.data.HierarchicalDataSource({
	                data: [${menuChartList}],
	                schema: {
                        model: {
                            children: "nodes"
                        }
                    },
	            });
	
	            $("#treeview").kendoTreeView({
                    dataSource: inline,
                    height: 500,
        	        checkboxes: {
                        checkChildren: true,  // 상위항목 체크 시 하위항목 모두 선책
                        template: checkboxTemplate
                    },            
                    dataTextField: ["name"]
                });

	            

	            function checkboxTemplate(e) {
	          	  if(e.item.checked == 'true') {
	          	    return "<input type='checkbox' name='treeCheck' checked='checked' "+ "value='"+e.item.menuNo+"'/>";
	          	  } 
	          	  else {
	          	    return "<input type='checkbox' name='treeCheck' "+ "value='"+e.item.menuNo+"'/>";
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

            <style>
                #example {
                    text-align: left;
                } 

                .treecontents {
                    text-align: left;
                    margin: 0 2em;
                }                
            </style>
        </div>

<input type="hidden" id="chkValue" name="chkValue" value="">


