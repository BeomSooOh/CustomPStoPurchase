
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<link rel="stylesheet" type="text/css" href="../../../css/pudd.css">
<link rel="stylesheet" type="text/css" href="../../../css/common.css">
<link rel="stylesheet" type="text/css" href="../../../css/re_pudd.css">

<jsp:include page="../include/TripOptionMap.jsp" flush="false" />
<jsp:include page="../include/TripCommonFunc.jsp" flush="false" />

<script src="${pageContext.request.contextPath}/js/jquery.mask.min2.js"></script>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.187.min.js'></script>

<body>
	<div class="pop_sign_wrap" style="min-width:998px">
	<div class="pop_sign_head" style="">
		<h1 id="h1_consDocTitle">출장품의 작성</h1>
		<div class="psh_btnbox">
		<!-- 양식팝업 오른쪽 버튼그룹 -->
		<div class="psh_right">
			<div class="btn_cen mt8">
				<input type="button" class="psh_btn" value="결재작성"  id="btn_approval" />
			</div>
		</div>
	</div>
</div>	
	
<div class="pop_sign_con">
	<div class="pop_con posi_re mt0">
	
		<!-- 출장정보 ------------------------------------------------------------------------------------------------------------------------->
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt4 mb0" id="">출장정보</p>	
			</div>
		</div>
		
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="110"/>
					<col width="21%"/>
					<col width="110"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>출장 기간</th>
					<td colspan="3">
					<input type="text" autocomplete="off" class="puddSetup" pudd-type="datepicker" id="txt_tripFromDate" value="2019-01-01"/>
					<select class="puddSetup" pudd-style="width:80px;" id="txt_tripFromTime">
						<option value="0030">00:30</option>
						<option value="0100">01:00</option>
						<option value="0130">01:30</option>
						<option value="0200">02:00</option>
						<option value="0230">02:30</option>
						<option value="0300">03:00</option>
						<option value="0330">03:30</option>
						<option value="0400">04:00</option>
						<option value="0430">04:30</option>
						<option value="0500">05:00</option>
						<option value="0530">05:30</option>
						<option value="0600">06:00</option>
						<option value="0630">06:30</option>
						<option value="0700">07:00</option>
						<option value="0730">07:30</option>
						<option value="0800">08:00</option>
						<option value="0830">08:30</option>
						<option value="0900" selected="selected">09:00</option>
						<option value="0930">09:30</option>
						<option value="1000">10:00</option>
						<option value="1030">10:30</option>
						<option value="1100">11:00</option>
						<option value="1130">11:30</option>
						<option value="1200">12:00</option>
						<option value="1230">12:30</option>
						<option value="1300">13:00</option>
						<option value="1330">13:30</option>
						<option value="1400">14:00</option>
						<option value="1430">14:30</option>
						<option value="1500">15:00</option>
						<option value="1530">15:30</option>
						<option value="1600">16:00</option>
						<option value="1630">16:30</option>
						<option value="1700">17:00</option>
						<option value="1730">17:30</option>
						<option value="1800">18:00</option>
						<option value="1830">18:30</option>
						<option value="1900">19:00</option>
						<option value="1930">19:30</option>
						<option value="2000">20:00</option>
						<option value="2030">20:30</option>
						<option value="2100">21:00</option>
						<option value="2130">21:30</option>
						<option value="2200">22:00</option>
						<option value="2230">22:30</option>
						<option value="2300">23:00</option>
						<option value="2330">23:30</option>
						<option value="2400">24:00</option>
					</select>
					~
					<input type="text" autocomplete="off" class="puddSetup" pudd-type="datepicker" value=""  id="txt_tripToDate" />
					<select class="puddSetup"  pudd-style="width:80px;"  id="txt_tripToTime">
						<option value="0030">00:30</option>
						<option value="0100">01:00</option>
						<option value="0130">01:30</option>
						<option value="0200">02:00</option>
						<option value="0230">02:30</option>
						<option value="0300">03:00</option>
						<option value="0330">03:30</option>
						<option value="0400">04:00</option>
						<option value="0430">04:30</option>
						<option value="0500">05:00</option>
						<option value="0530">05:30</option>
						<option value="0600">06:00</option>
						<option value="0630">06:30</option>
						<option value="0700">07:00</option>
						<option value="0730">07:30</option>
						<option value="0800">08:00</option>
						<option value="0830">08:30</option>
						<option value="0900">09:00</option>
						<option value="0930">09:30</option>
						<option value="1000">10:00</option>
						<option value="1030">10:30</option>
						<option value="1100">11:00</option>
						<option value="1130">11:30</option>
						<option value="1200">12:00</option>
						<option value="1230">12:30</option>
						<option value="1300">13:00</option>
						<option value="1330">13:30</option>
						<option value="1400">14:00</option>
						<option value="1430">14:30</option>
						<option value="1500">15:00</option>
						<option value="1530">15:30</option>
						<option value="1600">16:00</option>
						<option value="1630">16:30</option>
						<option value="1700">17:00</option>
						<option value="1730">17:30</option>
						<option value="1800" selected="selected">18:00</option>
						<option value="1830">18:30</option>
						<option value="1900">19:00</option>
						<option value="1930">19:30</option>
						<option value="2000">20:00</option>
						<option value="2030">20:30</option>
						<option value="2100">21:00</option>
						<option value="2130">21:30</option>
						<option value="2200">22:00</option>
						<option value="2230">22:30</option>
						<option value="2300">23:00</option>
						<option value="2330">23:30</option>
						<option value="2400">24:00</option>
					</select>
						&nbsp;&nbsp;
						<span id="txt_timeGap">2일 (48시간)</span>
						<span id="txt_alertOverTime" style="color: red;"></span>
					</td>
				</tr>
				
				<tr>
					<th>구분</th>
					<td>
						<input type="radio" name="selDomesticRadi" value="0" id="inputDomesticCode0" class="puddSetup selDomesticDiv" pudd-label="국내" />
						<input type="radio" name="selDomesticRadi" value="1" id="inputDomesticCode1" class="puddSetup selDomesticDiv" pudd-label="해외" />
					</td>
					<th>장소</th>
					<td>
						<div id="sel_location" class="dp_ib"></div>
						<input type="text" autocomplete="off" id="txt_locationNote" class="puddSetup"pudd-style="width:208px;" />
					</td>
				</tr>
				
				<tr>
					<th>일정</th>
					<td>
						<div id="sel_calendar" class="dp_ib">
						</div>
					</td>
					<th>목적</th>
					<td>
						<input type="text" autocomplete="off" class="puddSetup"pudd-style="width:412px;"  id="txt_purpose"/>
					</td>
				</tr>
				<tr>
					<th>여비지급</th>
					<td>
						<input type="radio" name="selPayRequestRadi" value="0" id=inputExpenseCode0 class="puddSetup selPayRequestDiv" pudd-label="대상" />
						<input type="radio" name="selPayRequestRadi" value="1" id="inputExpenseCode1" class="puddSetup selPayRequestDiv" pudd-label="비대상" />
					</td>
					<th>운임수단</th>
					<td>
						<div id="sel_transport" class="dp_ib"></div>
					</td>
					
				</tr>
				<tr>
					<th>출장자</th>
					<td class="posi_re" colspan="3">
						<div id="exSelectiveInput" style="width:676px;"></div>
						<div class="controll_btn p0">
							<input type="button" id="btn_userSelect" class="puddSetup" value="선택" pudd-style="">
							<button id="btn_attendReload" class="reload_btn k-button" data-role="button" role="button" aria-disabled="false" tabindex="0"></button>
						</div>
					</td>
				</tr>
				<div id="modal_display" class="modal_ab" style="top: 38px;left: 0;right: 0;height: 75px;z-index: 99;display:none;opacity: 0.1;"></div>
			</table>
		</div>

		<!-- 결의정보 ------------------------------------------------------------------------------------------------------------------------->
		<div class="btn_div consSummary">
			<div class="left_div">
				<p class="tit_p mt4 mb0">품의정보</p>	
			</div>
			<div class="right_div">
				<input type="button" class="puddSetup" value="등록" id="btn_consDocOpen"/>
			</div>
		</div>
		<div id="grid_consSummaryTable" style="display:none;;" class="consSummary">
		</div>
		<div class="com_ta4 rowHeight hover_no consSummary">
			<table>
				<colgroup>
					<col width="13.6%"/>
					<col width="18%"/>
					<col width="13.6%"/>
					<col width="18%"/>
					<col width="13.6%"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="fwb ri">프로젝트</th>
					<td class="fwb ri"> <span id="txt_mgtCnt"> 0 </span> 건 </td>
					<th class="fwb ri">예산과목</th>
					<td class="fwb ri"> <span id="txt_bgtCnt"> 0 </span> 건 </td>
					<th class="fwb ri">합계금액</th>
					<td class="fwb ri div_totalAmt" ><p class="fr"><span class="mr5 mt3 fl"> <span id="txt_totalAmt"> 0 </span> 원</span><input type="button" class="puddSetup pbud pudd_btn_down" ></p></td>
				</tr>
			</table>		
		</div>

		<!-- 경비내역 ------------------------------------------------------------------------------------------------------------------------->
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt4 mb0">경비내역</p>	
			</div>
