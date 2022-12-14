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
	<!-- ??????????????? -->
	<div class="top_box">
		<dl>
			<dt>???????????????</dt>
			<dd><input id="transportName" type="text" style="width:200px;" class="puddSetup" value="" /></dd>
			<dt>????????????</dt>
			<dd>
				<select id="useYn" class="puddSetup" pudd-style="width:90px;">
					<option value="" selected>??????</option>
					<option value="Y">??????</option>
					<option value="N">?????????</option>
				</select>
			</dd>
			<dd><input id="searchButton" type="button" class="puddSetup submit" value="??????" /></dd>
		</dl>						
	</div>

	<div class="sub_contents_wrap">

		<div class="btn_div">
			<div class="right_div">
				<input type="button" name="adjustBtn" id="addBtn" class="puddSetup" value="??????" />
				<input type="button" name="adjustBtn" id="saveBtn" class="puddSetup" value="??????" />
				<input type="button" name="adjustBtn" id="deleteBtn" class="puddSetup" value="??????" />
			</div>
		</div>
												
		<div class="twinbox">
			<table style="min-height:0">
				<colgroup>
					<col width="50%"/>
					<col />
				</colgroup>
				<tr>
					<td class="twinbox_td">
						<p class="tit_p fl">??????????????????</p>										
						<div id="grid" class="mt14"></div>											
					</td>
					<td class="twinbox_td">
						<p class="tit_p fl">????????????</p>
						<div class="com_ta">
							<table>
								<colgroup>
									<col width="100"/>
									<col width="100"/>
									<col width=""/>
								</colgroup>
								<tr>
									<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> ???????????????</th>
									<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
									<td><input id="trNmKr" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>
								<tr>
									<th>??????</th>
									<td><input id="trNmEn" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>
								<tr>
									<th>?????????</th>
									<td><input id="trNmJp" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>
								<tr>
									<th>?????????</th>
									<td><input id="trNmCn" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>	
								<tr>
									<th colspan="2">????????????</th>
									<td>
										<input type="radio" id="use_yn_y" name="useYn" value="Y" class="puddSetup" pudd-label="??????" checked />
										<input type="radio" id="use_yn_n" name="useYn" value="N" class="puddSetup" pudd-label="?????????" />
									</td>
								</tr>
								<tr>
									<th colspan="2">????????????</th>
									<td><input id="orderNum" type="text" pudd-style="width:100%;" class="puddSetup" value=""  onkeyup="this.value=this.value.replace(/[^\d]/gi,'')"/></td>
								</tr>
								<tr>
									<th colspan="2">??????</th>
									<td><input id="note" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>
							</table>
						</div>
							
					</td>
				</tr>
			</table>
		</div>
	</div><!--// sub_contents_wrap -->
</div><!--// iframe wrap -->
				
