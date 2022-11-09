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
	window.resizeTo ( 586, 596 );

	var dispValue = {
		result: [ ],
		search: [ ],
		hasFormLink: [ ]
	}

	$ ( document ).ready ( function ( ) {
		fnInitEvent ( );
		fnFormLinkAuthSearch ( );
	} );

	function fnInitEvent ( ) {
		/* resize event */
		$ ( '#chkAuthItem_All' ).click ( function ( ) {
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
				if ( item.authName.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
					dispValue.search.push ( item );
				} else if ( item.authCode.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
					dispValue.search.push ( item );
				} else if ( dispValue.hasFormLink.indexOf ( item.authCode ) > -1 ) {
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
					if ( item.authName.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
						dispValue.search.push ( item );
					} else if ( item.authCode.toString ( ).toUpperCase ( ).indexOf ( $ ( '#txtSearch' ).val ( ) ) > -1 ) {
						dispValue.search.push ( item );
					} else if ( dispValue.hasFormLink.indexOf ( item.authCode ) > -1 ) {
						/* 사용자 혼동을 줄이기 위해서 기존 선택된 목록도 표현한다. */
						dispValue.search.push ( item );
					}
				} );
				fnDataTableGrid ( );
			}
		} );
	}

	/* 검색 이벤트 */
	function fnFormLinkAuthSearch ( ) {
		$.ajax ( {
			async: false,
			type: "post",
			data: {
				formSeq: '${formSeq}',
				searchStr: $ ( '#txtSearch' ).val ( )
			},
			url: "/exp/ex/expend/admin/ExFormLinkAuthListSelect.do",
			datatype: "json",
			success: function ( result ) {
				dispValue.result = new Array ( );
				dispValue.hasFormLink = new Array ( );
				result.result.aaData.forEach ( function ( item, itemIndex ) {
					dispValue.result.push ( item );
					dispValue.search.push ( item );
					if ( item.hasFormLink.toString ( ).toUpperCase ( ) === 'Y' ) {
						dispValue.hasFormLink.push ( item.authCode );
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
		$ ( '#tblAuthList' ).contents ( ).unbind ( ).remove ( );
		$ ( 'input[name=chkAuthItem]:checked' ).prop ( 'checked', false );
		/* colGroup 설정 */
		var colGroup = '';
		colGroup += '<colgroup>';
		colGroup += '	<col width="34" />'; /* 체크박스 */
		colGroup += '	<col width="200" />'; /* 증빙유형명 */
		colGroup += '	<col width="120" />'; /* 증빙유형코드 */
		colGroup += '	<col width="" />'; /* 대변 계정과목 */
		colGroup += '</colgroup>';

		$ ( '#tblAuthList' ).append ( colGroup );
		/* list binding */
		if ( dispValue.search.length > 0 ) {
			for ( var i = 0; i < dispValue.search.length; i++ ) {
				var tr = '';
				tr += '<td><input type="checkbox" name="chkAuthItem" value="'+dispValue.search [ i ].authCode+'" id="chkAuthItem_' + ( dispValue.search [ i ].authCode || '' ) + '" /> <label for="chkAuthItem_' + ( dispValue.search [ i ].authCode || '' ) + '"></label></td>'; /* 체크박스 */
				tr += '<td>' + ( dispValue.search [ i ].authName || '' ) + '</td>'; /* 증빙유형명 */
				tr += '<td>' + ( dispValue.search [ i ].authCode || '' ) + '</td>'; /* 코드 */
				tr += '<td>' + ( dispValue.search [ i ].vatTypeName || '' ) + '</td>'; /* 차변 계정과목 */
				$ ( '#tblAuthList' ).append ( '<tr>' + ( tr || '' ) + '</tr>' );

				if ( dispValue.hasFormLink.indexOf ( dispValue.search [ i ].authCode ) > -1 ) {
					$ ( '#tblAuthList' ).find ( 'tr:last input[type=checkbox]' ).prop ( 'checked', true );
				}

				$ ( '#tblAuthList' ).find ( 'tr:last' ).click ( function ( event ) {
					var checkbox = $ ( this ).find ( 'input[type=checkbox]' );
					checkbox.prop ( 'checked', !checkbox [ 0 ].checked );
					fnCheckedItem ( checkbox );

					if ( dispValue.search.length === $ ( '#tblAuthList' ).find ( 'input[type=checkbox]:checked' ).length ) {
						$ ( '#chkAuthItem_All' ).prop ( 'checked', true );
					} else {
						$ ( '#chkAuthItem_All' ).prop ( 'checked', false );
					}

					event.preventDefault ( );
				} );
			}
		} else {
			$ ( '#tblAuthList' ).append ( '<tr><td colspan="4">등록된 증빙유형이 없습니다.</td></tr>' );
		}

		if ( dispValue.search.length === $ ( '#tblAuthList' ).find ( 'input[type=checkbox]:checked' ).length ) {
			$ ( '#chkAuthItem_All' ).prop ( 'checked', true );
		} else {
			$ ( '#chkAuthItem_All' ).prop ( 'checked', false );
		}
	}

	function fnCheckedItem ( checkbox ) {
		if ( checkbox [ 0 ].checked && dispValue.hasFormLink.indexOf ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkAuthItem_', '' ) ) < 0 ) {
			dispValue.hasFormLink.push ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkAuthItem_', '' ) );
		} else if ( !checkbox [ 0 ].checked && dispValue.hasFormLink.indexOf ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkAuthItem_', '' ) ) > -1 ) {
			dispValue.hasFormLink.splice ( dispValue.hasFormLink.indexOf ( checkbox.prop ( 'id' ).toString ( ).replace ( 'chkAuthItem_', '' ) ), 1 );
		}
	}

	function fnReflect ( ) {
		/* 모든항목을 삭제할 수 있기에 선택 항목 체크를 진행하지 않는다. */
// 		window.opener.fnAuthPopCallback ( dispValue.hasFormLink );
		
		// 증빙유형 정상적으로 삭제/등록 안되는 오류 발생하여 반영 로직 수정. 2018. 03. 02 신재호

		// 선택 된 항목
		var chkSels = new Array();
		$.each($("input:checkbox:checked"),function(idx,val){
			if($(this).attr("value") == 'on'){
				return true;
			}
			chkSels.push($(this).attr("value")); 
		});
		
		window.opener.fnAuthPopCallback ( chkSels );
		
		self.close ( );
	}
</script>

<div class="pop_wrap" style="width: 568px;">
	<!-- 윈도우팝업 사이즈 570*530 -->
	<div class="pop_head">
		<h1>${CL.ex_proofTypeSelect} <!--증빙유형 선택--></h1>
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
					<col width="200" />
					<col width="120" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" name="chkAuthItem" id="chkAuthItem_All" /> <label for="chkAuthItem_All"></label></th>
						<th>${CL.ex_proofTypeNm} <!--증빙유형명--></th>
						<th>${CL.ex_code} <!--코드--></th>
						<th>${CL.ex_classificationTax} <!--부가세 구분--></th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="com_ta2 ova_sc cursor_p bg_lightgray" style="height: 296px;">
			<table id="tblAuthList">
				<colgroup>
					<col width="34" />
					<col width="200" />
					<col width="120" />
					<col width="" />
				</colgroup>
				<tbody>
					<tr>
						<td><input type="checkbox" name="" id="" /> <label for=""></label></td>
						<td>매일${CL.ex_notDeduct} <!--불공제--></td>
						<td>80000</td>
						<td>${CL.ex_noTaxPurchase} <!--면세매입--></td>
					</tr>
				</tbody>
			</table>
		</div>


	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnSubmit" value="${CL.ex_check}" /> <!--확인-->
			<input type="button" id="btnCancel" class="gray_btn" value="${CL.ex_cancel}" /><!--취소-->
		</div>
	</div>
	<!-- //pop_foot -->

</div>
<!--// pop_wrap -->