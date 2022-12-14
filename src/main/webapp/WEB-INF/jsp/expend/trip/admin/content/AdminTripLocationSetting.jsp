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
</head>

<!-- iframe wrap -->
<div class="iframe_wrap">
	<div class="sub_contents_wrap">
		<div class="posi_re">
			<div id="" class="posi_ab" style="right:0px; z-index:1;">
				<input id="addBtn0" type="button" class="puddSetup" value="??????" />
				<input id="saveBtn0" type="button" class="puddSetup" value="??????" />
				<input id="deleteBtn0" type="button" class="puddSetup" value="??????" />
			</div>
		</div>							

		<div id="exTab">
			<ul>
				<li value = '0'>??????</li>
				<li value = '1'>??????</li>
			</ul>

			<div>							
				<div class="twinbox mt20">
					<table style="min-height:0">
						<colgroup>
							<col width="60%"/>
							<col />
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<p class="tit_p fl">???????????????</p>
								<div class="top_box">
									<dl>
										<dt>????????????</dt>
										<dd><input type="text" autocomplete="off" style="width:110px;" id="searchCode0" class="puddSetup searchCode" value="" /></dd>
										<dt>????????????</dt>
										<dd>
											<select id="locationEditYn0" class="puddSetup" pudd-style="width:80px;">
												<option value="" selected>??????</option>
												<option value="Y">??????</option>
												<option value="N">??????</option>
											</select>
										</dd>
										<dt>????????????</dt>
										<dd>
											<select id="useYn_search0" class="puddSetup" pudd-style="width:80px;">
												<option value="" selected>??????</option>
												<option value="Y">??????</option>
												<option value="N">?????????</option>
											</select>
										</dd>
										<dd><input type="button" id="searchButton0" class="puddSetup submit" value="??????" /></dd>
									</dl>
								</div>
								<div id="grid0" class="grid mt14"></div>											
							</td>


							<td class="twinbox_td">	
								<p class="tit_p fl">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="90"/>
											<col width="90"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td><input type="text" autocomplete="off" id="locationNmKr0" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input type="text" autocomplete="off" id="locationNmEn0" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="locationNmJp0" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="locationNmCn0" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>	
										<tr>
											<th colspan="2">????????????</th>
											<td>
												<input type="radio" name="locationEditYn" id="location_edit_yn_y0" value="Y" class="puddSetup" pudd-label="??????" checked />
												<input type="radio" name="locationEditYn" id="location_edit_yn_n0" value="N" class="puddSetup" pudd-label="??????" />
											</td>
										</tr>
										<tr>
											<th colspan="2">????????????</th>
											<td >
												<input type="radio" name="useYn" id="use_yn_y0" value="Y" class="puddSetup" pudd-label="??????" checked />
												<input type="radio" name="useYn" id="use_yn_n0" value="N" class="puddSetup" pudd-label="?????????" />
											</td>
										</tr>
										<tr>
											<th colspan="2">????????????</th>
											<td><input type="text" autocomplete="off" id="orderNum0" pudd-style="width:100%;" class="puddSetup" value="" /></td>
										</tr>
										<tr>
											<th colspan="2">??????</th>
											<td><input type="text" autocomplete="off" id="note0" pudd-style="width:100%;" class="puddSetup" value="" /></td>
										</tr>
									</table>
									
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
							<col />
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<p class="tit_p fl">???????????????</p>
								<div class="top_box">
									<dl>
										<dt>????????????</dt>
										<dd><input type="text" autocomplete="off" style="width:110px;" id="searchCode1" class="puddSetup searchCode" value="" /></dd>
										<dt>????????????</dt>
										<dd>
											<select id="locationEditYn1" class="puddSetup" pudd-style="width:80px;">
												<option value="" selected>??????</option>
												<option value="Y">??????</option>
												<option value="N">??????</option>
											</select>
										</dd>
										<dt>????????????</dt>
										<dd>
											<select id="useYn_search1" class="puddSetup" pudd-style="width:80px;">
												<option value="" selected>??????</option>
												<option value="Y">??????</option>
												<option value="N">?????????</option>
											</select>
										</dd>
										<dd><input type="button" id="searchButton1" class="puddSetup submit" value="??????" /></dd>
									</dl>
								</div>
								<div id="grid1" class="grid mt14"></div>											
							</td>


							<td class="twinbox_td">	
								<p class="tit_p fl">????????????</p>
								<div class="com_ta">
									<table>
										<colgroup>
											<col width="90"/>
											<col width="90"/>
											<col width=""/>
										</colgroup>
										<tr>
											<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> ????????????</th>
											<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
											<td><input type="text" autocomplete="off" id="locationNmKr1" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>
										<tr>
											<th>??????</th>
											<td><input type="text" autocomplete="off" id="locationNmEn1" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="locationNmJp1" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>
										<tr>
											<th>?????????</th>
											<td><input type="text" autocomplete="off" id="locationNmCn1" pudd-style="width:100%;" class="puddSetup clearTarget" value="" /></td>
										</tr>	
										<tr>
											<th colspan="2">????????????</th>
											<td>
												<input type="radio" name="locationEditYn" id="location_edit_yn_y1" value="Y" class="puddSetup" pudd-label="??????" checked />
												<input type="radio" name="locationEditYn" id="location_edit_yn_n1" value="N" class="puddSetup" pudd-label="??????" />
											</td>
										</tr>
										<tr>
											<th colspan="2">????????????</th>
											<td >
												<input type="radio" name="useYn" id="use_yn_y1" value="Y" class="puddSetup" pudd-label="??????" checked />
												<input type="radio" name="useYn" id="use_yn_n1" value="N" class="puddSetup" pudd-label="?????????" />
											</td>
										</tr>
										<tr>
											<th colspan="2">????????????</th>
											<td><input type="text" autocomplete="off" id="orderNum1" pudd-style="width:100%;" class="puddSetup" value="" /></td>
										</tr>
										<tr>
											<th colspan="2">??????</th>
											<td><input type="text" autocomplete="off" id="note1" pudd-style="width:100%;" class="puddSetup" value="" /></td>
										</tr>
									</table>
									
								</div>												
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>


	</div><!--// sub_contents_wrap -->
