<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="main.web.BizboxAMessage"%>
<style type="text/css">
input:focus {
	background-color: #ccffff;
}
</style>
<script type="text/javascript">
	/* ################################################## */
	/* #. var */
	/* ################################################## */
	/* ################################################## */
	/* #. document reayd */
	/* ################################################## */
	/* #. document ready */
	$ ( document ).ready ( function ( ) {
		fnInit ( );
		fnInitEvent ( );
		return;
	} );
	/* ################################################## */
	/* #. fnInit */
	/* ################################################## */
	/* #. fninit */
	function fnInit ( ) {
		fnInitPopSize ( );
		fnInitLayout ( );
		fnInitInput ( );
		return;
	};
	/* #. fninit - fnInitPopSize */
	function fnInitPopSize ( ) {
		var thisX = parseInt ( document.body.scrollWidth );
		var thisY = parseInt ( document.body.scrollHeight );
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 50;
		var marginY = 0;

		if ( maxThisX > 1017 ) {
			maxThisX = 1017;
		}
		/* #. 브라우저별 높이 조절. ( 표준 창 하에서 조절해 주십시오. ) */
		if ( navigator.userAgent.indexOf ( "MSIE 6" ) > 0 ) marginY = 45; /* IE 6.x */
		else if ( navigator.userAgent.indexOf ( "MSIE 7" ) > 0 ) marginY = 75; /* IE 7.x */
		else if ( navigator.userAgent.indexOf ( "Firefox" ) > 0 ) marginY = 50; /* FF */
		else if ( navigator.userAgent.indexOf ( "Opera" ) > 0 ) marginY = 30; /* Opera */
		else if ( navigator.userAgent.indexOf ( "Netscape" ) > 0 ) marginY = -2; /* Netscape */
		if ( thisX > maxThisX ) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}
		if ( thisY > maxThisY - marginY ) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}

		if ( maxThisY > 874 ) {
			maxThisY = 874;
		}

		/* #. 센터정렬 */
		var windowX = ( screen.width - ( maxThisX + 10 ) ) / 2;
		var windowY = ( screen.height - ( maxThisY ) ) / 2 - 20;
		window.moveTo ( windowX, windowY );
		window.resizeTo ( maxThisX, maxThisY );
		$ ( '.pop_sign_wrap' ).css ( 'height', ( maxThisY - 68 ) );
		return;
	};
	/* #. fninit - fnInitLayout */
	function fnInitLayout ( ) {
		/* 양식정보 바인딩 */
		fnGetFormInfo ( );
		/* 사용자정보 바인딩 */
		fnGetErpEmpInfo ( );
		return;
	};
	/* #. fninit - fnInitInput */
	function fnInitInput ( ) {
		/* Input Readonly 설정 */
		/* Input Datepicker 설정 */
		var gisuDate = $ ( '#txtGisuDate' );
		gisuDate.kendoDatePicker ( {
			culture: "ko-KR",
			format: "yyyy-MM-dd",
			change: function ( ) {
			}
		} );
		gisuDate.kendoMaskedTextBox ( {
			mask: '0000-00-00'
		} );
		gisuDate.closest ( ".k-datepicker" ).add ( gisuDate ).removeClass ( 'k-textbox' );
		/* Input Combobox 설정 */
		var docuList = NeosCodeUtil.getCodeList ( "G20201" );
		$ ( "#selectDocu" ).kendoComboBox ( {
			dataSource: docuList,
			dataTextField: "CODE_NM",
			dataValueField: "CODE",
			index: 0,
			change: function ( e ) {
				console.log ( this.value ( ) ); /* docu_fg */
				console.log ( this.text ( ) ); /* docu_fg_text */
				/* fnTradeTableSet(); */
				/* abdocu.BudgetInfo.remove(); */
			}
		} );
		return;
	};
	/* ################################################## */
	/* #. fnInitEvent */
	/* ################################################## */
	/* #. fnInitEvent */
	function fnInitEvent ( ) {
		fnInitEventButton ( );
		fnInitEventInput ( );
		return;
	};
	/* #. fnInitEvent - fnInitEventButton */
	function fnInitEventButton ( ) {
		/* 결의구분 / 프로젝트(부서) / 입출금계좌 / 적요 >> 저장 */
		return;
	};
	/* #. fnInitEvent - fnInitEventInput */
	function fnInitEventInput ( ) {
		/* 결의일자 */
		$ ( '#txtGisuDate' ).keyup ( function ( event ) {
			if ( event.keyCode == 113 ) { /* F2 */
				$ ( this ).next ( 'span' ).click ( );
				return false;
			} else if ( event.keyCode == 13 ) {
				var dateVal = $ ( this ).val ( ).toString ( ).replace ( /_/g, '' );
				if ( dateVal.length == 10 ) {
					$ ( "#selectDocu" ).data ( "kendoComboBox" ).input.focus ( );
				}
			}
		} );
		/* 프로젝트(부서) */
		$ ( '#txtProjectName' ).keyup ( function ( event ) {
			if ( event.keyCode == 113 ) { /* F2 */
				console.log ( '프로젝트 선택팝업 콜' );
				var params = {};
				params.type = 'project';
				popup ( params );
				return false;
			}
		} );
		/* 입출금계좌 */
		$ ( '#txtBankTrade' ).keyup ( function ( event ) {
			if ( event.keyCode == 113 ) { /* F2 */
				console.log ( '입출금계좌 선택팝업 콜' );
				return false;
			}
		} );
		/* 적요 */
		return;
	};
	/* ################################################## */
	/* #. get code || info */
	/* ################################################## */
	/* #. 양식정보 조회 */
	function fnGetFormInfo ( ) {
		var params = {};
		params.url = "/Ac/G20/Ex/AcExFormInfo.do";
		params.async = false;
		params.parameter = {};
		params.parameter.formSeq = '${ViewBag.formSeq}';
		var result = ajax ( params );
		if ( typeof result.aData != 'undefined' ) {
			/* 양식정보 */
			var formInfo = result.aData;
			/* 양식정보 표현 */
			if ( typeof formInfo.formName != 'undefined' ) {
				$ ( '.hFormName' ).html ( formInfo.formName || '' );
			}
		}
		return;
	};
	/* #. 사용자 정보 조회 ( ERP 기준 ) */
	function fnGetErpEmpInfo ( ) {
		var params = {};
		params.url = "/Ac/G20/Ex/AcExErpEmpInfo.do";
		params.async = false;
		params.parameter = {};
		var result = ajax ( params );
		if ( typeof result.aData != 'undefined' ) {
			/* 사용자정보 */
			empInfo = result.aData;
			/* 회사 표현 */
			if ( typeof empInfo.erpCompSeq != 'undefined' ) {
				var erpCompInfo = '[ ' + ( empInfo.erpCompSeq || '' ) + ' ] ' + ( empInfo.erpCompName || '' );
				$ ( '#hErpCompInfo' ).html ( erpCompInfo );
			}
			/* 예산회계단위 ( 사업장 ) 표현 */
			if ( typeof empInfo.erpBizSeq != 'undefined' ) {
				$ ( '#txtBizName' ).val ( empInfo.erpBizName || '' );
				$ ( '#txtBizName' ).attr ( 'code', empInfo.erpBizName || '' );
			}
			/* 결의부서 표현 */
			if ( typeof empInfo.erpDeptSeq != 'undefined' ) {
				$ ( '#txtDeptName' ).val ( empInfo.erpDeptName || '' );
				$ ( '#txtDeptName' ).attr ( 'code', empInfo.erpBizCode || '' );
			}
			/* 작성자 표현 */
			if ( typeof empInfo.erpEmpSeq != 'undefined' ) {
				$ ( '#txtEmpName' ).val ( empInfo.erpEmpName || '' );
				$ ( '#txtEmpName' ).attr ( 'code', empInfo.erpBizCode || '' );
			}
		} else {
			alert ( '사원정보 ERP 연동이 정상적으로 이루어지지 않았습니다.\r\n메시지가 지속적으로 나타나면 관리자에게 문의 바랍니다.' );
			/* self.close(); */
		}
		return;
	};
	/* #. 공통코드 조회 */
	function fnGetCommonCodeInfo ( ) {
		var params = {};
		params.url = "";
		params.async = false;
		params.parameter = {};
		var result = ajax ( params );
		return;
	};
	/* ################################################## */
	/* #. set code || info */
	/* ################################################## */
	/* ################################################## */
	/* #. function */
	/* ################################################## */
	function ajax ( params ) {
		try {
			var result = JSON.parse ( $.ajax ( {
				type: 'post',
				url: _g_contextPath_ + ( params.url || '' ),
				datatype: 'json',
				async: params.async,
				data: params.parameter
			} ).responseText ).result;

			return result;
		} catch ( e ) {
		}
	};

	function popup ( params ) {
		var getParam = '';

		Object.keys ( params ).forEach ( function ( key ) {
			if ( getParam == '' ) {
				getParam = getParam + '?' + key + '=' + params [ key ];
			} else {
				getParam = getParam + '&' + key + '=' + params [ key ];
			}
		} );

		var popUrl = _g_contextPath_ + "/ex/expend/user/ExUserCodePop.do" + getParam;
		var popOption = "width=300, height=300, resizable=yes, scrollbars=yes, status=no;"; /* 팝업창 옵션(optoin) */
		window.open ( popUrl, "", popOption );
	}