<!-- 			<div class="right_div"> -->
<!-- 				<input type="button" class="puddSetup" value="초기화" /> -->
<!-- 			</div> -->
		</div>
		<div id="grid_expenseDetailTable"></div>
	
		<div class="com_ta4 rowHeight">
			<table>
				<colgroup>
					<col width="21.8%">
					<col width="10.9%">
					<col width="10.9%">
					<col width="10.9%">
					<col width="10.9%">
					<col width="10.9%">
					<col width="10.9%">
					<col width="">
					<col width="17">
				</colgroup>
				<tr class="total fwb">
					<td>합 계</td>
					<td class="ri" id="txtAmtClass1">0</td>
					<td class="ri" id="txtAmtClass2">0</td>
					<td class="ri" id="txtAmtClass3">0</td>
					<td class="ri" id="txtAmtClass4">0</td>
					<td class="ri" id="txtAmtClass5">0</td>
					<td class="ri" id="txtAmtClass6">0</td>
					<td class="ri  div_tripAmt" id="txtAmtClass7">0</td>
					<td></td>
				</tr>
			</table>
		</div>



		</div><!-- //pop_con -->
	</div>
</div><!-- //pop_wrap -->
</body>
</html>


<script type="text/javascript">
	var isReWrite = 0;
	var isClear = 0;
	
	/*	[READY] document ready
	-------------------------------------------------- */
	$(document).ready(function() {
		
		if(!optionSet.erpEmpInfo){
			alert('사용자의 ERP사번매핑을 확인 해주세요.');
		}
		
		/* 푸딩 UI 초기화 */
		fnSetElemInit();
		
		/* 엘리먼트 이벤트 바인드 */
		fnSetEventInit();
		
		/* 설정 데이터 조회 */
		fnCallOptionData();
		
		/* 출장 품의 문서 생성 */
		fnCreateTripConsDoc();
		
		/* 작성창 사이즈 보정 */
		fnSetResize();
		
		/* 로딩 후처리 보정 */
		$('#grid_consSummaryTable').hide();
	});		
		
	/*	[resize] 작성창 사이즈 조정
	-------------------------------------------------- */
	function fnSetResize(){
		/* ## init - 품의서 팝업 크기 자동 조정 ## */
		var optionHeight = 685;
		var optionWidth = 1150;
		
		$('.pop_wrap').css("overflow", "auto");
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		var divHeight = optionHeight;

		if (isFirefox) {
			divHeight -= 79;
		}
		if (isIE || isEdge) {
			divHeight -= 70;
		}
		if (isChrome) {
			divHeight -= 67;
		}

		try {
			$('.pop_wrap').height(divHeight);
			window.resizeTo(optionWidth, optionHeight);
		} catch (exception) {
			log('   [ERROR] fail to page resize.');
		}

		try {
			var moveLeft = (screen.width - optionWidth) / 2;
			var moveTop = (screen.height - optionHeight) / 2;
			window.moveTo(moveLeft, moveTop);
		} catch (exception) {
		}

		$(window).resize(function(e, d) {
			$('.pop_wrap').height(window.innerHeight - 2);
		});

		/* 리사이징 최초 1회 자동 수행 */
		$('.pop_wrap').height(window.innerHeight - 2);
	}
	
	/*	[option] 품의결의 설정 데이터 조회
	-------------------------------------------------- */
	function fnCallOptionData(){
		
		/* [API] 일정 API호출 */
		fnCallAPI_CalendarList();
		
		/* 장소 데이터 호출 */
		fnCallLocationInfo();
		
		/* 교통 데이터 호출 */
		fnCallTransportInfo()
	}
	
	/*	[ajax] 교통수단 설정 정보 조회
	-------------------------------------------------- */
	function fnCallTransportInfo(){
		$.ajax({
			type : 'post'
			, url : "<c:url value='/trip/user/cons/selectOptionTransport.do' />"
			, datatype : 'json'
			, async : false
			, data : cmFnc_getUserInfo()
			, success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					optionSet.transport = result.result.aaData;

					var dataSourceComboBox = new Pudd.Data.DataSource({
						data : optionSet.transport
					});
					
					Pudd( "#sel_transport" ).puddComboBox({
						attributes : { style : "width:412px;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "exAreaSelectBox" }// control 자체 객체 속성 설정
					,	dataSource : dataSourceComboBox
					,	multiType : true
					,	dataValueField : "transportSeq"
					,	dataTextField : "transportName"
					,	disabled : false
					,	scrollListHide : true
					,	eventCallback : {
							"change" : function( e ) {
								console.log( "change" + e );
							}
						}
					});
					
				}else{
					alert('교통 정보 조회 실패');
					console.log(result);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}
	
	
	/*	[ajax] 장소 설정 정보 조회
	-------------------------------------------------- */
	function fnCallLocationInfo(){
		$.ajax({
			type : 'post'
			, url : "<c:url value='/trip/user/cons/selectOptionLocation.do' />"
			, datatype : 'json'
			, async : false
			, data : cmFnc_getUserInfo()
			, success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					optionSet.location = result.result.aaData;
					console.log('[ LOCATION API ]  SELECT TRIP AREA INFO >>>> ');
					try{
						console.table(result.result.aaData);
					}catch(e){
						console.log(result.result.aaData);
					}
					/* 장소 셀렉트 박스 갱신 */
					fnSetLocationSelect();
				}else{
					alert('장소 정보 조회 실패');
					console.log(result);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}
	
	
	/*	[장소] 국내/해외 구분 셀렉트 박스 갱신 
	-------------------------------------------------- */
	var _domesticGbnTemp;
	function fnSetLocationSelect(){
		var domesticGbn = $('input:radio[name=selDomesticRadi]:checked').val();
		if(_domesticGbnTemp == domesticGbn){
			return;
		}else{
			_domesticGbnTemp = domesticGbn;
		}
		
		var locationArr = [];
		for (var i = 0; i < optionSet.location.length; i++){
			var item = optionSet.location[i];
			if(item.domesticCode == domesticGbn ){
				locationArr.push(item);
			}
		}
		
		if(!locationArr.length){
			locationArr.push({'locationSeq' : '-1', 'locationName' : '옵션 미설정' });
		}
		
		var dataSourceComboBox = new Pudd.Data.DataSource({
			data : locationArr
		});
		
		$('#sel_location').empty();
		Pudd( "#sel_location" ).puddComboBox({
			attributes : { style : "width:200px;" }// control 부모 객체 속성 설정
		,	controlAttributes : { id : "exAreaSelectBox" }// control 자체 객체 속성 설정
		,	dataSource : dataSourceComboBox
		,	dataValueField : "locationSeq"
		,	dataTextField : "locationName"
		,	selectedIndex : -1
		,	disabled : false
		,	scrollListHide : false
		,	eventCallback : {
				"change" : function( e ) {
					var puddObj = Pudd( "#sel_location" ).getPuddObject();
					var rowData = puddObj.getOptionRowData( puddObj.node.selectedIndex );
					if(rowData.locationEditYN == 'Y'){
						$('#txt_locationNote').prop('disabled', false);
					}else{
						$("#txt_locationNote").val('');
						$("#txt_locationNote").prop('disabled', true);
					}
				}
			}
		});
	}
	
	/*	[API] 일정 API호출
	-------------------------------------------------- */
	function fnCallAPI_CalendarList(){
		var createGroupSeq = optionSet.loginVo.groupSeq;
		var createDeptSeq = optionSet.loginVo.orgnztId;
		var createCompSeq = optionSet.loginVo.compSeq;
		var createSeq = optionSet.loginVo.empSeq;
		$.ajax({
			type: 'POST'
			, url:'/schedule/MobileSchedule/SearchMyCalendarList'
            , data: JSON.stringify(
                      {
                            "header": { 
                                  "groupSeq": createGroupSeq, 
                                  "tId": "", 
                                  "pId": "" 
                             }, 
                            "body": { 
                                "langCode": "kr", 
                                "calType": "", 
                                "deptSeq": createDeptSeq, 
                                "compSeq": createCompSeq, 
                                "writeYn" : "Y", 
                                "groupSeq": createGroupSeq, 
                                "tId":"", 
								  "companyInfo": { 
									  "groupSeq": createGroupSeq, 
									  "compSeq": createCompSeq, 
									  "empSeq": createSeq, 
									  "bizSeq": "", 
									  "deptSeq": createDeptSeq, 
									  "emailAddr": "", 
									  "emailDomain": "" 
								  } 
                              }                                                                                                                                                              
                        } 
                    )
			, dataType:'json'
			, contentType:'application/json; charset=utf-8'
			, async : false
			, success : function(result) {
				if(result.resultMessage = 'SUCCESS'){
					console.log('[ CALENDAR API ] API CALL RESULT : ', 'background: #A22;');
					try{
						console.table(result.result.calList);
					}catch(e){
						console.log(result.result.calList);
					}
					fnSetCalandarData(result.result.calList);			
				}
			}, error : function(result) {
				fnSetCalandarData([]);
			}
		});
	}
	
	/*	[CALENDAR] 외부 일정 연동 출력
	-------------------------------------------------- */
	function fnSetCalandarData(aaData, selectedCalSeq){
		
		var dataSourceComboBox = new Pudd.Data.DataSource({
			data : aaData
		});
		
		$('#sel_calendar').empty();
		Pudd( "#sel_calendar" ).puddComboBox({
			attributes : { style : "width:170px;" }// control 부모 객체 속성 설정
		,	controlAttributes : { id : "exCalendarSelectBox" }// control 자체 객체 속성 설정
		,	dataSource : dataSourceComboBox
		,	dataValueField : "mcalSeq"
		,	dataTextField : "calTitle"
		,	selectedIndex : ( selectedCalSeq || 0 )
		,	disabled : false
		,	scrollListHide : false
		,	eventCallback : {
				"change" : function( e ) {
					var puddObj = Pudd( "#sel_location" ).getPuddObject();
					var rowData = puddObj.getOptionRowData( puddObj.node.selectedIndex );
				}
			}
		});
		
	}
	
	/*	[INIT] 엘리먼트 이벤트 바인드
	-------------------------------------------------- */
	function fnSetEventInit(){
		/* 기간 - 데이트 피커 이벤트 설정 */
		$('#txt_tripFromDate, #txt_tripToDate, #txt_tripToTime, #txt_tripFromTime').change(function(){
			 setTimeout(fnSetDisplayTimeGap,100);
		});
		
		/* 출장자 선택 버튼 이벤트 지정 */
		$('#btn_userSelect').unbind().click(function (){
			
			if(!Pudd('#sel_location').getPuddObject().val()){
				alert('장소정보를 입력해 주시기 바랍니다.');
				return false;
			}

			if(!$('#txt_locationNote').attr('disabled')){
				if(!$('#txt_locationNote').val()){
					alert('장소 상세정보를 입력해 주시기 바랍니다.');
					$('#txt_locationNote').focus();
					return false;
				}
			}
			
            var url = "<c:url value='/gw/systemx/orgChart.do'/>";
            var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");
            
            $('input[name=compFilter]').attr('value',optionSet.loginVo.compSeq);
            
            frmPop2.target = "cmmOrgPop";
            frmPop2.method = "post";
            frmPop2.action = url.replace("/exp", "");
            frmPop2.submit();
            frmPop2.target = "";
            pop.focus();
            return;
		});
		 
		/* 국내/해외 구분 라디오 이벤트 지정 */
		Pudd( 'input[type="radio"][name="selDomesticRadi"]' ).on( "click", function( e ) {
			fnSetLocationSelect();
			$("#txt_locationNote").val('');
			$("#txt_locationNote").prop('disabled', false);
		});
		
		/* 여비지급 여부 라디오 이벤트 지정 */
		Pudd( '.selPayRequestDiv' ).on( "click", function( e ) {
			fnSetConsSummaryDisplay();
		});
		
		
		/* 합계 금액 상세 클릭 이벤트 지원 */
		$(".pbud").click(function(){
			if ($(".pbud").hasClass("pudd_btn_down")) {
				$(".pbud").removeClass("pudd_btn_down");
				$(".pbud").addClass("pudd_btn_up");
				$("#grid_consSummaryTable").slideDown(300);
			} else {
				$(".pbud").removeClass("pudd_btn_up");
				$(".pbud").addClass("pudd_btn_down");
				$("#grid_consSummaryTable").slideUp(300);
			}
		});
		
		/* 품의정보 입력 진행 */
		$('#btn_consDocOpen').unbind().click(function(){
			/* 출장품의 정보 입력 */
			var url = "<c:url value='/expend/np/user/NpUserCRDocPop.do'/>";
			var pop = window.open('', "consDocPop", "width=" + 1100 + ", height=" + 900 + ", left=" + 150 + ", top=" + 150);
			$('#tripDocSeq').val(optionSet.tripConsDoc.tripConsDocSeq);
			consDocPop.target = "consDocPop";
			consDocPop.method = "post";
			consDocPop.action = url;
			consDocPop.submit();
			consDocPop.target = "";
			pop.focus();	
		});
		
		/* 결재 작성 진행 */
		$('#btn_approval').unbind().click(function(){
			fnDraftApproval();
		});
		
		/* 출장정보 재입력 기능 초기화 */
		$('#btn_attendReload').unbind().click(function(){
			if(confirm('출장자를 모두 삭제하시겠습니까?')){
				$('#selectedItems_forCmPop').val('');
				$('#exSelectiveInput').empty();
				var dataSourceAddr = new Pudd.Data.DataSource({
					data : []
				});
				Pudd( "#exSelectiveInput" ).puddSelectiveInput({
						// 수정모드인 경우 dataSource 전달, 신규는 해당없음
						dataSource : dataSourceAddr
					,	dataValueField : "empSeq"
					,	dataTextField : "txtEmpName"
					,	writeMode : false // 기본 입력 모드
					,	disabled : false
					,	editButton : false
					,	deleteButton : false
					,	textMarking : false
					,	emailValidate : false
					,	backspaceDelete : false
				});
				/* 경비내역 기본 테이블 생성. */
				fnSetExpenseDetails([]);
				$('#modal_display').hide();
				isClear = '1';
			}
		});
	}
		
	/*	[결재상신] 출장 품의 데이터 저장및 전자결재 상신 */
	function fnDraftApproval(){
		var param = cmFnc_CommonSaveData();
		console.log('draft approbal, save params : ');
		console.log(param);
		
		if(!fnDraftApprovalPreCheck()){
			return;
		}
		
		var url = '<c:url value='/trip/user/cons/insertTripCons.do' />';
		if(!'${param.approKey}'){
			url = '<c:url value='/trip/user/cons/insertTripCons.do' />';
		}else{
			url = '<c:url value='/trip/user/cons/updateTripCons.do' />';
		}
		
		var result2;
		$.ajax({
			type : 'post'
			, url : url
			, datatype : 'json'
			, async : false
			, data : param
			, success : function(result) {
				console.log('		[cons info] 지출 품의 2.0 작성 데이터 >');
				console.log(result);
				if(result.result.resultCode != 'SUCCESS'){
					alert('작성된 품의서 정보 저장 실패');
					return;
				}else{
					result2 = result;
					/* 전자결재 작성 */
					fnEventApproval();
				}
			}, error : function(result) {
				console.error(result);
			}
		});
		
		
	}
    /* SSL 적용관련 */
    if (!window.location.origin) {
        window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
    }
    var origin = document.location.origin;
	/* ## 결재작성 ## */
	/* ====================================================================================================================================================== */
	function fnEventApproval() {

		/* [ parameter ] */
		var parameter = {};

		parameter.processId = optionSet.formInfo.formDTp;
		var consDocSeq = $('input:radio[name=selPayRequestRadi]:checked').val() == '0' ? optionSet.tripConsDoc.consDocSeq : '0';
		parameter.approKey = optionSet.formInfo.formDTp + '_TRIP_' + optionSet.tripConsDoc.tripConsDocSeq + '_' + ( consDocSeq  || '0' );
		parameter.tripConsDocSeq = optionSet.tripConsDoc.tripConsDocSeq;
		parameter.consDocSeq = optionSet.tripConsDoc.consDocSeq;
		parameter.interlockName = "정보수정";
		// 20180910 soyoung, interlockName 정보수정 영문/일문/중문 추가
		parameter.interlockNameEn = "Edit information";
		parameter.interlockNameJp = "情報修正";
		parameter.interlockNameCn = "信息修改";
		parameter.docSeq = '';
		parameter.formSeq = optionSet.formInfo.formSeq;
		parameter.groupSeq = optionSet.loginVo.groupSeq;
		parameter.header = '';
		parameter.content = '';
		parameter.footer = '';
		parameter.reDraftUrl = location.protocol + '//' + location.host + "<c:url value='/ExpendReUsePop.do' />";
		
		parameter.oriApproKey = '${param.oriApproKey}';
		parameter.oriDocId = '${param.oriDocId}';
		parameter.form_gb = '${param.form_gb}';
		parameter.copyApprovalLine = '${param.copyApprovalLine}';
		parameter.copyAttachFile = '${param.copyAttachFile}';
		parameter.eapCallDomain = ( origin || '' );
		parameter.formType = "TRIPCONS";
		
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			/*   - url : /ex/np/user/cons/interlock/ExDocMake.do */
			url : '<c:url value='/ex/np/user/cons/interlock/ExDocMake.do' />',
			datatype : 'json',
			async : true,
			/*   - data : consNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : parameter,
			/*   - success :  */
			success : function(result) {
				if (result.result.resultCode === 'SUCCESS') {
					fnDocPopOpen(result);
				} else {
					alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
					return;
				}
			},
			/*   - error :  */
			error : function(result) {
				console.error(result);
			}
		});

		return;
	}
	
	function fnDocPopOpen(data) {
		var url = '/';
		url += data.result.eaType; 

		if (data.result.eaType == "eap") {
			url += '/ea/interface/eadocpop.do';
		} else if (data.result.eaType == "ea") {
			if('' != '${param.oriApproKey}'){
				url += '/ea/interface/eadocRedraftPop.do';
			} else {
				url += '/ea/interface/eadocpop.do';
				// url += '/edoc/eapproval/docCommonDrafWrite.do';
			}
		} else {
			alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
			return;
		}

		if (data.result.eaType == "eap") {
			if (data.result.docSeq != '0' && data.result.eaType != '' && data.result.formSeq != '0' && data.result.approKey != '') {
				url = url + '?form_id=' + optionSet.formInfo.formSeq;
				url = url + '&docId=' + data.result.docSeq;
				url = url + '&approKey=' + data.result.approKey;
				url = url + '&processId=' + optionSet.formInfo.formDTp;
			} else {
				alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
				return;
			}
		} else if (data.result.eaType == "ea") {
			if (data.result.docSeq != '-1' && data.result.eaType != '' && data.result.formSeq != '0' && data.result.approKey != '') {
 				if('' != '${param.oriApproKey}'){
					url += '?oriApproKey=${param.oriApproKey}';
					url += '&approKey=' + data.result.approKey;
					url += '&oriDocId=${param.oriDocId}';
					url += '&tiFormGb=${param.form_gb}';
					url += '&form_gb=${param.form_gb}';
					url += '&copyApprovalLine=${param.copyApprovalLine}';
					url += '&copyAttachFile=${param.copyAttachFile}';
				} else {
					// 비영리 결재 template_key 파라미터 사용하지 않음.
					// url += '?template_key=' + optionSet.formInfo.formSeq;
					url += '?form_id=' + optionSet.formInfo.formSeq;
					url += '&docId=' + data.result.docSeq;
					url += '&approKey=' + data.result.approKey;
					url += '&processId=' + optionSet.formInfo.formDTp;					
				}
			} else {
				alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
				return;
			}
		}

		var thisX = parseInt(document.body.scrollWidth);
		var thisY = parseInt(document.body.scrollHeight);
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 50;

		if (maxThisX > 1000) {
			maxThisX = 1000;
		}
		var marginY = 0;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if (navigator.userAgent.indexOf("MSIE 6") > 0)
			marginY = 45; // IE 6.x
		else if (navigator.userAgent.indexOf("MSIE 7") > 0)
			marginY = 75; // IE 7.x
		else if (navigator.userAgent.indexOf("Firefox") > 0)
			marginY = 50; // FF
		else if (navigator.userAgent.indexOf("Opera") > 0)
			marginY = 30; // Opera
		else if (navigator.userAgent.indexOf("Netscape") > 0)
			marginY = -2; // Netscape

		if (thisX > maxThisX) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}
		if (thisY > maxThisY - marginY) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}

		// 센터 정렬
		var windowX = (screen.width - (maxThisX + 10)) / 2;
		var windowY = (screen.height - (maxThisY)) / 2 - 20;
		/* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
		/* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
		/* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
		var win = window.open(url, '', "scrollbars=yes,resizable=yes,width=" + maxThisX + ",height=" + (maxThisY - 50) + ",top=" + windowY + ",left=" + windowX);
		if (win == null || win.screenLeft == 0) {
			alert("브라우져 팝업차단 설정을 확인해 주세요");
		} else {
			self.close();
		}
	}
	
	function fnDraftApprovalPreCheck(){
		var transperPuddObj = Pudd( "#exSelectiveInput" ).getPuddObject();
		var data = transperPuddObj.getInputList();
		
		if($('#txt_alertOverTime').html().length > 0){
			alert($('#txt_alertOverTime').html());
			return false;
		}
		
		if(!Pudd('#sel_location').getPuddObject().val()){
			alert('장소정보를 입력해 주시기 바랍니다.');
			return false;
		}

		if(!$('#txt_locationNote').attr('disabled')){
			if(!$('#txt_locationNote').val()){
				alert('장소 상세정보를 입력해 주시기 바랍니다.');
				$('#txt_locationNote').focus();
				return false;
			}
		}
		
		if(!$('#txt_purpose').val()){
			alert('출장 목적을 입력해 주시기 바랍니다.');
			$('#txt_purpose').focus();
			return false;
		}
		

		if(!fnGetTransportSelectedDataKey()){
			alert('운임수단을 입력해 주시기 바랍니다.');
			return false;
		}
		
		if(!data.length){
			alert('출장자를 입력해 주시기 바랍니다.');
			$('#btn_userSelect').click();
			return false;
		}
		if($('input:radio[name=selPayRequestRadi]:checked').val() == '0'){
			if(!parseInt($('#txt_mgtCnt').html())){
				alert('품의정보를 입력해 주시기 바랍니다.');
				$('#btn_consDocOpen').click();
				return false;
			}
			
			if(!fnJudgeAmt()){
				alert('품의합계 금액과 경비합계 금액이 일치하도록 금액을 조정해 주세요.');
				return false;
			}
		}
		return true;
	}
	
	/*	[출장 품의] 품의서 정보 입력 콜백
	-------------------------------------------------- */
	function fnConsDocPopCallback(param){
		optionSet.tripConsDoc.consDocSeq = param.consDocSeq;
		$('#btn_consDocOpen').val('수정');
		$('#consDocSeq').val(optionSet.tripConsDoc.consDocSeq);
		/* 품의문서 정보 조회 */
		$.ajax({
			type : 'post'
			, url : '<c:url value='/trip/user/cons/selectConsDocInfo.do' />'
			, datatype : 'json'
			, async : false
			, data : param
			, success : function(result) {
				console.log('		[cons info] 지출 품의 2.0 작성 데이터 >');
				console.log(result);
			
				if(result.result.resultCode != 'SUCCESS'){
					alert('작성된 품의서 정보 조회 실패');
					return;
				}else{
					fnSetConsSummarys(result.result.aData);
					fnSetConsBudgetInfo(result.result.aData);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}
	
	/*	[품의정보] 품의정보 테이블 정보 출력
	-------------------------------------------------- */
	function fnSetConsSummarys(aData){
		
		/* 요약 정보 출력 */
		$('#txt_mgtCnt').text(aData.mgtData.length);
		$('#txt_bgtCnt').text(aData.bgtData.length);
		$('#txt_totalAmt').text( fnGetCurrencyFormat( aData.consAmt ) );

		/* 금액 일치 여부 판단 */
		fnJudgeAmt();
		
		/* 상세 그리드 정보 출력 */		
		var dataSource1 = new Pudd.Data.DataSource({
			data : aData.bgtData
		});
		$("#grid_consSummaryTable").empty();
		if(optionSet.conVo.erpTypeCode == 'ERPiU'){
			Pudd("#grid_consSummaryTable").puddGrid({
				dataSource : dataSource1
			,	height : 89
			,	scrollable : true
			,	pageSize : false
			,	columns : [
					{
							field : "consDate"
						,	title : "발의일자"
						,	width : 16
						,	widthUnit : "%"
						,	content : {
								template : function( rowData ) {
									return fnGetDateFormat(rowData.consDate);
								}
							}
					}
				,	{
							field : "erpBudgetName"
						,	title : "예산단위"
						,	width : 16
						,	widthUnit : "%"
					}
				,	{
							field : "erpBizplanName"
						,	title : "사업계획"
						,	width : 16
						,	widthUnit : "%"
					}
				,	{
							field : "erpBgacctName"
						,	title : "예산계정"
						,	width : 16
						,	widthUnit : "%"
					}
				,	{
							field : "budgetNote"
						,	title : "적요"
						,	width : 16
						,	widthUnit : "%"
					}
				,	{
							field : "budgetAmt"
						,	title : "금액"
						,	width : 16
						,	widthUnit : "%"
						,	content : {
							template : function( rowData ) {
								return fnGetCurrencyFormat(rowData.budgetAmt);
							}
						}
					}
				]
			});
		}
		else{
			Pudd("#grid_consSummaryTable").puddGrid({
				dataSource : dataSource1
			,	height : 89
			,	scrollable : true
			,	pageSize : false
			,	columns : [
					{
							field : "consDate"
						,	title : "발의일자"
						,	width : 20
						,	widthUnit : "%"
						,	content : {
								template : function( rowData ) {
									return fnGetDateFormat(rowData.consDate);
								}
							}
					}
				,	{
							field : "mgtName"
						,	title : "프로젝트"
						,	width : 20
						,	widthUnit : "%"
					}
				,	{
							field : "budgetNote"
						,	title : "적요"
						,	width : 20
						,	widthUnit : "%"
					}
				,	{
							field : "erpBudgetName"
						,	title : "예산과목"
						,	width : 20
						,	widthUnit : "%"
					}
				,	{
							field : "budgetAmt"
						,	title : "금액"
						,	width : 20
						,	widthUnit : "%"
						,	content : {
							template : function( rowData ) {
								return fnGetCurrencyFormat(rowData.budgetAmt);
							}
						}
					}
				]
			});
		}
		
	}
	
	/* 수정 후 예산 및 과목 정보 저장*/
	function fnSetConsBudgetInfo(aData){
		aData.bgtData[0]||{consDocSeq:''}
		var data = {
				bgtData : JSON.stringify(aData.bgtData)
				, mgtData :	JSON.stringify(aData.mgtData)
				, consAmt : aData.consAmt
				, tripDocSeq : $('#tripDocSeq').val()
				, consDocSeq : aData.bgtData[0].consDocSeq
				, isReWrite : isReWrite
		}
		/* 품의문서 예산,과목 정보 저장 */
		$.ajax({
			type : 'post'
			, url : '<c:url value='/trip/user/cons/insertTripConsBudget.do' />'
			, datatype : 'json'
			, async : false
			, data : data
			, success : function(result) {
				console.log('		[cons info] 지출 품의 2.0 작성 예산 데이터 >');
				console.log(result);
				isReWrite = 1;
			
				if(result.result.resultCode != 'SUCCESS'){
					alert('작성된 품의서 정보 조회 실패');
					return;
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}
	
	/*	[여비지급] 여비지급 선택에 따른 품의/결의 정보 노출 처리
	-------------------------------------------------- */
	var _expUseTemp;
	function fnSetConsSummaryDisplay(){
		var expUse = $('input:radio[name=selPayRequestRadi]:checked').val();
		if(expUse == _expUseTemp){
			return;
		}else{
			_expUseTemp = expUse;
		}
		if(expUse == '1'){
			$('.consSummary').hide();	
		}else if(expUse == '0'){
			$('.consSummary').show();
		}
		
		fnJudgeAmt();
	}
	
	/*	[소요일자] 소요일자 출력 함수 구성
	-------------------------------------------------- */
	function fnSetDisplayTimeGap(){
		var printGap = '';
		
		var fromDate = $('#txt_tripFromDate').val();
		var toDate = $('#txt_tripToDate').val();
		
	    var diffDate_1 = new Date(fromDate);
	    var diffDate_2 = new Date(toDate);
	 
	    diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth(), diffDate_1.getDate());
	    diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth(), diffDate_2.getDate());
	 
	    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
	    diff = Math.ceil(diff / (1000 * 3600 * 24)) + 1;
	    printGap = diff + '일';

	    
	    var fromTime = $('#txt_tripFromTime').val();
	    var toTime = $('#txt_tripToTime').val()
	    
	    var startDate = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth(), diffDate_1.getDate(), $('#txt_tripFromTime').val().substring(0,2), $('#txt_tripFromTime').val().substring(2,4), 00);
 		var endDate  = new  Date(diffDate_2.getFullYear(), diffDate_2.getMonth(), diffDate_2.getDate(), $('#txt_tripToTime').val().substring(0,2), $('#txt_tripToTime').val().substring(2,4), 00);
 		var tmp = (endDate.getTime() - startDate.getTime()) / 3600000;
	    printGap += '(' + tmp + '시간)';
		
	    $('#txt_timeGap').html(printGap );
	    optionSet.attend = {
	   		tripDate :  diff
	   		, tripTime : tmp
	    }
	    
	    if(tmp < 0){
	    	$('#txt_alertOverTime').html('종료일이 시작일보다 작습니다.');
	    }else{
	    	$('#txt_alertOverTime').html('');
	    }
	}
	
	/*	[INIT] 푸딩 UI 초기화
	-------------------------------------------------- */
	function fnSetElemInit(){

		/* 출장 기간 데이트 피커 초기화 */
		var toD = new Date();
		var tMonth = (toD.getMonth() + 1);
		var tDay = toD.getDate();
		if(parseInt(tMonth) < 10){
			tMonth = '0' + tMonth; 
		}
		if(parseInt(tDay) < 10){
			tDay = '0' + tDay; 
		}
		$('#txt_tripFromDate').val(toD.getFullYear() +"-" + tMonth +"-"+tDay);
		$('#txt_tripToDate').val(toD.getFullYear() +"-" + tMonth +"-"+tDay);
		
		
		
		/* 장소 셀렉트 박스 기본 구성 */
		var dataSourceAddr = new Pudd.Data.DataSource({
			data : []
		});
		Pudd( "#exSelectiveInput" ).puddSelectiveInput({
				// 수정모드인 경우 dataSource 전달, 신규는 해당없음
				dataSource : dataSourceAddr
			,	dataValueField : "empSeq"
			,	dataTextField : "txtEmpName"
			,	writeMode : false // 기본 입력 모드
			,	disabled : false
			,	editButton : false
			,	deleteButton : true
			,	textMarking : false
			,	emailValidate : false
			,	backspaceDelete : false
		});
		
		
		/* 품의정보 기본 테이블 생성. */
		fnSetConsSummarys({
			mgtData : []
			, bgtData : []
			, consAmt : 0
		});
		
		/* 경비내역 기본 테이블 생성. */
		fnSetExpenseDetails([]);
	}
	
	function fnSetDefaultCheck(){
		$('#inputExpenseCode0').click();
		$('#inputDomesticCode0').click();
	}
	
	/*	[create cons doc] 출장 품의 문서 신규 생성
	-------------------------------------------------- */
	function fnCreateTripConsDoc(){
		var formSeq = '${param.formSeq}';
    	var approKey = '${param.approKey}';
		
		if(!approKey){
			/* 일반 결재 기안 */
			fnCreateNewConsDoc();
			setTimeout(fnSetDefaultCheck, 500);
		}else{
			/* 이전단계 결재 정보 조회 */
			fnCreateReConsDoc(approKey);
		}
	}
	
	/*	[Redraft trip cons doc] 출장 품의 문서 이전단계 로직 시작
	-------------------------------------------------- */
	function fnCreateReConsDoc(approKey){
		var param = cmFnc_getUserInfo();
		var approKeyArray = [];
		
		$('#selectedItems_forCmPop').val(localStorage.selectedItems_forCmPop||'');
		
		approKeyArray = (approKey || '').split('_');
		param.tripConsDocSeq = approKeyArray[2].toString();
		param.consDocSeq = approKeyArray[3].toString();
		optionSet.tripConsDoc = { tripConsDocSeq : approKeyArray[2].toString(), consDocSeq : approKeyArray[3].toString() };
		$.ajax({
			type : 'post'
			, url : '<c:url value='/trip/user/cons/selectTripConsDocAllInfo.do' />'
			, datatype : 'json'
			, async : false
			, data : param
			, success : function(result) {
				console.log('SUCCESS SELECT CONS DOC - ');
				console.log('CONS DOC INFO >>> ');
				if(result.result.resultCode == 'SUCCESS'){
					setTimeout(fnSetDisplayConsData, 500, result.result.aData);
				}else{
					alert('품의정보 조회에 실패하였습니다.');
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}

	/*	[이전단계] 이전단계 문서정보 데이터 조회
	------------------------------------------- */
	function fnSetDisplayConsData(item){
		var attendData = item.attendResult[0];
		var expenseData = item.amtResult; 
		var	travelerData = item.travelerResult;
		var consData = item.consResult;
		
		/* 여비지급 대상여부 (대상) / 품의서 등록 여부 확인 */
		if(item.attendResult[0].tripExpenseCode == '0' && (!!optionSet.tripConsDoc.consDocSeq)){
			$('#btn_consDocOpen').val('수정');
			$('#consDocSeq').val(optionSet.tripConsDoc.consDocSeq);
		}
		
		if(!!consData){
			fnSetConsSummarys(consData);
		}
		
		optionSet.preData = {
			attendSeq : attendData.attendSeq
		}
		
		/* 국내외 구분 콜백 */
		$('#inputDomesticCode' + attendData.domesticCode).click();
		
		/* 장소 데이터 변경 */
		Pudd( "#exAreaSelectBox" ).getPuddObject().setSelectedIndex( ''+ attendData.locationSeq );
		$('#txt_locationNote').val( attendData.locationAdv );
		
		/* 운임수단 데이터 변경 */
		fnSetSelectedTransport(attendData.transportSeq);
		
		/* 일정 데이터 변경 */
		fnSetSelectedCalendar(attendData.calendarSeq);
		
		/* 목적 데이터 변경 */
		$('#txt_purpose').val(attendData.purpose);
		
		/* 여비지급 대상여부 변경 */
		$('#inputExpenseCode' + attendData.tripExpenseCode).click();
		if(attendData.tripExpenseCode == '0'){
			isReWrite = 1;
		}
		
		/* 출장자 정보 */
		$('#select_org_info').val(unescape(attendData.orgDataInfo));
		var exData = [];
		for(var i = 0; i < travelerData.length; i ++){
			var empData = travelerData[i];
			exData.push({ 	
							'empSeq' : empData.empSeq
							, 'txtEmpName' : empData.empName + "(" + (empData.empNameAdv || '') + ') ' + empData.dutyName
							, 'empName' : empData.empName
							, 'positionName' : empData.dutyName
			});
		}
		
		/* 선택된 출장자 정보 변경 */
		$('#exSelectiveInput').empty();
		Pudd( "#exSelectiveInput" ).puddSelectiveInput({
				// 수정모드인 경우 dataSource 전달, 신규는 해당없음
				dataSource : new Pudd.Data.DataSource({
					data : exData
				})
			,	dataValueField : "empSeq"
			,	dataTextField : "txtEmpName"
			,	writeMode : false // 기본 입력 모드
			,	disabled : false
			,	editButton : false
			,	deleteButton : false
			,	textMarking : false
			,	emailValidate : false
			,	backspaceDelete : false
		});
		
		/* 출장 기간 날짜 변경 */
		var frDate = Pudd( "#txt_tripFromDate" ).getPuddObject();
		frDate.setDate( attendData.tripFromDate.split(' ')[0] );
		var toDate = Pudd( "#txt_tripToDate" ).getPuddObject();
		toDate.setDate( attendData.tripToDate.split(' ')[0] );
		
		/* 출장 기간 시간 변경 */
		var frTime = Pudd( "#txt_tripFromTime" ).getPuddObject();
		frTime.setSelectedIndex( attendData.tripFromDate.split(' ')[1].replace(/:/gi, '').substring(0,4) );
		var toTime = Pudd( "#txt_tripToTime" ).getPuddObject();
		toTime.setSelectedIndex( attendData.tripToDate.split(' ')[1].replace(/:/gi, '').substring(0,4) );
		
		/* 시간차 정보 재설정 */
		fnSetDisplayTimeGap();		
		$('#modal_display').show();
		
		/* 경비내역 정보 */
		fnSetExpenseDetails(expenseData);
	}

	/*	[CALENDAR] 일정 정보 재선택
	-------------------------------------------------- */
	function fnSetSelectedCalendar(calendarSeq){
		var createGroupSeq = optionSet.loginVo.groupSeq;
		var createDeptSeq = optionSet.loginVo.orgnztId;
		var createCompSeq = optionSet.loginVo.compSeq;
		var createSeq = optionSet.loginVo.empSeq;
		$.ajax({
			type: 'POST'
			, url:'/schedule/MobileSchedule/SearchMyCalendarList'
            , data: JSON.stringify(
                      {
                            "header": { 
                                  "groupSeq": createGroupSeq, 
                                  "tId": "", 
                                  "pId": "" 
                             }, 
                            "body": { 
                                "langCode": "kr", 
                                "calType": "", 
                                "deptSeq": createDeptSeq, 
                                "compSeq": createCompSeq, 
                                "writeYn" : "Y", 
                                "groupSeq": createGroupSeq, 
                                "tId":"", 
								  "companyInfo": { 
									  "groupSeq": createGroupSeq, 
									  "compSeq": createCompSeq, 
									  "empSeq": createSeq, 
									  "bizSeq": "", 
									  "deptSeq": createDeptSeq, 
									  "emailAddr": "", 
									  "emailDomain": "" 
								  } 
                              }                                                                                                                                                              
                        } 
                    )
			, dataType:'json'
			, contentType:'application/json; charset=utf-8'
			, async : false
			, success : function(result) {
				if(result.resultMessage = 'SUCCESS'){
					console.log('[ CALENDAR API ] API CALL RESULT : ', 'background: #A22;');
					var filterdList = [];
					var selectedCalSeq = 0;
					for(var i=0; i < result.result.calList.length; i++){
						var item = result.result.calList[i];
						/* 이전단계로 조회한 경우 선택 캘린더 기본 값 변경 */
						if( item.mcalSeq == calendarSeq ){
							selectedCalSeq = i;
						}
						filterdList.push(item);
					}
					fnSetCalandarData(filterdList, selectedCalSeq);			
				}
			}, error : function(result) {
				fnSetCalandarData([]);
			}
		});
	}
	
	/*	[운임수단] 재기안/이전단계 선택된 운임수단 조회
	-------------------------------------------------- */
	function fnSetSelectedTransport(transportSeqs){
		$.ajax({
			type : 'post'
			, url : "<c:url value='/trip/user/cons/selectOptionTransport.do' />"
			, datatype : 'json'
			, async : false
			, data : cmFnc_getUserInfo()
			, success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					optionSet.transport = result.result.aaData;

					transportSeqs += ',';
					for(var i=0; i < optionSet.transport.length; i++ ){
						var item = optionSet.transport[i];
						if( transportSeqs.indexOf( item.transportSeq + ',') > -1 ){
							item.selected = true;
							optionSet.transport[i] = item;
						}
					}
					
					var dataSourceComboBox = new Pudd.Data.DataSource({
						data : optionSet.transport
					});
					
					Pudd( "#sel_transport" ).puddComboBox({
						attributes : { style : "width:412px;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "exAreaSelectBox" }// control 자체 객체 속성 설정
					,	dataSource : dataSourceComboBox
					,	multiType : true
					,	dataValueField : "transportSeq"
					,	dataTextField : "transportName"
					,	disabled : false
					,	scrollListHide : true
					,	dataMultiSelected : "selected"
					,	eventCallback : {
							"change" : function( e ) {
								console.log( "change" + e );
							}
						}
					});
					
				}else{
					alert('교통 정보 조회 실패');
					console.log(result);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}
	
	/*	[Create trip cons doc] 출장 품의 문서 신규 생성
	-------------------------------------------------- */
	function fnCreateNewConsDoc(){
		$.ajax({
			type : 'post'
			, url : '<c:url value='/trip/user/cons/insertTripConsDoc.do' />'
			, datatype : 'json'
			, async : false
			, data : cmFnc_getUserInfo()
			, success : function(result) {
				console.log('SUCCESS CREATE CONS DOC - ');
				console.log('CONS DOC INFO >>> ');
				console.log(result)
				if(result.result.resultCode == 'SUCCESS'){
					$('#h1_consDocTitle').html($('#h1_consDocTitle').text() + ' / ' + result.result.aData.tripConsDocSeq);
					optionSet.tripConsDoc = {tripConsDocSeq : result.result.aData.tripConsDocSeq};
				}else{
					alert('품의서 생성에 실패하였습니다.');
					console.log('[ERROR] CREATE TRIP CONS DOC . LOG > ');
					console.log(result);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}

	
	/*	[공통팝업 콜백] 출장자 선택 콜백
	-------------------------------------------------- */
	function fnCallbackSel(param){
		console.log(' SELECT TRIPER INFO >>');
		console.log(param.returnObj);
		$('#modal_display').show();
		
		if(param.returnObj.length > 0){
			var selected = '';
			var exData = [];
			$('#select_org_info').val(JSON.stringify(param.returnObj));
			for(var i = 0; i < param.returnObj.length ; i++){
				var item = param.returnObj[i];
				if((item.compSeq || '') != optionSet.loginVo.compSeq){
					continue;
				}
				selected += ', ' + item.superKey;
				exData.push({ 	
								'empSeq' : item.empSeq
								, 'txtEmpName' : item.empName + (item.empNameAdv || '') + ' ' + item.positionName
								, 'empName' : item.empName
								, 'positionName' : item.positionName
				});
			}
			
			var dataSourceAddr = new Pudd.Data.DataSource({
				data : exData
			});
			
			$('#exSelectiveInput').empty();
			Pudd( "#exSelectiveInput" ).puddSelectiveInput({
					// 수정모드인 경우 dataSource 전달, 신규는 해당없음
					dataSource : dataSourceAddr
				,	dataValueField : "empSeq"
				,	dataTextField : "txtEmpName"
				,	writeMode : false // 기본 입력 모드
				,	disabled : false
				,	editButton : false
				,	deleteButton : false
				,	textMarking : false
				,	emailValidate : false
				,	backspaceDelete : false
			});
			
			/* 경비내역 상세 출력 */
			fnSelectAmtDatas(exData);
			localStorage.selectedItems_forCmPop = selected.substring(1);

			$('#selectedItems_forCmPop').val(localStorage.selectedItems_forCmPop||'');
		}else{
			$('#modal_display').hide();
			$('#selectedItems_forCmPop').val('');
			$('#exSelectiveInput').empty();
			var dataSourceAddr = new Pudd.Data.DataSource({
				data : []
			});
			Pudd( "#exSelectiveInput" ).puddSelectiveInput({
					// 수정모드인 경우 dataSource 전달, 신규는 해당없음
					dataSource : dataSourceAddr
				,	dataValueField : "empSeq"
				,	dataTextField : "txtEmpName"
				,	writeMode : false // 기본 입력 모드
				,	disabled : false
				,	editButton : false
				,	deleteButton : false
				,	textMarking : false
				,	emailValidate : false
				,	backspaceDelete : false
			});
			/* 경비내역 기본 테이블 생성. */
			fnSetExpenseDetails([]);
		}
	}
	
	/*	[경비내역] 경비내역 상세정보 데이터 조회
	-------------------------------------------------- */
	function fnSelectAmtDatas(users){
		var param = cmFnc_getUserInfo();
		var empSeqs = '';
		for (var i = 0; i < users.length; i++){
			empSeqs += ',' + (users[i].empSeq || '');
		}
		empSeqs = '(' + (empSeqs.substring(1)) + ')';
		param.empSeq = empSeqs; 
		param.locationSeq = $('#sel_location option:selected').val();
		param.transportSeq = fnGetTransportSelectedDataKey();
		
		$.ajax({
			type : 'post'
			, url : "<c:url value='/trip/user/cons/selectOptionAmt.do' />"
			, datatype : 'json'
			, async : true
			, data : param
			, success : function(result) {
				if(result.result.resultCode == 'SUCCESS'){
					fnSetExpenseDetails(result.result.aaData);
				}else{
					alert('교통 정보 조회 실패');
					console.log(result);
				}
			}, error : function(result) {
				console.error(result);
			}
		});
	}
	
	/*	[경비내역] 경비내역 테이블 출력
	-------------------------------------------------- */
	function fnSetExpenseDetails(users){
		var dataSource1 = new Pudd.Data.DataSource({
			data : users
,			pageSize : 500
		});
		
		$('#select_expense_info').val(JSON.stringify(users));
		
		$('#grid_expenseDetailTable').empty();
		Pudd("#grid_expenseDetailTable").puddGrid({
				dataSource : dataSource1
			,	height : 149
			,	scrollable : true
//			, 	pageable : {
//				buttonCount : 10 
//				, pageList : [ 10, 20, 30, 40, 50 ]
//			}
			// ,	editable : true
			,	columns : [ {
					field : "empName"
					, title : "이름"
					, width : 11.1
					, widthUnit : "%"
					, content : {
						template : function( rowData ) {
							var html = '<input type="hidden" class="hiddenExpenseJson" value="' + escape(JSON.stringify(rowData)) + '">' + rowData.empName + '</input>';
							return html;  
						}
					}
				}, {
					field : "dutyName"
					, title : "직책"
					, width : 11.1
					, widthUnit : "%"
				}, {
					field : ""
					, title : "일비"
					, width : 11.1
					, widthUnit : "%"
					, content : {
						template : function( rowData ) {
							var html = '';
							var amt = '';
							if(!'${param.approKey}'){
								amt = fnGetDailAmt('1', rowData.amtClass1Amt || '' );
							}else{
								if(isClear=='1'){
									amt = fnGetDailAmt('1', rowData.amtClass1Amt || '' );
								}
								else{
									amt = fnGetDailAmt('1', rowData.amtClass1Amt || '' );
								}
							}
							if(rowData.amtClass1HoldCode == '0'){
								html = '<input placeholder = "0" type="txtAmtClass1" class="puddSetup amtClass1Amt amtMask txtAmtClass1" type="text" name="DISPLAY_NM" value="' + amt + '" style="width:100%;" disabled/>';
							}else{
								rowData.maxAmt1 = rowData.maxAmt1 || amt; 
								html = '<input placeholder = "0" type="txtAmtClass1" class="puddSetup amtClass1Amt amtMask txtAmtClass1" type="text" name="DISPLAY_NM" value="' + amt + '" style="width:100%;" maxAmt="' + rowData.maxAmt1 + '"/>';
							}
							return html;  
						}
					}
				}, {
					field : "amtClass2Amt"
					, title : "식비"
					, width : 11.1
					, widthUnit : "%"
					, content : {
						template : function( rowData ) {
							var html = '';
							var amt = '';
							if(!'${param.approKey}'){
								amt = fnGetDailAmt('2', rowData.amtClass2Amt || '' );
							}else{
								if(isClear=='1'){
									amt = fnGetDailAmt('2', rowData.amtClass2Amt || '' );
								}
								else{
									amt = fnGetDailAmt('2', rowData.amtClass2Amt || '' );	
								}
							}
							if(rowData.amtClass2HoldCode == '0'){
								html = '<input placeholder = "0" type="txtAmtClass2" class="puddSetup amtClass2Amt amtMask txtAmtClass2" type="text" name="DISPLAY_NM" value="' + amt + '" style="width:100%;" disabled/>';
							}else{
								rowData.maxAmt2 = rowData.maxAmt2 || amt;
								html = '<input placeholder = "0" type="txtAmtClass2" class="puddSetup amtClass2Amt amtMask txtAmtClass2" type="text" name="DISPLAY_NM" value="' + amt + '" style="width:100%;" maxAmt="' + rowData.maxAmt2 + '"/>';
							}
							return html;
						}
					}
				}, {
					field : "amtClass3Amt"
					,	title : "숙박비"
					,	width : 11.1
					,	widthUnit : "%"
					,	content : {
						template : function( rowData ) {
							var html = '';
							var amt = '';
							if(!'${param.approKey}'){
								amt = fnGetDailAmt('3', rowData.amtClass3Amt || '' );
							}else{
								if(isClear=='1'){
									amt = fnGetDailAmt('3', rowData.amtClass3Amt || '' );	
								}
								else{
									amt = fnGetDailAmt('3', rowData.amtClass3Amt || '' );;	
								}
							}
							if(rowData.amtClass3HoldCode == '0'){
								html = '<input placeholder = "0" type="txtAmtClass3" class="puddSetup amtClass3Amt amtMask txtAmtClass3" type="text" name="DISPLAY_NM" value="' + amt + '" style="width:100%;" disabled/>';
							}else{
								rowData.maxAmt3 = rowData.maxAmt3 || amt;
								html = '<input placeholder = "0" type="txtAmtClass3" class="puddSetup amtClass3Amt amtMask txtAmtClass3" type="text" name="DISPLAY_NM" value="' + amt + '" style="width:100%;" maxAmt="' + rowData.maxAmt3 + '"/>';
							}
							return html;
						}
					}
				}, {
					field : "amtClass4Amt"
					, title : "운임비"
					, width : 11.1
					, widthUnit : "%"
					, content : {
						template : function( rowData ) {
							var html = '';
							if(rowData.amtClass4HoldCode == '0'){
								html = '<input placeholder = "0" type="txtAmtClass4" class="puddSetup amtClass4Amt amtMask txtAmtClass4" type="text" name="DISPLAY_NM" value="' + ( rowData.amtClass4Amt || '' ) + '" style="width:100%;" disabled/>';
							}else{
								rowData.maxAmt4 = rowData.maxAmt4 || rowData.amtClass4Amt;
								html = '<input placeholder = "0" type="txtAmtClass4" class="puddSetup amtClass4Amt amtMask txtAmtClass4" type="text" name="DISPLAY_NM" value="' + ( rowData.amtClass4Amt || '' ) + '" style="width:100%;" maxAmt="' + rowData.maxAmt4 + '"/>';
							}
							return html;
						}
					}
				}, {
					field : "amtClass5Amt"
					,	title : "관내여비"
					,	width : 11.1
					,	widthUnit : "%"
					,	content : {
						template : function( rowData ) {
							var html = '';
							if(rowData.amtClass5HoldCode == '0'){
								html = '<input placeholder = "0" type="txtAmtClass5" class="puddSetup amtClass5Amt amtMask txtAmtClass5" type="text" name="DISPLAY_NM" value="' + ( rowData.amtClass5Amt || '' ) + '" style="width:100%;" disabled/>';
							}else{
								rowData.maxAmt5 = rowData.maxAmt5 || rowData.amtClass5Amt;
								html = '<input placeholder = "0" type="txtAmtClass5" class="puddSetup amtClass5Amt amtMask txtAmtClass5" type="text" name="DISPLAY_NM" value="' + ( rowData.amtClass5Amt || '' ) + '" style="width:100%;" maxAmt="' + rowData.maxAmt5 + '"/>';
							}
							return html;
						}
					}
				}, {
					field : "amtClass6Amt"
					, title : "준비금"
					, width : 11.1
					, widthUnit : "%"
					, content : {
						template : function( rowData ) {
							var html = '';
							if(rowData.amtClass6HoldCode == '0'){
								html = '<input placeholder = "0" type="txtAmtClass6" class="puddSetup amtClass6Amt amtMask txtAmtClass6" type="text" name="DISPLAY_NM" value="' + ( rowData.amtClass6Amt || '' ) + '" style="width:100%;" disabled/>';
							}else{
								rowData.maxAmt6 = rowData.maxAmt6 || rowData.amtClass6Amt;
								html = '<input placeholder = "0" type="txtAmtClass6" class="puddSetup amtClass6Amt amtMask txtAmtClass6" type="text" name="DISPLAY_NM" value="' + ( rowData.amtClass6Amt || '' ) + '" style="width:100%;" maxAmt="' + rowData.maxAmt6 + '"/>';
							}
							return html;
						}
					}
				}, {
					field : "amtClassSum"
					, title : "합계"
					, content : {
						template : function( rowData ) {
							if(!'${param.approKey}'){
								var amtSum = fnGetDailAmt('1', rowData.amtClass1Amt || '0' ) + fnGetDailAmt('2', rowData.amtClass2Amt || '0' ) + fnGetDailAmt('3', rowData.amtClass3Amt || '0' ) + parseInt(rowData.amtClass4Amt) + parseInt(rowData.amtClass5Amt) + parseInt(rowData.amtClass6Amt);
							}
							else {
								if(isClear=='1'){
									var amtSum = fnGetDailAmt('1', rowData.amtClass1Amt || '0' ) + fnGetDailAmt('2', rowData.amtClass2Amt || '0' ) + fnGetDailAmt('3', rowData.amtClass3Amt || '0' ) + parseInt(rowData.amtClass4Amt) + parseInt(rowData.amtClass5Amt) + parseInt(rowData.amtClass6Amt);	
								}
								else{
									var amtSum = fnGetDailAmt('1', rowData.amtClass1Amt || '0' ) + fnGetDailAmt('2', rowData.amtClass2Amt || '0' ) + fnGetDailAmt('3', rowData.amtClass3Amt || '0' ) + parseInt(rowData.amtClass4Amt) + parseInt(rowData.amtClass5Amt) + parseInt(rowData.amtClass6Amt);
								}
							}
							var html = '<span class="txtAmtClass7">' + fnGetCurrencyFormat( amtSum || 0 )+ '</span>'
							return html;  
						}
					}
				} 
			]
			, loadCallback : function( headerTable, contentTable, footerTable, gridObj ) {
				$('.amtMask').mask("000,000,000,000,000,000,000", {reverse: true});
				$('.amtMask').keyup(function(){
					var thisAmt = parseInt( ($(this).val() || '0' ).replace(/,/gi, '') );
					var maxAmt = parseInt( ($(this).attr('maxAmt') || '0' ).replace(/,/gi, '') );
					if(maxAmt !== 0){
						if(thisAmt > maxAmt){
							$(this).val( fnGetCurrencyFormat(maxAmt) );
						}else{
							$(this).val(fnGetCurrencyFormat(thisAmt));
						}
					} else if(thisAmt === 0){
						$(this).val('');
					}
					
					var type = $(this).attr('type');
					var totalAmt = 0;
					$('.'+type).each(function () {
						totalAmt += parseInt($(this).val().replace( /[^0-9]/gi, '' ) || 0 );
					});
					
					$('#' + type).html( fnGetCurrencyFormat( totalAmt ) );
					
					var rowTotal = 
						parseInt($(this).parent().parent().find('.txtAmtClass1').val().replace( /[^0-9]/gi, '' ) || 0 )
						+ parseInt($(this).parent().parent().find('.txtAmtClass2').val().replace( /[^0-9]/gi, '' ) || 0 )
						+ parseInt($(this).parent().parent().find('.txtAmtClass3').val().replace( /[^0-9]/gi, '' ) || 0 )
						+ parseInt($(this).parent().parent().find('.txtAmtClass4').val().replace( /[^0-9]/gi, '' ) || 0 )
						+ parseInt($(this).parent().parent().find('.txtAmtClass5').val().replace( /[^0-9]/gi, '' ) || 0 )
						+ parseInt($(this).parent().parent().find('.txtAmtClass6').val().replace( /[^0-9]/gi, '' ) || 0 );
					$(this).parent().parent().find('.txtAmtClass7').text(fnGetCurrencyFormat( rowTotal ));
					
					var totalResultAmt =
						parseInt(( '' + $('#txtAmtClass1').html() ).replace(/[^0-9]/gi, ''))
						+ parseInt(( '' + $('#txtAmtClass2').html() ).replace(/[^0-9]/gi, ''))
						+ parseInt(( '' + $('#txtAmtClass3').html() ).replace(/[^0-9]/gi, ''))
						+ parseInt(( '' + $('#txtAmtClass4').html() ).replace(/[^0-9]/gi, ''))
						+ parseInt(( '' + $('#txtAmtClass5').html() ).replace(/[^0-9]/gi, ''))
						+ parseInt(( '' + $('#txtAmtClass6').html() ).replace(/[^0-9]/gi, ''))
					$('#txtAmtClass7').html( fnGetCurrencyFormat( totalResultAmt ) );
					
					/* 금액 일치 여부 판단 */
					fnJudgeAmt();
				});
				
				var totalAmt1 = 0;
				var totalAmt2 = 0;
				var totalAmt3 = 0;
				var totalAmt4 = 0;
				var totalAmt5 = 0;
				var totalAmt6 = 0;
				var totalAmt7 = 0;
				for( var i = 0; i < contentTable.rows.length; i++ ){
					var item = Pudd.getInstance( contentTable.rows[i] ).rowData;
					$(contentTable.rows[i]).attr('trSeq', i);
					if(!'${param.approKey}'){
						/* 일반 작성 자동계산 */
						totalAmt1 += fnGetDailAmt('1',parseInt( item.amtClass1Amt ) );
						totalAmt2 += fnGetDailAmt('2',parseInt( item.amtClass2Amt ) );
						totalAmt3 += fnGetDailAmt('3',parseInt( item.amtClass3Amt ) );
					}else{
						if(isClear=='1'){
							/* 이전단계 자동 일자 계산 제외 */
							totalAmt1 += fnGetDailAmt('1',parseInt( item.amtClass1Amt ) );
							totalAmt2 += fnGetDailAmt('2',parseInt( item.amtClass2Amt ) );
							totalAmt3 += fnGetDailAmt('3',parseInt( item.amtClass3Amt ) );
						}
						else{
							totalAmt1 += fnGetDailAmt('1',parseInt( item.amtClass1Amt ) );
							totalAmt2 += fnGetDailAmt('2',parseInt( item.amtClass2Amt ) );
							totalAmt3 += fnGetDailAmt('3',parseInt( item.amtClass3Amt ) );
						}
					}
					totalAmt4 += parseInt( item.amtClass4Amt );
					totalAmt5 += parseInt( item.amtClass5Amt );
					totalAmt6 += parseInt( item.amtClass6Amt );
					
					if(!'${param.approKey}'){
						totalAmt7 += (
							parseInt( fnGetDailAmt('1',item.amtClass1Amt ) || '0' ) 
							+ parseInt( fnGetDailAmt('2',item.amtClass2Amt ) || '0'  ) 
							+ parseInt( fnGetDailAmt('3',item.amtClass3Amt ) || '0'  ) 
							+ parseInt(item.amtClass4Amt || '0') 
							+ parseInt(item.amtClass5Amt || '0') 
							+ parseInt(item.amtClass6Amt || '0') 
						);
					}else{
						if(isClear=='1'){
							totalAmt7 += (
									parseInt( fnGetDailAmt('1',item.amtClass1Amt ) || '0' ) 
									+ parseInt( fnGetDailAmt('2',item.amtClass2Amt ) || '0'  ) 
									+ parseInt( fnGetDailAmt('3',item.amtClass3Amt ) || '0'  ) 
									+ parseInt(item.amtClass4Amt || '0') 
									+ parseInt(item.amtClass5Amt || '0') 
									+ parseInt(item.amtClass6Amt || '0') 
								);
						}
						else{
							totalAmt7 += (
									parseInt( item.amtClass1Amt  || '0') 
									+ parseInt( item.amtClass2Amt|| '0') 
									+ parseInt( item.amtClass3Amt|| '0') 
									+ parseInt(item.amtClass4Amt || '0') 
									+ parseInt(item.amtClass5Amt || '0') 
									+ parseInt(item.amtClass6Amt || '0')
								);	
						}
					}
				}   
				$('#txtAmtClass1').html( fnGetCurrencyFormat( totalAmt1 ) );
				$('#txtAmtClass2').html( fnGetCurrencyFormat( totalAmt2 ) );
				$('#txtAmtClass3').html( fnGetCurrencyFormat( totalAmt3 ) );
				$('#txtAmtClass4').html( fnGetCurrencyFormat( totalAmt4 ) );
				$('#txtAmtClass5').html( fnGetCurrencyFormat( totalAmt5 ) );
				$('#txtAmtClass6').html( fnGetCurrencyFormat( totalAmt6 ) );
				$('#txtAmtClass7').html( fnGetCurrencyFormat( totalAmt7 ) );
				
				/* 금액 일치 여부 판단 */
				fnJudgeAmt();
			}       
		});         
	}               
	
	function fnGetDailAmt(type, amt){
		if(!amt){
			return '';
		}
		if(type == '1'){
			/* 일비의 경우 처리 */
			return ( parseInt(optionSet.attend.tripDate ) * parseInt(amt) );
		}else if (type == '2'){
			/* 식비의 경우 처리 */
			return ( parseInt(optionSet.attend.tripDate) * parseInt(amt) );
		}else if (type == '3'){
			/* 숙박비의 경우 처리 */
			return ( parseInt(optionSet.attend.tripDate - 1 ) * parseInt(amt) );
		}
	}
	
	/*	[금액] 금액 일치 여부 판단
	------------------------------------------------------------ */
	function fnJudgeAmt(){
		var consAmt = parseFloat( $('#txt_totalAmt').text().replace(/,/gi, '') );
		var tripAmt = parseFloat( $('#txtAmtClass7').text().replace(/,/gi, '') );
		
		
		/* 여비지급 미대상 사용 경우. */
		if($('input:radio[name=selPayRequestRadi]:checked').val() == '1'){
			$('.div_totalAmt').css('background-color', 'white');
			$('#txtAmtClass7').css('background-color', 'white');
			return true
		}
		
		/* 금액 일치 여부 확인 */
		if(consAmt != tripAmt){
			$('.div_totalAmt').css('background-color', 'rgba(252,83,86,0.33)')
			$('#txtAmtClass7').css('background-color', 'rgba(252,83,86,0.33)')
			return false;
		}else{
			$('.div_totalAmt').css('background-color', 'white');
			$('#txtAmtClass7').css('background-color', 'white');
			return true;
		}
	}
	
</script>

<input type="hidden" name="" id="select_org_info" width="800" value="" /> 
<input type="hidden" name="" id="select_expense_info" width="800" value="" /> 

<!-- 공통팝업 위한 기능옵션 전달 폼 -->
<form id="frmPop2" name="frmPop2">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="" /> 
	<input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" /> 
	<input type="hidden" id="langCode_forCmPop" name="langCode" width="500" /> 
	<input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" /> 
	<input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" /> 
	<input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" /> 
	<input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" /> 
	<input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" /> 
	<input type="hidden" name="selectMode" width="500" value="u" /> 
	<input type="hidden" name="selectItem" width="500" value="m" /> 
	<input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> 
	<input type="hidden" name="callback" width="500" value="fnCallbackSel"/> 
	<input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
</form>

<form id="consDocPop" name="consDocPop" method="post" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="EXNPInterlockAPI" id="EXNPInterlockAPI" value="1"/>
	<input type="hidden" name="EXNPInterlockFormDTP" id="EXNPInterlockFormDTP" value="CON"/>
	<input type="hidden" name="EXNPInterlockFormDTP2" id="EXNPInterlockFormDTP" value="TRIPCON"/>
	<input type="hidden" name="tripDocSeq" id="tripDocSeq" value=""/>
	<input type="hidden" name="consDocPopCallback" id="consDocPopCallback" value="fnConsDocPopCallback"/>
	<input type="hidden" name="consDocSeq" id="consDocSeq" value=""/>
</form>	