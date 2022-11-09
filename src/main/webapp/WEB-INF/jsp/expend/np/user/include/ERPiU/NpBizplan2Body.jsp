<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>

<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_businessPlan}  <!--사업계획--></h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_searchCondition}  <!--조회조건--></dt>
			<dd>
				<select class="selectmenu" id="selIsConnectedBudget" style="width:150px;">
					<option value="">${CL.ex_all}  <!--전체--></option>
					<option value="Y" selected="selected">${CL.ex_connBussinessPlan}  <!--연결사업계획--></option>
				</select>
			</dd>
			<dt class="ar" style="width:65px;">${CL.ex_endDate}  <!--종료년월--></dt>
			<dd>
				<div class="dal_div">
					<input type="text" autocomplete="off" id="txtBizplanCloseMonth" value="2017-02" class="w113"/>
					<a href="#n" id="btnBizplanCloseMonth" class="button_dal"></a>
				</div>
			</dd>
		</dl>
		<dl>
		<dt>${CL.ex_inUseYN}  <!--사용여부--></dt>
		<dd>
			<select class="selectmenu" id="selUseYNCondition" style="width:150px;">
				<option value="A">${CL.ex_all}  <!--전체--></option>
				<option value="Y" selected="selected">${CL.ex_use}  <!--사용--></option>
				<option value="N">${CL.ex_noUser}  <!--미사용--></option>
			</select>
		</dd>
		<dt class="ar" style="width:65px;">${CL.ex_keyWord}  <!--검색어--></dt>
		<dd>
			<select class="puddSetup" pudd-style="width:100px" id="selSearchType">
				<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
				<option value="CD_BIZPLAN">${CL.ex_code}  <!--코드--></option>
				<option value="NM_BIZPLAN">${CL.ex_businessPlan}  <!--사업계획--></option>
				<option value="NM_BIZ_LEVEL">${CL.ex_high}  <!--상위--></option>
				<option value="NM_BIZ_LEVEL2">${CL.ex_higher}  <!--차상위--></option>
				<option value="NM_BIZ_LEVEL3">${CL.ex_highest}  <!--차차상위--></option>
			</select>
		</dd>
		<dd><input type="text" autocomplete="off" id="txtSearchStr" style="width:180px;" /></dd>
		<dd><input type="button" id="btnSearch" value="${CL.ex_search}" /></dd><!--검색-->
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
				<col width="5%"/>
				<col width="15%"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="20%"/>
			</colgroup>
			<tr>
				<th><input type="checkbox" id="chk_bizplanAllChk"/></th>
				<th>${CL.ex_code}  <!--코드--></th>
				<th>${CL.ex_businessPlan}  <!--사업계획--></th>
				<th>${CL.ex_high}  <!--상위--></th>
				<th>${CL.ex_higher}  <!--차상위--></th>
				<th>${CL.ex_highest}  <!--차차상위--></th>
			</tr>
		</table>
	</div>
	
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height:270px;">
		<table id="tblCommonCode">
		<colgroup>
				<col width="5%"/>
				<col width="15%"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="20%"/>
			</colgroup>
		</table>
	</div>
</div><!-- //pop_con -->

<script>
	function fnInitPopupLayout( ){
// 		$("#title").text("사업계획");
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
		var nowDate = new Date();
		fnSetDatepicker("#txtBizplanCloseMonth","yy-mm");
		$("#txtBizplanCloseMonth").val(nowDate.getFullYear() + "-" + ((nowDate.getMonth() + 1)<10?'0'+(nowDate.getMonth() + 1):(nowDate.getMonth() + 1)));
		
		$("#txtBizplanCloseMonth").keyup(function(e){
			if( ( 48 <= e.keyCode && e.keyCode <= 57 ) || (  96 <= e.keyCode && e.keyCode <= 105  ) ){
				var dataLength = $("#" + $(this).prop("id")).val().length;
				if( dataLength == 4 ){
					$("#" + $(this).prop("id")).val($("#" + $(this).prop("id")).val() + "-");
				}	
			}else if( e.keyCode == 13){
				$("#btnSearch").click();
			}
		});
		
		$('#chk_bizplanAllChk').click(function (){
			$('.chkBizplanCode').prop('checked', $(this).prop('checked'));
		});
	}
	
	function fnSetPageParam( param ){
		/* 	사업계획 파라미터 정의 
			useYNCondition : 사용유무 검색조건(A:전체, Y:사용, N:미사용)
			isConnectedBudget : 연결사업계획 조건( Y:연결사업계획 , '':전체)
			budgetCode : 예산단위 코드
		*/
		param.isConnectedBudget = $("#selIsConnectedBudget").val();
		param.bizplanCloseMonth = $("#txtBizplanCloseMonth").val().toString().replace(/-/g, '');
		param.useYNCondition = $("#selUseYNCondition").val();
		param.searchStr = $("#txtSearchStr").val();
		param.erpBudgetSeq = (param.erpBudgetSeq || '');
		return param;
	}
	
	function fnGridCommonCodeTable( data ){
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="5%"/>';
		colGroup += '<col width="15%"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="20%"/>';
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
					$(tr).append('<td> <input type="checkbox" class="chkBizplanCode" value="' + escape(JSON.stringify(val)) + '"/> </td>')
					$(tr).append('<td>' + val.CD_BIZPLAN + '</td>')
					$(tr).append('<td>' + val.NM_BIZPLAN + '</td>')
					if(val.NM_BIZ_LEVEL != undefined){
						$(tr).append('<td>' + val.NM_BIZ_LEVEL + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_BIZ_LEVEL2 != undefined){
						$(tr).append('<td>' + val.NM_BIZ_LEVEL2 + '</td>')
					}else{
						$(tr).append('<td></td>')
					}
					if(val.NM_BIZ_LEVEL3 != undefined){
						$(tr).append('<td>' + val.NM_BIZ_LEVEL3 + '</td>')
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
		} );
	}
</script>