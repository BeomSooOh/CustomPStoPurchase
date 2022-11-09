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
<%@page import="main.web.BizboxAMessage"%>

<div class="sub_wrap">
	<!-- iframe wrap -->
	<div class="iframe_wrap">
		<!-- 컨텐츠타이틀영역 -->
		<div class="sub_title_wrap">
			<div class="location_info">
				<ul>
					<li><a href="#n"> <img
							src="../../../Images/ico/ico_home01.png" alt=""></a></li>
					<li><a href="#n"><%=BizboxAMessage.getMessage("TX000009559","지출결의설정")%></a></li>
					<li class="on"><a href="#n"><%=BizboxAMessage.getMessage("TX000007444","버튼설정")%></a></li>
				</ul>
			</div>
			<div class="title_div">
				<h4><%=BizboxAMessage.getMessage("TX000007444","버튼설정")%></h4>
			</div>
		</div>
		<div class="sub_contents_wrap">
			<div class="twinbox">
				<table>
					<colgroup>
						<col width="30%" />
						<col width="70%" />
					</colgroup>
					<tr>
						<td class="twinbox_td">
							<p class="tit_p"><%=BizboxAMessage.getMessage("TX000019400","버튼설정")%></p>
							<div class="com_ta4 bgtable2 bg_lightgray scroll_y_on tb_borderT"
								style="height: 675px;">
								<table id="tbl_formList">

								</table>
							</div>
						</td>
						<td class="twinbox_td p0">
							<div class="tab_nor pl15 pt10">
								<ul>
									<li class="on div_page10" style="display: none;"><a
										href="javascript:tab_nor_Fn(1);"><%=BizboxAMessage.getMessage("TX000019401","결의내역 버튼설정")%></a></li>
									<!-- <li><a href="javascript:tab_nor_Fn(2)">새로운 탭</a></li> -->
								</ul>
								<div class="fr controll_btn p0 pr15">
									
									<button class="btn_sc_add coMode" style="display:none;" id="btn_devNewElem"><%=BizboxAMessage.getMessage("TX000003101","신규")%></button>
									<button class="coMode" style="display:none;" id="btn_devDeleteElem"><%=BizboxAMessage.getMessage("TX000005668","삭제")%></button>
									<button id="btn_orderSave"><%=BizboxAMessage.getMessage("TX000001256","저장")%></button>
								</div>
							</div>
							<div class="tab_area p15">
								<!-- 탭1 -->
								<div class="tab1 div_page10" style="display: none;">
								
								<div class="f11 text_gray pb10" style="margin:0 auto; width:660px;">
									※ 아래 미리보기 화면은 실제 팝업 사이즈와 다소 차이가 있을 수 있습니다.
								</div>
