<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>

<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<!-- 공통 정보영역 -->
<jsp:include page="../include/UserOptionMap.jsp" flush="false" />

<!-- iframe wrap -->
<!-- 컨텐츠타이틀영역 -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt class="ar" style="width:70px;">${CL.ex_gisudate}  <!--기수기준일--></dt>
			<dd><input type="text" autocomplete="off" id="dtGisuDate" value="" class="puddSetup" pudd-type="datepicker" /> </dd>
			<dt>${CL.ex_gisu}  <!--기수--></dt>
			<dd><input type="text" autocomplete="off" id="txtGisu" class="puddSetup ac" value="" style="width:48px;" disabled="true"/></dd>
			<dt class="ar" style="width:70px;">${CL.ex_searchPeriod}  <!--조회기간--></dt>
			<dd>
				<input type="text" autocomplete="off" style="width: 100px;" value="" id="txtGisuFromDate" class="puddSetup" pudd-type=""  disabled="true"/>
					~ 
				<input type="text" autocomplete="off" style="width: 100px;" id="txtGisuToDate" value="" class="puddSetup" pudd-type=""  disabled="true"/>
			</dd>
			<dt class="ar" style="width:70px;">${CL.ex_accountingUnit}  <!--회계단위--></dt>
			<dd>
				<div id="selDivList" />

				</div>
			</dd>
		</dl>
		
		<dl class="next2">
			<dt class="ar" style="width:70px;" id="txt_mgtType">${CL.ex_project}  <!--프로젝트--></dt>
			<dd>
				<input type="text" autocomplete="off" style="width:169px;" class="puddSetup" id="txtErpProjectName" readonly />
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpProjectSeq"/>
				<input type="button" id="btnProjectSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
			</dd>
			
			<dt class="ar divBottomArea" style="width:70px; display:none;" id="txt_mgtType" readonly>${CL.ex_bottomBussines}  <!--하위사업--></dt>
			<dd class="divBottomArea" style=" display:none;">
				<input type="text" autocomplete="off" style="width:306px;" class="puddSetup" id="txtErpBottomName"/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBottomSeq"/>
				<input type="button" id="btnBottomSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" /><!--선택-->
			</dd>
			
			<dt class="ar" style="width:70px;">${CL.ex_budgetSub}  <!--예산과목--></dt>
			<dd>
				<input type="text" autocomplete="off" style="width:118px;" class="puddSetup" id="txtErpBudgetName" readonly/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBudgetSeq"/>
				<input type="button" id="btnBudgetSelect" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}" />  <!--선택-->
				~
				<input type="text" autocomplete="off" style="width:118px;" class="puddSetup" id="txtErpBudgetName2" readonly/>
				<input type="hidden" style="width:227px;" class="puddSetup" id="txtErpBudgetSeq2"/>
				<input type="button" id="btnBudgetSelect2" class="puddSetup" pudd-style="height:22px;margin-left:3px;vertical-align: top;" value="${CL.ex_select}"/>  <!--선택-->
			</dd>
		</dl>
		
		<dl class="next2">
			<dt class="ar" style="width:70px;">${CL.ex_ioDivision}  <!--입출구분--></dt>
			<dd>
				<select id="selGrList" class="puddSetup" pudd-style="width:113px;" />
					<option value="" selected>${CL.ex_all}  <!--전체--></option>
					<option value="1">${CL.ex_income}  <!--수입--></option>
					<option value="2">${CL.ex_expend}  <!--지출--></option>
				</select>
			</dd>
			<dt style="width:27px;">${CL.ex_degree}  <!--차수--></dt>
			<dd><input id="txtBudgetCnt" type="text" class="puddSetup ac" value="" style="width:47px;" value="1" /></dd>		
		
			<dt class="ar" style="width:70px;">${CL.ex_budgetMoney}  <!--예산액--></dt>
			<dd>
				<select id="selOpt14List" class="puddSetup" pudd-style="width:142px;" />
					<option value="1" selected>${CL.ex_approvalBgt}  <!--승인예산--></option>
					<option value="2">${CL.ex_applyAmt}  <!--신청예산--></option>
				</select>
			</dd>
			<dt class="ar" style="width:40px;">${CL.ex_executionMoney}  <!--집행액--></dt>
			<dd>
				<select id="selOpt12List" class="puddSetup" pudd-style="width:142px;" />
					<option value="1" selected>${CL.ex_resExecution}  <!--결의집행--></option>
					<option value="2">${CL.ex_approvalExecution}  <!--승인집행--></option>
					<option value="3">${CL.ex_cashExecution}  <!--현금집행--></option>
				</select>
			</dd>
			<dt class="ar" style="width:70px;">${CL.ex_executionDate}  <!--집계일자--></dt>
			<dd>	
				<select id="selOpt13List" class="puddSetup" pudd-style="width:150px;" />
					<option value="1" selected>${CL.ex_purcaseDate}</option>
					<option value="2">${CL.ex_approvalDate}  <!--승인일자--></option>
					<option value="3">${CL.ex_ioDate}  <!--입출일자--></option>
				</select>
			</dd>
			<dd><input type="button" class="puddSetup submit" value="${CL.ex_search}" id="btnSerchYesilList"/></dd> <!--검색-->
		</dl>
	</div>


	<div class="btn_div cl">
		<div class="left_div">			
			<h5 class="fl">${CL.ex_budgetDifferCondition}  <!--예실대비 현황--></h5>
			<div class="fl ml10 mt3">
				<input type="checkbox" name="inp_chk" id="checkBgt1" class="checkBgt"/>&nbsp;<label class="" for="checkBgt1" checked>${CL.ex_bgt1Name}  <!--관--></label>
				<input type="checkbox" name="inp_chk" id="checkBgt2" class="checkBgt"/>&nbsp;<label class="" for="checkBgt2">${CL.ex_bgt2Name}  <!--항--></label>
				<input type="checkbox" name="inp_chk" id="checkBgt3" class="checkBgt"/>&nbsp;<label class="" for="checkBgt3">${CL.ex_bgt3Name}  <!--목--></label>
				<input type="checkbox" name="inp_chk" id="checkBgt4" class="checkBgt" checked/>&nbsp;<label class="" for="checkBgt4">${CL.ex_bgt4Name}  <!--세--></label>
			</div>
		</div>
		<div class="right_div mr15">
			<div class="controll_btn p0">
				<input type="checkbox" name="inp_chk" id="checkZeroLineCode" class=""/>&nbsp;<label class="" for="checkZeroLineCode">${CL.ex_existentSearch}  <!--금액 있는 건만 조회--></label>	
			
				<button id="btnExcelDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
			</div>
		</div>
	</div>

	<!-- 테이블 -->
	<div id="tblYesil" class="dal_Box" style="height: 350px;">
		<div class="dal_BoxIn posi_re" item="{}" style="height: 616px;">
			<div class="posi_left" item="{}" style="width: 500px;">
				<div class="com_ta2 rowHeight ovh leftHeader borderR" item="{}">
					<table item="{}">
						<colgroup item="{}">
							<col width="100" item="{}">
							<col width="100" item="{}">
							<col width="" item="{}">
						</colgroup>
						<thead item="{}">
							<tr item="{}">
								<th item="{}" rowspan="2" style="height:46px">${CL.ex_budgetCode}  <!--예산코드--></th>
								<th item="{}" rowspan="2" style="height:46px">${CL.ex_subjectDivision}  <!--과목구분--></th>
								<th item="{}" rowspan="2" style="height:46px">${CL.ex_budgetSubjectNm}  <!--예산과목명--></th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="com_ta2 rowHeight cursor_p ova_sc2 bg_lightgray ovh leftContents" item="{}" style="height: 456px;">
					<table item="{}">
						<colgroup item="{}">
							<col width="100" item="{}">
							<col width="100" item="{}">
							<col width="" item="{}">
						</colgroup>
						<tbody id="yesilTable_titleContents" item="{}">
							<tr>
								<td colspan="3">
									${CL.ex_inputData}  <!--데이터를 검색하세요.-->
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="posi_right" item="{}" style="left: 500px;">
				<div class="com_ta2 rowHeight hover_no ovh rightHeader mr17"  item="{}">
					<table item="{}">
						<colgroup item="{}">
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
						</colgroup>
						<thead item="{}">
							<tr>
								<th id="bgtAmt" colspan="5" item="{}">${CL.ex_budgetAmt}  <!--예산금액--></th>
								<th colspan="4" item="{}">${CL.ex_budgetExcutionAmt}  <!--집행금액--></th>
								<th rowspan="2" item="{}">${CL.ex_executionBalance}  <!--집행잔액--></th>
								<th rowspan="2" item="{}">${CL.ex_executionRate}  <!--집행률--></th>
							</tr>
							<tr item="{}">
								<th item="{}">${CL.ex_nextBgt}  <!--이월예산--></th>
								<th item="{}">${CL.ex_approvalBgt}  <!--승인예산--></th>
								<th item="{}">${CL.ex_supplementaryBgt}  <!--추경예산--></th>
								<th item="{}">${CL.ex_exclusiveBgt}  <!--전용액--></th>
								<th item="{}">${CL.ex_bgtSum}  <!--예산합계--></th>
								<th id="erpAllocationAmt" item="{}">기간배정액</th>
								<th item="{}">${CL.ex_consBal}  <!--품의잔액--></th>
								<th item="{}">${CL.ex_notTransRes}  <!--미전송 결의--></th>
								<th id="erpResBgt" item="{}">${CL.ex_erpResBgt}  <!--결의금액(ERP)--></th>
								<th item="{}">${CL.ex_totalAmt}  <!--합계--></th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="com_ta2 rowHeight ova_sc2 hover_no bg_lightgray rightContents" item="{}" style="height: 473px;" onscroll="dalBoxScroll()">
					<table item="{}">
						<colgroup item="{}">
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
							<col width="150" >
						</colgroup>
						<tbody id="yesilTable_contentsContents" item="{}">
							<tr>
								<td colspan="12" class="">
									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	

