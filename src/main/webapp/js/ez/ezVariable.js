/* 이지바로 결의내역 변수 */
var ezDataLevel1List = [
//	{
//		key : '',
//		data: [{id : '', value : ''}]
//	},{
//		key : '',
//		data: [{id : '', value : ''}]
//	}
];

var ezDataLevel2List =[
//    {
//    	key : '',
//    	data : '[{rownum:'',data:['']},{}]';
//    }
];

//이지바로 코드팝업 파라메터 변수
var ezparamList = [];


/* 결의내역 HEADER JSON */
var RESOL_JSON = [ {
	no : '0',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '연구과제',
	id : 'project',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[필수입력] 연구과제를 입력하세요.'
}, {
	no : '1',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '세목',
	id : 'bmcode',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[세목] 세목'
}, {
	no : '2',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '사용용도',
	id : 'use',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[사용용도]사용용도'
}, {
	no : '3',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'G20프로젝트',
	id : 'G20Project',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[G20프로젝트]G20프로젝트'
}, {
	no : '4',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'G20예산과목',
	id : 'G20abgt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',	
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[G20예산과목]G20예산과목.'
}, {
	no : '5',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '집행방법',
	id : 'execmtd',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[집행방법]집행방법'
}, {
	no : '6',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '집행요청구분',
	id : 'execreqdiv',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[집행요청구분]집행요청구분'
}, {
	no : '7',
	tail : 'Y',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'G20입출금계좌',
	id : 'inoutaccount',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[G20입출금계좌]G20입출금계좌'
} ]

/* ===================================================================================================================================================== */
/* 상세내역 HEADER JSON */
var DETAIL_JSON = [ {
	no : '0',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '결의일자',
	id : 'resoldate',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'cen',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[결의일자] 결의일자'
}, {
	no : '1',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'G20거래처구분',
	id : 'partnergbn',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'cen',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[G20거래처구분] G20거래처구분'
},{
	no : '2',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'G20거래처',
	id : 'partner',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'cen',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[G20거래처] G20거래처'
},{
	no : '3',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : '',
	displayClass : '',
	titleName : 'G20거래처명',
	id : 'partnernm',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'cen',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[G20거래처] G20거래처명'
},
{
	no : '4',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '카드번호',
	id : 'cardnum',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[카드번호]카드번호'
}, {
	no : '5',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '승인번호',
	id : 'aprovNum',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[승인번호]승인번호'
}, {
	no : '6',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '청구일련번호',
	id : 'serialNum',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[청구일련번호]청구일련번호'
}, {
	no : '7',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '거래일',
	id : 'trdate',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[거래일]거래일'
}, {
	no : '8',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '연구자',
	id : 'researcher',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[연구자]연구자'
}, {
	no : '9',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '직급',
	id : 'posi',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[직급]직급'
}, {
	no : '10',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '소속',
	id : 'belong',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[소속]소속'
}, {
	no : '11',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '성명',
	id : 'nm',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[성명]성명'
}, {
	no : '12',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출장자',
	id : 'entrant',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[출장자]출장자'
}, {
	no : '13',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '지급은행',
	id : 'bank',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[지급은행]지급은행'
}, {
	no : '14',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '지급계좌번호',
	id : 'bankaccount',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[지급계좌번호]지급계좌번호'
}, {
	no : '15',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '지급예금주',
	id : 'accholder',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[지급예금주]지급예금주'
}, {
	no : '16',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '참여율(%)',
	id : 'rate',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[지급예금주]지급예금주'
}, {
	no : '17',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '지급년월',
	id : 'recipdate',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[지급년월]지급년월'
}, {
	no : '18',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '지급처',
	id : 'recip',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[지급처]지급처'
}, {
	no : '19',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '지급기준액',
	id : 'paybaseamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[지급기준액]지급기준액'
}, {
	no : '20',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerTaxPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '세금계산서승인번호',
	id : 'taxapprno',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[세금계산서승인번호]세금계산서승인번호'
}, {
	no : '21',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '세금계산서공급자명',
	id : 'supperson',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[세금계산서공급자명]세금계산서공급자명'
}, {
	no : '22',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '세금계산서사업자번호',
	id : 'supbizno',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[세금계산서사업자번호]세금게산서사업자번호'
}, {
	no : '23',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '회의시작일시',
	id : 'meetstd',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDatetime',
	helpDeskMessage : '[회의시작일시]회의시작일시'
}, {
	no : '24',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '회의종료일시',
	id : 'meetetd',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDatetime',
	helpDeskMessage : '[회의종료일시]회의종료일시'
}, {
	no : '25',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '회의장소',
	id : 'meetplace',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[회의장소]회의장소'
}, {
	no : '26',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'G20비고',
	id : 'bigo',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[G20비고]G20비고'
}, {
	no : '27',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '위탁기관',
	id : 'consiorg',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[위탁기관]위탁기관'
}, {
	no : '28',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '위탁사업자번호',
	id : 'bizno',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[위탁사업자번호]위탁사업자번호'
}, {
	no : '29',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenResolAmtLayerPopup',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '결의금액',
	id : 'resolamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[결의금액]결의금액'
}, {
	no : '30',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '세액',
	id : 'taxamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[세액]세액'
},{
	no : '31',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '공급가액',
	id : 'supplyamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[공급가액]공급가액'
},{
	no : '32',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '계좌실입금액',
	id : 'realamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[계좌실입금액]계좌실입금액'
},{
	no : '33',
	tail : 'Y',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '법정부담금',
	id : 'lawamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[법정부담금]법정부담금'
}]

