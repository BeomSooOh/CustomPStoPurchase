

//사용방법 BudgetCheck.GetBudgetInfo(_org_seq, _budget_ym, _acct_code, _input_amt);
//리턴 json(aaData)
function BudgetCheck(){

	var budget_name = '';
	var unit_gb = '';
	var org_year  = '';
	var control_gb = '';
	var acct_code = '';
	var acct_name = '';
	var org_seq = 0;
	var budget_ym = '';
	var req_amt = 0;
	var use_amt = '';
	
	var org_amt = {"jan":"0","feb":"0","mar":"0","apr":"0","may":"0","jun":"0","jul":"0","aug":"0","sep":"0","oct":"0","nov":"0","dec":"0"};
	var adj_amt = {"jan":"0","feb":"0","mar":"0","apr":"0","may":"0","jun":"0","jul":"0","aug":"0","sep":"0","oct":"0","nov":"0","dec":"0"};
	var shi_amt = {"jan":"0","feb":"0","mar":"0","apr":"0","may":"0","jun":"0","jul":"0","aug":"0","sep":"0","oct":"0","nov":"0","dec":"0"};
	var rec_amt = {"jan":"0","feb":"0","mar":"0","apr":"0","may":"0","jun":"0","jul":"0","aug":"0","sep":"0","oct":"0","nov":"0","dec":"0"};
	
	
	
	//계정과목 금액정보가져오기
	function GetBudgetInfo(_org_seq, _budget_ym, _acct_code, _input_amt){
		this.budget_ym = _budget_ym;
		this.org_seq = _org_seq;
		this.acct_code = _acct_code;
		this.req_amt = _input_amt;
		fnGetAmtInfo(ResultFunc);
	}
	
	// 예산금액정보 호출
	function fnGetAmtInfo(callback){
		var params = {};
		params.budget_ym = this.budget_ym;
		params.org_seq = this.org_seq;
		params.acct_code = this.acct_code;
		params.req_amt = this.req_amt;
		
		var url = "/expend/ex/user/budget/ExBudgetInfoSelect.do";
		$.ajax({
			async: false,
			type: "post",
			data : params,
			url: url,
			datatype: "json",
			success: function (result) {
				console.log(result);
			},
			error: function (err) {
				alert("데이터 조회 중 오류가 발생하였습니다.")
				console.log(err);
			}
		});	
	}

	
	//결과값 계산
	function ResultFunc(){
		var aaData = {};
		aaData.budget_name = this.budget_name; //예산명칭
		aaData.org_seq = this.org_seq;// 예산순번
		aaData.unit_gb = this.unit_gb; //예산구분
		aaData.org_year = this.org_year;//예산년도
		aaData.acct_code = this.acct_code;//계정과목코드
		aaData.acct_name = this.acct_name;//계정과목 명
		aaData.use_amt = this.use_amt; // 전체사용금액
		
		var totalAmt = 0;
		var orgAmt = 0;
		var adjAmt = 0;
		var shiAmt = 0;
		var recAmt = 0;
		var remainAmt = 0;
		var overflowYN = '';
		var txtInfo = '';
		
		if(control_gb === 'Y'){
			
			totalAmt = Number(org_amt.dec) + Number(adj_amt.dec);
			orgAmt = org_amt.dec;
			adjAmt= adj_amt.dec;
			remainAmt = (totalAmt - this.use_amt) - req_amt;
			
			aaData.total_amt = totalAmt;
			aaData.org_amt = orgAmt;
			aaData.adj_amt = adjAmt;
			aaData.shi_amt = 0;
			aaData.rec_amt = 0;
			aaData.rem_amt = remainAmt;
			if(rem_amt <= 0)
			{
				aaData.overflow_yn = 'Y';
				aaData.txt_info = '예산금액을 초과하였습니다.';
			}
			else{
				aaData.overflow_yn = 'N';
				aaData.txt_info = '해당 계정과목에 대한 예산을 사용할 수 있습니다.';
			}
		}
		else if(control_gb === 'M'){
			var req_month = budget_ym.substr(budget_ym.length-1, 2);
			
			if(req_month === '01')
			{
				orgAmt = org_amt.jan;
				adjAmt= adj_amt.jan;
				shiAmt = shi_amt.jan;
				recAmt = rec_amt.jan;
				totalAmt = Number(org_amt.jan) + Number(adj_amt.jan) + Number(adj_amt.jan);
				remainAmt = (totalAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '02')
			{
				orgAmt = org_amt.feb;
				adjAmt = adj_amt.feb;
				shiAmt = shi_amt.feb;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.feb) + Number(adj_amt.feb) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '03')
			{
				orgAmt = org_amt.mar;
				adjAmt = adj_amt.mar;
				shiAmt = shi_amt.mar;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.mar) + Number(adj_amt.mar) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '04')
			{
				orgAmt = org_amt.apr;
				adjAmt = adj_amt.apr;
				shiAmt = shi_amt.apr;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.apr) + Number(adj_amt.apr) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '05')
			{
				orgAmt = org_amt.may;
				adjAmt = adj_amt.may;
				shiAmt = shi_amt.may;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.may) + Number(adj_amt.may) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '06')
			{
				orgAmt = org_amt.jun;
				adjAmt = adj_amt.jun;
				shiAmt = shi_amt.jun;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may' || idx==='jun')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.jun) + Number(adj_amt.jun) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '07')
			{
				orgAmt = org_amt.jul;
				adjAmt = adj_amt.jul;
				shiAmt = shi_amt.jul;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may' || idx==='jun' || idx==='jul')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.jul) + Number(adj_amt.jul) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '08')
			{
				orgAmt = org_amt.aug;
				adjAmt = adj_amt.aug;
				shiAmt = shi_amt.aug;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may' || idx==='jun' || idx==='jul' || idx==='aug')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.aug) + Number(adj_amt.aug) +Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '09')
			{
				orgAmt = org_amt.sep;
				adjAmt = adj_amt.sep;
				shiAmt = shi_amt.sep;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may' || idx==='jun' || idx==='jul' || idx==='aug' || idx==='sep')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.sep) + Number(adj_amt.sep) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '10')
			{
				orgAmt = org_amt.oct;
				adjAmt = adj_amt.oct;
				shiAmt = shi_amt.oct;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may' || idx==='jun' || idx==='jul' || idx==='aug' || idx==='sep' || idx==='oct')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.oct) + Number(adj_amt.oct)+Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '11')
			{
				orgAmt = org_amt.nov;
				adjAmt = adj_amt.nov;
				shiAmt = shi_amt.nov;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may' || idx==='jun' || idx==='jul' || idx==='aug' || idx==='sep' || idx==='oct' || idx==='nov')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.nov) + Number(adj_amt.nov) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '12')
			{
				orgAmt = org_amt.dec;
				adjAmt = adj_amt.dec;
				shiAmt = shi_amt.dec;
				$.each(this.rec_amt, function(idx, value) {
					if(idx === 'jan' || idx === 'feb' || idx==='mar' || idx ==='apr' || idx==='may' || idx==='jun' || idx==='jul' || idx==='aug' || idx==='sep' || idx==='oct' || idx==='nov' || idx==='dec')
					{
						recAmt = recAmt + value; 
					}
				}
				totalAmt = Number(org_amt.dec) + Number(adj_amt.dec) + Number(recAmt);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			
			aaData.total_amt = totalAmt;
			aaData.org_amt = orgAmt;
			aaData.adj_amt = adjAmt;
			aaData.shi_amt = shiAmt;
			aaData.rec_amt = recAmt;
			aaData.rem_amt = remainAmt;
			if(rem_amt <= 0)
			{
				aaData.overflow_yn = 'Y';
				aaData.txt_info = '예산금액을 초과하였습니다.';
			}
			else{
				aaData.overflow_yn = 'N';
				aaData.txt_info = '해당 계정과목에 대한 예산을 사용할 수 있습니다.';
			}
				
		}
		else if(control_gb ==='H'){
			var req_month = budget_ym.substr(budget_ym.length-1, 2);
			
			if(req_month === '01' ||req_month === '02'||req_month === '03'||req_month === '04'||req_month === '05'||req_month === '06')
			{
				orgAmt = org_amt.jun;
				adjAmt= adj_amt.jun;
				shiAmt = shi_amt.jun;
				recAmt = rec_amt.jun;
				totalAmt = Number(org_amt.jun) + Number(adj_amt.jun);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else 
			{
				orgAmt = org_amt.dec;
				adjAmt = adj_amt.dec;
				shiAmt = shi_amt.dec;
				recAmt = rec_amt.jun;
				totalAmt = Number(org_amt.dec) + Number(adj_amt.dec) +Number(recAmt);
				remainAmt = (totalAmt - this.use_amt) - req_amt;
			}
		}
		else if(control_gb ==='Q'){
			var req_month = budget_ym.substr(budget_ym.length-1, 2);
			
			if(req_month === '01' ||req_month === '02'||req_month === '03')
			{
				orgAmt = org_amt.mar;
				adjAmt= adj_amt.mar;
				shiAmt = shi_amt.mar;
				recAmt = rec_amt.mar;
				totalAmt = Number(org_amt.mar) + Number(adj_amt.mar);
				remainAmt = (totalAmt - shiAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '04' ||req_month === '05'||req_month === '06')
			{
				orgAmt = org_amt.jun;
				adjAmt = adj_amt.jun;
				shiAmt = shi_amt.jun;
				recAmt = rec_amt.jun;
				totalAmt = Number(org_amt.jun) + Number(adj_amt.jun) +Number(recAmt);
				remainAmt = (totalAmt - this.use_amt) - req_amt;
			}
			else if(req_month === '07' ||req_month === '08'||req_month === '09')
			{
				orgAmt = org_amt.sep;
				adjAmt = adj_amt.sep;
				shiAmt = shi_amt.sep;
				recAmt = rec_amt.jun + rec_amt.sep;
				totalAmt = Number(org_amt.sep) + Number(adj_amt.sep) +Number(recAmt);
				remainAmt = (totalAmt - this.use_amt) - req_amt;
			}
			else
			{
				orgAmt = org_amt.dec;
				adjAmt = adj_amt.dec;
				shiAmt = shi_amt.dec;
				recAmt = rec_amt.jun + rec_amt.sep + rec_amt.dec;
				totalAmt = Number(org_amt.sep) + Number(adj_amt.sep) +Number(recAmt);
				remainAmt = (totalAmt - this.use_amt) - req_amt;
			}
			
			aaData.total_amt = totalAmt;
			aaData.org_amt = orgAmt;
			aaData.adj_amt = adjAmt;
			aaData.shi_amt = shiAmt;
			aaData.rec_amt = recAmt;
			aaData.rem_amt = remainAmt;
			if(rem_amt <= 0)
			{
				aaData.overflow_yn = 'Y';
				aaData.txt_info = '예산금액을 초과하였습니다.';
			}
			else{
				aaData.overflow_yn = 'N';
				aaData.txt_info = '해당 계정과목에 대한 예산을 사용할 수 있습니다.';
			}
			
			
		}
		else if(control_gb ==='N'){
			aaData.total_amt = '';
			aaData.org_amt = 'N';
			aaData.adj_amt = 'N';
			aaData.shi_amt = 'N';
			aaData.rec_amt = 'N';
			aaData.rem_amt = 'N';
			aaData.overflow_yn = 'N';
			aaData.txt_info = '예산미통제';
		}
		else{
			return '오류가 발생하였습니다.(잘못된 예산 통제구분 값입니다.)';
		}
		
		return aaData;
	}
	
	

}