</div><!-- //sub_contents_wrap -->
</div><!-- iframe wrap -->


<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="fileName" value="" id="fileName" />
	<input type="hidden" name="excelHeader" value="" id="excelHeader" />
	<input type="hidden" name="procType" value="yesil" id="" />
	<input type="hidden" name="erpCompSeq" value="" id="formerpCompSeq" />
	<input type="hidden" name="erpGisu" value="" id="formerpGisu" />
	<input type="hidden" name="erpDivSeq" value="" id="formerpDivSeq" />
	<input type="hidden" name="erpMgtSeq" value="" id="formerpMgtSeq" />
	<input type="hidden" name="grCode" value="" id="formgrCode" />
	<input type="hidden" name="budgetCnt" value="" id="formbudgetCnt" />
	<input type="hidden" name="divCode" value="" id="formdivCode" />
	<input type="hidden" name="fromBudgetSeq" value="" id="formfromBudgetSeq" />
	<input type="hidden" name="toBudgetSeq" value="" id="formtoBudgetSeq" />
	<input type="hidden" name="option12" value="" id="formoption12" />
	<input type="hidden" name="option13" value="" id="formoption13" />
	<input type="hidden" name="option14" value="" id="formoption14" />
	<input type="hidden" name="fromDate" value="" id="formfromDate" />
	<input type="hidden" name="toDate" value="" id="formtoDate" />
	<input type="hidden" name="erpEmpSeq" value="" id="formerpEmpSeq" />
	<input type="hidden" name="zeroLineCode" value="" id="formzeroLineCode" />
	<input type="hidden" name="bottomSeq" value="" id="formbottomSeq" />
	<input type="hidden" name="orgnErpMgtSeq" value="" id="formorgnErpMgtSeq" />
	<input type="hidden" name="orgnErpBudgetSeq" value="" id="formorgnErpBudgetSeq" />
	<input type="hidden" name="orgnErpBottomSeq" value="" id="formorgnErpBottomSeq" />
	<input type="hidden" name="formoptionAllocate" value="" id="formoptionAllocate" />
</form>


