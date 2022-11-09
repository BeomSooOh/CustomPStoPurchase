/* 	이지바로 코드팝업 스크립트 함수 모음 
 *  2017.03.08 개발1팀 회계파트
 */


/* 최초 요청시 데이터에 대한 요청값을 구분하는 곳 */
function fnLoadRequestData(bindId, item){
	var result = '';
	
	/* 전역변수 */
	headjson ='';
	dataJson ='';
	
	switch(item.id)
	{
		case 'project':/* 연구과제 */
			fnSetGridHeaderProect();
			result = fnGetAjaxCode('project');
			fnMakeProjectCodeJson(result);
			break;
		case 'bmcode':/* 세목 */
			fnSetGridHeaderBMcode();
			result = fnGetAjaxCode('bmcode');
			fnMakeBMCodeJson(result);
			break;
		case 'use':/* 사용용도 */
			fnSetGridHeaderUseCode();
			result = fnGetAjaxCode('use');
			fnMakeUseCodeJson(result);
			break;
		case 'execmtd':/* 집행방법 */
			fnSetGridHeaderExecMtdCode();
			result = fnGetAjaxCode('execmtd');
			fnMakeExecMtdCodeJson(result);
			break;
		case 'execreqdiv':/* 집행요청구분 */
			fnSetGridHeaderExecReqDivCode();
			result = fnGetAjaxCode('execreqdiv');
			fnMakeExecReqDivCodeJson(result);
			break;
		case 'inoutaccount':/* G20입출금계좌 */
			fnSetGridHeaderInOutAccountCode();
			result = fnGetAjaxCode('inoutaccount');
			fnMakeInOutAccountCodeJson(result);
			break;
		case 'partner':/* 거래처 */
			var codeParam = fnInspectCodeHelpParams();
			if(codeParam.partnergbn == '1'){
				fnSetGridHeaderPartnerCode();
			}
			else if(codeParam.partnergbn == '2' || codeParam.partnergbn == '8'){
				fnSetGridHeaderResearcherCode();
			}
			else if(codeParam.partnergbn == '4'){
				fnSetGridHeaderEtcIncomeCode();
			}
			result = fnGetAjaxCode('partner');
			fnMakePartnerCodeJson(result);
			break;
		case 'researcher': /* 연구원*/
		case 'nm':
		case 'entrant':
		case 'peopleregno': /* 품목상세 */
			fnSetGridHeaderResearcherCode();
			result = fnGetAjaxCode('researcher');
			fnMakeResearcherCodeJson(result);
			break;
		case 'bank':
			fnSetGridHeaderBankCode();
			result = fnGetAjaxCode('bank');
			fnMakeBankCodeJson(result);
			break;
		case 'itemgbn':  /* 품목상세 */
			fnSetGridHeaderItemGbnCode();
			result = fnGetAjaxCode('itemgbn');
			fnMakeItemGbnCodeJson(result);
			break;
		case 'belonggbn':
			fnSetGridHeaderBelongGbnCode();
			result = fnGetAjaxCode('belonggbn');
			fnMakeBelongGbnCodeJson(result);
			break;
		case 'inoutgbn': /* 품목상세 */
			fnSetGridHeaderInoutGbnCode();
			result = fnGetAjaxCode('inoutgbn');
			fnMakeInoutGbnCodeJson(result);
			break;
		case 'usemethod': /* 품목상세 */
			fnSetGridHeaderUsemethodCode();
			result = fnGetAjaxCode('inoutgbn');
			//fnMakeUsemethodCodeJson(result);
			fnMakeInoutGbnCodeJson(result);
			break;
		case 'taxapprno': /* 전자세금계산서 */
			fnSetGridHeaderETaxCode();
			result = fnGetAjaxCode('taxapprno');
			fnMakeETaxCodeJson(result);
			break;
		case 'cardnum': /* 카드번호 */
			fnSetGridHeaderCardNumCode();
			result = fnGetAjaxCode('cardnum');
			fnMakeCardNumCodeJson(result);
			break;
		case 'partnergbn': /* 거래처 구분 */
			fnMakePartnerGbnCodeJson();
			fnSetGridHeaderPartnerGbnCode();
			break;
		case 'rate': /* 참여율 */
			fnSetGridHeaderRateCode();
			result = fnGetAjaxCode('rate');
			fnMakeRateCodeJson(result);
			break;
		default :
			break;
	}
}

/* 코드팝업 파라메터 업데이트 확인 */
function fnUpdateCodeHelpParams(newparam){
	$.each(ezparamList, function(index,item){
		if(item.key == groupClass)
		{
			fnSetCodeHelpParams(item,newparam);
			return false;
		}
	});
}

/* 코드팝업 파라메터 변수 존재 여부 확인 */
function fnInspectCodeHelpParams(){
	var exist = false;
	var retValue = {};
	
	$.each(ezparamList, function(index,item){
		if(item.key == groupClass)
		{
			retValue = item;
			exist = true;
			return false;
		}
	});
	
	//존재하지 않으면 생성하라.
	if(exist == false){
		var initValue = JSON.parse($("#hdnInitInfo").val());
		var newparam = 
		{	'key' : groupClass,
			'partnergbn' : '',
			'CO_CD' : initValue.CO_CD, 
			'LANGKIND' : 'KOR',
			'PRJNO':'',
			'OFCODE':'',
			'BIZGRP':'',
			'CODEDIV':'',
			'BMCODE':'',
			'P_HELP_TY':'',
			'P_CODE':'',
			'P_CODE2':'',
			'P_CODE3':'',
			'P_USE_YN':'',
			'P_NAME':'',
			'P_STD_DT':'',
			'P_WHERE':'',
			'RESPERSONNO':''
		};
		ezparamList.push(newparam);
		retValue = newparam;
	}
	return retValue;
}

/* 코드팝업 업데이트 */
function fnSetCodeHelpParams(ezparam, param) {
	ezparam.CO_CD = param.CO_CD || ezparam.CO_CD;
	ezparam.LANGKIND = param.LANGKIND || ezparam.LANGKIND;
	ezparam.PRJNO = param.PRJNO || ezparam.PRJNO;
	ezparam.OFCODE = param.OFCODE || ezparam.OFCODE;
	ezparam.BIZGRP = param.BIZGRP || ezparam.BIZGRP;
	ezparam.CODEDIV = param.CODEDIV || ezparam.CODEDIV;
	ezparam.BMCODE = param.BMCODE || ezparam.BMCODE;
	ezparam.P_HELP_TY = param.P_HELP_TY || ezparam.P_HELP_TY;
	ezparam.P_CODE = param.P_CODE || ezparam.P_CODE;
	ezparam.P_CODE2 = param.P_CODE2 || ezparam.P_CODE2;
	ezparam.P_CODE3 = param.P_CODE3 || ezparam.P_CODE3;
	ezparam.P_USE_YN = param.P_USE_YN || ezparam.P_USE_YN;
	ezparam.P_NAME = param.P_NAME || ezparam.P_NAME;
	ezparam.P_STD_DT = param.P_STD_DT || ezparam.P_STD_DT;
	ezparam.P_WHERE = param.P_WHERE || ezparam.P_WHERE;
	ezparam.RESPERSONNO = param.RESPERSONNO || ezparam.RESPERSONNO;
	ezparam.partnergbn = param.partnergbn ||  ezparam.partnergbn;
	
	return ezparam;
}

