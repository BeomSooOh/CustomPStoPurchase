package common.vo.np;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;


public class NpErpSendiUVO {

	List<Map<String, Object>> resDoc;
	List<Map<String, Object>> resBudget;
	List<Map<String, Object>> resTrade;
	List<Map<String, Object>> resItemSpec;
	List<Map<String, Object>> sendCauseData;
	List<Map<String, Object>> sendPayData;
	List<Map<String, Object>> sendGoodStateData;
	List<KeyContainer> budgetKey ;
	List<KeyContainer> tradeKey ;
	String erpNoCDocu;
	String erpNoCdMng;
	
	/**
	 * ERP iU 전송포멧에 맞게 준비
	 * @param resItemSpec 
	 */
	public NpErpSendiUVO ( ResultVO resDoc, ResultVO resBudget, ResultVO resTrade, ResultVO resItemSpec , String erpNoCDocu , String erpNoCdMng ) throws Exception {
		/* 
		 * 지역변수 초기화 
		 * */
		this.budgetKey = new ArrayList<>( );
		this.tradeKey = new ArrayList<>( );
		this.resDoc = resDoc.getAaData( );
		this.resBudget = resBudget.getAaData( );
		this.resTrade = resTrade.getAaData( );
		this.resItemSpec = resItemSpec.getAaData( );
		
		/*
		 * 생성자 파라미터 무결검증
		 * */
		if ( this.resDoc.size( ) != 1 ) {
			throw new Exception( "문서정보는 단일 데이터를 포함해야 합니다." );
		}
		if ( this.resBudget.size( ) == 0 ) {
			throw new Exception( "예산정보를 찾을 수 없습니다." );
		}
		if ( this.resTrade.size( ) == 0 ) {
			throw new Exception( "거래처정보를 찾을 수 없습니다." );
		}
		/*
		 * 데이터 키 변환 - 전송준비
		 * */
		this.erpNoCDocu = erpNoCDocu;
		this.erpNoCdMng = erpNoCdMng;
		this.readySendCauseData( );
		this.readySendGoodStateData( );
		this.readySendPayData( );
	}

