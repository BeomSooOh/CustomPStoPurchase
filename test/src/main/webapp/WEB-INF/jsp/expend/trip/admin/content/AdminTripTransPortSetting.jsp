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
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>운임수단명</dt>
			<dd><input id="transportName" type="text" style="width:200px;" class="puddSetup" value="" /></dd>
			<dt>사용유무</dt>
			<dd>
				<select id="useYn" class="puddSetup" pudd-style="width:90px;">
					<option value="" selected>전체</option>
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
			</dd>
			<dd><input id="searchButton" type="button" class="puddSetup submit" value="검색" /></dd>
		</dl>						
	</div>

	<div class="sub_contents_wrap">

		<div class="btn_div">
			<div class="right_div">
				<input type="button" name="adjustBtn" id="addBtn" class="puddSetup" value="추가" />
				<input type="button" name="adjustBtn" id="saveBtn" class="puddSetup" value="저장" />
				<input type="button" name="adjustBtn" id="deleteBtn" class="puddSetup" value="삭제" />
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
						<p class="tit_p fl">운임수단목록</p>										
						<div id="grid" class="mt14"></div>											
					</td>
					<td class="twinbox_td">
						<p class="tit_p fl">상세내역</p>
						<div class="com_ta">
							<table>
								<colgroup>
									<col width="100"/>
									<col width="100"/>
									<col width=""/>
								</colgroup>
								<tr>
									<th rowspan="4"><img src="../../../Images/ico/ico_check01.png" alt=""> 운임수단명</th>
									<th><img src="../../../Images/ico/ico_check01.png" alt=""> 한국어</th>
									<td><input id="trNmKr" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>
								<tr>
									<th>영어</th>
									<td><input id="trNmEn" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>
								<tr>
									<th>일본어</th>
									<td><input id="trNmJp" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>
								<tr>
									<th>중국어</th>
									<td><input id="trNmCn" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
								</tr>	
								<tr>
									<th colspan="2">사용유무</th>
									<td>
										<input type="radio" id="use_yn_y" name="useYn" value="Y" class="puddSetup" pudd-label="사용" checked />
										<input type="radio" id="use_yn_n" name="useYn" value="N" class="puddSetup" pudd-label="미사용" />
									</td>
								</tr>
								<tr>
									<th colspan="2">정렬순서</th>
									<td><input id="orderNum" type="text" pudd-style="width:100%;" class="puddSetup" value=""  onkeyup="this.value=this.value.replace(/[^\d]/gi,'')"/></td>
								</tr>
								<tr>
									<th colspan="2">비고</th>
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
		
		//운임수단 목록 조회
		fnGridSetTransTable();
	});
	
	function fnInitClickEvent(){
	
		//검색 클릭 이벤트
		$('#searchButton').click(function(){
			fnGridSetTransTable();	
		});
		
		//검색시 엔터 이벤트
		$('#transportName').keydown(function (key) {		 
	        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
	    		fnGridSetTransTable();	
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
			fnSave();	 	
		});
		//삭제
		var puddObj = Pudd( "#deleteBtn" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnDeleteTransport();
		});
		
		//그리드 행 클릭이벤트
		Pudd( "#grid" ).on( "gridRowClick", function( e ) {
			
			// e.detail 항목으로 customEvent param 전달됨
			var evntVal = e.detail;
		 
			if( ! evntVal ) return;
			if( ! evntVal.trObj ) return;
		 
			// dataSource에서 전달된 row data
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
	
	//운임수단 삭제
	function fnDeleteTransport(){
		if(!fnGetSelectedRowData().transSeq){
			alert("삭제할 데이터을 선택하십시요.");
			return;
		}
		if(confirm("삭제하시겠습니까")){
			$.ajax({
				type: 'POST',
				url:'<c:url value="/expend/trip/admin/option/AdminTransPortDelete.do"/>',
				data:{
						"transSeq":fnGetSelectedRowData().transSeq
					},
				dataType:'json',
				success: function(result){
					if(result.result.resultCode == 'EXSIST_AMT'){
						alert("출장비단가설정 메뉴에서 해당 조건이 반영된 출장비단가를 먼저 삭제하시기 바랍니다.");
					} else if(result.result.resultCode == 'SUCCESS'){
						alert("데이터가 삭제 되었습니다");
						fnFormInit();
						fnGridSetTransTable();
					}else{
						alert("삭제에 실패하였습니다.");						
					}				
				}
			});
		}	
	}
	
	/*	[운임수단목록] 선택된 운임수단 목록 가져오기
	-----------------------------------------*/
	function fnGetSelectedRowData(){
		if( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
			return {};
		}
		return JSON.parse(unescape( $('tr.on').eq(0).find('.hiddenExpenseJson').val() ));
	}
	
	/*	[저장] 운임수단 정보 저장
	-----------------------------------------------	*/
	function fnSave(){
		if($.trim($("#trNmKr").val()) == ""){
			alert("운임수단명을 입력해주세요.");
			$("#trNmKr").focus();
			return;
		}
		if(confirm("저장하시겠습니까?")){
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
						alert("저장 되었습니다");
						fnGridSetTransTable();
						fnFormInit();
					}else{
						alert("저장을 실패했습니다");
					}
				}
			});
		}
	}
	
	/*	[상세내역] 상세내역 입력 필드 초기화
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
	
	/*	[운임수단목록] 운임수단 목록 조회
	---------------------------------------------- */
	function fnGridSetTransTable(){
		var puddGrid = Pudd( "#grid" ).getPuddObject();
		//puddGrid.page( 1 );
		//운임수단목록 조회 그리드 생성
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
				,	title:"운임수단명"
				}
			,	{
					field:"use_yn"
				,	title:"사용여부"
				,	width : 20
				,	widthUnit : "%"	
				}
			]
		,noDataMessage : {
			message : "데이터가 존재하지 않습니다."
		}
		});
	}
</script>				