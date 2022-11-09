<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<script src="${pageContext.request.contextPath}/js/jquery.mask.min2.js"></script>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>



<!-- NpTrBody -->
<!-- 테이블 -->
<div class="pop_head">
	<h1>${CL.ex_vendor}</h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img id="imgClose" src="${pageContext.request.contextPath}/Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<form id="sendForm" name="sendFormPop" method="post">
	<input type="hidden" name="param" value="" id="param"/>
	<input type="hidden" name="data" value="" id="data"/>
</form>

<div class="pop_con">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl>
			<dt style="width: 55px;">${CL.ex_inUseYN}</dt>
			<dd>
				<select id="useYN" class="puddSetup" pudd-style="width:100px">
					<option value="1" selected="selected">${CL.ex_use}</option>
					<option value="">${CL.ex_all}</option>
				</select>
			</dd>
			<dt>${CL.ex_keyWord}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px" id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}</option>
					<option value="trSeq">${CL.ex_code}</option>
					<option value="trName">${CL.ex_vendor}</option>
					<option value="trRegNumber">${CL.ex_businessNumber}</option>
					<option value="baNb">${CL.ex_accountNum}</option>
					<option value="depositor">${CL.ex_representive}</option>
				</select>
			</dd>
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr" style="width: 170px; ime-mode: active;">
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
		
        <div class="right_div">
            <div class="controll_btn p0">
            	<button type="button" id="btnAddTrade">${CL.ex_newtradebutton}</button>
            </div>
		</div>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2 sc_head">
		<table>
			<colgroup>
				<col width="100" />
				<col width="" />
				<col width="120" />
				<col width="150" />
				<col width="100" />
			</colgroup>
			<tr>
				<th>${CL.ex_category}</th>
				<th>${CL.ex_vendor}</th>
				<th>${CL.ex_businessNumber}</th>
				<th>${CL.ex_accountNum}</th>
				<th>${CL.ex_representive}</th>
			</tr>
		</table>
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight" style="height: 324px;">
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
	var configNewTradeInsert = 0;
	function fnInitPopupLayout ( ) {
		// 		$("#title").text("예산단위");
		thisWidth = 699;
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
		
		fnAdvElemInit();
	}
	
	function fnAdvElemInit(){
		var opt = ${ViewBag.param}
		
		$('#btnAddTrade').click(function (){
			fnSetLayerInit();
			$('#layerAddTradeModal').show();
			$('#layerAddTrade').show();
		});
		
		if(opt.param.trOpt == 1){
			$('#layerAddTradeModal').hide();
			$('#layerAddTrade').hide();
			$('#btnAddTrade').hide();
		}
	}
	
	function fnSetPageParam ( param ) {
		/* 1: 일반거래처, 2: 금융거래처*/
		param.trType = ( param.trType || '' );
		param.trSeq = ''; /* $ ( "#txtSearchStr" ).val ( ); */
		param.trName = ''; /* $ ( "#txtSearchStr" ).val ( ); */
		param.trDetailType = '';
		return param;
	}

	function fnGridCommonCodeTable ( data ) {
		oldData = data;
		$ ( "#tblCommonCode" ).empty ( );
		var colGroup = '<colgroup>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width="120"/>';
		colGroup += '<col width="150"/>';
		colGroup += '<col width="100"/>';
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
			$ ( tr ).append ( '<td colspan="' + $ ( "#tblCommonCode colgroup col" ).length + '">${CL.ex_searchMent1}<a onClick="maxCount=9999999;fnGridCommonCodeTable(oldData);">&nbsp;[계속]</a></td>' );
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
		var useYN = $ ( '#useYN' ).val ( );

		$.each ( data, function ( idx, val ) {
			if ( !( ( searchType == '' ? JSON.stringify ( val ) : ( val [ searchType ] ? val [ searchType ] : '' ) ).indexOf ( $ ( '#txtSearchStr' ).val ( ) ) < 0 ) && !( ( useYN == '' ? JSON.stringify ( val ) : ( val [ "useYN" ] ? val [ "useYN" ] : '' ) ).indexOf ( $ ( '#useYN' ).val ( ) ) < 0 ) ) {
				resultCount++;
				var tr = document.createElement ( 'tr' );
				$ ( tr ).data ( 'data', val );
				$ ( tr ).append ( '<td>' + val.trSeq + '</td>' )
				$ ( tr ).append ( '<td>' + val.trName + '</td>' )

				$ ( tr ).append ( ( val.trRegNumber ? '<td>' + val.trRegNumber.substr(0,3) + '-' + val.trRegNumber.substr(3,2) + '-' + val.trRegNumber.substr(5) + '</td>' : '<td></td>' ) );
				$ ( tr ).append ( ( val.baNb ? '<td>' + val.baNb + '</td>' : '<td></td>' ) );
				$ ( tr ).append ( ( val.ceoName ? '<td>' + val.ceoName + '</td>' : '<td></td>' ) );

				$ ( tr ).click ( function ( ) {
					if ( !$ ( this ).hasClass ( 'on' ) ) {
						$ ( this ).parent ( ).find ( 'tr' ).removeClass ( 'on' );
						$ ( this ).addClass ( 'on' );
						fnSetClickEvent ( $ ( this ) );
						$('#txtSearchStr').focus();
					}
				} );
				$ ( "#tblCommonCode" ).append ( tr );
				
				if(resultCount >= 500){
					/* 최대 500${CL.ex_gun}만 표시한다. - 그 외는 검색으로 대체한다. */
					/* 사용자가 500${CL.ex_gun}이 넘는 데이터 기준으로 한${CL.ex_gun}한${CL.ex_gun} 찾는 액션은 하지 않을것이라 생각한다. */
					return false;
				}
			}
		} );

		$ ( "#valTotalCount" ).text ( "${CL.ex_yeCount} " + resultCount + " ${CL.ex_gun}" );

		if ( resultCount === 1 ) {
			fnSetDblClickEvent ( $ ( '#tblCommonCode tr:eq(0)' ) [ 0 ] );
		}

		if ( resultCount > 0 ) {
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
			
			if(($('tr.on').height() * ($('tr.on').index() + 1)) - $('#tblCommonCode').parent('div').scrollTop() > $('#tblCommonCode').parent('div').height()){
				$('#tblCommonCode').parent('div').scrollTop(($('tr.on').height() * $('tr.on').index()));
			} else if(($('tr.on').height() * $('tr.on').index()) < $('#tblCommonCode').parent('div').scrollTop()){
				$('#tblCommonCode').parent('div').scrollTop($('#tblCommonCode').parent('div').scrollTop() - $('tr.on').height());
			}
		} );

		if ( !resultCount ) {
			emptyTable ( );
		}
		maxCount = Number ( staticMaxCount.toString ( ) );
		fnInitTableEvent ( );
	}
	var _checkTrSeq = '';
	var _checkYN = '';
	
	/*	[신규거래처등록] 레이어 팝업 초기화
	-------------------------------------------- */
	function fnSetLayerInit(){
		/* 거래처 코드 */
		$('#txtTrSeq').val('');
		
		/* 중복 확인 */
		$('#btnExsitsCheck').unbind('click').click(function (){
			if( !$('#txtTrSeq').val() ){
				alert('거래처 코드를 입력하세요.');
				return;
			}
			
			$.ajax({
				type : 'post',
				url : '/exp/expend/np/admin/code/ExProcDataSelect.do',
				datatype : 'json',
				async : true,
				data : {
					procType : 'tradeExists'
					, trSeq : $('#txtTrSeq').val() 
				},
				success : function(result) {
					if(result.result.resultCode == 'SUCCESS'){
						
						var aData = result.result.aData;
						if(aData.chkResult == 'Y'){
							alert(aData.chkResultMessage);
							_checkTrSeq = aData.trSeq;
							_checkYN = 'Y';
						}else {
							alert(aData.chkResultMessage);
						}
					}else{
						alert('중복확인에 실패하였습니다.');
						console.log(result);
					}
				},
				error : function(result) {
					console.error(result);
				}
			});
		});
		
		/* 금융기관 팝업 호출 */
		$('#btnJiro').unbind('click').click(function (){
			fnCommonCode_btrName('bank',{});
		});
		
		/* 자동채번 */
		$('#btnAuthTrSeq').unbind('click').click(function (){
			$.ajax({
				type : 'post',
				url : '/exp/expend/np/admin/code/ExProcDataSelect.do',
				datatype : 'json',
				async : true,
				data : {
					procType : 'tradeAutoTrSeq'
				},
				success : function(result) {
					if(result.result.resultCode == 'SUCCESS'){
						$('#txtTrSeq').val(result.result.aData.trSeq);
						_checkTrSeq = result.result.aData.trSeq;
						_checkYN = 'Y';
					}else{
						alert('자동채번 생성에 실패하였습니다.');
						console.log(result);
					}
				},
				error : function(result) {
					console.error(result);
				}
			});
		});
		
		/* 거래처 명 */	
		$('#txtTradeName').val('');
		
		/* 사업자 번호 */
		$('#txtBusinessNb').val('');
		$('#txtBusinessNb').mask("000-00-00000", {placeholder: "___-__-_____"});
		
		/* 업태 */
		$('#txtBusinessGbn').val('');
		
		/* 종목 */
		$('#txtBusinessType').val('');
		
		$('#txtJiroCd').val('');
		$('#txtJiroNm').val('');
		$('#txtBaNb').val('');
		$('#txtDepositor').val('');
		
		
		/*	[신규거래처등록] 거래처 등록 진행
		-------------------------------------------- */
		$('#btnTradeAddOk').unbind('click').click(function (){
			if ( !$('#txtTrSeq').val() ){
				alert('거래처 코드를 입력하세요.');
				return;
			} else if ( _checkTrSeq != $('#txtTrSeq').val() ){
				alert('중복확인을 진행하세요.');
				return;
			} else if (_checkYN != 'Y') {
				alert('중복확인을 진행하세요.');
				return;
			} else if ( !$('#txtTradeName').val() ) {
				alert('거래처명을 입력하세요.');
				return;
			} else if ( !$('#txtBusinessNb').val() && ($('#selTradeGbn option:selected').val() == '1' )) {
				alert('사업자번호를 입력하세요.');
				return;
			} else if ( $('#txtBusinessNb').val().replace(/-/gi, '').length != 10  && ($('#selTradeGbn option:selected').val() == '1' )){
				alert('사업자번호를 확인하세요.');
				return;
			}
			
			var saveParam = {
				trSeq :$('#txtTrSeq').val()
				, trName : $('#txtTradeName').val()
				, trGbn : $('#selTradeGbn').val()
				, businessNb : $('#txtBusinessNb').val().replace(/-/gi, '')
				, businessGbn : $('#txtBusinessGbn').val()
				, businessType : $('#txtBusinessType').val()
				, procType : 'tradeInsert'
				, configNewTradeInsert : configNewTradeInsert
				, baNb : $('#txtBaNb').val()
				, jiroCd : $('#txtJiroCd').val()
				, depositor : $('#txtDepositor').val()
			};
			
			$.ajax({
				type : 'post',
				url : '/exp/expend/np/admin/code/ExProcDataSelect.do',
				datatype : 'json',
				async : true,
				data : saveParam,
				success : function(result) {
					if(result.result.resultCode == 'SUCCESS'){
						var item = result.result.aData;
						if(item.saveResult == 'N'){
							alert(item.chkResultMessage);
						} else if(item.saveResult == 'REG'){
							if(confirm(item.chkResultMessage)){
								configNewTradeInsert = 1;
								$('#btnTradeAddOk').click();
			        		}
							else{
								configNewTradeInsert = 0;
							}
						} else {
							$('#btnSearch').click();
							$('#layerAddTradeModal').hide();
							$('#layerAddTrade').hide();	
						}
					}else{
						alert('거래처 저장에 실패하였습니다.');
					}
				},
				error : function(result) {
					console.error(result);
				}
			});
		});

		/*	[신규거래처등록] 등록 취소
		-------------------------------------------- */
		$('#btnTradeAddCancel').click(function (){
			$('#layerAddTradeModal').hide();
			$('#layerAddTrade').hide();	
		});
		
		/* [신규거래처등록] 구분값 이벤트 */
		$('#selTradeGbn').change(function (){
			if($('#selTradeGbn option:selected').val()!='1'){
				$('#businessCheckIcon').hide();
			}	
			else{
				$('#businessCheckIcon').show();
			}
		});
	}	
	
	var popupWidth = 600;
	var popupHeight = 400;
	var basicPopupType = "";
	
	function fnCallCommonCodePop(param, data){
		if(param.code != undefined){
			param.code = param.code.toLowerCase();	
		}
		data = (data || []);
		fnDirectSearchCommonCode(param, data);
	}
	
	/* 공통코드 호출 */
	function fnDirectSearchCommonCode(params, paramData){
		if(!params.code){
			params.code = 'tr';
		}
		var tempParam = [];
		var ajaxParam = {};
		basicPopupType = params.popupType;
		tempParam["param"] = params;
		tempParam["param"].popupType = "1";
		tempParam["data"] = paramData;
		ajaxParam.param = JSON.stringify(tempParam["param"]);
		ajaxParam.data = JSON.stringify(tempParam["data"]);
		/* 공통코드 호출 */
		$.ajax({
	        type : 'post',
	        url : "NpCommonCodePop.do",
	        datatype : 'json',
	        async : true,
	        data : ajaxParam,
	        success : function( data ) {
	        	if(!data.result){
	        		return;
	        	}
	        	
	        	if(!!(JSON.parse(params.param).selectedBudgetSeqs)){
	        		var newAaData = [];
	        		for(var i = 0; i < data.result.aaData.length; i++ ){
	        			var item = data.result.aaData[i];
	        			if( (JSON.parse(params.param).selectedBudgetSeqs.indexOf('|' + (item.erpBudgetSeq || item.BGT_CD) + '|') == -1) ){
	        				newAaData.push(item);
	        			}
	        		}
	        		data.result.aaData = newAaData;
	        	}
	        	
	        	if( data != null && data.result != null && data.result.aaData != null && data.result.aaData.length == 1){
	        		fnDirectSearchCallback(params, data);
	        	}else{
	        		params.popupType = basicPopupType;
		        	switch(params.popupType.toString()){
						case "2" :
							/* 일반팝업 호출 */
							fnOpenCommonCodeBasicPop(params, data.result.aaData);
							break;
						default :
							console.log("코드 조회 방식 미설정");
							break;
					}
	        	}
	        },
	        error : function( data ) {
	            console.log('오류다!확인해봐!이상해~!!악!');
	        }
	    });
	}
	
	/* 기본 팝업 오픈 */
	function fnOpenCommonCodeBasicPop (params, data){
		$("#param").val(JSON.stringify(params));
		$("#data").val(JSON.stringify(data));
		if(data.length == 1){
			/* 윈도우 팝업 콜백 */
			data[0].code = params.code;
			data[0].dummy = params.dummy;
    		var callbackFunc = window[params.callbackFunction];
    		if( typeof(callbackFunc) == "function" ){
    			callbackFunc(data[0]);
    		}else{
    			alert("콜백함수를 정의하여 주세요.");
    		}
		}else {
			var winHeight = document.body.clientHeight; // 현재창의 높이
			var winWidth = document.body.clientWidth; // 현재창의 너비
			var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
			var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 
	
			var popX = winX + (winWidth - popupWidth)/2;
			var popY = winY + (winHeight - popupHeight)/2;
			
			
			var pop = window.open('', 'JiroPop', "width=" + JSON.parse(params.param).widthSize + ", height=" + JSON.parse(params.param).heightSize + ", left=" + popX + ", top=" + popY);
			
			sendForm.target = "JiroPop";
			sendForm.method = "post";
			sendForm.action = "NpCommonCodePop.do";;
			sendForm.submit();
			sendForm.target = "";
			
			if(pop != null){
				if(pop.focus){
					pop.focus();
				}else{
					alert('팝업 차단 설정을 확인 하세요.');
				}
			}
		}
	}
	
	/* ## 공통코드 - 팝업호출 ## */
	function fnCommonCodePop(code, obj, callback, data) {
		/* [ parameter ] */
		/*   - obj : 전송할 파라미터 */
		obj = (obj || {});
		/*   - callback : 코백 호출할 함수 명 */
		callback = (callback || '');
		/*   - data : 더미 */
		data = (data || {});

		/* 팝업 호출 */
		obj.widthSize = 780;
		obj.heightSize = 582;

		fnCallCommonCodePop({
			code : code,
			popupType : 2,
			param : JSON.stringify(obj),
			callbackFunction : callback,
			dummy : JSON.stringify(data)
		});
	}
	
	/* ## 공통코드 - 금융기관 ## */
	function fnCommonCode_btrName(code, param) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - param : 현재 작성중인 내역의 모든 정보 */
		param = (param || {});
		param.callback = 'fnCommonCode_btrName_callback';
		/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
		param.searchStr = '';

		/* 팝업 호출 */
		fnCommonCodePop('bank', param, param.callback);

		/* [ return ] */
		return;
	}

	function fnCommonCode_btrName_callback(param) {
		/* iCUBE example : {"BANK_NM":"외환(구)","BANK_CD":"050","code":"bank","dummy":"{}"} */

		/* [ parameter ] */
		/*   - param : 공통코드 팝업에서 사용자가 선택하여 반환된 정보 */
		
		$('#txtJiroNm').val(param.BANK_NM||'');
		$('#txtJiroCd').val(param.BANK_CD||'');

		/* [ return ] */
		return;
	}
