<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
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

    <script type="text/javascript" src='<c:url value="/js/xlsx/xlsx.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/xlsx/jszip.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/xlsx/xlsx.full.min.js"></c:url>'></script>
    
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
    <title>G20 2.0 배포</title>
</head>
<body>
    <div>
        <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%)" id="div_pwCheck">
			<input type="password" name="password" id="password" style="width:200px;" class="puddSetup" placeholder="비밀번호를 입력해주세요" value="" pudd-icon-svg="secure" />
			<input type="button" name="confirm" value="확인" onclick="javascript:fnPostPassword();"  class="puddSetup"/>
        </div>
        <div id="buttonDiv"></div>
    </div>
<script>

function fnPostPassword(){
    $.ajax({
          type:"POST",
          url: 'FuncNp20Check.do',
          datatype : "application/json",
          data : { password : $('#password').val() },
          success : function(data) {
             var config_message = data.pwd_config_result;
             if(config_message == "SUCCESS"){
            	$('#div_pwCheck').remove();
   			 	if(document.getElementById('install_button_cms')==null){
	          		var cmsButton = data.cmsButton;
	   			 	var	g20Button = data.g20Button;
	   			 	var	g20tripButton = data.g20tripButton;
	   				var	g20deleteButton = data.g20deleteButton;
	   			 	var fmButton = data.fmButton;
	   			 	var taxbillButtonIU = data.taxbillButtonIU;
	   			 	var taxbillButtonCUBE = data.taxbillButtonCUBE;
	   			 	var taxbillButtonAuto = data.taxbillButtonAuto;
   			 		var cmsDelButton = data.cmsDelButton;
   			 		var cmsBatchButton = data.cmsBatchButton;
   			 		var excelSummary = data.excelSummary;
   			 		var excelAuth = data.excelAuth;   			 		
   			 		var exbudget = data.budgetButtonAll;
   			 		var excelupload = data.exelupload;
   			 		var refreshButton = data.refreshButton;
   			 		var cmsCloudBatchButton = data.cmsCloudBatchButton;
   			 		var exArea = data.exArea;
   			 		var SummaryReset = data.SummaryReset;
   			 		var AuthReset = data.AuthReset;
   			 		
   			 		/* 영리 버튼 영역 */
	   			 	$('#buttonDiv').append('<h1 class="puddSetup" style="width:400px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">영리</h1><hr style="display:block;">');
	   			 	$('#buttonDiv').append(fmButton);
	   				$('#buttonDiv').append(exbudget);
	   				$('#buttonDiv').append(cmsCloudBatchButton);
	   			 	$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;">표준적요 엑셀 업로드</span>');
	   			 	$('#buttonDiv').append(excelSummary);
	   			 	$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;">증빙유형 엑셀 업로드</span>');
	   				$('#buttonDiv').append(excelAuth);
	   				$('#buttonDiv').append(excelupload);	
					
	   				/* 영리 초기화 버튼 영역 */
	   				$('#buttonDiv').append('<h1 class="puddSetup" style="width:500px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">*주의* 영리 표준적요/증빙유형 초기화 기능 </h1><hr style="display:block;">');
	   				$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;">회사</span>');
	   				$('#buttonDiv').append(exArea);
	   				$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;"> 표준적요 초기화 (회사 확인 필수) </span><br>');
	   				$('#buttonDiv').append(SummaryReset);
	   				$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;"> 증빙유형 초기화 (회사 확인 필수) </span><br>');
	   				$('#buttonDiv').append(AuthReset);
	   			 	
	   			 	/* 비영리 버튼 영역 */
	   			 	$('#buttonDiv').append('<h1 class="puddSetup" style="width:400px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">비영리</h1><hr style="display:block;">');	
	   			 	$('#buttonDiv').append(g20Button);
	   			 	$('#buttonDiv').append(g20tripButton);
	   			 	$('#buttonDiv').append(g20deleteButton);

	   			 	/* 비영리(1.0) 버튼 영역 */
					$('#buttonDiv').append("<br>");
					$('#buttonDiv').append("<br>");	   			 	
	   			 	$('#buttonDiv').append('<h1 class="puddSetup" style="width:400px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">비영리(1.0)</h1><hr style="display:block;">');	   			 	
	   			 	/* 비영리 1.0 참조품의 권한 */        		
					$('#buttonDiv').append("<input class=\"puddSetup\" type=\"button\" id=\"authMain\" value=\"참조품의 권한설정 메뉴\" onclick=\"fnAuthMain()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");
					$('#buttonDiv').append("<br>");
					$('#buttonDiv').append("<br>");	  	   			 	
	   			 	
	   			 	/* 공통 버튼 영역 */
	   			 	$('#buttonDiv').append('<h1 class="puddSetup" style="width:400px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">공통</h1><hr style="display:block;">');
	   			 	$('#buttonDiv').append(cmsButton);
					$('#buttonDiv').append(cmsDelButton);
					$('#buttonDiv').append(cmsBatchButton);
					$('#buttonDiv').append("<br>");
	   			 	$('#buttonDiv').append(taxbillButtonCUBE);
	         		$('#buttonDiv').append(taxbillButtonIU);
	         		$('#buttonDiv').append(taxbillButtonAuto);
	         		$('#buttonDiv').append("<br>");
	         		
	         		fnCompanyList();
	         		
	         		/* Refresh*/
	         		//$('#buttonDiv').append('<h1 class="puddSetup" style="width:400px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">Refresh</h1><hr style="display:block;">');
	         		//$('#buttonDiv').append(refreshButton);
   			 	}
             } 
             else if (config_message == "BPSUCCESS") {
            	 	$('#div_pwCheck').remove();	
            	 	var excelSummary = data.excelSummary;
			 		var excelAuth = data.excelAuth;   			 		
			 		var excelupload = data.exelupload;
			 		var exArea = data.exArea;
   			 		var SummaryReset = data.SummaryReset;
   			 		var AuthReset = data.AuthReset;
   			 		
			 		$('#buttonDiv').append('<h1 class="puddSetup" style="width:400px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">Bizbox Alpha 회계 구축세팅</h1><hr style="display:block;">');
            	 	$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;">표준적요 엑셀 업로드</span>');
            		$('#buttonDiv').append(excelSummary);
	   			 	$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;">증빙유형 엑셀 업로드</span>');
	   				$('#buttonDiv').append(excelAuth);
	   				$('#buttonDiv').append(excelupload);
	   				/* 영리 초기화 버튼 영역 */
	   				$('#buttonDiv').append('<h1 class="puddSetup" style="width:500px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">*주의* 영리 표준적요/증빙유형 초기화 기능 </h1><hr style="display:block;">');
	   				$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;">회사</span>');
	   				$('#buttonDiv').append(exArea);
	   				$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;"> 표준적요 초기화 (회사 확인 필수) </span><br>');
	   				$('#buttonDiv').append(SummaryReset);
	   				$('#buttonDiv').append('<br><span style=" font-size: 24px; margin: 0px 10px 0 0px;"> 증빙유형 초기화 (회사 확인 필수) </span><br>');
	   				$('#buttonDiv').append(AuthReset);

				 	/* 비영리(1.0) 버튼 영역 */
					$('#buttonDiv').append("<br>");
					$('#buttonDiv').append("<br>");
					$('#buttonDiv').append('<h1 class="puddSetup" style="width:400px;height: 22px;margin-top: 10px;visibility: visible;font-size: 25px;">비영리(1.0)</h1><hr style="display:block;">');
					/* 비영리 1.0 참조품의 권한 */
					$('#buttonDiv').append("<input class=\"puddSetup\" type=\"button\" id=\"authMain\" value=\"참조품의 권한설정 메뉴\" onclick=\"fnAuthMain()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");
					$('#buttonDiv').append("<br>");
					$('#buttonDiv').append("<br>");
	   				fnCompanyList();
             }
             else{
            	alert("비밀번호를 잘 못 입력하셨습니다.");
             }
          },
          error : function(xhr, status, error) {
             alert(error)
          }
    });
}

