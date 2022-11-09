package expend.ex.user.card;

import java.util.List;
import java.util.Map;

import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCommonResultVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


public interface BExUserCardService {

	/* 지출결의 - 카드 상신 목록 조회 ( 사용자 ) */
	List<Map<String, Object>> ExExpendEmpCardListInfoSelect ( Map<String, Object> params ) throws Exception;

	/* 지출결의 - 카드 사용내역 상태값 수정 */
	ExCommonResultVO ExExpendCardSubInfoUpdate ( ExCodeCardVO cardVo ) throws Exception;

	/* 지출결의 - 카드 사용내역 지출결의 항목 분개 처리 */
	ExCommonResultVO ExCardInfoMake ( Map<String, Object> params, ConnectionVO conVo, LoginVO loginVo ) throws Exception;

	/* 지출결의 - 카드 사용내역 지출결의 정보 맵핑 */
	ExCommonResultVO ExExpendCardInfoMapUpdate ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception;

	/* 지출결의 - 카드 사용내역 상세 */
	ExCodeCardVO ExReportCardDetailInfoSelect ( ExCodeCardVO cardVo ) throws Exception;
	
	/* 지출결의 - 카드 사용내역 상세_취소분 포함 */
	ExCodeCardVO ExReportCardDetailInfoWithCancelInfoSelect ( ExCodeCardVO cardVo ) throws Exception;
	
	/* 지출결의 - 카드 사용내역 상세 */
	Map<String, Object> ExExpendCardDetailInfoSelect ( ResultVO params, ConnectionVO conVo ) throws Exception;
	
	/* 지출결의 - 카드 사용내역 지출결의 정보 초기화 */
	ExCommonResultVO ExExpendCardInfoMapReset ( Map<String, Object> param ) throws Exception;
	
	/* 지출결의 - 카드사용내역 - 카드정보 조회 */
	ResultVO ExExpendUserCardInfoSelect ( Map<String, Object> param, PaginationInfo paginationInfo ) throws Exception;
}