	/**
	 * ERP전송 데이터 준비
	 * 헤더 정보와 예산정보를 가지고 있습니다.
	 * 대상 테이블 : FI_DOCUCAUSE.
	 */
	private void readySendCauseData ( ) {
		this.sendCauseData = new ArrayList<Map<String, Object>>( );
		String resBefore = "";
		int resIdx = -1;
		int dispIdx = 0;
		
		
		for ( int i = 0; i < this.resBudget.size( ); i++ ) {
			Map<String, Object> item = this.resBudget.get( i );
			Map<String, Object> temp = new HashMap<>( );
			
			if ( !resBefore.equals( item.get( "resSeq" ).toString( ) ) ) {
				resIdx++;
				resBefore = item.get( "resSeq" ).toString( );
				dispIdx=0;
			}	
			else {
				dispIdx++;
			}
			
			/* 문서번호 예산 비고 전송 옵션 */
			String budgetNote = "";
			if(item.get("budgetSendOpt").equals("0")) {
				budgetNote = CommonConvert.NullToString(item.get("docNo")) + item.get("budgetNote" );	
			}
			else {
				budgetNote = CommonConvert.NullToString( item.get("budgetNote") );
			}
			
			/* 회계발의일자 전송옵션 */
			if(item.get("budgetDtCacctSendOpt").equals("0")) {
				temp.put( "DT_CACCT", item.get( "cacctDate" ) ); // - 회계 발의 일자
			}
			else {
				temp.put( "DT_CACCT", "" ); // - 회계 발의 일자
			}
			
			
			temp.put( "APP_DOCU_ID", item.get("docSeq")); // 전자결재 문서 키
			temp.put( "CD_COMPANY", item.get( "erpCompSeq" ) ); // 회사 코드
			temp.put( "CD_PC", item.get( "erpPcSeq" ) ); // 회계 단위
			temp.put( "NO_CDOCU", makeKeyString(this.erpNoCDocu, resIdx) ); // - 결의서번호
			temp.put( "NO_CDOLINE", "" + ( dispIdx + 1 ) ); // 문서 예산 키
			temp.put( "CD_WDEPT", item.get( "erpDeptSeq" ) ); // ERP 부서 코드 
			temp.put( "ID_WRITE", item.get( "erpEmpSeq" ) ); // ERP 사용자 코드
			temp.put( "DT_WRITE", item.get( "resDate" ) ); // 발의 일자
			temp.put( "TP_EPNOTE", getSetFgCode ( item.get( "docuFgCode" ) ) ); // 결의 구분
			
			temp.put( "DT_CAUSE", item.get( "dtCause" ) ); // 원인행위일
			temp.put( "NM_PUMM", item.get( "note" ) ); // 품의 내역
			temp.put( "ST_CDOCU", "3" ); // - 진행상태 승인코드 : 3  
			temp.put( "ID_ACCEPT", ""); // - 전표 승인 사원 코드
			temp.put( "ST_STATE", item.get( "" ) ); // - 출납 상태
			temp.put( "CD_BUDGET", item.get( "erpBudgetSeq" ) ); // 예산단위 코드
			temp.put( "CD_BIZPLAN", item.get( "erpBizplanSeq" ) ); // 사업계획 코드
			temp.put( "CD_BGACCT", item.get( "erpBgacctSeq" ) ); // 예산계정 코드
			temp.put( "NM_NOTE",  budgetNote ); // 적요
			temp.put( "AM_TAXSTD", CommonConvert.NullToLong(item.get( "stdAmt" )) ); // 공급가액
			temp.put( "AM_ADDTAX", CommonConvert.NullToLong(item.get( "taxAmt" )) ); // 부가세
			temp.put( "AM_AMT", CommonConvert.NullToLong(item.get( "amt" )) ); // 공급대가
			temp.put( "DT_PAYPLAN", item.get( "dtPayPlan" ) ); // - 지출 / 수입 예정일
			temp.put( "DT_PAY", item.get( "" ) ); // - 지출 / 수입 일
			temp.put( "DT_REG", item.get( "" ) ); // - 등기일자
			temp.put( "DT_USER", item.get( "" ) ); // - 사용자설정일
			temp.put( "DT_START", item.get( "dtStart" ) ); // - 계약일
			temp.put( "DT_END", item.get( "dtEnd" ) ); // - 검수일
			temp.put( "ID_CAUSE", item.get( "idCause" ) ); // - 원인행위자
			temp.put( "CD_DEPOSIT", item.get( "btrSeq" ) ); // - 입출금계좌
			temp.put( "AM_ACTSUM", CommonConvert.NullToLong(item.get("erpOpenAmt")) ); // - 실행합
			temp.put( "AM_JSUM", "0" ); // - 예산잔액
			temp.put( "CD_DOCUPC", item.get( "" ) ); // - 전표처리회계단위
			temp.put( "NO_DOCU", item.get( "" ) ); // - 전표번호
			temp.put( "ST_DOCU", "" ); // - 전표상태 3 : 승인
			temp.put( "NM_REJECT", item.get( "" ) ); // - 반려사유
			temp.put( "NO_BDOCU", item.get( "" ) ); // - 반제전표
			temp.put( "NO_BDOLINE", "0" ); // - 반제전표라인
			temp.put( "TP_BDOCU", item.get( "" ) ); // - 원인전표여부(지출등록)
			temp.put( "ST_GWARE", "" ); // - 그룹웨어상태
			temp.put( "ID_INSERT", item.get( "" ) ); // - 최초입력일시
			temp.put( "DTS_INSERT", item.get( "" ) ); // - 최초입력사원
			temp.put( "ID_UPDATE", item.get( "" ) ); // - 수정일시
			temp.put( "DTS_UPDATE", item.get( "" ) ); // - 수정사원
			temp.put( "AM_EPNOTESUM", "0" ); // - 결의신청액
			temp.put( "AM_CAUSESUM", "0" ); // - 원인행위액
			temp.put( "AM_GMMSUM", "0" ); // - 결의금액
			temp.put( "AM_BGDAYSUM", "0" ); // - 승인금액
			temp.put( "NO_PAYORDER", item.get( "" ) ); // - 지급명령번호
			temp.put( "ID_EXAM", item.get( "" ) ); // - 
			temp.put( "ID_OBSER", item.get( "" ) ); // - 
			temp.put( "CD_ACCT", item.get( "erpFiacctSeq" ) ); // - 회계 계정 - 예산계정과 동일 
			temp.put( "NM_INPUT", item.get( "" ) ); // - 
			sendCauseData.add( temp );
			
			KeyContainer c = new KeyContainer( );
			c.noCDocu = makeKeyString(this.erpNoCDocu, resIdx);
			c.noCDoline = "" + ( dispIdx + 1 ) ;
			c.resDocSeq = item.get( "resDocSeq" ).toString( );
			c.resHeadSeq = item.get( "resSeq" ).toString( );
			c.resBudgetSeq = item.get( "budgetSeq" ).toString( );
			this.budgetKey.add( c );
		}
		return;
	}
	
