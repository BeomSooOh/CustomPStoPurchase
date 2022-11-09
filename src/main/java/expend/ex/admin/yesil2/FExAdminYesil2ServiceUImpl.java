package expend.ex.admin.yesil2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import net.sf.json.JSONArray;

@Service("FExAdminYesil2ServiceU")
public class FExAdminYesil2ServiceUImpl implements FExAdminYesil2Service {

    /* 변수정의 */
    /* 변수정의 - DAO */
    @Resource(name = "FExAdminYesil2ServiceUDAO")
    private FExAdminYesil2ServiceUDAO dao;
    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog;

    /* Biz - 예실대비현황 */
    /* Biz - 예실대비현황 - 관리자 */ /* iU */
    /* Biz - 예실대비현황 - 관리자 - 예실대비현황 2.0 */
    /* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
    @Override
    public Map<String, Object> ExAdminYesilIuSendParam(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        cmLog.CommonSetInfo("Call ExAdminYesil2SendParam(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        List<Map<String, Object>> result = null;

        try {
            if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminYesilSendParam - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ);
            }
            /* 공통코드 호출 */
            /* 공통코드 호출 */
            /* 기간구분 */
            params.put("key", CommonInterface.commonCodeUKey.TERMTYPE);
            result = dao.ExAdminIuYesilCommonCode(params, conVo);
            params.put("termTypeList", JSONArray.fromObject((result == null ? new ArrayList<Map<String, Object>>() : result)));
            /* 계정레벨 */
            params.put("key", CommonInterface.commonCodeUKey.ACCTLEVELTYPE);
            result = dao.ExAdminIuYesilCommonCode(params, conVo);
            params.put("acctLevelList", JSONArray.fromObject((result == null ? new ArrayList<Map<String, Object>>() : result)));
            /* 집행구분 */
            params.put("key", CommonInterface.commonCodeUKey.EXECUTETYPE);
            result = dao.ExAdminIuYesilCommonCode(params, conVo);
            params.put("executeList", JSONArray.fromObject((result == null ? new ArrayList<Map<String, Object>>() : result)));
            /* 결의부서 */
            Map<String, Object> erpDeptInfo = new HashMap<String, Object>();
            erpDeptInfo = dao.ExAdminIuYesilDeptInfo(params, conVo);
            params.put("deptInfo", (erpDeptInfo == null ? new HashMap<String, Object>() : erpDeptInfo));

        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return params;
    }

    /* Biz - 예실대비현황 */
    /* Biz - 예실대비현황 - 관리자 */ /* iU */
    /* Biz - 예실대비현황 - 관리자 - 예실대비현황 2.0 - 예실대비현황 조회 */
    @Override
    public List<Map<String, Object>> ExAdminIuYesilInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        cmLog.CommonSetInfo("Call ExAdminYesil2InfoSelect(params >> " + CommonConvert.CommonGetMapStr(params) + ")");
        List<Map<String, Object>> result = null;

        try {
            if (CommonConvert.CommonGetStr(params.get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminYesil2InfoSelect - iU - parameter not exists >> " + commonCode.ERPCOMPSEQ);
            }
            result = dao.ExAdminIuYesilInfoSelect(params, conVo);

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

            // 1. ERP 편성 예산 과목 정보 조회
            Map<String, Object> bgListParams = new HashMap<String, Object>();

            bgListParams.put("erpCompSeq", CommonConvert.CommonGetEmpVO().getErpCoCd());
            bgListParams.put("cdDeptPipe", params.get("cdDeptPipe"));
            bgListParams.put("cdBudgetPipe", params.get("cdBudgetPipe"));
            bgListParams.put("cdBizplanPipe", params.get("cdBizplanPipe"));
            bgListParams.put("cdBudgetAcctPipe", params.get("cdBudgetAcctPipe"));
            bgListParams.put("cdBudgetAcctPipe2", params.get("cdBudgetAcctPipe2"));
            bgListParams.put("fromDt", params.get("fromDt"));
            bgListParams.put("toDt", params.get("toDt"));
            bgListParams.put("compSeq",params.get("compSeq"));



            List<Map<String, Object>> bgacctList = dao.selectCommonBgacctCode(bgListParams, conVo);

            result.setAaData(bgacctList);
            result.setSuccess();

        } catch (Exception e) {
            result.setFail("예실대비현황 리스트 조회 실패", e);
        }

        return result;
    }


    public ResultVO ExAdminYesilBizPlanCheck(Map<String, Object> params, ConnectionVO conVo) throws Exception {
      ResultVO result = new ResultVO();

      try {
        params.put("erpCompSeq", CommonConvert.CommonGetEmpVO().getErpCoCd());

        Map<String,Object> bizPlanCheck = dao.ExAdminYesilBizPlanCheck(params,conVo);

        result.setaData(bizPlanCheck);
        result.setSuccess();


      } catch (Exception e) {
        result.setFail("사업계획 사용/미사용 체크 조회 실패 ",e);

      }

      return result;

    }



}
