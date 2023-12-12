<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/re_pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/animate.css' />">
	    
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jszip-3.1.5.min.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/FileSaver-1.2.2_1.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jexcel-1.0.5.js' />"></script> 
    
<script>

	var deptSeq = "${deptSeq}";
	var deptName = "${deptName}";
	var authLevel = "${authLevel}";

	
	function yearSelInut(){
		
		var thisYear = parseInt(new Date().getFullYear());
		
		for(var i=-10; i < 11; i++) {
			$("#purchaseGoalYear").append("<option value='"+(thisYear+i)+"'>"+(thisYear+i) + " 년도"+"</option>");
		}		
		
		$("#purchaseGoalYear").val(thisYear);
		
	}	
	

	$(document).ready(function() {
		
		yearSelInut();
		
		BindGrid();
		
	});
	
	var resultData = [];
	
	function BindGrid(){
		
		$('[name=goal_amt]').text("");
		$('[name=all_sum_amt]').text("");
		$('[name=attain_rate]').text("");
		
		$('[name=addData]').remove();
		
		var reqParam = {};
		reqParam.searchFromDate = $("#searchFromDate").val();
		reqParam.searchToDate = $("#searchToDate").val();
		reqParam.year = $("#purchaseGoalYear").val();
		// reqParam.itemGreenCertType = $("#itemGreenCertType").val();
		
		//녹색제품 인증구분 선택 데이터
		var greenCdList = new Array();
		$.each($("input[name='itemGreenCertType']:checked"), (index, item) => {
			greenCdList.push($(item).val());
		});
		var geenCd = greenCdList.join("|");
			        
		reqParam.itemGreenCertType = geenCd;
		
		if (authLevel == 'admin'){
			reqParam.deptSeq = $("#selectedDeptSeq").val();
		} else if (authLevel == 'dept'){
			reqParam.deptSeq = $("#selectLoginDept").val();
		}
		

		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/${authLevel}/SelectGreenAmtInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				
				resultData = result.resultData;
				
				if(resultData.length > 0){
					
					var goal_amt = 0;
					var all_sum_amt = 0;
					var attain_rate = 0;
					
					$.each(resultData, function( key, val ) {

						var cloneData = $('[name=dataBase]').clone();
						
						$(cloneData).find("[name=code_name]").text(val.code_name);
						$(cloneData).find("[name=all_cnt]").text(val.all_cnt);
						$(cloneData).find("[name=all_amt]").text(val.all_amt);
						$(cloneData).find("[name=green_cnt]").text(val.green_cnt);
						$(cloneData).find("[name=green_amt]").text(val.green_amt);
						$(cloneData).show().attr("name", "addData");
						$('[name=dataBase]').before(cloneData);	
						
						all_sum_amt += Number(val.all_amt.replace(/,/g, ""));
						goal_amt = val.goal_amt
						
					});
					
					$('[name=goal_amt]').text(goal_amt);
					$('[name=all_sum_amt]').text(all_sum_amt.toLocaleString());
					
					
					if (Number(goal_amt.replace(/,/g, "")) > 0 ){
						goal_amt = Number(goal_amt.replace(/,/g, ""));
						attain_rate = ((all_sum_amt/goal_amt)*100).toFixed(2) + "%";
					} else {
						attain_rate = "-";
					}
					
					
					
					$('[name=attain_rate]').text(attain_rate);
					
					
				}else{
					msgSnackbar("error", "실적 데이터가 존재하지 않습니다.");	
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});			
	} 	
	
    function excelDown() {
        
    	Pudd( "#circularProgressBar" ).puddProgressBar({
     
    		progressType : "circular"
    	,	attributes : { style:"width:150px; height:150px;" }
    	,	strokeColor : "#00bcd4"	// progress 색상
    	,	strokeWidth : "3px"	// progress 두께
    	,	percentText : ""
    	,	percentTextColor : "#fff"
    	,	percentTextSize : "24px"
    	,	modal : true
    	,	extraText : {
    			text : ""
    		,	attributes : { style : "" }
    		}
    	,	progressStartCallback : function( progressBarObj ) {
    			excelDownloadProcess( "녹색구매실적.xlsx", progressBarObj );
    		}
    	});
    }	
	
    function excelDownloadProcess( fileName, progressBarObj ) {
        
    	progressBarObj.updateProgressBar( 10 );// 10%
     
    	setTimeout( function() {
     
			progressBarObj.updateProgressBar( 40 );// 40%
		     
			// excel파일 다운로드 처리
			generateExcelDownload( resultData, fileName, function() {// saveCallback

				progressBarObj.updateProgressBar( 100 );// 100%
				progressBarObj.clearIntervalSet();// progressBar 종료

			}, function( rowIdx ){// stepCallback

				var percent = ( ( rowIdx * 100 / resultData.length ) / 2 ) + 40;
				percent = parseInt( percent );

				progressBarObj.updateProgressBar( percent );
				
			});
    			
    			
    	}, 10);
    }    
    
    
    function generateExcelDownload( dataPage, fileName, saveCallback, stepCallback ) {
        
    	var excel = new JExcel("맑은 고딕 11 #333333");
    	excel.set( { sheet : 0, value : "Sheet1" } );
     	
		var totalCount = dataPage.length;
		
    	// 엑셀 상단 기간 세팅
    	var periodStyle = excel.addStyle({
    		font: "맑은 고딕 11 #333333 B"
    	})
    	// var period = "기준일자: " + $("#searchFromDate").val() + "~" + $("#searchToDate").val();
    	var period = "조회년도: " + $("#purchaseGoalYear").val();
    	excel.set(0, 0, 0, period, periodStyle);
    	
    	var formatHeader = excel.addStyle ({
    		border: "thin,thin,thin,thin #000000",
    		fill: "#dedede",
    		font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
    		align : "C C",
    	});
		    	
    	var headerRow = 6;
    	var headerCol = 5;
    	
    	for(var i=1; i < headerRow; i++) {
    		for(var j=0; j < headerCol; j++) {
    			excel.set(0, j, i, null, formatHeader);
    		}
    	}
    	excel.set(0, 0, 1, "목표금액");
    	excel.set(0, 2, 1, "구매금액/달성률");
    	
    	excel.set(0, 0, 3, "제품분류");
    	excel.mergeCell(0, 0, 3, 0, 5);
    	excel.set(0, 1, 3, "녹색제품 구매계획");
    	excel.mergeCell(0, 1, 3, 4, 3);
    	excel.set(0, 1, 4, "총구매");
    	excel.mergeCell(0, 1, 4, 2, 4);
    	excel.set(0, 3, 4, "녹색구매");
    	excel.mergeCell(0, 3, 4, 4, 4);
    	
    	excel.set(0, 1, 5, "수량");
    	excel.set(0, 2, 5, "금액");
    	excel.set(0, 3, 5, "수량");
    	excel.set(0, 4, 5, "금액");
    	
    	// sheet번호, column, value(width)
    	for( var i = 0; i < headerCol; i++ ) {
    		excel.setColumnWidth( 0, i, 30 );
    	}    	
		
    	excel.setColumnWidth( 0, 0, 40 );
    	excel.setColumnWidth( 0, 1, 40 );
    	
    	var formatCell = excel.addStyle ({
    		align : "C"
    	});
    	
    	var formatCellR = excel.addStyle ({
    		align : "R"
    	});    	
    	

    	var all_sum_amt = 0;
    	var goal_amt = 0;
    	var attain_rate = 0;
    	for( var i = 0; i < totalCount; i++ ) {
    		all_sum_amt += Number(dataPage[ i ][ "all_amt" ].replace(/,/g, ""));
    		excel.set( 0, 1, 1, dataPage[ i ][ "goal_amt" ], formatCellR );
        	goal_amt = Number(dataPage[ i ][ "goal_amt" ].replace(/,/g, ""));
    	}
    	
    	excel.set( 0, 3, 1, all_sum_amt.toLocaleString(), formatCellR );
    	
    	if (goal_amt > 0 ){
        	attain_rate = ((all_sum_amt/goal_amt)*100).toFixed(2) + "%";
    	} else {
    		attain_rate = "-"
    	}
    	
    	excel.set( 0, 4, 1, attain_rate, formatCellR );
    	
    	excel.set( 0, 0, 2, "", formatCell );
    	excel.set( 0, 1, 2, "", formatCell );
    	excel.set( 0, 2, 2, "", formatCell );
    	excel.set( 0, 3, 2, "", formatCell );
    	excel.set( 0, 4, 2, "", formatCell );
    	
    	// header row 이후부터 출력
		for( var i = 0; i < totalCount; i++ ) {
    		
    		var rowNo = i + 6;
    		excel.set( 0, 0, rowNo, dataPage[ i ][ "code_name" ], formatCell );
    		excel.set( 0, 1, rowNo, (dataPage[ i ][ "all_cnt" ] + "").replace(/\B(?=(\d{3})+(?!\d))/g, ","), formatCellR );
    		excel.set( 0, 2, rowNo, (dataPage[ i ][ "all_amt" ] + "").replace(/\B(?=(\d{3})+(?!\d))/g, ","), formatCellR );
    		excel.set( 0, 3, rowNo, (dataPage[ i ][ "green_cnt" ] + "").replace(/\B(?=(\d{3})+(?!\d))/g, ","), formatCellR );
    		excel.set( 0, 4, rowNo, (dataPage[ i ][ "green_amt" ] + "").replace(/\B(?=(\d{3})+(?!\d))/g, ","), formatCellR );
    		
    	} 
     
    	excel.generate( fileName, saveCallback, stepCallback );
    } 
    
    
	function selectOrgchart(){
		 
		 var pop = window.open("", "cmmOrgPop", "width=799,height=769,scrollbars=no");
			$("#callback").val("callbackSel");
			frmPop.target = "cmmOrgPop";
			frmPop.method = "post";
			frmPop.action = "/gw/systemx/orgChart.do";
			frmPop.submit();
			pop.focus();
	}	
   
	function callbackSel(reqParam){
		
		if(reqParam.returnObj.length > 0){
			$("#selectedDeptSeq").val(reqParam.returnObj[0].deptSeq);
			$("#deptName").val(reqParam.returnObj[0].deptName);				
		}else{
			$("#selectedItems").val("");
			$("#selectedDeptSeq").val("");
			$("#deptName").val("");
		}
		
		BindGrid();

	 }	
    
	
