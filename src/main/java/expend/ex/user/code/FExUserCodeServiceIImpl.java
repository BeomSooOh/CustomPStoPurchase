package expend.ex.user.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import common.enums.ex.OptionCodeType;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ERPiU.ERPiUAccSeq;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.master.config.FExMasterConfigServiceADAO;


@Service("FExUserCodeServiceI")
public class FExUserCodeServiceIImpl implements FExUserCodeService {

    /* 변수정의 */
    /* 변수정의 - DAO */
    @Resource(name = "FExUserCodeServiceIDAO")
    private FExUserCodeServiceIDAO dao;
    @Resource(name = "FExMasterConfigServiceADAO")
    private FExMasterConfigServiceADAO configDAO;
    /* 변수정의 - service */
    @Resource(name = "BExAdminConfigService") /* 환경설정 서비스 */
    private BExAdminConfigService configService;

    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) */
    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 */
    /* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExUserEmpListInfoSelect(Map<String, Object> params, common.vo.common.ConnectionVO conVo) throws Exception {
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
        /* parameter : comp_seq, erp_comp_seq, form_seq, drcr_gbn, search_str */
        List<ExCodeMngVO> mngListVo = new ArrayList<ExCodeMngVO>();
        List<ExCodeMngVO> mngSetListVo = new ArrayList<ExCodeMngVO>();
        try {
            /* 관리항목 목록 조회 */
            mngListVo = new ArrayList<ExCodeMngVO>();
            mngListVo = dao.ExExpendMngListInfoSelect(mngVo, conVo);
            /* 설정된 관리항목 정보 조회 */
            mngSetListVo = new ArrayList<ExCodeMngVO>();
            mngSetListVo = configDAO.ExConfigMngListInfoSelect(mngVo);
            for (ExCodeMngVO curMngSetVo : mngSetListVo) {
                for (ExCodeMngVO curMngVo : mngListVo) {
                    curMngVo.setCompSeq(mngVo.getCompSeq());
                    curMngVo.setFormSeq(mngVo.getFormSeq());
                    /*
                     * ?? : join 해서 update 하는 방법이 없을까? 아니면, 특정건만 바로 찾을 수 있는 방법이 없을까?
                     */
                    if (curMngSetVo.getMngCode().equals(curMngVo.getMngCode())) {
                        curMngVo.setDrcrGbn(curMngSetVo.getDrcrGbn());
                        curMngVo.setUseGbn(curMngSetVo.getUseGbn());
                        if (curMngSetVo.getUseGbn().equals("EmpInfo")) {
                            curMngVo.setUseGbnName("사용자");
                        } else if (curMngSetVo.getUseGbn().equals("DeptInfo")) {
                            curMngVo.setUseGbnName("사용자 부서");
                        } else if (curMngSetVo.getUseGbn().equals("UserInput")) {
                            curMngVo.setUseGbnName("사용자 정의");
                        } else if (curMngSetVo.getUseGbn().equals("BizareaInfo")) {
                            curMngVo.setUseGbnName("사용자 사업장");
                        } else if (curMngSetVo.getUseGbn().equals("CompanyInfo")) {
                            curMngVo.setUseGbnName("사용자 회사");
                        }

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
        } else if (codeType.toUpperCase().equals(commonCode.CARD)) {
            return dao.ExCommonCodeCardSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EMP)) {
            return dao.ExCommonCodeEmpSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.DEPT)) {
            return dao.ExCommonCodeDeptSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EMPONE)) {
            return dao.ExCommonCodeEmpSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.ERPAUTH)) {
            return dao.ExCommonCodeErpAuthSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PARTNER)) {
            return dao.ExCommonCodePartnerSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PROJECT)) {
            return dao.ExCommonCodeProjectSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.VA)) {
            return dao.ExCommonCodeVaSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.VATTYPE)) {
            return dao.ExCommonCodeVatTypeSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.REGNOPARTNER)) {
            return dao.ExCommonCodeRegNoPartnerSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EXCHANGEUNIT)) {
        	return dao.ExCommonCodeExchangeUnitSelect(params, conVo);
        } else {
            throw new NotFoundLogicException(String.format("처리 분기 {0}를 찾을 수 없습니다.", codeType), commonCode.ICUBE);
        }
    }

    /* 공통코드 - 거래처 조회 */
    @Override
    public ExCodePartnerVO ExCodePartnerInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception {
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ExCodePartnerVO tempPartner = new ExCodePartnerVO();
        tempPartner.setPartnerCode(partnerVo.getPartnerCode());
        tempPartner.setPartnerFg(partnerVo.getPartnerFg());
        tempPartner.setPartnerName(partnerVo.getPartnerName());
        tempPartner.setPartnerNo(partnerVo.getPartnerNo());
        tempPartner.setCeoName(partnerVo.getCeoName());
        tempPartner.setDepositConvert(partnerVo.getDepositConvert());
        tempPartner.setDepositName(partnerVo.getDepositName());
        tempPartner.setDepositNo(partnerVo.getDepositNo());
        // tempPartner.setErpCompSeq( partnerVo.getErpCompSeq( ) ); // iCUBE에서 사업자 번호가 정상적으로 수신되지 않는 경우가 발생될 수 있다고하여, 로그인 정보에서 강제로 맵핑 처리 진행
        tempPartner.setErpCompSeq(loginVo.getErpCoCd()); // ERP 회사 코드는 로그인 정보에서 가져오도록 처리
        tempPartner.setSearchStr(partnerVo.getSearchStr());
        tempPartner.setSearchType(partnerVo.getSearchType());
        tempPartner.setFormSeq(partnerVo.getFormSeq());
        if (tempPartner.getPartnerNo().equals(commonCode.EMPTYSTR) && !tempPartner.getSearchStr().equals(commonCode.EMPTYSTR)) {
            tempPartner.setPartnerNo(tempPartner.getSearchStr());
        }
        try {
            partnerVo = dao.ExCodePartnerInfoSelect(partnerVo, conVo);

            // 지출결의 전송 시 iCUBE 거래처 자동등록 여부 옵션 조회
            Map<String, Object> optionParam = new HashMap<String, Object>();
            optionParam.put("compSeq", loginVo.getCompSeq());
            optionParam.put("formSeq", tempPartner.getFormSeq());
            optionParam.put("useSw", conVo.getErpTypeCode());
            optionParam.put("optionCode", OptionCodeType.NORMAL_AUTO_INPUT_CUSTOMER_ON_TRANSMISSION.getOptionCode());
            ResultVO optionList = new ResultVO();
            optionList = configService.ExAdminConfigOptionSelect(optionParam);
            String isAutoInputCustomer = "Y"; // 기본 : 사용
            if (optionList.getAaData().size() > 0) {
                isAutoInputCustomer = CommonConvert.CommonGetStr(optionList.getAaData().get(0).get("set_value"));
            }

            // 지출결의 전송 시 iCUBE 거래처 자동등록 여부 옵션이 "사용"일때만 거래처 등록(기본 : 사용)
            if (isAutoInputCustomer.equals("Y")) {
                if (partnerVo.getSeq() == 0 && partnerVo.getPartnerCode().equals(commonCode.EMPTYSTR) && !tempPartner.getPartnerNo().equals(commonCode.EMPTYSTR) && !tempPartner.getPartnerNo().equals("0000000000") && !tempPartner.getPartnerNo().equals("!@#$%^&*()")) {
                    // iCUBE 미등록 거래처이므로 등록후 진행하여야 한다.
                    Map<String, Object> sendParam = new HashMap<String, Object>();
                    partnerVo = tempPartner;
                    sendParam.put("erpCompSeq", tempPartner.getErpCompSeq());
                    sendParam.put("partnerName", tempPartner.getPartnerName());
                    if (CommonConvert.CommonGetStr(tempPartner.getPartnerNo()).equals("!@#$%^&*()")) {
                        /* 해외 사용분의 경우 검색을 위하여 임으로 지정된 사업자 등록번호를 다시 공백으로 변경하여 처리한다. */
                        sendParam.put("partnerNo", "");
                    } else {
                        sendParam.put("partnerNo", tempPartner.getPartnerNo());
                    }
                    sendParam.put("ceoName", tempPartner.getCeoName());
                    sendParam = dao.ExCodeUnRegisteredPartnerInfoInsert(sendParam, conVo);
                    if (!sendParam.isEmpty()) {
                        partnerVo.setPartnerCode(sendParam.get("TR_CD").toString());
                        partnerVo.setPartnerName(sendParam.get("TR_NM").toString());
                        partnerVo.setPartnerNo(sendParam.get("REG_NB").toString());
                    }
                }
            }
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
            throw new Exception("ERP 카드정보를 확인할 수 없습니다. 카드가 등록되지 않았거나, 카드번호가 잘못 지정되었을 수 있습니다.");
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