function fnExcelSummary(event){
	 var input = event.target;
	 var reader = new FileReader();
	 
	 reader.onload = function(){
		 var fileData = reader.result;
		 var wb = XLSX.read(fileData, {type : 'binary'});   
		 wb.SheetNames.forEach(function(sheetName){
		        var rowObj =XLSX.utils.sheet_to_row_object_array(wb.Sheets[sheetName]);
		        var jsonObj = JSON.stringify(rowObj);
		        
		        $.each(rowObj, function(idx, item){
		        	if(idx != 0) {
		        		 $.ajax({
		        			 type:"POST",
		        			 url:'<c:url value="/devmanager/ExcelUpload.do"/> ',
		        			 data : {
		        				 compCd : item.compCd,
		        				 summary_code : item.summaryCode,
		        				 summary_name : item.summaryName, 
		        				 dr_acct_code : item.drAcctCode,
		        				 dr_acct_name : item.drAcctName,
		        				 cr_acct_code : item.crAcctCode,
		        				 cr_acct_name : item.crAcctName,
		        				 vat_acct_code : item.vatAcctCode,
		        				 vat_acct_name : item.vatAcctName

		        			 },  
		        			 datatype : "json",
		        			 success : function(data){
		        				 
		        			 }, error : function(xhr, status, error) {
		        		           alert(error)
		        		        }
		        		 });
		        	}
		        });
		        alert("업로드가 완료 되었습니다.");
		 });
	 };
	 
	 reader.readAsBinaryString(input.files[0]);
} 

