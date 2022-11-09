package expend.ex.user.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import common.enums.lang.ComboBoxName;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckAuthorityException;
import common.helper.exception.CheckErpVersionException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundLogicException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.CommonMapper;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import expend.ex.admin.yesil2.BExAdminYesil2Service;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.expend.BExUserService;
import expend.ex.user.report.BExUserReportService;
import expend.ex.user.yesil.BExUserYesilService;
import net.sf.json.JSONArray;


@Controller
public class VExUserContentController {

    //
    protected org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    // common service
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    // code service
    @Resource(name = "BExUserCodeService")
    private BExUserCodeService codeService;

    // expend service
    @Resource(name = "BExUserService")
    private BExUserService userService;

    @Resource(name = "BExUserReportService")
    private BExUserReportService reportService;

    // 예실대비 현황 2.0 - Jun
    @Resource(name = "BExAdminYesil2Service")
    private BExAdminYesil2Service yesil2Service;

    // ext service
    @Resource(name = "BExUserYesilService")
    private BExUserYesilService yesilService;

    /* ==================================================================================================== */
    /* 나의 지출결의 현황 - ERPiU, iCUBE */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 지출결의 현황", order = 1401, gid = 140)
    @RequestMapping("/ex/user/report/ExApprovalList.do")
    public ModelAndView ExUserExpendReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            // LoginVO
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();

            // ConnectionVO
            ConnectionVO conVo = new ConnectionVO();
            conVo = cmInfo.CommonGetConnectionInfo(login);

            // path def
            if (conVo.isERPIU()) {
                mv.setViewName(CommonMapper.GetEXUUserExpendReport());
            } else if (conVo.isICUBE()) {
                mv.setViewName(CommonMapper.GetEXIUserExpendReport());
            } else {
                throw new CheckErpVersionException("ConnectionVO erp type not in ( ERPiU, iCUBE )");
            }

            // vars - VO
            ResultVO bizList = new ResultVO();
            ExCommonResultVO commonParam = new ExCommonResultVO();
            ExCommonResultVO allSts = new ExCommonResultVO();

            // vars - HashMap
            Map<String, Object> bizParam = new HashMap<String, Object>();
            Map<String, Object> firstData = new HashMap<String, Object>();

            // vars - List<VO>
            List<ExCommonResultVO> docStsList = new ArrayList<ExCommonResultVO>();

            // var - List<HashMap>
            List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();

            // var - String
            String pCompSeq = login.getCompSeq();
            String plangCode = login.getLangCode();
            String pGroupSeq = login.getGroupSeq();

            // set parameters - params
            params.put(commonCode.ERPCOMPSEQ, login.getErpCoCd());
            params.put(commonCode.COMPSEQ, login.getCompSeq());
            params.put(commonCode.EMPSEQ, login.getUniqId());

            // set parameters - commonParam ( 공통코드 - 문서상태 )
            commonParam.setGroupSeq(login.getGroupSeq());
            commonParam.setCompSeq(login.getCompSeq());
            commonParam.setLangCode(login.getLangCode());
            commonParam.setSearchType(commonCode.DOCSTATUS);

            // select code list
            docStsList = codeService.ExCodeCommonCodeListInfoSelect(commonParam);

