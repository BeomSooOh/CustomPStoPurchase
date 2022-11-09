<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

 

<!-- datatables -->
<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>

<!--Ezbaro js -->
<script type="text/javascript" src='<c:url value="/js/ezbaro/EzbaroAjax.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ezbaro/EzbaroCommon.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ezbaro/EzbaroEvtFocus.js"></c:url>'></script>



<script type="text/javascript">

/* ------------------------------------------------------------------------- */ 
/* 이지바로 스크립트 변수 지정
/* ------------------------------------------------------------------------- */

// 이지바로 화면타입
var g_chejuType = '';

// 결재작성 양식 아이디
var form_id = "${param.form_id}";

//이지바로 사용자 기본결의정보
var g_EzBasicInfo = {};

//기본내역
var g_EzLevel1 = {};

//상세내역
var g_EzLevel2 = {};

//품목상세 내역
var g_EzLevel3 ={
	'length' : 0
};

//전자결재 인터락에 표현할 변수
var g_EzInterlock = {}

//level1,2 리턴값
var g_exec_req = {};

//결의서 키값
var g_task_sq = 0; 

//ERP 연동키 값
var g_sync_seq = '';

//GW 마스터 값
var g_master_seq = 0;

//이지바로 팝업 파라메터 정보
var g_EzPopupParam = {CO_CD:'' 	 ,LANGKIND : ''		,PRJNO:''	,OFCODE:''
					,BIZGRP:''	 ,CODEDIV:''		,BMCODE:''	,P_HELP_TY:''
					,P_CODE:''	 ,P_CODE2:''		,P_CODE3:''	,P_USE_YN:''
					,P_NAME:''	 ,P_STD_DT:''		,P_WHERE:''	,RESPERSONNO:''};

var g_focus = {
		cusor : '0', //현재 인덱스 위치
		list : [] // 리스트 정보
}


/* ------------------------------------------------------------------------- */ 
/* 이지바로 스크립트 수행
/* ------------------------------------------------------------------------- */

$(document).ready(function() {			
	fnPageLoad();
	fnGetAcctUnit();
	fnGetDeptUser();
	fnSetWriteDate();	
	
});


//화면 우측상단 작성일 지정 함수
function fnSetWriteDate(){
	
	if(g_EzBasicInfo.WriteDate === undefined || g_EzBasicInfo.WriteDate === '')
	{
		var d = new Date();
		var month  = 0;
		var day = 0;
		if(d.getMonth() + 1 < 9)
		{
			month = '0' + Number(d.getMonth() + 1);
		}
		else
		{
			month = d.getMonth() + 1;
		}
		
		if(d.getDate() < 10)
		{
			day = '0' + d.getDate();
		}
		else
		{
			day = d.getDate();
		}
		var todayDate = d.getFullYear() +'-'+ month +'-'+ day;
		
		$("#txtWriteDate").val(todayDate);
		g_EzBasicInfo.WriteDate = $("#txtWriteDate").val();
		g_EzLevel1.TASK_DT = $("#txtWriteDate").val().replaceAll('-','');
	}
	else
	{
		g_EzBasicInfo.WriteDate = $("#txtWriteDate").val();
		g_EzLevel1.TASK_DT = $("#txtWriteDate").val().replaceAll('-','');
	}
	
}



/*************************************
 * 개발자 도구 함수
 1.fnShowAllDiv  : 전체 화면보기
 2.fnCheck : 이지바로 변수 확인
 *************************************/
function fnShowAllDiv()
{
	$('.type_div').show();
	$('#C1').show();
	$('#C2').show();
	$('#C3').show();
	$('#C4').show();
	$('#C5').show();
	$('#C6').show();
	$('#C7').show();
	$('#C8').show();
	$('#C9').show();
	$('#CA').show();
}
function fnCheck(){
	alert('체주타입 : '+g_chejuType);
	alert('연동키값 : '+g_sync_seq);
	alert('팝업:'+JSON.stringify(g_EzPopupParam));
	alert('기본내역 :'+JSON.stringify(g_EzBasicInfo));
	alert('결의내역 :'+JSON.stringify(g_EzLevel1));
	alert('상세내역 :'+JSON.stringify(g_EzLevel2));
	alert('품의상세내역 :'+JSON.stringify(g_EzLevel3));
	alert('ERP 프로시저 파라메터 값 :'+JSON.stringify(g_exec_req));

}
	

</script>
</head>
<body>
<input type="hidden" id="hidExecMethod"></input>
<input type="hidden" id="hidDetails"></input>
<input type="hidden" id="hidUse"></input>

