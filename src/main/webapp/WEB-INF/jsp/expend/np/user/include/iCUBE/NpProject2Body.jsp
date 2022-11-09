<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>
<!-- NpProjectBody -->
<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_project2}</h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt style="width: 50px;">${CL.ex_category}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:115px" id="selProjectStat">
					<option value="1,0" selected="selected">${CL.ex_use}</option>
					<option value="">${CL.ex_includingDonotUse}</option>
					<option value="1">${CL.ex_Progress}</option>
					<option value="0">${CL.ex_completion}</option>
				</select>
			</dd>
			<dt style="width: 50px;">${CL.ex_keyWord}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}</option>
					<option value="pjtSeq">${CL.ex_code}</option>
					<option value="pjtName">${CL.ex_project}</option>
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
		<div class="left_div fwb">
			<p id="valTotalCount" class="mt5 fwb">${CL.ex_yeCount} 0${CL.ex_gun}</p>
		</div>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2 sc_head">
		<table>
			<colgroup>
				<col width="25" />
				<col width="100" />
				<col width="" />
			</colgroup>
			<tr>
				<th> <input type="checkbox" id="chkAllchk"> </th>
				<th>${CL.ex_category}</th>
				<th>${CL.ex_project}</th>
			</tr>
		</table>
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight rightContents" style="height: 290px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width="25" />
				<col width="130" />
				<col width="" />
			</colgroup>
		</table>
	</div>
	<!-- //pop_con -->
</div>

<script>
	function fnInitPopupLayout ( ) {
		// 		$("#title").text("예산단위");
		thisWidth = 549;
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
		
		$('#chkAllchk').click(function (){
			$('.chkData').prop('checked', $(this).prop('checked'));
		});
	}

	function fnSetPageParam ( param ) {
		var pjtStatus = $ ( '#selProjectStat' ).val ( );
		
		param.erpPjtSeq = '';
		param.erpPjtStatus = pjtStatus;
		param.erpPjtType = '';
		param.baseDate = '';
		param.erpEmpSeq = '';
		param.erpPjtName = '';
		return param;
	}

	function fnGridCommonCodeTable ( data ) {
		console.log ( data );

		for ( var i = 0; i < data.length; i++ ) {
			var item = data [ i ];
			item.erpMgtSeq = item.pjtSeq;
			item.erpMgtStatus = item.pjtStatus;
			item.erpMgtName = item.pjtName;
		}

		oldData = data;
		$ ( "#tblCommonCode" ).empty ( );
		var colGroup = '<colgroup>';
		colGroup += '<col width="25"/>';
		colGroup += '<col width="100"/>';
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
			/* manyData ( ); */
			/* return; */
		}

		/* ${CL.ex_yeCount} 개수 확인 */
		var resultCount = 0;
		var searchType = $ ( '#selSearchType' ).val ( );
		var searchStr = $ ( '#txtSearchStr' ).val ( );
		var selProjectStat = $ ( '#selProjectStat' ).val ( );
		

		$.each ( data, function ( idx, val ) {
			/* 검색어 필터링 */
			var projectInfo = {
					erpMgtName: val.erpMgtName
					, erpMgtSeq: val.erpMgtSeq
			} 
			if ( !( ( searchType == '' ? JSON.stringify ( projectInfo ) : ( val [ searchType ] ? val [ searchType ] : '' ) ).indexOf ( $ ( '#txtSearchStr' ).val ( ) ) < 0 ) ) { 
				resultCount++;
				var tr = document.createElement ( 'tr' );
				$ ( tr ).data ( 'data', val );
				$ ( tr ).append ( '<td>' + '<input class="chkData" type="checkbox" value="'+ escape(JSON.stringify(val)) +'">' + '</td>' );
				$ ( tr ).append ( '<td>' + val.pjtSeq + '</td>' );
				$ ( tr ).append ( '<td class="al">&nbsp;' + val.pjtName + '</td>' );
				$ ( "#tblCommonCode" ).append ( tr );
			}
		} );

		$ ( "#valTotalCount" ).text ( "${CL.ex_yeCount} " + resultCount + " ${CL.ex_gun}" );

		if ( !resultCount ) {
			emptyTable ( );
		}
		maxCount = Number ( staticMaxCount.toString ( ) );
	}
</script>
