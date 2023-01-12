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
		
		$('[name=addData]').remove();
		
		var reqParam = {};
		reqParam.year = $("#purchaseGoalYear").val();;

		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/${authLevel}/SelectOverallHopeAmtInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				
				resultData = result.resultData;
				
				var trTotal = {};
				trTotal.name = "합계";
				trTotal.goal_amt = 0;
				trTotal.current_amt = 0;
				trTotal.current_cnt = 0;
				trTotal.attain_rate = "";
				
				if(resultData.length > 0){
					
					$.each(resultData, function( key, val ) {

						var cloneData = $('[name=dataBase]').clone();
						
						var goal_amt = parseInt(val.goal_amt.replace(/,/g, ''));
						var current_amt = parseInt(val.current_amt.replace(/,/g, ''));
						var current_cnt = parseInt(val.current_cnt);
						
						trTotal.current_amt += current_amt;
						trTotal.current_cnt += current_cnt;
						
						if(val.goal_amt == "-"){
							val.attain_rate = "-";
						}else{
							trTotal.goal_amt += goal_amt;
							val.attain_rate = (current_amt/goal_amt*100).toFixed(2) + " %";				
						}
						
						$(cloneData).find("[name=name]").text(val.name);
						$(cloneData).find("[name=goal_amt]").text(val.goal_amt);
						$(cloneData).find("[name=current_amt]").text(val.current_amt);
						$(cloneData).find("[name=current_cnt]").text(val.current_cnt);
						$(cloneData).find("[name=attain_rate]").text(val.attain_rate);
						$(cloneData).show().attr("name", "addData");
						$('[name=dataBase]').before(cloneData);						
						
					});							
					
					trTotal.attain_rate = trTotal.goal_amt == 0 ? "-" : ((trTotal.current_amt/trTotal.goal_amt*100).toFixed(2) + " %");		
					trTotal.goal_amt = (trTotal.goal_amt + "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					trTotal.current_amt = (trTotal.current_amt + "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					
					var cloneData = $('[name=dataBase]').clone();		
					
					$(cloneData).find("[name=name]").text(trTotal.name);
					$(cloneData).find("[name=goal_amt]").text(trTotal.goal_amt);
					$(cloneData).find("[name=current_amt]").text(trTotal.current_amt);
					$(cloneData).find("[name=current_cnt]").text(trTotal.current_cnt);
					$(cloneData).find("[name=attain_rate]").text(trTotal.attain_rate);
					$(cloneData).show().attr("name", "addData");
					
					$(cloneData).addClass("total");
					$('[name=dataBase]').before(cloneData);						
					
					resultData.push(trTotal);
					
					
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
     
    			excelDownloadProcess( "총괄희망구매실적(관리자).xlsx", progressBarObj );
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
    	var period = "조회년도: " + $("#purchaseGoalYear").val(); 
    	excel.set(0, 0, 0, period, periodStyle);
    	
    	var formatHeader = excel.addStyle ({
    		border: "thin,thin,thin,thin #000000",
    		fill: "#dedede",
    		font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
    		align : "C C",
    	});
		    	
    	var headerRow = 2;
    	var headerCol = 5;
    	
    	for(var i=1; i < headerRow; i++) {
    		for(var j=0; j < headerCol; j++) {
    			excel.set(0, j, i, null, formatHeader);
    		}
    	}
    	
		for(var j=0; j < headerCol; j++) {
			excel.set(0, j, totalCount, null, formatHeader);
		}    	
    	
    	excel.set(0, 0, 1, "구분");
    	excel.set(0, 1, 1, "목표 금액(원)");
    	excel.set(0, 2, 1, "현재 실적(원)");
    	excel.set(0, 3, 1, "건수");
    	excel.set(0, 4, 1, "달성률");    	
    	
    	// sheet번호, column, value(width)
    	for( var i = 0; i < 4; i++ ) {
    		excel.setColumnWidth( 0, i, 20 );
    	}    	
		
    	excel.setColumnWidth( 0, 0, 30 );
    	/*
    	excel.setColumnWidth( 0, 9, 50 );
    	excel.setColumnWidth( 0, 13, 25 );
    	excel.setColumnWidth( 0, 20, 25 );
    	excel.setColumnWidth( 0, 21, 25 );
    	excel.setColumnWidth( 0, 24, 25 );
    	*/
    	
    	var formatCell = excel.addStyle ({
    		align : "C"
    	});
    	
    	var formatCellR = excel.addStyle ({
    		align : "R"
    	});    	
    	
    	// header row 이후부터 출력
    	for( var i = 0; i < totalCount; i++ ) {
    		var rowNo = i + 2;
    		excel.set( 0, 0, rowNo, dataPage[ i ][ "name" ], rowNo == (totalCount+1) ? formatHeader : formatCell );
    		excel.set( 0, 1, rowNo, dataPage[ i ][ "goal_amt" ], rowNo == (totalCount+1) ? formatHeader : formatCellR );
    		excel.set( 0, 2, rowNo, dataPage[ i ][ "current_amt" ], rowNo == (totalCount+1) ? formatHeader : formatCellR );
    		excel.set( 0, 3, rowNo, dataPage[ i ][ "current_cnt" ], rowNo == (totalCount+1) ? formatHeader : formatCell );
    		excel.set( 0, 4, rowNo, dataPage[ i ][ "attain_rate" ], rowNo == (totalCount+1) ? formatHeader : formatCellR );
    	}
     
    	excel.generate( fileName, saveCallback, stepCallback );
    }    
	
</script>

<!-- 상세검색 -->
<div class="top_box">
	<dl>
		<dt class="ar" style="width:60px;">조회년도</dt>
		<dd><select id="purchaseGoalYear" onchange="BindGrid()"></select></dd>	
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
						<col width="40%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="10%"/>
					</colgroup>
					<tr>
						<th>구분</th>
						<th>목표 금액(원)</th>
						<th>현재 실적(원)</th>
						<th>건수</th>
						<th>달성률</th>
					</tr>
					<tr name="dataBase" style="display:none;">
						<td name="name"></td>
						<td class="ri" name="goal_amt"></td>
						<td class="ri" name="current_amt"></td>
						<td class="ri" name="current_cnt"></td>
						<td class="ri" name="attain_rate"></td>
					</tr>					
				</table>
			</div>
		</div>
	</div>
	<input style="display:none;" id="file_upload" type="file" />
	<div id="exArea"></div>
	<div id="jugglingProgressBar"></div>
	<div id="loadingProgressBar"></div>
	<div id="circularProgressBar"></div>	
</div><!-- //sub_contents_wrap -->