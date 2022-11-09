 <%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>


<style>

/* 결재양식_지출결의 전표 테이블*/
.statement{text-align:center; table-layout:fixed !important;} 
.statement th{background:#f1f1f1; font-weight:normal; height:25px; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1;word-break:break-all;} 
.statement.fwb_th th {font-weight:bold;}
.statement tr.Tline{border-top:1px solid #b1b1b1;}
.statement td{height:25px; border-bottom:1px solid #b1b1b1; border-right:1px solid #b1b1b1; line-height:140%; word-break:break-all;} 
.statement td.ar{text-align:right; padding-right:5px;} 
.statement td.al{text-align:left; padding-left:5px;} 
.statement .button_ex{border:0px; width: 18px; height: 18px; padding:0px; cursor:pointer;}
.statement_title{float:left; text-align:left; width:100%; height:19px; padding:6px 0 0 0;}
.statement .blue_a {color:#058df5}

</style>

<div style="max-height:500px; overflow-y:auto;" class="pop_wrap">
	<table class="statement" width="100%">
		<colgroup width="25%" />
		<colgroup width="25%"/>
		<colgroup width="25%" />
		<colgroup width="25%" />
		<tbody id="tblMngInfo">
			<tr height="25" class="Tline">
				<th> <b>관리항목</b> </th>
				<th> <b>항목명</b> </th>
				<th> <b>코드</b> </th>
				<th> <b>명</b> </th>
			</tr>
		</tbody>

	</table>
</div>
<script>

	var groupSeq = '${groupSeq}';
	var expendSeq = '${expendSeq}';
	var listSeq = '${listSeq}';
	var slipSeq = '${slipSeq}';
	var slipInfos = ${slipInfos};
	
		
	$(document).ready(function() {
		fnSetTableData(slipInfos);
	});

	function fnSetTableData(data){
		var trTag = '';
		var length = data.length;
	
		var Price = ["C05","H3","I3","B26","D03","C16","D16","D17","I6","I1","PX"];
		var Date = ["B21","B22","B23","B52","C08","C12","C34","D15","F1","F2","F3","D29","G1","G2","G3"];
	
		for(var i = 0 ; i < length; i++){
	
			var item = data[i];
		 	
			trTag += '<tr height="25">';
			trTag += '	<td> <b>' + item.mng_code + '</b> </td>'; 
			trTag += '	<td> <b>' + item.mng_name + '</b> </td>';
			trTag += '	<td> <b>' + item.ctd_code + '</b> </td>';

			if(Price.indexOf(item.mng_code) != -1){
					var res = (item.ctd_name || '');
					res = res.toString().replace(/,/g, '');
					if(res.split('.').length == 2) {
						res = res.split('.')[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '.' + res.split('.')[1];
					}
					else if(res.split('.').length == 1) {
						res = res.split('.')[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
					}
					trTag += '	<td> <b>' + res + '</b> </td>';
					
			}else if(Date.indexOf(item.mng_code) != -1) {
					trTag += '	<td> <b>' + [item.ctd_name.substring(0, 4), item.ctd_name.substring(4, 6), item.ctd_name.substring(6, 8)].join('-') + '</b> </td>'; 
				   
			}else {
					trTag += '	<td> <b>' + item.ctd_name+ '</b> </td>'; 
			}
			trTag += '</tr>';
		}
	
		$('#tblMngInfo').append(trTag);
		reSize();
	} 
	
	
	function reSize(){
		var strWidth = $('.pop_wrap').outerWidth()
		+ (window.outerWidth - window.innerWidth);
		var strHeight = $('.pop_wrap').outerHeight()
				+ (window.outerHeight - window.innerHeight);
		
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		
		if(isFirefox){
			
		}if(isIE){
			
		}if(isEdge){
			
		}if(isChrome){
			strHeight += 49;
		}
		
		try{
			var childWindow = window.parent;
			childWindow.resizeTo(strWidth, strHeight);	
		}catch(exception){
			console.log('window resizing cat not run dev mode.');
		}
	}
</script>