function fnExcelAuth(event){
	var input = event.target;
	 var reader = new FileReader();
	 
	 reader.onload = function(){
		 var fileData = reader.result;
		 var wb = XLSX.read(fileData, {type : 'binary'});   
		 wb.SheetNames.forEach(function(sheetName){
		        var rowObj =XLSX.utils.sheet_to_row_object_array(wb.Sheets[sheetName]);
		        var jsonObj = JSON.stringify(rowObj);
		        
		        $.each(rowObj, function(idx, item){
		        	if(idx != 0) {
		        		 $.ajax({
		        			 type:"POST",
		        			 url:'<c:url value="/devmanager/AuthExcelUpload.do"/> ',
		        			 data : {
		        				 compCd : item.compCd,
		        				 auth_code : item.authCode,
		        				 auth_name : item.authName,
		        				 order_num :	item.orderNum,
		        				 vat_type_code : item.vatTypeCode,
		        				 vat_type_name : item.vatTypeName,  
		           				 cr_acct_code : item.crAcctCode,
		        				 cr_acct_name : item.crAcctName,	 		        				 
		        				 vat_acct_code : item.vatAcctCode,
		        				 vat_acct_name : item.vatAcctName,
		        				 note_required_yn : item.noteRequiredYn,
		        				 auth_required_yn : item.authRequiredYn,
		        				 card_required_yn : item.cardRequiredYn,
		        				 partner_required_yn : item.partnerRequiredYn,
		        				 project_required_yn : item.projectRequiredYn
		        			 },  
		        			 datatype : "json",
		        			 success : function(data){
		        				 
		        			 }, error : function(xhr, status, error) {
		        		           alert(error)
		        		        }

		        		 });
		        		
		        	}
		        });
		        alert("업로드가 완료 되었습니다.");
		 });
	 };
	 
	 reader.readAsBinaryString(input.files[0]);

}

function fnCompanyList(){
	$.ajax({
		type : "POST",
		url:'<c:url value="/devmanager/CompanyList.do"/> ',
		datatype: "application/json",
		success : function(data){
			
			CompanyList = data.result.aaData
			CompanyList.unshift({"comp_seq" : "", "comp_name" : "선택하세요."})
		
			var dataSourceComboBox = new Pudd.Data.DataSource({
				 
				data : CompanyList
			});
			
			Pudd( "#exArea" ).puddComboBox({
				 
				attributes : { style : "width:200px;" }// control 부모 객체 속성 설정
			,	dataSource : dataSourceComboBox
			,	dataValueField : "comp_seq"
			,	dataTextField : "comp_name"
			,	selectedIndex : 0
			,	disabled : false
			,	scrollListHide : false
			});
		},
		error : function (error){
			alert(error);
		}
	});
}


function fnSummaryReset(){
	
	var StrSummaryContent = '회사 확인 : ' + Pudd( "#exArea" ).getPuddObject().text()  + '<br>' +'초기화시 기존데이터를 복구할 수 없습니다.'+ '<br>' +'계속 진행하시겠습니까?' + '<br>' + '(데이터 복구를 위해 반드시 기존자료를 엑셀 다운받으시기 바랍니다.)';
	
	Pudd.puddDialog({
		 
		width : 360,
		height : 100,
		modal : true,			// 기본값 true
		draggable : true,		// 기본값 true
		resize : false,			// 기본값 false
		header : {
			title : "표준적요 초기화 확인",
			align : "center",	// left, center, right
			minimizeButton : false,	// 기본값 false
			maximizeButton : false,	// 기본값 false
			closeButton : true,	// 기본값 true
			closeCallback : function( puddDlg ) {
				// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
				// 추가적인 작업 내용이 있는 경우 이곳에서 처리
			}
		},
		body : {
			content: StrSummaryContent
		},
		footer : {
			 
			buttons : [
				{
					attributes : {}// control 부모 객체 속성 설정
				,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
				,	value : "확인"
				,	clickCallback : function( puddDlg ) {
	 					
						puddDlg.showDialog( false );
						// 추가적인 작업 내용이 있는 경우 이곳에서 처리
						fnResetSummary();
						
					}
				}
			,	{
					attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
				,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
				,	value : "취소"
				,	clickCallback : function( puddDlg ) {
	 					
						puddDlg.showDialog( false );
						// 추가적인 작업 내용이 있는 경우 이곳에서 처리
					}
				}
			]
		}
	});	
}