</script>

<div class="pop_sign_wrap" style="width: 999px;">
	<div class="pop_sign_head">
		<h1>
			<span class="hFormName"><%=BizboxAMessage.getMessage( "TX000002958", "결의서" )%></span>
			<%=BizboxAMessage.getMessage( "TX000006808", "작성" )%></h1>
		<div class="psh_btnbox">
			<!-- 양식팝업 오른쪽 버튼그룹 -->
			<div class="psh_right">
				<div class="btn_cen mt8">
					<input type="button" class="psh_btn" id="btnReset" value="<%=BizboxAMessage.getMessage( "TX000002960", "초기화" )%>" /> <input type="button" class="psh_btn" id="btnReferConfer" value="<%=BizboxAMessage.getMessage( "TX000005358", "참조품의 가져오기" )%>" /> <input type="button" class="psh_btn" id="btnApprovalOpen" value="<%=BizboxAMessage.getMessage( "TX000003154", "결재작성" )%>" />
				</div>
			</div>
		</div>
	</div>
	<div class="pop_sign_con scroll_on" style="padding: 62px 16px 20px 16px;">
		<div class="h2_btn3">
			<h2 id="hErpCompInfo"></h2>
			<%--             <h2>${C_TINAME }  <input id="spanCompany" style="width:197px;" /> --%>
			<!--             </h2> -->
		</div>

		<div class="top_box mt15" style="overflow: hidden;" id="erpUserInfo">
			<div id="erpUserInfo-table">
				<dl class="dl2">
					<dt><%=BizboxAMessage.getMessage( "TX000009913", "예산회계단위" )%></dt>
					<dd>
						<input type="text" style="width: 150px;" id="txtBizName" readonly="readonly" disabled="disabled" class="requirement" tabindex="101" /> <input type="button" value="<%=BizboxAMessage.getMessage( "TX000001289", "검색" )%>" class="search-Event-H" />
					</dd>
				</dl>
				<dl class="dl2">
					<dt><%=BizboxAMessage.getMessage( "TX000009435", "결의/부서작성자" )%></dt>
					<dd>
						<input type="text" style="width: 150px;" id="txtDeptName" readonly="readonly" disabled="disabled" class="requirement" tabindex="102" /> <input type="text" style="width: 80px;" id="txtEmpName" readonly="readonly" disabled="disabled" class="requirement"> <input type="button" value="<%=BizboxAMessage.getMessage( "TX000001289", "검색" )%>" class="search-Event-H" />
					</dd>
				</dl>
				<dl class="dl2">
					<dt><%=BizboxAMessage.getMessage( "TX000009894", "결의 일자" )%></dt>
					<dd>
						<input style="width: 119px;" id="txtGisuDate" class="non-requirement" tabindex="103" part="user" />
					</dd>
				</dl>

			</div>
			<input type="hidden" id="erpGisu" /> <input type="hidden" id="erpGisuFromDt" /> <input type="hidden" id="erpGisuToDt" />
		</div>

		<div class="com_ta2 hover_no mt15" id="erpProjectInfo">

			<table border="0" id="erpProjectInfo-table">
				<thead>
					<tr>
						<th><%=BizboxAMessage.getMessage( "TX000003616", "결의구분" )%></th>
						<th><spna id="PjtTypeText"><%=BizboxAMessage.getMessage( "TX000000519", "프로젝트" )%></spna></th>
						<th style="display: none;" class="BottomTd"><%=BizboxAMessage.getMessage( "TX000005362", "하위사업" )%></th>
						<th><%=BizboxAMessage.getMessage( "TX000003617", "입출금계좌" )%></th>
						<th><%=BizboxAMessage.getMessage( "TX000000604", "적요" )%></th>
						<th width="70"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" style="width: 87%;" id="selectDocu" tabindex="201" class="non-requirement" /></td>
						<td><a href="#n" class="search-Event-H"><img src="<c:url value='/Images/ico/ico_explain.png'/>" alt="" /></a> <input type="text" style="width: 85%;" id="txtProjectName" readonly="readonly" class="requirement" tabindex="202" /> <input type="hidden" id="txt_IT_BUSINESSLINK" /> <input type="hidden" id="temp_PjtCd" /></td>
						<td style="display: none;" class="BottomTd"><a href="#n" class="search-Event-H"><img src="<c:url value='/Images/ico/ico_explain.png'/>" alt="" /></a> <input type="text" style="width: 85%;" class="" id="txtBottom_cd" tabindex="203" /></td>
						<td><a href="#n" class="search-Event-H"><img src="<c:url value='/Images/ico/ico_explain.png'/>" alt="" /></a> <input type="text" style="width: 85%;" id="txtBankTrade" class="non-requirement" tabindex="204" /> <input type="hidden" id="txt_BankTrade_NB" /></td>
						<td><input type="text" style="width: 87%;" id="txt_Memo" class="requirement" CODE="empty" tabindex="205" part="project" /></td>
						<td>
							<div class="controll_btn ac" style="padding: 0px;">
								<button type="button" id="" class="erpsave"><%=BizboxAMessage.getMessage( "TX000001256", "저장" )%></button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>


			<input type="hidden" id="txt_GisuDt" class="non-requirement" />
		</div>

		<!-- 		원인행위 사용여부에 따라  -->
		<div class="top_box mt15 dtmr5" style="overflow: hidden; display: none;" id="causeForm">
			<dl class="dl2">
				<dt><%=BizboxAMessage.getMessage( "TX000009893", "원인행위" )%></dt>
				<dd class="mr0">
					<input style="width: 100px;" id="CAUSE_DT" value="" class="requirement dateInput" tabindex="301" />
				</dd>
			</dl>
			<dl class="dl2">
				<dt><%=BizboxAMessage.getMessage( "TX000004254", "계약일" )%></dt>
				<dd class="mr0">
					<input style="width: 100px;" id="SIGN_DT" value="" class="dateInput" tabindex="302" />
				</dd>
			</dl>
			<dl class="dl2">
				<dt><%=BizboxAMessage.getMessage( "TX000005410", "검수일" )%></dt>
				<dd class="mr0">
					<input style="width: 100px;" id="INSPECT_DT" value="" class="dateInput" tabindex="303" />
				</dd>
			</dl>
			<dl class="dl2">
				<dt><%=BizboxAMessage.getMessage( "TX000009892", "원인행위자" )%></dt>
				<dd>
					<input type="text" style="width: 67px;" id="CAUSE_ID" value="" class="requirement" tabindex="304" />
				</dd>
				<dd>
					<input type="text" style="width: 100px" id="CAUSE_NM" value="" disabled="disabled" class="requirement" part="cause" />
				</dd>
				<dd>
					<input type="button" id="search-Event-T-emp" value="검색" class="search-Event-H" />
				</dd>
				<dd>
					<div class="controll_btn ac p0">
						<button type="button" id="btnSave"><%=BizboxAMessage.getMessage( "TX000001256", "저장" )%></button>
						<button type="button" id="btnReset"><%=BizboxAMessage.getMessage( "TX000002960", "초기화" )%></button>
					</div>
				</dd>
			</dl>
		</div>
		<div id="budgetInfo">
			<div class="com_ta2 hover_no mt15">
				<table>
					<tbody>
						<tr>
							<th><%=BizboxAMessage.getMessage( "TX000003625", "관" )%></th>
							<td id="td_veiw_BGT01_NM"></td>
							<th><%=BizboxAMessage.getMessage( "TX000003626", "항" )%></th>
							<td id="td_veiw_BGT02_NM"></td>
							<th><%=BizboxAMessage.getMessage( "TX000003627", "목" )%></th>
							<td id="td_veiw_BGT03_NM"></td>
							<th><%=BizboxAMessage.getMessage( "TX000003628", "세" )%></th>
							<td id="td_veiw_BGT04_NM"></td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="com_ta2 hover_no mt5">
				<table id="budgetInfoAm">
					<tbody>
						<tr>
							<th><%=BizboxAMessage.getMessage( "TX000003618", "예산액" )%></th>
							<td id="td_veiw_OPEN_AM"></td>
							<th><%=BizboxAMessage.getMessage( "TX000011177", "배정액" )%></th>
							<td id="td_veiw_ACCEPT_AM"></td>
							<th><%=BizboxAMessage.getMessage( "TX000005056", "집행액" )%></th>
							<td id="td_veiw_APPLY_AM"></td>
							<th><%=BizboxAMessage.getMessage( "TX000009911", "품의액" )%></th>
							<td id="td_veiw_REFER_AM"></td>
							<th><%=BizboxAMessage.getMessage( "TX000005686", "예산잔액" )%></th>
							<td id="td_veiw_LEFT_AM"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="com_ta2 mt15">
			<table id="erpBudgetInfo">
				<thead>
					<tr>
						<th width="170"><%=BizboxAMessage.getMessage( "TX000003622", "예산과목" )%></th>
						<th width="80"><%=BizboxAMessage.getMessage( "TX000011180", "결제수단" )%></th>
						<th width="80"><%=BizboxAMessage.getMessage( "TX000003635", "과세구분" )%></th>
						<th width=""><%=BizboxAMessage.getMessage( "TX000004257", "채주유형" )%></th>
						<th width="170"><%=BizboxAMessage.getMessage( "TX000005318", "예산사업장" )%></th>
						<th width=""><%=BizboxAMessage.getMessage( "TX000009910", "문광부사용방법" )%></th>
						<th width=""><%=BizboxAMessage.getMessage( "TX000000644", "비고" )%></th>
						<th width="130"><%=BizboxAMessage.getMessage( "TX000000552", "금액" )%></th>
						<th width="148"></th>
					</tr>
				</thead>
			</table>

			<div class="com_ta2 ova_sc cursor_p" style="overflow-y: scroll; height: 148px;">
				<table id="erpBudgetInfo-table">
					<tbody>
					</tbody>
				</table>
			</div>
		</div>

		<table id="erpBudgetInfo-tablesample" style="display: none">
			<tr class="">
				<td width="170" id="budget-td"><a href="#n" class="search-Event-B"><img src="<c:url value='/Images/ico/ico_explain.png' />" alt="" /></a> <input type="text" style="width: 78%;" id="txt_BUDGET_LIST" class="requirement" tabindex="10001" readonly="readonly" /> <input type="hidden" class="non-requirement" id="BGT01_NM" /> <input type="hidden" class="non-requirement" id="BGT02_NM" /> <input type="hidden" class="non-requirement" id="BGT03_NM" /> <input type="hidden" class="non-requirement" id="BGT04_NM" /> <input type="hidden" class="non-requirement" id="ACCT_AM" /> <input type="hidden" class="non-requirement" id="DELAY_AM" /> <input type="hidden" class="non-requirement" id="APPLY_AM" /> <input type="hidden" class="non-requirement" id="LEFT_AM" /> <input type="hidden" class="non-requirement" id="CTL_FG" /> <input type="hidden" class="non-requirement" id="LEVEL01_NM" /> <input type="hidden" class="non-requirement" id="LEVEL02_NM" /> <input type="hidden"
					class="non-requirement" id="LEVEL03_NM"
				/> <input type="hidden" class="non-requirement" id="LEVEL04_NM" /> <input type="hidden" class="non-requirement" id="LEVEL05_NM" /> <input type="hidden" class="non-requirement" id="LEVEL06_NM" /> <input type="hidden" class="non-requirement" id="IT_SBGTCDLINK" /></td>
				<td width="80"><input style="width: 95%;" id="selectSet_Fg" tabindex="10002" class="non-requirement" /><input type="hidden" class="non-requirement" id="tempSet_Fg" value="1" /></td>
				<td width="80"><input style="width: 95%;" id="selectVat_Fg" tabindex="10003" class="non-requirement" /><input type="hidden" class="non-requirement" id="tempVat_Fg" value="1" /></td>
				<td width=""><input style="width: 95%;" id="selectTr_Fg" tabindex="10004" class="non-requirement" /><input type="hidden" class="non-requirement" id="tempTr_Fg" value="1" /></td>
				<td width="170"><a href="#n" class="search-Event-B"><img src="<c:url value='/Images/ico/ico_explain.png' />" alt="" /></a> <input type="text" style="width: 78%;" id="txt_BUDGET_DIV_NM" class="requirement" tabindex="10005" readonly="readonly" /></td>
				<td width=""><select style="width: 65px;" id="selectIT_USE_WAY" tabindex="10007" class="non-requirement">
						<option value="01"><%=BizboxAMessage.getMessage( "TX000009432", "계좌이체" )%></option>
						<option value="02"><%=BizboxAMessage.getMessage( "TX000004704", "현금" )%></option>
						<option value="03"><%=BizboxAMessage.getMessage( "TX000003254", "법인카드" )%></option>
						<option value=""></option>
				</select></td>
				<td width=""><input type="text" style="width: 82%;" id="RMK_DC" CODE="empty" tabindex="10006" class="non-requirement" part="budget" /></td>
				<td width="130"><span id="totalAM" class="totalAM"></span></td>
				<td width="130">
					<div class="controll_btn ac p0">
						<button type="button" class="erpsave"><%=BizboxAMessage.getMessage( "TX000001256", "저장" )%></button>
						<button type="button" class="btndeleteRow"><%=BizboxAMessage.getMessage( "TX000000424", "삭제" )%></button>
					</div>
				</td>
			</tr>
		</table>

		<table id="erpBudgetInfo-tablesample-empty" style="display: none">
			<tr class="blank">
				<td width="170"></td>
				<td width="80"></td>
				<td width="80"></td>
				<td width=""></td>
				<td width="170"></td>
				<td width=""></td>
				<td width=""></td>
				<td width="130"></td>
				<td width="130"></td>
			</tr>
		</table>
		<div class="controll_btn mt10 p0">
			<button class="cl fl" type="button" id="tradeCardBtn" style="display: none;"><%=BizboxAMessage.getMessage( "TX000005379", "카드거래처" )%></button>
			<span class="mL5" id="tradeCardNm" style=""></span>
			<button type="button" id="btnPayData" onclick="fnPayDataPop();" style="display: none"><%=BizboxAMessage.getMessage( "TX000016508", "급여자료" )%></button>
			<button type="button" id="btnACardSungin" onclick="fnACardSunginPop();" style="display: none"><%=BizboxAMessage.getMessage( "TX000005278", "법인카드 승인내역" )%></button>
			<button type="button" id="btnItems" onclick="fnItemsFormPop();"><%=BizboxAMessage.getMessage( "TX000009891", "명세서 등록" )%></button>
			<span id="budgetTotalAm" style="display: none"></span><span class="mL5" id="ItemsTotalAm" style="display: none"></span> <span class="cl fr" id="referConfer" style="display: none"></span>
		</div>

		<div class="com_ta2 mt15 scroll_x_on">
			<table style="width: 966px;" id="erpTradeInfo">
				<thead>
					<tr>
						<th width="150" id="thTradeTrNm"><%=BizboxAMessage.getMessage( "TX000000313", "거래처명" )%></th>
						<!-- 1, 2(기타소득자) , 3(사원명), 4, 5(사업소득자)-->
						<th width="80"><%=BizboxAMessage.getMessage( "TX000000026", "대표자명" )%></th>
						<!-- 1 -->
						<th width="100" id="thTradeUnitAm"><%=BizboxAMessage.getMessage( "TX000000552", "금액" )%></th>
						<!-- 1, 2(지급총액), 3(지급총액) , 4-->
						<th width="100" id="thTradeSupAm"><%=BizboxAMessage.getMessage( "TX000000516", "공급가액" )%></th>
						<!-- 1, 2(실수령액), 3(실수령액) , 4-->
						<th width="100" id="thTradeVatAm"><%=BizboxAMessage.getMessage( "TX000000517", "부가세" )%></th>
						<!-- 1, 2(원천징수액), 3(원천징수액), 4 -->
						<th width="100"><%=BizboxAMessage.getMessage( "TX000003619", "금융기관" )%></th>
						<!-- 1, 2, 3, 4 -->
						<th width="120"><%=BizboxAMessage.getMessage( "TX000003620", "계좌번호" )%></th>
						<!-- 1, 2, 3, 4 -->
						<th width="80"><%=BizboxAMessage.getMessage( "TX000003621", "예금주" )%></th>
						<!-- 1, 2, 3, 4 -->
						<th width="130"><%=BizboxAMessage.getMessage( "TX000000644", "비고" )%></th>
						<!-- 1, 2, 3 , 4-->
						<th width="100"><%=BizboxAMessage.getMessage( "TX000000584", "신고기준일" )%></th>
						<!-- 1, 2(신고기준일), 3(신고기준일), 4 -->
						<th width="130"></th>
						<!-- 1, 2, 3 , 4-->
					</tr>
				</thead>
				<tbody id="erpTradeInfo-table">
				</tbody>
			</table>

		</div>

		<table id="erpTradeInfo-tablesample" style="display: none">
			<tr class="">
				<td width="150" id="trade-td"><a href="javascript:;" class="search-Event-T"><img src="<c:url value='/Images/ico/ico_explain.png' />" alt="<%=BizboxAMessage.getMessage( "TX000001289", "검색" )%>" title="<%=BizboxAMessage.getMessage( "TX000001289", "검색" )%>" /></a> <input type="text" style="width: 60%" id="txt_TR_NM" class="requirement" tabindex="20001" /> <input type="hidden" class="non-requirement" id="txt_TR_FG" /> <input type="hidden" class="non-requirement" id="txt_TR_FG_NM" /> <input type="hidden" class="non-requirement" id="txt_ATTR_NM" /> <input type="hidden" class="non-requirement" id="txt_PPL_NB" /> <input type="hidden" class="non-requirement" id="txt_ADDR" /> <input type="hidden" class="non-requirement" id="txt_TRCHARGE_EMP" /> <input type="hidden" class="non-requirement" id="txt_JIRO_CD" /> <input type="hidden" class="non-requirement" id="txt_JIRO_NM" /> <input type="hidden" class="non-requirement" id="txt_REG_NB" /> <input type="hidden"
					class="non-requirement" id="txt_NDEP_AM"
				/> <input type="hidden" class="non-requirement" id="txt_INAD_AM" /> <input type="hidden" class="non-requirement" id="txt_INTX_AM" /> <input type="hidden" class="non-requirement" id="txt_RSTX_AM" /> <input type="hidden" class="non-requirement" id="txt_WD_AM" /> <input type="hidden" class="non-requirement" id="txt_ETCRVRS_YM" /> <input type="hidden" class="non-requirement" id="txt_ETCDUMMY1" /> <input type="hidden" class="non-requirement" id="txt_DATA_CD" /> <input type="hidden" class="non-requirement" id="txt_ET_YN" /> <input type="hidden" class="non-requirement" id="txt_CTR_NM" /> <input type="hidden" class="non-requirement" id="txt_CTR_CD" /> <input type="hidden" class="non-requirement" id="txt_ITEM_NM" /> <input type="hidden" class="non-requirement" id="txt_ITEM_CNT" /> <input type="hidden" class="non-requirement" id="txt_ITEM_AM" /></td>
				<td width="80"><input type="text" style="width: 93%;" id="txt_CEO_NM" class="non-requirement" tabindex="20002" /></td>
				<td width="100"><input type="text" id="txt_UNIT_AM" style="width: 85%; padding-right: 7px;" class="ri requirement" CODE="empty" tabindex="20002" /></td>
				<td width="100"><input type="text" id="txt_SUP_AM" style="width: 85%; padding-right: 7px;" class="ri non-requirement" tabindex="20003" /></td>
				<td width="100"><input type="text" id="txt_VAT_AM" code="empty" style="width: 85%; padding-right: 7px;" class="ri requirement" tabindex="20004" /></td>
				<td width="100"><a href="javascript:;" class="search-Event-T"><img src="<c:url value='/Images/ico/ico_explain.png' />" alt="<%=BizboxAMessage.getMessage( "TX000001289", "검색" )%>" title="<%=BizboxAMessage.getMessage( "TX000001289", "검색" )%>" /></a> <input type="text" style="width: 73%;" id="txt_BTR_NM" class="non-requirement" tabindex="20005" /></td>
				<td width="120"><input type="text" style="width: 93%;" id="txt_BA_NB" class="non-requirement" tabindex="20006" /></td>
				<td width="80"><input type="text" style="width: 93%;" id="txt_DEPOSITOR" class="non-requirement" tabindex="20007" /></td>
				<td width="130"><input type="text" style="width: 93%;" id="txt_RMK_DC" class="non-requirement" tabindex="20008" /></td>
				<td width="100"><input style="width: 93%;" id="txt_TAX_DT" class="non-requirement enter" tabindex="20011" part="trade" /> <input type="hidden" class="non-requirement" id="tempTAX_DT" /></td>
				<td width="130">
					<div class="controll_btn ac p0">
						<button type="button" class="erpsave"><%=BizboxAMessage.getMessage( "TX000001256", "저장" )%></button>
						<button type="button" class="btndeleteRow"><%=BizboxAMessage.getMessage( "TX000000424", "삭제" )%></button>
					</div>
				</td>
			</tr>
		</table>

		<table id="erpTradeInfo-tablesample-empty" style="display: none">
			<tr class="blank">
				<td width="150"></td>
				<td width="80"></td>
				<td width="100"></td>
				<td width="100"></td>
				<td width="100"></td>
				<td width="100"></td>
				<td width="120"></td>
				<td width="80"></td>
				<td width="130"></td>
				<td width="100"></td>
				<td width="130"></td>
			</tr>
		</table>
	</div>
	<!-- //pop_con -->

