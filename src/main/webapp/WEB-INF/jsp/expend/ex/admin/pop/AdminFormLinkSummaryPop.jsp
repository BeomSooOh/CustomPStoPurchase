<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">
	window.resizeTo ( 706, 596 );

	var dispValue = {
		result: [ ],
		search: [ ],
		hasFormLink: [ ]
	}

	$ ( document ).ready ( function ( ) {
		fnInitEvent ( );
		fnFormLinkSummarySearch ( );
	} );

	function fnInitEvent ( ) {
		/* resize event */
		$ ( '#chkSummaryItem_All' ).click ( function ( ) {
			/* 체크박스 전체 선택 및 해제 */
			$ ( 'input[name=' + $ ( this ).prop ( 'name' ) + ']' ).not ( this ).prop ( 'checked', $ ( this ).is ( ':checked' ) );
			$.each ( $ ( 'input[name=' + $ ( this ).prop ( 'name' ) + ']' ).not ( this ), function ( checkboxIndex, checkbox ) {
				fnCheckedItem ( $ ( checkbox ) );
			} );
		} );

		$ ( "#btnSubmit" ).click ( function ( ) {
			/* 확인 이벤트 */
			fnReflect ( );
		} );

		$ ( "#btnCancel" ).click ( function ( ) {
			/* 취소 이벤트 */
			self.close ( );
		} );

		$ ( "#btnSearch" ).click ( function ( ) {
			/* 검색 이벤트 */
			dispValue.search = new Array ( );
			dispValue.result.forEach ( function ( item, itemIndex ) {
				if ( item.summaryName.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
					dispValue.search.push ( item );
				} else if ( item.summaryCode.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
					dispValue.search.push ( item );
				} else if ( dispValue.hasFormLink.indexOf ( item.summaryCode ) > -1 ) {
					/* 사용자 혼동을 줄이기 위해서 기존 선택된 목록도 표현한다. */
					dispValue.search.push ( item );
				}
			} );
			fnDataTableGrid ( );
		} );

		$ ( "#txtSearch" ).keyup ( function ( event ) {
			/* 검색어 입력 후 엔터 이벤트 */
			if ( event.which == 13 ) {
				dispValue.search = new Array ( );
				dispValue.result.forEach ( function ( item, itemIndex ) {
					if ( item.summaryName.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
						dispValue.search.push ( item );
					} else if ( item.summaryCode.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
						dispValue.search.push ( item );
					} else if ( dispValue.hasFormLink.indexOf ( item.summaryCode ) > -1 ) {
						/* 사용자 혼동을 줄이기 위해서 기존 선택된 목록도 표현한다. */
						dispValue.search.push ( item );
					}
				} );
				fnDataTableGrid ( );
			}
		} );
	}

	/* 검색 이벤트 */
	function fnFormLinkSummarySearch ( ) {
		$.ajax ( {
			async: false,
			type: "post",
			data: {
				formSeq: '${formSeq}',
				searchStr: $ ( '#txtSearch' ).val ( )
			},
			url: "/exp/ex/expend/admin/ExFormLinkSummaryListSelect.do",
			datatype: "json",
			success: function ( result ) {
				dispValue.result = new Array ( );
				dispValue.hasFormLink = new Array ( );
				result.result.aaData.forEach ( function ( item, itemIndex ) {
					dispValue.result.push ( item );
					dispValue.search.push ( item );
					if ( item.hasFormLink.toString ( ).toUpperCase ( ) === 'Y' ) {
						dispValue.hasFormLink.push ( item.summaryCode );
					}
				} );
				fnDataTableGrid ( );
			},
			error: function ( data ) {
				console.log ( "! [EX][LISTGRID] ERROR - " + JSON.stringify ( data ) );
			}
		} );
	}

	function fnDataTableGrid ( ) {
		/* 기존 항목 삭제 */
		$ ( '#tblSummaryList' ).contents ( ).unbind ( ).remove ( );
		$ ( 'input[name=chkSummaryItem]:checked' ).prop ( 'checked', false );
		/* colGroup 설정 */
		var colGroup = '';
		colGroup += '<colgroup>';
		colGroup += '	<col width="34" />'; /* 체크박스 */
		colGroup += '	<col width="150" />'; /* 표준적요명 */
		colGroup += '	<col width="100" />'; /* 표준적요코드 */
		colGroup += '	<col width="120" />'; /* 차변 계정과목 */
		colGroup += '	<col width="120" />'; /* 부가세 계정과목 */
		colGroup += '	<col width="" />'; /* 대변 계정과목 */
		colGroup += '</colgroup>';
		$ ( '#tblSummaryList' ).append ( colGroup );
		/* list binding */
		if ( dispValue.search.length > 0 ) {
			for ( var i = 0; i < dispValue.search.length; i++ ) {
				var tr = '';
				tr += '<td><input type="checkbox" name="chkSummaryItem" value="'+dispValue.search [ i ].summaryCode+'" id="chkSummaryItem_' + ( dispValue.search [ i ].summaryCode || '' ) + '" /> <label for="chkSummaryItem_' + ( dispValue.search [ i ].summaryCode || '' ) + '"></label></td>'; /* 체크박스 */
				tr += '<td>' + ( dispValue.search [ i ].summaryName || '' ) + '</td>'; /* 표준적요명 */
				tr += '<td>' + ( dispValue.search [ i ].summaryCode || '' ) + '</td>'; /* 코드 */
				tr += '<td>' + ( dispValue.search [ i ].drAcctName || '' ) + '</td>'; /* 차변 계정과목 */
				tr += '<td>' + ( dispValue.search [ i ].vatAcctName || '' ) + '</td>'; /* 부가세 계정과목 */
				tr += '<td>' + ( dispValue.search [ i ].crAcctName || '' ) + '</td>'; /* 대변 계정과목 */
				$ ( '#tblSummaryList' ).append ( '<tr>' + ( tr || '' ) + '</tr>' );

				if ( dispValue.hasFormLink.indexOf ( dispValue.search [ i ].summaryCode ) > -1 ) {
					$ ( '#tblSummaryList' ).find ( 'tr:last input[type=checkbox]' ).prop ( 'checked', true );
				}

				$ ( '#tblSummaryList' ).find ( 'tr:last' ).click ( function ( event ) {
					var checkbox = $ ( this ).find ( 'input[type=checkbox]' );
					checkbox.prop ( 'checked', !checkbox [ 0 ].checked );
					fnCheckedItem ( checkbox );

					if ( dispValue.search.length === $ ( '#tblSummaryList' ).find ( 'input[type=checkbox]:checked' ).length ) {
						$ ( '#chkSummaryItem_All' ).prop ( 'checked', true );
					} else {
						$ ( '#chkSummaryItem_All' ).prop ( 'checked', false );
					}

					event.preventDefault ( );
				} );
			}
		} else {
			$ ( '#tblSummaryList' ).append ( '<tr><td colspan="6">등록된 표준적요가 없습니다.</td></tr>' );
		}

		if ( dispValue.search.length === $ ( '#tblSummaryList' ).find ( 'input[type=checkbox]:checked' ).length ) {
			$ ( '#chkSummaryItem_All' ).prop ( 'checked', true );
		} else {
			$ ( '#chkSummaryItem_All' ).prop ( 'checked', false );
		}
	}

	function fnCheckedItem ( checkbox ) {
		if ( checkbox [ 0 ].checked && dispValue.hasFormLink.indexOf ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkSummaryItem_', '' ) ) < 0 ) {
			dispValue.hasFormLink.push ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkSummaryItem_', '' ) );
		} else if ( !checkbox [ 0 ].checked && dispValue.hasFormLink.indexOf ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkSummaryItem_', '' ) ) > -1 ) {
			dispValue.hasFormLink.splice ( dispValue.hasFormLink.indexOf ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkSummaryItem_', '' ) ), 1 );
		}
	}

	function fnReflect ( ) {
		/* 모든항목을 삭제할 수 있기에 선택 항목 체크를 진행하지 않는다. */
// 		window.opener.fnSummaryPopCallback ( dispValue.hasFormLink );
		// 표준적요 정상적으로 삭제/등록 안되는 오류 발생하여 반영 로직 수정. 2018. 03. 02 신재호
		
		// 선택 된 항목
		var chkSels = new Array();
		$.each($("input:checkbox:checked"),function(idx,val){
			if($(this).attr("value") == 'on'){
				return true;
			}
			chkSels.push($(this).attr("value")); 
		});
		
		window.opener.fnSummaryPopCallback ( chkSels );
		self.close ( );
	}
</script>
<div class="pop_wrap" style="width: 688px;">
	<!-- 윈도우팝업 사이즈 690*530 -->
	<div class="pop_head">
		<h1>${CL.ex_standardOutlineSelect} <!--표준적요 선택--></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>

	<div class="pop_con div_form">
		<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_keyWord} <!--검색어--></dt>
				<dd>
					<input id="txtSearch" type="text" style="width: 200px;" value="" />
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}" /> <!--검색-->
				</dd>
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta2 mt14">
			<table>
				<colgroup>
					<col width="34" />
					<col width="150" />
					<col width="100" />
					<col width="120" />
					<col width="120" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkSummaryItem" id="chkSummaryItem_All" /> <label for="chkSummaryItem_All"></label></th>
						<th>${CL.ex_standardOutlineNm} <!--표준적요명--></th>
						<th>${CL.ex_code} <!--코드--></th>
						<th>${CL.ex_drAccSub} <!--차변 계정과목--></th>
						<th>${CL.ex_surtaxAccSub} <!--부가세 계정과목--></th>
						<th>${CL.ex_crAccSub} <!--대변 계정과목--></th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="com_ta2 ova_sc cursor_p bg_lightgray" style="height: 296px;">
			<table id="tblSummaryList">
				<colgroup>
					<col width="34" />
					<col width="150" />
					<col width="100" />
					<col width="120" />
					<col width="120" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td><input type="checkbox" name="" id="" /> <label for=""></label></td>
						<td>${CL.ex_empProofCraft} <!--사원증제작--></td>
						<td>80000</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--
		<div class="com_ta2 mt14" style="height: 296px;">
			<table id="tblSummaryList">
			</table>
		</div>
		-->


	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnSubmit" value="${CL.ex_check}" /><!--확인-->
			<input type="button" id="btnCancel" class="gray_btn" value="${CL.ex_cancel}" /> <!--취소-->
		</div>
	</div>
	<!-- //pop_foot -->

</div>
<!--// pop_wrap -->