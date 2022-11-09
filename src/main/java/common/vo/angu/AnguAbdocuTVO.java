/**
  * @FileName : AnguAbdocuTVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.angu;

import common.helper.convert.CommonConvert;

/**
 *   * @FileName : AnguAbdocuTVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class AnguAbdocuTVO {

	private String anbojoSeq; /* 국고보조 시퀀스 */
	private String dSeq; /* 국고보조 집행등록 시퀀스 */
	private String bSeq; /* 국고보조 집행등록 비목정보 시퀀스 */
	private String tSeq; /* 국고보조 집행등록 비목정보 재원정보 시퀀스 */
	private String erpCompSeq; /* ERP 회사 코드 */
	private String erpCompName; /* ERP 회사 명칭 */
	private String mosfGisuDt; /* 집행등록 결의일자 ( 집행등록 요청의 품의일자(CNSUL_DE) ) */
	private String mosfGisuSq; /* 집행등록 결의순번 ( 집행등록 요청의 품의번호(CNSUL_NO) ) */
	private String mosfBgSq; /* 집행등록 비목순번 */
	private String mosfLnSq; /* 집행등록 재원순번 */
	private String gisuDt; /*  */
	private String gisuSq; /*  */
	private String cntcSn; /* 연계순번 ( 파일생성시 update (파일내 데이터를 구별하는 유일한 식별자_순차적 기재) ) */
	private String cntcJobProcessCode; /* 연계업무처리코드 ( 파일생성시 update (C: 등록, U: 수정, D: 삭제) ) */
	private String intrfcId; /* 인터페이스 ID ( IF-EXE-ERP-0074 ) */
	private String trnscId; /* 트랜잭션 ID ( 파일생성시 update ) */
	private String fileId; /* 파일 ID ( 파일생성시 update (첨부파일이 존재할 경우) ) */
	private String cntcCreatDt; /* 연계생성일시 ( 파일생성시 update ) */
	private String cntcTrgetSysCode; /* 연계대상시스템코드 ( 디폴트 (ANBOJO_SYSTEM_CD.SYSTEM_CD) ) */
	private String excutCntcId; /* 집행연계 ID ( 집행건별 유일KEY (CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ) ) */
	private String excutTaxitmCntcId; /* 집행비목세목연계 ID ( CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ+MOSF_BG_SQ ) */
	private String fnrscSeCode; /* 재원구분코드 ( 재원구분코드:1220 공통관리 인터페이스(공통관리코드) ) */
	private String mgtCd; /* 프로젝트 ( 결의서발행 시 활용(ABDOCU.MGT_CD) ) */
	private String bottomCd; /* 하위사업 */
	private String abgtCd; /* 예산과목 ( 결의서발행 시 활용(ABDOCU_B.ABGT_CD) ) */
	private String btrCd; /* 입/출금계좌 거래처 코드 ( 결의서발행 시 활용(ABDOCU.BTR_CD) ) */
	private String splpc; /* 공급가액 */
	private String vat; /* 부가가치세 */
	private String sumAmount; /* 합계금액 */
	private String insertId; /* 입력자 */
	private String insertDt; /* 입력일자 */
	private String insertIp; /* 입력 IP */
	private String modifyId; /* 수정자 */
	private String modifyDt; /* 수정일자 */
	private String modifyIp; /* 수정 IP */
	private String jsonAbdocuT; /* 재원정보 JSON */

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

	public String getbSeq ( ) {
		return CommonConvert.CommonGetStr(bSeq);
	}

	public void setbSeq ( String bSeq ) {
		this.bSeq = bSeq;
	}

	public String gettSeq ( ) {
		return CommonConvert.CommonGetStr(tSeq);
	}

	public void settSeq ( String tSeq ) {
		this.tSeq = tSeq;
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

	public String getMosfBgSq ( ) {
		return CommonConvert.CommonGetStr(mosfBgSq);
	}

	public void setMosfBgSq ( String mosfBgSq ) {
		this.mosfBgSq = mosfBgSq;
	}

	public String getMosfLnSq ( ) {
		return CommonConvert.CommonGetStr(mosfLnSq);
	}

	public void setMosfLnSq ( String mosfLnSq ) {
		this.mosfLnSq = mosfLnSq;
	}

	public String getGisuDt ( ) {
		return CommonConvert.CommonGetStr(gisuDt);
	}

	public void setGisuDt ( String gisuDt ) {
		this.gisuDt = gisuDt;
	}

	public String getGisuSq ( ) {
		return CommonConvert.CommonGetStr(gisuSq);
	}

	public void setGisuSq ( String gisuSq ) {
		this.gisuSq = gisuSq;
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

	public String getExcutCntcId ( ) {
		return CommonConvert.CommonGetStr(excutCntcId);
	}

	public void setExcutCntcId ( String excutCntcId ) {
		this.excutCntcId = excutCntcId;
	}

	public String getExcutTaxitmCntcId ( ) {
		return CommonConvert.CommonGetStr(excutTaxitmCntcId);
	}

	public void setExcutTaxitmCntcId ( String excutTaxitmCntcId ) {
		this.excutTaxitmCntcId = excutTaxitmCntcId;
	}

	public String getFnrscSeCode ( ) {
		return CommonConvert.CommonGetStr(fnrscSeCode);
	}

	public void setFnrscSeCode ( String fnrscSeCode ) {
		this.fnrscSeCode = fnrscSeCode;
	}

	public String getMgtCd ( ) {
		return CommonConvert.CommonGetStr(mgtCd);
	}

	public void setMgtCd ( String mgtCd ) {
		this.mgtCd = mgtCd;
	}

	public String getBottomCd ( ) {
		return CommonConvert.CommonGetStr(bottomCd);
	}

	public void setBottomCd ( String bottomCd ) {
		this.bottomCd = bottomCd;
	}

	public String getAbgtCd ( ) {
		return CommonConvert.CommonGetStr(abgtCd);
	}

	public void setAbgtCd ( String abgtCd ) {
		this.abgtCd = abgtCd;
	}

	public String getBtrCd ( ) {
		return CommonConvert.CommonGetStr(btrCd);
	}

	public void setBtrCd ( String btrCd ) {
		this.btrCd = btrCd;
	}

	public String getSplpc ( ) {
		return CommonConvert.CommonGetStr(splpc);
	}

	public void setSplpc ( String splpc ) {
		this.splpc = splpc;
	}

	public String getVat ( ) {
		return CommonConvert.CommonGetStr(vat);
	}

	public void setVat ( String vat ) {
		this.vat = vat;
	}

	public String getSumAmount ( ) {
		return CommonConvert.CommonGetStr(sumAmount);
	}

	public void setSumAmount ( String sumAmount ) {
		this.sumAmount = sumAmount;
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

	public String getJsonAbdocuT ( ) {
		return CommonConvert.CommonGetStr(jsonAbdocuT);
	}

	public void setJsonAbdocuT ( String jsonAbdocuT ) {
		this.jsonAbdocuT = jsonAbdocuT;
	}

	@Override
	public String toString ( ) {
		return "AnguAbdocuTVO [anbojoSeq=" + anbojoSeq + ", dSeq=" + dSeq + ", bSeq=" + bSeq + ", tSeq=" + tSeq + ", erpCompSeq=" + erpCompSeq + ", erpCompName=" + erpCompName + ", mosfGisuDt=" + mosfGisuDt + ", mosfGisuSq=" + mosfGisuSq + ", mosfBgSq=" + mosfBgSq + ", mosfLnSq=" + mosfLnSq + ", gisuDt=" + gisuDt + ", gisuSq=" + gisuSq + ", cntcSn=" + cntcSn + ", cntcJobProcessCode=" + cntcJobProcessCode + ", intrfcId=" + intrfcId + ", trnscId=" + trnscId + ", fileId=" + fileId + ", cntcCreatDt=" + cntcCreatDt + ", cntcTrgetSysCode=" + cntcTrgetSysCode + ", excutCntcId=" + excutCntcId + ", excutTaxitmCntcId=" + excutTaxitmCntcId + ", fnrscSeCode=" + fnrscSeCode + ", mgtCd=" + mgtCd + ", bottomCd=" + bottomCd + ", abgtCd=" + abgtCd + ", btrCd=" + btrCd + ", splpc=" + splpc + ", vat=" + vat + ", sumAmount=" + sumAmount + ", insertId=" + insertId + ", insertDt=" + insertDt + ", insertIp=" + insertIp + ", modifyId=" + modifyId + ", modifyDt=" + modifyDt + ", modifyIp=" + modifyIp
				+ ", jsonAbdocuT=" + jsonAbdocuT + "]";
	}
}