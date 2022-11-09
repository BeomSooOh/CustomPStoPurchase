<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>
<!-- NpDivBody -->
<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_cardInfo}  <!--카드정보--></h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt style="width: 50px;">${CL.ex_keyWord}  <!--검색어--></dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="cardName">${CL.ex_cardNm}  <!--카드명--></option>
					<option value="cardNum">${CL.ex_cardNumber}  <!--카드번호--></option>
				</select>
			</dd>
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr" style="width: 200px;ime-mode:active;">
			</dd>
			<dd>
				<input type="button" id="btnSearch" class="puddSetup submit" value="${CL.ex_search}" /> <!--검색-->
			</dd>
		</dl>
	</div>

	<div class="btn_div cl">
		<div class="left_div fwb mt5">
			<p id="valTotalCount" class="mt5 fwb">총 0건</p>
		</div>
		<div class="right_div">
			<input type="checkbox" name="chkNoUseCard" id="chkNoUseCard" onclick="fnNotUseCheck(this)"/>&nbsp;
			<label for="chkNoUseCard" class="mr10">${CL.ex_notUseCard}  <!--미사용 카드 포함--></label>
		</div>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2 sc_head">
		<table>
			<colgroup>
				<col width="30%" />
				<col width="70%" />
			</colgroup>
			<tr>
				<th>${CL.ex_cardNm}  <!--카드명--></th>
				<th>${CL.ex_cardNumber}  <!--카드번호--></th>
			</tr>
		</table>
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height: 290px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width="130" />
				<col width="" />
			</colgroup>
		</table>
	</div>
	<!-- //pop_con -->