            // code list add ("전체")
            switch (login.getLangCode().toUpperCase()) {
                case "KR":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLKR.toString());
                    break;
                case "EN":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLEN.toString());
                    break;
                case "JP":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLJP.toString());
                    break;
                case "CN":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLCN.toString());
                    break;
                default :
                	break;
            }

            if (allSts.getCommonName() == null || allSts.getCommonName().equals("")) {
                allSts.setCommonName(ComboBoxName.COMBOBOXALLKR.toString());
            }

            allSts.setCommonCode(commonCode.EMPTYSTR);
            docStsList.add(0, allSts);

            // set parameters - params ( 공통코드 - 문서상태 )
            params.put("commonCodeListDocStatus", JSONArray.fromObject(docStsList));

            // set parameters - bizParam
            bizParam.put(commonCode.COMPSEQ, login.getCompSeq());
            bizParam.put(commonCode.LANGCODE, login.getLangCode());
            bizParam.put(commonCode.CODETYPE, commonCode.BIZ);

            // select bizarea list
            bizList = codeService.ExCommonCodeInfoSelect(bizParam);
            rList = bizList.getAaData();

            // bizarea list add ("전체")
            switch (login.getLangCode().toUpperCase()) {
                case "KR":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLKR.toString());
                    break;
                case "EN":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLEN.toString());
                    break;
                case "JP":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLJP.toString());
                    break;
                case "CN":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLCN.toString());
                    break;
                default :
                	break;
            }

            if (firstData.get("commonCode") == null || firstData.get("commonCode").equals("")) {
                firstData.put("commonCode", ComboBoxName.COMBOBOXALLKR.toString());
            }

            firstData.put("commonCode", "");
            rList.add(0, firstData);

            // select lang pack list
            CustomLabelVO customLabel = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            // add object
            mv.addObject("ViewBag", params);
            mv.addObject("CL", customLabel.getData());
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            mv.addObject("bizList", CommonConvert.CommonGetListMapToJson(rList));

        } catch (NotFoundLoginSessionException e) {
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (NotFoundConnectionException e) {
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (CheckErpVersionException e) {
            mv.setViewName(CommonMapper.GetExErrorCheckERP());
        } catch (Exception e) {
            mv.setViewName(CommonMapper.GetExError());
        }

        return mv;
    }

    /* ==================================================================================================== */
    /* 나의 지출결의 상세 현황 - ERPiU, iCUBE */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 지출결의 상세 현황", order = 1405, gid = 140)
    @RequestMapping("/ex/user/report/ExExpendSlipReport.do")
    public ModelAndView ExUserExpendSlipReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            // LoginVO
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();

            // ConnectionVO
            ConnectionVO conVo = new ConnectionVO();
            conVo = cmInfo.CommonGetConnectionInfo(login);

            // path def
            if (conVo.isERPIU()) {
                mv.setViewName(CommonMapper.GetEXUUserExpendSlipReport());
            } else if (conVo.isICUBE()) {
                mv.setViewName(CommonMapper.GetEXIUserExpendSlipReport());
            } else {
                throw new CheckErpVersionException("ConnectionVO erp type not in ( ERPiU, iCUBE )");
            }

            // vars - VO
            ResultVO bizList = new ResultVO();
            ExCommonResultVO commonParam = new ExCommonResultVO();
            ExCommonResultVO allSts = new ExCommonResultVO();

            // vars - HashMap
            Map<String, Object> bizParam = new HashMap<String, Object>();
            Map<String, Object> firstData = new HashMap<String, Object>();

            // vars - List<VO>
            List<ExCommonResultVO> docStsList = new ArrayList<ExCommonResultVO>();

            // var - List<HashMap>
            List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();

            // var - String
            String pCompSeq = login.getCompSeq();
            String plangCode = login.getLangCode();
            String pGroupSeq = login.getGroupSeq();

            // set parameters - params
            params.put(commonCode.ERPCOMPSEQ, login.getErpCoCd());
            params.put(commonCode.COMPSEQ, login.getCompSeq());
            params.put(commonCode.EMPSEQ, login.getUniqId());

            // set parameters - commonParam ( 공통코드 - 문서상태 )
            commonParam.setGroupSeq(login.getGroupSeq());
            commonParam.setCompSeq(login.getCompSeq());
            commonParam.setLangCode(login.getLangCode());
            commonParam.setSearchType(commonCode.DOCSTATUS);

            // select code list
            docStsList = codeService.ExCodeCommonCodeListInfoSelect(commonParam);

            // code list add ("전체")
            switch (login.getLangCode().toUpperCase()) {
                case "KR":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLKR.toString());
                    break;
                case "EN":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLEN.toString());
                    break;
                case "JP":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLJP.toString());
                    break;
                case "CN":
                    allSts.setCommonName(ComboBoxName.COMBOBOXALLCN.toString());
                    break;
                default :
                	break;
            }

            if (allSts.getCommonName() == null || allSts.getCommonName().equals("")) {
                allSts.setCommonName(ComboBoxName.COMBOBOXALLKR.toString());
            }

            allSts.setCommonCode(commonCode.EMPTYSTR);
            docStsList.add(0, allSts);

            // set parameters - params ( 공통코드 - 문서상태 )
            params.put("commonCodeListDocStatus", JSONArray.fromObject(docStsList));

            // set parameters - bizParam
            bizParam.put(commonCode.COMPSEQ, login.getCompSeq());
            bizParam.put(commonCode.LANGCODE, login.getLangCode());
            bizParam.put(commonCode.CODETYPE, commonCode.BIZ);

            // select bizarea list
            bizList = codeService.ExCommonCodeInfoSelect(bizParam);
            rList = bizList.getAaData();

            // bizarea list add ("전체")
            switch (login.getLangCode().toUpperCase()) {
                case "KR":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLKR.toString());
                    break;
                case "EN":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLEN.toString());
                    break;
                case "JP":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLJP.toString());
                    break;
                case "CN":
                    firstData.put("commonCode", ComboBoxName.COMBOBOXALLCN.toString());
                    break;
                default :
                	break;
            }

            if (login.getLangCode().equals("en")) {
              firstData.put("commonName", "all");
            } else {
              firstData.put("commonName", "전체");
            }

            firstData.put("commonCode", "");
            rList.add(0, firstData);

            // select lang pack list
            CustomLabelVO customLabel = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            // add object
            mv.addObject("ViewBag", params);
            mv.addObject("CL", customLabel.getData());
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            mv.addObject("bizList", CommonConvert.CommonGetListMapToJson(rList));

        } catch (NotFoundLoginSessionException e) {
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (NotFoundConnectionException e) {
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (CheckErpVersionException e) {
            mv.setViewName(CommonMapper.GetExErrorCheckERP());
        } catch (Exception e) {
            mv.setViewName(CommonMapper.GetExError());
        }

        return mv;
    }

    /* ==================================================================================================== */
    /* 나의 카드 사용 현황 - ERPiU, iCUBE */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 카드사용 현황", order = 1402, gid = 140)
    @RequestMapping("/ex/user/report/ExUseCardlList.do")
    public ModelAndView ExUserCardReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            // LoginVO
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();

            // ConnectionVO
            ConnectionVO conVo = new ConnectionVO();
            conVo = cmInfo.CommonGetConnectionInfo(login);

            // path def
            if (conVo.isERPIU()) {
                //기존 tiles 와 구분하여 푸딩UI를 적용하기 위해 ".pudding_contents" 붙임. 해당 부분이 없으면 푸딩 tiles를 적용받지 않음.
                mv.setViewName(CommonMapper.GetEXUUserCardReport() + ".pudding_contents");
            } else if (conVo.isICUBE()) {
                mv.setViewName(CommonMapper.GetEXIUserCardReport() + ".pudding_contents");
            } else {
                throw new CheckErpVersionException("ConnectionVO erp type not in ( ERPiU, iCUBE )");
            }

            // vars - String
            String pGroupSeq = login.getGroupSeq();
            String pCompSeq = login.getCompSeq();
            String plangCode = login.getLangCode();

            // set parameters - params
            params.put("g20YN", conVo.getG20YN());
            params.put(commonCode.COMPSEQ, login.getCompSeq());
            params.put(commonCode.EMPSEQ, login.getUniqId());

            // select lang pack
            CustomLabelVO customLabel = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            // set parameters - mv
            mv.addObject("CL", customLabel.getData());
            mv.addObject("ViewBag", params);

        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", "NotFoundLoginSessionException");
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (NotFoundConnectionException e) {
            mv.addObject("errMsg", "NotFoundConnectionException");
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (CheckErpVersionException e) {
            mv.addObject("errMsg", "CheckErpVersionException");
            mv.setViewName(CommonMapper.GetExErrorCheckERP());
        } catch (Exception e) {
            mv.addObject("errMsg", "Exception");
            mv.setViewName(CommonMapper.GetExError());
        }

        return mv;
    }

    /* ==================================================================================================== */
    /* 나의 예실대비 현황(iCUBE) - iCUBE */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 예실대비 현황(iCUBE)", order = 1702, gid = 170)
    @RequestMapping("/ex/user/yesil/ExUserYesilReport.do")
    public ModelAndView ExUserYesilReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            // LoginVO
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();

            // ConnectionVO
            ConnectionVO conVo = new ConnectionVO();
            conVo = cmInfo.CommonGetConnectionInfo(login);

            // path def
            if (conVo.isICUBE()) {
                mv.setViewName(CommonMapper.GetEXIUserBudgetReport());
            } else if (conVo.isERPIU()) {
                throw new CheckErpVersionException("ERPiU 연동 전용기능입니다.");
            } else {
                throw new CheckErpVersionException("ConnectionVO erp type not in ( ERPiU, iCUBE )");
            }

            // vars - VO
            ResultVO result = new ResultVO();

            // vars - String
            String pGroupSeq = login.getGroupSeq();
            String pCompSeq = login.getCompSeq();
            String plangCode = login.getLangCode();

            // select lang pack
            CustomLabelVO customLabel = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            // set parameters - params
            params.put(commonCode.ERPCOMPSEQ, codeService.getErpCompSeq(login, conVo.getErpTypeCode(), login.getCompSeq()));
            params.put(commonCode.COMPSEQ, login.getCompSeq());

            // TODO : ??
            result = yesilService.ExUserYesilSendParam(params);

            // set parameters - mv
            mv.addObject("CL", customLabel.getData());
            mv.addObject("ViewBag", result);

        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", "NotFoundLoginSessionException");
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (NotFoundConnectionException e) {
            mv.addObject("errMsg", "NotFoundConnectionException");
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (CheckErpVersionException e) {
            mv.addObject("errMsg", "CheckErpVersionException");
            mv.setViewName(CommonMapper.GetExErrorCheckERP());
        } catch (Exception e) {
            mv.addObject("errMsg", "Exception");
            mv.setViewName(CommonMapper.GetExError());
        }

        return mv;
    }

    /* ==================================================================================================== */
    /* 나의 예실대비 현황(ERPiU) - ERPiU */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 예실대비 현황(ERPiU)", order = 1703, gid = 170)
    @RequestMapping("/ex/user/yesil/ExUserYesil2Report.do")
    public ModelAndView ExUserYesil2Report(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            // LoginVO
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();

            // ConnectionVO
            ConnectionVO conVo = new ConnectionVO();
            conVo = cmInfo.CommonGetConnectionInfo(login);

            // path def
            if (conVo.isERPIU()) {
                mv.setViewName(CommonMapper.GetEXUUserBudgetReport());
            } else if (conVo.isICUBE()) {
                throw new CheckErpVersionException("ERPiU 연동 전용기능입니다.");
            } else {
                throw new CheckErpVersionException("ConnectionVO erp type not in ( ERPiU, iCUBE )");
            }

            // vars - VO
            ResultVO result = new ResultVO();

            // vars - String
            String pGroupSeq = login.getGroupSeq();
            String pCompSeq = login.getCompSeq();
            String plangCode = login.getLangCode();

            // select lang pack
            CustomLabelVO customLabel = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            // set parameters - params
            params.put(commonCode.ERPCOMPSEQ, codeService.getErpCompSeq(login, conVo.getErpTypeCode(), login.getCompSeq()));
            params.put(commonCode.COMPSEQ, login.getCompSeq());

            // TODO : ??
            result = yesilService.ExUserYesil2SendParam(params);

            // set parameters - mv
            mv.addObject("ViewBag", result);
            mv.addObject("CL", customLabel.getData());

        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", "NotFoundLoginSessionException");
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (NotFoundConnectionException e) {
            mv.addObject("errMsg", "NotFoundConnectionException");
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (CheckErpVersionException e) {
            mv.addObject("errMsg", "CheckErpVersionException");
            mv.setViewName(CommonMapper.GetExErrorCheckERP());
        } catch (Exception e) {
            mv.addObject("errMsg", "Exception");
            mv.setViewName(CommonMapper.GetExError());
        }

        return mv;
    }
    /* ==================================================================================================== */
    /* 나의 예실대비 현황 2.0 (ERPiU) - ERPiU  이준성 개발 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 예실대비 현황 2.0 (ERPiU)", order = 1704, gid = 170)
    @RequestMapping("/ex/user/yesil/ExUserERPiUYesilReport.do")
    public ModelAndView ExUserERPiUYesilReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {

          /* 변수정의 */
          LoginVO loginVo = CommonConvert.CommonGetEmpVO();
          ResultVO result = new ResultVO();

          /* ERP 연결정보 조회 */
          ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
          /* ERP 회사 코드 확인 */
          params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
          params.put("compSeq", loginVo.getCompSeq());

          result = yesil2Service.ExAdminIuYesilSendParam(params);
          /* 명칭정보 조회 */
          String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
          String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
          String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
          CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
          /* 반환처리 */
          mv.addObject("CL", vo.getData());
          mv.addObject("ViewBag", result);
          /* View path 정의 */
          if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals("ERPiU")) {
              mv.setViewName(CommonMapper.GetEXUUserERPiUBudgetReport());
          } else {
              throw new NotFoundLogicException("ERPiU전용 메뉴 입니다.", conVo.getErpTypeCode());
          }
      } catch (NotFoundLogicException e) {
          mv.addObject("errMsg", e.getMessage());
          mv.setViewName("/expend/common/error/" + commonExPath.CMERRORCHECKERP);
      } catch (CheckAuthorityException e) {
          mv.addObject("errMsg", e.getMessage());
          mv.setViewName(CommonMapper.GetExErrorCheckAuth());
      } catch (NotFoundLoginSessionException e) {
          mv.addObject("errMsg", e.getMessage());
          mv.setViewName(CommonMapper.GetExErrorCheckLogin());
      } catch (Exception e) {
          e.printStackTrace();
          ExpInfo.ProcessLog(e.getLocalizedMessage());
          mv.addObject("errMsg", e.getMessage());
          mv.setViewName(CommonMapper.GetExError());
      }

        return mv;
    }

    /* ==================================================================================================== */
    /* 나의 세금계산서 현황(iCUBE) - iCUBE */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 세금계산서 현황(iCUBE)", order = 1403, gid = 140)
    @RequestMapping("/ex/user/report/ExUserETaxiCUBEList.do")
    public ModelAndView ExUserETaxiCUBEList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            // LoginVO
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();

            // ConnectionVO
            ConnectionVO conVo = new ConnectionVO();
            conVo = cmInfo.CommonGetConnectionInfo(login);

            // path def
            if (conVo.isERPIU()) {
                throw new CheckErpVersionException("iCUBE 연동 전용기능입니다.");
            } else if (conVo.isICUBE()) {
                mv.setViewName(CommonMapper.GetEXIUserEtaxReport());
            } else {
                throw new CheckErpVersionException("ConnectionVO erp type not in ( ERPiU, iCUBE )");
            }

            // vars - VO
            ExCommonResultVO commonParam = new ExCommonResultVO();

            // vars - String
            String pGroupSeq = login.getGroupSeq();
            String pCompSeq = login.getCompSeq();
            String plangCode = login.getLangCode();

            // select lang pack
            CustomLabelVO customLabel = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            // set parameters - params
            params.put("g20YN", conVo.getG20YN());
            params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
            params.put(commonCode.EMPSEQ, login.getUniqId());

            // set parameters - mv
            mv.addObject("CL", customLabel.getData());
            mv.addObject("ViewBag", params);
            mv.addObject("ifUseSystem", conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", "NotFoundLoginSessionException");
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (NotFoundConnectionException e) {
            mv.addObject("errMsg", "NotFoundConnectionException");
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (CheckErpVersionException e) {
            mv.addObject("errMsg", "CheckErpVersionException");
            mv.setViewName(CommonMapper.GetExErrorCheckERP());
        } catch (Exception e) {
            mv.addObject("errMsg", "Exception");
            mv.setViewName(CommonMapper.GetExError());
        }

        return mv;
    }

    /* ==================================================================================================== */
    /* 나의 세금계산서 현황(ERPiU) - ERPiU */
    /* ==================================================================================================== */
    @IncludedInfo(name = "나의 세금계산서 현황(ERPiU)", order = 1404, gid = 140)
    @RequestMapping("/ex/user/report/ExUserETaxERPiUList.do")
    public ModelAndView ExUserETaxERPiUList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.USER)) {
                throw new CheckAuthorityException(commonCode.USER);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 커넥션 설정 확인 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            /* 변수정의 */
            LoginVO login = CommonConvert.CommonGetEmpVO();
            @SuppressWarnings("unused")
            ExCommonResultVO commonParam = new ExCommonResultVO();
            params.put("g20YN", conVo.getG20YN());
            params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
            params.put(commonCode.EMPSEQ, login.getUniqId());
            mv.addObject("ViewBag", params);
            mv.addObject("ifUseSystem", conVo.getErpTypeCode());
            Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
            String pCompSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
            String plangCode = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.LANGCODE)));
            String pGroupSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.GROUPSEQ)));
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            /* View path 정의 [UserCardReport.jsp] */
            mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.USERETAXERPIUREPORT);
        } catch (CheckAuthorityException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckAuth());
        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (Exception e) {
            logger.error(e);
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
        }
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 공통코드 조회 테스트 페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "공통코드 조회 테스트 페이지", order = 9101, gid = 910)
    @RequestMapping("/expend/ex/user/UserCmmCodePopTestPage.do")
    public ModelAndView cmmCodePopTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        /* View path 정의 [UserCmmCodePopTestPage.jsp] */
        mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.USERCMMCODEPOPTESTPAGE);
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 미전송 사유보기 팝업 테스트 페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "미전송 사유보기 팝업 테스트 페이지", order = 9102, gid = 910)
    @RequestMapping("/expend/ex/user/CmmFailPopTestPage.do")
    public ModelAndView cmmFailPopTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        /* View path 정의 [CmmFailPopTestPage.jsp] */
        mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.CMMFAILPOPTESTPAGE);
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 명칭설정 테스트 페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "명칭설정 테스트 페이지", order = 9103, gid = 910)
    @RequestMapping("/expend/ex/user/cmmCustomLabelTestPage.do")
    public ModelAndView cmmCustomLabelTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        LoginVO login = CommonConvert.CommonGetEmpVO();
        String pCompSeq = CommonConvert.CommonGetStr(login.getCompSeq());
        String plangCode = CommonConvert.CommonGetStr(login.getLangCode());
        String pGroupSeq = CommonConvert.CommonGetStr(login.getGroupSeq());
        CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
        //System.out.println(vo.toString());
        mv.addObject("CL", vo.getData());
        /* View path 정의 [CustomLabelTestPage.jsp] */
        mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.CUSTOMLABELTESTPAGE);
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 법인카드 영역 법인 카드 조회 팝업 테스트 페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "법인카드 조회 테스트 페이지", order = 902, gid = 90)
    @RequestMapping("/expend/ex/user/UserCardUsageHistoryPopTestPage.do")
    public ModelAndView ExUserCardUsageHistoryPopTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        /* View path 정의 [UserCmmCodePopTestPage.jsp] */
        mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.USERCARDUSAGEHISTORYPOPTESTPAGE);
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 항목관리 영역 항목 관리 조회 팝업 테스트 페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "관리항목 조회 테스트 페이지", order = 904, gid = 90)
    @RequestMapping("/expend/ex/user/UserMngPopTestPage.do")
    public ModelAndView ExUserMngPopTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        /* View path 정의 [UserCmmCodePopTestPage.jsp] */
        mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.USERMNGPOPTESTPAGE);
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 지출결의 인터락 URL 인터락 URL 테스트 페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "인터락 URL 테스트 페이지", order = 905, gid = 90)
    @RequestMapping("/expend/ex/user/ExUserInterlockUrlTestPage.do")
    public ModelAndView ExUserInterlockUrlTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        /* View path 정의 [UserCmmCodePopTestPage.jsp] */
        mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.USERINTERLOCKURLTESTPAGE);
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 지출결의 버튼설정 테스트 페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "지출결의 버튼설정 테스트 페이지", order = 906, gid = 90)
    @RequestMapping("/expend/ex/user/ExUserButtonSettingTestPage.do")
    public ModelAndView ExUserButtonSettingTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        LoginVO login = CommonConvert.CommonGetEmpVO();
        String result = "[]";
        /* 버튼 설정 정보 조회 */
        try {
            HashMap<String, Object> param = new HashMap<>();
            param.put("formSeq", "10065");
            result = CommonConvert.CommonGetListMapToJson(userService.ExExpendButtonInfoSelect(param).getAaData());
        } catch (Exception e) {
            logger.error(e);
            result = "[]";
        } finally {
            /* View path 정의 [UserCmmCodePopTestPage.jsp] */
            mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.USERBUTTONSETTINGTESTPAGE);
            mv.addObject("btnInfo", result);
            mv.addObject("langKind", login.getLangCode());
        }
        return mv;
    }

    /* ==================================================================================================== */
    /* [테스트] 예실대비 현황 예실대비 현황 - 테스트 페이지 - 샘플페이지 */
    /* ==================================================================================================== */
    @IncludedInfo(name = "사용자 예실대비현황 샘플", order = 1701, gid = 170) // 사용자 170 / 관리자 180
    @RequestMapping("/expend/ex/user/ExUserYesilSample.do")
    public ModelAndView ExUserYesilSamplePage(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.setViewName(commonExPath.USERCONTENTPATH + commonExPath.USERYESILSAMPLEPAGE);
        return mv;
    }
}
