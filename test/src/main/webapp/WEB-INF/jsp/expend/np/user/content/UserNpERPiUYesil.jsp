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
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<!-- 공통 정보영역 -->
<jsp:include page="../include/UserOptionMap.jsp" flush="false" />

<!-- iframe wrap -->
<!-- 컨텐츠타이틀영역 -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl style="height: 40px;">
			<dt class="ar" style="width:70px;">결의부서</dt>
			<dd>
				<input type="text" autocomplete="off" style="width:246px;" class="puddSetup" id="txtErpDeptName" readonly/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpDeptSeq"/>
			</dd>
			
			<dt class="ar" style="width:70px;">예산단위</dt>
			<dd>
				<input type="text" autocomplete="off" style="width:169px;" class="puddSetup" id="txtErpBgudgetName" readonly/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBudgetSeq"/>
				<input type="button" id="btnErpBudgetSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
			</dd>
			<div id="bizplanArea">
				<dt class="ar" style="width:70px;">사업계획</dt>
				<dd>
					<input type="text" autocomplete="off" style="width:169px;" class="puddSetup" id="txtErpBizplanName" readonly/>
					<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBizplanSeq"/>
					<input type="button" id="btnErpBizplanSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
				</dd>
			</div>
			
			<dd><input type="button" class="puddSetup submit" value="${CL.ex_search}" id="btnSerchYesilList"/></dd> <!--검색-->
		</dl>
		
		<dl style="height: 50px;">
			<dt class="ar" style="width:70px;">예산계정</dt>
			<dd>
				<div class="controll_btn p0">
					<input type="text" autocomplete="off" style="width:169px;" class="puddSetup" id="txtErpBgacctName" readonly/>
					<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBgacctSeq"/>
					<input type="button" id="btnErpBgacctSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
					<button id="btnErpBgacctRefresh" class="reload_btn k-button" data-role="button" role="button" aria-disabled="false" tabindex="0"></button>
				</div>
			</dd>
				
			<dt class="ar" style="width:70px;">예산년월(기수)</dt>
			<dd><input type="text" autocomplete="off" id="txtBudgetYM" class="puddSetup ac" value="" style="width:48px;"/></dd>
			<dd>
				<input type="text" autocomplete="off" id="txtBudgetYMText" class="puddSetup ac" value="" style="width:171px;" disabled="true"/>
				<input type="hidden" id="txtErpGisuFromDate" class="puddSetup ac" value="" style="width:171px;" disabled="true"/>
				<input type="hidden" id="txtErpGisuToDate" class="puddSetup ac" value="" style="width:171px;" disabled="true"/>
			</dd>
			
			<dt class="ar" style="width:70px;">불용처리</dt>
			<dd>	
				<select id="selOpt13List" class="puddSetup" pudd-style="width:221px;" /> 
					<option value="1" selected>미반영</option>
					<option value="2">반영</option>
				</select>
			</dd>			
		</dl>
	</div>


	<div id="" class="controll_btn btn_div cl">
		<div class="left_div fwb mt5">
			${CL.ex_yeCount} <span class="" id="txtCntYesilReport">-</span> ${CL.ex_gun}
		</div>
