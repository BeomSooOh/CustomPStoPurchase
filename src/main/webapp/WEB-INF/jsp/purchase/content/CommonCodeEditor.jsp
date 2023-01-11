<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>공통코드관리</title>

    <!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/re_pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/animate.css' />">
	    
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script>  
    <script type="text/javascript" src="<c:url value='/js/jquery.maskMoney.js' />"></script>  
	
	<script type="text/javascript">
	
		var changeInfoList = [];	
		var insertCodeInfo = {};	
		var selGroup;		

		$(document).ready(function() {
			BindGroupGrid();
			
			yearSelInut();
		});
			
		function BindGroupGrid(){
			
			var dataSource = new Pudd.Data.DataSource({
					serverPaging: true
				,	editable : true
				,	pageSize: 10
				,	request : {
					    url : '<c:url value="/purchase/admin/SelectCodeGroupList.do" />'
					,	type : 'post'
					,	dataType : "json"
					,   parameterMapping : function( data ) {
						data.TYPE = "cm";
						return data;
					}
				}	    
				,   result : {
					data : function(response){
						return response.list;
					},
					totalCount : function(response){
						return response.totalCount;	
					},
					error : function(response){
						alert("error");
					}	
				}
					    
			});
			
			Pudd("#grid1").puddGrid({
				dataSource : dataSource
			,	scrollable : false
			, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
			,	serverPaging : true		
			,	pageable : {
					buttonCount : 10 
				,	pageList : [ 10, 20, 30, 40, 50 ]
				,	pageInfo : true
				}
			
			,	noDataMessage : {
				message : "검색된 데이터가 없습니다."
			}		
			,	progressBar : {
			   	 
					progressType : "loading"
				,	attributes : { style:"width:70px; height:70px;" }
				,	strokeColor : "#84c9ff"	// progress 색상
				,	strokeWidth : "3px"	// progress 두께
				,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
				,	percentTextColor : "#84c9ff"
				,	percentTextSize : "12px"
				,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			}	
			,	loadCallback : function( headerTable, contentTable, footerTable, gridObj) {
				
					gridObj.on( "gridRowClick", function( e ) {
						 
						var evntVal = e.detail;
					 
						if( ! evntVal ) return;
						if( ! evntVal.trObj ) return;
					 
						var rowData = evntVal.trObj.rowData;
						
						selGroup = rowData.GROUP;
						changeInfoList = [];
						$("#adminSaveBtn").hide();
						BindCodeGrid();
					 
					});				
			}		
			
			,	columns : [
					{
						field : "GROUP"
					,	title : "그룹코드"
					,	width : 150
					,	content : {
							attributes : { class : "ci" }
						}
					},
					{
						field : "NAME"
					,	title : "그룹명"
					,	width : 250
					,	content : {
							attributes : { class : "ci" }
						}
					},
					{
						field : "NOTE"
					,	title : "비고"
					,	content : {
							attributes : { class : "ci" }
						}
					}						
				]
			});	
		} 	
		

		
		function BindCodeGrid(){
			
			changeInfoList = [];
			$("#adminSaveBtn").hide();
			$("[name=codeEditBtn]").show();
			
			if(selGroup == "PURCHASE_GOAL"){
				$("#yearSelect").show();
				$("[name=codeEditBtn]").hide();
			}else{
				$("#yearSelect").hide();
			}
			
			var dataSource = new Pudd.Data.DataSource({
					serverPaging: true
				,	editable : true
				,	pageSize: 10
				,	request : {
					    url : '<c:url value="/purchase/admin/SelectCodeList.do" />'
					,	type : 'post'
					,	dataType : "json"
					,   parameterMapping : function( data ) {
						data.purchaseGoalYear = $("#purchaseGoalYear").val() + $("#selectedDeptSeq").val();
						data.GROUP = selGroup;
						return data;
					}
				}	    
				,   result : {
					data : function(response){
						return response.list;
					},
					totalCount : function(response){
						return response.totalCount;	
					},
					error : function(response){
						alert("error");
					}	
				}
					    
			});
			
			var colArray = [];
			
			if(selGroup != "PURCHASE_GOAL"){
				
				colArray.push({
					field : "gridCheckBox"		// grid 내포 checkbox 사용할 경우 고유값 전달
						,	width : 34
						,	editControl : {
								type : "checkbox"
							,	basicUse : true
							}
						,	attributes : { class : "display:none;" }
						});
				
				colArray.push({
					field : "CODE"
						,	title : "코드"
						,	width : 50
						});						
				
				
			}else{
				
				colArray.push({
					field : "CODE"
						,	title : "적용년도"
						,	width : 50
						,	content : {
								template : function( rowData ) {
									return $("#purchaseGoalYear").val() + " 년도";
								}
							}
						});				
				
			}
			
			colArray.push({
				field : "NAME"
					,	title : selGroup == "PURCHASE_GOAL" ? "희망기업구분" : "코드명"
					,	width : 90
					,	content : {
							template : function( rowData ) {
								
								if(selGroup == "PURCHASE_GOAL"){
									return rowData.NAME;
								}else{
									return '<input '+(selGroup == "PURCHASE_GOAL" ? "readonly" : "")+' onkeyup="fnSetChangeInfo(\''+rowData.CODE+'\', \'NAME\', \''+rowData.NAME+'\', this.value)" class="puddSetup ac" type="text" value="' + rowData.NAME + '" pudd-style="height:100%;width:100%;"/>';	
								}
								
							}
						}
					});
			
			colArray.push({
				field : "NOTE"
					,	title : selGroup == "PURCHASE_GOAL" ? "목표액" : "비고"
					,	width : 70
					,	content : {
							template : function( rowData ) {
								return '<input name="goalAmt" onkeyup="fnSetChangeInfo(\''+rowData.CODE+'\', \'NOTE\', \''+rowData.NOTE+'\', this.value)" class="puddSetup '+(selGroup == "PURCHASE_GOAL" ? "ri" : "ac")+'" type="text" value="' + rowData.NOTE + '" pudd-style="height:100%;width:100%;"/>';
							}
						}
					});
			colArray.push({
				field : "ORDER_NUM"
					,	title : "정렬"
					,	width : 50
					,	content : {
							template : function( rowData ) {
								return '<input onkeyup="fnSetChangeInfo(\''+rowData.CODE+'\', \'ORDER_NUM\', \''+rowData.ORDER_NUM.toString() +'\', this.value)" class="puddSetup ac" type="text" value="' + rowData.ORDER_NUM.toString() + '" pudd-style="height:100%;width:100%;" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" />';
							}
						}
					});	
			colArray.push({
				field : "USE_YN"
					,	title : "사용여부"
					,	width : 50
					,	content : {
							template : function( rowData ) {
								return '<select style="width:50px;text-align:center;" onchange="fnSetChangeInfo(\''+rowData.CODE+'\', \'USE_YN\', \''+rowData.USE_YN+'\', this.value)"><option value="Y"' + (rowData.USE_YN == "Y" ? ' selected ' : '') + '>Y</option><option value="N"' + (rowData.USE_YN == "N" ? ' selected ' : '') + '>N</option></select>';
							}
						}
					});				
			
			Pudd("#grid2").puddGrid({
				dataSource : dataSource
			,	scrollable : false
			, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
			,	serverPaging : true	
			
			,	pageable : {
					buttonCount : 10 
				,	pageList : [ 10, 20, 30, 40, 50 ]
				,	pageInfo : true
				}
			
			,	noDataMessage : {
				message : "검색된 데이터가 없습니다."
			}		
			,	progressBar : {
			   	 
					progressType : "loading"
				,	attributes : { style:"width:70px; height:70px;" }
				,	strokeColor : "#84c9ff"	// progress 색상
				,	strokeWidth : "3px"	// progress 두께
				,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
				,	percentTextColor : "#84c9ff"
				,	percentTextSize : "12px"
				,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			}	
			
			,	columns : colArray
			
			,	loadCallback : function( headerTable, contentTable, footerTable, gridObj ) {
				
					if(selGroup == "PURCHASE_GOAL"){
						$("[name=goalAmt]").maskMoney({
							precision : 0,
							allowNegative: false
						});
					}			
		
				}			
			});	
	
		}	
		
		
		function insertLayerPop(){

			// puddDialog 함수
			Pudd.puddDialog({
			 
				width : 300
			,	height : 195
			 
			,	modal : true			// 기본값 true
			,	draggable : false		// 기본값 true
			,	resize : false			// 기본값 false
			 
			,	header : {
		 		title : "코드추가"
			,	closeButton : true	// 기본값 true
			,	closeCallback : function( puddDlg ) {
					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}
			 
			,	body : {
			 
					iframe : true
				,	url : "${pageContext.request.contextPath}/purchase/layer/CodeInsertLayer.do"
				,	iframeAttribute : {
					id : "dlgFrame"
				}				

			}
			 
				// dialog 하단을 사용할 경우 설정할 부분
			,	footer : {
			
					buttons : [
						{
							attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : "저장"
						,	clickCallback : function( puddDlg ) {
							
								var iframeTag = document.getElementById( "dlgFrame" );
								insertCodeInfo = iframeTag.contentWindow.GetInsertCodeInfo();
								insertCodeInfo.GROUP = selGroup;
								
								if(insertCodeInfo.CODE == ""){
									msgSnackbar("warning", "코드를 입력해 주세요.");
								}else if(insertCodeInfo.NAME == ""){
									msgSnackbar("warning", "코드명을 입력해 주세요.");
								}else{
									
									//중복코드 체크
									$.ajax({
										type : 'post',
										url : '<c:url value="/purchase/admin/fnCheckCodeValidation.do" />',
							    		datatype:"json",
							            data: insertCodeInfo ,
										async : false,
										success : function(result) {
											
											if(result.resultCode == "success"){
												
												puddDlg.showDialog( false );
												confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnInsertProc()', '취소', '');													
												
											}else{
												msgSnackbar("error", "이미 등록된 코드입니다.");
											}
											
										},
										error : function(result) {
											msgSnackbar("error", "삭제 실패했습니다.");
										}
									});										
								}
							}
						},
						{
							attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : "취소"
						,	clickCallback : function( puddDlg ) {
								puddDlg.showDialog( false );
							}
						}
					]
				}
			});			
			
		}		
		
		function fnInsertProc(){
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/admin/insertCommonCodeProc.do" />',
	    		datatype:"json",
	            data: insertCodeInfo ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						msgSnackbar("success", "요청하신 삭제건 처리가 완료되었습니다.");
						BindCodeGrid();
						
					}else{
						msgSnackbar("error", "삭제 실패했습니다.");
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "삭제 실패했습니다.");
				}
			});		
			
		}		
		
				
		function checkNumber(event) {
			  if(event.key >= 0 && event.key <= 9) {
			    return true;
			  }
			  
			  return false;
		}

		
		function fnSetChangeInfo(CODE, calName, oriVal, newVal){
			
			var targetObj = changeInfoList.find(obj => obj.CODE === CODE);
			
			if(oriVal != newVal && targetObj == null){
				var changeInfo = {};
				changeInfo.CODE = CODE;
				changeInfoList.push(changeInfo)
			}
			
			if(oriVal != newVal){
				changeInfoList.find(obj => obj.CODE === CODE)[calName] = newVal;
			}else if(targetObj){
				delete changeInfoList.find(obj => obj.CODE === CODE)[calName];
			}
			
			if(changeInfoList.find(obj => obj.CODE === CODE)){
				
				if(Object.keys(changeInfoList.find(obj => obj.CODE === CODE)).length == 1){
					changeInfoList.some(function(item, index) {
				    	(changeInfoList[index]["CODE"] == CODE) ? !!(changeInfoList.splice(index, 1)) : false;
				    });
				}
			}
			
			if(changeInfoList.length > 0){
				$("#adminSaveBtn").show();	
			}else{
				$("#adminSaveBtn").hide();
			}
			
		}		
		
		function fnSaveColInfo(){
			
			if(changeInfoList.length > 0){
				confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnSaveProc()', '취소', '');	
			}else{
				msgSnackbar("warning", "수정한 항목이 없습니다.");
			}
			
		}		
		
		function fnSaveProc(){
			
			var insertDataObject = {};
			insertDataObject.GROUP = selGroup;
			insertDataObject.change_info_list = JSON.stringify(changeInfoList);
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/admin/updateCommonCodeProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						msgSnackbar("success", "요청하신 변경건 처리가 완료되었습니다.");
						BindCodeGrid();
						
					}else{
						
						msgSnackbar("error", "등록에 실패했습니다.");
						
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "등록에 실패했습니다.");
				}
			});		
			
		}		
		
		var delParam = {};
		
		function fnDel(){
			
			var dataCheckedRow = Pudd( "#grid2" ).getPuddObject().getGridCheckedRowData( "gridCheckBox" );
			
		    if(dataCheckedRow && dataCheckedRow.length == 0) {
		    	msgSnackbar("error", "삭제할 코드를 선택해 주세요.");
				return;
			}
			
		    var selectedList = [];
		    
		    $.each(dataCheckedRow, function (i, t) {
		    	
		    	var selectedInfo = {};
				selectedInfo.GROUP = selGroup;
				selectedInfo.CODE = t.CODE;
				selectedList.push(selectedInfo);
		    	
		    });
		    
			delParam = {};
			delParam.GROUP = selGroup;
			delParam.change_info_list = JSON.stringify(selectedList);		
			
			confirmAlert(350, 100, 'question', '삭제하시겠습니까?', '삭제', 'fnDelProc()', '취소', '');			

		}		
		
		function fnDelProc(){
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/admin/deleteCommonCodeProc.do" />',
	    		datatype:"json",
	            data: delParam ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						msgSnackbar("success", "요청하신 삭제건 처리가 완료되었습니다.");
						BindCodeGrid();
						
					}else{
						
						msgSnackbar("error", "삭제 실패했습니다.");
						
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "삭제 실패했습니다.");
				}
			});		
			
		}
		
		
		function yearSelInut(){
			
			var thisYear = parseInt(new Date().getFullYear());
			
	    	for(var i=-10; i < 11; i++) {
	    		$("#purchaseGoalYear").append("<option value='"+(thisYear+i)+"'>"+(thisYear+i) + " 년도"+"</option>");
	    	}		
	    	
	    	$("#purchaseGoalYear").val(thisYear);
			
		}
		
		function selectOrgchart(){
			 
			 var pop = window.open("", "cmmOrgPop", "width=799,height=769,scrollbars=no");
				$("#callback").val("callbackSel");
				frmPop.target = "cmmOrgPop";
				frmPop.method = "post";
				frmPop.action = "/gw/systemx/orgChart.do";
				frmPop.submit();
				pop.focus();
		}	
		
		function callbackSel(data){
			
			if(data.returnObj.length > 0){
				$("#selectedItems").val(data.returnObj[0].superKey);
				$("#selectedDeptSeq").val(data.returnObj[0].deptSeq);
				$("#deptName").val(data.returnObj[0].deptName);				
			}else{
				$("#selectedItems").val("");
				$("#selectedDeptSeq").val("");
				$("#deptName").val("");
			}
			
			BindCodeGrid();

		 }		
		
	</script>
