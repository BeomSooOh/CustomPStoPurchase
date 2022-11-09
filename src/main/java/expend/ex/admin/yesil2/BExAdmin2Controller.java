package expend.ex.admin.yesil2;

import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
//import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
//import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
//import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.ex.user.code.BExUserCodeService;

@Controller
public class BExAdmin2Controller {

	//private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    /* 변수정의 - Class */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    // 예실대비 현황 2.0 - Jun
    @Resource(name = "BExAdminYesil2Service")
    private BExAdminYesil2Service yesil2Service;
    //
    @Resource(name = "BExUserCodeService")
    private BExUserCodeService codeService;


    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예실대비2(PIVOT) 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminIuYesilInfoSelect.do")
    public ModelAndView ExAdminIuYesilInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        ResultVO result = new ResultVO();
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));

        try {

            params.put("erpType", conVo.getErpTypeCode());
            params.put(CommonInterface.commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO().getCompSeq());
            params.put("empSeq", CommonConvert.CommonGetEmpVO().getUniqId());
            params.put("procType", "yesil");

            ResultVO yesilResult = yesil2Service.ExAdminYesilList(params, conVo);

            if (CommonConvert.CommonGetStr(yesilResult.getResultCode()).equals(commonCode.SUCCESS)) {
                result.setAaData(yesilResult.getAaData());
                result.setSuccess();
            } else {
                result = yesilResult;
            }

        } catch (Exception e) {
            result.setFail("예실대비 현황 리스트 조회 실패");
        }

        mv.addObject("result", result);
        mv.setViewName("jsonView");
        return mv;
    }

    /* 사업계획 사용/미사용 체크 */
    @RequestMapping("/ex/expend/admin/ExAdminIuYesilBizPlanCheck.do")
    public ModelAndView ExAdminIuYesilInfoBizPlanCheck(@RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception{

      ModelAndView mv = new ModelAndView();

      ResultVO result = new ResultVO();
      LoginVO loginVo = CommonConvert.CommonGetEmpVO();
      ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));


      try {
        ResultVO bizPlanCheckResult = yesil2Service.ExAdminYesilBizPlanCheck(params,conVo);

        if (CommonConvert.CommonGetStr(bizPlanCheckResult.getResultCode()).equals(commonCode.SUCCESS)) {

          result.setaData(bizPlanCheckResult.getaData());
          result.setSuccess();
      } else {
          result = bizPlanCheckResult;
      }

      } catch (Exception e) {
        result.setFail(" 사업계획체크 실패 ");
      }

      mv.addObject("result", result);
      mv.setViewName("jsonView");

      return mv;
    }

}