function fnResetSummary(){
	if(Pudd( "#exArea" ).getPuddObject().val() == ''){
		alert('회사선택 해주세요.');
		return;
	}
	$.ajax({
		type:"POST",
		data:{
			compSeq : Pudd( "#exArea" ).getPuddObject().val()
		},
		url:'<c:url value="/devmanager/ResetSummary.do"/> ',
		datatype : "application/json",
		success : function(data){
			
			if (data.result.resultCode === "SUCCESS") {
				alert("표준적요 초기화 실행 완료 되었습니다");
			} else if(data.result.resultCode === "FAIL"){
				alert("표준적요 초기화 실행 실패 하였습니다.");
			}
		},error : function(error){
			alert(error);
		}
	})
}


function fnAuthReset(){
	
	var StrAuthContent = '회사 확인 : ' + Pudd( "#exArea" ).getPuddObject().text()  + '<br>' +'초기화시 기존데이터를 복구할 수 없습니다.'+ '<br>' +'계속 진행하시겠습니까?' + '<br>' + '(데이터 복구를 위해 반드시 기존자료를 엑셀 다운받으시기 바랍니다.)';
	
	Pudd.puddDialog({
		 
		width : 360,
		height : 100,
		modal : true,			// 기본값 true
		draggable : true,		// 기본값 true
		resize : false,			// 기본값 false
		header : {
			title : "증빙유형 초기화 확인",
			align : "center",	// left, center, right
			minimizeButton : false,	// 기본값 false
			maximizeButton : false,	// 기본값 false
			closeButton : true,	// 기본값 true
			closeCallback : function( puddDlg ) {
				// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
				// 추가적인 작업 내용이 있는 경우 이곳에서 처리
			}
		},
		body : {
			content: StrAuthContent
		},
		footer : {
			 
			buttons : [
				{
					attributes : {}// control 부모 객체 속성 설정
				,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
				,	value : "확인"
				,	clickCallback : function( puddDlg ) {
	 					
						puddDlg.showDialog( false );
						// 추가적인 작업 내용이 있는 경우 이곳에서 처리
						fnResetAuth();
						
					}
				}
			,	{
					attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
				,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
				,	value : "취소"
				,	clickCallback : function( puddDlg ) {
	 					
						puddDlg.showDialog( false );
						// 추가적인 작업 내용이 있는 경우 이곳에서 처리
					}
				}
			]
		}
	});	
}

function fnResetAuth(){
	
	if(Pudd( "#exArea" ).getPuddObject().val() == ''){
		alert('회사선택 해주세요.');
		return;
	}
	$.ajax({
		type:"POST",
		data:{
			compSeq : Pudd( "#exArea" ).getPuddObject().val()
		},
		url:'<c:url value="/devmanager/ResetAuth.do"/> ',
		datatype : "application/json",
		success : function(data){
			
			if (data.result.resultCode === "SUCCESS") {
				alert("증빙유형 초기화 실행 완료 되었습니다");
			} else if(data.result.resultCode === "FAIL"){
				alert("증빙유형 초기화 실행 실패 하였습니다.");
			}
		},error : function(error){
			alert(error);
		}
	})
}


function fnPostBuild(){
	if( confirm('설치 하시겠습니까?') ){
		$.ajax({
	        type:"POST",
	        url: "FuncNp20Install.do",
	        datatype : "application/json",
	        data : { moduleName : window.event.target.id },
	        success : function(data) {
	        	if(data.isSuccess.match("SUCCESS") != null || data.isSuccess.match("Build") != null){		// SUCCESS가 포함된 데이터가 없다면 FAIL <> FAIL일 경우 null return
	            	alert("설치 성공하였습니다");
	        	}
	        	else {
	        		alert("설치 실패하였습니다. (개발팀에 문의 바랍니다)");
	        	}
	        },
	        error : function(xhr, status, error) {
	           alert(error)
	        }
	  	});
	}
}

