<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<script type="text/css" src='<c:url value="/css/pudd.css"></c:url>'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<!--Excel다운로드를 위한 js-->
<script type="text/javascript"
	src='<c:url value="/js/t_excel/jszip-3.1.5.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/t_excel/FileSaver-1.2.2_1.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/t_excel/jexcel-1.0.4.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/pudd/pudd-1.1.186.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudding/js/jquery-1.9.1.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudding/common.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/css" src='<c:url value="/js/pudding/css/common.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/css/animate.css"></c:url>'></script>
<script type="text/css" src='<c:url value="/css/re_pudd.css"></c:url>'></script>


<!-- iframe wrap -->
<!-- 컨텐츠타이틀영역 -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl style="height: 40px;">
			<dt class="ar" style="width:70px;">${CL.ex_reolutionDept}<!-- 결의부서 --></dt>
			<dd>
				<input type="text" style="width:199px;" class="puddSetup" id="txtErpDeptName" readonly/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpDeptSeq"/>
			</dd>
			<dt class="ar" style="width:70px;">${CL.ex_budgetUnit} <!-- 예산단위 --> </dt>
			<dd>
				<input type="text" style="width:169px;" class="puddSetup" id="txtErpBgudgetName" readonly/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBudgetSeq"/>
				<input type="button" id="btnErpBudDeptSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
			</dd>
			
			<dt id = "dtBizChk" class="ar" style="width:70px;">${CL.ex_businessPlan} <!-- 사업계획 --></dt>
			<dd id = "ddBizChk">
				<input type="text" style="width:169px;" class="puddSetup" id="txtErpBizplanName" readonly/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBizplanSeq"/>
				<input type="button" id="btnErpBizplanSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
			</dd>
			<dd><input type="button" class="puddSetup submit" value="${CL.ex_search}" id="btnSerchYesilList"/></dd> <!--검색-->
		</dl>
		
		<dl style="height: 50px;">
			<dt class="ar" style="width:70px;">${CL.ex_budgetAccount}<!-- 예산계정 --></dt>
			<dd>
				<div class="controll_btn p0">
					<input type="text" style="width:169px;" class="puddSetup" id="txtErpBgacctName" readonly/>
					<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBgacctSeq"/>
					<input type="button" id="btnErpBgacctSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
					<button id="btnErpBgacctRefresh" class="reload_btn k-button" data-role="button" role="button" aria-disabled="false" tabindex="0"></button>
				</div>
			</dd>	
			<dt class="ar" style="width:90px;">${CL.ex_budgetYearbase}<!-- 예산년월(기수) --></dt>
			<dd><input type="text" id="txtBudgetYM" class="puddSetup ac" value="" style="width:48px;"/></dd>
			<dd>
				<input type="hidden" id="txtBudgetYMText" class="puddSetup ac" value="" style="width:171px;" disabled="true"/>
 				<input type="text" id="txtErpGisuFromDate" class="puddSetup" pudd-type="datepicker" pudd-type-display="month" value="" />
				~
				<input type="text" id="txtErpGisuToDate" class="puddSetup" pudd-type="datepicker" pudd-type-display="month" value="" />
			</dd>
		</dl>
	</div>


	<div id="" class="controll_btn btn_div cl">
		<div class="left_div fwb mt5">
			${CL.ex_yeCount}<!-- 총 --> <span class="" id="txtCntYesilReport">-</span> ${CL.ex_yeCase}<!-- 건 -->
		</div>
		<button id="btnExcelDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
	</div>
	
	<div id="divGridArea" style="height: 578px;">
		<div class="dal_Box" style="height: 564px;">
			<div class="dal_BoxIn posi_re" style="height: 564px;">
				<div class="posi_right" style="left: 0px;">
					<div class="com_ta2">
						<table>
							<colgroup>
								<col width="10%">
								<col width="20%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr></tr>
								<tr>
									<th>
										${CL.ex_budgetAccountCode}<!-- 예산계정코드 -->
									</th>
									<th>
										${CL.ex_accNm}<!-- 예산계정명 -->
									</th>
									<th>
										${CL.ex_budgetAmt}<!-- 예산금액 -->
									</th>
									<th>
										${CL.ex_noSendExpend}<!-- 미전송결의 -->
									</th>
									<th>
										${CL.ex_perFormance}<!-- 집행실적 -->
									</th>
									<th>
										${CL.ex_executionBalance}<!-- 집행잔액 -->
									</th>
									<th>
										${CL.ex_executionRate}<!-- 집행률 -->
									</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="hover_no com_ta2 ova_sc bg_lightgray" onscroll="" style="height: 500px;">
						<table>
							<colgroup>
								<col width="10%">
								<col width="20%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<tbody id="gridYesilReprtContents">
							</tbody>
						</table>						
					</div>
					<div class="hover_no com_ta2 bg_lightgray" onscroll="" style="height: 70px;">
						<table>
							<colgroup>
								<col width="10%">
								<col width="20%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<tbody id="gridYesilReprtTotal">
								<tr>
									<td style="background: #f9f9f9;" colspan="2" class="ri"> ${CL.ex_totalAmt} <!-- 합계 --> </td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalOpenAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalNonSendResAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalErpApplyAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalResultAmt">0</td>
									<td style="background: #f9f9f9;" class="cen" id="txtTotalEnforcementRate">-</td>
									<td style="background: #f9f9f9;"></td>
								</tr>							
							</tbody>
						</table>	
					</div>
				</div>
			</div>
		</div>
	</div>