/* ===================================================================================================================================================== */

var ITEMDETAIL_JSON = [ {
	no : '0',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '품명',
	id : 'item',
	value : '',
	requierdYN : 'Y',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[품목] 품목'
}, {
	no : '1',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '규격',
	id : 'standard',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[규격] 규격'
}, {
	no : '2',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '수량',
	id : 'amount',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskNumber',
	helpDeskMessage : '[수량] 수량'
}, {
	no : '3',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '단가',
	id : 'unitprice',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'cen',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[단가]단가'
}, {
	no : '4',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '공급가액',
	id : 'itemsupplyamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[공급가액]공급가액'
}, {
	no : '5',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '세액',
	id : 'itemtaxamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[세액]세액'
}, {
	no : '6',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '총구입액',
	id : 'itemtotalamt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'ri',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[총구입액]총구입액'
}, {
	no : '7',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '물품구분',
	id : 'itemgbn',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[물품구분]물품구분'
}, {
	no : '8',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'NTIS등록일자',
	id : 'ntisregdt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'cen',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[NTIS등록일자]NTIS등록일자'
}, {
	no : '9',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : 'NTIS등록번호',
	id : 'ntisregno',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[NTIS등록번호]NTIS등록번호'
}, {
	no : '10',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '전문가',
	id : 'specialist',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[전문가]전문가'
}, {
	no : '11',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출장자',
	id : 'itementrant',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[출장자]출장자'
}, {
	no : '12',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출장목적',
	id : 'purposebiztrip',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[출장목적]출장목적'
}, {
	no : '13',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출장시작일',
	id : 'biztripstdt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[출장시작일]출장시작일'
}, {
	no : '14',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출장종료일',
	id : 'biztripendt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[출장종료일]출장종료일'
}, {
	no : '15',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출장시작시간',
	id : 'biztripsttime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[출장시작시간]출장시작시간'
}, {
	no : '16',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출장종료시간',
	id : 'biztripentime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[출장종료시간]출장종료시간'
}, {
	no : '17',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '출발지',
	id : 'stplace',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[출발지]출발지'
}, {
	no : '18',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '도착지',
	id : 'enplace',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[도착지]도착지'
}, {
	no : '19',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '시내외구분',
	id : 'inoutgbn',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[시내외구분]시내외구분'
}, {
	no : '20',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '소속구분',
	id : 'belonggbn',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[소속구분]소속구분'
}, {
	no : '21',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '연구자등록번호',
	id : 'peopleregno',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[연구자등록번호]연구자등록번호'
}, {
	no : '22',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '특근자명',
	id : 'overtimeworker',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[특근자명]특근자명'
}, {
	no : '23',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '특근시작일',
	id : 'overworkstdt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[특근시작일]특근시작일'
}, {
	no : '24',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '특근종료일',
	id : 'overworkendt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[특근종료일]특근종료일'
}, {
	no : '25',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '특근시작시간',
	id : 'overworksttime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[특근시작시간]특근시작시간'
}, {
	no : '26',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '특근종료시간',
	id : 'overworkentime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[특근종료시간]특근종료시간'
}, {
	no : '27',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '소속사업자번호',
	id : 'belongbizno',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[소속사업자번호]소속사업자번호'
}, {
	no : '28',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '참석자성명',
	id : 'entnm',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[참석자성명]참석자성명'
}, {
	no : '29',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '교육자',
	id : 'educator',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[교육자]교육자'
}, {
	no : '30',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '교육기관명',
	id : 'eduorgnm',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[교육기관명]교육기관명'
}, {
	no : '31',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '교육시작일',
	id : 'edustdt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[교육시작일]교육시작일'
}, {
	no : '32',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '교육종료일',
	id : 'eduendt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[교육종료일]교육종료일'
}, {
	no : '33',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '교육시작시간',
	id : 'edusttime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[교육시작시간]교육시작시간'
}, {
	no : '34',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '교육종료시간',
	id : 'eduentime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[교육종료시간]교육종료시간'
}, {
	no : '35',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '활용장소',
	id : 'useplace',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[활용장소]활용장소'
}, {
	no : '36',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '활용시작일',
	id : 'usestdt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[활용시작일]활용시작일'
}, {
	no : '37',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '활용종료일',
	id : 'useendt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskDate',
	helpDeskMessage : '[활용종료일]활용종료일'
}, {
	no : '38',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '활용시작시간',
	id : 'usesttime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[활용시작시간]활용시작시간'
}, {
	no : '39',
	tail : 'N',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '활용종료시간',
	id : 'useentime',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : 'maskTime',
	helpDeskMessage : '[활용종료시간]활용종료시간'
}, {
	no : '40',
	tail : 'N',
	popupCustLoadFunc : 'fnOpenLayerPopup',
	popupCustBindFunc : 'fnSetResolPopBind',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '활용방법',
	id : 'usemethod',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'Y',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp',
	mask : '',
	helpDeskMessage : '[활용방법]활용방법'
}, {
	no : '41',
	tail : 'Y',
	popupCustLoadFunc : '',
	popupCustBindFunc : '',
	focusCustFunc : 'fnSetSelectCell',
	displayClass : '',
	titleName : '금액',
	id : 'amt',
	value : '',
	requierdYN : 'N',
	inputType : 'text',
	codeHelperYN : 'N',
	width : '150px',
	tdClass : 'le',
	inputClass : 'td_inp ar',
	mask : 'maskMoney',
	helpDeskMessage : '[금액]금액'
} ]

