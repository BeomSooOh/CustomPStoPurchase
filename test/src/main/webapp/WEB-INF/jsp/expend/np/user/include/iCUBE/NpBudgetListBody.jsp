<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/contents.css'></link>
<!-- NpBudgetListBody -->
<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_budgetSub}</h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con" style="width: 748px;">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt style="width: 80px;">${CL.ex_budgetListSearch}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:135px" id="selOption1">
					<option value="1">${CL.ex_all}</option>
					<option value="2" selected="selected">${CL.ex_currentOrganization}</option>
					<option value="3">${CL.ex_orgprojectperiod}</option>
				</select>
			</dd>
			<dt class="ar" style="display:none">${CL.ex_budgetgroup}</dt>
			<dd style="display:none">
				<select class="puddSetup" pudd-style="width:100px" id="selOption3">
					<option value="2" selected="selected">${CL.ex_hide}</option>
					<option value="1">${CL.ex_show}</option>
				</select>
			</dd>
		</dl>
		<dl class="next2">
			<dt style="width: 80px;">${CL.ex_useDate2}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:135px" id="selOption2">
					<option value="1" selected="selected">${CL.ex_all}</option>
					<option value="2">${CL.ex_hideafter}</option>
				</select>
			</dd>
			<dt style="width: 49px">${CL.ex_keyWord}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px">
					<option value="" selected="selected">${CL.ex_all}</option>
					<option value="">${CL.ex_code}</option>
					<option value="">${CL.ex_budgetSub}</option>
				</select>
			</dd>
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr" style="width: 200px; ime-mode: active;">
			</dd>
			<dd>
				<input type="button" id="btnSearch" class="puddSetup submit" value="${CL.ex_search}" />
			</dd>
		</dl>
	</div>

	<div class="btn_div cl">
          	<div class="left_div fwb mt5">
          		${CL.ex_yeCount} <span class="text_blue" id="valTotalCount">10</span> ${CL.ex_gun}
          	</div>
		<div class="right_div">
			<div class="yeon_div" style="display:none;">
				<dl>
					<dt>${CL.ex_budgetAmount} :</dt>
					<dd id="txtOpenAmt"></dd>
				</dl>
				<dl>
					<dt>${CL.ex_consBal} :</dt>
					<dd id="txtConsBalanceAmt"></dd>
				</dl>
				<dl>
					<dt>${CL.ex_budgetExcutionAmt} :</dt>
					<dd id="txtApplyAmt"></dd>
				</dl>
				<dl>
					<dt>${CL.ex_budgetBalance} :</dt>
					<dd id="txtBalanceAmt"></dd>
				</dl>
			</div>
			<input id="btnBudgetInfoSelect" type="button" class="puddSetup" pudd-style="float:right;width:62px;" value="${CL.ex_budgetsearch}" >
			
		</div>
	</div>
	<div class="cus_ta_ea scbg table3 posi_re">
		<!-- SCROLL HEADER -->
		<span class="scy_head1"></span>
		<!-- RIGHT HEADER -->
		<div id="" class="cus_ta_ea ovh mr17 scbg ta_bl rightHeader">
			<table id="tblHeader">
			</table>
		</div>
		<!-- RIGHT CONTENTS -->
		<div id="" class="cus_ta_ea rowHeight scroll_fix rightContents scbg ta_bl" style="height: 289px;" onscroll="table1Scroll()">
			<table id="tblCommonCode">
			</table>
		</div>
	</div>
	<!--//table3 -->
</div>
<!-- //pop_con -->