</div><!-- //sub_contents_wrap -->
<div id="loadingProgressBar"></div>


<script>
	/* ## document ready ## */
	/* ====================================================================================================================================================== */
		/* ${ViewBag.params} */
	
		var erpEmpInfo = {
	        deptSeq : "${ViewBag.params.deptInfo.CD_DEPT}"
	        ,deptName : "${ViewBag.params.deptInfo.NM_DEPT}"
	        ,erpCompSeq : "${ViewBag.params.erpCompSeq}"
	        ,erpEmpSeq : "${ViewBag.params.erpEmpSeq}"
	    };

	
	$(document).ready(function() {
		
		/* 0. 화면 레이아웃 출력용 기본 그리드 출력 */
		fnRenderTable([], true);
		
		/* 1. 버튼이벤트 등록 */
		fnSetBtnEvent();
		
		/* 2. 사용자 기본 정보 디폴트 옵션 */
		fnSetDefaultData();
		
		/* 3. ERPiU 예산 년월 정보 조회 */
		fnGetGisuInfo();
		
		fnGetEnvCheck();
		
	});

	/*	[기능] 회계 기수 정보 조회h
   	--------------------------------------*/
   	function fnGetGisuInfo(gisu) {
   		
		var param ={};
		param.noAccSeq = (gisu || '');

        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex/ExERPYesilIUAccSeqInfo.do" />',
            datatype : 'json',
            async : false,
            data : param ,
            success : function( data ) {
           		gisuInfo = data.result;
				$('#txtBudgetYM').val(gisuInfo.noAccSeq);

				$('#txtBudgetYMText').val( fnGetDateFormat(gisuInfo.dtFrom) + ' ~ ' + fnGetDateFormat(gisuInfo.dtTo) );
				
				Pudd( "#txtErpGisuFromDate" ).getPuddObject().setDate( gisuInfo.dtFrom.substring(0,7));
				Pudd( "#txtErpGisuToDate" ).getPuddObject().setDate( gisuInfo.dtTo.substring(0,7));
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
    }
	
   	/*	사업계획 사용/미사용 여부 확인 
	--------------------------------------------------*/
	function fnGetEnvCheck(){
		
   		var param ={};
		
   		$.ajax({
   			type : 'post',
   			url  : '<c:url value="/ex/expend/admin/ExAdminIuYesilBizPlanCheck.do" />',
   			datatype : 'json',
   			async : false,
   			data : param,
   			success : function( result ){
   				let cdEnv = result.result.aData.CD_ENV;
   				
   				if(cdEnv == '0'){
   					$('#dtBizChk').css("display","none");
   					$('#ddBizChk').css("display","none");
   				}else if(cdEnv == '1'){
   					$('#dtBizChk').css("display","block");
   					$('#ddBizChk').css("display","block");
   				}
   			},
   			error : function ( result ){
   				console.log("! [EX] ERROR - " + JSON.stringify(result));
   			}
   		})
   	}
		
	/*	[공통] 데이터 날짜 포멧 변경
	--------------------------------------------------*/
	function fnGetDateFormat(text){
		text = ( text || '' ).replace(/[^0-9]/gi, '')
		if(text.length == 8 ){
			return text.substring(0,4) + '-' + text.substring(4,6) + '-' + text.substring(6,8);   
		}else if(text.length == 6 ){
			return text.substring(0,4) + '-' + text.substring(4,6);
		}else if(text.length == 4){
			return text;
		}else {
			return '';
		}
	}
	
	/*	[초기화] 사용자 기본 정보 이용 데이터 초기화
	--------------------------------------------------*/
	function fnSetDefaultData(){
		$('#txtErpDeptSeq').val(erpEmpInfo.deptSeq);
		$('#txtErpDeptName').val(erpEmpInfo.deptName);	
	}
	
	/*	[버튼 이벤트] 화면 버튼 이벤트 등록
	--------------------------------------------------*/
	function fnSetBtnEvent(){
		// 숫자만 입력 가능 
     	var validCheck = {
    		    keyDown : function (e) {
    		        var key;
    		        if(window.event)
    		            key = window.event.keyCode; //IE
    		        else
    		            key = e.which; //firefox
    		        var event;
    		        if (key == 0 || key == 8 || key == 46 || key == 9){
    		            event = e || window.event;
    		            if (typeof event.stopPropagation != "undefined") {
    		                event.stopPropagation();
    		            } else {
    		                event.cancelBubble = true;
    		            }   
    		            return;
    		        }
    		        if (key < 48 || (key > 57 && key < 96) || key > 105 || e.shiftKey) {
    		            e.preventDefault ? e.preventDefault() : e.returnValue = false;
    		        }
    		    },        
    		    keyUp : function (e) {
    		        var key;
    		        if(window.event)
    		            key = window.event.keyCode; //IE
    		        else
    		            key = e.which; //firefox
    		        var event;
    		        event = e || window.event;        
    		        if ( key == 8 || key == 46 || key == 37 || key == 39 ) 
    		            return;
    		        else
    		            event.target.value = event.target.value.replace(/[^0-9]/g, "");
    		    },
    		    focusOut : function (ele) {
    		        ele.val(ele.val().replace(/[^0-9]/g, ""));
    		    }
    		};
		
			
		$("#btnErpDeptSelect , #btnErpBudDeptSelect , #btnErpBizplanSelect").click(function(){
			var btnType = $(this).attr('id').replace('btnErp','').replace('Select','');
			
			fnOpenCommonCodePop('N',btnType);
	
		});
		
		/* 예산계정 선택 팝업 */
		$('#btnErpBgacctSelect').click(function (){
			var getParam = "cdBudgetPipe=" +($("#txtErpBudgetSeq").val() || '') ;
				getParam += "&cdBizplanPipe=" + ($("#txtErpBizplanSeq").val() || '***');
			url = "<c:url value='/ex/expend/admin/ExAdminYesil2BudgetAcctPop.do?" + getParam + "'/>";
			fnIuYesilPopup(url, 640);
		});

		
		/* 예산계정 조회 초기화 */
		$('#btnErpBgacctRefresh').click(function (){
			$('#txtErpBgacctName').val('');
			$('#txtErpBgacctSeq').val('');
		});
		
		/* 검색 버튼 이벤트 지정 */
		$('#btnSerchYesilList').click(function (){
			fnSelectYesilList();
		});
		
		$('#txtBudgetYM').keydown(function (e){
			validCheck.keyDown(e);
		}).keyup( function(e){
    	    validCheck.keyUp(e);
    	    if(e.keyCode != 8){
    		var gisu = $(this).val();
    		fnGetGisuInfo(gisu);
    		}
    	}).focusout( function(e){        
    	    validCheck.focusOut($(this));
    	});
		
		$('#btnExcelDown').click(function(){
			fnExcelDownload();
		});
	}	
	
	/*	[검색] 예실대비 현황 리스트 검색및 출력  파라미터 수정 해야함 
	--------------------------------------------------*/
	var _yesilListAjaxParams;
	function fnSelectYesilList(){
		/* 1. 검색 기준 필수값 체크 
		if( !$('#txtErpBudgetSeq').val() ){
			alert('예산단위를 선택해주세요.');
			return;
		} else if( !$('#txtErpBizplanSeq').val() ){
			alert('사업계획을 선택해주세요.');
			return;
		} else if( !$('#txtErpBgacctSeq').val() ){
			alert('예산계정을 선택해주세요.');
			return;
		} else if(!$('#txtErpGisuFromDate').val()){
			alert('예산년월을 확인할 수 없습니다.');
			return;
		} else if (!$('#txtErpGisuToDate').val()){
			alert('예산년월을 확인할 수 없습니다.');
			return;
		}
*/
		var params = _yesilListAjaxParams = {
			cdDeptPipe : $('#txtErpDeptSeq').val()
			, cdBudgetPipe : $('#txtErpBudgetSeq').val()
			, cdBizplanPipe : $('#txtErpBizplanSeq').val()
			, cdBudgetAcctPipe : $('#txtErpBgacctSeq').val()
			, fromDt : $('#txtErpGisuFromDate').val().replace(/-/g, '')+'01'
			, toDt : $('#txtErpGisuToDate').val().replace(/-/g, '')+'31'
 			/* , fromDt : $('#txtBudgetYMText').val().split('~')[0].trim().replace(/-/g, '')
			, toDt : $('#txtBudgetYMText').val().split('~')[1].trim().replace(/-/g, '') */
		}
		
		var cdBudgetAcctPipe2 = $('#txtErpBgacctSeq').val().split('|');
		cdBudgetAcctPipe2.splice(cdBudgetAcctPipe2.length-1, 1);
		params.cdBudgetAcctPipe2 = '';
		for(var i =0; i<cdBudgetAcctPipe2.length; i++){
			var budgetCode =  "'"+ cdBudgetAcctPipe2[i] +"'";
			params.cdBudgetAcctPipe2 += ',' + budgetCode;
		}		
		params.cdBudgetAcctPipe2 = params.cdBudgetAcctPipe2.substring(1);
		// params.cdBudgetAcctPipe2 = cdBudgetAcctPipe2.join(',');
		
		$.ajax({
    		type:"post",
    		url : '<c:url value="/ex/expend/admin/ExAdminIuYesilInfoSelect.do" />',
    		datatype:"json",
    		data: params, 
    		success:function(result){
    			console.log(' 예실대비 현황 리스트 출력 ');
    			if(result.result.resultCode == 'SUCCESS'){
    				fnRenderTable(result.result.aaData, false);
    			}else{
    				fnRenderTable([], false);
    			}
    		}, error : function(result){
    		}
		});
		
	}
	
	/*	[코드도움] 공통 코드 도움 호출 
	--------------------------------------------------*/
	function fnOpenCommonCodePop( input ,codeType ) {
		if(input === 'Y'){
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnIuYesilCallback',
				searchStr : '',
				erp_emp_seq : (erpEmpInfo.erpEmpSeq || ''),
				erp_dept_seq : ($('#txtErpDeptSeq').val() || ''),
				budget_code : ($("#txtErpBudgetSeq").val() || ''),
				bizplan_code :($("#txtErpBizplanSeq").val() || '***'),
				acct_code : '',
				vat_type : '',
				reflectResultPop : '',
				expendCardOption : '',
				summryDisplayOption : '',
				formSeq : ''
			});
		}else{
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnIuYesilCallback',
				searchStr : '',
				erp_emp_seq : (erpEmpInfo.erpEmpSeq || ''),
				erp_dept_seq : ($('#txtErpDeptSeq').val() || ''),
				budget_code : ($("#txtErpBudgetSeq").val() || ''),
				bizplan_code :($("#txtErpBizplanSeq").val() || '***'),
				acct_code : '',
				vat_type : '',
				reflectResultPop : '',
				expendCardOption : '',
				summryDisplayOption : '',
				formSeq : ''
			});
		}
	}
		
	// 공통코드 콜백 함수 
	function fnIuYesilCallback(param){
		var target;
		var type = param.type;
		var elemId = '';
		switch (type){
		
		case 'dept':
			target = $('#txtErpDeptName');
			$('#txtErpDeptName').val(param.obj.erpDeptName);
			$('#txtErpDeptSeq').val(param.obj.erpDeptSeq);
			
			$('#txtErpBgudgetName').val('')
			$('#txtErpBudgetSeq').val('')
			
			$('#txtErpBizplanName').val('')
			$('#txtErpBizplanSeq').val('')
			
			$('#txtErpBgacctName').val('');
			$('#txtErpBgacctSeq').val('');
			break;
		case 'budget':
			target = $('#txtErpBgudgetName');
			$('#txtErpBgudgetName').val(param.obj.budgetName);
			$('#txtErpBudgetSeq').val(param.obj.budgetCode);
			
			$('#txtErpBizplanName').val('')
			$('#txtErpBizplanSeq').val('')
			
			$('#txtErpBgacctName').val('');
			$('#txtErpBgacctSeq').val('');
			break;
		case 'bizplan':
			target = $('#txtErpBizplanName');
			$('#txtErpBizplanName').val(param.obj.bizplanName);
			$('#txtErpBizplanSeq').val(param.obj.bizplanCode);
			
			$('#txtErpBgacctName').val('');
			$('#txtErpBgacctSeq').val('');
			break;
		case 'buddept':
			target = $('#btnErpBudDeptSelect');
			$('#txtErpBgudgetName').val(param.obj.budgetName);
			$('#txtErpBudgetSeq').val(param.obj.budgetCode);
			
			$('#txtErpBizplanName').val('')
			$('#txtErpBizplanSeq').val('')
			
			$('#txtErpBgacctName').val('');
			$('#txtErpBgacctSeq').val('');
			break;	
			

		}
	}
	
   	/*	[팝업] 예산계정 CallBack
   	--------------------------------------*/
   	function fnBudgetAcctCallback(param){

	   	var bgacctList = [];	
		for(var i = 0; i < param.length; i++){
			var item = param[i];
			var bgacctCode = parseInt(item);
				bgacctList.push(item);
		}
		
		if( !bgacctList.length ){
			$('#txtErpBgacctName').val('');
			$('#txtErpBgacctSeq').val('');
		}else if ( bgacctList.length == '1' ){
			$('#txtErpBgacctName').val(bgacctList[0].text);
			$('#txtErpBgacctSeq').val(bgacctList[0].value + '|');
		}else {
			$('#txtErpBgacctName').val(bgacctList[0].text + ' 외 ' + ( bgacctList.length - 1 )  + '건');
			var bgacctSeqs = '';
			for(var i = 0; i < bgacctList.length; i++){
				bgacctSeqs += bgacctList[i].value + '|';
			}
			$('#txtErpBgacctSeq').val(bgacctSeqs);
		}
		
   	}
	
    /*	[팝업] 팝업 호출
   	--------------------------------------*/
   	function fnIuYesilPopup(url, width){
   		var popWidth = width || 500; 
   		var popHeight = 530; //팝업 창 사이즈

   		var winHeight = document.body.clientHeight; // 현재창의 높이
   		var winWidth = document.body.clientWidth; // 현재창의 너비
   		var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
   		var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 

   		var popX = winX + (screen.width - popWidth) / 2;
		var popY = winY + (screen.height - popHeight) / 2;
   		
   		var pop = window.open(url, "AdminIuYesilPop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY);
   		
   		return;
   	}

	/*	[GRID] 예실대비 현황 데이터 출력
	--------------------------------------------------*/
	function fnRenderTable(aaData, isDefault){
		
		aaData = aaData || [];
		// $('#txtCntYesilReport').html(aaData.length.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		$('#gridYesilReprtContents').empty();

		
		if(!aaData.length){
			var noDataText = '';
			if(isDefault){
				noDataText = '데이터를 검색 하세요.';
			}else{
				noDataText = '검색 결과가 없습니다.';
			}
			
			$('#gridYesilReprtContents').append('<tr><td colspan="7"> ' + noDataText + ' </td></tr>');
		}

		aaData.sort(function(a, b) {
			return a.CD_BGACCT - b.CD_BGACCT;
		});
			/* 메인 그리드 데이터 출력 */
			var rowCount = 0;
			for(var i = 0 ; i < aaData.length; i++){
				var item = aaData[i];
			
					if( parseInt(item.AM_ACTSUM) > 0 || parseInt(item.AM_DRCR) > 0 || parseInt(item.AM_EXP) > 0){
						rowCount++;
						item.AM_PER = (((Number(item.AM_EXP) + Number(item.AM_DRCR)) / Number(item.AM_ACTSUM)) * 100).toFixed(2);
						item.AM_LEAVE = ( parseInt( item.AM_ACTSUM || '0' ) - ( parseInt( item.AM_EXP || '0' ) + parseInt( item.AM_DRCR || '0' ) ) );
							
						if(item.AM_PER == 'Infinity' || item.AM_PER == 'NaN'){ 
								item.AM_PER = '0'
						}
	
						$('#gridYesilReprtContents').append(fnGetTdCode(item));
					}
			}

			$('#txtCntYesilReport').html(rowCount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		
			/* 합계 행 데이터 출력 */
			var totalData = {	
				AM_ACTSUM : 0
				, AM_DRCR : 0
				, AM_EXP : 0
				, AM_LEAVE : 0
				, AM_PER : 0
			}
			
		for(var i = 0 ; i < aaData.length; i++){
			var item = aaData[i];
			totalData.AM_ACTSUM += parseInt( item.AM_ACTSUM || '0' );
			totalData.AM_DRCR += parseInt( item.AM_DRCR || '0' );
			totalData.AM_EXP += parseInt( item.AM_EXP || '0' );
			totalData.AM_LEAVE += parseInt( item.AM_LEAVE || '0' );
			totalData.AM_PER += parseInt(item.AM_PER || '0');
		}
		

		totalAmLeave = ( parseInt( totalData.AM_ACTSUM || '0' ) - ( parseInt( totalData.AM_EXP || '0' ) + parseInt( totalData.AM_DRCR || '0' ) ) );
		totalAmPer = (((Number(totalData.AM_EXP) + Number(totalData.AM_DRCR)) / Number(totalData.AM_ACTSUM)) * 100).toFixed(2);
		
		$('#txtTotalOpenAmt').html( fnGetCurrencyCode(totalData.AM_ACTSUM) );
		$('#txtTotalNonSendResAmt').html( fnGetCurrencyCode(totalData.AM_EXP) );
		$('#txtTotalErpApplyAmt').html( fnGetCurrencyCode(totalData.AM_DRCR) );
		//집행 잔액 
		$('#txtTotalResultAmt').html( fnGetCurrencyCode( totalAmLeave ) );
		$('#txtTotalEnforcementRate').html( (isNaN(totalAmPer) ? '0.00' : totalAmPer) + '%' );
	}
	
	/*	[GRID] HTML CODE 생성
	--------------------------------------------------*/
	function fnGetTdCode(item){
		var trCode = '';
		
		var tr = document.createElement('tr');
		$(tr).data('item', item);
		
		var td1 = document.createElement('td');
		$(td1).attr('height', '28px');
		$(td1).text(item.CD_BGACCT);
		$(tr).append(td1);
		
		var td2 = document.createElement('td');
		$(td2).attr('height', '28px');
		$(td2).text(item.NM_BGACCT);
		$(td2).addClass('le');
		$(tr).append(td2);
		
		var td3 = document.createElement('td');
		$(td3).text(fnGetCurrencyCode(item.AM_ACTSUM));
		$(td3).addClass('ri');
		$(tr).append(td3);
		
		var td4 = document.createElement('td');
		var a = document.createElement('a');
		$(a).text(fnGetCurrencyCode(item.AM_EXP));
		$(a).addClass('text_blue');
		$(a).addClass('consBalanceAmtPop');
		$(a).attr('style','cursor: pointer')
		$(a).css('text-decoration', 'decoration:underline');
		$(a).click(function(){
			fnOpenAmtListPop(item);
			return;
		})
		$(td4).addClass('ri');
		$(td4).append(a);
		$(tr).append(td4);
		
		var td5 = document.createElement('td');
		$(td5).text(fnGetCurrencyCode(item.AM_DRCR));
		$(td5).addClass('ri');
		$(tr).append(td5);
		
		var td6 = document.createElement('td');
		$(td6).text(fnGetCurrencyCode(item.AM_LEAVE));
		$(td6).addClass('ri');
		$(tr).append(td6);
		
		var td7 = document.createElement('td');
		$(td7).text(fnGetEnforcementRate(item.AM_PER));
		$(tr).append(td7);
		
		return tr;

	}
	
	/*	[GRID] 금액 통화코드 생성
	--------------------------------------------------*/
	function fnGetCurrencyCode(value){
		value = (value || '0');
		value = value.toString().replace(/,/g, '').split(' ').join('');
		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return value;
	}
	
	/*	[GRID] 집행 률 계산
	--------------------------------------------------*/
	function fnGetEnforcementRate(item){
		return item + '%'
	}
	

	/*	[팝업] 미전송 결의 리스트 팝업 호출
	--------------------------------------------------*/
	function fnOpenAmtListPop( param ){
		 
		var deptCd = $("#txtErpDeptName").val();
 		var budgetNm = param.NM_BUDGET;
		var budgetCd = param.CD_BUDGET;
		var acctNm = param.NM_BGACCT;
		var acctCd = param.CD_BGACCT;
		var bizplanNm = param.NM_BIZPLAN;
		var bizplanCd = param.CD_BIZPLAN;
		
		// 예산년월
		var yyBudget = param.YY_BUDGET
		// 미전송결의 합계
		var amExp = param.AM_EXP
		// 잔여금액 합계
		var amLeave = param.AM_LEAVE
		
		 
		var getParam = "deptCd=" + deptCd + "&budgetNm=" + encodeURI(encodeURIComponent(budgetNm)) + "&budgetCd="
		+ budgetCd + "&acctNm=" + encodeURI(encodeURIComponent(acctNm))
		+ "&acctCd=" + acctCd + "&bizplanNm=" + encodeURI(encodeURIComponent(bizplanNm))
		+ "&bizplanCd=" + bizplanCd
		+ '&erpGisuFromDate=' + $('#txtErpGisuFromDate').val()+'-01'
		+ '&erpGisuToDate=' + $('#txtErpGisuToDate').val()+'-31'
		+ '&yyBudget=' + yyBudget
		+ '&amExp=' + amExp
		+ '&amLeave=' + amLeave
		
		url = "<c:url value='/ex/admin/ExIuYesilExpendDetailPop.do?" + getParam + "'/>";
		
		window.open(url, "AdminYesilConsAmtDetailInfo", "width=" + 1000 + ", height=" + 720 + ", left=" + 150 + ", top=" + 150);
		
		return
	}
	
	function fnExcelDownload(){
		var cdBudgetAcctPipe2 = $('#txtErpBgacctSeq').val().split('|');
		cdBudgetAcctPipe2.splice(cdBudgetAcctPipe2.length-1, 1);
		
		Pudd( "#loadingProgressBar" ).puddProgressBar({
			progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }
			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "3px"	// progress 두께
			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "12px"
			
				,	progressStartCallback : function( progressBarObj ) {

					// dataSource를 통한 data 연동
					var sourceData = new Pudd.Data.DataSource({

						request : {
							url : '<c:url value="/ex/admin/CommonNewExcelDown.do" />'
						,	type : 'post'
						,	dataType : "json"
						,	contentType : "application/json; charset=utf-8"
						,	jsonStringify : true
						,	parameterMapping : function( data ) {
								data.cdBudgetAcctPipe2 = cdBudgetAcctPipe2.join(',');
								data.cdDeptPipe = $('#txtErpDeptSeq').val();
								data.cdBudgetPipe = $('#txtErpBudgetSeq').val();
								data.cdBizplanPipe = $('#txtErpBizplanSeq').val(); 
								data.cdBudgetAcctPipe = $('#txtErpBgacctSeq').val();
								data.fromDt = $('#txtErpGisuFromDate').val().replace(/-/g, '')+'01';
								data.toDt =  $('#txtErpGisuToDate').val().replace(/-/g, '')+'31';
								data.fileName = '예실대비현황2.0';		
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
								alert( "error - Pudd.Data.DataSource.read, status code - " + response.status );
							}
						}
					});

					//data read Start
					sourceData.read();

					var totalCount = sourceData.totalCount;
					var dataPage = sourceData.dataPage;
					
					if( totalCount ) {
						downloadExcelProcess( dataPage, totalCount );
						// loading progressBar 종료처리
						progressBarObj.clearIntervalSet();
						
					}else {
						// loading progressBar 종료처리
						progressBarObj.clearIntervalSet();
						alert("<%=BizboxAMessage.getMessage("TX000009638", "서비스 데이터가 없습니다.")%>");
					}
					
				}
			});		
	}
	
	 function downloadExcelProcess( dataPage, totalCount ){
			var excel = new JExcel("맑은 고딕 11 #333333");
			excel.set( { sheet : 0, value : "예실대비현황2.0Sheet" } );
			

			//헤더 컬럼 세팅
			var headers = [ "${CL.ex_budgetAccountCode}", "${CL.ex_accNm}", "${CL.ex_budgetAmt}", "${CL.ex_noSendExpend}", "${CL.ex_perFormance}", "${CL.ex_executionBalance}", "${CL.ex_executionRate}" ];
			var formatHeader = excel.addStyle({
				border: "thin,thin,thin,thin #000000",
				font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
				fill: "#dedede",
				align : "C"
			});

			for( var i=0; i<headers.length; i++ ) {
				excel.set( 0, i, 0, headers[i], formatHeader );// sheet번호, column, row, value, style
				// excel.set( 0, i, undefined, "15" ); // sheet번호, column, row, value(width)
				excel.setColumnWidth( 0, i, "15" ); // sheet번호, column, value(width)
			}
			//엑셀 순번 컬럼 사이즈 작게
			excel.set( 0, 0, undefined, "7" ); // sheet번호, column, row, value(width)

			var excelIndex = 0;
			for( var i=1; i<=totalCount; i++ ) {

				var idx = i-1;

				if(parseInt(dataPage[ idx ][ "AM_EXP" ]) == 0
					&& parseInt(dataPage[ idx ][ "AM_DRCR" ]) == 0
					&& parseInt(dataPage[ idx ][ "AM_ACTSUM" ]) == 0){
					continue;
				}



				excelIndex++;

				excel.set( 0, 0, excelIndex, dataPage[ idx ][ "CD_BGACCT" ] );
				excel.set( 0, 1, excelIndex, dataPage[ idx ][ "NM_BGACCT" ] );
				excel.set( 0, 2, excelIndex, dataPage[ idx ][ "AM_ACTSUM" ] );
				excel.set( 0, 3, excelIndex, dataPage[ idx ][ "AM_EXP" ] );
				excel.set( 0, 4, excelIndex, dataPage[ idx ][ "AM_DRCR" ] );
				excel.set( 0, 5, excelIndex, dataPage[ idx ][ "AM_LEAVE" ] );
				excel.set( 0, 6, excelIndex, dataPage[ idx ][ "AM_PER" ].toFixed(2) );
				
			}
			excel.generate( "예실대비현황2.0.xlsx" );
	
	 }
</script>