<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<div class="modal" style="display:none;z-index: 103;" id="PLP_divModal"></div>
<div id="PLP_divMainProgPop" class="resources_reservation_wrap Pop_border" style="width:443px;display:none;left: 50%;top: 50%;margin: -105px 0 0 -222px;z-index: 104; position:fixed;">
	<div class="pop_head">
		<h1 id="PLP_textTitle"></h1>
		<a href="#n" class="clo">
			<img onClick="PLP_fnCloseProgressDialog();" id="PLP_btnPopClose" src="/exp/Images/btn/btn_pop_clo02.png" value="" alt="" />
		</a>
	</div><!-- //pop_head -->
	
	<div class="pop_con">
		<p class="gle" id="PLP_mainText"></p>
		<div class="gra_set">
			<p class="gra_txt"><span id="PLP_txtProgValue">0%</span></p>
			<div class="gra_bg" id="PLP_graProgValueParent">
				<span class="bar" id="PLP_graProgValue" style="width:0%"></span>
			</div>
			<div class="gle_list"><%=BizboxAMessage.getMessage("TX000018781","총")%> <span class="colB" id="PLP_txtFullCnt">0</span><%=BizboxAMessage.getMessage("TX000000476","건")%> (<%=BizboxAMessage.getMessage("TX000006510", "실패")%> <span class="text_red fwb" id="PLP_txtErrorCnt">0</span><%=BizboxAMessage.getMessage("TX000000476","건")%>)</div>
			<div id="list_send_cancle" style="color:#666;margin-top:10px; display:none;">지출결의에 입력한 항목수에 따라 결재문서 건당 </br> 최대 3분정도의 전송 처리시간이 소요될 수 있습니다.</div>					
		</div>			
	</div><!-- //pop_con -->
	<div class="pop_foot" style="" id="PLP_divAdvArea">
		<div class="btn_cen pt12">
			<input class="blue_btn  PLP_advBtn" value="<%=BizboxAMessage.getMessage("TX000000078","확인")%>" type="button" id="PLP_btnConfirm" onClick="PLP_fnCloseProgressDialog();">
			<input class="red_btn PLP_advBtn" value="<%=BizboxAMessage.getMessage("TX000018782","실패 사유보기")%>" type="button" id="PLP_btnShowPop">
		</div>
	</div><!-- //pop_foot -->
</div><!-- //pop_wrap -->