	/**
	 * ERP전송 데이터 준비
	 * 헤더 정보와 예산정보를 가지고 있습니다.
	 * 대상 테이블 : FI_DOCUCAUSE.
	 */
	private void readySendGoodStateData ( ) {
		this.sendGoodStateData = new ArrayList<Map<String, Object>>( );
		String resBefore = "";
		String budgetBefore = "";
		int resIdx = -1;
		int dispIdx = 1;
		int noline = 0;
		
		for ( int i = 0; i < this.resItemSpec.size( ); i++ ) {
			Map<String, Object> item = this.resItemSpec.get( i );
			Map<String, Object> temp = new HashMap<>( );
			
			if ( !resBefore.equals( item.get( "resSeq" ).toString( ) ) ) {
				budgetBefore = item.get( "budgetSeq" ).toString( );
				resBefore = item.get( "resSeq" ).toString( );
				resIdx++;
				dispIdx=1;
			}	
			else if(!budgetBefore.equals( ( item.get("budgetSeq").toString()))) {
				budgetBefore = item.get( "budgetSeq" ).toString( );
				dispIdx++;
			}
			noline++;
			
			temp.put( "CD_COMPANY", item.get( "erpCompSeq" ) ); // 회사 코드
			temp.put( "CD_PC", CommonConvert.NullToString( resDoc.get(0).get("erpDivSeq") )); // 회계 단위
			temp.put( "NO_CDOCU", makeKeyString(this.erpNoCDocu, resIdx) ); // - 결의서번호
			temp.put( "NO_CDOLINE", "" + ( dispIdx ) ); // 문서 예산 키
			temp.put( "NO_LINE", "" + noline ); // 회사 코드
			temp.put( "NM_GOOD", item.get( "itemName" ) ); // 회사 코드
			temp.put( "NM_SIZE", item.get( "itemSize" ) ); // 회사 코드
			temp.put( "NM_UNIT", item.get( "itemUnit" ) ); // 회사 코드
			temp.put( "QT_GOOD", item.get( "itemCnt" ) ); // 회사 코드
			temp.put( "AM_PRC", item.get( "unitAmt" ) ); // 회사 코드
			temp.put( "AM_GOOD", item.get( "itemAmt" ) ); // 회사 코드
			temp.put( "NM_NOTE", item.get( "itemNote" ) ); // 회사 코드
			
			sendGoodStateData.add( temp );
			
		}
		return;
	}

	private String getSetFgCode (Object item){
		String returnStr = "";
		if(item == null){
			returnStr = "";
		}else{
			if(item.toString( ).length( ) == 1){
				return "00" + item.toString( );
			}else if (item.toString( ).length( ) == 2){
				return "0" + item.toString( );
			}else{
				return item.toString( );
			}
		}
		return returnStr;
	}
	
