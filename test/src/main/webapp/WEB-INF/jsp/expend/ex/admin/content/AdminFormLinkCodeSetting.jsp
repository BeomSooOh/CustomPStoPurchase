<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
	var dispValue = {
		summary: {
			/* 표준적요 검색 결과 */
			result: [ /* 검색결과 */],
			search: [ /* 사용자 검색어 입력 검색 결과 */]
		},
		auth: {
			/* 증빙유형 검색 결과 */
			result: [ /* 검색결과 */],
			search: [ /* 사용자 검색어 입력 검색 결과 */]
		}
	};
	var searchFlag = false;
	/* document ready */
	$ ( document ).ready ( function ( ) {
		fnFormListSelect ( ); /* 양식 목록 조회 */
		fnSummaryListSelect ( ); /* 표준적요 목록 조회 */
		fnAuthListSelect ( ); /* 증빙유형 목록 조회 */
		fnInitEvent ( ); /* 이벤트 바인딩 */
		fnSetTableMaxMinHeight ( ); /* 테이블 높이 설정 */
	} );
	/* event init */
	function fnInitEvent ( ) {
		$ ( window ).resize ( function ( ) {
			fnSetTableMaxMinHeight ( );
		} );

		$ ( '#btnSummarySearch' ).click ( function ( ) {
			/* 표준적요 검색 */
			searchFlag = true;
			fnSummarySearch ( );
		} );
		$ ( '#txtSummarySearchStr' ).keyup ( function ( event ) {
			/* 검색어 입력 후 자동 검색 */
			if ( event.keyCode == 13 ) {
				$ ( '#btnSummarySearch' ).click ( );
			}
		} );
		$ ( '#btnAuthSearch' ).click ( function ( ) {
			/* 증빙유형 검색 */
			searchFlag = true;
			fnAuthSearch ( );
		} );
		$ ( '#txtAuthSearchStr' ).keyup ( function ( ) {
			/* 검색어 입력 후 자동 검색 */
			if ( event.keyCode == 13 ) {
				$ ( '#btnAuthSearch' ).click ( );
			}
		} );
		$ ( '#btnSummaryPop' ).click ( function ( ) {
			/* 표준적요 선택 */
			fnSummaryPopCall ( );
		} );
		$ ( '#btnSummaryDelete' ).click ( function ( ) {
			/* 표준적요 삭제 */
			if ( $ ( '#tblSummaryListList input[name=chkSummaryItem]:checked' ).length > 0 ) {
				if ( confirm ( '선택한 표준적요를 삭제 처리하시겠습니까?' ) ) {
					// TODO: confirm layer 구현
					fnSummaryListDelete ( );
				}
			}
		} );
		$ ( '#btnAuthPop' ).click ( function ( ) {
			/* 증빙유형 선택 */
			fnAuthPopCall ( );
		} );
		$ ( '#btnAuthDelete' ).click ( function ( ) {
			/* 증빙유형 삭제 */
			if ( $ ( '#tblAuthListList input[name=chkAuthItem]:checked' ).length > 0 ) {
				if ( confirm ( '선택한 증빙유형을 삭제 처리하시겠습니까?' ) ) {
					// TODO: confirm layer 구현
					fnAuthListDelete ( );
				}
			}
		} );
		$ ( '#selFomrList' ).change ( function ( ) {
			/* 입력값 초기화 */
			$ ( '#txtSummarySearchStr' ).val ( '' );
			$ ( '#txtAuthSearchStr' ).val ( '' );
			/* 양식선택 */
			fnSummaryListSelect ( );
			fnAuthListSelect ( );
		} );

		$ ( '#chkSummaryItem_All' ).change ( function ( ) {
			/* 표준적요 전체 선택 */
			$ ( 'input[name=' + $ ( this ).prop ( 'name' ) + ']' ).not ( this ).prop ( 'checked', $ ( this ).is ( ':checked' ) );
		} );

		$ ( '#chkAuthItem_All' ).change ( function ( ) {
			/* 증빙유형 전체 선택 */
			$ ( 'input[name=' + $ ( this ).prop ( 'name' ) + ']' ).not ( this ).prop ( 'checked', $ ( this ).is ( ':checked' ) );
		} );
		return;
	}
	/* table height set */
	function fnSetTableMaxMinHeight ( ) {
		$ ( '#tblAuthListList' ).parent ( ).css ( 'min-height', ( window.innerHeight - 346 ) );
		$ ( '#tblAuthListList' ).parent ( ).css ( 'max-height', ( window.innerHeight - 346 ) );
		$ ( '#tblSummaryListList' ).parent ( ).css ( 'min-height', ( window.innerHeight - 346 ) );
		$ ( '#tblSummaryListList' ).parent ( ).css ( 'max-height', ( window.innerHeight - 346 ) );
		return;
	}
	/* form lsit select */
	function fnFormListSelect ( ) {
		$.ajax ( {
			async: false,
			type: "post",
			data: {},
			url: '/exp/ex/expend/admin/ExAdminGetFormInfoList.do',
			datatype: "json",
			success: function ( result ) {
				var formInfo = JSON.parse ( result.result.aData.formInfo );
				/* selFomrList */
				$ ( '#selFomrList' ).contents ( ).unbind ( ).remove ( );
				/* item binding */
				$.each ( formInfo, function ( itemIndex, item ) {
					if ( itemIndex === 0 ) {
						$ ( '#selFomrList' ).append ( '<option value="' + ( item.formSeq || '0' ) + '" selected="selected">' + ( item.formName || '' ) + '</option>' );
					} else {
						$ ( '#selFomrList' ).append ( '<option value="' + ( item.formSeq || '0' ) + '">' + ( item.formName || '' ) + '</option>' );
					}
				} );
			},
			error: function ( err ) {
			}
		} );
		return;
	}
	/* summary list select */
	function fnSummaryListSelect ( ) {
		console.log ( 'function run : fnSummaryListSelect..' );
		$.ajax ( {
			async: false,
			type: "post",
			data: {
				"formSeq": $ ( '#selFomrList' ).val ( )
			},
			url: "/exp/ex/expend/admin/ExFormLinkSettingSummaryListSelect.do",
			datatype: "json",
			success: function ( result ) {
				/* 데이터 변환 */
				dispValue.summary.result = new Array ( );
				dispValue.summary.search = new Array ( );
				result.result.aaData.forEach ( function ( item, itemIndex ) {
					dispValue.summary.result.push ( item );
					dispValue.summary.search.push ( item );
				} );
				/* 표준적요 연결 카운트 */
				$ ( '#lblSummaryListCount' ).html ( ( dispValue.summary.search.length > 0 ? dispValue.summary.search.length : '-' ) );
				/* list binding */
				fnSummaryTableBind ( );
			},
			error: function ( err ) {
			}
		} );
		return;
	}

	function fnSummaryTableBind ( ) {
		/* 기존 항목 삭제 */
		$ ( '#tblSummaryListList' ).contents ( ).unbind ( ).remove ( );
		$ ( 'input[name=chkSummaryItem]:checked' ).prop ( 'checked', false );
		/* colGroup 설정 */
		var colGroup = "";
		colGroup += '<colgroup>';
		colGroup += '	<col width="34" />'; /* 체크박스 */
		colGroup += '	<col width="34" />'; /* 순번 */
		colGroup += '	<col width="19%" />'; /* 표준적요명 */
		colGroup += '	<col width="13%" />'; /* 코드 */
		colGroup += '	<col width="19%" />'; /* 차변 계정과목 */
		colGroup += '	<col width="19%" />'; /* 부가세 계정과목 */
		colGroup += '	<col width="" />'; /* 대변 계정과목 */
		colGroup += '</colgroup>';
		$ ( '#tblSummaryListList' ).append ( colGroup );
		/* list binding */
		if ( dispValue.summary.search.length > 0 ) {
			for ( var i = 0; i < dispValue.summary.search.length; i++ ) {
				var tr = '';
				tr += '<td><input type="checkbox" style="margin-left: 0px;" name="chkSummaryItem" id="chkSummaryItem_' + ( dispValue.summary.search [ i ].summaryCode || '' ) + '" /> <label for="chkSummaryItem_' + ( dispValue.summary.search [ i ].summaryCode || '' ) + '"></label></td>'; /* 체크박스 */
				tr += '<td>' + ( i + 1 ) + '</td>'; /* 순번 */
				tr += '<td>' + ( dispValue.summary.search [ i ].summaryName || '' ) + '</td>'; /* 표준적요명 */
				tr += '<td>' + ( dispValue.summary.search [ i ].summaryCode || '' ) + '</td>'; /* 코드 */
				tr += '<td>' + ( dispValue.summary.search [ i ].drAcctName || '' ) + '</td>'; /* 차변 계정과목 */
				tr += '<td>' + ( dispValue.summary.search [ i ].vatAcctName || '' ) + '</td>'; /* 부가세 계정과목 */
				tr += '<td>' + ( dispValue.summary.search [ i ].crAcctName || '' ) + '</td>'; /* 대변 계정과목 */
				$ ( '#tblSummaryListList' ).append ( '<tr>' + ( tr || '' ) + '</tr>' );

				$ ( '#tblSummaryListList' ).find ( 'tr:last' ).click ( function ( ) {
					var checkbox = $ ( this ).find ( 'input[type=checkbox]' );
					checkbox.prop ( 'checked', !checkbox [ 0 ].checked );
					if ( dispValue.summary.search.length === $ ( '#tblSummaryListList' ).find ( 'input[type=checkbox]:checked' ).length ) {
						$ ( '#chkSummaryItem_All' ).prop ( 'checked', true );
					} else {
						$ ( '#chkSummaryItem_All' ).prop ( 'checked', false );
					}
				} );
			}
			$ ( '#txtSummarySearchStr' ).attr ( 'placeholder', '${CL.ex_standardOutlineComment}' );
		} else {
			if ( searchFlag && ( $ ( '#txtSummarySearchStr' ).val ( ) || '' ) !== '' ) {
				$ ( '#tblSummaryListList' ).append ( '<tr><td colspan="7">데이터가 존재하지 않습니다.</td></tr>' );
			} else {
				$ ( '#tblSummaryListList' ).append ( '<tr><td colspan="7">연결된 증빙유형이 없습니다. 지출결의 작성 시 등록된 증빙유형 전체 중 선택이 가능합니다.</td></tr>' );
			}
			searchFlag = false;
		}
	}
	/* auth list seelct */
	function fnAuthListSelect ( ) {
		$.ajax ( {
			async: false,
			type: "post",
			data: {
				"formSeq": $ ( '#selFomrList' ).val ( )
			},
			url: "/exp/ex/expend/admin/ExFormLinkSettingAuthListSelect.do",
			datatype: "json",
			success: function ( result ) {
				/* 데이터 변환 */
				dispValue.auth.result = new Array ( );
				dispValue.auth.search = new Array ( );
				result.result.aaData.forEach ( function ( item, itemIndex ) {
					dispValue.auth.result.push ( item );
					dispValue.auth.search.push ( item );
				} );

				/* 증빙유형 연결 카운트 */
				$ ( '#lblAuthListCount' ).html ( ( dispValue.auth.search.length > 0 ? dispValue.auth.search.length : '-' ) );
				/* list binding */
				fnAuthTableBind ( );
			},
			error: function ( err ) {
			}
		} );

		return;
	}

	function fnAuthTableBind ( ) {
		/* 기존 항목 삭제 */
		$ ( '#tblAuthListList' ).contents ( ).unbind ( ).remove ( );
		$ ( 'input[name=chkAuthItem]:checked' ).prop ( 'checked', false );
		/* colGroup 설정 */
		var colGroup = "";
		colGroup += '<colgroup>';
		colGroup += '	<col width="34" />'; /* 체크박스 */
		colGroup += '	<col width="34" />'; /* 순번 */
		colGroup += '	<col width="40%" />'; /* 증빙유형명 */
		colGroup += '	<col width="25%" />'; /* 코드 */
		colGroup += '	<col width="" />'; /* 부가세구분 */
		colGroup += '</colgroup>';
		$ ( '#tblAuthListList' ).append ( colGroup );
		/* list binding */
		if ( dispValue.auth.search.length > 0 ) {
			for ( var i = 0; i < dispValue.auth.search.length; i++ ) {
				var tr = '';
				tr += '<td><input type="checkbox" style="margin-left: 0px;" name="chkAuthItem" id="chkAuthItem_' + ( dispValue.auth.search [ i ].authCode || '' ) + '" /> <label for="chkAuthItem_' + ( dispValue.auth.search [ i ].authCode || '' ) + '"></label></td>'; /* 체크박스 */
				tr += '<td>' + ( i + 1 ) + '</td>'; /* 순번 */
				tr += '<td>' + ( dispValue.auth.search [ i ].authName || '' ) + '</td>'; /* 증빙유형명 */
				tr += '<td>' + ( dispValue.auth.search [ i ].authCode || '' ) + '</td>'; /* 코드 */
				tr += '<td>' + ( dispValue.auth.search [ i ].vatTypeName || '' ) + '</td>'; /* 부가세구분 */
				$ ( '#tblAuthListList' ).append ( '<tr>' + ( tr || '' ) + '</tr>' );

				$ ( '#tblAuthListList' ).find ( 'tr:last' ).click ( function ( ) {
					var checkbox = $ ( this ).find ( 'input[type=checkbox]' );
					checkbox.prop ( 'checked', !checkbox [ 0 ].checked );
					if ( dispValue.auth.search.length === $ ( '#tblAuthListList' ).find ( 'input[type=checkbox]:checked' ).length ) {
						$ ( '#chkAuthItem_All' ).prop ( 'checked', true );
					} else {
						$ ( '#chkAuthItem_All' ).prop ( 'checked', false );
					}
				} );
			}
			$ ( '#txtAuthSearchStr' ).attr ( 'placeholder', '<%=BizboxAMessage.getMessage("TX000022484","증빙유형 명칭 및 코드를 입력해주세요.")%>' );
			
		} else {
			if ( searchFlag && ( $ ( '#txtAuthSearchStr' ).val ( ) || '' ) !== '' ) {
				$ ( '#tblAuthListList' ).append ( '<tr><td colspan="5">데이터가 존재하지 않습니다.</td></tr>' );
			} else {
				$ ( '#tblAuthListList' ).append ( '<tr><td colspan="5">연결된 증빙유형이 없습니다. 지출결의 작성 시 등록된 증빙유형 전체 중 선택이 가능합니다.</td></tr>' );
			}
			searchFlag = false;
		}
	}
	/* summary search */
	function fnSummarySearch ( ) {
		/* txtSummarySearchStr */
		dispValue.summary.search = new Array ( );
		dispValue.summary.result.forEach ( function ( item, itemIndex ) {
			if ( item.summaryName.toString ( ).toUpperCase ( ).indexOf ( ( $ ( '#txtSummarySearchStr' ).val ( ) || '' ) ) > -1 ) {
				dispValue.summary.search.push ( item );
			} else if ( item.summaryCode.toString ( ).toUpperCase ( ).indexOf ( ( $ ( '#txtSummarySearchStr' ).val ( ) || '' ) ) > -1 ) {
				dispValue.summary.search.push ( item );
			}
		} );
		fnSummaryTableBind ( );
		return;
	}
	/* auth search */
	function fnAuthSearch ( ) {
		/* txtAuthSearchStr */
		dispValue.auth.search = new Array ( );
		dispValue.auth.result.forEach ( function ( item, itemIndex ) {
			if ( item.authName.toString ( ).toUpperCase ( ).indexOf ( ( $ ( '#txtAuthSearchStr' ).val ( ) || '' ) ) > -1 ) {
				dispValue.auth.search.push ( item );
			} else if ( item.authCode.toString ( ).toUpperCase ( ).indexOf ( ( $ ( '#txtAuthSearchStr' ).val ( ) || '' ) ) > -1 ) {
				dispValue.auth.search.push ( item );
			}
		} );
		fnAuthTableBind ( );
		return;
	}
	/* summary lsit delete */
	function fnSummaryListDelete ( ) {
		var summaryDelteList = [ ];
		$.each ( $ ( 'input[name=chkSummaryItem]:checked' ), function ( chkIndex, item ) {
			var summaryDelete = {};
			summaryDelete.formSeq = $ ( '#selFomrList' ).val ( );
			summaryDelete.summaryCode = $ ( item ).prop ( 'id' ).toString ( ).replace ( ( $ ( item ).prop ( 'name' ).toString ( ) + '_' ), '' );
			summaryDelteList.push ( summaryDelete );
		} );

		var sourceResult = [ ];
		summaryDelteList.forEach ( function ( item, itemIndex ) {
			sourceResult.push ( $.ajax ( {
				async: true,
				type: "post",
				data: {
					"formSeq": $ ( '#selFomrList' ).val ( ),
					"summaryCode": item.summaryCode
				},
				url: '/exp/ex/admin/config/ExAdminSetSummaryAuthDelete.do',
				datatype: "json"
			} ) );
		} );

		if ( sourceResult.length > 0 ) {
			$.when.apply ( this, sourceResult ).done ( function ( ) {
				fnSummaryListSelect ( );
				$ ( 'input[name=chkSummaryItem]:checked' ).prop ( 'checked', false );
			} );
		}
		return;
	}
	/* auth list delete */
	function fnAuthListDelete ( ) {
		var authDelteList = [ ];
		$.each ( $ ( 'input[name=chkAuthItem]:checked' ), function ( chkIndex, item ) {
			var authDelete = {};
			authDelete.formSeq = $ ( '#selFomrList' ).val ( );
			authDelete.authCode = $ ( item ).prop ( 'id' ).toString ( ).replace ( ( $ ( item ).prop ( 'name' ).toString ( ) + '_' ), '' );
			authDelteList.push ( authDelete );
		} );

		var sourceResult = [ ];
		authDelteList.forEach ( function ( item, itemIndex ) {
			sourceResult.push ( $.ajax ( {
				async: true,
				type: "post",
				data: {
					"formSeq": $ ( '#selFomrList' ).val ( ),
					"authTypeCode": item.authCode
				},
				url: '/exp/ex/admin/config/ExAdminSetAuthTypeAuthDelete.do',
				datatype: "json"
			} ) );
		} );

		if ( sourceResult.length > 0 ) {
			$.when.apply ( this, sourceResult ).done ( function ( ) {
				fnAuthListSelect ( );
				$ ( 'input[name=chkAuthItem]:checked' ).prop ( 'checked', false );
			} );
		}
		return;
	}
	/* summary pop call */
	function fnSummaryPopCall ( ) {
		var url = '/exp/ex/expend/admin/ExFormLinkSummaryPop.do?callBack=fnSummaryPopCallback&formSeq=' + $ ( '#selFomrList' ).val ( ), popupWidth = '706', popupHeight = '558', windowX = ( screen.width - popupWidth ) / 2, windowY = ( screen.height - popupHeight ) / 2;
		window.open ( url, "adminSummaryPop", "width=" + popupWidth + ",height=" + popupHeight + ",left=" + windowX + ",top=" + windowY );
		return;
	}
	/* auth pop call */
	function fnAuthPopCall ( ) {
		var url = '/exp/ex/expend/admin/ExFormLinkAuthPop.do?callBack=fnAuthPopCallback&formSeq=' + $ ( '#selFomrList' ).val ( ), popupWidth = '706', popupHeight = '558', windowX = ( screen.width - popupWidth ) / 2, windowY = ( screen.height - popupHeight ) / 2;
		window.open ( url, "adminAuthPop", "width=" + popupWidth + ",height=" + popupHeight + ",left=" + windowX + ",top=" + windowY );
		return;
	}
	/* summary pop callback */
	function fnSummaryPopCallback ( paramArr ) {
		var summaryArr = $.map(paramArr, function(val){
			var obj = {}
			obj.summaryCode = val;
			obj.formSeq = $('#selFomrList').val();
			
			return obj;
		});
		
		var param = {};
		param.summaryArr = JSON.stringify(summaryArr);
		
		$.ajax({
			type : "post",
			url : '<c:url value="/ex/admin/config/ExAdminSetSummaryAuthCreate.do" />',
			datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	if(data.result.resultCode == "SUCCESS"){
            		fnSummaryListSelect();
            	}else{
            		alert("표준적요 등록 중 오류가 발생하였습니다.");
            	}
            },
            error : function(){
            	alert("표준적요 등록 중 오류가 발생하였습니다.");
            }
		});
	}
	/* auth pop callback */
	function fnAuthPopCallback ( paramArr ) {
		var authArr = $.map(paramArr, function(val){
			var obj = {}
			obj.authTypeCode = val;
			obj.formSeq = $('#selFomrList').val();
			
			return obj;
		});
		
		var param = {};
		param.authArr = JSON.stringify(authArr);
		
		$.ajax({
			type : "post",
			url : '<c:url value="/ex/admin/config/ExAdminSetAuthTypeAuthCreate.do" />',
			datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	if(data.result.resultCode == "SUCCESS"){
            		fnAuthListSelect();
            	}else{
            		alert("증빙유형 등록 중 오류가 발생하였습니다.");
            	}
            },
            error : function(){
            	alert("증빙유형 등록 중 오류가 발생하였습니다.");
            }
		});
	}
