<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jszip-3.1.5.min.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/FileSaver-1.2.2_1.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jexcel-1.0.5.js' />"></script> 
    
<script>

	var targetSeq = "";
	var uploadPer = 0;
	var selGroup;
	
	$(document).ready(function() {
		
		popUpResize();
		
		BindGrid();
		
		document.getElementById('file_upload').addEventListener('change', handleFileSelect, false);

	});//---documentready
	
	function popUpResize(){
		
		if(!parent.getTopMenu){
			window.resizeTo(1200, 650);
		}
		
	}	
	
	var changeInfoList = [];
	
	function fnSaveColInfo(){
		
		if(changeInfoList.length > 0){
			confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnSaveProc()', '취소', '');	
		}else{
			msgSnackbar("warning", "수정한 항목이 없습니다.");
		}
		
	}
	
	function fnSaveProc(){
		
		var insertDataObject = {};
		insertDataObject.change_info_list = JSON.stringify(changeInfoList);
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/ContractAdminChangeProc.do" />',
    		datatype:"json",
            data: insertDataObject ,
			async : false,
			success : function(result) {
				
				if(result.resultCode == "success"){
					
					msgSnackbar("success", "요청하신 변경건 처리가 완료되었습니다.");
					/* BindGrid(); */
					gridReload();
					changeInfoList = [];
					
				}else{
					
					msgSnackbar("error", "등록에 실패했습니다.");
					
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "등록에 실패했습니다.");
			}
		});		
		
	}
	
	function fnSetChangeInfo(seq, calName, oriVal, newVal){
		
		var targetObj = changeInfoList.find(obj => obj.seq === seq);
		
		if(oriVal != newVal && targetObj == null){
			var changeInfo = {};
			changeInfo.seq = seq;
			changeInfoList.push(changeInfo)
		}
		
		if(oriVal != newVal){
			changeInfoList.find(obj => obj.seq === seq)[calName] = newVal;
		}else if(targetObj){
			delete changeInfoList.find(obj => obj.seq === seq)[calName];
		}
		
		if(changeInfoList.find(obj => obj.seq === seq)){
			
			if(Object.keys(changeInfoList.find(obj => obj.seq === seq)).length == 1){
				changeInfoList.some(function(item, index) {
			    	(changeInfoList[index]["seq"] == seq) ? !!(changeInfoList.splice(index, 1)) : false;
			    });
			}
		}
		
		if(changeInfoList.length > 0){
			$("#adminSaveBtn").show();	
		}else{
			$("#adminSaveBtn").hide();
		}
		
	}
	
	function gridReload(){
		var grid = Pudd("#grid1").getPuddObject();
		if (!grid) return;
		/* grid.page( 1 ); */
		grid.refresh();

	}
	
	function BindGrid(){
		
		var dataSource = new Pudd.Data.DataSource({
				serverPaging: true
			,	editable : true
			,	pageSize: 10
			,	request : {
				    url : '<c:url value="/purchase/${authLevel}/SelectContractList.do" />'
				,	type : 'post'
				,	dataType : "json"
				,   parameterMapping : function( data ) {
					
					data.searchFromDate = $("#searchFromDate").val(); ;
					data.searchToDate = $("#searchToDate").val();
					data.contractTitle = $("#contractTitle").val();
					data.writeDeptName = $("#writeDeptName").val();
					
					<c:if test="${authLevel!='user'}">
					data.writeEmpName = $("#writeEmpName").val();
					</c:if>
					<c:if test="${authLevel=='user'}">
					data.writeEmpName = "";
					</c:if>					
					
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
		,	scrollable : true
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
					fnSetBtn(rowData);
				 
				});				
		}		
		
		,	columns : [
				{
				title : "기본정보"
			,	columns : [
				<c:if test="${authLevel=='admin'}">
				{
					field : "gridCheckBox",
					width : 34,
					editControl : {
						type : "checkbox",
						basicUse : true
					}
				},
				</c:if>
				{
					field : "no"
				,	title : "연번"
				,	width : 70
				,	content : {
						attributes : { class : "ci" }
				}
			}
/*  				,{
						field : "seq"
					,	title : "연번"
					,	width : 70
					,	content : {
							attributes : { class : "ci" }
					}
				}  */
				
			,	{
						field : "manage_no"
					,	title : "관리번호"
					,	width : 130
					/*
					,	content : {
						// param : row에 해당되는 Data, td Node 객체, tr Node 객체, grid 객체
						clickCallback : function( rowData, tdNode, trNode, gridObj ) {
							fnContractStatePop("contractView", rowData.seq);
						}
					}
					*/
				}
			,	{
						field : "contract_no"
					,	title : "계약번호"
					,	width : 120
					,	content : {		
						template : function(rowData) {
							
							<c:choose><c:when test="${authLevel=='admin'}">
							return '<input onkeyup="fnSetChangeInfo(\''+rowData.seq+'\', \'contract_no\', \''+rowData.contract_no+'\', this.value)" type="text" pudd-style="width:100%;" class="puddSetup ac" value="' + rowData.contract_no + '" />';
							</c:when><c:otherwise>
							return rowData.contract_no;
							</c:otherwise></c:choose>
							
						}
					}				
					
				},	{
		 			field : "manage_no" 
		 				,	title : "회계년도"
		 				,	width : 130
		 				,	content : {	
		 					template : function(rowData) {
		 						if (rowData.manage_no == "" ){
		 							return "";
		 						} else {
		 						var manage_no = rowData.manage_no;
		 						var manage = (rowData.manage_no).split('-');
		 						var manage_no = manage[1];
		 						return manage_no;
		 						}
		 					}
		 				}	
				}
			,	{
						field : "target_type_name"
					,	title : "계약목적물"
					,	width : 120
				}	
			,	{
					field : "contract_type_text"
				,	title : "입찰/수의"
				,	width : 100
			}
 			,{
				 field : "" 
						,	title : "계약방법"
						,	width : 100
						,	content : {		
							template : function(rowData) {
								if (rowData.contract_type == "01" && rowData.noti_type == "01"){
									return rowData.compete_type_text;
								}
								else if (rowData.contract_type == "01" && rowData.noti_type == "02"){
									return "2인견적";
								}
								else if (rowData.contract_type == "02"){
									return "1인견적";
								} else {
									return "";
								}
							}
					}
			} 
			,{
						field : "title"
					,	title : "계약명"
					,	width : 250
					,	content : {
							attributes : { class : "le ellipsis" }
					}
					,	tooltip : { 
						alwaysShow : false		// 말줄임 여부와 관계없이 tooltip 보여줄 것인지 설정, 기본값 false
					,	showAtClientX : false	// toolTip 보여주는 위치가 mouse 움직이는 X 좌표 기준 여부, 기본값 false ( toolTip 부모객체 기준 )
					}
				}				
			,	{
						field : "contract_amt"
					,	title : "계약금액"
					,	width : 130
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,{
				field : "joint_contract_method_text"
					,	title : "공동계약방법"
					,	width : 120
					}
					
					,	
			{
						field : "contract_start_dt"
					,	title : "계약시작일"
					,	width : 150	
					,	content : {		
						template : function(rowData) {
							
							<c:choose><c:when test="${authLevel=='admin'}">
							return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'contract_start_dt\', \''+rowData.contract_start_dt+'\', this.value)" type="text" value="' + rowData.contract_start_dt + '" class="puddSetup" pudd-type="datepicker"/>';
							</c:when><c:otherwise>
							return rowData.contract_start_dt;
							</c:otherwise></c:choose>
							
						}
					}					
				}
			,	{
						field : "contract_end_dt"
					,	title : "계약종료일"
					,	width : 100							
				}
			,	{
				field : "construction_dt"
			,	title : "착공일자"
			,	width : 150	
			,	content : {		
				template : function(rowData) {
					
					<c:choose><c:when test="${authLevel=='admin'}">
					return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'construction_dt\', \''+rowData.construction_dt+'\', this.value)" type="text" value="' + rowData.construction_dt + '" class="puddSetup" pudd-type="datepicker"/>';
					
					
					</c:when><c:otherwise>
					return rowData.construction_dt;
					</c:otherwise></c:choose>
					
				}
			}					
		} ,	{
				field : "completion_dt"
			,	title : "준공일자"
			,	width : 150	
			,	content : {		
				template : function(rowData) {
					
					<c:choose><c:when test="${authLevel=='admin'}">
					return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'completion_dt\', \''+rowData.completion_dt+'\', this.value)" type="text" value="' + rowData.completion_dt + '" class="puddSetup" pudd-type="datepicker"/>';
					</c:when><c:otherwise>
					return rowData.completion_dt;
					</c:otherwise></c:choose>
					
				}
			}					
		}
			
			
				]
			}
			,	{
				title : "계약상대자 정보"
			,	columns : [
				{
						field : "tr_name"
					,	title : "계약상대자"
					,	width : 100
				}					
			,	{
						field : "tr_reg_number"
					,	title : "사업자등록번호"
					,	width : 100
				}
			,	{
						field : "ceo_name"
					,	title : "대표자명"
					,	width : 100							
				},{
					field : ""
						,	title : "장단기"
						,	width : 100	
						,	content : {		
							template : function(rowData) {
								
								if(rowData.contract_term == "01" || rowData.contract_form3 == "01"){
									return "단년도";
								}
								else if(rowData.contract_term == "02" || rowData.contract_form3 == "02" ){
										return "장기계속";
								}
								else if(rowData.contract_term == "03" || rowData.contract_form3 == "03"){
											return "계속비";
								}else{
									return "";
								}

							}
						}
					}
			,	{
				field : ""
			,	title : "금액확정"
			,	width : 100	
			,	content : {		
				template : function(rowData) {
					
					if(rowData.contract_form1 == "01" || rowData.c_contract_form1 == "01"){
						return "확정계약";
					}
					else if(rowData.contract_form1 == "02" || rowData.c_contract_form1 == "02" ){
							return "사후원가검토조건부계약";
					}
					else if(rowData.contract_form1 == "03" || rowData.c_contract_form1 == "03"){
								return "개산계약";
					}else{
						return "";
					}

				}
			}
		}
			,	{
				field : ""
			,	title : "금액산정"
			,	width : 100	
			,	content : {		
				template : function(rowData) {
					
					if(rowData.contract_form2 == "01" || rowData.c_contract_form2 == "01"){
						return "총액계약";
					}
					else if(rowData.contract_form2 == "02" || rowData.c_contract_form2 == "02"){
							return "단가계약";
					}
					else{
						return "";
					}

				}
			}
		}
			,	{
						field : "hope_company_info"
					,	title : "희망기업여부"
					,	width : 100
				}						
				]
			}
			,	{
				title : "발주정보"
			,	columns : [
				{
					field : "std_amt"
				,	title : "추정가격"
				,	width : 100		
				,	content : {
					attributes : { class : "ri" }
				}
				},
				{
						field : "amt"
					,	title : "발주금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
				,{
						field : "result_amt"
					,	title : "낙찰가격"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				},{
					field : ""
						,	title : "낙찰율"
						,	width : 100
						,	content : {		
							template : function(rowData) {
								var succrate_amt = 0;
								if (rowData.result_amt != 0 && rowData.amt != 0){
									var result_amt = parseInt(rowData.result_amt.replace(/,/g, ''));
									var amt = parseInt(rowData.amt.replace(/,/g, ''));
									return (result_amt/amt*100).toFixed(1) + " %";
								} else {
									return succrate_amt + "%";
								}
								
							}
						}
				},{
						field : "compete_type_text"
					,	title : "경쟁방식"
					,	width : 100							
				}
			,	{
						field : "decision_type_text"
					,	title : "낙찰자결정방법"
					,	width : 100
					,   ellipsis : true
					,	tooltip : { 
						alwaysShow : false		// 말줄임 여부와 관계없이 tooltip 보여줄 것인지 설정, 기본값 false
					,	showAtClientX : false	// toolTip 보여주는 위치가 mouse 움직이는 X 좌표 기준 여부, 기본값 false ( toolTip 부모객체 기준 )
					}						
				}	
			,	{
						field : "emp_name"
					,	title : "기안자"
					,	width : 100
			}
			,	{
						field : "dept_name"
					,	title : "기안자부서"
					,	width : 120
			} 
/*  			,	{
						field : "c_klempname"
					,	title : "계약담당자"
					,	width : 120
					,	content : {
						template : function(rowData) {
								
						if(rowData.c_klempname != ""){
							const c_klempname = (rowData.c_klempname||"").split("▦▦▦");
								
							return c_klempname[0];
						} else {
							return "";
						}
					}
				}
 			} */
			
			,	{
				field : ""
			,	title : "업무관련자"
			,	width : 120
			,	content : {
				template : function(rowData) {
						
					if(rowData.public_info != ""){
						const arr = (rowData.public_info||"").split("▦");
						const arr1 = [];
						const public_info = [];
						
						for(var i=1; i<arr.length; i+=3){
							const arr1 = arr[i].split("(");
							for(var j=0; j<arr1.length; j+=2){
									public_info.push(arr1[j]); 
									}
								}		 
						return public_info;
					} else {
						return rowData.public_info
					}
				}
				}
			}
				]
			}
			,	{
				title : "입찰정보"
			,	columns : [
				{
						field : ""
					,	title : "사전규격공개기간"
					,	width : 150
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'pre_notice_end_dt\', \''+rowData.pre_notice_end_dt+'\', this.value)" type="text" value="' + rowData.pre_notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.pre_notice_end_dt;
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}

						}
					}
				}					
			,	{
						field : ""
					,	title : "본 공고기간"
					,	width : 290
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'notice_start_dt\', \''+rowData.notice_start_dt+'\', this.value)" type="text" value="' + rowData.notice_start_dt + '" class="puddSetup" pudd-type="datepicker"/> ~ <input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'notice_end_dt\', \''+rowData.notice_end_dt+'\', this.value)" type="text" value="' + rowData.notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.notice_start_dt != "" && rowData.notice_end_dt != "" ? (rowData.notice_start_dt + " ~ " + rowData.notice_end_dt) : "";
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}							

						}
					}
				}
			,	{
						field : ""
					,	title : "재 공고기간"
					,	width : 290			
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'re_notice_start_dt\', \''+rowData.re_notice_start_dt+'\', this.value)" type="text" value="' + rowData.re_notice_start_dt + '" class="puddSetup" pudd-type="datepicker"/> ~ <input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'re_notice_end_dt\', \''+rowData.re_notice_end_dt+'\', this.value)" type="text" value="' + rowData.re_notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.re_notice_start_dt != "" && rowData.re_notice_end_dt != "" ? (rowData.re_notice_start_dt + " ~ " + rowData.re_notice_end_dt) : "";
								</c:otherwise></c:choose>									

							}else{
								return "";
							}
							
						}
					}				
				}
			,	{
						field : ""
					,	title : "공고기간 확정"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								if(rowData.notice_start_dt != "" && rowData.notice_end_dt != ""){
									return "확정";									
								}else{
									return "";
								}
								
							}else{
								return "";
							}
							
						}
					}					
				}	
			,	{
						field : "bidder_cnt"
					,	title : "투찰자수"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onkeyup="fnSetChangeInfo(\''+rowData.seq+'\', \'bidder_cnt\', \''+rowData.bidder_cnt+'\', this.value)" type="number" style="width:50px;" class="puddSetup ac" maxlength="2" value="' + rowData.bidder_cnt + '" /> 건';
								</c:when><c:otherwise>
								return rowData.bidder_cnt + (rowData.bidder_cnt != " 건" ? "" : ""); 
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}							
							
						}
					}
			}
			,	{
						field : "meet_dt"
					,	title : "제안서평가일"
					,	width : 180
			}					
				]
			}
			,	{
				title : "변경계약정보"
			,	columns : [
				{
						field : ""
					,	title : "변경계약일"
					,	width : 150
					,	content : {		
						template : function(rowData) {
							
							if(rowData.doc_sts_change == "90"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'contract_change_dt\', \''+rowData.contract_change_dt+'\', this.value)" type="text" value="' + rowData.contract_change_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.contract_change_dt; 
								</c:otherwise></c:choose>								
								
							}else if(rowData.doc_sts_change != "" && rowData.doc_sts_change != "10"){
								return rowData.contract_change_dt;
							}else{
								return "";
							}
							
						}
					}
				}					
			,	{
						field : "work_info_after"
					,	title : "과업내용변경"
					,	width : 100
				}
			,	{
						field : "contract_end_dt_after"
					,	title : "계약기간변경"
					,	width : 100							
				}	
			,	{
						field : ""
					,	title : "계약금액변경"
					,	width : 100		
					
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_amt_after != "" && rowData.contract_amt_after != "0"){
								return rowData.contract_amt_after + " 원";
							}else{
								return "";
							}
							
						}
					}					
					
				}	
			,	{
						field : "change_etc"
					,	title : "기타변경"
					,	width : 100							
				}
			,	{
				field : "change_reason"
			,	title : "변경사유"
			,	width : 100							
		}
				]
			}
			,	{
				title : "대금지급정보"
			,	columns : [
				{
						field : "pay_amt_a"
					,	title : "선금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "pay_amt_b"
					,	title : "기성금합산"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "pay_amt_c"
					,	title : "준공금"
					,	width : 100	
					,	content : {
							attributes : { class : "ri" }
					}						
				}
 			,	{
				field : ""
			,	title : "집행액"
			,	width : 100
			,	content : {
				attributes : { class : "ri" },
				template : function(rowData) {
					var pay_amt_a = rowData.pay_amt_a;
					var pay_amt_b = rowData.pay_amt_b;
					var pay_amt_c = rowData.pay_amt_c;
					
					
					if((pay_amt_a != "" && pay_amt_a != "0") || (pay_amt_b != "" && pay_amt_b != "0") || (pay_amt_c != "" && pay_amt_c != "0") ){
						 pay_amt_a = parseInt(rowData.pay_amt_a.replace(/,/g, ''));
						 pay_amt_b = parseInt(rowData.pay_amt_b.replace(/,/g, ''));
						 pay_amt_c = parseInt(rowData.pay_amt_c.replace(/,/g, ''));
						 
						 var sum_pay_amt = pay_amt_a + pay_amt_b + + pay_amt_c;
						 
						return sum_pay_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						
					}
					else if (pay_amt_a == "0" || pay_amt_a == "0" || pay_amt_a == "0"){
						 pay_amt_a = parseInt(rowData.pay_amt_a);
						 pay_amt_b = parseInt(rowData.pay_amt_b);
						 pay_amt_c = parseInt(rowData.pay_amt_c);
						 
						 return (pay_amt_a+pay_amt_b+pay_amt_c);
					}else {
						return "";
					}
				}
			}						
		} 
			,	{
						field : "remain_amt"
					,	title : "잔액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : ""
					,	title : "준공율"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.remain_amt != ""){
								
								var amt = parseInt(rowData.contract_amt.replace(/,/g, ''));
								var remain_amt = parseInt(rowData.remain_amt.replace(/,/g, ''));
								
								return ((amt-remain_amt)/amt*100).toFixed(1) + " %";
								
							}else{
								return "";
							}
							
						}
					}						
				}			
				]
			}
			,	{
				title : "자료"
			,	columns : [
				{
						field : ""
					,	title : "계약서"
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function(rowData) {
							
							if(rowData.contract_attach_info != ""){
								var attachInfo =  rowData.contract_attach_info.split("▦");
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="'+attachInfo[2]+'" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px;" ><img name="uploadFileIco" src="${pageContext.request.contextPath}' + fncGetFileClassImg(attachInfo[1]) + '" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName">' + attachInfo[0] + attachInfo[1] + '<span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'contract_attach_info\', this)" /></c:if></div>';	
							}else{
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px; display:none;" ><img name="uploadFileIco" src="" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName"><span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'contract_attach_info\', this)" /></c:if></div>';
							}
							
						}
					}
				}					
			,	{
						field : ""
					,	title : "계약제출서류"
					,	width : 100
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function(rowData) {
							
							if(rowData.submit_attach_info != ""){
								var attachInfo =  rowData.submit_attach_info.split("▦");
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="'+attachInfo[2]+'" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px;" ><img name="uploadFileIco" src="${pageContext.request.contextPath}' + fncGetFileClassImg(attachInfo[1]) + '" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName">'+attachInfo[0]+attachInfo[1]+'<span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'submit_attach_info\', this)" /></c:if></div>';	
							}else{
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px; display:none;" ><img name="uploadFileIco" src="" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName"><span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'submit_attach_info\', this)" /></c:if></div>';
							}							
							
						}
					}
				}			
				]
			}
		]
		

	});	
		
	} 	
	
	var attachTargetSeq;
	var attachTargetColName;
	var attachTargetObj;
	
	function fnSearchFile(seq, colName, el){
		attachTargetSeq = seq;
		attachTargetColName = colName;
		attachTargetObj = $(el).closest("td");
		
		$("#file_upload").click();
	}
	
	function handleFileSelect(evt) {
		
	    evt.stopPropagation();
	    evt.preventDefault();
	    
	    var f = evt.target.files[0];
	
	    var fileEx = "";
	    var lastDot = f.name.lastIndexOf('.');
	    
	    if(lastDot > 0){
	    	
	    	f.uid = '<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMdd"/>' + getUUID();
	    	f.fileName = f.name.substr(0, lastDot);
	    	f.fileExt = f.name.substr(lastDot);
		
			var abort = false;
			var formData = new FormData();
			var nfcFileNames = btoa(unescape(encodeURIComponent(f.name)));
	           
			formData.append("file0", f);
			formData.append("fileId", f.uid);
			formData.append("nfcFileNames", nfcFileNames);
	   	    
			fnSetProgress();
	
	        var AJAX = $.ajax({
	        	url: '<c:url value="/ajaxFileUploadProc.do" />',
	            type: 'POST',
	        	timeout:600000,
	            xhr: function () {
	                   myXhr = $.ajaxSettings.xhr();
	
	                   if (myXhr.upload) {
	                       myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
	                       myXhr.abort;
	                   }
	                   return myXhr;
	             },
	             success: completeHandler = function (data) {
	               	
	                fnRemoveProgress();
	               	
	                $(attachTargetObj).find('em').attr("fileid", f.uid).show();
	                $(attachTargetObj).find('[name="uploadFileName"]').text(f.fileName + f.fileExt);
	                $(attachTargetObj).find('[name="uploadFileIco"]').attr("src", "${pageContext.request.contextPath}" + fncGetFileClassImg(f.fileExt));
	                
	                fnSetChangeInfo(attachTargetSeq, attachTargetColName, "", f.fileName + "▦" + f.fileExt + "▦" + f.uid);
					
	               },
	               error: errorHandler = function () {
	
	                   if (abort) {
	                       alert('업로드를 취소하였습니다.');
	                   } else {
	                       alert('첨부파일 처리중 장애가 발생되었습니다. 다시 시도하여 주십시오');
	                   }
	
	                   //UPLOAD_COMPLITE = false;
	                   fnRemoveProgress();
	               },
	               data: formData,
	               cache: false,
	               contentType: false,
	               processData: false
	           });	
	    	
	    }
	    
	  	$('#file_upload').val("");
	    
	}
  
	function progressHandlingFunction(e) {
	    if (e.lengthComputable) {
	    	
	    	uploadPer = parseInt((e.loaded / e.total) * 100);
	    }
	}			    
  
	function fnSetProgress() {
		
		uploadPer = 0;
	
		Pudd( "#exArea" ).puddProgressBar({
			 
			progressType : "circular"
		,	attributes : { style:"width:70px; height:70px;" }
		 
		,	strokeColor : "#00bcd4"	// progress 색상
		,	strokeWidth : "3px"	// progress 두께
		 
		,	textAttributes : { style : "" }		// text 객체 속성 설정
		 
		,	percentText : ""
		,	percentTextColor : "#444"
		,	percentTextSize : "24px"
		,	backgroundLayerAttributes : { style : "background-color:#000;filter:alpha(opacity=20);opacity:0.2;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
		,	modal : true// 기본값 false - progressType : linear, circular 인 경우만 해당
		 
			// 200 millisecond 마다 callback 호출됨
		,	progressCallback : function( progressBarObj ) {
				return uploadPer;
			}
		});		    	
		
	}		    
  
	function fnRemoveProgress() {
		uploadPer = 100;
	}	
	
	function fnDownload(e){
		this.location.href = "${pageContext.request.contextPath}/fileDownloadProc.do?fileId=" + $(e).attr("fileid");
	}	
	
	function fnSetBtn(rowData){
		
		if(targetSeq == rowData.seq){
			return;
		}
		
		var reqParam = {};
		reqParam.seq = rowData.seq;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/ContractInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				
				console.log("seq > " + result.resultData.seq);
				console.log("contract_type > " + result.resultData.contract_type);
				console.log("doc_sts > " + result.resultData.doc_sts);
				console.log("approkey_plan > " + result.resultData.approkey_plan);
				console.log("approkey_meet > " + result.resultData.approkey_meet);
				console.log("approkey_result > " + result.resultData.approkey_result);
				console.log("approkey_conclusion > " + result.resultData.approkey_conclusion);
				console.log("approkey_change > " + result.resultData.approkey_change);
				console.log("doc_sts_change > " + result.resultData.doc_sts_change);
				console.log("change_seq > " + result.resultData.change_seq);
				console.log("change_seq_temp > " + result.resultData.change_seq_temp);
				
				var planState = "";
				var meetState = "";		
				var resultState = "";
				var conclusionState = "";
				var changeState = "";
				var paymentState = "";
				
				if(result.resultData.contract_type == "01"){
					
					//입찰
					planState = "V";
					
					if(result.resultData.approkey_conclusion != ""){
						
						meetState = "V";		
						resultState = "V";
						conclusionState = "V";				
						
						if(result.resultData.doc_sts == "90"){
							
							paymentState = "C";
							
							if(result.resultData.doc_sts_change == "10" || result.resultData.doc_sts_change == "20"){
								changeState = "V";					
							}else{
								changeState = "C";
							}
							
						}				
						
					}else if(result.resultData.approkey_result != ""){
						
						meetState = "V";		
						resultState = "V";	
						
						if(result.resultData.doc_sts == "90"){
							conclusionState = "C";	
						}
						
					}else if(result.resultData.approkey_meet != ""){
						
						meetState = "V";
						
						if(result.resultData.doc_sts == "90"){
							resultState = "C";	
						}				
						
					}else if(result.resultData.approkey_plan != ""){
						
						if(result.resultData.doc_sts == "90"){
							meetState = "C";	
						}
						
					}else{
						planState = "C";
					}
					
				}else{
					
					//수의
					conclusionState = "V";
					
					if(result.resultData.doc_sts == "90"){
						
						if(result.resultData.doc_sts_change == "" || result.resultData.doc_sts_change == "90"){
							paymentState = "C";
							changeState = "C";
						}else{
							//변경계약 진행
							changeState = "V";
						}
					}else if(result.resultData.doc_sts == "" || result.resultData.doc_sts == "10"){
						conclusionState = "C";
					}
					
				}
				
				var btnList = [];
				
				if(planState != ""){
					
					var btnStyle = planState == "C" ? "submit" : "cancel";
					var btnName = planState == "C" ? "입찰발주 의뢰" : "입찰발주 조회";					
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnCallBtn('contractView', result.resultData.seq);
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}		
				
				if(meetState != ""){
					
					var btnStyle = meetState == "C" ? "submit" : "cancel";
					var btnName = meetState == "C" ? "제안서평가위원회 개최" : "제안서평가위원회 개최 조회";
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnContractStatePop('btnMeet');
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}
				
				if(resultState != ""){
					
					var btnStyle = resultState == "C" ? "submit" : "cancel";
					var btnName = resultState == "C" ? "제안서평가결과등록" : "제안서평가결과조회";
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnContractStatePop('btnResult');
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}			

				if(conclusionState != ""){
					
					var btnStyle = conclusionState == "C" ? "submit" : "cancel";
					var btnName = conclusionState == "C" ? "계약체결품의" : "계약체결조회";
					
					var btnInfo = {
						attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
					,	value : btnName
					,	clickCallback : function( puddActionBar ) {
						
							fnCallBtn("btnConclusion", result.resultData.seq);
							
							$('.iframe_wrap').attr('onclick','').unbind('click');
							puddActionBar.showActionBar( false );
							targetSeq = "";
							
						}
					}

					btnList.push(btnInfo);			
					
				}
				
				if(changeState != ""){
					
					var btnStyle = changeState == "C" ? "submit" : "cancel";
					var btnName = changeState == "C" ? "변경계약체결" : "변경계약조회";
					
					var btnInfo = {
						attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
					,	value : btnName
					,	clickCallback : function( puddActionBar ) {
							fnContractStatePop('btnConclusionChange');
							
							$('.iframe_wrap').attr('onclick','').unbind('click');
							puddActionBar.showActionBar( false );
							targetSeq = "";
						}
					}

					btnList.push(btnInfo);			
					
				}		
				
				
				if(paymentState != ""){
					
					var btnStyle = "submit";
					var btnName = "대금지급";
					
					var btnInfo = {
						attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
					,	value : btnName
					,	clickCallback : function( puddActionBar ) {
							fnContractStatePop('btnConclusionPayment');
							
							$('.iframe_wrap').attr('onclick','').unbind('click');
							puddActionBar.showActionBar( false );
							targetSeq = "";
						}
					}
					btnList.push(btnInfo);			
				}	
				
				//닫기버튼
				var btnCancel = {
					attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
				,	controlAttributes : { class : "cancel", style : "background: #000000;color:#fff;border-color: #484848;" }// control 자체 객체 속성 설정
				,	value : "닫기"
				,	clickCallback : function( puddActionBar ) {
						puddActionBar.showActionBar( false );
						targetSeq = "";
					}
				}
				btnList.push(btnCancel);				
				
				
				puddActionBar_ = Pudd.puddActionBar({
					 
					height	: 100
				,	message : {
							type : "html"		// text, html
						,	content : '<span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #ffffff;">[ ' + (result.resultData.c_title ? result.resultData.c_title : result.resultData.title) + ' ]</span></br><span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #c2c2c2;">상세조회 항목을 선택해 주세요</span>'				
					}
				
				,	buttons : btnList	
				
				});
				
				targetSeq = result.resultData.seq;

				$(".iframe_wrap").on("click", function(e){
					
					if($("#grid1").find(e.target).length == 0){
						puddActionBar_.showActionBar( false );
						targetSeq = "";
						$('.iframe_wrap').attr('onclick','').unbind('click');
					}
					
				});
				
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});			
	}
	
	var puddActionBar_;
	
	function fnCallBtn(callId, seq, sub_seq){
		
		if(callId == "newContract"){
			//입찰발주계획 신규
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractCreatePop.do",  "ContractCreatePop", 1200, 900, 1, 1) ;
			
		}else if(callId == "contractView"){
			//입찰발주계획 조회
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractCreatePop.do?seq=" + seq,  "ContractViewPop", 1200, 900, 1, 1) ;
			
		}else if(callId == "newConclusion"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionCreatePop.do",  "ConclusionCreatePop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnConclusion"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionCreatePop.do?seq=" + (seq != null ? seq : targetSeq),  "ConclusionViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "newConclusionChange"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionChangePop.do?seq=" + (seq != null ? seq : targetSeq),  "ConclusionChangeCreatePop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnConclusionChange"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionChangePop.do?seq=" + (seq != null ? seq : targetSeq) + "&change_seq=" + sub_seq,  "ConclusionChangeViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnConclusionPayment"){
			
			if('${resFormSeq}' != ''){
				openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionPaymentPop.do?formSeq=${resFormSeq}&seq=" + (seq != null ? seq : targetSeq),  "ConclusionPaymentViewPop", 1350, 800, 1, 1) ;	
			}else{
				msgSnackbar("warning", "대금지급 지출결의 양식코드 미설정");
			}
			
		}else if(callId == "btnMeet"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractMeetPop.do?seq=" + targetSeq,  "ContractMeetViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnResult"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractResultPop.do?seq=" + targetSeq,  "ContractResultViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnSave"){
			
			fnSaveColInfo();
			
		}else if(callId == "btnSelect"){
			
			puddActionBar_ = Pudd.puddActionBar({
				 
				height	: 100
			,	message : {
		 
						type : "text"		// text, html
					,	content : "상세조회 항목을 선택해 주세요"
					//	type : "html"		// text, html
					//,	content : '<span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #ffffff;">결재문서를 상신하시겠습니까?</span>'
				}
			,	buttons : [
						{
								attributes : { style : "margin-top:4px;width:auto;" }// control 부모 객체 속성 설정
							,	controlAttributes : { id : "", class : "submit" }// control 자체 객체 속성 설정
							,	value : "계약입찰발주계획 상세"
							,	clickCallback : function( puddActionBar ) {
									fnCallBtn("contractView", seq);
									
									$('.iframe_wrap').attr('onclick','').unbind('click');
									puddActionBar.showActionBar( false );
								}
						}
					,	{
								attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
							,	controlAttributes : { id : "", class : "submit" }// control 자체 객체 속성 설정
							,	value : "계약체결 상세"
							,	clickCallback : function( puddActionBar ) {
									fnCallBtn("btnConclusion", seq);
									
									$('.iframe_wrap').attr('onclick','').unbind('click');
									puddActionBar.showActionBar( false );
								}
						}
				]
		});			
			
			setTimeout(function() {
				$(".iframe_wrap").on("click", function(e){puddActionBar_.showActionBar( false );$('.iframe_wrap').attr('onclick','').unbind('click');});
			}, 200);				
			
			
		}else {
			msgSnackbar("warning", "개발중입니다.");
		}
		
	}
	
	function fnContractStatePop(btnType, seq){
		
		if(seq == null && targetSeq == ""){
			
			if(btnType == "btnConclusion"){
				fnCallBtn("newConclusion");	
			}else{
				msgSnackbar("warning", "등록하실 계약건을 선택해 주세요.");
			}
			
			return;
		}
		
		var reqParam = {};
		
		if(seq){
			reqParam.seq = seq;
		}else{
			reqParam.seq = targetSeq;	
		}
		
		var resultState = false;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/ContractInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : false,
			success : function(result) {
				
				console.log("seq > " + result.resultData.seq);
				console.log("contract_type > " + result.resultData.contract_type);
				console.log("doc_sts > " + result.resultData.doc_sts);
				console.log("approkey_plan > " + result.resultData.approkey_plan);
				console.log("approkey_meet > " + result.resultData.approkey_meet);
				console.log("approkey_result > " + result.resultData.approkey_result);
				console.log("approkey_conclusion > " + result.resultData.approkey_conclusion);
				console.log("approkey_change > " + result.resultData.approkey_change);
				console.log("doc_sts_change > " + result.resultData.doc_sts_change);
				console.log("change_seq > " + result.resultData.change_seq);
				console.log("change_seq_temp > " + result.resultData.change_seq_temp);
				
				if(btnType == "btnConclusionPayment"){
					
					if(result.resultData.doc_sts_change == "20"){
						//변경계약 결재 진행중
						msgSnackbar("warning", "진행중인 변경계약건이 있어 대금지급 신청이 불가합니다.");
						return;							
					}else{
						resultState = true;
					}
					
				}else if(btnType == "btnConclusionChange"){
					
					if(result.resultData.change_seq_temp != ""){
						fnCallBtn("btnConclusionChange", result.resultData.seq, result.resultData.change_seq_temp);
						return;							
					}else if(result.resultData.doc_sts_change == "10" || result.resultData.doc_sts_change == "20"){
						fnCallBtn("btnConclusionChange", result.resultData.seq, result.resultData.change_seq);
						return;							
					}else if(result.resultData.approkey_conclusion != "" && result.resultData.doc_sts == "90") {
						resultState = true;
						btnType = "newConclusionChange";
					}
					
				}else if(btnType == "contractView"){
					
					resultState = true;
					
					if(result.resultData.contract_type == "02"){
						btnType = "btnConclusion";
					}else if(result.resultData.c_title != null && result.resultData.c_title != ""){
						btnType = "btnSelect";
					}
					
				}else if(btnType == "btnConclusion"){
					
					if(result.resultData.approkey_conclusion != "" || (result.resultData.approkey_result != "" && result.resultData.doc_sts == "90")){
						resultState = true;
					}
					
				}else if(result.resultData.approkey_result != ""){
					
					if(btnType == "btnMeet" || btnType == "btnResult"){
						resultState = true;
					}
					
				}else if(result.resultData.approkey_meet != ""){
					
					if(btnType == "btnMeet" || (btnType == "btnResult" && result.resultData.doc_sts == "90")){
						resultState = true;
					}
					
				}else if(result.resultData.approkey_plan != ""){
					
					if(btnType == "btnMeet" && result.resultData.doc_sts == "90"){
						resultState = true;
					}
					
				}
				
				if(resultState){
					
					fnCallBtn(btnType, seq);
					
				}else{
					msgSnackbar("warning", "이전 단계의 기안 신청이 완료되지 않았습니다.");
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});		
	}
	
	
    function excelDown() {
        
    	Pudd( "#circularProgressBar" ).puddProgressBar({
     
    		progressType : "circular"
    	,	attributes : { style:"width:150px; height:150px;" }
    	,	strokeColor : "#00bcd4"	// progress 색상
    	,	strokeWidth : "3px"	// progress 두께
    	,	percentText : ""
    	,	percentTextColor : "#fff"
    	,	percentTextSize : "24px"
    	,	modal : true
    	,	extraText : {
    			text : ""
    		,	attributes : { style : "" }
    		}
    	,	progressStartCallback : function( progressBarObj ) {
     
    			excelDownloadProcess( "계약현황.xlsx", progressBarObj );
    		}
    	});
    }	
	
    function excelDownloadProcess( fileName, progressBarObj ) {
        
    	var dataSourceList = new Pudd.Data.DataSource({
     
    		pageSize : 999999
    	,	serverPaging : true
     
    	,	request : {
     
    			url : '<c:url value="/purchase/${authLevel}/SelectContractList.do" />'
    		,	type : 'post'
    		,	dataType : "json"
     
    		,	parameterMapping : function( data ) {
     
	    			data.searchFromDate = $("#searchFromDate").val();
	    			data.searchToDate = $("#searchToDate").val();
	    			data.contractTitle = $("#contractTitle").val();
	    			data.writeDeptName = $("#writeDeptName").val();
	    			<c:if test="${authLevel!='user'}">
	    			data.writeEmpName = $("#writeEmpName").val();
	    			</c:if>
	    			<c:if test="${authLevel=='user'}">
	    			data.writeEmpName = "";
	    			</c:if>	
	 				return data ;
    			}
    		}
     
    	,	result : {
     
    			data : function( response ) {
     
    				return response.list;
    			}
     
    		,	totalCount : function( response ) {
     
    				return response.totalCount;
    			}
     
    		,	error : function( response ) {
     
    				//alert( "error - Pudd.Data.DataSource.read, status code - " + response.status );
    			}
    		}
    	});
     
    	progressBarObj.updateProgressBar( 10 );// 10%
     
    	setTimeout( function() {
     
    		dataSourceList.read( false, function(){
     
    			if( true === dataSourceList.responseResult ) {// success
     
    				progressBarObj.updateProgressBar( 40 );// 40%
     
    				// json data 저장
    				var dataPage = dataSourceList.dataPage;
    				var dataLen = dataPage.length;
     
    				// excel파일 다운로드 처리
    				generateExcelDownload( dataPage, fileName, function() {// saveCallback
     
    					progressBarObj.updateProgressBar( 100 );// 100%
    					progressBarObj.clearIntervalSet();// progressBar 종료
     
    				}, function( rowIdx ){// stepCallback
     
    					if( dataLen ) {
     
    						var percent = ( ( rowIdx * 100 / dataLen ) / 2 ) + 40;
    						percent = parseInt( percent );
     
    						progressBarObj.updateProgressBar( percent );
    					}
    				});
     
    			} else {// error
     
    				progressBarObj.clearIntervalSet();// progressBar 종료
    			}
    		});
    	}, 10);
    }    
    
    
    var modifyParam = {};
	
	function fnModify(){
		
		var dataCheckedRow = Pudd( "#grid1" ).getPuddObject().getGridCheckedRowData( "gridCheckBox" );
		
	    if(dataCheckedRow && dataCheckedRow.length == 0) {
	    	msgSnackbar("error", "품의환원 할 데이터를 선택해 주세요.");
			return;
		}
		
	    var selectedList = [];
	    
	    $.each(dataCheckedRow, function (i, t) {
	    	
	    	var selectedInfo = {};
			selectedInfo.seq = t.seq;
			selectedList.push(selectedInfo);
	    	
	    });
	    
	    modifyParam = {};
	    modifyParam.seq = selGroup;
	    modifyParam.change_info_list = JSON.stringify(selectedList);		
		
		confirmAlert(350, 100, 'question', '품의환원 하시겠습니까?', '확인', 'fnModifyProc()', '취소', '');			

	}	
    
	
	function fnModifyProc(){
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/modifyContractList.do" />',
    		datatype:"json",
            data: modifyParam ,
			async : false,
			success : function(result) {
				
				if(result.resultCode == "success"){
					
					msgSnackbar("success", "요청하신 품의 환원건 처리가 완료되었습니다.");
					gridReload();
					
				}else{
					msgSnackbar("error", "결재 완료되지 않은 데이터가 있습니다.");
					
				}	
			},
			error : function(result) {
				msgSnackbar("error", "품의 환원을 실패했습니다.");
			}
		});		
		
	}
	
    
    
    
    var delParam = {};
	
	function fnDel(){
		
		var dataCheckedRow = Pudd( "#grid1" ).getPuddObject().getGridCheckedRowData( "gridCheckBox" );
		
	    if(dataCheckedRow && dataCheckedRow.length == 0) {
	    	msgSnackbar("error", "삭제할 데이터를 선택해 주세요.");
			return;
		}
		
	    var selectedList = [];
	    
	    $.each(dataCheckedRow, function (i, t) {
	    	
	    	var selectedInfo = {};
			selectedInfo.seq = t.seq;
			selectedList.push(selectedInfo);
	    	
	    });
	    
		delParam = {};
		delParam.seq = selGroup;
		delParam.change_info_list = JSON.stringify(selectedList);		
		
		confirmAlert(350, 100, 'question', '삭제하시겠습니까?', '삭제', 'fnDelProc()', '취소', '');			

	}		
	
	function fnDelProc(){
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/deleteContractList.do" />',
    		datatype:"json",
            data: delParam ,
			async : false,
			success : function(result) {
				
				if(result.resultCode == "success"){
					
					msgSnackbar("success", "요청하신 삭제건 처리가 완료되었습니다.");
					/* BindGrid(); */
					gridReload();
					
				}else{
					
					msgSnackbar("error", "결재완료 또는 결재중인 데이터가 있습니다");
					
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "삭제 실패했습니다.");
			}
		});		
		
	}
    
    
    
    
    function generateExcelDownload( dataPage, fileName, saveCallback, stepCallback ) {
        
    	var excel = new JExcel("맑은 고딕 11 #333333");
    	excel.set( { sheet : 0, value : "Sheet1" } );
     	
		var totalCount = dataPage.length;
		
    	// 엑셀 상단 기간 세팅
    	var periodStyle = excel.addStyle({
    		font: "맑은 고딕 11 #333333 B"
    	})
    	var period = "계약기간: " + $("#searchFromDate").val() + "~" + $("#searchToDate").val() + " / 총 " + totalCount + "건"; 
    	excel.set(0, 0, 0, period, periodStyle);
    	
    	var formatHeader = excel.addStyle ({
    		border: "thin,thin,thin,thin #000000",
    		fill: "#dedede",
    		font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
    		align : "C C",
    	});
		    	
    	var headerRow = 3;
    	var headerCol = 51;
    	
    	for(var i=1; i < headerRow; i++) {
    		for(var j=0; j < headerCol; j++) {
    			excel.set(0, j, i, null, formatHeader);
    		}
    	}
    	
    	excel.set(0, 0, 1, "기본정보");
    	excel.mergeCell(0, 0, 1, 14, 1);
    	excel.set(0, 0, 2, "연번");
    	excel.set(0, 1, 2, "관리번호");
    	excel.set(0, 2, 2, "계약번호");
    	excel.set(0, 3, 2, "회계년도"); 
    	excel.set(0, 4, 2, "계약목적물");
    	excel.set(0, 5, 2, "입찰/수의");
    	excel.set(0, 6, 2, "계약방법"); 
    	excel.set(0, 7, 2, "계약명");
    	excel.set(0, 8, 2, "계약금액");
    	excel.set(0, 9, 2, "공동계약방법");
    	excel.set(0, 10, 2, "계약시작일");
    	excel.set(0, 11, 2, "계약종료일");
    	excel.set(0, 12, 2, "착공일자"); 
    	excel.set(0, 13, 2, "준공일자");
    	excel.set(0, 14, 2, "근거법령");
    	
    	excel.set(0, 15, 1, "계약상대자정보");
    	excel.mergeCell(0, 15, 1, 21, 1);
    	excel.set(0, 15, 2, "계약상대자");
    	excel.set(0, 16, 2, "사업자등록번호");
    	excel.set(0, 17, 2, "대표자명");
    	excel.set(0, 18, 2, "장단기");
    	excel.set(0, 19, 2, "금액확정");
    	excel.set(0, 20, 2, "금액산정");
    	excel.set(0, 21, 2, "희망기업여부");
    	
    	excel.set(0, 22, 1, "발주정보");
    	excel.mergeCell(0, 22, 1, 30, 1);
    	excel.set(0, 22, 2, "추정가격");
    	excel.set(0, 23, 2, "발주금액");
    	excel.set(0, 24, 2, "낙찰가격");
    	excel.set(0, 25, 2, "낙찰율"); 
    	excel.set(0, 26, 2, "경쟁방식");
    	excel.set(0, 27, 2, "낙찰자결정방법");    	
    	excel.set(0, 28, 2, "기안자");    	
    	excel.set(0, 29, 2, "기안자부서");
    	excel.set(0, 30, 2, "업무관련자"); 
    	
    	excel.set(0, 31, 1, "입찰정보");
    	excel.mergeCell(0, 31, 1, 36, 1);
    	excel.set(0, 31, 2, "사전규격공개기간");
    	excel.set(0, 32, 2, "본 공고기간");
    	excel.set(0, 33, 2, "재 공고기간");
    	excel.set(0, 34, 2, "공고기간 확정");    	
    	excel.set(0, 35, 2, "투찰자수");    	
    	excel.set(0, 36, 2, "제안서평가일");     
   
    	excel.set(0, 37, 1, "변경계약정보");
    	excel.mergeCell(0, 37, 1, 42, 1);
    	excel.set(0, 37, 2, "변경계약일");
    	excel.set(0, 38, 2, "과업내용변경");
    	excel.set(0, 39, 2, "계약기간변경");
    	excel.set(0, 40, 2, "계약금액변경");    	
    	excel.set(0, 41, 2, "기타변경");
    	excel.set(0, 42, 2, "변경사유"); 
    	
    	excel.set(0, 43, 1, "대금지급정보");
    	excel.mergeCell(0, 43, 1, 48, 1);
    	excel.set(0, 43, 2, "선금액");
    	excel.set(0, 44, 2, "기성금합산");
    	excel.set(0, 45, 2, "준공금");
    	excel.set(0, 46, 2, "집행액"); //
    	excel.set(0, 47, 2, "잔액");    	
    	excel.set(0, 48, 2, "준공율");    	
    	
    	excel.set(0, 49, 1, "자료");
    	excel.mergeCell(0, 49, 1, 50, 1);
    	excel.set(0, 49, 2, "계약서");
    	excel.set(0, 50, 2, "계약제출서류");
    	
    	// sheet번호, column, value(width)
    	for( var i = 0; i < 51; i++ ) {
    		excel.setColumnWidth( 0, i, 20 );
    	}    	
    	
    	excel.setColumnWidth( 0, 5, 50 );
    	excel.setColumnWidth( 0, 9, 50 );
    	
    	excel.setColumnWidth( 0, 13, 25 );
    	excel.setColumnWidth( 0, 20, 25 );
    	excel.setColumnWidth( 0, 21, 25 );
    	excel.setColumnWidth( 0, 24, 25 );
    	
    	var formatCell = excel.addStyle ({
    		align : "C"
    	});
    	
    	// header row 이후부터 출력
    	for( var i = 0; i < totalCount; i++ ) {
    		var rowNo = i + 3;
    		excel.set( 0, 0, rowNo, dataPage[ i ][ "no" ], formatCell );
    		excel.set( 0, 1, rowNo, dataPage[ i ][ "manage_no" ], formatCell );
    		excel.set( 0, 2, rowNo, dataPage[ i ][ "contract_no" ], formatCell );
    		
			if(dataPage[ i ][ "manage_no" ] != ""){
				var manage = dataPage[ i ][ "manage_no" ].split('-');
				var manage_yaer = manage[1]
				excel.set( 0, 3, rowNo, manage_yaer, formatCell ); // 회계년도
			}   
			
    		excel.set( 0, 4, rowNo, dataPage[ i ][ "target_type_name" ], formatCell );
    		excel.set( 0, 5, rowNo, dataPage[ i ][ "contract_type_text" ], formatCell );
    			
			if(dataPage[ i ][ "contract_type" ] != "" || dataPage[ i ][ "noti_type" ] != "" || dataPage[ i ][ "compete_type_text" ] != "" ){ // 계약방법 구분
				
				if(dataPage[ i ][ "contract_type" ] == "01" && dataPage[ i ][ "noti_type" ] == "01"){
					excel.set( 0, 6, rowNo, dataPage[ i ][ "compete_type_text" ], formatCell ); 
				} else if (dataPage[ i ][ "contract_type" ] == "01" && dataPage[ i ][ "noti_type" ] == "02") {
					excel.set( 0, 6, rowNo, "2인견적",formatCell ); 
				} else if (dataPage[ i ][ "contract_type" ] == "02") {
					excel.set( 0, 6, rowNo, "1인견적", formatCell ); 
				} else {
					excel.set( 0, 6, rowNo, "", formatCell ); 
				}	
			}   

    		excel.set( 0, 7, rowNo, dataPage[ i ][ "title" ], formatCell );
    		excel.set( 0, 8, rowNo, dataPage[ i ][ "contract_amt" ], formatCell );
    		excel.set( 0, 9, rowNo, dataPage[ i ][ "joint_contract_method_text" ], formatCell ); // 공동계약방법
    		excel.set( 0, 10, rowNo, dataPage[ i ][ "contract_start_dt" ], formatCell );
    		excel.set( 0, 11, rowNo, dataPage[ i ][ "contract_end_dt" ], formatCell );
    		excel.set( 0, 12, rowNo, dataPage[ i ][ "construction_dt" ], formatCell ); // 착공일자
    		excel.set( 0, 13, rowNo, dataPage[ i ][ "completion_dt" ], formatCell ); // 준공일자
    		excel.set( 0, 14, rowNo, dataPage[ i ][ "base_law_name" ], formatCell );
    		excel.set( 0, 15, rowNo, dataPage[ i ][ "tr_name" ], formatCell );
    		excel.set( 0, 16, rowNo, dataPage[ i ][ "tr_reg_number" ], formatCell );
    		excel.set( 0, 17, rowNo, dataPage[ i ][ "ceo_name" ], formatCell );
    		
    		if(dataPage[ i ][ "contract_term" ] != "" || dataPage[ i ][ "contract_form3" ] != ""){	// 장단기 구분
    		
				if(dataPage[ i ][ "contract_term" ] == "01" || dataPage[ i ][ "contract_form3" ] == "01"){
					excel.set( 0, 18, rowNo, "단년도", formatCell ); 
				} else if (dataPage[ i ][ "contract_term" ] == "02" || dataPage[ i ][ "contract_form3" ] == "02") {
					excel.set( 0, 18, rowNo, "장기계속",formatCell ); 
				} else if (dataPage[ i ][ "contract_term" ] == "03" || dataPage[ i ][ "contract_form3" ] == "03") {
					excel.set( 0, 18, rowNo, "계속비", formatCell ); 
				} else {
					excel.set( 0, 18, rowNo, "", formatCell );
				}
			}
    		
    		if(dataPage[ i ][ "contract_form1" ] != "" || dataPage[ i ][ "c_contract_form1" ] != ""){	// 금액확정 구분
        		
				if(dataPage[ i ][ "contract_form1" ] == "01" || dataPage[ i ][ "c_contract_form1" ] == "01"){
					excel.set( 0, 19, rowNo, "확정계약", formatCell ); 
				} else if (dataPage[ i ][ "contract_form1" ] == "02" || dataPage[ i ][ "c_contract_form1" ] == "02") {
					excel.set( 0, 19, rowNo, "사후원가검토조건부계약",formatCell ); 
				} else if (dataPage[ i ][ "contract_form1" ] == "03" || dataPage[ i ][ "c_contract_form1" ] == "03") {
					excel.set( 0, 19, rowNo, "개산계약", formatCell ); 
				} else {
					excel.set( 0, 19, rowNo, "", formatCell );
				}
			}
    			
    		if(dataPage[ i ][ "contract_form2" ] != "" || dataPage[ i ][ "c_contract_form2" ] != ""){	// 금액산정 구분
        		
				if(dataPage[ i ][ "contract_form2" ] == "01" || dataPage[ i ][ "c_contract_form2" ] == "01"){
					excel.set( 0, 20, rowNo, "총액계약", formatCell ); 
				} else if (dataPage[ i ][ "contract_form2" ] == "02" || dataPage[ i ][ "c_contract_form2" ] == "02") {
					excel.set( 0, 20, rowNo, "단가계약",formatCell ); 
				}  else {
		    		excel.set( 0, 20, rowNo, "", formatCell ); 
				}
			}
    		excel.set( 0, 21, rowNo, dataPage[ i ][ "hope_company_info" ], formatCell );
    		excel.set( 0, 22, rowNo, dataPage[ i ][ "std_amt" ], formatCell ); // 추정가격
    		excel.set( 0, 23, rowNo, dataPage[ i ][ "amt" ], formatCell );
    		excel.set( 0, 24, rowNo, dataPage[ i ][ "result_amt" ], formatCell ); // 낙찰가격
    		
    		if(dataPage[ i ][ "amt" ] != "" &&  dataPage[ i ][ "contract_amt" ] != ""){  // 낙찰율 	
				var succrate_amt = 0;
				if(dataPage[ i ][ "amt" ] != 0 &&  dataPage[ i ][ "contract_amt" ] != 0){ 
					var result_amt = parseInt(dataPage[ i ][ "contract_amt" ].replace(/,/g, ''));
					var amt = parseInt(dataPage[ i ][ "amt" ].replace(/,/g, ''));
						excel.set( 0, 25, rowNo, (result_amt/amt*100).toFixed(1) + "%", formatCell );
						}  	else {
					excel.set( 0, 25, rowNo, succrate_amt + "%", formatCell );
				}
    		}
    		
    		excel.set( 0, 26, rowNo, dataPage[ i ][ "compete_type_text" ], formatCell );
    		excel.set( 0, 27, rowNo, dataPage[ i ][ "decision_type_text" ], formatCell );
    		excel.set( 0, 28, rowNo, dataPage[ i ][ "emp_name" ], formatCell );
    		excel.set( 0, 29, rowNo, dataPage[ i ][ "dept_name" ], formatCell );
    		
     		if(dataPage[ i ][ "public_info" ] != ""){  // 업무관련자 구분
				const arr  = (dataPage[ i ][ "public_info" ]||"").split("▦");
    			const arr1 = [];
    			const public_info = [];
					for(var e=1; e<arr.length; e+=3){
						const arr1 = arr[e].split("(");
						for(var j=0; j<arr1.length; j+=2){
							public_info.push(arr1[j]); 
							}
						}
					excel.set( 0, 30, rowNo, public_info, formatCell ); 
				} else {
					excel.set( 0, 30, rowNo, dataPage[ i ][ "public_info" ], formatCell );	
				} 
    		
    		excel.set( 0, 31, rowNo, dataPage[ i ][ "pre_notice_end_dt" ], formatCell );
    		excel.set( 0, 32, rowNo, dataPage[ i ][ "notice_start_dt" ] != "" && dataPage[ i ][ "notice_end_dt" ] != "" ? (dataPage[ i ][ "notice_start_dt" ] + "~" + dataPage[ i ][ "notice_end_dt" ]) : "", formatCell );
    		excel.set( 0, 33, rowNo, dataPage[ i ][ "re_notice_start_dt" ] != "" && dataPage[ i ][ "re_notice_end_dt" ] != "" ? (dataPage[ i ][ "re_notice_start_dt" ] + "~" + dataPage[ i ][ "re_notice_end_dt" ]) : "", formatCell );
    		excel.set( 0, 34, rowNo, dataPage[ i ][ "notice_start_dt" ] != "" && dataPage[ i ][ "notice_end_dt" ] != "" ? "확정" : "", formatCell );
    		excel.set( 0, 35, rowNo, dataPage[ i ][ "bidder_cnt" ], formatCell );
    		excel.set( 0, 36, rowNo, dataPage[ i ][ "meet_dt" ], formatCell );
    		excel.set( 0, 37, rowNo, dataPage[ i ][ "contract_change_dt" ], formatCell );
    		excel.set( 0, 38, rowNo, dataPage[ i ][ "work_info_after" ], formatCell );
    		excel.set( 0, 39, rowNo, dataPage[ i ][ "contract_end_dt_after" ], formatCell );
    		excel.set( 0, 40, rowNo, dataPage[ i ][ "contract_amt_after" ] != "" && dataPage[ i ][ "contract_amt_after" ] != "0" ? dataPage[ i ][ "contract_amt_after" ] : "", formatCell );
    		excel.set( 0, 41, rowNo, dataPage[ i ][ "change_etc" ], formatCell );
    		excel.set( 0, 42, rowNo, dataPage[ i ][ "change_reason" ], formatCell ); // 변경사유 
    		excel.set( 0, 43, rowNo, dataPage[ i ][ "pay_amt_a" ], formatCell );
    		excel.set( 0, 44, rowNo, dataPage[ i ][ "pay_amt_b" ], formatCell );
    		excel.set( 0, 45, rowNo, dataPage[ i ][ "pay_amt_c" ], formatCell );
    		
    		
			if(dataPage[ i ][ "pay_amt_a" ] != "" || dataPage[ i ][ "pay_amt_b" ] != ""  || dataPage[ i ][ "pay_amt_c" ] != "" ){
					var sum_pay_amt = 0;
				
					if(dataPage[ i ][ "pay_amt_a" ] != "0" || dataPage[ i ][ "pay_amt_b" ] != "0"  || dataPage[ i ][ "pay_amt_c" ] != "0"){
						pay_amt_a = parseInt(dataPage[ i ][ "pay_amt_a" ].replace(/,/g, ''));
					 	pay_amt_b = parseInt(dataPage[ i ][ "pay_amt_b" ].replace(/,/g, ''));
					 	pay_amt_c = parseInt(dataPage[ i ][ "pay_amt_c" ].replace(/,/g, ''));
					 	 
					 	sum_pay_amt = pay_amt_a + pay_amt_b + + pay_amt_c;
					 
					 excel.set( 0, 46, rowNo, sum_pay_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','), formatCell ); // 집행액 계산
					} else if (dataPage[ i ][ "pay_amt_a" ] == "0" || dataPage[ i ][ "pay_amt_b" ] == "0"  || dataPage[ i ][ "pay_amt_c" ] == "0") {
						pay_amt_a = parseInt(dataPage[ i ][ "pay_amt_a" ]);
					 	pay_amt_b = parseInt(dataPage[ i ][ "pay_amt_b" ]);
					 	pay_amt_c = parseInt(dataPage[ i ][ "pay_amt_c" ]);
					 	
					 	sum_pay_amt = pay_amt_a + pay_amt_b + + pay_amt_c;
					 excel.set( 0, 46, rowNo, sum_pay_amt, formatCell ); // 집행액 계산
					} else {
					excel.set( 0, 46, rowNo, "", formatCell ); // 집행액 계산
					}	
			}   
			
    		excel.set( 0, 47, rowNo, dataPage[ i ][ "remain_amt" ], formatCell );
    		
			if(dataPage[ i ][ "remain_amt" ] != ""){
				var amt = parseInt(dataPage[ i ][ "contract_amt" ].replace(/,/g, ''));
				var remain_amt = parseInt(dataPage[ i ][ "remain_amt" ].replace(/,/g, ''));
				excel.set( 0, 48, rowNo, ((amt-remain_amt)/amt*100).toFixed(1) + " %", formatCell );
				
			}   		
			
			
			if(dataPage[ i ][ "contract_attach_info" ] != ""){
				excel.set( 0, 49, rowNo, "등록", formatCell );	
			}
			
			if(dataPage[ i ][ "submit_attach_info" ] != ""){
				excel.set( 0, 50, rowNo, "등록", formatCell );
			}			
    		
    	}
     
    	excel.generate( fileName, saveCallback, stepCallback );
    }    
	
