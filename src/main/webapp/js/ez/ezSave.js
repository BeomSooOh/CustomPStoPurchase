//그룹웨어 데이터 리스트
var gwVarList = [];
//이알피 데이터 리스트
var erpSendDataList = [];
/* 이지바로 전송전 GW변수 만들기(리스트 필요) */
function fnMakeGwVariable() {
	
	//그룹 클래스 및 변수 찾기
	var resolData = {
		'project' : '',
		'bmcode' : '',
		'use' : '',
		'G20Prject' : '',
		'G20abgt' : '',
		'execmtd' : '',
		'execreqdiv' : '',
		'inoutaccount' : ''
	};
	
	var detailData = {
		'resoldate' : '',
		'partnergbn' : '',
		'partner' : '',
		'cardnum' : '',
		'aprovNum' : '',
		'serialNum' : '',
		'trdate' : '',
		'posi' : '',
		'belong' : '',
		'nm' : '',
		'entrant' : '',
		'bank' : '',
		'bankaccount' : '',
		'accholder' : '',
		'recip' : '',
		'paybaseamt' : '',
		'taxapprno' : '',
		'supperson' : '',
		'supbizno' : '',
		'meetstd' : '',
		'metetd' : '',
		'meetplace' : '',
		'bigo' : '',
		'consiorg' : '',
		'bizno' : '',
		'resolamt' : '',
		'taxamt' : '',
		'supplyamt' : ''
	};
	
	var itemDetailData = {
		'rownum':'',
		'item' : '',
		'standard' : '',
		'amount' : '',
		'unitprice' : '',
		'itemsupplyamt' : '',
		'itemtaxamt' : '',
		'itemtotalamt' : '',
		'itemgbn' : '',
		'ntisregdt' : '',
		'ntisregno' : '',
		'specialist' : '',
		'itementrant' : '',
		'purposebiztrip' : '',
		'biztripstdt':'',
		'biztripendt':'',
		'biztripsttime':'',
		'biztripentime':'',
		'stplace':'',
		'enplace':'',
		'inoutgbn':'',
		'belonggbn':'',
		'peopleregno':'',
		'overtimeworker' : '',
		'overworkstdt' : '',
		'overworkendt' : '',
		'overworksttime' : '',
		'overworkentime' : '',
		'belongbizno' : '',
		'entnm' : '',
		'educator' : '',
		'eduorgnm' : '',
		'edustdt' : '',
		'eduendt' : '',
		'edusttime' : '',
		'eduentime' : '',
		'useplace' : '',
		'usestdt' : '',
		'useendt' : '',
		'usesttime' : '',
		'useentime' : '',
		'usemethod' : '',
		'amt' : ''
	}
	//GW 저장변수 생성(품목상세 제외)
	$.each(ezDataLevel1List, function(index, item) {
		var newNode = {};
		newNode.groupName = item.key;
		newNode.chejuType = item.cheju;

		$.each(ezparamList, function(ezindex, ezitem) {
			if (ezitem.key == item.key) {
				newNode.codeParam = ezitem;
				return false;
			}
		});

		newNode.resolData = JSON.parse(JSON.stringify(resolData));
		newNode.detailData = JSON.parse(JSON.stringify(detailData));
		newNode.itemDetailDataList = [];
		var itemDetailRowCount = $("#itemDetailContent_TRDATA").find("." + item.key).length;
		for (var i = 0; i < itemDetailRowCount; i++) {
			var newItem = JSON.stringify(itemDetailData);
			newNode.itemDetailDataList.push(JSON.parse(newItem));
		}
		gwVarList.push(newNode);
	});
	
	
	$.each(gwVarList, function(index, item) {
		var key = item.groupName;
		
		//결의내역 저장
		var resInputEle = $("#resolveContent_TRDATA").find('.'+key).find('input');
		$.each(resInputEle, function(eleIdex,eleItem){
			if($(eleItem).val() != ''){
				var eleId = $(eleItem).attr('id');
				var arrId = eleId.split('_');
				item.resolData[arrId[0]]= $(eleItem).val();
			}
		});
		
		//상세내역 저장
		var detInputEle = $("#detailContent_TRDATA").find('.'+key).find('input');
		$.each(detInputEle, function(eleIdex,eleItem){
			if($(eleItem).val() != ''){
				var eleId = $(eleItem).attr('id');
				var arrId = eleId.split('_');
				item.detailData[arrId[0]]= $(eleItem).val();
			}
		});
		
		//품목상세 저장
		var iteTrEle =$("#itemDetailContent_TRDATA").find('.'+key);
		$.each(iteTrEle, function(trIdex,trItem){
			var iteInputEle = $(trItem).find('input');
			$.each(iteInputEle,function(eleIdex,eleItem){
				if($(eleItem).val() != ''){
					var eleId = $(eleItem).attr('id');
					var arrId = eleId.split('_');	
					var setValue = $(eleItem).val();
					item.itemDetailDataList[trIdex]["rownum"]= arrId[1];
					item.itemDetailDataList[trIdex][arrId[0]]= setValue;
				}
			});
		});
	});
	
	
	fnMakeERPVariable(gwVarList);
}

