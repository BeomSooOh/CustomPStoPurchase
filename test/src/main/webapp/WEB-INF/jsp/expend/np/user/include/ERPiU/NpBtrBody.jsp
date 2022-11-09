<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_ioAccount}  <!--예적금계좌--></h1>
	<a href="javascript:fnCloseLayerPop();" class="clo" ><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>					
			<dt>사용여부</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:83px" id="selUseType">
					<option value="">${CL.ex_all}  <!--전체--></option>
					<option value="Y"  selected="selected">사용 </option>
					<option value="N">미사용</option>
				</select>
			</dd>
			<dt>예적금조회구분</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:90px" id="selPcType">
					<option value="">전체</option>
					<option value="Y" selected="selected">회계단위</option>
				</select>
			</dd>		
			<dt>${CL.ex_keyWord}  <!--검색어--></dt>
			<dd>
				<select class="puddSetup" pudd-style="width:80px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="CD_DEPOSIT">${CL.ex_code}  <!--코드--></option>
					<option value="NO_DEPOSIT">${CL.ex_accountNum}  <!--계좌번호--></option>
					<option value="NM_DEPOSIT">${CL.ex_depositAndInstallment}  <!--예적금--></option>
					<option value="NM_BANK">${CL.ex_bank}  <!--은행--></option>
				</select>
			</dd>
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr" style="width:150px;" />
			</dd>
			<dd>
				<input type="button" id="btnSearch" value="${CL.ex_search}" />  <!--검색-->
			</dd>
		</dl>
	</div>
	<!-- 건수 -->
	<div class="btn_div">
		<div class="left_div">
			<p class="mt5 fwb" id="valTotalCount">총 0 건</p>
		</div>
	</div>
	
	<!-- 테이블 -->
	<div class="com_ta2 sc_head">
		<table>
			<colgroup>
				<col width="100"/>
				<col width="130"/>
				<col width="130"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>${CL.ex_code}  <!--코드--></th>
				<th>${CL.ex_accountNum}  <!--계좌번호--></th>
				<th>${CL.ex_depositAndInstallment}  <!--예적금--></th>
				<th>${CL.ex_bank}  <!--은행--></th>
			</tr>
		</table>	
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight"  style="height:324px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width="100"/>
				<col width="130"/>
				<col width="130"/>
				<col width=""/>
			</colgroup>
		</table>
	</div>
</div><!-- //pop_con -->

<script>
	function fnInitPopupLayout( ){
// 		$("#title").text("예산단위");
		thisWidth = 528;
		thisHeight = 546;
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
// 		var nowDate = new Date();
// 		fnSetDatepicker("#txtStdYM","yy-mm");
// 		$("#txtStdYM").val(nowDate.getFullYear() + "-" + ((nowDate.getMonth() + 1)<10?'0'+(nowDate.getMonth() + 1):(nowDate.getMonth() + 1)));
		
// 		$("#txtStdYM").keyup(function(e){
// 			if( ( 48 <= e.keyCode && e.keyCode <= 57 ) || (  96 <= e.keyCode && e.keyCode <= 105  ) ){
// 				var dataLength = $("#" + $(this).prop("id")).val().length;
// 				if( dataLength == 4 ){
// 					$("#" + $(this).prop("id")).val($("#" + $(this).prop("id")).val() + "-");
// 				}	
// 			}else if( e.keyCode == 13){
// 				$("#btnSearch").click();
// 			}
// 		});
	}
	
	function fnSetPageParam( param ){
// 		param.stdYM = $("#txtStdYM").val().toString().replace(/-/g, '');
// 		param.searchStr = $("#txtSearchStr").val();
		return param;
	}
	
	function fnGridDataFilter(aaData){
		var useType = $('#selUseType').val();
		var pcType = $('#selPcType').val() == 'Y' ? fnGetCommonCodeParam().param.erpPcSeq : ''; 
		var returnAaData = [];
		var returnAaData2 = [];
		
		/* 사용여부 필터링 */
		for(var i=0; i < aaData.length; i++){
			var item = aaData[i];
			if(item.YN_USE == ( useType || item.YN_USE) ){
				returnAaData.push(item);
			}
		}
		
		/* 예적금조회구분 필터링 */
		for(var i=0; i < returnAaData.length; i++){
			var item = returnAaData[i];
			if(item.CD_PC == ( pcType || item.CD_PC) ){
				returnAaData2.push(item);
			}
		}
		return returnAaData2;
	}
	
	function fnGridCommonCodeTable( data ){
		data = fnGridDataFilter(data);
		
		console.log(data);
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width="130"/>';
		colGroup += '<col width="130"/>';
		colGroup += '<col width=""/>';
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
					$(tr).append('<td>' + val.CD_DEPOSIT + '</td>')
					$(tr).append('<td>' + val.NO_DEPOSIT + '</td>')
					$(tr).append('<td>' + val.NM_DEPOSIT + '</td>')
					$(tr).append('<td>' + val.NM_BANK + '</td>')
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