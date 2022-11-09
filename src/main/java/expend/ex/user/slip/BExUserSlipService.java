package expend.ex.user.slip;

import java.util.List;
import java.util.Map;

import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExAttachVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExExpendVO;

public interface BExUserSlipService {

	/* Pop */
	/* Pop - ExExpendSlipPop 반환값 처리 */
	Map<String, Object> ExUserSlipPopReturn(Map<String, Object> params) throws Exception;
	
	
	/* 지출결의 - 지출결의 항목 분개 생성 */
	ExExpendSlipVO ExSlipInfoInsert(ExExpendSlipVO slipVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 수정 */
	ExCommonResultVO ExSlipInfoUpdate(ExExpendSlipVO slipVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 삭제 */
	ExCommonResultVO ExSlipInfoDelete(ExExpendSlipVO slipVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 목록 삭제 */
	ExCommonResultVO ExSlipListInfoDelete(List<ExExpendSlipVO> slipListVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 하위 내역 모두 삭제 */
	ExCommonResultVO ExSlipDInfoDelete(ExExpendSlipVO slipVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 복사 */
	ExCommonResultVO ExSlipInfoCopy(LoginVO loginVo, List<ExExpendSlipVO> slipListVo, ConnectionVO conVo, String targetListSeq) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 조회 */
	ExExpendSlipVO ExSlipInfoSelect(ExExpendSlipVO slipVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 목록 조회 */
	List<ExExpendSlipVO> ExSlipListInfoSelect(ExExpendSlipVO slipVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 목록 조회 */
	List<Map<String, Object>> ExSlipGridInfoSelect(ExExpendSlipVO slipVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 생성 처리 */
	ExCommonResultVO ExSlipInfoSingleMake(LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 처리 */
	ExCommonResultVO ExSlipInfoMake(LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo) throws Exception;

	/* 예산 */
	/* 예산 - 지출결의 임시예산 등록 연동 */
	ExCommonResultVO ExSlipBudgetInfoUpdate(ExExpendSlipVO slipVo) throws Exception;

	/* 인터페이스 */
	/* 인터페이스 - 법인카드 사용내역 조회 */
	List<ExExpendSlipVO> ExInterfaceCardListInfoSelect(ExExpendVO expendVo) throws Exception;

	/* 인터페이스 - 매입전자세금계산서 사용내역 조회 */
	List<ExExpendSlipVO> ExInterfaceETaxListInfoSelect(ExExpendVO expendVo) throws Exception;

	/* 지출결의 분개 첨부파일 확인*/
	List<ExAttachVO> ExSlipAttachInfoSelect(Map<String,Object>params) throws Exception;
	
	/* 지출결의 - 지출결의 항목 분개 생성 처리(결재 진행중) */
	ExCommonResultVO ExSlipInfoSingleMakeApproval ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception;
	
	/* 지출결의 - 지출결의 분개단위 입력 시 항목 금액 수정 */
	ExCommonResultVO ExListAmtInfoUpdate(ExExpendSlipVO slipVo, boolean isAdd, boolean isCopy ) throws Exception;
	
	/* 지출결의 분개 목록 조회(해당 지출결의의 분개) */
	List<ExExpendSlipVO> ExExpendSlipListSelect ( Map<String, Object> param);
	
	/* 지출결의 종결문서 수정 시 카드/매입전자세금계산서 사용 내역 전송 여부 수정 */
	ResultVO ExInterfaceInfoUpdate ( ExExpendListVO listVo ) throws Exception;
	
	/* 지출결의 - 지출결의 가져오기 항목 분개 진행 */
	ResultVO ExExpendHistorySlipReflect ( LoginVO loginVo, ExExpendSlipVO tSlipVo, ConnectionVO conVo, String targetListSeq, String newExpendSeq ) throws Exception;
	
	/* 지출결의 - 해당 지출결의 분개 첨부파일 조회 */
	List<Map<String, Object>> ExExpendSlipAttachListInfoSelect ( Map<String, Object> param ) throws Exception;
}