<script>
	/*	스크립트 준비
	-------------------------------------- */
	$(document).ready(function(){
		
		/* 돔 객체 초기화 */
		fnSetElementIntit();
		
		/* ERP 기수 정보 조회 */
		fnGetGisuInfo();
		
		/* ERP 회계단위 리스트 조회 */
		fnGetDivList();
		
		/* ERP 프로젝트 리스트 조회 */
		// fnGetProjectList();
		
		/* 돔객체 이벤트 지정 */
		fnSetEvent();
		
		/* 부서/프로젝트 예산통제 구분 설정 */
		fnSetMgtType();
		
		/* 하위사업 사용여부 판단및 출력 */
		fnSetBottomOption();
		
		/* 예실대비 현황 사이즈 재조정 */
		setTimeout(function (){
			$('.dal_BoxIn').css('height', '641');
			$('#tblYesil').css('height', '600');
			$('.rightContents').css('height', '541');
			$('.leftContents').css('height', '524'); 	
		}, 300);
	});

	/*	[옵션] 하위 사업 사용여부 옵션에 따른 엘리먼트 초기화
	-------------------------------------- */
	function fnSetBottomOption(){
		var bottomUse = '0';
		try{
			bottomUse = optionSet['erp']['4']['14'].USE_YN;
		}catch(e){
			console.log('EXCEPTION ] >> 사용자 하위 사업 여부 판단 실패');
			bottomUse = '0';
		}
		
		if(bottomUse == '1'){
			$('.divBottomArea').show();
			
		}
		 
		/* 하위사업 선택 버튼 클릭 이벤트 지정 */
		$('#btnBottomSelect').click(function(){
			var param = {};
            param.erpMgtSeq = $('#txtErpProjectSeq').val();
			fnCommonCodePop('bottom2', param, 'fnCallbackBottomList');
		});
	}
	
	/*	[하위사업] 하위사업 선택 콜백
	-------------------------------------- */
	function fnCallbackBottomList(param){
		console.log('하위 사업 선택 콜백');
		console.log(param);
		var resultList = [];
		var seqs = '';
		for(var i = 0; i < param.length; i++){
			var item = JSON.parse( unescape( param[i] ) );
			resultList.push(item);
			seqs += '|' + item.bottomSeq;
		}
		seqs += '|';
		
		var advTxt = '';
		if(resultList.length > 1){
			advTxt = ' 외 ' + (resultList.length - 1) + '건';  
		}
		
		if(resultList.length > 0){
			$('#txtErpBottomName').val(resultList[0].bottomName + advTxt);
			$('#txtErpBottomSeq').val(seqs);
		} else {
			$('#txtErpBottomName').val('');
			$('#txtErpBottomSeq').val('');
		}
	}
	
	/*	[옵션] 돔객체 초기화
	-------------------------------------- */
	function fnSetMgtType(){
		/* 부서 통제 옵션 사용의 경우 별도 예외 처리 */
		if(optionSet.erp[4]['01'].FG_TY == '1'){
			$('#txt_mgtType').html('${CL.ex_department}');
		}
	}
	
	/*	[초기화] 돔객체 초기화
	-------------------------------------- */
	function fnSetElementIntit(){
		/* 기수 기준일 초기화 -> 오늘 날짜*/
		if('${ViewBag.empInfo.langCode}'=='en'){
			Pudd.Resource.Calendar.weekName = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
			Pudd.Resource.Calendar.todayNameStr = "today";
		}
		$('#dtGisuDate').prop('value', fnGetTodyString());
		
		Pudd( "#dtGisuDate" ).on( "change", function(){
			/* 기수 기준일에 따른 기수 정보 변경 */
			var baseDate = Pudd( this ).val();
			baseDate = baseDate.replace(/-/gi, '');
			if( ( baseDate < optionSet.erpGisu.fromDate ) || (baseDate > optionSet.erpGisu.toDate)){
				console.log('기수 정보 재조회');
				
				/* erp 기수 정보 재조회 */
				$.ajax({
					type : 'post',
					url : '<c:url value='/expend/np/admin/code/ExProcDataSelect.do'/>',
					datatype : 'json',
					async : false,
					data : {
						procType : 'commonGisuInfo'
						, erpCompSeq : optionSet.erpEmpInfo.erpCompSeq
						, erpType : optionSet.conVo.erpTypeCode
						, baseDate : baseDate
					},
					success : function(result) {
						if(result.result.resultCode == 'SUCCESS'){
							var item = result.result.aaData[0];
							optionSet.erpGisu.gisu = item.gisu;
							optionSet.erpGisu.fromDate = item.fromDate;
							optionSet.erpGisu.toDate = item.toDate;
							
							$('#txtGisuFromDate').val(fnGetDateFormat( optionSet.erpGisu.fromDate ));
							$('#txtGisuToDate').val(fnGetDateFormat( optionSet.erpGisu.toDate ));
							$('#txtGisu').val(optionSet.erpGisu.gisu);
							
						}else{
							alert('기수 정보 조회 실패');
						}
					},
					error : function(result) {
						console.error(result);
					}
				});
			}
		});
		
		var erpOptionSet = ${erp_optionSet};
		if(erpOptionSet[9].USE_YN=='0'){
			$('#erpAllocationAmt').hide();			
		}
		else{
			$('#erpAllocationAmt').show();
			$('#bgtAmt').attr('colspan','6');
		}
	}
	
	/*	[초기화] 돔객체 이벤트 지정
	-------------------------------------- */
	function fnSetEvent(){

		/* [버튼/검색] 예실대비 현황 리스트 조회 및 출력 */
		$('#btnSerchYesilList').click(function(){
			fnGetYesilList();
		});
		
		/* [버튼/선택] 프로젝트 / 부서 선택 이벤트 매핑 */
		if(optionSet.erp[4]['01'].FG_TY == '1'){
			/* 관리 부서 선택 팝업 호출 */
			$('#btnProjectSelect').click(function(){
				var param = {};
	            param.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
	            param.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
	            param.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
	            param.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
	            param.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
	            param.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
	            param.erpDivSeq = Pudd( "#selDivList" ).getPuddObject().val() + "|"; /* 회계통제단위 구분값 '|' */
	          			
				fnCommonCodePop('dept2', param, 'fnCallbackProjectList');
			});
		}else {
			/* 관리 프로젝트 선택 팝업 호출 */
			$('#btnProjectSelect').click(function(){
				var param = {};
	            param.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
	            param.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
	            param.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
	            param.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
	            param.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
	            param.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
	            param.erpDivSeq = Pudd( "#selDivList" ).getPuddObject().val() + "|"; /* 회계통제단위 구분값 '|' */
	          			
				fnCommonCodePop('project2', param, 'fnCallbackProjectList');
			});
		}
		
		
		
		/* [버튼/선택] 예산과목 선택 이벤트 매핑 */
		$('#btnBudgetSelect').click(function(){
			var param = {};
            param.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
            param.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
            param.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
            param.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
            param.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
            param.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
            param.erpDivSeq = Pudd( "#selDivList" ).getPuddObject().val() + "|"; /* 회계통제단위 구분값 '|' */
            param.erpMgtSeq = ( $('#txtErpProjectSeq').val() || '' ) + "|"; /* 예산통제단위 구분값 '|' */
            param.bottomSeq = $('#txtErpBottomSeq').val()||'';
            param.opt01 = '2'; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
            param.opt02 = '1'; /* 1: 모두표시, 2: 사용기한결과분 숨김 */
			param.opt03 = ''; /* 상위과목표시 1: 모두 표시, 2: 최하위 표시 */
			param.isYesil = 'Y'; /*예실대비현황 분기처리 위한 옵션*/

			fnCommonCodePop('budgetlist', param, 'fnCallbackBudgetList');
		});
		
		/* [버튼/선택] 예산과목 선택 이벤트 매핑 */
		$('#btnBudgetSelect2').click(function(){
			var param = {};
            param.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
            param.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
            param.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
            param.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
            param.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
            param.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
            param.erpDivSeq = Pudd( "#selDivList" ).getPuddObject().val() + "|"; /* 회계통제단위 구분값 '|' */
            param.erpMgtSeq = ( $('#txtErpProjectSeq').val() || '' ) + "|"; /* 예산통제단위 구분값 '|' */
            param.bottomSeq = $('#txtErpBottomSeq').val()||'';
            param.opt01 = '2'; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
            param.opt02 = '1'; /* 1: 모두표시, 2: 사용기한결과분 숨김 */
			param.opt03 = ''; /* 상위과목표시 1: 모두 표시, 2: 최하위 표시 */
			param.isYesil = 'Y'; /*예실대비현황 분기처리 위한 옵션*/
			
			fnCommonCodePop('budgetlist', param, 'fnCallbackBudgetList2');
		});
		
		
		/* 관항목세 단일선택 지원 */
		$('.checkBgt').change(function(){
			if (this.checked) {
				$(this).siblings('.checkBgt').attr('checked',false);
			}
		});
		
		/* 테이블 상세 영역 스크롤 동기화 */
        var num = 0;
        $('.dal_BoxIn .leftContents').unbind().on('mousewheel DOMMouseScroll', function (e) {
            if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0) {
                var rightConScVal = $(".dal_BoxIn .rightContents").scrollTop();
                if (num < rightConScVal) {
                    return false;
                } else {
                    num -= 120;
                    $(".dal_BoxIn .rightContents").scrollTop(num);
                };
            } else {
                var rightConScVal = $(".dal_BoxIn .rightContents").scrollTop();
                if (num > rightConScVal) {
                    return false;
                } else {
                    num += 120;
                    $(".dal_BoxIn .rightContents").scrollTop(num);
                };
            };
        });
        
        /* 차수 입력범위 통제 1~99 */
        $('#txtBudgetCnt').on('keyup keypress blur change', function(e) {
            if($(this).val().size == 0){
            	return false;
            }
            	
        	if($(this).val() > 99){
              $(this).val('99');
              return false;
            }else if($(this).val() < 1 ){
            	$(this).val('1');
                return false;
            }
          });
        
		/* 엑셀 다운로드 이벤트 정의 */
        $("#btnExcelDown").click(function(){
			fnAdminReportExcelDown();
		});
	}
	
	
	 /*	[ 엑셀 ] 예실대비현황
	--------------------------------------*/
	function fnAdminReportExcelDown() {
		if(!yesilListCnt){
			alert("${CL.ex_dataDoNotExists}");
			return;
		}

		$("#fileName").val( "예실대비현황" );

		/* Excel 헤더 정의 */
	
		var excelHeader = {};
		excelHeader.erpBudgetSeq = "예산코드";
		excelHeader.erpBudgetLevelName = "과목구분";
		excelHeader.erpBudgetName = "예산과목명";
		excelHeader.erpCarryAmt = "이월예산";
		excelHeader.erpOpenAmt = "승인예산";
		excelHeader.erpFutureAmt = "추경예산";
		excelHeader.erpExcAmt = "전용액";
		excelHeader.erpSumAmt = "예산합계";
		excelHeader.consBalanceAmt = "품의잔액(GW)";
		excelHeader.nonSendResAmt = "미전송 결의(GW)";
		excelHeader.erpResAmt = "결의금액(ERP)";		
		excelHeader.totalAmt = "집행합계";
		excelHeader.resultAmt = "집행잔액";
		excelHeader.amtRate = "집행률";

		$("#excelHeader").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	
	/*	[초기화] 각개 테이블 스크롤 정보 동기화
	-------------------------------------- */
	function dalBoxScroll() {
	    var rightTableContentsTop = $(".dal_BoxIn .rightContents").scrollTop();
	    var rightTableContentsLeft = $(".dal_BoxIn .rightContents").scrollLeft();
	    $(".dal_BoxIn .leftContents").scrollTop(rightTableContentsTop);
	    $(".dal_BoxIn .rightHeader").scrollLeft(rightTableContentsLeft);
	};


	/**
		예실대비 현황 리스트 조회 메인 리스트 관리
	**/

	/* [예실대비 현황] 예실대비 현황 리스트 조회 
	-------------------------------------- */
	function fnGetYesilList(){
		
		var param = fnGetCommonParam();
		if(!param.fromBudgetSeq){
			alert('예산과목을 선택하여 주세요.');
			return;
		}
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/admin/report/NpAdminYesilReport.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버 오류 발생');
					console.log(result.result.errorTrace);
				}else{
					console.log('################# 예실대비 현황 데이터 출력 ################');

					/* 예실대비 현황 데이터 출력 함수 호출 */
					fnSetYesilTable(result);
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	/* [예실대비 현황] 예실대비 현황 조회 파라미터 
	-------------------------------------- */
	function fnGetCommonParam(){
		var erpOptionSet = ${erp_optionSet};
		/* 관,항,목,세 구분 선택 */
		var divCode = 0; 
		if( $('#checkBgt1').prop('checked') ){
			divCode = 1;
		} else if( $('#checkBgt2').prop('checked') ){
			divCode = 2;
		} else if( $('#checkBgt3').prop('checked') ){
			divCode = 3;
		} else if( $('#checkBgt4').prop('checked') ){
			divCode = 4;
		}
		
		/* 액셀 다운로드 파라미터 세팅 */
		$('#formerpCompSeq').val(optionSet.conVo.erpCompSeq); 
		$('#formerpGisu').val($('#txtGisu').val());	
		$('#formerpDivSeq').val(Pudd( "#selDivList" ).getPuddObject().val() + '|');	
		$('#formerpMgtSeq').val($('#txtErpProjectSeq').val() + '|');	
		$('#formgrCode').val(Pudd( "#selGrList" ).getPuddObject().val());	
		$('#formbudgetCnt').val($('#txtBudgetCnt').val() ? $('#txtBudgetCnt').val() : 1 );	
		$('#formdivCode').val(divCode);	
		$('#formfromBudgetSeq').val($('#txtErpBudgetSeq').val() );			
		$('#formtoBudgetSeq').val( $('#txtErpBudgetSeq2').val());		
		$('#formoption12').val(Pudd( "#selOpt12List" ).getPuddObject().val());	
		$('#formoption13').val( Pudd( "#selOpt13List" ).getPuddObject().val());	
		$('#formoption14').val(Pudd( "#selOpt14List" ).getPuddObject().val());	
		$('#formfromDate').val( $('#txtGisuToDate').val().replace(/-/g, ''));	
		$('#formtoDate').val($('#txtGisuToDate'  ).val().replace(/-/g, '') + '|');	
		$('#formfromDate').val($('#txtGisuFromDate').val().replace(/-/g, '') + '|');	
		$('#formerpEmpSeq').val(optionSet.conVo.erpEmpSeq);	
		$('#formzeroLineCode').val( $('#checkZeroLineCode').prop('checked') ? 2 : 1);	
		$('#formbottomSeq').val( $('#txtErpBottomSeq').val() + '|' );	
		$('#formorgnErpMgtSeq').val($('#txtErpProjectSeq').val());	
		$('#formorgnErpBudgetSeq').val( $('#txtErpBudgetSeq').val());
		$('#formorgnErpBottomSeq').val( $('#txtErpBottomSeq').val());
		if(erpOptionSet[9].USE_YN == '1'){
			$('#formoptionAllocate').val("1");
		}
		var param= {
			erpCompSeq : optionSet.conVo.erpCompSeq
			, erpGisu : $('#txtGisu').val()
			, erpDivSeq : Pudd( "#selDivList" ).getPuddObject().val() + '|'
			, erpMgtSeq : $('#txtErpProjectSeq').val() + '|'
			, grCode : Pudd( "#selGrList" ).getPuddObject().val()
			, budgetCnt : $('#txtBudgetCnt').val() ? $('#txtBudgetCnt').val() : 1 
			, divCode : divCode
			, fromBudgetSeq : $('#txtErpBudgetSeq').val() 		
			, toBudgetSeq : $('#txtErpBudgetSeq2').val()
			, option12 : Pudd( "#selOpt12List" ).getPuddObject().val()
			, option13 : Pudd( "#selOpt13List" ).getPuddObject().val()
			, option14 : Pudd( "#selOpt14List" ).getPuddObject().val()
			, fromDate : $('#txtGisuToDate').val().replace(/-/g, '')		
			, toDate :  $('#txtGisuToDate'  ).val().replace(/-/g, '') + '|'
			, fromDate :$('#txtGisuFromDate').val().replace(/-/g, '') + '|'
			, erpEmpSeq : optionSet.conVo.erpEmpSeq
			, zeroLineCode : $('#checkZeroLineCode').prop('checked') ? 2 : 1 /* [금액 있는건만 표기 2 / 전체 1] */
			, bottomSeq : $('#txtErpBottomSeq').val() + '|'
			, orgnErpMgtSeq : $('#txtErpProjectSeq').val() || ''
			, orgnErpBudgetSeq : $('#txtErpBudgetSeq').val() || ''
			, orgnErpBottomSeq : $('#txtErpBottomSeq').val() || ''
			, formoptionAllocate : $('#formoptionAllocate').val() || ''
		};
		return param;
	}
		
	/*	[예실대비 현황] 예실대비 현황 데이터 없음 출력
	-------------------------------------- */
	function fnSetYesilNoData(){
		$('#yesilTable_titleContents').empty();
		$('#yesilTable_contentsContents').empty();
		
		var controllTrs = '<tr><td colspan="3">검색 결과가 없습니다.</td></tr>';
		var contentsTrs = '<tr><td colspan="12" class=""></td></tr>'
		$('#yesilTable_titleContents').append(controllTrs);
		$('#yesilTable_contentsContents').append(contentsTrs);
	}
	
	/*	[예실대비 현황] 예실대비 현황 데이터 출력
	-------------------------------------- */
	var yesilListCnt = 0;
	function fnSetYesilTable(param){
		var erpOptionSet = ${erp_optionSet};

		var aaData = param.result.aaData;
		console.log(aaData);
		yesilListCnt = aaData.length;

		/* 데이터 없으면 기본 노출 행 출력 */
		if(aaData.length == 0){
			fnSetYesilNoData();
			return;
		}
		
		/* 테이블 데이터 초기화 */
		$('#yesilTable_titleContents').empty();
		$('#yesilTable_contentsContents').empty();
		
		var isPrintTotal = false;
		
		/* 실제 그리드 출력 */
		for(var i=0; i < aaData.length; i++){
			/* 기본 변수 선언 */
			var item = aaData[i];
			var controllTrs = '';
			var contentsTrs = '';
			item.erpBudgetName = (item.erpBudgetName||'').replaceAll("\\\"", "\\\\\"").replaceAll("'", "`");
			if( (item.erpBudgetSeq == '0000000000')) {
				continue;
			}
		
			/* [좌] 컨트롤 테이블 데이터 입력 */
			controllTrs += ' <tr class="clickableTitle">';
			controllTrs += '	<td ' + fnGetBgStyle(item) + ' class="le"> ' + fnShowText(item.erpBudgetSeq) + ' </td>';						// 예산코드
			controllTrs += '	<td ' + fnGetBgStyle(item) + ' class="le"> ' + fnShowText(item.erpBudgetLevelName) + ' </td>';				// 과목구분
			controllTrs += '	<td ' + fnGetBgStyle(item) + ' class="borderR le">' + fnShowText(item.erpBudgetName) + '</td>';		// 예산과목명
			controllTrs += ' </tr>';
			$('#yesilTable_titleContents').append(controllTrs);
			
			/* [우] 데이터 테이블 데이터 입력 */	
			var totalAmt = fnParseInt(item.consBalanceAmt) + fnParseInt(item.nonSendResAmt) + fnParseInt(item.erpResAmt) + fnParseInt(item.erpApplyAmt);
			/* 예산 배정 옵션 사용시 기간배정액 노출 USE_YN:0 미사용 */
			if(erpOptionSet[9].USE_YN == '0'){ 
				var resultAmt = (fnParseInt(item.erpSumAmt) - fnParseInt(totalAmt));
				var amtRate = (100 - ( resultAmt / fnParseInt(item.erpSumAmt) * 100 ) ).toFixed(2) + '%';	
			}
			else{
				var resultAmt = (fnParseInt(item.erpAllocationAmt) - fnParseInt(totalAmt));
				var amtRate = (100 - ( resultAmt / fnParseInt(item.erpAllocationAmt) * 100 ) ).toFixed(2) + '%';
			}
			if( fnParseInt(item.erpSumAmt) == 0 ){
				amtRate = '0%';
			}
			amtRate = amtRate == 'NaN%' ? '0%' : amtRate;
			contentsTrs += '<tr>';
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(item.erpCarryAmt)+ '</td>';						// 이월예산
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(item.erpOpenAmt)+ '</td>';						// 승인예산
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(item.erpFutureAmt)+ '</td>';						// 추경예산
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(item.erpExcAmt)+ '</td>';							// 전용액
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(item.erpSumAmt)+ '</td>';							// 예산합계
			if(erpOptionSet[9].USE_YN == '1'){
				contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(item.erpAllocationAmt)+ '</td>';							// 기간배정액	
			}
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' 
				+ '<a href="#" class="consAmtPop text_blue" style="text-decoration:underline"  item=\'' + JSON.stringify(item) +'\'>' + fnShowAmt(item.consBalanceAmt) + '</a>'
				+ '</td>';																													// 품의잔액(GW)
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' 
				+ '<a href="#" class="resAmtPop text_blue" style="text-decoration:underline"  item=\'' + JSON.stringify(item) +'\'>' + fnShowAmt(item.nonSendResAmt) + '</a>'
				+ '</td>';																													// 미전송 결의(GW)
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' 
				+ '<a href="#" class="erpResAmtPop text_blue" style="text-decoration:underline"  item=\'' + JSON.stringify(item) +'\'>' + fnShowAmt(item.erpResAmt) + '</a>'
				+ '</td>';																													// 결의금액(ERP)			
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(totalAmt)+ '</td>';								// 합계
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="ri" > ' + fnShowAmt(resultAmt)+ '</td>';								// 집행잔액 
			contentsTrs += '	<td ' + fnGetBgStyle(item) + ' class="cen" > ' + fnShowText(amtRate)+ '</td>';								// 집행율
			contentsTrs += '</tr>';
			$('#yesilTable_contentsContents').append(contentsTrs);
		}

		/* 품의잔액 상세 정보 팝업 */
		$('.consAmtPop').click(function(){
			var item = JSON.parse($(this).attr('item'));
			/* 예산별 상세 정보 팝업 호출 */
			fnOpenAdminYesilConsAmtDetailInfo(item);
		});
		
		/* 미전송 결의금액 상세 정보 팝업 */
		$('.resAmtPop').click(function(){
			var item = JSON.parse($(this).attr('item'));
			/* 예산별 상세 정보 팝업 호출 */
			fnOpenAdminYesilResAmtDetailInfo(item);
		});
		
		/* ERP 전표 상세 정보 팝업 */
		$('.erpResAmtPop').click(function(){
			var item = JSON.parse($(this).attr('item'));
			/* 예산별 상세 정보 팝업 호출 */
			fnOpenAdminYesilERPResAmtDetailInfo(item);
		});
		
		if($('#selOpt12List').val() == '2'){
			$('#erpResBgt').html('승인금액(ERP)');
		}
		else{
			$('#erpResBgt').html('결의금액(ERP)');
		}
	}
	
	/*	[예실대비 현황] 예실대비 현황 스타일 관리 함수  
	-------------------------------------- */
	function fnGetBgStyle(item){
		var style = "style=\" ";
		
		if(item.erpBudgetLevel == 1){
			style += 'background-color:#acff87;text-overflow:ellipsis;white-space: nowrap;overflow: hidden;';
		} else if(item.erpBudgetLevel == 2){
			style += 'background-color:#bcffa7;text-overflow:ellipsis;white-space: nowrap;overflow: hidden;';
		} else if(item.erpBudgetLevel == 3){
			style += 'background-color:#d3ffc5;text-overflow:ellipsis;white-space: nowrap;overflow: hidden;';
		} else if(item.erpBudgetLevel == 4){
			style += 'background-color:#e2ffd9;text-overflow:ellipsis;white-space: nowrap;overflow: hidden;';
		} else{
			/* 기본 그리드 바탕색 - 없음. */
			// style += 'background-color:;';
			style += 'text-overflow:ellipsis;white-space: nowrap;overflow: hidden;';
		}
		/* 추가 style 변경 필요시 선택. */
		
		style += " \" ";
		
		return style
	}
	
	/**
		서버 데이터 조회	
	**/
	
	/*	[서버] 회계단위 정보 조회 
	-------------------------------------- */
	function fnGetDivList(){
		var param = {
			procType : 'div'
			, erpCompSeq : optionSet.conVo.erpCompSeq
			, baseDate : $('#dtGisuDate').prop('value').replace(/-/gi, '')
		};
		
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/admin/code/ExProcDataSelect.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					var dataSourceComboBox = new Pudd.Data.DataSource({
					    data : result.result.aaData
					});
					
					var selectedIndex = 0;
					for(var i = 0;i < result.result.aaData.length; i++){
						if(result.result.aaData[i].divSeq == optionSet.erpEmpInfo.erpDivSeq){
							selectedIndex = i;
						}
					}
					
					Pudd( "#selDivList" ).puddComboBox({
						attributes : { style : "width:360px; position:absolute;" }// control 부모 객체 속성 설정
					    , controlAttributes : {}// control 자체 객체 속성 설정
					    , dataSource : dataSourceComboBox
					    , dataValueField : "divSeq"
					    , dataTextField : "divName"
					    , selectedIndex : selectedIndex
					    , disabled : false
					    , scrollListHide : false

					});
				}else{
					alert('서버 조회도중 오류가 발생하였습니다.');
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	/*	[서버] 프로젝트 정보 조회 
	-------------------------------------- */
	function fnGetProjectList(){
		var param = {
			procType : 'project'
			, erpPjtSeq : ''
			, erpPjtName : ''
			, erpPjtStatus : '1' // 프로젝트 진행상태 진행
			, erpPjtType : ''
			, erpCompSeq : optionSet.conVo.erpCompSeq
			, erpEmpSeq : optionSet.loginVo.empSeq
			, baseDate : $('#dtGisuDate').prop('value').replace(/-/gi, '')
		};
		
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/admin/code/ExProcDataSelect.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					var dataSourceComboBox = new Pudd.Data.DataSource({
					    data : result.result.aaData
					});
					
					Pudd( "#selProjectList" ).puddComboBox({
					    attributes : { style : "width:219px;" }// control 부모 객체 속성 설정
					    , controlAttributes : {}// control 자체 객체 속성 설정
					    , dataSource : dataSourceComboBox
					    , dataValueField : "pjtSeq"
					    , dataTextField : "pjtName"
					    , selectedIndex : 1
					    , disabled : false
					    , scrollListHide : false
					});
				}else{
					alert('서버 조회도중 오류가 발생하였습니다.');
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	/*	[서버] 기수기준일에 따른 기수정보 조회 
	-------------------------------------- */
	function fnGetGisuInfo(){
		var param = {
			procType : 'gisuForDate'
			, erpCompSeq : optionSet.conVo.erpCompSeq
			, date : $('#dtGisuDate').prop('value').replace(/-/gi, '')
		};
		
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/admin/code/ExProcDataSelect.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버 오류 발생');
					console.log(result.result.errorTrace);
				}else{
					if ( result.result.aaData.length ){
						$('#txtGisuFromDate').val(fnGetDateFormat( result.result.aaData[0].gisuFromDate ));
						$('#txtGisuToDate').val(fnGetDateFormat( result.result.aaData[0].gisuToDate ));
						$('#txtGisu').val(result.result.aaData[0].gisu);
						
						optionSet.erpGisu.gisu = result.result.aaData[0].gisu;
						optionSet.erpGisu.fromDate = result.result.aaData[0].gisuFromDate;
						optionSet.erpGisu.toDate = result.result.aaData[0].gisuToDate;
						
					}else{
						alert('기수 정보 조회 실패');
					}
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}	

	
	/**
		공통 사용영역	
	**/
	
	
	/*	[공통] 데이터 수치 형변환 
	-------------------------------------- */
	function fnParseInt(value){
		if(!value){
			return 0;
		}else {
			return parseFloat(value);
		}
	}
	
	/*	[공통] 노출 텍스트 데이터 공통 처리 함수 
	-------------------------------------- */
	function fnShowText(value){
		if(!value){
			return '';
		}
		return value;
	}
	/*	[공통] 노출 금액 데이터 공통 처리 함수
	-------------------------------------- */
	function fnShowAmt(value){
		var defaultVal = 0;
	    value = '' + value || '';
	    value = '' + value.split('.')[0];
	    value = value.replace(/[^0-9\-]/g, '') || (defaultVal != undefined ? defaultVal : '0');
	    var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    return returnVal;
	}
	
	/*	[공통] 날짜 출력 형식 변환
	-------------------------------------------- */
	function fnGetDateFormat(value){
		var returnStr = '';
		if(value){
			if(value.length == 8){
				returnStr = value.substring(0, 4) + '-' + value.substring(4, 6) + '-' + value.substring(6, 8); 
			}
		}
		else {
			returnStr = '';
		}
		return returnStr;
	}
	
	/*	[공통] 오늘 날짜 조회
	-------------------------------------- */
	function fnGetTodyString(){
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		if(dd<10) { dd='0'+dd } 
		if(mm<10) { mm='0'+mm } 
		return yyyy + '-' + mm + '-' + dd ;
	}
	
	
	
	/**
		외부 팝업 호출	
	**/
	
	/*	[팝업] 예산별 상세 정보 팝업 호출  / [ERP 결의액]
	-------------------------------------- */
	function fnOpenAdminYesilERPResAmtDetailInfo(param){
		var url = "<c:url value='/expend/np/admin/AdminYesilERPResAmtDetailInfo.do'/>";
		window.open('', "AdminYesilConsAmtDetailInfo", "width=" + 1400 + ", height=" + 720 + ", left=" + 150 + ", top=" + 150);
		
		/* 팝업 파라미터 설정 */
		$('#ERP_BUDGET_SEQ').val(param.erpBudgetSeq);
		$('#ERP_BUDGET_NAME').val(param.erpBudgetName);
		$('#ERP_MGT_SEQ').val(( $( "#txtErpProjectSeq" ).val() || '' ));
		$('#ERP_BOTTOM_SEQ').val(( $( "#txtErpBottomSeq" ).val() || '' ));
		$('#ERP_GISU').val(optionSet.erpGisu.gisu);
		$('#FROM_DATE').val($('#txtGisuFromDate').val());
		$('#TO_DATE').val($('#txtGisuToDate').val());
		$('#ERP_DIV_CD').val( Pudd( "#selDivList" ).getPuddObject().val() + "|" );
		$('#ERP_DIV_NAME').val(Pudd( "#selDivList" ).getPuddObject().text());
		$('#ERP_CO_CD').val(optionSet.conVo.erpCompSeq);
		$('#ERP_EMP_CD').val(optionSet.loginVo.erpEmpCd);
		$('#OPTION_TYPE').val( parseInt($('#selOpt12List').val()) - 1 );
		
		yesilBudgetInfoPop.target = "AdminYesilConsAmtDetailInfo";
		yesilBudgetInfoPop.method = "post";
		yesilBudgetInfoPop.action = url;
		yesilBudgetInfoPop.submit();
	}
	
	/*	[팝업] 예산별 상세 정보 팝업 호출 / [품의잔액] 
	-------------------------------------- */
	function fnOpenAdminYesilConsAmtDetailInfo(param){
		var url = "<c:url value='/expend/np/admin/AdminYesilConsAmtDetailInfo.do'/>";
		window.open('', "AdminYesilConsAmtDetailInfo", "width=" + 1000 + ", height=" + 720 + ", left=" + 150 + ", top=" + 150);
		
		/* 팝업 파라미터 설정 */
		$('#ERP_BUDGET_SEQ').val(param.erpBudgetSeq);
		$('#ERP_BUDGET_NAME').val(param.erpBudgetName);
		$('#ERP_MGT_SEQ').val(( $( "#txtErpProjectSeq" ).val() || '' ));
		$('#ERP_BOTTOM_SEQ').val(( $( "#txtErpBottomSeq" ).val() || '' ));
		$('#ERP_GISU').val(optionSet.erpGisu.gisu);
		$('#FROM_DATE').val($('#txtGisuFromDate').val());
		$('#TO_DATE').val($('#txtGisuToDate').val());
		$('#ERP_DIV_CD').val( Pudd( "#selDivList" ).getPuddObject().val());
		$('#ERP_DIV_NAME').val(Pudd( "#selDivList" ).getPuddObject().text());
		
		yesilBudgetInfoPop.target = "AdminYesilConsAmtDetailInfo";
		yesilBudgetInfoPop.method = "post";
		yesilBudgetInfoPop.action = url;
		yesilBudgetInfoPop.submit();
	}
	
	/*	[팝업] 예산별 상세 정보 팝업 호출  / [미전송 결의액]
	-------------------------------------- */
	function fnOpenAdminYesilResAmtDetailInfo(param){
		var url = "<c:url value='/expend/np/admin/AdminYesilResAmtDetailInfo.do'/>";
		window.open('', "AdminYesilConsAmtDetailInfo", "width=" + 1000 + ", height=" + 720 + ", left=" + 150 + ", top=" + 150);
		
		/* 팝업 파라미터 설정 */
		$('#ERP_BUDGET_SEQ').val(param.erpBudgetSeq);
		$('#ERP_BUDGET_NAME').val(param.erpBudgetName);
		$('#ERP_MGT_SEQ').val(( $( "#txtErpProjectSeq" ).val() || '' ));
		$('#ERP_BOTTOM_SEQ').val(( $( "#txtErpBottomSeq" ).val() || '' ));
		$('#ERP_GISU').val(optionSet.erpGisu.gisu);
		$('#FROM_DATE').val($('#txtGisuFromDate').val());
		$('#TO_DATE').val($('#txtGisuToDate').val());
		$('#ERP_DIV_CD').val( Pudd( "#selDivList" ).getPuddObject().val());
		$('#ERP_DIV_NAME').val(Pudd( "#selDivList" ).getPuddObject().text());
		
		yesilBudgetInfoPop.target = "AdminYesilConsAmtDetailInfo";
		yesilBudgetInfoPop.method = "post";
		yesilBudgetInfoPop.action = url;
		yesilBudgetInfoPop.submit();
	}
	
	/*	[팝업] 예산과목 리스트 팝업 호출
	-------------------------------------- */
    function fnCommonCodePop(code, obj, callback, data) {
        /* [ parameter ] */
        obj = (obj || {});
        callback = (callback || '');
        data = (data || {});
        obj.widthSize = 780;
        obj.heightSize = 582;
        fnCallCommonCodePop({
            code: code,
            popupType: '2',
            param: JSON.stringify(obj),
            callbackFunction: callback,
            dummy: JSON.stringify(data)
        });
    }
	
	
    /*	[콜백] 프로젝트 리스트 팝업 호출 - 콜백
	-------------------------------------- */
	function fnCallbackProjectList(param){
		console.log('#### 프로젝트 조회 팝업 콜백 실행. ####');
		console.log(param);
		if((param[0]||'') == ''){
			param = [escape(JSON.stringify(param))];
		}
		 
		
		var resultList = [];
		var seqs = '';
		for(var i = 0; i < param.length; i++){
			var item = JSON.parse( unescape( param[i] ) );
			resultList.push(item);
			
			if(optionSet.erp[4]['01'].FG_TY == '1'){
				seqs += '|' + item.deptSeq;	
			} else {
				seqs += '|' + item.erpMgtSeq;
			}
		}
		seqs += '|';
		
		var advTxt = '';
		if(resultList.length > 1){
			advTxt = ' 외 ' + (resultList.length - 1) + '건';  
		}
		
		if(resultList.length > 0){
			if(optionSet.erp[4]['01'].FG_TY == '1'){
				$('#txtErpProjectName').val(resultList[0].deptName + advTxt);
				$('#txtErpProjectSeq').val(seqs);
			}else{
				$('#txtErpProjectName').val(resultList[0].erpMgtName + advTxt);
				$('#txtErpProjectSeq').val(seqs);
			}
		}else{
			$('#txtErpProjectName').val('');
			$('#txtErpProjectSeq').val('');
		}
	}
	
	/*	[콜백] 예산과목 리스트 팝업 호출 - 콜백
	-------------------------------------- */
	function fnCallbackBudgetList(param){
		console.log('#### 예산 과목 조회 팝업 콜백 실행. ####');
		console.log(param);
		$('#txtErpBudgetName').val(param.BGT_NM);
		$('#txtErpBudgetSeq').val(param.BGT_CD);
		
		if(!$('#txtErpBudgetSeq2').val()){
			$('#txtErpBudgetName2').val(param.BGT_NM);
			$('#txtErpBudgetSeq2').val(param.BGT_CD);
		}
	}
	
	
	/*	[콜백] 예산과목 리스트 팝업2 호출 - 콜백2
	-------------------------------------- */
	function fnCallbackBudgetList2(param){
		console.log('#### 예산 과목 조회 팝업2 콜백 실행. ####');
		console.log(param);
		$('#txtErpBudgetName2').val(param.BGT_NM);
		$('#txtErpBudgetSeq2').val(param.BGT_CD);
		
		if(!$('#txtErpBudgetSeq').val()){
			$('#txtErpBudgetName').val(param.BGT_NM);
			$('#txtErpBudgetSeq').val(param.BGT_CD);
		}
	}
	
</script>

<form id="yesilBudgetInfoPop" name="frmPop" method="post">
	<input type="hidden" name="erpBudgetSeq" value="" id="ERP_BUDGET_SEQ"/>
	<input type="hidden" name="erpBudgetName" value="" id="ERP_BUDGET_NAME"/>
	<input type="hidden" name="erpMgtSeq" value="" id="ERP_MGT_SEQ"/>
	<input type="hidden" name="erpBottomSeq" value="" id="ERP_BOTTOM_SEQ"/>
	<input type="hidden" name="erpGisu" value="" id="ERP_GISU"/>
	<input type="hidden" name="fromDate" value="" id="FROM_DATE"/>
	<input type="hidden" name="toDate" value="" id="TO_DATE"/>
	<input type="hidden" name="erpResGbn" value="" id="OPTION_TYPE"/>
	
	<input type="hidden" name="erpCompSeq" value="" id="ERP_CO_CD"/>
	<input type="hidden" name="erpDivSeq" value="" id="ERP_DIV_CD"/>
	<input type="hidden" name="erpDivName" value="" id="ERP_DIV_NAME"/>
	<input type="hidden" name="erpEmpSeq" value="" id="ERP_EMP_CD"/>
</form>	








