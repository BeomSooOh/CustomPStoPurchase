/**
  * @FileName : AnguAbdocuBVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.angu;

import common.helper.convert.CommonConvert;

/**
 *   * @FileName : AnguAbdocuBVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class AnguAbdocuBVO {

	private String anbojoSeq; /* 국고보조 시퀀스 */
	private String dSeq; /* 국고보조 집행등록 시퀀스 */
	private String bSeq; /* 국고보조 집행등록 비목정보 시퀀스 */
	private String erpCompSeq; /* ERP 회사 코드 */
	private String erpCompName; /* ERP 회사 명칭 */
	private String mosfGisuDt; /* 집행등록 결의일자 ( 집행등록 요청의 품의일자 ( CNSUL_DT ) ) */
	private String mosfGisuSq; /* 집행등록 결의순번 ( 집행등록 요청의 품의번호 ( CNSUL_NO ) ) */
	private String mosfBgSq; /* 집행등록 비목순번 */
	private String cntcSn; /* 연계 순번 ( 파일생성시 update ( 파일내 데이터를 구별하는 유일한 식별자, 순차적 기재 ) ) */
	private String cntcJobProcessCode; /* 연계 업무처리 코드 ( 파일생성시 update ( 등록 : C / 수정 : U / 삭제 : D ) ) */
	private String intrfcId; /* 인터페이스 ID ( IF-EXE-ERP-0074 ) */
	private String trnscId; /* 트랜잭션 ID ( 파일생성시 update ) */
	private String fileId; /* 파일 ID ( 파일생성시 update ( 첨부파일이 존재할 경우 ) ) */
	private String cntcCreatDt; /* 연계 생성 일시 ( 파일생성시 udpate ) */
	private String cntcTrgetSysCode; /* 연계 대상 시스템 코드 ( 디폴트 : ANBOJO_SYSTEM_CD.SYSTEM_CD ) */
	private String excutCntcId; /* 집행연계 ID ( 집행건별 유일 KEY ( CO_CD + MOSF_GISU_DT + MOSF_GISU_SQ ) ) */
	private String asstnTaxitmCode; /* 보조세목코드 ( 보조비목세목 ( T_CMM_ASSTM_EXPITM_TAXITM ), 공통관리 인터페이스 ( 공통관리코드 ) ) */
	private String excutTaxitmCntcId; /* 집행비목세목연계 ID ( CO_CD+MOSF_GISU_DT+MOSF_GISU_SQ+MOSF_BG_SQ ) */
	private String taxitmFnrscCnt; /* 세목별재원건수 ( 집행비목세목연계ID에 해당하는 _T 건수 ) */
	private String prdlstNm; /* 품목 */
	private String insertId; /* 입력자 */
	private String insertDt; /* 입력일자 */
	private String insertIp; /* 입력자 IP */
	private String modifyId; /* 수정자 */
	private String modifyDt; /* 수정일자 */
	private String modifyIp; /* 수정 IP */
	private String jsonAbdocuB; /* B json */

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

	public String getAsstnTaxitmCode ( ) {
		return CommonConvert.CommonGetStr(asstnTaxitmCode);
	}

	public void setAsstnTaxitmCode ( String asstnTaxitmCode ) {
		this.asstnTaxitmCode = asstnTaxitmCode;
	}

	public String getExcutTaxitmCntcId ( ) {
		return CommonConvert.CommonGetStr(excutTaxitmCntcId);
	}

	public void setExcutTaxitmCntcId ( String excutTaxitmCntcId ) {
		this.excutTaxitmCntcId = excutTaxitmCntcId;
	}

	public String getTaxitmFnrscCnt ( ) {
		return CommonConvert.CommonGetStr(taxitmFnrscCnt);
	}

	public void setTaxitmFnrscCnt ( String taxitmFnrscCnt ) {
		this.taxitmFnrscCnt = taxitmFnrscCnt;
	}

	public String getPrdlstNm ( ) {
		return CommonConvert.CommonGetStr(prdlstNm);
	}

	public void setPrdlstNm ( String prdlstNm ) {
		this.prdlstNm = prdlstNm;
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

	public String getJsonAbdocuB ( ) {
		return CommonConvert.CommonGetStr(jsonAbdocuB);
	}

	public void setJsonAbdocuB ( String jsonAbdocuB ) {
		this.jsonAbdocuB = jsonAbdocuB;
	}

	@Override
	public String toString ( ) {
		return "AnguAbdocuBVO [anbojoSeq=" + anbojoSeq + ", dSeq=" + dSeq + ", bSeq=" + bSeq + ", erpCompSeq=" + erpCompSeq + ", erpCompName=" + erpCompName + ", mosfGisuDt=" + mosfGisuDt + ", mosfGisuSq=" + mosfGisuSq + ", mosfBgSq=" + mosfBgSq + ", cntcSn=" + cntcSn + ", cntcJobProcessCode=" + cntcJobProcessCode + ", intrfcId=" + intrfcId + ", trnscId=" + trnscId + ", fileId=" + fileId + ", cntcCreatDt=" + cntcCreatDt + ", cntcTrgetSysCode=" + cntcTrgetSysCode + ", excutCntcId=" + excutCntcId + ", asstnTaxitmCode=" + asstnTaxitmCode + ", excutTaxitmCntcId=" + excutTaxitmCntcId + ", taxitmFnrscCnt=" + taxitmFnrscCnt + ", prdlstNm=" + prdlstNm + ", insertId=" + insertId + ", insertDt=" + insertDt + ", insertIp=" + insertIp + ", modifyId=" + modifyId + ", modifyDt=" + modifyDt + ", modifyIp=" + modifyIp + ", jsonAbdocuB=" + jsonAbdocuB + "]";
	}
}