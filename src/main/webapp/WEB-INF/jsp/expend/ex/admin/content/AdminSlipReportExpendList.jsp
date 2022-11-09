<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%-- <%@ include file="/WEB-INF/jsp/ea/include/includeCmmOrgPop.jsp"%> --%>


<!--css-->
<script type="text/css" src='<c:url value="/css/pudd.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/js/jqueryui/jquery-ui.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/js/pudding/css/common.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/css/animate.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/css/re_pudd.css"></c:url>'></script>
<!--js-->
<script type="text/javascript" src='<c:url value="/js/pudd/pudd-1.1.186.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudding/js/jquery-1.9.1.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudding/common.js"></c:url>'></script>

<!--Excel다운로드를 위한 js-->
<script type="text/javascript" src='<c:url value="/js/t_excel/jszip-3.1.5.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/FileSaver-1.2.2_1.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/jexcel-1.0.4.js"></c:url>'></script>

<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<script type="text/javascript">
	
	// 값을 담기  
	var slip = {};
	
	var listData = {};

	/* 변수정의 */
	var ifSystem = '${ViewBag.ifSystem}';

	var CommonPop = {
		Summary : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Summary'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			
			return;
		},// 표준적요
		Dept : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Dept'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			
			return;
		}, // 사용부서
		Auth : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Auth'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			
			return;
		}, // 증빙유형
		Emp : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Emp'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			return;
		}, // 사용자
		Project : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Project'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			
			return;
		}, // 프로젝트
		Partner : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Partner'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			return;
		}, // 거래처
		Card : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Card'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			
			return;
		}, // 카드
		Acct : function() {
			var Popresult = fnOpenCodePop({
				codeType : 'Acct'
				, callback : 'fnErpCallback'
				, searchStr : ''
				, reflectResultPop : false
			});
			
			return;
		} // 계정과목
	};
	
	/*	[공통] 날짜 포멧 변경2
	----------------------------------------- */
	function getFormatDateForDateObj(date){
		var year = date.getFullYear();                                 //yyyy
		var month = (1 + date.getMonth());                     //M
		month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
		var day = date.getDate();                                        //d
		day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
		return  year + '-' + month + '-' + day;
	}
	
	// ready
	$(document).ready(function() {

		var ftDate = ['#expendDate_fromDate','#expendDate_toDate','#expendReqDate_fromDate','#expendReqDate_toDate','#authDate_fromDate','#authDate_toDate'];
		
		$.each($(ftDate.join(',')), function(idx, elem) {
			$(elem).next().removeAttr("readonly");
		});
		
	    // Pudding
		var arrPuddElement = ['PudSummary', 'PudDept', 'PudAuth', 'PudEmp', 'PudProject', 'PudPartner', 'PudCard', 'PudAcct'];
		$.each(arrPuddElement, function(idx, id){
			var param = {};
			
			if(['PudPartner'].indexOf(id) > -1) {
				param.attributes = {style: "width:272px;"};
			} else if(['PudAcct'].indexOf(id) > -1) {
				param.attributes = { style : "width:187px;"  };
			}
			
			fnSetPuddTGextBox(id, param);
		});
		
		var docStatusInfo = ('${ViewBag.commonCodeListDocStatus}' === '' ? [] : ${ViewBag.commonCodeListDocStatus});
        $("#selDocSts").empty();
		$.each(docStatusInfo, function(idx, item) {
			$("#selDocSts").append("<option value='" + item.commonCode + "'>" + item.commonName + "</option>");
		});
		
		$("#selDocSts").selectmenu({change: function(){
			if($('#selDocSts').val() == '10' || $('#selDocSts').val() == ''){
            	$('#btnSearch').click();
            }else{
            	$('#btnSearch').click();
            }
		}});
		
		if(docStatusInfo.length > 0){
			$("#selDocSts").val(docStatusInfo[0].commonCode).selectmenu('refresh');
		}
		 $("#selDocSts").val('${CL.ex_all}');
	   
	    //사업장 데이터 dd 에다가 값 넣어주기 
		 var bizList = (${bizList} === '' ? [] : ${bizList});
		 $("#selAppBiz").empty();
			$.each(bizList, function(idx, item) {
				$("#selAppBiz").append("<option value='" + item.commonCode + "'>" + item.commonName + "</option>");
			});
			
			$("#selAppBiz").selectmenu({change: function(){
				$('#btnSearch').click();
			}});
			
			if(bizList.length > 0){
				$("#selAppBiz").val(bizList[0].commonCode).selectmenu('refresh');
			}

		fnInit(); // init
		fnEventInit(); // event init

		return;
	});
	

 	function fnInitBasicDate(targetId){

		var puddObj = Pudd( "#" + targetId ).getPuddObject();
	    if( ! puddObj ) return;
	    puddObj.setDate();
	    
	} 

	
	function fnInit() {
		var dataSource = new Pudd.Data.DataSource({
			 pageSize : 10 
			, serverPaging : true
			, request :{
						url  :"<c:url value='/ex/report/ExSlipReportExpendAdmListInfoSelect.do'/>"
						,	type : 'post'
						,	dataType : "json"
						,	parameterMapping : function( data ) {

							// 기안일자 값 가져오기 
							data.searchrepDateStartDate = $("#repDate_fromDate").val().toString().replace(/-/g, '');
							data.searchrepDateEndDate = $("#repDate_toDate").val().toString().replace(/-/g, '');
							// 회계일자 값 가져오기 
							data.searchexpendDateStartDate = $("#expendDate_fromDate").val().toString().replace(/-/g, '');
							data.searchexpendDateEndtDate = $("#expendDate_toDate").val().toString().replace(/-/g, '');
							// 지급요청일자 값 가져오기 
							data.searchexpendReqDateStartDate = $("#expendReqDate_fromDate").val().toString().replace(/-/g, '');
							data.searchexpendReqDatendDate = $("#expendReqDate_toDate").val().toString().replace(/-/g, '');
							// 증빙일자 값 가져오기 
							data.searchauthDateStartDate = $("#authDate_fromDate").val().toString().replace(/-/g, '');
							data.searchauthDateEndDate = $("#authDate_toDate").val().toString().replace(/-/g, ''); 
							//문서 기안자 
							data.appUserName = $('#txtAppEmpName').val();
							//문서 상태 
							data.searchDocStatus = ($('#selDocSts').val() == "전체" ? "" : $('#selDocSts').val());
							//문서번호 값 가져오기  
							data.appDocNo = $('#txtdocNo').val();
							//문서 제목 값 가져오기 
							data.appDocTitle = $('#txtdocTitle').val();
							//문서분류
							data.formName = $("#txtFormTitle").val();
							//사업장
							data.bizCd = ($("#selAppBiz").val()=="전체"?"":$("#selAppBiz").val());
							//전송 여부 
							data.erpSendYN = $("#selErpSendYN").val();
							//전송자 
							data.erpSendName = $("#txtErpSendName").val();
							//자동전표번호 
							data.erpSendSeq = $("#txtErpSendSeq").val();
							//사용부서
							data.erpUseDeptName = (!Pudd( "#PudDept" ).getPuddObject()) ? '' : Pudd( "#PudDept" ).getPuddObject().val();	
							//사용자							
							data.erpUseEmpName = (!Pudd( "#PudEmp" ).getPuddObject()) ? '' : Pudd( "#PudEmp" ).getPuddObject().val();
							//표준적요
							data.summaryName = (!Pudd( "#PudSummary" ).getPuddObject()) ? '' : Pudd( "#PudSummary" ).getPuddObject().val();
							//증빙유형
							data.authName = (!Pudd( "#PudAuth" ).getPuddObject()) ? '' : Pudd( "#PudAuth" ).getPuddObject().val();
							//프로젝트
							data.projectName = (!Pudd( "#PudProject" ).getPuddObject()) ? '' : Pudd( "#PudProject" ).getPuddObject().val();
							//카드
							data.cardName = (!Pudd( "#PudCard" ).getPuddObject()) ? '' : Pudd( "#PudCard" ).getPuddObject().val();
							//거래처
							data.partnerName = (!Pudd( "#PudPartner" ).getPuddObject()) ? '' : Pudd( "#PudPartner" ).getPuddObject().val();
							//계정과목
							data.acctCode = $("#txtAcctCode").val();
							data.acctName = (!Pudd( "#PudAcct" ).getPuddObject()) ? '' : Pudd( "#PudAcct" ).getPuddObject().val();
							//적요 검색 
							data.slipNote = $("#txtNote").val();
							//차대구분 
							data.drcrGbn = $('#selDcctCode').val();
							//카드승인번호
							data.authNum = $("#txtAuthNum").val();
							// if 조건문 확인 - DataPicker 
							if( data.searchexpendDateStartDate == '' ){
								data.searchexpendDateStartDate = '19000101';
							}
							if( data.searchexpendDateEndtDate == ''){
								data.searchexpendDateEndtDate = '99991231';
							}
							
							if( data.searchexpendReqDateStartDate == '' ){
								data.searchexpendReqDateStartDate = '19000101';
							}
							if( data.searchexpendReqDatendDate == ''){
								data.searchexpendReqDatendDate = '99991231';
							}
							
							if( data.searchauthDateStartDate == '' ){
								data.searchauthDateStartDate = '19000101';
							}
							if( data.searchauthDateEndDate == ''){
								data.searchauthDateEndDate = '99991231';
							}
	
						}
					}
			,	result:{
				data : function( response ) {
					slip = response.aData.resultList.list;
					$("#valTotalCount").text(response.aData.resultList.totalCount);
					return slip;
				}, totalCount : function( response ) {
					return response.aData.resultList.totalCount;
				}, error : function( response ) {
				}
			}
		});
			// Grid 그려주는곳 (서버 페이징)
			Pudd("#grid").puddGrid({
				dataSource : dataSource
			,	scrollable : true
			,	resizable : true
			,	pageable : {
					buttonCount : 10 
				,	pageList : [ 10, 20, 30, 40, 50 ]
				}
			,	columns : [
					{
						field : "gridCheckBox"
					,	width : 34
					,	editControl : {
							type : "checkbox"					
						,	basicUse : true
						}
					}
			,		{
						field : "formName"
					,	title : "${CL.ex_documentType}"
					,	width : 150	
					,	content : {
						attributes : { class : "le" , style :  "padding-left: 10px"}
					}
					
					}
				,	{
						field : "appDocNo"
					,	title : "${CL.ex_documentNumber}"
					,	width : 300	
					,	content : {
						attributes : { class : "le"  , style :  "padding-left: 10px"},
						template : function(rowData){
							return '<a href="javascript:;" title="" onClick="javascript: fnAppdocPop('
							+ "'"
							+ rowData.docSeq
							+ "', '"
							+ rowData.formSeq
							+ "'" + ')">'
							+ (rowData.docSts == 10?"임시보관문서":rowData.appDocNo)
							+ '</a>';
							
						}
						
					}
					
					}
				,	{
						field : "appDocTitle"
					,	title : "${CL.ex_title}" 
					,	minWidth : 300	
					,	content : {
							attributes : { class : "le" , style :  "padding-left: 10px"}
					
							}
						}
				,	{
						field:"appRepDate"
					,	title:"${CL.ex_draftDate}"
					,	width:90	
					}
				,	{
						field:"appUserName"
					,	title:"${CL.ex_staffOfDrafting}"
					,	width:100
					}
				,	{
						field:"docStsName"
					,	title:"${CL.ex_documentStatus}"
					,	width:90
					}
				,	{
						field:"expendErpSendYn"
					,	title:"${CL.ex_sending}"
					,	width:90
					,	content : {
						template : function( rowData ){
							
							   if ( rowData.expendErpSendYn == 'Y' || rowData.expendErpSendYn == '전송' ) {
								   
								   return  rowData.expendErpSendYn = '전송';
								   
			                    } else if ( rowData.expendErpSendYn == 'N' || rowData.expendErpSendYn == '미전송' || rowData.expendErpSendYn == '') {

			                    	return rowData.expendErpSendYn = '미전송';
			                    	
			                    }	else if ( rowData.expendErpSendYn == 'I' ) {
			                    	
			                    	return rowData.expendErpSendYn = '서버 통신 문제' ;
			                    	
			                    } 
						}
					}
				}
				,	{
						field:"expendErpSendName"
					,	title:"${CL.ex_sender}"
					,	width:100
					,	content : {
							template : function( rowData ) {
								 	if (rowData.expendErpSendName == '') {
				                        return "-";
				                        
				                    } else {
				                    	
				                        return rowData.expendErpSendName;
				                   }
							}
						}
					}
				,	{
						field:"expendErpSendSeq"
					,	title:"${CL.ex_automaticSlipNumber}"
					,	width:150
					,	content : {
							template : function( rowData ){
								   if (ifSystem == 'ERPiU') {
				                        if (rowData.expendErpiuAdocuId == '') {
				                            return "-";
				                        } else {
				                            return rowData.expendErpiuAdocuId;
				                        }
				                    } else if (ifSystem == 'iCUBE') {
				                        if (rowData.expendIcubeAdocuId == '') {
				                            return '-';
				                        } else {
				                            return rowData.expendIcubeAdocuId + ' / ' + rowData.expendIcubeAdocuSeq;
				                        }
				                    }
							}
						}
					 }
				,	{
						field:"expendDate"
					,	title:"${CL.ex_accountingDate}"
					,	width:90
					}
				,	{
						field:"expendReqDate"
					,	title:"${CL.ex_paymentDate}"
					,	width:90
					}
				,	{
						field:"expendUseEmpName"
					,	title:"${CL.ex_user}"
					,	width:100
					}
				,	{
						field:"expendUseDeptName"
					,	title:"${CL.ex_useDepartment}"
					,	width:110
					,	content : {
						attributes : { class : "le" , style :  "padding-left: 10px"}
					}
					}
				,	{
						field:"expendSlipSummaryName"
					,	title:"${CL.ex_standardOutline}"
					,	width:200
					,	content : {
						attributes : { class : "le" , style :  "padding-left: 10px" }
					}
					}	
				,	{
					
						field:"expendSlipAuthName"
					,	title:"${CL.ex_evidenceType}"
					,	width:200
					,	content : {
						attributes : { class : "le" , style :  "padding-left: 10px" }
					}
				}
				,	{
					
					field:"expendSlipNote"
				,	title:"${CL.ex_note}"
				,	width:250
				,	content : {
					attributes : { class : "le" , style :  "padding-left: 10px" }
				}
			}
				,	{
					
					field:"expendSlipAuthDate"
				,	title:"${CL.ex_evidenceDate}"
				,	width:90
			}
				,	{
					
					field:"expendSlipProjectName"
				,	title:"${CL.ex_project}"
				,	width:200
				,	content : {
					attributes : { class : "le"  , style :  "padding-left: 10px"}
				}
			}
				,	{
					
					field:"expendSlipCardName"
				,	title:"${CL.ex_card}"
				,	width:200
				,	content : {
					attributes : { class : "le" , style :  "padding-left: 10px" }
				}
			}
				,	{

					field:"expendSlipCardAuthNum"
				,	title:"${CL.ex_confirmationNumber}"
				,	width:90
			}
				,	{
					
					field:"expendSlipPartnerName"
				,	title:"${CL.ex_vendor}"
				,	width:200
				,	content : {
					attributes : { class : "le"  , style :  "padding-left: 10px"}
				}
			}
				,	{
					
					field:"expendSlipAcctName"
				,	title:"${CL.ex_account}"
				,	width:200
				,	content : {
					attributes : { class : "le" , style :  "padding-left: 10px" }
				}
			}
				,	{
					field:"expendSlipDrcrGbn"
				,	title:"차대구분"
				,	width:90
				,	content : {
					template : function( rowData ){
						   if ( rowData.expendSlipDrcrGbn == 'dr' || rowData.expendSlipDrcrGbn == '차변' ) {
							   
							   return rowData.expendSlipDrcrGbn = '차변';
							   
		                    } else if ( rowData.expendSlipDrcrGbn == 'vat' || rowData.expendSlipDrcrGbn == '부가세' ) {
		                    	
		                    	return rowData.expendSlipDrcrGbn = '부가세';
		                    	
		                    } else if ( rowData.expendSlipDrcrGbn == 'cr' || rowData.expendSlipDrcrGbn == '대변' ) {
		                    	
		                    	return rowData.expendSlipDrcrGbn = '대변';
		                    
		                    } 
					}
				}
			}
				,	{
					
					field:"expendSlipAmt"
				,	title:"${CL.ex_amount}"
				,	width:90
				,	content : {
					template : function( rowData ){
						return rowData.expendSlipAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					},
					attributes : { class : "ri"  , style :  "padding-right: 10px"} 
				}
			}
				
				]
			,noDataMessage : {
				message : "${CL.ex_dataDoNotExists}"
			}
		});
		return;
	}
	
	function fnEventInit() {
		// 기능 - 검색
		var puddSearch = Pudd( "#btnSearch" ).getPuddObject();
		puddSearch.on('click', function(e) {
			fnInit();
			return;
		});
		
        /* 엔터 키 이벤트 */
        $("input").keydown(function (event) {
            if (event.keyCode === 13) {
            	$('#btnSearch').click();
            }
        });

        /* delete키 이벤트 */
        $("input").keydown(function (event) {
            if (event.keyCode === 8 || event.keyCode === 46) {
            	fnInitBasicDate($(event.target).prev('input[type=text]').prop('id'));
            }
            
            return;
        });
		
		// 기능 - 엑셀다운로드
		/* var puddExcel = Pudd( "#btnExcelDownload" ).getPuddObject();
		puddExcel.on('click', function(e) {		
			fnAdminSlipReportExcelDown();
			return;
		}); */
		
		$("#btnExcelDownload").click(function(){
			 if($("#viewLoading").css("display") != "block"){
			   	   $("#viewLoading").css("width", "100%");
			       $("#viewLoading").css("height", "100%");
			       $("#viewLoading").fadeIn(100);    		
			   }
			fnAdminSlipReportExcelDown();
			$("#viewLoading").fadeOut(200);
		});
	
		return;
	}
	//Grid Table 속성 
	function fnSetPuddTGextBox(targetId, param) {
		var def = {
			attributes : {
				style : "width:122px;"
			}, // control 부모 객체 속성 설정
			inputType : "search",
			fnSearch : function() {
				if(typeof CommonPop[targetId.replace('Pud', '')] == 'function') {
					CommonPop[targetId.replace('Pud', '')]();
				}
				
				return;
			} // search 버튼 callback 선언
		};

		def = $.extend(def, param);

		Pudd('#' + targetId).puddTextBox(def);

		return;
	}
	
	/*	[서버 호출] 데이터 Excel 다운로드
 	--------------------------------------*/
	function fnAdminSlipReportExcelDown() {
		var param = {};
		
		/* 파라미터  */
		param.fileName = "지출결의상세현황";
		$("#fileName").val( param.fileName );
		param.listData = JSON.stringify(listData);
		$("#listData").val( param.listData );
		
		
		param.searchrepDateStartDate = $("#repDate_fromDate").val().toString().replace(/-/g, '');
		param.searchrepDateEndDate = $("#repDate_toDate").val().toString().replace(/-/g, '');
		
		$("#searchrepDateStartDate").val(param.searchrepDateStartDate);
		$("#searchrepDateEndDate").val(param.searchrepDateEndDate);
		
		// 회계일자 값 가져오기 
		param.searchexpendDateStartDate = $("#expendDate_fromDate").val().toString().replace(/-/g, '');
		param.searchexpendDateEndtDate = $("#expendDate_toDate").val().toString().replace(/-/g, '');
		
		$("#searchexpendDateStartDate").val(param.searchexpendDateStartDate);
		$("#searchexpendDateEndtDate").val(param.searchexpendDateEndtDate);
		
		// 지급요청일자 값 가져오기 
		param.searchexpendReqDateStartDate = $("#expendReqDate_fromDate").val().toString().replace(/-/g, '');
		param.searchexpendReqDatendDate = $("#expendReqDate_toDate").val().toString().replace(/-/g, '');
		$("#searchexpendReqDateStartDate").val(param.searchexpendReqDateStartDate);
		$("#searchexpendReqDatendDate").val(param.searchexpendReqDatendDate);
		
		// 증빙일자 값 가져오기 
		param.searchauthDateStartDate = $("#authDate_fromDate").val().toString().replace(/-/g, '');
		param.searchauthDateEndDate = $("#authDate_toDate").val().toString().replace(/-/g, '');
		$("#searchauthDateStartDate").val(param.searchauthDateStartDate);
		$("#searchauthDateEndDate").val(param.searchauthDateEndDate);

			//문서 기안자 
			param.appUserName = $('#txtAppEmpName').val();
			$("#appUserName").val(param.appUserName);
			//문서 상태 
			param.searchDocStatus = ($('#selDocSts').val() == "전체" ? "" : $('#selDocSts').val());
			$("#searchDocStatus").val(param.searchDocStatus);
			//문서번호 값 가져오기  
			param.appDocNo = $('#txtdocNo').val();
			$("#appDocNo").val(param.appDocNo);
			//문서 제목 값 가져오기 
			param.appDocTitle = $('#txtdocTitle').val();
			$("#appDocTitle").val(param.appDocTitle);
			//문서분류
			param.formName = $("#txtFormTitle").val();
			$("#formName").val(param.formName);
			//사업장
			param.bizCd = ($("#selAppBiz").val()=="전체"?"":$("#selAppBiz").val());
			$("#bizCd").val(param.bizCd);
			//전송 여부 
			param.erpSendYN = $("#selErpSendYN").val();
			$("#erpSendYN").val(param.erpSendYN);
			//전송자 
			param.erpSendName = $("#txtErpSendName").val();
			$("#erpSendName").val(param.erpSendName);
			//자동전표번호 
			param.erpSendSeq = $("#txtErpSendSeq").val();
			$("#erpSendSeq").val(param.erpSendSeq);
			//사용부서
			param.erpUseDeptName = (!Pudd( "#PudDept" ).getPuddObject()) ? '' : Pudd( "#PudDept" ).getPuddObject().val();
			$("#erpUseDeptName").val(param.erpUseDeptName);	
			//사용자							
			param.erpUseEmpName = (!Pudd( "#PudEmp" ).getPuddObject()) ? '' : Pudd( "#PudEmp" ).getPuddObject().val();
			$("#erpUseEmpName").val(param.erpUseEmpName);
			//표준적요
			param.summaryName = (!Pudd( "#PudSummary" ).getPuddObject()) ? '' : Pudd( "#PudSummary" ).getPuddObject().val();
			$("#summaryName").val(param.summaryName);
			//증빙유형
			param.authName = (!Pudd( "#PudAuth" ).getPuddObject()) ? '' : Pudd( "#PudAuth" ).getPuddObject().val();
			$("#authName").val(param.authName);
			//프로젝트
			param.projectName = (!Pudd( "#PudProject" ).getPuddObject()) ? '' : Pudd( "#PudProject" ).getPuddObject().val();
			$("#projectName").val(param.projectName);
			//카드
			param.cardName = (!Pudd( "#PudCard" ).getPuddObject()) ? '' : Pudd( "#PudCard" ).getPuddObject().val();
			$("#cardName").val(param.cardName);
			//거래처
			param.partnerName = (!Pudd( "#PudPartner" ).getPuddObject()) ? '' : Pudd( "#PudPartner" ).getPuddObject().val();
			$("#partnerName").val(param.partnerName);
			//계정과목
			param.acctCode = $("#txtAcctCode").val();
			param.acctName = (!Pudd( "#PudAcct" ).getPuddObject()) ? '' : Pudd( "#PudAcct" ).getPuddObject().val();
			$("#acctCode").val(param.acctCode);
			$("#acctName").val(param.acctName);
			//적요 검색 
			param.slipNote = $("#txtNote").val();
			$("#slipNote").val(param.slipNote);
			//차대구분 
			param.drcrGbn = $('#selDcctCode').val();
			$("#drcrGbn").val(param.drcrGbn);
			//승인번호
			param.authNum = $("#txtAuthNum").val();
			$("#authNum").val(param.authNum);
		// if 조건문 확인 - DataPicker 
		if( param.searchexpendDateStartDate == '' ){
			param.searchexpendDateStartDate = '19000101';
			$("#searchexpendDateStartDate").val(param.searchexpendDateStartDate);
		}
		if( param.searchexpendDateEndtDate == ''){
			param.searchexpendDateEndtDate = '99991231';
			$("#searchexpendDateEndtDate").val(param.searchexpendDateEndtDate);
		}
		
		if( param.searchexpendReqDateStartDate == '' ){
			param.searchexpendReqDateStartDate = '19000101';
			$("#searchexpendReqDateStartDate").val(param.searchexpendReqDateStartDate);
		}
		if( param.searchexpendReqDatendDate == ''){
			param.searchexpendReqDatendDate = '99991231';
			$("#searchexpendReqDatendDate").val(param.searchexpendReqDatendDate);
		}
		
		if( param.searchauthDateStartDate == '' ){
			param.searchauthDateStartDate = '19000101';
			$("#searchauthDateStartDate").val(param.searchauthDateStartDate);
		}
		if( param.searchauthDateEndDate == ''){
			param.searchauthDateEndDate = '99991231';
			$("#searchauthDateEndDate").val(param.searchauthDateEndDate);
		}
		/* Excel 헤더 정의 */
		var excelHeader = {};
		    excelHeader.formName="문서분류";
		    excelHeader.appDocNo="문서번호";
			excelHeader.appDocTitle ="제목";
			excelHeader.appRepDate="기안일자";
			excelHeader.appUserName="기안자";
			excelHeader.docStsName="문서상태";
			excelHeader.expendErpSendYn="전송여부";
			excelHeader.expendErpSendName="전송자";
			excelHeader.erpSendSeq="자동전표번호";
			excelHeader.expendDate="회계일자";
			excelHeader.expendReqDate="지급요청일자";
			excelHeader.expendUseEmpName="사용자";
			excelHeader.expendUseDeptCode="사용부서코드";
			excelHeader.expendUseDeptName="사용부서";
			excelHeader.expendSlipSummaryCode="표준적요코드";
			excelHeader.expendSlipSummaryName="표준적요";
			excelHeader.expendSlipAuthCode="증빙유형코드";
			excelHeader.expendSlipAuthName="증빙유형";
			excelHeader.expendSlipNote="적요";
			excelHeader.expendSlipAuthDate="증빙일자";
			excelHeader.expendSlipProjectCode="프로젝트코드";
			excelHeader.expendSlipProjectName="프로젝트";
			excelHeader.expendSlipCardName="카드명";
			excelHeader.expendSlipCardNum="카드번호";
			excelHeader.expendSlipCardAuthNum="승인번호";
			excelHeader.expendSlipPartnerCode="거래처코드";
			excelHeader.expendSlipPartnerName="거래처";
			excelHeader.expendSlipAcctCode="계정코드";
			excelHeader.expendSlipAcctName="계정과목";
			excelHeader.expendSlipDrcrGbn="차대구분";
			excelHeader.expendSlipAmt="금액";

		
		param.excelHeader = JSON.stringify(excelHeader);
		$("#excelHeader").val( param.excelHeader );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit(); 
		excelDownload.target = "";
	}
	//공통 팝업 콜백 함수 
	function fnErpCallback(param){
		//표준적요 
		Pudd( "#PudSummary" ).getPuddObject().val(param.obj.summaryName);
		//사용부서 
		Pudd( "#PudDept" ).getPuddObject().val(param.obj.erpDeptName);
		//증빙유형 
		Pudd( "#PudAuth" ).getPuddObject().val(param.obj.authName);
		//사용자 
		Pudd( "#PudEmp" ).getPuddObject().val(param.obj.erpEmpName);
		//프로젝트 
		Pudd( "#PudProject" ).getPuddObject().val(param.obj.projectName);
		//거래처
		Pudd( "#PudPartner" ).getPuddObject().val(param.obj.partnerName);
		//카드 
		Pudd( "#PudCard" ).getPuddObject().val(param.obj.cardName);
		//계정과목
		$("#txtAcctCode").val(param.obj.acctCode);
		Pudd( "#PudAcct" ).getPuddObject().val(param.obj.acctName);
	}
	
	/* function - fnAppdocPop */
	function fnAppdocPop(docSeq, formSeq) {
		var intWidth = '1000';
		var intHeight = screen.height - 100;
		var agt = navigator.userAgent.toLowerCase();

		if (agt.indexOf("safari") != -1) {
			intHeight = intHeight - 70;
		}

		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}
		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq
				+ "&form_id=" + formSeq + "&doc_auth=1";
		window.open(url, 'AppDoc',
				'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left='
						+ intLeft + ',top=' + intTop);
	}
	
	/* function - fnAppdocPop */
	function fnExpendPop(formSeq, formTp, docSeq, expendSeq, formName) {
		var intWidth = '900';
		var intHeight = screen.height - 100;
		var agt = navigator.userAgent.toLowerCase();

		if (agt.indexOf("safari") != -1) {
			intHeight = intHeight - 70;
		}

		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}
		var url = "/exp/ExpendPop.do?form_id=" + formSeq + "&form_tp=" + formTp + "&doc_width=900&doc_id=" + docSeq + "&expendSeq=" + expendSeq + "&adminReport=Y"
		window.open(url, formName,
				'menubar=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left='
						+ intLeft + ',top=' + intTop);
	}


