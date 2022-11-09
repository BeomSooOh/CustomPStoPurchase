<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_vendor}  <!--거래처--></h1>
	<a href="javascript:fnCloseLayerPop();" class="clo" ><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt>거래처구분</dt>
			<dd>
				<select id="selTrGbn" class="puddSetup" pudd-style="width:80px">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="001">${CL.ex_major}  <!--주요--></option>
					<option value="002">${CL.ex_financial}  <!--금융--></option>
					<option value="003">${CL.ex_individual}  <!--개인--></option>
					<option value="004">${CL.ex_credit}  <!--신용--></option>
					<option value="005">${CL.ex_others}  <!--기타--></option>
<!-- 					<option value="006">외국어</option> -->
				</select>
			</dd>
			<dt class="ar" style="width:72px;">거래처분류</dt>
			<dd>
				<select id="selTrType" class="puddSetup" pudd-style="width:80px">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="001">${CL.ex_purchase}  <!--매입--></option>
					<option value="002">${CL.ex_sales}  <!--매출--></option>
					<option value="003">${CL.ex_combine}  <!--통합--></option>
					<option value="004">${CL.ex_others}  <!--기타--></option>
				</select>
			</dd>
			<dt>${CL.ex_closeAndShutDownDivision}  <!--휴폐업구분--></dt>
			<dd>
				<select id="selTrOpenGbn" class="puddSetup" pudd-style="width:80px">
					<option value="null" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="001">${CL.ex_normality}  <!--정상--></option>
					<option value="002">${CL.ex_close}  <!--휴업--></option>
					<option value="003">${CL.ex_shutDown}  <!--폐업--></option>
				</select>
			</dd>
			<dt>${CL.ex_inUseYN}  <!--사용여부--></dt>
			<dd>
				<select id="selUseYN" class="puddSetup" pudd-style="width:80px">
					<option value="">${CL.ex_all}  <!--전체--></option>
					<option value="Y" selected="selected">${CL.ex_use}  <!--사용--></option>
					<option value="N">${CL.ex_noUser}  <!--미사용--></option>
				</select>
			</dd>
		</dl>
		<dl class="next2">
			<dt>${CL.ex_customerGroup1}  <!--거래처그룹--></dt>
			<dd>
				<select id="selTrGroup1" class="puddSetup" pudd-style="width:80px">
				</select>
			</dd>
			<dt class="ar" style="width:72px;">${CL.ex_customerGroup2}  <!--거래처그룹2--></dt>
			<dd>
				<select id="selTrGroup2" class="puddSetup" pudd-style="width:80px">
				</select>
			</dd>
			<dt class="ar" style="width:65px;">${CL.ex_keyWord}  <!--검색어--></dt>
			<dd>
				<select class="puddSetup" pudd-style="width:80px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="CD_PARTNER">${CL.ex_code}  <!--코드--></option>
					<option value="LN_PARTNER">${CL.ex_vendor}  <!--거래처--></option>
					<option value="NO_COMPANY">${CL.ex_corporateRegiNum}  <!--사업자등록번호--></option>
					<option value="NM_CEO">${CL.ex_representive}  <!--대표자--></option>
					<option value="NM_BANK">${CL.ex_finCompany}  <!--금융기관--></option>
					<option value="NO_DEPOSIT">${CL.ex_accountNum}  <!--계좌번호--></option>
					<option value="NM_DEPOSIT">${CL.ex_accHolder}  <!--예금주--></option>
				</select>
			</dd>
			<dd><input type="text" autocomplete="off" id="txtSearchStr" style="width:100px;" /></dd>
			<dd><input type="button" id="btnSearch" value="${CL.ex_search}" /></dd> <!--검색-->
		</dl>
	</div>
	
	<!-- 건수 -->
	<div class="btn_div">
		<div class="left_div">
			<p class="mt5 fwb" id="valTotalCount">총 0건</p>
		</div>
	</div>
	
	<!-- 테이블 -->
	<div class="com_ta2 sc_head">
	<table>
		<colgroup>
			<col width="100"/>
			<col width=""/>
			<col width=""/>
			<col width="80"/>
			<col width=""/>
			<col width=""/>
			<col width="80"/>
		</colgroup>
		<tr>
			<th>${CL.ex_code}  <!--코드--></th>
			<th>${CL.ex_vendor}  <!--거래처--></th>
			<th>${CL.ex_corporateRegiNum}  <!--사업자등록번호--></th>
			<th>${CL.ex_representive}  <!--대표자--></th>
			<th>${CL.ex_finCompany}  <!--금융기관--></th>
			<th>${CL.ex_accountNum}  <!--계좌번호--></th>
			<th>${CL.ex_accHolder}  <!--예금주--></th>
		</tr>
	</table>	
	</div>
	
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height:266px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width="100"/>
				<col width=""/>
				<col width=""/>
				<col width="80"/>
				<col width=""/>
				<col width=""/>
				<col width="80"/>
			</colgroup>
		</table>
	</div>
</div><!-- //pop_con -->

<script>
	function fnInitPopupLayout( ){
// 		$("#title").text("예산단위");
		thisWidth = 828;
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
	    	popMWidth = 80;
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
	    	popMHeight = 90;
	    }
		var group = JSON.parse('${ViewBag.trGroup}');
		var group2 = JSON.parse('${ViewBag.trGroup2}');
		
		$("#selTrGroup1").empty();
		$("#selTrGroup1").append("<option value=''>전체</option>");
		$.each(group, function(idx, item) {
			$("#selTrGroup1").append("<option value='" + item.CODE + "'>" + item.NAME + "</option>");
		});
		//$("#selTrGroup1").val("").selectmenu('refresh');
		
		$("#selTrGroup2").empty();
		$("#selTrGroup2").append("<option value=''>전체</option>");
		$.each(group2, function(idx, item) {
			$("#selTrGroup2").append("<option value='" + item.CODE + "'>" + item.NAME + "</option>");
		});
		//$("#selTrGroup2").val("").selectmenu('refresh');
		
	}
	
	function fnSetPageParam( param ){
		param.trGbn = $("#selTrGbn").val();
		param.trType = $("#selTrType").val();
		param.useYN = $("#selUseYN").val();
		param.trOpenGbn = $("#selTrOpenGbn").val();
		param.searchStr = $("#txtSearchStr").val();
		param.trGroup = $("#selTrGroup1").val(); 
		param.trGroup2 = $("#selTrGroup2").val();
		return param;
	}
	
	function fnGridCommonCodeTable( data ){
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width="80"/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width="80"/>';
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
					$(tr).append('<td>' + val.CD_PARTNER + '</td>')
					$(tr).append('<td>' + val.LN_PARTNER + '</td>')
					if(val.NO_COMPANY != undefined){
						$(tr).append('<td>' + val.NO_COMPANY.substr(0,3) + '-' + val.NO_COMPANY.substr(3,2) + '-' + val.NO_COMPANY.substr(5) + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_CEO != undefined){
						$(tr).append('<td>' + val.NM_CEO + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_BANK != undefined){
						$(tr).append('<td>' + val.NM_BANK + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NO_DEPOSIT != undefined){
						$(tr).append('<td>' + val.NO_DEPOSIT + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_DEPOSIT != undefined){
						$(tr).append('<td>' + val.NM_DEPOSIT + '</td>')
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

			if(resultCount == 100){
				$("#tblCommonCode").append('<tr><td colspan="7"> 검색하지 않은 경우 100건의 거래처만 노출됩니다.</td> </tr>');
			}
			
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
		} );
	}
</script>