/* 실 데이터 업데이트 */
function fnSetLevel1Data(ezData, param) {
	ezData.LANGKIND =param.LANGKIND || ezData.LANGKIND;
	ezData.CO_CD=param.CO_CD || ezData.CO_CD;
	ezData.TASK_DT =param.TASK_DT || ezData.TASK_DT;
	ezData.TASK_SQ =param.TASK_SQ || ezData.TASK_SQ;
	ezData.OFCODE =param.OFCODE || ezData.OFCODE;
	ezData.PRJNO =param.PRJNO || ezData.PRJNO;
	ezData.EXECDATE =param.EXECDATE ||ezData.EXECDATE;
	ezData.REGNO =param.REGNO ||ezData.REGNO;
	ezData.DIV_CD =param.DIV_CD ||ezData.DIV_CD;
	ezData.DEPT_CD =param.DEPT_CD ||ezData.DEPT_CD;
	ezData.EMP_CD =param.EMP_CD ||ezData.EMP_CD;
	ezData.EXECTIME =param.EXECTIME ||ezData.EXECTIME;
	ezData.EXECSEQ =param.EXECSEQ ||ezData.EXECSEQ;
	ezData.BIZGRP =param.BIZGRP ||ezData.BIZGRP;
	ezData.BMCODE =param.BMCODE ||ezData.BMCODE;
	ezData.EXECREQDIV =param.EXECREQDIV ||ezData.EXECREQDIV;
	ezData.EXECDIV =param.EXECDIV ||ezData.EXECDIV;
	ezData.EXECMTD =param.EXECMTD ||ezData.EXECMTD;
	ezData.RESOLNO =param.RESOLNO ||ezData.RESOLNO;
	ezData.RESOLDATE =param.RESOLDATE ||ezData.RESOLDATE;
	ezData.CONT =param.CONT ||ezData.CONT;
	ezData.BELONG =param.BELONG ||ezData.BELONG;
	ezData.NM =param.NM ||ezData.NM;
	ezData.RESPERSONNO =param.RESPERSONNO ||ezData.RESPERSONNO;
	ezData.POSI =param.POSI ||ezData.POSI;
	ezData.PAYYYMM =param.PAYYYMM ||ezData.PAYYYMM;
	ezData.PARTRATE =param.PARTRATE ||ezData.PARTRATE;
	ezData.PAYBASEAMT =param.PAYBASEAMT ||ezData.PAYBASEAMT;
	ezData.RESOLAMT =param.RESOLAMT ||ezData.RESOLAMT;
	ezData.EXTTAX =param.EXTTAX ||ezData.EXTTAX;
	ezData.ACCREGAMT =param.ACCREGAMT ||ezData.ACCREGAMT;
	ezData.COURTAMT =param.COURTAMT ||ezData.COURTAMT;
	ezData.CHARGE =param.CHARGE ||ezData.CHARGE;
	ezData.EXECBANK =param.EXECBANK ||ezData.EXECBANK;
	ezData.EXECREQACCNO =param.EXECREQACCNO ||ezData.EXECREQACCNO;
	ezData.ACCOWNER =param.ACCOWNER ||ezData.ACCOWNER;
	ezData.EXECRECIP =param.EXECRECIP ||ezData.EXECRECIP;
	ezData.EXECREQFLAG =param.EXECREQFLAG ||ezData.EXECREQFLAG;
	ezData.TAXAPPRNO =param.TAXAPPRNO ||ezData.TAXAPPRNO;
	ezData.SUPPERSON =param.SUPPERSON ||ezData.SUPPERSON;
	ezData.SUPBIZNO =param.SUPBIZNO ||ezData.SUPBIZNO;
	ezData.MEETSDT =param.MEETSDT ||ezData.MEETSDT;
	ezData.MEETEDT =param.MEETEDT ||ezData.MEETEDT;
	ezData.MEETPLACE =param.MEETPLACE ||ezData.MEETPLACE;
	ezData.CONSIORG =param.CONSIORG ||ezData.CONSIORG;
	ezData.BIZNO =param.BIZNO ||ezData.BIZNO;
	ezData.SENDYN =param.SENDYN ||ezData.SENDYN;
	ezData.SENDOPT =param.SENDOPT ||ezData.SENDOPT;
	ezData.SENDDATE =param.SENDDATE ||ezData.SENDDATE;
	ezData.SENDTIME =param.SENDTIME ||ezData.SENDTIME;
	ezData.STATECODE =param.STATECODE ||ezData.STATECODE;
	ezData.STATETEXT =param.STATETEXT ||ezData.STATETEXT;
	ezData.RCVDATE =param.RCVDATE ||ezData.RCVDATE;
	ezData.RCVTIME =param.RCVTIME ||ezData.RCVTIME;
	ezData.RESOLCHKNO =param.RESOLCHKNO ||ezData.RESOLCHKNO;
	ezData.RESOLCHKTXT =param.RESOLCHKTXT ||ezData.RESOLCHKTXT;
	ezData.ORIGRESOLNO =param.ORIGRESOLNO ||ezData.ORIGRESOLNO;
	ezData.CHECKDATE =param.CHECKDATE ||ezData.CHECKDATE;
	ezData.CHECKUSER =param.CHECKUSER ||ezData.CHECKUSER;
	ezData.TRNSDATE =param.TRNSDATE ||ezData.TRNSDATE;
	ezData.TRNSTIME =param.TRNSTIME ||ezData.TRNSTIME;
	ezData.TRNSBANK =param.TRNSBANK ||ezData.TRNSBANK;
	ezData.TRNSACCNO =param.TRNSACCNO ||ezData.TRNSACCNO;
	ezData.TRNSACCOWNER =param.TRNSACCOWNER ||ezData.TRNSACCOWNER;
	ezData.RECIP =param.RECIP ||ezData.RECIP;
	ezData.TRNSAMT =param.TRNSAMT ||ezData.TRNSAMT;
	ezData.CARDNO =param.CARDNO ||ezData.CARDNO;
	ezData.TRSEQ =param.TRSEQ ||ezData.TRSEQ;
	ezData.TRDATE =param.TRDATE ||ezData.TRDATE;
	ezData.APPRNO =param.APPRNO ||ezData.APPRNO;
	ezData.GISU_DT =param.GISU_DT ||ezData.GISU_DT;
	ezData.GISU_SQ =param.GISU_SQ ||ezData.GISU_SQ;
	ezData.PJT_CD =param.PJT_CD ||ezData.PJT_CD;
	ezData.ABGT_CD =param.ABGT_CD ||ezData.ABGT_CD;
	ezData.TR_FG =param.TR_FG ||ezData.TR_FG;
	ezData.TR_CD =param.TR_CD ||ezData.TR_CD;
	ezData.CTR_CD =param.CTR_CD ||ezData.CTR_CD;
	ezData.CTR_NM =param.CTR_NM ||ezData.CTR_NM;
	ezData.ETCRVRS_YM =param.ETCRVRS_YM ||ezData.ETCRVRS_YM;
	ezData.ETCDIV_CD =param.ETCDIV_CD ||ezData.ETCDIV_CD;
	ezData.ETCDUMMY1 =param.ETCDUMMY1 ||ezData.ETCDUMMY1;
	ezData.NDEP_AM =param.NDEP_AM ||ezData.NDEP_AM;
	ezData.INAD_AM =param.INAD_AM ||ezData.INAD_AM;
	ezData.INTX_AM =param.INTX_AM ||ezData.INTX_AM;
	ezData.RSTX_AM =param.RSTX_AM ||ezData.RSTX_AM;
	ezData.WD_AM =param.WD_AM ||ezData.WD_AM;
	ezData.BG_SQ =param.BG_SQ ||ezData.BG_SQ;
	ezData.ETCPAY_DT =param.ETCPAY_DT ||ezData.ETCPAY_DT;
	ezData.ET_YN =param.ET_YN ||ezData.ET_YN;
	ezData.ETCDATA_CD =param.ETCDATA_CD ||ezData.ETCDATA_CD;
	ezData.ETCTAX_RT =param.ETCTAX_RT ||ezData.ETCTAX_RT;
	ezData.HIFE_AM =param.HIFE_AM ||ezData.HIFE_AM;
	ezData.NAPE_AM =param.NAPE_AM ||ezData.NAPE_AM;
	ezData.DDCT_AM =param.DDCT_AM ||ezData.DDCT_AM;
	ezData.NOIN_AM =param.NOIN_AM ||ezData.NOIN_AM;
	ezData.WD_AM2 =param.WD_AM2 ||ezData.WD_AM2;
	ezData.ETCRATE =param.ETCRATE ||ezData.ETCRATE;
	ezData.HINCOME_SQ =param.HINCOME_SQ ||ezData.HINCOME_SQ;
	ezData.PYTP_FG =param.PYTP_FG ||ezData.PYTP_FG;
	ezData.GW_STATE = ''|| '0'; 
	ezData.GW_ID = '';
	ezData.BTR_CD =param.BTR_CD ||ezData.BTR_CD;
	ezData.RMK_DC =param.RMK_DC ||ezData.RMK_DC;
	ezData.COURTAMT =param.COURTAMT ||ezData.COURTAMT;
	ezData.INSERT_IP =param.INSERT_IP ||ezData.INSERT_IP;
	ezData.MODIFY_ID =param.MODIFY_ID ||ezData.MODIFY_ID;
	ezData.MODIFY_IP =param.MODIFY_IP ||ezData.MODIFY_IP;
	ezData.TAX_TY =param.TAX_TY ||ezData.TAX_TY;
	ezData.TR_NM =param.TR_NM ||ezData.TR_NM;
	ezData.ETCDUMMY2 =param.ETCDUMMY2 || ezData.ETCDUMMY2;
	ezData.TAX_YN = param.TAX_YN || ezData.TAX_YN;
	
	$.each(ezDataLevel1List, function(index,item){
		if(item.key == groupClass)
		{
			item.data = ezData;
			return false;
		}
	});
}


