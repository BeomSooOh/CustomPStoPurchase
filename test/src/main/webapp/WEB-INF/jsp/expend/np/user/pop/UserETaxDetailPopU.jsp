<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Bizbox A</title>
    
    <!--css-->
	<script type="text/css" src='<c:url value="/js/jqueryui/jquery-ui.css"></c:url>'></script>
	<script type="text/css" src='<c:url value="/js/pudding/css/common.css"></c:url>'></script>
	    
    <!--js-->
    <script type="text/javascript" src='<c:url value="/js/pudding/js/jquery-1.9.1.min.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/js/jqueryui/jquery.min.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
    <script type="text/javascript" src='<c:url value="/js/pudding/common.js"></c:url>'></script>
</head>

<body>
	<div class="pop_wrap_dir" style="width:898px;">
		<div class="pop_head">
			<h1 class="txtTaxFg">${CL.ex_electronicInvoice}  <!--매입전자세금계산서--></h1>
		</div>
						
		<div class="pop_con">		
			<div class="fl mb10" style="width:100%;">
                <ul>
                    <li class="fl" style="width:50%;"><span class="fwb">${CL.ex_confirmationNumber}  <!--승인번호--> :</span> <span id="taxNum">taxNum</span></li>
                    <li class="fl"><span class="fwb">${CL.ex_manageNum}  <!--관리번호--> :</span> <span id="num">num</span></li>
                </ul>
            </div>
			<!-- 세금계산서 -->		
            <div class="js_tax_grid">  	
				<table id="gridVIewTax" width="100%" border="0" cellspacing="0" cellpadding="0" class="Taxtabel Taxtabel_layout blue">
					<colgroup>
						<col width="70%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>

					<!-- 책번호, 일련번호 -->
					<tr>
						<td rowspan="2" class="textC"><strong name="taxPageTitle" class="f19 txtTaxFg">${CL.ex_electronicInvoice2}  <!--전자세금계산서--></strong></td>
						<td class="textC">${CL.ex_bookNum}  <!--책번호--></td>
						<td class="textR" id="volNum1">volNum1권</td>
						<td class="textC Rline" id="volNum2">volNum2호</td>
					</tr>
					<tr>
						<td class="textC">${CL.ex_serialNum}  <!--일련번호--></td>
						<td colspan="2" class="Rline" id="serial">serial</td>
					</tr>
					<tr>
						<td colspan="4" class="p0">
							<!-- 공급자, 공급받는자 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Taxtabel red">
								<colgroup>
								<col width="3%" />
								<col width="9%" />
								<col width="17%" />
								<col width="2%" />
								<col width="7%" />
								<col width="12%" />

								<col width="3%" />
								<col width="9%" />
								<col width="17%" />
								<col width="2%" />
								<col width="7%" />
								<col width="12%" />
								</colgroup>
							  <tr>
								<td rowspan="8" class="textC lh23">공<br/>급<br/>자</td>
								<td class="textC">${CL.ex_registNum}  <!--등록번호--></td>
								<td colspan="4" id="sellBizNum">sellBizNum</td>											
								<td rowspan="8" class="textC lh23">공<br/>급<br/>받<br/>는<br/>자</td>
								<td class="textC">${CL.ex_registNum}  <!--등록번호--></td>
								<td colspan="4" id="buyBizNum">buyBizNum</td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_mutual}  <!--상호--></td>
								<td colspan="2" id="sellCompName">sellCompName</td>
								<td class="textC">${CL.ex_name}  <!--성명--></td>
								<td class="textC" id="sellCeoName">sellCeoName</td>
								<td class="textC">${CL.ex_mutual}  <!--상호--></td>
								<td colspan="2" id="buyCompName">buyCompName</td>
								<td class="textC">${CL.ex_name}  <!--성명--></td>
								<td class="textC" id="buyCeoName">buyCeoName</td>
							  </tr>
							  <tr>
								<td class="textC lh18">${CL.ex_area}  <!--사업장--><br/>${CL.ex_address}  <!--주소--></td>
								<td colspan="4" id="sellAddr">sellAddr 1,2</td>      
								<td class="textC lh18">${CL.ex_area}  <!--사업장--><br/>${CL.ex_address}  <!--주소--></td>
								<td colspan="4" id="buyAddr">buyAddr 1,2</td>  
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_business}  <!--업태--></td>
								<td id="sellBusinessType">sellBusinessType</td>
								<td colspan="2" class="textC">${CL.ex_event}  <!--종목--></td>
								<td id="sellJongmokName">sellJongmokName</td>
								<td class="textC">${CL.ex_business}  <!--업태--></td>
								<td id="buyBusinessType">buyBusinessType</td>
								<td colspan="2" class="textC">${CL.ex_event}  <!--종목--></td>
								<td id="buyJongmokName">buyJongmokName</td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_deptNm}  <!--부서명--></td>
								<td id="sellDeptName">sellDeptName</td>
								<td colspan="2" class="textC">${CL.ex_chargePerson}  <!--담당자--></td>
								<td id="sellEmpName">sellEmpName</td>
								<td class="textC">${CL.ex_deptNm}  <!--부서명--></td>
								<td id="buyDeptName">buyDeptName</td>
								<td colspan="2" class="textC">${CL.ex_chargePerson}  <!--담당자--></td>
								<td id="buyEmpName">buyEmpName</td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_contact}  <!--연락처--></td>
								<td id="sellTell">sellTell</td>
								<td colspan="2" class="textC">${CL.ex_phone}  <!--휴대폰--></td>
								<td id="sellCellPhone">sellCellPhone</td>
                                <td class="textC">${CL.ex_contact}  <!--연락처--></td>
								<td id="buyTell">buyTell</td>
								<td colspan="2" class="textC">${CL.ex_phone}  <!--휴대폰--></td>
								<td id="buyCellPhone"></td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_email}  <!--E_Mail--></td>
								<td colspan="4" id="sellEmail">sellEmail</td>
								<td class="textC">${CL.ex_email}  <!--E_Mail--></td>
								<td colspan="4" id="buyEmail">buyEmail</td>
							  </tr>
							</table>		
						</td>
					</tr>
					<tr>
						<td colspan="4" class="p0">
							<!-- 작성일자 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Taxtabel red">
								<colgroup>
									<col width="50px" />
									<col width="44px" class="ch_w"/>
									<col width="44px" class="ch_w"/>
									<col width="23%" />
									<col width="23%" />
									<col width="" />
								</colgroup>
								<tr>
									<td colspan="3" class="textC">${CL.ex_writeDate}  <!--작성일자--></td>
									<td class="textC">${CL.ex_purPrice}  <!--공급가액--></td>
									<td class="textC">${CL.ex_taxAmount}  <!--세액--></td>
									<td class="textC">${CL.ex_note2}  <!--비고--></td>
								</tr>
								<tr>
									<td class="textC" id="taxDate1">taxDate1</td>
									<td class="textC" id="taxDate2">taxDate2</td>
									<td class="textC" id="taxDate3">taxDate3</td>
									<td class="textR" id="stdAmt">stdAmt</td>
									<td class="textR" id="vatAmt">vatAmt</td>
									<td id="dummy1">dummy1</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					<!-- 품목명 리스트 -->
					<td colspan="4" class="p0" id = "gridSubjectList">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Taxtabel red">
							  <colgroup>
									<col width="4%"/>
									<col width="4%"/>
									<col width="33%"/> 
									<col width="6%"/>
									<col width="6%"/>
									<col width="9.6%"/>
									<col width="10%"/>
									<col width="10%"/>
									<col width=""/>
								</colgroup>                              
							  <thead>
								  <tr>
									<td class="textC">${CL.ex_month}  <!--월--></td>
									<td class="textC">${CL.ex_day}  <!--일--></td>
									<td class="textC">대표 품목  <!--품목--></td>
									<td class="textC">${CL.ex_standard}  <!--규격--></td>
									<td class="textC">${CL.ex_volume}  <!--수량--></td>
									<td class="textC">${CL.ex_unitCost}  <!--단가--></td>
									<td class="textC">${CL.ex_purPrice}  <!--공급가액--></td>
									<td class="textC">${CL.ex_taxAmount}  <!--세액--></td>
									<td class="textC">비고</td>
								  </tr>
							  </thead>
							  <tbody id = "tbl_itemList">
								  <tr>
									<td class="textC" id="MidData1">taxDate1</td>
									<td class="textC" id="MidData2">taxDate2</td>
									<td class="textC" id="txtItemName"></td>
									<td id=""></td>
									<td id=""></td>
									<td id=""></td>
									<td class="textR" id="MidstdAmt">stdAmt</td>
									<td class="textR" id="MidvatAmt">vatAmt</td>
									<td class="textC" id="Middummy">dummy1</td>
								  </tr>
								</tbody>
							</table>
						</td>
					</tr>
					
                    <tr>
						<td colspan="4" class="p0">
							<!-- 합계금액 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Taxtabel red">
								<colgroup>
									<col width=""/>
									<col width="20%"/>
									<col width="11%"/>
									<col width="7%"/>
								</colgroup>
							  <tr>
								<td class="textC">${CL.ex_sumCost}  <!--합계금액--></td>
								<td rowspan="2" class="textC brrn fwb">${CL.ex_thisCost}  <!--이금액을--></td>
								<td rowspan="2" class="brrn lh18" id="dummy2">dummy2</td>
								<td rowspan="2" class="fwb">${CL.ex_ham}  <!--함--></td>
							  </tr>
							  <tr>
								<td class="textR" id="amt">amt</td>
							  </tr>
							</table>
						</td>
					</tr>
				</table>
            </div>
		</div>
	</div><!-- //pop_wrap -->
