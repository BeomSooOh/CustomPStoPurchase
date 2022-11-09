function fnMakePAYFGCodeJson ( data ) {
	'use strict';
	var codeGroup = [ {
		payFgCode: '1',
		payFgName: '일반'
	},
	/*
	 * { payFgCode: '2', payFgName: '인건비성' }
	 */
	];
	dataJson = codeGroup;
}
/* 국고보조사업 */
/* --------------------------------------- */

function fnMakeDDTLBZCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.ddtlbzCode = item.DDTLBZ_ID;
		codeRow.ddtlbzName = item.DDTLBZ_NM;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 이체계좌구분 */
/* --------------------------------------- */

function fnMakeTRANSFRACNUTSECodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.transFracnutSeCode = item.SYS_SE_CODE;
		codeRow.transFracnutSeMCode = item.CMMN_CODE;
		codeRow.transFracnutSeMName = item.CMMN_CODE_NM;
		codeRow.transFracnutSeDCode = item.CMMN_DETAIL_CODE;
		codeRow.transFracnutSeDName = item.CMMN_DETAIL_CODE_NM;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 자계좌이체사유코드 */
/* --------------------------------------- */

function fnMakeSBSACNTTRFRSNCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.sbsAcnttrfrSnCode = item.SYS_SE_CODE;
		codeRow.sbsAcnttrfrSnMCode = item.CMMN_CODE;
		codeRow.sbsAcnttrfrSnMName = item.CMMN_CODE_NM;
		codeRow.sbsAcnttrfrSnDCode = item.CMMN_DETAIL_CODE;
		codeRow.sbsAcnttrfrSnDName = item.CMMN_DETAIL_CODE_NM;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 증빙구분 */
/* --------------------------------------- */

function fnMakePRUFSECodeJson ( data ) {
	'use strict';
	var codeGroup = [ {
		prufseCode: '001',
		prufseName: '전자세금계산서'
	}, {
		prufseCode: '002',
		prufseName: '전자계산서'
	}, {
		prufseCode: '004',
		prufseName: '카드'
	}, {
		prufseCode: '999',
		prufseName: '기타'
	} ];

	dataJson = codeGroup;
}
/* 증빙승인번호 */
/* --------------------------------------- */

function fnMakePRUFSENOCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	var prufSeCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';

	if ( prufSeCode == '004' ) {
		codeTableHead.GetHead ( 'PRUFSENOCARD' );
		$.each ( data || [ ], function ( index, item ) {
			var codeRow = {};
			codeRow.CONFM_DE = item.CONFM_DE;
			codeRow.TR_NM = item.TR_NM;
			codeRow.CARD_NO = item.CARD_NO;
			codeRow.MRHST_NM = item.MRHST_NM;
			codeRow.MRBCRB_REGIST_NO = item.MRBCRB_REGIST_NO;
			codeRow.PUCHAS_TKBAK_NO = item.PUCHAS_TKBAK_NO;
			codeRow.PUCHAS_TAMT = item.PUCHAS_TAMT;
			codeRow.VAT = item.VAT;
			codeRow.SPLPC = item.SPLPC;
			codeRow.EXCUT_SUM_AMOUNT = item.EXCUT_SUM_AMOUNT;
			codeRow.AM = item.AM;
			codeRow.BCNC_RPRSNTV_NM = item.BCNC_RPRSNTV_NM;
			codeRow.BCNC_ADRES2 = item.BCNC_ADRES2;
			codeRow.BCNC_ADRES = item.BCNC_ADRES;
			codeRow.PUCHAS_DE = item.PUCHAS_DE;
			codeRow.BCNC_LSFT_NO = item.BCNC_LSFT_NO;
			codeRow.BCNC_TELNO = item.BCNC_TELNO;
			codeRow.CTR_CD = item.CTR_CD;
			codeGroup.push ( codeRow );
		} );
	} else if ( prufSeCode == '001' || prufSeCode == '002' ) {
		$.each ( data || [ ], function ( index, item ) {
			var codeRow = {};
			codeRow.eTaxTypeName = item.ETAX_TY_NM;
			codeRow.issData = item.ISS_DT;
			codeRow.isuDate = item.ISU_DT;
			codeRow.trName = item.TR_NM;
			codeRow.trRegNumber = item.TRREG_NB;
			codeRow.supAmount = item.SUP_AM;
			codeRow.vatAmount = item.VAT_AM;
			codeRow.sumAmount = item.SUM_AM;
			codeRow.issNumber = item.ISS_NO;
			codeRow.excutSumAmount = item.EXCUT_SUM_AMOUNT;
			codeRow.amount = item.AM;
			codeRow.erpCompSeq = item.CO_CD
			codeRow.erpBizSeq = item.DIV_CD
			codeRow.erpBizName = item.DIV_NM
			codeRow.taxType = item.TAX_TY
			codeRow.bizCeoName = item.DIVCEO_NM
			codeRow.trCode = item.TR_CD
			codeRow.bcncCmpnayName = item.BCNC_CMPNY_NM
			codeRow.duzonBankCode = item.DUZON_BANK_CODE
			codeRow.bcncAcnutNo = item.BCNC_ACNUT_NO
			codeRow.bcncAddress = item.BCNC_ADRES
			codeRow.bcncRprsntyName = item.BCNC_RPRSNTY_NM
			codeRow.bcncTelNo = item.BCNC_TELNO
			codeRow.bcncBankCode = item.BCNC_BANK_CODE
			codeRow.bankName = item.BANK_NM
			codeRow.sendYN = item.SEND_YN
			codeGroup.push ( codeRow );
		} );
	}
	dataJson = codeGroup;
}

/* 거래처구분 */
/* --------------------------------------- */

function fnMakeBCNCSECodeJson ( data ) {
	'use strict';
	var codeGroup = [ {
		bcncseCode: '001',
		bcncseName: '법인거래'
	}, {
		bcncseCode: '002',
		bcncseName: '개인사업자'
	}, {
		bcncseCode: '003',
		bcncseName: '개인거래'
	} ];
	dataJson = codeGroup;
}

/* 코드 */
/* --------------------------------------- */

function fnMakeTRCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.trCode = item.TR_CD;
		codeRow.trName = item.TR_NM;
		codeRow.regNumber = item.REG_NB;
		codeRow.baNumber = item.BA_NB;
		codeRow.ceoName = item.CEO_NM;
		codeRow.attrName = item.ATTR_NM;
		codeRow.attrNameKr = item.ATTR_NMK;
		codeRow.cetNameKr = item.CEO_NMK;
		codeRow.trFgName = item.TR_FG_NM;
		codeRow.trFgCode = item.TR_FG;
		codeRow.jiroCode = item.JIRO_CD;
		codeRow.trNameKr = item.TR_NMK;
		codeRow.jeonjaYN = item.JEONJA_YN;
		codeRow.liqRs = item.LIQ_RS;
		codeRow.eMail = item.EMAIL;
		codeRow.interDt = item.INTER_DT;
		codeRow.trchargeEMail = item.TRCHARGE_EMAIL;
		codeRow.interRt = item.INTER_RT;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 금융기관 */
/* --------------------------------------- */

function fnMakeBCNCBANKCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.bankCode = item.BANK_CD;
		codeRow.bankName = item.BANK_NM;
		codeRow.bankNameKr = item.BANK_NMK;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 보조비목세목코드 */
/* --------------------------------------- */

function fnMakeASSTNTAXITMCDCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.asstnExpitmTaxitmCode = item.ASSTN_EXPITM_TAXITM_CODE;
		codeRow.asstnExpitmName = item.ASSTN_EXPITM_NM;
		codeRow.asstnTaxitmName = item.ASSTN_TAXITM_NM;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 재원구분 */
/* --------------------------------------- */

function fnMakeFNRSCSECodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.fnrscseCode = item.SYS_SE_CODE;
		codeRow.fnrscseMCode = item.CMMN_CODE;
		codeRow.fnrscseMName = item.CMMN_CODE_NM;
		codeRow.fnrscseDCode = item.CMMN_DETAIL_CODE;
		codeRow.fnrscseDName = item.CMMN_DETAIL_CODE_NM;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 프로젝트 */
/* --------------------------------------- */

function fnMakeMGTCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.mgtCode = item.MGT_CD;
		codeRow.pjtName = item.PJT_NM;
		codeRow.trCode = item.TR_CD;
		codeRow.trName = item.TR_NM;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}
/* 코드 */
/* --------------------------------------- */

function fnMakeBTRCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.trCode = item.TR_CD;
		codeRow.trName = item.TR_NM;
		codeRow.regNumber = item.REG_NB;
		codeRow.baNumber = item.BA_NB;
		codeRow.ceoName = item.CEO_NM;
		codeRow.attrName = item.ATTR_NM;
		codeRow.attrNameKr = item.ATTR_NMK;
		codeRow.trFgName = item.TR_FG_NM;
		codeRow.trFgCode = item.TR_FG;
		codeRow.jiroCode = item.JIRO_CD;
		codeRow.trNameKr = item.TR_NMK;
		codeRow.jeonjaYN = item.JEONJA_YN;
		codeRow.liqRs = item.LIQ_RS;
		codeRow.eMail = item.EMAIL;
		codeRow.interDt = item.INTER_DT;
		codeRow.trchargeEMail = item.TRCHARGE_EMAIL;
		codeRow.interRt = item.INTER_RT;
		codeRow.cetNameKr = item.CEO_NMK;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}

/* 'CARDTR' */
/* 코드 */
/* --------------------------------------- */

function fnMakeCARDTRCodeJson ( data ) {
	'use strict';
	var codeGroup = [ ];
	$.each ( data || [ ], function ( index, item ) {
		var codeRow = {};
		codeRow.ctrCode = item.CTR_CD;
		codeRow.trName = item.TR_NM;
		codeRow.baNumber = item.BA_NB;
		codeGroup.push ( codeRow );
	} );
	dataJson = codeGroup;
}

