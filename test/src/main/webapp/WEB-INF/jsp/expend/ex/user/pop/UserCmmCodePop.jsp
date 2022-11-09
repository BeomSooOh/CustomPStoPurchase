<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<c:set var="Acct" value="Acct"/>
<c:set var="Auth" value="Auth"/>
<c:set var="BgAcct" value="BgAcct"/>
<c:set var="Bizplan" value="Bizplan"/>
<c:set var="Budget" value="Budget"/>
<c:set var="BudDept" value="BudDept"/>
<c:set var="Card" value="Card"/>
<c:set var="Cc" value="Cc"/>
<c:set var="Emp" value="Emp"/>
<c:set var="Dept" value="Dept"/>
<c:set var="ErpAuth" value="ErpAuth"/>
<c:set var="NoTax" value="NoTax"/>
<c:set var="Partner" value="Partner"/>
<c:set var="Pc" value="Pc"/>
<c:set var="Project" value="Project"/>
<c:set var="Summary" value="Summary"/>
<c:set var="Va" value="Va"/>
<c:set var="Vat" value="Vat"/>
<c:set var="RegNoPartner" value="RegNoPartner"/>
<c:set var="ExchangeUnit" value="ExchangeUnit"/>
<!-- <c:set var="VatType" value="VatType"/> -->


