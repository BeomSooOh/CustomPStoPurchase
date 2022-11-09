package expend.ex.user.mng;

import java.util.List;
import java.util.Map;

import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ExExpendVO;


public interface BExUserMngService {

	/* Pop */
	/* Pop - ExExpendMngPop 반환값 처리 */
	Map<String, Object> ExUserMngPopReturn ( Map<String, Object> params ) throws Exception;

	/* 지출결의 */
	/* 지출결의 - 지출결의 항목 분개 관리항목 생성 */
	ExExpendMngVO ExMngInfoInsert ( ExExpendMngVO mngVo ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 수정 */
	ExCommonResultVO ExMngInfoUpdate ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 조회 */
	ExExpendMngVO ExMngInfoSelect ( ExExpendMngVO mngVo ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 목록 조회 */
	List<ExExpendMngVO> ExMngListInfoSelect ( ExExpendMngVO mngVo ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 삭제 */
	ExCommonResultVO ExMngInfoDelete ( ExExpendMngVO mngVo ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 하위 내역 모두 삭제 */
	ExCommonResultVO ExMngDInfoDelete ( ExExpendMngVO mngVo ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 목록 조회 */
	List<Map<String, Object>> ExMngGridInfoSelect ( ExExpendMngVO mngVo ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 복사 */
	ExCommonResultVO ExMngInfoCopy ( ExExpendMngVO mngVo, String targetListSeq, String targetSlipSeq ) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 관리항목 분개 처리 */
	ExCommonResultVO ExMngInfoMake ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception;

	/* 공통코드 */
	/* 공통코드 - 지출결의 항목 분개 관리항목 목록 조회 */
	List<ExExpendMngVO> ExCodeMngListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception;

	/* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 */
	List<ExExpendMngVO> ExCodeMngDListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception;

	/* 지출결의 - 오류체크 - 관리항목 */
	List<ExCommonResultVO> ExMngErrorInfoSelect ( ExExpendVO expendVo ) throws Exception;

	/* 지출결의 - 지출결의 가져오기 관리항목 진행 */
	ResultVO ExExpendHistoryMngReflect ( ExExpendMngVO mngVo, String targetListSeq, String targetSlipSeq, String newExpendSeq ) throws Exception;

	/* 지출결의 - 분개추가 - 분개 필수 입력 옵션 조회 */
	ResultVO ExExpendMngNecessaryOptionInfoSelect ( Map<String, Object> param ) throws Exception;
}
