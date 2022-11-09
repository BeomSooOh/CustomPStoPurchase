/* 그리드 전달 파라미터 생성 */
var Grid = {
	/* ex) Grid.AttrArray(columns, 'title', ''); */
	AttrArray: function (obj, key, baseValue) {
		obj = (obj || []);
		key = (key || '');
		baseValue = (baseValue || '');

		var attrArray = [];

		if (key !== '') {
			$.each(obj, function (idx, item) {
				attrArray.push((item[key] || baseValue));
			});
		}
		return attrArray;
	}
};

/* ERP 옵션 조회 */
//var Option = {
//	iCUBE: {
//		/* 회계 */
//		ac: {
//			/* 회계 공통 키 */
//			key: '4',
//			/* 예산통제 구분 ( FG_TY ) */
//			mgt: {
//				value: '01',
//				getStat: function () {
//					/* 0 : 미사용 / 1 : 사용부서(부서) / 2 : 프로젝트(프로젝트)(기본값) */
//					if (optionSet &&
//						optionSet.erp &&
//						optionSet.erp[Option.iCUBE.ac.key] &&
//						optionSet.erp[Option.iCUBE.ac.key][this.value] &&
//						optionSet.erp[Option.iCUBE.ac.key][this.value]['FG_TY']) {
//						return (optionSet.erp[Option.iCUBE.ac.key][this.value]['FG_TY'] || '2');
//					} else {
//						return '0';
//					}
//				}
//			},
//			/* 원인행위 사용 여부 ( USE_YN ) */
//			cause: {
//				value: '05',
//				getStat: function () {
//					/* Y : 사용 / N : 미사용 */
//					return 'N'; /* 현재 옵션 미개발 */
//				}
//			},
//			/* 하위사업 사용 여부 ( USE_YN ) */
//			bottom: {
//				value: '14',
//				getStat: function () {
//					/* 0: 미사용 / 1 : 적용 */
//					if (optionSet &&
//						optionSet.erp &&
//						optionSet.erp[Option.iCUBE.ac.key] &&
//						optionSet.erp[Option.iCUBE.ac.key][this.value] &&
//						optionSet.erp[Option.iCUBE.ac.key][this.value]['USE_YN']
//					) {
//						return (((optionSet.erp[Option.iCUBE.ac.key][this.value]['USE_YN'] || '0') === '1') ? 'Y' : 'N');
//					} else {
//						return 'N';
//					}
//				}
//			}
//		}
//	}
//};

/* page 사용 변수 정의 */
var ElementDef = {
	/* 품의정보 테이블 */
    consTbl: 'consTbl',
	/* 품의정보 입력 설명 */
	ConsTooltip: 'ConsTooltip',
	/* 예산정보 테이블 */
	budgetTbl: 'budgetTbl',
	/* 예산정보 입력 설명 */
	BudgetTooltip: 'BudgetTooltip',
    /* ex) ElementDef.getElement(ElementDef.consTbl) */
	getElement: function (type) {
		return $('#' + this[type]);
	}
};

/* 기초 데이터 변수 정의 */
var BaseDateDef = {
	/* pageData.docuFgCode */
	docuFgCode: [
		/* 지출품의서 */
		{
			docuFgCode: '1',
			docuFgName: '지출품의서'
		},
		/* 구매품의서 */
		{
			docuFgCode: '2',
			docuFgName: '구매품의서'
		},
		/* 용역품의서 */
		{
			docuFgCode: '3',
			docuFgName: '용역품의서'
		}]
};