<div class="pop_wrap_dir" id="layerCommonCode">
	<div class="pop_con div_form">
	    <c:choose>
	    	<c:when test="${codeType eq Project}"> 
	    		<!-- 프로젝트 도움창 검색박스 -->
	    		<jsp:include page="../include/ExProjectSearchBox.jsp" flush="false" />
	    	</c:when>
	    	<c:otherwise>
	    		<!-- 검색영역 -->
				<div class="top_box">
					<dl>
						<dt>${CL.ex_keyWord}</dt>
						<dd>
							<div class="posi_re">
								<input id="cmmTxtSearchStr" type="text" style="width: 200px;ime-mode:active" value=""/>
								<a id="btn_removeFilter" href="#n" style="display:none;position:absolute;right:4px; top:2px;" onClick="javascript:fnClearFilter();">
									<img src="<c:url value="/Images/ico/ico_sear_clo.png"/>"  width="20" height="20"/>
								</a>
							</div>
						</dd>
						<dd class="mr15">
							<input type="button" id="btnSearch" value="${CL.ex_search}" />
						</dd>
					</dl>	
				</div>
	    	</c:otherwise>
	    </c:choose>
		
		<div class="right_div fr mt10 mb10">
			<span class="mr5">※ ${CL.ex_numberItem}<!-- 항목개수 --></span> <input id="selShowCount" style="width: 60px;" class="kendoComboBox" />
		</div>
		
		
		<!--  계정과목  -->
		<c:if test="${codeType == Acct}">
			<jsp:include page="../include/ExAcctBody.jsp" flush="false" />
		</c:if>
		
		<!--  증빙  -->
		<c:if test="${codeType == Auth}">
			<jsp:include page="../include/ExAuthBody.jsp" flush="false" />
		</c:if>
		
		<!--  예산계정  -->
		<c:if test="${codeType == BgAcct}">
			<jsp:include page="../include/ExBgAcctBody.jsp" flush="false" />
		</c:if>
		
		<!--  사업계획  -->
		<c:if test="${codeType == Bizplan}">
			<jsp:include page="../include/ExBizplanBody.jsp" flush="false" />
		</c:if>
		
		<!--  예산단위  -->
		<c:if test="${codeType == Budget}">
			<jsp:include page="../include/ExBudgetBody.jsp" flush="false" />
		</c:if>
		
		<!--  부서예산단위  -->
		<c:if test="${codeType == BudDept}">
			<jsp:include page="../include/ExBudDeptgetBody.jsp" flush="false" />
		</c:if>
						
		<!--  카드  -->
		<c:if test="${codeType == Card}">
			<jsp:include page="../include/ExCardBody.jsp" flush="false" />
		</c:if>
		
		<!--  코스트 센터  -->
		<c:if test="${codeType == Cc}">
			<jsp:include page="../include/ExCcBody.jsp" flush="false" />
		</c:if>
		
		<!--  사원  -->
		<c:if test="${codeType == Emp}">
			<jsp:include page="../include/ExEmpBody.jsp" flush="false" />
		</c:if>
		
		<!--  부  -->
		<c:if test="${codeType == Dept}">
			<jsp:include page="../include/ExDeptBody.jsp" flush="false" />
		</c:if>
		
		<!--  Erp 증빙  -->
		<c:if test="${codeType == ErpAuth}">
			<jsp:include page="../include/ExErpAuthBody.jsp" flush="false" />
		</c:if>
		
		<!--  불공제  -->
		<c:if test="${codeType == NoTax}">
			<jsp:include page="../include/ExNotaxBody.jsp" flush="false" />
		</c:if>
				
		<!--  거래처  -->
		<c:if test="${codeType == Partner}">
			<jsp:include page="../include/ExPartner.jsp" flush="false" />
		</c:if>
		
		<!--  회계단위  -->
		<c:if test="${codeType == Pc}">
			<jsp:include page="../include/ExPcBody.jsp" flush="false" />
		</c:if>
		
		<!--  프로젝트  -->
		<c:if test="${codeType == Project}">
			<jsp:include page="../include/ExProjectBody.jsp" flush="false" />
		</c:if>
		
		<!--  표준적요  -->
		<c:if test="${codeType == Summary}">
			<jsp:include page="../include/ExSummaryBody.jsp" flush="false" />
		</c:if>
		
		<!--  부가세  -->
		<c:if test="${codeType == Va}">
			<jsp:include page="../include/ExVaBody.jsp" flush="false" />
		</c:if>
		
		<!--  부가세 유형  -->
		<c:if test="${codeType == VatType}">
			<jsp:include page="../include/ExVatTypeBody.jsp" flush="false" />
		</c:if>
		
		<!--  사업자 등록번호가 존재하는 거래처  -->
		<c:if test="${codeType == RegNoPartner}">
			<jsp:include page="../include/ExRegNoPartnerBody.jsp" flush="false" />
		</c:if>
		
		<!--  환종  -->
		<c:if test="${codeType == ExchangeUnit}">
			<jsp:include page="../include/ExExchangeUnitBody.jsp" flush="false" />
		</c:if>
		
		
		<!-- 테이블 -->
		<div id="divEmpList" class="com_ta2 bg_lightgray mt14">
			<table id="tblEmpList">
			</table>
		</div>
	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="cmmBtnAccept" value="${CL.ex_check}" /> 
			<input type="button" id="cnnBtnClose" class="gray_btn" value="${CL.ex_cancel}" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!--// pop_wrap -->

<input type="hidden" value="" id="hid_cmmDataTrunk"/>

<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.list.js"></c:url>'></script>

