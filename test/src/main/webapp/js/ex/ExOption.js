/* 지출결의 옵션 설정 및 적용 스크립트  2016.11.15 회계파트 */

/* [Map] declare javascipt hashmap prototype
========================================*/
Map = function () {
    this.map = new Object();
};
Map.prototype = {
    put: function (key, value) {
        this.map[key] = value;
    },
    get: function (key) {
        if (!this.map[key]) {
            console.log('[EX CMM MSG] Calldata datemap.key "' + key + '" before accessing data set');
            return null;
        }
        return this.map[key];
    },
    containsKey: function (key) {
        return key in this.map;
    },
    containsValue: function (value) {
        for (var prop in this.map) {
            if (this.map[prop] == value)
                return true;
        }
        return false;
    },
    isEmpty: function (key) {
        return (this.size() == 0);
    },
    clear: function () {
        for (var prop in this.map) {
            delete this.map[prop];
        }
    },
    remove: function (key) {
        delete this.map[key];
    },
    keys: function () {
        var keys = new Array();
        for (var prop in this.map) {
            keys.push(prop);
        }
        return keys;
    },
    values: function () {
        var values = new Array();
        for (var prop in this.map) {
            values.push(this.map[prop]);
        }
        return values;
    },
    size: function () {
        var count = 0;
        for (var prop in this.map) {
            count++;
        }
        return count;
    }
};

/*=================================================================*/
/* 옵션 전역변수 시작*/
/*=================================================================*/
/* 옵션 사용 페이지 정의*/
//master 지출결의 문서 , list 전표, slip 분개, mng 관리항목, card 카드사용내역, cardlist 법인카드사용현황, expendlist  지출결의확인, ratelist  예실대비현황 
var type = ['master','list','slip','mng','card','cardlist','expendlist','ratelist'];

/* 옵션 설명 */
/* 003106 : [기능옵] 부서/사용자 입력범위 설정 ( 10(불가), 20(사원(전체)), 30(사원(결의부서내)), 40(부서), 50(부서+사원) ) */
 
/* 마스터 팝업 옵션*/
var master_disp = ['001001','001002','001003','001004','001005','001006','001007','001008'];
var master_func = ['003002','003003','003004','003007','003102','003104','003301','003303','003106','003107'];
var master_date = ['002001','002002','002003','002004'];

/* 리스트 팝업 옵션*/
var list_disp = ['000002','001002','001003','001004','001005','001006'];
var list_func = ['003002','003101','003103','003301','003302','003303','003304','003305','003106'];
var list_date = [];

/* 분개 팝업 옵션*/
var slip_disp = ['000002','001002','001003','001004','001005','001006'];
var slip_func = ['003002','003101','003103','003301','003302','003303','003304','003305','003106'];
var slip_date = [];

/* 관리항목 팝업 옵션*/
var mng_disp = [];
var mng_func = [];
var mng_date = [];

/* 카드사용내역 팝업 옵션*/
var card_disp = ['001004'];
var card_func = ['003002','003005','003301','003302'];
var card_date = [];

/* 매입전자세금계산서 팝업 옵션*/
var etax_disp = ['001004','001006'];
var etax_func = ['003002','003301','003302'];
var etax_date = [];

/* 법인카드 현황 옵션*/
var cardlist_disp = [];
var cardlist_func = ['003002','003005'];
var cardlist_date = [];

/* 지출결의 확인 옵션*/
var expendlist_disp = [];
var expendlist_func = ['003101','003301','003306'];
var expendlist_date = ['000000'];

/* 예실대비현황 옵션*/
var ratelist_disp = [];
var ratelist_func = ['003101'];
var ratelist_date = [];

var op_date_map = new Map();
var op_master = {};
var op_list = {};
var op_slip = {};
var op_mng = {};
var op_card = {};
var op_etax = {};
var op_cardlist = {};
var op_expendlist = {};
var op_ratelist = {};