/* 테이블 연관 관계 설정 */
function fnSetTableRelation ( ) {
	var topTable = "resolveContent";
	var mid1Table = "authContent";
	var mid2Table = "bimokContent";
	var botTable = "jaewonContent";
	var arrfocusKey = [ ];

	// 포커스테이블에 저장
	focusJsonList [ topTable ] = ABDOCU_0;
	focusJsonList [ mid1Table ] = ABDOCU_1;
	focusJsonList [ mid2Table ] = ABDOCU_B;
	focusJsonList [ botTable ] = ABDOCU_T;

	// 첫 번째 테이블 테이블 연관정보 저장
	var topTblRelation = {};
	topTblRelation.key = topTable;
	// 첫 번째 테이블 테이블 연관정보 배열
	var linkInfoTop = [ ];
	var linkInfoJsonTop = {};
	linkInfoJsonTop.myTableName = topTable;
	// 연관 태이블명
	linkInfoJsonTop.linkTableName = mid1Table;
	// 행 자동생성
	linkInfoJsonTop.autoCreateRow = 'Y';
	// 테이블 타입
	linkInfoJsonTop.linkTableType = '1';
	// 연관 테이블 명
	linkInfoJsonTop.linkParentElementId = mid1Table + "_TRDATA";
	// 연관테이블 json 데이터
	linkInfoJsonTop.linkJsonData = ABDOCU_1;
	// 포커스 여부
	linkInfoJsonTop.focusYN = 'Y';
	// 테이블카운드 변수 명
	linkInfoJsonTop.tableRowNumVariableName = 'mid1TableRowCount';
	// 저장
	linkInfoTop.push ( linkInfoJsonTop );
	topTblRelation.linkInfo = linkInfoTop;

	// 두 번째 테이블 테이블 연관정보 저장
	var mid1TblRelation = {};
	mid1TblRelation.key = mid1Table;
	// 두 번째 테이블 테이블 연관정보 배열
	var linkInfoMid = [ ];
	var linkInfoJsonMid = {};
	linkInfoJsonMid.myTableName = mid1Table;
	// 연관 태이블명
	linkInfoJsonMid.linkTableName = mid2Table;
	// 행 자동생성
	linkInfoJsonMid.autoCreateRow = 'Y';
	// 테이블 타입
	linkInfoJsonMid.linkTableType = '2';
	// 연관 테이블 명
	linkInfoJsonMid.linkParentElementId = mid2Table + "_TRDATA";
	// linkInfoJsonMid json 데이터
	linkInfoJsonMid.linkJsonData = ABDOCU_B;
	// 포커스 여부
	linkInfoJsonMid.focusYN = 'Y';
	// 테이블카운드 변수 명
	linkInfoJsonMid.tableRowNumVariableName = 'mid2TableRowCount';
	// 저장
	linkInfoMid.push ( linkInfoJsonMid );
	mid1TblRelation.linkInfo = linkInfoMid;

	var mid2TblRelation = {};
	mid2TblRelation.key = mid2Table;
	// 두 번째 테이블 테이블 연관정보 배열
	var linkInfoMid = [ ];
	var linkInfoJsonMid = {};
	linkInfoJsonMid.myTableName = mid2Table;
	// 연관 태이블명
	linkInfoJsonMid.linkTableName = botTable;
	// 행 자동생성
	linkInfoJsonMid.autoCreateRow = 'Y';
	// 테이블 타입
	linkInfoJsonMid.linkTableType = '2';
	// 연관 테이블 명
	linkInfoJsonMid.linkParentElementId = botTable + "_TRDATA";
	// linkInfoJsonMid json 데이터
	linkInfoJsonMid.linkJsonData = ABDOCU_T;
	// 포커스 여부
	linkInfoJsonMid.focusYN = 'Y';
	// 테이블카운드 변수 명
	linkInfoJsonMid.tableRowNumVariableName = 'botTableRowCount';
	// 저장
	linkInfoMid.push ( linkInfoJsonMid );
	mid2TblRelation.linkInfo = linkInfoMid;

	var botTblRelation = {};
	botTblRelation.key = botTable;

	var linkInfoBot = [ ];
	var linkInfoJsonBot = {};

	linkInfoJsonBot.myTableName = botTable;
	linkInfoJsonBot.linkTableName = botTable;
	// 행 자동생성
	linkInfoJsonBot.autoCreateRow = 'Y';
	// 테이블 타입
	linkInfoJsonBot.linkTableType = '2';
	// 연관 테이블 명
	linkInfoJsonBot.linkParentElementId = botTable + "_TRDATA";
	// linkInfoJsonMid json 데이터
	linkInfoJsonBot.linkJsonData = ABDOCU_T;
	// 포커스 여부
	linkInfoJsonBot.focusYN = 'Y';
	// 테이블카운드 변수 명
	linkInfoJsonBot.tableRowNumVariableName = 'botTableRowCount';

	linkInfoBot.push ( linkInfoJsonBot );
	botTblRelation.linkInfo = linkInfoBot;

	arrfocusKey.push ( topTblRelation );
	arrfocusKey.push ( mid1TblRelation );
	arrfocusKey.push ( mid2TblRelation );
	arrfocusKey.push ( botTblRelation );

	// 저장
	focusJsonList.arrfocusKey = arrfocusKey;
}

/* 코드 팝업 오픈 headjson과 dataJson은 전역변수 */
function fnPopCode ( bindId, item ) {
	/* 백그라운드 포커스 주기 */
	document.body.focus ( );
	fnLoadRequestData ( bindId, item );
	/* 로직 완료 후 그리기 */
	$ ( "#divCodeHelperPop" ).css ( 'display', 'block' );
	$ ( "#divCodeHelperPop" ).attr ( 'tabindex', '0' );
	$ ( "#divCodeHelperPop" ).focus ( );

	/* uctable 코드팝업 그리드 헤더 생성 */
	$.devTable.createCodeHelper ( headjson, 'divCodePopLayer', '1', '', 'N' );

	/* 데이터 바인드 */
	$.devTable.addrowCodeData ( headjson, dataJson, '1', 'divCodePopLayer' );

	/* 코드도움창 키이벤트 등록 */
	fnRegUCTableCodePopKeyEvent ( event, 'divCodePopLayer', 'hdnPopupData', 'hdnInputPopupInfo', headjson, '1' );
	
	$('#searchButton').unbind();
	$('#searchButton').click(function(){
		if(dataJson.length == 0){
			fnLoadRequestData ( bindId, item );
			
			/* uctable 코드팝업 그리드 헤더 생성 */
			$.devTable.createCodeHelper ( headjson, 'divCodePopLayer', '1', '', 'N' );

			/* 데이터 바인드 */
			$.devTable.addrowCodeData ( headjson, dataJson, '1', 'divCodePopLayer' );

			/* 코드도움창 키이벤트 등록 */
			fnRegUCTableCodePopKeyEvent ( event, 'divCodePopLayer', 'hdnPopupData', 'hdnInputPopupInfo', headjson, '1' );
		}
	});

	/* 현재 코드팝업 정보 파라메터 히든값에 저장하기 */
	item.bindId = bindId;
	item.searchText = $ ( "#" + bindId ).val ( );
	// 사용자 입력 검색어
	$ ( "#hdnInputPopupInfo" ).val ( JSON.stringify ( item ) );
	// 현재 팝업 더에터 저장
	$ ( "#hdnPopupData" ).val ( JSON.stringify ( dataJson ) );

	$ ( ".UCSearch" ).val ( item.searchText );
	fnPreCodePopSearch ( 'hdnPopupData', item.searchText, 'divCodePopLayer_TABLE', headjson, '1' );
	if(bindId.toString().split('_')[0] == 'TR'){
		$('#txtCodeSearch').focus(); /* 기본 입력 위치 정의 */
	}
}
/* 최초 요청시 데이터에 대한 요청값을 구분하는 곳 */
function fnLoadRequestData ( bindId, item ) {
	'use strict';
	var result = '';
	var processKey = item.id;

	if ( processKey == 'PRUFSENO' ) {
		var prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';
		if ( prufseCode == '004' ) {
			codeTableHead.GetHead ( "PRUFSENOCARD" ); /*
														 * 코드팝업 헤더 정의를 headjson 에 재정의
														 */
		} else {
			codeTableHead.GetHead ( processKey ); /* 코드팝업 헤더 정의를 headjson 에 재정의 */
		}
	} else {
		codeTableHead.GetHead ( processKey ); /* 코드팝업 헤더 정의를 headjson 에 재정의 */
	}
	result = codeListParam.GetCode ( processKey ); /* 공통코드 목록 조회 */

	switch ( item.id ) {
		case zl.dlf:
			break; /* 일 */
		case zl.qjsgh:
			break; /* 번호 */
		case zl.tkdjqduseh:
			break; /* 사업연도 */
		case zl.wlrmqrnqns:
			fnMakePAYFGCodeJson ( result );
			break; /* 지급구분 */
		case zl.rnrrhqhwhtkdjq:
			fnMakeDDTLBZCodeJson ( result );
			break; /* 국고보조사업 */
		case zl.dlcprPwhkrnqns:
			fnMakeTRANSFRACNUTSECodeJson ( result );
			break; /* 이체계좌구분 */
		case zl.wkrPwhkdlcptkdbzhem:
			fnMakeSBSACNTTRFRSNCodeJson ( result );
			break; /* 자계좌이체사유코드 */
		case zl.wkrPwhkdlcptkdb:
			break; /* 자계좌이체사유 */
		case zl.wmdqldrnqns:
			fnMakePRUFSECodeJson ( result );
			break; /* 증빙구분 */
		case zl.wmdqldtmddlsqjsgh:
			fnMakePRUFSENOCodeJson ( result );
			break; /* 증빙승인번호 */
		case zl.wmdqlddlfwk:
			break; /* 증빙일자 */
		case zl.wlqgoddydeh:
			break; /* 집행용도 */
		case zl.rjfocjrnqns:
			fnMakeBCNCSECodeJson ( result );
			break; /* 거래처구분 */
		case zl.wmdqldzhem:
			fnMakeTRCodeJson ( result );
			break; /* 코드 */
		case zl.rjfocjaud:
			break; /* 거래처명 */
		case zl.rmadbdrlrhks:
			fnMakeBCNCBANKCodeJson ( result );
			break; /* 금융기관 */
		case zl.dlqrmarPwhkqjsgh:
			break; /* 입금계좌번호 */
		case zl.qhwhrmaxhdwkdvytlsodyd:
			break; /* 보조금통장표시내용 */
		case zl.rjfocjxhdwkdvytlsodyd:
			break; /* 거래처통장표시내용 */
		case zl.rjfocjtkdjqwkwnalsqjsgh:
			break; /* 거래처 사업자/주민번호 */
		case zl.tkdjqwkdwnth:
			break; /* 사업장주소 */
		case zl.eovywkaud:
			break; /* 대표자명 */
		case zl.wjsghkqjsgh:
			break; /* 전화번호 */
		case zl.qhwhqlahrtpahrzhem:
			fnMakeASSTNTAXITMCDCodeJson ( result );
			break; /* 보조비목세목코드 */
		case zl.qhwhqlahraud:
			break; /* 보조비목명 */
		case zl.qhwhtpahraud:
			break; /* 보조세목명 */
		case zl.vnaahr:
			break; /* 품목 */
		case zl.wodnjsrnqns:
			fnMakeFNRSCSECodeJson ( result );
			break; /* 재원구분 */
		case zl.vmfhwprxm:
			fnMakeMGTCodeJson ( result );
			break; /* 프로젝트 */
		case zl.dPtksrhkahr:
			break; /* 예산과목 */
		case zl.wodnjszhem:
			fnMakeBTRCodeJson ( result );
			break; /* 코드 */
		case zl.cnfrmarPwhk:
			break; /* 출금계좌 */
		case zl.wlqgodrmador:
			break; /* 집행금액 */
		case zl.rhdrmqrkdor:
			break; /* 공급가액 */
		case zl.qnrktp:
			break; /* 부가세 */
		case zl.zkem:
			fnMakeCARDTRCodeJson ( result );
			break; /* 카드목록 */
	}
}