/* 이지바로 erp전송 변수 만들기(리스트 필요) */
function fnMakeERPVariable(gwList) {
	//1. 체주존재를 확인하여 저장한다.
	//2. 체주에 대한 erp코드팝업 변수를 확인한다.
	//3. 있으면 불러오고 없으면 생성한다.
	//4. input 값에 대한 데이터를 넣어준다.
	//5. 끝..
	
	var groupList = [];
	
	/* 아이템 그룹리스트 */
	$.each(gwList,function(index,item){
		groupList.push(item.groupName);
	});
	
	//체주유형 가져오기
	for(var i = 0; i <groupList.length; i++){
		var groupKey = gwList[i].groupName;
		var newDataRow = {};
		
		var resolData = {};
		var itemListData = [];
		
		$.each(ezDataLevel1List,function(index,item){
			if(item.key == groupKey){
				resolData = item.data;
				resolData.key = item.key;
				resolData.cheju = item.cheju;
				return false;
			}
		});
		
		var arrCheju = groupKey.split('_');
		var rownum = arrCheju[1];
		
		var writerInfo = JSON.parse($("#hdnInitInfo").val());
		/*결의내역, 상세내역 */
		
		resolData.TASK_DT = $("#txtWriteDate").val().replace('-','').replace('-','');
		//결의일자
		resolData.RESOLDATE = $("#resoldate_"+rownum+"_0").val().replace(/\//gi,"");
		//결의자
		resolData.EMP_CD = writerInfo.EMP_CD;
	    //결의부서
		resolData.DEPT_CD = writerInfo.DEPT_CD;
		//카드번호
		resolData.CARDNO =  $('#cardnum_'+ rownum +'_4').val();
		//승인번호
		resolData.APPRNO =  $('#aprovNum_'+ rownum +'_5').val();
	    //거래일
		resolData.TRDATE = $('#trdate_'+ rownum +'_7').val().replace(/\//gi,"");
	    //청구일련번호
		resolData.TRSEQ = $('#serialNum_'+ rownum +'_6').val().replace(/\-/gi,"");
		//지급계좌번호
		resolData.EXECREQACCNO = $('#bankaccount_'+ rownum +'_14').val();
		//지급예금주
		resolData.ACCOWNER = $('#accholder'+ rownum +'_15').val();
		//지급처
		resolData.EXECRECIP = $('#recip_'+ rownum +'_18').val();
		//직급
		resolData.POSI = $("#posi_"+ rownum +'_9').val();
		//회의 시작일시
		resolData.MEETSDT = $("#meetstd_"+ rownum +'_23').val();
		//회의 종료일시
		resolData.MEETEDT = $("#meetetd_"+ rownum +'_24').val();
		//회의장소
		resolData.MEETPLACE = $("#meetplace_"+ rownum +'_25').val();
		//G20비고
		resolData.RMK_DC = $("#bigo_"+ rownum +'_26').val();
		//소속
		resolData.BELONG = $('#belong_'+ rownum +'_10').val();
		//지급기준액 확인- 개발자 확인 필요
		resolData.PAYBASEAMT = $('#paybaseamt_'+ rownum +'_19').val().replace(/,/gi,"");
		//세금계산서 승인번호
		resolData.TAXAPPRNO =  $('#taxapprno_'+ rownum +'_20').val();
		//세금계산서 공급자명
		resolData.SUPPERSON =  $('#supperson_'+ rownum +'_21').val();
		//세금계산서 사업자등록번호
		resolData.SUPBIZNO =  $('#supbizno_'+ rownum +'_22').val();
		//위탁기관
		resolData.CONSIORG =  $('#consiorg_'+ rownum +'_27').val();
		//위탁기관 사업자등록번호
		resolData.BIZNO =  $('#bizno_'+ rownum +'_28').val();
		//공급가액
		resolData.SUPPLYAMT = $("#supplyamt_"+ rownum +'_31').val().replace(/,/gi,"");
		//세액
		resolData.EXTTAX = $("#taxamt_"+ rownum +'_30').val().replace(/,/gi,"");
		//결의금액
		resolData.RESOLAMT = $("#resolamt_"+ rownum +'_29').val().replace(/,/gi,"");

		//결의내용♥
		
		//resolData.CONT = $("#resolNote ."+ groupKey).val();
		var cont = '';
		var hdnResolData = $("#hdnResolNoteInfo").val();
		if(hdnResolData.length > 0){
			var dataList = JSON.parse(hdnResolData);
			$.each(dataList, function(index,item){
				if(item.key == groupKey ){
					cont =item.value;
					return false;
				}
			});
		}
		
		resolData.CONT = cont;
		
		$.each(gwList[i].itemDetailDataList,function(ix,data){
			var newNode = JSON.stringify(ANZR100DETAIL);
			newNode = JSON.parse(newNode);
			newNode.rownum = data.rownum;
			//기본사항 값 가져오기
			newNode.key = groupKey;
			newNode.cheju = resolData.cheju;
			newNode.CO_CD = resolData.CO_CD;
			newNode.TASK_DT = resolData.TASK_DT;
			newNode.OFCODE = resolData.OFCODE;
			newNode.TASK_SQ = resolData.TASK_SQ;
			//품명
			newNode.ITEMNAME = data.item || '';
			//규격
			newNode.STANDARD = data.standard;
			//단가
			newNode.UNITCOST = data.unitprice.replace(/,/gi,"");
			//공급가액
			newNode.SUPCOST = data.itemsupplyamt.replace(/,/gi,"");
			//세액
			newNode.EXTTAX = data.itemtaxamt.replace(/,/gi,"");
			//총구입액
			newNode.TOTPURCHAMT = data.itemtotalamt.replace(/,/gi,"") || '';
			//물품구분 팝업
			//NTIS 등록일자
			newNode.NTISREGDATE = data.ntisregdt;
			//NTIS 등록번호
			newNode.NTISREGNO = data.ntisregno;
			//전문가
			newNode.SPECIALIST = data.specialist;
			//출장자
			newNode.NM = data.itementrant|| '';
			//출장목적
			newNode.EDUORGNM = data.purposebiztrip;
			//출장시작일
			newNode.TERMF = data.biztripstdt.replace(/\//gi,"");
			//출장종료일
			newNode.TERMT = data.biztripendt.replace(/\//gi,"");
			//출장시작시간
			newNode.ST = data.biztripsttime;
			//출장종료시간
			newNode.ET = data.biztripentime;
			//출발지
			newNode.STARTPLACE = data.stplace;
			//도착지
			newNode.DEST = data.enplace;
			//시내외구분 팝업
			//소속구분 팝업
			//연구자등록번호 팝업
			newNode.NM = data.overtimeworker;
			//특근시작일
			newNode.TERMF = data.overworkstdt.replace(/\//gi,"");;
			//특근종료일
			newNode.TERMT = data.overworkendt.replace(/\//gi,"");;
			//특근시작시간
			newNode.ST = data.overworksttime;
			//특근종료시간
			newNode.ET = data.overworkentime;
			//소속사업자번호
			newNode.BELONG = data.belongbizno;
			//참석자성명
			newNode.NM = data.entnm;
			//교육자
			newNode.NM = data.educator;
			//교육기관명
			newNode.EDUORGNM = data.eduorgnm;
			//교육시작일
			newNode.TERMF = data.edustdt.replace(/\//gi,"");;
			//교육종료일
			newNode.TERMT = data.eduendt.replace(/\//gi,"");;
			//교육시작시간
			newNode.ST = data.eduendt;
			//교육종료시간
			newNode.ET = data.eduendt;
			//활용장소
			newNode.USESITE = data.useplace;
			//활용시작일
			newNode.TERMF = data.usestdt.replace(/\//gi,"");;
			//활용종료일
			newNode.TERMT = data.useendt.replace(/\//gi,"");;
			//활용시작시간
			newNode.ST = data.usesttime;
			//활용종료시간
			newNode.ET = data.useentime;
			//활용방법
			newNode.USEMETHOD = data.usemethod;
			//금액
			newNode.PAYAMT = data.amt.replace(/,/gi,"");;
			
			itemListData.push(newNode);
		});
		
		var sameItemList = [];
		var lv2_group_key = '';
		$.each(ezDataLevel2List	,function(index,item){
			if(item.key == groupKey){
				sameItemList = item.data;
				return false;
			}
		});

		$.each(sameItemList,function(index,item){
			$.each(itemListData,function(idx,itm){
				if(item.rownum == itm.rownum){
					itm = JSON.stringify(fnMatchlv2Variable(itm,item.data));
					itm = JSON.parse(itm);
					itm.key = groupKey;
					itemListData[idx] = itm;
					return false;
				}
			});
		});

		newDataRow.resolData = resolData;
		newDataRow.itemListData = itemListData;
		erpSendDataList.push(newDataRow);
	}
	console.log('최종');
	console.log(erpSendDataList);
}


function fnMatchlv2Variable(ezData, newData){
	ezData.LANGKIND = newData.LANGKIND || ezData.LANGKIND;
	ezData.CO_CD = newData.CO_CD || ezData.CO_CD;
	ezData.TASK_DT = newData.TASK_DT || ezData.TASK_DT;
	ezData.TASK_SQ = newData.TASK_SQ || ezData.TASK_SQ;
	ezData.OFCODE = newData.OFCODE || ezData.OFCODE;
	ezData.PRJNO = newData.PRJNO || ezData.PRJNO;
	ezData.REGSEQ = newData.REGSEQ || ezData.REGSEQ;
	ezData.BELONG = newData.BELONG || ezData.BELONG;
	ezData.BELONGDIV = newData.BELONGDIV || ezData.BELONGDIV;
	ezData.AREADIV = newData.AREADIV || ezData.AREADIV;
	ezData.ARTIDIV = newData.ARTIDIV || ezData.ARTIDIV;
	ezData.ITEMNAME = newData.ITEMNAME || ezData.ITEMNAME;
	ezData.STANDARD = newData.STANDARD || ezData.STANDARD;
	ezData.AMOUNT = newData.AMOUNT || ezData.AMOUNT;
	ezData.UNITCOST = newData.UNITCOST || ezData.UNITCOST;
	ezData.SUPCOST = newData.SUPCOST || ezData.SUPCOST;
	ezData.EXTTAX = newData.EXTTAX || ezData.EXTTAX;
	ezData.TOTPURCHAMT = newData.TOTPURCHAMT || ezData.TOTPURCHAMT;
	ezData.NTISREGNO = newData.NTISREGNO || ezData.NTISREGNO;
	ezData.NTISREGDATE = newData.NTISREGDATE || ezData.NTISREGDATE;
	ezData.CHECKDATE = newData.CHECKDATE || ezData.CHECKDATE;
	ezData.CHECKUSER = newData.CHECKUSER || ezData.CHECKUSER;
	ezData.PROFUSEDIV = newData.PROFUSEDIV || ezData.PROFUSEDIV;
	ezData.RESPERSONNO = newData.RESPERSONNO || ezData.RESPERSONNO;
	ezData.NM = newData.NM || ezData.NM;
	ezData.TERMF = newData.TERMF || ezData.TERMF;
	ezData.TERMT = newData.TERMT || ezData.TERMT;
	ezData.ST = newData.ST || ezData.ST;
	ezData.ET = newData.ET || ezData.ET;
	ezData.STARTPLACE = newData.STARTPLACE || ezData.STARTPLACE;
	ezData.DEST = newData.DEST || ezData.DEST;
	ezData.EDUORGNM = newData.EDUORGNM || ezData.EDUORGNM;
	ezData.PAYAMT = newData.PAYAMT || ezData.PAYAMT;
	ezData.GISU_DT = newData.GISU_DT || ezData.GISU_DT;
	ezData.GISU_SQ = newData.GISU_SQ || ezData.GISU_SQ;
	return ezData;
}

/* 상신버튼 클릭시 수행하는 함수 */
function fnMainEzbaroSaveProcess(){
	/*사전 준비 작업*/
	$.each(erpSendDataList, function(index,item){
		//1. 이지바로 결의내역 저장
		var task_sq = 0;
		task_sq = fnSendResolveDataToErp(item.resolData);
		erpSendDataList[index].resolData["TASK_SQ"] = task_sq;
		//2. 이지바로 결의내역 리턴 - task_sq를 하위 품목상세에 저장
		$.each(item.itemListData, function(slaveIndex,salveItem){
			item.itemListData[slaveIndex]['TASK_SQ']= task_sq;
			item.itemListData[slaveIndex]['PRJNO']= item.resolData.PRJNO;;
			
			if(erpSendDataList[index].resolData["TR_FG"] == 1)
			{
				salveItem.spType = 'D';
			}
			else if(erpSendDataList[index].resolData["TR_FG"] == 2){
				salveItem.spType = 'C';
			}
			var regseq = 0;
			regseq = fnSaveItemDetailErpData(salveItem);
			item.itemListData[slaveIndex]['REGSEQ']= regseq;;
			
		});
		console.log(item);
	});
	
	var master_seq = 0;
	//4. 그룹웨어 master 정보 생성
	master_seq = fnCreateEzbaroMaster();
	//5. 그룹웨어 ERP 데이터 저장
	$.each(erpSendDataList, function(index,item){
		var erp_master_seq = 0;
		erpSendDataList[index].resolData["master_seq"] = master_seq;
		erp_master_seq = fnInsertErpEzbaroMaster(item.resolData);
		$.each(item.itemListData, function(slaveIndex,salveItem){
			item.itemListData[slaveIndex]['master_seq']= master_seq;
			item.itemListData[slaveIndex]['erp_master_seq']= erp_master_seq;
			
			console.log('=======================salveItem==============================');
			console.log(salveItem);
			
			if(!fnInsertErpEzbaroSlave(salveItem)){
				console.log('ERP SLAVE DATA 생성에 실패하였습니다.');
				return false;
			}
		});
		console.log(item);
	});
	//6. 그룹웨어 ERP 파라메터 저장 
	$.each(ezparamList, function(index,item){
		item.master_seq = master_seq;
		fnInsertGwEzbaroParams(item);
	});
	
	
	console.log('전체 그룹웨어 데이터');
	console.log(gwVarList);
	//7. 그룹웨어 이지바로 결의내역 저장 ezDataLevel1List,ezDataLevel2List
	$.each(gwVarList, function(index,item){
		var gw_master_seq = 0;
		var resolData = $.extend({},item.resolData, item.detailData);
		
		$.each(erpSendDataList, function(erpIndex,erpItem){
			if(erpItem.resolData["key"] == item.groupName){
				resolData.TASK_DT = erpItem.resolData["TASK_DT"];
				resolData.TASK_SQ = erpItem.resolData["TASK_SQ"];
				resolData.CO_CD = erpItem.resolData["CO_CD"];
				resolData.resolnote = erpItem.resolData["CONT"];
				return false;
			}
			
		});
		
		resolData.master_seq = master_seq;
		resolData.cheju = item.chejuType;
		resolData.key = item.groupName;
		
		console.log('결의내용 데이터');
		console.log(resolData);
		
		gw_master_seq = fnInsertGwEzbaroMaster(resolData);
		
		
		$.each(item.itemDetailDataList, function(slaveIndex,salveItem){
			item.itemDetailDataList[slaveIndex]['TASK_DT']= resolData.TASK_DT;
			item.itemDetailDataList[slaveIndex]['TASK_SQ']= resolData.TASK_SQ;
			item.itemDetailDataList[slaveIndex]['CO_CD']= resolData.CO_CD;
			item.itemDetailDataList[slaveIndex]['master_seq']= master_seq;
			item.itemDetailDataList[slaveIndex]['gw_master_seq']= gw_master_seq;
			item.itemDetailDataList[slaveIndex]['key']= resolData.key;
			if(!fnInsertGwEzbaroSlave(salveItem)){
				console.log('GW SLAVE DATA 생성에 실패하였습니다.');
				return false;
			}
		});
	});
	
	
	var hdnInit = JSON.parse($("#hdnInitInfo").val());
	
	var head ={};
	head.AcctUnitNM = $("#txtAcctUnit").val();
	head.DEPTNM = hdnInit.DEPT_NM;
	head.USERNM = hdnInit.EMP_NM;
	head.MASTER_SEQ = master_seq;
	
	var content = [];
	/* 결의내용 반복 내용 */
	$.each(erpSendDataList,function(index,item){
		console.log('item 시작:');
		
		var newNode = {};
		newNode.TASK_DT = item.resolData.TASK_DT;
		newNode.TASK_SQ = item.resolData.TASK_SQ;
		newNode.CO_CD = item.resolData.CO_CD;
		
		
		$.each(gwVarList,function(gwIndex,gwItem){
			
			if(item.resolData.key === gwItem.groupName){
				console.log(gwItem);
				newNode.PRJNAME = gwItem.resolData.G20Project;
				newNode.BMNAME = gwItem.resolData.bmcode;
				newNode.EXECDIV_NM = gwItem.resolData.execreqdiv;
				newNode.EXECMTD_NM = gwItem.resolData.execmtd;
				return false;
			}
		});

		if(item.resolData.SUPPLYAMT == ''){
			item.resolData.SUPPLYAMT = 0;
		}
		if(item.resolData.EXTTAX == ''){
			item.resolData.EXTTAX = 0;
		}
		if(item.resolData.RESOLAMT == ''){
			item.resolData.RESOLAMT = 0;
		}
		
		newNode.SUPPLYAMT = item.resolData.SUPPLYAMT;
		newNode.EXTTAX = item.resolData.EXTTAX;
		newNode.RESOLAMT = item.resolData.RESOLAMT;
		content.push(newNode);
	});

	//9. 영리/비영리 결재프로세스 수행 시작
	if(eaInfo.eaType == 'eap'){
		/* 영리 전자결재 연동 */
		var apprParams = {};
		apprParams.doc_id = "0";
		apprParams.head = JSON.stringify(head);
		apprParams.content = JSON.stringify(content);
		//마스터 시퀀스 추가
		apprParams.masterSeq = master_seq;
		apprParams.interlock_url = JSON.stringify(eaInfo.interlockUrl);
		apprParams.processId = eaInfo.processId;
		apprParams.formSeq = eaInfo.formSeq;
		apprParams.approKey = eaInfo.processId + '_'+ master_seq; 
		apprParams.eapCallDomain = ( origin || '' );
		fnSetAppdoc(apprParams);
	}else if(eaInfo.eaType =='ea'){
		/* 비영리 전자결재 연동 */
		var apprParams = {};
		apprParams.doc_id = "0";
		apprParams.head = JSON.stringify(head);
		apprParams.content = JSON.stringify(content);
		//마스터 시퀀스 추가
		apprParams.masterSeq = master_seq;
		apprParams.interlock_url = JSON.stringify(eaInfo.interlockUrl);
		apprParams.processId = eaInfo.processId;
		apprParams.formSeq = eaInfo.formSeq;
		apprParams.approKey = eaInfo.processId + '_'+ master_seq; 
		apprParams.eapCallDomain = ( origin || '' );
		fnSetAppdoc(apprParams);
		
	}
	else{
		consele.log('전자결재 타입이 지정되지 않았거나 전재결재 모듈이 존재하지 않습니다. 관리자에게 문의하세요.');
	}
	
}

//이지바로 결의내역 전송
function fnSendResolveDataToErp(ezItem){
	//undefined 처리
	var task_sq = 0;
 	$.each(ezItem, function(index,item){
		item = item || '';
		ezItem[index] = item;
	});
 	task_sq = fnSaveResolErpData(ezItem);
 	return task_sq;
}


//이지바로 결의내역 전송
function fnSendIDataToErp(ezItem){
	//undefined 처리
	var task_sq = 0;
	$.each(ezItem, function(index,item){
		item = item || '';
		ezItem[index] = item;
	});
	regseq = fnSaveItemDetailErpData(ezItem);
	return regseq;
}

//이지바로 정보 마스터 생성
function fnCreateEzbaroMaster(){
	var master_seq  = 0;
	master_seq = fnCreateEzbaroMasterInfo();
	return master_seq;
}

