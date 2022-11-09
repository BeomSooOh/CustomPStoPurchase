<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script>

</script>

        <div id="example">
            <div class="demo-section k-header">
            	<h2>${groupMap.groupName}</h2>
                <div id="treeview"></div>
            </div>
            
            <div class="fLeft" id="comp_info"></div>
            
            <script> 
                   var homogeneous = new kendo.data.HierarchicalDataSource({
                        transport: {
                            read: {
                                url: "compList.do", 
                                dataType: "jsonp"
                            } 
                        },  
                        schema: {
                            model: {
                                id: "compSeq",
                                hasChildren: false
                            } 
                        } 
                    });   

                $("#treeview").kendoTreeView({
                    dataSource: homogeneous,
                    dataTextField: "compName",
                    select: onSelect
                }); 
                 
                function onSelect(e) {
                	var dataItem = this.dataItem(e.node);
					var id = dataItem.id;
					
					$.ajax({
						type:"post",
						url:'<c:url value="/cmm/systemx/comInfo.do" />',
						data:{"compSeq":id},
						datatype:"text",			
						success:function(data){								
							
							$('#comp_info').html(data);
							
						}
					});
                }   
                
                
                function onClick(e) { 
            		var id = $(e.event.target).attr("id");
            		
                	if (id == 'saveBtn') {
                		document.form.submit();
                	}
            	}
             

            	

            </script>

            <style>
                #example {
                    text-align: left;
                }

                .demo-section {
                    display: inline-block;
                    vertical-align: top;
                    width: 220px;
                    height:100%;
                    text-align: left;
                    margin: 0 2em;
                    float:left;
                }
                
                .fLeft {
                	float:left;
                }
            </style>
        </div>


