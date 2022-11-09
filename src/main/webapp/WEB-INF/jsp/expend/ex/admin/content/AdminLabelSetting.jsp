<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- javascript - src -->
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>
<!-- javascript -->
<!-- 프로토 타입 정의용 스크립트 -->
<script type="text/javascript">

	/* [Map] declare javascipt hashmap prototype
	========================================*/
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


<!-- body -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_keyWord}</dt>
			
			<dd class="mr5">
				<input id="txtSearchText" type="text" value="" style="width: 300px">
			</dd>
        
			<dd>
				<div class="controll_btn p0">
         			<button id="btnTextSearch" class="btn_sc_add">${CL.ex_search}</button>
        		</div>
				<span id="txtSearchAsi" class="posi_ab text_gray span_result_cnt"style="top: 20px; left: 330px;"></span>
			</dd>
		</dl>
	</div>
	<div id="" class="controll_btn cl">
		<button id="btnInitData2" class="k-button" style="display:none;"><%=BizboxAMessage.getMessage("","마지막 저장으로")%></button>
		<button id="btnInitData" class="k-button">${CL.ex_backtostart}</button>
		<button id="btnSaveLabelInfo" class="k-button">${CL.ex_save}</button>
	</div>
	<!-- 테이블 -->
	<div class="com_ta2 bg_lightgray">
		<table id="tblLabelList">
<%-- 			<colgroup> --%>
<%-- 				<col width="" /> --%>
<%-- 				<col width="" /> --%>
<%-- 				<col width="" /> --%>
<%-- 				<col width="" /> --%>
<%-- 				<col width="" /> --%>
<%-- 				<col width="" /> --%>
<%-- 			</colgroup> --%>
		</table>
	</div> 