/* 실 데이터 업데이트 */
function fnSetLevel2Data(ezData, param, rownum) {
	ezData.CO_CD=param.CO_CD || ezData.CO_CD;
	ezData.TAKS_DT =param.TAKS_DT || ezData.TAKS_DT;
	ezData.TASK_SQ =param.TASK_SQ || ezData.TASK_SQ;
	ezData.OFCODE =param.OFCODE || ezData.OFCODE;
	ezData.PRJNO =param.PRJNO || ezData.PRJNO;
	ezData.EXECDATE =param.EXECDATE ||ezData.EXECDATE;
	ezData.REGNO =param.REGNO ||ezData.REGNO;
	ezData.REGSEQ =param.REGSEQ ||ezData.REGSEQ;
	ezData.ARTDIV =param.ARTDIV ||ezData.ARTDIV;
	ezData.ITEMNAME =param.ITEMNAME ||ezData.ITEMNAME;
	ezData.STANDARD =param.STANDARD ||ezData.STANDARD;
	ezData.AMOUNT =param.AMOUNT ||ezData.AMOUNT;
	ezData.UNITCOST =param.UNITCOST ||ezData.UNITCOST;
	ezData.SUPCOST =param.SUPCOST ||ezData.SUPCOST;
	ezData.EXECREQDIV =param.EXECREQDIV ||ezData.EXECREQDIV;
	ezData.EXTTAX =param.EXTTAX ||ezData.EXTTAX;
	ezData.TOTPURCHAMT =param.TOTPURCHAMT ||ezData.TOTPURCHAMT;
	ezData.NTISREGNO =param.NTISREGNO ||ezData.NTISREGNO;
	ezData.NTISREGDATE =param.NTISREGDATE ||ezData.NTISREGDATE;
	ezData.CHECKDATE =param.CHECKDATE ||ezData.CHECKDATE;
	ezData.CHECKUSER =param.CHECKUSER ||ezData.CHECKUSER;
	ezData.GISU_DT =param.GISU_DT ||ezData.GISU_DT;
	ezData.GISU_SQ =param.GISU_SQ ||ezData.GISU_SQ;
	ezData.INSERT_ID =param.INSERT_ID ||ezData.INSERT_ID;
	ezData.INSERT_DT =param.INSERT_DT ||ezData.INSERT_DT;
	ezData.INSERT_IP =param.INSERT_IP ||ezData.INSERT_IP;
	ezData.MODIFY_ID =param.MODIFY_ID ||ezData.MODIFY_ID;
	ezData.MODIFY_DT =param.MODIFY_DT ||ezData.MODIFY_DT;
	ezData.MODIFY_IP =param.MODIFY_IP ||ezData.MODIFY_IP;
	
	
	var tmpList = [];
	$.each(ezDataLevel2List, function(index,item){
		if(item.key == groupClass)
		{
			tmpList = item.data;
			return false;
		}
	});
	
	$.each(tmpList, function(index,item){
		if(item.rownum == rownum)
		{
			item.data = ezData;
			return false;
		}
	});
}

/* 실제 데이터 결의상세 변수확인 */
function fnInspectLevel1Data(){
	var exist = false;
	var retValue = {};
	$.each(ezDataLevel1List, function(index, item){
		if(item.key == groupClass){
			retValue = item.data;
			exist = true;
			return false;
		}
	});
	
	if(exist == false){
		var node = {};
		
		var initValue = JSON.parse($("#hdnInitInfo").val());
		var newData = JSON.stringify(ANZR100);
		newData = JSON.parse(newData);
		newData.LANGKIND = 'KR';
		newData.CO_CD = initValue.CO_CD;
		newData.DIV_CD = initValue.DIV_CD;
		
		node.key = groupClass;
		node.data = newData;
		ezDataLevel1List.push(node);
		
		retValue = newData;
	}
	return retValue;
}


/* 실제 데이터 품목상세 변수확인 */
function fnInspectLevel2Data(rownum){
	var exist = false;
	var rowData = {};
	var retValue = {};
	$.each(ezDataLevel2List, function(index, item){
		if(item.key == groupClass){
			rowData = item.data;
			exist = true;
			return false;
		}
	});
	
	$.each(rowData, function(idex, item){
		if(item.rownum == rownum){
			retValue = item.data;
		}
	});
	
	if(exist == false){
		
		var listNode = {};
		var node = {};
		var initValue = JSON.parse($("#hdnInitInfo").val());
		var newData = JSON.stringify(ANZR100DETAIL);
		newData = JSON.parse(newData);
		newData.LANGKIND = 'KR';
		newData.CO_CD = initValue.CO_CD;
		
		node.data = newData;
		node.rownum = rownum;
		
		listNode.key = groupClass;
		listNode.data = [];
		listNode.data.push(node);
		
		ezDataLevel2List.push(listNode);
		
		retValue = node.data;
		
	}
	return retValue;
}