</div>


<div id="dialog-form-standard" style="display: none">
	<div class="pop_wrap_dir">
		<div class="pop_head">
			<h1></h1>
			<a href="#n" class="clo popClose"><img src="<c:url value='/Images/btn/btn_pop_clo02.png' />" alt="" /></a>
		</div>
		<div class="pop_con">
			<!-- 사웝검색 box -->
			<div class="top_box" style="overflow: hidden; display: none;" id="deptEmp_Search">
				<dl class="dl2">
					<dt class="mr0">
						<input type="checkbox" name="userAllview" id="userAllview" class="k-checkbox" value="1"> <label class="k-checkbox-label radioSel" for="userAllview" style="top: 0px; margin: 0 25px 0 10px;"><%=BizboxAMessage.getMessage( "TX000009909", "모든예산회계단위" )%></label>
						<%=BizboxAMessage.getMessage( "TX000016505", "범위" )%>
						: <input type="radio" name="B_use_YN" id="B_use_YN_2" value="2" class="k-radio"> <label class="k-radio-label" for="B_use_YN_2" style="top: 0px; margin: 0 0 0 10px; padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000000862", "전체" )%></label> <input type="radio" name="B_use_YN" id="B_use_YN_1" value="1" class="k-radio" checked="checked"> <label class="k-radio-label" for="B_use_YN_1" style="top: 0px; margin: 0 0 0 10px; padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000004252", "기준일" )%> </label> <input type="text" name="BASIC_DT" id="BASIC_DT" value="${basic_dt }" style="width: 80px;"> <a href="javascript:;" id="user_Search"><img src=" <c:url value='/Images/btn/search_icon2.png'/>" alt="<%=BizboxAMessage.getMessage( "TX000000899", "조회" )%>" /></a>
					</dt>
				</dl>
			</div>

			<!-- 채주사원 등록  -->
			<div class="top_box" style="overflow: hidden; display: none;" id="EmpTrade_Search">
				<dl class="dl2">
					<dt class="mr0">
						<%=BizboxAMessage.getMessage( "TX000016505", "범위" )%>
						: <input type="radio" name="B_use_YN2" id="B_use_YN2_2" value="2" /> <label for="B_use_YN2_2" class="mR5"><%=BizboxAMessage.getMessage( "TX000000862", "전체" )%></label> <input type="radio" name="B_use_YN2" id="B_use_YN2_1" value="1" checked="checked" /> <label for="B_use_YN2_1" class="mR5"><%=BizboxAMessage.getMessage( "TX000004252", "기준일" )%></label> <input type="text" name="P_STD_DT" id="P_STD_DT" value="${basic_dt }" style="width: 80px;"> <a href="javascript:;" id="user_Search2"><img src=" <c:url value='/Images/btn/search_icon2.png'/>" alt="<%=BizboxAMessage.getMessage( "TX000000899", "조회" )%>" /></a>
					</dt>
				</dl>
			</div>
			<!-- 입출금계좌 -->
			<div class="top_box" style="overflow: hidden; display: none;" id="BankTrade_Search">
				<dl class="dl2">
					<dt class="mr0">
						<%=BizboxAMessage.getMessage( "TX000000028", "사용여부" )%>
						: <input type="radio" name="BankTrade_use_YN" id="USE_YN_1" value="1" class="k-radio" checked="checked" /> <label class="k-radio-label" for="USE_YN_1" style="top: 0px; padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000000180", "사용" )%> </label> <input type="radio" name="BankTrade_use_YN" id="USE_YN_2" value="2" class="k-radio" /> <label class="k-radio-label" for="USE_YN_2" style="top: 0px; margin: 10px 0 0 10px; padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000009908", "전체(미사용포함)" )%></label>
					</dt>
				</dl>
			</div>

			<!-- 예산검색 -->
			<div class="top_box" style="overflow: hidden; display: none;" id="Budget_Search">
				<dl class="">
					<dt style="width: 100px;">
						<%=BizboxAMessage.getMessage( "TX000005289", "예산과목표시" )%>
						:
					</dt>
					<dd>
						<input type="radio" name="OPT_01" value="2" id="OPT_01_2" class="k-radio" checked="checked" /> <label class="k-radio-label" for="OPT_01_2" style="padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000005290", "당기 편성된 예산과목만 표시" )%></label> <input type="radio" name="OPT_01" value="1" id="OPT_01_1" class="k-radio" /> <label class="k-radio-label" for="OPT_01_1" style="padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000005112", "모든 예산과목 표시" )%></label> <input type="radio" name="OPT_01" value="3" id="OPT_01_3" class="k-radio" /> <label class="k-radio-label" for="OPT_01_3" style="padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000005291", "프로젝트 기간 예산 편성된 과목만 표시" )%></label>
					</dd>
				</dl>
				<dl class="">
					<dt style="width: 100px;">
						<%=BizboxAMessage.getMessage( "TX000005486", "사용기한" )%>
						:
					</dt>
					<dd>
						<input type="radio" name="OPT_02" value="1" id="OPT_02_1" class="k-radio" checked="checked" /> <label class="k-radio-label" for="OPT_02_1" style="padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000004225", "모두표시" )%></label> <input type="radio" name="OPT_02" value="2" id="OPT_02_2" class="k-radio" /> <label class="k-radio-label" for="OPT_02_2" style="padding: 0.2em 0 0 1.5em;"><%=BizboxAMessage.getMessage( "TX000009907", "사용기한경과분 숨김" )%></label>
					</dt>
				</dl>
			</div>

			<div class="top_box" style="overflow: hidden; display: none;" id="Trade_Search">
				<dl class="dl2">
					<dt class="mr0">
						<input type="checkbox" id="tradeAllview" />
						<%=BizboxAMessage.getMessage( "TX000016507", "모든 거래처 보여주기" )%>
					</dt>
				</dl>
			</div>
			<div class="com_ta2 mt10 ova_sc_all cursor_p" style="height: 340px;" id="dialog-form-standard-bind"></div>


		</div>
		<!-- //pop_con -->
	</div>
	<!-- //pop_wrap -->
</div>

<div id="dialog-form-background" class="modal" style="display: none;"></div>