	/**
	 * ERP전송 데이터 준비
	 * 채주정보를 가지고 있습니다.
	 * 대상 테이블 : FI_DOCUCAUSEPAY.
	 * @throws Exception 
	 */
	private void readySendPayData ( ) throws Exception {
		this.sendPayData = new ArrayList<Map<String, Object>>( );
		
		String budgetBefore = "";
		String resBefore = "";
		String cdMnCode = "";
		
		int resIdx = -1;
		int budgetIdx = 0;
		int tradeIdx = 0;
		//int cdMng = Integer.valueOf(this.erpNoCdMng.substring(5));
		
		for ( int i = 0; i < this.resTrade.size( ); i++ ) {
			Map<String, Object> item = this.resTrade.get( i );
			Map<String, Object> temp = new HashMap<>( );
			
			if (item.get( "setFgCode" ) == null || item.get( "setFgCode" ) == "") {
				throw new Exception("결제수단이 입력되지 않았습니다");
			}
			
			if (item.get( "vatFgCode" ) == null || item.get( "vatFgCode" ) == "") {
				throw new Exception("과세구분이 입력되지 않았습니다");
			}
			
			if (item.get( "trFgCode" ) == null || item.get( "trFgCode" ) == "") {
				throw new Exception("채주유형이 입력되지 않았습니다");
			}
			
			if ( !resBefore.equals( item.get( "resSeq" ).toString( ) ) ) {
				resBefore = item.get( "resSeq" ).toString( );
				budgetBefore = item.get( "budgetSeq" ).toString( );
				resIdx++;
				budgetIdx = 1;
				tradeIdx = 1;
			}
			else if ( !budgetBefore.equals( item.get( "budgetSeq" ).toString( ) ) ) {
					budgetBefore = item.get( "budgetSeq" ).toString( );
					budgetIdx++;
					tradeIdx = 1;
			} 
			else {
				tradeIdx++;
				
			}
			
			if(CommonConvert.NullToString(item.get("etcBelongYearMonth")).length()>0) {
				//cdMng++;
				//cdMng_code = this.erpNoCdMng.substring(0,6) + cdMng;
				cdMnCode = this.erpNoCdMng + item.get("tradeSeq");
			}else {
				cdMnCode = "";
			}
			
			temp.put( "CD_COMPANY", item.get( "erpCompSeq" ) ); // - 회사코드
			temp.put( "CD_PC", item.get( "erpPcSeq" ) ); // - 회계단위
			temp.put( "NO_CDOCU", makeKeyString(this.erpNoCDocu, resIdx) ); // - 결의서번호
			temp.put( "NO_CDOLINE", "" + budgetIdx ); // - 결의서라인번호 
			temp.put( "NO_PAYLINE", "" + tradeIdx ); // - 결제정보라인번호
			temp.put( "TP_PAY", item.get( "setFgCode" ) ); // - 결제수단
			temp.put( "FG_TAX", item.get( "vatFgCode" ) ); // - 과세구분
			temp.put( "TP_CRE", item.get( "trFgCode" ) ); // - 채주유형
			temp.put( "AM_AMT", CommonConvert.NullToLong(item.get( "amt" )) ); // - 공급대가
			temp.put( "AM_TAXSTD", CommonConvert.NullToLong(item.get( "stdAmt" )) ); // - 공급가액
			temp.put( "AM_ADDTAX", CommonConvert.NullToLong(item.get( "vatAmt" )) ); // - 부가세
			temp.put( "AM_INCOMTAX", CommonConvert.NullToLong(item.get( "etcIncomeVatAmt" )) ); // - 소득세
			temp.put( "AM_RESIDTAX", CommonConvert.NullToLong(item.get( "etcResidentVatAmt" )) ); // - 주민세
			temp.put( "AM_ANNU", "0" ); // - 국민연금
			temp.put( "AM_INS", "0" ); // - 건강보험
			temp.put( "AM_EMPE", "0" ); // - 고용보험
			temp.put( "AM_OINS", "0" ); // - 장기요양보험
			temp.put( "AM_ETCTAX", "0" ); // - 기타세액
			temp.put( "CD_CODE", item.get( "trSeq" ) ); // - 채주코드
			temp.put( "NM_NAME", item.get( "trName" ) ); // - 채주명
			temp.put( "NM_CEO", item.get( "ceoName" ) ); // - 대표자
			temp.put( "CD_BANK", item.get( "btrSeq" ) ); // - 금융기관코드
			temp.put( "NM_BANK", item.get( "btrName" ) ); // - 금융기관명
			temp.put( "NO_DEPOSIT", item.get( "baNb" ) ); // - 계좌번호
			temp.put( "NM_DEPOSIT", item.get( "depositor" ) ); // - 예금주
			temp.put( "NM_NOTE", item.get( "note" ) ); // - 비고
			temp.put( "DT_TO", item.get( "taxDate" ) ); // - 신고기준일 / 과세 경우 필수 
			temp.put( "CD_MNG", cdMnCode ); // - 소득등록관리번호
			temp.put( "YM", item.get( "" ) ); // - 귀속년월
			temp.put( "ID_INSERT", item.get( "" ) ); // - 최초입력일시
			temp.put( "DTS_INSERT", item.get( "" ) ); // - 최초입력사원
			temp.put( "ID_UPDATE", item.get( "" ) ); // - 수정일시
			temp.put( "DTS_UPDATE", item.get( "" ) ); // - 수정사원
			temp.put( "NO_CARD", CommonConvert.NullToString(item.get( "cardNum" )).equals("")?item.get( "ctrSeq" ):item.get( "cardNum" ) ); // - ERP NO_CARD가 키여서 포멧 보정하지 않음. 
			temp.put( "NM_INPUT", item.get( "" ) ); // - 
			temp.put( "ST_MUTUAL", item.get( "noTaxCode" ) ); // 불공제 사유 구분 코드
			temp.put( "CD_DEPOSITNO", item.get( "depositno" ) ); // 계좌 코드
			
			
			/* 사업/기타 소득자용 전송 파라미터 생성 */
		
			if(item.get( "trFgCode" ).toString().equals("4")) {
				temp.put( "TAX_CD", "Z02" );
				temp.put( "DATA_CD", "G" );
				temp.put( "EXP_RT", CommonConvert.NullToDouble(item.get("etcRequiredRate").toString())/100 );
				temp.put( "EXP_AM", CommonConvert.NullToLong( item.get("etcRequiredAmt") ) );
				temp.put( "TAXRATE", "0.2" );
				temp.put( "INCOME_CD", item.get("etcIncomeSeq") );
			}else if(item.get( "trFgCode" ).toString().equals("9")) {
				temp.put( "TAX_CD", "Z01" );
				temp.put( "DATA_CD", "F" );
				temp.put( "EXP_RT", "0" );
				temp.put( "EXP_AM", "0" );
				temp.put( "INCOME_CD", " " );
				temp.put( "TAXRATE", "0.03" );
			}
			
			temp.put( "NO_DOCU", makeKeyString(this.erpNoCDocu, resIdx) + CommonConvert.NullToString(budgetIdx) ); // - 결의서라인번호
			temp.put( "NO_DOLINE", CommonConvert.NullToString(tradeIdx) ); // - 결의서라인번호
			temp.put( "YM", item.get( "etcBelongYearMonth" ) );
			temp.put( "SQ", "0" );
			temp.put( "BIZ_SEQ", item.get("etcBizSeq") );
			temp.put( "PAY_DT", item.get( "etcBelongDate" ) );
			temp.put( "BILL_DT", item.get( "etcBelongDate" ) );
			temp.put( "PAY_AM", CommonConvert.NullToLong(item.get( "amt" )) );
			temp.put( "INCOME_AM", CommonConvert.NullToLong(item.get( "etcIncomeAmt" ) ) );
			temp.put( "INCOME_TAX", CommonConvert.NullToLong(item.get( "etcIncomeVatAmt" )) );
			temp.put( "INHABIT_TAX", CommonConvert.NullToLong(item.get( "etcResidentVatAmt" )) );
			
			
			sendPayData.add( temp );
			
			KeyContainer c = new KeyContainer( );
			c.noCDocu = makeKeyString(this.erpNoCDocu, resIdx);
			c.noCdMng = cdMnCode;
			c.noCDoline = "" + budgetIdx;
			c.noPayLine = "" + tradeIdx;
			c.resDocSeq = item.get( "resDocSeq" ).toString( );
			c.resHeadSeq = item.get( "resSeq" ).toString( );
			c.resBudgetSeq = item.get( "budgetSeq" ).toString( );
			c.resTradeSeq = item.get( "tradeSeq" ).toString( );
			this.tradeKey.add( c );
		}
		return;
	}

