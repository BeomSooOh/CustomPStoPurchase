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
			. 미리보기 버튼 / fnFormTest
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
	
	/*	[ 양식구분 ] 양식구분 라디오/ 양식정보 셀렉트 초기화
	------------------------------------------------- */
	function fnCommonFormInitLayout() {
		var formList = ${aaData};
		var consFormList = [];		// 품의서 양식 리스트
		var resFormList = [];		// 결의서 양식 리스트
		for(var i = 0; i < formList.length; i++){
			var item = formList[i];
			if(item.formDTp == 'EXNPCONU' || item.formDTp == 'EXNPCONI' || item.formDTp == 'EXNPCON' || item.formDTp == 'TRIPCONS'){
				consFormList.push(item);
			}else if(item.formDTp == 'EXNPRESU' || item.formDTp == 'EXNPRESI'|| item.formDTp == 'EXNPRES' || item.formDTp == 'TRIPRES'){
				resFormList.push(item);
			}
		}
		
		/* 라디오 박스 이벤트 등록 */
		$('input[name=radi_docGbn]').on('change', function() {
			// 체인지 이벤트
			var targetList = [];
			if($("input[name='radi_docGbn']:checked").val() == '0'){
				targetList = consFormList;
			}else if($("input[name='radi_docGbn']:checked").val() == '1'){
				targetList = resFormList;
			}
			/* 셀렉트 박스 이벤트 등록 */
			$("#list_formList").empty();
			$(targetList).each(function(index, data){
				$("#list_formList")[0].add(new Option(data.formName, data.formSeq));
			});
			/* 양식 상세 검색 진행 */
			fnCommonFormSearch();
		});
		
		/* 셀렉트 박스 이벤트 등록 */
		$(consFormList).each(function(index, data){
			$("#list_formList").empty();
			$("#list_formList")[0].add(new Option(data.formName, data.formSeq));
		});
	}
	
	/*	[ 이벤트 ] 엘리먼트 이벤트 바인드
	------------------------------------------------- */
	function fnCommonFormInitEventInit() {
		
		/* 저장 */
		$("#btn_saveForm").click(function(){
			fnSave(false);
		});
		
		/* 일괄저장 */
		$("#btn_saveFormAll").click(function(){
			fnSave(true);
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
		
		/* 미리보기 */
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
		console.log('erp type : ${erpType}');
		
		var formTp = ''; 
		if($("input[name='radi_docGbn']:checked").val() == '0'){
			if('${erpType}' == 'iCUBE'){
				formTp = 'EXNPCONI'
			}else if('${erpType}' == 'ERPiU'){
				formTp = 'EXNPCONU'
			}
		}else if($("input[name='radi_docGbn']:checked").val() == '1'){
			if('${erpType}' == 'iCUBE'){
				formTp = 'EXNPRESI'
			}else if('${erpType}' == 'ERPiU'){
				formTp = 'EXNPRESU'
			} 
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
					, isNp : 'Y'
					, formTp : formTp
				},
	    		success: function (data) {
	    			console.log('양식리스트 출력');
	    			console.log(data);
	    			
	    			if(data.result.resultCode == 'SUCCESS'){
	    				/* 서버 코드정보 기록 */
						if(serverSamples == null){
							serverCodes = data.result.aData.formCode;	
		    			}
	    				
	    				/* 서버 샘플코드 기록 */
		    			serverSamples = serverSamples || data.result.aData.samples;
		    			
		    			/* 양식데이터 맵객체에 등록 */
		    			// 양식코드 중복 호출 방지 코드 
		    			// 중복 호출을 방지 하려면 주석을 제거하세요.
		    			// formInfoMap.put(formSeq, data.result.aData);
		    			
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
		if(data.formInfo){
			$("#editorView")[0].contentWindow.fnEditorHtmlLoad(data.formInfo);
		}else{
			$("#editorView")[0].contentWindow.fnEditorHtmlLoad('');
		}
		
		/* 샘플 데이터 출력 */
		fnSetSampleDataGrid(serverSamples);
		/* 문서정보 데이터 출력 */
		/* 프로젝트 데이터 출력 */
		/* 예산 데이터 출력 */
		/* 채주 데이터 출력 */
	}
	
	/*	[ 양식 ] 양식정보 저장
	------------------------------------------------- */
	function fnSave(isAllSave){
		if( !fnValidation() ){
			return false;
		}
		
		var param = {};
		param.content =  $("#editorView")[0].contentWindow.fnEditorContents().replace(/'/gi, '');
		param.change_content = fnConvertHtml().replace(/'/gi, '');
		param.formSeq = $("#list_formList").val();
		param.isNp = 'Y';
		param.isAllSave = isAllSave;
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
		
		/* 저장 검증이 필요한 경우 이곳에서.. */
		
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
    					return '<div class="fl ml10"><input type="radio" name="sample_radio" id="radio_'+data.seq+'"/>&nbsp;<label for="radio_'+data.seq+'">'+data.sampleName+'</label></div>';
    				}else {
    					return '<div class="fl ml10"><input type="radio" name="sample_radio" id="radio_'+data.seq+'"/>&nbsp;<label for="radio_'+data.seq+'">'+$('#list_formList option:selected').text()+'</label></div>';
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
		$(htmlDoc).find("td:contains('_projectNum_')").closest('table').addClass("projectTable").removeAttr("width");
		$(htmlDoc).find("td:contains('_budgetNum_')").closest('table').addClass("budgetTable").removeAttr("width");
		$(htmlDoc).find("td:contains('_tradeNum_')").closest('table').addClass("tradeTable").removeAttr("width");
		
		$(htmlDoc).find("td:contains('_projectNum_')").addClass("projectBaseTd");
		$(htmlDoc).find("td:contains('_budgetNum_')").addClass("budgetBaseTd");
		$(htmlDoc).find("td:contains('_tradeNum_')").addClass("tradeBaseTd");
		
		$(htmlDoc).find("td:contains('_projectNum_')").closest('tr').addClass("projectBaseTr");
		$(htmlDoc).find("td:contains('_budgetNum_')").closest('tr').addClass("budgetBaseTr");
		$(htmlDoc).find("td:contains('_tradeNum_')").closest('tr').addClass("tradeBaseTr");
		
		/* 기준 행 지정 */
		for(var i = 1 ; i < ( $(htmlDoc).find(".projectBaseTd").attr('rowspan') || '1' ) ; i++){
			$(htmlDoc).find('.projectBaseTr:last').next('tr').addClass('projectBaseTr');
		}
		for(var i = 1 ; i < ( $(htmlDoc).find(".budgetBaseTd").attr('rowspan') || '1' ) ; i++){
			$(htmlDoc).find('.budgetBaseTr:last').next('tr').addClass('budgetBaseTr');
		}
		for(var i = 1 ; i < ( $(htmlDoc).find(".tradeBaseTd").attr('rowspan') || '1' ) ; i++){
			$(htmlDoc).find('.tradeBaseTr:last').next('tr').addClass('tradeBaseTr');
		}
		
		return htmlDoc.documentElement.outerHTML;

		
		
		/* 아래로 영리 코드 백업 */
		
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
		return htmlDoc.replace(/'/gi, '');;
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
	
	/*	[ 미리보기 ] 양식 테스트 / 미리보기 
	------------------------------------------------- */
	function fnFormTest(){
		
		// console.log(fnConvertHtml())
		$.ajax({
	       	type : "post",
	  		url : '<c:url value="/form/interlock/ExNPDocMakeTest.do"/>',
	  		datatype : "json",
	  		data : {
	  			html : fnConvertHtml()
	  			// TODO : 양식 호출 개발 중... 주석 해제 필요
	  			// , testYN : 'Y' 
	  			, exDocSeq : '5'
	  			, processId : $("input[name='radi_docGbn']:checked").val() == '0' ? 'EXNPCON' : 'EXNPRES'
	  			, formDevideMode : '8' // ???? 양식에 저장하던지 해야 함.
	  		},
	  		success: function (data) {
	  			if(data.result.resultCode == 'SUCCESS'){
	  				console.log('미리보기 데이터');
	  				console.log(data);
	  				
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
					alert('미리보기 양식 생성에 실패하였습니다.');
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

	<p class="tit_p">양식 설정 <span class="fwn">${CL.ex_elecDocComment}  <!--전자결재 본문 내 결의내역 표 양식을 설정합니다.--></span></p>
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_draftType}  <!--양식구분--></dt>
			<dd style="margin-top:18px;">
				<input type="radio" id="radi1" name="radi_docGbn" value="0" checked>
				<label for="radi1">${CL.ex_consDoc}  <!--품의서--></label>
				<input type="radio" id="radi2" name="radi_docGbn" value="1" class="ml10">
				<label for="radi2">${CL.ex_resDoc}  <!--결의서--></label>
			</dd>
			<dt>${CL.ex_formNm}  <!--양식명--></dt>
			<dd>
				<select id="list_formList" class="selectmenu" style="width:200px">
				</select>		
			</dd>
		</dl>
	</div>
	
	<div class="btn_div">
		<div class="left_div">
			<div class="fl">
				<select class="selectmenu" style="width:120px;" id="selDevideStruct">
<!-- 					<option value="0" selected="selected">통합구조 사용</option> -->
					<option value="1" selected="selected">${CL.ex_useDivideCt}  <!--분할구조 사용--></option>
				</select>
			</div>
<!-- 			<p class="fl mt5 ml20">결의정보, 예산내역, 결제내역을 하나의 표로 통합하여 보여주는 구조입니다.</p> -->
		</div>
		<div class="right_btn">
			<div class="controll_btn p0">
				<button id="btn_testForm">${CL.ex_lookAhead}  <!--미리보기--></button>
				<button id="btn_removeForm">${CL.ex_reset}  <!--초기화--></button>
				<button id="btn_saveForm">${CL.ex_approval2}  <!--적용--></button>
				<button id="btn_saveFormAll">${CL.ex_allApproval}  <!--일괄적용--></button>
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
								<input type="text" autocomplete="off" id="form_nm" name="form_nm" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>양식명(<%=BizboxAMessage.getMessage("TX000002790","영어")%>)</th>
								<td>
								<input type="text" autocomplete="off" id="form_nm_en" name="form_nm_en" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>양식명(<%=BizboxAMessage.getMessage("TX000002789","중국어")%>)</th>
								<td>
								<input type="text" autocomplete="off" id="form_nm_cn" name="form_nm_cn" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>양식명(<%=BizboxAMessage.getMessage("TX000002788","일본어")%>)</th>
								<td>
								<input type="text" autocomplete="off" id="form_nm_jp" name="form_nm_jp" value="" readonly="readonly" style="width: 100%"/>
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
								<li id="sample" class="on"><a href="javascript:tab_nor_Fn(1);">${CL.ex_sample}  <!--샘플--></a></li>
								<li id="doc"><a href="javascript:tab_nor_Fn(2, 'doc')">${CL.ex_docinfo}  <!--문서정보--></a></li>
								<li id="project"><a href="javascript:tab_nor_Fn(3, 'project')">${CL.ex_project}  <!--프로젝트--></a></li>
								<li id="budget"><a href="javascript:tab_nor_Fn(4, 'budget')">${CL.ex_budget}  <!--예산--></a></li>
								<li id="trade"><a href="javascript:tab_nor_Fn(5, 'trade')">${CL.ex_creditor}  <!--채주--></a></li>
								<li id="foot"><a href="javascript:tab_nor_Fn(6, 'foot')">${CL.ex_totalAmt}  <!--합계--></a></li>
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
									<table id="doc_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
							
							<!-- 프로젝트 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab3" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="project_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
							
							<!-- 예산 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab4" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="budget_table">
										<colgroup>
											<col width="50%"/>
											<col width="50%"/>
										</colgroup>
									</table>
								</div>
							</div>
							
							<!-- 채주 탭 --------------------------------------------------------------------------------------------------------------------->
							<div class="tab5" style="display:none;">
								<div class="com_ta2 bg_lightgray">
									<table id="trade_table">
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