// 코드팝업 커스텀 : 전자세금계산서
function fnOpenLayerTaxPopup ( bindId, item ) {
	var prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';
	if ( prufseCode == '999' ) {
		/* 증빙구분 >> 기타 */
		$ ( '#' + bindId ).parent ( ).next ( 'td' ).find ( 'input:first' ).click ( ).focus ( );
		return false;
	} else if ( prufseCode == '004' ) {
		/* 증빙구분 >> 카드 */
		/* #카드팝업 */
		fnOpenLayerCardDealPopup ( bindId, item );

	} else if ( prufseCode == '001' || prufseCode == '002' ) {
		/* 증빙구분 >> 전자세금계산서(과세), 전자계산서(면세) */
		/* #전자세금계산서팝업 */
		/* 백그라운드 포커스 주기 */
		document.body.focus ( );
		// setTimeout (function () {document.getElementById ( 'myInput'). focus
		// ();}, 10);
		/* ========================== */
		/*
		 * 데이터 호출 로직 /*==========================
		 */
		fnLoadRequestData ( bindId, item );
		/* 로직 완료 후 그리기 */
		$ ( "#divTaxCodeHelperPop" ).css ( 'display', 'block' );

		/* 자바스크립트 오늘 날짜 지정 */
		var d = new Date ( );
		var month = 0;
		var day = 0;
		if ( d.getMonth ( ) + 1 < 9 ) {
			month = '0' + Number ( d.getMonth ( ) + 1 );
		} else {
			month = d.getMonth ( ) + 1;
		}

		if ( d.getDate ( ) < 10 ) {
			day = '0' + d.getDate ( );
		} else {
			day = d.getDate ( );
		}
		var todayDate = d.getFullYear ( ) + '-' + month + '-' + day;

		$ ( '#txtTODT' ).mask ( '0000-00-00' );
		$ ( '#txtTODT' ).val ( todayDate );
		$ ( '#txtTODT' ).masked ( );

		d = new Date ( d.getFullYear ( ), d.getMonth ( ), d.getDate ( ) );
		d.setDate ( d.getDate ( ) - 7 );
		if ( d.getMonth ( ) + 1 < 9 ) {
			month = '0' + Number ( d.getMonth ( ) + 1 );
		} else {
			month = d.getMonth ( ) + 1;
		}

		if ( d.getDate ( ) < 10 ) {
			day = '0' + d.getDate ( );
		} else {
			day = d.getDate ( );
		}
		var fromDate = d.getFullYear ( ) + '-' + month + '-' + day;

		$ ( '#txtFRDT' ).mask ( '0000-00-00' );
		$ ( '#txtFRDT' ).val ( fromDate );
		$ ( '#txtFRDT' ).masked ( );

		/* uctable 코드팝업 그리드 헤더 생성 */
		$.devTable.createCodeHelper ( headjson, 'divTaxCodePopLayer', '2', '300px', 'N' );

		/* 데이터 바인드 */
		$.devTable.addrowCodeData ( headjson, dataJson, '2', 'divTaxCodePopLayer' );

		/* 코드도움창 키이벤트 등록 */
		fnRegUCTableCodePopKeyEvent ( event, 'divTaxCodePopLayer', 'hdnPopupData', 'hdnInputPopupInfo', headjson, '1' );

		// TABLE KEY EVET BIND(KEYDOWN)
		$ ( '#divTaxCodeHelperPop' ).on ( 'keydown', function ( e ) {
			switch ( e.keyCode ) {
				/* ESC EVENT */
				case 119:
					fnGetEtaxDtaAjax ( );
					break;
				default:
					break;
			}
		} );

		/* 현재 코드팝업 정보 파라메터 히든값에 저장하기 */
		item.bindId = bindId;
		$ ( "#hdnInputPopupInfo" ).val ( JSON.stringify ( item ) );
		// 현재 팝업 더에터 저장
		$ ( "#hdnPopupData" ).val ( JSON.stringify ( dataJson ) );

		/* 포커스 키 이벤트 등록 */
		$ ( "#selDTFG" ).focus ( );

		$ ( '#divTaxCodeSelectZone' ).unbind ( );
		// TABLE KEY EVET BIND(KEYDOWN)
		$ ( '#divTaxCodeSelectZone' ).on ( 'keydown', function ( e ) {
			switch ( e.keyCode ) {
				/* ENTER EVENT */
				case 13:
					var focusNo = [ 'selDTFG', 'txtFRDT', 'txtTODT', 'selTAXTY', 'selTRCD', 'selETAXTY' ];
					var nextId = '';
					var curId = document.activeElement.id
					for ( var i = 0; i < focusNo.length; i++ ) {
						if ( focusNo [ i ] == curId ) {
							if ( i == focusNo.length - 1 ) {
								nextId = focusNo [ 0 ];
								break;
							} else {
								if ( curId == 'selTRCD' ) {
									fnGetETaxPater ( );
									break;
								} else {
									nextId = focusNo [ i + 1 ];
									break;
								}
							}
						}
					}

					if ( curId == 'selTRCD' ) {
						$ ( "#" + nextId ).focus ( );
					} else {
						$ ( "#" + nextId ).focus ( );
						$ ( "#" + nextId ).select ( );
					}
					break;
				/* LEFT ARROW EVENT */
				case 37:
					break;
				case 38:
					break;
				/* RIGHT ARROW EVENT */
				case 39:
					break;
				/* DOWN ARROW EVENT */
				case 40:
					break;
				case 119:
					fnGetEtaxDtaAjax ( );
				default:
					break;
			}
		} );
	}
}

/* 전자세금계산서 데이터 조회 */
function fnGetEtaxDtaAjax ( ) {
	var item = {};
	item.id = zl.wmdqldtmddlsqjsgh;
	var bindId = '';
	$ ( "#divTaxCodePopLayer_TRDATA_FIX" ).empty ( );
	$ ( "#divTaxCodePopLayer_TRDATA" ).empty ( );
	/* ========================== */
	/*
	 * 데이터 호출 로직 /*==========================
	 */
	fnLoadRequestData ( bindId, item );
	/* 로직 완료 후 그리기 */
	$ ( "#divTaxCodeHelperPop" ).css ( 'display', '' );
	/* 데이터 바인드 */
	$.devTable.addrowCodeData ( headjson, dataJson, '2', 'divTaxCodePopLayer' );
	// 현재 팝업 더에터 저장
	$ ( "#hdnPopupData" ).val ( JSON.stringify ( dataJson ) );
}

/* 팝업 내 레이어 팝업 띄우기 */
function fnLayerSubCodePopKeyEvent ( e, pLocationId, pCodePopDataId, pInputPopDataId, pHeadJsonData, pCodeTableType ) {
	// 코드도움 테이블 명 저장
	var locationId = pLocationId + "_TABLE";
	// 히든 코드 도움창 json 정보
	var jsonDataId = pCodePopDataId;
	// 코드그리드헤더 정보
	var headJson = pHeadJsonData;
	// 코드테이블 타입정보
	var codeTableType = pCodeTableType;
	// KEY EVENT DELETE
	$ ( '.subSearch' ).unbind ( );
	// $('.onSel').unbind();
	$ ( '#' + locationId ).unbind ( );
	// 선택한 데이터에 대한 더블클릭 이벤트
	$ ( '#divTaxSubCodePopLayer_TABLE' ).dblclick ( function ( ) {
		fnSubSelectRow ( );
	} );
	// 검색버튼
	$ ( "#searchSubButton" ).click ( function ( ) {
		fnSearchStr ( jsonDataId, $ ( ".subSearch" ).val ( ), locationId, headJson, codeTableType );
	} );

	$ ( '.subSearch' ).unbind ( );
	// INPUT KEY EVET BIND(KEYDOWN)
	$ ( '.subSearch' ).on ( 'keydown', function ( e ) {
		switch ( e.keyCode ) {
			/* ENTER EVENT */
			case 13:
				fnSearchStr ( jsonDataId, $ ( ".subSearch" ).val ( ), locationId, headJson, codeTableType );
				$ ( "#" + locationId ).find ( 'TR' ).eq ( 0 ).click ( ).focus ( );
				return false;
				break;
			/* LEFT ARROW EVENT */
			case 37:
				break;
			/* UP ARROW EVENT */
			case 38:
				$ ( "#" + locationId ).find ( '.onSel' ).prev ( ).click ( ).focus ( );
				return false;
				break;
			/* RIGHT ARROW EVENT */
			case 39:

				break;
			/* DOWN ARROW EVENT */
			case 40:
				$ ( "#" + locationId ).find ( '.onSel' ).next ( ).click ( ).focus ( );
				return false;
				break;

			default:
				$ ( '.UCSearch' ).focus ( );
				break;
		}
	} );

	$ ( "#" + locationId ).unbind ( );
	$ ( "#" + locationId ).on ( 'keydown', function ( e ) {
		switch ( e.keyCode ) {
			/* ENTER EVENT */
			case 13:
				fnSubSelectRow ( );
				return false;
				break;
			/* LEFT ARROW EVENT */
			case 37:
				break;
			/* UP ARROW EVENT */
			case 38:
				$ ( "#" + locationId ).find ( '.onSel' ).prev ( ).click ( ).focus ( );
				return false;
				break;
			/* RIGHT ARROW EVENT */
			case 39:

				break;
			/* DOWN ARROW EVENT */
			case 40:
				$ ( "#" + locationId ).find ( '.onSel' ).next ( ).click ( ).focus ( );
				return false;
				break;
			case 27:
				// 팝업닫기
				// 레이어팝업 정보 초기화
				$ ( "#divTaxSubCodeHelperPop" ).css ( 'display', 'none' );
				$ ( "#" + pLocationId ).empty ( );
				$ ( "#txtCodeSearch" ).val ( '' );

				// KEY EVENT DELETE
				$ ( '.subSearch' ).unbind ( );
				$ ( '.onSel' ).unbind ( );
				$ ( '#' + locationId ).unbind ( );
				$ ( "#selTRCD" ).focus ( );
				break;
			default:
				$ ( '.subSearch' ).focus ( );
				break;
		}
	} );

	// Search json Data on hidden json value
	function fnSearchStr ( jsonDataId, searchStr, tableName, headJson, codeTableType ) {
		if ( searchStr.length > 0 ) {
			var data = $ ( "#" + jsonDataId ).val ( );
			var jsonArr = JSON.parse ( data );
			var resultJsonArr = [ ];
			for ( var i = 0; i < jsonArr.length; i++ ) {
				$.each ( jsonArr [ i ], function ( key, value ) {
					if ( value.indexOf ( searchStr ) !== -1 ) {
						resultJsonArr.push ( jsonArr [ i ] );
					}
				} );
			}
			$ ( "#" + tableName ).empty ( );
			tableName = tableName.replace ( '_TABLE', '' );
			$.devTable.addrowCodeData ( headJson, resultJsonArr, codeTableType, tableName )

		} else {
			var data = $ ( "#" + jsonDataId ).val ( );
			var jsonArr = JSON.parse ( data );
			$ ( "#" + tableName ).empty ( );
			tableName = tableName.replace ( '_TABLE', '' );
			$.devTable.addrowCodeData ( headJson, jsonArr, codeTableType, tableName )
		}
	}

	function fnSubSelectRow ( ) {
		var eleSelect = $ ( "#" + locationId ).find ( '.onSel' );
		var rowData = $ ( eleSelect ).prop ( 'data' );
		var popInfo;

		$ ( "#selTRCD option:eq(0)" ).remove ( );
		$ ( "#selTRCD" ).append ( "<option value='" + rowData.trCode + "'>" + rowData.trCode + '  ' + rowData.trName + "</option>" );
		// 팝업닫기
		// 레이어팝업 정보 초기화
		$ ( "#divTaxSubCodeHelperPop" ).css ( 'display', 'none' );
		$ ( "#" + pLocationId ).empty ( );
		$ ( "#txtCodeSearch" ).val ( '' );

		// KEY EVENT DELETE
		$ ( '.subSearch' ).unbind ( );
		$ ( '.onSel' ).unbind ( );
		$ ( '#' + locationId ).unbind ( );
		$ ( "#selETAXTY" ).focus ( );
	}

}

