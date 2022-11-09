/* 국고보조 결의집행 변수 */
var headjson = '';
var dataJson = '';
// var domain = 'http://local.duzonnext.com:8080';
var domain = '';

/* 국고보조 결의집행 JSON 변수 */
var zl = {
	dlf: 'GISUDT',
	qjsgh: 'GISUSQ',
	tkdjqduseh: 'BSNSYEAR',
	wlrmqrnqns: 'PAYFG',
	rnrrhqhwhtkdjq: 'DDTLBZ',
	dlcprPwhkrnqns: 'TRANSFRACNUTSE',
	wkrPwhkdlcptkdbzhem: 'SBSACNTTRFRSN',
	wkrPwhkdlcptkdb: 'SBSACNTTRFRSNCN',
	wmdqldrnqns: 'PRUFSE',
	wmdqldtmddlsqjsgh: 'PRUFSENO',
	wmdqlddlfwk: 'EXCUTERQUST',
	wlqgoddydeh: 'EXCUTPRPOS',
	wmdqldchddor: '',
	wmdqldrhdrmqrk: '',
	wmdqldqnrktp: '',
	emdfhrrksmdrhdrmqrkdor: '',
	emdfhrrksmdqnrktpdor: '',
	rjfocjrnqns: 'BCNCSE',
	wmdqldzhem: 'TR',
	rjfocjaud: 'BCNCCMPNY',
	rmadbdrlrhks: 'BCNCBANK',
	dlqrmarPwhkqjsgh: 'BCNCACNUT',
	qhwhrmaxhdwkdvytlsodyd: 'SBSIDYBANKINDICT',
	rjfocjxhdwkdvytlsodyd: 'BCNCBNKBINDICT',
	rjfocjtkdjqwkwnalsqjsgh: 'BCNCLSFT',
	tkdjqwkdwnth: 'BCNCADRES',
	eovywkaud: 'BCNCRPRSNTV',
	wjsghkqjsgh: 'BCNCTELNO',
	qhwhqlahrtpahrzhem: 'ASSTNTAXITMCD',
	qhwhqlahraud: 'ASSTNEXPITM',
	qhwhtpahraud: 'ASSTNTAXITM',
	vnaahr: 'PRDLST',
	wodnjsrnqns: 'FNRSCSE',
	vmfhwprxm: 'MGT',
	dPtksrhkahr: 'ABGT',
	wodnjszhem: 'BTR',
	cnfrmarPwhk: 'BANB',
	wlqgodrmador: 'AMOUNT',
	rhdrmqrkdor: 'SPLPC',
	qnrktp: 'VAT',
	zkem: 'CARDTR',
	TOTALAMT: 'TOTALAMT'
}
/* 국고보조 결의집행 JSON 변수 - AJAX정의 */
var codeListParam = {
	GetCode: function ( codeKey ) {
		var result;
		if ( this [ codeKey ] != undefined ) {
			var passElem = [ '|', 'selDTFG', 'selTAXTY', 'selETAXTY', 'selTRCD', 'txtTODT', 'txtFRDT', 'txtStDt', 'txEnDt', 'txtCardName', 'txtTotalAmt', 'txtAffiliateName', '|' ].join ( '|' );
			if ( passElem.indexOf ( [ '|', ( document.activeElement == null ? '' : document.activeElement.id ), '|' ].join ( '' ) ) < 0 ) {
				/* 예외케이스 발생.. */
				if ( document.activeElement.id != 'searchButton' 
					&& document.activeElement.id != 'searchSubButton') {
					if ( document.activeElement.id != '' && $ ( 'input.focus' ).attr ( 'id' ) != document.activeElement.id ) {
						result = [ ];
						return result;
					}
				}
			}
			if ( this [ codeKey ] [ 'sourceUrl' ] != undefined ) {
				switch ( codeKey ) {
					case zl.rnrrhqhwhtkdjq:
					case zl.wmdqldtmddlsqjsgh:
					case zl.qhwhqlahrtpahrzhem:
					case zl.wodnjsrnqns:
					case zl.vmfhwprxm:
					case zl.dPtksrhkahr:
					case zl.TOTALAMT:
						this [ codeKey ] [ 'data' ] = [ ];
						break;
				}

				if ( this [ codeKey ] [ 'data' ] && this [ codeKey ] [ 'data' ].length > 0 ) {
					result = this [ codeKey ] [ 'data' ];
				} else {
					var ajaxParam = {};
					ajaxParam.url = codeListParam [ codeKey ] [ 'sourceUrl' ] || '';
					ajaxParam.parameters = {};
					ajaxParam.parameters = codeListParam [ codeKey ] [ 'getParam' ] ( ) || {};

					if ( codeKey == 'TR' ) {
						if ( !ajaxParam.parameters.searchStr ) {
							result = [ ];
							return result;
						} else if ( ajaxParam.parameters.searchStr == "''" || ajaxParam.parameters.searchStr == "" ) {
							result = [ ];
							return result;
						}
					}

					if ( ajaxParam.url != '' ) {
						$.ajax ( {
							async: false,
							type: "post",
							data: ajaxParam.parameters,
							url: ajaxParam.url,
							datatype: "json",
							success: function ( resultValue ) {
								switch ( codeKey ) {
									case 'TOTALAMT':
										result = resultValue.result.aData;
										break;
									default:
										result = resultValue.result.aaData;
										break;
								}
							},
							error: function ( err ) {
								console.log ( err );
							}
						} );
					}

					this [ codeKey ] [ 'data' ] = result;
				}
			} else {
				result = this [ codeKey ];
			}
		} else {
			result = [ ];
		}
		return result;
	},
	/* 국고보조사업 */
	DDTLBZ: {
		sourceUrl: domain + '/exp/expend/angu/DdtlbzInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.BSNSYEAR = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'BSNSYEAR' ] [ 'BSNSYEAR' ] || '';
			return params;
		},
		data: [ ]
	},
	/* 이체계좌구분 */
	TRANSFRACNUTSE: {
		sourceUrl: domain + '/exp/expend/angu/TransfracnutseInfoS.do',
		getParam: function ( ) {
			var params = {};
			return params; /* 파라미터 없음 */
		},
		data: [ ]
	},
	/* 자계좌이체사유코드 */
	SBSACNTTRFRSN: {
		sourceUrl: domain + '/exp/expend/angu/SbsacnttrfrsnInfoS.do',
		getParam: function ( ) {
			var params = {};
			return params; /* 파라미터 없음 */
		},
		data: [ ]
	},
	/* 증빙승인번호 - 카드 */
	CARDTR: {
		sourceUrl: domain + '/exp/expend/angu/CardInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.DDTLBZ_ID = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'DDTLBZ' ] [ 'ddtlbzCode' ] || '';
			params.prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'PRUFSE' ] [ 'prufseCode' ] || '';
			return params;
		}
	},
	/* 증빙승인번호 */
	PRUFSENO: {
		sourceUrl: domain + '/exp/expend/angu/PrufsenoInfoS.do',
		getParam: function ( ) {
			var prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';
			var params = {};
			params.prufseCode = prufseCode;
			params.DDTLBZ_ID = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'DDTLBZ' ] [ 'ddtlbzCode' ] || '';
			params.TASC_CMMN_DETAIL_CODE_NM = '001';
			switch ( prufseCode ) {
				case '001':
				case '002':
					params.DT_FG = $ ( '#selDTFG' ).val ( ); /* 작성일자, 발행일자 구분 */
					params.FR_DT = $ ( '#txtFRDT' ).val ( ).toString ( ).replace ( /-/g, '' ); /* 일자 검색 시작일 */
					params.TO_DT = $ ( '#txtTODT' ).val ( ).toString ( ).replace ( /-/g, '' ); /* 일자 검색 종료일 */
					params.TAX_TY = $ ( '#selTAXTY' ).val ( ); /* 세무구분 */
					params.ETAX_TY = $ ( '#selETAXTY' ).val ( ); /* 세금계산서분류 */
					params.TR_CD = $ ( '#selTRCD' ).val ( ) + '|'; /* 매입거래처 */
					break;
				case '004':
					params.CONFM_DE_FR = $ ( '#txtStDt' ).val ( ).toString ( ).replace ( /-/g, '' ); /* 카드거래일자 검색 시작일 */
					params.CONFM_DE_TO = $ ( '#txEnDt' ).val ( ).toString ( ).replace ( /-/g, '' ); /* 카드거래일자 검색 종료일 */
					if ( $ ( '#txtCardName' ).data ( 'CardName' ) ) {
						params.CARD_NO = $ ( '#txtCardName' ).data ( 'CardName' ).baNumber || ''; /* 카드번호 */
					} else {
						params.CARD_NO = '';
					}
					params.MRHST_NM = $ ( '#txtAffiliateName' ).val ( ); /* 가맹점명 */
					params.PUCHAS_TAMT = $ ( '#txtTotalAmt' ).val ( ).toString ( ).replace ( /,/g, '' ) || '0'; /* 총금액 */
					params.DDTLBZ_ID = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'DDTLBZ' ] [ 'ddtlbzCode' ] || '';
					params.TASC_CMMN_DETAIL_CODE_NM = '001'
					break;
			}
			return params;
		}
	},
	/* 코드 */
	TR: {
		sourceUrl: domain + '/exp/expend/angu/TrInfoS.do',
		getParam: function ( ) {
			var params = {};
			if($('#divTaxSubCodeHelperPop').css('display') == 'block'
				|| $('#divTaxSubCodeHelperPop').css('display') == ''){
				params.searchStr = ( $ ( '#txtSubCodeSearch' ).val ( ) || '' );
			} else {
				params.searchStr = ( $ ( '#txtCodeSearch' ).val ( ) || '' );
			}
			return params; /* 파라미터 없음 */
		},
		data: [ ]
	},
	/* 금융기관 */
	BCNCBANK: {
		sourceUrl: domain + '/exp/expend/angu/BcncbankInfoS.do',
		getParam: function ( ) {
			var params = {};
			return params; /* 파라미터 없음 */
		},
		data: [ ]
	},
	/* 보조비목세목코드 */
	ASSTNTAXITMCD: {
		sourceUrl: domain + '/exp/expend/angu/AsstntaxitmInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.DDTLBZ_ID = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'DDTLBZ' ] [ 'ddtlbzCode' ] || '';
			params.BSNSYEAR = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'BSNSYEAR' ] [ 'BSNSYEAR' ] || '';
			params.FSYR = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'BSNSYEAR' ] [ 'BSNSYEAR' ] || '';
			return params;
		}
	},
	/* 재원구분 */
	FNRSCSE: {
		sourceUrl: domain + '/exp/expend/angu/FnrscseInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.DDTLBZ_ID = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'DDTLBZ' ] [ 'ddtlbzCode' ] || '';
			params.BSNSYEAR = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'BSNSYEAR' ] [ 'BSNSYEAR' ] || '';
			params.ASSTN_TAXITM_CODE = anbojoValue [ "bimok" ] [ [ seq.selMSeq, seq.selLSeq, seq.selSSeq ].join ( '|' ) ] [ "ASSTNTAXITMCD" ] [ "asstnExpitmTaxitmCode" ] || '';
			return params;
		}
	},
	/* 프로젝트 */
	MGT: {
		sourceUrl: domain + '/exp/expend/angu/MgtInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.DDTLBZ_ID = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'DDTLBZ' ] [ 'ddtlbzCode' ] || '';
			return params;
		}
	},
	/* 예산과목 레벨 */
	ABGTLEVEL: {
		sourceUrl: domain + '/exp/expend/angu/AbgtLevelInfoS.do',
		getParam: function ( ) {
			var params = {};
			return params; /* 파라미터 없음 */
		},
		data: [ ]
	},
	/* 예산과목 */
	ABGT: {
		sourceUrl: domain + '/exp/expend/angu/AbgtInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.BSNSYEAR = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'BSNSYEAR' ] [ 'BSNSYEAR' ] || '';
			params.ASSTN_TAXITM_CODE = anbojoValue [ "bimok" ] [ [ seq.selMSeq, seq.selLSeq, seq.selSSeq ].join ( '|' ) ] [ "ASSTNTAXITMCD" ] [ "asstnExpitmTaxitmCode" ] || '';
			params.GISU = empInfo.erpCompGisu || '0';
			params.FR_DT = empInfo.erpCompFrDate || '';
			params.TO_DT = empInfo.erpCompToDate || '';
			params.GR_FG = '2';
			params.DIV_CDS = '';
			params.MGT_CDS = '';
			params.BOTTOM_CDS = '';
			params.OPT_01 = budgetInfoSerchInfo.searchType1;
			params.OPT_02 = budgetInfoSerchInfo.searchType2;
			params.OPT_03 = budgetInfoSerchInfo.searchType3;
			params.BGT_FR_DT = empInfo.erpCompFrDate || '';
			params.GROUP_CD = '';
			params.BGT_NM = budgetInfoSerchInfo.searchBudgetName;
			params.BGT_CD = budgetInfoSerchInfo.searchBudgetName;
			return params;
		}
	},
	/* 사원코드 */
	PERCODE: {
		baseDate: '',
		sourceUrl: domain + '/exp/expend/angu/HpmeticInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.BASE_DT = this.baseDate || '';
			return params;
		}
	},
	/* 코드 */
	BTR: {
		sourceUrl: domain + '/exp/expend/angu/BtrInfoS.do',
		getParam: function ( ) {
			var params = {};
			return params; /* 파라미터 없음 */
		},
		data: [ ]
	},
	/* 지급구분 */
	PAYFG: [ {
		payFgCode: '1',
		payFgName: '일반'
	}, {
		payFgCode: '2',
		payFgName: '인건비성'
	} ],
	/* 증빙구분 */
	PRUFSE: [ {
		prufseCode: "001",
		prufseName: "전자세금계산서"
	}, {
		prufseCode: "002",
		prufseName: "전자계산서"
	}, {
		prufseCode: "004",
		prufseName: "카드"
	}, {
		prufseCode: "999",
		prufseName: "기타"
	} ],
	/* 거래처구분 */
	BCNCSE: [ {
		bcncseCode: '001',
		bcncseName: '법인거래'
	}, {
		bcncseCode: '002',
		bcncseName: '개인사업자'
	}, {
		bcncseCode: '003',
		bcncseName: '개인거래'
	} ],
	/* 금액집계 */
	TOTALAMT: {
		sourceUrl: domain + '/exp/expend/angu/AmountInfoS.do',
		getParam: function ( ) {
			var params = {};
			params.BSNSYEAR = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'BSNSYEAR' ] [ 'BSNSYEAR' ] || '';
			params.DDTLBZ_ID = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ 'DDTLBZ' ] [ 'ddtlbzCode' ] || '';
			params.ASSTN_TAXITM_CODE = anbojoValue [ "bimok" ] [ [ seq.selMSeq, seq.selLSeq, seq.selSSeq ].join ( '|' ) ] [ "ASSTNTAXITMCD" ] [ "asstnExpitmTaxitmCode" ] || '';
			params.FNRSC_SE_CODE = anbojoValue [ 'jaewon' ] [ [ seq.selMSeq, seq.selLSeq, seq.selSSeq, seq.selDSeq ].join ( '|' ) ] [ 'FNRSCSE' ] [ 'fnrscseDCode' ] || ''; /* 재원구분 */
			return params;
		}
	}
};
/* 국고보조 결의집행 JSON 변수 - 코드테이블 */
var codeTableHead = {
	GetHead: function ( headKey ) {
		headjson = this [ headKey ];
	},
	/* 지급구분 */
	PAYFG: [ {
		no: '0',
		displayClass: '',
		titleName: '지급구분코드',
		id: 'payFgCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '지급구분명칭',
		id: 'payFgName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 국고보조사업 */
	DDTLBZ: [ {
		no: '0',
		displayClass: '',
		titleName: '상세사업내역코드',
		id: 'ddtlbzCode',
		width: '50px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '상세사업내역명',
		id: 'ddtlbzName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 이쳬계좌구분 */
	TRANSFRACNUTSE: [ {
		no: '0',
		displayClass: 'loseSight',
		titleName: 'transFracnutSeCode',
		id: 'transFracnutSeCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '공통코드',
		id: 'transFracnutSeMCode',
		width: '50px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '공통코드명',
		id: 'transFracnutSeMName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '공통상세코드',
		id: 'transFracnutSeDCode',
		width: '50px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: '',
		titleName: '공통상세코드명',
		id: 'transFracnutSeDName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 자계좌이체사유코드 */
	SBSACNTTRFRSN: [ {
		no: '0',
		displayClass: 'loseSight',
		titleName: 'sbsAcnttrfrSnCode',
		id: 'sbsAcnttrfrSnCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '공통코드',
		id: 'sbsAcnttrfrSnMCode',
		width: '50px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '공통코드명',
		id: 'sbsAcnttrfrSnMName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '공통상세코드',
		id: 'sbsAcnttrfrSnDCode',
		width: '50px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: '',
		titleName: '공통상세코드명',
		id: 'sbsAcnttrfrSnDName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 증빙구분 */
	PRUFSE: [ {
		no: '0',
		displayClass: '',
		titleName: '증빙구분코드',
		id: 'prufseCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '증빙구분명칭',
		id: 'prufseName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 증빙승인번호 - 카드 */
	CARDTR: [ {
		no: '0',
		displayClass: '',
		titleName: '카드코드',
		id: 'ctrCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '0',
		displayClass: '',
		titleName: '카드명칭',
		id: 'trName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '0',
		displayClass: 'loseSight',
		titleName: '분류',
		id: 'baNumber',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 증빙승인번호 */
	PRUFSENO: [ {
		no: '0',
		displayClass: '',
		titleName: '분류',
		id: 'eTaxTypeName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '작성일자',
		id: 'issData',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '발급일자',
		id: 'isuDate',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '거래처명',
		id: 'trName',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: '',
		titleName: '거래처사업번호',
		id: 'trRegNumber',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '5',
		displayClass: '',
		titleName: '공급가액',
		id: 'supAmount',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '6',
		displayClass: '',
		titleName: '부가세',
		id: 'vatAmount',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '7',
		displayClass: '',
		titleName: '합계액',
		id: 'sumAmount',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '8',
		displayClass: '',
		titleName: '전자세금계산서승인번호',
		id: 'issNumber',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '9',
		displayClass: '',
		titleName: '기사용금액',
		id: 'excutSumAmount',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '10',
		displayClass: '',
		titleName: '등록가능금액',
		id: 'amount',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '11',
		displayClass: 'loseSight',
		titleName: 'erpCompSeq',
		id: 'erpCompSeq',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '12',
		displayClass: 'loseSight',
		titleName: 'erpBizSeq',
		id: 'erpBizSeq',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '13',
		displayClass: 'loseSight',
		titleName: 'erpBizName',
		id: 'erpBizName',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '14',
		displayClass: 'loseSight',
		titleName: 'taxType',
		id: 'taxType',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '15',
		displayClass: 'loseSight',
		titleName: 'bizCeoName',
		id: 'bizCeoName',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '16',
		displayClass: 'loseSight',
		titleName: 'trCode',
		id: 'trCode',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '17',
		displayClass: 'loseSight',
		titleName: 'bcncCmpnayName',
		id: 'bcncCmpnayName',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '18',
		displayClass: 'loseSight',
		titleName: 'duzonBankCode',
		id: 'duzonBankCode',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '19',
		displayClass: 'loseSight',
		titleName: 'bcncAcnutNo',
		id: 'bcncAcnutNo',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '20',
		displayClass: 'loseSight',
		titleName: 'bcncAddress',
		id: 'bcncAddress',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '21',
		displayClass: 'loseSight',
		titleName: 'bcncRprsntyName',
		id: 'bcncRprsntyName',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '22',
		displayClass: 'loseSight',
		titleName: 'bcncTelNo',
		id: 'bcncTelNo',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '23',
		displayClass: 'loseSight',
		titleName: 'bcncBankCode',
		id: 'bcncBankCode',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '24',
		displayClass: 'loseSight',
		titleName: 'bankName',
		id: 'bankName',
		width: '200px',
		tdClass: 'le'
	}, {
		no: '25',
		displayClass: 'loseSight',
		titleName: 'sendYN',
		id: 'sendYN',
		width: '200px',
		tdClass: 'le'
	} ],
	PRUFSENOCARD: [ {
		no: '0',
		displayClass: '',
		titleName: '거래일자',
		id: 'CONFM_DE',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '카드명',
		id: 'TR_NM',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '카드번호',
		id: 'CARD_NO',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '가맹점명',
		id: 'MRHST_NM',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: '',
		titleName: '가맹점사업자번호',
		id: 'MRBCRB_REGIST_NO',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '5',
		displayClass: '',
		titleName: '카드승인번호',
		id: 'PUCHAS_TKBAK_NO',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '6',
		displayClass: '',
		titleName: '공급가액',
		id: 'PUCHAS_TAMT',
		width: '100px',
		tdClass: 'ri'
	}, {
		no: '7',
		displayClass: '',
		titleName: '부가세',
		id: 'VAT',
		width: '100px',
		tdClass: 'ri'
	}, {
		no: '8',
		displayClass: '',
		titleName: '총금액',
		id: 'SPLPC',
		width: '100px',
		tdClass: 'ri'
	}, {
		no: '9',
		displayClass: '',
		titleName: '기사용금액',
		id: 'EXCUT_SUM_AMOUNT',
		width: '100px',
		tdClass: 'ri'
	}, {
		no: '10',
		displayClass: '',
		titleName: '등록가능금액',
		id: 'AM',
		width: '100px',
		tdClass: 'ri'
	}, {
		no: '11',
		displayClass: 'loseSight',
		titleName: 'BCNC_RPRSNTV_NM',
		id: 'BCNC_RPRSNTV_NM',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '12',
		displayClass: 'loseSight',
		titleName: 'BCNC_ADRES2',
		id: 'BCNC_ADRES2',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '13',
		displayClass: 'loseSight',
		titleName: 'BCNC_ADRES',
		id: 'BCNC_ADRES',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '14',
		displayClass: 'loseSight',
		titleName: 'PUCHAS_DE',
		id: 'PUCHAS_DE',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '15',
		displayClass: 'loseSight',
		titleName: 'BCNC_LSFT_NO',
		id: 'BCNC_LSFT_NO',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '16',
		displayClass: 'loseSight',
		titleName: 'BCNC_TELNO',
		id: 'BCNC_TELNO',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '17',
		displayClass: 'loseSight',
		titleName: 'CTR_CD',
		id: 'CTR_CD',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 거래처구분 */
	BCNCSE: [ {
		no: '0',
		displayClass: '',
		titleName: '거래처구분코드',
		id: 'bcncseCode',
		width: '60px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '거래처구분명칭',
		id: 'bcncseName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 증빙코드 */
	TR: [ {
		no: '0',
		displayClass: '',
		titleName: '거래처코드',
		id: 'trCode',
		width: '70px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '거래처명',
		id: 'trName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '사업자번호',
		id: 'regNumber',
		width: '70px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '계좌번호',
		id: 'baNumber',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: '',
		titleName: '대표자명',
		id: 'ceoName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '5',
		displayClass: 'loseSight',
		titleName: 'attrName',
		id: 'attrName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '6',
		displayClass: 'loseSight',
		titleName: 'attrNameKr',
		id: 'attrNameKr',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '7',
		displayClass: 'loseSight',
		titleName: 'cetNameKr',
		id: 'cetNameKr',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '8',
		displayClass: 'loseSight',
		titleName: 'trFgName',
		id: 'trFgName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '9',
		displayClass: 'loseSight',
		titleName: 'trFgCode',
		id: 'trFgCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '10',
		displayClass: 'loseSight',
		titleName: 'jiroCode',
		id: 'jiroCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '11',
		displayClass: 'loseSight',
		titleName: 'trNameKr',
		id: 'trNameKr',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '12',
		displayClass: 'loseSight',
		titleName: 'jeonjaYN',
		id: 'jeonjaYN',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '13',
		displayClass: 'loseSight',
		titleName: 'liqRs',
		id: 'liqRs',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '14',
		displayClass: 'loseSight',
		titleName: 'eMail',
		id: 'eMail',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '15',
		displayClass: 'loseSight',
		titleName: 'interDt',
		id: 'interDt',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '16',
		displayClass: 'loseSight',
		titleName: 'trchargeEMail',
		id: 'trchargeEMail',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '17',
		displayClass: 'loseSight',
		titleName: 'interRt',
		id: 'interRt',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 금융기관 */
	BCNCBANK: [ {
		no: '0',
		displayClass: '',
		titleName: '금융기관코드',
		id: 'bankCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '은행명',
		id: 'bankName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: 'loseSight',
		titleName: 'bankNameKr',
		id: 'bankNameKr',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 보조비목세목코드 */
	ASSTNTAXITMCD: [ {
		no: '0',
		displayClass: '',
		titleName: '보조비목세목코드',
		id: 'asstnExpitmTaxitmCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '보조비목명',
		id: 'asstnExpitmName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '보조세목명',
		id: 'asstnTaxitmName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 재원구분 */
	FNRSCSE: [ {
		no: '0',
		displayClass: 'loseSight',
		titleName: 'fnrscseCode',
		id: 'fnrscseCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '공통코드',
		id: 'fnrscseMCode',
		width: '50px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '공통코드명',
		id: 'fnrscseMName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '공통상세코드',
		id: 'fnrscseDCode',
		width: '50px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: '',
		titleName: '공통상세코드명',
		id: 'fnrscseDName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 프로젝트 */
	MGT: [ {
		no: '0',
		displayClass: '',
		titleName: '프로젝트코드',
		id: 'mgtCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '프로젝트명',
		id: 'pjtName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '코드',
		id: 'trCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '출금계좌',
		id: 'trName',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 예산과목 */
	ABGT: [ ],
	/* 재원코드 */
	BTR: [ {
		no: '0',
		displayClass: '',
		titleName: '거래처코드',
		id: 'trCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '거래처명',
		id: 'trName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '사업자번호',
		id: 'regNumber',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: '',
		titleName: '계좌번호',
		id: 'baNumber',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: '',
		titleName: '대표자명',
		id: 'ceoName',
		width: '70px',
		tdClass: 'le'
	}, {
		no: '5',
		displayClass: 'loseSight',
		titleName: 'attrName',
		id: 'attrName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '6',
		displayClass: 'loseSight',
		titleName: 'attrNameKr',
		id: 'attrNameKr',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '7',
		displayClass: 'loseSight',
		titleName: 'trFgName',
		id: 'trFgName',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '8',
		displayClass: 'loseSight',
		titleName: 'trFgCode',
		id: 'trFgCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '9',
		displayClass: 'loseSight',
		titleName: 'jiroCode',
		id: 'jiroCode',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '10',
		displayClass: 'loseSight',
		titleName: 'trNameKr',
		id: 'trNameKr',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '11',
		displayClass: 'loseSight',
		titleName: 'jeonjaYN',
		id: 'jeonjaYN',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '12',
		displayClass: 'loseSight',
		titleName: 'liqRs',
		id: 'liqRs',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '13',
		displayClass: 'loseSight',
		titleName: 'eMail',
		id: 'eMail',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '14',
		displayClass: 'loseSight',
		titleName: 'interDt',
		id: 'interDt',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '15',
		displayClass: 'loseSight',
		titleName: 'trchargeEMail',
		id: 'trchargeEMail',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '16',
		displayClass: 'loseSight',
		titleName: 'interRt',
		id: 'interRt',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '17',
		displayClass: 'loseSight',
		titleName: 'cetNameKr',
		id: 'cetNameKr',
		width: '100px',
		tdClass: 'le'
	} ],
	/* 사원코드 */
	PERCODE: [ {
		no: '0',
		displayClass: '',
		titleName: '코드',
		id: 'PER_CD',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '1',
		displayClass: '',
		titleName: '소득자명',
		id: 'PER_NM',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '2',
		displayClass: '',
		titleName: '주민번호',
		id: 'REG_NO',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '3',
		displayClass: 'loseSight',
		titleName: 'DATA_CD',
		id: 'DATA_CD',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '4',
		displayClass: 'loseSight',
		titleName: 'CO_CD',
		id: 'CO_CD',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '5',
		displayClass: 'loseSight',
		titleName: 'CORP_CD',
		id: 'CORP_CD',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '6',
		displayClass: 'loseSight',
		titleName: 'BANK_CD',
		id: 'BANK_CD',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '7',
		displayClass: 'loseSight',
		titleName: 'ACCT_NO',
		id: 'ACCT_NO',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '8',
		displayClass: 'loseSight',
		titleName: 'ACCT_NM',
		id: 'ACCT_NM',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '9',
		displayClass: 'loseSight',
		titleName: 'BANK_NM',
		id: 'BANK_NM',
		width: '100px',
		tdClass: 'le'
	}, {
		no: '10',
		displayClass: 'loseSight',
		titleName: 'BANK_NMK',
		id: 'BANK_NMK',
		width: '100px',
		tdClass: 'le'
	} ]
};
/* 국고보조 결의집행 JSON 변수 - 입력테이블 */
var ABDOCU_0 = [ {
	no: '0',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '일',
	id: zl.dlf,
	value: function ( ) {
		'use strict';
		return Number ( $ ( '#txtGisuDate' ).val ( ).split ( '-' ) [ 2 ] );
	},
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '30px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '-'
}, /* 일 */
{
	no: '1',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: 'loseSight',
	titleName: '번호',
	id: zl.qjsgh,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '-'
}, /* 번호 */
{
	no: '2',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '사업연도',
	id: zl.tkdjqduseh,
	value: function ( ) {
		'use strict';
		return $ ( '#txtGisuDate' ).val ( ).split ( '-' ) [ 0 ];
	},
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '60px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '사업연도를 입력하세요.'
}, /* 사업연도 */
{
	no: '3',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '지급구분',
	id: zl.wlrmqrnqns,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '60px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 지급구분을 입력하세요.'
}, /* 지급구분 */
{
	no: '4',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '국고보조사업',
	id: zl.rnrrhqhwhtkdjq,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 국고보조사업을 입력하세요.'
}, /* 국고보조사업 */
{
	no: '5',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '이체계좌구분',
	id: zl.dlcprPwhkrnqns,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 이쳬계좌구분을 입력하세요.'
}, /* 이체계좌구분 */
{
	no: '6',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '자계좌이체사유코드',
	id: zl.wkrPwhkdlcptkdbzhem,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '120px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 자계좌이체사유코드를 입력하세요.'
}, /* 자계좌이체사유코드 */
{
	no: '7',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '자계좌이체사유',
	id: zl.wkrPwhkdlcptkdb,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '자계좌이체사유를 입력하세요.'
}, /* 자계좌이체사유 */
{
	no: '8',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '증빙구분',
	id: zl.wmdqldrnqns,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 증빙구분을 입력하세요.'
}, /* 증빙구분 */
{
	no: '9',
	tail: 'N',
	popupCustLoadFunc: 'fnOpenLayerTaxPopup',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '증빙승인번호',
	id: zl.wmdqldtmddlsqjsgh,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 증빙승인번호를 입력하세요.'
}, /* 증빙승인번호 */
{
	no: '10',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '증빙일자',
	id: zl.wmdqlddlfwk,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: 'maskDate',
	helpDeskMessage: '증빙일자를 입력하세요.'
}, /* 증빙일자 */
{
	no: '11',
	tail: 'Y',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '집행용도',
	id: zl.wlqgoddydeh,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '집행용도를 입력하세요.'
}, /* 집행용도 */
{
	no: '12',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: 'loseSight',
	titleName: '작성자',
	id: 'EMP',
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '-'
} /* 작성자 */
];

var ABDOCU_1 = [ {
	no: '0',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: 'loseSight',
	titleName: '증빙총액',
	id: 'a',
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '-'
}, {
	no: '1',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: 'loseSight',
	titleName: '증빙공급가',
	id: 'b',
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '-'
}, {
	no: '2',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: 'loseSight',
	titleName: '증빙부가세',
	id: 'c',
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '-'
}, {
	no: '3',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: 'loseSight',
	titleName: '등록가능공급가액',
	id: 'd',
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '-'
}, {
	no: '4',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: 'loseSight',
	titleName: '등록가능부가세액',
	id: 'e',
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '-'
}, {
	no: '5',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '거래처구분',
	id: zl.rjfocjrnqns,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 거래처구분을 입력하세요.'
}, {
	no: '6',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '코드',
	id: zl.wmdqldzhem,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 코드를 입력하세요.'
}, {
	no: '7',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '거래처명',
	id: zl.rjfocjaud,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '거래처명을 입력하세요.'
}, {
	no: '8',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '금융기관',
	id: zl.rmadbdrlrhks,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 금융기관을 입력하세요.'
}, {
	no: '9',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '입금계좌번호',
	id: zl.dlqrmarPwhkqjsgh,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '입금계좌번호를 입력하세요.'
}, {
	no: '10',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '보조금통장표시내용',
	id: zl.qhwhrmaxhdwkdvytlsodyd,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '120px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '보조금통장표시내용을 입력하세요.'
}, {
	no: '11',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '거래처통장표시내용',
	id: zl.rjfocjxhdwkdvytlsodyd,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '120px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '거래처통장표시내용을 입력하세요.'
}, {
	no: '12',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '거래처사업자/주민번호',
	id: zl.rjfocjtkdjqwkwnalsqjsgh,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '140px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '거래처 사업자/주민번호를 입력하세요.'
}, {
	no: '13',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '사업장주소',
	id: zl.tkdjqwkdwnth,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '사업장주소를 입력하세요.'
}, {
	no: '14',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '대표자명',
	id: zl.eovywkaud,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '대표자명을 입력하세요.'
}, {
	no: '15',
	tail: 'Y',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '전화번호',
	id: zl.wjsghkqjsgh,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '전화번호를 입력하세요.'
} ];

var ABDOCU_B = [ {
	no: '0',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '보조비목세목코드',
	id: zl.qhwhqlahrtpahrzhem,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 보조비목세목코드를 입력하세요.'
}, {
	no: '1',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '보조비목명',
	id: zl.qhwhqlahraud,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '-'
}, {
	no: '2',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '보조세목명',
	id: zl.qhwhtpahraud,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '-'
}, {
	no: '3',
	tail: 'Y',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '품목',
	id: zl.vnaahr,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '품목을 입력하세요.'
} ];

var ABDOCU_T = [ {
	no: '0',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '재원구분',
	id: zl.wodnjsrnqns,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 재원구분을 입력하세요.'
}, {
	no: '1',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '프로젝트',
	id: zl.vmfhwprxm,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 프로젝트를 입력하세요.'
}, {
	no: '2',
	tail: 'N',
	popupCustLoadFunc: 'fnBudgetAcctCodePop',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '예산과목',
	id: zl.dPtksrhkahr,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 예산과목을 입력하세요.'
}, {
	no: '3',
	tail: 'N',
	popupCustLoadFunc: 'fnPopCode',
	popupCustBindFunc: 'fnBindCode',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '코드',
	id: zl.wodnjszhem,
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'Y',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '코드도움[F2] : 코드를 입력하세요.'
}, {
	no: '4',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '출금계좌',
	id: 'BTRNUM',
	value: '',
	requierdYN: 'Y',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 'le',
	inputClass: 'td_inp',
	mask: '',
	helpDeskMessage: '출금계좌를 입력하세요.'
}, {
	no: '5',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '집행금액',
	id: zl.wlqgodrmador,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 're',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '-'
}, {
	no: '6',
	tail: 'N',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '공급가액',
	id: zl.rhdrmqrkdor,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 're',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '공급가액을 입력하세요.'
}, {
	no: '7',
	tail: 'Y',
	popupCustLoadFunc: '',
	popupCustBindFunc: '',
	focusCustFunc: 'fnSetAnbojoValue',
	displayClass: '',
	titleName: '부가세',
	id: zl.qnrktp,
	value: '',
	requierdYN: 'N',
	inputType: 'text',
	codeHelperYN: 'N',
	width: '100px',
	tdClass: 're',
	inputClass: 'td_inp',
	mask: 'maskMoney',
	helpDeskMessage: '부가세를 입력하세요.'
} ];