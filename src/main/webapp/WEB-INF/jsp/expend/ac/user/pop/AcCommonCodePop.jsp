<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="main.web.BizboxAMessage"%>

<script type="text/javascript">
	/* 프로젝트 : erpCompSeq, erpEmpSeq, langCode */
	/* 부서 : erpCompSeq, erpEmpSeq, langCode, jobOption */
	/* 입출금계좌 : erpCompSeq, erpEmpSeq, langCode */

	/* ################################################## */
	/* #. var */
	/* ################################################## */
	var commonCodeUrl = "/Ac/G20/Ex/AcExErpCommonCodeListInfo.do";
	var commonCodeListInfo = {};
	var popSize = {
		project: {
			width: 400,
			height: 480
		}
	};

	/* ################################################## */
	/* #. document reayd */
	/* ################################################## */
	$ ( document ).ready ( function ( ) {
		fnInit ( );

		switch ( '${ViewBag.type}' ) {
			case "project": /* 프로젝트 */
				fnGetProjectListInfo ( );
				break;
			case "dept": /* 부서 */
				fnGetDeptListInfo ( );
				break;
			case "bankTrade": /* 입출금계좌 */
				fnGetBankTradeListInfo ( );
				break;
			default:
				alert ( '코드를 찾을 수 없습니다.\r\n메시지가 지속적으로 나타나면 관리자에게 문의 바랍니다.' );
				self.close ( );
				break;
		}
	} );

	/* ################################################## */
	/* #. fnInit */
	/* ################################################## */
	/* #. fninit */
	function fnInit ( ) {
		fnInitPopSize ( );
		return;
	};

	/* #. fninit - fnInitPopSize */
	function fnInitPopSize ( ) {
		if ( '${ViewBag.type}' != '' ) {
			var thisX = parseInt ( document.body.scrollWidth );
			var thisY = parseInt ( document.body.scrollHeight );
			var maxThisX = screen.width - 50;
			var maxThisY = screen.height - 50;
			var marginY = 0;

			if ( maxThisX > popSize [ '${ViewBag.type}' ] [ 'width' ] ) {
				maxThisX = popSize [ '${ViewBag.type}' ] [ 'width' ];
			}

			if ( maxThisY > popSize [ '${ViewBag.type}' ] [ 'height' ] ) {
				maxThisY = popSize [ '${ViewBag.type}' ] [ 'height' ];
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

			/* #. 센터정렬 */
			var windowX = ( screen.width - ( maxThisX + 10 ) ) / 2;
			var windowY = ( screen.height - ( maxThisY ) ) / 2 - 20;
			window.moveTo ( windowX, windowY );
			window.resizeTo ( maxThisX, maxThisY );
			$ ( '.pop_sign_wrap' ).css ( 'height', ( maxThisY - 68 ) );
			return;
		} else {
			var maxThisX = 500;
			var maxThisY = 500;
			var windowX = ( screen.width - ( maxThisX + 10 ) ) / 2;
			var windowY = ( screen.height - ( maxThisY ) ) / 2 - 20;
			window.moveTo ( windowX, windowY );
			window.resizeTo ( maxThisX, maxThisY );
			window.resizeTo ( maxThisX, maxThisY );
		}
		return;
	};

	/* ################################################## */
	/* #. get code || info */
	/* ################################################## */
	/* #. 프로젝트 */
	function fnGetProjectListInfo ( ) {
		var params = {};
		params.url = commonCodeUrl;
		params.async = false;
		params.parameter = {};
		params.parameter.type = '${ViewBag.type}';
		var result = ajax ( params );
		console.log ( result );
		if ( typeof result.aaData != 'undefined' ) {
			commonCodeListInfo = result.aaData;
			setTable ( {
				Data: commonCodeListInfo,
				Columns: [ {
					title: "코드",
					width: ""
				}, {
					title: "명칭",
					width: ""
				} ],
				ColumnsDef: [ {
					data: "projectCode"
				}, {
					data: "projectName"
				} ],
				RowCallback: function ( data ) {
					console.log ( rowData );
				}
			} );
		}
		return;
	}
	/* #. 부서 */
	function fnGetDeptListInfo ( ) {
		var params = {};
		params.url = commonCodeUrl;
		params.async = false;
		params.parameter = {};
		params.parameter.jobOption = '0';
		var result = ajax ( params );
		console.log ( result );
		if ( typeof result.aaData != 'undefined' ) {
			commonCodeListInfo = result.aaData;
		}
		return;
	}
	/* #. 입출금계좌 */
	function fnGetBankTradeListInfo ( ) {
		var params = {};
		params.url = commonCodeUrl;
		params.async = false;
		params.parameter = {};
		var result = ajax ( params );
		console.log ( result );
		if ( typeof result.aaData != 'undefined' ) {
			commonCodeListInfo = result.aaData;
		}
		return;
	}

	/* ################################################## */
	/* #. function */
	/* ################################################## */
	/* #. function - ajax */
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

	/* #. function - set table */
	function setTable ( params ) {
		console.log ( params );
		/* Head */
		var headTr = document.createElement ( "tr" );
		$.each ( params.Columns, function ( idx, itme ) {
			var headTh = document.createElement ( "th" );
			headTh.innerHTML = itme.title || '';
			headTr.appendChild ( headTh );
		} );
		$ ( '#dialog-form-standard-bind-table' ).append ( headTr );

		var searchTr = document.createElement ( "tr" );
		$.each ( params.Columns, function ( idx, itme ) {
			var searchTd = document.createElement ( "td" );
			var searchInput = document.createElement ( "input" );
			searchInput.setAttribute ( 'type', 'text' );
			searchInput.setAttribute ( 'style', 'width:90%' );
			searchTd.appendChild ( searchInput );
			searchTr.appendChild ( searchTd );
		} );
		$ ( '#dialog-form-standard-bind-table' ).append ( searchTr );

		/* Content */
		var ColumnsDef = params.ColumnsDef;
		$.each ( params.Data, function ( rowIdx, rowItem ) {
			var tr = document.createElement ( "tr" );
			tr.setAttribute ( 'value', JSON.stringify ( rowItem ) );
			$ ( tr ).bind ( {
				click: function ( event ) {
					console.log ( $ ( this ).attr ( 'value' ) );
				}
			} );

			$.each ( ColumnsDef, function ( colIdx, colItem ) {
				var td = document.createElement ( "td" );
				td.innerHTML = ( rowItem [ colItem.data ] || '' );
				tr.appendChild ( td );
			} );
			$ ( '#dialog-form-standard-bind-table' ).append ( tr );
		} );

		/* console.log ( params.Data );
		$.each ( params.Data, function ( idx, item ) {
			var tr = document.createElement ( "tr" );
			var colLength = 0; 
			$.each ( params.Columns, function ( idx, itme ) {
				var td = document.createElement ( "td" );
				colLength++;
				console.log ( params.ColumnsDef [ colLength ] [ data ] );
				td.innerHTML = item [ ColumnsDef [ colLength ] [ data ] ];
				tr.appendChild ( td );
			} );

			$ ( '#dialog-form-standard-bind-table' ).append ( tr );
		} ); */
		/* Footer */

		var selectIdx = 0;
		$ ( document ).focus ( );
		$ ( document ).unbind ( 'keyup' );
		$ ( document ).bind ( {
			keyup: function ( event ) {
				if ( event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 27 || event.keyCode == 13 ) {
					/* 38 : UP / 40 : DOWN / 27 : ESC */
					if ( event.keyCode == 27 ) {
						if ( confirm ( '팝업창을 닫으시겠습니까?' ) ) {
							alert ( '닫았습니다.' );
						} else {
							alert ( '안닫았습니다.' );
						}
					} else if ( event.keyCode == 38 ) {
						if ( selectIdx > 0 ) {
							selectIdx--;
						}
					} else if ( event.keyCode == 40 ) {
						if ( ( $ ( '#dialog-form-standard-bind-table tr' ).length - 3 ) > selectIdx ) {
							selectIdx++;
						}
					} else if ( event.keyCode == 13 ) {
						$ ( '.on' ).click ( );
					}

					var trIdx = ( selectIdx + 2 );
					$ ( '#dialog-form-standard-bind-table tr' ).removeClass ( 'on' );
					$ ( '#dialog-form-standard-bind-table tr:eq(' + ( selectIdx + 2 ) + ')' ).addClass ( 'on' );
					$ ( '#dialog-form-standard-bind-table tr:eq(' + ( selectIdx + 2 ) + ')' ).focus ( );
				}
			}
		} );

		return;
	}
</script>
<div class="pop_wrap_dir">
	<div class="pop_head">
		<h1>부서 코드</h1>
	</div>
	<div class="pop_con">
		<!-- 사웝검색 box -->
		<div class="top_box" id="deptEmp_Search" style="overflow: hidden; display: none;">
			<dl class="dl2">
				<dt class="mr0">
					<input name="userAllview" class="k-checkbox" id="userAllview" type="checkbox" value="1"> <label class="k-checkbox-label radioSel" style="margin: 0px 25px 0px 10px; top: 0px;" for="userAllview">모든예산회계단위</label> 범위 : <input name="B_use_YN" class="k-radio" id="B_use_YN_2" type="radio" value="2"> <label class="k-radio-label" style="margin: 0px 0px 0px 10px; padding: 0.2em 0px 0px 1.5em; top: 0px;" for="B_use_YN_2">전체</label> <input name="B_use_YN" class="k-radio" id="B_use_YN_1" type="radio" checked="checked" value="1"> <label class="k-radio-label" style="margin: 0px 0px 0px 10px; padding: 0.2em 0px 0px 1.5em; top: 0px;" for="B_use_YN_1">기준일 </label> <input name="BASIC_DT" id="BASIC_DT" style="width: 80px;" type="text" value=""> <a id="user_Search" href="javascript:;"><img alt="조회" src=" /ea/Images/btn/search_icon2.png"></a>
				</dt>
			</dl>
		</div>

		<!-- 채주사원 등록  -->
		<div class="top_box" id="EmpTrade_Search" style="overflow: hidden; display: none;">
			<dl class="dl2">
				<dt class="mr0">
					범위 : <input name="B_use_YN2" id="B_use_YN2_2" type="radio" value="2"> <label class="mR5" for="B_use_YN2_2">전체</label> <input name="B_use_YN2" id="B_use_YN2_1" type="radio" checked="checked" value="1"> <label class="mR5" for="B_use_YN2_1">기준일</label> <input name="P_STD_DT" id="P_STD_DT" style="width: 80px;" type="text" value=""> <a id="user_Search2" href="javascript:;"><img alt="조회" src=" /ea/Images/btn/search_icon2.png"></a>
				</dt>
			</dl>
		</div>
		<!-- 입출금계좌 -->
		<div class="top_box" id="BankTrade_Search" style="overflow: hidden; display: none;">
			<dl class="dl2">
				<dt class="mr0">
					사용여부 : <input name="BankTrade_use_YN" class="k-radio" id="USE_YN_1" type="radio" checked="checked" value="1"> <label class="k-radio-label" style="padding: 0.2em 0px 0px 1.5em; top: 0px;" for="USE_YN_1">사용 </label> <input name="BankTrade_use_YN" class="k-radio" id="USE_YN_2" type="radio" value="2"> <label class="k-radio-label" style="margin: 10px 0px 0px 10px; padding: 0.2em 0px 0px 1.5em; top: 0px;" for="USE_YN_2">전체미사용포함</label>
				</dt>
			</dl>
		</div>

		<!-- 예산검색 -->
		<div class="top_box" id="Budget_Search" style="overflow: hidden; display: none;">
			<dl>
				<dt style="width: 100px;">예산과목표시 :</dt>
				<dd>
					<input name="OPT_01" class="k-radio" id="OPT_01_2" type="radio" checked="checked" value="2"> <label class="k-radio-label" style="padding: 0.2em 0px 0px 1.5em;" for="OPT_01_2">당기 편성된 예산과목만 표시</label> <input name="OPT_01" class="k-radio" id="OPT_01_1" type="radio" value="1"> <label class="k-radio-label" style="padding: 0.2em 0px 0px 1.5em;" for="OPT_01_1">모든 예산과목 표시</label> <input name="OPT_01" class="k-radio" id="OPT_01_3" type="radio" value="3"> <label class="k-radio-label" style="padding: 0.2em 0px 0px 1.5em;" for="OPT_01_3">프로젝트 기간 예산 편성된 과목만 표시</label>
				</dd>
			</dl>
			<dl>
				<dt style="width: 100px;">사용기한 :</dt>
				<dd>
					<input name="OPT_02" class="k-radio" id="OPT_02_1" type="radio" checked="checked" value="1"> <label class="k-radio-label" style="padding: 0.2em 0px 0px 1.5em;" for="OPT_02_1">모두표시</label> <input name="OPT_02" class="k-radio" id="OPT_02_2" type="radio" value="2"> <label class="k-radio-label" style="padding: 0.2em 0px 0px 1.5em;" for="OPT_02_2">사용기한경과분 숨김</label>

				</dd>
			</dl>
		</div>

		<div class="top_box" id="Trade_Search" style="overflow: hidden; display: none;">
			<dl class="dl2">
				<dt class="mr0">
					<input id="tradeAllview" type="checkbox"> 모든 거래처 보여주기
				</dt>
			</dl>
		</div>
		<div class="com_ta2 mt10 ova_sc_all cursor_p" id="dialog-form-standard-bind" style="height: 340px;">
			<table id="dialog-form-standard-bind-table">
				<!-- 				<tbody>
					<tr>
						<th scope="col">부서 코드</th>
						<th scope="col">부서 명</th>
					</tr>
					<tr class="searchLine">
						<td><input style="width: 90%;" type="text" code="PJT_CD"></td>
						<td><input style="width: 90%;" type="text" code="PJT_NM"></td>
					</tr>
					<tr class="dialog-form-standard-bind-table-tr" style="cursor: pointer;" index="0">
						<td style="width: 150px;"></td>
						<td style="width: 250px;"></td>
					</tr>
					<tr class="dialog-form-standard-bind-table-tr" style="cursor: pointer;" index="1">
						<td style="width: 150px;"></td>
						<td style="width: 250px;"></td>
					</tr>
					<tr class="dialog-form-standard-bind-table-tr" style="cursor: pointer;" index="2">
						<td style="width: 150px;"></td>
						<td style="width: 250px;"></td>
					</tr>
					<tr class="dialog-form-standard-bind-table-tr" style="cursor: pointer;" index="3">
						<td style="width: 150px;"></td>
						<td style="width: 250px;"></td>
					</tr>
					<tr class="dialog-form-standard-bind-table-tr" style="cursor: pointer;" index="4">
						<td style="width: 150px;"></td>
						<td style="width: 250px;"></td>
					</tr>
					<tr class="dialog-form-standard-bind-table-tr" style="cursor: pointer;" index="5">
						<td style="width: 150px;"></td>
						<td style="width: 250px;"></td>
					</tr>
					<tr class="dialog-form-standard-bind-table-tr" style="cursor: pointer;" index="6">
						<td style="width: 150px;"></td>
						<td style="width: 250px;"></td>
					</tr>
				</tbody> -->
			</table>
		</div>
	</div>
</div>