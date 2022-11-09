<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css"
	href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>
<!-- NpIncomeBody -->
<!-- 테이블 -->
<div class="pop_head">
	<h1>관리내역</h1>
	<a href="javascript:fnCloseLayerPop();" class="clo"><img
		id="imgClose" src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
</div>

<div class="pop_con" style="width: 748px;">
	<!-- 상세검색 -->
	<div class="top_box">
		<dl class="">
			<dt style="width: 50px;">${CL.ex_keyWord}</dt>
			<dd>
				<select class="puddSetup" pudd-style="width:100px"
					id="selSearchType">
					<option value="" selected="selected">${CL.ex_all}</option>
					<option value="">${CL.ex_code}</option>
					<option value="">${CL.ex_management}</option>
				</select>
			</dd>
			<dd>
				<input type="text" autocomplete="off" id="txtSearchStr"
					style="width: 200px; ime-mode: active;">
			</dd>
			<dd>
				<input type="button" id="btnSearch" class="puddSetup submit"
					value="${CL.ex_search}" />
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
				<col width="70" />
				<col width="130" />
			</colgroup>
			<tr>
				<th>${CL.ex_code}</th>
				<th>${CL.ex_managementDetails}</th>
			</tr>
		</table>
	</div>
	<div class="com_ta2 ova_sc2 bg_lightgray rowHeight"
		style="height: 324px;">
		<table id="tblCommonCode">
		</table>
	</div>
</div>
<!-- //pop_con -->

<script>
	function fnInitPopupLayout() {
		// 		$("#title").text("예산단위");
		thisWidth = 780;
		thisHeight = 580;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if (navigator.userAgent.indexOf("MSIE 6") > 0) { // IE 6.x
			popMWidth = 15;
			popMHeight = 80;
		} else if (navigator.userAgent.indexOf("MSIE 7") > 0) { // IE 7.x
			popMWidth = 15;
			popMHeight = 80;
		} else if (navigator.userAgent.indexOf("Firefox") > 0) { // FF
			popMWidth = 80;
			popMHeight = 72;
		} else if (navigator.userAgent.indexOf("Netscape") > 0) { // Netscape
			popMWidth = 15;
			popMHeight = 80;
		} else if (navigator.userAgent.toLowerCase().indexOf("chrome") > 0) {
			popMWidth = 15;
			popMHeight = 68;
		} else if (navigator.userAgent.indexOf("Trident") > 0) {
			popMWidth = 15;
			popMHeight = 90;
		}
	}

	function fnSetPageParam(param) {
		return param;
	}

	function fnGridCommonCodeTable(data) {
		oldData = data;
		$("#tblCommonCode").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="70">';
		colGroup += '<col width="130">';
		colGroup += '</colgroup>';
		$("#tblCommonCode").append(colGroup);

		var emptyTable = function() {
			$("#valTotalCount").text("${CL.ex_yeCount} 0 ${CL.ex_gun}");
			var tr = document.createElement('tr');
			$(tr).append(
					'<td colspan="' + $("#tblCommonCode colgroup col").length
							+ '">${CL.ex_dataDoNotExists}</td>');
			$("#tblCommonCode").append(tr);
		}

		var manyData = function() {
			$("#valTotalCount").text("${CL.ex_yeCount} " + data.length + " ${CL.ex_gun}");
			var tr = document.createElement('tr');
			$(tr)
					.append(
							'<td colspan="'
									+ $("#tblCommonCode colgroup col").length
									+ '">검색 결과가 많습니다. 검색어를 이용해주세요.<a onClick="maxCount=9999999;fnGridCommonCodeTable(oldData);">&nbsp;[계속]</a></td>');
			$("#tblCommonCode").append(tr);
		}

		if (data.length > maxCount && ($('#txtSearchStr').val() == '')) {
			manyData();
			return;
		}

		/* ${CL.ex_yeCount} 개수 확인 */
		var resultCount = 0;
		var searchType = $("#selSearchType").val();

		$.each(data, function(idx, val) {
			if (!((searchType == '' ? JSON.stringify(val)
					: (val[searchType] ? val[searchType] : '')).indexOf($(
					'#txtSearchStr').val()) < 0)) {
				resultCount++;
				var tr = document.createElement('tr');
				$(tr).data('data', val);
				$(tr).append('<td>' + val.CTD_CD + '</td>')
				$(tr).append('<td>' + val.CTD_NM + '</td>')

				$(tr).click(function() {
					if (!$(this).hasClass('on')) {
						$(this).parent().find('tr').removeClass('on');
						$(this).addClass('on');
						fnSetClickEvent($(this));
					}
				});

				$("#tblCommonCode").append(tr);
			}
		});

		$("#valTotalCount").text("${CL.ex_yeCount} " + resultCount + " ${CL.ex_gun}");
		
		if (resultCount > 0) {
			$('#tblCommonCode tr:eq(0)').addClass('on');
		}
		
		if (resultCount === 1) {
			fnSetDblClickEvent($('tr.on')[0]);
		}

		var userAction = 'search';
		$('#txtSearchStr').unbind().keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;

			/* ArrowUp : 38 */
			if (keyCode.toString() === '38') {
				if($('tr.on').prev('tr').length > 0){
					var elem = $('tr.on').prev('tr');
					$('tr.on').removeClass('on');
					$(elem).addClass('on');
					$("#hidSelectVal").val(JSON.stringify($(elem).data('data')));
					userAction = 'ArrowUp';
				}
			}
			/* ArrowDown : 40 */
			else if (keyCode.toString() === '40') {
				if($('tr.on').next('tr').length > 0){
					var elem = $('tr.on').next('tr');
					$('tr.on').removeClass('on');
					$(elem).addClass('on');
					$("#hidSelectVal").val(JSON.stringify($(elem).data('data')));
					userAction = 'ArrowDown';
				}
			}
			/* Enter : 13 */
			else if (keyCode.toString() === '13') {
				if(userAction === ''){
					$('#btnSearch').click();
					userAction = 'Enter';
				} else {
					fnSetDblClickEvent($('tr.on')[0]);
				}
			} else {
				userAction = '';
			}
			
			if(($('.on').height() * ($('.on').index() + 1)) - $('.rightContents').scrollTop() > $('.rightContents').height()){
				$('.rightContents').scrollTop(($('.on').height() * $('.on').index()));
			} else if(($('.on').height() * $('.on').index()) < $('.rightContents').scrollTop()){
				$('.rightContents').scrollTop($('.rightContents').scrollTop() - $('.on').height());
			}
		});
		
		if (!resultCount) {
			emptyTable();
		}
		maxCount = Number(staticMaxCount.toString());
		fnInitTableEvent();
	}

	//휠스크롤
	function fixDataOnWheel() {
		if (event.wheelDelta < 0) {
			DataScroll.doScroll('scrollbarDown');
		} else {
			DataScroll.doScroll('scrollbarUp');
		}
		table1Scroll();
	}
	//각 테이블 스크롤 동기화
	function table1Scroll() {
		$(".table3 .leftContents").scrollTop(
				$(".table3 .rightContents").scrollTop());
		$(".table3 .rightHeader").scrollLeft(
				$(".table3 .rightContents").scrollLeft());
	}
</script>