</script>




<!-- 상세검색 -->
<div class="top_box">
	<dl>
		<dt class="ar" style="width:60px;">계약기간</dt>
		<dd>
			<input type="text" id="searchFromDate" value="2023-01-01" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="searchToDate" value="2026-12-31" class="puddSetup" pudd-type="datepicker"/>
<%-- 		<input type="text" id="searchFromDate" value="${fromDate}" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="searchToDate" value="${toDate}" class="puddSetup" pudd-type="datepicker"/> --%>
		</dd>
		<dt class="ar" style="width:40px;">계약명</dt>
		<dd><input type="text" id="contractTitle" pudd-style="width:120px;" class="puddSetup" placeHolder="공고명 입력" value="" /></dd>
		<dt class="ar" style="width:40px;">부서명</dt>
		<dd><input type="text" id="writeDeptName" pudd-style="width:120px;" class="puddSetup" placeHolder="부서명 입력" value="" /></dd>
		
		<c:if test="${authLevel!='user'}">
		<dt class="ar" style="width:40px;">사원명</dt>
		<dd><input type="text" id="writeEmpName" pudd-style="width:90px;" class="puddSetup" placeHolder="사원명 입력" value="" /></dd>
		</c:if>
		
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" onclick="BindGrid();" /></dd>
		
	</dl>
