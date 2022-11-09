<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jsTree/style.min.css' />" />
<style>
	li.jstree-open > a .jstree-icon.jstree-themeicon { margin-left: 5px; margin-top: 5px; margin-right: -3px; background:url("/eap/css/jsTree/ico_folder_open01.png") 0px 0px no-repeat !important; }
	li.jstree-closed > a .jstree-icon.jstree-themeicon { margin-left: 5px; margin-top: 5px; margin-right: -3px; background:url("/eap/css/jsTree/ico_folder_fold01.png") 0px 0px no-repeat !important; }
	li.jstree-leaf > a .jstree-icon.jstree-themeicon { margin-left: 5px; margin-top: 5px; margin-right: -3px; background:url("/eap/css/jsTree/ico_folder_fold01.png") 0px 0px no-repeat !important; }

	#orgTreeView .jstree-container-ul > .jstree-node { background:transparent; }
	#orgTreeView .jstree-container-ul > .jstree-node > .jstree-ocl { background:transparent; }	
	#orgTreeView .jstree-container-ul > .jstree-open > .jstree-ocl { background-position:-36px -4px; }
	#orgTreeView .jstree-container-ul > .jstree-closed> .jstree-ocl { background-position:-4px -4px; }
	#orgTreeView .jstree-container-ul > .jstree-leaf> .jstree-ocl { background:transparent; }
</style>
<script type="text/javascript" src="<c:url value='/js/jsTree/jstree.min.js' />"></script>

            <div id="orgTreeView"></div>

            <script>
	            
	            function onSelect(e) {
	            	var item = e.node;
	            	
	               	callbackOrgChart(item);	// 반드시 구현
	            }
	            
	            $('#orgTreeView').jstree({ 
	            	'core' : { 
	            		//'data' : ${orgChartList},
	            		//'data' : [{"children":[""],"icon":"","id":"3","state":{"selected":false,"opened":false},"text":"더존IT그룹"},{"children":[""],"icon":"","id":"6","state":{"selected":false,"opened":false},"text":"더존비즈온"},{"children":[""],"icon":"","id":"7","state":{"selected":false,"opened":false},"text":"더존Next"},{"children":[""],"icon":"","id":"8","state":{"selected":false,"opened":false},"text":"더존E＆H"},{"children":[""],"icon":"","id":"10","state":{"selected":false,"opened":false},"text":"더존북경득진망"},{"children":[""],"icon":"","id":"1509","state":{"selected":false,"opened":false},"text":"더존JAPAN"},{"children":[""],"icon":"","id":"1851","state":{"selected":false,"opened":false},"text":"강촌캠퍼스근무지원단"},{"children":[""],"icon":"","id":"872","state":{"selected":false,"opened":false},"text":"아이택스넷"},{"children":[""],"icon":"","id":"1538","state":{"selected":false,"opened":false},"text":"키컴"},{"children":[""],"icon":"","id":"3447","state":{"selected":false,"opened":false},"text":"아이존어린이집"},{"children":[""],"icon":"","id":"2576","state":{"selected":false,"opened":false},"text":"동물과사람"},{"children":[""],"icon":"","id":"14","state":{"selected":false,"opened":false},"text":"더존협력업체"},{"children":[""],"icon":"","id":"631","state":{"selected":false,"opened":false},"text":"더존회의실"}]
	            		'data' : {
		            		'url' : '<c:url value="/cmm/systemx/orgChartListJT.do" />',
		            		'dataType': 'JSON',
 		        			'data' : function (node) { //alert(JSON.stringify(node))
 		        				return {'parentSeq' : (node.id == "#" ? 0 : node.original.seq), 'compSeq' : ${compSeq} + ""}
 		        			},
		            		/*'success' : function(data) { alert(JSON.stringify(data));
		            			return data.JSONObjectList;
		            		}*/
	            		},
	            		//'check_callback' : true,
	            		'animation' : false 
	            	},
	            	//'plugins' : ['checkbox']
	            	//'plugins' : ['state','dnd','wholerow'],
	            	/*'json_data' : {
	            		'data' : ${orgChartList},
            			'ajax' : {
            				'type' : 'GET',
            				'url' : function (node) { 
            					var parentSeq = node.id;
            					if (parentSeq == "#")  {
            						parentSeq = 0;
            					}
            					var url = '<c:url value="/cmm/systemx/orgChartListJT.do?parentSeq=' + parentSeq + '" />';
            					return url;
            				},
            				'success' : function (data) {
            					return data.list;
            				}
            			}
            		}*/
	            })
	            .bind("loaded.jstree", function (event, data) {
					//console.log("loaded.jstree");
	            	//$(".jstree-default ul li:first-child").removeClass("jstree-node");
	            	//$(".jstree-default ul li:first-child").attr("style", "background-image:url(/eap/css/jsTree/32px.png); background-position:-157px -68px; background-repeat:no-repeat;");
	            	//$(".jstree-default ul li:first-child").addClass("jstree-root");
					// load후 처리될 event를 적어줍니다.
				})
				.bind("select_node.jstree", function (event, data) {
					//console.log("select_node.jstree");
					onSelect(data);
					// node가 select될때 처리될 event를 적어줍니다.​
				});
				/*.bind("open_node.jstree", function (event, data) {
					console.log("open_node.jstree");
					// node가 open 될때 처리될 event를 적어줍니다.​
				})
				.bind("dblclick.jstree", function (event) {
					console.log("dblclick.jstree");
					// node가 더블클릭 될때 처리될 event를 적어줍니다.​​
				});*/

        		/*'data' : {
        			'url' : '<c:url value="/systemx/orgChartListJT.do" />',
        			'data' : function (node) {
        				return {'parentSeq' : node.id}
        			}
        		}*/
            </script>
