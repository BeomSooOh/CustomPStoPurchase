<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/jquery-1.9.1.min.js"></c:url>'></script>
<!--  css 파일 모음 -->
<link rel="stylesheet" type="text/css" href='<c:url value="/css/kendoui/kendo.common.min.css"></c:url>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/kendoui/kendo.dataviz.min.css"></c:url>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/kendoui/kendo.mobile.all.min.css"></c:url>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/kendoui/kendo.silver.min.css"></c:url>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/common.css"></c:url>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/reKendo.css"></c:url>'>
	
<script type="text/javascript">
	
	
var C1 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt','itemgbn','ntisregdt','ntisregno'];
var C2 = ['entrant','purposebiztrip','biztripstdt','biztripendt','biztripsttime','biztripentime','stplace','enplace','inoutgbn','peopleregno'];
var C3 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt','itemgbn'];
var C4 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt'];
var C5 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt'];
var C6 = ['entrant','purposebiztrip','biztripstdt','biztripendt','biztripsttime','biztripentime','stplace','enplace','inoutgbn','peopleregno'];
var C7 = ['specialist','useplace','usestdt','useendt','usesttime','useentime','usemethod','amt'];       
var C8 = ['peopleregno','educator','eduorgnm','edustdt','eduendt','edusttime','eduentime'];
var C9 = ['belonggbn','peopleregno','belongbizno','entnm'];
var C10 = ['peopleregno','overtimeworker','overworkstdt','overworkendt','overworksttime','overworkentime'];
	
	$(document).ready(function() {
		var bindList = [];
		bindList = JSON.parse('${resultList}');
		var cheju = '';
		
		$.each(bindList,function(index,item){
			if(cheju == ''){
				cheju = item.cheju;
			}
			fnAddRow(item);
		});
		
		
	
		fnSetChejuType(cheju);
	});
	/*  체주유형 설정 */
	function fnSetChejuType(cheju){
		var arrCheju = cheju.split('_');
		var itemCheju = arrCheju[1];
		
		switch(itemCheju){
			case 'C1':
				for(var i=0; i < C1.length; i++){
					$('.th_'+C1[i]).css('display','');
					$('.'+C1[i]).css('display','');
				}
				break;
			case 'C2':
				for(var i=0; i < C2.length; i++){
					$('.th_'+C2[i]).css('display','');
					$('.'+C2[i]).css('display','');
				}
				break;
			case 'C3':
				for(var i=0; i < C3.length; i++){
					$('.th_'+C3[i]).css('display','');
					$('.'+C3[i]).css('display','');
				}
				break;
			case 'C4':
				for(var i=0; i < C4.length; i++){
					$('.th_'+C4[i]).css('display','');
					$('.'+C4[i]).css('display','');
				}
				break;
			case 'C5':
				for(var i=0; i < C5.length; i++){
					$('.th_'+C5[i]).css('display','');
					$('.'+C5[i]).css('display','');
				}
				break;
			case 'C6':
				for(var i=0; i < C6.length; i++){
					$('.th_'+C6[i]).css('display','');
					$('.'+C6[i]).css('display','');
				}
				break;
			case 'C7':
				for(var i=0; i < C7.length; i++){
					$('.th_'+C7[i]).css('display','');
					$('.'+C7[i]).css('display','');
				}
				break;
			case 'C8':
				for(var i=0; i < C8.length; i++){
					$('.th_'+C8[i]).css('display','');
					$('.'+C8[i]).css('display','');
				}
				break;
			case 'C9':
				for(var i=0; i < C9.length; i++){
					$('.th_'+C9[i]).css('display','');
					$('.'+C9[i]).css('display','');
				}
				break;
			case 'C10':
				for(var i=0; i < C10.length; i++){
					$('.th_'+C10[i]).css('display','');
					$('.'+C10[i]).css('display','');
				}
				break;
		}
		
	}
	
	function fnAddRow(rowData){
		var row = "<tr>" +
			"<td class='le item' style='width:100px; display:none;' >"+ rowData.item+"</td>" +
			"<td class='le standard' style='width:100px; display:none;'>"+rowData.standard +"</td>" +
			"<td class='ri amount' style='width:100px; display:none;' >"+rowData.amount +"</td>" +
			"<td class='ri unitprice' style='width:120px; display:none;'>"+rowData.unitprice +"</td>" +
			"<td class='ri itemsupplyamt' style='width:120px; display:none;'>"+ rowData.itemsupplyamt+"</td> " +
			"<td class='ri itemtaxamt' style='width:120px; display:none;'>"+rowData.itemtaxamt +"</td> " +
			"<td class='ri itemtotalamt' style='width:120px; display:none;'>"+rowData.itemtotalamt +"</td> " +
			"<td class='le itemgbn' style='width:100px; display:none;' >"+rowData.itemgbn +"</td> " +
			"<td class='cen ntisregdt' style='width:125px; display:none;' >"+rowData.ntisregdt +"</td> " +
			"<td class='le ntisregno' style='width:150px; display:none;'>"+rowData.ntisregno +"</td> " +
			"<td class='le specialist' style='width:100px; display:none;' >"+ rowData.specialist+"</td> " +
			"<td class='le itementrant' style='width:100px; display:none;' >"+ rowData.itementrant+"</td> " +
			"<td class='le purposebiztrip' style='width:100px; display:none;' >"+rowData.purposebiztrip +"</td> " +
			"<td class='cen biztripstdt' style='width:125px; display:none;' >"+rowData.biztripstdt +"</td> " +
			"<td class='cen biztripendt' style='width:125px; display:none;'>"+ rowData.biztripendt+"</td> " +
			"<td class='cen biztripsttime' style='width:100px; display:none;' >"+rowData.biztripsttime +"</td> " +
			"<td class='cen biztripentime' style='width:100px; display:none;'>"+rowData.biztripentime +"</td> " +
			"<td class='le stplace' style='width:100px; display:none;'>"+ rowData.stplace +"</td> " +
			"<td class='le enplace' style='width:100px; display:none;' >"+rowData.enplace +"</td> " +
			"<td class='le inoutgbn' style='width:100px; display:none;' >"+rowData.inoutgbn +"</td> " +
			"<td class='le belonggbn' style='width:100px; display:none;' >"+rowData.belonggbn +"</td> " +
			"<td class='le peopleregno' style='width:150px; display:none;' >"+rowData.peopleregno +"</td> " +
			"<td class='le overtimeworker' style='width:100px; display:none;' >"+rowData.overtimeworker +"</td> " +
			"<td class='cen overworkstdt' style='width:125px; display:none;' >"+ rowData.overworkstdt+"</td> " +
			"<td class='cen overworkendt' style='width:125px; display:none;' >"+rowData.overworkendt +"</td> " +
			"<td class='cen overworksttime' style='width:100px; display:none;' >"+rowData.overworksttime +"</td> " +
			"<td class='cen overworkentime' style='width:100px; display:none;' >"+rowData.overworkentime +"</td> " +
			"<td class='cen belongbizno' style='width:150px; display:none;'>"+ rowData.belongbizno +"</td> " +
			"<td class='le entnm' style='width:100px; display:none;' >"+rowData.entnm +"</td> " +
			"<td class='le educator' style='width:100px; display:none;' >"+rowData.educator +"</td> " +
			"<td class='le eduorgnm' style='width:100px; display:none;' >"+ rowData.eduorgnm+"</td> " +
			"<td class='cen edustdt' style='width:125px; display:none;' >"+rowData.edustdt +"</td> " +
			"<td class='cen eduendt' style='width:125px; display:none;'>"+rowData.eduendt +"</td> " +
			"<td class='cen edusttime' style='width:100px; display:none;' >"+ rowData.edusttime+"</td> " +
			"<td class='cen eduentime' style='width:100px; display:none;' >"+ rowData.eduentime+"</td> " +
			"<td class='le useplace' style='width:100px; display:none;' >"+ rowData.useplace+"</td> " +
			"<td class='cen usestdt' style='width:125px; display:none;' >"+rowData.usestdt +"</td> " +
			"<td class='cen useendt' style='width:125px; display:none;'>"+rowData.useendt +"</td> " +
			"<td class='cen usesttime' style='width:100px; display:none;' >"+ rowData.usesttime +"</td> " +
			"<td class='cen useentime' style='width:100px; display:none;'>"+ rowData.useentime +"</td> " +
			"<td class='le usemethod' style='width:100px; display:none;'>"+ rowData.usemethod+"</td> " +
			"<td class='ri amt' style='width:120px; display:none;' >"+ rowData.amt +"</td> " +
		"</tr>"
		
		$("#tblItemList").append(row);
	}
	