<script>

	/* main data info exsample */
	/* main data 정보 변경시 아래에 추가 바랍니다.
	var dataInfo = {
		title : '메인 타이틀'	
		, progText : '전표 전송을 진행중입니다.'
		, endText : '전표 전송이 완료되었습니다.'
	};
	----------------------------------------------------------- */

	/* 공용변수 영역 */
	var plp_progressing = false;		// 업무가 진행중 여부 판단 플래그
	var plp_storedValue  = 0; 			// 프로그레스 밸류 기록 변수 
	var plp_mainData;
	var plp_errCnt = 0;
	var plp_errInfo = [];
	var plp_popupData = {};
	/* 다이얼로그 준비 
	----------------------------------------*/
	$(document).ready(function(){
		console.log('setting progress layer ...');
		PLP_fnInitPop();
		$('#PLP_divMainProgPop').addClass('pop_wrap_dir');
		
		//실패사유 보기
		$('#PLP_btnShowPop').unbind().click(function(e){
			PLP_fnShowFailReasonPop();
		});
	});

	/* [ 초기화 ] 팝업 데이터 초기화 
	----------------------------------------*/
	function PLP_fnInitPop() {
		
		// 모달 영역 감추기.
		$('#PLP_divModal').hide();
		$('#PLP_divMainProgPop').hide();
		// 확장 영역 감추기
		$('#PLP_divAdvArea').hide();
		// 닫기 버튼 감추기
		$('#PLP_btnPopClose').hide();
		// 전송 전송 취소 
		// $('#list_send_cancle').hide();
		
		plp_errInfo = [];
		plp_progressing = false;		
		plp_storedValue  = 0; 			 
		plp_mainData = null;
		plp_errCnt = 0;
		
		$( "#PLP_graProgValue" ).animate({ width : parseInt(0) + 'px' }, 1);
		$('#PLP_txtProgValue').text( '0%');
		$('#PLP_txtFullCnt').text('0');
		$('#PLP_txtErrorCnt').text('0');
		
	}
	
	/* [ 제공함수 ] 서버 연산중인지 확인 
	----------------------------------------*/
	function PLP_fnIsGetProgressing(){
		return plp_progressing;
	}
	
	/* [ 시작 ] 프로그레스 팝업 시작 
	----------------------------------------*/
	function PLP_fnShowProgressDialog(data) {
		if(!data){
			alert("<%=BizboxAMessage.getMessage("TX000018783","프로그레스 팝업 메인정보가 설정되지 않았습니다.")%>");
			return;
		} 
		if (plp_progressing) {
			console.log('ProgressLayerPop.jsp >> ajax Communication work in progress..');
			return;
		}
		
		/* 팝업창 초기화 */
		PLP_fnInitPop();
		
		/* 기본 메인 데이터 설정 */
		plp_mainData = data;
		$('#PLP_textTitle').html(plp_mainData.title);
		$('#PLP_mainText').html(plp_mainData.progText);
		
		progressing = true;
		$('#PLP_divModal').show();
		$('#PLP_divMainProgPop').show();
		$('#viewLoading').hide();
		
		plp_popupData.pageTitle = data.popupPageTitle;
		plp_popupData.colGbn = data.popupColGbn;
		plp_popupData.colDetail = data.popupColDetail;
	}
	
	/* [ 종료 ] 프로그레스 업무 종료
	----------------------------------------*/	
	function PLP_fnEndProgressDialog() {
		$('#viewLoading').hide();
		// TODO : 사유보기 팝업창 출력 준비
		PLP_fnSetProgressStatus(plp_mainData.endText);
		
		// 닫기 버튼 출력
		$('#PLP_btnPopClose').show();
		
		if(plp_errInfo.length){
			$('.PLP_advBtn').hide();
			$('#PLP_btnShowPop').show();
			$('#PLP_divAdvArea').show();
		}else{
			$('.PLP_advBtn').hide();
			$('#PLP_btnConfirm').show();
			$('#PLP_divAdvArea').show();
		}
	}
	
	/* [ 닫기 ] 프로그레스 팝업 닫기
	----------------------------------------*/	
	function PLP_fnCloseProgressDialog() {
		progressing = false;
		PLP_fnInitPop();
		$('#PLP_divModal').hide();
		$('#PLP_divMainProgPop').hide();
	}
	
	/* [ 출력 ] 프로그레스 상태 출력
	----------------------------------------*/
	function PLP_fnSetProgressStatus(text) {
		$('#PLP_mainText').html(text);
	}
	
	/* [ 출력 ] 프로그레스 밸류 설정
	----------------------------------------*/
	function PLP_fnSetProgressValue(value, idx, length, isError) {
		$('#viewLoading').hide();
		var w = ( $('#PLP_graProgValueParent').width() / 100 ) * parseInt(value) ;
		$( "#PLP_graProgValue" ).animate({ width : parseInt(w) + 'px' }, 200);
		
		$({someValue: plp_storedValue}).animate({someValue: value}, {
		    duration: 400,
		    easing:'swing', 
		    step: function() { 
		    	$('#viewLoading').hide();
		    	$('#PLP_txtProgValue').text( parseInt( this.someValue + 0.5 ) + '%');
		    },
		    complete: function(){
		    	
		    	$('#PLP_txtProgValue').text( parseInt( value + 0.5 ) + '%');
		     }
		});
		
		plp_storedValue = value		
		
		/* 총 작업 분량 출력 */
		if(isError){
			plp_errCnt++;
		}
		$('#PLP_txtFullCnt').text(length);
		$('#PLP_txtErrorCnt').text(plp_errCnt);
	}
	
	/* [ 출력 ] 에러정보 기록
	----------------------------------------*/
	function PLP_fnSetErrInfo(data){
		plp_errInfo.push({
			colGbn : data.colGbn
			, colDetail : data.colDetail
		});
	}
	
	//실패사유 보기 팝업창 호출
	function PLP_fnShowFailReasonPop(){
		
		$('#hid_progLpop_pageTitle').val(plp_popupData.pageTitle);
		$('#hid_progLpop_colGbn').val(plp_popupData.colGbn);
		$('#hid_progLpop_colDetail').val(plp_popupData.colDetail);
		$('#hid_progLpop_colData').val(JSON.stringify(plp_errInfo));
		
		var popWidth = 600;
		var popHeight = 420;
		if(typeof InstallTrigger !== 'undefined'){	// firefox
			popWidth = 600;
			popHeight = 423;
		}if(false || !!document.documentMode){	//IE
			popWidth = 600;
			popHeight = 370;
		}if(!(false || !!document.documentMode) && !!window.StyleMedia){ //EDGE
			popWidth = 600;
			popHeight = 419;
		}if(!!window.chrome && !!window.chrome.webstore){ //chrome
			popWidth = 600;
			popHeight = 370;
		}
		var screenLeft=0, screenTop=0;
		var defaultParams = { };
		
	    if(typeof window.screenLeft !== 'undefined') {
	        screenLeft = window.screenLeft;
	        screenTop = window.screenTop;
	    } else if(typeof window.screenX !== 'undefined') {
	        screenLeft = window.screenX;
	        screenTop = window.screenY;
	    }
	    
	    var features_dict = {
            toolbar: 'no',
            location: 'no',
            directories: 'no',
            left: screenLeft + ($(window).width() - popWidth) / 2,
            top: screenTop + ($(window).height() - popHeight) / 2,
            status: 'no',
            menubar: 'no',
            scrollbars: 'no',
            resizable: 'no',
            width: popWidth,
            height: popHeight
        };
	    
        features_arr = [];
        for(var k in features_dict) {
            features_arr.push(k+'='+features_dict[k]);
        }
        features_str = features_arr.join(',');
	    
        var myForm = document.popForm;
        var url = "<c:url value="/ex/expend/common/ProcessFailPop.do" />";
        var win =  window.open("" ,"popForm", features_str); 
        myForm.action =url; 
        myForm.method="post";
        myForm.target="popForm";
        myForm.testVal = 'test';
      	myForm.submit();
      	win.focus();

      	PLP_fnInitPop();
		$('#PLP_btnPopClose').click();
	}
</script>

<form name="popForm">
	<input type="hidden" name="pageTitle" value="" id="hid_progLpop_pageTitle" />
	<input type="hidden" name="colGbn" value="" id="hid_progLpop_colGbn" />
	<input type="hidden" name="colDetail" value="" id="hid_progLpop_colDetail" />
    <input type="hidden" name="colData" value="" id="hid_progLpop_colData" />
</form>