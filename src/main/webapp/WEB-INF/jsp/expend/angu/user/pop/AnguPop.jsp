<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="main.web.BizboxAMessage"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<link rel="stylesheet" type="text/css" href='<c:url value="/js/jqueryui/jquery-ui.css"></c:url>'>

<script type="text/javascript" src='${pageContext.request.contextPath}/js/common/jquery.dtable.js?varsion=<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMddHHmmss"/>'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/common/jquery.codelayer.js?varsion=<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMddHHmmss"/>'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js?varsion=<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMddHHmmss"/>'></script>

<script type="text/javascript">
	/* {anbojoSeq=1266, anbojoStatCode=, docSeq=0, writeSeq=0, compSeq=EXP_iCUBE, BOJO_RMK=보조금통장표, TR_RMK=거래처통장표, erpCompToDate=20171231, erpBizName=비영리재단본사, erpSendYN=N, diKeyCode=0, formId=10102, erpDeptSeq=1000, erpSendSeq=, form_id=10102, erpCompFrDate=20170101, gisuDate=20171011, erpDeptName=운영부서, formSeq=10102, erpSectName=부문, erpCompSeq=3585, erpBizSeq=1000, erpEmpSeq=2000, erpSectSeq=1000, CO_CD=3585, jsonStr=, erpEmpName=운영팀, erpCompGisu=2, erpCompName=비영리재단, template_key=10102} */
	/* ## [+] [ 테이블 변수 ] ## */
	/* e나라도움 집행등록 */
	var anguInputInfo = {
		resolve: [ ],
		auth: [ ],
		bimok: [ ],
		jaewon: [ ]
	};
	var gisuInfo = {
		erpCompFrDate: '${ViewBag.aData.erpCompFrDate}',
		erpCompToDate: '${ViewBag.aData.erpCompToDate}',
		erpCompGisu: '${ViewBag.aData.erpCompGisu}'
	};
	var seqInfo = {
		resolve: {
			selectSeq: 0,
			maxSeq: 0
		},
		auth: {
			selectSeq: 0,
			maxSeq: 0
		},
		bimok: {
			selectSeq: 0,
			maxSeq: 0
		},
		jaewon: {
			selectSeq: 0,
			maxSeq: 0
		}
	};
	/* 결의내역 : resolveContent */
	var resolveTable = {
		layout: [ 'lht', 'lct', 'rht', 'rct', 'mr' ],
		colHeaders: [ '[checkbox_all]', '일', '사업연도', '지급구분', '지급구분코드', '국고보조사업', '국고보조사업코드', '이체계좌구분', '이체계좌구분코드', '자계좌이체사유코드', '자계좌이체사유코드코드', '자계좌이체사유', '증빙구분', '증빙구분코드', '증빙승인번호', '증빙일자', '집행용도', '결의내역순번', '과세구분코드' ],
		colKeys: [ '', 'anguDay', 'anguYear', 'anguPayDivName', 'anguPayDivCode', 'anguBusinessName', 'anguBusinessCode', 'anguAccountDivName', 'anguAccountDivCode', 'anguAccountReasonDivName', 'anguAccountReasonDivCode', 'anguAccountReason', 'anguAuthDivName', 'anguAuthDivCode', 'anguEtaxTaxNum', 'anguEtaxTaxIssueDate', 'anguNote', 'dSeq', 'TAX_TY' ],
		colReq: [ 'N', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', 'N', 'N', 'Y', 'Y', 'N', 'Y', 'Y', 'N', 'N' ],
		colLeftFixed: 1,
		colWidth: [ 34, 60, 100, 90, 0, 220, 0, 120, 0, 200, 0, 200, 120, 0, 220, 120, 200, 0, 0 ],
		colAlignments: [ 'cen', 'cen', 'cen', 'cen', 'cen', 'le', 'cen', 'cen', 'cen', 'cen', 'cen', 'le', 'cen', 'cen', 'cen', 'cen', 'le', 'cen', 'cen' ],
		callback: {
			rowAdd: function ( rowIndex, rowData ) {
				$ ( '#resolveContent' ).dtable ( 'colSetValue', rowIndex, 17, ++seqInfo.resolve.maxSeq, false );
				var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', rowIndex );
				if ( resolveInfo.anguPayDivCode === '1' ) {
					/* 일반 */
					$ ( '#authContent' ).dtable ( authTable.typeB );
					$ ( '#authContent' ).dtable ( 'rowSetAddData', [ '0', '0', '0', '0', '0', '법인거래', '001', '', '', '', '', '', '${ViewBag.aData.BOJO_RMK}', '${ViewBag.aData.TR_RMK}' ] );
				} else if ( resolveInfo.anguPayDivCode === '2' ) {
					/* 인건비성 */
					$ ( '#authContent' ).dtable ( authTable.typeA );
					$ ( '#authContent' ).dtable ( 'rowSetAddData', [ '법인거래', '001', '', '', '', '', '', '${ViewBag.aData.BOJO_RMK}', '${ViewBag.aData.TR_RMK}' ] );
				} else {
					$ ( '#authContent' ).dtable ( authTable.typeB );
					$ ( '#authContent' ).dtable ( 'rowSetAddData', [ '0', '0', '0', '0', '0', '법인거래', '001', '', '', '', '', '', '${ViewBag.aData.BOJO_RMK}', '${ViewBag.aData.TR_RMK}' ] );
				}

				$ ( '#bimokContent' ).dtable ( bimokTable ); /* 비목내역 테이블 초기화 */
				$ ( '#jaewonContent' ).dtable ( jaewonTable ); /* 재원내역 테이블 초기화 */

				$ ( '#resolveContent' ).dtable ( 'colSetMove', 0 );
			},
			rowRemove: function ( rowIndex, rowData ) {
			},
			rowClick: function ( rowIndex, rowData ) {
				fnSetAuthTable ( );
				$ ( '#resolveContent' ).dtable ( 'colSetMove', 0 );

				//var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', rowIndex );

				///* 증빙내역 초기화 (이벤트가 꼬였다...먼저 데이터를 복사 후 다시 바인딩 한다.) */
				//var authInfo = {};
				//for ( var i = anguInputInfo.auth.length; i > 0; i// ) {
				//	if ( anguInputInfo.auth [ i - 1 ].dSeq === resolveInfo.dSeq ) {
				//		authInfo = anguInputInfo.auth [ i - 1 ];
				//		break;
				//	}
				//}
				//if ( resolveInfo.anguPayDivCode === '1' ) {
				//	$ ( '#authContent' ).dtable ( authTable.typeB );
				//} else if ( resolveInfo.anguPayDivCode === '2' ) {
				//	$ ( '#authContent' ).dtable ( authTable.typeA );
				//} else {
				//	$ ( '#authContent' ).dtable ( authTable.typeB );
				//}
				//$ ( '#authContent' ).dtable ( 'rowSetAddData', [ ] );
				//$ ( '#authContent' ).dtable ( 'colSetValues', authInfo, false );

				//for ( var i = anguInputInfo.auth.length; i > 0; i// ) {
				//	if ( !anguInputInfo.auth [ i - 1 ] ) {
				//		anguInputInfo.auth.splice ( ( i - 1 ), 1 );
				//	} else if ( anguInputInfo.auth [ i - 1 ].dSeq === '' ) {
				//		anguInputInfo.auth.splice ( ( i - 1 ), 1 );
				//	} else if ( anguInputInfo.auth [ i - 1 ].dSeq === undefined ) {
				//		anguInputInfo.auth.splice ( ( i - 1 ), 1 );
				//	}
				//}

				// $ ( '#resolveContent' ).dtable ( 'colSetMove', 0 );
			}
		},
		columns: [ {
			/*  */
			type: 'checkbox'
		}, {
			/*  */
			type: 'text'
		}, {
			/*  */
			type: 'text'
		}, {
			/*  */
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguPayDiv',
						id: 'resolveContent'
					} );
				},
				closeEditor: function ( value ) {
					if ( value.anguPayDivCode === '1' ) {
						/* 일반 */
						$ ( '#authContent' ).dtable ( authTable.typeB );
						$ ( '#authContent' ).dtable ( 'rowSetAddData', [ '0', '0', '0', '0', '0', '법인거래', '001', '', '', '', '', '', '${ViewBag.aData.BOJO_RMK}', '${ViewBag.aData.TR_RMK}' ] );
					} else if ( value.anguPayDivCode === '2' ) {
						/* 인건비성 */
						$ ( '#authContent' ).dtable ( authTable.typeA );
						$ ( '#authContent' ).dtable ( 'rowSetAddData', [ '법인거래', '001', '', '', '', '', '', '${ViewBag.aData.BOJO_RMK}', '${ViewBag.aData.TR_RMK}' ] );
					}
				}
			}
		}, {
			/*  */
			type: 'hidden'
		}, {
			/*  */
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguBusiness',
						id: 'resolveContent'
					} );
				},
				closeEditor: function ( value ) {
				}
			}
		}, {
			/*  */
			type: 'hidden'
		}, {
			/*  */
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguAccountDiv',
						id: 'resolveContent'
					} );
				},
				closeEditor: function ( value ) {
					if ( value.anguAccountDivCode === '001' ) {
						$.fn.dtable.options [ 'resolveContent' ].columns [ 9 ].type = 'readonly';
						$.fn.dtable.options [ 'resolveContent' ].columns [ 11 ].type = 'readonly';
						$.fn.dtable.options [ 'resolveContent' ].colReq [ 9 ] = 'N';
						$.fn.dtable.options [ 'resolveContent' ].colReq [ 10 ] = 'N';
						$.fn.dtable.options [ 'resolveContent' ].columns [ 9 ].editor = {};
						$.fn.dtable.options [ 'resolveContent' ].columns [ 9 ].editor = {
							openEditor: function ( ) {
								return;
							},
							closeEditor: function ( value ) {
							}
						};
					} else if ( value.anguAccountDivCode === '002' ) {
						$.fn.dtable.options [ 'resolveContent' ].columns [ 9 ].type = 'text';
						$.fn.dtable.options [ 'resolveContent' ].columns [ 11 ].type = 'text';
						$.fn.dtable.options [ 'resolveContent' ].colReq [ 9 ] = 'Y';
						$.fn.dtable.options [ 'resolveContent' ].colReq [ 10 ] = 'Y';
						$.fn.dtable.options [ 'resolveContent' ].columns [ 9 ].editor = {
							openEditor: function ( ) {
								$ ( '#divCodeLayer' ).codelayer ( {
									codeType: 'anguAccountReasonDiv',
									id: 'resolveContent'
								} );
							},
							closeEditor: function ( value ) {
							}
						};
					}
				}
			}
		}, {
			/*  */
			type: 'hidden'
		}, {
			/*  */
			type: 'text',
			editor: {
			/* 이체계좌구분에 따라 동적 처리 */
			}
		}, {
			/*  */
			type: 'hidden'
		}, {
			/*  */
			type: 'text'
		}, {
			/*  */
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguAuthDiv',
						id: 'resolveContent'
					} );
				},
				closeEditor: function ( value ) {
					switch ( value.anguAuthDivCode ) {
						case '001': /* 전자세금계산서 */
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].type = 'codeonly';
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].editor = {
								openEditor: function ( ) {
									$ ( '#divCodeLayer' ).codelayer ( {
										codeType: 'anguEtaxTax',
										id: 'resolveContent'
									} );
								},
								closeEditor: function ( value ) {
									value.anguEtaxTaxPartnerNum = value.anguEtaxTaxPartnerNum.toString ( ).replace ( /(\d{3})(\d{2})(\d{5})/, '$1-$2-$3' );
									$ ( '#authContent' ).dtable ( 'colSetValues', value, false );
								}
							};
							break;
						case '002': /* 전자계산서 */
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].type = 'codeonly';
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].editor = {
								openEditor: function ( ) {
									$ ( '#divCodeLayer' ).codelayer ( {
										codeType: 'anguEtaxTaxFree',
										id: 'resolveContent'
									} );
								},
								closeEditor: function ( value ) {
									value.anguEtaxTaxPartnerNum = value.anguEtaxTaxPartnerNum.toString ( ).replace ( /(\d{3})(\d{2})(\d{5})/, '$1-$2-$3' );
									$ ( '#authContent' ).dtable ( 'colSetValues', value, false );
								}
							};
							break;
						case '004': /* 카드 */
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].type = 'codeonly';
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].editor = {
								openEditor: function ( ) {
									$ ( '#divCodeLayer' ).codelayer ( {
										codeType: 'anguCard',
										id: 'resolveContent'
									} );
								},
								closeEditor: function ( value ) {
									value.anguEtaxTaxPartnerNum = value.anguEtaxTaxPartnerNum.toString ( ).replace ( /(\d{3})(\d{2})(\d{5})/, '$1-$2-$3' );
									$ ( '#authContent' ).dtable ( 'colSetValues', value, false );
								}
							};
							break;
						case '999': /* 기타 */
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].type = 'readonly';
							$.fn.dtable.options [ 'resolveContent' ].columns [ 14 ].editor = {
								openEditor: function ( ) {
								},
								closeEditor: function ( value ) {
								}
							}
							break;
					}
				}
			}
		}, {
			type: 'hidden'
		}, {
			type: 'text',
			editor: {}
		}, {
			type: 'date'
		}, {
			type: 'text',
			editor: {
				moveFocus: function ( ) {
					$ ( '#authContent' ).dtable ( 'colSetMove', 1 );
				}
			}
		}, {
			type: 'hidden'
		}, {
			/* 과세구분코드 */
			type: 'hidden'
		} ],
		data: [ ],
		bindData: function ( ) {
			anguInputInfo.resolve = [ ];
			for ( var i = 0; i < $.fn.dtable.options [ 'resolveContent' ].rowSize; i++ ) {
				var tempData = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', i );
				tempData.anbojoSeq = '${ViewBag.aData.anbojoSeq}';
				anguInputInfo.resolve [ i ] = tempData;
			}
		}
	// data: [ [ '', '21', '2017', '인건비성', '2', '한국문화예술교육진흥원 운영지원', '20170209000000000010', '보조금계좌로이체', '002', '인건비(원천징수 후 개별지급)', '002', '[직접입력]', '전자세금계산서', '1', '201702011000000028135141', '2017-01-01', '[직접입력]' ] ]
	};
	/* 증빙내역 : authContent */
	var authTable = {
		/* 인건비성 */
		typeA: {
			layout: [ 'rht', 'rct' ],
			colHeaders: [ '거래처구분', '거래처구분코드', '코드', '거래처명', '금융기관', '금융기관코드', '입금계좌번호', '보조금통장표시내용', '거래처통장표시내용', '거래처 사업자/주민번호', '사업장주소', '대표자명', '전화번호', '결의내역순번', '금융기관코드-더존' ],
			colKeys: [ 'anguPartnerDivName', 'anguPartnerDivCode', 'TR_CD', 'anguEtaxTaxPartnerName', 'BANK_NM', 'BCNC_BANK_CODE', 'BCNC_ACNUT_NO', 'BOJO_RMK', 'TR_RMK', 'anguEtaxTaxPartnerNum', 'BCNC_ADRES', 'BCNC_RPRSNTY_NM', 'BCNC_TELNO', 'dSeq', 'DUZON_BANK_CODE' ],
			colReq: [ 'Y', 'Y', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', 'N', 'N' ],
			colLeftFixed: 0,
			colWidth: [ 100, 100, 100, 200, 100, 100, 200, 200, 200, 200, 200, 200, 200, 0, 0 ],
			colAlignments: [ 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen' ],
			callback: {
				rowAdd: function ( rowIndex, rowData ) {
					var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
					$ ( '#authContent' ).dtable ( 'colSetValue', rowIndex, 13, resolveInfo.dSeq, false );
				},
				rowRemove: function ( rowIndex, rowData ) {
				},
				rowClick: function ( rowIndex, rowData ) {
				}
			},
			columns: [ {
				type: 'text',
				editor: {
					openEditor: function ( ) {
						$ ( '#divCodeLayer' ).codelayer ( {
							codeType: 'anguPartnerDiv',
							id: 'authContent'
						} );
					},
					closeEditor: function ( value ) {
					}
				}
			}, {
				type: 'hidden'
			}, {
				type: 'text',
				editor: {
					openEditor: function ( ) {
						$ ( '#divCodeLayer' ).codelayer ( {
							codeType: 'anguPartnerAuth',
							id: 'authContent'
						} );
					},
					closeEditor: function ( value ) {
					}
				}
			}, {
				type: 'text'
			}, {
				/* 금융기관 */
				type: 'text',
				editor: {
					openEditor: function ( ) {
						$ ( '#divCodeLayer' ).codelayer ( {
							codeType: 'anguG20Bank',
							id: 'authContent'
						} );
					},
					closeEditor: function ( value ) {
						// $ ( '#authContent' ).dtable ( 'colSetValues', value, false );
						var param = {};
						param.BANK_CD = value.DUZON_BANK_CODE;
						$.ajax ( {
							url: '/exp/expend/angu/getAnguG20BankInfoI_Select_02.do',
							type: "post",
							async: true,
							datatype: "json",
							data: param,
							success: function ( result ) {
								$ ( '#authContent' ).dtable ( 'colSetValues', result.result.aData, false );
							}
						} );
					}
				}
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text',
				editor: {
					moveFocus: function ( ) {
						if($('#bimokContent_rct tr').length === 0){
							if(confirm('비목내역을 추가하시겠습니까?')){
								$('#btnAddBimokRow').click();
							}
						}
					}
				}
			}, {
				type: 'hidden'
			}, {
				type: 'hidden'
			} ],
			data: [ ], //[ [ '법인거래', '001', '', '', '', '', '', '${ViewBag.aData.BOJO_RMK}', '${ViewBag.aData.TR_RMK}' ] ],
			bindData: function ( ) {
				var anguInputInfoResolve = {};
				anguInputInfoResolve = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );

				for ( var i = anguInputInfo.auth.length; i > 0; i-- ) {
					if ( anguInputInfo.auth [ i - 1 ] ) {
						if ( anguInputInfo.auth [ i - 1 ].anbojoSeq === '${ViewBag.aData.anbojoSeq}' ) {
							if ( anguInputInfo.auth [ i - 1 ].dSeq === anguInputInfoResolve.dSeq ) {
								anguInputInfo.auth.splice ( ( i - 1 ), 1 );
							} else if ( anguInputInfo.auth [ i - 1 ].dSeq === '' ) {
								anguInputInfo.auth.splice ( ( i - 1 ), 1 );
							} else if ( anguInputInfo.auth [ i - 1 ].dSeq === undefined ) {
								anguInputInfo.auth.splice ( ( i - 1 ), 1 );
							}
						}
					} else {
						anguInputInfo.auth.splice ( ( i - 1 ), 1 );
					}
				}

				var tempData = $ ( '#authContent' ).dtable ( 'rowGetJsonData', i );
				tempData.anbojoSeq = '${ViewBag.aData.anbojoSeq}';
				tempData.dSeq = anguInputInfoResolve.dSeq;
				anguInputInfo.auth.push ( tempData );
			}
		/* data: [ [ '법인거래', '001', '10000', '엔프롬정보기술㈜', '한국', '010', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]' ] ] */
		},
		/* 일반 */
		typeB: {
			layout: [ 'rht', 'rct' ],
			colHeaders: [ '증빙총액', '증빙공급가', '증빙부가세', '등록가능공급가', '등록가능부가세', '거래처구분', '거래처구분코드', '코드', '거래처명', '금융기관', '금융기관코드', '입금계좌번호', '보조금통장표시내용', '거래처통장표시내용', '거래처 사업자/주민번호', '사업장주소', '대표자명', '전화번호', '결의내역순번', '금융기관코드-더존' ],
			colKeys: [ 'anguEtaxTaxReqAmt', 'anguEtaxTaxAmt', 'anguEtaxTaxVat', 'SUP_M_SPLPC', 'VAT_M_VAT', 'anguPartnerDivName', 'anguPartnerDivCode', 'TR_CD', 'anguEtaxTaxPartnerName', 'BANK_NM', 'BCNC_BANK_CODE', 'BCNC_ACNUT_NO', 'BOJO_RMK', 'TR_RMK', 'anguEtaxTaxPartnerNum', 'BCNC_ADRES', 'BCNC_RPRSNTY_NM', 'BCNC_TELNO', 'dSeq', 'DUZON_BANK_CODE' ],
			colReq: [ 'N', 'N', 'N', 'N', 'N', 'Y', 'Y', 'N', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', 'N', 'N' ],
			colLeftFixed: 0,
			colWidth: [ 150, 150, 150, 150, 150, 100, 100, 100, 200, 100, 100, 200, 200, 200, 200, 200, 200, 200, 0, 0 ],
			colAlignments: [ 'ri', 'ri', 'ri', 'ri', 'ri', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen', 'cen' ],
			callback: {
				rowAdd: function ( rowIndex, rowData ) {
					var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
					$ ( '#authContent' ).dtable ( 'colSetValue', rowIndex, 18, resolveInfo.dSeq, false );
				},
				rowRemove: function ( rowIndex, rowData ) {
				},
				rowClick: function ( rowIndex, rowData ) {
				}
			},
			columns: [ {
				type: 'readonly'
			}, {
				type: 'readonly'
			}, {
				type: 'readonly'
			}, {
				type: 'readonly'
			}, {
				type: 'readonly'
			}, {
				type: 'text',
				editor: {
					openEditor: function ( ) {
						$ ( '#divCodeLayer' ).codelayer ( {
							codeType: 'anguPartnerDiv',
							id: 'authContent'
						} );
					},
					closeEditor: function ( value ) {
					}
				}
			}, {
				type: 'hidden'
			}, {
				type: 'text',
				editor: {
					openEditor: function ( type ) {
						type = (type || '');
						if(type == 'EMP'){
							$ ( '#divCodeLayer' ).codelayer ( {
								codeType: 'anguEmpAuth',
								id: 'authContent'
							} );			
						} else {
							$ ( '#divCodeLayer' ).codelayer ( {
								codeType: 'anguPartnerAuth',
								id: 'authContent'
							} );							
						}
					},
					closeEditor: function ( value ) {
					}
				}
			}, {
				type: 'text'
			}, {
				type: 'text',
				editor: {
					openEditor: function ( ) {
						$ ( '#divCodeLayer' ).codelayer ( {
							codeType: 'anguG20Bank',
							id: 'authContent'
						} );
					},
					closeEditor: function ( value ) {
						var param = {};
						param.BANK_CD = value.DUZON_BANK_CODE;
						$.ajax ( {
							url: '/exp/expend/angu/getAnguG20BankInfoI_Select_02.do',
							type: "post",
							async: true,
							datatype: "json",
							data: param,
							success: function ( result ) {
								$ ( '#authContent' ).dtable ( 'colSetValues', result.result.aData, false );
							}
						} );
					}
				}
			}, {
				type: 'hidden'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text'
			}, {
				type: 'text',
				editor: {
					moveFocus: function ( ) {
						if($('#bimokContent_rct tr').length === 0){
							if(confirm('비목내역을 추가하시겠습니까?')){
								$('#btnAddBimokRow').click();
							}
						}
					}
				}
			}, {
				type: 'hidden'
			}, {
				type: 'hidden'
			} ],
			data: [ ], // [ [ '0', '0', '0', '0', '0', '법인거래', '001', '', '', '', '', '', '${ViewBag.aData.BOJO_RMK}', '${ViewBag.aData.TR_RMK}' ] ],
			bindData: function ( ) {
				// alert ( $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) + 1 );
				var anguInputInfoResolve = {};
				anguInputInfoResolve = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );

				for ( var i = anguInputInfo.auth.length; i > 0; i-- ) {
					if ( anguInputInfo.auth [ i - 1 ] ) {
						if ( anguInputInfo.auth [ i - 1 ].anbojoSeq === '${ViewBag.aData.anbojoSeq}' ) {
							if ( anguInputInfo.auth [ i - 1 ].dSeq === anguInputInfoResolve.dSeq ) {
								anguInputInfo.auth.splice ( ( i - 1 ), 1 );
							} else if ( anguInputInfo.auth [ i - 1 ].dSeq === '' ) {
								anguInputInfo.auth.splice ( ( i - 1 ), 1 );
							}
						}
					}
				}

				var tempData = $ ( '#authContent' ).dtable ( 'rowGetJsonData', i );
				tempData.anbojoSeq = '${ViewBag.aData.anbojoSeq}';
				tempData.dSeq = anguInputInfoResolve.dSeq;
				anguInputInfo.auth.push ( tempData );
			}
		/* data: [ [ '0', '0', '0', '0', '0', '법인거래', '001', '10000', '엔프롬정보기술㈜', '한국', '010', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]', '[직접입력]' ] ] */
		}
	};
	/* 비목내역 : bimokContent */
	var bimokTable = {
		layout: [ 'lht', 'lct', 'rht', 'rct', 'mr' ],
		colHeaders: [ '[checkbox_all]', '보조비목세목코드', '보조비목명', '보조세목명', '품목', '결의내역순번', '비목내역순번' ],
		colKeys: [ '', 'subDetailBimokCode', 'subBimokName', 'subDetailBimokName', 'bimokItem', 'dSeq', 'bSeq' ],
		colReq: [ 'N', 'Y', 'Y', 'Y', 'N', 'N', 'N' ],
		colLeftFixed: 1,
		colWidth: [ 34, 213, 213, 213, 213, 0, 0 ],
		colAlignments: [ 'cen', 'cen', 'cen', 'cen', 'le', 'cen', 'cen' ],
		callback: {
			rowAdd: function ( rowIndex, rowData ) {
				var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
				$ ( '#bimokContent' ).dtable ( 'colSetValue', rowIndex, 5, resolveInfo.dSeq, false );
				$ ( '#bimokContent' ).dtable ( 'colSetValue', rowIndex, 6, ++seqInfo.bimok.maxSeq, false );
			},
			rowRemove: function ( rowIndex, rowData ) {
			},
			rowClick: function ( rowIndex, rowData ) {
				fnSetJaewonTable ( );
				$ ( '#bimokContent' ).dtable ( 'colSetMove', 0 );
			}
		},
		columns: [ {
			type: 'checkbox'
		}, {
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguAsstnExpitmTaxitm',
						id: 'bimokContent'
					} );
				},
				closeEditor: function ( value ) {
				}
			}
		}, {
			type: 'readonly'
		}, {
			type: 'readonly'
		}, {
			type: 'text',
			editor: {
				moveFocus: function ( ) {
					if($('#jaewonContent_rct tr').length === 0){
						if(confirm('재원내역을 추가하시겠습니까?')){
							$('#btnAddJaewonRow').click();
						}
					}
				}
			}
		}, {
			type: 'hidden'
		}, {
			type: 'hidden'
		} ],
		data: [ ],
		bindData: function ( ) {
			var anguInputInfoResolve = {};
			anguInputInfoResolve = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );

			for ( var i = anguInputInfo.bimok.length; i > 0; i-- ) {
				if ( anguInputInfo.bimok [ i - 1 ] ) {
					if ( anguInputInfo.bimok [ i - 1 ].anbojoSeq === '${ViewBag.aData.anbojoSeq}' ) {
						if ( anguInputInfo.bimok [ i - 1 ].dSeq === anguInputInfoResolve.dSeq ) {
							anguInputInfo.bimok.splice ( ( i - 1 ), 1 );
						} else if ( anguInputInfo.bimok [ i - 1 ].dSeq === '' ) {
							anguInputInfo.bimok.splice ( ( i - 1 ), 1 );
						}
					}
				}
			}

			for ( var i = 0; i < $.fn.dtable.options [ 'bimokContent' ].rowSize; i++ ) {
				var tempData = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', i );
				tempData.anbojoSeq = '${ViewBag.aData.anbojoSeq}';
				tempData.dSeq = anguInputInfoResolve.dSeq;
				anguInputInfo.bimok.push ( tempData );
			}
		}
	/* data: [ [ 'checkbox', '11003', '인건비', '상용임금', '[직접입력]' ] ] */
	};
	/* 재원내역 : jaewonContent */
	var jaewonTable = {
		layout: [ 'lht', 'lct', 'rht', 'rct', 'mr' ],
		colHeaders: [ '[checkbox_all]', '재원구분', '재원구분코드', '프로젝트', '프로젝트코드', '예산과목', '예산과목코드', '코드', '출금계좌', '집행금액', '공급가액', '부가세', '결의내역순번', '비목내역순번', '재원내역순번' ],
		colKeys: [ '', 'anguJaewonDivName', 'anguJaewonDivCode', 'pjtName', 'mgtCode', 'BGT_NM', 'BGT_CD', 'TR_CD', 'TR_NM', 'anguInputReqSumAmount', 'anguInputAmount', 'anguInputVatAmount', 'dSeq', 'bSeq', 'tSeq' ],
		colReq: [ 'N', 'Y', 'N', 'Y', 'N', 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N', 'N', 'N' ],
		colLeftFixed: 1,
		colWidth: [ 34, 100, 100, 200, 0, 100, 100, 100, 100, 100, 100, 100, 0, 0, 0 ],
		colAlignments: [ 'cen', 'le', 'le', 'le', 'le', 'le', 'le', 'cen', 'cen', 'ri', 'ri', 'ri', 'cen', 'cen', 'cen' ],
		callback: {
			rowAdd: function ( rowIndex, rowData ) {
				var bimokInfo = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
				$ ( '#jaewonContent' ).dtable ( 'colSetValue', rowIndex, 12, bimokInfo.dSeq, false );
				$ ( '#jaewonContent' ).dtable ( 'colSetValue', rowIndex, 13, bimokInfo.bSeq, false );
				$ ( '#jaewonContent' ).dtable ( 'colSetValue', rowIndex, 14, ++seqInfo.jaewon.maxSeq, false );
			},
			rowRemove: function ( rowIndex, rowData ) {
			},
			rowClick: function ( rowIndex, rowData ) {
			}
		},
		columns: [ {
			type: 'checkbox'
		}, {
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguJaewonDiv',
						id: 'jaewonContent'
					} );
				},
				closeEditor: function ( value ) {
					fnGetResultAmtInfo ( );
				}
			}
		}, {
			type: 'hidden'
		}, {
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguProject',
						id: 'jaewonContent'
					} );
				},
				closeEditor: function ( value ) {
				}
			}
		}, {
			type: 'hidden'
		}, {
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguBgt',
						id: 'jaewonContent'
					} );
				},
				closeEditor: function ( value ) {
				}
			}
		}, {
			type: 'hidden'
		}, {
			type: 'text',
			editor: {
				openEditor: function ( ) {
					$ ( '#divCodeLayer' ).codelayer ( {
						codeType: 'anguBankPartner',
						id: 'jaewonContent'
					} );
				},
				closeEditor: function ( value ) {
				}
			}
		}, {
			type: 'readonly'
		}, {
			type: 'readonly'
		}, {
			type: 'text'
		}, {
			type: 'text'
		}, {
			type: 'hidden'
		}, {
			type: 'hidden'
		}, {
			type: 'hidden'
		} ],
		data: [ ],
		bindData: function ( ) {
			var anguInputInfoJaewon = $ ( '#jaewonContent' ).dtable ( 'rowGetJsonData', $ ( '#jaewonContent' ).dtable ( 'rowGetIndex' ) );
			anguInputInfoJaewon.anguInputReqSumAmount = ( Number ( anguInputInfoJaewon.anguInputAmount || '0' ) + Number ( anguInputInfoJaewon.anguInputVatAmount || '0' ) ).toString ( )
			$ ( '#jaewonContent' ).dtable ( 'colSetValue', $ ( '#jaewonContent' ).dtable ( 'rowGetIndex' ), 9, anguInputInfoJaewon.anguInputReqSumAmount, false );

			var anguInputInfoBimok = {};
			anguInputInfoBimok = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', $ ( '#bimokContent' ).dtable ( 'rowGetIndex' ) )

			for ( var i = anguInputInfo.jaewon.length; i > 0; i-- ) {
				if ( anguInputInfo.jaewon [ i - 1 ] ) {
					if ( anguInputInfo.jaewon [ i - 1 ].anbojoSeq === '${ViewBag.aData.anbojoSeq}' ) {
						if ( anguInputInfo.jaewon [ i - 1 ].dSeq === anguInputInfoBimok.dSeq ) {
							if ( anguInputInfo.jaewon [ i - 1 ].bSeq === anguInputInfoBimok.bSeq ) {
								anguInputInfo.jaewon.splice ( ( i - 1 ), 1 );
							} else if ( anguInputInfo.jaewon [ i - 1 ].bSeq === '' ) {
								anguInputInfo.jaewon.splice ( ( i - 1 ), 1 );
							}
						} else if ( anguInputInfo.jaewon [ i - 1 ].dSeq === '' ) {
							anguInputInfo.jaewon.splice ( ( i - 1 ), 1 );
						}
					}
				}
			}

			for ( var i = 0; i < $.fn.dtable.options [ 'jaewonContent' ].rowSize; i++ ) {
				var tempData = $ ( '#jaewonContent' ).dtable ( 'rowGetJsonData', i );
				tempData.anbojoSeq = '${ViewBag.aData.anbojoSeq}';
				tempData.dSeq = anguInputInfoBimok.dSeq;
				tempData.bSeq = anguInputInfoBimok.bSeq;
				anguInputInfo.jaewon.push ( tempData );
			}
		}
	/* data: [ [ 'checkbox', '보조금', '001', '더존프로젝트1(한국보육)', '00001', '복리후생비', '200200300', '90001', '한국문학 보조금통장', '[자동계산]', '[직접입력]', '[직접입력]' ] ] */
	};
	/* ## [-] [ 테이블 변수 ] ## */

	$ ( document ).ready ( function ( ) {
		fnInit ( );
		fnInitEvent ( );
		fnResolveTable ( );
		$ ( '#btnAddResolRow' ).click ( );
	} );

	function fnInit ( ) {
		/* element 정의 */
		/* element 정의  - 회계단위*/
		$ ( '#txtErpBizName' ).val ( '${ViewBag.aData.erpBizName}' );
		/* element 정의 - 결의부서 / 작성자 */
		$ ( '#txtErpDeptEmpName' ).val ( [ '${ViewBag.aData.erpDeptName}', '${ViewBag.aData.erpEmpName}' ].join ( ' / ' ) );
		/* element 정의 - 작성일*/
		$ ( '#txtGisuDate' ).kendoDatePicker ( commonFunc.getKendoDatepickerParam ( ) );
		$ ( '#txtGisuDate' ).val ( commonFunc.getToday ( ) );
		$ ( '#txtGisuDate' ).kendoMaskedTextBox ( {
			mask: commonFunc.getDateMask ( )
		} );
		var datepicker = $ ( "#txtGisuDate" ).data ( "kendoDatePicker" );
		datepicker.readonly ( );

		return;
	}
	function fnGetEmpInfo ( ) {
		var param = {};
		param.erpCompSeq = '${ViewBag.aData.erpCompSeq}';
		param.erpCompName = '${ViewBag.aData.erpCompName}';
		param.erpBizSeq = '${ViewBag.aData.erpBizSeq}';
		param.erpBizName = '${ViewBag.aData.erpBizName}';
		param.erpSectSeq = '${ViewBag.aData.erpSectSeq}';
		param.erpSectName = '${ViewBag.aData.erpSectName}';
		param.erpDeptSeq = '${ViewBag.aData.erpDeptSeq}';
		param.erpDeptName = '${ViewBag.aData.erpDeptName}';
		param.erpEmpSeq = '${ViewBag.aData.erpEmpSeq}';
		param.erpEmpName = '${ViewBag.aData.erpEmpName}';
		param.gisuDate = $ ( '#txtGisuDate' ).val ( ).toString ( ).replace ( /-/g, '' ).substring ( 0, 6 );

		return param;
	}
	function fnInitEvent ( ) {
		/* event 정의 */
		$ ( '#btnApproval' ).click ( function ( ) {
			/* event 정의 - 결재상신 */
			/* 국고보조 통합 시스템 연계 집행등록 내역 생성 */
			var param = {};
			param.anbojoSeq = '${ViewBag.aData.anbojoSeq}';
			param.empInfo = JSON.stringify ( fnGetEmpInfo ( ) );
			param.resolve = JSON.stringify ( anguInputInfo.resolve );
			param.auth = JSON.stringify ( anguInputInfo.auth );
			param.bimok = JSON.stringify ( anguInputInfo.bimok );
			param.jaewon = JSON.stringify ( anguInputInfo.jaewon );
			$.ajax ( {
				url: '/exp/expend/angu/setAnguDetailInfo_Insert.do',
				type: "post",
				async: true,
				datatype: "json",
				data: param,
				success: function ( result ) {
					/* 본문 생성 */
					var documentContents = fnSetDocumentContents ( );
					/* 문서 생성 및 화면 전환 */
					fnSetMoveDocument ( documentContents );
				}
			} );
			return;
		} );
		$ ( '#btnAddResolRow' ).click ( function ( ) {
			/* event 정의 - 결의내역 - 추가 */
			$ ( '#resolveContent' ).dtable ( 'rowSetAddData', [ '', $ ( '#txtGisuDate' ).val ( ).substring ( 8, 10 ), $ ( '#txtGisuDate' ).val ( ).substring ( 0, 4 ) ] );
			return;
		} );
		$ ( '#btnRemoveResolRow' ).click ( function ( ) {
			/* event 정의 - 결의내역 - 삭제 */
			if ( $ ( '#resolveContent' ).dtable ( 'getCheckedList' ).length > 0 ) {
				if ( confirm ( '선택된 집행등록을 삭제하시겠습니까?\r\n선택된 집행등록의 하위 비목세목코드와 재원정보도 삭제됩니다.' ) ) {
					var checkboxs = [ ];
					$.each ( $ ( '#resolveContent' ).dtable ( 'getCheckedList' ), function ( checkboxIndex, checkbox ) {
						checkboxs.push ( Number ( ( $ ( checkbox ).prop ( 'id' ) || '' ).toString ( ).replace ( 'resolveContent_chk_col_', '' ) ) );
					} );

					checkboxs.sort ( function ( a, b ) { // 내림차순
						return b - a;
					} );

					checkboxs.forEach ( function ( item, index ) {
						var tempData = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', item );
						fnSetResolveRemove ( tempData.dSeq );
						$ ( '#resolveContent' ).dtable ( 'rowSetRemoveData', item );
					} );

					if ( Object.keys ( $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', 0 ) ).length === 0 ) {
						/* 모두 삭제되어 결의내역이 1건도 없는 경우 자동으로 1행생성 */
						$ ( '#btnAddResolRow' ).click ( );
					}
				}
			}
			return;
		} );
		$ ( '#btnAddBimokRow' ).click ( function ( ) {
			/* event 정의 - 비목내역 - 추가 */
			var resolveInfo = {};
			resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) )

			var authInfo = {};
			for ( var i = 0; i < anguInputInfo.auth.length; i++ ) {
				if ( resolveInfo.dSeq === anguInputInfo.auth [ i ].dSeq ) {
					authInfo = anguInputInfo.auth [ i ];
					break;
				}
			}

			if ( Object.keys ( resolveInfo ).length === 0 ) {
				alert ( '결의내역 정보가 누락되었습니다.' );
				return false;
			} else if ( Object.keys ( authInfo ).length === 0 ) {
				alert ( '증빙내역 정보가 누락되었습니다.' );
				return false;
			}

			/* 필수입력 점검 */
			/* [V] 필수입력 점검 - 일 - resolveInfo.anguDay */
			if ( resolveInfo.anguDay.trim() === '' ) {
				alert ( '결의내역(일)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 사업연도 - resolveInfo.anguYear */
			if ( resolveInfo.anguYear.trim() === '' ) {
				alert ( '결의내역(사업연도)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 지급구분 - resolveInfo.anguPayDivCode */
			if ( resolveInfo.anguPayDivCode.trim() === '' ) {
				alert ( '결의내역(지급구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 국고보조사업 - resolveInfo.anguBusinessCode */
			if ( resolveInfo.anguBusinessCode.trim() === '' ) {
				alert ( '결의내역(국고보조사업)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 이체계좌구분 - resolveInfo.anguAccountDivCode */
			if ( resolveInfo.anguAccountDivCode.trim() === '' ) {
				alert ( '결의내역(이체계좌구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* 필수입력 점검 - 자계좌이체사유코드 */
			/* [V] 필수입력 점검 - 증빙구분 - resolveInfo.anguAuthDivCode */
			if ( resolveInfo.anguAccountDivCode.trim() === '002' && resolveInfo.anguAuthDivCode.trim() === '' ) {
				alert ( '결의내역(자계좌이체사유코드)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 증빙구분 - resolveInfo.anguEtaxTaxIssueDate */
			if ( resolveInfo.anguAuthDivCode.trim() === '' ) {
				alert ( '결의내역(증빙구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 증빙승인번호 - resolveInfo.anguEtaxTaxIssueDate */
			if ( resolveInfo.anguAuthDivCode.trim() === '001' && resolveInfo.anguEtaxTaxNum.trim() === '' ) {
				alert ( '결의내역(증빙승인번호)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 증빙일자 - resolveInfo.anguEtaxTaxIssueDate */
			if ( resolveInfo.anguEtaxTaxIssueDate.trim() === '' ) {
				alert ( '결의내역(증빙일자)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 집행용도 - resolveInfo.anguNote */
			if ( resolveInfo.anguNote.trim() === '' ) {
				alert ( '결의내역(집행용도)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 거래처구분 - authInfo.anguPartnerDivCode */
			if ( authInfo.anguPartnerDivCode.trim() === '' ) {
				alert ( '증빙내역(거래처구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 코드 - authInfo.TR_CD */
			// if ( authInfo.TR_CD === '' ) {
			// 	alert ( '증빙내역(코드)가 입력되지 않았습니다.' );
			//	return false;
			//}
			/* [V] 필수입력 점검 - 거래처명 - authInfo.anguEtaxTaxPartnerName */
			if ( authInfo.anguEtaxTaxPartnerName.trim() === '' ) {
				alert ( '증빙내역(거래처명)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 금융기관 - authInfo.anguPartnerDivCode */
			if ( authInfo.anguPartnerDivCode.trim() === '' ) {
				alert ( '증빙내역(금융기관)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 입금계좌번호 - authInfo.BCNC_ACNUT_NO */
			if ( authInfo.BCNC_ACNUT_NO.trim() === '' ) {
				alert ( '증빙내역(입금계좌번호)가 입력되지 않았습니다.' );
				return false;
			}
			/* 필수입력 점검 - 보조금통장표시내용 - authInfo. */
			/* 필수입력 점검 - 거래처통장표시내용 - authInfo. */
			/* [V] 필수입력 점검 - 거래처 사업자/주민번호 - authInfo.anguEtaxTaxPartnerNum */
			if ( authInfo.anguEtaxTaxPartnerNum.trim() === '' ) {
				alert ( '증빙내역(거래처 사업자/주민번호)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 사업장주소 - authInfo.BCNC_ADRES */
			if ( authInfo.BCNC_ADRES.trim() === '' ) {
				alert ( '증빙내역(사업장주소)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 대표자명 - authInfo.BCNC_RPRSNTY_NM */
			// if ( authInfo.BCNC_RPRSNTY_NM.trim() === '' ) {
			// 	alert ( '증빙내역(대표자명)이 입력되지 않았습니다.' );
			// 	return false;
			// }
			/* [V] 필수입력 점검 - 전화번호 - authInfo.BCNC_TELNO */
			// if ( authInfo.BCNC_TELNO === '' ) {
			// 	alert ( '증빙내역(전화번호)가 입력되지 않았습니다.' );
			// 	return false;
			// }

			$ ( '#bimokContent' ).dtable ( 'rowSetAddData', [ ] );
			return;
		} );
		$ ( '#btnRemoveBimokRow' ).click ( function ( ) {
			/* event 정의 - 비목내역 - 삭제 */
			alert ( '비목내역 삭제' );
			return;
		} );
		$ ( '#btnAddJaewonRow' ).click ( function ( ) {
			var resolveInfo = {};
			resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) )

			var authInfo = {};
			for ( var i = 0; i < anguInputInfo.auth.length; i++ ) {
				if ( resolveInfo.dSeq === anguInputInfo.auth [ i ].dSeq ) {
					authInfo = anguInputInfo.auth [ i ];
					break;
				}
			}

			if ( Object.keys ( resolveInfo ).length === 0 ) {
				alert ( '결의내역 정보가 누락되었습니다.' );
				return false;
			} else if ( Object.keys ( authInfo ).length === 0 ) {
				alert ( '증빙내역 정보가 누락되었습니다.' );
				return false;
			}

			/* 필수입력 점검 */
			/* [V] 필수입력 점검 - 일 - resolveInfo.anguDay */
			if ( resolveInfo.anguDay.trim() === '' ) {
				alert ( '결의내역(일)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 사업연도 - resolveInfo.anguYear */
			if ( resolveInfo.anguYear.trim() === '' ) {
				alert ( '결의내역(사업연도)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 지급구분 - resolveInfo.anguPayDivCode */
			if ( resolveInfo.anguPayDivCode.trim() === '' ) {
				alert ( '결의내역(지급구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 국고보조사업 - resolveInfo.anguBusinessCode */
			if ( resolveInfo.anguBusinessCode.trim() === '' ) {
				alert ( '결의내역(국고보조사업)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 이체계좌구분 - resolveInfo.anguAccountDivCode */
			if ( resolveInfo.anguAccountDivCode.trim() === '' ) {
				alert ( '결의내역(이체계좌구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* 필수입력 점검 - 자계좌이체사유코드 */
			/* [V] 필수입력 점검 - 증빙구분 - resolveInfo.anguAuthDivCode */
			if ( resolveInfo.anguAccountDivCode.trim() === '002' && resolveInfo.anguAuthDivCode.trim() === '' ) {
				alert ( '결의내역(자계좌이체사유코드)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 증빙구분 - resolveInfo.anguEtaxTaxIssueDate */
			if ( resolveInfo.anguAuthDivCode.trim() === '' ) {
				alert ( '결의내역(증빙구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 증빙승인번호 - resolveInfo.anguEtaxTaxIssueDate */
			if ( resolveInfo.anguAuthDivCode.trim() === '001' && resolveInfo.anguEtaxTaxNum.trim() === '' ) {
				alert ( '결의내역(증빙승인번호)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 증빙일자 - resolveInfo.anguEtaxTaxIssueDate */
			if ( resolveInfo.anguEtaxTaxIssueDate.trim() === '' ) {
				alert ( '결의내역(증빙일자)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 집행용도 - resolveInfo.anguNote */
			if ( resolveInfo.anguNote.trim() === '' ) {
				alert ( '결의내역(집행용도)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 거래처구분 - authInfo.anguPartnerDivCode */
			if ( authInfo.anguPartnerDivCode.trim() === '' ) {
				alert ( '증빙내역(거래처구분)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 코드 - authInfo.TR_CD */
			// if ( authInfo.TR_CD === '' ) {
			// 	alert ( '증빙내역(코드)가 입력되지 않았습니다.' );
			//	return false;
			//}
			/* [V] 필수입력 점검 - 거래처명 - authInfo.anguEtaxTaxPartnerName */
			if ( authInfo.anguEtaxTaxPartnerName.trim() === '' ) {
				alert ( '증빙내역(거래처명)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 금융기관 - authInfo.anguPartnerDivCode */
			if ( authInfo.anguPartnerDivCode.trim() === '' ) {
				alert ( '증빙내역(금융기관)이 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 입금계좌번호 - authInfo.BCNC_ACNUT_NO */
			if ( authInfo.BCNC_ACNUT_NO.trim() === '' ) {
				alert ( '증빙내역(입금계좌번호)가 입력되지 않았습니다.' );
				return false;
			}
			/* 필수입력 점검 - 보조금통장표시내용 - authInfo. */
			/* 필수입력 점검 - 거래처통장표시내용 - authInfo. */
			/* [V] 필수입력 점검 - 거래처 사업자/주민번호 - authInfo.anguEtaxTaxPartnerNum */
			if ( authInfo.anguEtaxTaxPartnerNum.trim() === '' ) {
				alert ( '증빙내역(거래처 사업자/주민번호)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 사업장주소 - authInfo.BCNC_ADRES */
			if ( authInfo.BCNC_ADRES.trim() === '' ) {
				alert ( '증빙내역(사업장주소)가 입력되지 않았습니다.' );
				return false;
			}
			
			var bimokInfo = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', $ ( '#bimokContent' ).dtable ( 'rowGetIndex' ) );

			/* [V] 필수입력 점검 - 보조비목세목코드 - bimok.subDetailBimokCode */
			if ( bimokInfo.subDetailBimokCode === '' ) {
				alert ( '비목내역(보조비목세목코드)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 보조비목명 - bimok.subBimokName */
			if ( bimokInfo.subBimokName === '' ) {
				alert ( '비목내역(보조비목명)가 입력되지 않았습니다.' );
				return false;
			}
			/* [V] 필수입력 점검 - 보조세목명 - bimok.subDetailBimokName */
			if ( bimokInfo.subDetailBimokName === '' ) {
				alert ( '비목내역(보조세목명)가 입력되지 않았습니다.' );
				return false;
			}

			/* event 정의 - 재원내역  - 추가 */
			$ ( '#jaewonContent' ).dtable ( 'rowSetAddData', [ ] );
			return;
		} );
		$ ( '#btnPerPayPop' ).click ( function ( ) {
			/* event 정의 - 인력정보 등록 */
			alert ( '개인 정보 암호화 및 급여정보 노출 기준 정의 문제로 인하여 서비스 준비 중입니다.' );
			return;
		} );
		$ ( '#btnRemoveJaewonRow' ).click ( function ( ) {
			/* event 정의 - 재원내역  - 삭제 */
			return;
		} );

		setTimeout ( function ( ) {
			/* 거래처가 많을 수 있으므로 처음에 거래처 정보를 비동기로 조회하여 저장한다. */
			/* TODO: 메모리가 감당할 수 있나? 총 거래처 카운트별로 얼마나 감당하는지 점검하자. */
			$.ajax ( {
				url: '/exp/expend/angu/getAnguPartnerInfoI_Select_01.do?P_HELP_TY=&P_USE_YN=1',
				async: true,
				success: function ( result ) {
					$ ( '#divCodeLayer' ).codelayer ( 'setSource', 'anguPartnerAuth', result.result.aaData );
				}
			} );

			$ ( "#viewLoading" ).hide ( );
		}, 3000 );
		return;
	}
	function fnResolveTable ( ) {
		$ ( '#resolveContent' ).dtable ( resolveTable );
		var authTableParam = {};
		authTableParam = $.extend ( authTableParam, authTable.typeB );
		authTableParam.data = [ ];
		$ ( '#authContent' ).dtable ( authTableParam );
		$ ( '#bimokContent' ).dtable ( bimokTable );
		$ ( '#jaewonContent' ).dtable ( jaewonTable );
	}

	function fnGetResultAmtInfo ( ) {
		var returnParam = '';
		var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
		var authInfo = $ ( '#authContent' ).dtable ( 'rowGetJsonData', $ ( '#authContent' ).dtable ( 'rowGetIndex' ) );
		var bimokInfo = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', $ ( '#bimokContent' ).dtable ( 'rowGetIndex' ) );
		var jaewonInfo = $ ( '#jaewonContent' ).dtable ( 'rowGetJsonData', $ ( '#jaewonContent' ).dtable ( 'rowGetIndex' ) );

		returnParam += '?BSNSYEAR=' + resolveInfo.anguYear;
		returnParam += '&DDTLBZ_ID=' + resolveInfo.anguBusinessCode;
		returnParam += '&ASSTN_TAXITM_CODE=' + bimokInfo.subDetailBimokCode;
		returnParam += '&FNRSC_SE_CODE=' + jaewonInfo.anguJaewonDivCode;

		$.ajax ( {
			url: '/exp/expend/angu/getAnguResultAmtInfoI_Select.do' + returnParam,
			async: true,
			success: function ( result ) {
				anguResultAmtInfo = result.result.aData;

				if ( anguResultAmtInfo.excutPlanAmount ) {
					/* 계획금액 */
					$ ( '#txtPlanAmount' ).val ( anguResultAmtInfo.excutPlanAmount.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) );
				}
				if ( anguResultAmtInfo.sum ) {
					/* 집행금액 */
					$ ( '#txtSumAmount' ).val ( anguResultAmtInfo.sum.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) );
				}
				if ( anguResultAmtInfo.sub ) {
					/* 집행잔액 */
					$ ( '#txtSubAmount' ).val ( anguResultAmtInfo.sub.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) );
				}
				if ( anguResultAmtInfo.excutAmount ) {
					/* E나라도움 집행금액 */
					// $ ( '#lblExcutAmount' ).empty ( ).append ( anguResultAmtInfo.excutAmount );
					$ ( '#txtExcutAmount' ).val ( anguResultAmtInfo.excutAmount.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) );
				}
				if ( anguResultAmtInfo.sumAmount ) {
					/* 미등록 집행금액 */
					// $ ( '#lblReqSumAmount' ).empty ( ).append ( anguResultAmtInfo.sumAmount );
					$ ( '#txtReqSumAmount' ).val ( anguResultAmtInfo.sumAmount.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) );
				}
			}
		} );

		$ ( "#viewLoading" ).hide ( );
	}

	/* ## [+] [ 테이블 갱신 ] ## */
	function fnSetAuthTable ( ) {
		var resolve = {};
		resolve = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );

		var auth = {};
		for ( var i = anguInputInfo.auth.length; i > 0; i-- ) {
			var index = ( i - 1 );
			if ( anguInputInfo.auth [ index ].dSeq === resolve.dSeq ) {
				auth = anguInputInfo.auth [ index ];
			} else {
				if ( !anguInputInfo.auth [ index ] ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.auth.splice ( index, 1 );
				} else if ( !anguInputInfo.auth [ index ].dSeq === "" ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.auth.splice ( index, 1 );
				} else if ( !anguInputInfo.auth [ index ].dSeq === undefined ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.auth.splice ( index, 1 );
				}
			}
		}

		switch ( resolve.anguPayDivCode ) {
			case '1':
				/* 일반 */
				$ ( '#authContent' ).dtable ( authTable.typeB );
				break;
			case '2':
				/* 인건비성 */
				$ ( '#authContent' ).dtable ( authTable.typeA );
				break;
			default:
				/* 기본 */
				$ ( '#authContent' ).dtable ( authTable.typeB );
				break;
		}

		$ ( '#authContent' ).dtable ( 'rowSetAddData', [ ] );
		$ ( '#authContent' ).dtable ( 'colSetValues', auth, false );

		fnSetBimokTable ( ); /* 하위 비목내역 갱신 */
		return;
	}
	function fnSetBimokTable ( ) {
		var resolve = {};
		resolve = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );

		var bimok = [ ];
		for ( var i = anguInputInfo.bimok.length; i > 0; i-- ) {
			var index = ( i - 1 );
			if ( anguInputInfo.bimok [ index ].dSeq === resolve.dSeq ) {
				bimok.push ( anguInputInfo.bimok [ index ] );
			} else {
				if ( !anguInputInfo.bimok [ index ] ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.bimok.splice ( index, 1 );
				} else if ( !anguInputInfo.bimok [ index ].dSeq === "" ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.bimok.splice ( index, 1 );
				} else if ( !anguInputInfo.bimok [ index ].bSeq === "" ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.bimok.splice ( index, 1 );
				} else if ( !anguInputInfo.bimok [ index ].dSeq === undefined ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.bimok.splice ( index, 1 );
				} else if ( !anguInputInfo.bimok [ index ].bSeq === undefined ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.bimok.splice ( index, 1 );
				}
			}
		}

		$ ( '#bimokContent' ).dtable ( bimokTable ); /* 비목내역 테이블 초기화 */

		for ( var i = 0; i < bimok.length; i++ ) {
			$ ( '#bimokContent' ).dtable ( 'rowSetAddData', [ ] );
			$ ( '#bimokContent' ).dtable ( 'colSetValues', bimok [ i ], false );

			if ( ( i + 1 ) === bimok.length ) {
				fnSetJaewonTable ( ); /* 하위 재원내역 갱신 */
			}

		}
		return;
	}
	function fnSetJaewonTable ( ) {
		var bimok = {};
		bimok = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', $ ( '#bimokContent' ).dtable ( 'rowGetIndex' ) );

		var jaewon = [ ];
		for ( var i = anguInputInfo.jaewon.length; i > 0; i-- ) {
			var index = ( i - 1 );
			if ( anguInputInfo.jaewon [ index ].dSeq === bimok.dSeq ) {
				if ( anguInputInfo.jaewon [ index ].bSeq === bimok.bSeq ) {
					jaewon.push ( anguInputInfo.jaewon [ index ] );
				}
			} else {
				if ( !anguInputInfo.jaewon [ index ] ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.jaewon.splice ( index, 1 );
				} else if ( !anguInputInfo.jaewon [ index ].dSeq === "" ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.jaewon.splice ( index, 1 );
				} else if ( !anguInputInfo.jaewon [ index ].bSeq === "" ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.jaewon.splice ( index, 1 );
				} else if ( !anguInputInfo.jaewon [ index ].tSeq === "" ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.jaewon.splice ( index, 1 );
				} else if ( !anguInputInfo.jaewon [ index ].dSeq === undefined ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.jaewon.splice ( index, 1 );
				} else if ( !anguInputInfo.jaewon [ index ].bSeq === undefined ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.jaewon.splice ( index, 1 );
				} else if ( !anguInputInfo.jaewon [ index ].tSeq === undefined ) {
					/* 잘못된 데이터 삭제 */
					anguInputInfo.jaewon.splice ( index, 1 );
				}
			}
		}

		$ ( '#jaewonContent' ).dtable ( jaewonTable ); /* 재원내역 테이블 초기화 */

		for ( var i = 0; i < jaewon.length; i++ ) {
			$ ( '#jaewonContent' ).dtable ( 'rowSetAddData', [ ] );
			$ ( '#jaewonContent' ).dtable ( 'colSetValues', jaewon [ i ], false );
		}

		return;
	}
	function fnSetResolveRemove ( dSeq ) {
		for ( var i = anguInputInfo.resolve.length; i > 0; i-- ) {
			var index = ( i - 1 );
			if ( anguInputInfo.resolve [ index ].dSeq === dSeq ) {
				fnSetAuthRemove ( dSeq );
				anguInputInfo.resolve.splice ( index, 1 );
			}
		}
	}

	function fnSetAuthRemove ( dSeq ) {
		for ( var i = anguInputInfo.auth.length; i > 0; i-- ) {
			var index = ( i - 1 );
			if ( anguInputInfo.auth [ index ].dSeq === dSeq ) {
				fnSetBimokRemove ( dSeq );
				anguInputInfo.auth.splice ( index, 1 );
			}
		}
	}

	function fnSetBimokRemove ( dSeq ) {
		for ( var i = anguInputInfo.bimok.length; i > 0; i-- ) {
			var index = ( i - 1 );
			if ( anguInputInfo.bimok [ index ].dSeq === dSeq ) {
				fnSetJaewonRemove ( anguInputInfo.bimok [ index ].dSeq, anguInputInfo.bimok [ index ].bSeq );
				anguInputInfo.bimok.splice ( index, 1 );
			}
		}
	}

	function fnSetJaewonRemove ( dSeq, bSeq ) {
		for ( var i = anguInputInfo.jaewon.length; i > 0; i-- ) {
			var index = ( i - 1 );
			if ( anguInputInfo.jaewon [ index ].dSeq === dSeq && anguInputInfo.jaewon [ index ].bSeq === bSeq ) {
				anguInputInfo.jaewon.splice ( index, 1 );
			}
		}
	}

	/* ## [-] [ 테이블 갱신 ] ## */

	/* ## [+] [ 공통화 필요 사항 ] ## */
	var commonFunc = {
		getKendoDatepickerParam: function ( ) {
			return {
				culture: "ko-KR",
				format: "yyyy-MM-dd",
				min: new Date ( Number ( '${ViewBag.aData.erpCompFrDate}'.substring ( 0, 4 ) ), ( Number ( '${ViewBag.aData.erpCompFrDate}'.substring ( 4, 6 ) ) - 1 ), Number ( '${ViewBag.aData.erpCompFrDate}'.substring ( 6, 8 ) ) ),
				max: new Date ( Number ( '${ViewBag.aData.erpCompToDate}'.substring ( 0, 4 ) ), ( Number ( '${ViewBag.aData.erpCompToDate}'.substring ( 4, 6 ) ) - 1 ), Number ( '${ViewBag.aData.erpCompToDate}'.substring ( 6, 8 ) ) )
			}
		},
		getDateMask: function ( ) {
			return '0000-00-00';
		},
		getToday: function ( ) {
			var date = new Date ( );
			return [ date.getFullYear ( ), ( date.getMonth ( ) + 1 ) < 10 ? '0' + ( date.getMonth ( ) + 1 ) : ( date.getMonth ( ) + 1 ), date.getDate ( ) < 10 ? '0' + date.getDate ( ) : date.getDate ( ) ].join ( '-' )
		}
	}
	/* ## [-] [ 공통화 필요 사항 ] ## */

	/* ## [+] [ 파라미터 반환 정의 ] ## */
	/* 국고보조통합시스템 - 국고보조사업 */
	function fnGetParamAnguBusiness ( ) {
		var rowValue = {};
		rowValue = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
		return 'BSNSYEAR=' + rowValue.anguYear;
	}
	/* 국고보조통합시스템 - 보조비목세목코드 */
	function fnGetBimokParam ( ) {
		var returnParam = '';
		resolve = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );

		for ( var i = 0; i < $.fn.dtable.options [ 'resolveContent' ].rowSize; i++ ) {
			if ( anguInputInfo.resolve [ i ].dSeq === resolve.dSeq ) {
				returnParam += 'BSNSYEAR=' + anguInputInfo.resolve [ i ].anguYear;
				returnParam += '&FSYR=' + anguInputInfo.resolve [ i ].anguYear;
				returnParam += '&DDTLBZ_ID=' + anguInputInfo.resolve [ i ].anguBusinessCode;
				break;
			}
		}

		return returnParam;
	}
	/* 국고보조통합시스템 - 재원구분 */
	function fnGetJaewonParam ( ) {
		// DDTLBZ_ID=TEST-00003&BSNSYEAR=2017&ASSTN_TAXITM_CODE=22001
		var returnParam = '';
		var anguInputInfoResolve = {};
		anguInputInfoResolve = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
		var anguInputInfoBimok = {};
		anguInputInfoBimok = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', $ ( '#bimokContent' ).dtable ( 'rowGetIndex' ) );

		returnParam += 'DDTLBZ_ID=' + anguInputInfoResolve.anguBusinessCode;
		returnParam += '&BSNSYEAR=' + anguInputInfoResolve.anguYear;
		returnParam += '&ASSTN_TAXITM_CODE=' + anguInputInfoBimok.subDetailBimokCode;

		return returnParam;
	}
	/* 국고보조통합시스템 - 프로젝트 */
	function fnGetProjectParam ( ) {
		var returnParam = '';
		var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
		returnParam += 'DDTLBZ_ID=' + resolveInfo.anguBusinessCode;
		return returnParam;
	}
	/* 국고보조통합시스템 - 예산과목 */
	function fnGetBgtParam ( ) {
		var returnParam = '';
		var resolveInfo = $ ( '#resolveContent' ).dtable ( 'rowGetJsonData', $ ( '#resolveContent' ).dtable ( 'rowGetIndex' ) );
		var authInfo = $ ( '#authContent' ).dtable ( 'rowGetJsonData', $ ( '#authContent' ).dtable ( 'rowGetIndex' ) );
		var bimokInfo = $ ( '#bimokContent' ).dtable ( 'rowGetJsonData', $ ( '#bimokContent' ).dtable ( 'rowGetIndex' ) );
		var jaewonInfo = $ ( '#jaewonContent' ).dtable ( 'rowGetJsonData', $ ( '#jaewonContent' ).dtable ( 'rowGetIndex' ) );

		returnParam += 'GISU=' + gisuInfo.erpCompGisu;
		returnParam += '&FR_DT=' + gisuInfo.erpCompFrDate;
		returnParam += '&TO_DT=' + gisuInfo.erpCompToDate;
		returnParam += '&GR_FG=2';
		returnParam += '&DIV_CDS=' + '${ViewBag.aData.erpBizSeq}' + '|';
		returnParam += '&MGT_CDS=' + jaewonInfo.mgtCode + '|';
		returnParam += '&BOTTOM_CDS=';
		returnParam += '&BGT_CD=' + '';
		returnParam += '&BGT_NM=' + '';
		returnParam += '&OPT_01=' + '1';
		returnParam += '&OPT_02=' + '2';
		returnParam += '&OPT_03=' + '1';
		returnParam += '&BGT_FR_DT=' + gisuInfo.erpCompFrDate;
		returnParam += '&GROUP_CD=';
		returnParam += '&BSNSYEAR=' + resolveInfo.anguYear;
		returnParam += '&ASSTN_TAXITM_CODE=' + bimokInfo.subDetailBimokCode;

		return returnParam;
	}
	/* 국고보조통합시스템 - 금융거래처 */
	function fnGetBankPartnerParam ( ) {
		var returnParam = '';
		returnParam += 'P_CODE=&P_CODE2=&P_CODE3=&P_NAME=&P_STD_DT=';
		return returnParam;
	}
	/* ## [-] [ 파라미터 반환 정의 ] ## */

	/* ## [+] [ 전자결재 연동 ] ## */
	/* 국고보조통합시스템 - 문서 생성 */
	function fnSetDocument ( ) {
	}
	/* 국고보조통합시스템 - 본문 생성 */
	function fnSetDocumentContents ( ) {
		var documentContents = '';
		documentContents = '							\n\
			<style type="text/css">							\n\
				p.HStyle0 {									\n\
					style-name: "바탕글";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle0 {								\n\
					style-name: "바탕글";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle0 {								\n\
					style-name: "바탕글";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle1 {									\n\
					style-name: "본문";						\n\
					margin-left: 15.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle1 {								\n\
					style-name: "본문";						\n\
					margin-left: 15.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle1 {								\n\
					style-name: "본문";						\n\
					margin-left: 15.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle2 {									\n\
					style-name: "개요 1";					\n\
					margin-left: 10.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle2 {								\n\
					style-name: "개요 1";					\n\
					margin-left: 10.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle2 {								\n\
					style-name: "개요 1";					\n\
					margin-left: 10.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle3 {									\n\
					style-name: "개요 2";					\n\
					margin-left: 20.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle3 {								\n\
					style-name: "개요 2";					\n\
					margin-left: 20.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle3 {								\n\
					style-name: "개요 2";					\n\
					margin-left: 20.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle4 {									\n\
					style-name: "개요 3";					\n\
					margin-left: 30.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle4 {								\n\
					style-name: "개요 3";					\n\
					margin-left: 30.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle4 {								\n\
					style-name: "개요 3";					\n\
					margin-left: 30.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle5 {									\n\
					style-name: "개요 4";					\n\
					margin-left: 40.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle5 {								\n\
					style-name: "개요 4";					\n\
					margin-left: 40.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle5 {								\n\
					style-name: "개요 4";					\n\
					margin-left: 40.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle6 {									\n\
					style-name: "개요 5";					\n\
					margin-left: 50.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle6 {								\n\
					style-name: "개요 5";					\n\
					margin-left: 50.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle6 {								\n\
					style-name: "개요 5";					\n\
					margin-left: 50.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle7 {									\n\
					style-name: "개요 6";					\n\
					margin-left: 60.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle7 {								\n\
					style-name: "개요 6";					\n\
					margin-left: 60.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle7 {								\n\
					style-name: "개요 6";					\n\
					margin-left: 60.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle8 {									\n\
					style-name: "개요 7";					\n\
					margin-left: 70.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle8 {								\n\
					style-name: "개요 7";					\n\
					margin-left: 70.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle8 {								\n\
					style-name: "개요 7";					\n\
					margin-left: 70.0pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle9 {									\n\
					style-name: "쪽 번호";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle9 {								\n\
					style-name: "쪽 번호";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle9 {								\n\
					style-name: "쪽 번호";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 160%;						\n\
					font-size: 10.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle10 {								\n\
					style-name: "머리말";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 150%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle10 {								\n\
					style-name: "머리말";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 150%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle10 {								\n\
					style-name: "머리말";					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: 0.0pt;						\n\
					line-height: 150%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle11 {								\n\
					style-name: "각주";						\n\
					margin-left: 13.1pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: -13.1pt;					\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle11 {								\n\
					style-name: "각주";						\n\
					margin-left: 13.1pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: -13.1pt;					\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle11 {								\n\
					style-name: "각주";						\n\
					margin-left: 13.1pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: -13.1pt;					\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle12 {								\n\
					style-name: "미주";						\n\
					margin-left: 13.1pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: -13.1pt;					\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle12 {								\n\
					style-name: "미주";						\n\
					margin-left: 13.1pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: -13.1pt;					\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle12 {								\n\
					style-name: "미주";						\n\
					margin-left: 13.1pt;					\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: justify;					\n\
					text-indent: -13.1pt;					\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬바탕;				\n\
					letter-spacing: 0;						\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				p.HStyle13 {								\n\
					style-name: "메모";						\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: left;						\n\
					text-indent: 0.0pt;						\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: -5%;					\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				li.HStyle13 {								\n\
					style-name: "메모";						\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: left;						\n\
					text-indent: 0.0pt;						\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: -5%;					\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
				div.HStyle13 {								\n\
					style-name: "메모";						\n\
					margin-top: 0.0pt;						\n\
					margin-bottom: 0.0pt;					\n\
					text-align: left;						\n\
					text-indent: 0.0pt;						\n\
					line-height: 130%;						\n\
					font-size: 9.0pt;						\n\
					font-family: 함초롬돋움;				\n\
					letter-spacing: -5%;					\n\
					font-weight: "normal";					\n\
					font-style: "normal";					\n\
					color: #000000;							\n\
				}											\n\
															\n\
			</style>';

		$.each(anguInputInfo.resolve, function (resolveIndex, resolveItem) {

			var subContents = '';

			$.each(anguInputInfo.auth, function (authIndex, authItem) {
				if (resolveItem.dSeq == authItem.dSeq) {
					var resultAmount = 0;
					$.each(anguInputInfo.bimok, function (bimokIndex, bimokItem) {
						if (authItem.dSeq == bimokItem.dSeq) {
							$.each(anguInputInfo.jaewon, function (jaewonIndex, jaewonItem) {
								if (bimokItem.dSeq == jaewonItem.dSeq && bimokItem.bSeq == jaewonItem.dSeq) {
									if (subContents == '') {
										subContents += ' \n\
											<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;border:none;"> \n\
											<tr> \n\
												<td rowspan="6" valign="middle" style="width:77;height:181;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;font-weight:bold">' + (resolveIndex + 1) + '</span></p> \n\
												</td> \n\
												<td colspan="3" valign="middle" style="width:569;height:37;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;font-weight:bold">결의내역&nbsp;</span></p> \n\
												</td> \n\
											</tr> \n\
											<tr> \n\
												<td valign="middle" style="width:182;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%;font-weight:bold">거래처명</span></p> \n\
												</td> \n\
												<td valign="middle" style="width:112;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%;font-weight:bold">금융기관</span></p> \n\
												</td> \n\
												<td valign="middle" style="width:275;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%;font-weight:bold">입금계좌번호</span></p> \n\
												</td> \n\
											</tr> \n\
											<tr> \n\
												<td valign="middle" style="width:182;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%">' + authItem.anguEtaxTaxPartnerName + '</span></p> \n\
												</td> \n\
												<td valign="middle" style="width:112;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%">' + authItem.BANK_NM + '</span></p> \n\
												</td> \n\
												<td valign="middle" style="width:275;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%">' + authItem.BCNC_ACNUT_NO + '</span></p> \n\
												</td> \n\
											</tr> \n\
											<tr> \n\
												<td colspan="2" valign="middle" style="width:294;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%;font-weight:bold">프로젝트</span></p> \n\
												</td> \n\
												<td valign="middle" style="width:275;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%;font-weight:bold">예산과목</span></p> \n\
												</td> \n\
											</tr> \n\
											<tr> \n\
												<td colspan="2" valign="middle" style="width:294;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%">' + resolveItem.anguBusinessName + '</span></p> \n\
												</td> \n\
												<td valign="middle" style="width:275;height:28;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
													<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림">' + jaewonItem.BGT_NM + '</span></p> \n\
												</td> \n\
											</tr> \n\ ';
									}
									
									resultAmount += (isNaN(jaewonItem.anguInputReqSumAmount) ? 0 : Number((jaewonItem.anguInputReqSumAmount)));
								}
							});
						}
					});

					if(subContents != ''){
						subContents += ' \n\
								<tr> \n\
								<td colspan="2" valign="middle" style="width:294;height:30;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
									<p class="HStyle0" style="text-align:center;"><span style="font-family:굴림;letter-spacing:-10%;font-weight:bold">합&nbsp; 계&nbsp; 금&nbsp; 액</span></p> \n\
								</td> \n\
								<td valign="middle" style="width:275;height:30;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n\
									<p class="HStyle0" style="text-align:right;"><span style="font-family:굴림">' + resultAmount.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) + '</span></p> \n\
								</td> \n\
							</tr> \n\
						</table>';
					}

					documentContents += subContents;
				}
			});
		});

		return documentContents;
		
		// var documentContents = '';
		// documentContents += ' \n\
		// 	<style type="text/css"> \n\
		// 		p.HStyle0 { \n\
		// 			style-name: "바탕글"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle0 { \n\
		// 			style-name: "바탕글"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle0 { \n\
		// 			style-name: "바탕글"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle1 { \n\
		// 			style-name: "본문"; \n\
		// 			margin-left: 15.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle1 { \n\
		// 			style-name: "본문"; \n\
		// 			margin-left: 15.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle1 { \n\
		// 			style-name: "본문"; \n\
		// 			margin-left: 15.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle2 { \n\
		// 			style-name: "개요 1"; \n\
		// 			margin-left: 10.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle2 { \n\
		// 			style-name: "개요 1"; \n\
		// 			margin-left: 10.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle2 { \n\
		// 			style-name: "개요 1"; \n\
		// 			margin-left: 10.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle3 { \n\
		// 			style-name: "개요 2"; \n\
		// 			margin-left: 20.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle3 { \n\
		// 			style-name: "개요 2"; \n\
		// 			margin-left: 20.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle3 { \n\
		// 			style-name: "개요 2"; \n\
		// 			margin-left: 20.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle4 { \n\
		// 			style-name: "개요 3"; \n\
		// 			margin-left: 30.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle4 { \n\
		// 			style-name: "개요 3"; \n\
		// 			margin-left: 30.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle4 { \n\
		// 			style-name: "개요 3"; \n\
		// 			margin-left: 30.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle5 { \n\
		// 			style-name: "개요 4"; \n\
		// 			margin-left: 40.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle5 { \n\
		// 			style-name: "개요 4"; \n\
		// 			margin-left: 40.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle5 { \n\
		// 			style-name: "개요 4"; \n\
		// 			margin-left: 40.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle6 { \n\
		// 			style-name: "개요 5"; \n\
		// 			margin-left: 50.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle6 { \n\
		// 			style-name: "개요 5"; \n\
		// 			margin-left: 50.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle6 { \n\
		// 			style-name: "개요 5"; \n\
		// 			margin-left: 50.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle7 { \n\
		// 			style-name: "개요 6"; \n\
		// 			margin-left: 60.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle7 { \n\
		// 			style-name: "개요 6"; \n\
		// 			margin-left: 60.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle7 { \n\
		// 			style-name: "개요 6"; \n\
		// 			margin-left: 60.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle8 { \n\
		// 			style-name: "개요 7"; \n\
		// 			margin-left: 70.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle8 { \n\
		// 			style-name: "개요 7"; \n\
		// 			margin-left: 70.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle8 { \n\
		// 			style-name: "개요 7"; \n\
		// 			margin-left: 70.0pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle9 { \n\
		// 			style-name: "쪽 번호"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle9 { \n\
		// 			style-name: "쪽 번호"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle9 { \n\
		// 			style-name: "쪽 번호"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 160%; \n\
		// 			font-size: 10.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle10 { \n\
		// 			style-name: "머리말"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 150%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle10 { \n\
		// 			style-name: "머리말"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 150%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle10 { \n\
		// 			style-name: "머리말"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 150%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle11 { \n\
		// 			style-name: "각주"; \n\
		// 			margin-left: 13.1pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: -13.1pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle11 { \n\
		// 			style-name: "각주"; \n\
		// 			margin-left: 13.1pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: -13.1pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle11 { \n\
		// 			style-name: "각주"; \n\
		// 			margin-left: 13.1pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: -13.1pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle12 { \n\
		// 			style-name: "미주"; \n\
		// 			margin-left: 13.1pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: -13.1pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle12 { \n\
		// 			style-name: "미주"; \n\
		// 			margin-left: 13.1pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: -13.1pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle12 { \n\
		// 			style-name: "미주"; \n\
		// 			margin-left: 13.1pt; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: -13.1pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: 0; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		p.HStyle13 { \n\
		// 			style-name: "메모"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: -5%; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		li.HStyle13 { \n\
		// 			style-name: "메모"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: -5%; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 		 \n\
		// 		div.HStyle13 { \n\
		// 			style-name: "메모"; \n\
		// 			margin-top: 0.0pt; \n\
		// 			margin-bottom: 0.0pt; \n\
		// 			text-align: justify; \n\
		// 			text-indent: 0.0pt; \n\
		// 			line-height: 130%; \n\
		// 			font-size: 9.0pt; \n\
		// 			font-family: 돋움; \n\
		// 			letter-spacing: -5%; \n\
		// 			font-weight: "normal"; \n\
		// 			font-style: "normal"; \n\
		// 			color: #000000; \n\
		// 		} \n\
		// 	</style> ';

		// $.each ( anguInputInfo.resolve, function ( resolveIndex, resolveItem ) {
		// 	var resolveRowCount = 0;
		// 	documentContents += '<p class="HStyle0" style="line-height:40%;"> \n';
		// 	documentContents += '	<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;border:none;width:657px"> \n';
		// 	documentContents += '		<tr> \n';
		// 	documentContents += '			<td rowspan="_resolvRowSpan_" valign="middle" bgcolor="#f2f2f2" style="width:53;height:241;border-left:solid #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:solid #999999 0.4pt;border-bottom:solid #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-family:돋움;font-weight:bold">' + ( resolveIndex + 1 ) + '</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td colspan="6" valign="middle" bgcolor="#f2f2f2" style="width:506;height:17;border-left:solid #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:solid #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-family:돋움;font-weight:bold">결의내역</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '		</tr> \n';
		// 	resolveRowCount++;
		// 	documentContents += '		<tr> \n';
		// 	documentContents += '			<td valign="middle" bgcolor="#f2f2f2" style="width:80;height:17;border-left:solid #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-family:돋움;letter-spacing:-10%;font-weight:bold">증빙일자</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td valign="middle" bgcolor="#f2f2f2" style="width:110;height:17;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-family:돋움;letter-spacing:-10%;font-weight:bold">국고보조사업</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td valign="middle" bgcolor="#f2f2f2" style="width:80;height:17;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-family:돋움;letter-spacing:-10%;font-weight:bold">증빙구분</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td valign="middle" bgcolor="#f2f2f2" style="width:106;height:17;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-family:돋움;letter-spacing:-10%;font-weight:bold">증빙승인번호</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td colspan="2" valign="middle" bgcolor="#f2f2f2" style="width:130;height:17;border-left:dotted #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-family:돋움;letter-spacing:-10%;font-weight:bold">집행용도</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '		</tr> \n';
		// 	resolveRowCount++;
		// 	documentContents += '		<tr> \n';
		// 	documentContents += '			<td valign="middle" style="width:80;height:35;border-left:solid #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( resolveItem.anguEtaxTaxIssueDate || '' ) + '</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td valign="middle" style="width:110;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( resolveItem.anguBusinessName || '' ) + '</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td valign="middle" style="width:80;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( resolveItem.anguAuthDivName || '' ) + '</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td valign="middle" style="width:106;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( resolveItem.anguEtaxTaxNum || '' ) + '</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '			<td colspan="2" valign="middle" style="width:130;height:35;border-left:dotted #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 	documentContents += '				<p class="HStyle0" style="text-align:center;"> \n';
		// 	documentContents += '					<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( resolveItem.anguNote || '' ) + '</span> \n';
		// 	documentContents += '				</p> \n';
		// 	documentContents += '			</td> \n';
		// 	documentContents += '		</tr> \n';
		// 	resolveRowCount++;
		// 	$.each ( anguInputInfo.auth, function ( authIndex, authItem ) {
		// 		if ( resolveItem.dSeq === authItem.dSeq ) {
		// 			documentContents += '			<tr> \n';
		// 			documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:80;height:35;border-left:solid #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">거래처구분</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:110;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">거래처명</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:80;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">금융기관</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:106;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">입금계좌번호</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td colspan="2" valign="middle" bgcolor="#f2f2f2" style="width:130;height:35;border-left:dotted #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">통장표시내용</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">(보조금/거래처)</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '			</tr> \n';
		// 			resolveRowCount++;
		// 			documentContents += '			<tr> \n';
		// 			documentContents += '				<td valign="middle" style="width:80;height:35;border-left:solid #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( authItem.anguPartnerDivName || '' ) + '</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td valign="middle" style="width:110;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( authItem.anguEtaxTaxPartnerName || '' ) + '</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td valign="middle" style="width:80;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( authItem.BANK_NM || '' ) + '</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td valign="middle" style="width:106;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( authItem.BCNC_ACNUT_NO || '' ) + '</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '				<td colspan="2" valign="middle" style="width:130;height:35;border-left:dotted #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( authItem.BOJO_RMK || '' ) + '</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 			documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">/ ' + ( authItem.TR_RMK || '' ) + '</span> \n';
		// 			documentContents += '					</p> \n';
		// 			documentContents += '				</td> \n';
		// 			documentContents += '			</tr> \n';
		// 			resolveRowCount++;
		// 			$.each ( anguInputInfo.bimok, function ( bimokIndex, bimokItem ) {
		// 				if ( resolveItem.dSeq === bimokItem.dSeq ) {
		// 					documentContents += '			<tr> \n';
		// 					documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:80;height:16;border-left:solid #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">보조비목세목</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:110;height:16;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">재원구분</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:80;height:16;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">프로젝트</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:106;height:16;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">예산과목</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:65;height:16;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">공급가액</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '				<td valign="middle" bgcolor="#f2f2f2" style="width:65;height:16;border-left:dotted #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">부가세</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '			</tr> \n';
		// 					resolveRowCount++;
		// 					var jaewonSumAmt = 0;
		// 					$.each ( anguInputInfo.jaewon, function ( jaewonIndex, jaewonItem ) {
		// 						if ( bimokItem.dSeq === jaewonItem.dSeq ) {
		// 							if ( bimokItem.bSeq === jaewonItem.bSeq ) {
		// 								documentContents += '			<tr> \n';
		// 								documentContents += '				<td valign="middle" style="width:80;height:35;border-left:solid #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 								documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 								documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( bimokItem.subBimokName || '' ) + '-' + ( bimokItem.subDetailBimokName || '' ) + '</span> \n';
		// 								documentContents += '					</p> \n';
		// 								documentContents += '				</td> \n';
		// 								documentContents += '				<td valign="middle" style="width:110;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 								documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 								documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( jaewonItem.anguJaewonDivName || '' ) + '</span> \n';
		// 								documentContents += '					</p> \n';
		// 								documentContents += '				</td> \n';
		// 								documentContents += '				<td valign="middle" style="width:80;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 								documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 								documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( jaewonItem.pjtName || '' ) + '</span> \n';
		// 								documentContents += '					</p> \n';
		// 								documentContents += '				</td> \n';
		// 								documentContents += '				<td valign="middle" style="width:106;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 								documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 								documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( jaewonItem.BGT_NM || '' ) + '</span> \n';
		// 								documentContents += '					</p> \n';
		// 								documentContents += '				</td> \n';
		// 								documentContents += '				<td valign="middle" style="width:65;height:35;border-left:dotted #999999 0.4pt;border-right:dotted #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 								documentContents += '					<p class="HStyle0" style="text-align:right;"> \n';
		// 								documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( ( jaewonItem.anguInputAmount || '0' ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) ) + '</span> \n';
		// 								documentContents += '					</p> \n';
		// 								documentContents += '				</td> \n';
		// 								documentContents += '				<td valign="middle" style="width:65;height:35;border-left:dotted #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:dotted #999999 0.4pt;border-bottom:dotted #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 								documentContents += '					<p class="HStyle0" style="text-align:right;"> \n';
		// 								documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;line-height:160%">' + ( ( jaewonItem.anguInputVatAmount || '0' ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) ) + '</span> \n';
		// 								documentContents += '					</p> \n';
		// 								documentContents += '				</td> \n';
		// 								documentContents += '			</tr> \n';
		// 								resolveRowCount++;
		// 								jaewonSumAmt = Number ( ( jaewonSumAmt || 0 ) ) + Number ( ( jaewonItem.anguInputReqSumAmount || 0 ) );
		// 							}
		// 						}
		// 					} );
		// 					documentContents += '			<tr> \n';
		// 					documentContents += '				<td colspan="4" valign="middle" bgcolor="#f2f2f2" style="width:376;height:16;border-left:solid #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:solid #999999 0.4pt;border-bottom:solid #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:center;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">합&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 계</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '				<td colspan="2" valign="middle" bgcolor="#f2f2f2" style="width:130;height:16;border-left:solid #999999 0.4pt;border-right:solid #999999 0.4pt;border-top:solid #999999 0.4pt;border-bottom:solid #999999 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt"> \n';
		// 					documentContents += '					<p class="HStyle0" style="text-align:right;"> \n';
		// 					documentContents += '						<span style="font-size:9.0pt;font-family:돋움;letter-spacing:-10%;font-weight:bold;line-height:160%">' + ( jaewonSumAmt.toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, "," ) ) + '</span> \n';
		// 					documentContents += '					</p> \n';
		// 					documentContents += '				</td> \n';
		// 					documentContents += '			</tr> \n';
		// 					resolveRowCount++;
		// 				}
		// 			} );
		// 		}
		// 	} );

		// 	documentContents += '	</table> \n';
		// 	documentContents += '</p> \n';
		// 	documentContents = documentContents.replace ( '_resolvRowSpan_', resolveRowCount );
		// } );

		// return documentContents;
	}
	/* 국고보조통합시스템 - 문서 이동 */
	function fnSetMoveDocument ( documentContents ) {
		var param = {};
		param.processId = "ANGUI";
		param.approKey = "ANGUI_EX_" + '${ViewBag.aData.anbojoSeq}';
		param.docTitle = "";
		param.interlockUrl = "";
		param.interlockName = "";
	 	// 20180910 soyoung, interlockName 이전단계 영문/일문/중문 추가
	 	param.interlockNameEn = "";
	 	param.interlockNameJp = "";
	 	param.interlockNameCn = "";
		param.docSeq = "0";
		param.formSeq = '${ViewBag.aData.formSeq}';
		param.docContents = documentContents;
		param.preUrl = [ location.protocol, '//', location.hostname, ':', location.port ].join ( '' );
		param.selectSql = 'Y';

		$.ajax ( {
			url: param.preUrl + '/exp/ApprovalDocMake.do',
			async: true,
			type: "post",
			data: param,
			datatype: "json",
			success: function ( result ) {
				if ( result.result.resultCode == 'SUCCESS' ) {
					var data = result.result;

					if ( data.docSeq != '-1' && data.eaType != '' && data.formSeq != '0' && data.approKey != '' ) {
						popupAutoResize ( );
						/* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
						/* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
						/* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
						var url = '';
						url = '/ea/ea/interface/eadocpop.do?form_id=' + data.formSeq + '&docId=' + data.docSeq + '&approKey=' + data.approKey + '&processId=ANGUI';
						var thisX = parseInt ( document.body.scrollWidth );
						var thisY = parseInt ( document.body.scrollHeight );
						var maxThisX = screen.width - 50;
						var maxThisY = screen.height - 50;

						if ( maxThisX > 1000 ) {
							maxThisX = 1000;
						}
						var marginY = 0;
						// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
						if ( navigator.userAgent.indexOf ( "MSIE 6" ) > 0 ) marginY = 45; // IE 6.x
						else if ( navigator.userAgent.indexOf ( "MSIE 7" ) > 0 ) marginY = 75; // IE 7.x
						else if ( navigator.userAgent.indexOf ( "Firefox" ) > 0 ) marginY = 50; // FF
						else if ( navigator.userAgent.indexOf ( "Opera" ) > 0 ) marginY = 30; // Opera
						else if ( navigator.userAgent.indexOf ( "Netscape" ) > 0 ) marginY = -2; // Netscape

						if ( thisX > maxThisX ) {
							window.document.body.scroll = "yes";
							thisX = maxThisX;
						}
						if ( thisY > maxThisY - marginY ) {
							window.document.body.scroll = "yes";
							thisX += 19;
							thisY = maxThisY - marginY;
						}

						// 센터 정렬
						var windowX = ( screen.width - ( maxThisX + 10 ) ) / 2;
						var windowY = ( screen.height - ( maxThisY ) ) / 2 - 20;

						var win = window.open ( url, '', "scrollbars=yes,resizable=yes,width=" + maxThisX + ",height=" + ( maxThisY - 50 ) + ",top=" + windowY + ",left=" + windowX );
						if ( win == null || win.screenLeft == 0 ) {
							alert ( "브라우져 팝업차단 설정을 확인해 주세요." );
						} else {
							self.close ( );
						}
					} else {
						alert ( "전자결재 문서 생성 중 오류가 발생하였습니다." );
						return;
					}
				} else {
					alert ( '결재문서 생성중 오류가 발생되었습니다. 다시 시도해주세요.' );
				}
			}
		} );
	}
	
	function popupAutoResize() {
	    var thisX = parseInt(document.body.scrollWidth);
	    var thisY = parseInt(document.body.scrollHeight);
	    var maxThisX = screen.width - 50;
	    var maxThisY = screen.height - 50;

	    if (maxThisX > 1000) {
	        maxThisX = 1000;
	    }
	    var marginY = 0;
	    // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
	    if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45; // IE 6.x
	    else if (navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75; // IE 7.x
	    else if (navigator.userAgent.indexOf("Firefox") > 0) marginY = 50; // FF
	    else if (navigator.userAgent.indexOf("Opera") > 0) marginY = 30; // Opera
	    else if (navigator.userAgent.indexOf("Netscape") > 0) marginY = -2; // Netscape

	    if (thisX > maxThisX) {
	        window.document.body.scroll = "yes";
	        thisX = maxThisX;
	    }
	    if (thisY > maxThisY - marginY) {
	        window.document.body.scroll = "yes";
	        thisX += 19;
	        thisY = maxThisY - marginY;
	    }

	    // 센터 정렬
	    var windowX = (screen.width - (maxThisX + 10)) / 2;
	    var windowY = (screen.height - (maxThisY)) / 2 - 20;
	    window.moveTo(windowX, windowY);
	    window.resizeTo(maxThisX, maxThisY);
	}
	/* ## [-] [ 전자결재 연동 ] ## */
</script>

<div class="pop_wrap brbn">
	<div class="sub_wrap">
		<div id="divCodeLayer"></div>
		<div class="pop_sign_head posi_re">
			<h1>e나라도움 결의정보등록</h1>
			<div class="psh_btnbox">
				<!-- 양식팝업 오른쪽 버튼그룹 -->
				<div class="psh_right">
					<div class="btn_cen mt8">
						<input type="button" id="btnApproval" class="psh_btn" value="결재상신" />
					</div>
				</div>
			</div>
		</div>
		<div class="pop_con posi_re pb50">
			<div class="top_box ovh">
				<dl style="min-width: 980px;">
					<dt>회계단위</dt>
					<dd style="width: 25%;">
						<input type="text" id="txtErpBizName" style="width: 90%;" disabled="disabled" />
						<!--<a href="#" class="btn_search"></a>-->
					</dd>
					<dt>결의부서 / 작성자</dt>
					<dd style="width: 25%;">
						<input type="text" id="txtErpDeptEmpName" style="width: 90%;" disabled="disabled" />
						<!--<a href="#" class="btn_search"></a>-->
					</dd>
					<dt>작성일</dt>
					<dd>
						<input id="txtGisuDate" class="dpWid" />
					</dd>
				</dl>
			</div>
			<!-- 결의내역 ------------------------------------------------------------------------------------------------------------------------->
			<div class="clear">
				<p class="tit_p mt20 fl">결의내역</p>
				<div class="controll_btn pt15 fr">
					<button id="btnAddResolRow">추가</button>
					<button id="btnRemoveResolRow">삭제</button>
				</div>
			</div>
			<!-- 결의내역 테이블 -->
			<div id="resolveContent"></div>
			<!-- 증빙내역 ------------------------------------------------------------------------------------------------------------------------->
			<div class="clear">
				<p class="tit_p mt20 fl">증빙내역</p>
			</div>
			<!-- 증빙내역 테이블 -->
			<div id="authContent"></div>
			<!-- 비목내역 ------------------------------------------------------------------------------------------------------------------------->
			<div class="clear">
				<p class="tit_p mt20 fl">비목내역</p>
				<div class="controll_btn pt15 fr">
					<button id="btnAddBimokRow">추가</button>
					<button id="btnRemoveBimokRow" style="display: none;">삭제</button>
				</div>
			</div>
			<!-- 비목내역 테이블 -->
			<div id="bimokContent"></div>
			<!-- 재원내역 ------------------------------------------------------------------------------------------------------------------------->
			<div class="clear">
				<p class="tit_p mt20 fl">재원내역</p>

				<div class="controll_btn pt15 fr">
					<input type="button" id="btnAddJaewonRow" value="추가" class="ml2" /> <input type="button" id="btnPerPayPop" value="인력정보등록" class="ml2" />
					<button id="btnRemoveJaewonRow" style="display: none;">삭제</button>
				</div>
			</div>
			<!-- 재원내역 테이블 -->
			<div id="jaewonContent"></div>
			<!-- 재원내역 하단box -->
			<div id="" class="bg_lightgray" style="margin-top: 16px !important;">
				<div class="twinbox">
					<table style="min-height: 100px;">
						<colgroup>
							<col width="50%" />
							<col />
						</colgroup>
						<tr>
							<td class="twinbox_td">
								<!-- <div class="clear"> --> <!-- <span class="fl mt5 mr5">증빙공급가</span> <input id="txtAuthAmt" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 mr5 ml20">등록공급가</span> <input id="txtAppAmt" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> --> <!-- </div> --> <!-- <div class="clear mt10"> --> <!-- <span class="fl mt5 mr5">증빙부가세</span> <input id="txtAuthVat" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 mr5 ml20">등록부가세</span> <input id="txtAppVat" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> --> <!-- </div> --> <!-- <div class="clear mt10"> --> <!-- <span class="fl mt5 mr5">증빙총금액</span> <input id="txtAuthTotalAmt" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> --> <!-- </div> -->
							</td>
							<td class="twinbox_td">
								<div class="clear">
									<span class="fl mt5 mr5">계획금액</span> <input id="txtPlanAmount" type="text" id="" class="fl ar pr5" disabled="disabled" style="width: 100px;" />
								</div>

								<div class="clear mt10">
									<span class="fl mt5 mr5">집행금액</span> <input type="text" id="txtSumAmount" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 ml20" style="width: 110px;">E나라도움 집행금액</span> <input type="text" id="txtExcutAmount" class="fl ar pr5" disabled="disabled" style="width: 100px;" /><span id="lblExcutAmount" class="fl mt5 ml20 ar" style="width: 100px;"></span>
								</div>

								<div class="clear mt10">
									<span class="fl mt5 mr5">집행잔액</span> <input type="text" id="txtSubAmount" class="fl ar pr5" disabled="disabled" style="width: 100px;" /> <span class="fl mt5 ml20" style="width: 110px;">미등록 집행금액</span> <input type="text" id="txtReqSumAmount" class="fl ar pr5" disabled="disabled" style="width: 100px;" /><span id="lblReqSumAmount" class="fl mt5 ml20 ar" style="width: 100px;"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>


		</div>
		<!--// pop_con -->
	</div>
	<!--// pop_wrap -->
	<!-- 입력팁 -->
	<div class="toolTipBox">
		<span id="spanToolTipTxt">-</span>
	</div>
	<!-- 코드도움팝업 -->
	<div id="divCodeHelperPop" class='divTopPopup' style="display: none">
		<div class="modal posi_fix" style="z-index: 101"></div>
		<div class="pop_wrap_dir posi_ab" style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 102">
			<div class="pop_head">
				<h1>코드도움</h1>
				<a href="javascript:fnPopClose()" class="clo"> <img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
			</div>
			<div class="pop_con">
				<div class="top_box">
					<dl>
						<dt>검색</dt>
						<dd class="mr0" style="width: 85%;">
							<input type="text" id="txtCodeSearch" class="UCSearch" style="width: 85%; text-indent: 4px;" /> <input type="button" id="searchButton" value="검색" />
						</dd>
					</dl>
				</div>
				<div id='divCodePopLayer'></div>
			</div>
		</div>
	</div>
	<!-- 전자세금 계산서 코드도움팝업 -->
	<div id="divTaxCodeHelperPop" class='divTopPopup' style="display: none">
		<div class="modal posi_fix" style="z-index: 101"></div>

		<div class="pop_wrap_dir posi_ab" style="width: 800px; height: 607px; top: 50%; left: 50%; margin: -303px 0 0 -400px; z-index: 102">
			<div class="pop_head">
				<h1>전자세금계산서 자료조회</h1>
				<a href="javascript:fnTaxPopClose()" class="clo"> <img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
			</div>

			<div class="pop_con">
				<div id="divTaxCodeSelectZone" class="top_box">
					<dl>
						<dl>
							<dd class="ml20" style="width: 150px;">
								<select id="selDTFG" class="selectmenu" style="width: 148px;">
									<option value="1" selected="selected">작성일자</option>
									<option value="2">발행일자</option>
								</select>
							</dd>
							<dd>
								<div class="dal_div">
									<input type="text" id="txtFRDT" value="2015-02-01" class="w113" />

								</div>
								~
								<div class="dal_div">
									<input type="text" id="txtTODT" value="2017-02-01" class="w113" />
								</div>
							</dd>
							<dt class="ar" style="width: 94px;">세무구분</dt>
							<dd style="width: 150px;">
								<select id="selTAXTY" class="selectmenu" style="width: 148px;">
									<option value="2" selected="selected">과세</option>
									<option value="4">면세</option>
								</select>
							</dd>

						</dl>

						<dl class="next2">
							<dt class="ar" style="width: 145px;">매입거래처</dt>
							<dd style="width: 250px;">
								<select id="selTRCD" class="selectmenu" style="width: 222px;">
									<!-- 									<option value="">전체</option> -->
									<!-- 									<option value="" selected="selected">000001 정주개발</option> -->
								</select> <a href="#" class="fl btn_search" onClick="fnGetETaxPater()"></a>
							</dd>
							<dt>세금계산서분류</dt>
							<dd style="width: 150px;">
								<select id="selETAXTY" class="selectmenu" style="width: 148px;">
									<option value="" selected="selected">전체</option>
									<option value="1">일반</option>
									<option value="2">수정</option>
								</select>
							</dd>
						</dl>
					</dl>
				</div>
				<div id='divTaxCodePopLayer'></div>

				<!-- 안내문구 -->
				<p class="text_blue f11 mt10">
					* <span id="Span1">조회한 전자세금계산서가 없는 경우, ERP에서 자료수집을 실행해 주세요.</span>
				</p>

			</div>
			<div class="pop_foot">
				<div class="btn_cen pt12">
					<input type="button" value="자료수집 요청" /> <input type="button" onClick="fnGetEtaxDtaAjax()" value="조회(F8)" />
					<!--                     <input type="button" value="확인" /> -->
					<!--                     <input type="button" class="gray_btn" value="취소" /> -->
				</div>
			</div>
			<!-- //pop_foot -->

		</div>
		<!-- 코드도움팝업 -->
		<div id="divTaxSubCodeHelperPop" class='divTopPopup' style="display: none">
			<div class="modal posi_fix" style="z-index: 103"></div>

			<div class="pop_wrap_dir posi_ab" style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 104">
				<div class="pop_head">
					<h1>코드도움</h1>
					<a href="javascript:fnSubPopClose();" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
				</div>

				<div class="pop_con">
					<div class="top_box">
						<dl>
							<dt>검색</dt>
							<dd class="mr0" style="width: 85%;">
								<input type="text" id="txtSubCodeSearch" class="subSearch" style="width: 85%; text-indent: 4px;" /> <input type="button" id="searchSubButton" value="검색" />
							</dd>
						</dl>
					</div>
					<div id='divTaxSubCodePopLayer'></div>

				</div>
			</div>
		</div>
	</div>
	<!-- 카드거래내역 코드도움팝업 -->
	<div id="divCardDealtHelperPop" class='divTopPopup' style="display: none">
		<div class="modal posi_fix" style="z-index: 101"></div>

		<div class="pop_wrap_dir posi_ab" style="width: 800px; height: 607px; top: 50%; left: 50%; margin: -303px 0 0 -400px; z-index: 102">
			<div class="pop_head">
				<h1>카드거래내역 자료조회</h1>
				<a href="javascript:fnCardDealPopClose()" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
			</div>

			<div class="pop_con">
				<div class="top_box" id="divCardDealSelectZone">
					<dl>
						<dl>
							<dt>카드거래일자</dt>
							<dd>
								<div class="dal_div">
									<input type="text" id="txtStDt" value="" class="w113" />
								</div>
								~
								<div class="dal_div">
									<input type="text" id='txEnDt' value="" class="w113" />
								</div>
							</dd>
							<dt class="ar" style="width: 60px;">신용카드</dt>
							<dd style="width: 290px;">
								<input class="input_search" id="txtCardName" type="text" value="" style="width: 256px;" readonly="readonly" /> <a href="javascript: fnGetCardInfo()" class="btn_search"></a>
							</dd>
						</dl>

						<dl class="next2">
							<dt class="ar" style="width: 78px;">총금액</dt>
							<dd style="width: 250px;">
								<input class="input_search" id="txtTotalAmt" type="text" value="" style="width: 245px;" />
							</dd>
							<dt class="ar" style="width: 58px;">가맹점명</dt>
							<dd style="width: 282px;">
								<input class="input_search" id="txtAffiliateName" type="text" value="" style="width: 280px;" />
							</dd>
						</dl>
					</dl>
				</div>

				<div id='divCardDealPopLayer'></div>

				<!-- 안내문구 -->

			</div>

			<div class="pop_foot">
				<div class="btn_cen pt12">
					<!--<input type="button" value="자료수집" />-->
					<input type="button" onClick="fnGetCardDealDataAjax()" value="조회(F8)" />
					<!--                     <input type="button" value="확인" /> -->
					<!--                     <input type="button" class="gray_btn" value="취소" /> -->
				</div>
			</div>
			<!-- //pop_foot -->

		</div>

		<!-- 코드도움팝업 -->
		<div id="divCardSubCodeHelperPop" class='divTopPopup' style="display: none">
			<div class="modal posi_fix" style="z-index: 103"></div>

			<div class="pop_wrap_dir posi_ab" style="width: 516px; height: 640px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 104">
				<div class="pop_head">
					<h1>코드도움</h1>
					<a href="javascript:fnSubCardPopClose()" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
				</div>

				<div class="pop_con">
					<div class="top_box">
						<dl>
							<dt>검색</dt>
							<dd class="mr0" style="width: 85%;">
								<input type="text" id="txtSubCardSearch" class="subCardSearch" style="width: 85%; text-indent: 4px;" /> <input type="button" id="searchSubCardButton" value="검색" />
							</dd>
						</dl>
					</div>
					<div id='divCardSubCodePopLayer'></div>

				</div>
			</div>
		</div>
	</div>

	<!-- 예산과목 조회 팝업  -->
	<div id="divBudgetAcctCodeHelperPop" class='divTopPopup' style="display: none">
		<!-- modal -->
		<div class="modal posi_fix" style="z-index: 101"></div>

		<div id="budgetListPop" class="pop_wrap_dir posi_ab" style="width: 800px; height: 715px; top: 50%; left: 50%; margin: -338px 0 0 -400px; z-index: 102">
			<div class="pop_head">
				<h1>예산과목 코드도움</h1>
				<a id="btnBudgetListLayerColse" href="#n" class="clo"><img src="<c:url value='/Images/btn/btn_pop_clo02.png'/>" alt=""></a>
			</div>

			<div class="pop_con">
				<!-- 테이블 -->
				<div id="divBudgetAcctCodePopLayer"></div>

				<!-- 부분검색 -->
				<div class="top_box mt10">
					<dl>
						<dl>
							<dt style="width: 110px;">부분검색</dt>
							<dt>예산과목명</dt>
							<dd style="width: 200px;">
								<input class="input_search" id="txtBudgetName" type="text" value="" style="width: 166px;" />
								<!--<a href="#" class="btn_search"></a>-->
							</dd>
							<dt>예산과목코드</dt>
							<dd style="width: 200px;">
								<input class="input_search" id="txtBudgetCode" type="text" value="" style="width: 166px;" />
								<!--<a href="#" class="btn_search"></a>-->
							</dd>
						</dl>

						<dl class="mt-20">
							<dt style="width: 120px;">예산과목표시</dt>
							<dd>
								<input type="radio" name="type1_radio" id="type1Radio1" value="1" class="ml10" checked=""> <label for="type1Radio1">모든 예산과목 표시</label> <input type="radio" name="type1_radio" id="type1Radio2" value="2" class="ml20"> <label for="type1Radio2">당기 예산편성된 과목만 표시</label> <input type="radio" name="type1_radio" id="type1Radio3" value="3" class="ml20"> <label for="type1Radio3">프로젝트기간 예산편성된 과목만 표시</label>
							</dd>
						</dl>

						<dl class="mt-20">
							<dt style="width: 120px;">사용기한</dt>
							<dd>
								<input type="radio" name="type2_radio" id="type2Radio1" value="1" class="ml10" checked=""> <label for="type2Radio1">모두표시</label> <input type="radio" name="type2_radio" id="type2Radio2" value="2" style="margin-left: 76px;"> <label for="type2Radio2">사용기한 경과분 숨김</label>
							</dd>
						</dl>

						<dl class="mt-20">
							<dt style="width: 120px;">상위과목표시</dt>
							<dd>
								<input type="radio" name="type3_radio" id="type3Radio1" value="1" class="ml10" checked=""> <label for="type3Radio1">모두표시</label> <input type="radio" name="type3_radio" id="type3Radio2" value="2" style="margin-left: 76px;"> <label for="type3Radio2">최하위 표시</label>
							</dd>
						</dl>

						<!-- <dl class="mt-20">
                            <dt style="width:120px;">예산그룹표시</dt>
                            <dd>
                                <input type="radio" name="type4_radio" id="type4Radio1" class="ml10" checked="">
                                <label for="type4Radio1">표시</label>
                                <input type="radio" name="type4_radio" id="type4Radio2" style="margin-left:100px;">
                                <label for="type4Radio2">숨김</label>
                            </dd>
                        </dl> -->
					</dl>
				</div>

			</div>
			<!--// pop_con -->

			<div class="pop_foot">
				<div class="btn_cen pt12">
					<input id="btnBudgetListSearch" type="button" value="검색(F8)" /> <input id="btnBudgetAccept" type="button" value="확인" />
					<!-- <input type="button" class="gray_btn" value="취소" /> -->
				</div>
			</div>
			<!-- //pop_foot -->
		</div>
	</div>
	<!--// pop_wrap -->
</div>
<!--// 카드거래내역 자료조회 팝업 -->