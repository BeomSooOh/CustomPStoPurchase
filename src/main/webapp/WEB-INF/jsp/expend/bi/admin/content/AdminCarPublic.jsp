<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<script type="text/javascript">
	$(document).ready(function() {
		fnInit();
		$("#btnSearch").click();
	});
	
	/* 초기화 */
	function fnInit(){
		fnInitLayout();
		fnInitBtnEvent();
		fnInitKeyEvent();
	}
	/* 레이아웃 초기화 */
	function fnInitLayout(){
		
	}
	/* 버튼 이벤트 초기화 */
	function fnInitBtnEvent(){
		$("#btnSearch").click(function(){
			fnCarPublicSelect();
		});
		
		$("#btnSync").click(function(){
			fnCarPublicSync();
		});
		
	}
	/* 키보드 이벤트 초기화 */
	function fnInitKeyEvent(){
		$("#txtCarNb").keydown(function (event) {
            if (event.keyCode === 13) {
            	$("#btnSearch").click();
            }
		});
	}
	/* 차량공개범위 조회(iCUBE) */
	/* 필요 파라미터 검색어 ; searchStr, useYN */
	function fnCarPublicSelect(){
		var param = {};
		param.searchStr = $("#txtCarNb").val();
		param.useYN = $("#selUseYN").val();
        $.ajax({
            type : 'post',
            url : '<c:url value="/bi/admin/car/CarInfoListSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	fnGridList(data.result);
            },
            error : function( data ) {
                return;
            }
        });
	}
	/* 그리드 출력 */
	function fnGridList(result){
		var data = (result.aaData || {});
		
		$('#tblCarTable').dataTable( {
        	"aaSorting": [],
            "fixedHeader" : true,
            "select" : true,
            "pageLength" : 7,
            // "sScrollY" : param.scrollY,
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
// 	            $(nRow).on('click', (function() {
// 	            }));
	        },
	        "columnDefs" : [ {
	            "targets" : 6,
	            "data" : null, 
	            "render" : function( data ) {
	            	if(data.useYN == '1'){
	            		return '사용';	
	            	}else{
	            		return '미사용';
	            	}
	            	
	            }
	        }, {
	            "targets" : 7,
	            "data" : null, //"vatYN", 
	            "render" : function( data ) {
	            	if(data.bizFg == '0'){
	            		return '일반 업무용';	
	            	}else if(data.bizFg == '1'){
	            		return '출·퇴근용';	
	            	}else{
	            		return '';
	            	}
	            }
	        }],
	        "aoColumns" : [ {
                "sTitle" : "NO",
                "mDataProp" : "rowNum",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "50px",
                "sClass" : ""
            },{
                "sTitle" : "차량번호",
                "mDataProp" : "carNumber",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "13%",
                "sClass" : ""
            },{
                "sTitle" : "차종",
                "mDataProp" : "carName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "15%",
                "sClass" : ""
            },{
                "sTitle" : "부서",
                "mDataProp" : "erpDeptName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "%",
                "sClass" : ""
            },{
                "sTitle" : "이름",
                "mDataProp" : "erpEmpName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "10%",
                "sClass" : ""
            },{
                "sTitle" : "직책",
                "mDataProp" : "duty",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "10%",
                "sClass" : ""
            },{
                "sTitle" : "사용여부",
//                 "mDataProp" : "rowNum",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "10%",
                "sClass" : ""
            },{
                "sTitle" : "사용구분",
//                 "mDataProp" : "rowNum",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "13%",
                "sClass" : ""
            }]
        });
	}
	
	
	/* iCUBE 차량 정보 동기화 */
	/* 현재 미사용 */
	function fnCarPublicSync(){
		var param = {};
        $.ajax({
            type : 'post',
            url : '<c:url value="/bi/admin/car/BiAdminCarInfoSync.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	$("#btnSearch").click();
            },
            error : function( data ) {
                return;
            }
        });
	}
</script>


<!-- contents -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>차량번호</dt>
			<dd><input id="txtCarNb" type="text" value="" style="width:150px;"/></dd>
			<dt>사용여부</dt>
			<dd>
				<select class="selectmenu" style="width:80px;" id="selUseYN">
					<option value="" selected="selected">전체</option>
					<option value="1">사용</option>
					<option value="0">미사용</option>
				</select>
			</dd>
			<dd><input type="button" id="btnSearch" value="검색" /></dd>
		</dl>
	</div>			
	<div class="btn_div">
		<div class="left_div">
			<h5>차량목록 <span class="f11 fwn text_blue ml10"><span class="f12">※</span> ERP에 등록된 차량정보입니다.</span></h5></h5>
		</div>
		<div class="right_div">
			<div class="controll_btn p0">
				<button id="btnSync" style="display: none;">동기화</button>
			</div>
		</div>
	</div>							
	
	<!-- 테이블 -->
	<div class="com_ta2">
		<table id="tblCarTable"> 
		</table>
	</div>

	<!--// paging -->
	<div class="gt_paging" style="display: none;">
		<div class="paging">
			<span class="pre_pre"><a href="">10페이지전</a></span>
			<span class="pre"><a href="">이전</a></span>
				<ol>
					<li class="on"><a href="">1</a></li>
					<li><a href="">2</a></li>
					<li><a href="">3</a></li>
					<li><a href="">4</a></li>
					<li><a href="">5</a></li>
					<li><a href="">6</a></li>
					<li><a href="">7</a></li>
					<li><a href="">8</a></li>
					<li><a href="">9</a></li>
					<li><a href="">10</a></li>
				</ol>
			<span class="nex"><a href="">다음</a></span>
			<span class="nex_nex"><a href="">10페이지다음</a></span>
		</div>
		
		<div class="gt_count">
			<select class="selectmenu up" style="width:50px;">
				<option value="" selected="selected">100</option>
				<option value="">300</option>
				<option value="">700</option>
			 </select>
		</div>	
	</div>
</div><!-- //sub_contents_wrap -->