/* ===============================코드 바인드 모음=============================== */
function fnSetBindingCode(bindId,rowData){
	var key = bindId.split('_');
	var lvData;
	var lv2Data;
	
	if(key[0] != 'itemgbn' && key[0] !='inoutgbn' && key[0] != 'belonggbn' && key[0] != 'usemethod' && key[0] != 'peopleregno'){
		lvData = fnInspectLevel1Data();
	}
	else{
		lv2Data = fnInspectLevel2Data(key[1]);
	}
	
	
	switch(key[0])
	{
		case 'project':/* 연구과제 */
			$("#"+bindId).val(rowData.PRJNAME);
			$("#G20Project_"+key[1]+"_3").val(rowData.PJT_NM);
			lvData.PRJNO = rowData.PRJNO;
			//lvData.PJT_NM = rowData.PJT_NM;
			lvData.PJT_CD = rowData.PJT_CD;
			lvData.OFCODE = rowData.OFCODE; 
			lvData.BIZGRP = rowData.BIZGRP; 
			break;
		case 'bmcode':/* 세목 */
			$("#"+bindId).val(rowData.BMNAME);
			$("#G20abgt_"+key[1]+"_4").val(rowData.BM_NM);
			lvData.BMCODE = rowData.BMCODE;
			lvData.ABGT_CD = rowData.BM_CD;
			break;
		case 'use':/* 사용용도 */
			$("#"+bindId).val(rowData.CDNM);
			lvData.EXECDIV = rowData.CODE;
			break;
		case 'execmtd':/* 집행방법 */
			$("#"+bindId).val(rowData.CDNM);
			lvData.EXECMTD = rowData.CODE;
			break;
		case 'execreqdiv':/* 집행요청구분 */
			$("#"+bindId).val(rowData.EXECREQDIV_NM);
			lvData.EXECMTD = rowData.OFCODE;
			break;
		case 'inoutaccount':/* G20입출금계좌 */
			$("#"+bindId).val(rowData.ATTR_NM);
			lvData.BTR_CD = rowData.TR_CD;
			break;
		case 'partner':/* 거래처 */
			var arrElement = $("#"+bindId).attr('id').split('_');
			var codeParam = fnInspectCodeHelpParams();
			
			if(codeParam.partnergbn == '1'){
				//지급은행 코드팝업 수행
				var reqParam = {};
				reqParam.TR_CD = rowData.TR_CD;
				reqParam.LANGKIND = 'KOR';
				var hdnInit = JSON.parse($("#hdnInitInfo").val());
				reqParam.CO_CD = hdnInit.CO_CD;
				/* 호출 */
				var resultBankInfo = {CO_CD : '', TR_CD : '', DEPOSITOR :'', BANK_CD : '', BANK_NM:''};
				resultBankInfo = fnGetAjaxBankInfo(reqParam);
				if(resultBankInfo == null){
					resultBankInfo = {CO_CD : '', TR_CD : '', DEPOSITOR :'', BANK_CD : '', BANK_NM:''};
				}
				//거래처
				$("#"+bindId).val(rowData.TR_CD);
				//거래처명
				$("#partnernm_"+ arrElement[1] + "_3").val(rowData.ATTR_NM);
				//지급은행
				$("#bank_"+ arrElement[1] + "_13").val(resultBankInfo.BANK_NM);
				//지급계좌번호
				$("#bankaccount_"+ arrElement[1] + "_14").val(rowData.BA_NB);
				//지급예금주
				$("#accholder_"+ arrElement[1] + "_15").val(resultBankInfo.DEPOSITOR);
				
				lvData.TR_CD = rowData.TR_CD;
				lvData.TRNSBANK = resultBankInfo.BANK_NM;
				lvData.EXECBANK  = resultBankInfo.BANK_CD;
				lvData.TR_NM = rowData.ATTR_NM;
			}
			else if(codeParam.partnergbn =='2'){
				//거래처
				$("#"+bindId).val(rowData.EMP_CD);
				//거래처명
				$("#partnernm_"+ arrElement[1] + "_3").val(rowData.KOR_NM);
				//지급예금주
				$("#accholder"+ arrElement[1] + "_15").val(rowData.KOR_NM);
				
				lvData.TR_CD = rowData.TR_CD;
				lvData.TR_NM =rowData.KOR_NM;
			}
			else if(codeParam.partnergbn =='4'){
				//거래처
				$("#"+bindId).val(rowData.PER_CD);
				//거래처명
				$("#partnernm_"+ arrElement[1] + "_3").val(rowData.PER_NM);
				//지급은행
				$("#bank_"+ arrElement[1] + "_13").val(rowData.BANK_NM);
				//지급계좌번호
				$("#bankaccount_"+ arrElement[1] + "_14").val(rowData.ACCT_NO);
				//지급예금주
				$("#accholder_"+ arrElement[1] + "_15").val(rowData.ACCT_NM);
				
				lvData.TR_CD = rowData.TR_CD;
				lvData.TRNSBANK = rowData.BANK_NM;
				lvData.EXECBANK  = rowData.BANK_CD;	
				lvData.TR_NM  =rowData.PER_NM;
			}
			else if(codeParam.partnergbn == '8'){
				//지급은행 코드팝업 수행
				var reqParam = {};
				reqParam.EMP_CD = rowData.EMP_CD;
				reqParam.LANGKIND = 'KOR';
				var hdnInit = JSON.parse($("#hdnInitInfo").val());
				reqParam.CO_CD = hdnInit.CO_CD;
				/* 호출 */
				var resultBankInfo = {EMP_CD : '', KOR_NM : '', KOR_NMK :'', ACCT_NO : '', ACCT_NO2:'', PYTB_CD:'',DPST_NM:'',BANK_CD:'',BANK_NM:'',BANK_NMK:'',CAUSE_FG:'',RSRG_NO:'' };
				resultBankInfo = fnGetAjaxEmpBankInfo(reqParam);
				if(resultBankInfo == null){
					resultBankInfo = {CO_CD : '', TR_CD : '', DEPOSITOR :'', BANK_CD : '', BANK_NM:''};
				}
				//거래처
				$("#"+bindId).val(rowData.EMP_CD);
				//거래처명
				$("#partnernm_"+ arrElement[1] + "_3").val(rowData.KOR_NM);
				//지급은행
				$("#bank_"+ arrElement[1] + "_13").val(resultBankInfo.BANK_NM);
				//지급계좌번호
				$("#bankaccount_"+ arrElement[1] + "_14").val(resultBankInfo.ACCT_NO);
				//지급예금주
				$("#accholder_"+ arrElement[1] + "_15").val(resultBankInfo.DPST_NM);
				
				lvData.TR_CD = rowData.TR_CD;
				lvData.TRNSBANK = resultBankInfo.BANK_NM;
				lvData.EXECBANK  = resultBankInfo.BANK_CD;	
				lvData.TR_NM  = rowData.KOR_NM;
			}
			
			var lv1Data = fnInspectLevel1Data();
			var prjnm = '';
			var usenm = '';
			var execmtdnm = '';
			
			//결의내역 
			var resInputEle = $("#resolveContent_TRDATA").find('.'+groupClass).find('input');
			$.each(resInputEle, function(eleIdex,eleItem){
				var arrElement = $(eleItem).attr('id').split('_');
				if(arrElement[0].indexOf('project') == 0){
					prjnm = $(eleItem).val();
				}else if(arrElement[0].indexOf('bmcode') == 0){
					bmcodenm = $(eleItem).val();
				}else if(arrElement[0].indexOf('use') == 0){
					usenm = $(eleItem).val();
				}else if(arrElement[0].indexOf('execmtd') == 0){
					execmtdnm = $(eleItem).val();
				}
			});
			
			var arrElement = $("#"+bindId).attr('id').split('_');
			var txtValue = "작성일자 : " + $("#txtWriteDate").val() + "\n"+
						"연구과제 : " + lv1Data.PRJNO + "\n" +
						"연구과제명 : " + prjnm+ "\n" +
						"세목 : " + bmcodenm+ "\n" +
						"사용용도 : " + usenm+ "\n" +
						"집행방법 : " + execmtdnm+ "\n" +
						"거래처명 : " + $("#partnernm_"+ arrElement[1] + "_3").val()+ "\n";
			$('#resolNote').val(txtValue);
			fnSetResolNoteTxt();
			
			break;
		case 'nm':
		case 'entrant':
			$("#"+bindId).val(rowData.NM);
			lvData.RESPERSONNO = rowData.RESPERSONNO;
			lvData.BELONG = rowData.BELONG;
			lvData.NM = rowData.NM;
			lvData.POSI = rowData.POSI;
			$("#belong_"+key[1]+"_10").val(rowData.BELONG);
			$("#posi_"+key[1]+"_9").val(rowData.POSI);
			break;
		case 'bank':
			$("#"+bindId).val(rowData.CDNM);
			lvData.TRNSBANK = rowData.CDNM;
			lvData.EXECBANK = rowData.CODE;
			break;
		case 'itemgbn':
			$("#"+bindId).val(rowData.CDNM);
			lv2Data.ARTIDIV = rowData.CODE;
			break;
		case 'belonggbn':
			$("#"+bindId).val(rowData.CDNM);
			lv2Data.BELONGDIV = rowData.code;
			break;	
		case 'inoutgbn':
			$("#"+bindId).val(rowData.CDNM);
			lv2Data.AREADIV = rowData.CODE;
			break;	
		case 'peopleregno':
			$("#"+bindId).val(rowData.RESPERSONNO);
			lv2Data.RESPERSONNO = rowData.RESPERSONNO;
			lv2Data.BELONG = rowData.BELONG;
			lv2Data.NM = rowData.NM;
			lv2Data.POSI = rowData.POSI;
			$("#belongbizno_"+key[1]+"_27").val(rowData.BELONG);
			$("#entnm_"+key[1]+"_28").val(rowData.NM);
			break;	
		case 'usemethod':
			$("#entrant_"+key[1]+'_12').val(rowData.NM);
			lv2Data.PROFUSEDIV = rowData.CODE;
			break;
		case 'taxapprno':
			$("#taxapprno_"+key[1]+'_20').val(rowData.ISS_NO);
			$("#supperson_"+key[1]+'_21').val(rowData.TR_NM);
			$("#supbizno_"+key[1]+'_22').val(rowData.TRREG_NB);
			break;
		case 'cardnum':
			$("#cardnum_"+key[1]+'_4').val(rowData.CARDNO);
			$("#aprovNum_"+key[1]+'_5').val(rowData.APPRNO);
			$("#serialNum_"+key[1]+'_6').val(rowData.TRSEQ);
			$("#trdate_"+key[1]+'_7').val(rowData.TRDATE);			
			if(rowData.EXTTAX == ''){
				rowData.EXTTAX = 0;
			}	
			$("#resolamt_"+key[1]+'_29').val(Number(rowData.EXTTAX)+Number(rowData.DEMCOST));
			$("#taxamt_"+key[1]+'_30').val(rowData.EXTTAX);
			$("#supplyamt_"+key[1]+'_31').val(rowData.DEMCOST);
			
			break;
		case 'partnergbn':
			$("#"+bindId).val(rowData.CDNM);
			//partnergbn = rowData.CODE;
			$.each(ezparamList, function(index,item){
				if(item.key == groupClass)
				{
					var codeParam = {};
					codeParam.partnergbn = rowData.CODE;
					fnSetCodeHelpParams(item,codeParam);
					return false;
				}
			});
			
			break;
		case 'researcher':
			var arrElement = $("#"+bindId).attr('id').split('_');
			$("#"+bindId).val(rowData.NM);
			lvData.RESPERSONNO = rowData.RESPERSONNO;
			lvData.BELONG = rowData.BELONG;
			lvData.NM = rowData.NM;
			lvData.POSI = rowData.POSI;
			
			var lv1Data = fnInspectLevel1Data();
			
			//지급은행 코드팝업 수행
			var reqParam = {};
			reqParam.PRJNO = lv1Data.PRJNO;
			reqParam.RESPERSONNO = rowData.RESPERSONNO;
			reqParam.LANGKIND = 'KOR';
			var hdnInit = JSON.parse($("#hdnInitInfo").val());
			reqParam.CO_CD = hdnInit.CO_CD;
			/* 호출 */
			var resultInfo = {PRJNO : '', RESPERSONNO : '', ACNTNO :'', ACCBANK : '', ACCSOWNM:'', CERTDIV:'',ACCCLASS:'',ACCBANK_NM:''};
			resultInfo = fnGetAjaxEmpAcctInfo(reqParam);
			if(resultInfo == null){
				resultInfo = {PRJNO : '', RESPERSONNO : '', ACNTNO :'', ACCBANK : '', ACCSOWNM:'', CERTDIV:'',ACCCLASS:'',ACCBANK_NM:''};
			}
			$("#bank_"+arrElement[1]+"_13").val(resultInfo.ACCBANK_NM);
			$("#bankaccount_"+arrElement[1]+"_14").val(resultInfo.ACNTNO);
			$("#belong_"+key[1]+"_10").val(rowData.BELONG);
			$("#posi_"+key[1]+"_9").val(rowData.POSI);
			
			lvData.TRNSBANK = resultInfo.ACCTBANK_NM;
			lvData.EXECBANK  = resultInfo.ACCBANK;	
			//item.RESPERSONNO; 
			//item.NM; 
			break;
		case 'rate' :
			var arrElement = $("#"+bindId).attr('id').split('_');
			$("#"+bindId).val(rowData.PARTRATE);
			$("#recipdate_"+arrElement[1]+"_17").val(rowData.PARTYYMM);
			$("#paybaseamt_"+arrElement[1]+"_19").val(rowData.PAYBASEAMT);
			
			lvData.PAYYYMM = rowData.PAYYYMM;
			lvData.PARTRATE = rowData.PARTRATE;
			lvData.PAYBASEAMT = rowData.PAYBASEAMT;
			
			
			break;
		default :
			break;
	}
	
	if(key[0] != 'itemgbn' && key[0] !='inoutgbn' && key[0] != 'belonggbn' && key[0] != 'usemethod' && key[0] != 'peopleregno'){
		/* level1 데이터 업데이트 */
		fnSetLevel1Data(lvData, rowData);
		
		/* 화면분기 표현 */
		if(key[0] === 'bmcode' || key[0] === 'use'|| key[0] === 'execmtd' ){
			var lvData = fnInspectLevel1Data();
			var cheju = fnGetDisplayTblHeader(lvData.EXECMTD || '', lvData.BMCODE || '', lvData.EXECDIV || '');
			if(cheju != ''){
				/* 기존 존재하는 테이블 row 삭제 */
				fnDeleteChejuChanged();
			
				fnSetDisplayTblHeader(cheju);
				//체주타입 저장
				$.each(ezDataLevel1List, function(index,item){
					if(item.key == groupClass)
					{
						item.cheju = cheju;
						return false;
					}
				});
				
				var execdivGroup = [ 'AT101','AT107', 'PH101', 'PH103', 'PH104'];
				if(execdivGroup.indexOf(lvData.EXECDIV) == -1){
					//console.log('거래처');
					var codeParam = {};
					var level1data = {};
					codeParam.P_USE_YN = '1';
					codeParam.P_HELP_TY = 'STRADE_CODE';
					level1data.TR_FG = '1';
					
					$.each(ezparamList, function(index,item){
						if(item.key == groupClass)
						{
							fnSetCodeHelpParams(item,codeParam);
							return false;
						}
					});
					
					var lvData = fnInspectLevel1Data();
					fnSetLevel1Data(lvData, level1data);
					

				}
				else{
					var codeParam = {};
					var level1data = {};
					codeParam.P_USE_YN = '';
					codeParam.P_HELP_TY = 'SEMP_CODE';
					level1data.TR_FG = '2';
					
					$.each(ezparamList, function(index,item){
						if(item.key == groupClass)
						{
							fnSetCodeHelpParams(item,level1data);
							return false;
						}
					});
					var lvData = fnInspectLevel1Data();
					fnSetLevel1Data(lvData, level1data);

				}
			}
		}
	}
	else{
		/* level2 데이터 업데이트 */
		fnSetLevel2Data(lv2Data, rowData, key[1]);
	}
	
	
	/* 코드팝업 파라메터 업데이트 */
	var codeParams = fnInspectCodeHelpParams();
	fnSetCodeHelpParams(codeParams,rowData);
	$.each(ezparamList, function(index,item){
		if(item.key == groupClass)
		{
			item = codeParams;
			item.key = groupClass;
			return false;
		}
	});
	
	/*  특이 케이스 전자세금계산서 매핑, 품목상세 매핑(테이블 행 추가) */
	if(key[0] == 'taxapprno'){
		var params = {};
		params.CO_CD =rowData.CO_CD;
		params.ISS_NO =rowData.ISS_NO;
		params.TAX_TY =rowData.TAX_TY;
		fnLoadETAXList(params);
	}
	
}