</script>


<div class="pop_wrap" id="layerCommonCode" style="width: 1024;">
	<div class="pop_head">
			<h1>상세보기</h1>
			<a href="#n" onclick="" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
	</div>	
	
	<div class="pop_con">
		<div class="scroll_on">
			<div class="com_ta2 hover_no bgtable2" style="height:500px">
				<table id="tblItemList">
					<tr>
						<th class="th_item" style="wclassth:100px; display:none;">품명</th>
						<th class="th_standard" style="wclassth:100px; display:none;">규격</th>
						<th class="th_amount" style="wclassth:100px; display:none;">수량</th>
						<th class="th_unitprice" style="wclassth:120px; display:none;">단가</th>
						<th class="th_itemsupplyamt" style="wclassth:120px; display:none;">공급가액</th>
						<th class="th_itemtaxamt" style="wclassth:120px; display:none;">세액</th>
						<th class="th_itemtotalamt" style="wclassth:120px; display:none;">총구입액</th>
						<th class="th_itemgbn" style="wclassth:100px; display:none;">물품구분</th>
						<th class="th_ntisregdt" style="wclassth:125px; display:none;">NTIS등록일자</th>
						<th class="th_ntisregno" style="wclassth:150px; display:none;">NTIS등록번호</th>
						<th class="th_specialist" style="wclassth:100px; display:none;">전문가</th>
						<th class="th_itementrant" style="wclassth:100px; display:none;">출장자</th>
						<th class="th_purposebiztrip" style="wclassth:100px; display:none;">출장목적</th>
						<th class="th_biztripstdt" style="wclassth:125px; display:none;">출장시작일</th>
						<th class="th_biztripendt" style="wclassth:125px; display:none;">출장종료일</th>
						<th class="th_biztripsttime" style="wclassth:100px; display:none;">출장시작시간</th>
						<th class="th_biztripentime" style="wclassth:100px; display:none;">출장종료시간</th>
						<th class="th_stplace" style="wclassth:100px; display:none;">출발지</th>
						<th class="th_enplace" style="wclassth:100px; display:none;">도착지</th>
						<th class="th_inoutgbn" style="wclassth:100px; display:none;">시내외구분</th>
						<th class="th_belonggbn" style="wclassth:100px; display:none;">소속구분</th>
						<th class="th_peopleregno" style="wclassth:150px; display:none;">연구자등록번호</th>
						<th class="th_overtimeworker"style="wclassth:100px; display:none;">특근자명</th>
						<th class="th_overworkstdt"style="wclassth:125px; display:none;">특근시작일</th>
						<th class="th_overworkendt"style="wclassth:125px; display:none;">특근종료일</th>
						<th class="th_overworksttime"style="wclassth:100px; display:none;">특근시작시간</th>
						<th class="th_overworkentime"style="wclassth:100px; display:none;">특근종료시간</th>
						<th class="th_belongbizno"style="wclassth:150px; display:none;">소속사업자번호</th>
						<th class="th_entnm"style="wclassth:100px; display:none;">참석자성명</th>
						<th class="th_educator"style="wclassth:100px; display:none;">교육자</th>
						<th class="th_eduorgnm"style="wclassth:100px; display:none;">교육기관명</th>
						<th class="th_edustdt"style="wclassth:125px; display:none;">교육시작일</th>
						<th class="th_eduendt"style="wclassth:125px; display:none;">교육종료일</th>
						<th class="th_edusttime"style="wclassth:100px; display:none;">교육시작시간</th>
						<th class="th_eduentime"style="wclassth:100px; display:none;">교육종료시간</th>
						<th class="th_useplace"style="wclassth:100px; display:none;">활용장소</th>
						<th class="th_usestdt"style="wclassth:125px; display:none;">활용시작일</th>
						<th class="th_useendt"style="wclassth:125px; display:none;">활용종료일</th>
						<th class="th_usesttime"style="wclassth:100px; display:none;">활용시작시간</th>
						<th class="th_useentime"style="wclassth:100px; display:none;">활용종료시간</th>
						<th class="th_usemethod"style="wclassth:100px; display:none;">활용방법</th>
						<th class="th_amt"style="width:120px; display:none;">금액</th>
					</tr>	
				</table>
			</div>
		</div>
	</div>
</div>