function fnPopClose ( ) {
	$ ( "#divCodeHelperPop" ).css ( 'display', 'none' );
	$ ( "#divCodePopLayer" ).empty ( );
	$ ( "#hdnPopupData" ).val ( '' );
	$ ( "#hdnInputPopupInfo" ).val ( '' );
	$ ( "#txtCodeSearch" ).val ( '' );
}

function fnTaxPopClose ( ) {
	// 종속 거래처 팝업 초기화
	fnSubPopClose ( );
	$ ( "#divTaxCodeHelperPop" ).css ( 'display', 'none' );
	$ ( "#divTaxCodePopLayer" ).empty ( );
	$ ( "#hdnInputPopupInfo" ).val ( '' );
	$ ( "#hdnPopupData" ).val ( '' );
	$ ( "#selTRCD option:eq(0)" ).remove ( );
}

function fnSubPopClose ( ) {
	$ ( "#divTaxSubCodeHelperPop" ).css ( 'display', 'none' );
	$ ( "#divTaxSubCodePopLayer" ).empty ( );
	$ ( "#hdnPopupData" ).val ( '' );
	$ ( "#txtSubCodeSearch" ).val ( '' );
}

/* 사용자 입력 코드팝업 도움창 */
function fnPreCodePopSearch ( jsonDataId, searchStr, tableName, headJson, codeTableType ) {
	if ( searchStr.length > 0 ) {
		var data = $ ( "#" + jsonDataId ).val ( );
		var jsonArr = JSON.parse ( data );
		var resultJsonArr = [ ];
		for ( var i = 0; i < jsonArr.length; i++ ) {
			$.each ( jsonArr [ i ], function ( key, value ) {
				if ( value.indexOf ( searchStr ) !== -1 ) {
					resultJsonArr.push ( jsonArr [ i ] );
				}
			} );
		}
		$ ( "#" + tableName ).empty ( );
		tableName = tableName.replace ( '_TABLE', '' );
		$.devTable.addrowCodeData ( headJson, resultJsonArr, codeTableType, tableName )

	} else {
		var data = $ ( "#" + jsonDataId ).val ( );
		var jsonArr = JSON.parse ( data );
		$ ( "#" + tableName ).empty ( );
		tableName = tableName.replace ( '_TABLE', '' );
		$.devTable.addrowCodeData ( headJson, jsonArr, codeTableType, tableName )
	}
}

function fnGetRowData ( target, rowIdx ) {
	var row = $ ( target ).find ( 'tr' ).eq ( rowIdx );
	var input = $ ( row ).find ( 'td input' );
	var rowValue = {};
	$.each ( input, function ( idx, inp ) {
		var key = $ ( inp ).attr ( 'id' ).toString ( ).substring ( 0, $ ( inp ).attr ( 'id' ).toString ( ).indexOf ( '_' ) );
		rowValue [ key ] = $ ( inp ).data ( key ) == undefined ? {
			key: $ ( inp ).val ( )
		} : $ ( inp ).data ( key );
	} );
}

/* 전자 세금 계산서 매입 거래처 데이터 불러오기 */
function fnGetETaxPater ( ) {
	var item = {};
	item.id = "TR";
	var bindId = '';
	/* ========================== */
	/*
	 * 데이터 호출 로직 /*==========================
	 */
	fnLoadRequestData ( bindId, item );
	/* 로직 완료 후 그리기 */
	$ ( "#divTaxSubCodeHelperPop" ).css ( 'display', 'block' );
	/* uctable 코드팝업 그리드 헤더 생성 */
	$.devTable.createCodeHelper ( headjson, 'divTaxSubCodePopLayer', '1', '350px', 'N' );
	/* 데이터 바인드 */
	$.devTable.addrowCodeData ( headjson, dataJson, '1', 'divTaxSubCodePopLayer' );
	/* 코드도움창 키이벤트 등록 */
	fnLayerSubCodePopKeyEvent ( event, 'divTaxSubCodePopLayer', 'hdnPopupData', '', headjson, '1' );
	// 현재 팝업 더에터 저장
	$ ( "#hdnPopupData" ).val ( JSON.stringify ( dataJson ) );
}