</script>
<!-- hidden -->
<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="searchrepDateStartDate" value="" id="searchrepDateStartDate"/>
	<input type="hidden" name="searchrepDateEndDate" value="" id="searchrepDateEndDate"/>
	<input type="hidden" name="searchexpendDateStartDate" value="" id="searchexpendDateStartDate"/>
	<input type="hidden" name="searchexpendDateEndtDate" value="" id="searchexpendDateEndtDate"/>
	<input type="hidden" name="searchexpendReqDateStartDate" value="" id="searchexpendReqDateStartDate"/>
	<input type="hidden" name="searchexpendReqDatendDate" value="" id="searchexpendReqDatendDate"/>
	<input type="hidden" name="searchauthDateStartDate" value="" id="searchauthDateStartDate"/>
	<input type="hidden" name="searchauthDateEndDate" value="" id="searchauthDateEndDate"/>
	<input type="hidden" name="appUserName" value="" id="appUserName"/>
	<input type="hidden" name="searchDocStatus" value="" id="searchDocStatus"/>
	<input type="hidden" name="appDocNo" value="" id="appDocNo"/>
	<input type="hidden" name="appDocTitle" value="" id="appDocTitle"/>
	<input type="hidden" name="formName" value="" id="formName"/>
	<input type="hidden" name="bizCd" value="" id="bizCd"/>
	<input type="hidden" name="erpSendYN" value="" id="erpSendYN"/>
	<input type="hidden" name="erpSendName" value="" id="erpSendName"/>
	<input type="hidden" name="erpSendSeq" value="" id="erpSendSeq"/>
	<input type="hidden" name="erpUseDeptName" value="" id="erpUseDeptName"/>
	<input type="hidden" name="erpUseEmpName" value="" id="erpUseEmpName"/>
	<input type="hidden" name="summaryName" value="" id="summaryName"/>
	<input type="hidden" name="authName" value="" id="authName"/>
	<input type="hidden" name="projectName" value="" id="projectName"/>
	<input type="hidden" name="cardName" value="" id="cardName"/>
	<input type="hidden" name="partnerName" value="" id="partnerName"/>
	<input type="hidden" name="acctCode" value="" id="acctCode"/>
	<input type="hidden" name="acctName" value="" id="acctName"/>
	<input type="hidden" name="slipNote" value="" id="slipNote"/>
	<input type="hidden" name="drcrGbn" value="" id="drcrGbn"/>
	<input type="hidden" name="authNum" value="" id="authNum"/>
	<input type="hidden" name="excelHeader" value="" id="excelHeader"/>
	<input type="hidden" name="fileName" value="" id="fileName">
