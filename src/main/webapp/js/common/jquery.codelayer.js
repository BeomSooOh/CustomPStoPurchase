( function ( $ ) {
	var testDomain = '';
	var preKeyCode = '';
	var gCodeType = {
		/* 국고보조통합시스템 */
		/* 국고보조통합시스템 - 지급구분 */
		anguPayDiv: {
			url: '',
			colTitles: [ '코드', '명' ],
			colWidths: [ '150', '300' ],
			colAlignments: [ 'cen', 'le' ],
			colKeys: [ 'anguPayDivCode', 'anguPayDivName' ],
			title: '지급구분',
			searchType: 'A',
			source: [ {
				anguPayDivCode: '1',
				anguPayDivName: '일반'
			}, {
				anguPayDivCode: '2',
				anguPayDivName: '인건비성'
			} ],
			searchSource: [ ]
		},
		/* 국고보조통합시스템 - 국고보조사업 */
		anguBusiness: {
			url: testDomain + '/exp/expend/angu/getAnguBusinessInfoI_Select.do',
			colTitles: [ '상세사업내역코드', '상세사업내역명' ],
			colWidths: [ '150', '300' ],
			colAlignments: [ 'cen', 'le' ],
			colKeys: [ 'anguBusinessCode', 'anguBusinessName' ],
			title: '국고보조사업',
			searchType: 'A',
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				if ( window [ 'fnGetParamAnguBusiness' ] ) {
					return window [ 'fnGetParamAnguBusiness' ] ( );
				} else {
					$.error ( '[fnGetParamAnguBusiness] 함수가 정의되지 않았습니다. ( return ex) BSNSYEAR=2017 )' );
				}
			}
		},
		/* 국고보조통합시스템 - 이체계좌구분 */
		anguAccountDiv: {
			url: testDomain + '/exp/expend/angu/getAnguAccountDivInfoI_Select.do',
			colTitles: [ '코드', '명' ],
			colWidths: [ '150', '300' ],
			colAlignments: [ 'cen', 'le' ],
			colKeys: [ 'anguAccountDivCode', 'anguAccountDivName' ],
			title: '이체계좌구분코드',
			searchType: 'A',
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				return 'CMMN_CODE=1089';
			}
		},
		/* 국고보조통합시스템 - 자계좌이체사유코드 */
		anguAccountReasonDiv: {
			url: testDomain + '/exp/expend/angu/getAnguAccountReasonDivInfoI_Select.do',
			colTitles: [ '코드', '명' ],
			colWidths: [ '150', '300' ],
			colAlignments: [ 'cen', 'le' ],
			colKeys: [ 'anguAccountReasonDivCode', 'anguAccountReasonDivName' ],
			title: '자계좌이체사유코드',
			searchType: 'A',
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				return 'CMMN_CODE=0665';
			}
		},
		/* 국고보조통합시스템 - 증빙구분 */
		anguAuthDiv: {
			url: '',
			colTitles: [ '코드', '명' ],
			colWidths: [ '150', '300' ],
			colAlignments: [ 'cen', 'le' ],
			colKeys: [ 'anguAuthDivCode', 'anguAuthDivName' ],
			title: '증빙구분',
			searchType: 'A',
			source: [ {
				anguAuthDivCode: "001",
				anguAuthDivName: "전자세금계산서"
			}, {
				anguAuthDivCode: "002",
				anguAuthDivName: "전자계산서"
			}, {
				anguAuthDivCode: "004",
				anguAuthDivName: "카드"
			}, {
				anguAuthDivCode: "999",
				anguAuthDivName: "기타"
			} ],
			searchSource: [ ]
		},
		/* 국고보조통합시스템 - 증빙승인번호 - 전자세금계산서(과세) */
		anguEtaxTax: {
			url: testDomain + '/exp/expend/angu/getAnguEtaxTaxInfoI_Select.do',
			colTitles: [ 'No', '분류', '작성일자', '발급일자', '거래처명', '거래처사업번호', '공급가액', '부가세', '합계액', '전자세금계산서승인번호', '기사용금액', '등록가능금액' ],
			colWidths: [ '50', '100', '100', '100', '200', '100', '120', '120', '120', '200', '120', '120', '120' ],
			colAlignments: [ 'cen', 'cen', 'cen', 'cen', 'le', 'le', 'ri', 'ri', 'ri', 'le', 'ri', 'ri', 'ri' ],
			colKeys: [ 'anguEtaxTaxNo', 'anguEtaxTaxDiv', 'anguEtaxTaxWriteDate', 'anguEtaxTaxIssueDate', 'anguEtaxTaxPartnerName', 'anguEtaxTaxPartnerNum', 'anguEtaxTaxAmt', 'anguEtaxTaxVat', 'anguEtaxTaxReqAmt', 'anguEtaxTaxNum', 'anguEtaxTaxUsedAmt', 'anguEtaxTaxNotUsedAmt' ],
			title: '전자세금계산서',
			searchType: 'B',
			reSearch: 'Y', /* ajax 재요청 여부 */
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				var returnParam = '';
				var rowValue = $ ( '#' + $.fn.codelayer.options [ 'anguEtaxTax' ].id ).dtable ( 'rowGetJsonData', $ ( '#' + $.fn.codelayer.options [ 'anguEtaxTax' ].id ).dtable ( 'rowGetIndex' ) );

				if ( $ ( '#selDateDiv' ).val ( ) === 'WriteDate' ) {
					returnParam += 'DT_FG=1';
				} else {
					returnParam += 'DT_FG=2';
				}

				returnParam += '&FR_DT=' + $ ( '#txtETaxFromDate' ).val ( ).toString ( ).replace ( /-/g, '' );
				returnParam += '&TO_DT=' + $ ( '#txtETaxToDate' ).val ( ).toString ( ).replace ( /-/g, '' );
				returnParam += '&ETAX_TY=' + $ ( '#selETaxDiv' ).val ( );
				returnParam += '&TR_CD=';
				returnParam += '&DDTLBZ_ID=' + rowValue.anguBusinessCode;
				returnParam += '&TASC_CMMN_DETAIL_CODE_NM=' + rowValue.anguAccountDivCode;

				return returnParam;
			}
		},
		/* 국고보조통합시스템 - 증빙승인번호 - 전자계산서(면세) */
		anguEtaxTaxFree: {
			url: testDomain + '/exp/expend/angu/getAnguEtaxTaxFreeInfoI_Select.do',
			colTitles: [ 'No', '분류', '작성일자', '발급일자', '거래처명', '거래처사업번호', '공급가액', '부가세', '합계액', '전자세금계산서승인번호', '기사용금액', '등록가능금액' ],
			colWidths: [ '50', '100', '100', '100', '200', '100', '120', '120', '120', '200', '120', '120', '120' ],
			colAlignments: [ 'cen', 'cen', 'cen', 'cen', 'le', 'le', 'ri', 'ri', 'ri', 'le', 'ri', 'ri', 'ri' ],
			colKeys: [ 'anguEtaxTaxNo', 'anguEtaxTaxDiv', 'anguEtaxTaxWriteDate', 'anguEtaxTaxIssueDate', 'anguEtaxTaxPartnerName', 'anguEtaxTaxPartnerNum', 'anguEtaxTaxAmt', 'anguEtaxTaxVat', 'anguEtaxTaxReqAmt', 'anguEtaxTaxNum', 'anguEtaxTaxUsedAmt', 'anguEtaxTaxNotUsedAmt' ],
			title: '전자세금계산서',
			searchType: 'B',
			reSearch: 'Y', /* ajax 재요청 여부 */
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				var returnParam = '';
				var rowValue = $ ( '#' + $.fn.codelayer.options [ 'anguEtaxTaxFree' ].id ).dtable ( 'rowGetJsonData', $ ( '#' + $.fn.codelayer.options [ 'anguEtaxTax' ].id ).dtable ( 'rowGetIndex' ) );

				if ( $ ( '#selDateDiv' ).val ( ) === 'WriteDate' ) {
					returnParam += 'DT_FG=1';
				} else {
					returnParam += 'DT_FG=2';
				}

				returnParam += '&FR_DT=' + $ ( '#txtETaxFromDate' ).val ( ).toString ( ).replace ( /-/g, '' );
				returnParam += '&TO_DT=' + $ ( '#txtETaxToDate' ).val ( ).toString ( ).replace ( /-/g, '' );
				returnParam += '&ETAX_TY=' + $ ( '#selETaxDiv' ).val ( );
				returnParam += '&TR_CD=';
				returnParam += '&DDTLBZ_ID=' + rowValue.anguBusinessCode;
				return returnParam;
			}
		},
		/* 국고보조통합시스템 - 증빙승인번호 - 카드 */
		anguCard: {
			url: testDomain + '/exp/expend/angu/getAnguCardInfoI_Select.do',
			colTitles: [ '거래일자', '카드명', '카드번호', '가맹점명', '가맹점사업자번호', '카드승인번호', '공급가액', '부가세', '총금액', '기사용금액', '등록가능금액' ],
			colWidths: [ '100', '100', '100', '150', '100', '150', '100', '100', '100', '100', '100' ],
			colAlignments: [ 'le', 'le', 'le', 'le', 'le', 'le', 'le', 'le', 'le', 'le', 'le' ],
			colKeys: [ 'anguEtaxTaxIssueDate', 'trNm', 'cardNo', 'anguEtaxTaxPartnerName', 'anguEtaxTaxPartnerNum', 'anguEtaxTaxNum', 'anguEtaxTaxAmt', 'anguEtaxTaxVat', 'anguEtaxTaxReqAmt', 'excutSumAmount', 'am' ],
			title: '카드거래내역',
			searchType: 'C',
			reSearch: 'N', /* ajax 재요청 여부 */
			source: [ ],
			searchSource: [ ],
			cardAuth: [ ],
			getParam: function ( ) {
				var returnParam = '';
				var rowValue = $ ( '#' + $.fn.codelayer.options [ 'anguCard' ].id ).dtable ( 'rowGetJsonData', $ ( '#' + $.fn.codelayer.options [ 'anguCard' ].id ).dtable ( 'rowGetIndex' ) );
				var oldValue =  ($ ( '#selETaxDiv' ).val() || '');
				gCodeType.anguCard.cardAuth = [ ]; /* 초기화 */
				if ( gCodeType.anguCard.cardAuth.length === 0 && $ ( '#selETaxDiv > option' ).length === 0 ) {
					$.ajax ( {
						url: '/exp/expend/angu/getAnguCardAuthI_Select.do?DDTLBZ_ID=' + rowValue.anguBusinessCode,
						async: false,
						success: function ( result ) {
							gCodeType.anguCard.cardAuth = [ ];
							gCodeType.anguCard.cardAuth = result.result.aaData;

							$.each ( gCodeType.anguCard.cardAuth, function ( idx, item ) {
								$ ( '#selETaxDiv' ).append ( '<option value="' + item.BA_NB + '">' + item.TR_NM + '</option>' );
							} );
						}
					} );
				}
				
				if((oldValue || '') != ''){
					$ ( '#selETaxDiv' ).val(oldValue);
				}

				returnParam += 'CONFM_DE_FR=' + $ ( '#txtETaxFromDate' ).val ( ).toString ( ).replace ( /-/g, '' );
				returnParam += '&CONFM_DE_TO=' + $ ( '#txtETaxToDate' ).val ( ).toString ( ).replace ( /-/g, '' );
				returnParam += '&CARD_NO=' + $ ( '#selETaxDiv' ).val ( );
				returnParam += '&MRHST_NM=';
				returnParam += '&PUCHAS_TAMT=0';
				returnParam += '&DDTLBZ_ID=' + rowValue.anguBusinessCode;
				returnParam += '&TASC_CMMN_DETAIL_CODE_NM=' + rowValue.anguAccountDivCode;
				return returnParam;
			}
		},
		/* 국고보조통합시스템 - 거래처구분 */
		anguPartnerDiv: {
			url: '',
			colTitles: [ '코드', '명' ],
			colWidths: [ '150', '300' ],
			colAlignments: [ 'cen', 'le' ],
			colKeys: [ 'anguPartnerDivCode', 'anguPartnerDivName' ],
			title: '거래처구분',
			searchType: 'A',
			source: [ {
				anguPartnerDivCode: '001',
				anguPartnerDivName: '법인거래'
			}, {
				anguPartnerDivCode: '002',
				anguPartnerDivName: '개인사업자'
			}, {
				anguPartnerDivCode: '003',
				anguPartnerDivName: '개인거래'
			} ],
			searchSource: [ ]
		},
		/* 국고보조통합시스템 - 증빙내역 - 사원 */
		anguEmpAuth: {
			url: testDomain + '/exp/expend/angu/getAnguEmpInfoI_Select.do',
			colTitles: [ '사원코드', '사원명', '금융기관', '금융기관명', '입금계좌번호', '거래처사업자/주민번호', '사업장주소', '대표자명', '전화번호' ],
			colWidths: [ '100', '150', '150', '200', '200', '300', '300', '150', '150' ],
			colAlignments: [ 'cen', 'le', 'cen', 'le', 'le' ],
			colKeys: [ 'TR_CD', 'anguEtaxTaxPartnerName', 'BCNC_BANK_CODE', 'BANK_NM', 'BCNC_ACNUT_NO', 'anguEtaxTaxPartnerNum', 'BCNC_ADRES', 'BCNC_RPRSNTY_NM', 'BCNC_TELNO' ],
			title: '거래처',
			searchType: 'A',
			source: [ ],
			searchSource: [ ]
		},
		/* 국고보조통합시스템 - 증빙내역 - 코드 */
		anguPartnerAuth: {
			url: testDomain + '/exp/expend/angu/getAnguPartnerInfoI_Select_01.do?P_HELP_TY=&P_USE_YN=1',
			colTitles: [ '거래처코드', '거래처명', '사업자번호', '계좌번호', '대표자명' ],
			colWidths: [ '150', '300', '150', '150', '150' ],
			colAlignments: [ 'cen', 'le', 'cen', 'le', 'le' ],
			colKeys: [ 'TR_CD', 'anguEtaxTaxPartnerName', 'anguEtaxTaxPartnerNum', 'BCNC_ACNUT_NO', 'BCNC_RPRSNTY_NM' ],
			title: '거래처',
			searchType: 'A',
			source: [ ],
			searchSource: [ ]
		},
		/* 국고보조통합시스템 - 보조비목세목코드 */
		anguAsstnExpitmTaxitm: {
			url: testDomain + '/exp/expend/angu/getAnguBimokInfoI_Select.do',
			colTitles: [ '코드', '비목명', '세목명' ],
			colWidths: [ '100', '150', '150' ],
			colAlignments: [ 'cen', 'le', 'le' ],
			colKeys: [ 'subDetailBimokCode', 'subBimokName', 'subDetailBimokName' ],
			title: '보조비목세목코드',
			searchType: 'A',
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				if ( window [ 'fnGetBimokParam' ] ) {
					return window [ 'fnGetBimokParam' ] ( );
				} else {
					$.error ( '보조비목세목 파라미터 정의 함수가 없습니다. (fnGetBimokParam)' );
				}
			}
		},
		/* 국고보조통합시스템 - 재원구분 */
		anguJaewonDiv: {
			url: testDomain + '/exp/expend/angu/getAnguJaewonInfoI_Select.do',
			colTitles: [ '코드', '명' ],
			colWidths: [ '150', '300' ],
			colAlignments: [ 'cen', 'le' ],
			colKeys: [ 'anguJaewonDivCode', 'anguJaewonDivName' ],
			title: '재원정보',
			searchType: 'A',
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				if ( window [ 'fnGetJaewonParam' ] ) {
					return window [ 'fnGetJaewonParam' ] ( );
				} else {
					$.error ( '재원구분 파라미터 정의 함수가 없습니다. (fnGetJaewonParam)' );
				}
			}
		},
		/* 국고보조통합시스템 - 프로젝트 */
		anguProject: {
			url: testDomain + '/exp/expend/angu/getAnguProjectInfoI_Select.do',
			colTitles: [ '프로젝트 코드', '프로젝트명', '코드', '출금계좌' ],
			colWidths: [ '100', '300', '100', '150' ],
			colAlignments: [ 'cen', 'le', 'cen', 'le' ],
			colKeys: [ 'mgtCode', 'pjtName', 'TR_CD', 'TR_NM' ],
			title: '프로젝트',
			searchType: 'A',
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				if ( window [ 'fnGetProjectParam' ] ) {
					return window [ 'fnGetProjectParam' ] ( );
				} else {
					$.error ( '프로젝트 파라미터 정의 함수가 없습니다. (fnGetProjectParam)' );
				}
			}
		},
		/* 국고보조통합시스템 - 예산과목 */
		anguBgt: {
			url: testDomain + '/exp/expend/angu/getAnguBgtInfoI_Select.do',
			colTitles: [ '예산그룹', '관', '항', '목', '세', '코드' ],
			colWidths: [ '100', '100', '100', '100', '100', '100' ],
			colAlignments: [ 'le', 'le', 'le', 'le', 'le', 'le' ],
			colKeys: [ 'GROUP_NM', 'BGT01_NM', 'BGT02_NM', 'BGT03_NM', 'BGT04_NM', 'BGT_CD' ],
			title: '예산과목',
			searchType: 'A',
			reSearch: 'N', /* ajax 재요청 여부 */
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				if ( window [ 'fnGetBgtParam' ] ) {
					return window [ 'fnGetBgtParam' ] ( );
				} else {
					$.error ( '예산과목 파라미터 정의 함수가 없습니다. (fnGetBgtParam)' );
				}
			}
		},
		/* e나라도움 - 금융기관(iCUBE G20) */
		anguG20Bank: {
			url: testDomain + '/exp/expend/angu/getAnguG20BankInfoI_Select_01.do',
			colTitles: [ '코드', '은행명' ],
			colWidths: [ '100', '200' ],
			colAlignments: [ 'le', 'le' ],
			colKeys: [ 'DUZON_BANK_CODE', 'BANK_NM' ],
			title: '거래처',
			searchType: 'A',
			reSearch: 'N', /* ajax 재요청 여부 */
			source: [ ],
			searchSource: [ ]
		},
		/* 국고보조통합시스템 - 금융거래처 */
		anguBankPartner: {
			url: testDomain + '/exp/expend/angu/getAnguBankPartnerInfoI_Select.do',
			colTitles: [ '거래처코드', '거래처명', '사업자번호', '계좌번호', '대표자명' ],
			colWidths: [ '100', '300', '150', '150', '100' ],
			colAlignments: [ 'le', 'le', 'le', 'le', 'le', 'le' ],
			colKeys: [ 'TR_CD', 'TR_NM', 'REG_NB', 'BA_NB', 'CEO_NM' ],
			title: '거래처',
			searchType: 'A',
			reSearch: 'N', /* ajax 재요청 여부 */
			source: [ ],
			searchSource: [ ],
			getParam: function ( ) {
				if ( window [ 'fnGetBankPartnerParam' ] ) {
					return window [ 'fnGetBankPartnerParam' ] ( );
				} else {
					$.error ( '예산과목 파라미터 정의 함수가 없습니다. (fnGetBankPartnerParam)' );
				}
			}
		},
		/* 차량운행기록부 */
		car: {
			url: testDomain + '/exp/bi/admin/car/CarInfoListSelect.do?searchStr=&useYN=',
			colTitles: [ '차량코드', '차량번호', '차종' ],
			colWidths: [ '', '', '' ],
			colAlignments: [ 'cen', 'cen', 'le' ],
			colKeys: [ 'carCode', 'carNumber', 'carName' ],
			title: '차량',
			searchType: 'A',
			source: [ ],
			searchSource: [ ]
		}
	};

	var methods = {
		setSource: function ( type, source ) {
			switch ( type ) {
				case 'anguPartnerAuth':
					gCodeType [ type ].source = source;
					break;
			}
		},
		init: function ( options ) {
			/* parameter 처리 */
			if ( !options.codeType ) {
				$.error ( 'not exists codeType' );
				return;
			}
			var defaults = {
				id: '',
				codeType: '',
				width: 500,
				height: 602,
				bindMaxSeq: 0,
				/* 삭제된 상위 항목 수 */
				removeUpCount: 0,
				/* 현재 포커스 위치 */
				selectFocus: 0,
				reSearch: 'N' /* ajax 재요청 여부 */
			};
			var options = $.extend ( options, gCodeType [ options.codeType ] );
			if ( options.searchType === 'B' || options.searchType === 'C' ) {
				// options.width = 741;
				options.width = 800;
				options.height = 636;
			}

			options = $.extend ( defaults, options );
			var id = $ ( this ).prop ( 'id' );
			var main = $ ( this );
			/* $('#divCodeLayer').codeLayer({}); */
			/* create layer */
			var createLayer = function ( ) {
				/* save options */
				if ( !$.fn.codelayer.options ) {
					$.fn.codelayer.options = [ ];
				}
				$.fn.codelayer.options [ options.codeType ] = options;
				/* layout */
				main.codelayer ( 'layerSetLayout', options.codeType );
				/* searcy type */
				main.codelayer ( 'layerSetSearchType', options.codeType );
				/* bind title */
				main.codelayer ( 'layerSetTitle', options.codeType );

				/* get json data */
				var result = [ ];
				if ( options.reSearch !== 'Y' ) {
					if ( options.url != '' ) {
						/* 거래처는 조회 시간이 오래 걸리므로 사전 조회시 그냥 이용한다. */
						if ( !( options.codeType === 'anguPartnerAuth' && options.source.length > 0 ) ) {
							result.push ( $.ajax ( {
								url: options.url + '?' + ( ( options.getParam ) ? options.getParam ( ) : '' ),
								success: function ( result ) {
									if ( result.result.resultCode === 'SUCCESS' ) {
										if ( result.result.aaData ) {
											if ( options.codeType === 'car' ) {
												result.result.aaData.forEach ( function ( item, idx ) {
													item.carDispName = item.carCode + '. ' + item.carNumber + ' (' + item.carName + ')';
												} );
											}
											options.source = result.result.aaData;
										} else {
											options.source = [ ];
										}
									} else {
										$.error ( result.result.resultCode );
										alert ( '데이터 조회 중 확인되지 않은 문제점이 발생되었습니다.\r\n지속적으로 발생될 경우 관리자에게 문의해 주세요.' )
									}
								}
							} ) );
						}
					}
				}
				if ( result.length > 0 ) {
					$.when.apply ( this, result ).done ( function ( ) {
						/* bind list */
						main.codelayer ( 'layerSetBindList', options.codeType );
						/* set event */
						main.codelayer ( 'layerSetEvent', options.codeType );
						/* layer focus */
						main.codelayer ( 'layerFocus', options.codeType );
					} );
				} else {
					/* bind list */
					main.codelayer ( 'layerSetBindList', options.codeType );
					/* set event */
					main.codelayer ( 'layerSetEvent', options.codeType );
					/* layer focus */
					main.codelayer ( 'layerFocus', options.codeType );
				}

				/* resize event */
				pop_position ( );
				$ ( window ).resize ( function ( ) {
					pop_position ( );
				} );
			}
			createLayer ( );
		},
		layerSetLayout: function ( codeType ) {
			var id = $ ( this ).prop ( 'id' );
			/* modal 확인 */
			if ( $ ( '.sub_wrap' ).find ( '.modal' ).length === 0 ) {
				$ ( '.sub_wrap' ).append ( '<div class="modal"></div>' );
			}
			if ( !$ ( '#' + id ).hasClass ( 'pop_wrap_dir' ) ) {
				$ ( '#' + id ).addClass ( 'pop_wrap_dir' );
			}
			$ ( '#' + id ).contents ( ).unbind ( ).remove ( );
			/* layer size */
			$ ( '#' + id ).width ( $.fn.codelayer.options [ codeType ].width );
			$ ( '#' + id ).height ( $.fn.codelayer.options [ codeType ].height );
			/* layer head */
			var layoutHtml = '';
			layoutHtml += '<div class="pop_head">';
			layoutHtml += '		<h1>' + $.fn.codelayer.options [ codeType ].title + '</h1>';
			layoutHtml += '		<a href="#n" class="clo" id="btnCodeLayerClose"><img src="/exp/Images/btn/btn_pop_clo02.png" alt="" /></a>';
			layoutHtml += '</div>';
			layoutHtml += '<div class="pop_con">';
			layoutHtml += '</div>';
			layoutHtml += '<div class="pop_foot">';
			layoutHtml += '		<div class="btn_cen pt12">';
			layoutHtml += '			<input type="button" id="btnLayerReSearch" value="조회 ( F12 )" />'; /* 옵션처리 필요 */
			layoutHtml += '			<input type="button" id="btnLayerCommit" value="확인 ( TAB )" />'; /* 옵션처리 필요 */
			layoutHtml += '			<input type="button" id="btnLayerReject" class="gray_btn" value="취소 ( ESC )" />'; /* 옵션처리 필요 */
			layoutHtml += '		</div>';
			layoutHtml += '</div>';
			$ ( '#' + id ).append ( layoutHtml );

			$ ( '#btnCodeLayerClose' ).click ( function ( ) {
				$ ( '#' + id ).codelayer ( 'layerClose', codeType );
			} );
			return;
		},
		layerSetSearchType: function ( codeType ) {
			/* search type - A : 검색어만 존재하는 Layer */
			var id = $ ( this ).prop ( 'id' );
			var searchBoxHtml = '';
			switch ( $.fn.codelayer.options [ codeType ].searchType ) {
				case 'A':
					searchBoxHtml += '<div class="top_box">';
					searchBoxHtml += '		<dl>';
					searchBoxHtml += '			<dt>검색어</dt>';
					searchBoxHtml += '			<dd><input type="text" id="btnLayerSearchTextBox" style="width:200px" /></dd>';
					searchBoxHtml += '			<dd><input type="button" id="btnLayerSearch" value="검색" /></dd>';
					searchBoxHtml += '		</dl>';
					searchBoxHtml += '</div>';
					break;
				case 'B':
					searchBoxHtml += '<div class="top_box">';
					searchBoxHtml += '	<dl>';
					searchBoxHtml += '		<dl>';
					searchBoxHtml += '			<dd class="ml20" style="width:150px;">';
					searchBoxHtml += '				<select class="selectmenu pr20" id="selDateDiv"><option value="WriteDate">작성일자</option><option value="IssueDate">발행일자</option></select>';
					searchBoxHtml += '			</dd>';
					searchBoxHtml += '			<dd>';
					searchBoxHtml += '				<div class="dal_div">';
					searchBoxHtml += '					<input id="txtETaxFromDate" type="text" value="" class="w113" />';
					searchBoxHtml += '				</div>';
					searchBoxHtml += '				~';
					searchBoxHtml += '				<div class="dal_div">';
					searchBoxHtml += '					<input id="txtETaxToDate" type="text" value="" class="w113" />';
					searchBoxHtml += '				</div>';
					searchBoxHtml += '			</dd>';
					searchBoxHtml += '			<dt class="ar" style="width: 94px;">세무구분</dt>';
					searchBoxHtml += '			<dd style="width:150px;">';
					if ( codeType === 'anguEtaxTax' ) {
						searchBoxHtml += '				<input class="input_search" type="text" value="과세" style="width:120px;" readonly="readonly" />';
					} else if ( codeType === 'anguEtaxTaxFree' ) {
						searchBoxHtml += '				<input class="input_search" type="text" value="면세" style="width:120px;" readonly="readonly" />';
					}
					searchBoxHtml += '			</dd>';
					searchBoxHtml += '		</dl>';
					searchBoxHtml += '		<dl class="next2">';
					searchBoxHtml += '			<dt class="ar" style="width:145px;">매입거래처</dt>';
					searchBoxHtml += '			<dd style="width:250px;">';
					searchBoxHtml += '				<input id="txtPartnerName" class="input_search" id="" type="text" value="" style="width:220px;" />';
					searchBoxHtml += '				<a href="#" class="btn_search"></a>';
					searchBoxHtml += '			</dd>';
					searchBoxHtml += '			<dt>세금계산서분류</dt>';
					searchBoxHtml += '			<dd style="width:150px;">';
					searchBoxHtml += '				<select class="selectmenu pr20" id="selETaxDiv"><option value="">전체</option><option value="1">일반</option><option value="2">수정</option></select>';
					searchBoxHtml += '			</dd>';
					searchBoxHtml += '		</dl>';
					searchBoxHtml += '	</dl>';
					searchBoxHtml += '</div>';
					break;
				case 'C':
					searchBoxHtml += '<div class="top_box">';
					searchBoxHtml += '	<dl>';
					searchBoxHtml += '		<dt class="ar" style="width:145px;">카드거래일자</dt>';
					searchBoxHtml += '		<dd>';
					searchBoxHtml += '			<div class="dal_div">';
					searchBoxHtml += '				<input id="txtETaxFromDate" type="text" value="" class="w113" />';
					searchBoxHtml += '			</div>';
					searchBoxHtml += '			~';
					searchBoxHtml += '			<div class="dal_div">';
					searchBoxHtml += '				<input id="txtETaxToDate" type="text" value="" class="w113" />';
					searchBoxHtml += '			</div>';
					searchBoxHtml += '		</dd>';
					searchBoxHtml += '		<dt class="ar" style="width: 94px;">신용카드</dt>';
					searchBoxHtml += '			<dd style="width:150px;">';
					searchBoxHtml += '				<select class="selectmenu pr20" id="selETaxDiv"></select>';
					searchBoxHtml += '			</dd>';
					searchBoxHtml += '	</dl>';
					searchBoxHtml += '</div>';
					break;
				default:
					searchBoxHtml = '';
					break;
			}

			$ ( '#' + id ).find ( '.pop_con' ).append ( searchBoxHtml );

			$ ( "#txtETaxFromDate" ).kendoDatePicker ( {
				format: "yyyy-MM-dd",
				culture: "ko-KR"
			} );
			$ ( "#txtETaxToDate" ).kendoDatePicker ( {
				format: "yyyy-MM-dd",
				culture: "ko-KR"
			} );

			var now = new Date ( );
			$ ( "#txtETaxFromDate" ).val ( [ now.getFullYear ( ), ( now.getMonth ( ) + 1 ) < 10 ? '0' + ( now.getMonth ( ) + 1 ) : ( now.getMonth ( ) + 1 ), '01' ].join ( '-' ) );
			$ ( "#txtETaxToDate" ).val ( [ now.getFullYear ( ), ( now.getMonth ( ) + 1 ) < 10 ? '0' + ( now.getMonth ( ) + 1 ) : ( now.getMonth ( ) + 1 ), ( now.getDate ( ) < 10 ? '0' + now.getDate ( ) : now.getDate ( ) ) ].join ( '-' ) );
			return;
		},
		layerSetTitle: function ( codeType ) {
			var id = $ ( this ).prop ( 'id' );
			var titleHtml = '';
			var colGroupHtml = '';
			var colTitleHtml = '';
			for ( var i = 0; i < $.fn.codelayer.options [ codeType ].colTitles.length; i++ ) {
				if ( ( $.fn.codelayer.options [ codeType ].colTitles.length - 1 ) == i ) {
					if ( $.fn.codelayer.options [ codeType ].colWidths [ i ] ) {
						colGroupHtml += '<col width="' + ( $.fn.codelayer.options [ codeType ].colWidths [ i ] || ( $.fn.codelayer.options [ codeType ].width / $.fn.codelayer.options [ codeType ].colTitles.length ) ) + '"/>';
					} else {
						colGroupHtml += '<col width=""/>';
					}
				} else {
					colGroupHtml += '<col width="' + ( $.fn.codelayer.options [ codeType ].colWidths [ i ] || ( $.fn.codelayer.options [ codeType ].width / $.fn.codelayer.options [ codeType ].colTitles.length ) ) + '"/>';
				}
				colTitleHtml += '<th>' + ( $.fn.codelayer.options [ codeType ].colTitles [ i ] || '' ) + '</th>';
			}

			if ( $.fn.codelayer.options [ codeType ].searchType === 'B' ) {
				titleHtml += '<div class="sub mt10" style="width:768px;">';
			} else {
				titleHtml += '<div class="sub mt10">';
			}
			titleHtml += '		<div class="com_ta2 mr17 ovh taHeader">';
			titleHtml += '			<table>';
			titleHtml += '				<colgroup>' + colGroupHtml + '</colgroup>';
			titleHtml += '				<tr>' + colTitleHtml + '</tr>';
			titleHtml += '			</table>';
			titleHtml += '		</div>';
			titleHtml += '		<div class="com_ta2 ova_sc2 cursor_p bg_lightgray taBody" id="bindList" style="height:290px">';
			titleHtml += '			<table>';
			titleHtml += '				<colgroup>' + colGroupHtml + '</colgroup>';
			titleHtml += '			</table>';
			titleHtml += '		</div>';
			titleHtml += '</div>';
			$ ( '#' + id ).find ( '.pop_con' ).append ( titleHtml );

			$ ( '.taBody' ).scroll ( function ( ) {
				$ ( this ).parent ( ).find ( '.taHeader' ).scrollLeft ( $ ( this ).scrollLeft ( ) );
			} );
			return;
		},
		layerSetBindList: function ( codeType ) {
			var id = $ ( this ).prop ( 'id' );
			var listHtml = '';
			$.fn.codelayer.options [ codeType ].bindMaxSeq = 0;
			var source = ( $.fn.codelayer.options [ codeType ].searchSource.length > 0 ? $.fn.codelayer.options [ codeType ].searchSource : $.fn.codelayer.options [ codeType ].source );
			var max = ( source.length < ( $.fn.codelayer.options [ codeType ].bindMaxSeq + 10 ) ? source.length : ( $.fn.codelayer.options [ codeType ].bindMaxSeq + 10 ) );

			$ ( '#' + id ).find ( '#bindList table' ).contents ( ).not ( 'colgroup' ).unbind ( ).remove ( );
			source.forEach ( function ( item, idx ) {
				if ( idx >= $.fn.codelayer.options [ codeType ].bindMaxSeq ) {
					if ( idx < ( $.fn.codelayer.options [ codeType ].bindMaxSeq + max ) ) {
						var tr = document.createElement ( 'tr' );
						$ ( tr ).data ( 'bindData', item );
						for ( var i = 0; i < $.fn.codelayer.options [ codeType ].colTitles.length; i++ ) {
							var td = document.createElement ( 'td' );
							$ ( td ).addClass ( ( $.fn.codelayer.options [ codeType ].colAlignments [ i ] || '' ) );
							$ ( td ).attr ( 'width', $.fn.codelayer.options [ codeType ].colWidths [ i ] );
							$ ( td ).append ( ( item [ $.fn.codelayer.options [ codeType ].colKeys [ i ] ] || '' ) );
							$ ( tr ).append ( $ ( td ) );
						}

						$ ( tr ).click ( function ( ) {
							$.fn.codelayer.options [ codeType ].selectFocus = ( $ ( this ).index ( ) + 1 );
							$ ( '#' + id ).codelayer ( 'layerRowFocus', codeType );
						} );
						$ ( tr ).dblclick ( function ( ) {
							$ ( '#' + id ).codelayer ( 'layerCommit', codeType );
						} );
						$ ( '#' + id ).find ( '#bindList table' ).append ( tr );
					}
				}
			} );

			$.fn.codelayer.options [ codeType ].bindMaxSeq = max;

			$ ( '#' + id ).find ( '#bindList table' ).append ( listHtml );
			if ( $ ( '#' + id ).find ( '#bindList table tr.on' ).length === 0 ) {
				if ( $ ( '#' + id ).find ( '#bindList table tr' ).length > 0 ) {
					$.fn.codelayer.options [ codeType ].selectFocus = 1;
				}
			}

			/* set row focus */
			$ ( '#' + id ).codelayer ( 'layerRowFocus', codeType );
		},
		layerAddBindList: function ( codeType ) {
			var id = $ ( this ).prop ( 'id' );
			var listHtml = '';
			var source = ( $.fn.codelayer.options [ codeType ].searchSource.length > 0 ? $.fn.codelayer.options [ codeType ].searchSource : $.fn.codelayer.options [ codeType ].source );
			var max = ( source.length < ( $.fn.codelayer.options [ codeType ].bindMaxSeq + 10 ) ? source.length : ( $.fn.codelayer.options [ codeType ].bindMaxSeq + 10 ) );
			source.forEach ( function ( item, idx ) {
				if ( idx >= $.fn.codelayer.options [ codeType ].bindMaxSeq ) {
					if ( idx < ( $.fn.codelayer.options [ codeType ].bindMaxSeq + max ) ) {
						var tr = document.createElement ( 'tr' );
						$ ( tr ).data ( 'bindData', item );
						for ( var i = 0; i < $.fn.codelayer.options [ codeType ].colTitles.length; i++ ) {
							var td = document.createElement ( 'td' );
							$ ( td ).addClass ( ( $.fn.codelayer.options [ codeType ].colAlignments [ i ] || '' ) );
							$ ( td ).append ( ( item [ $.fn.codelayer.options [ codeType ].colKeys [ i ] ] || '' ) );
							$ ( tr ).append ( $ ( td ) );
						}
						$ ( '#' + id ).find ( '#bindList table' ).append ( tr );
					}
				}
			} );

			$.fn.codelayer.options [ codeType ].bindMaxSeq = max;
		},
		layerSetEvent: function ( codeType ) {
			var id = $ ( this ).prop ( 'id' );
			var source = ( $.fn.codelayer.options [ codeType ].searchSource.length > 0 ? $.fn.codelayer.options [ codeType ].searchSource : $.fn.codelayer.options [ codeType ].source );
			switch ( $.fn.codelayer.options [ codeType ].searchType ) {
				case 'A':
					$ ( '#btnLayerSearchTextBox' ).keydown ( function ( ) {
						if ( ( event.keyCode || event.which ) == 40 ) {
							/* bottom arrow */
							$ ( '#' + id ).codelayer ( 'bottomArrowFocus', codeType, source );
							$ ( '#' + id ).codelayer ( 'bottomArrowScroll', codeType, source );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 38 ) {
							/* top arrow */
							$ ( '#' + id ).codelayer ( 'topArrowFocus', codeType, source );
							$ ( '#' + id ).codelayer ( 'topArrowScroll', codeType, source );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 13 ) {
							if ( preKeyCode === '' ) {
								$ ( '#' + id ).codelayer ( 'layerCommit', codeType );
							} else {
								$ ( '#btnLayerSearch' ).click ( );
							}
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 9 ) {
							/* TAB */
							$ ( '#' + id ).codelayer ( 'layerCommit', codeType );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 27 ) {
							/* ESC */
							$ ( '#' + id ).codelayer ( 'layerClose', codeType );
							preKeyCode = '';
							event.preventDefault ( );
						} else {
							preKeyCode = ( event.keyCode || event.which );
						}
					} );

					$ ( '#btnLayerSearch' ).click ( function ( ) {
						if ( $ ( '#btnLayerSearchTextBox' ).val ( ) !== '' ) {
							if ( $.fn.codelayer.options [ codeType ].reSearch === 'Y' ) {
								/* 무조건 다시 조회 */
							} else {
								$.fn.codelayer.options [ codeType ].searchSource = [ ];
								$.fn.codelayer.options [ codeType ].source.forEach ( function ( item, idx ) {
									if ( JSON.stringify ( item ).toUpperCase ( ).indexOf ( $ ( '#btnLayerSearchTextBox' ).val ( ).toUpperCase ( ) ) > -1 ) {
										$.fn.codelayer.options [ codeType ].searchSource.push ( item );
									}
								} );
							}
							if ( $.fn.codelayer.options [ codeType ].searchSource.length === 0 ) {
								// $.fn.codelayer.options[codeType].searchSource.push([]);
							}
						} else {
							$.fn.codelayer.options [ codeType ].searchSource = [ ];
						}

						$ ( '#' + id ).find ( '#bindList table tr' ).unbind ( ).remove ( );
						$ ( '#' + id ).codelayer ( 'layerSetBindList', codeType );
					} );

					$ ( '#btnLayerReject' ).click ( function ( ) {
						$ ( '#' + id ).codelayer ( 'layerClose', codeType );
					} );
					$ ( '#btnLayerReSearch' ).hide ( );
					break;
				case 'B':
					/* 작성일자/발행일자 : selDateDiv */
					/* 작성일자-시작일 : txtETaxFromDate */
					/* 작성일자-종료일 : txtETaxToDate */
					/* 매입거래처 : txtPartnerName */
					/* 세금계산서분류 : selETaxDiv */

					$ ( '#selDateDiv, #txtETaxFromDate, #txtETaxToDate, #txtPartnerName, #selETaxDiv' ).keydown ( function ( ) {
						if ( ( event.keyCode || event.which ) == 40 ) {
							/* bottom arrow */
							$ ( '#' + id ).codelayer ( 'bottomArrowFocus', codeType, $.fn.codelayer.options [ codeType ].source );
							$ ( '#' + id ).codelayer ( 'bottomArrowScroll', codeType, $.fn.codelayer.options [ codeType ].source );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 38 ) {
							/* top arrow */
							$ ( '#' + id ).codelayer ( 'topArrowFocus', codeType, $.fn.codelayer.options [ codeType ].source );
							$ ( '#' + id ).codelayer ( 'topArrowScroll', codeType, $.fn.codelayer.options [ codeType ].source );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 13 ) {
							/* ENTER */
							if ( preKeyCode === '' ) {
								$ ( '#' + id ).codelayer ( 'layerCommit', codeType );
							} else {
								$ ( '#btnLayerSearch' ).click ( );
							}
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 9 ) {
							/* TAB */
							$ ( '#' + id ).codelayer ( 'layerCommit', codeType );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 27 ) {
							/* ESC */
							$ ( '#' + id ).codelayer ( 'layerClose', codeType );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 123 ) {
							/* F12 */
							$ ( '#btnLayerReSearch' ).click ( );
							preKeyCode = '';
							event.preventDefault ( );
						} else {
							preKeyCode = ( event.keyCode || event.which );
						}
					} );

					$ ( '#btnLayerReSearch' ).show ( );
					$ ( '#btnLayerReSearch' ).click ( function ( ) {
						if ( $.fn.codelayer.options [ codeType ].reSearch === 'Y' || codeType == 'anguCard' ) {
							$.fn.codelayer.options [ codeType ].source = [ ];
							$.fn.codelayer.options [ codeType ].searchSource = [ ];

							$.ajax ( {
								url: $.fn.codelayer.options [ codeType ].url + '?' + ( ( $.fn.codelayer.options [ codeType ].getParam ) ? $.fn.codelayer.options [ codeType ].getParam ( ) : '' ),
								success: function ( result ) {
									if ( result.result.resultCode === 'SUCCESS' ) {
										if ( result.result.aaData ) {
											if ( $.fn.codelayer.options [ codeType ].codeType === 'car' ) {
												result.result.aaData.forEach ( function ( item, idx ) {
													item.carDispName = item.carCode + '. ' + item.carNumber + ' (' + item.carName + ')';
												} );
											}
											$.fn.codelayer.options [ codeType ].source = result.result.aaData;
										} else {
											$.fn.codelayer.options [ codeType ].source = [ ];
										}
									} else {
										$.error ( result.result.resultCode );
										alert ( '데이터 조회 중 확인되지 않은 문제점이 발생되었습니다.\r\n지속적으로 발생될 경우 관리자에게 문의해 주세요.' )
									}

									/* bind list */
									$ ( '#' + id ).codelayer ( 'layerSetBindList', codeType );
									/* layer focus */
									$ ( '#' + id ).codelayer ( 'layerFocus', codeType );
								}
							} );
						}
					} );
					break;
				case 'C':
					$ ( '#txtETaxFromDate, #txtETaxToDate, #selETaxDiv' ).keydown ( function ( ) {
						if ( ( event.keyCode || event.which ) == 40 ) {
							/* bottom arrow */
							$ ( '#' + id ).codelayer ( 'bottomArrowFocus', codeType, $.fn.codelayer.options [ codeType ].source );
							$ ( '#' + id ).codelayer ( 'bottomArrowScroll', codeType, $.fn.codelayer.options [ codeType ].source );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 38 ) {
							/* top arrow */
							$ ( '#' + id ).codelayer ( 'topArrowFocus', codeType, $.fn.codelayer.options [ codeType ].source );
							$ ( '#' + id ).codelayer ( 'topArrowScroll', codeType, $.fn.codelayer.options [ codeType ].source );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 13 ) {
							/* ENTER */
							if ( preKeyCode === '' ) {
								$ ( '#' + id ).codelayer ( 'layerCommit', codeType );
							} else {
								$ ( '#btnLayerSearch' ).click ( );
							}
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 9 ) {
							/* TAB */
							$ ( '#' + id ).codelayer ( 'layerCommit', codeType );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 27 ) {
							/* ESC */
							$ ( '#' + id ).codelayer ( 'layerClose', codeType );
							preKeyCode = '';
							event.preventDefault ( );
						} else if ( ( event.keyCode || event.which ) == 123 ) {
							/* F12 */
							$ ( '#btnLayerReSearch' ).click ( );
							preKeyCode = '';
							event.preventDefault ( );
						} else {
							preKeyCode = ( event.keyCode || event.which );
						}
					} );
					
					$ ( '#btnLayerReSearch' ).show ( );
					$ ( '#btnLayerReSearch' ).click ( function ( ) {
						$.fn.codelayer.options [ codeType ].source = [ ];
						$.fn.codelayer.options [ codeType ].searchSource = [ ];

						$.ajax ( {
							url: $.fn.codelayer.options [ codeType ].url + '?' + ( ( $.fn.codelayer.options [ codeType ].getParam ) ? $.fn.codelayer.options [ codeType ].getParam ( ) : '' ),
							success: function ( result ) {
								if ( result.result.resultCode === 'SUCCESS' ) {
									if ( result.result.aaData ) {
										if ( $.fn.codelayer.options [ codeType ].codeType === 'car' ) {
											result.result.aaData.forEach ( function ( item, idx ) {
												item.carDispName = item.carCode + '. ' + item.carNumber + ' (' + item.carName + ')';
											} );
										}
										$.fn.codelayer.options [ codeType ].source = result.result.aaData;
									} else {
										$.fn.codelayer.options [ codeType ].source = [ ];
									}
								} else {
									$.error ( result.result.resultCode );
									alert ( '데이터 조회 중 확인되지 않은 문제점이 발생되었습니다.\r\n지속적으로 발생될 경우 관리자에게 문의해 주세요.' )
								}

								/* bind list */
								$ ( '#' + id ).codelayer ( 'layerSetBindList', codeType );
								/* layer focus */
								$ ( '#' + id ).codelayer ( 'layerFocus', codeType );
							}
						} );
					} );
					break;
			}
			
			/*
			$ ( '#' + id ).scroll(function(){
				if(( ( $('#bindList').height() + $('#bindList').scrollTop() ) % $('#bindList')[0].scrollHeight ) < 30){
					$ ( '#' + id ).codelayer ( 'bottomArrowScroll', codeType, source );
				}
			});
			*/
			// $ ( '#' + id ).codelayer ( 'bottomArrowScroll', codeType, source );
		},
		layerRowFocus: function ( codeType ) {
			var id = $ ( this ).prop ( 'id' );
			$ ( '#' + id ).find ( '.pop_con table tr.on' ).removeClass ( 'on' );
			if ( $.fn.codelayer.options [ codeType ].selectFocus > $.fn.codelayer.options [ codeType ].bindMaxSeq ) {
				$ ( '#' + id ).codelayer ( 'layerAddBindList', codeType );
			}
			$ ( '#' + id ).find ( '.pop_con table tr:eq(' + $.fn.codelayer.options [ codeType ].selectFocus + ')' ).addClass ( 'on' );
		},
		layerFocus: function ( codeType ) {
			switch ( $.fn.codelayer.options [ codeType ].searchType ) {
				case 'A':
					$ ( '#btnLayerSearchTextBox' ).focus ( ).select ( );
					break;
				case 'B':
					$ ( '#txtETaxFromDate' ).focus ( ).select ( );
					break;
				case 'C':
					$ ( '#txtETaxFromDate' ).focus ( ).select ( );
					break;
			}
		},
		layerCommit: function ( codeType ) {
			var id = $ ( this ).prop ( 'id' );
			var bindData = $ ( '#' + id ).find ( '#bindList table tr.on' ).data ( 'bindData' );

			if ( codeType === 'anguPartnerAuth' ) {
				/* 거래처인 경우 별도 정보를 필요로 하므로 중간에서 추가정보를 조회한다. */
				$.ajax ( {
					url: '/exp/expend/angu/getAnguPartnerInfoI_Select_02.do?TR_CD=' + bindData.TR_CD + '&JIRO_CD=' + bindData.JIRO_CD + '&TR_FG=' + bindData.TR_FG,
					async: false,
					success: function ( result ) {
						bindData = $.extend ( bindData, result.result.aData );
						$ ( '#' + $.fn.codelayer.options [ codeType ].id ).dtable ( 'colSetValues', bindData );
						$ ( '#' + id ).codelayer ( 'layerClose', codeType );
					}
				} );
			} else {
				$ ( '#' + $.fn.codelayer.options [ codeType ].id ).dtable ( 'colSetValues', bindData );
				$ ( '#' + id ).codelayer ( 'layerClose', codeType );
			}
		},
		layerClose: function ( codeType ) {
			$ ( '.modal' ).remove ( );
			$ ( '.pop_wrap_dir' ).contents ( ).unbind ( ).remove ( );
			/* TODO: z-index 처리 */
			$ ( '.pop_wrap_dir' ).css ( 'width', 0 );
			$ ( '.pop_wrap_dir' ).css ( 'heigh', 0 );
			$ ( '#' + $.fn.codelayer.options [ codeType ].id ).dtable ( 'setCellMod' );
		},
		bottomArrowFocus: function ( codeType, source ) {
			$.fn.codelayer.options [ codeType ].selectFocus = ( $.fn.codelayer.options [ codeType ].selectFocus + 1 );
			if ( $.fn.codelayer.options [ codeType ].selectFocus > source.length ) {
				$.fn.codelayer.options [ codeType ].selectFocus = source.length;
			}
		},
		bottomArrowScroll: function ( codeType, source ) {
			var id = $ ( this ).prop ( 'id' );
			$ ( '#' + id ).codelayer ( 'layerRowFocus', codeType );
			if ( ( $ ( '#bindList' ).scrollTop ( ) + $ ( '#bindList' ).height ( ) - $ ( '#bindList table tr:eq(0)' ).height ( ) ) < ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top ) ) {
				$ ( '#bindList' ).scrollTop ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top );
			}
		},
		topArrowFocus: function ( codeType, source ) {
			$.fn.codelayer.options [ codeType ].selectFocus = ( $.fn.codelayer.options [ codeType ].selectFocus - 1 );
			if ( $.fn.codelayer.options [ codeType ].selectFocus < 1 ) {
				$.fn.codelayer.options [ codeType ].selectFocus = 1;
			}
		},
		topArrowScroll: function ( codeType, source ) {
			var id = $ ( this ).prop ( 'id' );
			$ ( '#' + id ).codelayer ( 'layerRowFocus', codeType );
			if ( ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top ) > $ ( '#bindList' ).height ( ) ) {
				if ( $ ( '#bindList' ).scrollTop ( ) > ( ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top ) % $ ( '#bindList' ).height ( ) ) ) {
					$ ( '#bindList' ).scrollTop ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top );
				}
			} else {
				if ( ( $ ( '#bindList' ).scrollTop ( ) % $ ( '#bindList' ).height ( ) ) < ( ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top ) % $ ( '#bindList' ).height ( ) ) ) {
					$ ( '#bindList' ).scrollTop ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top );
				} else if ( ( $ ( '#bindList' ).scrollTop ( ) % $ ( '#bindList' ).height ( ) ) > ( ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top ) % $ ( '#bindList' ).height ( ) ) ) {
					$ ( '#bindList' ).scrollTop ( $ ( '#bindList tr:eq(' + ( $.fn.codelayer.options [ codeType ].selectFocus - 1 ) + ')' ).offset ( ).top - $ ( '#bindList tr:eq(0)' ).offset ( ).top );
				}
			}
		},
	};

	$.fn.codelayer = function ( method ) {
		if ( typeof method === 'object' || !method ) {
			return methods.init.apply ( this, arguments );
		} else if ( methods [ method ] ) {
			return methods [ method ].apply ( this, Array.prototype.slice.call ( arguments, 1 ) );
		} else {
			$.error ( 'Method ' + method + ' does not exist on method..' );
		}
	};
} ) ( jQuery );
