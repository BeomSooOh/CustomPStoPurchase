<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_budgetUnit}  <!--예산단위--></h1>
	<a href="javascript:fnCloseLayerPop();" class="clo" ><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>					
			<dt>${CL.ex_incomeEndDate}  <!--소득종료일--></dt>
			<dd>
				<div class="dal_div">
					<input type="text" autocomplete="off" id="txtStdYM" value="" class="inpDateBox w113" />
					<a href="#n" id="btnStdYM" class="button_dal"></a>
				</div>
			</dd>
			<dt>${CL.ex_search}  <!--검색--></dt>
			<dd>
				<select class="puddSetup" pudd-style="width:90px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="PER_NM">${CL.ex_incomePeopleNm}  <!--소득자명--></option>
					<option value="REG_NO">${CL.ex_peopleNum}  <!--주민등록번호--></option>
				</select>
			</dd>
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr" style="width:130px;" />
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
				<col width="130"/>
				<col width="130"/>
				<col width=""/>
			</colgroup>
			<tr>
				<th>${CL.ex_incomePeopleCode}  <!--소득자코드--></th>
				<th>${CL.ex_incomePeopleNm}  <!--소득자명--></th>
				<th>${CL.ex_peopleNum}  <!--주민등록번호--></th>
			</tr>
		</table>	
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight"  style="height:290px;">
		<table id="tblCommonCode">
			<colgroup>
				<col width="130"/>
				<col width="130"/>
				<col width=""/>
			</colgroup>
		</table>
	</div>
</div><!-- //pop_con -->

<script>
	function fnInitPopupLayout( ){
		thisWidth = 595;
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
		var nowDate = new Date();
		fnSetDatepicker("#txtStdYM","yy-mm-dd");
		$("#txtStdYM").val(nowDate.getFullYear() + "-" + ((nowDate.getMonth() + 1)<10?'0'+(nowDate.getMonth() + 1):(nowDate.getMonth() + 1)));
		
		$("#txtStdYM").keyup(function(e){
			if( ( 48 <= e.keyCode && e.keyCode <= 57 ) || (  96 <= e.keyCode && e.keyCode <= 105  ) ){
				var dataLength = $("#" + $(this).prop("id")).val().length;
				if( dataLength == 4 ){
					$("#" + $(this).prop("id")).val($("#" + $(this).prop("id")).val() + "-");
				}	
			}else if( e.keyCode == 13){
				$("#btnSearch").click();
			}
		});
	}
	
	function fnSetPageParam( param ){
		param.stdYM = $("#txtStdYM").val().toString().replace(/-/g, '');
		param.searchStr = $("#txtSearchStr").val();
		return param;
	}
	
	function fnGridCommonCodeTable( data ){
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
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
					var regNoFull = val.REG_NO;
					var regNo = regNoFull.substring(0,6);
					var displayRegNo = regNo + " - *******";
					$(tr).data('data', val);
					$(tr).append('<td>' + val.PER_CD + '</td>')
					$(tr).append('<td>' + val.PER_NM + '</td>')
					$(tr).append('<td>' + displayRegNo + '</td>')
					$("#tblCommonCode").append(tr);
				}
				
			});
			
			$("#valTotalCount").text("총 " + resultCount + " 건");
		}
		fnInitTableEvent ( );
		
		if ( resultCount > 1 ) {
			$('#tblCommonCode tr:eq(0)').addClass('on');
		}
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