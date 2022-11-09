package expend.ex.admin.yesil2;

import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service("BExAdminYesil2Service")
public class BExAdminYesil2ServiceImpl implements BExAdminYesil2Service {

    // ERP iU 예실대비 현황 2.0 개발
    // name 값 확인 잘 하기
    @Resource(name = "FExAdminYesil2ServiceU")
    private FExAdminYesil2Service yesil2ServiceU;
    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog; /* Log 관리 */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */


    /* Biz - 예실대비현황 2.0 */
    /* Biz - 예실대비현황 2.0 - 관리자 */ /* IU */
    /* Biz - 예실대비현황 2.0 - 관리자 - 예실대비현황 2.0 이준성 개발 */
    /* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
    @Override
    public ResultVO ExAdminIuYesilSendParam(Map<String, Object> params) throws Exception {
        cmLog.CommonSetInfo("Call ExAdminYesil2SendParam(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        ResultVO result = new ResultVO();

        try {
            /* 기본값 지정 */
            /* 기존값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 기본값 지정 - 연동 시스템 정보 처리 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
            /* 연동 조회 정보이지만 ERP iU 만 받을 것입니다. */
            switch (CommonConvert.CommonGetStr(conVo.getErpTypeCode())) {
                case commonCode.ICUBE: /* ERP iCUBE */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    break;
                case commonCode.ERPIU:
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    /* 데이터 조회 */
                    result.setParams(yesil2ServiceU.ExAdminYesilIuSendParam(params, conVo));
                    break;
                case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    break;
                default: /* Bizbox Alpha */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ);
                    }
                    break;
            }

        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }


    /* Biz - 예실대비현황 2.0 */
    /* Biz - 예실대비현황 2.0 - 관리자 */ /* IU */
    /* Biz - 예실대비현황 2.0 - 관리자 - 예실대비현황 2.0 - 예실대비 조회 */
    @Override
    public ResultVO ExAdminIuYesilInfoSelect(Map<String, Object> params) throws Exception {
        cmLog.CommonSetInfo("Call ExAdminYesil2BudgetAcctInfo(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
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
                    break;
                case commonCode.ERPIU: /* ERP iU */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    /* 데이터 조회 */
                    result.setAaData(yesil2ServiceU.ExAdminIuYesilInfoSelect(params, conVo));
                    break;
                case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ);
                    }
                    break;
                default: /* Bizbox Alpha */
                    /* 필수 파라미터 점검 */
                    if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                        throw new Exception("ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ);
                    }
                    break;
            }
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }
    
    @Override
    public ResultVO ExAdminYesilList(Map<String, Object> params, ConnectionVO conVo) throws Exception {

        ResultVO result = new ResultVO();

        try {
            switch (conVo.getErpTypeCode()) {
                case commonCode.ERPIU:
                    result = yesil2ServiceU.ExAdminYesilList(params, conVo);
                    break;
                case commonCode.ICUBE:
                default:
                    throw new Exception("ERPiU 연동만 지원하는 기능입니다.");
            }
        } catch (Exception e) {
            result.setFail("오류 발생", e);
        }

        return result;
    }

    public ResultVO ExAdminYesilBizPlanCheck(Map<String, Object> params, ConnectionVO conVo) throws Exception {
      ResultVO result = new ResultVO();
      
      try {
        switch (conVo.getErpTypeCode()) {
          case commonCode.ERPIU:
              result = yesil2ServiceU.ExAdminYesilBizPlanCheck(params, conVo);
              break;
          case commonCode.ICUBE:
          default:
              throw new Exception("ERPiU 연동만 지원하는 기능입니다.");
      }
      } catch (Exception e) {
        result.setFail("오류 발생", e);
      }
      
      return result;
    }


}