</head>

<body>


	<div class="sub_contents_wrap">
		<div class="twinbox">
			<table style="min-height:450px;"> 
				<colgroup>
					<col width="50%"/>
					<col />
				</colgroup>
				<tr>
					<td class="twinbox_td">
						<div class="btn_div mt0">
							<div class="left_div">							
								<h5>공통코드</h5>
							</div>
						</div>
	
						<div id="grid1"></div>			
					</td>
	
					<td class="twinbox_td">
						<div class="btn_div mt0">
							<div id="yearSelect" style="display:none;" >
								<div class="top_box">
								<dl class="next2">
									<dt class="ar" style="width:60px;">적용년도</dt>
									<dd><select id="purchaseGoalYear" onchange="BindCodeGrid()"></select></dd>
									<dt class="ar" style="width:60px;">적용부서</dt>
									<dd><input readonly type="text" id="deptName" pudd-style="width:120px;" class="puddSetup" placeHolder="미선택시 전체목표" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
									<dd><input type="button" class="puddSetup submit" id="searchButton" value="선택" onclick="selectOrgchart();" /></dd>
								</dl>
								</div>
							</div>								
							<div class="right_div">
								<div class="controll_btn p0">
									<input name="codeEditBtn" onclick="insertLayerPop();" type="button" class="puddSetup" value="추가" />
									<input name="codeEditBtn" onclick="fnDel();" type="button" class="puddSetup" value="삭제" />
									<input id="adminSaveBtn" onclick="fnSaveColInfo();"  style="background:#03a9f4;color:#fff;display:none;" type="button" class="puddSetup" value="저장" />
								</div>
							</div>
						</div>
	
						<div id="grid2"></div>	
					</td>
				</tr>
			</table>
		</div>
			
			
	</div><!-- //sub_contents_wrap -->
	<input type="hidden" id="selectedDeptSeq" value="" />
	<form id="frmPop" name="frmPop"> 
			<input type="hidden" name="selectedItems" id="selectedItems" value="" />
			<input type="hidden" name="popUrlStr" id="txt_popup_url" value="/gw/systemx/orgChart.do" />
			<input type="hidden" name="selectMode" id="selectMode" value="d" />
			<input type="hidden" name="selectItem" value="s" />
			<input type="hidden" name="callback" id="callback" value="" />
			<input type="hidden" name="compSeq" value="" />
			<input type="hidden" name="callbackUrl" value="/gw/html/common/callback/cmmOrgPopCallback.jsp"/>
			<input type="hidden" name="empUniqYn" value="N" />
			<input type="hidden" name="empUniqGroup" value="ALL" />
	</form>
</body>
</html>