/* 체주 유형 변경에 따른 관계테이블 ROW 삭제 */
function fnDeleteChejuChanged(){

	$.each($("#itemDetailContent_TRDATA_FIX").find('tr'), function(){
		if($(this).attr('class').indexOf(groupClass) != -1){
			$(this).remove();											
		}
	});
	
	$.each($("#itemDetailContent_TRDATA").find('tr'), function(){
		if($(this).attr('class').indexOf(groupClass) != -1){

			$(this).remove();							
		}
	});
	
	$.each($("#detailContent_TRDATA").find('tr'), function(){
		if($(this).attr('class').indexOf(groupClass) != -1){
			$(this).remove();
			return false;
		}
	});
	
	/* 저장 데이터 삭제 */
	
	//결의내역 수정
	var lv1DelIdx;
	$.each(ezDataLevel1List,function(index,item){
		if(item.key.indexOf(groupClass) == 0){
			//lv1DelIdx = index;
			var newNode = {};
			newNode.ABGT_CD = item.data.ABGT_CD;
			newNode.BIZGRP = item.data.BIZGRP;
			newNode.BMCODE = item.data.BMCODE;
			newNode.CO_CD = item.data.CO_CD;
			newNode.DIV_CD = item.data.DIV_CD;
			newNode.EXECDIV = item.data.EXECDIV;
			newNode.EXECMTD = item.data.EXECMTD;
			newNode.LANGKIND = item.data.LANGKIND;
			newNode.OFCODE = item.data.OFCODE;
			newNode.PJT_CD = item.data.PJT_CD;
			newNode.PRJNO = item.data.PRJNO;
			ezDataLevel1List[index].data = newNode;
			return false;
		}
	});
	
	//상세내역 인덱스 가져오기
	var lv2DelIdx;
	$.each(ezDataLevel1List,function(index,item){
		if(item.key.indexOf(groupClass) == 0){
			lv2DelIdx = index;
			return false;
		}
	});
	/* 전체 데이터 삭제 */
	ezDataLevel2List.splice(lv2DelIdx,1);
	
	//파라메터 삭제
	var ezParamIdx;
	$.each(ezparamList,function(index,item){
		if(item.key.indexOf(groupClass) == 0){
			var newNode = {};
			newNode= item;
			newNode.CODEDIV = '';
			newNode.P_CODE = '';
			newNode.P_CODE2 = '';
			newNode.P_CODE3 = '';
			newNode.P_NAME = '';
			newNode.P_STD_DT = '';
			newNode.P_WHERE = '';
			newNode.RESPERSONNO = '';
			ezparamList[index] = newNode;
			return false;
		}
	});
}


/* ===============================코드 바인드 모음=============================== */


/* ===============================코드도움 그리기 및 데이터 바인드 모음=============================== */
/* 연구과제 코드도움 */
function fnSetGridHeaderProect(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '전문기관코드',
		id : 'OFCODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '과제고유번호',
		id : 'PRJNO',
		width : '100px',
		tdClass : 'le'
	}, {
		no : '2',
		displayClass : '',
		titleName : '연구과제명',
		id : 'PRJNAME',
		width : '250px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : '',
		titleName : '프로젝트코드',
		id : 'PJT_CD',
		width : '100px',
		tdClass : 'cen'
	}, {
		no : '4',
		displayClass : '',
		titleName : '프로젝트명',
		id : 'PJT_NM',
		width : '250px',
		tdClass : 'cen'
	},{
		no : '5',
		displayClass : 'loseSight',
		titleName : 'BIZGRP',
		id : 'BIZGRP',
		width : '125px',
		tdClass : 'cen'
	},{
		no : '6',
		displayClass : 'loseSight',
		titleName : 'CO_CD',
		id : 'CO_CD',
		width : '125px',
		tdClass : 'cen'
	},
	
	];
}
/* 연구과제 코드도움 데이터 */
function fnMakeProjectCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.OFCODE = item.OFCODE; /* 전문기관코드 */
		codeRow.PRJNO = item.PRJNO; /* 연구과제코드 */
		codeRow.PRJNAME = item.PRJNAME; /* 연구과제 명*/
		codeRow.PJT_CD = item.PJT_CD; /* 프로젝트 코드*/
		codeRow.PJT_NM = item.PJT_NM;/* 프로젝트 명*/
		codeRow.BIZGRP = item.BIZGRP;/* BIZGRP */
		codeRow.CO_CD = item.CO_CD;/* CO_CD */
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 세목 코드도움 */
function fnSetGridHeaderBMcode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '세목코드',
		id : 'BMCODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '세목명',
		id : 'BMNAME',
		width : '200px',
		tdClass : 'le'
	}, {
		no : '2',
		displayClass : '',
		titleName : '세목그룹',
		id : 'BIZGRP',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : '',
		titleName : '비목코드',
		id : 'BM_CD',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '4',
		displayClass : '',
		titleName : '비목명',
		id : 'BM_NM',
		width : '200px',
		tdClass : 'cen'
	}];
}