<script type="text/javascript">
	
	$(document).ready(function() {
		
		fnInitClickEvent();
		
		//???????????? ?????? ??????
		fnGridSetTransTable();
	});
	
	function fnInitClickEvent(){
	
		//?????? ?????? ?????????
		$('#searchButton').click(function(){
			fnGridSetTransTable();	
		});
		
		//????????? ?????? ?????????
		$('#transportName').keydown(function (key) {		 
	        if(key.keyCode == 13){//?????? 13?????? ?????? (????????? 13)
	    		fnGridSetTransTable();	
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
			fnSave();	 	
		});
		//??????
		var puddObj = Pudd( "#deleteBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnDeleteTransport();
		});
		
		//????????? ??? ???????????????
		Pudd( "#grid" ).on( "gridRowClick", function( e ) {
			
			// e.detail ???????????? customEvent param ?????????
			var evntVal = e.detail;
		 
			if( ! evntVal ) return;
			if( ! evntVal.trObj ) return;
		 
			// dataSource?????? ????????? row data
			var rowData = evntVal.trObj.rowData;
		 	
			$('#trNmKr').val(rowData.trNmKr);
			$('#trNmEn').val(rowData.trNmEn);
			$('#trNmJp').val(rowData.trNmJp);
			$('#trNmCn').val(rowData.trNmCn);
			
			if(rowData.use_yn=='Y'){
				Pudd( 'input:radio[id="use_yn_y"]' ).getPuddObject().setChecked( true );
			}
			else{
				Pudd( 'input:radio[id="use_yn_n"]' ).getPuddObject().setChecked( true );
			}
			
			$('#orderNum').val(rowData.order_num);
			$('#note').val(rowData.note);
		});	
	}
	
	//???????????? ??????
	function fnDeleteTransport(){
		if(!fnGetSelectedRowData().transSeq){
			alert("????????? ???????????? ??????????????????.");
			return;
		}
		if(confirm("????????????????????????")){
			$.ajax({
				type: 'POST',
				url:'<c:url value="/expend/trip/admin/option/AdminTransPortDelete.do"/>',
				data:{
						"transSeq":fnGetSelectedRowData().transSeq
					},
				dataType:'json',
				success: function(result){
					if(result.result.resultCode == 'EXSIST_AMT'){
						alert("????????????????????? ???????????? ?????? ????????? ????????? ?????????????????? ?????? ??????????????? ????????????.");
					} else if(result.result.resultCode == 'SUCCESS'){
						alert("???????????? ?????? ???????????????");
						fnFormInit();
						fnGridSetTransTable();
					}else{
						alert("????????? ?????????????????????.");						
					}				
				}
			});
		}	
	}
	
	/*	[??????????????????] ????????? ???????????? ?????? ????????????
	-----------------------------------------*/
	function fnGetSelectedRowData(){
		if( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
			return {};
		}
		return JSON.parse(unescape( $('tr.on').eq(0).find('.hiddenExpenseJson').val() ));
	}
	
	/*	[??????] ???????????? ?????? ??????
	-----------------------------------------------	*/
	function fnSave(){
		if($.trim($("#trNmKr").val()) == ""){
			alert("?????????????????? ??????????????????.");
			$("#trNmKr").focus();
			return;
		}
		if(confirm("?????????????????????????")){
			var saveUrl = "";
			
			if((!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length)){
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTransPortInsert.do"/>';
			}else{
				saveUrl = '<c:url value="/expend/trip/admin/option/AdminTransPortUpdate.do"/>';
			}
			
			$.ajax({
				type: 'POST',
				url:saveUrl,
				data: {
					"transSeq":fnGetSelectedRowData().transSeq
					,"trNmKr":$('#trNmKr').val()
					,"trNmEn":$('#trNmEn').val()
					,"trNmJp":$('#trNmJp').val()
					,"trNmCn":$('#trNmCn').val()
					,"useYn":$('input[name="useYn"]:checked').val()
					,"orderNum":$('#orderNum').val()
					,"note":$('#note').val()
			},
				dataType:'json',
				success: function(e){
					if(e.result){
						alert("?????? ???????????????");
						fnGridSetTransTable();
						fnFormInit();
					}else{
						alert("????????? ??????????????????");
					}
				}
			});
		}
	}
	
	/*	[????????????] ???????????? ?????? ?????? ?????????
	---------------------------------------------- */
	function fnFormInit(){
		$('#trNmKr').val('');
		$('#trNmEn').val('');
		$('#trNmJp').val('');
		$('#trNmCn').val('');
		Pudd( 'input:radio[id="use_yn_y"]' ).getPuddObject().setChecked( true );
		$('#orderNum').val('');
		$('#note').val('');
	}
	
	/*	[??????????????????] ???????????? ?????? ??????
	---------------------------------------------- */
	function fnGridSetTransTable(){
		var puddGrid = Pudd( "#grid" ).getPuddObject();
		//puddGrid.page( 1 );
		//?????????????????? ?????? ????????? ??????
		var transPortData = new Pudd.Data.DataSource({
			pageSize : 10
			,	request : {
					url : "<c:url value='/expend/trip/admin/option/AdminTripSettingPageSelect.do'/>"
				,	type : 'post'
				,	dataType : "json"
				,	parameterMapping : function( data ) {
						data.pageType = 'transPort';
						data.searchCode = $('#transportName').val()||'';
						data.useYn = data.useYn = $("#useYn option:selected").val();
					}
				}
			,	result : {
					data : function( response ) {
						return response.result.aaData;
					}
				,	totalCount : function( response ) {
						return response.result.aaData.length;
					}
				,	error : function( response ) {
						alert( "error - Pudd.Data.DataSource.read, status code - " + response.result.resultCode );
					}
				}
		   });
	 
		Pudd( "#grid" ).puddGrid({ 
			dataSource : transPortData 
		,	height : 300
		,	scrollable : true 
		,	pageable : {
				buttonCount : 10
			,	pageList : [ 10, 20, 30, 40, 50 ]
			} 
		,	resizable : true	
	/* 	,	gridContent : { 
				attributes : { style : "min-height:226px;"}
			} */
		,	columns : [ 
				{
					field : "NO"
					, title : "no"
					, width : 80
					, content : {
						template : function( rowData ) {
							var html = '<input type="hidden" class="hiddenExpenseJson" value="' + escape(JSON.stringify(rowData)) + '">' + rowData.NO + '</input>';
							return html;  
						}
					}
				}
			,	{
					field:"transname"
				,	title:"???????????????"
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
</script>				