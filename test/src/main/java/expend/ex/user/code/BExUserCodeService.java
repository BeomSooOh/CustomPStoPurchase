package expend.ex.user.code;

import java.util.List;
import java.util.Map;
import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAcctVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardPublicVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ERPiU.ERPiUAccSeq;


public interface BExUserCodeService {
    /* Biz - 공통코드 */

    /* Biz - 공통코드 - 공통코드 조회 */
    ResultVO ExCommonCodeInfoSelect(Map<String, Object> params) throws Exception;

    /* Biz - 공통코드 - 사용자 */
    /* Biz - 공통코드 - 사용자 - 목록 조회 */
    ResultVO ExUserEmpListInfoSelect(Map<String, Object> params) throws Exception;

    /* Biz - 공통코드 - 계정과목 */
    /* Biz - 공통코드 - 계정과목 등록 */
    ExCodeAcctVO ExCodeAcctInfoInsert(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 계정과목 수정 */
    ExCommonResultVO ExCodeAcctInfoUpdate(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 계정과목 삭제 */
    ExCommonResultVO ExCodeAcctInfoDelete(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 증빙유형 */
    /* Biz - 공통코드 - 지출결의 - 증빙유형 등록 */
    ExCodeAuthVO ExExpendAuthInfoInsert(ExCodeAuthVO authVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 증빙유형 수정 */
    ExCommonResultVO ExExpendAuthInfoUpdate(ExCodeAuthVO authVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 증빙유형 조회 */
    ExCodeAuthVO ExExpendAuthInfoSelect(ExCodeAuthVO authVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 증빙유형 삭제 */
    ExCommonResultVO ExExpendAuthInfoDelete(ExCodeAuthVO authVo) throws Exception;

    /* Biz - 공통코드 - 증빙유형 등록 */
    ExCodeAuthVO ExCodeAuthInfoInsert(ExCodeAuthVO authVo) throws Exception;

    /* Biz - 공통코드 - 증빙유형 수정 */
    ExCommonResultVO ExCodeAuthInfoUpdate(ExCodeAuthVO authVo) throws Exception;

    /* Biz - 공통코드 - 증빙유형 삭제 */
    ExCommonResultVO ExCodeAuthInfoDelete(ExCodeAuthVO authVo) throws Exception;

    /* Biz - 공통코드 - 예산정보 */
    /* Biz - 공통코드 - 지출결의 - 예산정보 등록 */
    ExCodeBudgetVO ExExpendBudgetInfoInsert(ExCodeBudgetVO budgetVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 예산정보 조회 */
    ExCodeBudgetVO ExExpendBudgetInfoSelect(ExCodeBudgetVO budgetVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 임시예산정보 등록 */
    ExCommonResultVO ExExpendGmmsumOtherInfoInsert(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 임시예산정보 삭제 */
    ExCommonResultVO ExExpendGmmsumOtherInfoDelete(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 예산정보 확인 */
    ExCodeBudgetVO ExCodeBudgetAmtInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 예산 통제구분 조회 */
    ExCodeBudgetVO ExCodeBudgetTypeInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 */
    /* Biz - 공통코드 - 지출결의 - 카드정보 등록 */
    ExCodeCardVO ExExpendCardInfoInsert(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 카드정보 수정 */
    ExCommonResultVO ExExpendCardInfoUpdate(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 카드정보 조회 */
    ExCodeCardVO ExExpendCardInfoSelect(ExCodeCardVO cardVo) throws Exception;
    
    /* Biz - 공통코드 - 지출결의 - 카드정보 조회(iCUBE 일때만 해당) - iCUBE에 존재하는 카드이지만 그룹웨어에는 없을때 카드정보에 있는 거래처정보를 가져오기 위해 조회 */
    ExCodeCardVO ExExpendCardInfoSelectWithPartner(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 지출결의 - 카드정보 삭제 */
    ExCommonResultVO ExExpendCardInfoDelete(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 등록 */
    ExCodeCardVO ExCodeCardInfoInsert(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 등록 update */
    ExCodeCardVO fnExpendCardInsert_Update(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 수정 */
    ExCommonResultVO ExCodeCardInfoUpdate(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 삭제 */
    ExCommonResultVO ExCodeCardInfoDelete(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 ERP 가져오기 */
    ExCommonResultVO ExCodeCardInfoFromErpCopy(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 공개범위 등록 */
    ExCommonResultVO ExCodeCardPublicListInfoInsert(List<ExCodeCardPublicVO> publicListVo) throws Exception;

    /* Biz - 공통코드 - 카드정보 공개범위 삭제 */
    ExCommonResultVO ExCodeCardPublicListInfoDelete(ExCodeCardVO cardVo) throws Exception;

    /* Biz - 공통코드 */
    /* Biz - 공통코드 - 회사 목록 조회 */
    List<ExCommonResultVO> ExCodeCommonCompListInfoSelect(ExCommonResultVO commonParam) throws Exception;

    /* Biz - 공통코드 - 양식 목록 조회 */
    List<ExCommonResultVO> ExCodeCommonFormListInfoSelect(ExCommonResultVO commonParam) throws Exception;

    /* Biz - 공통코드 - 공통코드 목록 조회 */
    List<ExCommonResultVO> ExCodeCommonCodeListInfoSelect(ExCommonResultVO commonParam) throws Exception;

    /* Biz - 공통코드 - 양식 상세 조회 */
    Map<String, Object> ExCodeCommonFormDetailInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 양식정보 조회 */
    List<Map<String, Object>> ExFormListInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception;

    /* 공통사용 - ERP 회사코드 확인 */
    String getErpCompSeq(LoginVO loginVo, String system, String compSeq) throws Exception;

    /* Biz - 공통코드 - BizboxA - ERP 회사코드, 사업장코드, 부서코드, 사원코드 조회 */
    String getErpCodeInfoSelect(String compSeq, String bizSeq, String deptSeq, String empSeq, String searchType) throws Exception;

    /* Biz - 공통코드 - 관리항목 */
    /* Biz - 지출결의 - 관리항목 전체 목록 조회 */
    List<ExCodeMngVO> ExExpendMngListInfoSelect(ExCodeMngVO mngVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 사용자 */
    /* Biz - 지출결의 - 사용자 등록 */
    ExCodeOrgVO ExExpendEmpInfoInsert(ExCodeOrgVO orgVo) throws Exception;

    /* Biz - 지출결의 - 사용자 수정 */
    ExCommonResultVO ExExpendEmpInfoUpdate(ExCodeOrgVO orgVo) throws Exception;

    /* Biz - 지출결의 - 사용자 조회 */
    ExCodeOrgVO ExExpendEmpInfoSelect(ExCodeOrgVO orgVo) throws Exception;

    /* Biz - 지출결의 - 사용자 삭제 */
    ExCommonResultVO ExExpendEmpInfoDelete(ExCodeOrgVO orgVo) throws Exception;

    /* Biz - 공통코드 - 거래처 */
    /* Biz - 지출결의 - 거래처 등록 */
    ExCodePartnerVO ExExpendPartnerInfoInsert(ExCodePartnerVO partnerVo) throws Exception;

    /* Biz - 공통코드 - 거래처 */
    /* Biz - 지출결의 - 거래처 등록 후 t_ex_expend에 추가 */
    ExCodePartnerVO fnExpendPartnerInsert_Update(ExCodePartnerVO partnerVo) throws Exception;

    /* Biz - 지출결의 - 거래처 수정 */
    ExCommonResultVO ExExpendPartnerInfoUpdate(ExCodePartnerVO partnerVo) throws Exception;

    /* Biz - 지출결의 - 거래처 조회 */
    ExCodePartnerVO ExExpendPartnerInfoSelect(ExCodePartnerVO partnerVo) throws Exception;

    /* Biz - 지출결의 - 거래처 삭제 */
    ExCommonResultVO ExExpendPartnerInfoDelete(ExCodePartnerVO partnerVo) throws Exception;

    /* Biz - 공통코드 - 프로젝트 */
    /* Biz - 지출결의 - 프로젝트 등록 */
    ExCodeProjectVO ExExpendProjectInfoInsert(ExCodeProjectVO projectVo) throws Exception;

    /* Biz - 공통코드 - 프로젝트 */
    /* Biz - 지출결의 - 프로젝트 등록 후 t_ex_expend에 추가 */
    ExCodeProjectVO fnExpendProjectInsert_Update(ExCodeProjectVO projectVo) throws Exception;

    /* Biz - 지출결의 - 프로젝트 수정 */
    ExCommonResultVO ExExpendProjectInfoUpdate(ExCodeProjectVO projectVo) throws Exception;

    /* Biz - 지출결의 - 프로젝트 조회 */
    ExCodeProjectVO ExExpendProjectInfoSelect(ExCodeProjectVO projectVo) throws Exception;

    /* Biz - 지출결의 - 프로젝트 삭제 */
    ExCommonResultVO ExExpendProjectInfoDelete(ExCodeProjectVO projectVo) throws Exception;

    /* Biz - 공통코드 - 표준적요 */
    /* Biz - 지출결의 - 표준적요 등록 */
    ExCodeSummaryVO ExExpendSummaryInfoInsert(ExCodeSummaryVO summaryVo) throws Exception;

    /* Biz - 지출결의 - 표준적요 수정 */
    ExCommonResultVO ExExpendSummaryInfoUpdate(ExCodeSummaryVO summaryVo) throws Exception;

    /* 지출결의 - 표준적요 조회 */
    ExCodeSummaryVO ExExpendSummaryInfoSelect(ExCodeSummaryVO summaryVo) throws Exception;

    /* Biz - 지출결의 - 표준적요 삭제 */
    ExCommonResultVO ExExpendSummaryInfoDelete(ExCodeSummaryVO summaryVo) throws Exception;

    /* Biz - 공통코드 - 표준적요 등록 */
    ExCodeSummaryVO ExCodeSummaryInfoInsert(ExCodeSummaryVO summaryVo) throws Exception;

    /* Biz - 공통코드 - 표준적요 수정 */
    ExCommonResultVO ExCodeSummaryInfoUpdate(ExCodeSummaryVO summaryVo) throws Exception;

    /* Biz - 공통코드 - 표준적요 삭제 */
    ExCommonResultVO ExCodeSummaryInfoDelete(ExCodeSummaryVO summaryVo) throws Exception;

    /* Biz - 공통코드 - 부가세 */
    /* Biz - 공통코드 - 부가세 생성 */
    ExCodeAuthVO ExCodeVatTypeInfoInsert(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 부가세 수정 */
    ExCommonResultVO ExCodeVatTypeInfoUpdate(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception;

    /* Biz - 공통코드 - 부가세 삭제 */
    ExCommonResultVO ExCodeVatTypeInfoDelete(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception;

    ExCodePartnerVO ExCodePartnerInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception;

    ExCodeCardVO ExCodeCardInfoSelect(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception;

    /* Biz - 지출결의 - 지출결의 expendSeq 조회 */
    Map<String, Object> ExUserExpendSeq(Map<String, Object> param) throws Exception;

    /* Biz - 지출결의 - 지출결의 docSts 조회 */
    Map<String, Object> ExUserExpendDocStsSelect(Map<String, Object> param) throws Exception;

    /* 테스트 데이터 */
    List<Map<String, Object>> ExpendInfoSelect(Map<String, Object> param);

    /**
     * ERP회사코드, 사업장코드, 문서번호 조회
     */
    ResultVO ExCodeERPInfoSelect(ResultVO param);

    /**
     * 해당 지출결의 매입전자 세금계산서 번호 조회
     */
    ResultVO ExExpendETaxInfoListSelect(ResultVO param);
    
    /*
     * 해당 지출결의 카드 번호 조회 
     * */
    ResultVO ExExpendCardAInfoListSelect(ResultVO param);

    /* row_id, row_no, slipSeq 조회 */
    ResultVO ExExpendSlipBudgetInfoSelect(ResultVO param);

    /* 전자결재 정보 조회 */
    ResultVO ExExpendDocInfoSelect(ResultVO param);

    /* t_ex_group_path 조회 */
    Map<String, Object> ExCommonExpGroupPathSelect(Map<String, Object> param);

    /* Biz - 공통코드 - ERPiU 접대비 계정 유무 확인 */
    ResultVO ExCommonAcctReceptYN(Map<String, Object> params, ConnectionVO conVo) throws Exception;

    /* Biz - ERPiU - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    ERPiUAccSeq ExERPiUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception;

    ERPiUAccSeq ExERPYesilIUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception;
}
