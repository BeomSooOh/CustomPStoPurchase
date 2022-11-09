package expend.ex.user.code;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ERPiU.ERPiUAccSeq;
import expend.ex.master.config.FExMasterConfigServiceADAO;


@Service("FExUserCodeServiceU")
public class FExUserCodeServiceUImpl implements FExUserCodeService {

    /* 변수정의 */
    /* 변수정의 - DAO */
    @Resource(name = "FExUserCodeServiceUDAO")
    private FExUserCodeServiceUDAO dao;
    @Resource(name = "FExMasterConfigServiceADAO")
    private FExMasterConfigServiceADAO configDAO;

    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) */
    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 */
    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExUserEmpListInfoSelect(Map<String, Object> params, common.vo.common.ConnectionVO conVo) throws Exception {
        return null;
    }

    /* 공통코드 - 관리항목 전체 목록 조회 */
    @Override
    public List<ExCodeMngVO> ExExpendMngListInfoSelect(ExCodeMngVO mngVo, ConnectionVO conVo) throws Exception {
        /* parameter : comp_seq, form_seq, drcr_gbn, erp_comp_seq, search_str */
        List<ExCodeMngVO> mngListVo = new ArrayList<ExCodeMngVO>();
        List<ExCodeMngVO> mngSetListVo = new ArrayList<ExCodeMngVO>();
        try {
            /* 관리항목 목록 조회 */
            /* parameter : erp_comp_seq, search_str */
            mngListVo = new ArrayList<ExCodeMngVO>();
            mngListVo = dao.ExExpendMngListInfoSelect(mngVo, conVo);
            /* 설정된 관리항목 정보 조회 */
            /* parameter : comp_seq, form_seq, drcr_gbn, search_str */
            mngSetListVo = new ArrayList<ExCodeMngVO>();
            mngSetListVo = configDAO.ExConfigMngListInfoSelect(mngVo);
            for (ExCodeMngVO curMngSetVo : mngSetListVo) {
                for (ExCodeMngVO curMngVo : mngListVo) {
                    curMngVo.setCompSeq(mngVo.getCompSeq());
                    curMngVo.setFormSeq(mngVo.getFormSeq());
                    /* ?? : join 해서 update 하는 방법이 없을까? 아니면, 특정건만 바로 찾을 수 있는 방법이 없을까? */
                    if (curMngSetVo.getMngCode().equals(curMngVo.getMngCode())) {
                        curMngVo.setDrcrGbn(curMngSetVo.getDrcrGbn());
                        curMngVo.setUseGbn(curMngSetVo.getUseGbn());
                        curMngVo.setUseGbnName(curMngSetVo.getUseGbnName());
                        curMngVo.setCtdCode(curMngSetVo.getCtdCode());
                        curMngVo.setCtdName(curMngSetVo.getCtdName());
                        curMngVo.setCustSet(curMngSetVo.getCustSet());
                        curMngVo.setCustSetTarget(curMngSetVo.getCustSetTarget());
                        curMngVo.setModifyYN(curMngSetVo.getModifyYN());
                        curMngVo.setNote(curMngSetVo.getNote());
                    }
                }
            }
        } catch (Exception e) {
            throw e;
        }

        return mngListVo;
    }

    @Override
    public List<Map<String, Object>> ExUserCommCodeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        String codeType = params.get(commonCode.CODETYPE).toString();
        if (codeType.toUpperCase().equals(commonCode.ACCT)) {
            return dao.ExCommonCodeAcctSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.BGACCT)) {
        	return ExCommonCodeBgAcctSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.BIZPLAN)) {
            return dao.ExCommonCodeBizplanSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.BUDGET)) {
            return dao.ExCommonCodeBudgetSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.CARD)) {
            return dao.ExCommonCodeCardSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.CC)) {
            return dao.ExCommonCodeCcSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EMP)) {
            return dao.ExCommonCodeEmpSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.DEPT)) {
            return dao.ExCommonCodeDeptSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EMPONE)) {
            return dao.ExCommonCodeEmpSelectOne(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.ERPAUTH)) {
            return dao.ExCommonCodeErpAuthSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.NOTAX)) {
            return dao.ExCommonCodeNotaxSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PARTNER)) {
            return dao.ExCommonCodePartnerSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PC)) {
            return dao.ExCommonCodePcSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PROJECT)) {
            return dao.ExCommonCodeProjectSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.VATTYPE)) {
            return dao.ExCommonCodeVatTypeSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.REGNOPARTNER)) {
            return dao.ExCommonCodeRegNoPartnerSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EXCHANGEUNIT)) {
        	return dao.ExCommonCodeExchangeUnitSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.BUDDEPT)) {
            return dao.ExCommonCodeBudDeptSelect(params,conVo);
        } else {
            throw new NotFoundLogicException(String.format("처리 분기 {0}를 찾을 수 없습니다.", codeType), commonCode.ERPIU);
        }
    }

    /**
     * 예산계정 코드 조회
     * @throws Exception
     */
    private List<Map<String, Object>> ExCommonCodeBgAcctSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
    	Map<String, Object> checkResult = dao.checkBgAcctLinkAcct(params, conVo);

    	// 회계계정연결 데이터가 있으면 연결설정된 데이터 내에서만 검색한다.
    	if(Integer.valueOf(CommonConvert.CommonGetSeq(checkResult.get("linkCount"))) > 0) {
    		return dao.ExCommonCodeBgAcctLinkAcctSelect(params, conVo);
    	}else {
    		return dao.ExCommonCodeBgAcctSelect(params, conVo);
    	}
    }

    /* 공통코드 - 거래처 조회 */
    @Override
    public ExCodePartnerVO ExCodePartnerInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception {
        try {
            partnerVo = dao.ExCodePartnerInfoSelect(partnerVo, conVo);
        } catch (Exception e) {
            throw e;
        }

        return partnerVo;
    }

    /* 공통코드 - 카드 조회 */
    @Override
    public ExCodeCardVO ExCodeCardInfoSelect(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
        try {
            cardVo = dao.ExCodeCardInfoSelect(cardVo, conVo);
        } catch (Exception e) {
            throw e;
        }

        return cardVo;
    }

    /* Function - ERPiU - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    @Override
    public ERPiUAccSeq ExERPiUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        try {
            // groupSeq 점검
            if (accSeq.getGroupSeq() == null || accSeq.getGroupSeq().equals("")) {
                throw new Exception("필수값이 수신되지 않았습니다. [ groupSeq ]");
            }
            // erpCompSeq 점검
            else if (accSeq.getErpCompSeq() == null || accSeq.getErpCompSeq().equals("")) {
                throw new Exception("필수값이 수신되지 않았습니다. [ erpCompSeq || CD_COMPANY ]");
            }
            // ERPiU 회계 기수 정보 조회
            else {
                return dao.ExERPiUAccSeqInfo(accSeq, conVo);
            }
        } catch (Exception e) {
            throw e;
        }
    }


    /* Function - ERPiU 예실대비 현황 2.0  - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    @Override
    public ERPiUAccSeq ExERPYesilIUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        try {
            // groupSeq 점검
            if (accSeq.getGroupSeq() == null || accSeq.getGroupSeq().equals("")) {
                throw new Exception("필수값이 수신되지 않았습니다. [ groupSeq ]");
            }
            // erpCompSeq 점검
            else if (accSeq.getErpCompSeq() == null || accSeq.getErpCompSeq().equals("")) {
                throw new Exception("필수값이 수신되지 않았습니다. [ erpCompSeq || CD_COMPANY ]");
            }
            // ERPiU 회계 기수 정보 조회
            else {
                return dao.ExERPYesilIUAccSeqInfo(accSeq, conVo);
            }
        } catch (Exception e) {
            throw e;
        }
    }

}
