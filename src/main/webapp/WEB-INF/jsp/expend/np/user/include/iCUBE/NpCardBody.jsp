<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>
<!-- NpDivBody -->
<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_cardInfo}</h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt style="width: 50px;">${CL.ex_keyWord}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}</option>
					<option value="cardName">${CL.ex_theNameOfCard}</option>
					<option value="cardNum">${CL.ex_cardNumber}</option>
				</select>
			</dd>
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr" style="width: 200px;ime-mode:active;">
			</dd>
			<dd>
				<input type="button" id="btnSearch" class="puddSetup submit" value="${CL.ex_search}" />
			</dd>
		</dl>
	</div>

	<div class="btn_div cl">
		<div class="left_div fwb mt5">
			<p id="valTotalCount" class="mt5 fwb">${CL.ex_yeCount} 0${CL.ex_gun}</p>
		</div>
		<div class="right_div">
			<input type="checkbox" name="chkNoUseCard" id="chkNoUseCard" onclick="fnNotUseCheck(this)"/>&nbsp;
			<label for="chkNoUseCard" class="mr10">${CL.ex_notUseCard}</label>
		</div>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2 sc_head">
		<table>
			<colgroup>
				<col width="34" />
				<col width="" />
				<col width="" />
			</colgroup>
			<tr>
				<th><input type="checkbox" id="chkAll" name="all_chk" onclick="fnAllChk('tblCommonCode');"></th>
				<th>${CL.ex_theNameOfCard}</th>
				<th>${CL.ex_cardNumber}</th>
			</tr>
		</table>
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height: 319px;">
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
			checkedData = param.checkedCardInfo || '';
			return param;
		}

		function fnGridCommonCodeTable ( data ) {
			oldData = data;
			$ ( "#tblCommonCode" ).empty ( );
			var colGroup = '<colgroup>';
			colGroup += '<col width="34"/>';
			colGroup += '<col width=""/>';
			colGroup += '<col width=""/>';
			colGroup += '</colgroup>';
			$ ( "#tblCommonCode" ).append ( colGroup );

			var emptyTable = function ( ) {
				$ ( "#valTotalCount" ).text ( "${CL.ex_yeCount} 0 ${CL.ex_gun}" );
				var tr = document.createElement ( 'tr' );
				$ ( tr ).append ( '<td colspan="' + $ ( "#tblCommonCode colgroup col" ).length + '">${CL.ex_dataDoNotExists}</td>' );
				$ ( "#tblCommonCode" ).append ( tr );
			}

			var manyData = function ( ) {
				$ ( "#valTotalCount" ).text ( "${CL.ex_yeCount} " + data.length + " ${CL.ex_gun}" );
				var tr = document.createElement ( 'tr' );
				$ ( tr ).append ( '<td colspan="' + $ ( "#tblCommonCode colgroup col" ).length + '">검색 결과가 많습니다. 검색어를 이용해주세요.<a onClick="maxCount=9999999;fnGridCommonCodeTable(oldData);">&nbsp;[계속]</a></td>' );
				$ ( "#tblCommonCode" ).append ( tr );
			}

			if ( data.length > maxCount && ( $ ( '#txtSearchStr' ).val ( ) == '' ) ) {
				manyData ( );
				return;
			}

			/* ${CL.ex_yeCount} 개수 확인 */
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
					$(tr).append('<td><input type="checkbox" name="cardCheckBox" id="chk_'+val.cardCode+'" value="' + ([val.cardCode, val.cardName, val.repCardNum].join('|').toString() || '') + '"/>' + '</td>');
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

			$ ( "#valTotalCount" ).text ( "${CL.ex_yeCount} " + resultCount + " ${CL.ex_gun}" );

			if ( !resultCount ) {
				emptyTable ( );
			}
			maxCount = Number ( staticMaxCount.toString ( ) );
			
			if(checkedData) {
				fnCheckedData();
			}
			//fnInitTableEvent ( );
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