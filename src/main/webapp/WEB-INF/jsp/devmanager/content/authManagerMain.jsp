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
			<dt>사용자명</dt>
			<dd><input id="authUserName" type="text" style="width:200px;" class="puddSetup" value="" /></dd>
			<dd><input id="searchButton" type="button" class="puddSetup submit" value="검색" /></dd>
		</dl>						
	</div>

	<div class="sub_contents_wrap">

		<div class="btn_div">
			<div class="right_div">
				<input type="button" name="authNew" id="authNew" class="puddSetup" value="추가" />
				<input type="button" name="authRun" id="authRun" class="puddSetup" value="저장" />
				<input type="button" name="authDel" id="authDel" class="puddSetup" value="삭제" />
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
						<p class="tit_p fl">참조품의 권한 부여 목록</p>										
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
									<th rowspan="3">권한 설정</th>
									<th>권한소유자</th>
									<td>
										<input id="auth_user" type="text" pudd-style="width:70%;" class="puddSetup" value="" readonly="readonly"/>
										<input type="button" name="userPop" id="userPop" class="puddSetup" value="검색" onclick="fnUserPop()" />
									</td>
								</tr>
								<tr>
									<th>권한유형</th>
									<td>
										<select class="puddSetup"  id="auth_type" name="auth_type" onchange="fnAuthType(event)">
										<option value="u" selected="selected">사용자</option>
										<option value="d">부서</option>
										<option value="c">회사</option></select>
									</td>
								</tr>
								<tr>
									<th>권한대상</th>
									<td>
										<input id="auth_obj" type="text" pudd-style="width:70%;" class="puddSetup" value="" readonly="readonly"/>
										<input type="button" name="searchPop" id="searchPop" class="puddSetup" value="검색" onclick="fnSearchPop()"/>
									</td>
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
		
		fnGridSetAuthTable();
	});
	
	function fnInitClickEvent(){
	
		//검색 클릭 이벤트
		$('#searchButton').click(function(){
			fnGridSetAuthTable();	
		});
		
		//검색시 엔터 이벤트
		$('#authUserName').keydown(function (key) {		 
	        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
	        	fnGridSetAuthTable();	
	        }
	    });
		
		//추가 
		var puddObj = Pudd( "#authNew" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			$('tr.on').removeClass('on');
			fnAuthNew();
		});
		//저장
		var puddObj = Pudd( "#authRun" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnAuthRun();	 	
		});
		//삭제
		var puddObj = Pudd( "#authDel" ).getPuddObject();
		puddObj.on( "click", function( e ) {
			fnAuthDel();
		});
		
		//그리드 행 클릭이벤트
		Pudd( "#grid" ).on( "gridRowClick", function( e ) {
			
			// e.detail 항목으로 customEvent param 전달됨
			var evntVal = e.detail;
		 
			if( ! evntVal ) return;
			if( ! evntVal.trObj ) return;
		 
			// dataSource에서 전달된 row data
			var rowData = evntVal.trObj.rowData;
		 	
			$('#auth_user').val(rowData.emp_name);
			$('#auth_type').val(rowData.gbn_name);
			$('#auth_obj').val(rowData.seq_name);
			$('#auth_user_seq').val(rowData.emp_seq);
			$('#auth_obj_seq').val(rowData.seq);
			$('#auth_seq').val(rowData.auth_seq);

		
			Pudd( "#auth_type" ).getPuddObject().setSelectedIndex( ''+ rowData.gbn_org );

		});	
	}

	/*	선택된 참조품의 권한 목록 가져오기
	-----------------------------------------*/
	function fnGetSelectedRowData(){
		if( (!$('tr.on').length) || (!$('tr.on').eq(0).find('.hiddenExpenseJson').length) ){
			return {};
		}
		return JSON.parse(unescape( $('tr.on').eq(0).find('.hiddenExpenseJson').val() ));
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
	function fnGridSetAuthTable(){
		var puddGrid = Pudd( "#grid" ).getPuddObject();
		//puddGrid.page( 1 );
		//참조품의 권한 조회 그리드 생성
		var transPortData = new Pudd.Data.DataSource({
			pageSize : 10
			,	request : {
					url : "FuncAuthList.do"
				,	type : 'post'
				,	dataType : "json"
				,	parameterMapping : function( data ) {
						data.searchCode = $('#authUserName').val()||''
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
		,	columns : [ 
				{
					field : "emp_name"
					, title : "권한소유자"
					, width : 150
					, content : {
						template : function( rowData ) {
							var html = '<input type="hidden" class="hiddenExpenseJson" value="' + escape(JSON.stringify(rowData)) + '">' + rowData.emp_name + '</input>';
							return html;  
						}
					}
				}
			,	{
					field:"gbn_name"
					, title:"권한유형"	
					, width : 150					
				}
			,	{
					field:"seq_name"
				,	title:"권한대상"
				
				}
			]
		,noDataMessage : {
			message : "데이터가 존재하지 않습니다."
		}
		});
	}
	
	

	function fnUserPop(){
	    var url = "<c:url value='/gw/systemx/orgChart.do'/>";
	    var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

		$("#callback").val("callbackSel");
		$("#selectMode").val("u");
		$("#selectItem").val("s");	
	    frmPop.target = "cmmOrgPop";
	    frmPop.method = "post";
	    frmPop.action = url.replace("/exp", "");
	    frmPop.submit();
	    frmPop.target = "";
	    pop.focus();
	    return;
	}

	function fnUserPop2(){
	    var url = "<c:url value='/gw/systemx/orgChart.do'/>";
	    var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

		$("#callback").val("callbackSel2");
		$("#selectMode").val("u");
		$("#selectItem").val("s");		
	    frmPop.target = "cmmOrgPop";
	    frmPop.method = "post";
	    frmPop.action = url.replace("/exp", "");
	    frmPop.submit();
	    frmPop.target = "";
	    pop.focus();
	    return;
	}

	function fnAuthType(e){
		// 최사인 경우 선택한 사용자의 회사와 동일
		if( $('#auth_type option:selected').val() == 'c' ){
			$('#searchPop').hide();
			$('#auth_obj').hide();
			
		}else{
			$('#searchPop').show();
			$('#auth_obj').show();		
		}
		
	}

	function fnSearchPop(){
		// 사원, 부서 선택 창을 다르게 표시
		if( $('#auth_type option:selected').val() == 'u' ){
			fnUserPop2();
		}else if( $('#auth_type option:selected').val() == 'd' ){

		    var url = "<c:url value='/gw/systemx/orgChart.do'/>";
			var pop = window.open("", "cmmOrgPop", "width=799,height=769,scrollbars=no");
			$("#callback").val("callbackSel3");
			$("#selectMode").val("d");
			$("#selectItem").val("s");			
			frmPop.target = "cmmOrgPop";
			frmPop.method = "post";
		    frmPop.action = url.replace("/exp", "");
			frmPop.submit();
			pop.focus();		
		}
	}

	function callbackSel(data) {
		if(data.returnObj.length > 0){
	    	$("#auth_user").val(data.returnObj[0].empName);
	   		$("#auth_user_seq").val(data.returnObj[0].empSeq);
	   		$("#auth_user_dept").val(data.returnObj[0].deptSeq);
		}
	}

	function callbackSel2(data) {
		if(data.returnObj.length > 0){
	    	$("#auth_obj").val(data.returnObj[0].empName);
	   		$("#auth_obj_seq").val(data.returnObj[0].empSeq);
		}
	}

	function callbackSel3(data) {
		if(data.returnObj.length > 0){
	    	$("#auth_obj").val(data.returnObj[0].deptName);
	   		$("#auth_obj_seq").val(data.returnObj[0].deptSeq);
		}
	}

	function fnAuthNew() {
		$('#auth_user').val('');
		$('#auth_type').val('');
		$('#auth_obj').val('');
		$('#auth_user_seq').val('');
		$('#auth_user_dept').val('');		
		$('#auth_obj_seq').val('');
		$('#auth_seq').val('');
		Pudd( "#auth_type" ).getPuddObject().setSelectedIndex( 'u' );			
	}	
	
	
	function fnAuthRun() {
		
		if( $("#auth_user").val() == null || $("#auth_user").val() == "" ){
			alert('권한소유자를 선택하여 주세요.');
			return;
		}
		
		if( $('#auth_type option:selected').val() != 'c' ){
			if( $("#auth_obj").val() == null || $("#auth_obj").val() == "" ){
				alert('권한대상을 선택하여 주세요.');
				return;
			}	
		}
		if(confirm("저장하시겠습니까?")){
			var saveUrl = "";
			var data = {};
			data.auth_user_seq = $("#auth_user_seq").val();
			
			data.auth_obj_seq = $("#auth_obj_seq").val();
			data.auth_type = $('#auth_type option:selected').val();
			
			if($('tr.on').length){
				saveUrl = "FuncUserAuthUpdate.do";
				
				data.auth_seq = fnGetSelectedRowData().auth_seq;	
			}else{
				saveUrl = "FuncUserAuth.do";
	
				data.auth_user_dept = $("#auth_user_dept").val();			
			}		
			
		    $.ajax({
		        type:"POST",
		        url: saveUrl,
		        datatype : "application/json",
		        data : data,
		        success : function(result) {
					if(result.isSuccess == 'SUCCESS'){
						alert("저장되엇습니다.");
						fnAuthNew();
						fnGridSetAuthTable();
					}else{
						alert("저장에 실패하였습니다.");						
					}	
		        }
			});	
		}		
	}

	function fnAuthDel() {
		
		if(!fnGetSelectedRowData().auth_seq){
			alert("삭제할 데이터을 선택하십시요.");
			return;
		}
		if(confirm("삭제하시겠습니까")){
			$.ajax({
				type: 'POST',
				url:"FuncDelAuth.do",
				data:{
						"auth_seq":fnGetSelectedRowData().auth_seq
					},
				dataType:'json',
				success: function(result){
					if(result.isSuccess == 'SUCCESS'){
						alert("데이터가 삭제 되었습니다");
						fnAuthNew();
						fnGridSetAuthTable();
					}else{
						alert("삭제에 실패하였습니다.");						
					}				
				}
			});
		}			
	
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

<input class="" type="hidden" value="" id="auth_user_seq" name="auth_user_seq">
<input class="" type="hidden" value="" id="auth_user_dept" name="auth_user_dept">
<input class="" type="hidden" value="" id="auth_obj_seq" name="auth_obj_seq">
<input class="" type="hidden" value="" id="auth_seq" name="auth_seq">
				