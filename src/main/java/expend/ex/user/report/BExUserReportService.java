package expend.ex.user.report;

import java.util.List;
import java.util.Map;

import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


public interface BExUserReportService {

	/* Biz - 회계 ( 사용자 ) */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 - 목록 조회 */
	ResultVO ExUserExpendReportListInfoSelect ( Map<String, Object> params ) throws Exception;
	
	/* Biz - 회계 ( 사용자 ) */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 상세 현황 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 상세 현황 - 목록 조회 */
	ResultVO ExUserExpendSlipReportListInfoSelect (Map<String, Object> params) throws Exception;
	
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 - 목록 조회 - 푸딩 버전*/
	ResultVO ExUserExpendReportListInfoNewSelect ( Map<String, Object> params ) throws Exception;
	
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 카드 사용 현황 */
	/* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 나드 사용 현황 - 목록 조회 */
	ResultVO ExUserCardReportListInfoSelect ( ExReportCardVO reportCardVO, PaginationInfo paginationInfo ) throws Exception;
	
	/* 인터락 생성으 위한 지출결의 정보 가져오기 -- header*/
	Map<String,Object>ExReportHeaderInterLockInfoSelect  ( Map<String, Object> params ) throws Exception;
	
	/* 인터락 생성으 위한 지출결의 정보 가져오기 -- contents*/
	List<Map<String,Object>>ExReportContentsInterLockInfoSelect  ( Map<String, Object> params ) throws Exception;
	
	/* 인터락 생성으 위한 지출결의 정보 가져오기 -- footer*/
	Map<String,Object>ExReportFooterInterLockInfoSelect  ( Map<String, Object> params ) throws Exception;
	
	/* 인터락 생성을 위한 소계 정보 가져오기 -- subtotal*/
	List<Map<String,Object>> ExReportSubtotalInterLockInfoSelect  ( Map<String, Object> params ) throws Exception;
	
	/* 세금계산서 현황 / 카드사용현황 외부시스템 이관처리 진행 */
	ResultVO ExUserInterfaceTransfer ( Map<String, Object> param ) throws Exception;

	/* 세금계산서 현황 / 카드사용현황 외부시스템 이관취소 진행 */
	ResultVO ExUserInterfaceTransferCancel ( Map<String, Object> param ) throws Exception;
	
	/* 세금계산서 현황 이관 내역 조회 */
	List<Map<String, Object>> ExUserETaxTransferHistory ( Map<String, Object> param ) throws Exception;
}