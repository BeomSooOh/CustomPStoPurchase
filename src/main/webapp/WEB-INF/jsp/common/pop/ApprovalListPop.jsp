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
	<colgroup>
		<col width="80px" />
		<col width="" />
		<col width="" />
		<col width="" />
		<col width="100px" />
		<col width="100px" />
		<col width="" />
	</colgroup>
	<tbody id="tblSlipInfo">
		<tr height="25" class="Tline">
			<th rowspan="2"><b>${CL.ex_division}<!-- 구분 --></b></th>
			<th rowspan="2"><b>${CL.ex_account}<!-- 계정과목 --></b></th>
			<th><b>${CL.ex_project}<!-- 프로젝트 --></b></th>
			<th><b>${CL.ex_vendor}<!-- 거래처 --></b></th>
			<th rowspan="2"><b>${CL.ex_debitAmount}<!-- 차변금액 --></b></th>
			<th rowspan="2"><b>${CL.ex_creditAmount}<!-- 대변금액 --></b></th>
			<th rowspan="2"><b>${CL.ex_note}<!-- 적요 --></b></th>
		</tr>
		<tr height="25">
			<th><b>${CL.ex_businessCard}<!-- 법인카드 --></b></th>
			<th><b>${CL.ex_user}<!-- 사용자 --></b></th>
		</tr>
	</tbody>
</table>
</div>

<script>
	var groupSeq = '${groupSeq}';
	var expendSeq = '${expendSeq}';
	var listSeq = '${listSeq}';
	var listInfos = ${listInfos};

	$(document).ready(function() {
		fnSetTableData(listInfos);
	});
	
	function fnSetTableData(data){
		var length = data.length;
		var bodyTag = '';
		var footerTag = '';
		var drAmt = 0;
		var crAmt = 0;
		
		for(var i=0; i < length ; i++ ){
			var item = data[i];
			
			if(item.drcrGbn == '차변'){
				drAmt += parseInt(item.amt);
			}else{
				crAmt += parseInt(item.amt);
			}
			bodyTag += '<tr height="25">';
			bodyTag += '	<td rowspan="2">' + (item.drcrGbn == '차변' ? '${CL.ex_debit}' : '${CL.ex_credit}') ; // 차변 : 대변
			bodyTag += '		<a onClick="javascript:window.open(\'/exp/ApprovalSlipPop.do?expend_seq=${expendSeq}&list_seq=${listSeq}&group_seq=${groupSeq}&slip_seq='+item.slipSeq+'\',\'\',\'width=700, height=600\')" href="#n" style="color:#3aa1f3;">[' + '${CL.ex_detailView}' + ']</a>'; // 상세
			bodyTag += '	</td>';
			bodyTag += '	<td rowspan="2" class="textL pdL5">' + item.acctName + '</td>';
			bodyTag += '	<td class="textL pdL5">' + item.projectName + '</td>';
			bodyTag += '	<td class="textL pdL5">'+ item.partnerName +'</td>';
			bodyTag += '	<td rowspan="2" class="textR pdR5 ar">'+ numberWithCommas( item.drcrGbn == '차변' ? item.amt : 0 ) +'</td>';
			bodyTag += '	<td rowspan="2" class="textR pdR5 ar">'+ numberWithCommas( item.drcrGbn == '대변' ? item.amt : 0 ) +'</td>';
			bodyTag += '	<td rowspan="2" class="textL pdL5 al">'+ (item.note || '') +'</td>';
			bodyTag += '</tr>';
			bodyTag += '<tr height="25">';
			if(item.syncId){
				bodyTag += '	<td class="textL pdL5"><a href="#n" onClick="javascript:window.open(\'/exp/expend/ex/user/card/ExExpendCardDetailInfo.do?syncId='+ item.syncId +' \', \'\', \'width=450, height=470\')">'+ item.cardName +'</a></td>';
			}else {
				bodyTag += '	<td class="textL pdL5">'+ item.cardName +'</td>';
			}
			bodyTag += '	<td class="textL pdL5">'+ item.empName +'</td>';
			bodyTag += '</tr>';
		}
		
		footerTag += '<tr height="25">';
		footerTag += '	<th colspan="4"><b>${CL.ex_totalAmt}</b></th>'; // 합계
		footerTag += '	<th class="textR pdr5 ar">' + numberWithCommas(drAmt) + '&nbsp;</th>';
		footerTag += '	<th class="textR pdr5 ar">' + numberWithCommas(crAmt) + '&nbsp;</th>';
		footerTag += '	<th><b></b></th>';
		footerTag += '</tr>' ;
		
		$('#tblSlipInfo').append(bodyTag).append(footerTag);
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
			strHeight += 42;
		}
		
		try{
			var childWindow = window.parent;
			childWindow.resizeTo(strWidth, strHeight);	
		}catch(exception){
			console.log('window resizing cat not run dev mode.');
		}
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
</script>