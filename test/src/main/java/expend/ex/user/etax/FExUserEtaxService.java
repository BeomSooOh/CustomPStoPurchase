package expend.ex.user.etax;

import java.util.List;
import java.util.Map;

import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.interlock.InterlockExpendVO;


public interface FExUserEtaxService {

	/* 매입전자세금계산서 */
	/* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
	List<ExCodeETaxVO> ExETaxListInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception;

	/* 매입전자세금계산서 - 매입전자세금계산서 조회 */
	ExCodeETaxVO ExETaxDetailInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception;

	/* 매입전자세금계산서 - 매입전자세금계산서 연동 코드 저장 */
	ResultVO ExExpendETaxInfoMapUpdate ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception;

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 지출결의 항목 분개 처리 */
	ExCommonResultVO ExETaxInfoMake ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception;

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 상태값 수정 */
	ResultVO ExExpendETaxInfoUpdate ( ExCodeETaxVO etaxVo ) throws Exception;

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 목록 상태값 수정 */
	InterlockExpendVO ExUserETaxStateListInfoUpdate ( Map<String, Object> params ) throws Exception;

	/* 매입전자세금계산서 - 세금계산서 현황 리스트 조회 */
	List<Map<String, Object>> ExUserTtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception;

	/* 매입전자세금계산서 - 세금계산서 상세 정보 조회 */
	Map<String, Object> ExExpendEtaxGWInfoSelect ( Map<String, Object> param );

	/* 매입전자세금계산서 - 세금계산서 현황 리스트 조회 */
	List<Map<String, Object>> ExUserETaxExpendInfoSelect ( Map<String, Object> param ) throws Exception;
}