</div><!--// iframe wrap -->
				
<script type="text/javascript">
	var nowTab = 0;
	
	/*	[?????????] ???????????? ?????? ????????? ???
	---------------------------------------------------- */
	$(document).ready(function() {
		fnInitClickEvent();
		fnGridSetLocationTable(nowTab);
	});
	
	function fnInitClickEvent(){
		/*  */
		Pudd( "#exTab" ).puddTab({	 
		 		newTab : false
		 	,	tabClickCallback : function( idx, tabMenu, tabArea ) {
		 			nowTab = idx;
		 			fnGridSetLocationTable(nowTab);
			}
		 	
		});
		
		//????????? ??? ??????????????? 
		Pudd( ".grid").on( "gridRowClick", function( e ) {
			
			// e.detail ???????????? customEvent param ?????????
			var evntVal = e.detail;
		 
			if( ! evntVal ) return;
			if( ! evntVal.trObj ) return;
		 
			// dataSource?????? ????????? row data
			var rowData = evntVal.trObj.rowData;
		 	
			$('#locationNmKr' + nowTab).val(rowData.locationNmKr);
			$('#locationNmEn' + nowTab).val(rowData.locationNmEn);
			$('#locationNmJp' + nowTab).val(rowData.locationNmJp);
			$('#locationNmCn' + nowTab).val(rowData.locationNmCn);
			
			if(rowData.use_yn=='Y'){
				Pudd( 'input:radio[id="use_yn_y' + nowTab + '"]' ).getPuddObject().setChecked( true );
				Pudd( 'input:radio[id="use_yn_n' + nowTab + '"]' ).getPuddObject().setChecked( false );
			}
			else{
				Pudd( 'input:radio[id="use_yn_y' + nowTab + '"]' ).getPuddObject().setChecked( false );
				Pudd( 'input:radio[id="use_yn_n' + nowTab + '"]' ).getPuddObject().setChecked( true );
			}
			if(rowData.location_edit_yn=='Y'){
				Pudd( 'input:radio[id="location_edit_yn_y' + nowTab  + '"]' ).getPuddObject().setChecked( true );
				Pudd( 'input:radio[id="location_edit_yn_n' + nowTab  + '"]' ).getPuddObject().setChecked( false );
			}
			else{
				Pudd( 'input:radio[id="location_edit_yn_y' + nowTab  + '"]' ).getPuddObject().setChecked( false );
				Pudd( 'input:radio[id="location_edit_yn_n' + nowTab + '"]' ).getPuddObject().setChecked( true );
			}
			
			$('#orderNum' + nowTab).val(rowData.orderNum);
			$('#note' + nowTab).val(rowData.note);
		});
		
		
		//?????? 
		var puddObj = Pudd( "#addBtn" + nowTab ).getPuddObject();
		puddObj.on( "click", function( e ) {
			$('tr.on').removeClass('on');
			fnFormInit();
		});
		//??????
		var puddObj = Pudd( "#saveBtn" + nowTab ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnSave();	 	
		});
		//??????
		var puddObj = Pudd( "#deleteBtn" + nowTab ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnDelete();
		});
	
		//???????????????
		$('.submit').click(function(){
			fnGridSetLocationTable(nowTab);
		});
		
		$('.searchCode').keydown(function (key) {		 
	        if(key.keyCode == 13){//?????? 13?????? ?????? (????????? 13)
	    		fnGridSetLocationTable(nowTab);
	        }
	    });
	}

	/*	[??????] ????????? ?????? ??????
	------------------------------------------- */
	function fnDelete(){
		if(!fnGetSelectedRowData().locationSeq){
			alert("????????? ???????????? ??????????????????.");
			return;
		}
		if(confirm("????????????????????????")){
			$.ajax({
				type: 'POST',
				url:'<c:url value="/expend/trip/admin/option/AdminTripDelete.do"/>',
				data:{
						"pageType" : 'location'
						,"locationSeq":fnGetSelectedRowData().locationSeq
					},
				dataType:'json',
				success: function(result){
					if(result.result.resultCode == 'EXSIST_AMT'){
						alert('????????????????????? ???????????? ?????? ????????? ????????? ?????????????????? ?????? ??????????????? ????????????.');
					}else if(result.result.resultCode == 'SUCCESS'){
						alert('????????? ?????????????????????.');
						fnFormInit();
						fnGridSetLocationTable(nowTab);
					}else{
						alert("????????? ?????????????????????.");						
					}				
				}
			});
		}	
	}
	
	/*	[???????????????] ????????? ????????? ????????????
	-----------------------------------------*/
	function fnGetSelectedRowData(){
		if( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
			return {};
		}
		return JSON.parse(unescape( $('tr.on').eq(0).find('.hiddenExpenseJson').val() ));
	}
	
	/*	[??????] ?????? ?????? ?????? ?????????
	-----------------------------------------*/
	function fnSave(){
		if($.trim($("#locationNmKr" + nowTab).val()) == ""){
			alert("??????????????? ??????????????????.");
			$("#locationNmKr" + nowTab).focus();
			return;
		}
		var puddTab = Pudd( "#exTab" ).getPuddObject();
		if(confirm("?????????????????????????")){
			var saveUrl = "";
			
			if((!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length)){
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTripSettingPageInsert.do"/>';
			}else{
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTripSettingPageUpdate.do"/>';
			}
			$.ajax({
				type: 'POST',
				url:saveUrl,
				data: {
					"pageType" : 'location'
						,"locationSeq":fnGetSelectedRowData().locationSeq
						, "locationEditYn":Pudd( 'input:radio[id="location_edit_yn_y' + nowTab + '"]' ).getPuddObject().getChecked()?'Y':'N'
						,"locationNmKr":$('#locationNmKr' + nowTab).val()
						,"locationNmEn":$('#locationNmEn' + nowTab).val()
						,"locationNmJp":$('#locationNmJp' + nowTab).val()
						,"locationNmCn":$('#locationNmCn' + nowTab).val()
						,"domesticDiv":puddTab.getActiveTab()
						,"useYn":$('input[name="useYn"]:checked').val()
						,"orderNum":$('#orderNum' + nowTab).val()
						,"note":$('#note' + nowTab).val()
				},
				dataType:'json',
				success: function(e){
					if(e.result){
						alert("?????? ???????????????");
						fnGridSetLocationTable(nowTab);
						fnFormInit();
					}else{
						alert("????????? ??????????????????");
					}
				}
			});
		}
	}
	
	/*	[????????? ??????] ????????? ?????? ??????/??????
	-------------------------------------------- */
	function fnGridSetLocationTable(nowTab){
		var LocationData = new Pudd.Data.DataSource({
			pageSize : 10
			, request : {
					url : "<c:url value='/expend/trip/admin/option/AdminTripSettingPageSelect.do'/>"
				,	type : 'post'
				,	dataType : "json"
				,	parameterMapping : function( data ) {
						var puddTab = Pudd( "#exTab" ).getPuddObject();
						data.pageType = 'location';
						data.searchCode =  $("#searchCode" + nowTab).val();
						data.domesticDiv = puddTab.getActiveTab(); 
						data.useYn = $("#useYn_search" + nowTab + " option:selected").val();
						data.locationEditYn = $("#locationEditYn" + nowTab + " option:selected").val();
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
			dataSource : LocationData 
		,	height : 300
		,	scrollable : true 
		,	pageable : {
				buttonCount : 10
			,	pageList : [ 10, 20, 30, 40, 50 ]
			} 
		,	resizable : true	
		,	columns : [ 
			{
				field : "NO"
				,	title : "no"
				,	width : 80
				, content : {
					template : function( rowData ) {
						var html = '<input type="hidden" class="hiddenExpenseJson" value="' + escape(JSON.stringify(rowData)) + '">' + rowData.NO + '</input>';
						return html;  
					}
				}
			}
		,	{
				field:"locationname"
			,	title:"????????????"
			}
		,	{
				field:"location_edit_yn"
				,	title:"????????????"
				,	width : 20
				,	widthUnit : "%"	
			}
		,	{
				field:"use_yn"
				,	title:"????????????"
				,	width : 20
				,	widthUnit : "%"	
			}
		]
		,noDataMessage : {
			message : "???????????? ???????????? ????????????."
		}
		});
	
	}
	
	/*	[????????????] ???????????? ?????????
	------------------------------------------- */
	function fnFormInit(){
		$('.clearTarget').val('');
		Pudd( 'input:radio[id="use_yn_y' + nowTab +'"]' ).getPuddObject().setChecked( true );
		Pudd( 'input:radio[id="location_edit_yn_y' + nowTab + '"]' ).getPuddObject().setChecked( true );
		$('#orderNum' + nowTab).val('');
		$('#note' + nowTab).val('');
	}

</script>				