</form>
<div class="iframe_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt style="" style="ar"><%=BizboxAMessage.getMessage("TX000000938","기안일자")%></dt>
			<dd>       
			 <div class="dal_div">
                    <input type="text" value="" id="repDate_fromDate" class="w113 puddSetup" pudd-type="datepicker"  />
                    <script type="text/javascript">
						var d = new Date()
						var monthOfYear = d.getMonth()
						d.setMonth(monthOfYear - 1)
						$("#repDate_fromDate").val(getFormatDateForDateObj(d));
					</script>
                </div>
                ~
                <div class="dal_div">
                    <input type="text" value="" id="repDate_toDate" class="w113 puddSetup" pudd-type="datepicker"  />
                    <script type="text/javascript">
						var d = new Date();
						$("#repDate_toDate").val(getFormatDateForDateObj(d));
					</script>
                </div>
             </dd>
			<dt><%=BizboxAMessage.getMessage("TX000000499","기안자")%></dt>
			<dd>
				<input type="text" id ="txtAppEmpName" style="width: 100px" />
			</dd>
			<dt><%=BizboxAMessage.getMessage("TX000005832","문서상태")%></dt>
			<dd> 
				<select id="selDocSts" style="width: 100px;" class="selectmenu">
				</select>
			</dd>
			<dd>
				<input type="button" id="btnSearch" class="puddSetup submit"
					value="검색" />
			</dd>
		</dl>
		<span class="btn_Detail"><%=BizboxAMessage.getMessage("TX000005724","상세검색")%> <img id="all_menu_btn"
			src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
	</div>

	<div class="SearchDetail">
		<dl>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000663","문서번호")%></dt>
			<dd>
				<input type="text" id = "txtdocNo" style="width: 120px;" />
			</dd>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000493","제목")%></dt>
			<dd>
				<input type="text" id = "txtdocTitle" style="width: 270px;" />
			</dd>
			<dt style="width: 75px;" ><%=BizboxAMessage.getMessage("TX000000492","문서분류")%></dt>
			<dd>
				<input type="text" id = "txtFormTitle" style="width: 120px;" />
			</dd>
		</dl>
		<dl>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000811","사업장")%></dt>
			<dd>
				<select id="selAppBiz" class="selectmenu" style="width: 122px;">
				</select>
			</dd>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000005174","회계일자")%></dt>  
			<dd>
			 <div class="dal_div">
                    <input type="text" value="" id="expendDate_fromDate" class="w113 puddSetup" pudd-type="datepicker"  />
                </div>
                ~
                <div class="dal_div">
                    <input type="text" value="" id="expendDate_toDate" class="w113 puddSetup" pudd-type="datepicker"  />
                </div>
             </dd>
			<dt style="width: 75px;"><%=BizboxAMessage.getMessage("TX000001003","전송여부")%></dt>
			<dd>
				<select id ="selErpSendYN" class="puddSetup" pudd-style="width:122px;">
					<option value="A" selected>전체</option>
					<option value="Y">전송</option>
					<option value="N">미전송</option>
				</select>
			</dd>
		</dl>
		<dl>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000565","전표번호")%></dt>
			<dd>
				<input type="text" id ="txtErpSendSeq" style="width: 120px;" />
			</dd>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000002867","지급요청일자")%></dt>
			<dd>
			 <div class="dal_div">
                    <input type="text" value="" id="expendReqDate_fromDate" class="w113 puddSetup" pudd-type="datepicker"  />
                </div>
                ~
                <div class="dal_div">
                    <input type="text" value="" id="expendReqDate_toDate" class="w113 puddSetup" pudd-type="datepicker"  />
                </div>
             </dd>
			<dt style="width: 75px;"><%=BizboxAMessage.getMessage("TX000005750","전송자")%></dt>
			<dd>
				<input type="text" id="txtErpSendName" style="width: 120px;" />
			</dd>
		</dl>
		<dl>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000004612","표준적요")%></dt>
			<dd>
				<div id="PudSummary"></div>
			</dd>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000514","증빙일자")%></dt>
			<dd>
			 <div class="dal_div">
                    <input type="text" value="" id="authDate_fromDate" class="w113 puddSetup" pudd-type="datepicker"  />
                </div>
                ~
                <div class="dal_div">
                    <input type="text" value="" id="authDate_toDate" class="w113 puddSetup" pudd-type="datepicker"  />
                </div>
             </dd>
			<dt style="width: 75px;"><%=BizboxAMessage.getMessage("TX000000537","사용부서")%></dt>
			<dd>
				<div id="PudDept"></div>
			</dd>
		</dl>
		<dl>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000004698","증빙유형")%></dt>
			<dd>
				<div id="PudAuth"></div>
			</dd>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000345","적요명")%></dt>
			<dd>
				<input id = 'txtNote' type="text" style="width: 272px;" class="puddSetup" value="" />
			</dd>
			<dt style="width: 75px;"><%=BizboxAMessage.getMessage("TX000000150","사용자")%></dt>
			<dd>
				<div id="PudEmp"></div>
			</dd>
		</dl>
		<dl>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000352","프로젝트명")%></dt>
			<dd>
				<div id="PudProject"></div>
			</dd>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000520","거래처")%></dt>
			<dd>
				<div id="PudPartner"></div>
			</dd>
			<dt style="width: 75px;"><%=BizboxAMessage.getMessage("TX000000527","카드명")%></dt>
			<dd>
				<div id="PudCard"></div>
			</dd>
		</dl>
		<dl>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000004258","차대구분")%></dt>
			<dd>
				<select id="selDcctCode" class="puddSetup" pudd-style="width:122px;">
					<option value="A" selected>전체</option>
					<option value="dr">차변</option>
					<option value="vat">부가세</option>
					<option value="cr">대변</option>
				</select>
			</dd>
			<dt style="width: 75px;" class="ar"><%=BizboxAMessage.getMessage("TX000000341","계정과목")%></dt>
			<dd>
				<input type="text" id="txtAcctCode" style="width: 80px;" />
			</dd>
			<dd style="margin-left: 3px;">
				<div id="PudAcct"></div>
			</dd>
			<dt style="width: 75px;"><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></dt>
			<dd>
				<input type="text" id="txtAuthNum" style="width: 120px;" />
			</dd>
		</dl>
	</div>

	<!-- 컨텐츠내용영역 -->
	<div class="sub_contents_wrap">
		<div class="left_div">
			<span class="fwb mt14" style="text-align:left;float:left">총 <span id="valTotalCount">0</span> 건</span>
		</div>
		<div class="btn_div">
			<div class="right_div">
				<input type="button" id="btnExcelDownload" class="puddSetup" value="엑셀다운로드" />
			</div>
		</div>
		<div id="grid"></div>
	</div>
	<div id="loadingProgressBar"></div>
	<div id="viewLoading" style="position: absolute; top: 0px; left: 0px; z-index: 9999; text-align: center; background: #ffffff; filter: alpha(opacity = 50); opacity: 0.5; display: none;">
		<iframe id="ifLoading" src="about:blank" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 9999; text-align: center;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%;">
				<tr>
					<td style="height: 100%;">
						<img src='${pageContext.request.contextPath}/css/kendoui/Default/loading-image.gif' />
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<!-- //iframe wrap -->