/* 코드 팝업 바인드 */
/* --------------------------------------- */
function fnBindCode ( bindId, rowData ) {
	var codeDiv = bindId.split ( '_' ) [ 0 ];
	switch ( codeDiv ) {
		case zl.wlrmqrnqns:
			/* 지급구분 */
			$ ( '#' + bindId ).val ( rowData.payFgName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.rnrrhqhwhtkdjq:
			/* 국고보조사업 */
			$ ( '#' + bindId ).val ( rowData.ddtlbzName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.dlcprPwhkrnqns:
			/* 이체계좌구분 */
			$ ( '#' + bindId ).val ( rowData.transFracnutSeDName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.wkrPwhkdlcptkdbzhem:
			/* 자계좌이체사유코드 */
			$ ( '#' + bindId ).val ( rowData.sbsAcnttrfrSnDName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.wmdqldrnqns:
			/* 증빙구분 */
			$ ( '#' + bindId ).val ( rowData.prufseName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.wmdqldtmddlsqjsgh:
			/* 증빙승인번호 */
			fnTaxPopClose ( );
			var prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';
			if ( prufseCode == '001' || prufseCode == '002' ) {
				$ ( '#' + bindId ).val ( rowData.issNumber );
				$ ( '#' + bindId ).data ( codeDiv, rowData );
				var issData = rowData.issData || '';
				if ( issData.length == 8 ) {
					$ ( '#' + bindId ).parent ( ).next ( 'td' ).find ( 'input' ).val ( [ rowData.issData.substring ( 0, 4 ), rowData.issData.substring ( 4, 6 ), rowData.issData.substring ( 6, 8 ) ].join ( '/' ) );
				}
			} else if ( prufseCode == '004' ) {
				$ ( '#' + bindId ).val ( rowData.PUCHAS_TKBAK_NO );
				$ ( '#' + bindId ).data ( codeDiv, rowData );
				var CONFM_DE = rowData.CONFM_DE || '';
				if ( CONFM_DE.length == 8 ) {
					$ ( '#' + bindId ).parent ( ).next ( 'td' ).find ( 'input' ).val ( [ rowData.CONFM_DE.substring ( 0, 4 ), rowData.CONFM_DE.substring ( 4, 6 ), rowData.CONFM_DE.substring ( 6, 8 ) ].join ( '/' ) );
				}
			}
			break;
		case zl.rjfocjrnqns:
			/* 거래처구분 */
			$ ( '#' + bindId ).val ( rowData.bcncseName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.wmdqldzhem:
			/* 코드 */
			/* 코드 - 코드 */
			$ ( '#' + bindId ).val ( rowData.trCode );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			/* 추가코드 바인딩 */
			var inpId = bindId.split ( '_' ) [ 0 ] || '';
			var rowSeq = bindId.split ( '_' ) [ 1 ] || '0';
			var colSeq = bindId.split ( '_' ) [ 2 ] || '0';
			var partnerInfo = {
				attrName: rowData.attrName,
				attrNameKr: rowData.attrName,
				baNumber: rowData.baNumber,
				ceoName: rowData.ceoName,
				cetNameKr: rowData.ceoName,
				eMail: "",
				interDt: rowData.interDt,
				interRt: "",
				jeonjaYN: rowData.jeonjaYN,
				jiroCode: rowData.jiroCode,
				liqRs: rowData.liqRs,
				regNumber: rowData.regNumber,
				trchargeEMail: "",
				trCode: rowData.trCode,
				trFgCode: rowData.trFgCode,
				trFgName: rowData.trFgName,
				trName: rowData.trName,
				trNameKr: rowData.trName,
				trAddress: "",
				telNumber: ""
			};
			
			var ajaxParam = {};
			ajaxParam.regNb = partnerInfo.regNumber || '';
			
			$.ajax ( {
				async: false,
				type: "post",
				data: ajaxParam,
				url: domain + '/exp/expend/angu/LinkPartnerInfoS.do',
				datatype: "json",
				success: function ( resultValue ) {
					var oldInfo = $ ( '#' + [ zl.wmdqldzhem, rowSeq, ( Number ( colSeq ) + 0 ) ].join ( '_' ) ).data ( zl.wmdqldzhem );
					if ( ( resultValue.result.aData.trCode || '' ) != '' ) {
						var newInfo = resultValue.result.aData || {};
						oldInfo.attrName = ( newInfo.attrName || '' ) != '' ? newInfo.attrName : oldInfo.attrName;
						oldInfo.attrNameKr = ( newInfo.attrNameKr || '' ) != '' ? newInfo.attrNameKr : oldInfo.attrNameKr;
						oldInfo.baNumber = ( newInfo.baNumber || '' ) != '' ? newInfo.baNumber : oldInfo.baNumber;
						oldInfo.ceoName = ( newInfo.ceoName || '' ) != '' ? newInfo.ceoName : oldInfo.ceoName;
						oldInfo.cetNameKr = ( newInfo.cetNameKr || '' ) != '' ? newInfo.cetNameKr : oldInfo.cetNameKr;
						oldInfo.eMail = ( newInfo.eMail || '' ) != '' ? newInfo.eMail : oldInfo.eMail;
						oldInfo.interDt = ( newInfo.interDt || '' ) != '' ? newInfo.interDt : oldInfo.interDt;
						oldInfo.interRt = ( newInfo.interRt || '' ) != '' ? newInfo.interRt : oldInfo.interRt;
						oldInfo.jeonjaYN = ( newInfo.jeonjaYN || '' ) != '' ? newInfo.jeonjaYN : oldInfo.jeonjaYN;
						oldInfo.jiroCode = ( newInfo.jiroCode || '' ) != '' ? newInfo.jiroCode : oldInfo.jiroCode;
						oldInfo.liqRs = ( newInfo.liqRs || '' ) != '' ? newInfo.liqRs : oldInfo.liqRs;
						oldInfo.regNumber = ( newInfo.regNumber || '' ) != '' ? newInfo.regNumber : oldInfo.regNumber;
						oldInfo.trchargeEMail = ( newInfo.trchargeEMail || '' ) != '' ? newInfo.trchargeEMail : oldInfo.trchargeEMail;
						oldInfo.trCode = ( newInfo.trCode || '' ) != '' ? newInfo.trCode : oldInfo.trCode;
						oldInfo.trFgCode = ( newInfo.trFgCode || '' ) != '' ? newInfo.trFgCode : oldInfo.trFgCode;
						oldInfo.trFgName = ( newInfo.trFgName || '' ) != '' ? newInfo.trFgName : oldInfo.trFgName;
						oldInfo.trName = ( newInfo.trName || '' ) != '' ? newInfo.trName : oldInfo.trName;
						oldInfo.trNameKr = ( newInfo.trNameKr || '' ) != '' ? newInfo.trNameKr : oldInfo.trNameKr;

						/* 거래처명 */
						$ ( '#' + [ zl.rjfocjaud, rowSeq, ( Number ( colSeq ) + 1 ) ].join ( '_' ) ).val ( oldInfo.trName || '' );
						/* 입금계좌번호 */
						$ ( '#' + [ zl.dlqrmarPwhkqjsgh, rowSeq, ( Number ( colSeq ) + 3 ) ].join ( '_' ) ).val ( oldInfo.baNumber || '' );
						/* 거래처사업자/주민번호 */
						$ ( '#' + [ zl.rjfocjtkdjqwkwnalsqjsgh, rowSeq, ( Number ( colSeq ) + 6 ) ].join ( '_' ) ).val ( oldInfo.regNumber || '' );
						/* 사업장주소 */
						$ ( '#' + [ zl.tkdjqwkdwnth, rowSeq, ( Number ( colSeq ) + 7 ) ].join ( '_' ) ).val ( oldInfo.trAddress || '' );
						/* 대표자명 */
						$ ( '#' + [ zl.eovywkaud, rowSeq, ( Number ( colSeq ) + 8 ) ].join ( '_' ) ).val ( oldInfo.ceoName || '' );
						/* 전화번호 */
						$ ( '#' + [ zl.wjsghkqjsgh, rowSeq, ( Number ( colSeq ) + 9 ) ].join ( '_' ) ).val ( oldInfo.telNumber || '' );
						/* 데이터 다시 저장 */
						$ ( '#' + [ zl.wmdqldzhem, rowSeq, ( Number ( colSeq ) + 0 ) ].join ( '_' ) ).data ( zl.wmdqldzhem, oldInfo );

						/* 금융기관 */
						var bankInfo = {};
						bankInfo.bankCode = newInfo.bankCode || '';
						bankInfo.bankName = newInfo.bankName || '';
						bankInfo.bankNameKr = newInfo.bankNameKr || '';

						$ ( '#' + [ zl.rmadbdrlrhks, rowSeq, ( Number ( colSeq ) + 2 ) ].join ( '_' ) ).val ( bankInfo.bankName );
						$ ( '#' + [ zl.rmadbdrlrhks, rowSeq, ( Number ( colSeq ) + 2 ) ].join ( '_' ) ).data ( zl.rmadbdrlrhks, bankInfo );
					}
				},
				error: function ( err ) {
					console.log ( err );
				}
			} );
			/* 코드 - 거래처명 */
			// $ ( '#BCNCCMPNY_' + rowSeq + '_' + ( Number ( colSeq ) + 1 ) ).val ( rowData.trName );
			/* 코드 - 입금계좌번호 */
			/*
			 * $('#BCNCACNUT_' + rowSeq + '_' + (Number(colSeq) + 3)).val(rowData.baNumber);
			 */
			/* 코드 - 거래처 사업자/주민번호 */
			/*
			 * $('#BCNCLSFT_' + rowSeq + '_' + (Number(colSeq) + 6)).val(rowData.regNumber);
			 */
			/* 코드 - 대표자명 */
			/*
			 * $('#BCNCRPRSNTV_' + rowSeq + '_' + (Number(colSeq) + 8)).val(rowData.ceoName);
			 */
			break;
		case zl.rmadbdrlrhks:
			/* 금융기관 */
			$ ( '#' + bindId ).val ( rowData.bankName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.qhwhqlahrtpahrzhem:
			/* 보조비목세목코드 */
			$ ( '#' + bindId ).val ( rowData.asstnExpitmTaxitmCode );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			/* 추가코드 바인딩 */
			var inpId = bindId.split ( '_' ) [ 0 ] || '';
			var rowSeq = bindId.split ( '_' ) [ 1 ] || '0';
			var colSeq = bindId.split ( '_' ) [ 2 ] || '0';
			/* 보조비목세목코드 - 보조비목명 */
			$ ( '#ASSTNEXPITM_' + rowSeq + '_' + ( Number ( colSeq ) + 1 ) ).val ( rowData.asstnExpitmName );
			/* 보조비목세목코드 - 보조세목명 */
			$ ( '#ASSTNTAXITM_' + rowSeq + '_' + ( Number ( colSeq ) + 2 ) ).val ( rowData.asstnTaxitmName );
			break;
		case zl.wodnjsrnqns:
			/* 재원구분 */
			$ ( '#' + bindId ).val ( rowData.fnrscseDName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.vmfhwprxm:
			/* 프로젝트 */
			$ ( '#' + bindId ).val ( rowData.pjtName );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			break;
		case zl.dPtksrhkahr:
			/* 예산과목 */
			for ( var i = 1; i < 8; i++ ) {
				if ( rowData [ 'BGT0' + i + '_NM' ] != undefined && rowData [ 'BGT0' + i + '_NM' ] != '' ) {
					$ ( '#' + bindId ).val ( rowData [ 'BGT0' + i + '_NM' ] );
					$ ( '#' + bindId ).data ( codeDiv, rowData );
					break;
				}
			}
			break;
		case zl.wodnjszhem:
			/* 코드 */
			$ ( '#' + bindId ).val ( rowData.trCode );
			$ ( '#' + bindId ).data ( codeDiv, rowData );
			/* 코드-출금계좌 */
			var inpId = bindId.split ( '_' ) [ 0 ] || '';
			var rowSeq = bindId.split ( '_' ) [ 1 ] || '0';
			var colSeq = bindId.split ( '_' ) [ 2 ] || '0';
			$ ( '#' + [ 'BTRNUM', rowSeq, ( Number ( colSeq ) + 1 ) ].join ( '_' ) ).val ( rowData.attrName );
			break;
		case zl.rhdrmqrkdor:
		case zl.qnrktp:
			alert ( '1' );
			break;
	}
}

function fnSetAnbojoValue ( focusJsonList, inp ) {
	// SEQ
	var pTr = $ ( inp ).parent ( ).parent ( );
	var pTblId = $ ( pTr ).parent ( ).attr ( 'id' );

	switch ( pTblId ) {
		case 'resolveContent_TRDATA':
			if ( $ ( pTr ).attr ( 'mseq' ) === undefined ) {
				seq.maxMSeq = ( seq.maxMSeq + 1 );
				$ ( pTr ).attr ( 'mseq', seq.maxMSeq );
				seq.selMSeq = $ ( pTr ).attr ( 'mseq' );
			} else {
				seq.selMSeq = $ ( pTr ).attr ( 'mseq' );
			}

			/* 증빙내역 */
			var authTbl = $ ( '#authContent_TRDATA tr' );
			$.each ( authTbl, function ( idx, tr ) {
				if ( $ ( tr ).attr ( 'mseq' ) == undefined ) {
					$ ( tr ).css ( 'display', '' );
				} else if ( $ ( tr ).attr ( 'mseq' ) == $ ( pTr ).attr ( 'mseq' ) ) {
					$ ( tr ).css ( 'display', '' );
				} else {
					$ ( tr ).css ( 'display', 'none' );
				}
			} );

			/* 비목내역 */
			var bimokTbl = $ ( '#bimokContent_TRDATA tr' );
			$.each ( bimokTbl, function ( idx, tr ) {
				$ ( tr ).css ( 'display', 'none' );
				$ ( '#bimokContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
			} );

			/* 재원내역 */
			var jaewonTbl = $ ( '#jaewonContent_TRDATA tr' );
			$.each ( jaewonTbl, function ( idx, tr ) {
				$ ( tr ).css ( 'display', 'none' );
				$ ( '#jaewonContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
			} );
			break;
		case 'authContent_TRDATA':
			if ( $ ( pTr ).attr ( 'mseq' ) === undefined ) {
				$ ( pTr ).attr ( 'mseq', seq.selMSeq );
			}

			if ( $ ( pTr ).attr ( 'lseq' ) === undefined ) {
				seq.maxLSeq = ( seq.maxLSeq + 1 );
				$ ( pTr ).attr ( 'lseq', seq.maxLSeq );
				seq.selLSeq = $ ( pTr ).attr ( 'lseq' );
			} else {
				seq.selLSeq = $ ( pTr ).attr ( 'lseq' );
			}

			/* 비목내역 */
			var bimokTbl = $ ( '#bimokContent_TRDATA tr' );
			$.each ( bimokTbl, function ( idx, tr ) {
				if ( $ ( pTr ).attr ( 'lseq' ) == undefined ) {
					$ ( tr ).css ( 'display', '' );
					$ ( '#bimokContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', '' );
				} else if ( $ ( tr ).attr ( 'mseq' ) == $ ( pTr ).attr ( 'mseq' ) ) {
					if ( $ ( tr ).attr ( 'lseq' ) == $ ( pTr ).attr ( 'lseq' ) ) {
						$ ( tr ).css ( 'display', '' );
						$ ( '#bimokContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', '' );
					} else {
						$ ( tr ).css ( 'display', 'none' );
						$ ( '#bimokContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
					}
				} else {
					$ ( tr ).css ( 'display', 'none' );
					$ ( '#bimokContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
				}
			} );

			/* 재원내역 */
			var jaewonTbl = $ ( '#jaewonContent_TRDATA tr' );
			$.each ( jaewonTbl, function ( idx, tr ) {
				$ ( tr ).css ( 'display', 'none' );
				$ ( '#jaewonContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
			} );
			break;
		case 'bimokContent_TRDATA':
			if ( $ ( pTr ).attr ( 'mseq' ) === undefined ) {
				$ ( pTr ).attr ( 'mseq', seq.selMSeq );
			}

			if ( $ ( pTr ).attr ( 'lseq' ) === undefined ) {
				$ ( pTr ).attr ( 'lseq', seq.selLSeq );
			}

			if ( $ ( pTr ).attr ( 'sseq' ) === undefined ) {
				seq.maxSSeq = ( seq.maxSSeq + 1 );
				$ ( pTr ).attr ( 'sseq', seq.maxSSeq );
				seq.selSSeq = $ ( pTr ).attr ( 'sseq' );
			} else {
				seq.selSSeq = $ ( pTr ).attr ( 'sseq' );
			}

			/* 재원내역 */
			var jaewonTbl = $ ( '#jaewonContent_TRDATA tr' );
			$.each ( jaewonTbl, function ( idx, tr ) {
				if ( $ ( tr ).attr ( 'sseq' ) == undefined ) {
					$ ( tr ).css ( 'display', '' );
					$ ( '#jaewonContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', '' );
				} else if ( $ ( tr ).attr ( 'mseq' ) == $ ( pTr ).attr ( 'mseq' ) ) {
					if ( $ ( tr ).attr ( 'lseq' ) == $ ( pTr ).attr ( 'lseq' ) ) {
						if ( $ ( tr ).attr ( 'sseq' ) == $ ( pTr ).attr ( 'sseq' ) ) {
							$ ( tr ).css ( 'display', '' );
							$ ( '#jaewonContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', '' );
						} else {
							$ ( tr ).css ( 'display', 'none' );
							$ ( '#jaewonContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
						}
					} else {
						$ ( tr ).css ( 'display', 'none' );
						$ ( '#jaewonContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
					}
				} else {
					$ ( tr ).css ( 'display', 'none' );
					$ ( '#jaewonContent_TRDATA_FIX tr' ).eq ( $ ( tr ).index ( ) ).css ( 'display', 'none' );
				}
			} );
			break;
		case 'jaewonContent_TRDATA':
			if ( $ ( pTr ).attr ( 'mseq' ) === undefined ) {
				$ ( pTr ).attr ( 'mseq', seq.selMSeq );
			}

			if ( $ ( pTr ).attr ( 'lseq' ) === undefined ) {
				$ ( pTr ).attr ( 'lseq', seq.selLSeq );
			}

			if ( $ ( pTr ).attr ( 'sseq' ) === undefined ) {
				$ ( pTr ).attr ( 'sseq', seq.selSSeq );
			}

			if ( $ ( pTr ).attr ( 'dseq' ) === undefined ) {
				seq.maxDSeq = ( seq.maxDSeq + 1 );
				$ ( pTr ).attr ( 'dseq', seq.maxDSeq );
				seq.selDSeq = $ ( pTr ).attr ( 'dseq' );
			} else {
				seq.selDSeq = $ ( pTr ).attr ( 'dseq' );
			}
			break;
	}

	var resolveTr = $ ( '#resolveContent_TRDATA tr' );
	$.each ( resolveTr, function ( idxTr, tr ) {
		var mSeq = $ ( tr ).attr ( 'mseq' );
		if ( !anbojoValue [ 'resolve' ] ) {
			anbojoValue [ 'resolve' ] = {};
		}

		var tds = $ ( tr ).find ( 'td' );
		$.each ( tds, function ( idxTd, td ) {
			var tdInfo = {};
			var id = $ ( td ).find ( 'input' ).attr ( 'id' ).split ( '_' ) [ 0 ];
			if ( !anbojoValue [ 'resolve' ] [ mSeq ] ) {
				anbojoValue [ 'resolve' ] [ mSeq ] = {};
			}

			anbojoValue [ 'resolve' ] [ mSeq ] [ id ] = {};
			switch ( id ) {
				case zl.dlf:
					/* 일 */
					anbojoValue [ 'resolve' ] [ mSeq ] [ id ] = {
						GISUDT: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.tkdjqduseh:
					/* 사업연도 */
					anbojoValue [ 'resolve' ] [ mSeq ] [ id ] = {
						BSNSYEAR: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.wlqgoddydeh:
					/* 집행용도 */
					anbojoValue [ 'resolve' ] [ mSeq ] [ id ] = {
						EXCUTPRPOS: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.wmdqlddlfwk:
					/* 증빙일자 */
					anbojoValue [ 'resolve' ] [ mSeq ] [ id ] = {
						EXCUTERQUST: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.wkrPwhkdlcptkdb:
					anbojoValue [ 'resolve' ] [ mSeq ] [ id ] = {
						SBSACNTTRFRSNCN: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				default:
					anbojoValue [ 'resolve' ] [ mSeq ] [ id ] = $ ( td ).find ( 'input' ).data ( id )
					break;
			}
		} );
	} );
	var authTr = $ ( '#authContent_TRDATA tr' );
	$.each ( authTr, function ( idxTr, tr ) {
		var mSeq = $ ( tr ).attr ( 'mseq' );
		var lSeq = $ ( tr ).attr ( 'lseq' );
		var key = mSeq + '|' + lSeq;
		if ( !anbojoValue [ 'auth' ] ) {
			anbojoValue [ 'auth' ] = {};
		}

		var tds = $ ( tr ).find ( 'td' );
		$.each ( tds, function ( idxTd, td ) {
			var tdInfo = {};
			var id = $ ( td ).find ( 'input' ).attr ( 'id' ).split ( '_' ) [ 0 ];
			if ( !anbojoValue [ 'auth' ] [ key ] ) {
				anbojoValue [ 'auth' ] [ key ] = {};
			}

			anbojoValue [ 'auth' ] [ key ] [ id ] = {};
			switch ( id ) {
				case zl.rjfocjaud:
					/* 거래처명 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						BCNCCMPNY: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.dlqrmarPwhkqjsgh:
					/* 입금계좌번호 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						BCNCACNUT: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.qhwhrmaxhdwkdvytlsodyd:
					/* 보조금통장표시내용 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						SBSIDYBANKINDICT: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.rjfocjxhdwkdvytlsodyd:
					/* 거래처통장표시내용 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						BCNCBNKBINDICT: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.rjfocjtkdjqwkwnalsqjsgh:
					/* 거래처 사업자/주민번호 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						BCNCLSFT: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.tkdjqwkdwnth:
					/* 사업장주소 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						BCNCADRES: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.eovywkaud:
					/* 대표자명 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						BCNCRPRSNTV: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.wjsghkqjsgh:
					/* 전화번호 */
					anbojoValue [ 'auth' ] [ key ] [ id ] = {
						BCNCTELNO: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				default:
					anbojoValue [ 'auth' ] [ key ] [ id ] = $ ( td ).find ( 'input' ).data ( id )
					break;
			}
		} );
	} );
	var bimokTr = $ ( '#bimokContent_TRDATA tr' );
	$.each ( bimokTr, function ( idxTr, tr ) {
		var mSeq = $ ( tr ).attr ( 'mseq' );
		var lSeq = $ ( tr ).attr ( 'lseq' );
		var sSeq = $ ( tr ).attr ( 'sseq' );
		var key = mSeq + '|' + lSeq + '|' + sSeq;
		if ( !anbojoValue [ 'bimok' ] ) {
			anbojoValue [ 'bimok' ] = {};
		}

		var tds = $ ( tr ).find ( 'td' );
		$.each ( tds, function ( idxTd, td ) {
			var tdInfo = {};
			var id = $ ( td ).find ( 'input' ).attr ( 'id' ).split ( '_' ) [ 0 ];
			if ( !anbojoValue [ 'bimok' ] [ key ] ) {
				anbojoValue [ 'bimok' ] [ key ] = {};
			}

			anbojoValue [ 'bimok' ] [ key ] [ id ] = {};
			switch ( id ) {
				case zl.qhwhqlahraud:
					/* 보조비목명 */
					anbojoValue [ 'bimok' ] [ key ] [ id ] = {
						ASSTNEXPITM: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.qhwhtpahraud:
					/* 보조세목명 */
					anbojoValue [ 'bimok' ] [ key ] [ id ] = {
						ASSTNTAXITM: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.vnaahr:
					/* 품목 */
					anbojoValue [ 'bimok' ] [ key ] [ id ] = {
						PRDLST: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				default:
					anbojoValue [ 'bimok' ] [ key ] [ id ] = $ ( td ).find ( 'input' ).data ( id )
					break;
			}
		} );
	} );
	var jaewonTr = $ ( '#jaewonContent_TRDATA tr' );
	$.each ( jaewonTr, function ( idxTr, tr ) {
		var mSeq = $ ( tr ).attr ( 'mseq' );
		var lSeq = $ ( tr ).attr ( 'lseq' );
		var sSeq = $ ( tr ).attr ( 'sseq' );
		var dSeq = $ ( tr ).attr ( 'dseq' );
		var key = mSeq + '|' + lSeq + '|' + sSeq + '|' + dSeq;
		if ( !anbojoValue [ 'jaewon' ] ) {
			anbojoValue [ 'jaewon' ] = {};
		}

		var tds = $ ( tr ).find ( 'td' );
		$.each ( tds, function ( idxTd, td ) {
			var tdInfo = {};
			var id = $ ( td ).find ( 'input' ).attr ( 'id' ).split ( '_' ) [ 0 ];
			if ( !anbojoValue [ 'jaewon' ] [ key ] ) {
				anbojoValue [ 'jaewon' ] [ key ] = {};
			}

			anbojoValue [ 'jaewon' ] [ key ] [ id ] = {};
			switch ( id ) {
				/* 증빙공급가, 증빙부가세, 증빙총금액, 등록공급가, 등록부가세 갱신 프로세스 수행 */
				case zl.wodnjsrnqns:
					anbojoValue [ 'jaewon' ] [ key ] [ id ] = $ ( td ).find ( 'input' ).data ( id );
					if ( anbojoValue [ 'jaewon' ] [ [ seq.selMSeq, seq.selLSeq, seq.selSSeq, seq.selDSeq ].join ( '|' ) ] != undefined && anbojoValue [ 'jaewon' ] [ [ seq.selMSeq, seq.selLSeq, seq.selSSeq, seq.selDSeq ].join ( '|' ) ] [ 'FNRSCSE' ] != undefined ) {
						var amountInfo = codeListParam.GetCode ( 'TOTALAMT' );
						/* 계획금액 */
						$ ( '#txtPlanAmount' ).val ( ( amountInfo.EXCUT_PLAN_AMOUNT || '0' ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
						/* 집행금액 */
						$ ( '#txtSumAmount' ).val ( ( amountInfo.SUM || '0' ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
						/* 집행잔액 */
						$ ( '#txtSubAmount' ).val ( ( amountInfo.SUB || '0' ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
						/* E나라도움 집행금액 */
						$ ( '#lblExcutAmount' ).html ( ( amountInfo.EXCUT_AMOUNT || '0' ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
						/* 미등록 집행금액 */
						$ ( '#lblSumAmount' ).html ( ( amountInfo.SUM_AMOUNT || '0' ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
					} else {
						/* 계획금액 */
						$ ( '#txtPlanAmount' ).val ( '-' );
						/* 집행금액 */
						$ ( '#txtSumAmount' ).val ( '-' );
						/* 집행잔액 */
						$ ( '#txtSubAmount' ).val ( '-' );
						/* E나라도움 집행금액 */
						$ ( '#lblExcutAmount' ).html ( '-' );
						/* 미등록 집행금액 */
						$ ( '#lblSumAmount' ).html ( '-' );
					}
					break;
				case 'BTRNUM':
					/* 출금계좌 */
					anbojoValue [ 'jaewon' ] [ key ] [ id ] = {
						BTRNUM: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.wlqgodrmador:
					/* 집행금액 */
					anbojoValue [ 'jaewon' ] [ key ] [ id ] = {
						AMOUNT: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.rhdrmqrkdor:
					/* 공급가액 */
					anbojoValue [ 'jaewon' ] [ key ] [ id ] = {
						SPLPC: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				case zl.qnrktp:
					/* 부가세 */
					anbojoValue [ 'jaewon' ] [ key ] [ id ] = {
						VAT: $ ( td ).find ( 'input' ).val ( )
					}
					break;
				default:
					anbojoValue [ 'jaewon' ] [ key ] [ id ] = $ ( td ).find ( 'input' ).data ( id );
					break;
			}
		} );
	} );

	/* input 예외처리 */
	var inpId = ( $ ( inp ).attr ( 'id' ) || '' ).toString ( ).split ( '_' ) [ 0 ] || '';
	switch ( inpId ) {
		case zl.wmdqldtmddlsqjsgh:
			/* 부모의 M 아이디를 획득하여, 현재 증빙구분값을 확인한다. */
			var prufseNoMSeq = $ ( inp ).parent ( ).parent ( ).attr ( 'mseq' );
			/* 현재 증빙구분값을 확인한다. 증빙구분의 값에 따라서, 세금게산서, 카드, 미입력등 분기가 발생된다. */
			var prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';
			if ( prufseCode == '001' ) {
				/* 증빙구분이 전자세금계산서인 경우 */
			} else if ( prufseCode == '002' ) {
				/* 증빙구분이 전자계산서인 경우 */
			} else if ( prufseCode == '004' ) {
				/* 증빙구분이 카드인 경우 */
			} else if ( prufseCode == '999' ) {
				/* 증빙구분이 기타인 경우 */
				// $(inp).parent().next('td:first').find('input').click().focus();
			}
			break;
		case zl.rjfocjrnqns:
			/* 거래처 구분 */
			if ( $ ( inp ).val ( ) == '' ) {
				$ ( inp ).val ( '법인거래' );
				$ ( inp ).data ( zl.rjfocjrnqns, {
					bcncseCode: '001',
					bcncseName: '법인거래'
				} );
			}

			var prufseNoMSeq = $ ( inp ).parent ( ).parent ( ).attr ( 'mseq' );
			var prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';
			var partnerInfo = {};

			if ( prufseCode == '001' || prufseCode == '002' || prufseCode == '004' ) {
				var prufseNo = anbojoValue [ 'resolve' ] [ '1' ] [ zl.wmdqldtmddlsqjsgh ] || {};
				var inpId = $ ( inp ).attr ( 'id' ).split ( '_' ) [ 0 ] || '';
				var rowSeq = $ ( inp ).attr ( 'id' ).split ( '_' ) [ 1 ] || '0';
				var colSeq = $ ( inp ).attr ( 'id' ).split ( '_' ) [ 2 ] || '0';
				
				if ( prufseCode == '004' ) {
					/* 증빙공급가 */
					$('#txtAuthAmt').val('0');
					/* 증빙부가세 */
					$('#txtAuthVat').val('0');
					/* 증빙총금액 */
					$('#txtAuthTotalAmt').val((prufseNo.PUCHAS_TAMT || '0').toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ));
					/* 등록공급가 */
					/* $('#txtAppAmt').val((prufseNo.EXCUT_SUM_AMOUNT||'0').toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' )); */
					/* 등록부가세 */
					/* $('#txtAppVat').val('0'); */
					$('#txtAppTotalAmt').val((prufseNo.EXCUT_SUM_AMOUNT || '0').toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ));
				} else {
					/* 증빙공급가 */
					$('#txtAuthAmt').val('0');
					/* 증빙부가세 */
					$('#txtAuthVat').val('0');
					/* 증빙총금액 */
					$('#txtAuthTotalAmt').val('0');
					/* 등록공급가 */
					/* $('#txtAppAmt').val('0'); */
					/* 등록부가세 */
					/* $('#txtAppVat').val('0'); */
					$('#txtAppTotalAmt').val('0');
				}

				switch ( prufseCode ) {
					case '001':
					case '002':
						$ ( '#' + [ zl.wmdqldzhem, rowSeq, ( Number ( colSeq ) + 1 ) ].join ( '_' ) ).val ( prufseNo.trCode );
						partnerInfo = {
							attrName: prufseNo.bcncCmpnayName,
							attrNameKr: prufseNo.bcncCmpnayName,
							baNumber: prufseNo.bcncAcnutNo,
							ceoName: prufseNo.bcncRprsntyName,
							cetNameKr: "",
							eMail: "",
							interDt: "",
							interRt: "",
							jeonjaYN: 0,
							jiroCode: prufseNo.duzonBankCode,
							liqRs: 0,
							regNumber: prufseNo.trRegNumber,
							trchargeEMail: "",
							trCode: prufseNo.trCode,
							trFgCode: 1,
							trFgName: "일반",
							trName: prufseNo.bcncCmpnayName,
							trNameKr: prufseNo.bcncCmpnayName,
							trAddress: prufseNo.bcncAddress,
							telNumber: prufseNo.bcncTelNo
						}
						break;
					case '004':
						partnerInfo = {
							attrName: prufseNo.MRHST_NM,
							attrNameKr: prufseNo.MRHST_NM,
							baNumber: "",
							ceoName: prufseNo.BCNC_RPRSNTV_NM,
							cetNameKr: "",
							eMail: "",
							interDt: "",
							interRt: "",
							jeonjaYN: 0,
							jiroCode: "",
							liqRs: 0,
							regNumber: prufseNo.BCNC_LSFT_NO,
							trchargeEMail: "",
							trCode: "",
							trFgCode: 1,
							trFgName: "일반",
							trName: prufseNo.MRHST_NM,
							trNameKr: prufseNo.MRHST_NM,
							trAddress: prufseNo.BCNC_ADRES2,
							telNumber: prufseNo.BCNC_TELNO
						}
						break;
				}

				$ ( '#' + [ zl.wmdqldzhem, rowSeq, ( Number ( colSeq ) + 1 ) ].join ( '_' ) ).data ( zl.wmdqldzhem, partnerInfo );
				/* 거래처명 */
				$ ( '#' + [ zl.rjfocjaud, rowSeq, ( Number ( colSeq ) + 2 ) ].join ( '_' ) ).val ( partnerInfo.trName || '' );
				/* 입금계좌번호 */
				$ ( '#' + [ zl.dlqrmarPwhkqjsgh, rowSeq, ( Number ( colSeq ) + 4 ) ].join ( '_' ) ).val ( partnerInfo.baNumber || '' );
				/* 거래처사업자/주민번호 */
				$ ( '#' + [ zl.rjfocjtkdjqwkwnalsqjsgh, rowSeq, ( Number ( colSeq ) + 7 ) ].join ( '_' ) ).val ( partnerInfo.regNumber || '' );
				/* 사업장주소 */
				$ ( '#' + [ zl.tkdjqwkdwnth, rowSeq, ( Number ( colSeq ) + 8 ) ].join ( '_' ) ).val ( partnerInfo.trAddress || '' );
				/* 대표자명 */
				$ ( '#' + [ zl.eovywkaud, rowSeq, ( Number ( colSeq ) + 9 ) ].join ( '_' ) ).val ( partnerInfo.ceoName || '' );
				/* 전화번호 */
				$ ( '#' + [ zl.wjsghkqjsgh, rowSeq, ( Number ( colSeq ) + 10 ) ].join ( '_' ) ).val ( partnerInfo.telNumber || '' );
				/* 보조금통장표시내용 */
				$ ( '#' + [ zl.qhwhrmaxhdwkdvytlsodyd, rowSeq, ( Number ( colSeq ) + 5 ) ].join ( '_' ) ).val ( $ ( '#' + [ zl.qhwhrmaxhdwkdvytlsodyd, rowSeq, ( Number ( colSeq ) + 10 ) ].join ( '_' ) ).val ( ) || iCUBEOptionInfo.trRmk );
				/* 거래처통장표시내용 */
				$ ( '#' + [ zl.rjfocjxhdwkdvytlsodyd, rowSeq, ( Number ( colSeq ) + 6 ) ].join ( '_' ) ).val ( $ ( '#' + [ zl.rjfocjxhdwkdvytlsodyd, rowSeq, ( Number ( colSeq ) + 11 ) ].join ( '_' ) ).val ( ) || iCUBEOptionInfo.bojoRmk );

				var ajaxParam = {};
				ajaxParam.regNb = partnerInfo.regNumber || '';

				$.ajax ( {
					async: false,
					type: "post",
					data: ajaxParam,
					url: domain + '/exp/expend/angu/LinkPartnerInfoS.do',
					datatype: "json",
					success: function ( resultValue ) {
						var oldInfo = $ ( '#' + [ zl.wmdqldzhem, rowSeq, ( Number ( colSeq ) + 1 ) ].join ( '_' ) ).data ( zl.wmdqldzhem );
						if ( ( resultValue.result.aData.trCode || '' ) != '' ) {
							var newInfo = resultValue.result.aData || {};
							oldInfo.attrName = ( newInfo.attrName || '' ) != '' ? newInfo.attrName : oldInfo.attrName;
							oldInfo.attrNameKr = ( newInfo.attrNameKr || '' ) != '' ? newInfo.attrNameKr : oldInfo.attrNameKr;
							oldInfo.baNumber = ( newInfo.baNumber || '' ) != '' ? newInfo.baNumber : oldInfo.baNumber;
							oldInfo.ceoName = ( newInfo.ceoName || '' ) != '' ? newInfo.ceoName : oldInfo.ceoName;
							oldInfo.cetNameKr = ( newInfo.cetNameKr || '' ) != '' ? newInfo.cetNameKr : oldInfo.cetNameKr;
							oldInfo.eMail = ( newInfo.eMail || '' ) != '' ? newInfo.eMail : oldInfo.eMail;
							oldInfo.interDt = ( newInfo.interDt || '' ) != '' ? newInfo.interDt : oldInfo.interDt;
							oldInfo.interRt = ( newInfo.interRt || '' ) != '' ? newInfo.interRt : oldInfo.interRt;
							oldInfo.jeonjaYN = ( newInfo.jeonjaYN || '' ) != '' ? newInfo.jeonjaYN : oldInfo.jeonjaYN;
							oldInfo.jiroCode = ( newInfo.jiroCode || '' ) != '' ? newInfo.jiroCode : oldInfo.jiroCode;
							oldInfo.liqRs = ( newInfo.liqRs || '' ) != '' ? newInfo.liqRs : oldInfo.liqRs;
							oldInfo.regNumber = ( newInfo.regNumber || '' ) != '' ? newInfo.regNumber : oldInfo.regNumber;
							oldInfo.trchargeEMail = ( newInfo.trchargeEMail || '' ) != '' ? newInfo.trchargeEMail : oldInfo.trchargeEMail;
							oldInfo.trCode = ( newInfo.trCode || '' ) != '' ? newInfo.trCode : oldInfo.trCode;
							oldInfo.trFgCode = ( newInfo.trFgCode || '' ) != '' ? newInfo.trFgCode : oldInfo.trFgCode;
							oldInfo.trFgName = ( newInfo.trFgName || '' ) != '' ? newInfo.trFgName : oldInfo.trFgName;
							oldInfo.trName = ( newInfo.trName || '' ) != '' ? newInfo.trName : oldInfo.trName;
							oldInfo.trNameKr = ( newInfo.trNameKr || '' ) != '' ? newInfo.trNameKr : oldInfo.trNameKr;

							/* 거래처명 */
							$ ( '#' + [ zl.rjfocjaud, rowSeq, ( Number ( colSeq ) + 2 ) ].join ( '_' ) ).val ( oldInfo.trName || '' );
							/* 입금계좌번호 */
							$ ( '#' + [ zl.dlqrmarPwhkqjsgh, rowSeq, ( Number ( colSeq ) + 4 ) ].join ( '_' ) ).val ( oldInfo.baNumber || '' );
							/* 거래처사업자/주민번호 */
							$ ( '#' + [ zl.rjfocjtkdjqwkwnalsqjsgh, rowSeq, ( Number ( colSeq ) + 7 ) ].join ( '_' ) ).val ( oldInfo.regNumber || '' );
							/* 사업장주소 */
							$ ( '#' + [ zl.tkdjqwkdwnth, rowSeq, ( Number ( colSeq ) + 8 ) ].join ( '_' ) ).val ( oldInfo.trAddress || '' );
							/* 대표자명 */
							$ ( '#' + [ zl.eovywkaud, rowSeq, ( Number ( colSeq ) + 9 ) ].join ( '_' ) ).val ( oldInfo.ceoName || '' );
							/* 전화번호 */
							$ ( '#' + [ zl.wjsghkqjsgh, rowSeq, ( Number ( colSeq ) + 10 ) ].join ( '_' ) ).val ( oldInfo.telNumber || '' );
							/* 데이터 다시 저장 */
							$ ( '#' + [ zl.wmdqldzhem, rowSeq, ( Number ( colSeq ) + 1 ) ].join ( '_' ) ).data ( zl.wmdqldzhem, oldInfo );

							/* 금융기관 */
							var bankInfo = {};
							bankInfo.bankCode = newInfo.bankCode || '';
							bankInfo.bankName = newInfo.bankName || '';
							bankInfo.bankNameKr = newInfo.bankNameKr || '';

							$ ( '#' + [ zl.rmadbdrlrhks, rowSeq, ( Number ( colSeq ) + 3 ) ].join ( '_' ) ).val ( bankInfo.bankName );
							$ ( '#' + [ zl.rmadbdrlrhks, rowSeq, ( Number ( colSeq ) + 3 ) ].join ( '_' ) ).data ( zl.rmadbdrlrhks, bankInfo );
						}
					},
					error: function ( err ) {
						console.log ( err );
					}
				} );
			}
			break;
		case zl.qhwhrmaxhdwkdvytlsodyd:
			$ ( inp ).val ( $ ( inp ).val ( ) || iCUBEOptionInfo.trRmk );
			break;
		case zl.rjfocjxhdwkdvytlsodyd:
			$ ( inp ).val ( $ ( inp ).val ( ) || iCUBEOptionInfo.bojoRmk );
			break;
	}

	$ ( inp ).select ( );

	/* readonly 처리 */
	switch ( $ ( inp ).attr ( 'id' ).split ( '_' ) [ 0 ] ) {
		case zl.qhwhqlahraud:
		case zl.qhwhtpahraud:
		case zl.dlf:
		case zl.tkdjqduseh:
		case zl.wlqgodrmador:
		case zl.rjfocjaud:
			$ ( inp ).attr ( 'readonly', 'readonly' );
			break;
		case zl.dlcprPwhkrnqns:
		case zl.wkrPwhkdlcptkdbzhem:
		case zl.wkrPwhkdlcptkdb:
			if ( anbojoValue [ "resolve" ] [ seq.selMSeq ] [ zl.dlcprPwhkrnqns ] != undefined ) {
				var transFracnutSeDCode = anbojoValue [ "resolve" ] [ seq.selMSeq ] [ zl.dlcprPwhkrnqns ] [ "transFracnutSeDCode" ] || '';
				if ( transFracnutSeDCode == '001' ) {
					/* 거래처계좌로이체 */
					$ ( inp ).attr ( 'readonly', 'readonly' );
					focusJsonList [ 'resolveContent' ] [ 6 ] [ 'requierdYN' ] = 'N';
					focusJsonList [ 'resolveContent' ] [ 6 ] [ 'codeHelperYN' ] = 'N';
					focusJsonList [ 'resolveContent' ] [ 7 ] [ 'requierdYN' ] = 'N';
					focusJsonList [ 'resolveContent' ] [ 7 ] [ 'codeHelperYN' ] = 'N';
					// var rowSeq = $('input.focus').attr('id').split('_')[1];
					// $('PRUFSE_' + rowSeq + '_8').click().focus();
				} else if ( transFracnutSeDCode == '002' ) {
					/* 보조금계좌로이쳬 */
					$ ( inp ).removeAttr ( 'readonly' );
					if ( $ ( inp ).val ( ) == '-' ) {
						$ ( inp ).val ( '' );
					}
					focusJsonList [ 'resolveContent' ] [ 6 ] [ 'requierdYN' ] = 'Y';
					focusJsonList [ 'resolveContent' ] [ 6 ] [ 'codeHelperYN' ] = 'Y';
					focusJsonList [ 'resolveContent' ] [ 7 ] [ 'requierdYN' ] = 'N';
					focusJsonList [ 'resolveContent' ] [ 7 ] [ 'codeHelperYN' ] = 'N';
				}
			}
			break;
		case zl.wmdqldtmddlsqjsgh:
			var prufseCode = anbojoValue [ 'resolve' ] [ seq.selMSeq ] [ zl.wmdqldrnqns ] [ 'prufseCode' ] || '';
			if ( prufseCode == '999' ) {
				$ ( inp ).attr ( 'readonly', 'readonly' );
				focusJsonList [ 'resolveContent' ] [ 9 ] [ 'requierdYN' ] = 'N';
				focusJsonList [ 'resolveContent' ] [ 9 ] [ 'codeHelperYN' ] = 'N';
			} else {
				$ ( inp ).removeAttr ( 'readonly' );
				focusJsonList [ 'resolveContent' ] [ 9 ] [ 'requierdYN' ] = 'Y';
				focusJsonList [ 'resolveContent' ] [ 9 ] [ 'codeHelperYN' ] = 'Y';
			}
			break;
		case zl.rhdrmqrkdor:
		case zl.qnrktp:
			var rowIdx = $ ( inp ).attr ( 'id' ).split ( '_' ) [ 1 ];
			if ( $ ( '#SPLPC_' + rowIdx + '_6' ).attr ( 'change' ) == undefined ) {
				$ ( '#SPLPC_' + rowIdx + '_6' ).focusout ( function ( ) {
					var inputIdx = $ ( this ).attr ( 'id' ).split ( '_' ) [ 1 ];
					var splpc = Number ( $ ( '#SPLPC_' + rowIdx + '_6' ).val ( ).replace ( /,/g, '' ) );
					var vat = Number ( $ ( '#VAT_' + rowIdx + '_7' ).val ( ).replace ( /,/g, '' ) );
					$ ( '#AMOUNT_' + rowIdx + '_5' ).val ( ( splpc + vat ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
				} );
				$ ( '#SPLPC_' + rowIdx + '_6' ).attr ( 'change', 'change' );
			}
			if ( $ ( '#VAT_' + rowIdx + '_7' ).attr ( 'change' ) == undefined ) {
				$ ( '#VAT_' + rowIdx + '_7' ).focusout ( function ( ) {
					var inputIdx = $ ( this ).attr ( 'id' ).split ( '_' ) [ 1 ];
					var splpc = Number ( $ ( '#SPLPC_' + rowIdx + '_6' ).val ( ).replace ( /,/g, '' ) );
					var vat = Number ( $ ( '#VAT_' + rowIdx + '_7' ).val ( ).replace ( /,/g, '' ) );
					$ ( '#AMOUNT_' + rowIdx + '_5' ).val ( ( splpc + vat ).toString ( ).replace ( /\B(?=(\d{3})+(?!\d))/g, ',' ) );
				} );
				$ ( '#VAT_' + rowIdx + '_7' ).attr ( 'change', 'change' );
			}
			break;
	}
}