/* ===================================================================================================================================================== */

/* 가짜 코드팝업 데이터 json Array 생성 */
var dataJson = [ 
//{
//	code : '00001',
//	name : '유전자 공학의 기초와 응용사례 분석',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00002',
//	name : '신호파동의 실험에 대한 고찰',
//	regNumber : '20111101005',
//	regDate : '20170101',
//	regPeople : '임꺽정'
//}, {
//	code : '00003',
//	name : '운영체제',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00004',
//	name : '유전자 공학 강의실습',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00005',
//	name : '클라우드 컴퓨팅에서 N스크린 서비스를 위한 실시간 동영상 재생기법',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00006',
//	name : '맵리듀스 성능향상을 위한 배치기법',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00007',
//	name : 'Migration of Virtual Machine ',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00008',
//	name : '정형기법',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00009',
//	name : '머신러닝에 대한 고찰',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//}, {
//	code : '00010',
//	name : '멀티미디어 정보검색',
//	regNumber : '20150228001',
//	regDate : '20170101',
//	regPeople : '홍길동'
//} 
];


var ANZR100 = {
		LANGKIND : '',
		CO_CD:'',
		TASK_DT : '',
		TASK_SQ : '',
		OFCODE : '',
		PRJNO : '',
		EXECDATE : '',
		REGNO : '',
		DIV_CD : '',
		DEPT_CD : '',
		EMP_CD : '',
		EXECTIME : '',
		EXECSEQ : '',
		BIZGRP : '',
		BMCODE : '',
		EXECREQDIV : '',
		EXECDIV : '',
		EXECMTD : '',
		RESOLNO : '',
		RESOLDATE : '',
		CONT : '',
		BELONG : '',
		NM : '',
		RESPERSONNO : '',
		POSI : '',
		PAYYYMM : '',
		PARTRATE : '',
		PAYBASEAMT : '',
		RESOLAMT : '',
		EXTTAX : '',
		ACCREGAMT : '',
		COURTAMT : '',
		CHARGE : '',
		EXECBANK : '',
		EXECREQACCNO : '',
		ACCOWNER : '',
		EXECRECIP : '',
		EXECREQFLAG : '',
		TAXAPPRNO : '',
		SUPPERSON : '',
		SUPBIZNO : '',
		MEETSDT : '',
		MEETEDT : '',
		MEETPLACE : '',
		CONSIORG : '',
		BIZNO : '',
		SENDYN : '',
		SENDOPT : '',
		SENDDATE : '',
		SENDTIME : '',
		STATECODE : '',
		STATETEXT : '',
		RCVDATE : '',
		RCVTIME : '',
		RESOLCHKNO : '',
		RESOLCHKTXT : '',
		ORIGRESOLNO : '',
		CHECKDATE : '',
		CHECKUSER : '',
		TRNSDATE : '',
		TRNSTIME : '',
		TRNSBANK : '',
		TRNSACCNO : '',
		TRNSACCOWNER : '',
		RECIP : '',
		TRNSAMT : '',
		CARDNO : '',
		TRSEQ : '',
		TRDATE : '',
		APPRNO : '',
		GISU_DT : '',
		GISU_SQ : '',
		PJT_CD : '',
		ABGT_CD : '',
		TR_FG : '',
		TR_CD : '',
		CTR_CD : '',
		CTR_NM : '',
		ETCRVRS_YM : '',
		ETCDIV_CD : '',
		ETCDUMMY1 : '',
		NDEP_AM : '',
		INAD_AM : '',
		INTX_AM : '',
		RSTX_AM : '',
		WD_AM : '',
		BG_SQ : '',
		ETCPAY_DT : '',
		ET_YN : '',
		ETCDATA_CD : '',
		ETCTAX_RT : '',
		HIFE_AM : '',
		NAPE_AM : '',
		DDCT_AM : '',
		NOIN_AM : '',
		WD_AM2 : '',
		ETCRATE : '',
		HINCOME_SQ : '',
		PYTP_FG : '',
		GW_STATE : '',
		GW_ID : '',
		RMK_DC:'',
		BTR_CD:'',
		COURTAMT:'',
		INSERT_IP:'',
		MODIFY_ID:'',
		MODIFY_IP:'',
		TAX_TY:''
		
}



