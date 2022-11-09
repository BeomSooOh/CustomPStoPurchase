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
			<h1 class="txtTaxTy">${CL.ex_electronicInvoice}  <!--매입전자세금계산서--></h1>
		</div>
						
		<div class="pop_con">		
			<p class="mb10" id="txtAuthNum"><span class="fwb">${CL.ex_confirmationNumber}  <!--승인번호--> :</span>txtAuthNum</p>
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
					<tr height="50">
						<td colspan="4" class="textC"><strong name="taxPageTitle" class="f19 txtTaxTy" id="">${CL.ex_electronicInvoice2}  <!--전자세금계산서--></strong></td>
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
								<td colspan="4" id="txtLSaupNum">txtLSaupNum</td>											
								<td rowspan="8" class="textC lh23">공<br/>급<br/>받<br/>는<br/>자</td>
								<td class="textC">${CL.ex_registNum}  <!--등록번호--></td>
								<td colspan="4" id="txtRSaupNum">txtRSaupNum</td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_mutual}  <!--상호--></td>
								<td colspan="2" id="txtLTrName">txtLTrName</td>
								<td class="textC">${CL.ex_name}  <!--성명--></td>
								<td class="textC" id="txtLCeoName">txtLCeoName</td>
								<td class="textC">${CL.ex_mutual}  <!--상호--></td>
								<td colspan="2" id="txtRTrName">txtRTrName</td>
								<td class="textC">${CL.ex_name}  <!--성명--></td>
								<td class="textC" id="txtRCeoName">txtRCeoName</td>
							  </tr>
							  <tr>
								<td class="textC lh18" rowspan="2">${CL.ex_area}  <!--사업장--><br/>${CL.ex_address}  <!--주소--></td>
								<td rowspan="2" colspan="3" id="txtLAddr">txtLAddr</td>       
                                <td class="textC">${CL.ex_engageAreaNum}  <!--종사업장번호--></td>   
								<td class="textC lh18" rowspan="2">${CL.ex_area}  <!--사업장--><br/>${CL.ex_address}  <!--주소--></td>
								<td rowspan="2" colspan="3" id="txtRAddr">txtRAddr</td>       
                                <td class="textC">${CL.ex_engageAreaNum}  <!--종사업장번호--></td>  
							  </tr>
                              <tr>
                                <td class="textC" id="txtLJongmokNum">txtLJongmokNum</td>
                                <td class="textC" id="txtRJongmokNum">txtRJongmokNum</td>          
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_business}  <!--업태--></td>
								<td id="txtLBusinessType">txtLBusinessType</td>
								<td colspan="2" class="textC">${CL.ex_event}  <!--종목--></td>
								<td id="txtLJongmokName">txtLJongmokName</td>
								<td class="textC">${CL.ex_business}  <!--업태--></td>
								<td id="txtRBusinessType">txtRBusinessType</td>
								<td colspan="2" class="textC">${CL.ex_event}  <!--종목--></td>
								<td  id="txtRJongmokName">txtRJongmokName</td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_deptNm}  <!--부서명--></td>
								<td id="txtLDeptName">txtLDeptName</td>
								<td colspan="2" class="textC">${CL.ex_chargePerson}  <!--담당자--></td>
								<td id="txtLEmpName">txtLEmpName</td>
								<!-- 공급받는자 부서명, 담당자 --> 
								<td class="textC">${CL.ex_deptNm}  <!--부서명--></td>
								<td id=""></td>
								<td colspan="2" class="textC">${CL.ex_chargePerson}  <!--담당자--></td>
								<td id=""></td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_contact}  <!--연락처--></td>
								<td id="txtLTell">txtLTell</td>
								<td colspan="2" class="textC">${CL.ex_phone}  <!--휴대폰--></td>
								<td id="txtLCellPhone">txtLCellPhone</td>
								<!-- 공급받는자 연락처,휴대폰 번호 --> 
								<td class="textC">${CL.ex_contact}  <!--연락처--></td>
								<td id=""></td>
								<td colspan="2" class="textC">${CL.ex_phone}  <!--휴대폰--></td>
								<td id=""></td>
							  </tr>
							  <tr>
								<td class="textC">${CL.ex_email}  <!--E_Mail--></td>
								<td colspan="4" id="txtLEmail">txtLEmail</td>
								<td class="textC">${CL.ex_email}  <!--E_Mail--></td>
								<td colspan="4" id="txtREmail">txtREmail</td>
							  </tr>
							</table>		
						</td>
					</tr>
					<tr>
						<td colspan="4" class="p0">
							<!-- 작성일자 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Taxtabel red">
								<colgroup>
									<col width="6%" />
									<col width="6%" />
									<col width="6%" />
									<col width="23%" />
									<col width="22%" />
									<col width="" />
								</colgroup>
								<tr>
									<td colspan="3" class="textC">작성${CL.ex_day}  <!--일-->자</td>
									<td class="textC">${CL.ex_purPrice}  <!--공급가액--></td>
									<td class="textC">${CL.ex_taxAmount}  <!--세액--></td>
									<td class="textC">비고</td>
								</tr>
								<tr>
									<td class="textC" id="txtIssDateYear">txtIssDateYear</td>
									<td class="textC" id="txtIssDateMonth">txtIssDateMonth</td>
									<td class="textC" id="txtIssDateDate">txtIssDateDate</td>
									<td class="textR" id="txtStdAmt">txtStdAmt</td>
									<td class="textR" id="txtVatAmt">txtVatAmt</td>
									<td id="txtDummy1">txtDummy1</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<!-- 항목 없을때에 숨김 처리 --> 
						<td colspan="4" class="p0" id = "gridSubjectList">
							<!-- 품목명 리스트 -->
							<table width="100%" id="gridPrevGoods" border="0" cellspacing="0" cellpadding="0" class="Taxtabel red">
							  <colgroup>
									<col width="4%"/>
									<col width="4%"/>
									<col width="33%" />
									<col width="6%"/>
									<col width="6%"/>
									<col width="10%"/>
									<col width="10%"/>
									<col width="10%"/>
									<col width=""/>
								</colgroup>                              
							  <thead>
								  <tr>
									<td class="textC">${CL.ex_month}  <!--월--></td>
									<td class="textC">${CL.ex_day}  <!--일--></td>
									<td class="textC">${CL.ex_item}  <!--품목--></td>
									<td class="textC">${CL.ex_standard}  <!--규격--></td>
									<td class="textC">${CL.ex_volume}  <!--수량--></td>
									<td class="textC">${CL.ex_unitCost}  <!--단가--></td>
									<td class="textC">${CL.ex_purPrice}  <!--공급가액--></td>
									<td class="textC">${CL.ex_taxAmount}  <!--세액--></td>
									<td class="textC">비고</td>
								  </tr>
							  </thead>
							  <tbody id="tbl_itemList">
								  <tr>
									<td class="textC" id="txtItemDateMonth">txtItemDateMonth</td>
									<td class="textC" id="txtItemDateDate">txtItemDateDate</td>
									<td id="txtItemName">txtItemName</td>
									<td class="textC" id="txtItemStendard">txtItemStendard</td>
									<td class="textC" id="txtItemCnt">txtItemCnt</td>
									<td class="textR" id="txtItemUnitAmt">txtItemUnitAmt</td>
									<td class="textR" id="txtItemStdAmt">txtItemStdAmt</td>
									<td class="textR" id="txtItemVatAmt">txtItemVatAmt</td>
									<td id="txtItemNote">txtItemNote</td>
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
									<col width="10%"/>
									<col width="7%"/>
								</colgroup>
							  <tr>
								<td class="textC">${CL.ex_sumCost}  <!--합계금액--></td>
								<td rowspan="2" class="textC brrn fwb">${CL.ex_thisCost}  <!--이금액을--></td>
								<td rowspan="2" class="brrn lh18" id="txtDummy2">txtDummy2</td>
								<td rowspan="2" class="fwb">${CL.ex_ham}  <!--함--></td>
							  </tr>
							  <tr>
								<td class="textR" id="txtAmt">txtAmt</td>
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
	/*	[document.ready] 법인카드 상세내역 문서 준비
	-------------------------------------------------- */
	$(document).ready(function(){
		var eTaxInfo = {};
		
		<c:forEach var="item" items="${eTaxInfo}">
			eTaxInfo['${item.key}'] = "${item.value}".replaceAll("'","`");
		</c:forEach>
		
		var txtAuthNum = (eTaxInfo.authNum || '');
		var txtLSaupNum = (eTaxInfo.lSaupNum || '');
		var txtLTrName = (eTaxInfo.lTrName || '');
		var txtLCeoName = (eTaxInfo.lCeoName || '');
		
		var txtLAddr = (eTaxInfo.lDivAddr || '') + '<br>' + (eTaxInfo.lDivAddr2 || '');
		
		var txtLJongmokNum	 = (eTaxInfo.lJongmokNum || '');
		var txtLBusinessType = (eTaxInfo.lBusinessType || '');
		var txtLJongmokName = (eTaxInfo.lJongmokName || '');
		var txtLDeptName = (eTaxInfo.lDeptName || '');
		var txtLEmpName = (eTaxInfo.lEmpName || '');
		var txtLTell = (eTaxInfo.lTell || '');
		var txtLCellPhone = (eTaxInfo.lCellPhone || '');
		var txtLEmail = (eTaxInfo.lEmail || '');
		
		
		var txtRSaupNum = (eTaxInfo.rSaupNum || '');
		var txtRTrName = (eTaxInfo.rTrName || '');
		var txtRCeoName = (eTaxInfo.rCeoName || '');
		var txtRAddr = (eTaxInfo.rDivAddr || '') + '<br>' + (eTaxInfo.rDivAddr2 || '');
		var txtRJongmokNum = (eTaxInfo.rJongmokNum || '');
		var txtRBusinessType = (eTaxInfo.rBusinessType || '');
		var txtRJongmokName = (eTaxInfo.rJongmokName || '');
		var txtREmail = (eTaxInfo.rEmail || '');
		
		
		var txtDummy1 = (eTaxInfo.dummy1 || '');
		var txtItemName = (eTaxInfo.itemName || eTaxInfo.mainItemDc) || '';
		var txtItemStendard = (eTaxInfo.itemStendard || '-');
		var txtItemCnt = Number(eTaxInfo.itemCnt || '0') == 0 ? fnGetCurrencyCode('1', 0) : fnGetCurrencyCode(eTaxInfo.itemCnt, 0);
		var txtItemUnitAmt = Number(eTaxInfo.itemUnitAmt || '0') == 0 ? fnGetCurrencyCode(eTaxInfo.stdAmt, 0) : fnGetCurrencyCode(eTaxInfo.itemUnitAmt, 0);
		var txtItemStdAmt = Number(eTaxInfo.itemStdAmt || '0') == 0 ? fnGetCurrencyCode(eTaxInfo.stdAmt, 0) : fnGetCurrencyCode(eTaxInfo.itemStdAmt, 0);
		var txtItemVatAmt = Number(eTaxInfo.itemVatAmt || '0') == 0 ? fnGetCurrencyCode(eTaxInfo.vatAmt, 0) : fnGetCurrencyCode(eTaxInfo.itemVatAmt, 0);
		
		var txtItemNote = (eTaxInfo.itemNote || '');
		var txtDummy2 = (eTaxInfo.dummy2 || '');
		
		/* 날짜 처리 필요 */
		var txtIssDateYear = (eTaxInfo.issDate || '').substring(0, 4);
		var txtIssDateMonth = (eTaxInfo.issDate || '').substring(4, 6);
		var txtIssDateDate =  (eTaxInfo.issDate || '').substring(6, 8);
		
		var txtItemDateMonth = ((eTaxInfo.itemDateMonth || '').substring(0, 2) || (eTaxInfo.issDate || '').substring(4, 6)) || '';
		var txtItemDateDate =  (eTaxInfo.itemDateDate || '').substring(2, 4)  || (eTaxInfo.issDate || '').substring(6, 8);
		
		/* 금액 처리 필요. */
		var txtStdAmt = fnGetCurrencyCode(eTaxInfo.stdAmt, 0);
		var txtVatAmt = fnGetCurrencyCode(eTaxInfo.vatAmt, 0);
		var txtAmt = fnGetCurrencyCode(eTaxInfo.amt, 0);
		
		
		if('${eTaxInfo.taxTy}' == 1){
			$('.txtTaxTy').html('매출전자세금계산서');
		} else if('${eTaxInfo.taxTy}' == 2){
			$('.txtTaxTy').html('매입전자세금계산서');
		} else if('${eTaxInfo.taxTy}' == 3){
			$('.txtTaxTy').html('매출전자계산서');
		} else if('${eTaxInfo.taxTy}' == 4){
			$('.txtTaxTy').html('매입전자계산서');
		}  else{
			$('.txtTaxTy').html('전자(세금)계산서');
		}
		
		/* 승인번호 */
		$('#txtAuthNum').html('<span class="fwb">승인번호 : ' + txtAuthNum + '</span>');
		$('#txtLSaupNum').html(txtLSaupNum);
		$('#txtLTrName').html(txtLTrName);
		$('#txtLCeoName').html(txtLCeoName);
		$('#txtLAddr').html(txtLAddr);
		$('#txtLJongmokNum').html(txtLJongmokNum);
		$('#txtLBusinessType').html(txtLBusinessType);
		$('#txtLJongmokName').html(txtLJongmokName);
		$('#txtLDeptName').html(txtLDeptName);
		$('#txtLEmpName').html(txtLEmpName);
		$('#txtLTell').html(txtLTell);
		$('#txtLCellPhone').html(txtLCellPhone);
		$('#txtLEmail').html(txtLEmail);
		
		$('#txtRSaupNum').html(txtRSaupNum);
		$('#txtRTrName').html(txtRTrName);
		$('#txtRCeoName').html(txtRCeoName);
		$('#txtRAddr').html(txtRAddr);
		$('#txtRJongmokNum').html(txtRJongmokNum);
		$('#txtRBusinessType').html(txtRBusinessType);
		$('#txtRJongmokName').html(txtRJongmokName);
		$('#txtREmail').html(txtREmail);
		
		$('#txtDummy1').html(txtDummy1);
		$('#txtDummy2').html(txtDummy2);
		$('#txtStdAmt').html(txtStdAmt);
		$('#txtVatAmt').html(txtVatAmt);
		$('#txtAmt').html(txtAmt);
		$('#txtIssDateYear').html(txtIssDateYear);
		$('#txtIssDateMonth').html(txtIssDateMonth);
		$('#txtIssDateDate').html(txtIssDateDate);
		
		
		/* 물품 그리기 */
		<c:set var="myVar" value="Dale's Truck" />
		<c:set var="search" value="'" />
		<c:set var="replace" value="%27" />
		<c:set var="eTaxItemInfo" value="${fn:replace(eTaxItemInfo, search, replace)}"/>
		var itemListJSON = '${eTaxItemInfo}' || '';
		if(itemList == ''){
			itemList = '[]';
		}
		var itemList = JSON.parse(itemListJSON);
		
		if(itemList.length == 1){
			/* 단일건의 경우 1행 출력 */
			$('#txtItemDateMonth').html(txtItemDateMonth);
			$('#txtItemDateDate').html(txtItemDateDate);
			$('#txtItemName').html(txtItemName);
			$('#txtItemStendard').html(txtItemStendard);
			$('#txtItemCnt').html(txtItemCnt);
			$('#txtItemUnitAmt').html(txtItemUnitAmt);
			$('#txtItemStdAmt').html(txtItemStdAmt);
			$('#txtItemVatAmt').html(txtItemVatAmt);
			$('#txtItemNote').html(txtItemNote);
		}else{
			$('#tbl_itemList').empty();
			for(var i = 0; i < itemList.length; i++){
				var item = itemList[i];
				//항목이 있는 경우만 리스트 나타냄
				if(item.itemDate != '' && item.itemDate != null){
					var itemDateMonth = ( (item.itemDate || '').substring(4, 6) || (item.issDate || '').substring(4, 6) ) || '';
					var itemDateDate = ( (item.itemDate || '').substring(6, 8) || (item.issDate || '').substring(6, 8) ) || '';
					var itemCnt = Number(item.itemCnt || '0') == 0 ? fnGetCurrencyCode('1', 0) : fnGetCurrencyCode(item.itemCnt, 0);
					var itemUnitAmt = Number(item.itemUnitAmt || '0') == 0 ? 0 : fnGetCurrencyCode(item.itemUnitAmt, 0);
					var itemStdAmt = Number(item.itemStdAmt || '0') == 0 ? 0 : fnGetCurrencyCode(item.itemStdAmt, 0);
					var itemVatAmt = Number(item.itemVatAmt || '0') == 0 ? 0 : fnGetCurrencyCode(item.itemVatAmt, 0);
					
					var tr = '';
					tr += '<tr>';
					tr += '	<td class="textC" >' + itemDateMonth + '</td>';
					tr += '	<td class="textC" >' + itemDateDate + '</td>';
					tr += '	<td >' + (item.itemName || '') + '</td>';
					tr += '	<td class="textC" >' + (item.itemStendard || '') + '</td>';
					tr += '	<td class="textC" >' + itemCnt + '</td>';
					tr += '	<td class="textR" >' + itemUnitAmt + '</td>';
					tr += '	<td class="textR" >' + itemStdAmt + '</td>';
					tr += '	<td class="textR" >' + itemVatAmt + '</td>';
					tr += '	<td id="">' + (item.itemNote || '') + '</td>';
					tr += '</tr>';
					$('#tbl_itemList').append(tr);
				}else {
					$('#gridSubjectList').css('display','none');
				}
			}
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