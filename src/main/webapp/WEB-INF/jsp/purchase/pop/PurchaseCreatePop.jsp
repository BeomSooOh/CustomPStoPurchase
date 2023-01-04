<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>구매품의 등록</title>

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

	<jsp:include page="/WEB-INF/jsp/common/cmmJunctionCodePop.jsp" flush="false" />		
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/UserOptionMap.jsp" flush="false" />	
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/NpUserResPop.jsp" flush="false" />	

	<script type="text/javascript">
	
	/* 예산관련 변수 시작 */
	var consDocSeq = "";
	var consSeq = "";
	
	var eaBaseInfo = ${eaBaseInfo};
	var commonParam = {};
	var commonElement;
	
	commonParam.callback = 'fnCommonCode_callback';
	commonParam.widthSize = "628";
	commonParam.heightSize = "546";
	commonParam.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
	commonParam.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
	commonParam.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
	commonParam.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
	commonParam.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
	commonParam.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
	
	commonParam.erpDivSeq = optionSet.erpEmpInfo.erpDivSeq;
	commonParam.erpDivName = optionSet.erpEmpInfo.erpDivName;
	
	commonParam.erpGisuDate = commonParam.frDate.replaceAll('-','');
	
	commonParam.opt01 =  '2'; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
	commonParam.opt02 = '1'; /* 1: 모두표시, 2: 사용기한결과분 숨김 */
	commonParam.opt03 = '2'; /* 1: 예산그룹 전체, 2: 예산그룹 숨김 */
	commonParam.grFg = '2'; /* 1 : 수입, 2 : 지출 */		
	
	commonParam.resDocSeq =  "-1";
	commonParam.consDocSeq =  "-1";
	commonParam.confferDocSeq =  "-1";
	commonParam.confferSeq =  "-1";
	commonParam.confferBudgetSeq = "-1";
	commonParam.consSeq = "-1";
	commonParam.resSeq = "-1";
	commonParam.selectedBudgetSeqs = "";	
	
	var outProcessCode = "Conclu01";
	var disabledYn = "${disabledYn}";
	
	var insertDataObject = {};
	
	var attachFormList = [];
	var attachFileNew = [];
	var attachFileDel = [];		
	var commonCodeTargetInfo = [];
	var targetElement;
	
	var tempArray = [];
	var tempObj = {};
	var tempStr = "";
	
	<c:forEach var="items" items="${attachForm_Purchase01}">
	
	tempObj = {};
	tempArray =  "${items.LINK}".split('▦');
	tempObj.code = "${items.CODE}";
	tempObj.formNm = "${items.NAME}";
	
	tempObj.mustYn = tempArray[0];
	tempObj.formFileNm = tempArray[1];
	tempObj.formFileId = tempArray[2];
	
	tempObj.fileId = "${items.file_id}";
	tempObj.fileName = "${items.file_name}";
	tempObj.fileExt = "${items.file_ext}";
	tempObj.newYn = "${items.new_yn}";
	
	attachFormList.push(tempObj);
	</c:forEach>	
	
	function fnChangeEtc(e){
		
		if($(e).attr('type') == "radio" || $(e).attr('type') == "select"){
			$('[name^="' + $(e).attr('name') + '_"]').hide();
		}
		
		if($(e).attr('type') == "select"){
			$('[name="' + $(e).attr('name') + "_" + $(e).val() + '"]').show();
		}else{
			
			if(e.checked){
				$('[name="' + $(e).attr('name') + "_" + $(e).val() + '"]').show();	
			}else{
				$('[name="' + $(e).attr('name') + "_" + $(e).val() + '"]').hide();
			}
		}
	}	
	
	
	function fnSectorAdd(tableName, maxCnt){
		
		var aaDataCnt = $('[name="'+tableName+'"] tr[name=addData]').length + 1;
		
		if(maxCnt != null && aaDataCnt > maxCnt){
			msgSnackbar("warning", "등록 가능한 개수를 초과했습니다.");
			return;
		}			
		
		var cloneData = $('[name="'+tableName+'"] tr[name=dataBase]').clone();
		$(cloneData).show().attr("name", "addData");
		
		$('[name="'+tableName+'"]').append(cloneData);
		
		amountInputSet();
		
	}
	
	function fnSectorDel(e, tableName){
		
		if(tableName != null && $('[name="'+tableName+'"] tr[name=addData]').length == 1){
			return;
		}
		
		$(e).closest("tr").remove();
		
	}		
	
	
	
	function fnCommonCode_trName(code, e) {
		
		if(e != null){
			commonElement = $(e).closest("tr");
			
			if(code != "tr"){
				if(code == "budgetlist"){
					commonParam.erpDivSeq = $(commonElement).find("[name=erp_budget_div_seq]").val() + "|"; /* 회계통제단위 구분값 '|' */
					commonParam.erpMgtSeq = $(commonElement).find("[name=pjt_seq]").val() + "|"; /* 예산통제단위 구분값 '|' */
				}else{
					commonParam.erpDivSeq = $(commonElement).find("[name=erp_budget_div_seq]").val(); /* 회계통제단위 구분값 '|' */
					commonParam.erpMgtSeq = $(commonElement).find("[name=pjt_seq]").val(); /* 예산통제단위 구분값 '|' */
				}
				commonParam.bottomSeq = $(commonElement).find("[name=bottom_seq]").val(); /* 하위사업 구분값 '|' */
				commonParam.erpBudgetDivSeq = commonParam.erpDivSeq.replace('|', '');
			}

		}

		fnCommonCodePop(code, commonParam, commonParam.callback);

		/* [ return ] */
		return;
	}
	
	/* ## 공통코드 - 팝업호출 ## */
	function fnCommonCodePop(code, obj, callback, data) {
		/* [ parameter ] */
		/*   - obj : 전송할 파라미터 */
		obj = (obj || {});
		/*   - callback : 코백 호출할 함수 명 */
		callback = (callback || '');
		/*   - data : 더미 */
		data = (data || {});

		/* 팝업 호출 */
		obj.widthSize = 780;
		obj.heightSize = 582;

		fnCallCommonCodePop({
			code : code,
			popupType : 2,
			param : JSON.stringify(obj),
			callbackFunction : callback,
			dummy : JSON.stringify(data)
		});
	}	
	
	function fnCommonCode_callback(param) {
		
		callbackResult = param;
		
		if(param != null){
			
			//거래처 
			if(param.code == "tr"){
				
				if($("[name=tr_seq][value="+param.trSeq+"]").length > 0){
					msgSnackbar("error", "이미 선택된 거래처입니다.");
					return;
				}					
				
				$(commonElement).find("[name=tr_seq]").val( param.trSeq || "" );
				$(commonElement).find("[name=tr_name]").val( param.trName || "" );
				
				$(commonElement).find("[name=tr_reg_number]").text( param.trRegNumber || "" );
				$(commonElement).find("[name=ceo_name]").text( param.ceoName || "" );
				$(commonElement).find("[name=addr]").text( param.addr || "" );
				
				$(commonElement).find("[name=at_tr_name]").val( param.atTrName || "" );
				$(commonElement).find("[name=ba_nb]").val( param.baNb || "" );
				$(commonElement).find("[name=btr_name]").val( param.btrName || "" );
				$(commonElement).find("[name=btr_seq]").val( param.btrSeq || "" );
				$(commonElement).find("[name=depositor]").val( param.depositor || "" );
				$(commonElement).find("[name=tr_fg]").val( param.trFg || "" );
				$(commonElement).find("[name=tr_fg_name]").val( param.trFgName || "" );
			
			//회계단위	
			}else if(param.code == "div"){
				$(commonElement).find("[name=erp_budget_div_seq]").val( param.divSeq || "" );
				$(commonElement).find("[name=erp_budget_div_name]").val( param.divName || "" );
			
			//프로젝트	
			}else if(param.code == "project"){
				$(commonElement).find("[name=pjt_seq]").val( param.pjtSeq || "" );
				$(commonElement).find("[name=pjt_name]").val( param.pjtName || "" );
				
			//하위사업	
			}else if(param.code == "bottom"){
				$(commonElement).find("[name=bottom_seq]").val( param.bottomSeq || "" );
				$(commonElement).find("[name=bottom_name]").val( param.bottomName || "" );
			
			//예산과목
			}else if(param.code == "budgetlist"){
				
				if($("[name=bgt_seq][value="+param.erpBudgetSeq+"]").length > 0){
					msgSnackbar("error", "이미 선택된 예산과목입니다.");
					return;
				}
				
				$(commonElement).find("[name=erp_budget_seq]").val( param.erpBudgetSeq || "" );
				$(commonElement).find("[name=erp_budget_name]").val( param.erpBudgetName || "" );
				
				if(param.erpBgt1Seq != ""){
					$(commonElement).find("[name=erp_bgt1_seq]").val( param.erpBgt1Seq );
					$(commonElement).find("[name=erp_bgt1_name]").val( param.erpBgt1Name );	
				}else{
					$(commonElement).find("[name=erp_bgt1_seq]").val("");
					$(commonElement).find("[name=erp_bgt1_name]").val("");
				}
				
				if(param.erpBgt2Seq != ""){
					$(commonElement).find("[name=erp_bgt2_seq]").val( param.erpBgt2Seq );
					$(commonElement).find("[name=erp_bgt2_name]").val( param.erpBgt2Name );	
				}else{
					$(commonElement).find("[name=erp_bgt1_seq]").val("");
					$(commonElement).find("[name=erp_bgt2_name]").val("");
				}
				
				if(param.erpBgt3Seq != ""){
					$(commonElement).find("[name=erp_bgt3_seq]").val( param.erpBgt3Seq );
					$(commonElement).find("[name=erp_bgt3_name]").val( param.erpBgt3Name );	
				}else{
					$(commonElement).find("[name=erp_bgt3_seq]").val("");
					$(commonElement).find("[name=erp_bgt3_name]").val("");
				}
				
				if(param.erpBgt4Seq != ""){
					$(commonElement).find("[name=erp_bgt4_seq]").val( param.erpBgt4Seq );
					$(commonElement).find("[name=erp_bgt4_name]").val( param.erpBgt4Name );	
				}else{
					$(commonElement).find("[name=erp_bgt4_seq]").val("");
					$(commonElement).find("[name=erp_bgt4_name]").val("");
				}					
			
				//예산금액 조회
				fnSetBudgetAmtInfo();
				
			}			
			
		}
		
	}
	
	
	function commonCodeSelectLayer(group, title, type, target, multiYn){
		
		commonCodeTargetInfo = [];
		
		/*
		if(appendYn == "Y"){
			commonCodeTargetSet(type, targetName);	
		}
		*/
		
		// puddDialog 함수
		Pudd.puddDialog({
		 
			width : 400
		,	height : 500
		 
		,	modal : true			// 기본값 true
		,	draggable : false		// 기본값 true
		,	resize : false			// 기본값 false
		 
		,	header : {
	 		title : title
		,	closeButton : true	// 기본값 true
		,	closeCallback : function( puddDlg ) {
				// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
				// 추가적인 작업 내용이 있는 경우 이곳에서 처리
			}
		}
		 
		,	body : {
		 
				iframe : true
			,	url : "${pageContext.request.contextPath}/purchase/layer/CodeSelectLayer.do?multiYn=" + multiYn + "&group=" + group
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
					,	value : <c:if test="${viewType == 'I'}">"확인"</c:if><c:if test="${viewType != 'I'}">"저장"</c:if>
					,	clickCallback : function( puddDlg ) {
						
						var iframeTag = document.getElementById( "dlgFrame" );
						iframeTag.contentWindow.fnDlgFrameFunc();							
						commonCodeCallback(type, target);
						puddDlg.showDialog( false );
							
						}
					},
					
					{
						attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
					,	value : <c:if test="${disabledYn == 'Y'}">"닫기"</c:if><c:if test="${disabledYn == 'N'}">"취소"</c:if>
					,	clickCallback : function( puddDlg ) {
							puddDlg.showDialog( false );
							attachFileNew = [];
							attachFileDel = [];	
						}
					}
				]
			}
		});			
		
	}		
	
	function commonCodeCallback(type, target){
		
		if(type == "ul"){
			$(target).find('[name="hope_company_list"] [name=addData]').remove();
			$.each(commonCodeTargetInfo, function( idx, addData ) {
				var cloneData = $(target).find('[name="hope_company_list"] [name=dataBase]').clone();
				$(cloneData).show().attr("name", "addData");
				$(cloneData).attr("addCode", addData.code);
				$(cloneData).find("[name=addName]").text(addData.name);
				$(target).find('[name="hope_company_list"]').append(cloneData);				
			});									
		}
	}	
	
	function fnSearchFile(e){
		targetElement = $(e).find('[name="hope_attach_info"]');
		document.getElementById('file_upload').addEventListener('change', handleFileSelect, false);
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
        	
        	//동일파일명 체크
        	var sameExists = false; 
        	
			$.each($(targetElement).find("[name=addFile]"), function( key, uploadFileInfo ) {
				
				if(f.fileName == $(uploadFileInfo).find('[name="attachFileName"]').text() &&
						f.fileExt == $(uploadFileInfo).find('[name="attachExtName"]').text()){
					sameExists = true;
				}
                
			});	   
			
			if(sameExists){
				msgSnackbar("error", "동일한 이름의 첨부파일이 존재합니다.");
			}else{
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
	                    
	        			var cloneData = $(targetElement).find('[name="attachBase"]').clone();
	        			$(cloneData).show().attr("name", "addFile");
	        			$(cloneData).find('[name="attachFileName"]').attr("fileid", f.uid);
	        			$(cloneData).find('[name="attachFileName"]').text(f.fileName);
	        			$(cloneData).find('[name="attachExtName"]').text(f.fileExt);	
	        			
	        			$(targetElement).append(cloneData);
						
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
	
	function fnDelFile(e){
		targetElement = $(e).closest("li").remove();
	}		
		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>구매품의 등록</h1>
		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8">
					<c:if test="${btnSaveYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('save')" value="임시저장" />
					</c:if>
					<input type="button" class="psh_btn" onclick="fnCallBtn('attach')" value="첨부파일" />
					<c:if test="${btnApprYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('appr')" value="결재작성" />
					</c:if>					
				</div>
			</div>
		</div>
	</div>


	<div class="pop_con" style="overflow: auto; min-height: 460px;">
		<div class="top_box">
			<dl>
				<dt>작성일자</dt>
				<dd objKey="write_dt" objCheckFor="checkVal('date', 'writeDt', '작성일자', 'selectDate(this)', '')" ><input ${disabled} name="writeDt" type="text" value="${write_dt}" class="puddSetup" pudd-type="datepicker"/></dd>
				
				<input objKey="write_comp_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${write_comp_seq}" />
				<input objKey="write_dept_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${write_dept_seq}" />
				<input objKey="write_emp_seq" objCheckFor="checkVal('text', this, '작성자', 'selectOrgchart()', '')" type="hidden" value="${write_emp_seq}" />
				
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="130"/>
					<col width="369"/>
					<col width="130"/>
					<col width="369"/>
				</colgroup>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 유형선택</th>
					<td colspan="3" objKey="purchase_type" objCheckFor="checkVal('radio', 'purchaseType', '유형선택', '', '')" >
						<input ${disabled} type="radio" name="purchaseType" class="puddSetup" pudd-label="비품" value="01" <c:if test="${ (viewType == 'I') || (viewType == 'U' && purchaseDetailInfo.purchase_type == '01') }">checked</c:if> />
						<input ${disabled} type="radio" name="purchaseType" class="puddSetup" pudd-label="소모품" value="02" <c:if test="${ viewType == 'U' && purchaseDetailInfo.purchase_type == '02' }">checked</c:if> />	
					</td>	
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 문서제목</th>
					<td colspan="3"><input objKey="title" objCheckFor="checkVal('text', this, '문서제목', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="<c:if test="${ viewType == 'U' }">${purchaseDetailInfo.title}</c:if>" /></td>
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 구매방법</th>
					<td><input objKey="purchase_method" objCheckFor="checkVal('text', this, '구매방법', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="<c:if test="${ viewType == 'U' }">${purchaseDetailInfo.purchase_method}</c:if>" /></td>
					<th>결재방법</th>
					<td objKey="pay_type_info" objCheckFor="checkVal('checkbox', 'payType', '결제방법', 'mustAlert', '|etc|')" >
						<c:forEach var="items" items="${payTypeCode}">
							<c:choose>
								<c:when test="${items.CODE == 'etc'}">
									<input ${disabled} type="checkbox" onclick="fnChangeEtc(this)" name="payType"  value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
									<input ${disabled} type="text" style="display:none;" name="payType_${items.CODE}" pudd-style="width:150px;" class="puddSetup" value="" />
								</c:when>
								<c:otherwise>
									<input ${disabled} type="checkbox" name="payType"  value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
								</c:otherwise>
							</c:choose>						
						</c:forEach>						
					</td>
				</tr>
				<tr>
					<th>공급업체</th>
					<td colspan="3">
						<div class="com_ta mt10">
							<table name="tradeList" objKey="tradeObjList" objCheckFor="checkVal('obj', 'tradeList', '계약대상', 'mustAlert', '')">
								<colgroup>
									<c:if test="${disabledYn == 'N'}"> 
									<col width="50"/>
									</c:if>				
									<col width="200"/>
									<col width="150"/>
									<col width="250"/>
									<col width=""/>
								</colgroup>
								<tr>
									<c:if test="${disabledYn == 'N'}"> 
									<th class="cen">
										<input type="button" onclick="fnSectorAdd('tradeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									</c:if>				
									<th class="cen">사업자명</th>
									<th class="cen">사업자등록번호</th>
									<th class="cen">희망기업여부</th>
									<th class="cen">희망기업확인서</th>
								</tr>
								<tr name="dataBase" style="display:none;">
									<c:if test="${disabledYn == 'N'}"> 
									<td>
										<input type="button" onclick="fnSectorDel(this, 'tradeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>				
									<td>
										<div class="posi_re">
											<input tbval="Y" name="at_tr_name" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="ba_nb" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="btr_name" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="btr_seq" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="tr_fg" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="tr_fg_name" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="depositor" type="hidden" value="" requiredNot="true" />
										
											<input tbval="Y" name="tr_seq" type="hidden" value="" />
											<input tbval="Y" name="tr_name" type="text" pudd-style="width:calc( 100% );" class="puddSetup pr30" value="" readonly />
											
											<c:if test="${disabledYn == 'N'}"> 
											<a href="#n" onclick="fnCommonCode_trName('tr', this)" class="btn_search" style="margin-left: -25px;"></a>
											</c:if>
										</div>
									</td>
									<td tbval="Y" name="tr_reg_number" requiredNot="true" class="cen"></td>
									<td>
										<div class="multi_sel" style="width:calc( 100% - 58px);">
											<ul tbval="Y" tbType="ul" name="hope_company_list" class="multibox" style="width:100%;">							
												<li name="dataBase" addCode="" style="display:none;">
													<span name="addName"></span>
													<c:if test="${disabledYn == 'N'}"> 
													<a href="#n" onclick="$(this).closest('li').remove();" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a>
													</c:if>
												</li>
											</ul>								
										</div>
										<c:if test="${disabledYn == 'N'}"> 
										<div class="controll_btn p0 pt4">	
											<button id="" onclick="commonCodeSelectLayer('hopeCompany', '희망기업여부', 'ul', $(this).closest('tr'), 'Y')">선택</button>
										</div>
										</c:if>
									</td>									
									<td class="file_add">	
										<ul tbval="Y" tbType="file" name="hope_attach_info" class="file_list_box fl">
											<li name="attachBase" style="display:none;">
												<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" alt="">
												<a href="javascript:;" name="attachFileName" onClick="fnDownload(this)" class="fl ellipsis pl5" style="max-width: 250px;"></a>
												<span name="attachExtName"></span>
												<c:if test="${disabledYn == 'N'}"> 
												<a href="javascript:;" onclick="fnDelFile(this)" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" alt=""></a>
												</c:if>
											</li>
										</ul>
										<c:if test="${disabledYn == 'N'}">
										<span class="fr mt2"><input onclick="fnSearchFile($(this).closest('tr'))" type="button" class="puddSetup" value="파일찾기" /></span>
										</c:if>
									</td>								
								</tr>
								<tr name="addData">
									<c:if test="${disabledYn == 'N'}"> 
									<td>
										<input type="button" onclick="fnSectorDel(this, 'tradeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>				
									<td>
										<div class="posi_re">
											<input tbval="Y" name="at_tr_name" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="ba_nb" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="btr_name" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="btr_seq" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="tr_fg" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="tr_fg_name" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="depositor" type="hidden" value="" requiredNot="true" />
										
											<input tbval="Y" name="tr_seq" type="hidden" value="" />
											<input tbval="Y" name="tr_name" type="text" pudd-style="width:calc( 100% );" class="puddSetup pr30" value="" readonly />
											
											<c:if test="${disabledYn == 'N'}"> 
											<a href="#n" onclick="fnCommonCode_trName('tr', this)" class="btn_search" style="margin-left: -25px;"></a>
											</c:if>
										</div>
									</td>
									<td tbval="Y" name="tr_reg_number" requiredNot="true" class="cen"></td>
									<td>
										<div class="multi_sel" style="width:calc( 100% - 58px);">
											<ul tbval="Y" tbType="ul" name="hope_company_list" class="multibox" style="width:100%;">							
												<li name="dataBase" addCode="" style="display:none;">
													<span name="addName"></span>
													<c:if test="${disabledYn == 'N'}"> 
													<a href="#n" onclick="$(this).closest('li').remove();" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a>
													</c:if>
												</li>
											</ul>								
										</div>
										<c:if test="${disabledYn == 'N'}"> 
										<div class="controll_btn p0 pt4">	
											<button id="" onclick="commonCodeSelectLayer('hopeCompany', '희망기업여부', 'ul', $(this).closest('tr'), 'Y')">선택</button>
										</div>
										</c:if>
									</td>									
									<td class="file_add">	
										<ul tbval="Y" tbType="file" name="hope_attach_info" class="file_list_box fl">
											<li name="attachBase" style="display:none;">
												<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" alt="">
												<a href="javascript:;" name="attachFileName" onClick="fnDownload(this)" class="fl ellipsis pl5" style="max-width: 250px;"></a>
												<span name="attachExtName"></span>
												<c:if test="${disabledYn == 'N'}"> 
												<a href="javascript:;" onclick="fnDelFile(this)" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" alt=""></a>
												</c:if>
											</li>
										</ul>
										<c:if test="${disabledYn == 'N'}">
										<span class="fr mt2"><input onclick="fnSearchFile($(this).closest('tr'))" type="button" class="puddSetup" value="파일찾기" /></span>
										</c:if>
									</td>	
								</tr>				
							</table>
						</div>						
					</td>
				</tr>
			</table>
		</div>


		<!-- 예산정보 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">예산정보</p>
			</div>
		</div>
		
		<div class="com_ta4">
			<table>
				<colgroup>
					<col width="50"/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="ac">
						<input type="button" id="" class="puddSetup" style="width:20px;height:20px;background:url('../../../Images/btn/btn_plus01.png') no-repeat center" value="" />
					</th>
					<th class="ac">예산회계단위</th>
					<th class="ac">프로젝트</th>
					<th class="ac">하위사업</th>
					<th class="ac">예산과목</th>
				</tr>
				<tr>
					<td>
						<input type="button" id="" class="puddSetup" style="width:20px;height:20px;background:url('../../../Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<!-- 테이블 -->
		<div class="com_ta6 mt10">
			<table>
				<colgroup>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="150"/>
				</colgroup>
				<tr>
					<th>관</th>
					<td>운영비(210)</td>
					<th>항</th>
					<td>일반수용비(01)</td>
					<th>목</th>
					<td></td>
					<th>세</th>
					<td></td>
				</tr>				
				<tr>
					<th>예산액</th>
					<td class="ri pr10">1,000,000</td>
					<th>집행액</th>
					<td class="ri pr10">1,000,000</td>
					<th>품의액</th>
					<td class="ri pr10">1,000,000</td>
					<th>예산잔액</th>
					<td class="ri pr10">1,000,000</td>
				</tr>
			</table>
		</div>	


		<!-- 물품규격 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">물품규격</p>
			</div>
		</div>
		
		<div class="com_ta4 ova_sc">
			<table style="width:2000px;">
				<colgroup>
					<col width="50"/>
					<col width="200"/>
					<col width="250"/>
					<col width="200"/>
					<col width="150"/>
					<col width="150"/>
					<col width="200"/>
					<col width="150"/>
					<col width="300"/>
					<col width="250"/>
					<col width="250"/>
					<col width="200"/>
					<col width="200"/>
					<col width="130"/>
					<col width="250"/>
					<col width="200"/>
				</colgroup>
				<tr>
					<th class="ac">
						<input type="button" id="" class="puddSetup" style="width:20px;height:20px;background:url('../../../Images/btn/btn_plus01.png') no-repeat center" value="" />
					</th>
					<th class="ac">물품분류번호</th>
					<th class="ac">물품식별번호</th>
					<th class="ac">품명</th>
					<th class="ac">조달단가</th>
					<th class="ac">구매수량</th>
					<th class="ac">소계</th>
					<th class="ac">납품기한</th>
					<th class="ac">수령장소</th>					
					<th class="ac">취득수수료</th>
					<th class="ac">단위</th>
					<th class="ac">물품대장코드</th>
					<th class="ac">사용위치</th>
					<th class="ac">국내외구분</th>
					<th class="ac">국가코드</th>
					<th class="ac">취득사유코드</th>
				</tr>
				<tr>
					<td>
						<input type="button" id="" class="puddSetup" style="width:20px;height:20px;background:url('../../../Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					<td><input type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup" value="" /></td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td><input type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup" value="" /></td>
					<td><input type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup ar" value="" /></td>
					<td><input type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup ar" value="" /></td>
					<td class="ri">1,000,000원</td>
					<td><input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/></td>
					<td><input type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup" value="" /></td>
					<td class="le">
						<input type="text" pudd-style="width:100px;" class="puddSetup ar" value="" /> 원
						<a href="#n" class="btn_search ml10"></a>
					</td>
					<td class="file_add">	
						<ul class="file_list_box fl">
							<li>
								<a href="javascript:;" class="fl ellipsis pl5" style="max-width:150px;" id="">킬로그램</a>
								<a href="javascript:;" id="" title="파일삭제"><img src="../../../Images/btn/close_btn01.png" id="" alt=""></a>
							</li>
						</ul>
						<sapn class="fr"><a href="#n" class="btn_search" style="margin-left: -30px; margin-top:-4px"></a></span>
					</td>
					<td>
						<select class="puddSetup" pudd-style="width:calc( 100% - 10px);">
							<option value="">내구성물품대장</option>
						</select>
					</td>
					<td>
						<select class="puddSetup" pudd-style="width:calc( 100% - 10px);">
							<option value="">본사1층 서울관광플라자</option>
						</select>
					</td>
					<td>
						<select class="puddSetup" pudd-style="width:calc( 100% - 10px);">
							<option value="">국내</option>
						</select>
					</td>
					<td class="file_add">	
						<ul class="file_list_box fl">
							<li>
								<a href="javascript:;" class="fl ellipsis pl5" style="max-width:150px;" id="">남아프리카공화국 오스트레일리아</a>
								<a href="javascript:;" id="" title="파일삭제"><img src="../../../Images/btn/close_btn01.png" id="" alt=""></a>
							</li>
						</ul>
						<sapn class="fr"><a href="#n" class="btn_search" style="margin-left: -30px; margin-top:-4px"></a></span>
					</td>
					<td>
						<select class="puddSetup" pudd-style="width:calc( 100% - 10px);">
							<option value="">취득/무상관리전환</option>
						</select>
					</td>
				</tr>
			</table>
		</div>

		<!-- 테이블 -->
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="160"/>
					<col width="408"/>
					<col width="160"/>
					<col width="270"/>
				</colgroup>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 녹색제품구매확인</th>
					<td>
						<input type="radio" name="radi" class="puddSetup" pudd-label="녹색제품 구입" />
						<input type="radio" name="radi" class="puddSetup" pudd-label="해당없음" />
						
						<select class="puddSetup pl15" pudd-style="width:150px;">
							<option value="">인증구분 선택</option>
						</select>
					</td>
					<th>녹색제품 미구매 사유</th>
					<td>
						<select class="puddSetup pl15" pudd-style="width:100%;">
							<option value="">품목에 녹색제품 없음</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>녹색제품 분류</th>
					<td colspan="3">
						<div class="posi_re lh24">
							<span class="fl" style="width:calc( 100% - 30px);">업체요구사항업체요구사항 <img src="../../../Images/btn/close_btn01.png" id="" alt="" class="mtImg" onclick="" /></span>
							<sapn class="fr pr10"><a href="#n" class="btn_search" style="margin-left: -15px;"></a></span>
						</div>	
					</td>
				</tr>
			</table>
		</div>
		
		
		
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->

<div id="exArea"></div>
<form id="frmPop" name="frmPop"> 
		<input type="hidden" name="selectedItems" id="selectedItems" value="" />
		<input type="hidden" name="popUrlStr" id="txt_popup_url" value="/gw/systemx/orgChart.do" />
		<input type="hidden" name="selectMode" id="selectMode" value="u" />
		<input type="hidden" name="selectItem" value="m" />
		<input type="hidden" name="callback" id="callback" value="" />
		<input type="hidden" name="compSeq" value="" />
		<input type="hidden" name="callbackUrl" value="/gw/html/common/callback/cmmOrgPopCallback.jsp"/>
		<input type="hidden" name="empUniqYn" value="Y" />
		<input type="hidden" name="empUniqGroup" value="ALL" />
</form>
<input style="display:none;" id="file_upload" type="file" />
</body>
</html>