var ANZR100DETAIL = {
		LANGKIND : '',
		CO_CD:'',
		TASK_DT : '',
		TASK_SQ : '',
		OFCODE:'',
		PRJNO:'',
		REGSEQ:'',
		BELONG:'',
		BELONGDIV:'',
		AREADIV:'',
		ARTIDIV:'',
		ITEMNAME:'',
		STANDARD:'',
		AMOUNT:'',
		UNITCOST:'',
		SUPCOST:'',
		EXTTAX:'',
		TOTPURCHAMT:'',
		NTISREGNO:'',
		NTISREGDATE:'',
		CHECKDATE:'',
		CHECKUSER:'',
		PROFUSEDIV:'',
		RESPERSONNO:'',
		BELONG:'',
		NM:'',
		TERMF:'',
		TERMT:'',
		ST:'',
		ET:'',
		STARTPLACE:'',
		DEST:'',
		EDUORGNM:'',
		PAYAMT:'',
		GISU_DT:'',
		GISU_SQ:''
}

/* ===================================================================================================================================================== */
//가짜 그리드 헤더 정보
var headjson; 
//= [ {
//	no : '0',
//	displayClass : '',
//	titleName : '연구과제코드',
//	id : 'code',
//	width : '125px',
//	tdClass : 'cen'
//}, {
//	no : '1',
//	displayClass : '',
//	titleName : '연구과제명',
//	id : 'name',
//	width : '200px',
//	tdClass : 'le'
//}, {
//	no : '2',
//	displayClass : '',
//	titleName : '연구번호',
//	id : 'regNumber',
//	width : '125px',
//	tdClass : 'cen'
//}, {
//	no : '3',
//	displayClass : '',
//	titleName : '연구년월',
//	id : 'regDate',
//	width : '125px',
//	tdClass : 'cen'
//}, {
//	no : '4',
//	displayClass : '',
//	titleName : '연구자',
//	id : 'regPeople',
//	width : '125px',
//	tdClass : 'cen'
//} ];