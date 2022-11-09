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

<!-- javascript - src -->
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExOption.js?ver=20190729"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>

<script>
	/* [Map] declare javascipt hashmap prototype
	======================================== */
	Map = function () {
		this.map = new Object();
	};
	Map.prototype = {
		put: function (key, value) {
			this.map[key] = value;
		},
		get: function (key) {
			return this.map[key];
		},
		containsKey: function (key) {
			return key in this.map;
		},
		containsValue: function (value) {
			for (var prop in this.map) {
				if (this.map[prop] == value) return true;
			}
			return false;
		},
		isEmpty: function (key) {
			return (this.size() == 0);
		},
		clear: function () {
			for (var prop in this.map) {
				delete this.map[prop];
			}
		},
		remove: function (key) {
			delete this.map[key];
		},
		keys: function () {
			var keys = new Array();
			for (var prop in this.map) {
				keys.push(prop);
			}
			return keys;
		},
		values: function () {
			var values = new Array();
			for (var prop in this.map) {
				values.push(this.map[prop]);
			}
			return values;
		},
		size: function () {
			var count = 0;
			for (var prop in this.map) {
				count++;
			}
			return count;
		}
	};		
</script>

<script>
	/* 양식정보 저장을위한 맵 객체 */
	var formInfoMap = new Map();
	/* 서버에서 조회된 코드 정보 */
	var serverCodes = null;
	/* 서버에서 조회된 샘플 정보 */
	var serverSamples = null;
	
	/*	[ 양식설정 ] 양식설정 문서 준비
	------------------------------------------------- */
	$(document).ready(function(){
		/* 
			레이아웃 초기화
			. 서버로부터 받아온 양식리스트 셀렉트 반영
		*/
		fnCommonFormInitLayout();
		
		/* 
			이벤트 바인드 
			. 저장 이벤트 바인드 / fnSave
			. 신규 버튼 / fnRemoveForm
			. 양식 검색 / fnCommonFormSearch
			. 테스트 버튼 / fnFormTest
			. 양식 체인지 / fnCommonFormSearch
		*/
		fnCommonFormInitEventInit();
	});
	
	/*	[ 에디터 ] 더존 에디터 로딩 완료
		 이 페이지는 더존에디터 로딩후에 메인 로직을 진행합니다.
	------------------------------------------------- */
	function fnEditorLoadCallback(){
		fnCommonFormSearch();
	}
	
	/*	[ 셀렉트 ] 양식정보 초기화
	------------------------------------------------- */
	function fnCommonFormInitLayout() {
		var formList = ${aaData};
		$(formList).each(function(index, data){
			$("#list_formList")[0].add(new Option(data.formNm, data.formSeq));
		});
	}
	
	/*	[ 이벤트 ] 엘리먼트 이벤트 바인드
	------------------------------------------------- */
	function fnCommonFormInitEventInit() {
		
		/* 저장 */
		$("#btn_saveForm").click(function(){
			fnSave();
		});
		
		/* 신규 */
		$("#btn_removeForm").click(function(){
			if(confirm('정말 초기화 할까요?')){
				$("#editorView")[0].contentWindow.fnEditorHtmlLoad("");
			}
		});
		
		/* 검색 */
		$("#btnSearch").click(function(){
			fnCommonFormSearch();
		});
		
		/* 테스트 */
		 $("#btn_testForm").click(function(){
			fnFormTest();
		});
		
		/* 양식리스트 */
		$('#list_formList').change(function(){
			fnCommonFormSearch();
		});
		return;
	}
	
	/*	[ 양식 ] 선택된 양식 이력 검사후 조회
	------------------------------------------------- */
	function fnCommonFormSearch(){
		var formSeq = $("#list_formList").val();
		if(!formSeq){
			alert('양식 리스트 조회에 실패하였습니다.');
			return;
		}
		formInfoMap.containsKey(formSeq) ?
			fnChangeView(formInfoMap.get(formSeq)) : 
			( $.ajax({
	        	type:"post",
	    		url:'<c:url value="/common/form/CommonFormDataInfo.do"/>',
	    		datatype:"json",
				data: {
					formSeq : formSeq || 0
					, needSample : (serverSamples == null) ? 'Y' : 'N' 
				},
	    		success: function (data) {
	    			if(data.result.resultCode == 'SUCCESS'){
	    				/* 서버 코드정보 기록 */
						if(serverSamples == null){
							serverCodes = data.result.aData.formCode;	
		    			}
	    				
	    				/* 서버 샘플코드 기록 */
		    			serverSamples = serverSamples || data.result.aData.samples;
		    			
		    			/* 양식데이터 맵객체에 등록 */
		    			
		    			formInfoMap.put(formSeq, data.result.aData);
		    			
		    			/* 뷰 정보 변경 */
		    			fnChangeView(data.result.aData);
	    			}else {
	    				console.log(data.result.resultCode);
						console.log(data.result.resultName);
	    				alert('데이터 조회도중 에러가 발생하였습니다.');
	    			}
	   		    },
			    error: function (result) { 
	    			alert("<%=BizboxAMessage.getMessage("TX000017937","검색에 실패하였습니다.")%>");
	    		}
	    	}) );
	}

	/*	[ 양식 ] 양식 선택에 따른 화면 정보 변경
	------------------------------------------------- */
	function fnChangeView(data){
		
		/* 양식정보 출력 */
		$('#form_nm').val(data.formInfo.formNm);
		$('#form_nm_en').val(data.formInfo.formNmEn);
		$('#form_nm_jp').val(data.formInfo.formNmJp);
		$('#form_nm_cn').val(data.formInfo.formNmCn);
		$("#use_yn").val(data.formInfo.useYN);
		
		/* HTML코드 파싱 */
		if(data.form){
			$("#editorView")[0].contentWindow.fnEditorHtmlLoad(data.form.formContent);
		}else{
			$("#editorView")[0].contentWindow.fnEditorHtmlLoad('');
		}
		
		/* 샘플 데이터 출력 */
		fnSetSampleDataGrid(serverSamples);
	}
	
	/*	[ 양식 ] 양식정보 저장
	------------------------------------------------- */
	function fnSave(){
		if( !fnValidation() ){
			return false;
		}

		var param = {};
		param.content =  $("#editorView")[0].contentWindow.fnEditorContents().replace(/'/gi, '');
		param.change_content = fnConvertHtml().replace(/'/gi, '');
		param.formSeq = $("#list_formList").val();
		
		$.ajax({
        	type:"post",
    		url:'<c:url value="/common/form/CommonFormSave.do"/>',
    		datatype:"json",
			data: param,
    		success: function (data) {
    			if(data.result > 0){
    				alert("<%=BizboxAMessage.getMessage("TX000002598","저장하였습니다")%>");
    			}else{
    				alert("<%=BizboxAMessage.getMessage("TX000002596","저장에 실패하였습니다")%>");	
    			}
   		    },
		    error: function (result) { 
		    	alert("<%=BizboxAMessage.getMessage("TX000009591","데이터 저장 중 오류가 발생하였습니다")%>");
    		}
    	});
	}
	
	/*	[ 저장 ] 작성된 양식 무결 검증
	------------------------------------------------- */
	function fnValidation(){
		var strHtml = $("#editorView")[0].contentWindow.fnEditorContents();
		var parser = new DOMParser();
		var htmlDoc = parser.parseFromString(strHtml, "text/html");
		var sampleNo = $('input:radio[name=sample_radio]:checked').val();
		
		/* 저장 검증이 필요한 경우 이곳에서.. */
		if( ($(htmlDoc).find("table").length > 1) && 
			(sampleNo != "4") ){ // 기본양식+차변소계 일때는 제외
			alert("하나의 테이블만 생성해주세요.");
			return false;
		}
		return true;
	}
	
	/*	[ 양식 ] 샘플코드 리스트 출력
	------------------------------------------------- */
	function fnSetSampleDataGrid(data){
		$('#sample_table').DataTable({
			"aaSorting": [],
            "select" : true,
            "paging" : false,
            "bAutoWidth" : false,
            "destroy" : true,
            "paging" : false, 
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            	$(nRow).find("input[type=radio]").click(function(){
            		$("#editorView")[0].contentWindow.fnEditorHtmlLoad(aData.sampleContent);
            	});
            },
            "fnDrawCallback": function ( oSettings ) {
                $(oSettings.nTHead).hide();
            },
            columnDefs : [ {
    			"targets" : 0,
    			"data" : null,
    			"render"  : function(data) {
    				if(data.seq != -1){
    					return '<div class="fl ml10"><input type="radio" name="sample_radio" id="radio_'+data.seq+'" value="'+data.seq+'"/>&nbsp;<label for="radio_'+data.seq+'">'+data.sampleName+'</label></div>';
    				}else {
    					return '<div class="fl ml10"><input type="radio" name="sample_radio" id="radio_'+data.seq+'" value="'+data.seq+'"/>&nbsp;<label for="radio_'+data.seq+'">'+$('#list_formList option:selected').text()+'</label></div>';
    				}
    			}
    		} ], 
            aoColumns : [ {
           		"sTitle" : "샘플명",
       			"bVisible" : true,
       			"bSortable" : false,
       			"sWidth" : ""
       		} ]
        });
	}
	

	
	/*	[ 에디터 ] HTML정보 컨버트
	------------------------------------------------- */
	/* 상배 : 뜯어 고치는 중... */
	function fnConvertHtml(){
		
		var strHtml = $("#editorView")[0].contentWindow.fnEditorContents();
		var parser = new DOMParser();
		var htmlDoc = parser.parseFromString(strHtml, "text/html");
		
		$(htmlDoc).find("td").removeClass();
		$(htmlDoc).find("td:contains('_listNum_')").addClass("listNum");
		$(htmlDoc).find("td:contains('_slipNum_')").addClass("slipNum");
		$(htmlDoc).find("td:contains('_slipDrNum_')").addClass("slipDrNum").addClass("slipNum");
		$(htmlDoc).find("td:contains('_slipCrNum_')").addClass("slipCrNum").addClass("slipNum");
		$(htmlDoc).find("td:contains('_mngNum_')").addClass("mngNum");
		$(htmlDoc).find("td:contains('_subtotalListNum_')").addClass("subtotalListNum");
		
		return htmlDoc.documentElement.outerHTML;
		
		var strHtml = $("#editorView")[0].contentWindow.fnEditorContents();
		var parser = new DOMParser();
		var htmlDoc = parser.parseFromString(strHtml, "text/html");
		
		$(htmlDoc).find("table").addClass("main");
		
		/* 항목 별 행 개수( 예 : 항목 하나에 2줄 ) */
		var listRow = $(htmlDoc).find("td:contains('_listNum_')").prop("rowSpan") || 0;
		/* 분개 별 행 개수( 예 : 분개 하나에 2줄 ) */
		var slipRow = $(htmlDoc).find("td:contains('_slipNum_')").prop("rowSpan") || 0;
		/* 관리항목 별 행 개수( 예 : 관리항목 하나에 2줄 ) */
		var mngRow = $(htmlDoc).find("td:contains('_mngNum_')").prop("rowSpan") || 0;
		var listTempRow = listRow;
		var slipTempRow = slipRow;
		var mngTempRow = mngRow;
		/* 항목 첫번째 열 인덱스 */
		var listTdInx = $(htmlDoc).find("td:contains('_listNum_')").index();
		/* 분개 첫번째 열 인덱스 */
		var slipTdInx = $(htmlDoc).find("td:contains('_slipNum_')").index();
		/* 관리항목 첫번째 열 인덱스 */
		var mngTdInx = $(htmlDoc).find("td:contains('_mngNum_')").index();
		/* 항목 첫번째 행 인덱스 */
		var listInx = $(htmlDoc).find("tr:contains('_listNum_')").index();
		/* 분개 첫번째 행 인덱스 */
		var slipInx = $(htmlDoc).find("tr:contains('_slipNum_')").index();
		/* 관리항목 첫번째 행 인덱스 */
		var mngInx = $(htmlDoc).find("tr:contains('_mngNum_')").index();	
		var slipAppendInx = slipInx;
		var listAppendInx = listInx;
		var mngAppendInx = mngInx;
		
		$(htmlDoc).find("td:contains('_listNum_')").addClass("listNum");
		$(htmlDoc).find("td:contains('_slipNum_')").addClass("slipNum");
		$(htmlDoc).find("td:contains('_mngNum_')").addClass("mngNum");
		
		/* list > slip > mng */
		if( ( slipInx > 0 && slipInx > listInx && slipInx < (listRow+listInx) ) || ( slipInx == listInx && listTdInx < slipTdInx ) ){
			if( (mngInx > 0 && mngInx > slipInx && mngInx < (slipRow+mngInx)) || ( mngInx == slipInx && slipTdInx < mngTdInx ) ){
				slipTempRow = slipRow - mngRow;
				listTempRow = listRow - mngRow;
				mngAppendInx = mngInx - slipInx;
				$(htmlDoc).find("td:contains('_slipNum_')").prop("rowSpan", slipTempRow);
			}
			listTempRow = listRow - slipRow;
			slipAppendInx = slipInx - listInx;
			$(htmlDoc).find("td:contains('_listNum_')").prop("rowSpan", listTempRow);
		}
		
		if(slipAppendInx == 0){ slipAppendInx = 1; }
		if(listAppendInx == 0){ listAppendInx = 1; }
		if(mngAppendInx == 0){ mngAppendInx = 1; }
		
		var slipTr = "";
		var listTr = "";
		var mngTr = "";
		
		/* 변환 */
		if( ( slipInx > 0 && slipInx > listInx && slipInx < (listRow+listInx) ) || ( slipInx == listInx && listTdInx < slipTdInx ) || (listInx < slipInx) ){
			if( (mngInx > 0 && mngInx > slipInx && mngInx < (slipRow+mngInx)) || ( mngInx == slipInx && slipTdInx < mngTdInx ) ){
				var mngParam = fnGetTableData(htmlDoc, mngInx, mngTempRow, "mng");
				mngTr = mngParam.tr;
				htmlDoc = mngParam.htmlDoc;
			}
			
			var slipParam = fnGetTableData(htmlDoc, slipInx, slipTempRow, "slip");
			slipTr = slipParam.tr;
			htmlDoc = slipParam.htmlDoc;
			
			var listParam = fnGetTableData(htmlDoc, listInx, listTempRow, "list");
			listTr = listParam.tr;
			htmlDoc = listParam.htmlDoc;
		}
		
		if(listInx > 0 && slipInx < 0 ){	// list만 존재
			var listParam = fnGetTableData(htmlDoc, listInx, listTempRow, "list");
			listTr = listParam.tr;
			htmlDoc = listParam.htmlDoc;
			$(htmlDoc).find("tr:nth-child(" + listAppendInx +")").after(listTr);
		}else if(slipInx > 0 && listInx < 0){	// slip만 존재
			var slipParam = fnGetTableData(htmlDoc, slipInx, slipTempRow, "slip");
			slipTr = slipParam.tr;
			htmlDoc = slipParam.htmlDoc;
			$(htmlDoc).find("tr:nth-child(" + slipAppendInx +")").after(slipTr);
		}else if(mngInx > 0 && listInx < 0 && slipInx < 0){	// mng만 존재
			var mngParam = fnGetTableData(htmlDoc, mngInx, mngTempRow, "mng");
			mngTr = mngParam.tr;
			htmlDoc = mngParam.htmlDoc;
			$(htmlDoc).find("tr:nth-child(" + mngAppendInx +")").after(mngTr);
		}else{
			/* list > slip > mng */
			if( ( slipInx > 0 && slipInx > listInx && slipInx < (listRow+listInx) ) || ( slipInx == listInx && listTdInx < slipTdInx ) ){	// list > slip
				if( (mngInx > 0 && mngInx > slipInx && mngInx < (slipRow+mngInx)) || ( mngInx == slipInx && slipTdInx < mngTdInx ) ){	// slip > mng
					if(mngInx - slipInx == 0){
						$(slipTr).find("slip tr:nth-child(" + mngAppendInx +")").before(mngTr);
					}else{
						$(slipTr).find("slip tr:nth-child(" + mngAppendInx +")").after(mngTr);
					}
				}
			
				if(slipInx - listInx == 0){
					$(listTr).find("list tr:nth-child(" + slipAppendInx +")").before(slipTr);
				}else{
					$(listTr).find("list tr:nth-child(" + slipAppendInx +")").after(slipTr);
				}
				
				$(htmlDoc).find("tr:nth-child(" + listAppendInx +")").after(listTr);
			}
		}
		return htmlDoc;
	}
	
	/*	[ 에디터 ] 테이블 정보 조회
	------------------------------------------------- */	
	function fnGetTableData(htmlDoc, elementInx, elementRow, type){
		var tr = document.createElement("tr");
		var td = document.createElement("td");
		var type = document.createElement(type)
		var table = document.createElement("table");
		var html = "";
		
		$(htmlDoc).find("tr:nth-child(n+"+(elementInx+1)+") ").each(function(index){
			if(elementRow <= index){
				$(table).append(html);
				$(type).append(table);
				$(td).append(type);
				$(tr).append(td);
				return false;
			}
			html += this.outerHTML;
			$(this).remove();
		});
		return {
			'tr' : tr,
			'htmlDoc' : htmlDoc
		};
	}
	
	/*	[ 에디터 ] HTML코드 인서트
	------------------------------------------------- */
	function clickToInsertHtml(contentValue){
		/* 상배 : 매핑정보만 기록하고 있으면 꼴뵈기 싫은 코드 안봐도 됨. */
		// contentValue = '<class="content" style="color:tomato;">테스트다 이얍'
	   	$("#editorView")[0].contentWindow.fnInsertHtml(contentValue);
	}
	
	/*	[ 아이템 컨트롤 ] 탭 정보 스위칭 액션 
	------------------------------------------------- */
	var filterGbn = '';
	function tab_nor_Fn(num , gbn){
		$(".tab"+num).show();
		$(".tab"+num).siblings().hide();
		
		var inx = num -1;

		$(".tab_nor li").eq(inx).addClass("on");
		$(".tab_nor li").eq(inx).siblings().removeClass("on");
		
		if(gbn != null && gbn != 'undefined' && gbn != ''){
			filterGbn = gbn;
			fnSetCodeDataGrid(serverCodes.filter(fnGetFilteredCodeList), gbn);
		}
	}
	
	/*	[ 아이템 컨트롤 ] 탭 정보 필터링
	------------------------------------------------- */	
	function fnGetFilteredCodeList(data){
		return data.codeGbn == filterGbn;
	}
	
	/*	[ 아이템 컨트롤 ] 탭 디스플레이 출력
	------------------------------------------------- */
	function fnSetCodeDataGrid(data, id){
		var id = '#'+id+'_table';
		$(id).DataTable({
			"aaSorting": [],
            "select" : true,
            "paging" : false,
            "bAutoWidth" : false,
            "destroy" : true,
            "paging" : false, 
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            	$(nRow).css("cursor", "pointer");
            	$(nRow).find("td:eq(1)").click(function(){
            		clickToInsertHtml( aData.code );           		
            	});
            },
            "fnDrawCallback": function ( oSettings ) {
                $(oSettings.nTHead).hide();
            },
            columnDefs : [ {
    			"targets" : 0,
    			"data" : null,
    			"render"  : function(data) {
    				if(data.requried_yn == 'Y'){
    					return '<img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt="" />' + data.codeName;
    				}else{
						return data.codeName;
    				}
				}
           	}, {
           		"targets" : 1,
    			"data" : null,
    			"render"  : function(data) {
    				return data.code;
    			}
    		}], 
            aoColumns : [ {
           		"sTitle" : "코드명",
       			"bVisible" : true,
       			"bSortable" : false,
       			"sWidth" : ""
       		}, {
           		"sTitle" : "코드",
       			"bVisible" : true,
       			"bSortable" : false,
       			"sWidth" : ""
       		} ]
        });
	}
	
	/*	[ 테스트 ] 양식 테스트 / 미리보기 
	------------------------------------------------- */
	function fnFormTest(){
		
		// console.log(fnConvertHtml())
		$.ajax({
	       	type : "post",
	  		url : '<c:url value="/form/interlock/ExDocMakeTest.do"/>',
	  		datatype : "json",
	  		data : {
	  			html : fnConvertHtml()
	  			, testYN : 'Y'
	  		},
	  		success: function (data) {
	  			if(data.result.resultCode == 'SUCCESS'){
	  				var popup = window.open("/common/form/FormTestPop.do", "이름" , "width=980, height=500 , scrollbars=yes");
	  				if(popup){
		  				popup.document.write(data.result.aData.html);
	  				}else{
	  					alert('팝업 차단설정을 확인해주세요.');
	  				}
	  			} else if(data.result.resultCode == 'VALIDATION'){
	  				alert(data.result.resultName);
	  			}
	  			else{
	  				console.log(data.result.resultCode);
					console.log(data.result.resultName);
					alert('테스트 양식 생성에 실패하였습니다.');
	  			}
	 		},
	    	error: function (result) {
	    		console.log('# !! error . ');
	    		console.log(result);
	  		}
	  	});
	}