</script>
<!-- //sub_contents_wrap -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_formSelect} <!--양식선택--></dt>
			<dd>
				<select id="selFomrList" class="selectmenu" style="width: 200px">
					<option value="" selected="selected">${CL.ex_expendResA} <!--지출결의(A양식)--></option>
					<option value=""></option>
				</select>
			</dd>
		</dl>
	</div>
	<div class="twinbox mt20">
		<table style="min-height: 450px;">
			<colgroup>
				<col width="50%" />
				<col />
			</colgroup>
			<tr>
				<td class="twinbox_td">

					<div class="top_box gray_box in_top_box">
						<dl>
							<dt>${CL.ex_standardOutline} <!--표준적요--></dt>
							<dd class="posi_re">
								<div class="controll_btn p0">
									<input class="input_search" id="txtSummarySearchStr" type="text" value="" style="width: 260px;" placeholder="${CL.ex_standardOutlineComment}" /> <!--표준적요-->  
									<button id="btnSummarySearch" class="btn_sc_add">${CL.ex_search}</button>
								</div>
							</dd>
						</dl>
					</div>
					<div class="btn_div">
						<div class="left_div">
							<h5>
								${CL.ex_standardOutlineConnList} <!--표준적요 연결 목록--> ( ${CL.ex_connCount} : <span id="lblSummaryListCount" class="text_blue">5</span> 건 )
							</h5>
						</div>
						<div class="right_div">
							<div class="controll_btn p0">
								<button id="btnSummaryPop">${CL.ex_standardOutlineSelect} <!--표준적요 선택--></button>
								<button id="btnSummaryDelete">${CL.ex_remove} <!--삭제--></button>
							</div>
						</div>
					</div>
					<div class="com_ta2 sc_head">
						<table>
							<colgroup>
								<col width="34" />
								<col width="34" />
								<col width="19%" />
								<col width="13%" />
								<col width="19%" />
								<col width="19%" />
								<col width="" />
							</colgroup>
							<tr>
								<th><input type="checkbox" name="chkSummaryItem" id="chkSummaryItem_All" /> <label for="chkSummaryItem_All"></label></th>
								<th>No</th>
								<th>${CL.ex_standardOutlineNm} <!--표준적요명--></th>
								<th>${CL.ex_code} <!--코드--></th>
								<th>${CL.ex_drAccSub} <!--차변 계정과목--></th>
								<th>${CL.ex_surtaxAccSub} <!--부가세 계정과목--></th>
								<th>${CL.ex_crAccSub} <!--대변 계정과목--></th>
							</tr>
						</table>
					</div>
					<div class="com_ta2 ova_sc2 bg_lightgray flex_ta" style="min-height: 420px;">
						<table id="tblSummaryListList"></table>
					</div>
				</td>
				<td class="twinbox_td" style="">
					<div class="top_box gray_box">
						<dl>
							<dt>${CL.ex_evidenceType} <!--증빙유형--></dt>
							<dd class="posi_re">
								<div class="controll_btn p0">
									<input class="input_search" id="txtAuthSearchStr" type="text" value="" style="width: 260px;" placeholder="${CL.ex_evidenceTypeComment}" /> <!--증빙유형--> 
									<button id="btnAuthSearch" class="btn_sc_add">${CL.ex_search}</button>
								</div>
							</dd>
						</dl>
					</div>
					<div class="btn_div">
						<div class="left_div">
							<h5>
								${CL.ex_proofTypeConnList} <!--증빙유형 연결 목록--> (${CL.ex_connCount} : <span id="lblAuthListCount" class="text_blue">5</span> 건 )
							</h5>
						</div>
						<div class="right_div">
							<div class="controll_btn p0">
								<button id="btnAuthPop">${CL.ex_proofTypeSelect} <!--증빙유형 선택--></button>
								<button id="btnAuthDelete">${CL.ex_remove} <!--삭제--></button>
							</div>
						</div>
					</div>
					<div class="com_ta2 sc_head">
						<table>
							<colgroup>
								<col width="34" />
								<col width="34" />
								<col width="40%" />
								<col width="25%" />
								<col width="" />
							</colgroup>
							<tr>
								<th><input type="checkbox" name="chkAuthItem" id="chkAuthItem_All" /> <label for="chkAuthItem_All"></label></th>
								<th>No</th>
								<th>${CL.ex_proofTypeNm} <!--증빙유형명--></th>
								<th>${CL.ex_code} <!--코드--></th>
								<th>${CL.ex_classificationTax} <!--부가세 구분--></th>
							</tr>
						</table>
					</div>
					<div class="com_ta2 ova_sc2 bg_lightgray flex_ta" style="min-height: 420px;">
						<table id="tblAuthListList"></table>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- //sub_contents_wrap -->