<%-- 		<button id="btnExcelDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button> --%>
	</div>
	
	<div id="divGridArea" style="height: 578px;">
		<div class="dal_Box" style="height: 564px;">
			<div class="dal_BoxIn posi_re" style="height: 564px;">
				<div class="posi_right" style="left: 0px;">
					<div class="com_ta2 rowHeight ovh rightHeader mr17">
						<table item="{}">
							<colgroup item="{}">
								<col width="10" item="{}">
								<col width="10" item="{}">
								<col width="10" item="{}">
								<col width="10" item="{}">
								<col width="10" item="{}">
								<col width="10" item="{}">
								<col width="10" item="{}">
								<col width="10" item="{}">
								<col width="7" item="{}">
							</colgroup>
							<thead item="{}">
								<tr item="{}"></tr>
								<tr item="{}">
									<th width="10" item="{}">
										예산계정코드
									</th>
									<th width="10" item="{}">
										예산계정명
									</th>
									<th width="10" item="{}">
										예산금액
									</th>
									<th width="10" item="{}">
										품의합계
									</th>
									<th width="10" item="{}">
										미전송결의
									</th>
									<th width="10" item="{}">
										결의서실적
									</th>
									<th width="10" item="{}">
										전표실적
									</th>
									<th width="10" item="{}">
										집행잔액
									</th>
									<th width="7" item="{}">
										집행률
									</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="hover_no com_ta2 ova_sc2 bg_lightgray" onscroll="" style="height: 500px;">
						<table item="{}">
							<colgroup item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="7" item="{}"></colgroup>
							<tbody id="gridYesilReprtContents" item="{}">
								<tr>
									<td height="28px;"> 예산계정코드 </td>
									<td height="28px;"> 테스트 예산 계정 명 </td>
									<td class="ri" height="28px;">5,000</td>
									<td class="ri" height="28px;">5,000</td>
									<td class="ri" height="28px;">5,000</td>
									<td class="ri" height="28px;">5,000</td>
									<td class="ri" height="28px;">5,000</td>
									<td class="ri" height="28px;">5,000</td>
									<td class="cen">	100% </td>
								</tr>
							</tbody>
						</table>						
					</div>
					<div class="hover_no com_ta2 bg_lightgray" onscroll="" style="height: 70px;">
						<table item="{}">
							<colgroup item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="10" item="{}"><col width="7" item="{}"><col width="1" item="{}"></colgroup>
							<tbody id="gridYesilReprtTotal" item="{}">
								<tr>
									<td style="background: #f9f9f9;" colspan="2" class="ri"> 합계 </td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalOpenAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalConsAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalNonSendResAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalErpResAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalErpApplyAmt">0</td>
									<td style="background: #f9f9f9;" class="ri" id="txtTotalResultAmt">0</td>
									<td style="background: #f9f9f9;"class="cen" id="txtTotalEnforcementRate">-</td>
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