var option_code = {
	//해당 화면 명
	type : '',
	//화면
	disp_code :[],	
	//기능
	func_code :[],
	//일자
	date_code :[],
	
	initVar : function(){
		type = '';
		disp_code = [];
		func_code :[];
		date_code :[];
		
	},

	pushValue : function(option, _type){
			this.type = _type;
		
			var new_disp_code = function() {
				var new_code = [];
				$.each(option, function(idx, value) {
					
					if(_type === 'master')
					{
						if (master_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'list')
					{
						if (list_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'slip')
					{
						if (slip_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'mng')
					{
						if (mng_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'card')
					{
						if (card_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'etax')
					{
						if (etax_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'cardlist')
					{
						if (cardlist_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'expendlist')
					{
						if (expendlist_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'ratelist')
					{
						if (ratelist_disp.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}
				});
				return new_code;
			}
			this.disp_code = new_disp_code();
			 
			var new_func_code = function() {
				var new_code = [];
				$.each(option, function(idx, value) {
					
					if(_type === 'master')
					{
						if (master_func.indexOf(value.option_code)!== -1){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'list')
					{
						if (list_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'slip')
					{
						if (slip_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'mng')
					{
						if (mng_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'card')
					{
						if (card_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'etax')
					{
						if (etax_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'cardlist')
					{
						if (cardlist_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'expendlist')
					{
						if (expendlist_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'ratelist')
					{
						if (ratelist_func.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}
				});
				return new_code;
			}
			this.func_code = new_func_code();
			
			
			var new_date_code = function() {
				var new_code = [];
				$.each(option, function(idx, value) {
					
					if(_type === 'master')
					{
						if (master_date.indexOf(value.option_code) !== -1){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'list')
					{
						if (list_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'slip')
					{
						if (slip_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'mng')
					{
						if (mng_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'card')
					{
						if (card_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'etax')
					{
						if (etax_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'cardlist')
					{
						if (cardlist_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'expendlist')
					{
						if (expendlist_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}else if(_type === 'ratelist')
					{
						if (ratelist_date.indexOf(value.option_code) !== -1 ){
							var code = {
								'code' : value.option_code,
								'value' : value.option_value
							};
							new_code.push(code);
						}
					}
					
				});
				return new_code;
			}
			this.date_code = new_date_code();
		}
};
/*=================================================================*/
/* 옵션 전역변수 끝*/
/*=================================================================*/




/*=================================================================*/
/* 옵션 메인함수 시작*/
/*=================================================================*/

/* 옵션 관련 메인함수*/
function fnSetExOption(_option, _type){
	var optionList = {};
	//옵션 담기
	if(!_option)
	{
		alert(NeosUtil.getMessage("", "지출결의 설정 값이 존재하지 않으므로 미작동할 수 있습니다"));
		return;
	}
	// 지출결의 작성 화면
	if(_type === 'master') {
		option_code.initVar();
		option_code.pushValue(_option,'master');
		this.op_master = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_master);
	}
	else if(_type ==='list'){
		option_code.initVar();
		option_code.pushValue(_option,'list');
		this.op_list = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_list);
	}
	else if(_type === 'slip')
	{
		option_code.initVar();
		option_code.pushValue(_option,'slip');
		this.op_slip = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_slip);
	}
	else if(_type === 'mng'){
		option_code.initVar();
		option_code.pushValue(_option,'mng');
		this.op_mng =  JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_mng);
	}
	else if(_type === 'card') // 카드내역 작성 화면
	{
		option_code.initVar();
		option_code.pushValue(_option,'card');
		this.op_card = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_card);
		
	}
	else if(_type === 'etax') // 매입전자세금계산서 작성 화면
	{
		option_code.initVar();
		option_code.pushValue(_option,'etax');
		this.op_etax = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_etax);
		
	}
	else if(_type === 'cardlist') //법인카드사용현황 화면
	{
		option_code.initVar();
		option_code.pushValue(_option,'cardlist');
		this.op_cardlist = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_cardlist);
		
	}
	else if(_type === 'expendlist') //지출결의확인 화면
	{
		option_code.initVar();
		option_code.pushValue(_option,'expendlist');
		this.op_expendlist = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_expendlist);
	}
	else if(_type === 'ratelist') //예실대비현황 화면
	{
		option_code.initVar();
		option_code.pushValue(_option,'ratelist');
		this.op_reatelist = JSON.parse(JSON.stringify(option_code));
		fnSetOption(this.op_reatelist);
	}
	else{ //미 존재
		return;
	}
	
}

/*=================================================================*/
/* 옵션 메인함수 끝*/
/*=================================================================*/






/*=================================================================*/
/* 옵션 적용 함수 시작*/
/*=================================================================*/

/* 옵션 수행 */
function fnSetOption(option)
{	
	//초기화
	fnInitDisplay(option.type);
	
	//화면
	$.each(option.disp_code, function(idx, code) {
		fnReflectDisplayOption(code);
	});
	
	//일자
	$.each(option.date_code, function(idx, code) {
		//마스터 팝
		if(option.type === 'master' && !fnSetDateMap.isEmpty){
			fnSetDateMap();
			if(code.code == '002001'){//기본입력 결의일자 ( 회계일자, 예산년월 ) 설정
				var optionDate = op_date_map.get(code.value);
				/* 회계일자 마감 설정 */
				for( var i = 0 ; i < expendDateList.length ; i++){
					var tDate = expendDateList[i];
					/* 기본 회계일자가 마감기간에 포함된 경우 아래의 로직으로 반영 */
					if( tDate.closeFromDate <= optionDate.replace(/-/g, '') && tDate.closeToDate >= optionDate.replace(/-/g, '')){
						/* 변경된 회계일자가 월을 넘어가는 경우 마감시작일 -1일 로 반영
						 * 만약 이 경우도 월이 바뀌게 되면 마감종료일 +1일로 반영
						 */
						// 옵션 일자
						var optDate = new Date(optionDate.replace(/-/g, '').substr(0,4), (optionDate.replace(/-/g, '').substr(4,2) - 1),optionDate.replace(/-/g, '').substr(6,2));
						// 회계일자 마감시작일
						var expFDate = new Date(tDate.closeFromDate.substr(0,4),(tDate.closeFromDate.substr(4,2) - 1),tDate.closeFromDate.substr(6,2));
						// 회계일자 마감종료일
						var expTDate = new Date(tDate.closeToDate.substr(0,4),(tDate.closeToDate.substr(4,2) - 1),tDate.closeToDate.substr(6,2));
						// 반영될 값
						var setDate = new Date(expTDate.getFullYear(), expTDate.getMonth(), (expTDate.getDate() + 1));
						if(expTDate.getMonth() != setDate.getMonth()){
							setDate = new Date(expFDate.getFullYear(), expFDate.getMonth(), (expFDate.getDate() - 1));
							if(expFDate.getMonth() != setDate.getMonth()){
								setDate = new Date(expTDate.getFullYear(), expTDate.getMonth(), (expTDate.getDate() + 1));
							}
						}
						var year = setDate.getFullYear();
						var month = setDate.getMonth() + 1;
						var day = setDate.getDate();
						month = (month < 10 ? "0" + month : month);
						day = (day < 10 ? "0" + day : day);
						optionDate = year + "-" + month + "-" + day;
						break;
					}
				}
				$('#txtExpendDate').val(optionDate);
				expend.set('expendDate', $('#txtExpendDate').val().replace(/-/g, '')); 
			}else if(code.code == '002002' && code.value ==='N'){ //기본입력 결의일자 작성자 편집 기능
				$("#txtExpendDate").attr('disabled','disabled');
				//date pick 숨기기
				var parentElement = $('div').find('.com_ta');
				var childDate = parentElement.find($("span"));
				childDate.each(function() {
					if($(this).attr('aria-controls') === 'txtExpendDate_dateview'){
						$(this).css('display','none');
					}
				});
			}else if(code.code == '002003'){//기본입력 지급요청일자 설정
				$('#txtExpendReqDate').val(op_date_map.get(code.value));
				expend.set('expendReqDate', $('#txtExpendReqDate').val().replace(/-/g, ''));
			}else if(code.code == '002004' && code.value ==='N'){ //기본입력 지급요청일자 작성자 편집 기능
				//읽기 전용 속성추가
				$('#txtExpendReqDate').attr('disabled', 'disabled');
				//date pick 숨기기
				var parentElement = $('div').find('.com_ta');
				var childDate = parentElement.find($("span"));
				childDate.each(function() {
					if($(this).attr('aria-controls') === 'txtExpendReqDate_dateview'){
						$(this).css('display','none');
					}
				});
			}
		}
	});
	//기능
	var moduleType = option.type;
	$.each(option.func_code, function(idx, code) {
		fnReflectFunctionOption(code, moduleType);
	});
}

/*=================================================================*/
/* 오션 적용 함수 끝*/
/*=================================================================*/




/*=================================================================*/
/* 화면 옵션 시작 */
/*=================================================================*/

/* 화면설정 옵션 */
function fnReflectDisplayOption(displayOption){
	switch (displayOption.code){
		case '001001' :
			if(displayOption.value.indexOf('L') == -1){
				$(".ExpendList").hide();
				isInsertSlipMode = true;
				// 기본 항목 추가(분개단위 입력이므로 빈 항목이 필요함)
				
			}else{
				$('#btnExpendSlipInterfaceETax').hide();
				$('#btnExpendSlipInterfaceCard').hide();
			}
			if(displayOption.value.indexOf('S') == -1){
				$(".ExpendSlip").hide();
			}
			if(displayOption.value.indexOf('M') == -1){
				$(".ExpendMng").hide();
			}
			
			if(ifSystem == "ERPiU"){
				/* 회계단위 무조건 표시 */
				$('.ExpendPC').show();
			}
			break;
		case '001002' : //사용자 정보 입력 설정
			if(displayOption.value == "E"){ //문서
				$('.ExpendEmp').show();
				$('.ExpendListEmp').hide();
				$('.ExpendSlipEmp').hide();
				if(ifSystem == "ERPiU"){
					$('.ExpendCCPC').show();	
				}else if(ifSystem == "iCUBE"){
					$('.ExpendCCPC').hide();
				}
			}else if(displayOption.value == "L"){ //전표
				$('.ExpendEmp').hide();
				$('.ExpendListEmp').show();
				$('.ExpendSlipEmp').hide();
				if(ifSystem == "ERPiU"){
					$('.ExpendListCCPC').show();	
				}else if(ifSystem == "iCUBE"){
					$('.ExpendListCCPC').hide();
				}
			}else if(displayOption.value == "S"){ //분개
				$('.ExpendEmp').hide();
				$('.ExpendListEmp').hide();
				$('.ExpendSlipUser').show();
				if(ifSystem == "ERPiU"){
					$('.ExpendSlipCCPC').show();	
				}else if(ifSystem == "iCUBE"){
					$('.ExpendSlipCCPC').hide();
				}
			}
			
			if(ifSystem == "ERPiU"){
				/* 회계단위 무조건 표시 */
				$('.ExpendPC').show();
			}
			break;
		case '001003' : //예산 정보 입력 설정 (iCUBE의 경우 예산정보를 입력하지 않는다.)
			if(ifSystem == "ERPiU"){
				if(displayOption.value == "E"){ //문서
					$('.ExpendBudget').show();
					$('.ExpendListBudget').hide();
					$('.ExpendSlipBudget').hide();
					$('.ERPiUBudget').attr("disabled",true);
				}else if(displayOption.value == "L"){ //전표
					$('.ExpendBudget').hide();
					$('.ExpendListBudget').show();
					$('.ExpendSlipBudget').hide();
				}else if(displayOption.value == "S"){ //분개
					$('.ExpendBudget').hide();
					$('.ExpendListBudget').hide();
					$('.ExpendSlipBudget').show();
				}
			}else if(ifSystem == "iCUBE"){
				$('.ExpendBudget').hide();
				$('.ExpendListBudget').hide();
				$('.ExpendSlipBudget').hide();
			}
			break;
		case '001004' : //프로젝트 정보 입력 설정
			if(displayOption.value == "E"){ //문서
				$('.ExpendProject').show();
				$('.ExpendListProject').hide();
//				$('.ExpendSlipProject').hide();
				// 카드사용내역 옵션 반영
				$('.ExpendCardProject').attr("disabled",true);
				$('.ExpendCardProjectBtn').hide();
				// 매입전자세금계산서 반영
				$('.ExpendETaxProject').attr("disabled",true);
				$('.ExpendETaxProjectBtn').hide();
			}else if(displayOption.value == "L"){ //전표
				$('.ExpendProject').hide();
				$('.ExpendListProject').show();
//				$('.ExpendSlipProject').hide();
			}else if(displayOption.value == "S"){ //분개
				$('.ExpendProject').hide();
				$('.ExpendListProject').hide();
				$('.ExpendSlipProject').show();
			}
			break;
		case '001005' : //거래처 정보 입력 설정
			if(displayOption.value == "E"){ //문서
				$('.ExpendPartner').show();
				$('.ExpendListPartner').hide();
//				$('.ExpendSlipPartner').hide();
			}else if(displayOption.value == "L"){ //전표
				$('.ExpendPartner').hide();
				$('.ExpendListPartner').show();
//				$('.ExpendSlipPartner').hide();
			}else if(displayOption.value == "S"){ //분개
				$('.ExpendPartner').hide();
				$('.ExpendListPartner').hide();
				$('.ExpendSlipPartner').show();
			}
			break;
		case '001006' : //카드정보 입력 설정
			if(displayOption.value == "E"){ //문서
				$('.ExpendCard').show();
				$('.ExpendListCard').hide();
//				$('.ExpendSlipCard').hide();
				// 매입전자세금계산서 반영
				$('.ExpendETaxCard').attr("disabled",true);
				$('.ExpendETaxCardBtn').hide();
			}else if(displayOption.value == "L"){ //전표
				$('.ExpendCard').hide();
				$('.ExpendListCard').show();
//				$('.ExpendSlipCard').hide();
			}else if(displayOption.value == "S"){ //분개
				$('.ExpendCard').hide();
				$('.ExpendListCard').hide();
				$('.ExpendSlipCard').show();
			}
			break;
		case '001007' : //기본 적요 설정
			if(displayOption.value == "Y"){ // 사용
				$('.ExpendBaseNote').show();
			} else{ //미사용
				$('.ExpendBaseNote').hide();
			}
			break;
		case '001008' : // 표준적요 명칭 설정
			summryDisplayOption = displayOption.value
			break;
				
	}
}

/* 화면 초기화 */
function fnInitDisplay(pageType){
	var tPageType = "";
	if(pageType != "master"){
		tPageType = pageType.substr(0,1).toUpperCase() + pageType.substr(1,pageType.length);
	}
	if(ifSystem == "ERPiU"){
		$(".Expend" + tPageType + "iCUBE, .Expend" + tPageType + "BiaboxA").hide();
	}else if(ifSystem == "iCUBE"){
		$(".Expend" + tPageType + "ERPiU, .Expend" + tPageType + "BiaboxA").hide();
	}else if(ifSystem == "BizboxA"){
		$(".Expend" + tPageType + "iCUBE, .Expend" + tPageType + "ERPiU").hide();
	}
}


/*=================================================================*/
/* 화면 옵션 끝 */
/*=================================================================*/

/*=================================================================*/
/* 일자 옵션 시작 */
/*=================================================================*/

/* 기능옵션별 날짜 설정 */
function fnSetDateMap() {
    var date = new Date();
    op_date_map.clear();

    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString()[1] ? (date.getMonth() + 1) : '0' + (date.getMonth() + 1).toString();
    var today = date.getDate().toString()[1] ? date.getDate() : '0' + date.getDate().toString();
    var lastDate = (new Date(year, month, 0)).getDate();

    var mMonth = Number(month) - 1 == '0' ? '12' : ((Number(month) - 1).toString()[1] ? (Number(month) - 1).toString() : '0' + (Number(month) - 1).toString());
    var mYear = mMonth == '12' ? year - 1 : year;
    var mLastDate = (new Date(mYear, mMonth, 0)).getDate();

    var pYear = Number(month) == '12' ? year + 1 : year;
    var pMonth = Number(month) + 1 == '13' ? '01' : ((Number(month) + 1).toString()[1] ? (Number(month) + 1).toString() : '0' + (Number(month) + 1).toString());
    var pLastDate = (new Date(pYear, pMonth, 0)).getDate();

    /* 전월 05일 */
    op_date_map.put('m1_5', mYear + '-' + mMonth + '-' + '05');
    /*전월 10일*/
    op_date_map.put('m1_10', mYear + '-' + mMonth + '-' + '10');
    /*전월 15일*/
    op_date_map.put('m1_15', mYear + '-' + mMonth + '-' + '15');
    /*전월 20일*/
    op_date_map.put('m1_20', mYear + '-' + mMonth + '-' + '20');
    /*전월 25일*/
    op_date_map.put('m1_25', mYear + '-' + mMonth + '-' + '25');
    /*전월 말일*/
    op_date_map.put('m1_31', mYear + '-' + mMonth + '-' + mLastDate);

    /*당월 05일*/
    op_date_map.put('p0_5', year + '-' + month + '-' + '05');
    /*당월 10일*/
    op_date_map.put('p0_10', year + '-' + month + '-' + '10');
    /*당월 15일*/
    op_date_map.put('p0_15', year + '-' + month + '-' + '15');
    /*당월 20일*/
    op_date_map.put('p0_20', year + '-' + month + '-' + '20');
    /*당월 25일*/
    op_date_map.put('p0_25', year + '-' + month + '-' + '25');
    /*당월 말일*/
    op_date_map.put('p0_31', year + '-' + month + '-' + lastDate);

    /*익월 05일*/
    op_date_map.put('p1_5', pYear + '-' + pMonth + '-' + '05');
    /*익월 10일*/
    op_date_map.put('p1_10', pYear + '-' + pMonth + '-' + '10');
    /*익월 15일*/
    op_date_map.put('p1_15', pYear + '-' + pMonth + '-' + '15');
    /*익월 20일*/
    op_date_map.put('p1_20', pYear + '-' + pMonth + '-' + '20');
    /*익월 25일*/
    op_date_map.put('p1_25', pYear + '-' + pMonth + '-' + '25');
    /*익월 말일*/
    op_date_map.put('p1_31', pYear + '-' + pMonth + '-' + pLastDate);

    /* 오늘 */
    op_date_map.put('p0_p0', year + '-' + month + '-' + today);


    /* 기능 옵션 추가 */
    // var list = op_list.func_code;
    var list = [{ 'code': '003005', value: '5' }];
    for (var i = 0; i < list.length; i++) {
    	var item = list[i];

        if (item.code == '003005') {
            var date = new Date();
            date.setDate(parseInt(date.getDate()) - parseInt(item.value));

            var yyyy = date.getFullYear().toString();
            var MM = (date.getMonth() + 1).toString()[1] ? (date.getMonth() + 1).toString() : '0' + (date.getMonth() + 1).toString();
            var dd = (date.getDate()).toString()[1] ? (date.getDate()).toString() : '0' + (date.getDate()).toString();
            var oDate = yyyy + '-' + MM + '-' + dd;
            op_date_map.put('003005', oDate);
        }
    }
}
/*=================================================================*/
/* 일자 옵션 끝 */
/*=================================================================*/


/*=================================================================*/
/* 기능 옵션 시작 */
/*=================================================================*/
function fnReflectFunctionOption(functionOption, moduleType){
	var mType = '';
	mType = moduleType.substr(0,1).toUpperCase() + moduleType.substr(1,moduleType.length);
	switch (functionOption.code) {
	case '003002' : // 카드번호 표시 설정
		if(functionOption.value == '2'){
			isDisplayFullNumber = false;	
		}
		break;
	case '003003' : // 지출결의 상신 시 결의내역 최대입력 건수 설정( 최대 : 150 건 ) >> 2019.07.29.김상겸 : 최대 100건에서 150건으로 변경
		maxListLength = functionOption.value;
		if( !functionOption.value || functionOption.value == ''){
			maxListLength = 150;
		}else if( functionOption.value > 150 ){
			maxListLength = 150;	
		}
		break;
	case '003004' : // 관리항목 필수입력 확인 설정
		if(functionOption.value == "N"){
			chkMngInfo = false;
		}
		break;
	case '003005' : // 기본입력 카드사용내역 검색기간 설정
		var date = new Date();
		var optValue = functionOption.value;
		if(!optValue || optValue == ''){
			optValue = 0;
		}
        date.setDate(parseInt(date.getDate()) - parseInt(optValue));

        var yyyy = date.getFullYear().toString();
        var MM = (date.getMonth() + 1).toString()[1] ? (date.getMonth() + 1).toString() : '0' + (date.getMonth() + 1).toString();
        var dd = (date.getDate()).toString()[1] ? (date.getDate()).toString() : '0' + (date.getDate()).toString();
        var oDate = yyyy + '-' + MM + '-' + dd;
        //op_date_map.put('003005', oDate);
        if(moduleType == "card"){
        	$(cardElement.fromDate).resetDate(functionOption.value * -1);
        }else if(moduleType == "cardlist"){
        	$("#txtFromDate").val(fnFormatDate('yyyy-MM-dd', date));
        }
		break;
	case '003101' : // 코드 도움창에서 검색결과가 1건인 경우 자동 반영
		if(functionOption.value == "N"){
			reflectResultPop = false;	
		}
		break;
	case '003102' :  // 적요란 표준적요 자동입력 설정
		if(functionOption.value == "N"){
			isAutoInputNoteInfo = false;
		}
		break;
	case '003103' :  // 카드사용내역 연동시 금액 편집 설정
		if(functionOption.value == "Y"){
			updateCardAmt = true;
		}
		break;
	case '003104' :  // 예산 미연동시 마이너스 지출결의 작성 설정
		if(functionOption.value == "Y"){
			isNegativeAmt = true;
		}else{
			isNegativeAmt = false;
		}
		break;
	case '003301' : // 예산연동 사용여부 설정( 기본 : 미사용 )
		if(functionOption.value == "N"){
			isUseBudget = false;
		}
		
		break;
	case '003302' :
		//expendListReqBudget
		//expendListReqBizplan
		//expendListReqBgAcct
		if(mType != 'master'){
			$(".Expend" + mType +"Budget").hide();
		}
		// 예산 미사용일 경우에는 표시하지 않는다.
		if(isUseBudget){
			if(functionOption.value == '1'){ // 예산단위 + 사업계획 + 예산계정 ( 필수 )
				if(mType != 'master'){
					$(".Expend" + mType + "ReqBudget").show();
					$(".Expend" + mType + "ReqBizplan").show();
					$(".Expend" + mType + "ReqBgAcct").show();
					$("#expend" + mType + "ReqBudget").show();
					$("#expend" + mType + "ReqBizplan").show();
					$("#expend" + mType + "ReqBgAcct").show();
				}
			}else if(functionOption.value == '2'){ // 예산단위 + 사업계획 + 예산계정 ( 필수아님 )
				if(mType != 'master'){
					$(".Expend" + mType + "ReqBudget").show();
					$(".Expend" + mType + "ReqBizplan").show();
					$(".Expend" + mType + "ReqBgAcct").show();
					$("#expend" + mType + "ReqBudget").hide();
					$("#expend" + mType + "ReqBizplan").hide();
					$("#expend" + mType + "ReqBgAcct").hide();
				}
			}else if(functionOption.value == '3'){ // 예산단위 + 예산계정 ( 필수 )
				if(mType != 'master'){
					$(".Expend" + mType + "ReqBudget").show();
					$(".Expend" + mType + "ReqBgAcct").show();
					$("#expend" + mType + "ReqBudget").show();
					$("#expend" + mType + "ReqBgAcct").show();
					$(".Expend" + mType + "ReqBizplan").hide();
				}
			}else if(functionOption.value == '4'){ // 예산단위 + 예산계정 ( 필수아님 )
				if(mType != 'master'){
					$(".Expend" + mType + "ReqBudget").show();
					$(".Expend" + mType + "ReqBgAcct").show();
					$("#expend" + mType + "ReqBudget").hide();
					$("#expend" + mType + "ReqBgAcct").hide();
					$(".Expend" + mType + "ReqBizplan").hide();
				}
			}else{
				if(mType !== 'master'){
					$(".Expend" + mType + "Budget").hide();
				}
			}
		}

		break;
	case '003303' : // [예산연동] 오류확인시 예산확인 여부 설정 ( 기본 : 사용 )
		if(functionOption.value == "N"){
			isBudgetCheck = false;
		}
		break;
	case '003304' :
		break;
	case '003305' :
		break;
	case '003106':
		/* 003106 : [기능옵] 부서/사용자 입력범위 설정 ( 10(불가), 20(사원(전체)), 30(사원(결의부서내)), 40(부서), 50(부서+사원) ) */
		
		if(functionOption.value == "10"){
			/* 10 : 사용자 - 선택 불가 / 사용부서 - 선택 불가 */
			expendEmpChange = false; // 사용자 선택 가능 여부 >> fnExpendMasterEmpPop
			expendDeptChange = false; // 부서 선택 가능 여부 >> fnExpendMasterDeptPop
			expendEmpDeptLink = false; // 부서 내 사용자만 조회 여부 >> fnExpendMasterEmpPop
			expendEmpDeptLinkChange = true; // 사용자 변경 시 부서 변경 여부 >> fnExpend_Callback_Dept && fnExpend_Callback_Emp
		}
		else if(functionOption.value == "20"){
			/* 20 : 사용자 - 선택 가능(전체부서) / 사용부서 - 선택 불가 (선택한 사용자가 속한 부서 입력) */
			expendEmpChange = true; // 사용자 선택 가능 여부 >> fnExpendMasterEmpPop
			expendDeptChange = false; // 부서 선택 가능 여부 >> fnExpendMasterDeptPop
			expendEmpDeptLink = false; // 부서 내 사용자만 조회 여부 >> fnExpendMasterEmpPop
			expendEmpDeptLinkChange = true; // 사용자 변경 시 부서 변경 여부 >> fnExpend_Callback_Dept && fnExpend_Callback_Emp
		}
		else if(functionOption.value == "30"){
			/* 30 : 사용자 - 선택 가능 (사용부서 귀속 사용자) / 사용부서 : 선택 불가 (선택한 사용자가 속한 부서 입력) */
			expendEmpChange = true; // 사용자 선택 가능 여부 >> fnExpendMasterEmpPop
			expendDeptChange = false; // 부서 선택 가능 여부 >> fnExpendMasterDeptPop
			expendEmpDeptLink = true; // 부서 내 사용자만 조회 여부 >> fnExpendMasterEmpPop
			expendEmpDeptLinkChange = false; // 사용자 변경 시 부서 변경 여부 >> fnExpend_Callback_Dept && fnExpend_Callback_Emp
		}
		else if(functionOption.value == "40"){
			/* 40 : 사용자 - 선택 불가 / 사용부서 - 선택 가능 (사용자 유지) */
			expendEmpChange = false; // 사용자 선택 가능 여부 >> fnExpendMasterEmpPop
			expendDeptChange = true; // 부서 선택 가능 여부 >> fnExpendMasterDeptPop
			expendEmpDeptLink = false; // 부서 내 사용자만 조회 여부 >> fnExpendMasterEmpPop
			expendEmpDeptLinkChange = false; // 사용자 변경 시 부서 변경 여부 >> fnExpend_Callback_Dept && fnExpend_Callback_Emp
		}
		else if(functionOption.value == "50"){
			/* 50 : 사용자 - 선택 가능 / 사용부서 - 선택 가능 (사용자 선택 시 사용부서는 사용자가 속한 부서 입력) */
			expendEmpChange = true; // 사용자 선택 가능 여부 >> fnExpendMasterEmpPop
			expendDeptChange = true; // 부서 선택 가능 여부 >> fnExpendMasterDeptPop
			expendEmpDeptLink = false; // 부서 내 사용자만 조회 여부 >> fnExpendMasterEmpPop
			expendEmpDeptLinkChange = true; // 사용자 변경 시 부서 변경 여부 >> fnExpend_Callback_Dept && fnExpend_Callback_Emp
		}
		
		if(!expendEmpChange) {
			$('#txtExpendEmpCode, #txtExpendEmpName').attr('readonly', 'readonly');
		}
		
		if(!expendDeptChange) {
			$('#txtExpendDeptCode, #txtExpendDeptName').attr('readonly', 'readonly');
		}
		break;
	case '003107':
		if(functionOption.value == "N"){
			hideMngWrite = false;
		}
		break;
	}
}

/*=================================================================*/
/* 기능 옵션 끝 */
/*=================================================================*/