/* 세목 코드도움 데이터 */
function fnMakeBMCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.BMCODE = item.BMCODE; /* 세목코드 */
		codeRow.BMNAME = item.BMNAME; /* 세목명 */
		codeRow.BIZGRP = item.BIZGRP; /* 세목그룹 */
		codeRow.BM_CD = item.BM_CD; /* 비목코드 */
		codeRow.BM_NM = item.BM_NM; /* 비목 명 */
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}


/* 사용용도 코드도움 */
function fnSetGridHeaderUseCode(){
	headjson = [ {
		no : '0',
		displayClass : 'loseSight',
		titleName : 'CDDIV',
		id : 'CDDIV',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '사용용도코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : 'loseSight',
		titleName : 'OFCODE',
		id : 'OFCODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : '',
		titleName : '사용용도명',
		id : 'CDNM',
		width : '150px',
		tdClass : 'le'
	}];
}

/* 사용용도 코드도움 데이터 */
function fnMakeUseCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CDDIV = item.CDDIV; 
		codeRow.CODE = item.CODE; 
		codeRow.OFCODE = item.OFCODE; 
		codeRow.CDNM = item.CDNM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}



/* 집행방법 코드도움 */
function fnSetGridHeaderExecMtdCode(){
	headjson = [ {
		no : '0',
		displayClass : 'loseSight',
		titleName : 'CDDIV',
		id : 'CDDIV',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '집행방법코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : 'loseSight',
		titleName : 'OFCODE',
		id : 'OFCODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : '',
		titleName : '집행방법명',
		id : 'CDNM',
		width : '150px',
		tdClass : 'le'
	}];
}

/* 집행방법 코드도움 데이터 */
function fnMakeExecMtdCodeJson(data){
	var codeGroup = [];
	var paramJson = {};
	paramJson =fnInspectCodeHelpParams();
	var exceptionList = ['CC','CD','PC'];
	
	if(paramJson.BMCODE == 'KR072010' || paramJson.BMCODE == 'KR072020' || paramJson.BMCODE == 'KR072030' || paramJson.BMCODE == 'KR072070'){
		$.each(data, function(index,item){
			if(exceptionList.indexOf(item.CODE) == -1){
				var codeRow = {};
				codeRow.CDDIV = item.CDDIV; 
				codeRow.CODE = item.CODE; 
				codeRow.OFCODE = item.OFCODE; 
				codeRow.CDNM = item.CDNM; 
				codeGroup.push(codeRow);
			}
		});
	}
	else{
		$.each(data, function(index,item){
			var codeRow = {};
			codeRow.CDDIV = item.CDDIV; 
			codeRow.CODE = item.CODE; 
			codeRow.OFCODE = item.OFCODE; 
			codeRow.CDNM = item.CDNM; 
			codeGroup.push(codeRow);
		});
	}
	dataJson = codeGroup;
}


/* 집행요청 코드도움 */
function fnSetGridHeaderExecReqDivCode(){
	headjson = [ {
		no : '0',
		displayClass : 'loseSight',
		titleName : 'CDDIV',
		id : 'CDDIV',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '집행요청구분코드',
		id : 'EXECREQDIV',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : 'loseSight',
		titleName : 'OFCODE',
		id : 'OFCODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : '',
		titleName : '집행요청구분명',
		id : 'EXECREQDIV_NM',
		width : '150px',
		tdClass : 'le'
	}];
}

/* 집행요청 코드도움 데이터 */
function fnMakeExecReqDivCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CDDIV = item.CDDIV; 
		codeRow.EXECREQDIV = item.CODE; 
		codeRow.OFCODE = item.OFCODE; 
		codeRow.EXECREQDIV_NM = item.CDNM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}


/* G20 입출금계좌 코드도움 */
function fnSetGridHeaderInOutAccountCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '거래처코드',
		id : 'TR_CD',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '거래처명',
		id : 'ATTR_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : '',
		titleName : '사업자번호',
		id : 'REG_NB',
		width : '150px',
		tdClass : 'le'
	}, {
		no : '3',
		displayClass : '',
		titleName : '계좌번호',
		id : 'BA_NB',
		width : '200px',
		tdClass : 'le'
	},{
		no : '4',
		displayClass : '',
		titleName : '대표자명',
		id : 'CEO_NM',
		width : '80px',
		tdClass : 'cen'
	},];
}

/* G20입출금계좌 코드도움 데이터 */
function fnMakeInOutAccountCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.TR_CD = item.TR_CD; 
		codeRow.ATTR_NM = item.ATTR_NM; 
		codeRow.REG_NB = item.REG_NB; 
		codeRow.BA_NB = item.BA_NB;
		codeRow.CEO_NM = item.CEO_NM;
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}



/* G20 거래처 코드도움 */
function fnSetGridHeaderPartnerCode(){
	var lvData = fnInspectLevel1Data();
	
	if(lvData.TR_FG == 1){
		headjson = [ {
			no : '0',
			displayClass : '',
			titleName : '거래처코드',
			id : 'TR_CD',
			width : '80px',
			tdClass : 'cen'
		}, {
			no : '1',
			displayClass : '',
			titleName : '거래처명',
			id : 'ATTR_NM',
			width : '200px',
			tdClass : 'cen'
		}, {
			no : '2',
			displayClass : '',
			titleName : '사업자번호',
			id : 'REG_NB',
			width : '150px',
			tdClass : 'le'
		}, {
			no : '3',
			displayClass : '',
			titleName : '계좌번호',
			id : 'BA_NB',
			width : '200px',
			tdClass : 'le'
		},{
			no : '4',
			displayClass : '',
			titleName : '대표자명',
			id : 'CEO_NM',
			width : '80px',
			tdClass : 'cen'
		},];
	}
	else{//////////////////////
		headjson = [ {
			no : '0',
			displayClass : '',
			titleName : '사원코드',
			id : 'EMP_CD',
			width : '80px',
			tdClass : 'cen'
		}, {
			no : '1',
			displayClass : '',
			titleName : '사원명',
			id : 'KOR_NM',
			width : '200px',
			tdClass : 'cen'
		}];
	}
}

/* 거래처 코드도움 데이터 */
function fnMakePartnerCodeJson(data){
	var lvData = fnInspectLevel1Data();
	var codeGroup = [];
	var codeParam = fnInspectCodeHelpParams();
	if(codeParam.partnergbn == '1'){
		$.each(data, function(index,item){
			var codeRow = {};
			codeRow.TR_CD = item.TR_CD; 
			codeRow.ATTR_NM = item.ATTR_NM; 
			codeRow.REG_NB = item.REG_NB; 
			codeRow.BA_NB = item.BA_NB;
			codeRow.CEO_NM = item.CEO_NM;
			codeGroup.push(codeRow);
		});
	}
	else if(codeParam.partnergbn == '2' || codeParam.partnergbn == '8' ){
		$.each(data, function(index,item){
			var codeRow = {};
			codeRow.EMP_CD = item.EMP_CD; 
			codeRow.KOR_NM = item.KOR_NM;
			codeGroup.push(codeRow);
		});
	}
	else if(codeParam.partnergbn == '4'){
		$.each(data, function(index,item){
			var codeRow = {};
			codeRow.PER_CD = item.PER_CD; 
			codeRow.PER_NM = item.PER_NM;
			var myRegNo = item.REG_NO.slice(0,6);
			myRegNo = myRegNo + '-*******';
			codeRow.REG_NO =  myRegNo;
			codeRow.DATA_CD = item.DATA_CD;
			codeRow.CO_CD = item.CO_CD;
			codeRow.CORP_CD = item.CORP_CD;
			codeRow.BANK_CD = item.BANK_CD;
			codeRow.ACCT_NO = item.ACCT_NO;
			codeRow.ACCT_NM = item.ACCT_NM;
			codeRow.BANK_NM = item.BANK_NM;
			codeRow.BANK_NMK = item.BANK_NMK;
			codeGroup.push(codeRow);
		});
	}

	dataJson = codeGroup;
}


