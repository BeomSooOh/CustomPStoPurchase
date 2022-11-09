<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
	<title>Bizbox A</title>

	<!--css-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pudd.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pudding/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animate.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/re_pudd.css">

	<!--js-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudd/pudd-1.1.172.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/common.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.mask.min2.js"></script>
	<jsp:include page="../include/TripCommonFunc.jsp" flush="false" />
</head>


<script type="text/javascript">
	
	var nowTab = 0;
	var nowTabName = '일비';
	var orderBy = false;
	
	/*	[document]	document ready
	--------------------------------------------- */
	$(document).ready(function() {
		
		/* 초기화 */
		fnInit();
		
		/* 클릭 이벤트 정의 */
		fnInitClickEvent();
	
		/* 페이지 진입시 검색 */
		fnGridSetAmtTable(nowTab);
		
	});

	/*	[국내외] 국내외 구분 선택 드롭다운 이벤트 지정
	--------------------------------------------*/
	function fnChangeDomesticDiv(domesticDiv){
		$("#domestic_div").val(domesticDiv);
	}
	
	/*	[초기화] 엘리먼트 초기화
	--------------------------------------------*/
	function fnInit(){
		$('.amtMask').mask("000,000,000,000,000,000,000", {reverse: true});	
	}
	
	/*	[이벤트] 엘리먼트 클릭 이벤트 바인드
	--------------------------------------------*/
	function fnInitClickEvent(){
		
		/* 기준일 순 정렬 이벤트 */
		$('.orderBy').hide();
		/* 1: 정렬 '': 비정렬 */
		$('.orderBy').click(function(){
			orderBy = !orderBy;
			fnGridSetAmtTable(nowTab);
			if(orderBy){
				$('.orderBy').val('기준일 순 취소');
			}else{
				$('.orderBy').val('기준일 순');
			}
		});
		
		/* 그리드 행 클릭이벤트 */
		Pudd( ".grid").on( "gridRowClick", function( e ) {
			var rowData = e.detail.trObj.rowData;
			fnFormInit(rowData);
		});
		
		//탭 클릭 이벤트
		Pudd( "#exTab" ).puddTab({ 
				tabMinWidth : 95
		 	,	newTab : false
		 	,	tabClickCallback : function( idx, tabMenu, tabArea ) {
	 				nowTab = idx;
	 				nowTabName = tabMenu.innerText;
	 				fnGridSetAmtTable(nowTab);
	 				
				}
		});
		
		//검색이벤트
		$('#searchButton').click(function(){
			fnGridSetAmtTable(nowTab);
		});
		
		$(".enter").keydown(function (key) {		 
		    if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
		    	fnGridSetAmtTable(nowTab);
		    }
		});
		
		//추가 
		var puddObj = Pudd( "#addBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			$('tr.on').removeClass('on');
			fnFormInit();
		});
		//저장
		var puddObj = Pudd( "#saveBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnSaveTripAmt();	 	
		});
		//삭제
		var puddObj = Pudd( "#deleteBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnDeleteAmt();
		});
		

	}
	
	/*	[삭제] 출장비단가 정보 삭제
	----------------------------------------*/
	function fnDeleteAmt(){
		if(!$('tr:visible.on').length){
			alert("삭제할 데이터을 선택하십시요.");
			return;
		}
		
		if(confirm("삭제하시겠습니까")){
			$.ajax({
				type: 'POST',
				url:'<c:url value="/expend/trip/admin/option/AdminTripDelete.do"/>',
				data:{
						"pageType" : 'Amt'
						,"amtSeq": fnGetSelectedRowData().aData.amtSeq
					},
				dataType:'json',
				success: function(e){
					if(e.result){
						alert("데이터가 삭제 되었습니다");
						fnGridSetAmtTable(nowTab);
					}else{
						alert("삭제에 실패하였습니다.");						
					}				
				}
			});
		}
	}
	
	
	/*	[상세내역] 상세내역 정보 초기화
	-------------------------------------------*/
	function fnFormInit( param ){
		if(!param){
			$('.txtDisplayDomesticRadio').show();
			$('.txtDisplayDomesticCode').hide();
		}else{
			$('.txtDisplayDomesticRadio').hide();
			$('.txtDisplayDomesticCode').show();
			$('.txtDisplayDomesticCode').text(param.domesticName);
		}
		
		param = param || {};
		
		$('.locationName').val(  param.locationName || ''  );
		$('.dutyGroupName').val(  param.dutyGroupName || ''  );
		$('.transportName').val(  param.transportName || ''  );
		var applyAmt = '';
		if(param.applyAmt){
			applyAmt = fnGetCurrencyFormat(param.applyAmt);
		}
		$('.applyAmt').val(   applyAmt  );
		$('#amtHoldCode_' + nowTab).val(  param.amtHoldCode || ''  );
		$('.note').val(  param.note || ''  );
		
		if(param.domesticDiv=='1'){
			Pudd( 'input:radio[id="domestic_1_' + nowTab + '"]' ).getPuddObject().setChecked( true );
		} else{
			Pudd( 'input:radio[id="domestic_0_' + nowTab + '"]' ).getPuddObject().setChecked( true );
		}
		
		dateObj = new Pudd.Util.Date( );// val값은 '2018-08-03' 형식으로 전달, 없으면 현재일자
		dateObj = param.applyDate || dateObj.getFormatString('yyyy-MM-dd');
		var puddObj = Pudd( "#applyDate_" + nowTab ).getPuddObject();
		puddObj.setDate(dateObj);
		
		Pudd( "#amtHoldCode_" + nowTab ).getPuddObject().setSelectedIndex( ''+ param.amtHoldCode );
		if( (param.amtHoldCode || '0') == '0' ){
			$('#amtHoldName_' + nowTab ).text('단가');
		}else {
			$('#amtHoldName_' + nowTab ).text('상한액');
		}
	}
	
	/*	[단가목록] 사용자 입력 단가정보 저장 tkdqo
	-------------------------------------------*/
	function fnSaveTripAmt(){
		
		if ( !( $(".transportName:visible").val() || $(".locationName:visible").val()) ){
			if( $(".transportName:visible").length ){
				alert('교통수단을 입력해주세요.');
				return;
			}else {
				alert('출장지를 입력해주세요');
				return;
			}
		} else if( $.trim($(".dutyGroupName:visible").val() ) == ""){
			alert("직책그룹 명을 입력해주세요.");
			return;
		}
		
		
		if(confirm("저장하시겠습니까?")){
			var saveUrl = "";
			if($('tr.on').length){
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTripSettingPageUpdate.do"/>';
			}else{
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTripSettingPageInsert.do"/>';
			}
			
			$.ajax({
				type: 'POST',
				url:saveUrl,
				data: {
					 domesticCode  : $(':radio[name="domestic_div_1"]:checked').val()
					, locationSeq  : $('.hidLocationName').eq(nowTab).val() || fnGetSelectedRowData().locationSeq || '0'
					, transportSeq : $('.hidTransportName').eq(nowTab).val() || fnGetSelectedRowData().transportSeq || '0'
					, dutyGroupSeq : $('.hidDutyGroupName').eq(nowTab).val() || fnGetSelectedRowData().dutyGroupSeq || '0'

					, applyDate : fnGetCommonParams().applyDate
					, applyAmt  : fnGetCommonParams().applyAmt
					, amtHoldCode : fnGetCommonParams().amtHoldCode
					, note : fnGetCommonParams().note
					
					, amtSeq : fnGetSelectedRowData().aData.amtSeq || ''
					, amtClassCode : parseInt( nowTab ) + 1
					, amtClassName : nowTabName
					, pageType:'Amt'
				},
				dataType:'json',
				success: function(result){
					if(result.result.resultCode == 'EXSIST_AMT'){
						alert("동일한 기준의 출장비단가가 존재합니다. 입력한 내역을 확인해주시기 바랍니다.");
					}else if(result.result.resultCode == 'SUCCESS'){
						alert("저장 되었습니다");
						fnGridSetAmtTable(nowTab);
					}else{
						alert("저장을 실패했습니다");
					}
				}
			});
		}
	}
	
	/*	[파라미터] 공통 사용 파라미터 조회
	-------------------------------------------*/
	function fnGetCommonParams(){
		return {
			applyDate : $('#applyDate_'+nowTab).val().replace(/-/gi,"")
			, applyAmt :  ( $('#applyAmt_'+nowTab).val()  || '0' ).replace(/,/gi, '')
			, amtHoldCode : $('.amtHoldCode:visible option:selected').val()
			, note : $('#note_'+nowTab).val()
		};
	}
		
	/*	[단가목록] 선택된 데이터 가져오기
	-----------------------------------------*/
	function fnGetSelectedRowData(){
		if( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
			return {
				aData : {}
				, transportSeq : ''
				, locationSeq : ''
				, dutyGroupSeq : '' 
			};
		}
		return {
			aData : JSON.parse(unescape( $('tr.on').eq(0).find('.hiddenExpenseJson').val() ))
			, transportSeq : $('tr.on').eq(0).find('.hidTransportSeq').val()
			, locationSeq : $('tr.on').eq(0).find('.hidLocationSeq').val()
			, dutyGroupSeq : $('tr.on').eq(0).find('.hidDutyGroupSeq').val()
		}
	}
	
	/*	[단가목록] 단가 목록 리스트 조회
	------------------------------------------- */
	function fnGridSetAmtTable(nowTab){
		var puddObj = Pudd( "#amtHoldCode_" + nowTab ).getPuddObject();
		puddObj.on( "change", function( e ) {
			var val = puddObj.val();
			if(val == '0'){
				$('#amtHoldName_' + nowTab).text('단가');
			}else {
				$('#amtHoldName_' + nowTab).text('상한액');
			}
		});
	
		$('#txtAllPrint_' + nowTab).unbind().click(function(){
			/* 기본 그리드 데이터 출력 */
		//	fnPrintGrid();
		});

		/* 기본 그리드 데이터 출력 */
		fnPrintGrid();
	}

	/*	[단가목록] 단가목록 리스트 출력
	--------------------------------------------------*/
	function fnPrintGrid(){
		
		var LocationData2 = new Pudd.Data.DataSource({
			pageSize : 500
			, request : {
					url : "<c:url value='/expend/trip/admin/option/AdminTripSettingPageSelect.do'/>"
				,	type : 'post'
				,	dataType : "json"
				,	parameterMapping : function( data ) {
						var puddTab = Pudd( "#exTab" ).getPuddObject();
						data.pageType = 'amt';
						data.amtClassCode = nowTab * 1 + 1;
						data.domesticDiv = $("#domesticDiv option:selected").val();; // 추가 
						data.dutyGroupName = $("#dutyGroupName").val();
						data.locationName = $("#locationName").val();
						data.transPortName = '';
						data.orderBy = orderBy?1:'';
						data.allSearchYN = ( !!$('#txtAllPrint_' + nowTab).attr('checked') ? 'Y' : 'N' );
					}
			}, result : {
				data : function( response ) {
					return response.result.aaData;
				}, totalCount : function( response ) {
					return response.result.aaData.length;
				}, error : function( response ) {
					alert( "error - Pudd.Data.DataSource.read, status code - " + response.result.resultCode );
				}
			}
		});
		
		Pudd( ".grid" ).puddGrid({ 
			dataSource : LocationData2 
			, height : 300
			, scrollable : true 
			, columns : [
				{
					field : "NO"
					, title : "no"
					, width : 60
					, content : {
						template : function( rowData ) {
							var html = '<input type="hidden" class="hiddenExpenseJson" value="' + escape(JSON.stringify(rowData)) + '">' + rowData.NO + '</input>';
							html+= '<input type="hidden" class="hidLocationSeq" value="' +  ( rowData.locationSeq  || '' )  + '"></input>';
							html+= '<input type="hidden" class="hidDutyGroupSeq" value="' + ( rowData.dutyGroupSeq || '' ) + '"></input>';
							html+= '<input type="hidden" class="hidTransportSeq" value="' + ( rowData.transportSeq || '' ) + '"></input>';
							return html;  
						}
					}
				}, {
					field:"domesticName"
					, title:"국내외"
					, width : 70
				}, {
					field : "locationName"
					, title : "출장지"
					, width : 20
					, widthUnit : "%"	
				}, {
					field:"dutyGroupName"
					, title:"직책그룹"
					, width : 20
					, widthUnit : "%"	
				}, {
					field:"applyDate"
					, title:"기준일"
					, width : 20
					, widthUnit : "%"	
				}, {
					field:"applyAmt"
					, title:"단가"
					, content : {
						attributes : { class : "ri" }
						, template : function( rowData ) {
							var html = '';
							if(rowData.amtHoldCode == '0'){
								html = '<span style="padding-right: 8px;">' + fnGetCurrencyFormat( rowData.applyAmt || '' ) + '</span>'
							}else{
								html = '<span style="padding-right: 8px;">(' + fnGetCurrencyFormat( rowData.applyAmt || '' ) + ')</span>'
							}
							return html;
						}
					}
				}
			]
			, noDataMessage : {
				message : "데이터가 존재하지 않습니다."
			}
		});
		
		/* 상세내역 초기화 */
		fnFormInit();
	}
	
	/*	[팝업] 교통수단 선택 팝업 호출
	--------------------------------------------------*/
	function fnSelTransportPop(){
		var width = 650 ;
		var height = 560;	
		var windowX = Math.ceil( (window.screen.width  - width) / 2 );
		var windowY = Math.ceil( (window.screen.height - height) / 2 );
		var strScroll = 0;
		var strResize = 0;
		var location = 0;
		
		var domesticDiv = $(':radio[name="domestic_div_1"]:checked').val();
		var url = "${pageContext.request.contextPath}/expend/trip/admin/AdminTripTransPortInfo.do?domesticDiv=" + domesticDiv;
	
		pop = window.open(url, "searchWindow", "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll+", resizable="+ strResize+", location="+ location);
		try {pop.focus(); } catch(e){}
		return pop;
	}
	
	/*	[콜백] 교통수단 선택 콜백
	--------------------------------------------------*/
	function setTransPortCallback(rowData){
		$(".transportName").val(rowData.transname);
		$('.hidTransportName').eq(nowTab).val(rowData.transportSeq);
	}
	
	/*	[팝업] 출장지 선택 팝업 호출
	--------------------------------------------------*/
	function fnSelLocationPop(){
		var width = 650 ;
		var height = 560;	
		var windowX = Math.ceil( (window.screen.width  - width) / 2 );
		var windowY = Math.ceil( (window.screen.height - height) / 2 );
		var strScroll = 0;
		var strResize = 0;
		var location = 0;
		
		var domesticDiv = $(':radio[name="domestic_div_1"]:checked').val();
		var url = "${pageContext.request.contextPath}/expend/trip/admin/AdminTripLocationInfo.do?domesticDiv=" + domesticDiv;
	
		pop = window.open(url, "searchWindow", "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll+", resizable="+ strResize+", location="+ location);
		try {pop.focus(); } catch(e){}
		return pop;
	}
	
	/*	[콜백] 출장지 선택 콜백
	--------------------------------------------------*/
	function setLocationCallback(rowData){
		$(".locationName").val(rowData.locationname);
		$('.hidLocationName').eq(nowTab).val(rowData.locationSeq);
	}
	
	/*	[팝업] 직책그룹 선택 팝업 호출
	--------------------------------------------------*/
	function fnSelDutyGroupPop(){
	 	var width = 650 ;
		var height = 560;	
		var windowX = Math.ceil( (window.screen.width  - width) / 2 );
		var windowY = Math.ceil( (window.screen.height - height) / 2 );
		var strScroll = 0;
		var strResize = 0;
		var location = 0;
		
		var domesticDiv = $(':radio[name="domestic_div_1"]:checked').val();
		var url = "${pageContext.request.contextPath}/expend/trip/admin/AdminTripPositionGroupInfo.do?domesticDiv=" + domesticDiv;
		pop = window.open(url, "searchWindow", "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll+", resizable="+ strResize+", location="+ location);
		try {pop.focus(); } catch(e){}
		return pop; 
	}

	/*	[콜백] 직책그룹 선택 콜백
	--------------------------------------------------*/
	function setPositionCallback(rowData){
		$(".dutyGroupName").val(rowData.dutyGroupName);
		$('.hidDutyGroupName').eq(nowTab).val(rowData.dutyGroupSeq);
	}
</script>

	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt style="width:50px;" class="ar">국내외</dt>
			<dd>
				<select id="domesticDiv" class="puddSetup" pudd-style="width:100px;">
					<option value="">전체</option>
					<option value="0">국내</option>
					<option value="1">해외</option>
				</select>
			</dd>

			<dt>출장지</dt>
			<dd><input id="locationName" type="text" style="width:150px;" class="puddSetup enter" value="" /></dd>

			<dt>직책그룹</dt>
			<dd><input id="dutyGroupName" type="text" style="width:150px;" class="puddSetup enter" value="" /></dd>

<!-- 			<dt>교통수단</dt> -->
<!-- 			<dd><input id="transPortName" type="text" style="width:175px;" class="puddSetup enter" value="" /></dd> -->

			<dd><input id="searchButton"type="button" class="puddSetup submit" value="검색" /></dd>
		</dl>
	</div>

	<div class="sub_contents_wrap">					
		<div class="posi_re mt14">
			<div id="" class="posi_ab" style="right:0px; z-index:1;">
				<input id="addBtn" type="button" class="puddSetup" value="추가" />
				<input id="saveBtn" type="button" class="puddSetup" value="저장" />
				<input id="deleteBtn" type="button" class="puddSetup" value="삭제" />
			</div>
		</div>							

		<div id="exTab" class="mt14">
			<ul>
				<li>일비</li>
				<li>식비</li>
				<li>숙박비</li>
				<li>운임비</li>
				<li>관내여비</li>
				<li>준비금</li>
			</ul>

			<div>							
				<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="60%"/>
							<col/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<div class="btn_div mt0">
									<div class="left_div">
										<h5 class="fl">단가목록</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value="" id="txtAllPrint_0" class="puddSetup" pudd-label="전체내역 보기" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="기준일 순" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">상세내역</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>국내외</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														국내
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_0" value="0" class="puddSetup" pudd-label="국내" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_0" value="1" class="puddSetup" pudd-label="해외" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 출장지</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 직책그룹</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>기준일</th>
											<td><input type="text" autocomplete="off" id="applyDate_0" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th> <span id="amtHoldName_0">단가</span> </th>
											<td>
												<input type="text" autocomplete="off" placehold="0" id="applyAmt_0" pudd-style="width:35%;" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> 원
												<select id="amtHoldCode_0" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>고정금액</option>
													<option value="1">실비적용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>비고</th>
											<td><input id="note_0" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- 금액고정 : 입력한 단가로 금액반영 (수정불가) <br/>
									- 실비적용 : 입력한 단가 내 수정가능 (미입력 시 금액 제한없음)
								</div>																				
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div>
				<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="60%"/>
							<col/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<div class="btn_div mt0">
									<div class="left_div">
										<h5 class="fl">단가목록</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value="" id="txtAllPrint_1" class="puddSetup" pudd-label="전체내역 보기" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="기준일 순" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">상세내역</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>국내외</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														국내
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_1" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="국내" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_1" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="해외" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 출장지</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 직책그룹</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>기준일</th>
											<td><input type="text" autocomplete="off" id="applyDate_1" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_1">단가</span></th>
											<td>
												<input type="text" autocomplete="off" id="applyAmt_1" pudd-style="width:35%;" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> 원
												<select id="amtHoldCode_1" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>고정금액</option>
													<option value="1">실비적용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>비고</th>
											<td><input id="note_1" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- 금액고정 : 입력한 단가로 금액반영 (수정불가) <br/>
									- 실비적용 : 입력한 단가 내 수정가능 (미입력 시 금액 제한없음)
								</div>																				
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div>
												<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="60%"/>
							<col/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<div class="btn_div mt0">
									<div class="left_div">
										<h5 class="fl">단가목록</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value="" id="txtAllPrint_2" class="puddSetup" pudd-label="전체내역 보기" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="기준일 순" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">상세내역</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>국내외</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														국내
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_2" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="국내" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_2" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="해외" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 출장지</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 직책그룹</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>기준일</th>
											<td><input type="text" autocomplete="off" id="applyDate_2" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_2">단가</span></th>
											<td>
												<input type="text" autocomplete="off" id="applyAmt_2" pudd-style="width:35%;" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> 원
												<select id="amtHoldCode_2" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>고정금액</option>
													<option value="1">실비적용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>비고</th>
											<td><input id="note_2" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- 금액고정 : 입력한 단가로 금액반영 (수정불가) <br/>
									- 실비적용 : 입력한 단가 내 수정가능 (미입력 시 금액 제한없음)
								</div>																				
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div>
												<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="60%"/>
							<col/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<div class="btn_div mt0">
									<div class="left_div">
										<h5 class="fl">단가목록</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value=""  id="txtAllPrint_3" class="puddSetup" pudd-label="전체내역 보기" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="기준일 순" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">상세내역</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>국내외</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														국내
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_3" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="국내" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_3" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="해외" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 출장지</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 직책그룹</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>기준일</th>
											<td><input type="text" autocomplete="off" id="applyDate_3" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_3">단가</span></th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:35%;" id="applyAmt_3" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> 원
												<select id="amtHoldCode_3" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>고정금액</option>
													<option value="1">실비적용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>비고</th>
											<td><input id="note_3" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- 금액고정 : 입력한 단가로 금액반영 (수정불가) <br/>
									- 실비적용 : 입력한 단가 내 수정가능 (미입력 시 금액 제한없음)
								</div>																				
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div>
												<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="60%"/>
							<col/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<div class="btn_div mt0">
									<div class="left_div">
										<h5 class="fl">단가목록</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value=""  id="txtAllPrint_4" class="puddSetup" pudd-label="전체내역 보기" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="기준일 순" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">상세내역</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>국내외</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														국내
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_4" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="국내" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_4" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="해외" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 출장지</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 직책그룹</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>기준일</th>
											<td><input type="text" autocomplete="off" id="applyDate_4" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_4">단가</span></th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:35%;" id="applyAmt_4" placeHolder="0" class="applyAmt  amtMask puddSetup" value=""/> 원
												<select id="amtHoldCode_4" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>고정금액</option>
													<option value="1">실비적용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>비고</th>
											<td><input id="note_4" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- 금액고정 : 입력한 단가로 금액반영 (수정불가) <br/>
									- 실비적용 : 입력한 단가 내 수정가능 (미입력 시 금액 제한없음)
								</div>																				
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div>
												<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="60%"/>
							<col/>
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<div class="btn_div mt0">
									<div class="left_div">
										<h5 class="fl">단가목록</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value=""  id="txtAllPrint_5" class="puddSetup" pudd-label="전체내역 보기" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="기준일 순" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">상세내역</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>국내외</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														국내
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_5" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="국내" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_5" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="해외" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 출장지</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> 직책그룹</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="선택" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>기준일</th>
											<td><input type="text" autocomplete="off" id="applyDate_5" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_5">단가</span></th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:35%;" id="applyAmt_5"  placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> 원
												<select id="amtHoldCode_5" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>고정금액</option>
													<option value="1">실비적용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>비고</th>
											<td><input id="note_5" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- 금액고정 : 입력한 단가로 금액반영 (수정불가) <br/>
									- 실비적용 : 입력한 단가 내 수정가능 (미입력 시 금액 제한없음)
								</div>																				
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div><!--// sub_contents_wrap -->
</html>
