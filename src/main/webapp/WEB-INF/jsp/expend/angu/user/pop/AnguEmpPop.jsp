<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="main.web.BizboxAMessage"%>

<!-- jQuery plugin -->
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.mask.js"></c:url>'></script>

<!-- e나라도움 연계 참조 -->
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.anbojo.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.anbojo.var.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.ucdevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/angu/jquery.uckeydevtable.1.0.js"></c:url>'></script>

<script type="text/javascript">
	/* [+] ## var ################################################## */
	/* http://local.duzonnext.com:8080/exp/expend/angu/AnguEmpPop.do?anbojoSeq=805&mseq=1&lseq=1&sseq=1&dseq=1&bsnsyear=2017&mosfGisuDt=20170710&baseDate=20170710&erpBizSeq=1000 */
	var anbojoSeq = '${param.anbojoSeq}', mseq = '${param.mseq}', lseq = '${param.lseq}', sseq = '${param.sseq}', dseq = '${param.dseq}', bsnsyear = '${param.bsnsyear}', mosfGisuDt = '${param.mosfGisuDt}', baseDate = '${param.baseDate}', erpBizSeq = '${param.erpBizSeq}';
	/* [-] ## var ################################################## */

	/* [+] ## document ready ################################################## */

	$ ( document ).ready ( function ( ) {
        var key = '';
        key += fnGetPadLeft(anbojoSeq, 10);
        key += fnGetPadLeft(mseq, 3);
        key += fnGetPadLeft(lseq, 3);
        key += fnGetPadLeft(sseq, 3);
        
        var oldValue = JSON.parse(JSON.parse(opener.$('#txtPayInfoData').val() || '{}')[key] || '{}');
        
        if(oldValue.length > 0){
        	$.each(oldValue, function(idx, item){
        		fnSetAddTableRow ( item );
        		$('#divPayInfo.rightContents table tr:last td input[name=etctrCd]').data('result', item.etctrCd_result);
        		$('#divPayInfo.rightContents table tr:last td input[name=pymntAmount]').data('result', item.pymntAmount_result);
        	});
        	fnSetAddTableRow ( {} );
        } else {
        	fnSetAddTableRow ( {} );
        }
		
		fnKeyEvent ( );
		//이지바로 테이블 로우 선택 
		var TR = $ ( '#divPayInfo.rightContents.cus_ta table tr' );
		var iFocus = $ ( '#divPayInfo.rightContents.cus_ta table tr td input' );

		TR.click ( function ( ) {
			TR.removeClass ( 'lineOn onSel' ), $ ( this ).addClass ( 'lineOn onSel' );
		} );

		iFocus.click ( function ( ) {
			iFocus.removeClass ( 'focus' ), $ ( this ).addClass ( 'focus' );
		} );

		$ ( '#btnCommit' ).click ( function ( ) {
			fnPersonPayInfoSave ( );
		} );
	} );

	//휠스크롤
	function fixDataOnWheel ( ) {
		if ( event.wheelDelta < 0 ) {
			DataScroll.doScroll ( 'scrollbarDown' );
		} else {
			DataScroll.doScroll ( 'scrollbarUp' );
		}
		table1Scroll ( );
	}
	//각 테이블 스크롤 동기화
	function table1Scroll ( ) {
		$ ( ".table1 .leftContents" ).scrollTop ( $ ( ".table1 .rightContents" ).scrollTop ( ) );
		$ ( ".table1 .rightHeader" ).scrollLeft ( $ ( ".table1 .rightContents" ).scrollLeft ( ) );
	}

	/* [-] ## document ready ################################################## */

	/* [+] ## before data search ################################################## */
	function fnGetPayInfoS ( ) {
		var ajaxParam = {};
		ajaxParam.url = '';
		ajaxParam.parameters = {};
		ajaxParam.parameters.anbojoSeq = anbojoSeq;
		ajaxParam.parameters.mSeq = mseq;
		ajaxParam.parameters.lSeq = lseq;
		ajaxParam.parameters.sSeq = sseq;
		ajaxParam.parameters.dSeq = dseq;
	}

	function fnSetPayInfo ( ) {
		var itemKey = [ ];
		var table = $ ( '#divPayInfo.rightContents table' );
		$.each ( payInfo, function ( idx, item ) {

		} );
	}
	/* [-] ## before data search ################################################## */

	/* [+] ## row event ################################################## */
	function fnSetInputEvent ( rowSeq ) {
		$ ( '#divPayInfo.rightContents table tr:eq(' + rowSeq + ') input[type=text]' ).focus ( function ( ) {
			$ ( '#divPayInfo.rightContents table tr' ).removeClass ( 'lineOn onSel' );
			$ ( this ).parent ( ).parent ( ).addClass ( 'lineOn onSel' );
			$ ( 'input[type=text]' ).removeClass ( 'focus' );
			$ ( this ).addClass ( 'focus' );
		} );

		/* var rowKey = ['', 'etctrCd', 'hnfNm', 'hnfLsftNo', 'pymntAmount', '', '', 'prrt', 'partcptnBeginDe', 'partcptnEndDe']; */
		$.each ( $ ( '#divPayInfo.rightContents table tr:eq(' + rowSeq + ') input[type=text]' ), function ( idx, item ) {
			switch ( $ ( item ).attr ( 'name' ) ) {
				case "pymntAmount":
					break;
				default:
					break;
			}
		} );
	}

	function fnSetAddTableRow ( rowData ) {
		rowData = rowData || {};
		var tr = document.createElement ( 'tr' );
		var rowKey = [ '', 'etctrCd', 'hnfNm', 'hnfLsftNo', 'pymntAmount', '', '', 'prrt', 'partcptnBeginDe', 'partcptnEndDe' ];
		var rowFormat = [ '', 'string', 'string', 'string', 'num', 'num', 'num', 'num', 'yyyy/MM/dd', 'yyyy/MM/dd' ];
		var rowElem = [ 'span', 'input', 'input', 'input', 'input', 'input', 'input', 'input', 'input', 'input' ];
		var rowWidth = [ '50px', '100px', '120px', '140px', '100px', '100px', '100px', '80px', '100px', '100px' ];
		var rowAlign = [ 'cen', 'cen', 'cen', 'cen', 'ri', 'ri', 'ri', 'ri', 'cen', 'cen' ];

		$.each ( rowElem, function ( idx, elem ) {
			var td = document.createElement ( 'td' );
			$ ( td ).css ( 'width', rowWidth [ idx ] );
			$ ( td ).addClass ( rowAlign [ idx ] );
			var elem = document.createElement ( elem );
			$ ( elem ).attr ( 'name', rowKey [ idx ] );
			var itemValue = rowData [ rowKey [ idx ] ] ? rowData [ rowKey [ idx ] ] : '';
			
			if(rowKey [ idx ] == 'pymntAmount'){
				itemValue = (Number(rowData['ndepAm'] || '0') + Number(rowData['inadAm'] || '0')).toString();
			} else if(idx == 5){
				itemValue = Number(rowData['intxAm'] || '0').toString();
			} else if(idx == 6){
				itemValue = Number(rowData['rstxAm'] || '0').toString();
			}

			switch ( rowElem [ idx ] ) {
				case "input":
					$ ( elem ).attr ( 'type', 'text' );
					$ ( elem ).addClass ( 'td_inp' );
					$ ( elem ).val ( itemValue );

					switch ( rowFormat [ idx ] ) {
						case "jm":
							itemValue = ( itemValue || '' ).replace ( /-/g, '' );
							itemValue = ( itemValue || '' ).replace ( /^(\d{6})(\d{7})$/, '$1-$2' );

							$ ( elem ).focusout ( function ( ) {
								var val = $ ( this ).val ( );
								val = ( val || '' ).replace ( /-/g, '' );
								val = ( val || '' ).replace ( /^(\d{6})(\d{7})$/, '$1-$2' );
								$ ( this ).val ( val );
							} );
							break;
						case "num":
							itemValue = ( itemValue || '0' ).replace ( /,/g, '' );
							itemValue = ( itemValue || '0' ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' );

							$ ( elem ).focusout ( function ( ) {
								var val = $ ( this ).val ( );
								val = ( val || '0' ).replace ( /,/g, '' );
								val = ( val || '0' ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' );
								$ ( this ).val ( val );
							} );
							break;
						case "yyyy/MM/dd":
							itemValue = ( itemValue || '' ).toString ( ).replace ( /-/g, '' );
							itemValue = ( itemValue || '' ).toString ( ).replace ( /\//g, '' );
							itemValue = ( itemValue || '' ).replace ( /^(\d{4})(\d{2})(\d{2})$/, '$1/$2/$3' );

							$ ( elem ).focusout ( function ( ) {
								var val = $ ( this ).val ( );
								val = ( val || '' ).toString ( ).replace ( /-/g, '' );
								val = ( val || '' ).toString ( ).replace ( /\//g, '' );
								val = ( val || '' ).replace ( /^(\d{4})(\d{2})(\d{2})$/, '$1/$2/$3' );
								$ ( this ).val ( val );
							} );
							break;
						default:
							break;
					}
					break;
				default:
					$ ( elem ).text ( $ ( '#divPayInfo.rightContents table tr' ).length + 1 );
					break;
			}

			$ ( td ).append ( elem );
			$ ( tr ).append ( td );
		} );

		$ ( '#divPayInfo.rightContents table' ).append ( tr );
		fnSetInputEvent ( $ ( tr ).index ( ) );
		$ ( '#divPayInfo.rightContents table tr:eq(' + $ ( tr ).index ( ) + ') td:eq(1) input' ).click ( ).focus ( ).select ( );
	}
	/* [-] ## row event ################################################## */

	/* [+] ## person event ################################################## */
	var personInfo = [ ];

	function fnCommonCodePop ( ) {
		$ ( '#divCodeInfo table tr' ).unbind ( );
		$ ( '#divCodeInfo table' ).unbind ( );
		$ ( '#divCodeInfo table' ).empty ( );
		$ ( '#commonCodeLayer' ).show ( );
		$ ( '#txtSearchStr' ).val ( $ ( 'input[name=etctrCd].focus' ).val ( ) );
		$ ( '#txtSearchStr' ).focus ( );
	}

	function fnCommonCodeClose ( ) {
		$ ( '#divCodeInfo table tr' ).unbind ( );
		$ ( '#divCodeInfo table' ).unbind ( );
		$ ( '#divCodeInfo table' ).empty ( );
		$ ( '#commonCodeLayer' ).hide ( );
		$ ( 'input.focus' ).click ( ).focus ( ).select ( );
	}

	function fnCommonCodeSearch ( ) {
		var ajaxParam = {};
		/* ajaxParam.url = 'http://local.duzonnext.com:8080/exp/expend/angu/HpmeticInfoS.do'; */
		ajaxParam.url = domain + '/exp/expend/angu/HpmeticInfoS.do';
		ajaxParam.parameters = {};
		ajaxParam.parameters.BASE_DT = baseDate;

		$.ajax ( {
			async: false,
			type: "post",
			data: ajaxParam.parameters,
			url: ajaxParam.url,
			datatype: "json",
			success: function ( resultValue ) {
				$ ( '#divCodeInfo.rightContents table tr' ).unbind ( );
				$ ( '#divCodeInfo.rightContents table' ).unbind ( );
				$ ( '#divCodeInfo.rightContents table' ).empty ( );

				$.each ( resultValue.result.aaData, function ( idx, item ) {
					resultValue.result.aaData.push ( item );
				} );

				personInfo = resultValue.result.aaData;

				fnCommonCodeTableBind ( );
			},
			error: function ( err ) {
				console.log ( err );
			}
		} );
	}

	function fnCommonCodeTableBind ( searchPersonInfo ) {
		/* 코드 / 소득자명 / 주민번호 */
		if ( $ ( '#divCodeInfo.rightContents table' ).data ( 'result' ) && $ ( '#divCodeInfo.rightContents table' ).data ( 'result' ).length > 0 ) {
			searchPersonInfo = $ ( '#divCodeInfo.rightContents table' ).data ( 'result' );
		} else {
			searchPersonInfo = searchPersonInfo || personInfo;
		}

		var bindStartIdx = $ ( '#divCodeInfo.rightContents table tr' ).length;
		var bindEndIdx = bindStartIdx + 10;

		$.each ( searchPersonInfo, function ( idx, item ) {
			if ( idx >= bindStartIdx && idx < bindEndIdx ) {
				fnCommonCodeTableAddRow ( item );
			}

			if ( idx >= bindEndIdx ) { return false; }
		} );

		$ ( '#divCodeInfo.rightContents table' ).data ( 'result', searchPersonInfo );
	}

	function fnCommonCodeTableAddRow ( rowData ) {
		rowData = rowData || {};
		var tr = document.createElement ( 'tr' );
		$ ( tr ).data ( 'result', rowData );
		var rowKey = [ 'PER_CD', 'PER_NM', 'REG_NO' ]
		var rowFormat = [ 'string', 'string', 'string' ];
		var rowElem = [ 'span', 'span', 'span' ];
		var rowWidth = [ '100px', '100px', '200px' ];
		var rowAlign = [ 'cen', 'cen', 'cen' ];

		$.each ( rowElem, function ( idx, elem ) {
			var td = document.createElement ( 'td' );
			$ ( td ).css ( 'width', rowWidth [ idx ] );
			$ ( td ).addClass ( rowAlign [ idx ] );
			var elem = document.createElement ( elem );
			$ ( elem ).attr ( 'name', rowKey [ idx ] );
			var itemValue = rowData [ rowKey [ idx ] ] ? rowData [ rowKey [ idx ] ] : '';

			switch ( rowElem [ idx ] ) {
				case "input":
					$ ( elem ).attr ( 'type', 'text' );
					$ ( elem ).addClass ( 'td_inp' );
					$ ( elem ).val ( itemValue );

					switch ( rowFormat [ idx ] ) {
						case "jm":
							itemValue = ( itemValue || '000000-0000000' ).replace ( /-/g, '' );
							itemValue = ( itemValue || '0000000000000' ).replace ( /^(\d{6})(\d{7})$/, '$1-$2' );

							$ ( elem ).focusout ( function ( ) {
								var val = $ ( this ).val ( );
								val = ( val || '000000-0000000' ).replace ( /-/g, '' );
								val = ( val || '0000000000000' ).replace ( /^(\d{6})(\d{7})$/, '$1-$2' );
								$ ( this ).val ( val );
							} );
							break;
						case "num":
							itemValue = ( itemValue || '0' ).replace ( /,/g, '' );
							itemValue = ( itemValue || '0' ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' );

							$ ( elem ).focusout ( function ( ) {
								var val = $ ( this ).val ( );
								val = ( val || '0' ).replace ( /,/g, '' );
								val = ( val || '0' ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' );
								$ ( this ).val ( val );
							} );
							break;
						case "yyyy/MM/dd":
							itemValue = ( itemValue || '00000000' ).toString ( ).replace ( /-/g, '' );
							itemValue = ( itemValue || '00000000' ).toString ( ).replace ( /\//g, '' );
							itemValue = ( itemValue || '00000000' ).replace ( /^(\d{4})(\d{2})(\d{2})$/, '$1/$2/$3' );

							$ ( elem ).focusout ( function ( ) {
								var val = $ ( this ).val ( );
								val = ( val || '00000000' ).toString ( ).replace ( /-/g, '' );
								val = ( val || '00000000' ).toString ( ).replace ( /\//g, '' );
								val = ( val || '00000000' ).replace ( /^(\d{4})(\d{2})(\d{2})$/, '$1/$2/$3' );
								$ ( this ).val ( val );
							} );
							break;
						default:
							break;
					}
					break;
				default:
					$ ( elem ).text ( itemValue );
					break;
			}

			$ ( td ).append ( elem );
			$ ( tr ).append ( td );
		} );

		$ ( '#divCodeInfo.rightContents table' ).append ( tr );
		fnCommonCodeRowEvent ( $ ( tr ).index ( ) );
		// $('#divCodeInfo.rightContents table tr:eq(' + $(tr).index() + ') td:eq(1) input').click().focus().select();

		if ( $ ( '#divCodeInfo.rightContents table tr.lineOn.onSel' ).length == 0 ) {
			$ ( '#divCodeInfo.rightContents table tr:eq(0)' ).addClass ( 'lineOn onSel' );
		}
	}

	function fnCommonCodeRowEvent ( rowSeq ) {
		$ ( '#divCodeInfo.rightContents table tr:eq(' + rowSeq + ')' ).click ( function ( ) {
			$ ( '#divCodeInfo.rightContents table tr' ).removeClass ( 'lineOn onSel' );
			$ ( this ).addClass ( 'lineOn onSel' );
		} );

		$ ( '#divCodeInfo.rightContents table tr:eq(' + rowSeq + ')' ).dblclick ( function ( ) {
			var result = $ ( this ).data ( 'result' );
			fnSetCommonCode ( result );
			fnCommonCodeClose ( );
		} );
	}

	function fnSetCommonCode ( rowData ) {
		console.log ( rowData );
		/* {"ACCT_NM":"","PER_CD":"0001","PER_NM":"KIM","REG_NO":"6101015!@1@!PnRQrTZMjF5hHma+oazObw==","ACCT_NO":"","BANK_CD":"","CO_CD":"3585","CORP_CD":"2","DATA_CD":"BI"} */
		baseInput = $ ( 'input[type=text].focus' );
		/* 코드 */
		baseInput.val ( rowData.PER_CD );
		/* 지급처명 */
		baseInput.parent ( ).next ( 'td' ).find ( 'input' ).val ( rowData.PER_NM )
		/* 생년월일 */
		baseInput.parent ( ).next ( 'td' ).next ( 'td' ).find ( 'input' ).val ( rowData.REG_NO )
		/* data */
		baseInput.data ( 'result', rowData );
	}

	/* [-] ## person event ################################################## */

	/* [+] ## pay event ################################################## */
	function fnInitPayEvent ( ) {
		$ ( '#selIncomeGbn' ).unbind ( ).change ( function ( ) {
			var val = $ ( this ).val ( );
			/* pay event */
			$ ( '#txtIncludeYM' ).val ( baseDate.substring ( 0, 6 ).replace ( /^(\d{4})(\d{2})$/, '$1/$2' ) );
			$ ( '#txtSubmitYear' ).val ( baseDate.substring ( 0, 4 ).replace ( /^(\d{4})$/, '$1' ) );

			switch ( val ) {
				case "60":
					/* 필요경비 없는 기타소득(63 제외) */
					$ ( '#txtReqExpendRate' ).attr ( 'readonly', 'readonly' );
					$ ( '#txtReqExpendRate' ).val ( '' );
					break;
				case "60":
					/* 필요경비 없는 기타소득(63 제외) */
					$ ( '#txtReqExpendRate' ).removeAttr ( 'readonly' );
					$ ( '#txtReqExpendRate' ).val ( '' );
					break;
				case "63":
					/* 연금저축,소기업소상공인공제부금해지 소득 */
					$ ( '#txtReqExpendRate' ).attr ( 'readonly', 'readonly' );
					$ ( '#txtReqExpendRate' ).val ( '' );
					break;
				case "68":
					/* 비과세 기타소득 */
					$ ( '#txtReqExpendRate' ).attr ( 'readonly', 'readonly' );
					$ ( '#txtReqExpendRate' ).val ( '' );
					break;
				case "71":
					/* 상금 및 부상 */
				case "72":
					/* 광업권 등 */
				case "73":
					/* 지역권 등 */
				case "74":
					/* 주택입주지체상금 */
				case "75":
					/* 원고료 등 */
				case "76":
					/* 강연료 등 */
					$ ( '#txtReqExpendRate' ).attr ( 'readonly', 'readonly' );
					$ ( '#txtReqExpendRate' ).val ( '80' );
					fnPayAutoCalc ( );
					break;
			}
		} );

		$ ( '#txtReqExpendRate' ).unbind ( ).change ( function ( ) {
			fnPayAutoCalc ( );
		} );

		$ ( '#txtReqExpendRate' ).unbind ( ).keydown ( function ( event ) {
			switch ( event.keyCode.toString ( ) ) {
				case "13":
					$ ( '#txtReqExpendAmt' ).focus ( ).select ( );
					break;
			}
		} );

		$ ( '#txtReqExpendAmt' ).unbind ( ).keydown ( function ( event ) {
			switch ( event.keyCode.toString ( ) ) {
				case "13":
					$ ( '#txtIncomeAmt' ).focus ( ).select ( );
					break;
			}
		} );

		$ ( '#txtIncomeAmt' ).unbind ( ).keydown ( function ( event ) {
			switch ( event.keyCode.toString ( ) ) {
				case "13":
					$ ( '#txtIncludeYM' ).focus ( ).select ( );
					break;
			}
		} );

		$ ( '#txtIncludeYM' ).unbind ( ).keydown ( function ( event ) {
			switch ( event.keyCode.toString ( ) ) {
				case "13":
					$ ( '#txtSubmitYear' ).focus ( ).select ( );
					break;
			}
		} );

		$ ( '#txtSubmitYear' ).unbind ( ).keydown ( function ( event ) {
			switch ( event.keyCode.toString ( ) ) {
				case "13":
					fnPaySave ( );
					break;
			}
		} );
	}

	function fnPaySave ( ) {
		var amount = $ ( 'input.focus' ).val ( ).replace ( /,/g, '' );
		var vatAmt = Number ( $ ( '#txtIncomeTax' ).val ( ).replace ( /,/g, '' ) ) + Number ( $ ( '#txtJuminTax' ).val ( ).replace ( /,/g, '' ) );
		var reqAmt = Number ( amount ) - Number ( vatAmt );

		$ ( 'input.focus' ).parent ( ).next ( 'td' ).find ( 'input' ).val ( reqAmt.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
		$ ( 'input.focus' ).parent ( ).next ( 'td' ).next ( 'td' ).find ( 'input' ).val ( vatAmt.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );

		var result = {};
		result.etcdummy1 = $ ( '#selIncomeGbn' ).val ( ); /* 소득구분 */
		result.etcrate = $ ( '#txtReqExpendRate' ).val ( ).replace ( /,/g, '' ); /* 필요경비율 */
		result.ndepAm = $ ( '#txtReqExpendAmt' ).val ( ).replace ( /,/g, '' ); /* 필요경비금액 */
		result.inadAm = $ ( '#txtIncomeAmt' ).val ( ).replace ( /,/g, '' ); /* 소득금액 */
		result.intxAm = $ ( '#txtIncomeTax' ).val ( ).replace ( /,/g, '' ); /* 소득세액 */
		result.rstxAm = $ ( '#txtJuminTax' ).val ( ).replace ( /,/g, '' ); /* 주민세액 */
		result.etcrvrsYm = $ ( '#txtIncludeYM' ).val ( ).replace ( /\//g, '' ); /* 귀속년월 */
		result.etcdummy2 = $ ( '#txtSubmitYear' ).val ( ); /* 신고귀속 */
		$ ( 'input.focus' ).data ( 'result', result );

		$ ( '#selIncomeGbn' ).val ( '60' ).unbind ( );
		$ ( '#txtReqExpendRate' ).val ( '' ).unbind ( );
		$ ( '#txtReqExpendAmt' ).val ( '' ).unbind ( );
		$ ( '#txtIncomeAmt' ).val ( '' ).unbind ( );
		$ ( '#txtIncomeTax' ).val ( '' ).unbind ( );
		$ ( '#txtJuminTax' ).val ( '' ).unbind ( );
		$ ( '#txtIncludeYM' ).val ( '' ).unbind ( );
		$ ( '#txtSubmitYear' ).val ( '' ).unbind ( );
		$ ( '#divResolAmtCodeHelperPop' ).hide ( );
		$ ( 'input.focus' ).parent ( ).next ( 'td' ).find ( 'input' ).focus ( ).select ( );
	}

	function fnPayClose ( ) {
		$ ( '#selIncomeGbn' ).val ( '60' ).unbind ( );
		$ ( '#txtReqExpendRate' ).val ( '' ).unbind ( );
		$ ( '#txtReqExpendAmt' ).val ( '' ).unbind ( );
		$ ( '#txtIncomeAmt' ).val ( '' ).unbind ( );
		$ ( '#txtIncomeTax' ).val ( '' ).unbind ( );
		$ ( '#txtJuminTax' ).val ( '' ).unbind ( );
		$ ( '#txtIncludeYM' ).val ( '' ).unbind ( );
		$ ( '#txtSubmitYear' ).val ( '' ).unbind ( );
		$ ( '#divResolAmtCodeHelperPop' ).hide ( );
		$ ( 'input.focus' ).focus ( ).select ( );
	}

	function fnPayAutoCalc ( ) {
		var amount = $ ( 'input.focus' ).val ( ).toString ( ).replace ( /,/g, '' );
		/* 필요경비금액 */
		$ ( '#txtReqExpendAmt' ).val ( fnPayCalcTypeA ( amount, $ ( '#txtReqExpendRate' ).val ( ) ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
		/* 소득금액 */
		$ ( '#txtIncomeAmt' ).val ( fnPayCalcTypeB ( amount, $ ( '#txtReqExpendRate' ).val ( ) ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
		/* 소득세액 */
		$ ( '#txtIncomeTax' ).val ( fnPayCalcTypeC ( amount, $ ( '#txtReqExpendRate' ).val ( ) ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
		/* 주민세액 */
		$ ( '#txtJuminTax' ).val ( fnPayCalcTypeD ( amount, $ ( '#txtReqExpendRate' ).val ( ) ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
	}

	function fnPayPop ( ) {
		fnInitPayEvent ( );
		$ ( '#divResolAmtCodeHelperPop' ).show ( );
		$ ( '#selIncomeGbn' ).val ( '76' ).change ( );
		$ ( '#txtReqExpendAmt' ).focus ( ).select ( );
	}
	/* [-] ## pay event ################################################## */

	/* [+] ## key event ################################################## */
	function fnKeyEvent ( ) {
		$ ( document ).keydown ( function ( event ) {
			var preTarget = null, nextTarget = null, target = $ ( event.target );
			var targetType = target.prop ( 'type' );
			var trIndex = -1;
			if ( targetType == 'text' ) {
				trIndex = target.parent ( ).parent ( ).index ( );
				if ( target.parent ( ).next ( 'td' ).find ( 'input' ).length > 0 ) {
					nextTarget = $ ( target.parent ( ).next ( 'td' ).find ( 'input' ) );
				}
				if ( target.parent ( ).prev ( 'td' ).find ( 'input' ).length > 0 ) {
					preTarget = $ ( target.parent ( ).prev ( 'td' ).find ( 'input' ) );
				}
			}

			if ( $ ( target ).prop ( 'name' ) == 'searchStr' ) {
				fnKeyEventCommonCodePop ( event, preTarget, nextTarget, target, targetType, trIndex );
			} else {
				if ( $ ( '#commonCodeLayer' ).css ( 'display' ) != 'none' ) {
					$ ( '#txtSearchStr' ).focus ( );
				} else {
					fnKeyEventGridInput ( event, preTarget, nextTarget, target, targetType, trIndex );
				}
			}
		} );

		$ ( document ).keyup ( function ( event ) {
		} );
	}

	/* common code event */
	var preKey = '';

	function fnKeyEventCommonCodePop ( event, preTarget, nextTarget, target, targetType, trIndex ) {
		switch ( event.keyCode.toString ( ) ) {
			case "13":
				/* enter */
				if ( $ ( '#divCodeInfo.rightContents table tr' ).length == 0 ) {
					fnCommonCodeSearch ( );
				} else {
					$ ( '#divCodeInfo.rightContents table tr' ).unbind ( );
					$ ( '#divCodeInfo.rightContents table' ).unbind ( );
					$ ( '#divCodeInfo.rightContents table' ).empty ( );
					$ ( '#divCodeInfo.rightContents table' ).data ( 'result', [ ] );

					var result = [ ];
					$.each ( personInfo, function ( idx, item ) {
						if ( item.PER_CD.indexOf ( $ ( '#txtSearchStr' ).val ( ) ) > -1 ) {
							result.push ( item );
						} else if ( item.PER_NM.indexOf ( $ ( '#txtSearchStr' ).val ( ) ) > -1 ) {
							result.push ( item );
						} else if ( item.REG_NO.indexOf ( $ ( '#txtSearchStr' ).val ( ) ) > -1 ) {
							result.push ( item );
						}
					} );

					fnCommonCodeTableBind ( result );
					$ ( '#divCodeInfo.rightContents' ).scrollTop ( 0 );
				}
				break;
			case "9":
				$ ( '#divCodeInfo.rightContents table tr.lineOn.onSel' ).dblclick ( );
				break;
			case "38":
				/* up */
				var trIdx = $ ( '#divCodeInfo.rightContents table tr.lineOn.onSel' ).index ( );
				var trStartPosition = $ ( '#divCodeInfo.rightContents table tr:eq(0)' ).offset ( ).top;
				if ( trIdx != 0 ) {
					$ ( '#divCodeInfo.rightContents table tr:eq(' + trIdx + ')' ).removeClass ( 'lineOn onSel' );
					$ ( '#divCodeInfo.rightContents table tr:eq(' + ( trIdx - 1 ) + ')' ).addClass ( 'lineOn onSel' );
					$ ( '#divCodeInfo.rightContents' ).scrollTop ( ( $ ( '#divCodeInfo.rightContents table tr.lineOn.onSel' ).offset ( ).top - trStartPosition ) );
				} else {
					return;
				}
				break;
			case "40":
				/* down */
				var trIdx = $ ( '#divCodeInfo.rightContents table tr.lineOn.onSel' ).index ( );
				var trLen = $ ( '#divCodeInfo.rightContents table tr' ).length;
				var trStartPosition = $ ( '#divCodeInfo.rightContents table tr:eq(0)' ).offset ( ).top;

				if ( trIdx == ( trLen - 1 ) ) {
					var result = $ ( '#divCodeInfo.rightContents table' ).data ( 'result' );
					if ( trLen < result.length ) {
						fnCommonCodeTableBind ( );
					}

					var trLen = $ ( '#divCodeInfo.rightContents table tr' ).length;
				}

				if ( trIdx < ( trLen - 1 ) ) {
					$ ( '#divCodeInfo.rightContents table tr:eq(' + trIdx + ')' ).removeClass ( 'lineOn onSel' );
					$ ( '#divCodeInfo.rightContents table tr:eq(' + ( trIdx + 1 ) + ')' ).addClass ( 'lineOn onSel' );
					$ ( '#divCodeInfo.rightContents' ).scrollTop ( ( $ ( '#divCodeInfo.rightContents table tr.lineOn.onSel' ).offset ( ).top - trStartPosition ) );
				} else {
					return;
				}
				break;
			case "27":
				if ( $ ( '#commonCodeLayer' ).css ( 'display' ) != 'none' ) {
					fnCommonCodeClose ( );
				}
				if ( $ ( '#divResolAmtCodeHelperPop' ).css ( 'display' ) != 'none' ) {
					fnPayClose ( );
				}
				break;
			default:
				preKey = event.keyCode.toString ( );
				break;
		}
	}
	/* input event */
	function fnKeyEventGridInput ( event, preTarget, nextTarget, target, targetType, trIndex ) {
		switch ( event.keyCode.toString ( ) ) {
			case "13":
				/* 코드팝업인 경우 */
				if ( $ ( target ).prop ( 'name' ) == 'etctrCd' ) {
					if ( $ ( target ).data ( 'result' ) == undefined || $ ( target ).data ( 'result' ) == null ) {
						fnCommonCodePop ( );
						return;
					}
				}

				if ( $ ( target ).prop ( 'name' ) == 'pymntAmount' ) {
					if ( $ ( target ).val ( ) != '' && $ ( target ).val ( ) != '0' ) {
						fnPayPop ( );
						return;
					}
				}

				/* 코드팝업이 아닌 경우 */
				if ( nextTarget == null ) {
					if ( trIndex == ( $ ( '#divPayInfo.rightContents table tr' ).length - 1 ) ) {
						fnSetAddTableRow ( );
					}
					/* 행추가 */
					target.parent ( ).parent ( ).parent ( ).find ( 'tr:eq(' + ( trIndex + 1 ) + ') td:eq(1)' ).find ( 'input' ).click ( ).focus ( ).select ( );
				} else {
					nextTarget.click ( ).focus ( ).select ( );
				}
				break;
			case "8":
				if ( $ ( target ).prop ( 'name' ) == 'etctrCd' ) {
					$ ( target ).data ( 'result', null );
				}
				break;
			case "38":
				/* up */
				/* #. tr 이 맨 처음 경우 */
				if ( trIndex <= 0 ) {
					return;
				} else {
					var tdIndex = target.parent ( ).index ( );
					$ ( '#divPayInfo.rightContents table tr:eq(' + ( trIndex - 1 ) + ') td:eq(' + tdIndex + ')' ).find ( 'input' ).click ( ).focus ( ).select ( );
				}
				break;
			case "40":
				/* down */
				/* #. tr 이 맨 아래 경우 */
				if ( trIndex == ( $ ( '#divPayInfo.rightContents table tr' ).length - 1 ) ) {
					return;
				} else {
					var tdIndex = target.parent ( ).index ( );
					$ ( '#divPayInfo.rightContents table tr:eq(' + ( trIndex + 1 ) + ') td:eq(' + tdIndex + ')' ).find ( 'input' ).click ( ).focus ( ).select ( );
				}
				break;
			case "37":
				/* left */
				/* #. 왼쪽에 추가 input 이 없는 경우 */
				if ( preTarget == null ) {
					return;
				} else {
					preTarget.click ( ).focus ( ).select ( );

				}
				break;
			case "39":
				/* right */
				/* #. 오른쪽에 추가 input 이 없는 경우 */
				if ( nextTarget == null ) {
					return;
				} else {
					nextTarget.click ( ).focus ( ).select ( );
				}
				break;
			case "27":
				if ( $ ( '#commonCodeLayer' ).css ( 'display' ) != 'none' ) {
					fnCommonCodeClose ( );
				}
				if ( $ ( '#divResolAmtCodeHelperPop' ).css ( 'display' ) != 'none' ) {
					fnPayClose ( );
				}
				break;
		}
	}
	/* [-] ## key event ################################################## */

	/* [+] ## pay calc ################################################## */
	/* 필요경비금액 = 지급총액 * ( 필요경비율 / 100 ) */
	function fnPayCalcTypeA ( pymntAmount, prrt ) {
		var result;
		result = Math.round ( Number ( pymntAmount ) * ( Number ( prrt ) / 100 ) );
		return result;
	}
	/* 소득금액 = 지금총액 - ( 지급총액 * ( 필요경비율 / 100 ) ) */
	function fnPayCalcTypeB ( pymntAmount, prrt ) {
		var result;
		Math.round ( result = Math.round ( Number ( pymntAmount ) - ( Number ( pymntAmount ) * ( Number ( prrt ) / 100 ) ) ) );
		return result;
	}
	/* 소득세액 = ( 지금총액 - ( 지급총액 * ( 필요경비율 / 100 ) ) ) / 5 */
	function fnPayCalcTypeC ( pymntAmount, prrt ) {
		var result;
		result = Math.round ( ( Number ( pymntAmount ) - ( Number ( pymntAmount ) * ( Number ( prrt ) / 100 ) ) ) / 5 );
		return result;
	}
	/* 주민세액 = ( ( 지금총액 - ( 지급총액 * ( 필요경비율 / 100 ) ) ) / 5 ) / 10 */
	function fnPayCalcTypeD ( pymntAmount, prrt ) {
		var result;
		result = Math.round ( ( ( Number ( pymntAmount ) - ( Number ( pymntAmount ) * ( Number ( prrt ) / 100 ) ) ) / 5 ) / 10 );
		return result;
	}
	/* [-] ## pay calc ################################################## */

	/* [+] ## save ################################################## */
	function fnPersonPayInfoSave ( ) {
		var ajaxParam = {};
		ajaxParam.parameters = [ ];

		for ( var i = 0; i < $ ( '#divPayInfo table tr' ).length; i++ ) {
			var inputs = $ ( '#divPayInfo table tr:eq(' + i + ') td' ).find ( 'input' );
			var temp = {};
			$.each ( inputs, function ( idx, item ) {
				temp [ $ ( item ).prop ( 'name' ) ] = $ ( item ).val ( );
				console.log ( $ ( item ).prop ( 'name' ) + ' : ' + $ ( item ).val ( ) );
				if ( $ ( item ).data ( 'result' ) != null && $ ( item ).data ( 'result' ) != undefined ) {
					temp [ $ ( item ).prop ( 'name' ) + '_result' ] = $ ( item ).data ( 'result' );
				}
			} );

			if ( ( temp [ 'hnfLsftNo' ] || '' ) != '' ) {
				var param = {};
				$.extend(param, temp);
				param.anbojoSeq = anbojoSeq;
				param.dSeq = mseq;
				param.bSeq = lseq;
				param.tSeq = sseq;
				param.bsnsyear = bsnsyear;
				param.mosfGisuDt = mosfGisuDt;
				param.payFg = '2';
				param.wdAm = '0';
				param.etYn = '1';
				param.etcdataCd = 'G';
				param.etcdivCd = '${param.erpBizSeq}'

				param.etctrCd = ( temp [ 'etctrCd' ] || '' );
				param.hnfNm = ( temp [ 'hnfNm' ] || '' );
				param.hnfLsftNo = ( temp [ 'hnfLsftNo' ] || '' );
				param.prrt = ( temp [ 'prrt' ] || '' ); /* 참여율 */
				param.partcptnBeginDe = ( temp [ 'partcptnBeginDe' ] || '' ).replace ( /\//g, '' ); /* 참여시작일자 */
				param.partcptnEndDe = ( temp [ 'partcptnEndDe' ] || '' ).replace ( /\//g, '' ); /* 참여종료일자 */

				param.pymntAmount = ( temp [ 'pymntAmount_result' ] [ 'pymntAmount' ] || '' ); /* 지급총금액 */
				param.etcrvrsYm = ( temp [ 'pymntAmount_result' ] [ 'etcrvrsYm' ] || '' ); /* 급여/기타소득 귀속년월 */
				param.etcdummy1 = ( temp [ 'pymntAmount_result' ] [ 'etcdummy1' ] || '' ); /* 기타소득 소득구분 OR 자료 불러오기 구분 */
				param.etcdummy2 = ( temp [ 'pymntAmount_result' ] [ 'etcdummy2' ] || '' ); /* 기타소득 신고귀속년 */
				param.ndepAm = ( temp [ 'pymntAmount_result' ] [ 'ndepAm' ] || '' ); /* 기타소득 필요경비금액 */
				param.inadAm = ( temp [ 'pymntAmount_result' ] [ 'inadAm' ] || '' ); /* 기타소득 소득금액 */
				param.intxAm = ( temp [ 'pymntAmount_result' ] [ 'intxAm' ] || '' ); /* 급여/기타/사업 소득세액 */
				param.rstxAm = ( temp [ 'pymntAmount_result' ] [ 'rstxAm' ] || '' ); /* 급여/기타/사업 주민세액 */
				param.etcrate = ( temp [ 'pymntAmount_result' ] [ 'etcrate' ] || '' ); /* 필요경비율 */
				ajaxParam.parameters.push ( param );
			}
		}

		ajaxParam.parameters = JSON.stringify ( ajaxParam.parameters );

        var PersonPayInfo = {};
        if(opener.$('#txtPayInfoData').val() != ''){
            PersonPayInfo = JSON.parse(opener.$('#txtPayInfoData').val());
        }
        
        var key = '';
        key += fnGetPadLeft(anbojoSeq, 10);
        key += fnGetPadLeft(mseq, 3);
        key += fnGetPadLeft(lseq, 3);
        key += fnGetPadLeft(sseq, 3);
        PersonPayInfo[key] = ajaxParam.parameters;
        
        opener.$('#txtPayInfoData').val(JSON.stringify(PersonPayInfo));
		
		$.ajax ( {
			url: domain + '/exp/expend/angu/AnguPayI.do',
			async: true,
			type: "post",
			data: ajaxParam,
			datatype: "json",
			success: function ( result ) {
				if ( result.result.resultCode == 'SUCCESS' ) {
					self.close ( );
				} else {
					alert ( "오류가 발생되었습니다. 다시 시도해주세요." );
				}
			},
			error: function ( err ) {
				console.log ( err );
			}
		} );
	}
	
	function fnGetPadLeft(key, col){
        return ('0000000000' + key).substring((('0000000000' + key).length - col), ('0000000000' + key).length);
    }
	/* [-] ## save ################################################## */
</script>

<!-- 인력정보등록 팝업 -->
<div>
	<!-- modal -->
	<div class="modal posi_fix" style="z-index: 101"></div>

	<div class="pop_wrap_dir posi_ab" style="width: 800px; height: 574px; top: 50%; left: 50%; margin: -287px 0 0 -400px; z-index: 102">
		<div class="pop_head">
			<h1>인력정보등록</h1>
			<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
		</div>

		<div class="pop_con">
			<div class="top_box">
				<dl>
					<dt>지급처구분</dt>
					<dd>
						<input id="" type="text" value="2" style="width: 30px;" disabled="disabled" /> <input id="" type="text" value="기타소득" style="width: 80px;" readonly="readonly" />
					</dd>
					<!-- <dd class="ml10 mt23">1.급여, 2.기타소득 , 3.사업소득 / 지급처를 변경하기 위해선 모든 데이터를 삭제해야합니다.</dd> -->
				</dl>
			</div>
			<!-- 테이블 -->
			<div class="popTable mt20 table1">
				<div class="cus_ta">
					<table>
						<tr>
							<td class="p0 brn posi_re" width="*" valign="top">
								<!-- SCROLL HEADER --> <span class="scy_head1"></span> <!-- RIGHT HEADER -->
								<div id="divPayInfoH" class="cus_ta ovh mr17 rightHeader">
									<table>
										<tr>
											<th style="width: 50px;">순번</th>
											<th style="width: 100px;">코드</th>
											<th style="width: 120px;">지급처명</th>
											<th style="width: 140px;">생년월일</th>
											<th style="width: 100px;">지급총액</th>
											<th style="width: 100px;">실수령액</th>
											<th style="width: 100px;">원천징수액</th>
											<th style="width: 80px;">참여율</th>
											<th style="width: 100px;">참여시작일자</th>
											<th style="width: 100px;">참여종료일자</th>
										</tr>
									</table>
								</div> <!-- RIGHT CONTENTS -->
								<div id="divPayInfo" class="cus_ta scroll_fix rightContents" style="height: 307px;" onScroll="table1Scroll()">
									<table>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<!-- 안내문구 -->
			<!--<p class="text_blue f11 mt20"><span id="tooltip">F2:기타소득자코드도움 , F3:처리된 기타소득 불러오기 , F4:일반거래처도움</span></p>-->
			<p class="text_blue f11 mt20">
				<span id="tooltip">-</span>
			</p>

		</div>
		<!--// pop_con -->

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" value="삭제(F5)" /> <input type="button" id="btnCommit" value="확인" />
			</div>
		</div>
		<!-- //pop_foot -->
	</div>
	<!--// pop_wrap -->
</div>
<!--// 인력정보등록 팝업 -->
<div id="commonCodeLayer" class='divTopPopup' style="display: none;">
	<div class="modal posi_fix" style="z-index: 103"></div>
	<div class="pop_wrap_dir posi_ab" style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 104">
		<div class="pop_head">
			<h1>코드도움 [반영 : TAB]</h1>
			<a href="javascript:fnCommonCodeClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
		</div>
		<div class="pop_con">
			<div class="top_box">
				<dl>
					<dt>검색</dt>
					<dd class="mr0" style="width: 85%;">
						<input type="text" id="txtSearchStr" name="searchStr" style="width: 85%; text-indent: 4px;" /> <input type="button" id="btnSearch" value="검색" />
					</dd>
				</dl>
			</div>
			<div class="popTable mt20 table1">
				<div class="cus_ta">
					<table>
						<tr>
							<td class="p0 brn posi_re" width="*" valign="top">
								<!-- SCROLL HEADER --> <span class="scy_head1"></span> <!-- RIGHT HEADER -->
								<div id="" class="cus_ta ovh mr17 rightHeader">
									<table>
										<tr>
											<th style="width: 100px;">코드</th>
											<th style="width: 100px;">소득자명</th>
											<th style="width: 200px;">주민번호</th>
										</tr>
									</table>
								</div> <!-- RIGHT CONTENTS -->
								<div id="divCodeInfo" class="cus_ta scroll_fix rightContents" style="height: 307px;" onScroll="table1Scroll()">
									<table>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 원천징수액입력 -->
<div id="divResolAmtCodeHelperPop" class='divTopPopup' style="display: none;">
	<!-- modal -->
	<div class="modal posi_fix" style="z-index: 101"></div>

	<div class="pop_wrap_dir posi_ab" style="width: 396px; height: 425px; top: 50%; left: 50%; margin: -212px 0 0 -188px; z-index: 102">
		<div class="pop_head">
			<h1>원천징수액 입력</h1>
			<a href="javascript:fnPayClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
		</div>
		<div class="pop_con">
			<!-- 테이블 -->
			<div class="com_ta">
				<table>
					<colgroup>
						<col width="120" />
						<col width="50" />
					</colgroup>

					<tr>
						<th>소득구분</th>
						<td class="le"><select id="selIncomeGbn" style="width: 180px;">
								<option value="60">필요경비 없는 기타소득(63 제외)</option>
								<option value="62">그외 필요경비있는 기타소득</option>
								<option value="63">연금저축,소기업소상공인공제부금해지 소득</option>
								<option value="68">비과세 기타소득</option>
								<option value="71">상금 및 부상</option>
								<option value="72">광업권 등</option>
								<option value="73">지역권 등</option>
								<option value="74">주택입주지체상금</option>
								<option value="75">원고료 등</option>
								<option value="76">강연료 등</option>
						</select></td>
					</tr>
					<tr>
						<th>필요경비율</th>
						<td class="le"><input type="text" id="txtReqExpendRate" class="td_inp" style="width: 36px;" value="">&nbsp;%</td>
					</tr>
					<tr>
						<th>필요경비금액</th>
						<td class="le"><input type="text" id="txtReqExpendAmt" class="td_inp ar pr5" style="width: 175px;" value="">&nbsp;원</td>
					</tr>
					<tr>
						<th>소득금액</th>
						<td class="le"><input type="text" id="txtIncomeAmt" class="td_inp ar pr5" style="width: 175px;" value="" readonly="">&nbsp;원</td>
					</tr>
					<tr>
						<th>소득세액</th>
						<td class="le"><input type="text" id="txtIncomeTax" class="td_inp ar pr5" style="width: 175px;" value="" disabled="disabled">&nbsp;원</td>
					</tr>
					<tr>
						<th>주민세액</th>
						<td class="le"><input type="text" id="txtJuminTax" class="td_inp ar pr5" style="width: 175px;" value="" disabled="disabled">&nbsp;원</td>
					</tr>
					<tr>
						<th>귀속년월</th>
						<td class="le"><input type="text" id="txtIncludeYM" class="td_inp" style="width: 60px;" value=""></td>
					</tr>
					<tr>
						<th>신고귀속</th>
						<td class="le"><input type="text" id="txtSubmitYear" class="td_inp" style="width: 42px;" value="" readonly=""></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" id="btnSaveSubResolAmt" value="저장" /> <input type="button" id="btnCancelSubResolAmt" class="gray_btn" value="취소" />
			</div>
		</div>
		<!-- //pop_foot -->
	</div>
</div>