</script>

<!-- 상세검색 -->
<div class="top_box">
	<dl>
		<dt class="ar" style="width:60px;">조회년도</dt>
		<dd><select id="purchaseGoalYear" onchange="BindGrid()"></select></dd>
<%--		<dt class="ar" style="width:60px;">기준일자</dt>
 		<dd>
			<input type="text" id="searchFromDate" value="${fromDate}" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="searchToDate" value="${toDate}" class="puddSetup" pudd-type="datepicker"/>
		</dd>	
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" onclick="BindGrid();" /></dd> --%>
		<c:if test="${authLevel=='admin'}">
		<dt class="ar" style="width:30px;">부서</dt>
		<dd><input readonly type="text" id="deptName" pudd-style="width:120px;" class="puddSetup"  value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="선택" onclick="selectOrgchart();" /></dd>
		</c:if>
		<c:if test="${authLevel=='dept'}">
		<dt class="ar" style="width:30px;">부서</dt>
			<dd>
			<select type="select" id="selectLoginDept" name="selectLoginDept" onchange="BindGrid()"> 
				<option value="">전체</option>
				<option value="${deptSeq}" >${deptName}</option>
			</select>
			<dd>
		</c:if>
	<dt class="ar">녹색제품 인증구분</dt>
<%-- 		<dd>
			<select id="itemGreenCertType" onchange="BindGrid();" style="text-align: center;">
				<option value="">전체</option>
				<c:forEach var="items" items="${greenCertType}">
				<option value="${items.CODE}">${items.NAME}</option>
				</c:forEach>
			</select>			
		</dd>  --%>
		<dd style="margin-top : 19px;">
			<c:forEach var="items" items="${greenCertType}">
			<input type="checkbox" name="itemGreenCertType" value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}"/>
			</c:forEach>
		</dd>
			
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" onclick="BindGrid();" /></dd>		
	</dl>