/* 연구원 코드도움 */
function fnSetGridHeaderResearcherCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '연구자등록',
		id : 'RESPERSONNO',
		width : '80px',
		tdClass : 'cen'
	},{
		no : '1',
		displayClass : '',
		titleName : '연구자명',
		id : 'NM',
		width : '200px',
		tdClass : 'cen'
	},{
		no : '2',
		displayClass : 'loseSight',
		titleName : 'BELONG',
		id : 'BELONG',
		width : '200px',
		tdClass : 'cen'
	},{
		no : '3',
		displayClass : 'loseSight',
		titleName : 'POSI',
		id : 'POSI',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 연구원 코드도움 데이터 */
function fnMakeResearcherCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.RESPERSONNO = item.RESPERSONNO; 
		codeRow.BELONG = item.BELONG; 
		codeRow.POSI = item.POSI; 
		codeRow.NM = item.NM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}


/* 지급은행 코드도움 */
function fnSetGridHeaderBankCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '은행코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '은행코드명',
		id : 'CDNM',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 지급은행 코드도움 데이터 */
function fnMakeBankCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CODE = item.CODE; 
		codeRow.CDNM = item.CDNM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 물품구분 코드도움 */
function fnSetGridHeaderItemGbnCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '물품구분코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '물품구분명',
		id : 'CDNM',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 물품구분 코드도움 데이터 */
function fnMakeItemGbnCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CODE = item.CODE; 
		codeRow.CDNM = item.CDNM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 소속구분 코드도움 */
function fnSetGridHeaderBelongGbnCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '소속구분코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '소속구분명',
		id : 'CDNM',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 소속구분 코드도움 데이터 */
function fnMakeBelongGbnCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CODE = item.CODE; 
		codeRow.CDNM = item.CDNM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 시내외구분 코드도움 */
function fnSetGridHeaderInoutGbnCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '시내외구분코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '시내외구분명',
		id : 'CDNM',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 시내외구분 코드도움 데이터 */
function fnMakeInoutGbnCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CODE = item.CODE; 
		codeRow.CDNM = item.CDNM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 활용방법 코드도움 */
function fnSetGridHeaderUsemethodCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '활용방법코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '활용방법명',
		id : 'CDNM',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 카드번호 코드도움 데이터 */
function fnMakeCardNumCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CODE = item.CODE; 
		codeRow.CDNM = item.CDNM; 
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 카드번호 코드도움 */
function fnSetGridHeaderCardNumCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '카드번호',
		id : 'CARDNO',
		width : '150px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '카드종류',
		id : 'CARDGB_NM',
		width : '150px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : '',
		titleName : '거래일',
		id : 'TRDATE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : '',
		titleName : '가맹점',
		id : 'MCHT_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '4',
		displayClass : '',
		titleName : '승인번호',
		id : 'APPRNO',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '5',
		displayClass : '',
		titleName : '매입금액',
		id : 'DEMCOST',
		width : '150px',
		tdClass : 'cen'
	}, {
		no : '6',
		displayClass : '',
		titleName : '부가세',
		id : 'EXTTAX',
		width : '150px',
		tdClass : 'cen'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'OFCODE',
		id : 'OFCODE',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'PRJNO',
		id : 'PRJNO',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'FRCVDATE',
		id : 'FRCVDATE',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'RCVDATE',
		id : 'RCVDATE',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'RCVTIME',
		id : 'RCVTIME',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'CARDGB',
		id : 'CARDGB',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'TRSEQ',
		id : 'TRSEQ',
		width : '200px',
		tdClass : 'ri'
	}];
}

/* 활용방법 코드도움 데이터 */
function fnMakeCardNumCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CARDNO = item.CARDNO; 
		codeRow.CARDGB_NM = item.CARDGB_NM;
		codeRow.TRDATE = item.TRDATE;
		codeRow.MCHT_NM  = item.MCHT_NM;
		codeRow.APPRNO = item.APPRNO;
		codeRow.DEMCOST	  = item.DEMCOST;
		codeRow.EXTTAX	 = item.EXTTAX;
		codeRow.OFCODE = item.OFCODE;
		codeRow.PRJNO = item.PRJNO;
		codeRow.FRCVDATE = item.FRCVDATE;
		codeRow.RCVDATE = item.RCVDATE;
		codeRow.CARDGB	 = item.CARDGB;
		codeRow.TRSEQ	 = item.CODE;
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 전자세금계산서 */
function fnSetGridHeaderETaxCode(data){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '분류',
		id : 'ETAX_TY_NM',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '작성일자',
		id : 'ISS_DT',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : '',
		titleName : '발급일자',
		id : 'ISS_YMD',
		width : '200px',
		tdClass : 'cen'
	},{
		no : '3',
		displayClass : '',
		titleName : '거래처명',
		id : 'TR_NM',
		width : '200px',
		tdClass : 'cen'
	},{
		no : '4',
		displayClass : '',
		titleName : '거래처사업자번호',
		id : 'TRREG_NB',
		width : '200px',
		tdClass : 'cen'
	},{
		no : '5',
		displayClass : '',
		titleName : '공급가액',
		id : 'SUP_AM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '6',
		displayClass : '',
		titleName : '부가세',
		id : 'VAT_AM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '7',
		displayClass : '',
		titleName : '합계액',
		id : 'SUM_AM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '8',
		displayClass : '',
		titleName : '전자세금계산서승인번호',
		id : 'ISS_NO',
		width : '200px',
		tdClass : 'cen'
	},{
		no : '9',
		displayClass : '',
		titleName : '기사용금액',
		id : 'RESOLAMT',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '10',
		displayClass : '',
		titleName : '등록가능금액',
		id : 'AM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '11',
		displayClass : 'loseSight',
		titleName : 'CO_CD',
		id : 'CO_CD',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '12',
		displayClass : 'loseSight',
		titleName : 'DIV_CD',
		id : 'DIV_CD',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '13',
		displayClass : 'loseSight',
		titleName : 'TR_CD',
		id : 'TR_CD',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '14',
		displayClass : 'loseSight',
		titleName : 'TAX_TY',
		id : 'TAX_TY',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '15',
		displayClass : 'loseSight',
		titleName : 'DIVREG_NB',
		id : 'DIVREG_NB',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '16',
		displayClass : 'loseSight',
		titleName : 'DIVSUB_NB',
		id : 'DIVSUB_NB',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '17',
		displayClass : 'loseSight',
		titleName : 'DIV_NM',
		id : 'DIV_NM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '18',
		displayClass : 'loseSight',
		titleName : 'DIVCEO_NM',
		id : 'DIVCEO_NM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '19',
		displayClass : 'loseSight',
		titleName : 'TRSUB_NB',
		id : 'TRSUB_NB',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '20',
		displayClass : 'loseSight',
		titleName : 'TR_NM',
		id : 'TR_NM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '21',
		displayClass : 'loseSight',
		titleName : 'TRCEO_NM',
		id : 'TRCEO_NM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '22',
		displayClass : 'loseSight',
		titleName : 'ETAX_TY',
		id : 'ETAX_TY',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '23',
		displayClass : 'loseSight',
		titleName : 'ETAX_FG',
		id : 'ETAX_FG',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '24',
		displayClass : 'loseSight',
		titleName : 'SEND_FG',
		id : 'SEND_FG',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '25',
		displayClass : 'loseSight',
		titleName : 'INSERT_ID',
		id : 'INSERT_ID',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '26',
		displayClass : 'loseSight',
		titleName : 'INSERT_DT',
		id : 'INSERT_DT',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '27',
		displayClass : 'loseSight',
		titleName : 'INSERT_IP',
		id : 'INSERT_IP',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '28',
		displayClass : 'loseSight',
		titleName : 'ITEM_DC',
		id : 'ITEM_DC',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '29',
		displayClass : 'loseSight',
		titleName : 'ADDTAX_CD',
		id : 'ADDTAX_CD',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '29',
		displayClass : 'loseSight',
		titleName : 'ADDTAX_AM',
		id : 'ADDTAX_AM',
		width : '200px',
		tdClass : 'ri'
	},{
		no : '30',
		displayClass : 'loseSight',
		titleName : 'ADDRTE_RT',
		id : 'ADDRTE_RT',
		width : '200px',
		tdClass : 'ri'
	}];
}
/* 전자세금계산서 코드도움 데이터 */
function fnMakeETaxCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.ETAX_TY_NM = item.ETAX_TY_NM; 
		codeRow.ISS_DT = item.ISS_DT;
		codeRow.ISS_YMD = item.ISS_YMD;
		codeRow.TR_NM = item.TR_NM;
		codeRow.TRREG_NB = item.TRREG_NB;
		codeRow.SUP_AM = item.SUP_AM;
		codeRow.VAT_AM = item.VAT_AM;
		codeRow.SUM_AM = item.SUM_AM;
		codeRow.ISS_NO = item.ISS_NO;
		codeRow.RESOLAMT = item.RESOLAMT;
		codeRow.AM = item.AM;
		codeRow.CO_CD = item.CO_CD;
		codeRow.DIV_CD = item.DIV_CD;
		codeRow.TR_CD = item.TR_CD;
		codeRow.TAX_TY = item.TAX_TY;
		codeRow.DIVREG_NB = item.DIVREG_NB;
		codeRow.DIVSUB_NB = item.DIVSUB_NB;
		codeRow.DIV_NM = item.DIV_NM;
		codeRow.DIVCEO_NM = item.DIVCEO_NM;
		codeRow.TRSUB_NB = item.TRSUB_NB;
		codeRow.TR_NM = item.TR_NM;
		codeRow.TRCEO_NM = item.TRCEO_NM;
		codeRow.ETAX_TY = item.ETAX_TY;
		codeRow.ETAX_FG = item.ETAX_FG;
		codeRow.SEND_FG = item.SEND_FG;
		codeRow.INSERT_ID = item.INSERT_ID;
		codeRow.INSERT_DT = item.INSERT_DT;
		codeRow.INSERT_IP = item.INSERT_IP;
		codeRow.ITEM_DC = item.ITEM_DC;
		codeRow.ADDTAX_CD = item.ADDTAX_CD;
		codeRow.ADDTAX_AM = item.ADDTAX_AM;
		codeRow.ADDRTE_RT = item.ADDRTE_RT;
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 거래처구분 코드도움 */
function fnSetGridHeaderPartnerGbnCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '거래처구분 코드',
		id : 'CODE',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '거래처구분 명',
		id : 'CDNM',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 거래처구분 코드도움 데이터 */
