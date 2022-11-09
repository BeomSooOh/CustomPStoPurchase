<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<div class="top_box">
	<dl>
		<dd>
			<input type="text" id="txt_filter" style="width: 200px">
		</dd>
		<dd>
			<input type="button" class="btn_search" value="검색" id="btn_txtSearch"/>
		</dd>
		
		<dd>
			<input type="button" class="btn_search advSerch" value="한글ㄴ" id="" code="lang_kr"/>
		</dd>
		<dd>
			<input type="button" class="btn_search advSerch" value="영어ㄴ" id="" code="lang_en"/>
		</dd>
		<dd>
			<input type="button" class="btn_search advSerch" value="일어ㄴ" id="" code="lang_jp"/>
		</dd>
		<dd>
			<input type="button" class="btn_search advSerch" value="중국ㄴ" id="" code="lang_cn"/>
		</dd>
	</dl>
</div>

<!-- 그리드 리스트 -->
<div id="grid"></div>
<br>
<input type="button" class="btn_search" value="신규" id="btn_new"/>
<input type="button" class="btn_search" value="저장" id="btn_save"/>
<br>
langCode : <input type="text" id="txt_langCode" style="width: 400px" disabled>
<br>
한글 : <input type="text" id="txt_langKr" style="width: 400px" >
<br>
영어 : <input type="text" id="txt_langEn" style="width: 400px" >
<br>
일어 : <input type="text" id="txt_langJp" style="width: 400px" >
<br>
중국어 : <input type="text" id="txt_langCn" style="width: 400px" >
<br>
메모 : <input type="text" id="txt_note" style="width: 400px" >


<script type="text/javascript">
	
	/*	[Init]	다국어 처리 권한 준비
	-----------------------------------------------*/
	$(document).ready(function(){
		fnSetLangCodeGrid();
		
		fnSetBtnEvent();
	});
	
	/*	[btn]	버튼 이벤트 바인드
	-----------------------------------------------*/
	function fnSetBtnEvent(){
		// 검색
		$('#btn_txtSearch').click(function(){
			var paramSet = {};
			paramSet.keyword = $('#txt_filter').val() || '';
			fnSetLangCodeGrid(paramSet);
		});
		
        //엔터키 입력시 검색 수행
        $("#txt_filter").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;

    			var paramSet = {};
    			paramSet.keyword = $('#txt_filter').val() || '';
    			fnSetLangCodeGrid(paramSet);
            }
        });
        
        // 필터링
        $('.advSerch').click(function(){
        	var paramSet = {};
        	paramSet.code =$(this).attr('code'); 
        	fnSetLangCodeGrid(paramSet);
        });
        
        // 저장
        $('#btn_save').click(function(){
        	var paramSet = {};
        	paramSet.langCode = $('#txt_langCode').val() || '';
        	paramSet.langKr = $('#txt_langKr').val() || '';
        	paramSet.langEn = $('#txt_langEn').val() || '';
        	paramSet.langJp = $('#txt_langJp').val() || '';
        	paramSet.langCn = $('#txt_langCn').val() || '';
        	paramSet.langNote = $('#txt_note').val() || '';
        	
    		$.ajax({
    			async: true,
    			type: "post",
    			url: '<c:url value="/devmanager/langpack/FuncDMLangPackInsertorUpdate.do" />',
    			datatype: "json",
    			data: paramSet,
    			success: function (result) {
    				var paramSet = {};
    				paramSet.keyword = $('#txt_filter').val() || '';
    				fnSetLangCodeGrid(paramSet);
    				alert('저장 성공!');
    			},
    			error: function (err) {
    			}
    		});
        });
        
        // 신규
        $('#btn_new').click(function(){
        	$('#txt_langCode').val('');
        	$('#txt_langKr').val('');
        	$('#txt_langEn').val('');
        	$('#txt_langJp').val('');
        	$('#txt_langCn').val('');
        	$('#txt_note').val('');
        })
	}
	
	/*	[Grid]	다국어 코드 그리드 데이터 바인드 
	-----------------------------------------------*/
	function fnSetLangCodeGrid(paramSet){
		if(!paramSet){
			paramSet = {};
			paramSet.keyword = '';
			paramSet.code = '';
		}
		
		var dataSource = null;
		dataSource = new kendo.data.DataSource({
			serverPaging: true,
			pageSize: 10,
			transport: {
				read: {
					url: "FuncDMLangPackMainList.do",
					dataType: "json",
					type: 'post'
				},
				parameterMap: function (data, operation) {
					data.keyword = paramSet.keyword || '';
					data.code = paramSet.code || '';
					return data;
				}
			},
			schema: {
				data: function (response) {
					return response.test.list;
				},
				total: function (response) {
					return response.test.totalCount;
				}
			},
		});
		
		$("#grid").kendoGrid({
			columns: [
				{
					title: "lang_code",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'lang_code'
				}
				, {
					title: "lang_kr",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'lang_kr'
				}, {
					title: "lang_en",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'lang_en'
				}, {
					title: "lang_jp",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'lang_jp'
				}, {
					title: "lang_cn",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'lang_cn'
				}, {
					title: "lang_note",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'lang_note'
				},{
					title: "create_date",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'create_date'
				}, {
					title: "modify_date",
					width: 200,
					headerAttributes: {
						style: "text-align: center;"
					},
					attributes: {
						style: "text-align: center;"
					},
					field: 'modify_date'
				}
			]
			, width : 400
			, dataSource: dataSource
			//, height:295
			, selectable: "single"
			, groupable: false
			, columnMenu:false
			, editable: false
			, sortable: true
		    , pageable: true
		    , navigatable: true
		    , change: function (arg) {
           	  	var gview = $("#grid").data("kendoGrid");
           	 	var selectedItem = gview.dataItem(gview.select());
           	 
	        	$('#txt_langCode').val(selectedItem.lang_code);
	        	$('#txt_langKr').val(selectedItem.lang_kr);
	        	$('#txt_langEn').val(selectedItem.lang_en);
	        	$('#txt_langJp').val(selectedItem.lang_jp);
	        	$('#txt_langCn').val(selectedItem.lang_cn);
	        	$('#txt_note').val(selectedItem.lang_note);
			}
		});
	}

</script>