</div>

<div class="sub_contents_wrap posi_re">
	<div class="btn_div">
		<div class="left_div">
			<div id="" class="controll_btn p0">
				<input type="button" onclick="fnCallBtn('newContract');" class="puddSetup" style="background:#03a9f4;color:#fff;" value="신규입찰발주" />
				<input type="button" onclick="fnCallBtn('newConclusion');" style="background:#03a9f4;color:#fff" class="puddSetup" value="1인수의계약체결" />
			</div>
		</div>
		<div class="right_div">
			<div id="" class="controll_btn p0">
				<c:if test="${authLevel=='admin'}">
				<input type="button" onclick="fnModify();" class="puddSetup" value="품의환원" />
				</c:if>
				<c:if test="${authLevel=='admin'}">
				<input id="adminSaveBtn" style="display:none;width:70px;background:rgb(0 0 0);color:#fff;" type="button" onclick="fnCallBtn('btnSave');" class="puddSetup" value="저장" />
				</c:if>
				<c:if test="${authLevel=='admin'}">
				<input type="button" onclick="fnDel();" class="puddSetup" value="삭제" />
				</c:if>
				<input type="button" onclick="excelDown();" class="puddSetup" value="엑셀다운로드" />
			</div>
		</div>
	</div>
	
	<div class="dal_Box_">
		<div class="dal_BoxIn_ posi_re">
			<div id="grid1"></div>
		</div>
	</div>
	<input style="display:none;" id="file_upload" type="file" />
	<div id="exArea"></div>
	<div id="jugglingProgressBar"></div>
	<div id="loadingProgressBar"></div>
	<div id="circularProgressBar"></div>	
</div><!-- //sub_contents_wrap -->