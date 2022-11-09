/*
 * 그룹웨어 예산 확인 스크립트
 */

//네임스페이스 GWEXBUDGET 선언
if(typeof GWEXBUDGET === undefined){
	var GWEXBUDGET = {};
	
}

GWEXBUDGET.params = {};
//GWEXBUDGET 변수 선언
GWEXBUDGET.check = (function() {	
	//예산정보
	var budget_info = {
		org_seq : 0,
		budget_name : '',
		unit_gb : '',
		org_year : '',
		control_gb : '',
		acct_code : '',
		acct_name : '',
		budget_ym : {year :'', month :''},
		total_amt : 0,
		org_amt : 0,
		adj_amt : 0,
		shi_amt : 0,
		bal_amt : 0,
		req_amt : 0,
		use_amt : 0, //사용금액
		overflow_yn : 'N',
		error : '',
		result_txt : ''
	};
	
	//예산금액 정보( 배열 형태로 구성하였다. 0번 = 1월금액, 1번 = 2월금액..)
	var budget_amt = {
		org_amt : [0,0,0,0,0,0,0,0,0,0,0,0],
		adj_amt : [0,0,0,0,0,0,0,0,0,0,0,0],
		shi_amt : [0,0,0,0,0,0,0,0,0,0,0,0],
		rec_amt : [0,0,0,0,0,0,0,0,0,0,0,0]
	};
	
	// 계정과목 금액정보가져오기
	var init = (function(param) {
		this.budget_info.budget_ym.year = param.budget_ym || '';
		this.budget_info.budget_ym.month = param.budget_ym.substr(budget_ym.length-1, 2);
		this.budget_info.acct_code = param.acct_code || '';
		this.budget_info.org_seq = param.org_seq || 0;
		this.budget_info.req_amt = param.req_amt || 0;
	});

	//데이터 가져오기
	var getdata = (function(){
		//var url =  _g_contextPath_  + '지출결의 자체예산 금액정보 가져오기';
		var url =  _g_contextPath_;
		
		var params = {};
		params.budget_ym = this.budget_info.budget_ym;
		params.acct_code = this.budget_info.acct_code;
		params.org_seq = this.budget_info.org_seq;
		params.req_amt = this.budget_info.req_amt;
		params.unit_code = this.budget_info.unit_code;
		$.ajax({
			async: false,
			type: "post",
			url: url,
			datatype: "json",
			data : params.parameter,
			success: function (result) {
				if(result){
					budget_amt.org_amt = result.aaData.org_amt;
					budget_amt.adj_amt = result.aaData.adj_amt;
					budget_amt.shi_amt = result.aaData.shi_amt;
					budget_amt.rec_amt = result.aaData.rec_amt;
					budget_info.budget_name = result.aaData.budget_name;
					if(result.aaData.unit_gb === 'C'){
						budget_info.unit_gb = '회사 단위 편성';
					}
					else if(result.aaData.unit_gb === 'W'){
						budget_info.unit_gb = '사업장 단위 편성';
					}
					else if(result.aaData.unit_gb === 'D'){
						budget_info.unit_gb = '부서 단위 편성';
					}
					else if(result.aaData.unit_gb === 'T'){
						budget_info.unit_gb = '팀 단위 편성';
					}
					else if(result.aaData.unit_gb === 'P'){
						budget_info.unit_gb = '임직원 단위 편성';
					}
					else{
						budget_info.unit_gb = '';
						budget_info.error = '예산편성 단위에 대한 구분 값이 없습니다.';
					}
					budget_info.org_year = result.aaData.org_year;
					budget_info.control_gb = result.aaData.control_gb;
					budget_info.acct_name = result.aaData.acct_name;	
				}
			},
			error: function (err) {
				alert("데이터 조회 중 오류가 발생하였습니다.");
				budget_info.error = '데이터 조회 중 에러';
				console.log(err);
			}
	});
	
	// 총금액, 잔액계산
	var calc = (function() {
		if(budget_info.control_gb ==='Y'){
			budget_info.total_amt = Number(org_amt[11] + adj_amt[11]);
			budget_info.bal_amt = Number(org_amt[11] + adj_amt[11] - use_amt - req_amt);
		}
		else if(budget_info.control_gb ==='M'){
			switch(budget_info.budget_ym.month){
				case '01':
				budget_info.total_amt = Number(org_amt[0] + adj_amt[0]);
				budget_info.bal_amt = Number(org_amt[0] + adj_amt[0] - shi_amt[0] - use_amt - req_amt);
					break;
				case '02':
					budget_info.total_amt = Number(org_amt[1]+ adj_amt[1] + rec_amt[1]);
					budget_info.bal_amt = Number(org_amt[1] + adj_amt[1] + rec_amt[1] - shi_amt[1] - use_amt - req_amt);
					break;
				case '03':
					budget_info.total_amt = Number(org_amt[2]+ adj_amt[2] + rec_amt[2]);
					budget_info.bal_amt = Number(org_amt[2] + adj_amt[2] + rec_amt[2] - shi_amt[2] - use_amt - req_amt);
					break;
				case '04':
					budget_info.total_amt = Number(org_amt[3]+ adj_amt[3] + rec_amt[3]);
					budget_info.bal_amt = Number(org_amt[3] + adj_amt[3] + rec_amt[3] - shi_amt[3] - use_amt - req_amt);
					break;
				case '05':
					budget_info.total_amt = Number(org_amt[4]+ adj_amt[4] + rec_amt[4]);
					budget_info.bal_amt = Number(org_amt[4] + adj_amt[4] + rec_amt[4] - shi_amt[4] - use_amt - req_amt);
					break;
				case '06':
					budget_info.total_amt = Number(org_amt[5]+ adj_amt[5] + rec_amt[5]);
					budget_info.bal_amt = Number(org_amt[5] + adj_amt[5] + rec_amt[5] - shi_amt[5] - use_amt - req_amt);
					break;
				case '07':
					budget_info.total_amt = Number(org_amt[6]+ adj_amt[6] + rec_amt[6]);
					budget_info.bal_amt = Number(org_amt[6] + adj_amt[6] + rec_amt[6] - shi_amt[6] - use_amt - req_amt);
					break;
				case '08':
					budget_info.total_amt = Number(org_amt[7]+ adj_amt[7] + rec_amt[7]);
					budget_info.bal_amt = Number(org_amt[7] + adj_amt[7] + rec_amt[7] - shi_amt[7] - use_amt - req_amt);
					break;
				case '09':
					budget_info.total_amt = Number(org_amt[8]+ adj_amt[8] + rec_amt[8]);
					budget_info.bal_amt = Number(org_amt[8] + adj_amt[8] + rec_amt[8] - shi_amt[8] - use_amt - req_amt);
					break;
				case '10':
					budget_info.total_amt = Number(org_amt[9]+ adj_amt[9] + rec_amt[9]);
					budget_info.bal_amt = Number(org_amt[9] + adj_amt[9] + rec_amt[9] - shi_amt[9] - use_amt - req_amt);
					break;
				case '11' :
					budget_info.total_amt = Number(org_amt[10]+ adj_amt[10] + rec_amt[10]);
					budget_info.bal_amt = Number(org_amt[10] + adj_amt[10] + rec_amt[10] - shi_amt[10] - use_amt - req_amt);
					break;
				case '12':
					budget_info.total_amt = Number(org_amt[11]+ adj_amt[11] + rec_amt[11]);
					budget_info.bal_amt = Number(org_amt[11] + adj_amt[11] + rec_amt[11] - shi_amt[11] - use_amt - req_amt);
					break;
				default :
					budget_info.total_amt = 0;
				    budget_info.bal_amt =0;
					
			}
		}
		else if(budget_info.control_gb ==='H'){
			switch(budget_info.budget_ym.month){
				case '01','02','03','04','05','06':
					budget_info.total_amt = Number(org_amt[5] + adj_amt[5]);
					budget_info.bal_amt = Number(org_amt[5] + adj_amt[5] - shi_amt[5] - use_amt - req_amt);
					break;
				case '07','08','09','10','11','12':
					budget_info.total_amt = Number(org_amt[11] + adj_amt[11] + rec_amt[11]);
					budget_info.bal_amt = Number(org_amt[11] + adj_amt[11] + rec_amt[11] - use_amt - req_amt);
					break;
				default :
					budget_info.total_amt = 0;
				    budget_info.bal_amt =0;
			}
		}
		else if(budget_info.control_gb ==='Q'){
			switch(budget_info.budget_ym.month){
				case '01','02','03':
					budget_info.total_amt = Number(org_amt[2] + adj_amt[2]);
					budget_info.bal_amt = Number(org_amt[2] + adj_amt[2] - shi_amt[2] - use_amt - req_amt);
					break;
				case '04','05','06':
					budget_info.total_amt = Number(org_amt[5] + adj_amt[5] + rec_amt[5]);
					budget_info.bal_amt = Number(org_amt[5] + adj_amt[5] + rec_amt[5] - shi_amt[5] - use_amt - req_amt);
					break;
				case '07','08','09':
					budget_info.total_amt = Number(org_amt[8] + adj_amt[8] + rec_amt[8]);
					budget_info.bal_amt = Number(org_amt[8] + adj_amt[8] + rec_amt[8] - shi_amt[8] - use_amt - req_amt);
					break;
				case '10','11','12':
					budget_info.total_amt = Number(org_amt[11] + adj_amt[11] + rec_amt[11]);
					budget_info.bal_amt = Number(org_amt[11] + adj_amt[11] + rec_amt[11] - shi_amt[11] - use_amt - req_amt);
					break;
				default :
					budget_info.total_amt = 0;
				    budget_info.bal_amt =0;
			}
		}
		else if(budget_info.control_gb ==='N'){
			budget_info.total_amt = 0;
		    budget_info.bal_amt = 0;
		}
		else{
			budget_info.error = '[알 수 없는 예산확인 요청]예산통제 구분 값이 없습니다.';
		}
	});

	var result =(function(){
		if(budget_info.error !== ''){
			result_txt = '예산확인 중 오류가 발생하였습니다.';
		}
		else{
			if(budget_info.control_gb === 'N'){
				result_txt = '예산미통제';
			}
			else{
				if(budget_info.bal_amt < 0){
					budget_info.overflow_yn = 'Y';
					budget_info.result_txt = '예산초과';
				}
			}
		}
		return budget_info;
	});
	
	return {
		getBudgetInfo : function(){
			init(GWEXBUDGET.params);
			getdata();
			calc();
			return result();
		}
	};

})(GWEXBUDGET.params);


//해당함수 호출하여 사용
//요청파라메터: params{budget_ym : '' , acct_code : '', org_seq : '', req_amt:''}
function fnGetGWBudgetInfo(params)
{
	GWEXBUDGET.params = params;
	return	GWEXBUDGET.check.getBudgetInfo(GWEXBUDGET.params);
}