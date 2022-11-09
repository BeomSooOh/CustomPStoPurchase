package expend.np.admin.report;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface BNpAdminReportService {

	/**
	 * 환원 처리 및 취소
	 */
	ResultVO updateConfferReturnYN ( Map<String, Object> params ) throws Exception;

	/**
	 * 품의현황 조회
	 */
	ResultVO selectConsReport ( Map<String, Object> params ) throws Exception;

	/**
	 * 관리자 - 품의서 현황 - 품의서 반환/취소
	 */
	ResultVO updateConfferStatus ( Map<String, Object> params ) throws Exception;

	/**
	 * 관리자 - 품의서 현황 - 품의예산 반환/취소
	 */
	ResultVO updateConfferBudgetStatus ( Map<String, Object> params ) throws Exception;

	/**
	 * 관리자 - 품의서 현황 - 참조결의서 리스트 조회
	 */
	ResultVO selectConsConfferResList ( Map<String, Object> params ) throws Exception;

	/**
	 * 관리자 - 품의서 현황 - 품의서 예산내역 조회
	 */
	ResultVO selectConsBudgetList ( Map<String, Object> params ) throws Exception;

	/**
	 * 결의현황 조회
	 */
	ResultVO selectResReport ( Map<String, Object> params ) throws Exception;

	/**
	 * 결의서 전송 리스트 조회
	 */
	ResultVO selectSendList ( Map<String, Object> params ) throws Exception;

	/**
	 * 결의서 삭제
	 */
	ResultVO NpAdminResDelete ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/**
	 * 결의서 전송
	 */
	ResultVO insertResSend ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/**
	 * 결의서 취소
	 */
	ResultVO deleteResSendCancel ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/**
	 * 관리자 - 카드사용현황
	 */
	List<Map<String, Object>> selectCardReport ( Map<String, Object> params );

	/**
	 * 관리자 - 카드사용 내역 미사용/사용처리
	 */
	ResultVO updateSendYN ( Map<String, Object> params ) throws Exception;

	/**
	 * 관리자 - 매입전자세금계산서 현황
	 */
	ResultVO NPAdminEtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception;

	/**
	 * 관리자 - 세금계산서현황 - 세금계산서 사용/미사용처리
	 */
	ResultVO NPAdminETaxSetUseYN ( ResultVO param ) throws Exception;

	/**
	 * 관리자 - 예실대비현황 - 예실대비 현황 리스트 조회
	 */
	ResultVO NPAdminYesilList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/**
	 * 관리자 - 예실대비현황 - 예실대비 현황 리스트 조회[엑셀다운로드용]
	 */
	ResultVO NPAdminYesilListExcel ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/**
	 * 관리자 - 예실대비현황 - 프로젝트 리스트 조회
	 */
	ResultVO NPAdminMgtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/**
	 * 관리자 - 예실대비 현황 - 예산별 품의서 조회
	 */
	ResultVO NPAdminConsAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/**
	 * 관리자 - 예실대비 현황 - 예산별 결의서 조회
	 */
	ResultVO NPAdminResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/**
	 * 관리자 - 예실대비 현황 - 전송 결의서 리스트 조회
	 */
	ResultVO NPAdminERPResAmtList ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;

	/**
	 * 관리자 - 품의서 반환 - 품의서 삭제
	 */
	ResultVO deleteConsDoc(Map<String, Object> params) throws Exception;
}