</script>


<!-- 거래처 신규 생성 레이어 팝업 -->
<div class="pop_wrap_dir" style="width: 425px; top: 50%; left: 50%; margin-left: -190px; margin-top: -210px; display: none;" id="layerAddTrade">
	<div class="pop_head">
		<h1>${CL.ex_newtradebutton}</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table class="iCUBE">
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th>
						<img src="../../../Images/ico/ico_check01.png" alt="">
						${CL.ex_vendorCode}
					</th>
					<td>
						<input class="input_search fl" id="txtTrSeq" type="text" value="" style="width: 100px;" placeholder=""/> 
			            <div class="controll_btn p0" style="margin-left: 5px;">
			            	<button type="button" id="btnExsitsCheck">${CL.ex_doublecheck}</button>
			            	<button type="button" id="btnAuthTrSeq">${CL.ex_autocount}</button>
			            </div>
					</td>
				</tr>
				<tr>
					<th>
						<img src="../../../Images/ico/ico_check01.png" alt="">
						${CL.ex_vendorNm}
					</th>
					<td>
						<input type="text" autocomplete="off" id="txtTradeName" class="" value="" style="width: 257px;"/>
					</td>
				</tr>
				<tr>
					<th>
						<img src="../../../Images/ico/ico_check01.png" alt="">
						${CL.ex_category}
					</th>
					<td>
		                <select id="selTradeGbn" class=""  style="width: 257px;" >
		                    <option value="1" selected> 1.${CL.ex_normal} </option>
		                    <option value="2"> 2.${CL.ex_trade} </option>
		                    <option value="4"> 4.${CL.ex_others} </option>
		                </select>					
					</td>
				</tr>
				<tr>
					<th>
						<img id="businessCheckIcon" src="../../../Images/ico/ico_check01.png" alt="">
						${CL.ex_businessNumber}
					</th>
					<td>
						<input type="text" autocomplete="off" id="txtBusinessNb" class="" value="" style="width: 257px;" />
					</td>
				</tr>
				<tr>
					<th>${CL.ex_finCompany}</th>
					<td>
						<input class="input_search fl" id="txtJiroNm" type="text" value="" style="width: 233px;" placeholder="" readonly="readonly" />
						<input type="hidden" id="txtJiroCd" value=""/>
						<a href="#" class="btn_search fl" id="btnJiro" style="margin-left: -1px;"></a> 
					</td>
				</tr>
				<tr>
					<th>${CL.ex_accountNum}</th>
					<td>
						<input type="text" autocomplete="off" id="txtBaNb" class="" value="" style="width: 257px;"/>
					</td>
				</tr>
				<tr>
					<th>${CL.ex_accHolder}</th>
					<td>
						<input type="text" autocomplete="off" id="txtDepositor" class="" value="" style="width: 257px;"/>
					</td>
				</tr>
				<tr>
					<th>${CL.ex_business}</th>
					<td>
						<input type="text" autocomplete="off" id="txtBusinessGbn" class="" value="" style="width: 257px;"/>
					</td>
				</tr>
				<tr>
					<th>${CL.ex_event}</th>
					<td>
						<input type="text" autocomplete="off" id="txtBusinessType" class="" value="" style="width: 257px;"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnTradeAddOk" value="${CL.ex_enrollment}" /> 
			<input type="button" id="btnTradeAddCancel" class="gray_btn" value="${CL.ex_cancel}" />  <!--취소-->
		</div>
	</div>
</div>
<div class="modal" style="display: none;" id="layerAddTradeModal"></div>
<!-- 거래처 신규 생성 레이어 팝업 -->