function fnDeleteExnp(){
	if( prompt('초기화를 진행하시겠습니까?\n1.전송된문서 있는지 확인 필요\n2.참조품의된 문서 없는지 확인\n3.초기화시 문서 복구 불가\n\n초기화를 하시려면 입력칸에 "지금삭제" 를 입력해주세요.') == '지금삭제' ){
		$.ajax({
	        type:"POST",
	        url: "FuncNp20Delete.do",
	        datatype : "application/json",
	        data : { moduleName : window.event.target.id },
	        success : function(data) {
	        	if(data.isSuccess.match("SUCCESS") != null){		// SUCCESS가 포함된 데이터가 없다면 FAIL <> FAIL일 경우 null return
	            	alert("초기화 되었습니다.");
	        	}
	        	else {
	        		alert("초기화 실패입니다. 개발팀 문의 부탁드립니다.");
	        	}
	        },
	        error : function(xhr, status, error) {
	           alert(error)
	        }
	  	});
	}
}

function refreshGS() {
	$.ajax({
		 type:"POST",
	        url: "RefreshAll.do",
	        datatype : "application/json",
	        data : { moduleName : window.event.target.id },
	        success : function(data) {
	        	if (data.isSuccess.match("Refresh") != null) {
	        		alert("Refresh 성공 하였습니다.");
	        	}
	        	else {
	        		alert("Refresh 실패하였습니다. (개발팀에 문의 바랍니다)");
	        	}
	        },
	        error : function(xhr, status, error) {
	           alert(error);
	        }
	});
}

function fnBudget(){
	$.ajax({
        type:"POST",
        url:'<c:url value="/devmanager/InsertBudget.do"/> ',
        datatype : "application/json",
        data : { moduleName : window.event.target.id},
        success : function(data) {
        	if(data.isSuccess.match("SUCCESS") != null || data.isSUccess.match("SUCCESS") != ""){
            	alert("예산연동 모듈 설치 완료 되었습니다.");
        	} else {
        		alert("예산연동 모듈 설치 실패 하였습니다");
        	}
        },
        error : function(xhr, status, error) {
           alert(error)
        }
	});
	
}

function fnSynCloudcNow() {
	$.ajax({
        type:"POST",
		url : '<c:url value="/devmanager/CloudCmsBatch.do" />',
		datatype : "application/json",
		data : { moduleName : window.event.target.id},
		success : function(data) {
        	if(data.isSuccess.match("SUCCESS") != null || data.isSUccess.match("SUCCESS") != ""){
				alert("클라우드 CMS배치 실행 완료 되었습니다");
			} else {
				alert("클라우드 CMS배치 실행 실패 하였습니다.");
			}
		},
        error : function(xhr, status, error) {
            alert(error)
         }
	});
}


/*	[ajax] CMS module interworking immediately
---------------------------------------*/
function fnSyncNow() {
	$.ajax({
		async : true,
		type : "post",
		url : '<c:url value="/common/batch/cms/CommonSetCmsSyncNow.do" />',
		datatype : "json",
		data : {},
		success : function(result) {
			if (result.result.resultCode === "SUCCESS") {
				alert("CMS배치 실행 완료 되었습니다");
			} else if(result.result.resultCode === "FAIL"){
				alert("CMS배치 실행 실패 하였습니다.");
			}
		},
		error : function(err) {
			alert(err);
		}
	});
}

function fnAuthMain(){
    var url = "<c:url value='authManagerMain.do'/>";
    var pop = window.open("", "authPop", "width=1280,height=700,scrollbars=no,screenX=150,screenY=150");

    frmPop.target = "authPop";
    frmPop.method = "post";
    frmPop.action = url
    frmPop.submit();
    frmPop.target = "";
    pop.focus();
    return;
}

</script>

<form id="frmPop" name="frmPop">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="" /> 
	<input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" /> 
	<input type="hidden" id="langCode_forCmPop" name="langCode" width="500" /> 
	<input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" /> 
	<input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" /> 
	<input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" /> 
	<input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" /> 
	<input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" /> 
	<input type="hidden" id="selectMode" name="selectMode" width="500" value="" /> 
	<input type="hidden" id="selectItem" name="selectItem" width="500" value="" /> 
	<input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> 
	<input type="hidden" id="callback" name="callback" value="" />
	<input type="hidden" name="callbackUrl" width="500" value="/exp/html/common/callback/cmmOrgPopCallback.jsp" />
</form>
	
</body>
</html>