<!-- 								<span class="blue" style="">※ 아래 미리보기 화면은 실제 팝업 사이즈와 다소 차이가 있을 수 있습니다.</span> -->
									<div class="buttonSet">
										<div class="head" id="div_selected_position10">
											<span class="title" id="txt_formTitle">-</span>
											<div class="fr btn_cen mr15" id="div_title_selected"
												style="width: 50%;"></div>
										</div>
										<div class="p15">
											<!-- 상단버튼 -->
											<div class="button_sel img01 clickable" style="height: 108px;" page="10" position="10">
												<div class="head_btn ml10" id="div_title_list"></div>
											</div>


											<!-- 항목정보 -->
											<div class="btn_div mt14 div_area_L">
												<p class="tit_p fl mt5 mb5"><%=BizboxAMessage.getMessage("TX000009503","항목정보")%></p>
												<div class="right_div" style="width: 87%;">
													<div class="controll_btn fr p0" id="div_list_selected"
														style="width: 100%;"></div>
												</div>
											</div>
											<div class="button_sel img02 clickable div_area_L" style="height: 108px;" page="10" position="20">
												<div class="controll_btn ml10" id="div_list_list"></div>
											</div>


											<!-- 분개정보 -->
											<div class="btn_div mt14 div_area_S">
												<p class="tit_p fl mt5 mb5"><%=BizboxAMessage.getMessage("TX000007462","분개정보")%></p>
												<div class="right_div" style="width: 87%;">
													<div class="controll_btn fr p0" id="div_slip_selected"
														style="width: 100%;"></div>
												</div>
											</div>
											<div class="button_sel img03 clickable div_area_S" style="height: 108px;" page="10" position="30">
												<div class="controll_btn ml10" id="div_slip_list"></div>
											</div>


											<!-- 관리항목 -->
											<div class="btn_div mt14 div_area_M">
												<p class="tit_p fl mt5 mb5"><%=BizboxAMessage.getMessage("TX000002703","관리항목")%></p>
												<div class="right_div" style="width: 87%;">
													<div class="controll_btn fr p0" id="div_mng_selected"
														style="width: 100%;">
														<!-- 버튼 드래그앤 드롭시 이쪽에 넣어주세요. -->
													</div>
												</div>
											</div>
											<div class="button_sel img04 clickable div_area_M" style="height: 108px;" page="10" position="40">
												<div class="controll_btn ml10" id="div_mng_list"></div>
											</div>
										</div>
									</div>
								</div>
							</div> <!--// tab_area -->
						</td>
					</tr>
				</table>
			</div>
			<!-- twinbox -->
		</div>
		<!-- 메인영역 // sub_contents_wrap -->
		
		<div class="modal btnPopInfo" style="display:none;z-index: 103;" id="PLP_divModal"></div>
		<div class="pop_wrap_dir btnPopInfo" style="width: 498px; display:none;left: 50%;top: 50%;z-index: 104;">
			<div class="pop_head">
				<h1 id="txt_popTitle"><%=BizboxAMessage.getMessage("TX000019402","신규버튼")%></h1>
				<a href="#n" class="clo">
					<img onClick="javascript:fnEndBtnPop();" id="PLP_btnPopClose" src="/exp/Images/btn/btn_pop_clo02.png" value="" alt="" />
				</a>
			</div>

			<div class="pop_con">
				<div class="com_ta">
					<table>
						<colgroup>
							<col width="15%" />
							<col width="22%" />
							<col width="63%" />
						</colgroup>
						<tr>
							<th rowspan="5" class="p0 ac"><%=BizboxAMessage.getMessage("TX000007398","버튼")%><br /><%=BizboxAMessage.getMessage("TX000000152","명칭")%>
							</th>
							<th><img src="/exp/Images/ico/ico_check01.png" alt="" /><%=BizboxAMessage.getMessage("TX000000936","기본값")%></th>
							<td><input type="text" id="btn_nmBasic" style="width: 95%" value="" class="btnPopInput" readonly/></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000002787","한국어")%></th>
							<td><input type="text" id="btn_nmKR" style="width: 95%" value="" class="btnPopInput" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000002790","영어")%></th>
							<td><input type="text" id="btn_nmEN" style="width: 95%" value="" class="btnPopInput" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000002788","일본어")%></th>
							<td><input type="text" id="btn_nmJP" style="width: 95%" value="" class="btnPopInput" /></td>
						</tr>
						<tr>
							<th><%=BizboxAMessage.getMessage("TX000002789","중국어")%></th>
							<td><input type="text" id="btn_nmCN" style="width: 95%" value="" class="btnPopInput" /></td>
						</tr>
						<tr>
							<th colspan="2"><%=BizboxAMessage.getMessage("","버튼너비")%></th>
							<td>
								<select class="selectmenu" style="width: 150px;">
									<option value="79">4<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="91">5<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="104" selected="selected">6<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="116">7<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="129">8<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="141">9<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="154">10<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="166">11<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="179">12<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="191">13<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
									<option value="203">14<%=BizboxAMessage.getMessage("TX000019403","글자")%></option>
								</select>
							</td>
						</tr>
						<tr class="coMode">
							<th colspan="2">호출 URL</th>
							<td><input type="text" id="dev_callURL" style="width: 95%" value="" /></td>
						</tr>
						<tr class="coMode">
							<th colspan="2">Parameter</th>
							<td><textarea id="dev_callParam" name="" style="width: 91%; padding: 2%;"
									rows="4"></textarea></td>
						</tr>
						<tr class="coMode">
							<th colspan="2">Call Back URL</th>
							<td><select id="dev_callbackType" class="selectmenu cl fl" style="width: 255px;">
									<option value="0" selected="selected">스크립트</option>
									<option value="1">외부스크립트</option>
									<option value="2">Data Base</option>
							</select>

								<p class="mt7">
									ㆍ함수명 <input type="text" id="dev_callbackKey" style="width: 195px;" class="ml5"
										value="" />
								</p> <!-- 스크립트 선택일경우 사용 --></td>
						</tr>
						<tr class="coMode">
							<th colspan="2">라이선스 여부</th>
							<td><input type="checkbox" name="" id="licenseYN" selected />
								</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- //pop_con -->

			<div class="pop_foot">
				<div class="btn_cen pt12">
					<input type="button" value="신규생성" onClick="javascript:fnSubmitAddBtnPop();" style="display:none;" id="pop_btnAdd"/>
					<input type="button" value="저장" onClick="javascript:fnSubmitBtnPop();" id="pop_btnSave"/> 
					<input type="button" class="gray_btn" value="취소" onClick="javascript:fnEndBtnPop();"/>
				</div>
			</div>
			<!-- //pop_foot -->
		</div>
		<!-- 버튼 팝업 // pop_wrap -->
		
	</div>
</div>
<input type="hidden" id="hid_formSeq" value=""/>
<input type="hidden" id="hid_pageSeq" value=""/>
<input type="hidden" id="hid_positionSeq" value=""/>

<style type="text/css">
.highlight {
    border: 1px solid red;
    font-weight: bold;
    font-size: 45px;
    background-color: lightblue;
}
</style>

