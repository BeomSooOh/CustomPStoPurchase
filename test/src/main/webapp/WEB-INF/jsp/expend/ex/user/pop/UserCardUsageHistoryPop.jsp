<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<!-- 사용자 정보 -->
<input id="hidExpendCardEmpInfo" type="hidden" />
<!-- 표준적요 정보 -->
<input id="hidExpendCardSummaryInfo" type="hidden" />
<!-- 증빙유형 정보 -->
<input id="hidExpendCardAuthInfo" type="hidden" />
<!-- 사유구분 정보 -->
<input id="hidExpendCardVaInfo" type="hidden" />
<!-- 불공제구분 정보 -->
<input id="hidExpendCardNoTaxInfo" type="hidden" />
<!-- 부가세구분 정보 -->
<input id="hidExpendCardVatTypeInfo" type="hidden" />
<!-- 프로젝트 정보 -->
<input id="hidExpendCardProjectInfo" type="hidden" />
<!-- 예산 정보 -->
<input id="hidExpendCardERPiUBudgetInfo" type="hidden" />
<!-- 사업계획 정보 -->
<input id="hidExpendCardBizplanInfo" type="hidden" />
<!-- 예산계정 정보 -->
<input id="hidExpendCardBgAcctInfo" type="hidden" />
<!-- 선택 내역 -->
<input id="hidExpendCardSelected" type="hidden" />
<!-- 카드정보 폼데이터 -->
<form id="cardInfoPop" method="post">
	<input type="hidden" id="formDataCallback" name="callback" value="" />
	<input type="hidden" id="formDataSearchStr" name="searchStr" value="" />
	<input type="hidden" id="formDataCheckedCardInfo" name="checkedCardInfo" value="" />
</form>

<div class="pop_wrap_dir pop_auto_hei pop_wrap_dir_expend" style = "position:fixed;"  id="layerExpendCard">
	<div class="pop_con">
		<div class="top_box clear">
			<dl class="dl2">
				<dt><%=BizboxAMessage.getMessage("TX000000696","기간")%></dt>
				<dd>
					<input id="txtExpendCardFromDate" value="" class="dpWid" /> ~ <input id="txtExpendCardToDate" value="" class="dpWid" />
				</dd>
				<!-- 카드정보 -->
				<dt>${CL.ex_cardInfo}</dt>
				<dd>
					<input id="txtExpendCardNum" type="text" style="width: 180px;ime-mode:active" value="" readonly="readonly" />
				</dd>
				<dd>
					<div class="controll_btn p0">
						 <button id="btnExpendCardInfoHelpPop" class="k-button">${CL.ex_select}</button>
						 <button id="btnExpendCardListSearch" class="btn_sc_add">${CL.ex_search}</button>
					</div>
				</dd>				
			</dl>
			<span class="btn_Detail">${CL.ex_advancedSearch} <img id="all_menu_btn"
				src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
		</div>
		
		<!-- 상세검색박스 -->
		<div class="SearchDetail mb10">
			<dl>
				<dt style="width: 60px;">${CL.ex_whereUsed}</dt>
				<dd class="mr5">
					<input id="txtWhereUsed" type="text" value="" style="width: 200px" class="enter">
				</dd>
				<dt style="width: 95px;">${CL.ex_corporateRegistrationNumber}</dt>
				<dd class="mr5">
					<input id="txtCorporateRegistrationNumber" type="text" value="" style="width: 200px" class="enter">
				</dd>
			</dl>
		</div>

		<table class="mt10" style="width: 100%;">
			<colgroup>
				<col style="" />
				<col style="width: 35%" />
			</colgroup>
			<tr>
				<!-- 사용내역 -->
				<td class="vt">
					<div class="btn_div mt0">
						<div class="left_div">
							<p class="tit_p m0 mt5 fl">${CL.ex_useDetails}</p><!-- 사용내역 -->
							<div class="fl mt3 ml15">
								<input type="radio" name="cardSorting" id="cardSortingAsc" class="" checked="checked"/> 
								<label class="" for="cardSortingAsc">${CL.ex_PastList} <!--과거순--></label> 
								<input type="radio" name="cardSorting" id="cardSortingDesc" class="" />
								<label class="" for="cardSortingDesc">${CL.ex_Lately} <!--최신순--></label>
							</div>
						</div>
						
						<div id="CardToExpendCompleteness" style="display: none;"></div>
						<div class="right_div">
							<span class="mr5">※ ${CL.ex_numberItem}<!-- 항목개수 --></span> <input id="selShowCount" style="width: 60px;" class="kendoComboBox" />
						</div>
					</div>

					<!-- 테이블 -->
					<div id="divExpendCardList" class="com_ta2" style="min-height: 543px;">
						<table id="tblExpendCardList">
						</table>
					</div>
				</td>

				<!-- 옵션 -->
				<td class="vt pl10">
					<div class="btn_div mt0">
						<div class="right_div">
							<div id="" class="controll_btn p0">
								<button id="btnExpendCardDetailInfo" class="k-button" style="display: none;"><%=BizboxAMessage.getMessage("TX000006020","상세보기")%></button>
								<button id="btnExpendCardInfoReset" class="k-button">${CL.ex_reset}</button><!-- 카드내역 초기화 -->
								<button id="btnExpendCardInfoSave" class="k-button">${CL.ex_save}</button><!-- 저장 -->
							</div>
						</div>
					</div>

					<!-- 테이블 -->
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="100" />
								<col width="" />
							</colgroup>
							<tr>
								<th>${CL.ex_user}</th><!-- 사용자 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispEmp" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardEmpPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr>
								<th>${CL.ex_useDepartment}</th><!-- 사용부서 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispDept" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardDeptPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<%-- <tr>
								<th>${CL.ex_accountingUnit}</th>
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispPc" type="text" style="width: 90%;" value="" class="inputText"/> <a id="btnExpendCardPcPop" class="btn_sear" href="#"></a>
								</td>
							</tr> --%>
							<tr>
								<th>${CL.ex_costCenter}</th><!-- 코스트센터 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispCc" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardCcPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr id="ExpendCardSummary">
								<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id="cardReqSummary"/>${CL.ex_standardOutline}</th><!-- 표준적요 -->
								<td class="dod_search">
 									<div class="posi_re mb5">
										<input id="txtExpendCardDispSummary" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> 
										<a id="btnExpendCardSummaryPop" class="btn_sear" href="#"></a>
									</div>
										<input id= "btnListiCUBEBudgetChk" style="width: 45%;" type = "button" value="예산확인"/>
								</td>
							</tr>
							<tr id="ExpendCardAuth">
								<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id="cardReqAuth"/>${CL.ex_evidenceType}</th><!-- 증빙유형 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispAuth" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardAuthPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr id="ExpendCardVa" style="display: none;">
								<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />${CL.ex_reasonType}</th><!-- 사유구분 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispVa" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardVaPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr id="ExpendCardNoTax" style="display: none;">
								<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />${CL.ex_noType}</th><!-- 불공제구분 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispNoTax" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardNoTaxPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr id="ExpendCardNote">
								<th><img style="display: none;" id="cardReqNote" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />${CL.ex_note}<!-- 적요 --></th>
								<td>
<!-- 									<input id="txtExpendCardNote" type="text" style="width: 90%;" value="" class="inputText"/> -->
									<input id="txtExpendCardDispNote" type="text" style="width: 90%;" value="" class="inputText"/>
								</td>
							</tr>
							<tr calss="ExpendCardProject">
								<th><img style="display: none;" id="cardReqProject" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />${CL.ex_project}</th><!-- 프로젝트 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispProject" type="text" style="width: 90%;" value="" class="inputText ExpendCardProject" autocomplete="off"/> <a id="btnExpendCardProjectPop" class="btn_sear ExpendCardProjectBtn" href="#"></a>
								</td>
							</tr>
							<tr class="ERPiUBudget ExpendCardReqBudget" style="display: none;">
								<th>
								<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id="expendCardReqBudget"/>
								${CL.ex_budgetUnit}</th><!-- 예산단위 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispBudget" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardBudgetPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr class="ERPiUBudget ExpendCardReqBizplan" style="display: none;">
								<th>
								<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id="expendCardReqBizplan"/>
								${CL.ex_businessPlan}</th><!-- 사업계획 -->
								<td class="dod_search posi_re">
									<input id="txtExpendCardDispBizplan" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/> <a id="btnExpendCardBizplanPop" class="btn_sear" href="#"></a>
								</td>
							</tr>
							<tr class="ERPiUBudget ExpendCardReqBgAcct" style="display: none;">
								<th>
								<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id="expendCardReqBgAcct"/>
								${CL.ex_budgetAccount}</th><!-- 예산계정 -->
								<td class="dod_search">
								<div class="posi_re mb5">
									<input id="txtExpendCardDispBgAcct" type="text" style="width: 90%;" value="" class="inputText" autocomplete="off"/>
									 <a id="btnExpendCardBgAcctPop" class="btn_sear" href="#"></a>
								</div>	 
									<input id= "btnListERPiUBudgetChk" style="width: 45%;" type = "button" value="예산확인"/>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- //pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input id="btnExpendCardToExpend" type="button" value="<%=BizboxAMessage.getMessage("TX000000423","반영")%>" /> 
			<button id="btnExpendCardColose" class="gray_btn">${CL.ex_cancel}</button>
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->

<!-- /* 프로그레스 레이어 팝업 참조 */ -->

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<%-- <script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script> --%>
<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.format.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.list.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.pop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.valid.js"></c:url>'></script>

<script>
    /* 변수정의 */
    var ifSystem = '${ViewBag.ifSystem}';
    var inputFlag = true;
    /* 데이터테이블 현재 페이지 저장 여부 */
    var isInitPage = false;
    var cTable;
    var currentPage = 0;
    var checkedCardInfo = null; //선택된 카드정보
    