</div>
	<script>
		function fnInitPopupLayout ( ) {
			thisWidth = 487;
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
		}

		var checkedData = '';
		function fnSetPageParam ( param ) {
			checkedData = param.checkedCardInfo;
			return param;
		}

		function fnGridCommonCodeTable ( data ) {
			console.log ( data );

			oldData = data;
			$ ( "#tblCommonCode" ).empty ( );
			var colGroup = '<colgroup>';
			colGroup += '<col width="30%"/>';
			colGroup += '<col width="70%"/>';
			colGroup += '</colgroup>';
			$ ( "#tblCommonCode" ).append ( colGroup );

			var emptyTable = function ( ) {
				$ ( "#valTotalCount" ).text ( "총 0 건" );
				var tr = document.createElement ( 'tr' );
				$ ( tr ).append ( '<td colspan="' + $ ( "#tblCommonCode colgroup col" ).length + '">데이터가 없습니다.</td>' );
				$ ( "#tblCommonCode" ).append ( tr );
			}

			var manyData = function ( ) {
				$ ( "#valTotalCount" ).text ( "총 " + data.length + " 건" );
				var tr = document.createElement ( 'tr' );
				$ ( tr ).append ( '<td colspan="' + $ ( "#tblCommonCode colgroup col" ).length + '">검색 결과가 많습니다. 검색어를 이용해주세요.<a onClick="maxCount=9999999;fnGridCommonCodeTable(oldData);">&nbsp;[계속]</a></td>' );
				$ ( "#tblCommonCode" ).append ( tr );
			}

			if ( data.length > maxCount && ( $ ( '#txtSearchStr' ).val ( ) == '' ) ) {
				manyData ( );
				return;
			}

			/* 총 개수 확인 */
			var resultCount = 0;
			var searchType = $ ( '#selSearchType' ).val ( );
			var searchStr = $ ( '#txtSearchStr' ).val ( );
			if(cardCheckYN == '') {
				cardCheckYN = false;
			}
			var cardUseYN = (cardCheckYN == true ? "" : "Y");

			$.each ( data, function ( idx, val ) {
				if ( !( ( searchType == '' ? JSON.stringify ( val ) : ( val [ searchType ] ? val [ searchType ] : '' ) ).indexOf ( $ ( '#txtSearchStr' ).val ( ) ) < 0 ) 
						&& !( ( cardCheckYN ? "YN" : val [ "useYN" ] ).indexOf ( cardUseYN ) < 0 )		
				) {
					resultCount++;
					var tr = document.createElement ( 'tr' );
					$ ( tr ).data ( 'data', val );
					$ ( tr ).append ( '<td>' + val.cardName + '</td>' )
					$ ( tr ).append ( '<td>' + fnFormatCardNum(val.cardNum) + '</td>' )
					$ ( "#tblCommonCode" ).append ( tr );

					$ ( tr ).click ( function ( ) {
						if ( !$ ( this ).hasClass ( 'on' ) ) {
							$ ( this ).parent ( ).find ( 'tr' ).removeClass ( 'on' );
							$ ( this ).addClass ( 'on' );
							fnSetClickEvent ( $ ( this ) );
						}
					} );
				}
			} );

			$ ( "#valTotalCount" ).text ( "총 " + resultCount + " 건" );

			if ( !resultCount ) {
				emptyTable ( );
			}
			maxCount = Number ( staticMaxCount.toString ( ) );
			
			if(checkedData) {
				fnCheckedData();
			}
			
			if ( resultCount > 0 ) {
				$ ( '#tblCommonCode tr:eq(0)' ).addClass ( 'on' );
			}

			if ( resultCount === 1 ) {
				fnSetDblClickEvent ( $ ( 'tr.on' ) [ 0 ] );
			}
			
			fnInitTableEvent ( );
			
			var userAction = 'search';
			$ ( '#txtSearchStr' ).unbind ( ).keydown ( function ( ) {
				var keyCode = event.keyCode ? event.keyCode : event.which;
				/* ArrowUp : 38 */
				if ( keyCode.toString ( ) === '38' ) {
					if ( $ ( 'tr.on' ).prev ( 'tr' ).length > 0 ) {
						var elem = $ ( 'tr.on' ).prev ( 'tr' );
						$ ( 'tr.on' ).removeClass ( 'on' );
						$ ( elem ).addClass ( 'on' );
						$ ( "#hidSelectVal" ).val ( JSON.stringify ( $ ( elem ).data ( 'data' ) ) );
						userAction = 'ArrowUp';
					}
				}
				/* ArrowDown : 40 */
				else if ( keyCode.toString ( ) === '40' ) {
					if ( $ ( 'tr.on' ).next ( 'tr' ).length > 0 ) {
						var elem = $ ( 'tr.on' ).next ( 'tr' );
						$ ( 'tr.on' ).removeClass ( 'on' );
						$ ( elem ).addClass ( 'on' );
						$ ( "#hidSelectVal" ).val ( JSON.stringify ( $ ( elem ).data ( 'data' ) ) );
						userAction = 'ArrowDown';
					}
				}
				/* Enter : 13 */
				else if ( keyCode.toString ( ) === '13' ) {
					if ( userAction === '' ) {
						$ ( '#btnSearch' ).click ( );
						userAction = 'Enter';
					} else {
						fnSetDblClickEvent ( $ ( 'tr.on' ) [ 0 ] );
					}
				} else {
					userAction = '';
				}
				
				if ( ( $ ( 'tr.on' ).height ( ) * ( $ ( 'tr.on' ).index ( ) + 1 ) ) - $ ( '#tblCommonCode' ).parent ( 'div' ).scrollTop ( ) > $ ( '#tblCommonCode' ).parent ( 'div' ).height ( ) ) {
					$ ( '#tblCommonCode' ).parent ( 'div' ).scrollTop ( ( $ ( 'tr.on' ).height ( ) * $ ( 'tr.on' ).index ( ) ) );
				} else if ( ( $ ( 'tr.on' ).height ( ) * $ ( 'tr.on' ).index ( ) ) < $ ( '#tblCommonCode' ).parent ( 'div' ).scrollTop ( ) ) {
					$ ( '#tblCommonCode' ).parent ( 'div' ).scrollTop ( $ ( '#tblCommonCode' ).parent ( 'div' ).scrollTop ( ) - $ ( 'tr.on' ).height ( ) );
				}
			} );
			
		}
		
		/* 기존 체크박스 유지 */
		function fnCheckedData() {
			$('input:checkbox[name="cardCheckBox"]').each(function(){
				if(checkedData.indexOf($(this).attr("id").replace("chk_", "")) > -1) {
					this.checked = true;
				}
			});
		}
		
		/* 체크박스 전체 체크/언체크 */
		function fnAllChk(){
			if($("#chkAll").prop("checked")) { 
				$("#tblCommonCode input[type=checkbox]").not(":disabled").prop("checked",true); 
			} else { 
				$("#tblCommonCode input[type=checkbox]").not(":disabled").prop("checked",false);
			}
	 	}
		
		/* 미사용 카드 포함 체크 */
		var cardCheckYN = '';
		function fnNotUseCheck(data) {
			cardCheckYN = $(data).is(":checked");
			fnGridCommonCodeTable ( oldData );
		}
		
		/* 카드번호 포맷 */
		function fnFormatCardNum(value) {
			value = (value || '');
			value = value.toString().replace(/-/g, '').split(' ').join('');
			value = value.replace(/([0-9]{4})([0-9]{4})([0-9]{3,4})([0-9]{4})/, '$1-****-****-$4');

			return value;
		}
	</script>