</body>
</html>



<script>
	/*	[document.ready] 전자 세금계산서 상세내역 문서 준비
	-------------------------------------------------- */
	$(document).ready(function(){
		var eTaxInfo = {};
		
		<c:forEach var="item" items="${eTaxInfo}">
			eTaxInfo['${item.key}'] = "${item.value}".replace("'","`");
		</c:forEach>
		
		var taxNum			  = (eTaxInfo.taxNum || '');
		var hometaxIssNo	  = (eTaxInfo.hometaxIssNo || ''); // 국세청승인번호 추가 by Kwon Oh Gwang on 2019-04-18.
		var num				  =	(eTaxInfo.num || '');
		var volNum1			  =	(eTaxInfo.volNum1 || '');
		var volNum2			  =	(eTaxInfo.volNum2 || '');
		var serial			  =	(eTaxInfo.serial || '');
		var sellBizNum		  =	(eTaxInfo.sellBizNum || '');
		var sellCompName	  =	(eTaxInfo.sellCompName || '');
		var sellCeoName		  =	(eTaxInfo.sellCeoName || '');
		var sellAddr1		  =	(eTaxInfo.sellAddr1 || '');
		var sellAddr2		  =	(eTaxInfo.sellAddr2 || '');
		var sellBusinessType  =	(eTaxInfo.sellBusinessType || '');
		var sellJongmokName	  =	(eTaxInfo.sellJongmokName || '');
		var sellDeptName	  =	(eTaxInfo.sellDeptName || '');
		var sellEmpName		  =	(eTaxInfo.sellEmpName || '');
		var sellTell		  =	(eTaxInfo.sellTell || '');
		var sellCellPhone	  =	(eTaxInfo.sellCellPhone || '');
		var sellEmail		  =	(eTaxInfo.sellEmail || '');
		var buyBizNum		  =	(eTaxInfo.buyBizNum || '');
		var buyCompName		  =	(eTaxInfo.buyCompName || '');
		var buyCeoName		  =	(eTaxInfo.buyCeoName || '');
		var buyAddr1		  =	(eTaxInfo.buyAddr1 || '');
		var buyAddr2		  =	(eTaxInfo.buyAddr2 || '');
		var buyBusinessType	  =	(eTaxInfo.buyBusinessType || '');
		var buyJongmokName	  =	(eTaxInfo.buyJongmokName || '');
		var buyDeptName		  =	(eTaxInfo.buyDeptName || '');
		var buyEmpName		  =	(eTaxInfo.buyEmpName || '');
		var buyTell			  =	(eTaxInfo.buyTell || '');
		var buyCellPhone	  =	(eTaxInfo.buyCellPhone || '');
		var buyEmail		  =	(eTaxInfo.buyEmail || '');
		var taxDate			  =	(eTaxInfo.taxDate || '');
		var stdAmt			  =	(eTaxInfo.stdAmt || '');
		var vatAmt			  =	(eTaxInfo.vatAmt || '');
		var amt				  =	(eTaxInfo.amt || '');
		var dummy1			  =	(eTaxInfo.dummy1 || '');
		var dummy2			  =	(eTaxInfo.dummy2 || '');
		
		var itemNm			  =	(eTaxInfo.itemNm || '');
		
		if(dummy2 == '1') dummy2 = '청구';
		if(dummy2 == '2') dummy2 = '영수';
		
		
		if('${eTaxInfo.taxFg}' == 1){
			$('.txtTaxFg').html('매입전자세금계산서');
		} else {
			$('.txtTaxFg').html('매입전자계산서');
		}
		
		
		$('#taxNum').html(hometaxIssNo ); // taxNum(관리번호) -> hometaxIssNo(국세청승인번호) 으로 변경 by Kwon Oh Gwang on 2019-04-18.
		$('#num').html(taxNum ); // num -> taxNum(관리번호) 으로 변경 by Kwon Oh Gwang on 2019-04-18.
		$('#volNum1').html(volNum1);
		$('#volNum2').html(volNum2);
		$('#serial').html(serial);
		
		$('#sellBizNum').html(sellBizNum);
		$('#sellCompName').html(sellCompName);
		$('#sellCeoName').html(sellCeoName);
		$('#sellAddr').html(sellAddr1 + '<br>' + sellAddr2);
		$('#sellBusinessType').html(sellBusinessType);
		$('#sellJongmokName').html(sellJongmokName);
		$('#sellDeptName').html(sellDeptName);
		$('#sellEmpName').html(sellEmpName);
		$('#sellTell').html(sellTell);
		$('#sellCellPhone').html(sellCellPhone);
		$('#sellEmail').html(sellEmail);
		
		$('#buyBizNum').html(buyBizNum);
		$('#buyCompName').html(buyCompName);
		$('#buyCeoName').html(buyCeoName);
		$('#buyAddr').html(buyAddr1 + '<br>' + buyAddr2);
		$('#buyBusinessType').html(buyBusinessType);
		$('#buyJongmokName').html(buyJongmokName);
		$('#buyDeptName').html(buyDeptName);
		$('#buyEmpName').html(buyEmpName);
		$('#buyTell').html(buyTell);
		$('#buyCellPhone').html(buyCellPhone);
		$('#buyEmail').html(buyEmail);
		
		$('#dummy1').html(dummy1);
		$('#dummy2').html(dummy2);
		
		$('#taxDate1').html(taxDate.substring(0, 4));
		$('#taxDate2').html(taxDate.substring(4, 6));
		$('#taxDate3').html(taxDate.substring(6, 8));
		$('#stdAmt').html(fnGetCurrencyCode(stdAmt, 0));
		$('#vatAmt').html(fnGetCurrencyCode(vatAmt, 0));
		$('#amt').html(fnGetCurrencyCode(amt, 0));
		
		
		$('#MidData1').html(taxDate.substring(4, 6));
		$('#MidData2').html(taxDate.substring(6, 8));
		$('#MidstdAmt').html(fnGetCurrencyCode(stdAmt, 0));
		$('#MidvatAmt').html(fnGetCurrencyCode(vatAmt, 0));
		$('#Middummy').html(dummy1);
		$('#txtItemName').html(itemNm);
		
		if(eTaxInfo.itemNm == '' || eTaxInfo.itemNm ==null){
			$('#gridSubjectList').css('display','none');
		}
	});
	
	function fnGetAuthDate(date, time){
		var authDate = date.replace(/[^0-9]/g,'');
		var authTime = date.replace(/[^0-9]/g,'');
		
		return authDate.substring(0, 4) + '-'+ authDate.substring(4, 6) + '-'+ authDate.substring(6, 8) 
		+ ' ' +authTime.substring(0, 2) + ':'+ authTime.substring(2, 4) + ':'+ authTime.substring(4, 6);
	}
	function fnGetCardCode(val){
		var cardNum = val.replace(/[^0-9]/g,'');
		return cardNum.substring(0, 4) + '-'+ cardNum.substring(4, 8) + '-'+ cardNum.substring(8, 12) + '-'+ cardNum.substring(11, 15);
	}
	
	/*  [공통함수] 통화 코드 적용 
	일천 단위에 통화코드 ','적용.
	Params /
	valeu      : 통화 코드 적용 밸류
	-----------------------------------------------------*/
	function fnGetCurrencyCode(value, defaultVal) {
	    value = '' + value || '';
	    value = '' + value.split('.')[0];
	    value = value.replace(/[^0-9\-]/g, '') || (defaultVal != undefined ? defaultVal : '0');
	    var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    return returnVal;
	}
	
</script>