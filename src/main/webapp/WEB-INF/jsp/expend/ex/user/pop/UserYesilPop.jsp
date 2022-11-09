<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExAmtCommon.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEx.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.format.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.list.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.pop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.valid.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>

<!-- javascript -->
<script>
	/* UserYesilProjectPop var */
	
	/* document.ready */
	$(document).ready(function() {
		
		log('+ [UserYesiPop] (document).ready');
		$('#text_input').focus();
		var defaultInfo = {
			budgetFlag : '${budgetFlag}',
			fromDt : '${fromDt}',
			toDt : '${toDt}',
			searchStr : '${searchStr}'
		}
		
		fnUserYesilProjectPopInit(defaultInfo);
		fnUserYesilProjectPopEventInit();
		
		$("#text_input").val('${searchStr}');
		/* 페이지 준비완료, 최초 조회 시작 */
		fnGetMaingridData(defaultInfo);
		log('+ [UserYesiPop] (document).ready');
	});
	
	/* 초기화 */
	function fnUserYesilProjectPopInit(defaultInfo) {
		log('+ [UserYesilProjectPop] fnUserYesilProjectPopInit');
		fnUserYesilProjectPopLayout();
		fnUserYesilProjectPopDatepicker();
		fnUserYesilProjectPopInitInput();
		fnUserYesilProjectPopInitButton(defaultInfo);
		log('- [UserYesilProjectPop] fnUserYesilProjectPopInit');
		return;
	}0
	
	/* 초기화 - Layout */
	function fnUserYesilProjectPopLayout() {
		log('+ [UserYesilProjectPop] fnUserYesilProjectPopLayout');
		$('button').kendoButton(); /* 켄도버튼정의 */
		log('- [UserYesilProjectPop] fnUserYesilProjectPopLayout');
		return;
	}
	
	/* 초기화 - Datepicker */
	function fnUserYesilProjectPopDatepicker() {
		log('+ [UserYesilProjectPop] fnUserYesilProjectPopDatepicker');
		log('- [UserYesilProjectPop] fnUserYesilProjectPopDatepicker');
		return;
	}
	
	/* 초기화 - Event */
	function fnUserYesilProjectPopEventInit() {
		log('+ [UserYesilProjectPop] fnUserYesilProjectPopEventInit');
		$("#text_input").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		log('- [UserYesilProjectPop] fnUserYesilProjectPopEventInit');
		return;
	}
	
	/* 초기화 - Input */
	function fnUserYesilProjectPopInitInput() {
		log('+ [UserYesilProjectPop] fnUserYesilProjectPopInitInput');
		
		log('- [UserYesilProjectPop] fnUserYesilProjectPopInitInput');
		return;
	}
	/* 초기화 - Button */
	function fnUserYesilProjectPopInitButton(defaultInfo) {
		log('+ [UserYesilProjectPop] fnUserYesilProjectPopInitButton');
        
        /* 검색버튼 이벤트 설정 */
		$('#btnSearch').click(function (){
			fnGetMaingridData(defaultInfo);
		});
		
		/* 확인버튼 이벤트 설정 */
		$('#btnAccept').click(function (){
			if($('#hid_dataTrunk').val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000019021","선택된 정보가 없습니다.")%>");
				return false;
			}
			var data = JSON.parse($('#hid_dataTrunk').val());
			var param = { obj : data , budgetFlag : '${budgetFlag}'};
			
			window.close();
			
			// 콜백 함수 호출
			window.opener.fnPopCallback(param);
		});
		
        /* 취소버튼 이벤트 설정 */
		$('#btnClose').click(function (){
			window.close();
		});
		log('- [UserYesilProjectPop] fnUserYesilProjectPopInitButton');
		return;
	}
	
	/* [ 사이즈 변경 ] 페이지 리폼
	-----------------------------------------------*/
	function fnResizeForm() {
		var strWidth = $('.pop_wrap').outerWidth() + (window.outerWidth - window.innerWidth);
		var strHeight = $('.pop_wrap').outerHeight() + (window.outerHeight - window.innerHeight);
		
		$('.pop_wrap').css("overflow","auto");
		
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		
		
		if(isFirefox){
			
		}if(isIE){

		}if(isEdge){
		strWidth = 475;
		strHeight = 530;
			
		}if(isChrome){
			
		}
		
		try{
			var childWindow = window.parent;
			childWindow.resizeTo(strWidth, strHeight);	
		}catch(exception){
			console.log('window resizing cat not run dev mode.');
		}
	}
	
	function fnGetMaingridData(defaultInfo){
		var param = {};
		param.budgetFlag = defaultInfo.budgetFlag;
		param.fromDt = defaultInfo.fromDt;
		param.toDt = defaultInfo.toDt;
		param.search_str = $('#text_input').val() || '';
		
		// 정보 조회 후 메인 그리드 출력
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/expend/user/ExUserYesilPopInfoSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : param,
	        success : function( data ) {	  
	        	fnSetMainList(defaultInfo, data);
	        	fnResizeForm();
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}
	
	/* 메인리스트 설정
	--------------------------------------------*/
	function fnSetMainList(defaultInfo, data){
		var aoColumn = "";
			aoColumn = [ {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000045","코드")%>",
                "mDataProp" : "NO_PROJECT",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000519","프로젝트")%>",
                "mDataProp" : "NM_PROJECT",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
          } ];
		// 그리드 그리기 호출
		fnSetGridView(defaultInfo, 'tbl_yesilPop', data.result.aaData, aoColumn);
	}
	
	/*	[뷰]	그리드 데이터 셋팅
	--------------------------------------------*/
	function fnSetGridView(defaultInfo, elemID, data, aoColumn, columDefs){
		columDefs = (columDefs || {});
		
		var id = '' + elemID;
		id = id[0] == '#' ? id : '#' + id;
		if(data && data.length == 1 && $('#text_input').val() != ''){
			$('#hid_dataTrunk').val(JSON.stringify(data[0]));
			$('#btnAccept').click();
		}
		
        var oTable = $(id).dataTable({
            /* "fixedHeader" : true, */
            "select" : true,
            "pageLength" : 7,
            "sScrollY" : "260px",
            "bAutoWidth" : false,
            "destroy" : true,
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
                $(nRow).on('click', (function() {
                	$('#hid_dataTrunk').val(JSON.stringify(aData))
                }));
                $(nRow).on('dblclick', (function() {
                    $('#hid_dataTrunk').val(JSON.stringify(aData));
                    $('#btnAccept').click();
                }));
            },
            "aoColumns" : aoColumn,
            "columnDefs" : columDefs
        });
	}
</script>

<input type="hidden" value="" id="hid_dataTrunk"/>

<div class="pop_wrap" style="width: 475px;">
	<div class="pop_head">
		<h1><%=BizboxAMessage.getMessage("TX000018990","프로젝트별")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con div_form">
	<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000000399","검색어")%></dt>
				<dd><input id="text_input" name="text_input" type="text" style="width:200px;" value="${searchStr}"/></dd>
				<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" /></dd>
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta2 mt14">
			<table id = "tbl_yesilPop">
				<colgroup>
					<col width="130"/>
					<col width=""/>
				</colgroup>
			</table>		
		</div>
	</div><!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnAccept" value="<%=BizboxAMessage.getMessage("TX000000078","확인")%>" />
			<input type="button" id="btnClose" class="gray_btn" value="<%=BizboxAMessage.getMessage("TX000002947","취소")%>" />
		</div>
	</div><!-- //pop_foot -->
</div><!--// pop_wrap -->