</script>

<!-- 컨텐츠내용영역 -->
<div class="sub_contents_wrap">
	<div class="top_box">
		<dl>
			<dt>양식구분</dt>
			<dd>
				<select id="list_formList" style=" margin-right:5px; float:left;">
			</dd>
			<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" /></dd>
		</dl>
	</div>
	
	<div class="btn_div m0 cl">
		<div class="right_div">
			<!-- 컨트롤버튼영역 -->
			<div id="" class="controll_btn">
				<!-- <button id="btnAdd">테스트저장</button> -->
				<button id="btn_testForm">테스트</button> 
				<button id="btn_removeForm">신규</button>
				<button id="btn_saveForm">저장</button>
			</div>
		</div>
	</div>
<div class="twinbox">
		<table> 
			<colgroup>
				<col width="35%"/>
				<col />
			</colgroup>
			<tr>
				<td class="twinbox_td">
					<div class="com_ta mb20" style="display:none;">
						<table>
							<colgroup>
								<col width="40%"/>
								<col />
							</colgroup>
							<tr>
								<th>양식명(<%=BizboxAMessage.getMessage("TX000002787","한국어")%>)</th>
								<td>
								<input type="text" id="form_nm" name="form_nm" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>양식명(<%=BizboxAMessage.getMessage("TX000002790","영어")%>)</th>
								<td>
								<input type="text" id="form_nm_en" name="form_nm_en" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>양식명(<%=BizboxAMessage.getMessage("TX000002789","중국어")%>)</th>
								<td>
								<input type="text" id="form_nm_cn" name="form_nm_cn" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>양식명(<%=BizboxAMessage.getMessage("TX000002788","일본어")%>)</th>
								<td>
								<input type="text" id="form_nm_jp" name="form_nm_jp" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th><%=BizboxAMessage.getMessage("TX000000274","사용유무")%></th>
								<td>
									<select id="use_yn" name="use_yn" disabled="disabled">
									<option value="Y"><%=BizboxAMessage.getMessage("TX000000180","사용")%></option>
									<option value="N"><%=BizboxAMessage.getMessage("TX000001243","미사용")%></option>
									</select>
								</td>
							</tr>
						</table>
					</div>
					<div class="com_ta">
						<div class="tab_nor">
							<ul>
								<li id="sample" class="on"><a href="javascript:tab_nor_Fn(1);">샘플</a></li>
								<li id="head"><a href="javascript:tab_nor_Fn(2, 'head')">헤더</a></li>
								<li id="list"><a href="javascript:tab_nor_Fn(3, 'list')">항목</a></li>
								<li id="slip"><a href="javascript:tab_nor_Fn(4, 'slip')">분개</a></li>
								<li id="mng"><a href="javascript:tab_nor_Fn(5, 'mng')">관리항목</a></li>
								<li id="foot"><a href="javascript:tab_nor_Fn(6, 'foot')">합계</a></li>
							</ul>
						</div>
					
						<div class="tab_area" style="height:500px;overflow:auto;border-right:1px;">
							<!-- 샘플 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab1">
								<div class="com_ta2 bg_lightgray">
									<table id="sample_table">
									</table>
								</div>
							</div>
							
							<!-- 헤더 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab2" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="head_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
							
							<!-- 항목 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab3" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="list_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
							
							<!-- 분개 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab4" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="slip_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
							
							<!-- 관리항목 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab5" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="mng_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
							
							<!-- footer 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab6" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="foot_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
						</div>
					</div>
				</td>
				<td rowspan="1" class="twinbox_td">
					<iframe id="editorView" src="/gw/editorView.do?groupSeq=${groupSeq}" style="min-width:100%;height: 700px;"></iframe>
				</td>
			</tr>
		</table>
	</div>
</div>