</div>

<div class="sub_contents_wrap posi_re">
	<div class="btn_div">
		<div class="right_div">
			<div id="" class="controll_btn p0">
				<input type="button" onclick="excelDown();" class="puddSetup" value="엑셀다운로드" />
			</div>
		</div>		
	</div>
	
	<div class="dal_Box_">
		<div class="dal_BoxIn_ posi_re">
			<!-- 테이블 -->
			<div class="com_ta4">
				<table>
					<colgroup>
						<col width="15%"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="15%"/>
					</colgroup>
					<tr>
						<th>목표금액</th>
						<td class="ri" name="goal_amt"></td>
						<th>구매금액/달성률</th>
						<td class="ri" name="all_sum_amt"></td>
						<td class="ri" name="attain_rate"></td>
					</tr>
					<tr>
						<td colspan="5"></td>
					</tr>
					<tr>
						<th rowspan="3">제품분류</th>
						<th colspan="4">녹색제품 구매계획</th>
					</tr>
                    <tr>
						<th colspan="2">총구매</th>
                        <th colspan="2">녹색구매</th>
					</tr>
                    <tr>
						<th>수량</th>
                        <th>금액</th>
                        <th>수량</th>
                        <th>금액</th>
					</tr>
					<tr name="dataBase" style="display:none;">
						<td name="code_name"></td>
						<td class="ri" name="all_cnt"></td>
						<td class="ri" name="all_amt"></td>
						<td class="ri" name="green_cnt"></td>
						<td class="ri" name="green_amt"></td>
					</tr>					
				</table>
			</div>			
		</div>
	</div>
	<input style="display:none;" id="file_upload" type="file" />
	<div id="exArea"></div>
	<input type="hidden" id="selectedDeptSeq" value="" />
	<form id="frmPop" name="frmPop"> 
			<input type="hidden" name="selectedItems" id="selectedItems" value="" />
			<input type="hidden" name="popUrlStr" id="txt_popup_url" value="/gw/systemx/orgChart.do" />
			<input type="hidden" name="selectMode" id="selectMode" value="d" />
			<input type="hidden" name="selectItem" value="s" />
			<input type="hidden" name="callback" id="callback" value="" />
			<input type="hidden" name="compSeq" value="" />
			<input type="hidden" name="callbackUrl" value="/gw/html/common/callback/cmmOrgPopCallback.jsp"/>
			<input type="hidden" name="empUniqYn" value="N" />
			<input type="hidden" name="empUniqGroup" value="ALL" />
	</form>
	<div id="jugglingProgressBar"></div>
	<div id="loadingProgressBar"></div>
	<div id="circularProgressBar"></div>	
</div><!-- //sub_contents_wrap -->