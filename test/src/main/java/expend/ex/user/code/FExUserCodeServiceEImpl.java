package expend.ex.user.code;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ERPiU.ERPiUAccSeq;

@Service("FExUserCodeServiceE")
public class FExUserCodeServiceEImpl implements FExUserCodeService {

    /* 변수정의 */
    /* 변수정의 - DAO */
    @Resource(name = "FExUserCodeServiceEDAO")
    private FExUserCodeServiceEDAO dao;

    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) */
    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 */
    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExUserEmpListInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExUserEmpListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ);
            }

            result = dao.ExUserEmpListInfoSelect(params, conVo);
        } catch (Exception e) {
            throw e;
        }

        return result;
    }

    /* 공통코드 - 관리항목 전체 목록 조회 */
    @Override
    public List<ExCodeMngVO> ExExpendMngListInfoSelect(ExCodeMngVO mngVo, ConnectionVO conVo) throws Exception {
        return null;
    }

    @Override
    public List<Map<String, Object>> ExUserCommCodeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        String codeType = params.get(commonCode.CODETYPE).toString();

        if (codeType.toUpperCase().equals(commonCode.ACCT)) {
            return dao.ExCommonCodeAcctSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.BGACCT)) {
            return dao.ExCommonCodeBgAcctSelect(params, conVo);
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
            return dao.ExCommonCodeEmpSelect(params, conVo);
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
        } else if (codeType.toUpperCase().equals(commonCode.VA)) {
            return dao.ExCommonCodeVaSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.VATTYPE)) {
            return dao.ExCommonCodeVatTypeSelect(params, conVo);
        } else {
            throw new NotFoundLogicException(String.format("처리 분기 {0}를 찾을 수 없습니다.", codeType), commonCode.ETC);
        }
    }


    /* 공통코드 - 거래처 조회 */
    @Override
    public ExCodePartnerVO ExCodePartnerInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception {
        try {
            // partnerVo = dao.ExCodePartnerInfoSelect(partnerVo, conVo);
        } catch (Exception e) {
            throw e;
        }
        return partnerVo;
    }

    /* 공통코드 - 카드 조회 */
    @Override
    public ExCodeCardVO ExCodeCardInfoSelect(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
        try {
            // cardVo = dao.ExCodeCardInfoSelect(cardVo, conVo);
        } catch (Exception e) {
            throw e;
        }

        return cardVo;
    }

    /* Function - ERPiU - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    @Override
    public ERPiUAccSeq ExERPiUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        throw new NotImplementedException("ERPiU 전용기능입니다.");
    }

    @Override
    public ERPiUAccSeq ExERPYesilIUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        throw new NotImplementedException("ERPiU 전용기능입니다.");
    }
}