<script>
	function fnInitPopupLayout ( ) {
		// 		$("#title").text("예산단위");
		thisWidth = 780;
		thisHeight = 580;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if ( navigator.userAgent.indexOf ( "MSIE 6" ) > 0 ) { // IE 6.x
			popMWidth = 15;
			popMHeight = 80;
		} else if ( navigator.userAgent.indexOf ( "MSIE 7" ) > 0 ) { // IE 7.x
			popMWidth = 15;
			popMHeight = 80;
		} else if ( navigator.userAgent.indexOf ( "Firefox" ) > 0 ) { // FF
			popMWidth = 80;
			popMHeight = 72;
		} else if ( navigator.userAgent.indexOf ( "Netscape" ) > 0 ) { // Netscape
			popMWidth = 15;
			popMHeight = 80;
		} else if ( navigator.userAgent.toLowerCase ( ).indexOf ( "chrome" ) > 0 ) {
			popMWidth = 15;
			popMHeight = 68;
		} else if ( navigator.userAgent.indexOf ( "Trident" ) > 0 ) {
			popMWidth = 15;
			popMHeight = 90;
		}
		
		/* 예산잔액 가조회 기능 설정 */
		fnSetBudgetSelectInfoInit();

		/* 예산 조회 정보 옵션 반영 */
		setTimeout(function() {
			Pudd( "#selOption1" ).getPuddObject().setSelectedIndex( "" + ( viewBagParam.param.opt01 || '2') );
		}, 500);
	}

	/*	[예산조회] 예산잔액 가조회 버튼 이벤트 설정
	------------------------------------------- */
	function fnSetBudgetSelectInfoInit(){
		$('#btnBudgetInfoSelect').click(function (){
			var selData = {};
			try{
				selData = $($ ( 'tr.onSel' ) [ 0 ]).data('data');
			}catch(e){
				alert('선택된 데이터가 없습니다.');
			}
			var param = viewBagParam.param;
			param.erpBudgetSeq = selData.erpBudgetSeq;
			param.erpGisuDate = !!param.resDate?param.resDate.replaceAll('-',''):param.consDate.replaceAll('-','');
			param.erpBudgetDivSeq = param.erpDivSeq.replace('|', '');
			param.erpMgtSeq = param.erpMgtSeq.replace('|', '');
			param.resDocSeq =  param.resDocSeq || "-1";
			param.consDocSeq =  param.consDocSeq || "-1";
			param.confferDocSeq =  param.confferDocSeq || "-1";
			param.confferSeq =  param.confferSeq || "-1";
			param.confferBudgetSeq = param.confferBudgetSeq || "-1";
			param.consSeq = param.consSeq || "-1";
			param.resSeq = param.resSeq || "-1";
			$.ajax({
				type : 'post',
				url : '<c:url value="/ex/np/user/res/resBudgetInfoSelect.do" />',
				datatype : 'json',
				async : false,
				data : param,
				success : function(result) {
					var data = result.result.aData;
					$('#txtOpenAmt').text(fnGetCurrencyCode(data.openAmt));
					$('#txtConsBalanceAmt').text(fnGetCurrencyCode(data.consBalanceAmt));
					$('#txtApplyAmt').text(fnGetCurrencyCode(data.resApplyAmt));
					$('#txtBalanceAmt').text(fnGetCurrencyCode(data.balanceAmt));
					$('.yeon_div').show();
					$ ( '#txtSearchStr' ).focus ( );
					
				},
				/*   - error :  */
				error : function(result) {
					$('#txtBudgetInfo').text('예산정보 조회 중 오류 발생');
					$ ( '#txtSearchStr' ).focus ( );
				}
			});
		});
	}
	
	/*	[공용] 숫자에 콤마 찍어서 가져오기
	---------------------------------------- */
	function fnGetCurrencyCode(value){
	    value = '' + value || '';
	    value = '' + value.split('.')[0];
	    value = value.replace(/[^0-9\-]/g, '') || '0';
	    var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    return returnVal;
	}
	
	function fnSetPageParam ( param ) {
		param.gisu = ( param.gisu || '' ); /* ERP 기수 */
		param.frDate = ( param.frDate || '' ); /* 기수 시작일 */
		param.toDate = ( param.toDate || '' ); /* 기수 종료일 */
		param.grFg = param.grFg; /* 수입 : 1, 구매 : 2 */
		param.divSeqs = ( param.erpDivSeq || '' ) + "|"; /* 회계통제단위 구분값 '|' */
		param.mgtSeqs = ( param.projectSeq || '' ) + "|"; /* 예산통제단위 구분값 '|' */
		param.bottomSeqs = ''; /* 하위 사업 코드 구분값 '|' */
		param.bgtSeq = ''; /* 검색 예산과목 코드 */
		param.bgtName = ''; /* 예산과목 명 */
		param.opt01 = $ ( "#selOption1" ).val ( ); /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
		param.opt02 = $ ( "#selOption2" ).val ( ); /* 1: 모두표시, 2: 사용기한결과분 숨김 */
		param.opt03 = $ ( "#selOption3" ).val ( ); /* 1: 표시, 2:숨김*/
		var nowDate = new Date ( );
		var bgtDate = nowDate.getFullYear ( ) + '' + ( nowDate.getMonth ( ) < 10 ? '0' + nowDate.getMonth ( ) : nowDate.getMonth ( ) ) + '' + ( nowDate.getDate ( ) < 10 ? '0' + nowDate.getDate ( ) : nowDate.getDate ( ) );
		param.bgtFrDate = bgtDate;
		return param;
	}

	function fnGridCommonCodeTable ( data ) {
		$ ( "#tblHeader" ).empty ( );
		$ ( "#tblCommonCode" ).empty ( );

		for ( var i = 0; i < data.length; i++ ) {
			/* 원인행위자 추가 */
			var item = data [ i ];
			item.erpBudgetSeq = item.BGT_CD;
			item.erpBudgetName = item.BGT_NM;

			item.erpBgt1Seq = ( item.BGT01_CD || '' );
			item.erpBgt2Seq = ( item.BGT02_CD || '' );
			item.erpBgt3Seq = ( item.BGT03_CD || '' );
			item.erpBgt4Seq = ( item.BGT04_CD || '' );

			item.erpBgt1Name = ( item.BGT01_NM || '' );
			item.erpBgt2Name = ( item.BGT02_NM || '' );
			item.erpBgt3Name = ( item.BGT03_NM || '' );
			item.erpBgt4Name = ( item.BGT04_NM || '' );
		}

		var hasLevel1 = false;
		var hasLevel2 = false;
		var hasLevel3 = false;
		var hasLevel4 = false;
		var hasLevel5 = false;
		var hasLevel6 = false;
		var colLength = 4;
		$.each ( data, function ( idx, val ) {
			var length = 4;
			if ( val.LEVEL01_NM != undefined ) {
				hasLevel1 = true;
				length = 5;
			}
			if ( val.LEVEL02_NM != undefined ) {
				hasLevel2 = true;
				length = 6;
			}
			if ( val.LEVEL03_NM != undefined ) {
				hasLevel3 = true;
				length = 7;
			}
			if ( val.LEVEL04_NM != undefined ) {
				hasLevel4 = true;
				length = 8;
			}
			if ( val.LEVEL05_NM != undefined ) {
				hasLevel5 = true;
				length = 9;
			}
			if ( val.LEVEL06_NM != undefined ) {
				hasLevel6 = true;
				length = 10;
			}
			if( colLength <= length) {
				colLength = length; 
			}
		} );
		/* 테이블 헤더 그려주자 */
		var headerName = JSON.parse ( '${ViewBag.budgetHeaderName}' || '[]' );
		if ( !headerName.length ) {
			headerName = [ {
				labelName: '${CL.ex_bgt1Name}'
			}, {
				labelName: '${CL.ex_bgt2Name}'
			}, {
				labelName: '${CL.ex_bgt3Name}'
			}, {
				labelName: '${CL.ex_bgt4Name}'
			} ];
		}

		var headerHTML = '';
		headerHTML += '<colgroup>'
		for ( var i = 0; i < colLength; i++ ) {
			headerHTML += '<col width="140">';
		}
		/* 과목 코드 출력용 콜그룹 +1 */
		headerHTML += '<col width="140">'; 
		headerHTML += '</colgroup>'
		headerHTML += '<tbody>'
		
		for ( var i = 0; i < colLength; i++ ) {
			if ( colLength - 4 == i ) {
				headerHTML += '<th>' + headerName [ i ].labelName + '(${CL.ex_bgt1Name})</th>';
			} else if ( colLength - 3 == i ) {
				headerHTML += '<th>' + headerName [ i ].labelName + '(${CL.ex_bgt2Name})</th>';
			} else if ( colLength - 2 == i ) {
				headerHTML += '<th>' + headerName [ i ].labelName + '(${CL.ex_bgt3Name})</th>';
			} else if ( colLength - 1 == i ) {
				headerHTML += '<th>' + headerName [ i ].labelName + '(${CL.ex_bgt4Name})</th>';
			} else {
				headerHTML += '<th>' + headerName [ i ].labelName + '</th>';
				
			}
		}
		
		/* 과목 코드 출력용 테이블 헤더 +1 */
		headerHTML += '<th>${CL.ex_code}</th>';
		headerHTML += '</tbody>'
		$ ( "#tblHeader" ).append ( headerHTML );

		var colGroup = '<colgroup>';
		for ( var i = 0; i < $ ( "#tblHeader colgroup col" ).length; i++ ) {
			colGroup += '<col width="140">';
		}
		colGroup += '</colgroup>';
		$ ( "#tblCommonCode" ).append ( colGroup );

		/* 총 개수 확인 */

		var resultCount = 0;
		$.each ( data, function ( idx, val ) {
			/* 품의서 선택된 예산있는경우 추가하지 않음. */
			viewBagParam.param.selectedBudgetSeqs = viewBagParam.param.selectedBudgetSeqs || '';
			if( viewBagParam.param.selectedBudgetSeqs.indexOf( '|'+ val.erpBudgetSeq +'|' ) == -1  ){
				if ( ( JSON.stringify ( val ).indexOf ( $ ( '#txtSearchStr' ).val ( ) ) > -1 ) ) {
					resultCount++;
					var tr = document.createElement ( 'tr' );
					$ ( tr ).data ( 'data', val );
	
					if ( hasLevel1 ) {
						if ( val.LEVEL01_NM != undefined ) {
							$ ( tr ).append ( '<td>' + val.LEVEL01_NM + '</td>' );
						} else {
							$ ( tr ).append ( '<td></td>' );
						}
					}
					if ( hasLevel2 ) {
						if ( val.LEVEL02_NM != undefined ) {
							$ ( tr ).append ( '<td>' + val.LEVEL02_NM + '</td>' );
						} else {
							$ ( tr ).append ( '<td></td>' );
						}
					}
					if ( hasLevel3 ) {
						if ( val.LEVEL03_NM != undefined ) {
							$ ( tr ).append ( '<td>' + val.LEVEL03_NM + '</td>' );
						} else {
							$ ( tr ).append ( '<td></td>' );
						}
					}
					if ( hasLevel4 ) {
						if ( val.LEVEL04_NM != undefined ) {
							$ ( tr ).append ( '<td>' + val.LEVEL04_NM + '</td>' );
						} else {
							$ ( tr ).append ( '<td></td>' );
						}
					}
					if ( hasLevel5 ) {
						if ( val.LEVEL05_NM != undefined ) {
							$ ( tr ).append ( '<td>' + val.LEVEL05_NM + '</td>' );
						} else {
							$ ( tr ).append ( '<td></td>' );
						}
					}
					if ( hasLevel6 ) {
						if ( val.LEVEL06_NM != undefined ) {
							$ ( tr ).append ( '<td>' + val.LEVEL06_NM + '</td>' );
						} else {
							$ ( tr ).append ( '<td></td>' );
						}
					}
					if ( val.BGT01_NM != undefined ) {
						$ ( tr ).append ( '<td>' + val.BGT01_NM + '</td>' );
					} else {
						$ ( tr ).append ( '<td></td>' );
					}
					if ( val.BGT02_NM != undefined ) {
						$ ( tr ).append ( '<td>' + val.BGT02_NM + '</td>' );
					} else {
						$ ( tr ).append ( '<td></td>' );
					}
					if ( val.BGT03_NM != undefined ) {
						$ ( tr ).append ( '<td>' + val.BGT03_NM + '</td>' );
					} else {
						$ ( tr ).append ( '<td></td>' );
					}
					if ( val.BGT04_NM != undefined ) {
						$ ( tr ).append ( '<td>' + val.BGT04_NM + '</td>' );
					} else {
						$ ( tr ).append ( '<td></td>' );
					}
					
					$ ( tr ).append ( '<td>' + ( val.BGT_CD || '' ) + '</td>' );
	
					$ ( tr ).click ( function ( ) {
						if ( !$ ( this ).hasClass ( 'onSel' ) ) {
							$ ( 'tr.onSel' ).removeClass ( 'onSel' );
							$ ( this ).parent ( ).find ( 'tr' ).removeClass ( 'onSel' );
							$ ( this ).addClass ( 'onSel' );
							fnSetClickEvent ( $ ( this ) );
							$ ( '#txtSearchStr' ).focus ( );
							$('.yeon_div').hide();
						}
					} );
	
					$ ( "#tblCommonCode" ).append ( tr );
				}
				
			}
		} );

		$ ( "#valTotalCount" ).text ( resultCount || '0' );

		if ( resultCount < 1 ) {
			var tr = document.createElement ( 'tr' );
			$ ( tr ).append ( '<td colspan="' + $ ( "#tblCommonCode colgroup col" ).length + '">${CL.ex_dataDoNotExists}</td>' )
			$ ( "#tblCommonCode" ).append ( tr );
		}

		if ( resultCount > 0 ) {
			$ ( '#tblCommonCode tr:eq(0)' ).addClass ( 'onSel' );
		}
		
		if ( resultCount == 1 ) {
			fnSetDblClickEvent ( $ ( 'tr.onSel' ) [ 0 ] );
		}

		var userAction = 'search';
		$ ( '#txtSearchStr' ).unbind ( ).keydown ( function ( ) {
			var keyCode = event.keyCode ? event.keyCode : event.which;

			/* ArrowUp : 38 */
			if ( keyCode.toString ( ) === '38' ) {
				if ( $ ( 'tr.onSel' ).prev ( 'tr' ).length > 0 ) {
					var elem = $ ( 'tr.onSel' ).prev ( 'tr' );
					$ ( 'tr.onSel' ).removeClass ( 'onSel' );
					$ ( elem ).addClass ( 'onSel' );
					$ ( "#hidSelectVal" ).val ( JSON.stringify ( $ ( elem ).data ( 'data' ) ) );
					userAction = 'ArrowUp';
					$('.yeon_div').hide();
				}
			}
			/* ArrowDown : 40 */
			else if ( keyCode.toString ( ) === '40' ) {
				if ( $ ( 'tr.onSel' ).next ( 'tr' ).length > 0 ) {
					var elem = $ ( 'tr.onSel' ).next ( 'tr' );
					$ ( 'tr.onSel' ).removeClass ( 'onSel' );
					$ ( elem ).addClass ( 'onSel' );
					$ ( "#hidSelectVal" ).val ( JSON.stringify ( $ ( elem ).data ( 'data' ) ) );
					userAction = 'ArrowDown';
					$('.yeon_div').hide();
				}
			}
			/* Enter : 13 */
			else if ( keyCode.toString ( ) === '13' ) {
				$('.yeon_div').hide();
				if ( userAction === '' ) {
					$ ( '#btnSearch' ).click ( );
					userAction = 'Enter';
				} else {
					fnSetDblClickEvent ( $ ( 'tr.onSel' ) [ 0 ] );
				}
			} else {
				userAction = '';
			}

			if ( ( $ ( '.onSel' ).height ( ) * ( $ ( '.onSel' ).index ( ) + 1 ) ) - $ ( '.rightContents' ).scrollTop ( ) > $ ( '.rightContents' ).height ( ) ) {
				$ ( '.rightContents' ).scrollTop ( ( $ ( '.onSel' ).height ( ) * $ ( '.onSel' ).index ( ) ) );
			} else if ( ( $ ( '.onSel' ).height ( ) * $ ( '.onSel' ).index ( ) ) < $ ( '.rightContents' ).scrollTop ( ) ) {
				$ ( '.rightContents' ).scrollTop ( $ ( '.rightContents' ).scrollTop ( ) - $ ( '.onSel' ).height ( ) );
			}
		} );
		fnInitTableEvent ( );
	}

	//휠스크롤
	/* function fixDataOnWheel ( ) {
		console.log('fixDataOnWheel');
		if ( event.wheelDelta < 0 ) {
			DataScroll.doScroll ( 'scrollbarDown' );
		} else {
			DataScroll.doScroll ( 'scrollbarUp' );
		}
		table1Scroll ( );
	} */
	//각 테이블 스크롤 동기화
	function table1Scroll ( ) {
		$ ( ".table3 .leftContents" ).scrollTop ( $ ( ".table3 .rightContents" ).scrollTop ( ) );
		$ ( ".table3 .rightHeader" ).scrollLeft ( $ ( ".table3 .rightContents" ).scrollLeft ( ) );
	}
</script>