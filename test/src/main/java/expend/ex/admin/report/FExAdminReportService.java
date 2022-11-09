package expend.ex.admin.report;

import java.util.List;
import java.util.Map;
import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;
import common.vo.ex.ExSendStatVO;

public interface FExAdminReportService {

    /* Common */
    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 현황 */
    /* Bizbox Alpha - 지출결의 현황 - 목록 조회 */
    List<Map<String, Object>> ExAdminExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception;

    /* Common */
    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 상세 현황 */
    /* Bizbox Alpha - 지출결의 상세 현황 - 목록 조회 이준성 */
    Map<String, Object> ExAdminSlipExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception;

    /* Common */
    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 상세 현황 엑셀 다운로드 */
    /* Bizbox Alpha - 지출결의 상세 현황 엑셀 다운로드 - 목록 조회 이준성 */
    List<Map<String, Object>> ExSlipAdminExpendManagerReportListInfoSelectExceDown(Map<String, Object> params) throws Exception;

    /* Common */
    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 확인 */
    /* Bizbox Alpha - 지출결의 확인 - 목록 조회 */
    List<Map<String, Object>> ExAdminExpendCheckReportListInfoSelect(Map<String, Object> params) throws Exception;

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 확인 */
    /* Bizbox Alpha - 지출결의 확인 - 엑셀 상세다운로드 데이터 조회 */
    List<Map<String, Object>> ExAdminExpendCheckReportListInfoSelect2(Map<String, Object> params) throws Exception;

    /* Bizbox Alpha - 카드 사용 현황 */
    /* Bizbox Alpha - 카드 사용 현황 - 목록 조회 */
    List<Map<String, Object>> ExAdminCardReportListInfoSelect(ExReportCardVO reportCardVO) throws Exception;

    /* Bizbox Alpha - 카드 사용 현황 */
    /* Bizbox Alpha - 카드 사용 현황 - 엑셀데이터 조회 */
    List<Map<String, Object>> ExAdminCardReportListInfoSelectForExcel(Map<String, Object> params) throws Exception;

    /* 그룹웨어 지출결의 더미데이터 조회 - iCUBE포멧 */
    ResultVO ExReportExpendDummyListInfoSelect(Map<String, Object> param) throws Exception;

    /* 그룹웨어 지출결의 더미데이터 조회 - iU포멧 */
    ResultVO ExReportExpendDummyListInfoSelectU(Map<String, Object> param) throws Exception;

    /* 지출결의 ERP 전송 */
    ResultVO ExReportExpendSendListInfoSend(List<Map<String, Object>> data, ConnectionVO conVo, LoginVO loginVo) throws Exception;

    /* 지출결의 ERP 전송 취소 */
    ResultVO ExReportExpendSendListInfoReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception;
    
    /* 지출결의 ERP 전송 취소 - 준성  */
    ResultVO ExReportExpendSendListInfoChekedReturn(Map<String, Object> param, ConnectionVO conVo ) throws Exception;

    /* 지출결의 ERP 전송 취소(항목단위) */
    ResultVO ExReportExpendSendListInfoAllReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception;
    
    /* 지출결의 ERP 전송 취소(항목단위) - 준성  */
    ResultVO ExReportExpendSendListInfoAllReturn2(Map<String, Object> param, ConnectionVO conVo) throws Exception;

    /* 지출결의 삭제 */
    ResultVO ExAdminExpendInfoDelete(ResultVO param) throws Exception;

    /* ERP 전송한 전표 삭제 */
    ResultVO ExAdminExpendSendERPDataDelete(ResultVO param, ConnectionVO conVo) throws Exception;

    /* ERP 임시 예산삭제 */
    ResultVO ExAdminExpendERPBudgetDelete(ResultVO param, ConnectionVO conVo) throws Exception;

    /* 외부연동(법인카드, 매입전자세금계산서) 미사용 처리 */
    ResultVO ExAdminExpendOtherSystemRollback(ResultVO param, ConnectionVO conVo) throws Exception;

    /* 전자결재 문서 삭제 */
    ResultVO ExAdminAppdocDelete(ResultVO param) throws Exception;

    /* 매입전자세금계산서 ERP 연동 정보 초기화(iCUBE) */
    ResultVO ExAdminExpendOtherSystemERPInfoReollback(ResultVO param, ConnectionVO conVo) throws Exception;

    /* 지출결의 ERP 전송(항목 별 전송) */
    ResultVO ExReportExpendSendListInfoSendByList(List<Map<String, Object>> data, ConnectionVO conVo, LoginVO loginVo) throws Exception;

    /* 지출결의 - 매입전자세금계산서 리스트 조회 */
    List<Map<String, Object>> ExAdminEtaxReportList(ResultVO param, ConnectionVO conVo) throws Exception;

    /* 지출결의 - iCUBE 연동문서 현황 리스트 조회 */
    ResultVO ExAdminiCUBEDocList(ResultVO param, ConnectionVO conVo) throws Exception;

    /* 지출결의 - iCUBE 연동문서 현황 문서 삭제 */
    ResultVO ExAdminiCUBEDocListDelete(ResultVO param, ConnectionVO conVo) throws Exception;

    /* 항목단위 입력인 경우 전송 이력 조회 */
    List<Map<String, Object>> ExAdminExpendReportListHistorySelect(Map<String, Object> params);

    /* 매입전자세금계산서 - 해당 세금계산서의 사업장 정보 조회 (ERPiU 전용) */
    ResultVO ExAdminETaxBizInfoSelect(ResultVO param, ConnectionVO conVo) throws Exception;

    /* 지출결의 - 세금계산서현황 - 세금계산서 사용/미사용처리 */
    ResultVO ExAdminETaxSetUseYN(ResultVO param) throws Exception;

    /* 지출결의 - 카드사용현황 - 카드사용내역 사용/미사용처리 */
    ResultVO ExAdminCardSetUseYN(ResultVO param) throws Exception;

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 ( 항목 기준 ) */
    List<Map<String, Object>> ExAdminSendAttachSelectList(Map<String, Object> param) throws Exception;

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 ( 문서 기준 ) */
    List<Map<String, Object>> ExAdminSendAttachAllSelectList(Map<String, Object> param) throws Exception;

    /* 지출결의 - ERP 자동전송 - 전자결재 회계API 연동 시에는 로그인세션이 따로 없기 때문에 로그인세션정보를 별도로 구해준다. */
    LoginVO ExGetLoginSessionForApprovalProcess(Map<String, Object> param) throws Exception;

    /* 지출결의 - ERP 전송 - 전송 상태 점검 */
    ExSendStatVO ExGetSendState(ExSendStatVO p) throws Exception;

    /* 지출결의 - ERP 전송 - 전송 상태 업데이트 */
    ExSendStatVO ExSetSendState(ExSendStatVO p) throws Exception;

    /* 지출결의 - ERP 전송 - 전송 상태복원 */
    ExSendStatVO ExSetSendStateRollback(ExSendStatVO p) throws Exception;
}
