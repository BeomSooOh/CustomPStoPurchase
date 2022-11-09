package expend.ex.admin.report;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;


public interface BExAdminReportService {

	/* Biz - 회계(관리자) */
	/* Biz - 회계(관리자) - 지출결의 관리 */
	/* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 현황 */
	/* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 현황 - 목록 조회 */
	ResultVO ExAdminExpendManagerReportListInfoSelect ( @RequestParam Map<String, Object> params ) throws Exception;

	/* Biz - 회계(관리자) */
	/* Biz - 회계(관리자) - 지출결의 관리 */
	/* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 */
	/* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 - 목록 조회 */
	ResultVO ExAdminExpendCheckReportListInfoSelect ( @RequestParam Map<String, Object> params ) throws Exception;

	/* Biz - 회계(관리자) */
	/* Biz - 회계(관리자) - 지출결의 관리 */
	/* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 */
	/* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 - 엑셀다운로드 데이터 조회 */
	ResultVO ExAdminExpendCheckReportListInfoSelect2( @RequestParam Map<String, Object> params ) throws Exception;
	
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 카드 사용 현황 */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나드 사용 현황 - 목록 조회 */
	ResultVO ExAdminCardReportListInfoSelect ( ExReportCardVO reportCardVO ) throws Exception;

	/* 지출결의 - ERP 전송 */
	ResultVO ExReportExpendSendListInfoSend ( Map<String, Object> param ) throws Exception;

	/* 지출결의 - ERP 전송 취소 */
	ResultVO ExReportExpendSendListInfoReturn ( Map<String, Object> param ) throws Exception;

	/* Biz - 회계 ( 관리자 ) - 지출결의 현황 - 지출결의 삭제 */
	ResultVO ExAdminExpendInfoDelete ( Map<String, Object> params ) throws Exception;
	
	/*지출결의 - 회계(관리자) - 지출결의 상세현황 리스트 조회 이준성 */
	ResultVO ExSlipAdminExpendManagerReportListInfoSelect  ( Map<String, Object> params ) throws Exception;
	/*지출결의 - 회계(관리자) - 지출결의 상세현황 엑셀 다운로드 조회 이준성 */
	ResultVO ExSlipAdminExpendManagerReportListInfoSelectExceDown(Map<String, Object> params) throws Exception;
	
	/* 지출결의 - 매입전자세금계산서 리스트 조회 */
	ResultVO ExAdminEtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception;

	/* 지출결의 - iCUBE 연동문서 현황 리스트 조회 */
	ResultVO ExAdminiCUBEDocList ( ResultVO param, ConnectionVO conVo ) throws Exception;

	/* 지출결의 - iCUBE 연동문서 현황 문서 삭제 */
	ResultVO ExAdminiCUBEDocListDelete ( ResultVO param, ConnectionVO conVo ) throws Exception;
	
	/* 지출결의 - 세금계산서현황 - 세금계산서 사용/미사용처리 */
	ResultVO ExAdminETaxSetUseYN ( ResultVO param ) throws Exception;
	
	/* 지출결의 - 카드사용현황 - 카드사용내역 사용/미사용처리 */
	ResultVO ExAdminCardSetUseYN ( ResultVO param ) throws Exception;
	
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 카드 사용 현황 */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 카드 사용 현황 - 엑셀 다운로드 */
	ResultVO ExAdminCardReportListInfoSelectForExcel ( Map<String, Object> params ) throws Exception;

}