//     let empInfo = {"erpEmpSeq":"UC7","id":"dufgufroal","langCode":"kr","empName":"김상겸","erpCompSeq":"1414","groupSeq":"demo","eaType":"eap","empSeq":"3449","compSeq":"4000","userSe":"ADMIN","deptSeq":"4636","bizSeq":"1111"};
//     let formInfo = {"formSeq":"10227","interlockWidth":"647","formTp":"ea0000","formName":"지출결의서-ERPiU","formDTp":"EXPENDU","interlockHeight":"screen.height - 400","ifSystem":"ERPiU","form_nm_basic":"approval_form_head_19.html","interlockYN":"N","formId":"10227","interlockUrl":"/exp/ExpendPop.do","formMode":"1","form_id":"10227"};
//     let expendUseEmp = {"seq":"27544","compSeq":"4000","compName":"","bizSeq":"1111","bizName":"","deptSeq":"","deptName":"","empSeq":"3449","empName":"","erpCompSeq":"1414","erpCompName":"UC컴퍼니","erpBizSeq":"1000","erpBizName":"UC사업장","erpDeptSeq":"3002","erpDeptName":"영업2팀","erpEmpSeq":"UC7","erpEmpName":"지훈","erpPcSeq":"1000","erpPcName":"UC사업장","erpCcSeq":"3002","erpCcName":"영업2팀","depositName":"///지훈","depositCd":"","depositName2":"","depositCd2":"","formSeq":"","langCode":"","searchStr":"UC7","callback":"","createSeq":"3449","modifySeq":"3449","groupSeq":"groupSeq"};
//     let ExCodeBudget = {"seq":0,"expendSeq":"","listSeq":"","slipSeq":"","rowId":"","rowNo":"","compSeq":"","erpCompSeq":"","deptSeq":"","deptName":"","erpDeptSeq":"","erpDeptName":"","empSeq":"","erpEmpSeq":"","useYN":"0","budgetType":"","budgetYm":"","budgetGbn":"","budYm":"","budgetCode":"","budgetName":"","projectCode":"","projectName":"","bizplanCode":"","bizplanName":"","bgacctCode":"","bgacctName":"","budgetJsum":"0","budgetActsum":"0","budgetAmAction":"0","budgetGwAct":"0","budget_controlYN":"N","amt":"0.00","searchStr":"","callback":"","createSeq":"","modifySeq":""};
    
    var cardPopAttribute = {
        "type" : "",
        "title" : "<%=BizboxAMessage.getMessage("TX000016475","코드도움")%>",
        "width" : "650",
        "height" : "689",
        "opener" : "3",
        "parentId" : "layerExpendCard",
        "childerenId" : "layerCommonCode",
        "callback" : "",
        "comp_seq" : (empInfo.compSeq || '0'),
        "form_seq" : (formInfo.formSeq || '0'),
        "search_str" : "",
        "empInfo" : "hidExpendCardEmpInfo",
        "budgetIfno" : "hidExpendCardERPiUBudgetInfo"
    };

    var cardElement = {
        fromDate : "#txtExpendCardFromDate", /* 기간 / 시작 *//* cardElement.fromDate */
        toDate : "#txtExpendCardToDate", /* 기간 / 종료 *//* cardElement.toDate */
        cardNum : "#txtExpendCardNum", /* 카드정보 *//* cardElement.cardNum */
        whereUsed : "#txtWhereUsed", /* 사용처 *//* cardElement.whereUsed */
        corporateRegistrationNumber : "#txtCorporateRegistrationNumber", /* 사업자등록번호 *//* cardElement.corporateRegistrationNumber */
        emp : { /* 사용자 */
            disp : "#txtExpendCardDispEmp", /* cardElement.emp.disp */
            info : "#hidExpendCardEmpInfo" /* cardElement.emp.info */
        },
        dept : {
            disp : "#txtExpendCardDispDept", /* cardElement.dept.disp */
            info : "#hidExpendCardEmpInfo" /* cardElement.dept.info */
        },
        /* pc : {
            disp : "#txtExpendCardDispPc",
            info : "#hidExpendCardEmpInfo"
        }, */
        cc : { /* 코스트센터 */
            disp : "#txtExpendCardDispCc", /* cardElement.cc.disp */
            info : "#hidExpendCardEmpInfo"
        },
        summary : { /* 표준적요 */
            disp : "#txtExpendCardDispSummary", /* cardElement.summary.disp */
            info : "#hidExpendCardSummaryInfo" /* cardElement.summary.info */
        },
        auth : { /* 증빙유형 */
            disp : "#txtExpendCardDispAuth", /* cardElement.auth.disp */
            info : "#hidExpendCardAuthInfo" /* cardElement.auth.info */
        },
        va : { /* 사유구분 */
            disp : "#txtExpendCardDispVa", /* cardElement.va.disp */
            info : "#hidExpendCardVaInfo" /* cardElement.va.info */
        },
        noTax : { /* 불공제구분 */
            disp : "#txtExpendCardDispNoTax", /* cardElement.noTax.disp */
            info : "#hidExpendCardNoTaxInfo" /* cardElement.noTax.info */
        },
        project : { /* 프로젝트 */
            disp : "#txtExpendCardDispProject", /* cardElement.project.disp */
            info : "#hidExpendCardProjectInfo" /* cardElement.project.info */
        },
        budget : { /* 예산단위 */
            disp : "#txtExpendCardDispBudget", /* cardElement.budget.disp */
            info : "#hidExpendCardERPiUBudgetInfo" /* cardElement.budget.info */
        },
        bizplan : { /* 사업계획 */
            disp : "#txtExpendCardDispBizplan", /* cardElement.bizplan.disp */
            info : "#hidExpendCardERPiUBudgetInfo" /* cardElement.bizplan.info */
        },
        bgacct : { /* 예산계정 */
            disp : "#txtExpendCardDispBgAcct", /* cardElement.bgacct.disp */
            info : "#hidExpendCardERPiUBudgetInfo" /* cardElement.bgacct.info */
        },
        note : "#txtExpendCardDispNote", /* cardElement.note */
        showCount : "#selShowCount", /* cardElement.showCount */
        selectList : "#hidExpendCardSelected", /* 선택목록 *//* cardElement.selectList */
        tableDiv : "#divExpendCardList", /* 목록 테이블 div *//* cardElement.tableDiv */
        tableLIst : "#tblExpendCardList" /* 목록 테이블 *//* cardElement.tableLIst */
    };

    var cardButton = {
       	cardHelp : "#btnExpendCardInfoHelpPop", /* 선택(카드정보) *//* cardButton.cardHelp */
        search : "#btnExpendCardListSearch", /* 검색 *//* cardButton.search */
        detail : "#btnExpendCardDetailInfo", /* 상세보기 *//* cardButton.detail */
        save : "#btnExpendCardInfoSave", /* 저장 *//* cardButton.save */
        callback : "#btnExpendCardToExpend", /* 반영 *//* cardButton.callback */
        close : "#btnExpendCardColose", /* 취소 *//* cardButton.close */
        emp : "#btnExpendCardEmpPop", /* 사용자 *//* cardButton.emp */
        pc : "#btnExpendCardPcPop", /* 회계단위 *//* cardButton.pc */
        cc : "#btnExpendCardCcPop", /* 코스트센터 *//* cardButton.cc */
        summary : "#btnExpendCardSummaryPop", /* 표준적요 *//* cardButton.summary */
        auth : "#btnExpendCardAuthPop", /* 증빙유형 *//* cardButton.auth */
        va : "#btnExpendCardVaPop", /* 사유구분 *//* cardButton.va */
        noTax : "#btnExpendCardNoTaxPop", /* 불공제구분 *//* cardButton.noTax */
        project : "#btnExpendCardProjectPop", /* 프로젝트 *//* cardButton.project */
        budget : "#btnExpendCardBudgetPop", /* 예산단위 *//* cardButton.budget */
        bizplan : "#btnExpendCardBizplanPop", /* 사업계획 *//* cardButton.bizplan */
        bgacct : "#btnExpendCardBgAcctPop" /* 예산계정 *//* cardButton.bgacct */
    };

    /* 문서로드 */
    $(document).ready(function() {
    	/*팝업 위치설정*/
		pop_position();
		$(window).resize(function() { 
		    pop_position();
		});
        fnExpendCardInit();
        fnExpendCardEventInit();
        fnSetFocus();
        fnSetExOption(option, 'card');
        $(cardButton.search).click();
        // 프로젝트 문서단위 입력인 경우 문서에 있는 프로젝트 정보를 고정한다.
        if($('#txtExpendCardDispProject').is('[disabled=disabled]')){
        	$("#txtExpendCardDispProject").val('[' + $('#txtExpendProjectCode').val() + '] ' + $('#txtExpendProjectName').val());
        }
        
        //상세검색 추가로 인해 위치 조정
        var topPosition = ($("#layerExpendCard").position().top - 20);
        $("#layerExpendCard").css("top", topPosition);
        
        fnSetCardEmpDeptOptionSet();
        
        return;
    });
    
    function fnSetCardEmpDeptOptionSet() {
    	if(expendEmpChange) {
			$('#txtExpendCardDispEmp').removeAttr('disabled');
			$('#btnExpendCardEmpPop').css("display", "inline-block");
    	} else {
			$('#txtExpendCardDispEmp').attr('disabled', 'disabled');
			$('#btnExpendCardEmpPop').hide();
    	}
    	
    	if(expendDeptChange) {
			$('#txtExpendCardDispDept').removeAttr('disabled');
			$('#btnExpendCardDeptPop').show();
    	} else {
			$('#txtExpendCardDispDept').attr('disabled', 'disabled');
			$('#btnExpendCardDeptPop').hide();
    	}
    	
    	if(expendEmpDeptLink) {
			$('#txtExpendCardDispDept').attr('disabled', 'disabled');
			$('#btnExpendCardDeptPop').hide();
    	}
    	
    	return;
    }

    /* 초기화 */
    function fnExpendCardInit() {
        fnExpendCardInitLayout();
        fnExpendCardInitDatepicker();
        fnExpendCardInitInput();
        
        if(!expendEmpChange) {
        	$('#txtExpendCardDispEmp').attr('readonly', 'readonly');
        	$('#txtExpendCardDispEmp').attr('disabled', 'disabled');
        } else {
        	$('#txtExpendCardDispEmp').removeAttr('readonly', 'readonly');
        	$('#txtExpendCardDispEmp').removeAttr('disabled', 'disabled');
        }
        
        if(!expendDeptChange) {
        	$('#txtExpendCardDispDept').attr('readonly', 'readonly');
        	$('#txtExpendCardDispDept').attr('disabled', 'disabled');
        } else {
        	$('#txtExpendCardDispDept').removeAttr('readonly', 'readonly');
        	$('#txtExpendCardDispDept').removeAttr('disabled', 'disabled');
        }
        
        return;
    }

    /* 초기화 - Layout */
    function fnExpendCardInitLayout() {
        /* 사용자 입력 초기화 */
        /* 사용자 정보, 표준적요 정보, 증빙유형 정보, 프로젝트 정보, 예산 정보, 사업계획 정보, 예산계정 정보, 선택 내역 */
        $('input[type=hidden]').val('');
        $(cardElement.emp.disp).val(''); /* 사용자 */
        $(cardElement.summary.disp).val(''); /* 표준적요 */
        $(cardElement.note).val(''); /* 적요 */
        $(cardElement.auth.disp).val(''); /* 증빙유형 */
        $(cardElement.project.disp).val(''); /* 프로젝트 */
        $(cardElement.budget.disp).val(''); /* 예산단위 */
        $(cardElement.bizplan.disp).val(''); /* 사업계획 */
        $(cardElement.bgacct.disp).val(''); /* 예산계정 */

		if ((typeof expendUseEmp.empSeq != 'undefined' && expendUseEmp.empSeq != '') || (typeof expendUseEmp.erpEmpSeq != 'undefined' && expendUseEmp.erpEmpSeq != '')) {
			/* 사용자 */
			var disp_emp_name = ((expendUseEmp.erpEmpName == '' ? expendUseEmp.empName : expendUseEmp.erpEmpName) || '');
			var disp_emp_seq = ((expendUseEmp.erpEmpSeq == '' ? expendUseEmp.empSeq : expendUseEmp.erpEmpSeq) || '');
			$(cardElement.emp.info).val(JSON.stringify(expendUseEmp));
			$(cardElement.emp.disp).val('[' + disp_emp_seq + '] ' + disp_emp_name);
			
		    /* 부서 */
			var disp_dept_name = ((expendUseEmp.erpDeptName == '' ? expendUseEmp.deptName : expendUseEmp.erpDeptName) || '');
			var disp_dept_seq = ((expendUseEmp.erpDeptSeq == '' ? expendUseEmp.deptSeq : expendUseEmp.erpDeptSeq) || '');
			$(cardElement.dept.disp).val('[' + disp_dept_seq + '] ' + disp_dept_name);
			
			if ('${ViewBag.ifSystem}' == 'ERPiU') {
				/* 회계단위 */
				var disp_pc_name = ($('#txtExpendPcName').val() || '');
				var disp_pc_seq = ($('#txtExpendPcCode').val() || '');
				/* $(cardElement.pc.disp).val('[' + disp_pc_seq + '] ' + disp_pc_name); */
				/* 코스트센터 */
				var disp_cc_name = (expendUseEmp.erpCcName || '');
				var disp_cc_seq = (expendUseEmp.erpCcSeq || '');
				$(cardElement.cc.disp).val('[' + disp_cc_seq + '] ' + disp_cc_name);
				
			} else {
				/* $(cardElement.pc.disp).parent('td').parent('tr').hide(); */ /* 부모 tr 숨기기 */
				$(cardElement.cc.disp).parent('td').parent('tr').hide(); /* 부모 tr 숨기기 */
			}
			
			
			if (${ViewBag.isEmpInfoLocateExpend} ) {
				$(cardElement.emp.disp).attr('disabled', 'disabled');
				$(cardButton.emp).hide();
				$(cardElement.dept.disp).attr('disabled', 'disabled');
				/* $(cardElement.pc.disp).attr('disabled', 'disabled'); */
				$(cardButton.pc).hide();
				$(cardElement.cc.disp).attr('disabled', 'disabled');
				$(cardButton.cc).hide();
			}else{
	            $(cardElement.emp.disp).removeAttr('disabled', 'disabled');
	            $(cardButton.emp).show();
	            $(cardElement.dept.disp).attr('disabled', 'disabled');
// 	            $(cardElement.dept.disp).removeAttr('disabled', 'disabled');
	            if ('${ViewBag.ifSystem}' == 'ERPiU') {
		            /* $(cardElement.pc.disp).removeAttr('disabled', 'disabled'); */
					$(cardButton.pc).show();
					$(cardElement.cc.disp).removeAttr('disabled', 'disabled');
					$(cardButton.cc).show();
	            }
			}
		}

        /* 예산처리 */
        if ('${ViewBag.ifSystem}' == 'ERPiU') {
//             $('.ERPiUBudget').show();
            var cardBudgetInfo = {};
            $.extend(cardBudgetInfo, ExCodeBudget);
            cardBudgetInfo.budgetYm = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
            $(cardElement.budget.info).val(JSON.stringify(cardBudgetInfo));
            $(cardElement.budget.disp).val('');
            $(cardElement.bizplan.disp).val('');
            $(cardElement.bgacct.disp).val('');
        } else {
            $('.ERPiUBudget').hide();
        }
        return;
    }

    /* 초기화 - Datepicker */
    function fnExpendCardInitDatepicker() {
        $([ cardElement.fromDate, cardElement.toDate ].join(', ')).setKendoDatePicker();
        $([ cardElement.fromDate, cardElement.toDate ].join(', ')).setKendoDatePickerMask();
        $(cardElement.toDate).resetDate();
        $(cardElement.fromDate).resetDate(-10);

        return;
    }

    /* 초기화 - Input */
    function fnExpendCardInitInput() {
        setComboBox($(cardElement.showCount), fnGetListCount([ 10, 25, 50, -1 ]), function() {
        	if($(cardElement.showCount).val() == '전체'){
        		$(cardElement.showCount).val(-1);
        	}
            $('select[name=tblExpendCardList_length]').val($(cardElement.showCount).val());
            $('select[name=tblExpendCardList_length]').trigger('change');
            return;
        }); /* 항목개수 설정 */
        
        
        /* 기본적용 적요 반영 */
        if ($("#txtExpendCardDispNote").val() == "") {
			if ($("#txtExpendBaseNote").val() != "") {
				$("#txtExpendCardDispNote").val(parent.$("#txtExpendBaseNote").val());
			}
		}
        
        /* 정렬순서 반영 - 과거순*/
        $('#cardSortingAsc').change(function() {
            if ($(this).is(':checked')) {
            	$("#tblExpendCardList").DataTable().order([[4,'asc'],[5,'asc']]).draw();
            }
        });
        /* 정렬순서 반영 - 최신순*/
        $('#cardSortingDesc').change(function() {
            if ($(this).is(':checked')) {
            	$("#tblExpendCardList").DataTable().order([[4,'desc'],[5,'desc']]).draw();
            }
        });
        return;
    }

    /* 이벤트 초기화 */
    function fnExpendCardEventInit() {
        $('button').kendoButton(); /* 켄도버튼정의 */
        fnExpendCardEventInitButton();
        fnExpendCardEventInitEnter();
        return;
    }

    /* 이벤트 초기화 - 버튼 */
    function fnExpendCardEventInitButton() {
        /* 버튼 클릭 이벤트 */
        /* 버큰클릭 이벤트 - 선택(카드정보) */
        $(cardButton.cardHelp).btnClick('fnExpendCardInfoHelpPop');
        
        /* 버큰클릭 이벤트 - 검색 */
//         $(cardButton.search).btnClick('btnExpendCardListSearch');
        $("#btnExpendCardListSearch").on("click",function(){
        	isInitPage = false;
        	btnExpendCardListSearch();
        });
        /* 엔터 이벤트 - 검색기간 */
//         $([ cardElement.fromDate, cardElement.toDate, cardElement.cardNum ].join(', ')).txtEnter('btnExpendCardListSearch');
		$("#txtExpendCardFromDate, #txtExpendCardToDate, #txtWhereUsed, #txtCorporateRegistrationNumber").keydown(function(event){
			if (event.keyCode == 13){
				isInitPage = false;
				$("#btnExpendCardListSearch").click();	
			}
		});
		
		/* 엔터 이벤트 - 카드정보 */
		$("#txtExpendCardNum").keydown(function(e){
			if(e.keyCode == 13){
				fnExpendCardInfoHelpPop("Y");
			}
		});
        /* 버큰클릭 이벤트 - 상세보기 */
        $(cardButton.detail).btnClick('fnExpendCardRowDetailInfo');

        /* 버튼클릭 이벤트 - 저장 */
//         $(cardButton.save).btnClick('fnExpendCardInfoUpdate');
        $("#btnExpendCardInfoSave").on("click", function(){
        	isInitPage = true;
        	fnExpendCardInfoUpdate();
        })
        
        $("#btnExpendCardInfoReset").on("click", function(){
        	isInitPage = false;
        	fnExpendCardInfoReset();
        })

        /* 버튼클릭 이벤트 - 반영 */
        $(cardButton.callback).btnClick('fnExpendCardToExpend');

        /* 버튼클릭 이벤트 - 취소 */
        $("#btnExpendCardColose").click(function(){
//         	layerPopClose('');
        	fnExCloseLayPop();
        });
        if( isUseBudget==false){
        	$('#btnListiCUBEBudgetChk').hide(); 
	        $('#btnListERPiUBudgetChk').hide();
        }else {

	        if( expendBudgetInfo.useYN ==='Y' &&  ifSystem == 'ERPiU'){
		        /* 이준성 개발 !!!! ==> 문의사항은 이준성연구원에게... +- */
		        $('#btnListiCUBEBudgetChk').hide(); 
		        $('#btnListERPiUBudgetChk').show();
		        
		        $('#btnListERPiUBudgetChk').click(function(){
		        	var budgetInfo = JSON.parse(($('#hidExpendCardERPiUBudgetInfo').val() || '{}'));
		        	if((budgetInfo.budgetCode || '') == '') {
		        		alert('예산단위를 입력하세요.');
		        		return;
		        	}
		        	if((budgetInfo.bgacctCode || '') == '') {
		        		alert('예산계정을 입력하세요.');
		        		return;
		        	}
		        	
		        	fnExpendERPiUBudgetChk();
		        	
		        	return;
		        });
		        //expendBudgetInfo.useYN ==='Y' && 
	        }else if(expendBudgetInfo.useYN ==='Y' && ifSystem == 'iCUBE'){
	        	$('#btnListERPiUBudgetChk').hide();
	        	$('#btnListiCUBEBudgetChk').show(); 
	        	 
	        	$('#btnListiCUBEBudgetChk').click(function(){

		        	fnExpendiCUBEBudgetChk();
		        	
		        	return;
	        	});
	        }
        }
        /* 버튼클릭 이벤트 - 사용자, 사용부서, 회계단위, 코스트센터, 표준적요, 증빙유형, 프로젝트, 예산단위, 사업계획, 예산계정, 사유구분, 불공제구분 */
        $("#btnExpendCardEmpPop, #btnExpendCardDeptPop, #btnExpendCardPcPop, #btnExpendCardCcPop, #btnExpendCardSummaryPop, #btnExpendCardAuthPop, "
        + "#btnExpendCardProjectPop, #btnExpendCardBudgetPop, #btnExpendCardBizplanPop, #btnExpendCardBgAcctPop, #btnExpendCardVaPop, "
        + "#btnExpendCardNoTaxPop").click(function(){
        	var btnType = $(this).attr('id').replace('btnExpendCard','').replace('Pop','');
        	var btnCallback = '';
        	switch(btnType){
	        	case 'Budget' :
	        	case 'Bizplan' :
	        	case 'BgAcct' :
	        		btnCallback = 'fnExpendCardCallbackBudget';
	        		break;
	        	default :
	        		btnCallback = 'fnExpendCardCallback';
	        		break;
        	}
        	
        	if(!expendEmpChange && btnType == 'Emp') {
        		alert('사용자를 변경할 수 없습니다.');
        		return;
        	}
        	
			if(!expendDeptChange && btnType == 'Dept') {
				alert('사용부서를 변경할 수 없습니다.');
        		return;
        	}
        	
        	fnOpenCommonCodePop('N', btnType, btnCallback);
		});
        return;
    }
    
    /* 이벤트 초기화 - 엔터 */
    function fnExpendCardEventInitEnter() {
    	
    	$(document).keydown(function(event){
    		if(event.keyCode == '27'){
    			$("#btnExpendCardColose").click();
			}
    	})
    	
    	//카드정보 텍스트
    	$("#txtExpendCardNum").keyup(function(){
    		//선택된 카드정보 초기화
    		checkedCardInfo = null;
    	});
    	
    	$("#txtExpendCardDispNote").keyup(function(e){
			var NoteContent = $(this).val();
			if(NoteContent.length >= 100){
				alert('글자수 제한(100byte)을 초과하였습니다.');
				return  $(this).val(NoteContent.substring(0, 100));
			}
		})
    	
    	/* 엔터 이벤트 - 사용자, 회계단위, 코스트센터, 표준적요, 증빙유형, 프로젝트, 예산단위, 사업계획, 예산계정 */
        $("#txtExpendCardDispEmp, #txtExpendPcCode, #txtExpendPcName, #txtExpendCardDispSummary, #txtExpendCardDispAuth, "
        + "#txtExpendCardDispProject, #txtExpendCardDispBudget, #txtExpendCardDispBizplan, #txtExpendCardDispBgAcct, "
        + "#txtExpendCardDispVa, #txtExpendCardDispNoTax").keydown(function(event){
   			if(event.keyCode == '13'){
	        	// cardReqNote
	        	// expendListReqBudget
	        	var isReq = false;
   				var txtType = $(this).attr('id').replace('txtExpendCardDisp','');
	        	var txtCallback = '';
	        	switch(txtType){
		        	case 'Budget' :
		        	case 'Bizplan' :
		        	case 'BgAcct' :
		        		txtCallback = 'fnExpendCardCallbackBudget';
		        		if($("#expendCardReq"+txtType).is(":visible")){
		        			isReq = true;
		        		}else{
		        			isReq = false;
		        		}
		        		break;
		        	default :
		        		txtCallback = 'fnExpendCardCallback';
			        	if($("#cardReq"+txtType).is(":visible")){
		        			isReq = true;
		        		}else{
		        			isReq = false;
		        		}
		        		break;
	        	}
	        	if(isReq){
	        		fnOpenCommonCodePop('Y', txtType, txtCallback);	
	        	}else{
	        		fnSetFocus($(this).attr('id'));
	        	}
			}
		});
        
        $("#txtExpendCardDispNote").keydown(function(event){
			if(event.keyCode == '13'){
				if($("#cardReqNote").is(":visible")){
					if($("#txtExpendCardDispNote").val() != ''){
						fnSetFocus('txtExpendCardDispNote');	
					}
				}else{
					fnSetFocus('txtExpendCardDispNote');
				}
			}
        });
    }
    
    function fnOpenCommonCodePop(input, codeType, callBack){
		// 엔터 이벤트로 호출하는 경우
		if(input === 'Y'){
			fnOpenCodePop({
				codeType : codeType,
				callback : callBack,
				searchStr : $("#txtExpendCardDisp" + codeType).val(),
				erp_emp_seq : (JSON.parse($(cardElement.emp.info).val()).erpEmpSeq || expendUseEmp.erpEmpSeq || ''),
				erp_dept_seq : (expendEmpDeptLink ? (JSON.parse($(cardElement.emp.info).val()).erpDeptSeq || expendUseEmp.erpDeptSeq || '') : ''),
				acct_code : ((JSON.parse($(cardElement.summary.info).val() || '{}').drAcctCode || '') || ''),
				budget_code : (JSON.parse(($("#hidExpendCardERPiUBudgetInfo").val() || '{}')).budgetCode || ''),
				bizplan_code : (JSON.parse(($("#hidExpendCardERPiUBudgetInfo").val() || '{}')).bizplanCode || '***'),
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				summryDisplayOption : summryDisplayOption,
				formSeq : expend.formSeq,
				vat_type : ($('#hidExpendCardVatTypeInfo').val() || '')
			});
		}else{ // 찾기 버튼으로 호출하는 경우
			fnOpenCodePop({
				codeType : codeType,
				callback : callBack,
				searchStr : '',
				erp_emp_seq : (JSON.parse($(cardElement.emp.info).val()).erpEmpSeq || expendUseEmp.erpEmpSeq || 0),
				erp_dept_seq : (expendEmpDeptLink ? (JSON.parse($(cardElement.emp.info).val()).erpDeptSeq || expendUseEmp.erpDeptSeq || '') : ''),
				acct_code : ((JSON.parse($(cardElement.summary.info).val() || '{}').drAcctCode || '') || ''),
				budget_code : (JSON.parse(($("#hidExpendCardERPiUBudgetInfo").val() || '{}')).budgetCode || ''),
				bizplan_code : (JSON.parse(($("#hidExpendCardERPiUBudgetInfo").val() || '{}')).bizplanCode || '***'),
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				summryDisplayOption : summryDisplayOption,
				formSeq : expend.formSeq,
				vat_type : ($('#hidExpendCardVatTypeInfo').val() || '')
			});
		}
	}
    
    /* 버튼 - 선택(카드정보) */
    function fnExpendCardInfoHelpPop(input){
		var popWidth = 500, popHeight = 530; //팝업 창 사이즈

		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winWidth = document.body.clientWidth; // 현재창의 너비
		var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 

		var popX = winX + (winWidth - popWidth)/2;
		var popY = winY + (winHeight - popHeight)/2;
		
		var searchStr = "";
		//엔터로 검색하는 경우
		if(input == "Y"){
			searchStr = ($("#txtExpendCardNum").val() || "");
		}
		
		//선택된 카드정보
		var cardNumArray = [];
		if(checkedCardInfo){
	    	for(var i=0; i < checkedCardInfo.length; i++){
	    		cardNumArray.push(checkedCardInfo[i].cardNum);
	    	}
  		}
		
		$("#formDataCallback").val("fnExpendCardCallbackCardInfo"); //카드정보 콜백url
		$("#formDataSearchStr").val(searchStr); //카드정보 검색어
		$("#formDataCheckedCardInfo").val(JSON.stringify(checkedCardInfo)); //이미 선택된 카드정보
		
        var url = '<c:url value="/ex/card/UserCardInfoHelpPop.do" />';
        
		window.open("", "cardInfoPop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY);
		
		var cardInfoForm = $("#cardInfoPop");
		cardInfoForm.attr("action", url);
		cardInfoForm.attr("target", "cardInfoPop");
		
		cardInfoForm.submit();
    }
    
  	//카드정보 콜백함수
    function fnExpendCardCallbackCardInfo(data){
    	//선택된 카드정보 텍스트 표시
    	var checkedCardInfoTxt = (data[0].cardName || "");
    	if(data.length > 1){
    		checkedCardInfoTxt += " 외 " + (data.length - 1) + " 건";
    	}
    	
    	$("#txtExpendCardNum").val(checkedCardInfoTxt);
    	
    	//선택된 카드정보 값 저장
    	checkedCardInfo = $.extend(true, [], data);
    	
    	//검색
    	btnExpendCardListSearch();
    }
  	
  	//선택된 카드정보 변환
  	function fnExpendConvertCheckedCardInfo(data){
  		var checkedCardInfoVal = "";
  		
  		if(data){
	  		var checkedCardInfoVal = ("'" + data[0].cardNum.replace(/-/g, '') + "'" || "");
	    	for(var i=1; i < data.length; i++){
	    		checkedCardInfoVal += ", " + "'" + data[i].cardNum.replace(/-/g, '') + "'";
	    	}
  		}
    	
    	return checkedCardInfoVal;
  	}

    /* 버튼 - 검색 */
    function btnExpendCardListSearch(  ) {
        /* 변수정의 */
        var data = {};
        $.extend(data, ExCodeCard);
        data.searchFromDate = $(cardElement.fromDate).val().toString().replace(/-/g, ''); /* 검색 시작일 : 승인일자 기준 */
        data.searchToDate = $(cardElement.toDate).val().toString().replace(/-/g, ''); /* 검색 종료일 : 승인일자 기준 */
		data.searchStr = fnExpendConvertCheckedCardInfo(checkedCardInfo); /* 선택된 카드정보 */
        data.ifMId = ''; /* 지출결의 아이디 : 중복 내역을 제외하기 위한 처리 */
        data.expendSeq = expend.expendSeq;
        data.sorting = 'ASC';
        data.isSearchWithCancel = '${ViewBag.isSearchWithCancel}'; // 카드사용내역 조회 시 취소분 포함인지 구분하는 값
        data.whereUsed = $(cardElement.whereUsed).val(); // 사용처
        data.corporateRegistrationNumber = $(cardElement.corporateRegistrationNumber).val().toString().replace(/-/g, ''); // 사업자등록번호
        data = fnConvertJavaParam(data);
        /* 서버호출 */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/expend/ex/user/card/ExCardListInfoSelect.do" />';
        ajaxParam.async = true;
        ajaxParam.data = data;
        ajaxParam.callback = function( data ) {
            fnExpendCardGridListBind(data.aaData);
            isInitPage = false;
        };

        fnCallAjax(ajaxParam);

        return;
    }

    /* 버튼 - 검색 - 테이블 바인딩 */
    function fnExpendCardGridListBind( param ) {
 
        param = (param || {});
        $(cardElement.tableDiv).resetDataTable();

        cTable = $("#tblExpendCardList").dataTable({
            "fixedHeader" : true,
            "select" : true,
            "lengthMenu" : [ [ 10, 25, 50, -1 ], [ 10, 25, 50, "All" ] ],
            "pageLength" : ($(cardElement.showCount).val() == '-1' ? 100 : $(cardElement.showCount).val()),
            "sScrollY" : 505,
            "bAutoWidth" : false,
            "paging" : true,
            "bSort" : true,
            "destroy" : true,
            "language" : dataTableLanguage,
            "bStateSave" : isInitPage,
            "fnInfoCallback" : function(oSettings, iStart, iEnd, iMax, iTotal, sPre){
            	if( Number(iMax) != 0){
            		var cPage = sPre.split(' / ')[0];
            		if( !isInitPage && cPage != currentPage){
            			currentPage = cPage;
            		}
            	}
            },
            "data" : param,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    fnExpendCardRowSelect(aData);
                    return;
                }));
                
                $(nRow).on('dblclick', (function() {
                	fnRowDblClick(aData);
                    return;
                }));

                return nRow;
            },
            "columnDefs" : [ {
                "targets" : 0,
                "data" : null,
                "render" : function( data ) {
                    if (data != null && data != "") {
                        return '<input type="checkbox" name="inp_CardChk" id="inp_CardChk' + data.syncId + '" value="' + data.syncId + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_CardChk' + data.syncId + '"></label>';
                    } else {
                        return "";
                    }
                }
            }, {
                "targets" : 1,
                "data" : null,
                "render" : function( data ) {
                    var result = '';
                    result = '<span id="">' + fnFormatStringToDate('yyyy-MM-dd hh:mm', data.authDate + data.authTime) + '</span>';
                    result += '<br /><span id="">' + data.mercName;
                    switch(data.vatStat){
	                    case "0" :
	                    	result +=  '[해외]';
	                    	break;
	                    case "1" :
	                    	result +=  '[일반]';
	                    	break;
	                    case "2" :
	                    	result +=  '[간이]';
	                    	break;
	                    case "3" :
	                    	result +=  '[면세]';
	                    	break;
	                    case "4" :
	                    	result +=  '[휴업]';
	                    	break;
	                    case "5" :
	                    	result +=  '[폐업]';
	                    	break;
	                    case "6" :
	                    	result +=  '[비영리]';
	                    	break;
	                    case "8" :
	                    	result +=  '[미등록]';
	                    	break;
	                    case "9" :
	                    	result +=  '[오류]';
	                    	break;
	                    case "A" :
	                    	result +=  '[간이A]';
	                    	break;
                    	default :
                    		break;
                    }
                    result +=  '</span>';
                    if(data.mccName != undefined && data.mccName != ''){
                    	result += '<br /><span id="">[' + data.mccName + ']</span>';	
                    }
                    result += '<br /><span id="">[' + data.cardName + ']</span>';
                    if (isDisplayFullNumber == false) {
						result += '<br /><span id="">' + data.cardNum.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/,"$1-****-****-$4") + '</span>';
					}else{
						result += '<br /><span id="">' + data.cardNum.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/,"$1-$2-$3-$4") + '</span>';
					}
                    
                    return result;
                }
            }, {
                "targets" : 2,
                "data" : null,
                "render" : function( data ) {
                    var result = '';
                    var signCorrection = (data.georaeStat == '1' || data.georaeStat == 'N') ? 1 : ( parseInt(data.requestAmount) < 1 ? 1 : -1 );
                    var signClass = (data.georaeStat == '1' || data.georaeStat == 'N') ? '' : 'text_red'; // 승인취소 시 빨간색으로 표시
                    var subSignCorrection = 1;
                    
                    if (signCorrection < 0 && parseInt(data.vatMdAmount) < 0){
    					subSignCorrection = -1;
    				}
                    
                 	// 금액 처리 준비
    				var requestAmount = data.requestAmount || '0';
    				var vatMdAmount = data.vatMdAmount || '0';
    				var amtMdAmount = data.amtMdAmount || '0';
    				var amtSerMdAmount = data.amtSerMdAmount || '0';
    				
    				// 승인/취소에 따른 부호 보정
    				requestAmount = parseInt(requestAmount) * signCorrection;
    				vatMdAmount = parseInt(vatMdAmount) * signCorrection * subSignCorrection;
    				amtMdAmount = parseInt(amtMdAmount) * signCorrection * subSignCorrection;
    				amtSerMdAmount = parseInt(amtSerMdAmount) * signCorrection * subSignCorrection;
                    
                    /* 공급가액 과 (공급가액 + 서비스금액)금액을 비교한 뒤 같으면 공급가액 표현 , 다르면 (공급가액 + 서비스금액) 을 표현한다 */
                    
                    result = '<span id="" class="fwb '+ signClass +'">' + fnAddComma(requestAmount) + '</span>';
                    result += '<br /><span id="" class="'+ signClass +'">' + fnAddComma(vatMdAmount) + '</span>';                
                    if(data.amtMdAmount == data.amtSerMdAmount) {
                    	result += '<br /><span id="" class="'+ signClass +'">' + fnAddComma(amtMdAmount) + '</span>';
                    }
                    else {
                    	result += '<br /><span id="" class="'+ signClass +'">' + fnAddComma(amtSerMdAmount) + '</span>';
                    }
                    return result;
                }
            }, {
                "targets" : 3,
                "data" : null,
                "render" : function( data ) {
                    var result = '';
                    /* 표준적요 */
                    result += (typeof data.summaryName == 'undefined' || data.summaryName == '' ? '' : "<span id=''>${CL.ex_standardOutline} : " + ((typeof data.summaryName == 'undefined' ? '' : data.summaryName) || '') + '</span><br />'); // 표준적요
                    /* 증빙유형 */
                    result += (typeof data.authName == 'undefined' || data.authName == '' ? '' : "<span id=''>${CL.ex_evidenceType} : " + ((typeof data.authName == 'undefined' ? '' : data.authName) || '') + '</span><br />'); // 증빙유형
                    /* 프로젝트 */
                    result += (typeof data.projectName == 'undefined' || data.projectName == '' ? '' : "<span id=''>${CL.ex_project} : " + ((typeof data.projectName == 'undefined' ? '' : data.projectName) || '') + '</span><br />'); // 프로젝트
                    /* 예산 [ERPiU] */
                    if ('${ViewBag.ifSystem}' == 'ERPiU') {
                        var disp_budget_name = '';
                        if (typeof data.budgetName != 'undefined' && data.budgetName != '') {
                            disp_budget_name += (data.budgetName || '');

                            if (typeof data.bizplanName != 'undefined' && data.bizplanName != '') {
                                disp_budget_name += '/' + (data.bizplanName || '***');

                                if (typeof data.bgacctName != 'undefined' && data.bgacctName != '') {
                                    disp_budget_name += '/' + (data.bgacctName || '');
                                } else {
                                    disp_budget_name = '';
                                }
                            } else {
                                disp_budget_name = '';
                            }
                        } else {
                            disp_budget_name = '';
                        }

                        result += (disp_budget_name == '' ? '' : '<span id=""><%=BizboxAMessage.getMessage("TX000004246","예산")%> : ' + disp_budget_name + '</span><br />');
                    } else if ('${ViewBag.ifSystem}' == 'iCUBE') {
                        result = result;
                    }
                    /* 적요 */
                    result += (typeof data.note == 'undefined' || data.note == '' ? '' : "<span id=''>${CL.ex_note} : " + ((typeof data.note == 'undefined' ? '' : data.note) || '') + '</span><br />');// 적요

                    return (result || '-');
                }
            } ],
            "aoColumns" : [ {
                "sTitle" : "<input type='checkbox' id='inp_CardChk' name='inp_CardChk' onclick='fnChk(this)'>",
                "bSearchable" : false,
                "bSortable" : false,
                "bVisible" : true,
                "sWidth" : "34",
                "sClass" : "center"
            }, {
                sTitle : "${CL.ex_approvalInformation}", // 승인정보
                bVisible : true,
                bSortable : false,
                sWidth : "170px",
                sClass : "td_le"
            }, {
                sTitle : "${CL.ex_amount}", // 금액
                bVisible : true,
                bSortable : false,
                sWidth : "90px",
                sClass : "td_ri"
            }, {
                sTitle : "${CL.ex_informationResolution}", // 지출결의 정보
                bVisible : true,
                bSortable : false,
                sWidth : "",
                sClass : "td_le"
            }, {
                sTitle : "승인일자", // 지출결의 정보
                mData  : "authDate",
                bVisible : false,
                bSortable : true,
                sWidth : "",
                sClass : "td_le"
            }, {
                sTitle : "승인시간", // 지출결의 정보
                mData  : "authTime",
                bVisible : false,
                bSortable : true,
                sWidth : "",
                sClass : "td_le"
            }  ]
        });
        
        cTable.dataTable().fnPageChange( (Number(currentPage) - 1));

        if($(cardElement.showCount).val() == '전체'){
    		$(cardElement.showCount).val(-1);
    	}
        $('select[name=tblExpendCardList_length]').val($(cardElement.showCount).val());
        $('select[name=tblExpendCardList_length]').trigger('change');
        
        /* 정렬순서 반영 - 과거순*/
        if($("#cardSortingAsc").is(':checked')){
        	$("#tblExpendCardList").DataTable().order([[4,'asc'],[5,'asc']]).draw();
        }else{
        	$("#tblExpendCardList").DataTable().order([[4,'desc'],[5,'desc']]).draw();
        }
    }

    /* 이벤트 정의 호출 - 저장 */
    function fnExpendCardInfoUpdate( param ) {
    	
        param = ((typeof param == 'object' ? '' : param) || '');

        var data = {};
       
        data.target = fnGetCheckboxInfo('inp_CardChk');
        $.each(data.target, function( idx, item ) {
            data.target[idx].syncId = item.key;
        });

        /* 사용자 필수 확인 */
        data.empInfo = $(cardElement.emp.info).getJson(ExCodeOrg);
        if (!$(cardElement.emp.info).chkValid(expendType.emp)) { return; }

        /* 표준적요 필수 확인 */
        data.summaryInfo = $(cardElement.summary.info).getJson(ExCodeSummary);
        if (!$(cardElement.summary.info).chkValid(expendType.summary)) { return; }

        /* 증빙유형 필수 확인 */
        data.authInfo = $(cardElement.auth.info).getJson(ExCodeAuth);
        if (!$(cardElement.auth.info).chkValid(expendType.auth)) { return; }

        /* 적요 필수 확인 *//* 필수 값은 증빙유형 등록 기준으로 판단. */
        data.note = ($(cardElement.note).val() || '');
        if (!$(cardElement.note).chkValid(expendType.note, data.authInfo)) { return; }

        /* 프로젝트 필수 확인 *//* 필수 값은 증빙유형 등록 기준으로 판단. */
		// 기존 프로젝트 정보 삭제 시 처리 진행
		var isDeleteProject = false;
		if( $('#txtExpendCardDispProject').val() === '' && $(cardElement.project.info).val( ) != ''){
			var projectInfo = JSON.parse( $(cardElement.project.info).val( ) || {} );
			if( projectInfo.seq != 0 ){
				isDeleteProject = true;
			}
			projectInfo.seq = 0 ;
			$(cardElement.project.info).val(JSON.stringify(projectInfo));
		}
        data.isDeleteProject = isDeleteProject;
        data.projectInfo = $(cardElement.project.info).getJson(ExCodeProject);
        if (!$(cardElement.project.info).chkValid(expendType.project, data.authInfo)) { return; }
        
        /* 예산 */
        if(ifSystem === 'ERPiU'){
			if($("#expendCardReqBudget").is(":visible") && $(".ExpendCardReqBudget").is(":visible")){
				if($("#txtExpendCardDispBudget").val().trim() == ''){
					alert("<%=BizboxAMessage.getMessage("TX000018804","예산단위가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendCardReqBizplan").is(":visible") && $(".ExpendCardReqBizplan").is(":visible")){
				if($("#txtExpendCardDispBizplan").val().trim() == ''){
					alert("<%=BizboxAMessage.getMessage("TX000018805","사업정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendCardReqBgAcct").is(":visible") && $(".ExpendCardReqBgAcct").is(":visible")){
				if($("#txtExpendCardDispBgAcct").val().trim() == ''){
					alert("<%=BizboxAMessage.getMessage("TX000018806","예산계정이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
		}
        
        //준성 
        if(expendBudgetInfo.useYN ==='Y' && isUseBudget){
	        data.budgetInfo = {};
	        var budgetERPiUInfo = fnFormatStrToJson($(cardElement.budget.info).val());
	        if ('${ViewBag.ifSystem}' == 'ERPiU') {
	            data.budgetInfo = JSON.stringify(budgetERPiUInfo); /* 예산 */
	        } else if ('${ViewBag.ifSystem}' == 'iCUBE' ) {
	        	
	        	//준성 예산 체크할때에 확인 하기 
	            data.budgetInfo.erpEmpSeq =  data.empInfo.erpEmpSeq;
	            data.budgetInfo.erpDeptSeq = data.empInfo.erpDeptSeq;
	            data.budgetInfo.erpCompSeq = data.empInfo.erpCompSeq;
	            data.budgetInfo.budYm = '';//귀속년월 추가
	            data.budgetInfo.budgetJsum ='';//귀속년월 추가
	            data.budgetInfo.budgetActsum ='';//귀속년월 추가
	            data.budgetInfo.budgetControlYN = 'Y';//
	            data.budgetInfo.budgetYm =  $('#txtExpendDate').val().toString().replace(/-/g, '').substring(0, 6);
	            data.budgetInfo.budgetGbn = expendBudgetInfo.budgetType;
	            data.budgetInfo.budgetType = expendBudgetInfo.erpType;
	            data.budgetInfo.bgacctCode = data.summaryInfo.drAcctCode;
	            data.budgetInfo.bgacctName = data.summaryInfo.drAcctName;
	            
	            if(expendBudgetInfo.erpType === 'iCUBE' && expendBudgetInfo.budgetType === 'D'){
	            	/* 이준성 임시 주석 */
	            	//data.budgetInfo.budgetCode = expendUseEmp.erpDeptSeq;
	            	//data.budgetInfo.budgetName = expendUseEmp.erpDeptName;
	            	data.budgetInfo.budgetCode = data.empInfo.erpDeptSeq;
	            	data.budgetInfo.budgetName = data.empInfo.erpDeptName;
	            	data.budgetInfo.budgetGbn = 'D';
				}
	            else if(expendBudgetInfo.erpType === 'iCUBE' && expendBudgetInfo.budgetType === 'P'){
	            	if(data.projectInfo.projectCode === ''){
	            		alert("<%=BizboxAMessage.getMessage("TX000007086","프로젝트를 선택하여 주십시요.")%>");
	            		return false;
	            	}
	            	data.budgetInfo.budgetCode = data.projectInfo.projectCode;
	            	data.budgetInfo.budgetName = data.projectInfo.projectName;
	            	data.budgetInfo.budgetGbn = 'P';
				}
	        	
	        }
        }
        data = fnConvertJavaParam(data); /* Java 전달을 위해, 하위 JSON 은 string 으로 변환 */

        /* 서버호출 */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/expend/ex/user/card/ExCardInfoMapUpdate.do"/>';
        ajaxParam.async = false;
        ajaxParam.data = data;
        ajaxParam.callback = function( data ) {
			//저장시 필요한 input값 초기화
        	fnInitExpendCardInput();
			
        	//사유구분, 불공제구분 숨김처리
        	$('#ExpendCardVa, #ExpendCardNoTax').hide();

			//카드사용내역 조회
            btnExpendCardListSearch();
        };

        fnCallAjax(ajaxParam);

        return;
    }

    /* 이벤트 정의 호출 - 반영 */
    function fnExpendCardToExpend( param ) {
    			
        param = ((typeof param == 'object' ? '' : param) || '');

        var data = {};
        data.target = fnGetCheckboxInfo('inp_CardChk');
        $.each(data.target, function( idx, item ) {
            data.target[idx].syncId = item.key;
        });
        
        if(data.target.length == 0){
        	alert('내역을 선택 후 진행하여 주시길 바랍니다.');
        	return false;
        }else if((listCount + data.target.length) > maxListLength){
    		alert("<%=BizboxAMessage.getMessage("TX000016473","항목을 추가 할 수 없습니다. (사유 : 결의내역 최대 입력 건수 초과.) ")%>"+ "\n" + 
    				"<%=BizboxAMessage.getMessage("TX000016481","지출결의 설정에서 설정 할 수 있습니다.")%>"
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016498","선택한 개수")%>" + " : "+ data.target.length
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016496","설정된 최대 개수")%>" + " : "+ maxListLength); 
    		return false;
    	}
       
        /* 사용자 정보 */
		data.emp = $(cardElement.emp.info).getJson(ExCodeOrg);
        data.expendSeq = expend.get("expendSeq");
        data.isUseBudget = isUseBudget;
        
    	/* 준성 예산정보 필수입력 설정에 대한 사용/미사용 여부 체크 */
    	if(ifSystem == 'ERPiU'){
    		var budgetUseYn = option.filter(function(item){
        	    if(item.option_code === '003302'){
        	        return item.option_value;
        	    }
        	})	
        	/* 준성 예산정보 필수입력 설정에 대한 사용/미사용 여부 체크 */
            data.budgetUseYn = budgetUseYn[0].option_value;
    	}
    	
        /* 분개단위 입력 여부 확인 */
        data.isSlipMode = isInsertSlipMode;
        /* 결재 중 수정 관련 변수 */
        data.formInfo = JSON.stringify(formInfo);
        /* 취소분 포함해서 조회하는지 구분 */
        data.isSearchWithCancel = '${ViewBag.isSearchWithCancel}';
        PLP_fnInitPop();
        PLP_fnShowProgressDialog({
			title : '카드사용내역 반영'	
				, progText : '카드사용내역 반영을 진행중입니다.'
				, endText : '카드사용내역 반영이 완료되었습니다.'
				, popupPageTitle : '사용내역 반영 실패사유'
				, popupColGbn : '승인정보'
				, popupColDetail : '실패사유'
		});
        $('#PLP_divMainProgPop > .pop_head:not(:contains("반영"))').remove()
        $("#PLP_divMainProgPop").css("z-index",104);
        PLP_fnSetProgressValue(0, 0, data.target.length);
        fnRecurForSave(0, data, data.target);
        
        return;
    }

    /* 프로그레스 재귀 구성 */ 
    function fnRecurForSave(idx, data, orgnTarget){
    	var length = orgnTarget.length;
		if(idx >= length){
			// 프로그레스 일정 종료
			PLP_fnEndProgressDialog();
			
			/* 선택 내역 정상 반영인 경우 자동 창 닫기 */
			if( plp_errInfo.length == 0 ){
				$('#PLP_btnConfirm').hide();
				setTimeout(function(){
					$('#PLP_btnPopClose').click();
					$("#btnExpendCardColose").click();
					fnExCloseLayPop();
				}, 400);
			}else{
				// 리스트 갱신
				setTimeout(function(){
					btnExpendCardListSearch();
				},420);	
			}
			return ;
		}
		
		data.target = [orgnTarget[idx++]];
        /* 서버호출 */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/expend/ex/user/card/ExCardInfoMake.do" />';
        ajaxParam.async = true;
        ajaxParam.data = fnConvertJavaParam(data); /* Java 전달을 위해, 하위 JSON 은 string 으로 변환 */
        ajaxParam.callback = function( result ) {
               if (result.aaData.code == 'SUCCESS') {
                   window['${ViewBag.callback}']();
                   PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
                   fnRecurForSave(idx, data, orgnTarget);
               } else {
            	var tempKey = JSON.parse(data.target || {})[0].key; 
               	PLP_fnSetErrInfo({
   					'colGbn' : $('#inp_CardChk' + tempKey).parent().next('td').html()
   					, 'colDetail' : result.aaData.error
   				});
               	PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);
               	fnRecurForSave(idx, data, orgnTarget);
               }
        };

        fnCallAjax(ajaxParam);
    }
    
    /* 이벤트 콜백 ( 카드사용내역 ) */
    function fnExpendCardCallback( param ) {
		var type = param.type;
        var target;
		var nowId;
        switch (type) {
	        case expendType.emp:
	        	nowId = 'txtExpendCardDispEmp';
	        	target = $([ cardElement.emp.info, cardElement.emp.disp
	        	             , cardElement.dept.info, cardElement.dept.disp
	        	             , cardElement.cc.info, cardElement.cc.disp ].join(', '));
                var empInfo = $(cardElement.emp.info).getJson(ExCodeOrg);
                
                /* 사용자 */
                empInfo.erpEmpName = (param.obj.erpEmpName || '');
                empInfo.erpEmpSeq = (param.obj.erpEmpSeq || '');
                /* 부서 */
                empInfo.erpDeptName = (param.obj.erpDeptName || '');
                empInfo.erpDeptSeq = (param.obj.erpDeptSeq || '');
                /* 사업장 */
                empInfo.erpBizName = (param.obj.erpBizName || '');
                empInfo.erpBizSeq = (param.obj.erpBizSeq || '');
             
                
                if(ifSystem === 'ERPiU'){
	                /* 회계단위 */
	                empInfo.erpPcName = $('#txtExpendPcName').val(); /* (param.obj.erpPcName || ''); */
	                empInfo.erpPcSeq = $('#txtExpendPcCode').val(); /* (param.obj.erpPcSeq || ''); */
	                /* 코스트센터 */
	                empInfo.erpCcName = (param.obj.erpCcName || '');
	                empInfo.erpCcSeq = (param.obj.erpCcSeq || '');
	                
	                /* 거래처계좌번호  */
	                empInfo.depositCd = (param.obj.depositCd || '');
	                empInfo.depositCd2 = (param.obj.depositCd2 || '');
	                empInfo.depositName = (param.obj.depositName || '');
	                empInfo.depositName2 = (param.obj.depositName2 || '');
                }
                empInfo.seq = 0;
                param.obj = empInfo;
	        	break;
	        case expendType.dept:
	        	target = $([ cardElement.dept.info, cardElement.dept.disp ].join(', '));
	        	
	        	/* 부서 */
	        	var empInfo = $(cardElement.emp.info).getJson(ExCodeOrg);
                empInfo.erpDeptName = (param.obj.erpDeptName || '');
                empInfo.erpDeptSeq = (param.obj.erpDeptSeq || '');
                
                param.obj = empInfo;
	        	
                break;
            case expendType.pc:
            	// nowId = 'txtExpendCardDispPc';
                // target = $([ cardElement.emp.info, cardElement.pc.disp ].join(', '));
                var empInfo = $(cardElement.emp.info).getJson(ExCodeOrg);
                empInfo.erpPcName = ($('#txtExpendPcName').val() || '');
                empInfo.erpPcSeq = ($('#txtExpendPcCode').val() || '');
                empInfo.seq = 0;
                param.obj = empInfo;
                break;
            case expendType.cc:
            	nowId = 'txtExpendCardDispCc';
                target = $([ cardElement.emp.info, cardElement.cc.disp ].join(', '));
                var empInfo = $(cardElement.emp.info).getJson(ExCodeOrg);
                empInfo.erpCcName = (param.obj.erpCcName || '');
                empInfo.erpCcSeq = (param.obj.erpCcSeq || '');
                empInfo.seq = 0;
                param.obj = empInfo;
                break;
            case expendType.summary:
            	nowId = 'txtExpendCardDispSummary';
                target = $([ cardElement.summary.info, cardElement.summary.disp ].join(', '));
                if(isAutoInputNoteInfo){
                	$("#txtExpendCardDispNote").val(param.obj.summaryName);
                }
                
                //표준적요 변경 시 예산정보 초기화(예산단위, 사업계획, 예산계정)_ERPiU만 적용
                if(ifSystem == "ERPiU" && '${ViewBag.isSummaryChangeReset}' == "Y"){
	                $("#txtExpendCardDispBudget, #txtExpendCardDispBizplan, #txtExpendCardDispBgAcct").val("");
                }
                break;
            case expendType.auth:
            	nowId = 'txtExpendCardDispAuth';
                target = $([ cardElement.auth.info, cardElement.auth.disp ].join(', '));
                break;
            case expendType.va: //사유구분
            	nowId = 'txtExpendCardDispVa';
                target = $([ cardElement.va.info, cardElement.va.disp ].join(', '));
                break;
            case expendType.notax: //불공제구분
            	nowId = 'txtExpendCardDispNoTax';
                target = $([ cardElement.noTax.info, cardElement.noTax.disp ].join(', '));
                break;
            case expendType.project:
            	nowId = 'txtExpendCardDispProject';
                target = $([ cardElement.project.info, cardElement.project.disp ].join(', '));
                break;
        }

        fnSetExpendDispValue(target, param.obj, type); /* 데이터 바인딩 */
        
        if (type == 'auth') {
            fnSetRequired('card', param.obj); /* 필수값 처리 */
            
        	if(ifSystem == "iCUBE"){
        		/*
					23 : 불공(면세매입)
					24 : 불공(매입불공제)
					26 : 불공(의제매입세액등)
					위의 경우 사유구분 값을 입력하게 한다.
				*/
        		switch (param.obj.vatTypeCode) {
					case '23':
					case '24':
					case '26':
						//사유구분
						type = 'va'
						target = $([ cardElement.va.disp, cardElement.va.info ].join(', '));
						fnSetExpendDispValue(target, param.obj, type); 
						$('#ExpendCardVa').show();		
						
						//부가세구분
						$("#hidExpendCardVatTypeInfo").val(param.obj.vatTypeCode);
						break;	
					default:
						//사유구분 초기화
						$('#ExpendCardVa').hide();
					    $([ cardElement.va.disp, cardElement.va.info ].join(', ')).val("");
					    
					    //부가세구분 초기화
						$("#hidExpendCardVatTypeInfo").val("");
					    
						var authInfoId = $(cardElement.auth.info);
						var authInfo = JSON.parse(authInfoId.val());
						
						// authInfo.vatTypeCode = '';
						// authInfo.vatTypeName = '';
						authInfo.vaTypeCode = '';
						authInfo.vaTypeName = '';
						
						authInfoId.val(JSON.stringify(authInfo));		
						break;
				}
        	} else if(ifSystem == "ERPiU"){
        		/*
					22 : 불공(세금계산서)
					50 : 불공(신용카드)
					위의 경우 불공제 구분 값을 입력하게 한다.
				*/
				switch (param.obj.vatTypeCode) {
					case '22':
					case '50':
						//불공제구분
						type = 'notax'
						target = $([ cardElement.noTax.disp, cardElement.noTax.info ].join(', '));
						fnSetExpendDispValue(target, param.obj, type); 
						$('#ExpendCardNoTax').show();		
						break;	
					default:
						//불공제구분 초기화
						$('#ExpendCardNoTax').hide();
						$([ cardElement.noTax.disp, cardElement.noTax.info ].join(', ')).val("");
						
						var authInfoId = $(cardElement.auth.info);
						var authInfo = JSON.parse(authInfoId.val());
						
						// 세무구분은 리셋되면 안됨. 2019-07-10 김상겸
						// authInfo.vatTypeCode = '';
						// authInfo.vatTypeName = '';
						authInfo.noTaxCode = '';
						authInfo.noTaxName = '';
						
						authInfoId.val(JSON.stringify(authInfo));			
						break;
				}
        	}
        }else if(type == 'va'){
        	if(ifSystem == "iCUBE"){
        		//증빙유형 정보에 사유구분 정보 입력하여 다시 저장
        		var authInfoId = $(cardElement.auth.info);
				var vaInfo = JSON.parse(authInfoId.val());
				
				vaInfo.vaTypeCode = param.obj.vaTypeCode;
				vaInfo.vaTypeName = param.obj.vaTypeName;
				vaInfo.seq = 0;
				
				authInfoId.val(JSON.stringify(vaInfo));		
				
				//포커스 이동
				$(cardElement.note).focus();
			}
        }else if(type == 'notax'){
        	if(ifSystem == "ERPiU"){
        		//증빙유형 정보에 불공제구분 정보 입력하여 다시 저장
        		var authInfoId = $(cardElement.auth.info);
				var noTaxInfo = JSON.parse(authInfoId.val());
				
				noTaxInfo.noTaxCode = param.obj.noTaxCode;
				noTaxInfo.noTaxName = param.obj.noTaxName;
				noTaxInfo.seq = 0;
				
				authInfoId.val(JSON.stringify(noTaxInfo));	
				
				//포커스 이동
				$(cardElement.note).focus();
			}
        }
        fnSetFocus(nowId); /* 포커스 처리 */

        return;
    }

    /* 이벤트 콜백 - 예산 */
    function fnExpendCardCallbackBudget( param ) {
        var budgetInfo = $(cardElement.budget.info).getJson(ExCodeOrg);
        var type = param.type;
        var target;
        var nowId;
        switch (type) {
            case expendType.budget:
            	nowId = 'txtExpendCardDispBudget';
                budgetInfo.budgetCode = param.obj.budgetCode;
                budgetInfo.budgetName = param.obj.budgetName;
                budgetInfo.budgetYm = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
                target = $([ cardElement.budget.info, cardElement.budget.disp ].join(', '));
                break;
            case expendType.bizplan:
            	nowId = 'txtExpendCardDispBizplan';
                budgetInfo.bizplanCode = (param.obj.bizplanCode || '***');
                budgetInfo.bizplanName = (param.obj.bizplanName || '***');
                budgetInfo.budgetYm = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
                target = $([ cardElement.bizplan.info, cardElement.bizplan.disp ].join(', '));
                break;
            case expendType.bgacct:
            	nowId = 'txtExpendCardDispBgAcct';
                budgetInfo.bgacctCode = param.obj.bgacctCode;
                budgetInfo.bgacctName = param.obj.bgacctName;
                budgetInfo.budgetYm = fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, ''));
                
				// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                budgetInfo.cdBgLevel = (param.obj.cdBgLevel || '');
                budgetInfo.ynControl = (param.obj.ynControl || '');
                budgetInfo.tpControl = (param.obj.tpControl || '');
                
                target = $([ cardElement.bgacct.info, cardElement.bgacct.disp ].join(', '));
                break;
        }

        fnSetExpendDispValue(target, budgetInfo, type); /* 데이터 바인딩 */
        fnSetFocus(nowId); /* 포커스 처리 */

        return;
    }

    /* 공통사용 */
    /* 공통사용 - 팝업호출 파라미터 */
    function fnMakePopParam( getParam ) {
        var param = {};
        param.url = '';
        param.title = '';
        param.width = 650;
        param.height = 689;
        param.opener = '3';
        param.parentId = 'layerExpendCard';
        param.childerenId = 'layerCommonCode';
        param.getParam = getParam;
        return param;
    }

    /* 공통사용 - 파업 호출 */
    function fnCallPopup( param ) {
        layerPopOpen(param.url, '', param.title, param.width, param.height, param.opener, param.parentId, param.childerenId);
    }

    /* 공통사용 - 포커스 이동 */
//     function fnSetFocus() {
//         var target = [ 'txtExpendCardDispSummary', 'txtExpendCardDispAuth', 'txtExpendCardDispNote', 'txtExpendCardDispProject', 'txtExpendCardDispBudget', 'txtExpendCardDispBizplan', 'txtExpendCardDispBgAcct' ];
// 		// cardReqProject
//         for ( var item in target) {
//             if (($('#' + target[item]).val() || '') == '') {
//                 $('#' + target[item]).focus();
//                 break;
//             }
//         }

//         inputFlag = true;

//         return;
//     }
    function fnSetFocus(nowId) {
        var target = [ 'txtExpendCardDispSummary', 'txtExpendCardDispAuth', 'txtExpendCardDispNote', 'txtExpendCardDispProject', 'txtExpendCardDispBudget', 'txtExpendCardDispBizplan', 'txtExpendCardDispBgAcct' ];
		var required = ['cardReqSummary', 'cardReqAuth', 'cardReqNote', 'cardReqProject', 'expendCardReqBudget', 'expendCardReqBizplan', 'expendCardReqBgAcct'];
		var rowDisplay = ['ExpendCardSummary', 'ExpendCardAuth', 'ExpendCardNote', 'ExpendCardProject', 'ExpendCardReqBudget', 'ExpendCardReqBizplan', 'ExpendCardReqBgacct'];
		// cardReqProject
		for(var i = 0 ; i < target.length ; i++){
			if(nowId == ''){
				$('#txtExpendCardDispSummary').focus();
			}else if(target[i] == nowId && i < target.length){
				$('#' + target[(i+1)]).focus();
			}
		}
        inputFlag = true;
        return;
    }

    /* 버튼 - 검색 - 테이블 바인딩 - 행 클릭 */
    function fnExpendCardRowSelect( param ) {
		var objViewList = $(".inputText:visible");
		for( i = 0 ; i < objViewList.length ; i++){
			var objType = objViewList[i].id.replace('txtExpendCardDisp','').toLowerCase();
			if(objType === 'emp' || objType === 'dept' || objType === 'pc' || objType === 'cc'){
				var empInfo = $(cardElement.emp.info).getJson(ExCodeOrg);
				if(param.empSeq != 0){/* 사용자 정보 저장되어 있는경우에는 해당 사용자 정보 표시 */
					empInfo.erpEmpSeq = param.erpEmpSeq;
					empInfo.erpEmpName = param.erpEmpName;
					empInfo.erpDeptSeq = param.erpDeptSeq;
					empInfo.erpDeptName = param.erpDeptName;
					empInfo.erpPcSeq = $('#txtExpendPcCode').val(); /* param.erpPcSeq;*/
					empInfo.erpPcName = $('#txtExpendPcName').val(); /* param.erpPcName; */
					empInfo.erpCcSeq = param.erpCcSeq;
					empInfo.erpCcName = param.erpCcName; 
					empInfo.erpBizSeq = param.erpBizSeq;
					empInfo.erpBizName = param.erpBizName;
					if(objType === 'emp'){
						$("#" + objViewList[i].id).inputInit(param.erpEmpSeq, param.erpEmpName);
					}else if(objType === 'dept'){
						$("#" + objViewList[i].id).inputInit(param.erpDeptSeq, param.erpDeptName);
					}else if(objType === 'pc'){
						$("#" + objViewList[i].id).inputInit($('#txtExpendPcCode').val(), $('#txtExpendPcName').val());
					}else if(objType === 'cc'){
						$("#" + objViewList[i].id).inputInit(param.erpCcSeq, param.erpCcName);	
					}
				}else{/* 사용자 정보 저장되어 있지 않은 경우에는 로그인한 사용자의 사용자 정보 표시 */
					empInfo.erpEmpSeq = expendUseEmp.erpEmpSeq;
					empInfo.erpEmpName = expendUseEmp.erpEmpName;
					empInfo.erpDeptSeq = expendUseEmp.erpDeptSeq;
					empInfo.erpDeptName = expendUseEmp.erpDeptName;
					empInfo.erpPcSeq = $('#txtExpendPcCode').val(); /* expendUseEmp.erpPcSeq; */
					empInfo.erpPcName = $('#txtExpendPcName').val(); /* expendUseEmp.erpPcName; */
					empInfo.erpCcSeq = expendUseEmp.erpCcSeq;
					empInfo.erpCcName = expendUseEmp.erpCcName;
					empInfo.erpBizSeq = expendUseEmp.erpBizSeq;
					empInfo.erpBizName = expendUseEmp.erpBizName;
					empInfo.seq = 0;
					if(objType === 'emp'){
						$("#" + objViewList[i].id).inputInit(expendUseEmp.erpEmpSeq, expendUseEmp.erpEmpName);
					}else if(objType === 'dept'){
						$("#" + objViewList[i].id).inputInit(expendUseEmp.erpDeptSeq, expendUseEmp.erpDeptName);
					}else if(objType === 'pc'){
						$("#" + objViewList[i].id).inputInit($('#txtExpendPcCode').val(), $('#txtExpendPcName').val());
					}else if(objType === 'cc'){
						$("#" + objViewList[i].id).inputInit(expendUseEmp.erpCcSeq, expendUseEmp.erpCcName);	
					}
				}
				$('#hidExpendCardEmpInfo').val( JSON.stringify(empInfo) );
			}
			else if(objType === 'summary'){
				$("#" + objViewList[i].id).inputInit(param.summaryCode, param.summaryName);
				var summaryParam = {};
				summaryParam.summaryCode = param.summaryCode;
				summaryParam.summaryName = param.summaryName;
				summaryParam.drAcctCode = param.drAcctCode;
				summaryParam.drAcctName = param.drAcctName;
				summaryParam.seq = param.summarySeq;
				$("#hidExpendCardSummaryInfo").val(JSON.stringify(summaryParam));
				
			}else if(objType === 'note'){
				$("#" + objViewList[i].id).val(param.note);
			}else if(objType === 'auth'){
				$("#" + objViewList[i].id).inputInit(param.authCode, param.authName);
				var authParam = {};
				var authInfoId = $(cardElement.auth.info);
				
				//사유구분 또는 불공제구분의 값이 변경될 시 증빙유형을 새로 등록하기 위해 필요한 부분을 전체 조회해서 저장
				authParam.seq = param.authSeq;
				authParam.authDiv = param.authDiv;
				authParam.authCode = param.authCode;
				authParam.authName = param.authName;
				authParam.cashType = param.cashType;
				authParam.crAcctCode = param.crAcctCode;
				authParam.crAcctName = param.crAcctName;
				authParam.vatAcctCode = param.vatAcctCode;
				authParam.vatAcctName = param.vatAcctName;
				authParam.vatTypeCode = param.vatTypeCode;
				authParam.vatTypeName = param.vatTypeName;
				authParam.erpAuthCode = param.erpAuthCode;
				authParam.erpAuthName = param.erpAuthName;
				authParam.authRequiredYN = param.authRequiredYN;
				authParam.partnerRequiredYN = param.partnerRequiredYN;
				authParam.cardRequiredYN = param.cardRequiredYN;
				authParam.projectRequiredYN = param.projectRequiredYN;
				authParam.noteRequiredYN = param.noteRequiredYN;
				authParam.noTaxCode = param.noTaxCode;
				authParam.noTaxName = param.noTaxName;
				authParam.vaTypeCode = param.vaTypeCode;
				authParam.vaTypeName = param.vaTypeName;
				
				authInfoId.val(JSON.stringify(authParam));
				
				// 사유구분
				if(ifSystem == "iCUBE" && param.vaTypeCode != ""){
					$(cardElement.va.disp).inputInit(param.vaTypeCode, param.vaTypeName);
					$(cardElement.va.info).val(JSON.stringify(authParam));
					$('#ExpendCardVa').show();	
					
					//부가세구분
					$("#hidExpendCardVatTypeInfo").val(param.vatTypeCode);
				}else{
					$('#ExpendCardVa').hide();	
					$([ cardElement.va.disp, cardElement.va.info, "#hidExpendCardVatTypeInfo" ].join(', ')).val("");
				}
				
				// 불공제구분
				if(ifSystem == "ERPiU" && param.noTaxCode != ""){
					$(cardElement.noTax.disp).inputInit(param.noTaxCode, param.noTaxName);
					$(cardElement.noTax.info).val(JSON.stringify(authParam));
					$("#ExpendCardNoTax").show();	
				}else{
					$("#ExpendCardNoTax").hide();	
					$([ cardElement.noTax.disp, cardElement.noTax.info ].join(', ')).val("");
				}
			}else if(objType === 'project'){
				if($('#txtExpendCardDispProject').is('[disabled=disabled]') && param.projectCode == ''){
					$("#" + objViewList[i].id).inputInit(expendProject.projectCode, expendProject.projectName);
					var projectParam = {};
					projectParam.projectCode = expendProject.projectCode;
					projectParam.projectName = expendProject.projectName;
					projectParam.seq = 0;
					$("#hidExpendCardProjectInfo").val(JSON.stringify(projectParam));
				}else{
					$("#" + objViewList[i].id).inputInit(param.projectCode, param.projectName);
					var projectParam = {};
					projectParam.projectCode = param.projectCode;
					projectParam.projectName = param.projectName;
					projectParam.seq = param.projectSeq;
					$("#hidExpendCardProjectInfo").val(JSON.stringify(projectParam));	
				}
				
			}else if(objType === 'budget'){
				$("#" + objViewList[i].id).inputInit(param.budgetCode, param.budgetName);
				var budgetInfo = fnFormatStrToJson($(cardElement.budget.info).val());
				budgetInfo.budgetCode = param.budgetCode;
				budgetInfo.budgetName= param.budgetName;
				$(cardElement.budget.info).val(JSON.stringify(budgetInfo));
			}else if(objType === 'bizplan'){
				$("#" + objViewList[i].id).inputInit(param.bizplanCode, param.bizplanName);
				var budgetInfo = fnFormatStrToJson($(cardElement.budget.info).val());
				budgetInfo.bizplanCode = param.bizplanCode;
				budgetInfo.bizplanName= param.bizplanName;
				$(cardElement.budget.info).val(JSON.stringify(budgetInfo));
			}else if(objType === 'bgacct'){
				$("#" + objViewList[i].id).inputInit(param.bgacctCode, param.bgacctName);
				var budgetInfo = fnFormatStrToJson($(cardElement.budget.info).val());
				budgetInfo.bgacctCode = param.bgacctCode;
				budgetInfo.bgacctName = param.bgacctName;
				
				// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                budgetInfo.cdBgLevel = (param.cdBgLevel || '');
                budgetInfo.ynControl = (param.ynControl || '');
                budgetInfo.tpControl = (param.tpControl || '');
				
				$(cardElement.budget.info).val(JSON.stringify(budgetInfo));
			}
		}
		$("#hidExpendCardSelected").val(JSON.stringify(param));
	}

    /* 버튼 - 검색 - 테이블 바인딩 - 행 더블클릭 */
    function fnExpendCardRowDetailInfo() {
        var param = ($(cardElement.selectList).val() == '' ? {} : JSON.parse($(cardElement.selectList).val() || {}));
        if ((param.syncId || '0') == '0') { return; }

        /* 파라미터 : sync_id */
        var getParam = "";
        getParam += "?syncId=" + (param.syncId || '0');
        var param = fnMakePopParam(getParam);
        param.title = "<%=BizboxAMessage.getMessage("TX000006020","상세보기")%>";
        param.url = encodeURI('<c:url value="/expend/ex/user/card/ExReportCardDetailInfo.do" />' + getParam);
        fnCallPopup(param);

        return;
    }
    
    function fnRowDblClick(aData) {
        /* 파라미터 : sync_id */
        var getParam = "";
        getParam += "?syncId=" + (aData.syncId || '0');
        /* 파라미터 : */
        getParam += "&isDisplayFullNumber=" + isDisplayFullNumber;
        var param = fnMakePopParam(getParam);
		param.url = encodeURI('<c:url value="/expend/ex/user/card/ExExpendCardDetailInfo.do" />' + getParam);
        window.open(param.url,'카드 사용내역 상세보기',"width=500,height=535");  
        return;
    }
    
    /* 아이큐브 예산파라메터 생성 */
    function fnSetiCUBEBudget(){
    	
    }
    
    /* 이벤트 정의 호출 - 저장 */
    function fnExpendCardInfoReset( ) {
    	
        if(!confirm("정말로 초기화 하시겠습니까?")){
        	return;
        }
    	var data = {};
        data.target = fnGetCheckboxInfo('inp_CardChk');
        $.each(data.target, function( idx, item ) {
            data.target[idx].syncId = item.key;
        });
        
        /* 서버호출 */
        var ajaxParam = {};
        ajaxParam.url = '<c:url value="/expend/ex/user/card/ExCardInfoMapReset.do"/>';
        ajaxParam.async = false;
        ajaxParam.data = fnConvertJavaParam(data);
        ajaxParam.callback = function( data ) {
        	//저장시 필요한 input값 초기화
        	fnInitExpendCardInput();
        	
        	//사유구분, 불공제구분 숨김처리
        	$('#ExpendCardVa, #ExpendCardNoTax').hide();
        	
 			//카드사용내역 검색
            btnExpendCardListSearch();
        };

        fnCallAjax(ajaxParam);
    }
    
    //저장시 필요한 input값 초기화
    function fnInitExpendCardInput(){
    	//사용자, 부서, 코스트센터 초기화 제외
    	var notInitItem = ["emp", "dept", "cc"];
    	
    	//cardElement 오브젝트 탐색
    	$.each(cardElement, function(key, val){
    		//하위 오브젝트를 가지고 있는 것과 notInitItem에 속해있지 않은 것만 초기화
    		if(typeof val == "object" && notInitItem.indexOf(key) == -1){
	    		$.each(val, function(subKey, subVal){
	        		//disp, info input 둘다 초기화
	        		$(subVal).val("");
	    		});
    		}
    		
    		//적요는 하위 오브젝트가 없기 때문에 따로 초기화
    		if(key == "note"){
    			$(val).val("");
    		}
    	});
    }
    
    
    /* ERPiU - 예산 체크 진행 - 이준성 연구원 */
	function fnExpendERPiUBudgetChk(){
    	
		var budgetInfo = JSON.parse(($('#hidExpendCardERPiUBudgetInfo').val() || '{}'));
		
		if(expend.get("erpiuBudgetVer") != "" && (budgetInfo.ynControl || '') !== 'Y') {
			alert('예산통제 대상이 아닙니다.');
			return;
		}
		
		var bgParam = "?callback=&bgacct_code=" + budgetInfo.bgacctCode
		bgParam += "&bgacct_name=" + escape(encodeURIComponent(budgetInfo.bgacctName))
		bgParam += "&budget_code=" + budgetInfo.budgetCode;
		bgParam += "&bizplan_code=" + (budgetInfo.bizplanCode || '***');
		bgParam += "&amt=0";
		bgParam += "&budget_ym=" + ($('#txtExpendDate').val().toString().replace(/-/g, '') || budgetInfo.budgetYm +'01' );
		bgParam += "&drcr_gbn=dr";
		bgParam += "&expendSeq=" + expend.expendSeq;
		bgParam += "&listSeq=0";
		bgParam += "&basicListAmt=0";
		bgParam += "&cd_bg_level=" + (budgetInfo.cdBgLevel || '');
		bgParam += "&yn_control=" + (budgetInfo.ynControl || '');
		bgParam += "&tp_control=" + (budgetInfo.tpControl || '');
		
		var popParam = {};
		popParam.title = "${CL.ex_budgetChk}";
		popParam.width = '';
		popParam.height = '';
		popParam.opener = '3';
		popParam.parentId = '';
		popParam.childId = '';
		popParam.getParam = bgParam;
		var url = "<c:url value='/ex/user/expend/ExBudgetCheckPopup.do'/>"+ popParam.getParam;
		
		var popupWidth = 500;
		var popupHeight = 380;
		var windowX = (screen.width - popupWidth)/2;
		var windowY = (screen.height - popupHeight)/2;
		
		window.open(url,'예산확인',"width=500,height=280,left=" + windowX + ",top=" + windowY);
    	
		return;	
	}
    
	/* iCUBE - 예산 체크 진행 */
	function fnExpendiCUBEBudgetChk(){
		
		
		var budgetInfoProject = JSON.parse(($('#hidExpendCardProjectInfo').val() || '{}'));
		var budgetInfoeErpDept = JSON.parse(($('#hidExpendCardEmpInfo').val() || '{}'));

			if ($("#hidExpendCardSummaryInfo").val() !== '') {
				var acctInfo = JSON.parse($("#hidExpendCardSummaryInfo").val())
				
				_acct_code = (acctInfo.drAcctCode || 0);
				_acct_name = (acctInfo.drAcctName || '');
				if (_acct_code === 0) {
					alert("<%=BizboxAMessage.getMessage("TX000018816","잘못된 계정과목입니다")%>");
					return;
				}
			} else {
				alert("<%=BizboxAMessage.getMessage("TX000007236","표준적요를 입력해 주세요.")%>");
				return;
			}
			
			if ( expendBudgetInfo.budgetType === "D" ) {
				_budget_code = budgetInfoeErpDept.erpDeptSeq;
				
			} else if ( expendBudgetInfo.budgetType === "P" ) {
				
				if(budgetInfoProject.projectCode && budgetInfoProject.projectCode != '' && budgetInfoProject.projectCode != '0'){
					
					if( (budgetInfoProject.projectCode || '') === '' ){
						alert("<%=BizboxAMessage.getMessage("TX000007086","프로젝트를 선택하여 주십시요.")%>");
						return false;
					}
					
					_budget_code = budgetInfoProject.projectCode;	
					
				}else{
					
					if( (budgetInfoProject.projectCode || '') === '' ){
						alert("<%=BizboxAMessage.getMessage("TX000007086","프로젝트를 선택하여 주십시요.")%>");
						return false;
					}
					
					_budget_code = budgetInfoProject.projectCode;
				}
				
			} else {
				
				alert("<%=BizboxAMessage.getMessage("TX000018818","예산편성 타입이 잘못되었습니다")%>");
				return;
			}

			var bgParam = "?callback=&acct_code=" + _acct_code
					+ "&acct_name=" + escape(encodeURIComponent(_acct_name))
					+ "&budget_code=" + _budget_code
					+ "&amt=" + "0"
					+ "&budget_ym=" + (expend.expendDate || fnFormatStringToDate('yyyyMM', $('#txtExpendDate').val().toString().replace(/-/g, '')) )
					+ "&drcr_gbn=" + 'dr'
					+ "&expendSeq=" + expend.expendSeq
					+ "&listSeq=" + "0"
					+ "&basicListAmt=" + 0 + "";
			var popParam = {};
			popParam.title = "${CL.ex_budgetChk}";
			popParam.width = '';
			popParam.height = '';
			popParam.opener = '3';
			popParam.parentId = '';
			popParam.childId = '';
			popParam.getParam = bgParam;
			var url = "<c:url value='/ex/user/expend/ExBudgetCheckPopup.do'/>"+ popParam.getParam;

			var popupWidth = 500;
		    var popupHeight = 380;
		    var windowX = (screen.width - popupWidth)/2;
		    var windowY = (screen.height - popupHeight)/2;
		    
			window.open(url,"${CL.ex_budgetChk}","width=500,height=280,left=" + windowX + ",top=" + windowY);
	}
</script>

