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
	/* ???????????? ??????????????? ??? ?????? */
	var formInfoMap = new Map();
	/* ???????????? ????????? ?????? ?????? */
	var serverCodes = null;
	/* ???????????? ????????? ?????? ?????? */
	var serverSamples = null;
	
	/*	[ ???????????? ] ???????????? ?????? ??????
	------------------------------------------------- */
	$(document).ready(function(){
		/* 
			???????????? ?????????
			. ??????????????? ????????? ??????????????? ????????? ??????
		*/
		fnCommonFormInitLayout();
		
		/* 
			????????? ????????? 
			. ?????? ????????? ????????? / fnSave
			. ?????? ?????? / fnRemoveForm
			. ?????? ?????? / fnCommonFormSearch
			. ????????? ?????? / fnFormTest
			. ?????? ????????? / fnCommonFormSearch
		*/
		fnCommonFormInitEventInit();
	});
	
	/*	[ ????????? ] ?????? ????????? ?????? ??????
		 ??? ???????????? ??????????????? ???????????? ?????? ????????? ???????????????.
	------------------------------------------------- */
	function fnEditorLoadCallback(){
		fnCommonFormSearch();
	}
	
	/*	[ ????????? ] ???????????? ?????????
	------------------------------------------------- */
	function fnCommonFormInitLayout() {
		var formList = ${aaData};
		$(formList).each(function(index, data){
			$("#list_formList")[0].add(new Option(data.formNm, data.formSeq));
		});
	}
	
	/*	[ ????????? ] ???????????? ????????? ?????????
	------------------------------------------------- */
	function fnCommonFormInitEventInit() {
		
		/* ?????? */
		$("#btn_saveForm").click(function(){
			fnSave();
		});
		
		/* ?????? */
		$("#btn_removeForm").click(function(){
			if(confirm('?????? ????????? ??????????')){
				$("#editorView")[0].contentWindow.fnEditorHtmlLoad("");
			}
		});
		
		/* ?????? */
		$("#btnSearch").click(function(){
			fnCommonFormSearch();
		});
		
		/* ????????? */
		 $("#btn_testForm").click(function(){
			fnFormTest();
		});
		
		/* ??????????????? */
		$('#list_formList').change(function(){
			fnCommonFormSearch();
		});
		return;
	}
	
	/*	[ ?????? ] ????????? ?????? ?????? ????????? ??????
	------------------------------------------------- */
	function fnCommonFormSearch(){
		var formSeq = $("#list_formList").val();
		if(!formSeq){
			alert('?????? ????????? ????????? ?????????????????????.');
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
	    				/* ?????? ???????????? ?????? */
						if(serverSamples == null){
							serverCodes = data.result.aData.formCode;	
		    			}
	    				
	    				/* ?????? ???????????? ?????? */
		    			serverSamples = serverSamples || data.result.aData.samples;
		    			
		    			/* ??????????????? ???????????? ?????? */
		    			
		    			formInfoMap.put(formSeq, data.result.aData);
		    			
		    			/* ??? ?????? ?????? */
		    			fnChangeView(data.result.aData);
	    			}else {
	    				console.log(data.result.resultCode);
						console.log(data.result.resultName);
	    				alert('????????? ???????????? ????????? ?????????????????????.');
	    			}
	   		    },
			    error: function (result) { 
	    			alert("<%=BizboxAMessage.getMessage("TX000017937","????????? ?????????????????????.")%>");
	    		}
	    	}) );
	}

	/*	[ ?????? ] ?????? ????????? ?????? ?????? ?????? ??????
	------------------------------------------------- */
	function fnChangeView(data){
		
		/* ???????????? ?????? */
		$('#form_nm').val(data.formInfo.formNm);
		$('#form_nm_en').val(data.formInfo.formNmEn);
		$('#form_nm_jp').val(data.formInfo.formNmJp);
		$('#form_nm_cn').val(data.formInfo.formNmCn);
		$("#use_yn").val(data.formInfo.useYN);
		
		/* HTML?????? ?????? */
		if(data.form){
			$("#editorView")[0].contentWindow.fnEditorHtmlLoad(data.form.formContent);
		}else{
			$("#editorView")[0].contentWindow.fnEditorHtmlLoad('');
		}
		
		/* ?????? ????????? ?????? */
		fnSetSampleDataGrid(serverSamples);
	}
	
	/*	[ ?????? ] ???????????? ??????
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
    				alert("<%=BizboxAMessage.getMessage("TX000002598","?????????????????????")%>");
    			}else{
    				alert("<%=BizboxAMessage.getMessage("TX000002596","????????? ?????????????????????")%>");	
    			}
   		    },
		    error: function (result) { 
		    	alert("<%=BizboxAMessage.getMessage("TX000009591","????????? ?????? ??? ????????? ?????????????????????")%>");
    		}
    	});
	}
	
	/*	[ ?????? ] ????????? ?????? ?????? ??????
	------------------------------------------------- */
	function fnValidation(){
		var strHtml = $("#editorView")[0].contentWindow.fnEditorContents();
		var parser = new DOMParser();
		var htmlDoc = parser.parseFromString(strHtml, "text/html");
		var sampleNo = $('input:radio[name=sample_radio]:checked').val();
		
		/* ?????? ????????? ????????? ?????? ????????????.. */
		if( ($(htmlDoc).find("table").length > 1) && 
			(sampleNo != "4") ){ // ????????????+???????????? ????????? ??????
			alert("????????? ???????????? ??????????????????.");
			return false;
		}
		return true;
	}
	
	/*	[ ?????? ] ???????????? ????????? ??????
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
                "lengthMenu" : "?????? _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "infoFiltered" : "(?????? _MAX_ ???.)"
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
           		"sTitle" : "?????????",
       			"bVisible" : true,
       			"bSortable" : false,
       			"sWidth" : ""
       		} ]
        });
	}
	

	
	/*	[ ????????? ] HTML?????? ?????????
	------------------------------------------------- */
	/* ?????? : ?????? ????????? ???... */
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
		
		/* ?????? ??? ??? ??????( ??? : ?????? ????????? 2??? ) */
		var listRow = $(htmlDoc).find("td:contains('_listNum_')").prop("rowSpan") || 0;
		/* ?????? ??? ??? ??????( ??? : ?????? ????????? 2??? ) */
		var slipRow = $(htmlDoc).find("td:contains('_slipNum_')").prop("rowSpan") || 0;
		/* ???????????? ??? ??? ??????( ??? : ???????????? ????????? 2??? ) */
		var mngRow = $(htmlDoc).find("td:contains('_mngNum_')").prop("rowSpan") || 0;
		var listTempRow = listRow;
		var slipTempRow = slipRow;
		var mngTempRow = mngRow;
		/* ?????? ????????? ??? ????????? */
		var listTdInx = $(htmlDoc).find("td:contains('_listNum_')").index();
		/* ?????? ????????? ??? ????????? */
		var slipTdInx = $(htmlDoc).find("td:contains('_slipNum_')").index();
		/* ???????????? ????????? ??? ????????? */
		var mngTdInx = $(htmlDoc).find("td:contains('_mngNum_')").index();
		/* ?????? ????????? ??? ????????? */
		var listInx = $(htmlDoc).find("tr:contains('_listNum_')").index();
		/* ?????? ????????? ??? ????????? */
		var slipInx = $(htmlDoc).find("tr:contains('_slipNum_')").index();
		/* ???????????? ????????? ??? ????????? */
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
		
		/* ?????? */
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
		
		if(listInx > 0 && slipInx < 0 ){	// list??? ??????
			var listParam = fnGetTableData(htmlDoc, listInx, listTempRow, "list");
			listTr = listParam.tr;
			htmlDoc = listParam.htmlDoc;
			$(htmlDoc).find("tr:nth-child(" + listAppendInx +")").after(listTr);
		}else if(slipInx > 0 && listInx < 0){	// slip??? ??????
			var slipParam = fnGetTableData(htmlDoc, slipInx, slipTempRow, "slip");
			slipTr = slipParam.tr;
			htmlDoc = slipParam.htmlDoc;
			$(htmlDoc).find("tr:nth-child(" + slipAppendInx +")").after(slipTr);
		}else if(mngInx > 0 && listInx < 0 && slipInx < 0){	// mng??? ??????
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
	
	/*	[ ????????? ] ????????? ?????? ??????
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
	
	/*	[ ????????? ] HTML?????? ?????????
	------------------------------------------------- */
	function clickToInsertHtml(contentValue){
		/* ?????? : ??????????????? ???????????? ????????? ????????? ?????? ?????? ????????? ???. */
		// contentValue = '<class="content" style="color:tomato;">???????????? ??????'
	   	$("#editorView")[0].contentWindow.fnInsertHtml(contentValue);
	}
	
	/*	[ ????????? ????????? ] ??? ?????? ????????? ?????? 
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
	
	/*	[ ????????? ????????? ] ??? ?????? ?????????
	------------------------------------------------- */	
	function fnGetFilteredCodeList(data){
		return data.codeGbn == filterGbn;
	}
	
	/*	[ ????????? ????????? ] ??? ??????????????? ??????
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
                "lengthMenu" : "?????? _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "infoFiltered" : "(?????? _MAX_ ???.)"
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
           		"sTitle" : "?????????",
       			"bVisible" : true,
       			"bSortable" : false,
       			"sWidth" : ""
       		}, {
           		"sTitle" : "??????",
       			"bVisible" : true,
       			"bSortable" : false,
       			"sWidth" : ""
       		} ]
        });
	}
	
	/*	[ ????????? ] ?????? ????????? / ???????????? 
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
	  				var popup = window.open("/common/form/FormTestPop.do", "??????" , "width=980, height=500 , scrollbars=yes");
	  				if(popup){
		  				popup.document.write(data.result.aData.html);
	  				}else{
	  					alert('?????? ??????????????? ??????????????????.');
	  				}
	  			} else if(data.result.resultCode == 'VALIDATION'){
	  				alert(data.result.resultName);
	  			}
	  			else{
	  				console.log(data.result.resultCode);
					console.log(data.result.resultName);
					alert('????????? ?????? ????????? ?????????????????????.');
	  			}
	 		},
	    	error: function (result) {
	    		console.log('# !! error . ');
	    		console.log(result);
	  		}
	  	});
	}
</script>

<!-- ????????????????????? -->
<div class="sub_contents_wrap">
	<div class="top_box">
		<dl>
			<dt>????????????</dt>
			<dd>
				<select id="list_formList" style=" margin-right:5px; float:left;">
			</dd>
			<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","??????")%>" /></dd>
		</dl>
	</div>
	
	<div class="btn_div m0 cl">
		<div class="right_div">
			<!-- ????????????????????? -->
			<div id="" class="controll_btn">
				<!-- <button id="btnAdd">???????????????</button> -->
				<button id="btn_testForm">?????????</button> 
				<button id="btn_removeForm">??????</button>
				<button id="btn_saveForm">??????</button>
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
								<th>?????????(<%=BizboxAMessage.getMessage("TX000002787","?????????")%>)</th>
								<td>
								<input type="text" id="form_nm" name="form_nm" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>?????????(<%=BizboxAMessage.getMessage("TX000002790","??????")%>)</th>
								<td>
								<input type="text" id="form_nm_en" name="form_nm_en" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>?????????(<%=BizboxAMessage.getMessage("TX000002789","?????????")%>)</th>
								<td>
								<input type="text" id="form_nm_cn" name="form_nm_cn" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th>?????????(<%=BizboxAMessage.getMessage("TX000002788","?????????")%>)</th>
								<td>
								<input type="text" id="form_nm_jp" name="form_nm_jp" value="" readonly="readonly" style="width: 100%"/>
								</td>
							</tr>
							<tr>
								<th><%=BizboxAMessage.getMessage("TX000000274","????????????")%></th>
								<td>
									<select id="use_yn" name="use_yn" disabled="disabled">
									<option value="Y"><%=BizboxAMessage.getMessage("TX000000180","??????")%></option>
									<option value="N"><%=BizboxAMessage.getMessage("TX000001243","?????????")%></option>
									</select>
								</td>
							</tr>
						</table>
					</div>
					<div class="com_ta">
						<div class="tab_nor">
							<ul>
								<li id="sample" class="on"><a href="javascript:tab_nor_Fn(1);">??????</a></li>
								<li id="head"><a href="javascript:tab_nor_Fn(2, 'head')">??????</a></li>
								<li id="list"><a href="javascript:tab_nor_Fn(3, 'list')">??????</a></li>
								<li id="slip"><a href="javascript:tab_nor_Fn(4, 'slip')">??????</a></li>
								<li id="mng"><a href="javascript:tab_nor_Fn(5, 'mng')">????????????</a></li>
								<li id="foot"><a href="javascript:tab_nor_Fn(6, 'foot')">??????</a></li>
							</ul>
						</div>
					
						<div class="tab_area" style="height:500px;overflow:auto;border-right:1px;">
							<!-- ?????? ??? --------------------------------------------------------------------------------------------------------------------->
							<div class="tab1">
								<div class="com_ta2 bg_lightgray">
									<table id="sample_table">
									</table>
								</div>
							</div>
							
							<!-- ?????? ??? --------------------------------------------------------------------------------------------------------------------->
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
							
							<!-- ?????? ??? --------------------------------------------------------------------------------------------------------------------->
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
							
							<!-- ?????? ??? --------------------------------------------------------------------------------------------------------------------->
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
							
							<!-- ???????????? ??? --------------------------------------------------------------------------------------------------------------------->
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
							
							<!-- footer ??? --------------------------------------------------------------------------------------------------------------------->
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