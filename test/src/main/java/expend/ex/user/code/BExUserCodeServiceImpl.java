package expend.ex.user.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
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
import main.web.BizboxAMessage;


@Service("BExUserCodeService")
public class BExUserCodeServiceImpl implements BExUserCodeService {

    /* 변수정의 */
    /* 변수정의 - Service */
    @Resource(name = "FExUserCodeServiceA")
    private FExUserCodeService codeA; /* Bizbox Alpha */
    @Resource(name = "FExUserCodeServiceI")
    private FExUserCodeService codeI; /* ERP iCUBE */
    @Resource(name = "FExUserCodeServiceU")
    private FExUserCodeService codeU; /* ERP iU */
    @Resource(name = "FExUserCodeServiceE")
    private FExUserCodeService codeE; /* ERP ETC */
    /* 변수정의 - DAO */
    @Resource(name = "FExUserCodeServiceADAO")
    private FExUserCodeServiceADAO daoA; /* Bizbox Alpha */
    @Resource(name = "FExUserCodeServiceIDAO")
    private FExUserCodeServiceIDAO daoI; /* ERP iCUBE */
    @Resource(name = "FExUserCodeServiceUDAO")
    private FExUserCodeServiceUDAO daoU; /* ERP iU */
    @Resource(name = "FExUserCodeServiceEDAO")
    private FExUserCodeServiceEDAO daoE; /* ERP ETC */
    /* 변수정의 - Common */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    /* Biz - 공통코드 */
    /* Biz - 공통코드 - 사용자 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 공통코드 - 사용자 - 목록 조회 */
    @Override
    public ResultVO ExUserEmpListInfoSelect(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        try {
            /* 기본값 지정 */
            /* 기존값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 기본값 지정 - 연동 시스템 정보 처리 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
            /* 연동시스템별 정보 처리 */
            switch (CommonConvert.CommonGetStr(conVo.getErpTypeCode())) {
                case commonCode.ICUBE: /* ERP iCUBE */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    /* 데이터 조회 */
                    result.setAaData(codeI.ExUserEmpListInfoSelect(params, conVo));
                    break;
                case commonCode.ERPIU: /* ERP iU */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    /* 데이터 조회 */
                    result.setAaData(codeU.ExUserEmpListInfoSelect(params, conVo));
                    break;
                case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    /* 데이터 조회 */
                    result.setAaData(codeE.ExUserEmpListInfoSelect(params, conVo));
                    break;
                default: /* Bizbox Alpha */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ);
                    }
                    /* 데이터 조회 */
                    result.setAaData(codeA.ExUserEmpListInfoSelect(params, conVo));
                    break;
            }
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    /* Biz - 공통코드 - 공통코드 조회 */
    @Override
    public ResultVO ExCommonCodeInfoSelect(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        try {
            /* 기본값 지정 */
            /* 기존값 지정 - 사용자 정보 처리 */
            String erpEmpSeq = CommonConvert.CommonGetStr(params.get("erpEmpSeq"));
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            if (!erpEmpSeq.equals("")) {
                params.put("erpEmpSeq", erpEmpSeq);
            }
            /* 기본값 지정 - 연동 시스템 정보 처리 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            params.put("groupSeq", loginVo.getGroupSeq());
            params.put("erpCompSeq", conVo.getErpCompSeq());
            if (params.get(commonCode.COMPSEQ) == null || params.get(commonCode.COMPSEQ).equals("")) {
                params.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            }
            if (params.get(commonCode.DEPTSEQ) == null || params.get(commonCode.DEPTSEQ).equals("")) {
                params.put(commonCode.DEPTSEQ, loginVo.getOrganId());
            }
            if (params.get(commonCode.EMPSEQ) == null || params.get(commonCode.EMPSEQ).equals("")) {
                params.put(commonCode.EMPSEQ, loginVo.getUserSe());
            }
            if (params.get(commonCode.ERPCOMPSEQ) == null || params.get(commonCode.ERPCOMPSEQ).equals("")) {
                params.put(commonCode.ERPCOMPSEQ, loginVo.getErpCoCd());
            }
            params.put(commonCode.USERSE, CommonConvert.CommonGetEmpInfo().get(commonCode.USERSE));
            FExUserCodeService service = null;
            String errorStr = commonCode.EMPTYSTR;
            /* 연동시스템별 정보 처리 */
            switch (CommonConvert.CommonGetStr(conVo.getErpTypeCode())) {
                case commonCode.ICUBE: /* ERP iCUBE */
                    service = codeI;
                    errorStr = "ExCommonCodeInfoSelect - iCUBE - parameter not exists >> ";
                    break;
                case commonCode.ERPIU: /* ERP iU */
                    service = codeU;
                    errorStr = "ExCommonCodeInfoSelect - ERPiU - parameter not exists >> ";
                    break;
                case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
                    service = codeE;
                    errorStr = "ExCommonCodeInfoSelect - ETC - parameter not exists >> ";
                    break;
                default: /* Bizbox Alpha */
                    service = codeA;
                    errorStr = "ExCommonCodeInfoSelect - Alpha - parameter not exists >> ";
                    break;
            }
            /* 필수 파라미터 점검 */
            if (!CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.BIZBOXA) && CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception(errorStr + commonCode.ERPCOMPSEQ);
            }
            // 데이터 조회
            result.setAaData(service.ExUserCommCodeSelect(params, conVo));
        } catch (NotFoundLogicException e) {
            /* iCUBE, iU, ETC erp에 없는 모듈 호출시 그룹웨어로 재시도 */
            if (!e.GetTryConnType().equals(commonCode.BIZBOXA)) {
                ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
                result.setAaData(codeA.ExUserCommCodeSelect(params, conVo));
            }
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    /* Biz - 공통코드 - 계정과목 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 공통코드 - 계정과목 생성 */
    @Override
    public ExCodeAcctVO ExCodeAcctInfoInsert(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        try {
            acctVo = daoA.ExCodeAcctInfoInsert(acctVo);
        } catch (Exception e) {
            throw e;
        }
        return acctVo;
    }

    /* Biz - 공통코드 - 계정과목 수정 */
    @Override
    public ExCommonResultVO ExCodeAcctInfoUpdate(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeAcctInfoUpdate(acctVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 계정과목 삭제 */
    @Override
    public ExCommonResultVO ExCodeAcctInfoDelete(ExCodeAcctVO acctVo, ConnectionVO conVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeAcctInfoDelete(acctVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 지출결의 - 증빙유형 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 지출결의 - 증빙유형 생성 */
    @Override
    public ExCodeAuthVO ExExpendAuthInfoInsert(ExCodeAuthVO authVo) throws Exception {
        try {
            if (authVo.getEtaxYN() == null || authVo.getEtaxYN().equals(commonCode.EMPTYSTR)) {
                authVo.setEtaxYN(commonCode.EMPTYNO);
                authVo.setEtaxSendYN(commonCode.EMPTYNO);
            }
            authVo = daoA.ExExpendAuthInfoInsert(authVo);
        } catch (Exception e) {
            throw e;
        }
        return authVo;
    }

    /* Biz - 지출결의 - 증빙유형 수정 */
    @Override
    public ExCommonResultVO ExExpendAuthInfoUpdate(ExCodeAuthVO authVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendAuthInfoUpdate(authVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 지출결의 - 증빙유형 조회 */
    @Override
    public ExCodeAuthVO ExExpendAuthInfoSelect(ExCodeAuthVO authVo) throws Exception {
        try {
            authVo = daoA.ExExpendAuthInfoSelect(authVo);
        } catch (Exception e) {
            throw e;
        }
        return authVo;
    }

    /* Biz - 지출결의 - 증빙유형 삭제 */
    @Override
    public ExCommonResultVO ExExpendAuthInfoDelete(ExCodeAuthVO authVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendAuthInfoDelete(authVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 증빙유형 등록 */
    @Override
    public ExCodeAuthVO ExCodeAuthInfoInsert(ExCodeAuthVO authVo) throws Exception {
        try {
            authVo = daoA.ExCodeAuthInfoInsert(authVo);
        } catch (Exception e) {
            throw e;
        }
        return authVo;
    }

    /* Biz - 공통코드 - 증빙유형 수정 */
    @Override
    public ExCommonResultVO ExCodeAuthInfoUpdate(ExCodeAuthVO authVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeAuthInfoUpdate(authVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 증빙유형 삭제 */
    @Override
    public ExCommonResultVO ExCodeAuthInfoDelete(ExCodeAuthVO authVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeAuthInfoDelete(authVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 예산정보 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 지출결의 - 예산정보 생성 */
    @Override
    public ExCodeBudgetVO ExExpendBudgetInfoInsert(ExCodeBudgetVO budgetVo) throws Exception {
        try {
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));

            if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                if (budgetVo.getBizplanCode().equals("") || budgetVo.getBizplanCode().equals("0")) {
                    budgetVo.setBizplanCode("***");
                }
            }

            // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
            budgetVo = daoA.ExExpendBudgetInfoInsert(budgetVo);
        } catch (Exception e) {
            throw e;
        }
        return budgetVo;
    }

    /* Biz - 지출결의 - 예산정보 조회 */
    @Override
    public ExCodeBudgetVO ExExpendBudgetInfoSelect(ExCodeBudgetVO budgetVo) throws Exception {
        try {
            // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
            budgetVo = daoA.ExExpendBudgetInfoSelect(budgetVo);
        } catch (Exception e) {
            throw e;
        }
        return budgetVo;
    }

    /* Biz - 지출결의 - 임시예산정보 생성 */
    @Override
    public ExCommonResultVO ExExpendGmmsumOtherInfoInsert(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        return null;
    }

    /* Biz - 지출결의 - 임시예산정보 삭제 */
    @Override
    public ExCommonResultVO ExExpendGmmsumOtherInfoDelete(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        return null;
    }

    // 수정 예정 신재호
    /* Biz - 지출결의 - 예산확인 */
    @Override
    public ExCodeBudgetVO ExCodeBudgetAmtInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        try {
            // switch ( budgetVo.getBudget_type() ) {
            // case "P":
            // case "D":
            // /* iCUBE 예산잔액 확인을 위해, 생성된 문서가 자동전표 전송 전까지의 금액을 조회하며, "반려", "삭제" 는 조회하지 않는다. */
            // budgetVo = daoA.ExCodeiCUBEBudgetAmtInfoSelect( budgetVo );
            // break;
            // }
            budgetVo = daoA.ExCodeiCUBEBudgetAmtInfoSelect(budgetVo);
        } catch (Exception e) {
            throw e;
        }
        return budgetVo;
    }

    /* Biz - 지출결의 - 예산통제 구분 확인 */ /* iCUBE */
    @Override
    public ExCodeBudgetVO ExCodeBudgetTypeInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        try {
            budgetVo = daoI.ExCodeBudgetTypeInfoSelect(budgetVo, conVo);
        } catch (Exception e) {
            throw e;
        }
        return budgetVo;
    }

    /* Biz - 공통코드 - 카드정보 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 지출결의 - 카드정보 생성 */
    @Override
    public ExCodeCardVO ExExpendCardInfoInsert(ExCodeCardVO cardVo) throws Exception {
        try {
            cardVo = daoA.ExExpendCardInfoInsert(cardVo);
        } catch (Exception e) {
            throw e;
        }
        return cardVo;
    }

    /* Biz - 지출결의 - 카드정보 수정 */
    @Override
    public ExCommonResultVO ExExpendCardInfoUpdate(ExCodeCardVO cardVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendCardInfoUpdate(cardVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 지출결의 - 카드정보 조회 */
    @Override
    public ExCodeCardVO ExExpendCardInfoSelect(ExCodeCardVO cardVo) throws Exception {
        try {
            cardVo = daoA.ExExpendCardInfoSelect(cardVo);
        } catch (Exception e) {
            throw e;
        }
        return cardVo;
    }

	/* 지출결의 - 카드정보 조회(iCUBE 일때만 해당) - iCUBE에 존재하는 카드이지만 그룹웨어에는 없을때 카드정보에 있는 거래처정보를 가져오기 위해 조회 */
    @Override
	public ExCodeCardVO ExExpendCardInfoSelectWithPartner(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
		try {
            cardVo = daoA.ExExpendCardInfoSelect(cardVo);

            // 항목에 저장된 카드정보(card_code)가 있고 카드정보의 거래처가 없을때
        	if(!CommonConvert.CommonGetStr(cardVo.getCardCode()).equals(commonCode.EMPTYSTR) &&
        		CommonConvert.CommonGetStr(cardVo.getPartnerCode()).equals(commonCode.EMPTYSTR)) {
        		Map<String, Object> params = new HashMap<>();
        		params.put("erpCompSeq", conVo.getErpCompSeq());
        		params.put("searchStr", cardVo.getCardCode());

        		// iCUBE 카드정보 조회
        		List<Map<String, Object>> result = daoI.ExCommonCodeCardSelectForICUBE(params, conVo);

        		if(result.size() > 0) {
        			cardVo.setPartnerCode(CommonConvert.CommonGetStr(result.get(0).get("partnerCode")));
        			cardVo.setPartnerName(CommonConvert.CommonGetStr(result.get(0).get("partnerName")));
        		}
        	}
        } catch (Exception e) {
            throw e;
        }
        return cardVo;
	}

    /* Biz - 지출결의 - 카드정보 삭제 */
    @Override
    public ExCommonResultVO ExExpendCardInfoDelete(ExCodeCardVO cardVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendCardInfoDelete(cardVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 카드정보 생성 */
    @Override
    public ExCodeCardVO ExCodeCardInfoInsert(ExCodeCardVO cardVo) throws Exception {
        try {
            /* 카드 등록 */
            cardVo.setCardPublicJson(cardVo.getCardPublicJson());
            cardVo = daoA.ExCodeCardInfoInsert(cardVo);
            /* 공개범위 삭제 */
            this.ExCodeCardPublicListInfoDelete(cardVo);
            /* 공개범위 등록 */
            if (!cardVo.getCardPublic().equals(commonCode.EMPTYSTR)) {
                List<ExCodeCardPublicVO> publicListVo = new ArrayList<ExCodeCardPublicVO>();
                List<Map<String, Object>> listMap = CommonConvert.CommonGetJSONToListMap(cardVo.getCardPublic());
                for (Map<String, Object> map : listMap) {
                    ExCodeCardPublicVO publicVo = new ExCodeCardPublicVO();
                    publicListVo.add((ExCodeCardPublicVO) CommonConvert.CommonGetMapToObject(map, publicVo));
                }
                this.ExCodeCardPublicListInfoInsert(publicListVo);
            }
        } catch (Exception e) {
            throw e;
        }
        return cardVo;
    }

    /* Biz - 지출결의 - card 등록 후 t_ex_expend 에 등록 */
    @Override
    public ExCodeCardVO fnExpendCardInsert_Update(ExCodeCardVO cardVO) throws Exception {
        try {
            cardVO = daoA.ExExpendCardInfoInsert(cardVO);
            daoA.fnExpendCardInsert_Update(cardVO);
        } catch (Exception e) {
            throw e;
        }
        /* 프로젝트 t_ex_expend 컬럼에 기입 */
        return cardVO;
    }


    /* Biz - 공통코드 - 카드정보 수정 */
    @Override
    public ExCommonResultVO ExCodeCardInfoUpdate(ExCodeCardVO cardVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            /* 카드 수정 */
            cardVo.setCardPublicJson(cardVo.getCardPublicJson());
            cardVo.setCardPublic(cardVo.getCardPublic());
            resultVo = daoA.ExCodeCardInfoUpdate(cardVo);
            /* 공개범위 삭제 */
            this.ExCodeCardPublicListInfoDelete(cardVo);
            /* 공개범위 등록 */
            if (!cardVo.getCardPublic().equals(commonCode.EMPTYSTR)) {
                List<ExCodeCardPublicVO> publicListVo = new ArrayList<ExCodeCardPublicVO>();
                List<Map<String, Object>> listMap = CommonConvert.CommonGetJSONToListMap(cardVo.getCardPublic());
                for (Map<String, Object> map : listMap) {
                    ExCodeCardPublicVO publicVo = new ExCodeCardPublicVO();
                    publicListVo.add((ExCodeCardPublicVO) CommonConvert.CommonGetMapToObject(map, publicVo));
                }
                this.ExCodeCardPublicListInfoInsert(publicListVo);
            }
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 카드정보 삭제 */
    @Override
    public ExCommonResultVO ExCodeCardInfoDelete(ExCodeCardVO cardVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeCardInfoDelete(cardVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - ERP카드정보 가져오기 */
    @Override
    public ExCommonResultVO ExCodeCardInfoFromErpCopy(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
        return null;
    }

    /* Biz - 공통코드 - 카드공개범위 등록 */
    @Override
    public ExCommonResultVO ExCodeCardPublicListInfoInsert(List<ExCodeCardPublicVO> publicListVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            for (ExCodeCardPublicVO exCodeCardPublicVO : publicListVo) {
                resultVo = daoA.ExCodeCardPublicListInfoInsert(exCodeCardPublicVO);
                if (!resultVo.getCode().equals(commonCode.SUCCESS)) {
                    throw new Exception(BizboxAMessage.getMessage("TX000009297", "카드 공개범위 저장 실패"));
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 카드공개범위 삭제 */
    @Override
    public ExCommonResultVO ExCodeCardPublicListInfoDelete(ExCodeCardVO cardVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeCardPublicListInfoDelete(cardVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 공통코드 - 회사 목록 조회 */
    @Override
    public List<ExCommonResultVO> ExCodeCommonCompListInfoSelect(ExCommonResultVO commonParam) throws Exception {
        List<ExCommonResultVO> resultVo = new ArrayList<ExCommonResultVO>();
        try {
            resultVo = daoA.ExCodeCommonCompListInfoSelect(commonParam);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 양식 목록 조회 */
    @Override
    public List<ExCommonResultVO> ExCodeCommonFormListInfoSelect(ExCommonResultVO commonParam) throws Exception {
        /* parameter : comp_seq */
        List<ExCommonResultVO> resultVo = new ArrayList<ExCommonResultVO>();
        try {
            resultVo = daoA.ExCodeCommonFormListInfoSelect(commonParam);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 공통코드 목록 조회 */
    @Override
    public List<ExCommonResultVO> ExCodeCommonCodeListInfoSelect(ExCommonResultVO commonParam) throws Exception {
        List<ExCommonResultVO> resultVo = new ArrayList<ExCommonResultVO>();
        try {
            resultVo = daoA.ExCodeCommonCodeListInfoSelect(commonParam);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 양식 상세 조회 */
    @Override
    public Map<String, Object> ExCodeCommonFormDetailInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        // 변수정의
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            // result = sqlMgr.listSelect(queryId, param);
            //result = daoA.ExCodeCommonFormDetailInfoSelect(param, conVo);
        	result = daoA.ExCodeCommonFormDetailInfoSelect(param);
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    /* Biz - 공통코드 - 양식 목록 조회 */
    @Override
    public List<Map<String, Object>> ExFormListInfoSelect(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        /* parameter : */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            //result = daoA.ExFormListInfoSelect(param, conVo);
        	result = daoA.ExFormListInfoSelect(param);
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    /* Biz - 공통코드 - ERP 회사코드 확인 */
    @Override
    public String getErpCompSeq(LoginVO loginVo, String system, String compSeq) throws Exception {
        String result = commonCode.EMPTYSTR;
        if (!system.equals(commonCode.BIZBOXA)) {
            if (!loginVo.getCompSeq().equals(compSeq)) {
                result = this.getErpCodeInfoSelect(compSeq, commonCode.EMPTYSTR, commonCode.EMPTYSTR, commonCode.EMPTYSTR, "comp");
            } else {
                result = loginVo.getErpCoCd();
            }
        }
        return result;
    }

    /* Biz - 공통코드 - ERP 회사코드, 사업장코드, 부서코드, 사원코드 조회 */
    @Override
    public String getErpCodeInfoSelect(String compSeq, String bizSeq, String deptSeq, String empSeq, String searchType) throws Exception {
        /* 변수정의 */
        String result = commonCode.EMPTYSTR;
        Map<String, Object> sendParam = new HashMap<String, Object>();
        sendParam.put(commonCode.COMPSEQ, (StringUtils.isEmpty(compSeq) ? commonCode.EMPTYSTR : compSeq));
        sendParam.put(commonCode.BIZSEQ, (StringUtils.isEmpty(bizSeq) ? commonCode.EMPTYSTR : bizSeq));
        sendParam.put(commonCode.DEPTSEQ, (StringUtils.isEmpty(deptSeq) ? commonCode.EMPTYSTR : deptSeq));
        sendParam.put(commonCode.EMPSEQ, (StringUtils.isEmpty(empSeq) ? commonCode.EMPTYSTR : empSeq));
        try {
            switch (searchType) {
                case "comp":
                    result = daoA.getErpCodeCompanyInfoSelect(sendParam);
                    break;
                case "biz":
                    result = daoA.getErpCodeBizInfoSelect(sendParam);
                    break;
                case "dept":
                    result = daoA.getErpCodeDeptInfoSelect(sendParam);
                    break;
                case "emp":
                    result = daoA.getErpCodeEmpInfoSelect(sendParam);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    @Override
    public List<ExCodeMngVO> ExExpendMngListInfoSelect(ExCodeMngVO mngVo, ConnectionVO conVo) throws Exception {
        List<ExCodeMngVO> result = new ArrayList<ExCodeMngVO>();
        /* 연동시스템별 정보 처리 */
        switch (CommonConvert.CommonGetStr(conVo.getErpTypeCode())) {
            case commonCode.ICUBE: /* ERP iCUBE */
                result = codeI.ExExpendMngListInfoSelect(mngVo, conVo);
                break;
            case commonCode.ERPIU: /* ERP iU */
                result = codeU.ExExpendMngListInfoSelect(mngVo, conVo);
                break;
            case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
                break;
            default: /* Bizbox Alpha */
                break;
        }
        return result;
    }

    /* Biz - 공통코드 - 사용자 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 지출결의 - 사용자 등록 */
    @Override
    public ExCodeOrgVO ExExpendEmpInfoInsert(ExCodeOrgVO orgVo) throws Exception {
        try {
            /* 필수값 확인 */
            if (orgVo.getCompName().equals(commonCode.EMPTYSTR) && orgVo.getErpCompSeq().equals(commonCode.EMPTYSTR)) {
                return null;
            }
            if (orgVo.getEmpSeq().equals(commonCode.EMPTYSTR) && orgVo.getErpEmpSeq().equals(commonCode.EMPTYSTR)) {
                return null;
            }
            orgVo = daoA.ExExpendEmpInfoInsert(orgVo);
        } catch (Exception e) {
            throw e;
        }
        return orgVo;
    }

    /* Biz - 지출결의 - 사용자 수정 */
    @Override
    public ExCommonResultVO ExExpendEmpInfoUpdate(ExCodeOrgVO orgVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            /* 필수값 확인 */
            if (orgVo.getSeq() == 0) {
                int empSeq = daoA.ExExpendEmpInfoInsert(orgVo).getSeq();
                orgVo.setSeq(empSeq);
                resultVo.setCode(commonCode.SUCCESS);
                resultVo.setMessage(BizboxAMessage.getMessage("TX000009301", "정상처리되었습니다"));
                resultVo.setMap(CommonConvert.CommonGetObjectToMap(orgVo));
            }
            resultVo = daoA.ExExpendEmpInfoUpdate(orgVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 지출결의 - 사용자 조회 */
    @Override
    public ExCodeOrgVO ExExpendEmpInfoSelect(ExCodeOrgVO orgVo) throws Exception {
        try {
            orgVo = daoA.ExExpendEmpInfoSelect(orgVo);
        } catch (Exception e) {
            throw e;
        }
        return orgVo;
    }

    /* Biz - 지출결의 - 사용자 삭제 */
    @Override
    public ExCommonResultVO ExExpendEmpInfoDelete(ExCodeOrgVO orgVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendEmpInfoDelete(orgVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 거래처 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 지출결의 - 거래처 등록 */
    @Override
    public ExCodePartnerVO ExExpendPartnerInfoInsert(ExCodePartnerVO partnerVo) throws Exception {
        try {
            partnerVo = daoA.ExExpendPartnerInfoInsert(partnerVo);
        } catch (Exception e) {
            throw e;

        }
        return partnerVo;
    }

    /* Biz - 지출결의 - 거래처 등록 후 t_ex_expend 에 등록 */
    @Override
    public ExCodePartnerVO fnExpendPartnerInsert_Update(ExCodePartnerVO partnerVO) throws Exception {
        try {
            partnerVO = daoA.ExExpendPartnerInfoInsert(partnerVO);
            daoA.fnExpendPartnerInsert_Update(partnerVO);
        } catch (Exception e) {
            throw e;
        }
        /* 프로젝트 t_ex_expend 컬럼에 기입 */

        return partnerVO;
    }

    /* Biz - 지출결의 - 거래처 수정 */
    @Override
    public ExCommonResultVO ExExpendPartnerInfoUpdate(ExCodePartnerVO partnerVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendPartnerInfoUpdate(partnerVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 지출결의 - 거래처 조회 */
    @Override
    public ExCodePartnerVO ExExpendPartnerInfoSelect(ExCodePartnerVO partnerVo) throws Exception {
        try {
            partnerVo = daoA.ExExpendPartnerInfoSelect(partnerVo);
        } catch (Exception e) {
            throw e;
        }
        return partnerVo;
    }

    /* Biz - 지출결의 - 거래처 삭제 */
    @Override
    public ExCommonResultVO ExExpendPartnerInfoDelete(ExCodePartnerVO partnerVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendPartnerInfoDelete(partnerVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 프로젝트 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 지출결의 - 프로젝트 등록 */
    @Override
    public ExCodeProjectVO ExExpendProjectInfoInsert(ExCodeProjectVO projectVo) throws Exception {
        try {
            projectVo = daoA.ExExpendProjectInfoInsert(projectVo);
        } catch (Exception e) {
            throw e;
        }
        return projectVo;
    }

    /* Biz - 지출결의 - 프로젝트 등록 후 t_ex_expend 에 등록 */
    @Override
    public ExCodeProjectVO fnExpendProjectInsert_Update(ExCodeProjectVO projectVo) throws Exception {
        try {
            projectVo = daoA.ExExpendProjectInfoInsert(projectVo);
            daoA.fnExpendProjectInsert_Update(projectVo);
        } catch (Exception e) {
            throw e;
        }
        /* 프로젝트 t_ex_expend 컬럼에 기입 */

        return projectVo;
    }


    /* Biz - 지출결의 - 프로젝트 수정 */
    @Override
    public ExCommonResultVO ExExpendProjectInfoUpdate(ExCodeProjectVO projectVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendProjectInfoUpdate(projectVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 지출결의 - 프로젝트 조회 */
    @Override
    public ExCodeProjectVO ExExpendProjectInfoSelect(ExCodeProjectVO projectVo) throws Exception {
        try {
            projectVo = daoA.ExExpendProjectInfoSelect(projectVo);
        } catch (Exception e) {
            throw e;
        }
        return projectVo;
    }

    /* Biz - 지출결의 - 프로젝트 삭제 */
    @Override
    public ExCommonResultVO ExExpendProjectInfoDelete(ExCodeProjectVO projectVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendProjectInfoDelete(projectVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 표준적요 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 지출결의 - 표준적요 등록 */
    @Override
    public ExCodeSummaryVO ExExpendSummaryInfoInsert(ExCodeSummaryVO summaryVo) throws Exception {
        try {
            summaryVo = daoA.ExExpendSummaryInfoInsert(summaryVo);
        } catch (Exception e) {
            throw e;
        }
        return summaryVo;
    }

    /* Biz - 지출결의 - 표준적요 수정 */
    @Override
    public ExCommonResultVO ExExpendSummaryInfoUpdate(ExCodeSummaryVO summaryVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendSummaryInfoUpdate(summaryVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 지출결의 - 표준적요 조회 */
    @Override
    public ExCodeSummaryVO ExExpendSummaryInfoSelect(ExCodeSummaryVO summaryVo) throws Exception {
        try {
            summaryVo = daoA.ExExpendSummaryInfoSelect(summaryVo);
        } catch (Exception e) {
            throw e;
        }
        return summaryVo;
    }

    /* Biz - 지출결의 - 표준적요 삭제 */
    @Override
    public ExCommonResultVO ExExpendSummaryInfoDelete(ExCodeSummaryVO summaryVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExExpendSummaryInfoDelete(summaryVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 표준적요 등록 */
    @Override
    public ExCodeSummaryVO ExCodeSummaryInfoInsert(ExCodeSummaryVO summaryVo) throws Exception {
        try {
            summaryVo = daoA.ExCodeSummaryInfoInsert(summaryVo);
        } catch (Exception e) {
            throw e;
        }
        return summaryVo;
    }

    /* Biz - 공통코드 - 표준적요 수정 */
    @Override
    public ExCommonResultVO ExCodeSummaryInfoUpdate(ExCodeSummaryVO summaryVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeSummaryInfoUpdate(summaryVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 표준적요 삭제 */
    @Override
    public ExCommonResultVO ExCodeSummaryInfoDelete(ExCodeSummaryVO summaryVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeSummaryInfoDelete(summaryVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 부가세 */ /* BizboxA, iCUBE, ERPiU, ETC */
    /* Biz - 공통코드 - 부가세 생성 */
    @Override
    public ExCodeAuthVO ExCodeVatTypeInfoInsert(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception {
        try {
            vatTypeVo = daoA.ExCodeVatTypeInfoInsert(vatTypeVo);
        } catch (Exception e) {
            throw e;
        }
        return vatTypeVo;
    }

    /* Biz - 공통코드 - 부가세 수정 */
    @Override
    public ExCommonResultVO ExCodeVatTypeInfoUpdate(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeVatTypeInfoUpdate(vatTypeVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* Biz - 공통코드 - 부가세 삭제 */
    @Override
    public ExCommonResultVO ExCodeVatTypeInfoDelete(ExCodeAuthVO vatTypeVo, ConnectionVO conVo) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = daoA.ExCodeVatTypeInfoDelete(vatTypeVo);
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* 공통코드 - 거래처 조회 */
    @Override
    public ExCodePartnerVO ExCodePartnerInfoSelect(ExCodePartnerVO partnerVo, ConnectionVO conVo) throws Exception {
        switch (conVo.getErpTypeCode()) {
            case commonCode.BIZBOXA:
                partnerVo = codeA.ExCodePartnerInfoSelect(partnerVo, conVo);
                break;
            case commonCode.ERPIU:
                partnerVo = codeU.ExCodePartnerInfoSelect(partnerVo, conVo);
                break;
            case commonCode.ICUBE:
                partnerVo = codeI.ExCodePartnerInfoSelect(partnerVo, conVo);
                break;
            case commonCode.ETC:
                partnerVo = codeE.ExCodePartnerInfoSelect(partnerVo, conVo);
                break;
            default :
            	break;
        }
        return partnerVo;
    }

    /* 공통코드 - 거래처 조회 */
    @Override
    public ExCodeCardVO ExCodeCardInfoSelect(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
        switch (conVo.getErpTypeCode()) {
            case commonCode.BIZBOXA:
                cardVo = codeA.ExCodeCardInfoSelect(cardVo, conVo);
                break;
            case commonCode.ERPIU:
                cardVo = codeU.ExCodeCardInfoSelect(cardVo, conVo);
                break;
            case commonCode.ICUBE:
                cardVo = codeI.ExCodeCardInfoSelect(cardVo, conVo);
                break;
            case commonCode.ETC:
                cardVo = codeE.ExCodeCardInfoSelect(cardVo, conVo);
                break;
            default :
            	break;
        }
        return cardVo;
    }

    @Override
    public Map<String, Object> ExUserExpendSeq(Map<String, Object> param) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = daoA.ExUserCodeExpendSeq(param);
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    @Override
    public Map<String, Object> ExUserExpendDocStsSelect(Map<String, Object> param) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = daoA.ExUserExpendDocStsSelect(param);
            if (result == null) {
                result = new HashMap<String, Object>();
                result.put("expendStatCode", commonCode.EMPTYSTR);
            }
        } catch (Exception e) {
            throw e;
        }
        return result;
    }

    /* 테스트 데이터 */
    @Override
    public List<Map<String, Object>> ExpendInfoSelect(Map<String, Object> param) {
        List<Map<String, Object>> expend = new ArrayList<Map<String, Object>>();
        expend = daoA.ExpendInfoSelect(param);
        return expend;
    }

    /**
     * ERP회사코드, 사업장코드, 문서번호 조회
     */
    @Override
    public ResultVO ExCodeERPInfoSelect(ResultVO param) {
        param = daoA.ExCodeERPInfoSelect(param);
        return param;
    }

    /**
     * 해당 지출결의 매입전자 세금계산서 번호 조회
     */
    @Override
    public ResultVO ExExpendETaxInfoListSelect(ResultVO param) {
        param = daoA.ExExpendETaxInfoListSelect(param);
        return param;
    }
    
    /**
     * 준성 해당 지출결의 카드건 번호 조회
     * */
    @Override
    public ResultVO ExExpendCardAInfoListSelect(ResultVO param) {
        param = daoA.ExExpendCardInfoListSelect(param);
        return param;
    }

    /* row_id, row_no, slipSeq 조회 */
    @Override
    public ResultVO ExExpendSlipBudgetInfoSelect(ResultVO param) {
        param = daoA.ExExpendSlipBudgetInfoSelect(param);
        return param;
    }

    /* 전자결재 정보 조회 */
    @Override
    public ResultVO ExExpendDocInfoSelect(ResultVO param) {
        param = daoA.ExExpendDocInfoSelect(param);
        return param;
    }

    /* t_ex_group_path 조회 */
    @Override
    public Map<String, Object> ExCommonExpGroupPathSelect(Map<String, Object> param) {
        Map<String, Object> result = new HashMap<String, Object>();
        result = daoA.ExCommonExpGroupPathSelect(param);
        return result;
    }

    /* Biz - 공통코드 - ERPiU 접대비 계정 유무 확인 */
    @Override
    public ResultVO ExCommonAcctReceptYN(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result.setAaData(daoU.ExCommonAcctReceptYN(params, conVo));
            result.setSuccess();
        } catch (Exception e) {
            result.setFail(e.toString());
        }
        return result;
    }

    /* Biz - ERPiU - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    @Override
    public ERPiUAccSeq ExERPiUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        try {
            if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                return codeU.ExERPiUAccSeqInfo(accSeq, conVo);
            } else {
                throw new Exception("ERPiU 전용기능입니다.");
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
    }

    /* Biz - ERPiU 예실대비 현황 2.0 - 회계 기수 정보 조회 ( 기수, 시작일, 종료일 ) */
    @Override
    public ERPiUAccSeq ExERPYesilIUAccSeqInfo(ERPiUAccSeq accSeq, ConnectionVO conVo) throws Exception {
        try {
            if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                return codeU.ExERPYesilIUAccSeqInfo(accSeq, conVo);
            } else {
                throw new Exception("ERPiU 전용기능입니다.");
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
    }
}
