<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Bizbox A</title>
    
     <!--css-->
	<link rel="stylesheet" type="text/css" href="../../../Scripts/jqueryui/jquery-ui.css"/>
    <link rel="stylesheet" type="text/css" href="../../../css/common.css">
	    
    <!--js-->
    <script type="text/javascript" src="../../../Scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="../../../Scripts/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="../../../Scripts/jqueryui/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../../../Scripts/common.js"></script>
</head>

<body>
	<div class="pop_wrap creditSlip">
		<div class="pop_head">
			<h1>${CL.ex_cardAppStatement}  <!--카드승인전표--></h1>
			<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
		</div>			
			
		<div class="pop_con mr25 ml25" style="">
			<div class="com_ta4 bgnth hover_no">
				<table>
					<colgroup>				
						<col width="100"/>
						<col />
					</colgroup>	
						<tr>
							<td class="ri">${CL.ex_cardNumber}  <!--카드번호--></td>
							<td class="fwb le" id="cardNum">  </td>
						</tr>
						<tr>
							<td class="ri">${CL.ex_dateApproval}  <!--승인일시--></td>
							<td class="fwb le" id="authDate"> </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_confirmationNumber}  <!--승인번호--></td>
							<td class="fwb le" id="authNum">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_affiliateNm}  <!--가맹점명--></td>
							<td class="fwb le" id="tradeName">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_businessNumber}  <!--사업자번호--></td>
							<td class="fwb le" id="tradeSeq">  </td>
						</tr>
						<tr id="tr_mccName">
							<td class="ri">${CL.ex_typeOfBusiness}  <!--업종--></td>
							<td class="fwb le" id="mccName">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_address}  <!--주소--></td>
							<td class="fwb le lh18 vt" style="height:35px;" id="addr">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_telephone}  <!--전화번호--></td>
							<td class="fwb le" id="tel">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_purPrice}  <!--공급가액--></td>
							<td class="fwb le" id="stdAmt">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_vat}  <!--부가세--></td>
							<td class="fwb le" id="vatAmt">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_serviceAmount}  <!--서비스금액--></td>
							<td class="fwb le" id="serAmt">  </td>
						</tr>
                        <tr>
							<td class="ri">${CL.ex_amount}  <!--금액--></td>
							<td class="fwb le" id="amt">  </td>
						</tr>
					</tbody>
				</table>								
			</div>
		</div><!--// pop_con -->		
	</div><!--// pop_wrap -->
</body>
</html>


<script>
	/*	[document.ready] 법인카드 상세내역 문서 준비
	-------------------------------------------------- */
	$(document).ready(function(){
		window.resizeTo(448, 558);
		
		var cardNum = '${cardInfo.cardNum}';
		var authDate = '${cardInfo.authDate}'; 
		var authTime = '${cardInfo.authTime}';
		var authNum = '${cardInfo.authNum}';
		<c:set var="search" value="'" />
		<c:set var="replace" value="`" />
		<c:set var="cardTradeName" value="${fn:replace(cardInfo.mercName, search, replace)}"/>
		var tradeName = '${cardTradeName}';
		var tradeSeq = '${cardInfo.mercSaupNo}';
		var addr = '${cardInfo.mercAddr}';
		var tel = '${cardInfo.mercTel}';
		var georaeStat = '${cardInfo.georaeStat}';
		var stdAmt = '${cardInfo.amt_md_amount}';
		var vatAmt = '${cardInfo.vat_md_amount}';
		var serAmt = '${cardInfo.serAmount}';
		var amt = '${cardInfo.requestAmount}';
		
		var mccName = '${cardInfo.mccName}';
		if(!mccName){
			$('#tr_mccName').remove();
		}else if(mccName){
			window.resizeTo(445, 600); 
		}
		
		$('#cardNum').html(fnGetCardCode(cardNum));
		$('#authDate').html(fnGetAuthDate(authDate, authTime));
		$('#mccName').html(mccName);
		$('#authNum').html(authNum);
		$('#tradeName').html(tradeName);
		$('#tradeSeq').html(tradeSeq);
		$('#addr').html(addr);
		$('#tel').html(tel);
		
		$('#stdAmt').html( fnGetCurrencyCode( fnMinusAmtCheck(georaeStat, stdAmt), 0 ) );
		$('#vatAmt').html( fnGetCurrencyCode( fnMinusAmtCheck(georaeStat, vatAmt), 0 ) );
		$('#serAmt').html( fnGetCurrencyCode( fnMinusAmtCheck(georaeStat, serAmt), 0 ) );
		$('#amt').html( fnGetCurrencyCode( fnMinusAmtCheck(georaeStat, amt), 0 ) );
		
		if(georaeStat === '0'){
			$('#stdAmt, #vatAmt, #serAmt, #amt').css('color', 'red');	
		}
	});
	
	function fnMinusAmtCheck(georaeStat, amtValue){
		if(georaeStat === '0'){
			/* 승인 취소 건 */
			if(amtValue.indexOf('-') < 0){
				if(Number(amtValue.replace(/,/g, '')) != 0){
					amtValue = '-' + amtValue;
				}
			}
		}
		
		return amtValue;
	} 

	/*  [공통함수] 날짜 표기 형태 리턴 
	Params / 날짜, 시간
	valeu      : 통화 코드 적용 밸류
	-----------------------------------------------------*/
	function fnGetAuthDate(date, time){
		var authDate = date.replace(/[^0-9]/g,'');
		var authTime = time.replace(/[^0-9]/g,'');
		
		return authDate.substring(0, 4) + '-'+ authDate.substring(4, 6) + '-'+ authDate.substring(6, 8) 
		+ ' ' +authTime.substring(0, 2) + ':'+ authTime.substring(2, 4) + ':'+ authTime.substring(4, 6);
	}
	
	/*  [공통함수] 카드 번호 표기 형태 리턴 
	Params / 카드 번호
	valeu      : 통화 코드 적용 밸류
	-----------------------------------------------------*/
	function fnGetCardCode(val){
		var cardNum = val.replace(/[^0-9]/g,'');
		return cardNum.substring(0, 4) + '-'+ cardNum.substring(4, 8) + '-'+ cardNum.substring(8, 12) + '-'+ cardNum.substring(12, 16);
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