	@SuppressWarnings("unused")
	private String getCardNum (Object o){
		String result = "";
		if(o == null){
			return "";
		}
		result = o.toString( ).replace( "-", "" );
		if(result.length( ) == 16){
			result = result.substring( 0,4 ) + "-" + result.substring( 4, 8 )   + "-" + result.substring( 8, 12 ) + "-" + result.substring( 12, 16 );
		}
		
		return result;
	}
	
	private String makeKeyString(String orgnKey, int val){
		String imperfactKey  = orgnKey.substring( 0, 10 );
		String idx = orgnKey.substring( 10 );
		int idx2 = Integer.parseInt( idx ) + val;
		return imperfactKey + String.format( "%05d", idx2 );
	}
	
	/**
	 * ERP 전송 키 반환
	 * 대상 테이블 : t_exnp_resbudget
	 * 
	 * @throws Exception
	 */
	public List<KeyContainer> getBudgetKeyList(){
		return this.budgetKey;
	}
	
	/**
	 * ERP 전송 키 반환
	 * 대상 테이블 : t_exnp_restrade
	 * 
	 * @throws Exception
	 */
	public List<KeyContainer> getTradeKeyList(){
		return this.tradeKey;
	}
	
	/**
	 * ERP 전송 데이터 반환
	 * 대상 테이블 : FI_DOCUCAUSE
	 * 
	 * @throws Exception
	 */
	public List<Map<String, Object>> getSendCauseData ( ) throws Exception {
		if ( this.sendCauseData == null ) {
			throw new Exception( "전송 데이터가 준비되지 않았습니다." );
		}
		return this.sendCauseData;
	}

	/**
	 * ERP 전송 데이터 반환
	 * 대상 테이블 : FI_DOCUCAUSEPAY
	 * 
	 * @throws Exception
	 */
	public List<Map<String, Object>> getSendPayData ( ) throws Exception {
		if ( this.sendPayData == null ) {
			throw new Exception( "전송 데이터가 준비되지 않았습니다." );
		}
		return this.sendPayData;
	}
	
	public List<Map<String, Object>> getSendItemSpecData ( ) throws Exception {
		if ( this.sendPayData == null ) {
			throw new Exception( "전송 데이터가 준비되지 않았습니다." );
		}
		return this.sendGoodStateData;
	}
	
	public class KeyContainer{
		public String noCDocu;
		public String noCDoline;
		public String noCdMng;
		public String noPayLine;
		public String resDocSeq;
		public String resHeadSeq;
		public String resBudgetSeq;
		public String resTradeSeq;
		
		public KeyContainer(){
			noCDocu = "";
			noCDoline = "";
			noCdMng = "";
			noPayLine = "";
			resDocSeq = "";
			resHeadSeq = "";
			resBudgetSeq = "";
			resTradeSeq = "";
		}
	}
}
