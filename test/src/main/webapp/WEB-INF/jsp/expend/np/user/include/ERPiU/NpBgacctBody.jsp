<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_budgetAccount}  <!--예산계정--></h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div><!-- //pop_head -->

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt class="ar" style="width:65px;">${CL.ex_keyWord}  <!--검색어--></dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="CD_BGACCT">${CL.ex_code}  <!--코드--></option>
					<option value="NM_BGACCT">${CL.ex_budgetAccount}  <!--예산계정--></option>
					<option value="NM_LEVEL">${CL.ex_high}  <!--상위--></option>
					<option value="NM_LEVEL2">${CL.ex_higher}  <!--차상위--></option>
					<option value="NM_LEVEL3">${CL.ex_highest}  <!--차차상위--></option>
				</select>
			</dd>
			<dd><input type="text" autocomplete="off" id="txtSearchStr" style="width:297px;" /></dd>
			<dd><input type="button" id="btnSearch" value="${CL.ex_search}" /></dd>  <!--검색-->
			
		</dl>
		<!-- <dl class="next2"> -->
		<dl class="next2">
			<dt  class="ar" style="width:65px;">${CL.ex_budget}  <!--예산-->년도</dt>
			<dd>
				<select id="selBgtYear" class="selectmenu" style="width:100px;">
				</select>
			</dd>
			<dt class="ar" style="width:115px;">${CL.ex_connAccount}  <!--연결계정--></dt>
			<dd>
				<select id="selIsConnectedBizplan" class="selectmenu" style="width:150px;">
					<option value="">${CL.ex_all}  <!--전체--></option>
					<option value="Y" selected="selected">${CL.ex_connAccount}  <!--연결계정--></option>
				</select>
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
				<col width="16%"/>
				<col width="21%"/>
				<col width="21%"/>
				<col width="21%"/>
				<col width="21%"/>
			</colgroup>
			<tr>
				<th>${CL.ex_code}  <!--코드--></th>
				<th>${CL.ex_budgetAccount}  <!--예산계정--></th>
				<th>${CL.ex_high}  <!--상위--></th>
				<th>${CL.ex_higher}  <!--차상위--></th>
				<th>${CL.ex_highest}  <!--차차상위--></th>
			</tr>
		</table>	
	</div>

	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height:290px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width="16%"/>
				<col width="21%"/>
				<col width="21%"/>
				<col width="21%"/>
				<col width="21%"/>
			</colgroup>
		</table>
	</div>
</div><!-- //pop_con -->

<script>
	function fnInitPopupLayout( ){
	// 	$("#title").text("예산계정");
		thisWidth = 728;
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
	    	popMHeight = 72;
	    }
	    else if(navigator.userAgent.indexOf("Netscape") > 0){  // Netscape
	    	popMWidth = 15;
	    	popMHeight = 80;
	    }
	    else if(navigator.userAgent.toLowerCase().indexOf("chrome") > 0){
	    	popMWidth = 15;
	    	popMHeight = 68;
	    }
	    else if(navigator.userAgent.indexOf("Trident") > 0){
	    	popMWidth = 15;
	    	popMHeight = 80;
	    }
		/* 회계년도 옵션 설정 */
		$("#selBgtYear").empty();
		var viewYear = 3;
		var nowYear = (new Date()).getFullYear();
		var startYear = nowYear - viewYear;
		
		for(var i = 0 ; i < (viewYear * 2 + 1) ; i ++){
			$("#selBgtYear").append("<option value='" + (startYear + i) + "'>" + (startYear + i)+ "</option>");
		}
		$("#selBgtYear").val(nowYear).selectmenu('refresh');
	}
	
	function fnSetPageParam( param ){
		/* 	예산계정 파라미터 정의 
			bgacctType : 결의구분 ( A:전체, '':결의구분 )
			isConnectedBizplan : 연결계정 ( Y:연결계정, '':전체)
			budgetCode : 예산단위 코드
			bizplanCode : 사업계획 코드
		*/
		param.isConnectedBizplan = $("#selIsConnectedBizplan").val();
		param.bgtYear = $("#selBgtYear").val();
		param.searchStr = $("#txtSearchStr").val();
		param.erpBudgetSeq = (param.erpBudgetSeq || '');
		param.erpBizplanSeq = (param.erpBizplanSeq || '');
		return param;
	}
	
	function fnGridCommonCodeTable( data ){
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="16%"/>';
		colGroup += '<col width="21%"/>';
		colGroup += '<col width="21%"/>';
		colGroup += '<col width="21%"/>';
		colGroup += '<col width="21%"/>';
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
				/* 진짜. 일정 압박으로 인해.. 이렇게 할 수 밖에 없는 코드가 너무 보기 싫다... */
				var selectedBgacctCd = '( |' + (val.CD_BUDGET||'') + '|' + (val.CD_BIZPLAN||'') + '|' + (val.CD_BGACCT||'') + '| )';
				if((viewBagParam.param.selectedBudgetSeqs||'').indexOf(selectedBgacctCd)!=-1){
					return true;
				}
				
				if ( !( ( searchType == '' ? JSON.stringify ( val ) : ( val [ searchType ] ? val [ searchType ] : '' ) ).indexOf ( $ ( '#txtSearchStr' ).val ( ) ) < 0 )){
					
					
					resultCount++;
					var tr = document.createElement('tr');
					$(tr).data('data', val);
					$(tr).append('<td>' + val.CD_BGACCT + '</td>')
					$(tr).append('<td>' + val.NM_BGACCT + '</td>')
					if(val.NM_LEVEL != undefined){
						$(tr).append('<td>' + val.NM_LEVEL + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_LEVEL2 != undefined){
						$(tr).append('<td>' + val.NM_LEVEL2 + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_LEVEL3 != undefined){
						$(tr).append('<td>' + val.NM_LEVEL3 + '</td>')
					}else{
						$(tr).append('<td></td>')
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
				}
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