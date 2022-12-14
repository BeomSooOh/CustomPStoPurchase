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
	var nowTabName = '??????';
	var orderBy = false;
	
	/*	[document]	document ready
	--------------------------------------------- */
	$(document).ready(function() {
		
		/* ????????? */
		fnInit();
		
		/* ?????? ????????? ?????? */
		fnInitClickEvent();
	
		/* ????????? ????????? ?????? */
		fnGridSetAmtTable(nowTab);
		
	});

	/*	[?????????] ????????? ?????? ?????? ???????????? ????????? ??????
	--------------------------------------------*/
	function fnChangeDomesticDiv(domesticDiv){
		$("#domestic_div").val(domesticDiv);
	}
	
	/*	[?????????] ???????????? ?????????
	--------------------------------------------*/
	function fnInit(){
		$('.amtMask').mask("000,000,000,000,000,000,000", {reverse: true});	
	}
	
	/*	[?????????] ???????????? ?????? ????????? ?????????
	--------------------------------------------*/
	function fnInitClickEvent(){
		
		/* ????????? ??? ?????? ????????? */
		$('.orderBy').hide();
		/* 1: ?????? '': ????????? */
		$('.orderBy').click(function(){
			orderBy = !orderBy;
			fnGridSetAmtTable(nowTab);
			if(orderBy){
				$('.orderBy').val('????????? ??? ??????');
			}else{
				$('.orderBy').val('????????? ???');
			}
		});
		
		/* ????????? ??? ??????????????? */
		Pudd( ".grid").on( "gridRowClick", function( e ) {
			var rowData = e.detail.trObj.rowData;
			fnFormInit(rowData);
		});
		
		//??? ?????? ?????????
		Pudd( "#exTab" ).puddTab({ 
				tabMinWidth : 95
		 	,	newTab : false
		 	,	tabClickCallback : function( idx, tabMenu, tabArea ) {
	 				nowTab = idx;
	 				nowTabName = tabMenu.innerText;
	 				fnGridSetAmtTable(nowTab);
	 				
				}
		});
		
		//???????????????
		$('#searchButton').click(function(){
			fnGridSetAmtTable(nowTab);
		});
		
		$(".enter").keydown(function (key) {		 
		    if(key.keyCode == 13){//?????? 13?????? ?????? (????????? 13)
		    	fnGridSetAmtTable(nowTab);
		    }
		});
		
		//?????? 
		var puddObj = Pudd( "#addBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			$('tr.on').removeClass('on');
			fnFormInit();
		});
		//??????
		var puddObj = Pudd( "#saveBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnSaveTripAmt();	 	
		});
		//??????
		var puddObj = Pudd( "#deleteBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnDeleteAmt();
		});
		

	}
	
	/*	[??????] ??????????????? ?????? ??????
	----------------------------------------*/
	function fnDeleteAmt(){
		if(!$('tr:visible.on').length){
			alert("????????? ???????????? ??????????????????.");
			return;
		}
		
		if(confirm("????????????????????????")){
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
						alert("???????????? ?????? ???????????????");
						fnGridSetAmtTable(nowTab);
					}else{
						alert("????????? ?????????????????????.");						
					}				
				}
			});
		}
	}
	
	
	/*	[????????????] ???????????? ?????? ?????????
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
		
		dateObj = new Pudd.Util.Date( );// val?????? '2018-08-03' ???????????? ??????, ????????? ????????????
		dateObj = param.applyDate || dateObj.getFormatString('yyyy-MM-dd');
		var puddObj = Pudd( "#applyDate_" + nowTab ).getPuddObject();
		puddObj.setDate(dateObj);
		
		Pudd( "#amtHoldCode_" + nowTab ).getPuddObject().setSelectedIndex( ''+ param.amtHoldCode );
		if( (param.amtHoldCode || '0') == '0' ){
			$('#amtHoldName_' + nowTab ).text('??????');
		}else {
			$('#amtHoldName_' + nowTab ).text('?????????');
		}
	}
	
	/*	[????????????] ????????? ?????? ???????????? ?????? tkdqo
	-------------------------------------------*/
	function fnSaveTripAmt(){
		
		if ( !( $(".transportName:visible").val() || $(".locationName:visible").val()) ){
			if( $(".transportName:visible").length ){
				alert('??????????????? ??????????????????.');
				return;
			}else {
				alert('???????????? ??????????????????');
				return;
			}
		} else if( $.trim($(".dutyGroupName:visible").val() ) == ""){
			alert("???????????? ?????? ??????????????????.");
			return;
		}
		
		
		if(confirm("?????????????????????????")){
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
						alert("????????? ????????? ?????????????????? ???????????????. ????????? ????????? ?????????????????? ????????????.");
					}else if(result.result.resultCode == 'SUCCESS'){
						alert("?????? ???????????????");
						fnGridSetAmtTable(nowTab);
					}else{
						alert("????????? ??????????????????");
					}
				}
			});
		}
	}
	
	/*	[????????????] ?????? ?????? ???????????? ??????
	-------------------------------------------*/
	function fnGetCommonParams(){
		return {
			applyDate : $('#applyDate_'+nowTab).val().replace(/-/gi,"")
			, applyAmt :  ( $('#applyAmt_'+nowTab).val()  || '0' ).replace(/,/gi, '')
			, amtHoldCode : $('.amtHoldCode:visible option:selected').val()
			, note : $('#note_'+nowTab).val()
		};
	}
		
	/*	[????????????] ????????? ????????? ????????????
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
	
	/*	[????????????] ?????? ?????? ????????? ??????
	------------------------------------------- */
	function fnGridSetAmtTable(nowTab){
		var puddObj = Pudd( "#amtHoldCode_" + nowTab ).getPuddObject();
		puddObj.on( "change", function( e ) {
			var val = puddObj.val();
			if(val == '0'){
				$('#amtHoldName_' + nowTab).text('??????');
			}else {
				$('#amtHoldName_' + nowTab).text('?????????');
			}
		});
	
		$('#txtAllPrint_' + nowTab).unbind().click(function(){
			/* ?????? ????????? ????????? ?????? */
		//	fnPrintGrid();
		});

		/* ?????? ????????? ????????? ?????? */
		fnPrintGrid();
	}

	/*	[????????????] ???????????? ????????? ??????
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
						data.domesticDiv = $("#domesticDiv option:selected").val();; // ?????? 
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
					, title:"?????????"
					, width : 70
				}, {
					field : "locationName"
					, title : "?????????"
					, width : 20
					, widthUnit : "%"	
				}, {
					field:"dutyGroupName"
					, title:"????????????"
					, width : 20
					, widthUnit : "%"	
				}, {
					field:"applyDate"
					, title:"?????????"
					, width : 20
					, widthUnit : "%"	
				}, {
					field:"applyAmt"
					, title:"??????"
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
				message : "???????????? ???????????? ????????????."
			}
		});
		
		/* ???????????? ????????? */
		fnFormInit();
	}
	
	/*	[??????] ???????????? ?????? ?????? ??????
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
	
	/*	[??????] ???????????? ?????? ??????
	--------------------------------------------------*/
	function setTransPortCallback(rowData){
		$(".transportName").val(rowData.transname);
		$('.hidTransportName').eq(nowTab).val(rowData.transportSeq);
	}
	
	/*	[??????] ????????? ?????? ?????? ??????
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
	
	/*	[??????] ????????? ?????? ??????
	--------------------------------------------------*/
	function setLocationCallback(rowData){
		$(".locationName").val(rowData.locationname);
		$('.hidLocationName').eq(nowTab).val(rowData.locationSeq);
	}
	
	/*	[??????] ???????????? ?????? ?????? ??????
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

	/*	[??????] ???????????? ?????? ??????
	--------------------------------------------------*/
	function setPositionCallback(rowData){
		$(".dutyGroupName").val(rowData.dutyGroupName);
		$('.hidDutyGroupName').eq(nowTab).val(rowData.dutyGroupSeq);
	}