<script>

	/* 사업계획 미사용 옵션 체크 */
	var erpOptionSet = ${erp_optionSet};
	var bizplanUseOpt  = 1;
	
	function erpOptionSetLoop(){
		for(var i=0; i<erpOptionSet.length ;i++){
			if(erpOptionSet[i].TP_ENV == 'TP_BUDGETMNG'){
				bizplanUseOpt = erpOptionSet[i].CD_ENV; 
			}
		}
	}
	
	/* ## document ready ## */
	/* ====================================================================================================================================================== */
	$(document).ready(function() {
		
		/* [TEST]  삭제 필요 GridTable 1차 기본 형 조회 */
		var testData = [{
			erpBudgetSeq : 'A00001'
			, erpBudgetName : '테스트 예산과목'
			, openAmt : '1000000'
			, consAmt : '35000'
			, nonSendResAmt : '180000'
			, erpResAmt : '200000'
			, erpApplyAmt : '65000'
		}, {
			erpBudgetSeq : 'A00002'
			, erpBudgetName : '테스트 예산과목2'
			, openAmt : '500000'
			, consAmt : '7000'
			, nonSendResAmt : '30000'
			, erpResAmt : '10000'
			, erpApplyAmt : '25000'
		}];
		
		fnInit();
		
		/* 0. 화면 레이아웃 출력용 기본 그리드 출력 */
		fnRenderTable([], true);
		
		/* 1. 버튼이벤트 등록 */
		fnSetBtnEvent();
		
		/* 2. 사용자 기본 정보 디폴트 옵션 */
		fnSetDefaultData();
		
		/* 3. ERPiU 예산 년월 정보 조회 */
		fnGetERPiUGisuInfo();
	});

	function fnInit(){
		erpOptionSetLoop();
		
		if(bizplanUseOpt != '1'){ // 사업계획 미사용
			$('#bizplanArea').hide();
		}
	}
	
	/*	[기수] ERP기수 정보 조회
	--------------------------------------------------*/
	var _gisuInfo;
	function fnGetERPiUGisuInfo(){
		var innerParam = JSON.stringify({ erpCompSeq : optionSet.erpEmpInfo.erpCompSeq });
		var params = {
			erpCompSeq : optionSet.erpEmpInfo.erpCompSeq
			, code : 'gisu'
			, param : innerParam
		}
		$.ajax({
    		type:"post",
    		url : '<c:url value="/expend/np/user/code/ExCodeInfoSelect.do" />',
    		datatype:"json",
    		data: params, 
    		success:function(data){
    			var gisuInfo = _gisuInfo = data.result.aaData;
    			var d = new Date();
    			var year = '' + d.getFullYear();
    			var month = (d.getMonth()+1) < 10 ? ('0' + (d.getMonth() + 1) ) : ('' + ( d.getMonth() + 1 )) ;
    			var date = d.getDate() < 10 ? ('0' + d.getDate()) : ('' + d.getDate()) ;
    			var toDate = year + month + date;
    			
    			for(var i = 0; i < gisuInfo.length; i++ ){
    				var item = gisuInfo[i];
    				if( ( item.DT_FROM <= toDate )  && ( item.DT_TO >= toDate ) ){
    					$('#txtBudgetYM').val(item.NO_ACCSEQ);
    					$('#txtBudgetYMText').val( fnGetDateFormat(item.DT_FROM) + ' ~ ' + fnGetDateFormat(item.DT_TO) );
    					$('#txtErpGisuFromDate').val(item.DT_FROM.substring(0,6));
    					$('#txtErpGisuToDate').val(item.DT_TO.substring(0,6));
    				}
    			}
    		}, error : function(data){
    		}
		});
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
		$('#txtErpDeptName').val(optionSet.erpEmpInfo.erpDeptName);
		$('#txtErpDeptSeq').val(optionSet.erpEmpInfo.erpDeptSeq);
	}
	
	/*	[버튼 이벤트] 화면 버튼 이벤트 등록
	--------------------------------------------------*/
	function fnSetBtnEvent(){
		
		/* 결의부서 선택 팝업 */
		$('#btnErpDeptSelect').click(function (){
			fnCommonCode( 'dept2' );
		});
		
		/* 예산단위 선택 팝업 */
		$('#btnErpBudgetSelect').click(function (){
			fnCommonCode( 'budget' );
		});
		
		/* 사업계획 선택 팝업 */
		$('#btnErpBizplanSelect').click(function (){
			fnCommonCode( 'bizplan' );
		});
		
		/* 예산계정 선택 팝업 */
		$('#btnErpBgacctSelect').click(function (){
			fnCommonCode( 'bgacct2' );
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
		
		$('#txtBudgetYM').keyup(function (  ){
			var gisu = $(this).val();
			$('#txtBudgetYMText').val('');
			for(var i = 0; i < _gisuInfo.length; i++){
				var item = _gisuInfo[i];
				if(item.NO_ACCSEQ == gisu){
					$('#txtBudgetYMText').val( fnGetDateFormat(item.DT_FROM) + ' ~ ' + fnGetDateFormat(item.DT_TO) );
					$('#txtErpGisuFromDate').val(item.DT_FROM.substring(0,6));
					$('#txtErpGisuToDate').val(item.DT_TO.substring(0,6));
				}
			}
		});	
	}
	
	/*	[예산년월] 현재 입력 기준 예산년월 가져오기 
	--------------------------------------------------*/
	function fnGetBudgetYM(){
		var gisu = $('#txtBudgetYM').val();
		for(var i = 0; i < _gisuInfo.length; i++){
			var item = _gisuInfo[i];
			if(item.NO_ACCSEQ == gisu){
				return item.DT_TO.substring(0,6);
			}
		}
	}
	function fnGetBudgetY(){
		var gisu = $('#txtBudgetYM').val();
		for(var i = 0; i < _gisuInfo.length; i++){
			var item = _gisuInfo[i];
			if(item.NO_ACCSEQ == gisu){
				return item.DT_TO.substring(0,4);
			}
		}
	}
	
	/*	[검색] 예실대비 현황 리스트 검색및 출력 
	--------------------------------------------------*/
	var _yesilListAjaxParams;
	function fnSelectYesilList(){
		/* 1. 검색 기준 필수값 체크 */
		if(!$('#txtBudgetYMText').val()){
			alert('예산년월을 확인할 수 없습니다.');
			return;
		}
		
		if( !$('#txtErpDeptSeq').val() ){
			alert('결의부서를 선택해주세요.');
			return;
		} else if( !$('#txtErpBudgetSeq').val() ){
			alert('예산단위를 선택해주세요.');
			return;
		} else if( !$('#txtErpBizplanSeq').val() && bizplanUseOpt == '1' ){
			alert('사업계획을 선택해주세요.');
			return;
		} else if( !$('#txtErpBgacctSeq').val() ){
			alert('예산계정을 선택해주세요.');
			return;
		}
		
		var params = _yesilListAjaxParams = {
			txtBudgetYM : $('#txtBudgetYM').val() + '|'
			, erpDeptSeq : $('#txtErpDeptSeq').val() + '|'
			, erpBudgetSeq : $('#txtErpBudgetSeq').val() + '|'
			, erpBizplanSeq : bizplanUseOpt == '1'?$('#txtErpBizplanSeq').val() + '|':''
			, erpBgacctSeqs : $('#txtErpBgacctSeq').val()
			, erpGisuFromDate : $('#txtErpGisuFromDate').val()
			, erpGisuToDate : $('#txtErpGisuToDate').val()
			, erpCompSeq : optionSet.erpEmpInfo.erpCompSeq
			, advAmtOption : $('#selOpt13List').val()
			
			, bpErpBizplanSeq : $('#txtErpBizplanSeq').val()
			, bpErpBudgetSeq : $('#txtErpBudgetSeq').val()
			, bpWriteMonth : fnGetBudgetYM()
			, bpBgtYear : fnGetBudgetY()
			
			, compSeq : optionSet.loginVo.compSeq
		}
		
		$.ajax({
    		type:"post",
    		url : '<c:url value="/expend/np/admin/report/NpAdminYesilReport.do" />',
    		datatype:"json",
    		data: params, 
    		success:function(result){
    			console.log(' 예실대비 현황 리스트 출력 ');
    			console.log(result);
    			if(result.result.resultCode == 'SUCCESS'){
    				fnRenderTable(result.result.aaData, false);
    			}else{
    			}
    		}, error : function(result){
    		}
		});
		
	}
	
	/*	[코드도움] 공통 코드 도움 호출 
	--------------------------------------------------*/
	function fnCommonCode( code ) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');

		/* 파라미터 정의 */
		var param = {};
		
		switch (code){
			case 'dept2' :
				param = {
					callback : 'fnCommonCode_deptCallback'
					, widthSize : '645'
					, heightSize : '560'
				}
				break;
			case 'budget' :
				if(!$('#txtErpDeptSeq').val()){
					alert('결의부서를 선택하세요.');
					return;
				}
				param = {
					callback : 'fnCommonCode_erpBudgetCallback'
					, widthSize : '645'
					, heightSize : '580'
					, erpDeptSeq : $('#txtErpDeptSeq').val()
				}
				break;
			case 'bizplan' : 
				if(!$('#txtErpBudgetSeq').val()){
					alert('예산단위를 선택하세요.');
					return;
				}
				param = {
					callback : 'fnCommonCode_erpBizplanCallback'
					, widthSize : '745'
					, heightSize : '580'
					, erpBudgetSeq : $('#txtErpBudgetSeq').val()
				}
				break;	
			case 'bgacct2' :
				if(!$('#txtErpBizplanSeq').val() && bizplanUseOpt == '1'){
					alert('사업계획을 선택하세요.');
					return;
				}
				param = {
					callback : 'fnCommonCode_erpBgacctCallback'
					, widthSize : '745'
					, heightSize : '580'
					, erpBizplanSeq : $('#txtErpBizplanSeq').val()
					, erpBudgetSeq : $('#txtErpBudgetSeq').val()
					, writeMonth : fnGetBudgetYM()
					, bgtYear : fnGetBudgetY()
				}
				break;
			default : 
				console.log('정의되지 않은 공통코드입니다. ( ' + code + ' / fnCommonCode_' + code + ' )');
				return;
		}
		
		/* [코드도움] 공통 코드 팝업 호출 */
		fnCallCommonCodePop({
			code : code,
			popupType : 2,
			param : JSON.stringify(param),
			callbackFunction : param.callback,
			dummy : JSON.stringify({})
		});
	}
	
	
	/*	[코드도움] 결의부서 선택 콜백
	--------------------------------------------------*/
	function fnCommonCode_deptCallback(aData) {
		if(!!aData[0]){
			aData = JSON.parse(unescape(aData[0]));
		}
		$('#txtErpDeptName').val(aData.NM_DEPT);
		$('#txtErpDeptSeq').val(aData.CD_DEPT);
	}
	
	/*	[코드도움] 예산단위 선택 콜백
	--------------------------------------------------*/
	function fnCommonCode_erpBudgetCallback(aData) {
		$('#txtErpBudgetSeq').val(aData.CD_BUDGET);
		$('#txtErpBgudgetName').val(aData.NM_BUDGET);
	}
	
	/*	[코드도움] 사업계획 선택 콜백
	--------------------------------------------------*/
	function fnCommonCode_erpBizplanCallback(aData) {
		$('#txtErpBizplanName').val(aData.NM_BIZPLAN);
		$('#txtErpBizplanSeq').val(aData.CD_BIZPLAN);
	}
	
	/*	[코드도움] 예산계정 선택 콜백
	--------------------------------------------------*/
	function fnCommonCode_erpBgacctCallback(aaData) {
		var bgacctList = [];
		for(var i = 0; i < aaData.length; i++){
			var item = JSON.parse(unescape( aaData[i] ));
			bgacctList.push(item);
		}
		
		if( !bgacctList.length ){
			$('#txtErpBgacctName').val('');
			$('#txtErpBgacctSeq').val('');
		}else if ( bgacctList.length == '1' ){
			$('#txtErpBgacctName').val(bgacctList[0].NM_BGACCT);
			$('#txtErpBgacctSeq').val(bgacctList[0].CD_BGACCT + '|');
		}else {
			$('#txtErpBgacctName').val(bgacctList[0].NM_BGACCT + ' 외 ' + ( bgacctList.length - 1 )  + '건');
			var bgacctSeqs = '';
			for(var i = 0; i < bgacctList.length; i++){
				bgacctSeqs += bgacctList[i].CD_BGACCT + '|';
			}
			$('#txtErpBgacctSeq').val(bgacctSeqs);
		}
	}
	
	/*	[GRID] 예실대비 현황 데이터 출력
	--------------------------------------------------*/
	function fnRenderTable(aaData, isDefault){
		console.log('**************************** ERP iU 예실대비 현황 리스트 출력 ****************************');
		aaData = aaData || [];
		$('#txtCntYesilReport').html(aaData.length.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		$('#gridYesilReprtContents').empty();
		
		if(!aaData.length){
			var noDataText = '';
			if(isDefault){
				noDataText = '데이터를 검색 하세요.';
			}else{
				noDataText = '검색 결과가 없습니다.';
			}
			
			$('#gridYesilReprtContents').append('<tr><td colspan="9"> ' + noDataText + ' </td></tr>');
		}
		
		/* 메인 그리드 데이터 출력 */
		for(var i = 0 ; i < aaData.length; i++){
			var item = aaData[i];
			item.consAmt = item.consAmt * 1;
			$('#gridYesilReprtContents').append(fnGetTdCode(item));
		}
		
		/* 합계 행 데이터 출력 */
		var totalData = {	
			openAmt : 0
			, consAmt : 0
			, nonSendResAmt : 0
			, erpResAmt : 0
			, erpApplyAmt : 0
		}
		for(var i = 0 ; i < aaData.length; i++){
			var item = aaData[i];
			totalData.openAmt += parseInt( item.openAmt || '0' );
			totalData.consAmt += parseInt( item.consAmt || '0' );
			totalData.nonSendResAmt += parseInt( item.nonSendResAmt || '0' );
			totalData.erpResAmt += parseInt( item.erpResAmt || '0' );
			totalData.erpApplyAmt += parseInt( item.erpApplyAmt || '0' );
		}
		$('#txtTotalOpenAmt').html( fnGetCurrencyCode(totalData.openAmt) );
		$('#txtTotalConsAmt').html( fnGetCurrencyCode(totalData.consAmt) );
		$('#txtTotalNonSendResAmt').html( fnGetCurrencyCode(totalData.nonSendResAmt) );
		$('#txtTotalErpResAmt').html( fnGetCurrencyCode(totalData.erpResAmt) );
		$('#txtTotalErpApplyAmt').html( fnGetCurrencyCode(totalData.erpApplyAmt) );
		$('#txtTotalResultAmt').html( fnGetCurrencyCode( fnGetResultAmt( totalData ) ) );
		$('#txtTotalEnforcementRate').html( fnGetEnforcementRate( totalData ) );
		
		$('.consBalanceAmtPop').click(function (){
			var aData = JSON.parse(unescape( $(this).parents('tr').attr('data') ) );
			fnOpenConsListPop(aData);
		});
		
		$('.resAmtPop').click(function (){
			var aData = JSON.parse(unescape( $(this).parents('tr').attr('data') ) );
			fnOpenAmtListPop(aData);
		});
	}
	
	/*	[GRID] HTML CODE 생성
	--------------------------------------------------*/
	function fnGetTdCode(item){
		var trCode = '';
		trCode += '<tr data="' + escape( JSON.stringify( item ) ) + '">';
		trCode += '	<td height="28px;"> ' + item.erpBgacctSeq + ' </td>';
		trCode += '	<td height="28px;"> ' + item.erpBgacctName + ' </td>';
		trCode += '	<td class="ri" height="28px;">'+ '<a class="" style="">' + fnGetCurrencyCode(item.openAmt) + '</a>' +'</td>';
		trCode += '	<td class="ri" height="28px;">'+ '<a href="#" class="consBalanceAmtPop text_blue" style="text-decoration:underline">' + fnGetCurrencyCode(item.consAmt) + '</a>' +'</td>';
		trCode += '	<td class="ri" height="28px;">'+ '<a href="#" class="resAmtPop text_blue" style="text-decoration:underline">' + fnGetCurrencyCode(item.nonSendResAmt) + '</a>' +'</td>';
		trCode += '	<td class="ri" height="28px;">'+ '<a class="" style="">' + fnGetCurrencyCode(item.erpResAmt) + '</a>' +'</td>';
		trCode += '	<td class="ri" height="28px;">'+ '<a class="" style="">' + fnGetCurrencyCode(item.erpApplyAmt) + '</a>' +'</td>';
		trCode += '	<td class="ri" height="28px;">' + '<a class="" style="">' + fnGetCurrencyCode( fnGetResultAmt( item ) ) + '</a>' + '</td>';
		trCode += '	<td class="cen"> ' + fnGetEnforcementRate( item ) + ' </td>';
		trCode += '</tr>';		
		
		return trCode;
	}
	
	/*	[GRID] 금액 통화코드 생성
	--------------------------------------------------*/
	function fnGetCurrencyCode(value){
		value = (value || '0');
		value = value.toString().replace(/,/g, '').split(' ').join('');
		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return value;
	}
	
	/*	[GRID] 집행잔액 계산
	--------------------------------------------------*/
	function fnGetResultAmt(item){
		var totalApplyAmt = 0;
		totalApplyAmt += parseInt( item.consAmt || '0' );
		totalApplyAmt += parseInt( item.nonSendResAmt || '0' );
		totalApplyAmt += parseInt( item.erpResAmt || '0' );
		totalApplyAmt += parseInt( item.erpApplyAmt || '0' );
		var openAmt = 0;
		openAmt = parseInt(item.openAmt || '0');
		
		return openAmt - totalApplyAmt;
	}
	
	/*	[GRID] 집행 률 계산
	--------------------------------------------------*/
	function fnGetEnforcementRate(item){
		var totalApplyAmt = 0;
		totalApplyAmt += parseFloat( item.consAmt || '0' );
		totalApplyAmt += parseFloat( item.nonSendResAmt || '0' );
		totalApplyAmt += parseFloat( item.erpResAmt || '0' );
		totalApplyAmt += parseFloat( item.erpApplyAmt || '0' );
		
		var openAmt = 0;
		openAmt = parseInt(item.openAmt || '0');
		
		if(totalApplyAmt < 0){
			return '0%';
		}else if( openAmt == 0 ){
			return '0%';
		}
		
		var result = (parseFloat(totalApplyAmt) / parseFloat(openAmt))  * 100;
		return '' + result.toFixed(1) + '%'
	}
	
	/*	[팝업] 품의합계 잔액 리스트 팝업 호출
	--------------------------------------------------*/
	function fnOpenConsListPop( param ){
		var url = "<c:url value='/expend/np/admin/AdminYesilConsAmtDetailInfo.do'/>";
		window.open('', "AdminYesilConsAmtDetailInfo", "width=" + 1000 + ", height=" + 720 + ", left=" + 150 + ", top=" + 150);

		$('#FORM_BUDGET_YM_FROM').val(_yesilListAjaxParams.erpGisuFromDate);
		$('#FORM_BUDGET_YM_TO').val(_yesilListAjaxParams.erpGisuToDate);
		$('#FORM_BUDGET_SEQ').val(_yesilListAjaxParams.bpErpBudgetSeq);
		$('#FORM_BIZPLAN_SEQ').val(_yesilListAjaxParams.bpErpBizplanSeq);
		$('#FORM_BGACCT_NAME').val(param.erpBgacctName);
		$('#FORM_BGACCT_SEQ').val(param.erpBgacctSeq);
		
		yesilBudgetInfoPop.target = "AdminYesilConsAmtDetailInfo";
		yesilBudgetInfoPop.method = "post";
		yesilBudgetInfoPop.action = url;
		yesilBudgetInfoPop.submit();
	}
	
	/*	[팝업] 미전송 결의 리스트 팝업 호출
	--------------------------------------------------*/
	function fnOpenAmtListPop( param ){
		var url = "<c:url value='/expend/np/admin/AdminYesilResAmtDetailInfo.do'/>";
		window.open('', "AdminYesilConsAmtDetailInfo", "width=" + 1000 + ", height=" + 720 + ", left=" + 150 + ", top=" + 150);
		
		$('#FORM_BUDGET_YM_FROM').val(_yesilListAjaxParams.erpGisuFromDate);
		$('#FORM_BUDGET_YM_TO').val(_yesilListAjaxParams.erpGisuToDate);
		$('#FORM_BUDGET_SEQ').val(_yesilListAjaxParams.bpErpBudgetSeq);
		$('#FORM_BIZPLAN_SEQ').val(_yesilListAjaxParams.bpErpBizplanSeq);
		$('#FORM_BGACCT_NAME').val(param.erpBgacctName);
		$('#FORM_BGACCT_SEQ').val(param.erpBgacctSeq);
		
		yesilBudgetInfoPop.target = "AdminYesilConsAmtDetailInfo";
		yesilBudgetInfoPop.method = "post";
		yesilBudgetInfoPop.action = url;
		yesilBudgetInfoPop.submit();
	}
</script>


<form id="yesilBudgetInfoPop" name="frmPop" method="post">
	<input type="hidden" name="fromDate" value="" id="FORM_BUDGET_YM_FROM"/>
	<input type="hidden" name="toDate" value="" id="FORM_BUDGET_YM_TO"/>
	<input type="hidden" name="erpBgacctSeq" value="" id="FORM_BGACCT_SEQ"/>
	<input type="hidden" name="erpBgacctName" value="" id="FORM_BGACCT_NAME"/>
	<input type="hidden" name="erpBudgetSeq" value="" id="FORM_BUDGET_SEQ"/>
	<input type="hidden" name="erpBizplanSeq" value="" id="FORM_BIZPLAN_SEQ"/>
</form>	

