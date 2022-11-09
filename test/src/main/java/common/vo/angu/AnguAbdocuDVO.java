/**
  * @FileName : AnguAbdocuDVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.angu;

import common.helper.convert.CommonConvert;

/**
 *   * @FileName : AnguAbdocuDVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class AnguAbdocuDVO {

	private String anbojoSeq; /* 국고보조 시퀀스 */
	private String dSeq; /* 국고보조 집행등록 시퀀스 */
	private String erpCompSeq; /* ERP 회사 코드 */
	private String erpCompName; /* ERP 회사 명칭 */
	private String mosfGisuDt; /* 집행등록 결의일자 */
	private String mosfGisuSq; /* 집행등록 결의순번 */
	private String mosfPayFg; /* 지급구분 ( 1 : 일반 / 2 : 인력등록 ) */
	private String erpBizSeq; /* ERP 사업장 코드 */
	private String erpBizName; /* ERP 사업장 명칭 */
	private String erpDeptSeq; /* ERP 부서 코드 */
	private String erpDeptName; /* ERP 부서 명칭 */
	private String erpEmpSeq; /* ERP 사원 번호 */
	private String erpEmpName; /* ERP 사원 명 */
	private String cntcSn; /* 연계순번 ( 파일 생성시 update, 파일내 데이터를 구별하는 유일한 식별자_순차적 기재 ) */
	private String cntcJobProcessCode; /* 연계업무처리 코드 ( 등록, 수정, 삭제 요청시 ( C : 등록 / U : 수정 / D : 삭제 ) / 집행등록 요청 시 : C / 집행수정 요청 시 : U / 집행삭제 요청 시 : D ) */
	private String intrfcId; /* 인터페이스 ID ( IF-EXE-ERP-0074 ) */
	private String trnscId; /* 트랜잭션 ID ( 파일생성시 update ) */
	private String fileId; /* 파일 ID ( 파일생성시 update ( 첨부파일이 존재할 경우 ) ) */
	private String cntcCreatDt; /* 연계생성일시 ( 파일생성시 update ( yyyymmddhh24miss ) ) */
	private String cntcTrgetSysCode; /* 연계대상 기관시스템코드 ( 디폴트 : ANBOJO_SYSTEM_CD.SYSTEM_CD ) */
	private String bsnsyear; /* 사업연도 */
	private String ddtlbzId; /* 상세내역 사업 ID ( 국고보조사업 ) */
	private String excInsttId; /* 수행기관 ID ( 디폴트 : ANBOJO_SYSTEM_CD.BUSINESS_CD ) */
	private String excutCntcId; /* 집행연계 ID ( 집행건별 유일 KEY ( CO_CD + MOSF_GISU_DT + MOSF_GISU_SQ ) */
	private String excutTySeCode; /* 집행 유형 구분 코드 ( 10 : 계약집행 / 20 : 일반집행 ( 연계는 일반집행만 지원 ) ) */
	private String prufSeCode; /* 증빙구분 코드 ( 전자세금계산서 : 001 / 전자계산서(면세) : 002 / 카드 : 004 / 기타 : 005 ) */
	private String cardNo; /* 카드번호 ( 증빙구분 카드(004) 인 경우 카드 번호 ) */
	private String ctrCd; /* */
	private String prufSeNo; /* 증빙승인번호 ( 전자세금계산서 승인번호, 카드 매입 추심번호 ) */
	private String taxTy; /* 매입매출 구분 ( 증빙구분코드가 전자세금계산서 / 전자계산서인 경우만 적용 ( 매출 : 1 / 매입 : 2 / 면세매출 : 3 / 면세매입 : 4 ) => 결의서 발행 시 과세구분 정의로 활용, 신용카드의 경우 과세구분 : "과세" 로 처리 ) */
	private String excutRequstDe; /* 증빙일자 ( 전자세금계산서 = 발행일자 / 카드 = 매입일자 / 기타 = 직접입력 ) */
	private String transfrAcnutSeCode; /* 이체계좌구분 ( 공통코드 : 1089 ( 거래처계좌입금 : 001 / 자계좌입금 : 002 ) ) */
	private String sbsacntTrfrsnCode; /* 자계좌이체사유코드 ( 공통코드 : 0665 ( 교부전집행 : 001 / 운영비 : 002 / 해외송금 : 003 / 카드결제 : 004 / 기타 : 099 ) ) ※자계좌입금구분이'002'이면 해당 항목 필수입력 */
	private String sbsacntTrfrsnCn; /* 자계좌이체사유 ( 자계좌이체사유코드 기타 ( 099 ) 인 경우 필수 입력 */
	private String bcncSeCode; /* 거래처구분 코드 ( 법인거래 : 001 / 개인사업자거래 : 002 / 개인거래 : 003 ) */
	private String trCd; /* 거래처 코드 ( 거래처실명번호와 매칭된 STRADE 의 TR_CD ( 코드도움을 통한 변경 가능 ) ) */
	private String bcncLsftNo; /* 거래처 실명 번호 ( 법인, 개인사업자 - 사업자번호 / 개인 - 생년월일 + 성별 ) */
	private String bcncCmpnyNm; /* 거래처 회사명 */
	private String bcncIndutyNm; /* 거래처 업종명 */
	private String bcncBizcndNm; /* 거래처 업태명 */
	private String bcncRprsntvNm; /* 거래처 대표자명 */
	private String bcncAdres; /* 거래처 주소 */
	private String bcncTelno; /* 거래처 전화번호 */
	private String bcncBankCode; /* 거래처 입금은행 코드 */
	private String duzonBankCode; /* 거래처 입금은행 코드 ( 더존 ) */
	private String bcncAcnutNo; /* 거래처 입금계좌번호 */
	private String excutSplpc; /* 집행 공급가액 */
	private String excutVat; /* 집행 부가가치세 */
	private String excutSumAmount; /* 집행 합계금액 */
	private String excutPrposCn; /* 집행용도 내용 */
	private String bcncBnkbIndictCn; /* 거래처 통장 표시 내용 */
	private String sbsidyBnkbIndictCn; /* 보조금 통장 표시 내용 */
	private String prepar; /* 예비 */
	private String excutExpitmTaxitmCnt; /* 집행별 비목세목 건 수 */
	private String sendYN; /* 전송 상태 값 */
	private String processResultCode; /* 집행등록 처리 결과 코드 */
	private String processResultMssage; /* 집행등록 처리 결과 메시지 */
	private String exrltCode; /* 이체결과 처리 결과 코드 */
	private String exrltMssage; /* 이체결과 처리 결과 메시지 */
	private String insertId; /* 입력자 */
	private String insertDt; /* 입력일자 */
	private String insertIp; /* 입력 IP */
	private String modifyId; /* 수정자 */
	private String modifyDt; /* 수정일자 */
	private String modifyIp; /* 수정 IP */
	private String jsonAbdocuH; /* H json */
	private String jsonAbdocuD; /* D json */

	public String getAnbojoSeq ( ) {
		return CommonConvert.CommonGetStr(anbojoSeq);
	}

	public void setAnbojoSeq ( String anbojoSeq ) {
		this.anbojoSeq = anbojoSeq;
	}

	public String getdSeq ( ) {
		return CommonConvert.CommonGetStr(dSeq);
	}

	public void setdSeq ( String dSeq ) {
		this.dSeq = dSeq;
	}

	public String getErpCompSeq ( ) {
		return CommonConvert.CommonGetStr(erpCompSeq);
	}

	public void setErpCompSeq ( String erpCompSeq ) {
		this.erpCompSeq = erpCompSeq;
	}

	public String getErpCompName ( ) {
		return CommonConvert.CommonGetStr(erpCompName);
	}

	public void setErpCompName ( String erpCompName ) {
		this.erpCompName = erpCompName;
	}

	public String getMosfGisuDt ( ) {
		return CommonConvert.CommonGetStr(mosfGisuDt);
	}

	public void setMosfGisuDt ( String mosfGisuDt ) {
		this.mosfGisuDt = mosfGisuDt;
	}

	public String getMosfGisuSq ( ) {
		return CommonConvert.CommonGetStr(mosfGisuSq);
	}

	public void setMosfGisuSq ( String mosfGisuSq ) {
		this.mosfGisuSq = mosfGisuSq;
	}

	public String getMosfPayFg ( ) {
		return CommonConvert.CommonGetStr(mosfPayFg);
	}

	public void setMosfPayFg ( String mosfPayFg ) {
		this.mosfPayFg = mosfPayFg;
	}

	public String getErpBizSeq ( ) {
		return CommonConvert.CommonGetStr(erpBizSeq);
	}

	public void setErpBizSeq ( String erpBizSeq ) {
		this.erpBizSeq = erpBizSeq;
	}

	public String getErpBizName ( ) {
		return CommonConvert.CommonGetStr(erpBizName);
	}

	public void setErpBizName ( String erpBizName ) {
		this.erpBizName = erpBizName;
	}

	public String getErpDeptSeq ( ) {
		return CommonConvert.CommonGetStr(erpDeptSeq);
	}

	public void setErpDeptSeq ( String erpDeptSeq ) {
		this.erpDeptSeq = erpDeptSeq;
	}

	public String getErpDeptName ( ) {
		return CommonConvert.CommonGetStr(erpDeptName);
	}

	public void setErpDeptName ( String erpDeptName ) {
		this.erpDeptName = erpDeptName;
	}

	public String getErpEmpSeq ( ) {
		return CommonConvert.CommonGetStr(erpEmpSeq);
	}

	public void setErpEmpSeq ( String erpEmpSeq ) {
		this.erpEmpSeq = erpEmpSeq;
	}

	public String getErpEmpName ( ) {
		return CommonConvert.CommonGetStr(erpEmpName);
	}

	public void setErpEmpName ( String erpEmpName ) {
		this.erpEmpName = erpEmpName;
	}

	public String getCntcSn ( ) {
		return CommonConvert.CommonGetStr(cntcSn);
	}

	public void setCntcSn ( String cntcSn ) {
		this.cntcSn = cntcSn;
	}

	public String getCntcJobProcessCode ( ) {
		return CommonConvert.CommonGetStr(cntcJobProcessCode);
	}

	public void setCntcJobProcessCode ( String cntcJobProcessCode ) {
		this.cntcJobProcessCode = cntcJobProcessCode;
	}

	public String getIntrfcId ( ) {
		return CommonConvert.CommonGetStr(intrfcId);
	}

	public void setIntrfcId ( String intrfcId ) {
		this.intrfcId = intrfcId;
	}

	public String getTrnscId ( ) {
		return CommonConvert.CommonGetStr(trnscId);
	}

	public void setTrnscId ( String trnscId ) {
		this.trnscId = trnscId;
	}

	public String getFileId ( ) {
		return CommonConvert.CommonGetStr(fileId);
	}

	public void setFileId ( String fileId ) {
		this.fileId = fileId;
	}

	public String getCntcCreatDt ( ) {
		return CommonConvert.CommonGetStr(cntcCreatDt);
	}

	public void setCntcCreatDt ( String cntcCreatDt ) {
		this.cntcCreatDt = cntcCreatDt;
	}

	public String getCntcTrgetSysCode ( ) {
		return CommonConvert.CommonGetStr(cntcTrgetSysCode);
	}

	public void setCntcTrgetSysCode ( String cntcTrgetSysCode ) {
		this.cntcTrgetSysCode = cntcTrgetSysCode;
	}

	public String getBsnsyear ( ) {
		return CommonConvert.CommonGetStr(bsnsyear);
	}

	public void setBsnsyear ( String bsnsyear ) {
		this.bsnsyear = bsnsyear;
	}

	public String getDdtlbzId ( ) {
		return CommonConvert.CommonGetStr(ddtlbzId);
	}

	public void setDdtlbzId ( String ddtlbzId ) {
		this.ddtlbzId = ddtlbzId;
	}

	public String getExcInsttId ( ) {
		return CommonConvert.CommonGetStr(excInsttId);
	}

	public void setExcInsttId ( String excInsttId ) {
		this.excInsttId = excInsttId;
	}

	public String getExcutCntcId ( ) {
		return CommonConvert.CommonGetStr(excutCntcId);
	}

	public void setExcutCntcId ( String excutCntcId ) {
		this.excutCntcId = excutCntcId;
	}

	public String getExcutTySeCode ( ) {
		return CommonConvert.CommonGetStr(excutTySeCode);
	}

	public void setExcutTySeCode ( String excutTySeCode ) {
		this.excutTySeCode = excutTySeCode;
	}

	public String getPrufSeCode ( ) {
		return CommonConvert.CommonGetStr(prufSeCode);
	}

	public void setPrufSeCode ( String prufSeCode ) {
		this.prufSeCode = prufSeCode;
	}

	public String getCardNo ( ) {
		return CommonConvert.CommonGetStr(cardNo);
	}

	public void setCardNo ( String cardNo ) {
		this.cardNo = cardNo;
	}

	public String getCtrCd ( ) {
		return CommonConvert.CommonGetStr(ctrCd);
	}

	public void setCtrCd ( String ctrCd ) {
		this.ctrCd = ctrCd;
	}

	public String getPrufSeNo ( ) {
		return CommonConvert.CommonGetStr(prufSeNo);
	}

	public void setPrufSeNo ( String prufSeNo ) {
		this.prufSeNo = prufSeNo;
	}

	public String getTaxTy ( ) {
		return CommonConvert.CommonGetStr(taxTy);
	}

	public void setTaxTy ( String taxTy ) {
		this.taxTy = taxTy;
	}

	public String getExcutRequstDe ( ) {
		return CommonConvert.CommonGetStr(excutRequstDe);
	}

	public void setExcutRequstDe ( String excutRequstDe ) {
		this.excutRequstDe = excutRequstDe;
	}

	public String getTransfrAcnutSeCode ( ) {
		return CommonConvert.CommonGetStr(transfrAcnutSeCode);
	}

	public void setTransfrAcnutSeCode ( String transfrAcnutSeCode ) {
		this.transfrAcnutSeCode = transfrAcnutSeCode;
	}

	public String getSbsacntTrfrsnCode ( ) {
		return CommonConvert.CommonGetStr(sbsacntTrfrsnCode);
	}

	public void setSbsacntTrfrsnCode ( String sbsacntTrfrsnCode ) {
		this.sbsacntTrfrsnCode = sbsacntTrfrsnCode;
	}

	public String getSbsacntTrfrsnCn ( ) {
		return CommonConvert.CommonGetStr(sbsacntTrfrsnCn);
	}

	public void setSbsacntTrfrsnCn ( String sbsacntTrfrsnCn ) {
		this.sbsacntTrfrsnCn = sbsacntTrfrsnCn;
	}

	public String getBcncSeCode ( ) {
		return CommonConvert.CommonGetStr(bcncSeCode);
	}

	public void setBcncSeCode ( String bcncSeCode ) {
		this.bcncSeCode = bcncSeCode;
	}

	public String getTrCd ( ) {
		return CommonConvert.CommonGetStr(trCd);
	}

	public void setTrCd ( String trCd ) {
		this.trCd = trCd;
	}

	public String getBcncLsftNo ( ) {
		return CommonConvert.CommonGetStr(bcncLsftNo);
	}

	public void setBcncLsftNo ( String bcncLsftNo ) {
		this.bcncLsftNo = bcncLsftNo;
	}

	public String getBcncCmpnyNm ( ) {
		return CommonConvert.CommonGetStr(bcncCmpnyNm);
	}

	public void setBcncCmpnyNm ( String bcncCmpnyNm ) {
		this.bcncCmpnyNm = bcncCmpnyNm;
	}

	public String getBcncIndutyNm ( ) {
		return CommonConvert.CommonGetStr(bcncIndutyNm);
	}

	public void setBcncIndutyNm ( String bcncIndutyNm ) {
		this.bcncIndutyNm = bcncIndutyNm;
	}

	public String getBcncBizcndNm ( ) {
		return CommonConvert.CommonGetStr(bcncBizcndNm);
	}

	public void setBcncBizcndNm ( String bcncBizcndNm ) {
		this.bcncBizcndNm = bcncBizcndNm;
	}

	public String getBcncRprsntvNm ( ) {
		return CommonConvert.CommonGetStr(bcncRprsntvNm);
	}

	public void setBcncRprsntvNm ( String bcncRprsntvNm ) {
		this.bcncRprsntvNm = bcncRprsntvNm;
	}

	public String getBcncAdres ( ) {
		return CommonConvert.CommonGetStr(bcncAdres);
	}

	public void setBcncAdres ( String bcncAdres ) {
		this.bcncAdres = bcncAdres;
	}

	public String getBcncTelno ( ) {
		return CommonConvert.CommonGetStr(bcncTelno);
	}

	public void setBcncTelno ( String bcncTelno ) {
		this.bcncTelno = bcncTelno;
	}

	public String getBcncBankCode ( ) {
		return CommonConvert.CommonGetStr(bcncBankCode);
	}

	public void setBcncBankCode ( String bcncBankCode ) {
		this.bcncBankCode = bcncBankCode;
	}

	public String getDuzonBankCode ( ) {
		return CommonConvert.CommonGetStr(duzonBankCode);
	}

	public void setDuzonBankCode ( String duzonBankCode ) {
		this.duzonBankCode = duzonBankCode;
	}

	public String getBcncAcnutNo ( ) {
		return CommonConvert.CommonGetStr(bcncAcnutNo);
	}

	public void setBcncAcnutNo ( String bcncAcnutNo ) {
		this.bcncAcnutNo = bcncAcnutNo;
	}

	public String getExcutSplpc ( ) {
		return CommonConvert.CommonGetStr(excutSplpc);
	}

	public void setExcutSplpc ( String excutSplpc ) {
		this.excutSplpc = excutSplpc;
	}

	public String getExcutVat ( ) {
		return CommonConvert.CommonGetStr(excutVat);
	}

	public void setExcutVat ( String excutVat ) {
		this.excutVat = excutVat;
	}

	public String getExcutSumAmount ( ) {
		return CommonConvert.CommonGetStr(excutSumAmount);
	}

	public void setExcutSumAmount ( String excutSumAmount ) {
		this.excutSumAmount = excutSumAmount;
	}

	public String getExcutPrposCn ( ) {
		return CommonConvert.CommonGetStr(excutPrposCn);
	}

	public void setExcutPrposCn ( String excutPrposCn ) {
		this.excutPrposCn = excutPrposCn;
	}

	public String getBcncBnkbIndictCn ( ) {
		return CommonConvert.CommonGetStr(bcncBnkbIndictCn);
	}

	public void setBcncBnkbIndictCn ( String bcncBnkbIndictCn ) {
		this.bcncBnkbIndictCn = bcncBnkbIndictCn;
	}

	public String getSbsidyBnkbIndictCn ( ) {
		return CommonConvert.CommonGetStr(sbsidyBnkbIndictCn);
	}

	public void setSbsidyBnkbIndictCn ( String sbsidyBnkbIndictCn ) {
		this.sbsidyBnkbIndictCn = sbsidyBnkbIndictCn;
	}

	public String getPrepar ( ) {
		return CommonConvert.CommonGetStr(prepar);
	}

	public void setPrepar ( String prepar ) {
		this.prepar = prepar;
	}

	public String getExcutExpitmTaxitmCnt ( ) {
		return CommonConvert.CommonGetStr(excutExpitmTaxitmCnt);
	}

	public void setExcutExpitmTaxitmCnt ( String excutExpitmTaxitmCnt ) {
		this.excutExpitmTaxitmCnt = excutExpitmTaxitmCnt;
	}

	public String getSendYN ( ) {
		return CommonConvert.CommonGetStr(sendYN);
	}

	public void setSendYN ( String sendYN ) {
		this.sendYN = sendYN;
	}

	public String getProcessResultCode ( ) {
		return CommonConvert.CommonGetStr(processResultCode);
	}

	public void setProcessResultCode ( String processResultCode ) {
		this.processResultCode = processResultCode;
	}

	public String getProcessResultMssage ( ) {
		return CommonConvert.CommonGetStr(processResultMssage);
	}

	public void setProcessResultMssage ( String processResultMssage ) {
		this.processResultMssage = processResultMssage;
	}

	public String getExrltCode ( ) {
		return CommonConvert.CommonGetStr(exrltCode);
	}

	public void setExrltCode ( String exrltCode ) {
		this.exrltCode = exrltCode;
	}

	public String getExrltMssage ( ) {
		return CommonConvert.CommonGetStr(exrltMssage);
	}

	public void setExrltMssage ( String exrltMssage ) {
		this.exrltMssage = exrltMssage;
	}

	public String getInsertId ( ) {
		return CommonConvert.CommonGetStr(insertId);
	}

	public void setInsertId ( String insertId ) {
		this.insertId = insertId;
	}

	public String getInsertDt ( ) {
		return CommonConvert.CommonGetStr(insertDt);
	}

	public void setInsertDt ( String insertDt ) {
		this.insertDt = insertDt;
	}

	public String getInsertIp ( ) {
		return CommonConvert.CommonGetStr(insertIp);
	}

	public void setInsertIp ( String insertIp ) {
		this.insertIp = insertIp;
	}

	public String getModifyId ( ) {
		return CommonConvert.CommonGetStr(modifyId);
	}

	public void setModifyId ( String modifyId ) {
		this.modifyId = modifyId;
	}

	public String getModifyDt ( ) {
		return CommonConvert.CommonGetStr(modifyDt);
	}

	public void setModifyDt ( String modifyDt ) {
		this.modifyDt = modifyDt;
	}

	public String getModifyIp ( ) {
		return CommonConvert.CommonGetStr(modifyIp);
	}

	public void setModifyIp ( String modifyIp ) {
		this.modifyIp = modifyIp;
	}

	public String getJsonAbdocuH ( ) {
		return CommonConvert.CommonGetStr(jsonAbdocuH);
	}

	public void setJsonAbdocuH ( String jsonAbdocuH ) {
		this.jsonAbdocuH = jsonAbdocuH;
	}

	public String getJsonAbdocuD ( ) {
		return CommonConvert.CommonGetStr(jsonAbdocuD);
	}

	public void setJsonAbdocuD ( String jsonAbdocuD ) {
		this.jsonAbdocuD = jsonAbdocuD;
	}

	@Override
	public String toString ( ) {
		return "AnguAbdocuDVO [anbojoSeq=" + anbojoSeq + ", dSeq=" + dSeq + ", erpCompSeq=" + erpCompSeq + ", erpCompName=" + erpCompName + ", mosfGisuDt=" + mosfGisuDt + ", mosfGisuSq=" + mosfGisuSq + ", mosfPayFg=" + mosfPayFg + ", erpBizSeq=" + erpBizSeq + ", erpBizName=" + erpBizName + ", erpDeptSeq=" + erpDeptSeq + ", erpDeptName=" + erpDeptName + ", erpEmpSeq=" + erpEmpSeq + ", erpEmpName=" + erpEmpName + ", cntcSn=" + cntcSn + ", cntcJobProcessCode=" + cntcJobProcessCode + ", intrfcId=" + intrfcId + ", trnscId=" + trnscId + ", fileId=" + fileId + ", cntcCreatDt=" + cntcCreatDt + ", cntcTrgetSysCode=" + cntcTrgetSysCode + ", bsnsyear=" + bsnsyear + ", ddtlbzId=" + ddtlbzId + ", excInsttId=" + excInsttId + ", excutCntcId=" + excutCntcId + ", excutTySeCode=" + excutTySeCode + ", prufSeCode=" + prufSeCode + ", cardNo=" + cardNo + ", ctrCd=" + ctrCd + ", prufSeNo=" + prufSeNo + ", taxTy=" + taxTy + ", excutRequstDe=" + excutRequstDe + ", transfrAcnutSeCode=" + transfrAcnutSeCode
				+ ", sbsacntTrfrsnCode=" + sbsacntTrfrsnCode + ", sbsacntTrfrsnCn=" + sbsacntTrfrsnCn + ", bcncSeCode=" + bcncSeCode + ", trCd=" + trCd + ", bcncLsftNo=" + bcncLsftNo + ", bcncCmpnyNm=" + bcncCmpnyNm + ", bcncIndutyNm=" + bcncIndutyNm + ", bcncBizcndNm=" + bcncBizcndNm + ", bcncRprsntvNm=" + bcncRprsntvNm + ", bcncAdres=" + bcncAdres + ", bcncTelno=" + bcncTelno + ", bcncBankCode=" + bcncBankCode + ", duzonBankCode=" + duzonBankCode + ", bcncAcnutNo=" + bcncAcnutNo + ", excutSplpc=" + excutSplpc + ", excutVat=" + excutVat + ", excutSumAmount=" + excutSumAmount + ", excutPrposCn=" + excutPrposCn + ", bcncBnkbIndictCn=" + bcncBnkbIndictCn + ", sbsidyBnkbIndictCn=" + sbsidyBnkbIndictCn + ", prepar=" + prepar + ", excutExpitmTaxitmCnt=" + excutExpitmTaxitmCnt + ", sendYN=" + sendYN + ", processResultCode=" + processResultCode + ", processResultMssage=" + processResultMssage + ", exrltCode=" + exrltCode + ", exrltMssage=" + exrltMssage + ", insertId=" + insertId
				+ ", insertDt=" + insertDt + ", insertIp=" + insertIp + ", modifyId=" + modifyId + ", modifyDt=" + modifyDt + ", modifyIp=" + modifyIp + ", jsonAbdocuH=" + jsonAbdocuH + ", jsonAbdocuD=" + jsonAbdocuD + "]";
	}
}
