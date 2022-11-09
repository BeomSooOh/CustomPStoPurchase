package expend.ex.user.list;

import java.util.List;
import java.util.Map;

import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExAttachVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;

public interface BExUserListService {

	/* Pop */
	/* Pop - ExExpendListPop 반환값 처리 */
	Map<String, Object> ExUserListPopReturn(Map<String, Object> params) throws Exception;
	
	/* 지출결의 - 지출결의 항목 조회 */
	ExExpendListVO ExUserListInfoSelect(ExExpendListVO listVo) throws Exception;
	
	/* 지출결의 - 지출결의 항목 목록 조회 */
	List<Map<String, Object>> ExListGridInfoSelect(ExExpendListVO listVo) throws Exception;
	
	/* 지출결의 - 지출결의 항목 처리 */
	ExCommonResultVO ExListInfoMake(LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo) throws Exception;

	/* 지출결의 - 지출결의 항목 분개 처리 수정 */
	ExCommonResultVO ExListInfoMakeUpdate(LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo) throws Exception;
	
	/* 지출결의 - 지출결의 항목 생성 */
	ExExpendListVO ExListInfoInsert(ExExpendListVO listVo) throws Exception;

	/* 지출결의 - 지출결의 항목 수정 */
	ExCommonResultVO ExListInfoUpdate(ExExpendListVO listVo) throws Exception;

	/* 지출결의 - 지출결의 항목 삭제 */
	ExCommonResultVO ExListInfoDelete(ExExpendListVO listVo) throws Exception;
	
	/* 지출결의 - 지출결의 항목 복사 */
	ExCommonResultVO ExListInfoCopy(LoginVO loginVo, List<ExExpendListVO> listListVo, ConnectionVO conVo) throws Exception;

	/* 지출결의 - 지출결의 항목 목록 삭제 */
	ExCommonResultVO ExListListInfoDelete(List<ExExpendListVO> listListVo) throws Exception;
	
	/* 지출결의 - 지출결의 항목 첨부파일 정보 조회  */
	List<ExAttachVO> ExListAttachInfoSelect(Map<String,Object>params) throws Exception;
	
	/* 지출결의 - 지출결의 항목 처리 수정( 결재 진행중 ) */
	ExCommonResultVO ExListInfoMakeUpdateApproval(LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo) throws Exception;
	
	/* 지출결의 - 지출결의 분개단위 입력 시 항목 금액 수정 */
	ExCommonResultVO ExListAmtEdit(Map<String, Object> param) throws Exception;
	
	/* 지출결의 - 지출결의 항목 금액 정보 조회 */
	Map<String, Object> ExListAmtSelect(ExExpendListVO listVo) throws Exception;
	
	/* 지출결의 - 지출결의 가져오기 반영 */
	ResultVO ExExpendHistoryReflect ( LoginVO loginVo, ExExpendListVO listVo, ConnectionVO conVo, String newExpendSeq ) throws Exception;
	
	/* 지출결의 - 지출결의 가져오기(분개단위 입력) */
	ResultVO ExExpendHistoryReflectSlipMode ( LoginVO loginVo, ExExpendListVO listVo, ConnectionVO conVo, String newExpendSeq, ExExpendListVO basicList ) throws Exception;
	
	/* 지출결의 - 지출결의 항목 리스트 조회 */
	List<ExExpendListVO> ExExpendListSelect ( Map<String, Object> param);
	
	/* 지출결의 - 지출결의 항목 첨부파일 삭제 */
	ResultVO ExExpendListAttachDelete ( ResultVO param);
	
	/* 지출결의 - 해당 지출결의 예산정보 조회 */
	ResultVO ExExpendHistoryBudgetInfoSelect ( ResultVO param);
	
	/* 지출결의 - 해당 지출결의 항목 첨부파일 조회 */
	List<Map<String, Object>> ExExpendListAttachListInfoSelect ( Map<String, Object> param );
	
	/* 지출결의 종결문서 수정 시 카드/매입전자세금계산서 사용 내역 전송 여부 수정 */
	ResultVO ExInterfaceInfoUpdate ( ExExpendListVO listVo ) throws Exception;
	
	/* 외화입력 - 환율정보 조회 */
	ResultVO ExchangeRateInfoSelect ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception;
	
	/* 외화입력 - 올림구분 조회 */
	ResultVO RoundingTypeInfoSelect ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception;
	
	/* 외화입력 - 외화계정인지 확인 */
	ResultVO CheckForeignCurrencyAcctCode ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception;
	
	/* 외화입력 - iCUBE 환율, 외화금액 소수점 자릿수 조회(iCUBE 시스템 환경설정) */
	ResultVO PointLengthInfoSelect ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception;
}