</div>
<script>
	
	/* 공용 필드 영역 */
	var searchResult;	// 검색결과 :  Map - prototype
	var storedData;		// 최초 접근 데이터 : aaData
	var savedData;		// 최근 저장 데이터(DB기준) : aaData
	var idIdxFlag = 0;	// 엘리먼트 key 지정용 : number
	var oTable;			// 데이터 테이블 오브젝트 객체 : object
	
	/*	[ 문서준비 ] 명칭설정 페이지 문서 준비
	-----------------------------------------------*/
	$(document).ready(function (){
		
		/* 필드/프로퍼티 초기화 */
		fnInitVariable();
		
		/* 명칭데이터 호출 */
		fnGetLabelData();
		
		/* 이벤트 바인드 */
		fnEventBind();
	});
	
	/*	[ 이벤트 ] 검색 이벤트 바인드 
	-----------------------------------------------*/
	function fnEventBind(){
		
		/* 검색 */
		$('#btnTextSearch').click(function (){
			
			var resultList = [];
			var searchVal = $('#txtSearchText').val().toString();
			if(!searchVal){
				
				$('td').removeClass('selected');
				$('#txtSearchAsi').text('');
				return;
			}
			if(searchResult.get(searchVal)){
				var item = searchResult.get(searchVal);
				item.searchIdx = (++item.searchIdx) % item.resultList.length;
				fnSetFocusClass(item.resultList[item.searchIdx]);
				$('#txtSearchAsi').text( (parseInt(item.searchIdx) + 1) + '/' + item.resultList.length);
				searchResult.put(searchVal, item);
				
			}else{
				
				$('.searchTarget')
				.filter(function() { 
					var str = '';
					str += $(this).val() || $(this).text();
					return ( str.indexOf(searchVal) > -1 ) 
				}).each( function(){
					resultList.push($(this).attr('id'));
				});
				if(!resultList.length){
					$('#txtSearchAsi').text('0/0');
					return;
				}
				
				var item = {
					'searchIdx' : 0
					, 'resultList' : resultList	
				};
				fnSetFocusClass(item.resultList[item.searchIdx]);
				$('#txtSearchAsi').text( (parseInt(item.searchIdx) + 1) + '/' + resultList.length);
				searchResult.put(searchVal, item);
			}
		});
		
		/* 검색 / 엔터입력 */
		$('#txtSearchText').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;

                $('#btnTextSearch').click();
            }else{
            	$('#txtSearchAsi').text('');
            }
        });
		
		/* 데이터 초기화 */
		$('#btnInitData').click(function(){
			if(confirm("<%=BizboxAMessage.getMessage("","모든 정보가 페이지 최초접근 시점으로 롤백됩니다.")%>")){
				fnSetMainGrid(storedData);
				$('#btnSaveLabelInfo').click();
				$('#btnInitData2').hide();
			}
		});
		
		$('#btnInitData2').click(function(){
			if(confirm("<%=BizboxAMessage.getMessage("","모든 정보가 최근 저장 시점으로 롤백됩니다.")%>")){
				fnSetMainGrid(savedData);
				$('#btnSaveLabelInfo').click();
			}
		});
		
		/* 저장 */
		$('#btnSaveLabelInfo').click(function (){
			var targetData = fnGetSaveDataFormat();
			if(targetData.length){
				fnSaveChangeInfo(targetData);	
			}
		});
	}
	
	function fnSaveChangeInfo(data){
		$.ajax({
			type : "post",
			async : true,
			url : '<c:url value="/ex/expend/admin/ExAdminSetLabelInfoList.do"></c:url>',
			datatype : "json",
			data : {param : JSON.stringify(data)},
			success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					savedData = result.result.aaData;
					// alert('저장이 완료되었습니다.');
					$('#btnInitData2').show();
				}else{
					console.log('명칭 데이터 저장 오류 발생 /');
					console.log(result.result.resultName);	
				}
			},
			error : function(e, status) { //error : function(xhr, status, error) {
				console.log('명칭 데이터 저장 중 치명적 오류 발생 /');
				console.log(e);
			}
		});
	}
	
	
	/* [저장] 저장 데이터 포멧에 맞추어 불러오기
	---------------------------------------------------------*/	
	function fnGetSaveDataFormat(){
		var orgnData = savedData || storedData;  
		var length = orgnData.length;
		
		var updateList = [];
		for(var i = 0; i < length; i++){
			var item = {
				langCode : $('.langCode' + i).text()
				, langKR : $('.langKR' + i).val()
				, langJP : $('.langJP' + i).val()
				, langType : $('.langType' + i).text()
				, compSeq : $('.compSeq' + i).text()
				, langCN : $('.langCN' + i).val()
				, langEN : $('.langEN' + i).val()
				, basicName : $('.basicName' + i).text()
				, tooltip : $('.tooltip' + i).val()
				, langpackCode : $('.langpackCode'+i).text()
			};
			
			if(!fnIsMatchObject(orgnData[i], item)){
				updateList.push(item);
			}
		}
		return updateList;	
	}
	
	/* [저장] 저장 데이터 포멧 비교
	---------------------------------------------------------*/	
	function fnIsMatchObject(a, b){
		if(a.langKR != b.langKR){
			return false;
		} if(a.langJP != b.langJP){
			return false;
		} if(a.langCN != b.langCN){
			return false;
		} if(a.langEN != b.langEN){
			return false;
		} if(a.tooltip != b.tooltip){
			return false;
		}
		return true;
	}
	
	/* [검색] 데이터 테이블 포커스및 셀렉트 표현
	---------------------------------------------------------*/
	function fnSetFocusClass(id){
		$('td').removeClass('selected');
		$('#' + id).closest('td').addClass('selected');
   
		$(".dataTables_scrollBody").animate({
			scrollTop : 0
		}, 0);
		var y = $('#' + id).closest('tr').offset().top - 161 - 350;
		$('.searchTarget').removeClass('focused');
		$('#' + id).addClass('focused');
		$(".dataTables_scrollBody").animate({
			scrollTop : y
		}, 0); // 이동
	}
	
	/* [노드 반환] 선택된 노드 포지션 반환
	---------------------------------------------------------*/
	function getPosition(element) {
		var xPosition = 0;
		var yPosition = 0;

		while (element) {
			xPosition += (element.offsetLeft - element.scrollLeft + element.clientLeft);
			yPosition += (element.offsetTop - element.scrollTop + element.clientTop);
			element = element.offsetParent;
		}
		return {
			x : xPosition,
			y : yPosition
		};
	}
	
	/*	[ 초기화 ] 필드/프로퍼티 초기화
	-----------------------------------------------*/
	function fnInitVariable(){
		searchResult = new Map();
	}
	
	/*	[ ajax ] 명칭데이터 서버로부터 호출
	-----------------------------------------------*/
	function fnGetLabelData(){
		$.ajax({
			type : "post",
			async : true,
			url : '<c:url value="/ex/expend/admin/ExAdminGetLabelInfoList.do"></c:url>',
			datatype : "json",
			data : { },
			success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					if(!storedData){
						storedData = result.result.aaData;
					}
					fnSetMainGrid(result.result.aaData);
				}else{
					console.log('명칭 데이터 호출 오류 발생 /');
					console.log(result.result.resultName);	
				}
			},
			error : function(e, status) { //error : function(xhr, status, error) {
				console.log('명칭 데이터 치명적 오류 발생 /');
				console.log(e);
			}
		});
	}
	
	/*	[ table ] 메인 테이블 데이터 설정
	-----------------------------------------------*/
	function fnSetMainGrid(data){
		var rowId = 0;
		var columnDefs = [
			{
				"targets" : 0,
				"data" : null,
				"sWidth" : "",
				"render" : function(data) {
					return '' ;
				}
			},{
				"targets" : 1,
				"data" : null,
				"sWidth" : "",
				"render" : function(data) {
					return '<span class="dev_code basicName'+rowId+'" id="searchElem'+ (++idIdxFlag) +'">'+ data.basicName +'</span>'
					+ '<span class="searchTarget langCode'+rowId+'" id="searchElem'+ (++idIdxFlag) +'" style="display:none;">'+ data.langCode +'</span>'
					+ '<span class="langType'+rowId+'" style="display:none;">'+ data.langType +'</span>'
					+ '<span class="compSeq'+rowId+'" style="display:none;">'+ data.compSeq +'</span>'
					+ '<span class="langpackCode'+rowId+'" style="display:none;">'+ data.langpackCode +'</span>';
				}
			},{
				"targets" : 2,
				"data" : null,
				"sWidth" : "",
				"render" : function(data) {
					return '<input class="searchTarget langKR'+rowId+'" id="searchElem'+ (++idIdxFlag) +'" type="text" value="'+ data.langKR +'"/>';
				}
			},{
				"targets" : 3,
				"data" : null,
				"sWidth" : "",
				"render" : function(data) {
					return '<input class="searchTarget langEN'+rowId+'" id="searchElem'+ (++idIdxFlag) +'" type="text" value="'+ data.langEN +'"/>';
				}
			},{
				"targets" : 4,
				"data" : null,
				"sWidth" : "",
				"render" : function(data) {
					return '<input class="searchTarget langJP'+rowId+'" id="searchElem'+ (++idIdxFlag) +'" type="text" value="'+ data.langJP +'"/>';
				}
			},{
				"targets" : 5,
				"data" : null,
				"sWidth" : "",
				"render" : function(data) {
					return '<input class="searchTarget langCN'+rowId+'" id="searchElem'+ (++idIdxFlag) +'" type="text" value="'+ data.langCN +'"/>';
				}
			},{
				"targets" : 6,
				"data" : null,
				"sWidth" : "",
				"render" : function(data) {
					return '<input class="searchTarget tooltip'+(rowId++)+'" id="searchElem'+ (++idIdxFlag) +'" type="text" value="'+ data.tooltip +'"/>';
				}
			}
		];
		
		var columns = [
			{
				"sTitle" : "${CL.ex_code}",
				"bVisible" : false,
				"bSortable" : false,
				"sWidth" : ""
			},{
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000000936","기본값")%>",
				"bVisible" : true,
				"bSortable" : false,
				"sWidth" : ""
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000002787","한국어")%>",
				"bVisible" : true,
				"bSortable" : false,
				"sWidth" : ""
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000002790","영&nbsp;&nbsp;어")%>",
				"bVisible" : true,
				"bSortable" : false,
				"sWidth" : ""
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000002788","일본어")%>",
				"bVisible" : true,
				"bSortable" : false,
				"sWidth" : ""
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000002789","중국어")%>",
				"bVisible" : true,
				"bSortable" : false,
				"sWidth" : ""
			}, {
				"sTitle" : "<%=BizboxAMessage.getMessage("","툴팁")%>",
				"bVisible" : true,
				"bSortable" : false,
				"sWidth" : ""
			}
		];
		
		oTable = $('#tblLabelList').dataTable({
			select : true,
			bAutoWidth : true,
			"sScrollY": "600px",
			destroy : true,
			language : getTableDef('language'),
			data : data,
			columnDefs : columnDefs || [],
			aoColumns : columns || '',
			bSort : false,
			paging : false,
		});
	}
</script>