<script>
	var isDisplayFullNumber = false;
	var summryDisplayOption = 'N';
	/*	[문서준비]	공통코드 조회 공통영역
	--------------------------------------------*/
	$(document).ready(function (){
		fnSetCombobox();
		$("#cmmTxtSearchStr").focus();
		/* 1. 기본정보 설정 */
		var defaultInfo = {
			codeType : '${codeType}'
			, callback : '${callback}'
// 			, searchStr : fnConvertSpecialCharater('${searchStr}')
			, erp_emp_seq : '${erp_emp_seq}'
			, erp_dept_seq : '${erp_dept_seq}'
			, budget_code : '${budget_code}'
			, bizplan_code : '${bizplan_code}'
			, acct_type : '${acct_type}'
			, acct_code : '${acct_code}'
			, vat_type : '${vat_type}'
			, reflectResultPop : '${reflectResultPop}'
			, expendCardOption: '${expendCardOption}'
			, summryDisplayOption : '${summryDisplayOption}'
			, searchType : '${searchType}'
			, formSeq : '${formSeq}'
			, ifSystem : '${ifSystem}'
		};
		defaultInfo.searchStr = fnConvertSpecialCharater('${searchStr}');
		
		/* 2. 공통영역 버튼이벤트 설정 */
		isDisplayFullNumber = defaultInfo.expendCardOption;
		summryDisplayOption = defaultInfo.summryDisplayOption;
		fnSetCommonAreaBtnEvent(defaultInfo)
		
		
		$("#cmmTxtSearchStr").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		
		var searchStr = '${searchStr}';
		$("#cmmTxtSearchStr").val(fnConvertSpecialCharater('${searchStr}'));
		if(searchStr.length > 0){
			$('#btn_removeFilter').show();
		}
		
		/* 3. 페이지 준비완료, 최초 조회 시작 */
		cmmFnc_GetMaingridData(defaultInfo);
		
		/* 4. ESC 키 입력 이벤트 바인드 */
		fnSetKeyEventBind();
	});
	
	function fnSetCombobox(){
		setComboBox($('#selShowCount'), '${viewLangth}', function() {
            $('select[name=tbl_codePopTbl_length]').val($('#selShowCount').val());
            $('select[name=tbl_codePopTbl_length]').trigger('change');
            return;
        }); /* 항목개수 설정 */
	}

	/* [ 입력 ] 키 이벤트 바인드
	-----------------------------------------------*/
	function fnSetKeyEventBind(){
		$('#cmmTxtSearchStr').keyup(function(){
			if($(this).val().toString().length){
				$('#btn_removeFilter').show();
			}else{
				$('#btn_removeFilter').hide();
			}
		});
		
    	$(document).keydown(function(event){
    		if(event.which == 27) {
    			$('#cnnBtnClose').click();
    		}
    	});
	}
	
	/* [ 사이즈 변경 ] 페이지 리폼
	-----------------------------------------------*/
	function fnResizeForm() {
		var strWidth = $('.pop_wrap_dir').outerWidth() + (window.outerWidth - window.innerWidth);
		var strHeight = $('.pop_wrap_dir').outerHeight() + (window.outerHeight - window.innerHeight);
		
		$('.pop_wrap_dir').css("overflow","auto");
		
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		
		if(isFirefox){
			
		}if(isIE){

		}if(isEdge){
			strWidth = 380;
			strHeight = 447;
		}if(isChrome){
		}
		
		try{
			var childWindow = window.parent;
			childWindow.resizeTo(strWidth, strHeight);	
		}catch(exception){
			console.log('window resizing cat not run dev mode.');
		}
		
	}
	
	
	/*	[정보조회]	공통사용 메인 리스트 정보 조회
	--------------------------------------------*/
	function cmmFnc_GetMaingridData(defaultInfo){
		
		var param = {};
		param.advFilter = delegatorGetAdvFilter();
		param.searchStr = ($('#cmmTxtSearchStr').val() || ''); 
		param.codeType = (defaultInfo.codeType || '');
		param.erpEmpSeq = (defaultInfo.erp_emp_seq || '');
		param.erpDeptSeq = (defaultInfo.erp_dept_seq || '');
		param.budgetCode = (defaultInfo.budget_code || '');
		param.bizplanCode = (defaultInfo.bizplan_code || '');
		param.acctType = (defaultInfo.acct_type || '');
		param.acctCode = (defaultInfo.acct_code || '');
		param.vatType = (defaultInfo.vat_type || '');
		param.expendCardOption = defaultInfo.expendCardOption;
		param.searchType = defaultInfo.searchType ;
		param.summryDisplayOption = defaultInfo.summryDisplayOption
		param.formSeq = defaultInfo.formSeq;
		
		//프로젝트 도움창 전용 파라미터
		if(defaultInfo.codeType == "Project" && defaultInfo.ifSystem == "iCUBE"){
			param.selProjectStatus = $("#selProjectStatus").val() || '';
		}
		
		if(!param.codeType){
			alert('오류가 발생했습니다.');
			console.log(param);
		}
		// 정보 조회 후 메인 그리드 출력
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/expend/ex/user/code/ExCodeInfoSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : param,
	        success : function( data ) {	  
	        	delegatorSetMainList(defaultInfo, data);    
	        	// 페이지 리사이징
	    		fnResizeForm();
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}
	
	/*	[뷰]	그리드 데이터 셋팅
	--------------------------------------------*/
	function cmmFnc_SetGridView(defaultInfo, elemID, data, aoColumn, columDefs){
		columDefs = (columDefs || {});
		var isOrderBy = true;
		if( defaultInfo.codeType == 'Summary' || defaultInfo.codeType == 'Auth' ){
			isOrderBy = false;
		}
		
		var id = '' + elemID;
		id = id[0] == '#' ? id : '#' + id;
		if(data && data.length == 1 && defaultInfo.reflectResultPop === 'true' && $('#cmmTxtSearchStr').val() != ''){
			$('#hid_cmmDataTrunk').val(JSON.stringify(data[0]));
			$('#cmmBtnAccept').click();
		}
        var oTable = $(id).dataTable({
            /* "fixedHeader" : true, */
            "select" : true,
            "pageLength" : 7,
            "lengthMenu" : [ [ 7, 25, 50, 100 ], [ 7, 25, 50, 100 ] ],
            "sScrollY" : "263px",
            "bAutoWidth" : false,
            "bSort" : isOrderBy,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : '데이터가 없습니다.',
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : '데이터가 없습니다.',
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                	$('#hid_cmmDataTrunk').val(JSON.stringify(aData))
                }));
                $(nRow).on('dblclick', (function() {
                    $('#hid_cmmDataTrunk').val(JSON.stringify(aData));
                    $('#cmmBtnAccept').click();
                }));
            },
            "aoColumns" : aoColumn,
            "columnDefs" : columDefs
        });
        
        $('select[name=tbl_codePopTbl_length]').val($('#selShowCount').val());
		$('select[name=tbl_codePopTbl_length]').trigger('change');
	}
	
	
	/*	[뷰]	공통사용 버튼 이벤트 설정
	--------------------------------------------*/
	function fnSetCommonAreaBtnEvent(defaultInfo){
		/* 검색버튼 이벤트 설정 */
		$('#btnSearch').click(function (){
			cmmFnc_GetMaingridData(defaultInfo);
		});
		
		/* 확인버튼 이벤트 설정 */
		$('#cmmBtnAccept').click(function (){
			// 상세영역으로부터 리턴밸류 조회
			if($('#hid_cmmDataTrunk').val() === ''){
				alert('선택된 정보가 없습니다.');
				return false;
			}
			var param = delegatorGetReturnObj();
			param.type = defaultInfo.codeType.toLowerCase();
			
			// 콜백 함수 호출
			window.opener[defaultInfo.callback](param);
			
			// 팝업창 닫기
			window.close();
		});
		
		/* 취소버튼 이벤트 설정 */
		$('#cnnBtnClose').click(function (){
			window.close();
		});
	}

	/*	[필터]	필터 초기화및 재 조회
	--------------------------------------------*/
	function fnClearFilter(){
		$('#cmmTxtSearchStr').val('');
		$('#btnSearch').click();
		$('#btn_removeFilter').hide();
		$('#cmmTxtSearchStr').focus();
	}
	
	/* 델리게이터 선언 */
	delegatorSetMainList = function (){
		alert('메인리스트 조회 델리게이터가 설정되지 않았습니다.');
	}
	delegatorGetReturnObj = function (){
		alert('저장 포멧 조회 델리게이터가 설정되지 않았습니다.');
	}
	delegatorGetAdvFilter = function (){
		return {};
	}

</script>