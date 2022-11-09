package common.procedure.npG20;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface BCommonProcService {

	public ResultVO getProcResult(Map<String, Object> params) throws Exception;
	
	public ResultVO getProcResult(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	/**
	 * iCUBE 거래처 등록 및 반환
	 * 1. FUNCTION명 : DBO.USP_C0MMON_GET_TR_CD_FOR_NOT_EXIST_INSERT
	 * 2. 매개변수 정보
	 *    1 : @LANGKIND / 언어종류 / NVARCHAR(3) / 필수 / KOR' 로 고정
	 *    2 : @CO_CD / 회사코드 / NVARCHAR(4) / 필수 / 연동할 ICUBE회사코드
	 *    3 : @TR_FG / 거래처구분 / NVARCHAR(1) / 필수 / "1.일반거래처, 2.수출거래처(사업자번호無), 3.주민(사업자번호無), 4.기타, 5.금융기관(일반보통예금계좌), 6.정기예금, 7.정기적금, 8.카드사(카드매출), 9.신용카드(카드매입)"
	 *    4 : @TR_NM / 거래처명 / NVARCHAR(60) / 필수
	 *    5 : @REG_NB / 사업자번호 / NVARCHAR(30) / 필수 / 특수문자제거한 정수 값
	 *    6 : @CEO_NM / 대표자명 / NVARCHAR(30)
	 *    7 : @BUSINESS / 업태 / NVARCHAR(40)
	 *    8 : @JONGMOK / 종목 / NVARCHAR(40)
	 *    9 : @TEL / 전화번호 / NVARCHAR(20)
	 *    10 : @ZIP / 우편번호 / NVARCHAR(7) /  / 특수문자제거한 정수 값
	 *    11 : @DIV_ADDR1 / 기본주소 / NVARCHAR(150)
	 *    12 : @ADDR2 / 주소상세 / NVARCHAR(150)
	 */
	public Map<String, Object> setProcTrade(Map<String, Object> params) throws Exception;
	
	/**
	 * iCUBE 거래처 단건 조회
	 * 1. FUNCTION명 : DBO.selectTradeInfo
	 * 2. 매개변수 정보
	 *    1 : @CO_CD / 회사코드 / NVARCHAR(4) / 필수 / 연동할 ICUBE회사코드
	 *    2 : @REG_NB / 사업자번호 / NVARCHAR(30) / 필수 / 특수문자제거한 정수 값
	 */
	public Map<String, Object> getProcTrade(Map<String, Object> params) throws Exception;
	/**
	 * 씨제이나눔재단 커스텀 지급거래처 단건 조회
	*/
	public Map<String, Object> getCustProcTrade(Map<String, Object> tradeParam) throws Exception;;

	
	/**
	 * 	사용메뉴 : G20 예실대비 현황 v2.0
	 * 	기능요약 : iCUBE G20 예산별 결의서 조회
	 */
	public ResultVO getERPResListInfoSet(Map<String, Object> params, ConnectionVO conVo) throws Exception;

}