<div id='divDevelopBtn' style="display:none;">
	<!-- <button onClick = 'fnShowAllDiv()'>전체 체주유형 및 전체 품목상세보기 </button> -->
	<button onClick ='fnCheck()'>전역변수 체크</button>
	<button onClick ='fnModifyLevel1ERP()'>leve2 임시 업데이트 </button>
	<button onClick ='fnModifyLevel3ERP()'>leve3 인서트 호출 </button>
	<button onClick ='CallApploaval()'>[테스트]전자결재 상신 </button>
	<button onClick = 'fnGetLevel1FocusID()'>결의내역 포커스리스트</button>
	<button onClick = 'fnGetLevel2FocusID()'>상세내역 포커스리스트</button>
	<button onClick = 'fnGetAllFocusID()'>전체내역 포커스리스트</button>
</div>

	<div class="pop_sign_wrap" style="width:998px">
		<div class="pop_sign_head posi_re">
			<h1>Ezbaro <%=BizboxAMessage.getMessage("TX000009969","결의정보등록")%> </h1>
			<div class="psh_btnbox">
				<!-- 양식팝업 오른쪽 버튼그룹 -->
				<div class="psh_right">
					<div class="btn_cen mt8">
						<input type="button" id='btnEAWrite' class="psh_btn" value="<%=BizboxAMessage.getMessage("TX000003154","결재작성")%>">
					</div>
				</div>
			</div>
		</div>	
					
		<!--  기본내역/결의내역 시작 -->
		<div class="pop_con">
            <div class="top_box">
                <dl>
                    <dt><%=BizboxAMessage.getMessage("TX000002866","회계단위")%></dt>
                    <dd style="width:177px;">
                        <input type="text" id="txtAcctUnit" style="width:140px;" />
                        <!--  <a href="#" id="btnAcctUnit" class="btn_search"></a> -->
                    </dd>
                    <dt><%=BizboxAMessage.getMessage("TX000009968","결의부서")%> / <%=BizboxAMessage.getMessage("TX000002723","작성자")%></dt>
                    <dd style="width:177px;">
                        <input type="text" id="txtDeptUser" style="width:140px;" />
                        <!--  <a href="#" id="btnDeptUser" class="btn_search"></a> -->
                    </dd>
                    <dt><%=BizboxAMessage.getMessage("TX000000612","작성일")%></dt>
                    <dd><input id="txtWriteDate" class="dpWid" onchange = "fnSetWriteDate()" /> </dd>
                </dl>
            </div>

            <p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009967","결의내역")%></p>
			<div class="controll_btn pt15 fr">
				<button onClick= 'fnReset()'><%=BizboxAMessage.getMessage("TX000002960","초기화")%></button>
				<button id="btnTypeSearch" onClick='fnSetDisplay()''><%=BizboxAMessage.getMessage("TX000000899","조회")%></button>				
			</div>

            <div id='divReport' class="com_ta hover_no">
                <table>
                    <colgroup>
                        <col width="11%" />
                        <col width="14%" />
                        <col width="11%" />
                        <col width="14%" />
                        <col width="11%" />
                        <col width="14%" />
                        <col width="11%" />
                        <col width="" />
                    </colgroup>
                    <tr>
                        <th><%=BizboxAMessage.getMessage("TX000009966","연구과제")%></th>
                        <td colspan="3" class="le">
                            <input class="k-textbox input_search" id="txtProJect" type="text" value="" style="width:92.4%;" readonly='readonly' />
                            <a href="#" id="btnProJect" class="btn_search"></a>
                        </td>
                        <th><%=BizboxAMessage.getMessage("TX000009965","세목")%></th>
                        <td class="le">
                            <input class="k-textbox input_search" id="txtDetails" type="text" value="" style="width:78%;" readonly='readonly' />
                            <a href="#" id="btnDetails" class="btn_search"></a>
                        </td>
                        <th><%=BizboxAMessage.getMessage("TX000009964","사용용도")%></th>
                        <td class="le">
                            <input class="k-textbox input_search" id="txtUse" type="text" value="" style="width:78%;" readonly='readonly' />
                            <a href="#" id="btnUse" class="btn_search"></a>
                        </td>
                    </tr>
                    <tr>
                        <th>G20<%=BizboxAMessage.getMessage("TX000000519","프로젝트")%></th>
                        <td class="le">
                            <input class="k-textbox input_search" id="txtG20Project" type="text" value="" style="width:98%;" readonly='readonly'  onChange="fnEzInputChangeEvt('1','txtG20Project')"/>
                        </td>
                        <th>G20<%=BizboxAMessage.getMessage("TX000003622","예산과목")%></th>
                        <td class="le">
                            <input class="k-textbox input_search" id="txtG20BgSubj"  type="text" value="" readonly='readonly' style="width:98%;" />
                           <!-- <a href="#" id="btnG20BgSubj" class="btn_search"></a>--> 
                        </td>
                        <th><%=BizboxAMessage.getMessage("TX000009963","집행방법")%></th>
                        <td class="le">
                            <input class="k-textbox input_search" id="txtExecMethod" type="text" value="" readonly='readonly' style="width:78%;" />
                            <a href="#" id="btnExecMethod" class="btn_search"></a>
                        </td>
                        <th><%=BizboxAMessage.getMessage("TX000009962","집행요청구분")%></th>
                        <td class="le">
                            <input class="k-textbox input_search" id="txtExecReqGb" type="text" value="" readonly='readonly' style="width:78%;" />
                            <a href="#" id="btnExecReqGb" class="btn_search"></a>
                        </td>
                    </tr>                   
                </table>
            </div>
		<!--  기본내역/결의내역 끝 -->
			

		<!-- 상세내역 시작 -->
		
            <!--A-1 Type -->
            <div class="type_div type A1" style="display:none;">

                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>

                <div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%"></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:78%;" placeholder="">
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcApprovalNum" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000011204","출장자")%></th>
							<td class="le" colspan='3'>
								<input class="k-textbox input_search" id="txtEntrant" type="text" value="" style="width:78%;" placeholder=""/>
								<a href="#" id="btnEntrant" class="btn_search"></a>
							</td>
                        </tr>						
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtBankName" type="text" value="" style="width:78%;" placeholder="">
								<a href="#" id="btnBankName" class="btn_search"></a>
							</td>
							<th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le">
								<input type="text" id="txtBankAccNum" style="width:99%">
							</td>
							<th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le">
								<input type="text" id="txtBankAccHolder" style="width:99%">
							</td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br><%=BizboxAMessage.getMessage("","공급자명")%></th>
							<td class="le"><input type="text" id="txtTaxCalcProvider" style="width: 99%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le">
								<input type="text" id="txtTotalAmt" class="ar pr5" style="width:94%">
							</td>							
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le">
								<input type="text" id="txtTaxAmt" class="ar pr5" style="width:94%">
							</td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le">
								<input type="text" id="txtSupplyAmt" class="ar pr5" style="width:94%">
							</td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br><%=BizboxAMessage.getMessage("TX000000024","사업자번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcLicenseNum" style="width: 99%"></td>
						</tr>						
                    </table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
                <div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>


            </div>
            <!--// A-1 Type -->

            <!--A-2 Type -->
            <div class="type_div type A2" style="display:none;">

                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>

                <div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
                        <tr>
                            <th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le" colspan="3">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:93%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>    
                        </tr>
                        <tr>                        
                         <tr>
                            <th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le" colspan="3">
								<input class="k-textbox input_search" id="txtBankName" type="text" value="" style="width:93%;" placeholder=""/>
								<a href="#" id="btnBankName" class="btn_search"></a>
							</td>
							<th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le">
								<input type="text" id="txtBankAccHolder" style="width:100%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcApprovalNum" style="width: 99%" /></td>                           							
                        </tr>
                        <tr>
                        	<th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le" colspan="3">
								<input type="text" id="txtBankAccNum" style="width:99%" />
							</td>
                      		<th><%=BizboxAMessage.getMessage("TX000004695","지급처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtJigubcher" type="text" value="" style="width:100%;" placeholder=""/>
							</td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("","공급자명")%></th>
							<td class="le"><input type="text" id="txtTaxCalcProvider" style="width: 99%" /></td>
                        </tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le">
								<input type="text" id="txtTotalAmt" class="ar pr5" style="width:95%" />
							</td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le">
								<input type="text" id="txtTaxAmt" class="ar pr5" style="width:95%" />
							</td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le">
								<input type="text" id="txtSupplyAmt" class="ar pr5" style="width:95%" />
							</td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000000024","사업자번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcLicenseNum" style="width: 99%" /></td>
                        </tr>
                    </table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
                <div><textarea name="" id="txtResolNote" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>
            </div>
            <!--// A-2 Type -->


            <!-- A3 Type -->
            <div class="type_div type A3" style=" display:none;">
				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>

                <div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
                        <tr>
                            <th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:84%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
                        </tr>
						<tr>
                            <th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtBankName" type="text" value="" style="width:84%;" placeholder=""/>
								<a href="#" id="btnBankName" class="btn_search"></a>
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le" colspan="3">
								<input type="text" id="txtBankAccNum" style="width:99.5%" />
							</td>
                        </tr>
                        <tr>
                        	<th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le">
								<input type="text" id="txtBankAccHolder" style="width:99%" />
							</td>
                        	<th><%=BizboxAMessage.getMessage("TX000009951","위탁기관")%></th>
							<td class="le"><input type="text" id="txtConsOrg" style="width:99%" value=""/></td>
							<th><%=BizboxAMessage.getMessage("TX000009950","위탁사업자번호")%></th>
							<td class="le"><input type="text" id="txtConsOrgNum" style="width:99%" value=""/></td>
                        </tr>
                        <tr>
                        	<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
                        	<td class="le"><input type="text" id="txtTaxCalcApprovalNum" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("","공급자명")%></th>
							<td class="le"><input type="text" id="txtTaxCalcProvider" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000000024","사업자번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcLicenseNum" style="width: 99%" /></td>
						</tr>                        
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le">
								<input type="text" id="txtTotalAmt" class="ar pr5" style="width:94%" />
							</td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le">
								<input type="text" id="txtTaxAmt" class="ar pr5" style="width:94%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le">
								<input type="text" id="txtSupplyAmt" class="ar pr5" style="width:94%" />
							</td>                                                       
                        </tr>
                    </table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
                <div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            
            <!-- A4 Type -->
            <div class="type_div type A4" style=" display:none;">
				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>

                <div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
                        <tr>
                            <th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le" colspan="3">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:93%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
                        </tr>
                         <tr>
                         	                           
                        </tr>
                        <tr>
                         <th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtBankName" type="text" value="" style="width:78%;" placeholder=""/>
								<a href="#" id="btnBankName" class="btn_search"></a>
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le" colspan="3">
								<input type="text" id="txtBankAccNum" style="width:99.5%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le">
								<input type="text" id="txtBankAccHolder" style="width:99%" />
							</td>
                        </tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000011204","출장자")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtEntrant" type="text" value="" style="width:78%;" placeholder=""/>
								<a href="#" id="btnEntrant" class="btn_search"></a>
							</td>
                             <th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le">
								<input type="text" id="txtTotalAmt" class="ar pr5" style="width:94%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le">
								<input type="text" id="txtTaxAmt" class="ar pr5" style="width:94%" />
							</td>
							 <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le">
								<input type="text" id="txtSupplyAmt" class="ar pr5" style="width:94%" />
							</td>
                        </tr>
                    </table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
                <div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            
            
            <!-- A5 Type -->
            <div class="type_div type A5" style=" display:none;">
				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>

                <div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
                        <tr>
                            <th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:78%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
							<th><%=BizboxAMessage.getMessage("TX000000978","성명")%></th>
							<td class="le"><input type="text" id="txtName" style="width: 75%" value="" /> <a href="#" id="btnName" class="btn_search"></a></td>
                        </tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtBankName" type="text" value="" style="width: 78%;" placeholder="" /> <a href="#" id="btnBankName" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le"><input type="text" id="txtBankAccNum" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le"><input type="text" id="txtBankAccHolder"	style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000004695","지급처")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtJigubcher" type="text" value="" style="width: 99%;" placeholder="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000706","소속")%></th>
							<td class="le"><input type="text" id="txtSosok" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le">
								<input type="text" id="txtTotalAmt" class="ar pr5" style="width:94%" />
							</td>                           
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le">
								<input type="text" id="txtTaxAmt" class="ar pr5" style="width:94%" />
							</td>
                             <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le">
								<input type="text" id="txtSupplyAmt" class="ar pr5" style="width:94%" />
							</td>
                        </tr>
                    </table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
                <div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            <!--  A6 Type --> 
            <div class="type_div type A6" style=" display:none;">
				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>

                <div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
                        <tr>
                            <th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le" colspan="3">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:93%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
                        </tr>
                         <tr>
                            <th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtBankName" type="text" value="" style="width:78%;" placeholder=""/>
								<a href="#" id="btnBankName" class="btn_search"></a>
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le" colspan="3">
								<input type="text" id="txtBankAccNum" style="width:99%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le">
								<input type="text" id="txtBankAccHolder" style="width:99%" />
							</td>							
                        </tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004695","지급처")%></th>
							<td class="le">
								<input type="text" id="txtJigubcher" style="width: 99%">
							</td>
                           <th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le">
								<input type="text" id="txtTotalAmt" class="ar pr5" style="width:94%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le">
								<input type="text" id="txtTaxAmt" class="ar pr5" style="width:94%" />
							</td>
							 <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le">
								<input type="text" id="txtSupplyAmt" class="ar pr5" style="width:94%" />
							</td>
                        </tr>
                    </table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
                <div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>

            <!-- A7 Type -->
            <div class="type_div type A7" style="display:none;">
				 <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>

                <div class="com_ta hover_no mt10">
                    <table>
                        <colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
                        <tr>
                            <th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
                            <th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:83%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>                       
                        </tr>
                         <tr>
                            <th><%=BizboxAMessage.getMessage("TX000009959","지급은행")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtBankName" type="text" value="" style="width:83%;" placeholder=""/>
								<a href="#" id="btnBankName" class="btn_search"></a>
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000009958","지급계좌번호")%></th>
							<td class="le">
								<input type="text" id="txtBankAccNum" style="width:99%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000009957","지급예금주")%></th>
							<td class="le">
								<input type="text" id="txtBankAccHolder" style="width:98%" />
							</td>                         
                        </tr>
						<tr>
                            <th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le">
								<input type="text" id="txtTotalAmt" class="ar pr5" style="width:94%" />
							</td>
                            <th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le">
								<input type="text" id="txtTaxAmt" class="ar pr5" style="width:95%" />
							</td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le">
								<input type="text" id="txtSupplyAmt" class="ar pr5" style="width:94%" />
							</td>							
                        </tr>                    
                    </table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
                <div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            <!--// A7 Type -->


            <!-- B1 Type -->
            <div class="type_div type B1" style="display:none;">
                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>
				<div class="com_ta hover_no mt10">
					<table>
						<colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:82%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009952","거래일")%></th>
							<td class="le" colspan="5"><input id="txtDealDate" style="width: 19%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004699","카드번호")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtCardNum" type="text" value="" style="width: 84%;" /> <a href="#" id="btnCardNum" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtApprovalNum" style="width: 99%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005310","청구일련번호")%></th>
							<td class="le"><input type="text" id="txtSerialNum" style="width: 97.2%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcApprovalNum" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("","공급자명")%></th>
							<td class="le"><input type="text" id="txtTaxCalcProvider" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000000024","사업자번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcLicenseNum"	style="width: 97.2%" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTotalAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTaxAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtSupplyAmt" style="width: 94%" /></td>
						</tr>
					</table>
				</div>
				

			<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
			<div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            
            <!-- B2 Type -->
            <div class="type_div type B2" style="display:none;">
                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>
				<div class="com_ta hover_no mt10">
						<table>
						<colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:82%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009952","거래일")%></th>
							<td class="le"><input id="txtDealDate" style="width: 100%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000004695","지급처")%></th>
							<td class="le" colspan="3">
								<input type="text" id="txtJigubcher" style="width: 31.6%">
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004699","카드번호")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtCardNum" type="text" value="" style="width: 84%;" /> <a href="#" id="btnCardNum" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtApprovalNum" style="width: 99%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005310","청구일련번호")%></th>
							<td class="le"><input type="text" id="txtSerialNum" style="width: 97.2%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcApprovalNum" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("","공급자명")%></th>
							<td class="le"><input type="text" id="txtTaxCalcProvider" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000000024","사업자번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcLicenseNum"	style="width: 97.2%" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTotalAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTaxAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtSupplyAmt" style="width: 94%" /></td>
						</tr>
					</table>
				</div>
				

			<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
			<div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            
             <!-- B3 type -->
            <div class="type_div type B3" style="display:none;">
                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>
				<div class="com_ta hover_no mt10">
						<table>
						<colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:82%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009952","거래일")%></th>
							<td class="le"><input id="txtDealDate" style="width: 100%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000009951","위탁기관")%></th>
							<td class="le"><input type="text" id="txtConsOrg" style="width:99%" value=""/></td>
							<th><%=BizboxAMessage.getMessage("TX000009950","위탁사업자번호")%></th>
							<td class="le"><input type="text" id="txtConsOrgNum" style="width:99%" value=""/></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004699","카드번호")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtCardNum" type="text" value="" style="width: 84%;" /> <a href="#" id="btnCardNum" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtApprovalNum" style="width: 99%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005310","청구일련번호")%></th>
							<td class="le"><input type="text" id="txtSerialNum" style="width: 97.2%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcApprovalNum" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("","공급자명")%></th>
							<td class="le"><input type="text" id="txtTaxCalcProvider" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000000024","사업자번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcLicenseNum"	style="width: 97.2%" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTotalAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTaxAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtSupplyAmt" style="width: 94%" /></td>
						</tr>
					</table>
				</div>
				

			<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
			<div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            
               <!-- B4 Type -->
            <div class="type_div type B4" style="display:none;">
                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>
				<div class="com_ta hover_no mt10">
				<table>
						<colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:82%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009952","거래일")%></th>
							<td class="le"><input id="txtDealDate" style="width: 100%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000011204","출장자")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtEntrant" type="text" value="" style="width: 83%;" /> <a	href="#" id="btnEntrant" class="btn_search"></a></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004699","카드번호")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtCardNum" type="text" value="" style="width: 84%;" /> <a href="#" id="btnCardNum" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtApprovalNum" style="width: 99%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005310","청구일련번호")%></th>
							<td class="le"><input type="text" id="txtSerialNum" style="width: 97.2%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcApprovalNum" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("","공급자명")%></th>
							<td class="le"><input type="text" id="txtTaxCalcProvider" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005997","세금계산서")%><br /><%=BizboxAMessage.getMessage("TX000000024","사업자번호")%></th>
							<td class="le"><input type="text" id="txtTaxCalcLicenseNum"	style="width: 97.2%" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTotalAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTaxAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtSupplyAmt" style="width: 94%" /></td>
						</tr>
					</table>
				</div>
				

			<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
			<div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            
            <!-- B5 Type -->
            <div class="type_div type B5" style="display:none;">

                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>
                <div class="com_ta hover_no mt10">
                   <table>
						<colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:82%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009952","거래일")%></th>
							<td class="le" colspan="5"><input id="txtDealDate" style="width: 19%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004699","카드번호")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtCardNum" type="text" value="" style="width: 84%;" /> <a href="#" id="btnCardNum" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtApprovalNum" style="width: 99%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005310","청구일련번호")%></th>
							<td class="le"><input type="text" id="txtSerialNum" style="width: 97.2%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000706","소속")%></th>
							<td class="le"><input type="text" id="txtSosok" style="width: 99%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000978","성명")%></th>
							<td class="le"><input type="text" id="txtName" style="width: 80%" value="" /> <a href="#" id="btnName" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000004695","지급처")%></th>
							<td class="le"><input type="text" id="txtJigubcher" style="width: 98%"></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTotalAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTaxAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtSupplyAmt" style="width: 94%" /></td>
						</tr>
					</table>
                </div>

				<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>	
				<div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>
				
            </div>
            

			<!-- B6 Type -->
            <div class="type_div type B6" style="display:none;">
                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>
				<div class="com_ta hover_no mt10">
					 <table>
						<colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:82%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009952","거래일")%></th>
							<td class="le"><input id="txtDealDate" style="width: 100%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000004695","지급처")%></th>
							<td class="le" colspan="3">
								<input type="text" id="txtJigubcher" style="width: 31.6%">
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004699","카드번호")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtCardNum" type="text" value="" style="width: 84%;" /> <a href="#" id="btnCardNum" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtApprovalNum" style="width: 99%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005310","청구일련번호")%></th>
							<td class="le"><input type="text" id="txtSerialNum" style="width: 97.2%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTotalAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTaxAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtSupplyAmt" style="width: 94%" /></td>
						</tr>
					</table>
				</div>

			<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
			<div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
            
		<!--  B7 Type  -->
 			<div class="type_div type B7" style="display:none;">
                <p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000000512","상세내역")%></p>
				<div class="com_ta hover_no mt10">
					 <table>
						<colgroup>
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="14%" />
							<col width="11%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000506","결의일자")%></th>
							<td><input id="txtResolDate" value="" style="width:100%" /></td>
							<th>G20<%=BizboxAMessage.getMessage("TX000009961","거래처구분")%></th>
							<td class="le">
								<input type="text" id="txtG20PartnerGb" style="width: 99%">
							</td>
							<th>G20<%=BizboxAMessage.getMessage("TX000000520","거래처")%></th>
							<td class="le">
								<input class="k-textbox input_search" id="txtG20Partner" type="text" value="" style="width:82%;" placeholder=""/>
								<a href="#" id="btnG20Partner" class="btn_search"></a>
							</td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000009952","거래일")%></th>
							<td class="le" colspan="5"><input id="txtDealDate" style="width: 19%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000004699","카드번호")%></th>
							<td class="le"><input class="k-textbox input_search" id="txtCardNum" type="text" value="" style="width: 84%;" /> <a href="#" id="btnCardNum" class="btn_search"></a></td>
							<th><%=BizboxAMessage.getMessage("TX000005311","승인번호")%></th>
							<td class="le"><input type="text" id="txtApprovalNum" style="width: 99%" value="" /></td>
							<th><%=BizboxAMessage.getMessage("TX000005310","청구일련번호")%></th>
							<td class="le"><input type="text" id="txtSerialNum" style="width: 97.2%" value="" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000000538","결의금액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTotalAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtTaxAmt" style="width: 94%" /></td>
							<th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
							<td class="le"><input type="text" class="ar pr5" id="txtSupplyAmt" style="width: 94%" /></td>
						</tr>
					</table>
				</div>

			<p class="tit_p mt20"><%=BizboxAMessage.getMessage("TX000009954","결의내용")%></p>
			<div><textarea id="txtResolNote" name="" rows="4" style="padding:5px; width:98.8%; overflow:auto;"></textarea></div>

            </div>
		<!-- 상세내역 끝 -->
		
		
		
		
		
		<!--  품의상세 시작 -->
			<!-- C1 Type -->
			<div id="C1" style="display:none">			
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000007208","품목")%></button>				
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                            <col width="34" />
                            <col width="130" />
                            <col width="70" />
                            <col width="60" />
                            <col width="105" />
                            <col width="105" />
                            <col width="105" />
                            <col width="130" />
                            <col width="90" />
                            <col width="" />
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>
                            </th>
                            <th><%=BizboxAMessage.getMessage("TX000007208","품목")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000467","규격")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000004231","수량")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000468","단가")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009948","물품구분")%></th>
                            <th>NTIS<%=BizboxAMessage.getMessage("TX000000876","등록일자")%></th>
                            <th>NTIS<%=BizboxAMessage.getMessage("TX000004891","등록번호")%></th>
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
                        <colgroup>
                            <col width="34" />
                            <col width="130" />
                            <col width="70" />
                            <col width="60" />
                            <col width="105" />
                            <col width="105" />
                            <col width="105" />
                            <col width="130" />
                            <col width="90" />
                            <col width="" />
                        </colgroup>
                        
                    </table>
                </div>
			</div>
			
			
			<!-- C2 Type -->
			<div id="C2" style="display:none">		
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>	
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                            <col width="34">
                            <col width="100">
                            <col width="130">
                            <col width="130">
                            <col width="85">
                            <col width="85">
                            <col width="90">
                            <col width="90">
                            <col width="100">
                            <col width="">
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>                                
                            </th>
                            <th><%=BizboxAMessage.getMessage("TX000004659","출장목적")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000011205","출장시작일")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000011203","출장종료일")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009945","출장시작시간")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009944","출장종료시간")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000004732","출발지")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000004733","도착지")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009943","시내외구분")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009960","연구자")%><br /><%=BizboxAMessage.getMessage("TX000009946","연구자등록번호")%></th>
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
                       <colgroup>
                            <col width="34">
                            <col width="100">
                            <col width="130">
                            <col width="130">
                            <col width="85">
                            <col width="85">
                            <col width="90">
                            <col width="90">
                            <col width="100">
                            <col width="">
                        </colgroup>               
                    </table>
                </div>
			</div>	
			
			
			<!-- C3 Type -->
			<div id="C3" style="display:none">			
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>			
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                            <col width="34" />
                            <col width="310" />
                            <col width="100" />
                            <col width="90" />
                            <col width="140" />
                            <col width="140" />
                            <col width="" />
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>         
                            </th>
                            <th><%=BizboxAMessage.getMessage("TX000007208","품목")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000467","규격")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000004231","수량")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000468","단가")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009948","물품구분")%></th>
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
						<colgroup>
                            <col width="34" />
                            <col width="310" />
                            <col width="100" />
                            <col width="90" />
                            <col width="140" />
                            <col width="140" />
                            <col width="" />
                        </colgroup>                       
                    </table>
                </div>
			</div>
			
			
			<!-- C4 Type -->
			<div id="C4" style="display:none">			
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>			
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                            <col width="34" />
							<col width="140" />
                            <col width="140" />
                            <col width="140" />
                            <col width="130" />
                            <col width="130" />
							<col width="100" />
							<col width="" />
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>         
                            </th>
                            <th><%=BizboxAMessage.getMessage("TX000007208","품목")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000467","규격")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000004231","수량")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000468","단가")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
                            <th><%=BizboxAMessage.getMessage("","총구입액")%></th>
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
						<colgroup>
                             <col width="34" />
							<col width="140" />
                            <col width="140" />
                            <col width="140" />
                            <col width="130" />
                            <col width="130" />
							<col width="100" />
							<col width="" />
                        </colgroup>                       
                    </table>
                </div>
			</div>
			
			<!-- C5 Type -->
			<div id="C5" style="display:none">			
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>			
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                            <col width="34" />
                            <col width="310" />
                            <col width="100" />
                            <col width="90" />
                            <col width="140" />
                            <col width="140" />
                            <col width="" />
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>         
                            </th>
                            <th><%=BizboxAMessage.getMessage("TX000007208","품목")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000467","규격")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000004231","수량")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000468","단가")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>                  
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
						<colgroup>
                           <col width="34" />
                            <col width="310" />
                            <col width="100" />
                            <col width="90" />
                            <col width="140" />
                            <col width="140" />
                            <col width="" />
                        </colgroup>                       
                    </table>
                </div>
			</div>
			
			
			
			<!-- C-6 Type -->
			<div id="C6" style="display:none">
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>		
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                          <col width="34" />
							<col width="140" />
							<col width="100" />
							<col width="170" />
							<col width="110" />
							<col width="110" />
							<col width="90" />
							<col width="90" />
							<col width="" />
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>
                            </th>
							<th><%=BizboxAMessage.getMessage("","전문가")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009942","활용장소")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009941","활동시작일")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009936","활동종료일")%></th>
							<th><%=BizboxAMessage.getMessage("TX000009940","활동시작시간")%></th>
							<th><%=BizboxAMessage.getMessage("TX000009935","활동종료시간")%></th>
                            <th><%=BizboxAMessage.getMessage("","활동방법")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000005709","금액")%></th>
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
						<colgroup>
                             <col width="34" />
							<col width="140" />
							<col width="100" />
							<col width="170" />
							<col width="110" />
							<col width="110" />
							<col width="90" />
							<col width="90" />
							<col width="" />
                        </colgroup>
                    </table>
                </div>
			</div>
			
			<!-- C7 Type -->
			<div id="C7" style="display:none">
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>		
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                          <col width="34" />
							<col width="140" />
                            <col width="140" />
                            <col width="140" />
                            <col width="130" />
                            <col width="130" />
							<col width="100" />
							<col width="" />
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>
                            </th>
							<th><%=BizboxAMessage.getMessage("TX000009946","연구자등록번호")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009939","교육자")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000007587","교육기관")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009932","교육시작일")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009931","교육종료일")%></th>
							<th><%=BizboxAMessage.getMessage("TX000009930","교육시작시간")%></th>
							<th><%=BizboxAMessage.getMessage("TX000009929","교육종료시간")%></th>           
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
						<colgroup>
                            <col width="34" />
							<col width="140" />
                            <col width="140" />
                            <col width="140" />
                            <col width="130" />
                            <col width="130" />
							<col width="100" />
							<col width="" />
                        </colgroup>
                    </table>
                </div>
			</div>
			
			<!-- C8 Type -->
			<div id="C8" style="display:none">
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>		
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                          <col width="34" />
							<col width="260" />
                            <col width="260" />
                            <col width="260" />                  
							<col width="" />
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>
                            </th>
							<th><%=BizboxAMessage.getMessage("TX000006534","소속구분")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009946","연구자등록번호")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009928","참석자성명")%></th>                      
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
						<colgroup>
                            <col width="34" />
							<col width="260" />
                            <col width="260" />
                            <col width="260" />                  
							<col width="" />
                        </colgroup>
                    </table>
                </div>
			</div>
			
			<!-- C9 Type -->
			<div id="C9" style="display:none">
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>		
				</div>

				<div class="com_ta2">
                     <table>
                        <colgroup>
                           <col width="34">
                            <col width="310">
                            <col width="100">
                            <col width="130">
                            <col width="130">
                            <col width="130">
                            <col width="">
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>
                            </th>
							<th><%=BizboxAMessage.getMessage("TX000009946","연구자등록번호")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009927","특근자명")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009926","특근시작일")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009925","특근종료일")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009924","특근시작시간")%></th>
							<th><%=BizboxAMessage.getMessage("TX000009923","특근종료시간")%></th>				           
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
						<colgroup>
                           <col width="34">
                            <col width="310">
                            <col width="100">
                            <col width="130">
                            <col width="130">
                            <col width="130">
                            <col width="">
                        </colgroup>
                    </table>
                </div>
			</div>
			
			<!-- C10 Type -->			
			<div id="CA" style="display:none">			
				<p class="tit_p mt20 fl"><%=BizboxAMessage.getMessage("TX000009949","품목상세")%></p>			
				<div class="controll_btn pt15 fr">
					<button onClick="fnAddTableRow()"><%=BizboxAMessage.getMessage("TX000000446","추가")%></button>
					<button onClick="fnRowCheDel()"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>				
				</div>

				<div class="com_ta2">
                    <table>
                        <colgroup>
                            <col width="34">
                            <col width="130">
                            <col width="70">
                            <col width="60">
                            <col width="60">
                            <col width="105">
                            <col width="105">
                            <col width="105">
                            <col width="120">
                            <col width="90">
                            <col width="">
                        </colgroup>
                        <tr>
                            <th>
                                <input type="checkbox"></input>
                            </th>
                            <th><%=BizboxAMessage.getMessage("TX000007208","품목")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000467","규격")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000004231","수량")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000468","단가")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000516","공급가액")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000000586","세액")%></th>
                            <th><%=BizboxAMessage.getMessage("","총구입액")%></th>
                            <th><%=BizboxAMessage.getMessage("TX000009948","물품구분")%></th>
                            <th>NTIS<%=BizboxAMessage.getMessage("TX000000876","등록일자")%></th>
                            <th>NTIS<%=BizboxAMessage.getMessage("TX000004891","등록번호")%></th>
                        </tr>
                    </table>
                </div>

                <div class="com_ta2 ova_sc bg_lightgray" style="height:148px;">
                    <table class="mainTable">
                        <colgroup>
                            <col width="34">
                            <col width="130">
                            <col width="70">
                            <col width="60">
                            <col width="60">
                            <col width="105">
                            <col width="105">
                            <col width="105">
                            <col width="120">
                            <col width="90">
                            <col width="">
                        </colgroup>
                        
                    </table>
                </div>
			</div>
			



		</div><!--// pop_con -->
	</div><!--// pop_wrap -->
</body>
</html>