</script>

	<!-- ??????????????? -->
	<div class="top_box">
		<dl>
			<dt style="width:50px;" class="ar">?????????</dt>
			<dd>
				<select id="domesticDiv" class="puddSetup" pudd-style="width:100px;">
					<option value="">??????</option>
					<option value="0">??????</option>
					<option value="1">??????</option>
				</select>
			</dd>

			<dt>?????????</dt>
			<dd><input id="locationName" type="text" style="width:150px;" class="puddSetup enter" value="" /></dd>

			<dt>????????????</dt>
			<dd><input id="dutyGroupName" type="text" style="width:150px;" class="puddSetup enter" value="" /></dd>

<!-- 			<dt>????????????</dt> -->
<!-- 			<dd><input id="transPortName" type="text" style="width:175px;" class="puddSetup enter" value="" /></dd> -->

			<dd><input id="searchButton"type="button" class="puddSetup submit" value="??????" /></dd>
		</dl>
	</div>

	<div class="sub_contents_wrap">					
		<div class="posi_re mt14">
			<div id="" class="posi_ab" style="right:0px; z-index:1;">
				<input id="addBtn" type="button" class="puddSetup" value="??????" />
				<input id="saveBtn" type="button" class="puddSetup" value="??????" />
				<input id="deleteBtn" type="button" class="puddSetup" value="??????" />
			</div>
		</div>							

		<div id="exTab" class="mt14">
			<ul>
				<li>??????</li>
				<li>??????</li>
				<li>?????????</li>
				<li>?????????</li>
				<li>????????????</li>
				<li>?????????</li>
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
										<h5 class="fl">????????????</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value="" id="txtAllPrint_0" class="puddSetup" pudd-label="???????????? ??????" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="????????? ???" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>?????????</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														??????
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_0" value="0" class="puddSetup" pudd-label="??????" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_0" value="1" class="puddSetup" pudd-label="??????" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="applyDate_0" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th> <span id="amtHoldName_0">??????</span> </th>
											<td>
												<input type="text" autocomplete="off" placehold="0" id="applyAmt_0" pudd-style="width:35%;" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> ???
												<select id="amtHoldCode_0" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>????????????</option>
													<option value="1">????????????</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input id="note_0" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- ???????????? : ????????? ????????? ???????????? (????????????) <br/>
									- ???????????? : ????????? ?????? ??? ???????????? (????????? ??? ?????? ????????????)
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
										<h5 class="fl">????????????</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value="" id="txtAllPrint_1" class="puddSetup" pudd-label="???????????? ??????" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="????????? ???" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>?????????</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														??????
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_1" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="??????" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_1" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="??????" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="applyDate_1" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_1">??????</span></th>
											<td>
												<input type="text" autocomplete="off" id="applyAmt_1" pudd-style="width:35%;" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> ???
												<select id="amtHoldCode_1" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>????????????</option>
													<option value="1">????????????</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input id="note_1" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- ???????????? : ????????? ????????? ???????????? (????????????) <br/>
									- ???????????? : ????????? ?????? ??? ???????????? (????????? ??? ?????? ????????????)
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
										<h5 class="fl">????????????</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value="" id="txtAllPrint_2" class="puddSetup" pudd-label="???????????? ??????" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="????????? ???" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>?????????</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														??????
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_2" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="??????" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_2" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="??????" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="applyDate_2" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_2">??????</span></th>
											<td>
												<input type="text" autocomplete="off" id="applyAmt_2" pudd-style="width:35%;" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> ???
												<select id="amtHoldCode_2" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>????????????</option>
													<option value="1">????????????</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input id="note_2" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- ???????????? : ????????? ????????? ???????????? (????????????) <br/>
									- ???????????? : ????????? ?????? ??? ???????????? (????????? ??? ?????? ????????????)
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
										<h5 class="fl">????????????</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value=""  id="txtAllPrint_3" class="puddSetup" pudd-label="???????????? ??????" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="????????? ???" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>?????????</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														??????
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_3" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="??????" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_3" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="??????" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="applyDate_3" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_3">??????</span></th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:35%;" id="applyAmt_3" placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> ???
												<select id="amtHoldCode_3" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>????????????</option>
													<option value="1">????????????</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input id="note_3" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- ???????????? : ????????? ????????? ???????????? (????????????) <br/>
									- ???????????? : ????????? ?????? ??? ???????????? (????????? ??? ?????? ????????????)
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
										<h5 class="fl">????????????</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value=""  id="txtAllPrint_4" class="puddSetup" pudd-label="???????????? ??????" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="????????? ???" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>?????????</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														??????
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_4" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="??????" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_4" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="??????" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="applyDate_4" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_4">??????</span></th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:35%;" id="applyAmt_4" placeHolder="0" class="applyAmt  amtMask puddSetup" value=""/> ???
												<select id="amtHoldCode_4" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>????????????</option>
													<option value="1">????????????</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input id="note_4" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- ???????????? : ????????? ????????? ???????????? (????????????) <br/>
									- ???????????? : ????????? ?????? ??? ???????????? (????????? ??? ?????? ????????????)
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
										<h5 class="fl">????????????</h5>									
										<span class="fl pt5 pl5"><input type="checkbox" value=""  id="txtAllPrint_5" class="puddSetup" pudd-label="???????????? ??????" /></span>
									</div>
									<div class="right_div">
										<input type="button" class="orderBy puddSetup" value="????????? ???" />
									</div>
								</div>
																				
								<div class="grid"></div>											
							</td>

							<td class="twinbox_td">										
								<p class="tit_p fl mt5">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="120"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th>?????????</th>
											<td>	
												<div>
													<label class="txtDisplayDomesticCode">
														??????
													</label>
												</div>
												<div  class="txtDisplayDomesticRadio">
													<input type="radio" name="domestic_div_1" id="domestic_0_5" value="0" onchange="fnChangeDomesticDiv('0')" class="puddSetup" pudd-label="??????" checked />
													<input type="radio" name="domestic_div_1" id="domestic_1_5" value="1" onchange="fnChangeDomesticDiv('1')" class="puddSetup" pudd-label="??????" />
												</div>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="locationName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidLocationName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelLocationPop()"/>
											</td>
										</tr>
										<tr>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:65%;" class="dutyGroupName puddSetup" value="" readonly/>
												<input type="hidden"  class="hidDutyGroupName" value="" />
												<input type="button" class="puddSetup" value="??????" onclick="fnSelDutyGroupPop()"/>
											</td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="applyDate_5" class="applyDate puddSetup" pudd-type="datepicker" value="" /></td>
										</tr>
										<tr>
											<th><span id="amtHoldName_5">??????</span></th>
											<td>
												<input type="text" autocomplete="off" pudd-style="width:35%;" id="applyAmt_5"  placeHolder="0" class="applyAmt amtMask puddSetup" value=""/> ???
												<select id="amtHoldCode_5" class="amtHoldCode puddSetup" pudd-style="width:95px;">
													<option value="0" selected>????????????</option>
													<option value="1">????????????</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input id="note_5" class="note" type="text" value="" style="width:100%;"></td>
										</tr>
									</table>
								</div>
									
								<div class="text_blue mt10 f11 lh18">
									- ???????????? : ????????? ????????? ???????????? (????????????) <br/>
									- ???????????? : ????????? ?????? ??? ???????????? (????????? ??? ?????? ????????????)
								</div>																				
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div><!--// sub_contents_wrap -->
</html>