function fnMakePartnerGbnCodeJson(){
		var codeGroup = [];
		var codeRow1= {};
		codeRow1.CODE = '1'; 
		codeRow1.CDNM = '거래처등록' 
		codeGroup.push(codeRow1);
		
		var codeRow2= {};
		codeRow2.CODE = '2'; 
		codeRow2.CDNM = '사원등록'
		codeGroup.push(codeRow2);
		
		var codeRow3= {};
		codeRow3.CODE = '4'; 
		codeRow3.CDNM = '기타소득'
		codeGroup.push(codeRow3);
		
		var codeRow4= {};
		codeRow4.CODE = '8'; 
		codeRow4.CDNM = '급여소득'
		codeGroup.push(codeRow4);
		
		dataJson = codeGroup;
}


/* 참여율 코드도움 */
function fnSetGridHeaderRateCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '구분년월',
		id : 'PARTYYMM',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '참여율',
		id : 'PARTRATE',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : '',
		titleName : '기준금액',
		id : 'PAYBASEAMT',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : '',
		titleName : '지급가능금액',
		id : 'CALC_AM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '4',
		displayClass : '',
		titleName : '지급기준',
		id : 'PAYDIV_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '5',
		displayClass : 'loseSight',
		titleName : 'OFCODE',
		id : 'OFCODE',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '6',
		displayClass : 'loseSight',
		titleName : 'PRJNO',
		id : 'PRJNO',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '7',
		displayClass : 'loseSight',
		titleName : 'RESPERSONNO',
		id : 'RESPERSONNO',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '8',
		displayClass : 'loseSight',
		titleName : 'CO_CD',
		id : 'CO_CD',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '9',
		displayClass : 'loseSight',
		titleName : 'PAYDIV',
		id : 'PAYDIV',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '10',
		displayClass : 'loseSight',
		titleName : 'SENDYN',
		id : 'SENDYN',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '11',
		displayClass : 'loseSight',
		titleName : 'SENDYN_NM',
		id : 'SENDYN_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '12',
		displayClass : 'loseSight',
		titleName : 'SENDOPT',
		id : 'SENDOPT',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '13',
		displayClass : 'loseSight',
		titleName : 'DELETE_NM',
		id : 'DELETE_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '14',
		displayClass : 'loseSight',
		titleName : 'STATE_NM',
		id : 'STATE_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '15',
		displayClass : 'loseSight',
		titleName : 'SENDOPT_NM',
		id : 'SENDOPT_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '16',
		displayClass : 'loseSight',
		titleName : 'SEND_DT',
		id : 'SEND_DT',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '17',
		displayClass : 'loseSight',
		titleName : 'STATECODE',
		id : 'STATECODE',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '18',
		displayClass : 'loseSight',
		titleName : 'STATETEXT',
		id : 'STATETEXT',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '19',
		displayClass : 'loseSight',
		titleName : 'RCV_DT',
		id : 'RCV_DT',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* 참여율 코드도움 데이터 */
function fnMakeRateCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.OFCODE = item.OFCODE; 
		codeRow.PRJNO = item.PRJNO;
		codeRow.RESPERSONNO = item.RESPERSONNO;
		codeRow.PARTYYMM = item.PARTYYMM;
		codeRow.CO_CD = item.CO_CD;
		codeRow.PARTRATE = item.PARTRATE;
		codeRow.PAYBASEAMT = item.PAYBASEAMT;
		codeRow.CALC_AM = item.CALC_AM;
		codeRow.PAYDIV = item.PAYDIV;
		codeRow.PAYDIV_NM = item.PAYDIV_NM;
		codeRow.SENDYN = item.SENDYN;
		codeRow.SENDYN_NM = item.SENDYN_NM;
		codeRow.SENDOPT = item.SENDOPT;
		codeRow.DELETE_NM = item.DELETE_NM;
		codeRow.STATE_NM = item.STATE_NM;
		codeRow.SENDOPT_NM = item.SENDOPT_NM;
		codeRow.SEND_DT = item.SEND_DT;
		codeRow.STATECODE = item.STATECODE;
		codeRow.STATETEXT = item.STATETEXT;
		codeRow.RCV_DT = item.RCV_DT;
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}

/* 기타소득 거래처 코드도움 */
function fnSetGridHeaderEtcIncomeCode(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '코드',
		id : 'PER_CD',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '소득자 명',
		id : 'PER_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : '',
		titleName : '주민등록번호',
		id : 'REG_NO',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : 'loseSight',
		titleName : 'DATA_cD',
		id : 'DATA_CD',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '4',
		displayClass : 'loseSight',
		titleName : 'CO_CD',
		id : 'CO_CD',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '5',
		displayClass : 'loseSight',
		titleName : 'CORP_CD',
		id : 'CORP_CD',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '6',
		displayClass : 'loseSight',
		titleName : 'BANK_CD',
		id : 'BANK_CD',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '7',
		displayClass : 'loseSight',
		titleName : 'ACCT_NO',
		id : 'ACCT_NO',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '8',
		displayClass : 'loseSight',
		titleName : 'ACCT_NM',
		id : 'ACCT_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '9',
		displayClass : 'loseSight',
		titleName : 'BANK_NM',
		id : 'BANK_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '10',
		displayClass : 'loseSight',
		titleName : 'BANK_NMK',
		id : 'BANK_NMK',
		width : '200px',
		tdClass : 'cen'
	}];
}



/* 원천징수액 소득구분 코드도움 데이터 */
function fnMakeIncomeGbnCodeJson(data){
	var codeGroup = [];
	$.each(data, function(index,item){
		var codeRow = {};
		codeRow.CTD_CD = item.CTD_CD;
		codeRow.CTD_NM = item.CTD_NM;
		codeRow.CTD_CD2 = item.CTD_CD2;
		codeRow.DATA_CD = item.DATA_CD;
		codeRow.RMK_DC = item.RMK_DC;
		codeRow.DUMMY1 = item.DUMMY1;		
		codeGroup.push(codeRow);
	});
	dataJson = codeGroup;
}


/* 원천징수액 소득구분 코드도움 */
function fnSetGridHeaderIncomeGbn(){
	headjson = [ {
		no : '0',
		displayClass : '',
		titleName : '코드',
		id : 'CTD_CD',
		width : '80px',
		tdClass : 'cen'
	}, {
		no : '1',
		displayClass : '',
		titleName : '관리내역명',
		id : 'CTD_NM',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '2',
		displayClass : 'loseSight',
		titleName : 'CTD_CD2',
		id : 'CTD_CD2',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '3',
		displayClass : 'loseSight',
		titleName : 'DATA_CD',
		id : 'DATA_CD',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '4',
		displayClass : 'loseSight',
		titleName : 'RMK_DC',
		id : 'RMK_DC',
		width : '200px',
		tdClass : 'cen'
	}, {
		no : '5',
		displayClass : 'loseSight',
		titleName : 'DUMMY1',
		id : 'DUMMY1',
		width : '200px',
		tdClass : 'cen'
	}];
}

/* ===============================코드도움 그리기 및 데이터 바인드 모음=============================== */