<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_accountingAcc}  <!--회계계정--></h1>
	<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
</div><!-- //pop_head -->

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_accLevel}  <!--계정레벨--></dt>
			<dd>
				<select id="selIsConectedBgacct" class="selectmenu" style="width:150px;">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="">${CL.ex_subject}  <!--과목--></option>
					<option value="">${CL.ex_item}  <!--항목--></option>
					<option value="">${CL.ex_detail}  <!--세목--></option>
				</select>
			</dd>
			
			<dt>${CL.ex_searchCondition2}<!--조회여부--></dt>
			<dd>
				<select id="selSelectYN" class="selectmenu" style="width:150px;">
					<option value="Y" selected="selected">${CL.ex_yes}  <!--예--></option>
					<option value="N">${CL.ex_no}  <!--아니요--></option>
				</select>
			</dd>
		</dl>
		<dl class="">
			<dt class="ar" style="width:51px;">${CL.ex_keyWord}  <!--검색어--></dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="CD_ACCT">${CL.ex_code}  <!--코드--></option>
					<option value="NM_ACCT">${CL.ex_accountingAcc}  <!--회계계정--></option>
					<option value="NM_ACITEM">${CL.ex_subjectCode}  <!--과목코드--></option>
					<option value="NM_ACHTEM">${CL.ex_itemCode}  <!--항목코드--></option>
				</select>
			</dd>
			
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr" style="width:195px;" />
			</dd>
			<dd>
				<input type="button" id="btnSearch" value="${CL.ex_search}" />  <!--검색-->
			</dd>
		</dl>
	</div>
         
	<!-- 건수 -->
	<div class="btn_div">
		<div class="left_div">
			<p id="valTotalCount" class="mt5 fwb">총 0건</p>
		</div>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2 sc_head">
		<table>
			<colgroup>
				<col width="19%"/>
				<col width="27%"/>
				<col width="27%"/>
				<col width="27%"/>
			</colgroup>
			<tr>
				<th>${CL.ex_code}  <!--코드--></th>
				<th>${CL.ex_accountingAcc}  <!--회계계정--></th>
				<th>${CL.ex_subjectCode}  <!--과목코드--></th>
				<th>${CL.ex_itemCode}  <!--항목코드--></th>
			</tr>
		</table>	
	</div>

	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height:270px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width="19%"/>
				<col width="27%"/>
				<col width="27%"/>
				<col width="27%"/>
			</colgroup>
		</table>
	</div>
</div><!-- //pop_con -->

<script>
	function fnInitPopupLayout( ){
	// 	$("#title").text("회계계정");
		thisWidth = 628;
		thisHeight = 580;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
	    if (navigator.userAgent.indexOf("MSIE 6") > 0){        // IE 6.x
	    	popMWidth = 15;
	    	popMHeight = 80;
    	}
	    else if(navigator.userAgent.indexOf("MSIE 7") > 0){    // IE 7.x
	    	popMWidth = 15;
	    	popMHeight = 80;
	    }
	    else if(navigator.userAgent.indexOf("Firefox") > 0){	// FF
	    	popMWidth = 15;
	    	popMHeight = 39;
	    }
	    else if(navigator.userAgent.indexOf("Netscape") > 0){  // Netscape
	    	popMWidth = 15;
	    	popMHeight = 80;
	    }
	    else if(navigator.userAgent.toLowerCase().indexOf("chrome") > 0){
	    	popMWidth = 15;
	    	popMHeight = 35;
	    }
	    else if(navigator.userAgent.indexOf("Trident") > 0){
	    	popMWidth = 15;
	    	popMHeight = 50;
	    }
	}
	
	function fnSetPageParam( param ){
		/* 	회계계정 파라미터 정의
			bgacctCode : 예산계정코드
		*/
		param.isConectedBgacct = $("#selIsConectedBgacct").val();
		param.erpBgacctSeq = (param.erpBgacctSeq || '');
		param.searchStr = $("#txtSearchStr").val();
		return param;
	}
	
	function fnGridCommonCodeTable( data ){
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="19%"/>';
		colGroup += '<col width="27%"/>';
		colGroup += '<col width="27%"/>';
		colGroup += '<col width="27%"/>';
		colGroup += '</colgroup>';
		$("#tblCommonCode").append(colGroup);
		
		/* 총 개수 확인 */
		if(data.length == 0){
			$("#valTotalCount").text("총 0 건");
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblCommonCode colgroup col").length + '">데이터가 없습니다.</td>')
			$("#tblCommonCode").append(tr);
		}else{
			var resultCount = 0;
			var searchType = $("#selSearchType").val();
			
			$.each(data,function(idx, val){
				if ( !( ( searchType == '' ? JSON.stringify ( val ) : ( val [ searchType ] ? val [ searchType ] : '' ) ).indexOf ( $ ( '#txtSearchStr' ).val ( ) ) < 0 )){
					resultCount++;
					var tr = document.createElement('tr');
					$(tr).data('data', val);
					$(tr).append('<td>' + val.CD_ACCT + '</td>')
					$(tr).append('<td>' + val.NM_ACCT + '</td>')
					if(val.NM_ACITEM != undefined){
						$(tr).append('<td>' + val.NM_ACITEM + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_ACHTEM != undefined){
						$(tr).append('<td>' + val.NM_ACHTEM + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
				}
				
				$("#tblCommonCode").append(tr);
				
				$ ( tr ).click ( function ( ) {
					if ( !$ ( this ).hasClass ( 'on' ) ) {
						$ ( this ).parent ( ).find ( 'tr' ).removeClass ( 'on' );
						$ ( this ).addClass ( 'on' );
						fnSetClickEvent ( $ ( this ) );
						
						$ ( '#txtSearchStr' ).focus ( );
					}
				} );
			});
			
			$ ( "#valTotalCount" ).text ( "총 " + resultCount + " 건" );

			if ( resultCount > 0 ) {
				$ ( '#tblCommonCode tr:eq(0)' ).addClass ( 'on' );
			}

			if ( resultCount === 1 ) {
				fnSetDblClickEvent ( $ ( 'tr.on' ) [ 0 ] );
			}
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
</script>