<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_empResi}  <!--사원등록--></h1>
	<a href="javascript:fnCloseLayerPop();" class="clo" ><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
		<dt>${CL.ex_workDiv}  <!--재직구분--></dt>
		<dd>
			<select id="selWorkSts" class="puddSetup" pudd-style="width:80px">
				<option value="">${CL.ex_all}  <!--전체--></option>
				<option value="" selected="selected">${CL.ex_work}  <!--재직--></option>
			</select>
		</dd>
		<dt>${CL.ex_applyForm}  <!--고용형태--></dt>
		<dd>
			<select id="selWorkType" class="puddSetup" pudd-style="width:80px">
<!-- 			고용형태(null:전체,001:상용직,002:일용직,003:파견직,004:도급직) -->
				<option value="">${CL.ex_all}  <!--전체--></option>
				<option value="001" selected="selected">${CL.ex_commUse}  <!--상용직--></option>
				<option value="002">${CL.ex_everyDayUse}  <!--일용직--></option>
				<option value="003">${CL.ex_dispatchUse}  <!--파견직--></option>
				<option value="004">${CL.ex_subcontractUse}  <!--도급직--></option>
			</select>
		</dd>
		</dl>
		<dl class="next2">
			<dt class="ar" style="width:51px;">${CL.ex_keyWord}  <!--검색어--></dt>
			<dd>
				<select class="puddSetup" pudd-style="width:80px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="NM_DEPT">${CL.ex_department}  <!--부서--></option>
					<option value="NO_EMP">${CL.ex_employeeNumber}  <!--사원번호--></option>
					<option value="NM_KOR">${CL.ex_fullName}  <!--이름--></option>
				</select>
			</dd>
			<dd><input type="text" autocomplete="off" id="txtSearchStr" style="width:163px;" /></dd>
			<dd><input type="button" id="btnSearch" value="${CL.ex_search}" /></dd> <!--검색-->
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
				<col width=""/>
				<col width="105"/>
				<col width="90"/>
			</colgroup>
			<tr>
				<th>${CL.ex_department}  <!--부서--></th>
				<th>${CL.ex_employeeNumber}  <!--사원번호--></th>
				<th>${CL.ex_fullName}  <!--이름--></th>
			</tr>
		</table>	
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height:290px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width=""/>
				<col width="105"/>
				<col width="90"/>
			</colgroup>
		</table>
	</div>
</div><!-- //pop_con -->

<script>
	function fnInitPopupLayout( ){
// 		$("#title").text("예산단위");
		thisWidth = 438;
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
	}
	
	function fnSetPageParam( param ){
		/* 	사원 선택 팝업은 전체 사원을 표시할 수 도있으며 부서에 포함된 사원만 표시 할 수 있다.
			따라서 부서에 포함된 사원을 표시하려면 부서코드를 받아야 한다.
		*/
		param.workType = $("#selWorkType").val();
		param.searchStr = $("#txtSearchStr").val();
		return param;
	}
	
	function fnGridCommonCodeTable( data ){
		var newData = [];
		for(var i=0; i < data.length; i++){
			var item = data[i];
			if(  ( item.DT_RETIRE || '00000000'  ) == '00000000'){
				newData.push(item);
			}
		}
		data = newData;
		
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width=""/>';
		colGroup += '<col width="105"/>';
		colGroup += '<col width="90"/>';
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
					$(tr).append('<td>' + val.NM_DEPT + '</td>')
					$(tr).append('<td>' + val.NO_EMP + '</td>')
					$(tr).append('<td>' + val.NM_KOR + '</td>')
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
		} );
	}
</script>