<script type="text/javascript" src='<c:url value="/js/jquery-ui-1.10.4.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.focus.js"></c:url>'></script>
<script>
	/*	[문서 준비] 버튼설정 페이지 문서 준비
	 -------------------------------------------------- */
	var cmmInfo = fnGetDataObject();
	$(document).ready(function() {
		/* document ready */
		fnSetCheatkey();

		/* 전자결재 양식 리스트 조회 */
		fnSelectFormInfo();

		/* 클릭 이벤트 바인드 */
		fnSetBtnEvent();
		
		/* 버튼설정 레이어 팝업 초기화 */
		fnReadyBtnPop();
	});

	/*	[팝업] 버튼설정 팝업 준비
	-------------------------------------------------- */
	function fnReadyBtnPop(){
		/* 개발자 모드 감추기 */
		$('.coMode').hide();
		
		/* 레이어 위치 재조정 */
		var top = ( parseInt($('.pop_wrap_dir').height()) / 2 ) * -1 + 'px';
		var left = ( parseInt($('.pop_wrap_dir').width()) / 2 ) * -1 + 'px';
		$('.pop_wrap_dir').css('margin-top', top);
		$('.pop_wrap_dir').css('margin-left', left);
		
		/* 팝업창 감추기 */
		$('.btnPopInfo').hide();
		
		/* ESC입력 추가 / 팝업 닫기 */
		$(document).keydown(function(e){
			if(e.keyCode == 27){
				fnEndBtnPop();
			}
		});
	}
	
	/*	[팝업] 버튼설정 팝업 초기화
	-------------------------------------------------- */	
	function fnInitBtnPop(){
		$('.btnPopInput').val('');
		$(".selectmenu").val("100");
		
		$(".selectmenu").val('');
		$('#dev_callURL').val('');
		$('#dev_callParam').val('');
		$('#dev_callbackType').val('0');
		$('#licenseYN').prop('checked', false);
		
		$('#txt_popTitle').text('신규버튼');
	}
	/*	[팝업] 신규버튼 팝업 출력
	-------------------------------------------------- */
	function fnShowBtnAddPop(page, position){
		fnInitBtnPop();
		if(!cmmInfo.getHiddenMode()){
			return ;
		}
		/* 양식 정보 설정 */
		$('#btn_nmBasic').attr("readonly",false);
		var top = ( parseInt($('.pop_wrap_dir').height()) / 2 ) * -1 + 'px';
		var left = ( parseInt($('.pop_wrap_dir').width()) / 2 ) * -1 + 'px';
		$('.pop_wrap_dir').css('margin-top', top);
		$('.pop_wrap_dir').css('margin-left', left);
		$('#pop_btnSave').hide();
		$('#pop_btnAdd').show();

		/* 기본값 저장 */
		$('#hid_pageSeq').val(page);
		$('#hid_positionSeq').val(position);
		
		$('.btnPopInfo').show();
	}
	
	
	/*	[팝업] 버튼설정 팝업 출력
	-------------------------------------------------- */	
	function fnShowBtnPop(data){
		fnInitBtnPop();
		cmmInfo.setFocusBtn(data);
		if(cmmInfo.getHiddenMode()){			
			var top = ( parseInt($('.pop_wrap_dir').height()) / 2 ) * -1 + 'px';
			var left = ( parseInt($('.pop_wrap_dir').width()) / 2 ) * -1 + 'px';
			$('.pop_wrap_dir').css('margin-top', top);
			$('.pop_wrap_dir').css('margin-left', left);
			$('#btn_nmBasic').attr("readonly",false);
		}
		/* 명칭정보 설정 */
		$('#btn_nmBasic').val(data.nmBasic || '');
		$('#btn_nmKR').val(data.nmKR || '');
		$('#btn_nmEN').val(data.nmEN || '');
		$('#btn_nmCN').val(data.nmCN || '');
		$('#btn_nmJP').val(data.nmJP || '');
		/* 사용자 선택 사이즈 */
		$(".selectmenu").val(data.btnSize);
		/* 개발자 파라미터 */
		$('#dev_callURL').val(data.callURL || '');
		$('#dev_callParam').val(data.callParam || '');
		$('#dev_callbackType').val(data.callbackType || '');
		$('#dev_callbackKey').val(data.callbackKey);
		$('#licenseYN').prop('checked', data.licenseYN == 'Y');
		
		/*팝업 타이틀 설정*/
		$('#txt_popTitle').text(data.nmBasic);
		
		/* 컨트롤 버튼 설정 */
		$('#pop_btnSave').show();
		$('#pop_btnAdd').hide();
		
		$('.btnPopInfo').show();
	}
	/*	[팝업] 버튼설정 팝업 저장
	-------------------------------------------------- */	
	function fnSubmitBtnPop(){
		var btn = cmmInfo.getFocusBtn();
		cmmInfo.removeFocusBtn();
		var data = {
			compSeq : btn.compSeq
			, pageSeq : btn.pageSeq
			, formSeq : btn.formSeq
			, btnSeq : btn.btnSeq
			, position : btn.position
			, displayYN : btn.displayYN
			
			, defaultCode : btn.defaultCode
			
			, nmBasic : $('#btn_nmBasic').val()
			, nmKR : $('#btn_nmKR').val()
			, nmEN : $('#btn_nmEN').val()
			, nmCN : $('#btn_nmCN').val()
			, nmJP : $('#btn_nmJP').val()
			, btnSize : $(".selectmenu").val()
			
			, callURL : $('#dev_callURL').val()
			, callParam : $('#dev_callParam').val()
			, callbackType : $('#dev_callbackType').val()
			, callbackKey : $('#dev_callbackKey').val()
			, licenseYN : $('#licenseYN').prop('checked') ? 'Y' : 'N'
		};
		$.ajax({
			type : "post"
			, async : true
			, url : '<c:url value="/ex/expend/admin/ExAdminSetButtonUpdate.do"></c:url>'
			, datatype : "json"
			, data : data
			, success : function(result) {
				fnInitBtnPop();
				$('.btnPopInfo').hide();
				fnSetViewInfo(data);
			}
			, error : function(e, status) { //error : function(xhr, status, error) {
			}
		});
	}
	/*	[팝업] 버튼설정 신규 생성 
	-------------------------------------------------- */	
	function fnSubmitAddBtnPop(){
		var data = {
			compSeq : 'EXP_BUTTON'
			, pageSeq : $('#hid_pageSeq').val()
			, formSeq : '0'
			, position : $('#hid_positionSeq').val()
			, displayYN : 'N'

			, defaultCode : $('#btn_nmBasic').val()
			, nmBasic : $('#btn_nmBasic').val()
			, nmKR : $('#btn_nmKR').val()
			, nmEN : $('#btn_nmEN').val()
			, nmCN : $('#btn_nmCN').val()
			, nmJP : $('#btn_nmJP').val()
			, btnSize : $(".selectmenu").val()
			
			, callURL : $('#dev_callURL').val()
			, callParam : $('#dev_callParam').val()
			, callbackType : $('#dev_callbackType').val()
			, callbackKey : $('#dev_callbackKey').val()
			, licenseYN : $('#licenseYN').prop('checked') ? 'Y' : 'N'
		};
		$.ajax({
			type : "post"
			, async : true
			, url : '<c:url value="/ex/expend/admin/ExAdminSetButtonCreate.do"></c:url>'
			, datatype : "json"
			, data : data
			, success : function(result) {
				fnInitBtnPop();
				$('.btnPopInfo').hide();
				fnGetBtnSettingInfo($('#hid_formSeq').val());
			}
			, error : function(e, status) { //error : function(xhr, status, error) {
			}
		});
	}
		
	/*	[팝업] 버튼설정 팝업 취소
	-------------------------------------------------- */	
	function fnEndBtnPop(){		
		fnInitBtnPop();
		$('.btnPopInfo').hide();
	}

	/*	[새로고침] 화면 정보 새로고침
	-------------------------------------------------- */
	function fnSetViewInfo(data){
		id = '#p' + data.pageSeq + 'p' + data.position + 's' + data.btnSeq;
		$(id).html( ( data['nm' + '${langCode}'.toUpperCase()] || data.nmBasic ) );
		var btn = cmmInfo.getBtnInfo();
		var temp = btn['page' + data.pageSeq]['position' + data.position]
		
		for(var i =0; i< temp.length ; i++){
			if(temp[i].btnSeq == data.btnSeq){
				btn['page' + data.pageSeq]['position' + data.position][i] = data;
				$('#p' + data.pageSeq + 'p' + data.position + 's' + data.btnSeq).innerWidth(data.btnSize);
				
				break;
			}
		}
		cmmInfo.setBtnInfo(btn);
	}
	
	/*	[버튼] 버튼 클릭 이벤트 바인드
	-------------------------------------------------- */
	function fnSetBtnEvent() {
		/* 저장 버튼 바인드 */
		$('#btn_orderSave').click(function() {
			var data = fnGetServerSideFormat();
			$.ajax({
				type : "post"
				, async : true
				, url : '<c:url value="/ex/expend/admin/ExAdminSetButtonLocationUpdate.do"></c:url>'
				, datatype : "json"
				, data : {
					'param' : JSON.stringify(fnGetServerSideFormat())
				}
				, success : function(result) {
					alert('<%=BizboxAMessage.getMessage("TX000001983","저장이 완료되었습니다.")%>');
				}
				, error : function(e, status) { //error : function(xhr, status, error) {
				}
			});
		});
		
		/* 신규버튼 바인드 */
		$('#btn_devNewElem').click(function() {
			if( $('.button_sel.on').length ){
				fnShowBtnAddPop($('.button_sel.on').attr('page'), $('.button_sel.on').attr('position'));
			}else{
				alert('영역을 선택하세요.');
			}
		});
		
		/* 삭제버튼 바인드 */
		$('#btn_devDeleteElem').click(function() {
			if( $('.dragBtn.on').length ){
				if( $('.dragBtn.on').attr('defaultyn') == 'Y' ){
					alert('기본버튼은 삭제할 수 없습니다.');
					return;
				}
				
				if(confirm('정말삭제 할까요?')){
					$.ajax({
						type : "post"
						, async : true
						, url : '<c:url value="/ex/expend/admin/ExAdminSetButtonDelete.do"></c:url>'
						, datatype : "json"
						, data : {
							'defaultCode' : $('.dragBtn.on').attr('code')
						}
						, success : function(result) {
							fnGetBtnSettingInfo($('#hid_formSeq').val());
							alert('삭제가 완료되었습니다.');
						}
						, error : function(e, status) { //error : function(xhr, status, error) {
						}
					});
				}
			}else{
				alert('버튼을 선택하세요.');
			}
		});
	}

	/*	[포멧] 서버 저장을 위한 데이터 포멧 
	-------------------------------------------------- */
	function fnGetServerSideFormat() {
		var btnInfo = cmmInfo.getBtnInfo();
		if (btnInfo == null) {
			return null;
		}
		var returnList = [];
		for ( var pageKey in btnInfo) {
			var page = btnInfo[pageKey];
			for ( var positionKey in page) {
				returnList = returnList.concat(btnInfo[pageKey][positionKey]);
			}
		}
		return returnList;
	}

	/*	[양식리스트] 양식 리스트 조회
	-------------------------------------------------- */
	function fnSelectFormInfo() {
		$.ajax({
			type : "post",
			async : true,
			url : '<c:url value="/ex/expend/admin/ExAdminGetFormInfoList.do"></c:url>',
			datatype : "json",
			data : {},
			success : function(result) {
				if (result.result.resultCode == 'SUCCESS') {
					fnSetFormListBox(JSON.parse(result.result.aData.formInfo));
				} else {
					alert('<%=BizboxAMessage.getMessage("TX000019404","양식리스트 조회에 실패하였습니다.")%>');
					console.log(result.result.resultName);
				}
			},
			error : function(e, status) { //error : function(xhr, status, error) {
			}
		});
	}

	/*	[양식리스트] 양식 리스트 테이블 출력
	 -------------------------------------------------- */
	function fnSetFormListBox(data) {
		/* 양식 리스트 목록 정의 */
		var formListTag = '';
		for ( var key in data) {
			formListTag += '<tr class="tr_formInfo" formSeq="' + data[key].formSeq + '">';
			formListTag += '	<td>';
			formListTag += '	' + data[key].formName;
			formListTag += '	</td>';
			formListTag += '</tr>';
		}
		$('#tbl_formList').append(formListTag);

		/* table row 이벤트 바인드 */
		$('.tr_formInfo').click(function() { 
			$('#hid_formSeq').val($(this).attr('formSeq'));
			
			/* tr class 처리 */
			$('.tr_formInfo').removeClass('on');
			$(this).addClass('on');

			/* 화면 타이틀 변경 */
			$('#txt_formTitle').text($(this).find('td').html() || '');

			/* 버튼 설정정보 호출 */
			fnGetBtnSettingInfo($(this).attr('formSeq'));
		});

		/* 양식리스트 있으면 최초 정보 조회 */
		if ($('.tr_formInfo').length) {
			$('.tr_formInfo').eq(0).click();
		}
	}

	/*	[버튼설정 리스트] 사용자 버튼설정 정보 가져오기
	 -------------------------------------------------- */
	function fnGetBtnSettingInfo(formSeq) {
		$.ajax({
			type : "post",
			async : true,
			url : '<c:url value="/ex/expend/admin/ExAdminGetButtonInfoList.do"></c:url>',
			datatype : "json",
			data : {
				formSeq : (formSeq || '').toString()
			},
			success : function(result) {
				
				if (result.result.resultCode == 'SUCCESS') {
					var code = 'LSM';
					if(result.formInfo.aData){
						code = result.formInfo.aData.setValue;
					}
					cmmInfo.setOptionCode(code);
					fnSetDivView(code);
					fnSetBtnView(result.result.aData);
					cmmInfo.setBtnInfo(result.result.aData, true);
				} else {
					alert('버튼설정정보 조회에 실패하였습니다.');
					console.log(result.result.resultName);
				}
			},
			error : function(e, status) { //error : function(xhr, status, error) {
			}
		});
	}

	/*	[ 미리보기 뷰 ] 옵션 별 뷰 설정
	 -------------------------------------------------- */
	function fnSetDivView(code){
		if(code.indexOf('L') > -1){
			$('.div_area_L').show();
		}else{
			$('.div_area_L').hide();
		}
		if(code.indexOf('S') > -1){
			$('.div_area_S').show();
		}else{
			$('.div_area_S').hide();
		}
		if(code.indexOf('M') > -1){
			$('.div_area_M').show();
		}else{
			$('.div_area_M').hide();
		}
	}
		
	/*	[ 미리보기 뷰 ] 뷰 설정
	 -------------------------------------------------- */
	function fnSetBtnView(aData) {
		/* 탭 페이지 출력 여부 / 탭이 추가될경우 해당 부분 확인 필요함 */
		for ( var divKey in aData) {
			$('.div_' + divKey).show();
			for ( var positionKey in aData[divKey]) {
				var actionName = 'fnSetView' + divKey + '_' + positionKey;
				window[actionName](aData[divKey][positionKey]);
			}
		}
		/* 더블클릭 이벤트 정의 */
		fnSetBtnDblClickEvent();
		/* 드래그 이벤트 정의 */
		fnSetDnDEnvet();
		/* 클리커블 오브젝트 클릭 이벤트 정의 */
		fnSetBtnClickEvent();
	}
	
	/*	[ 클릭 ] 클릭커블 객체 이벤트 바인드
	 -------------------------------------------------- */
	function fnSetBtnClickEvent(){
		$('.clickable').click(function (){
			$('.clickable').removeClass("on");
			$(this).addClass("on");
			event.stopPropagation();
		});
	}

	/*	[ 더블클릭 ] 더블클릭 이벤트 정의
	 -------------------------------------------------- */
	function fnSetBtnDblClickEvent() {
		$('.dragBtn').dblclick(function() {
			fnShowBtnPop(
				fnGetBtnInfo({
					page : $(this).attr('page').toString(),
					position : $(this).attr('position').toString(),
					btnSeq : $(this).attr('btnSeq').toString()
				})
			);
		});
	}

	/*	[ 더블클릭 ] 더블클릭 이벤트 정의
	 -------------------------------------------------- */
	function fnGetBtnInfo(data) {
		var btns = cmmInfo.getBtnInfo()['page' + data.page]['position'
				+ data.position];
		var btn = {};
		for (var i = 0; i < btns.length; i++) {
			if (btns[i].btnSeq == data.btnSeq) {
				btn = btns[i];
				break;
			}
		}
		btn.coMode = cmmInfo.getHiddenMode();
		return btn;
	}

	/*	[ 드래그앤드롭 ] DnD이벤트 정의
	 -------------------------------------------------- */
	function fnSetDnDEnvet() {
		/* 타이틀 그룹 소터블 */
		$('#div_title_selected>div, #div_title_list>div').sortable({
			cancel : false,
			connectWith : ".connectedSortable10",
		    placeholder: 'sortable-placeholder',
			start: function(event, ui) {
				$('.clickable').removeClass('on');
				$(ui.item).find('button').addClass('on')
				ui.placeholder.html(ui.item.html().replace('style="cursor:move;', 'style="cursor:move;background:firebrick;'));
				ui.placeholder.css({'opacity':'0.3'});
			},
			stop : function(event, ui) {
				var data = {};
				data.page = $(ui.item).find('button').attr('page').toString();
				data.position = $(ui.item).find('button').attr('position').toString();
				data.btnSeq = $(ui.item).find('button').attr('btnSeq').toString();
				$(ui.item).parent('div').hasClass('useBtn') ? fnSetButtonShow(data) : fnSetButtonHide(data);
			}
		});
		/* 항목 그룹 소터블 */
		$('#div_list_selected>div, #div_list_list>div').sortable({
			cancel : false,
			connectWith : ".connectedSortable20",
		    placeholder: 'sortable-placeholder',
			start: function(event, ui) {
				$('.clickable').removeClass('on');
				$(ui.item).find('button').addClass('on')				
				ui.placeholder.html(ui.item.html().replace('style="cursor:move;', 'style="cursor:move;background:cornflowerblue;'));
				ui.placeholder.css({'opacity':'0.3'});
			},
			stop : function(event, ui) {
				var data = {};
				data.page = $(ui.item).find('button').attr('page').toString();
				data.position = $(ui.item).find('button').attr('position').toString();
				data.btnSeq = $(ui.item).find('button').attr('btnSeq').toString();
				$(ui.item).parent('div').hasClass('useBtn') ? fnSetButtonShow(data) : fnSetButtonHide(data);
			}
		});
		/* 분개 그룹 소터블 */
		$('#div_slip_selected>div, #div_slip_list>div').sortable({
			cancel : false,
			connectWith : ".connectedSortable30",
		    placeholder: 'sortable-placeholder',
			start: function(event, ui) {
				$('.clickable').removeClass('on');
				$(ui.item).find('button').addClass('on')				
				ui.placeholder.html(ui.item.html().replace('style="cursor:move;', 'style="cursor:move;background:cornflowerblue;'));
				ui.placeholder.css({'opacity':'0.3'});
			},
			stop : function(event, ui) {
				var data = {};
				data.page = $(ui.item).find('button').attr('page').toString();
				data.position = $(ui.item).find('button').attr('position').toString();
				data.btnSeq = $(ui.item).find('button').attr('btnSeq').toString();
				$(ui.item).parent('div').hasClass('useBtn') ? fnSetButtonShow(data) : fnSetButtonHide(data);
			}
		});
	}

	/*	[ 태그 ] 계산된 버튼 엘리먼트 입력
	 -------------------------------------------------- */
	function fnSetViewpage10_position10(data) {
		/* 뷰 설정 10-10 */
		data = fnGetBtnListFormat(data);
		$('#div_title_selected>div, #div_title_list>div').remove();
		$('#div_title_selected').append(fnGetSelectedTagFormat(data, 10, 10));
		$('#div_title_list').append(fnGetListTagFormat(data, 10, 10));
	}
	function fnSetViewpage10_position20(data) {
		/* 뷰 설정 10-20 */
		data = fnGetBtnListFormat(data);
		$('#div_list_selected>div, #div_list_list>div').remove();
		$('#div_list_selected').append(fnGetSelectedTagFormat(data, 10, 20));
		$('#div_list_list').append(fnGetListTagFormat(data, 10, 20));
	}
	function fnSetViewpage10_position30(data) {
		/* 뷰 설정 10-30 */
		data = fnGetBtnListFormat(data);
		$('#div_slip_selected>div, #div_slip_list>div').remove();
		$('#div_slip_selected').append(fnGetSelectedTagFormat(data, 10, 30));
		$('#div_slip_list').append(fnGetListTagFormat(data, 10, 30));
	}
	function fnSetViewpage10_position40(data) {
		console.log(data);
		/* 뷰 설정 10-40 */
		data = fnGetBtnListFormat(data);
		$('#div_mng_selected>div, #div_mng_list>div').remove();
		$('#div_mng_selected').append(fnGetSelectedTagFormat(data, 10, 40));
		$('#div_mng_list').append(fnGetListTagFormat(data, 10, 40));
	}

	/*	[ 태그 ] 선택된 버튼설정 포멧 변경
	 -------------------------------------------------- */
	function fnGetSelectedTagFormat(data, page, position) {
		var length = data.selected.length, selectedTag = '';
		selectedTag += '<div class="connectedSortable' + position
				+ ' ar useBtn" style="width:100%; min-height:24px; line-height:24px;">';
		for (var i = 0; i < length; i++) {
			var item = data.selected[i];
			selectedTag += '<span>';
			selectedTag += '	<button id="p'+page+'p'+position+'s'+item.btnSeq+'" class="clickable dragBtn" page="'+page+'" position="'+position+'" btnSeq="'+ item.btnSeq +'" code="'+ item.defaultCode +'" order="'+item.orderNum+'" defaultyn="'+item.defaultYN+'"  style="cursor:move;width:'+ item.btnSize +'px;">';
			selectedTag +=	'		'+ ( item['nm' + '${langCode}'.toUpperCase()] || item.nmBasic );
			selectedTag += '	</button>';
			selectedTag += '</span>';
		}
		selectedTag += '</div>';
		return selectedTag;
	}

	/*	[ 태그 ] 미선택 버튼설정 포멧 변경
	 -------------------------------------------------- */
	function fnGetListTagFormat(data, page, position) {
		var length = data.list.length, listTag = '';
		listTag += '<div class="connectedSortable' + position
				+ ' noUseBtn" style="width:100%;float:left;height:90px;">';
		for (var i = 0; i < length; i++) {
			var item = data.list[i];
			
			/* 옵션별 예외처리 */
			if( ( item.defaultCode == 'electronicInvoiceSlip' || item.defaultCode == 'cardUseHistorySlip' )  && cmmInfo.isList()){
				continue;
			}
			listTag += '<span>';
			listTag += '	<button id="p'+page+'p'+position+'s'+item.btnSeq+'" class="clickable dragBtn" page="'+page+'" position="'+position+'" btnSeq="'+ item.btnSeq +'"  code="'+ item.defaultCode +'" order="'+item.orderNum+'" defaultyn="'+item.defaultYN+'" style="cursor:move;width:'+ item.btnSize +'px;">'
			listTag +=	'		'+ ( item['nm' + '${langCode}'.toUpperCase()] || item.nmBasic );
			listTag += '	</button>';
			listTag += '</span>';
		}
		listTag += '</div>';
		return listTag;
	}

	/*	[ 버튼 가져오기 ] 버튼설정 포멧 변경
	 -------------------------------------------------- */
	function fnGetBtnListFormat(data) {
		var returnObj = {
			list : [],
			selected : []
		};
		var length = data.length;
		for (var i = 0; i < length; i++) {
			var item = data[i];

			/* 라이센스가 존재하거나, 개발자 모드일 경우. */
			if (item.licenseYN == 'Y' || cmmInfo.getHiddenMode()) {
				if (item.displayYN == 'Y') {
					returnObj.selected.push(item);
				} else {
					returnObj.list.push(item);
				}
			}
		}
		return returnObj;
	}

	/*	[버튼이동] 버튼 사용안함 처리
	 -------------------------------------------------- */
	function fnSetButtonHide(data) {
		var btns = cmmInfo.getBtnInfo();
		var temp = btns['page' + data.page]['position' + data.position];
		for (var i = 0; i < temp.length; i++) {
			if (temp[i].btnSeq == data.btnSeq) {
				temp[i].displayYN = 'N';
			}
		}
		cmmInfo.setBtnInfo(btns);
	}
	/*	[버튼이동] 버튼 사용함 처리
	 -------------------------------------------------- */
	function fnSetButtonShow(data) {
		var btns = cmmInfo.getBtnInfo();
		var temp = btns['page' + data.page]['position' + data.position];
		for (var i = 0; i < temp.length; i++) {
			if (temp[i].btnSeq == data.btnSeq) {
				temp[i].displayYN = 'Y';
			}
		}
		cmmInfo.setBtnInfo(btns);
	}

	/*	[문서 한글] 문서 미리보기 설정  관리자버튼설정 - key
	 -------------------------------------------------- */
	function fnSetCheatkey() {
		var keySet = [68, 76, 87, 78, 83, 84, 74, 68]
		var keyCnt = 9;
		var comboResult = 0;

		/* 문서 키다운 이벤트 */
		$(document).keydown(function(event) {
			if (event.which == 38 && event.shiftKey) {
				keyCnt = 0;
				comboResult = 0;
				console.log('initialize key code');
			} else if (keyCnt < 9) {
				if (keySet[keyCnt] == event.which) {
					comboResult++;
				}
				keyCnt++;

				if (keyCnt == 8 && comboResult == 8) {
					fnShowDeveloperMode();
				}
			}
		});
	}

	/*	[문서 한글] 한글 사용 지원
	 -------------------------------------------------- */
	function fnShowDeveloperMode() {
		$('.coMode').show();
		cmmInfo.setHiddenMode();
		fnSetBtnView(cmmInfo.getBtnInfo());
	}

	/*	[버튼 아이디] 버튼 순서에 따른 아이디
	 -------------------------------------------------- */
	function fnGetBtnIdList(selector) {
		var data = [];
		$(selector).each(function() {
			data.push($(this).attr('btnSeq').toString());
		});
		return data;
	}
	function fnGetBtnIdObject() {
		var data = {};
		data.page10 = {};
		data.page10.position10 = fnGetBtnIdList('.connectedSortable10 button');
		data.page10.position20 = fnGetBtnIdList('.connectedSortable20 button');
		data.page10.position30 = fnGetBtnIdList('.connectedSortable30 button');
		data.page10.position40 = fnGetBtnIdList('.connectedSortable40 button');
		return data;
	}

	/*	[오브젝트] 사용지원 오브젝트
	 -------------------------------------------------- */
	function fnGetDataObject() {
		var hiddenMode = false;
		var btnInfo = null;
		var focusBtn = null;
		var isList = false;
		return {
			setOptionCode : function(code){
				isList = code.indexOf('L') > -1;
			},
			isList : function(){
				return isList;
			},
			getFocusBtn : function(){
				return focusBtn;
			},
			setFocusBtn : function(data){
				focusBtn = data;
			},
			removeFocusBtn : function(){
				focusBtn = null;
			},
			getHiddenMode : function() {
				return hiddenMode;
			},
			getBtnInfo : function() {
				return btnInfo;
			},
			setHiddenMode : function() {
				hiddenMode = true;
			},
			setBtnInfo : function(data, dataRefresh) {
				if(dataRefresh){
					btnInfo = data;
				}else{
					var reorderData = cmmInfo.updateBtnInfo(data);
					btnInfo = reorderData == null ? data : reorderData;
				}
			},
			updateBtnInfo : function(data) {
				if (btnInfo == null) {
					return null;
				}
				var idObject = fnGetBtnIdObject();
				var reorderedBtnInfo = btnInfo;

				/* 버튼 움직임에 따른 데이터 리오더 */
				for ( var pageKey in idObject) {
					var page = idObject[pageKey];
					for ( var positionKey in page) {
						var ids = page[positionKey];

						var btnList = btnInfo[pageKey][positionKey]
						reorderedBtnInfo[pageKey][positionKey] = [];
						for (var i = 0; i < ids.length; i++) {
							for (var k = 0; k < btnList.length; k++) {
								var btn = btnList[k];
								if (btn.btnSeq == ids[i]) {
									btn.orderNum = i;
									reorderedBtnInfo[pageKey][positionKey]
											.push(btn);
								}
							}
						}
					}
				}
				return reorderedBtnInfo;
			}
		};
	}
</script>


