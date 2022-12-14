package expend.ex.admin.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import base.BaseCtl;
import bizbox.orgchart.service.vo.LoginVO;
import bizbox.orgchart.util.JedisClient;
import cloud.CloudConnetInfo;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckAuthorityException;
import common.helper.exception.CheckErpTypeException;
import common.helper.exception.NotFoundLogicException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.batch.CommonBatchCmsConfigVO;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.CommonMapper;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCommonResultVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import expend.ex.admin.acct.BExAdminAcctService;
import expend.ex.admin.card.BExAdminCardService;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.admin.item.BExAdminItemService;
import expend.ex.admin.yesil.BExAdminYesilService;
import expend.ex.admin.yesil2.BExAdminYesil2Service;
import expend.ex.user.code.BExUserCodeService;
import net.sf.json.JSONArray;

@Controller
public class VExAdminContentController extends BaseCtl {

    // Service
    @Resource(name = "BExAdminAcctService")
    private BExAdminAcctService acctService;

    @Resource(name = "BExAdminItemService")
    private BExAdminItemService itemService;

    @Resource(name = "BExAdminCardService")
    private BExAdminCardService cardService;

    @Resource(name = "BExAdminYesilService")
    private BExAdminYesilService yesilService;

    //???????????? ?????? 2.0 - Jun
    @Resource(name = "BExAdminYesil2Service")
    private BExAdminYesil2Service yesil2Service;

    @Resource(name = "BExUserCodeService")
    private BExUserCodeService codeService;

    @Resource(name = "CommonBatchCmsService")
    private common.batch.cms.CommonBatchCmsService CommonBatchCmsService;

    @Resource(name = "BExAdminConfigService")
    private BExAdminConfigService exAdminConfigService;

    @Resource(name = "BExUserCodeService")
    private BExUserCodeService exUserCodeService;

    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* ?????? ?????? ?????? ?????? */

    /**
     * <pre>
     * ??? ?????????
     *   ??? ??????
     *     ??? ???????????? ?????? [gid : 101]
     *       ??? ???????????? ?????? [gid : 101 / order : 1000]
     *       ??? ???????????? ??????(?????????) [gid : 101 / order : 1001]
     *       ??? ???????????? ???????????? [gid : 101 / order : 1002]
     *       ??? ???????????? ?????? [gid : 101 / order : 1003]
     *       ??? ?????? ?????? ?????? [gid : 101 / order : 1004]
     *       ??? iCUBE ???????????? ?????? [gid : 101 / order : 1005]
     *       ??? ?????????????????????(iCUBE) [gid : 101 / order : 1006]
     *       ??? ?????????????????????(ERPiU) [gid : 101 / order : 1007]
     *     ??? ???????????? ?????? [gid : 102]
     *       ??? ?????? ?????? [gid : 102 / order : 1000]
     *       ??? ???????????? ?????? [gid : 102 / order : 1001]
     *       ??? ???????????? ?????? [gid : 102 / order : 1002]
     *       ??? ?????? ??? ???????????? & ???????????? ?????? [gid : 102 / order : 1003]
     *       ??? ?????? ?????? [gid : 102 / order : 1004]
     *       ??? ?????? ?????? [gid : 102 / order : 1005]
     *       ??? ???????????? ?????? [gid : 102 / order : 1006]
     *       ??? ?????? ?????? [gid : 102 / order : 1007]
     *       ??? ?????? ?????? [gid : 102 / order : 1008]
     *       ??? ??????????????????????????? ?????? [gid : 102 / order : 1009]
     *       ??? ???????????? [gid : 102 / order : 1010]
     *       ??? ???????????? ?????? [gid : 102 / order : 1011]
     *     ??? ???????????? [gid : 103]
     *       ??? ???????????? ??????(iCUBE) [gid : 103 / order : 1000]
     *       ??? ???????????? ??????(ERPiU) [gid : 103 / order : 1000]
     *       ??? ???????????? ??????(ERPiU) [gid : 103 / order : 1000]
     * </pre>
     */
    @IncludedInfo(name = "????????? > ?????? > ???????????? ?????? > ?????? ??????", order = 1005, gid = 102)
    @RequestMapping("/ex/admin/config/ExItemSetting.do")
    public ModelAndView ExSettingItems(@RequestParam Map<String, Object> param) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            Map<String, Object> result = new HashMap<String, Object>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            setCommonParams(sendParam);
            result = itemService.ExAdminItemConfigSendParam();
            /* ???????????? ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            CommonConvert.CommonGetEmpVO();
            CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ????????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result); /* result{ empInfo={}, formInfo= [], erpTypeCode= } */
            mv.setViewName(CommonMapper.GetEXAdminItemConfig());
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

    @IncludedInfo(name = "????????? > ?????? > ???????????? ?????? > ???????????? ??????", order = 1000, gid = 101)
    @RequestMapping("/ex/admin/report/ExApprovalSendList.do")
    public ModelAndView ExAdminExpendManagerReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String groupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, groupSeq);
            /* ERP ???????????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ)));
            /* ????????? ????????? ?????? */
            ResultVO bizList = new ResultVO();
            Map<String, Object> bizParam = new HashMap<String, Object>();
            bizParam.put("compSeq", CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            bizParam.put("langCode", CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            bizParam.put(commonCode.CODETYPE, commonCode.BIZ);
            bizList = codeService.ExCommonCodeInfoSelect(bizParam);
            List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
            rList = bizList.getAaData();
            Map<String, Object> firstData = new HashMap<String, Object>();
            if (loginVo.getLangCode().equals("en")) {
                firstData.put("commonName", "all");
            } else {
                firstData.put("commonName", "??????");

            }
            firstData.put("commonCode", "");
            rList.add(0, firstData);
            /* ?????? ?????? */
            mv.addObject("erpType", conVo.getErpTypeCode());
            mv.addObject("CL", vo.getData());
            mv.addObject("bizList", CommonConvert.CommonGetListMapToJson(rList));
            // mv.addObject( "AuthPageYN", 'N' );

            if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                mv.setViewName(CommonMapper.GetEXUAdminExpendConfirmReport());
            } else if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
                mv.setViewName(CommonMapper.GetEXIAdminExpendConfirmReport());
            } else {
                throw new CheckErpTypeException("ERP ?????? ?????? ?????? ?????? ??????ERP ?????? ?????? ????????? ???????????????. ERPiU ??? iCUBE ????????? ???????????????.");
            }
        } catch (CheckAuthorityException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckAuth());
        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (CheckErpTypeException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
        }
        return mv;
    }

    /* Contents View - ?????? (?????????) - ???????????? ?????? - ?????? ?????? ?????? */
    @IncludedInfo(name = "?????? ?????? ??????", order = 1503, gid = 150)
    @RequestMapping("/ex/admin/report/ExUseCardlList.do")
    public ModelAndView ExAdminCardReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ????????? ?????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            /* ?????? ?????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            /* buildType ??????(?????????,??????????????? ) */
            boolean bool = false;

            /* ??????????????? cms ?????? ?????? ??? */
            Map<String, String> param = new HashMap<String, String>();
            param.put("compSeq", pCompSeq);
            param.put("groupSeq", pGroupSeq);

            List<CommonBatchCmsConfigVO> cmsConfigListVo = new ArrayList<CommonBatchCmsConfigVO>();
            cmsConfigListVo = CommonBatchCmsService.selectCms(param);
            String cmsDate = "";
            if (!cmsConfigListVo.isEmpty()) {
                cmsDate = cmsConfigListVo.get(0).getModifyDate();
            }

            JedisClient jedisClient = CloudConnetInfo.getJedisClient();

            String buildType = jedisClient.getBuildType();

            if (buildType != null && buildType.equals("build") && !cmsConfigListVo.isEmpty()) {
                bool = true;
            }

            /* ?????? ????????? ?????? ?????? */
            Map<String, Object> result = new HashMap<String, Object>();
            result = cardService.ExAdminCardConfigSendParam();
            result.put("g20YN", conVo.getG20YN());
            /* ?????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result); /* result{ empInfo={}, erpTypeCode=, ex00001=[], ex00004=[] } */
            mv.addObject("buildType", bool);
            mv.addObject("cmsDate", cmsDate);

            if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                mv.setViewName(CommonMapper.GetEXUAdminCardReport());
            } else if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
                mv.setViewName(CommonMapper.GetEXIAdminCardReport());
            } else {
                throw new CheckErpTypeException("ERP ?????? ?????? ?????? ?????? ??????ERP ?????? ?????? ????????? ???????????????. ERPiU ??? iCUBE ????????? ???????????????.");
            }

        } catch (CheckAuthorityException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckAuth());
        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (CheckErpTypeException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckErpSetting());
        } catch (Exception e) {
            e.printStackTrace();
            ExpInfo.ProcessLog(e.getLocalizedMessage());
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
        }
        return mv;
    }

    /* [] ????????? - ?????? - ???????????? ?????? ??????(?????????) ????????? */
    @IncludedInfo(name = "???????????? ?????? ??????", order = 1502, gid = 150)
    @RequestMapping("/ex/admin/report/ExApprovalSlipList.do")
    public ModelAndView ExSlipReportExpendList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            ExCommonResultVO commonParam = new ExCommonResultVO();
            List<ExCommonResultVO> commonListCode = new ArrayList<ExCommonResultVO>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* ????????? ?????? */
            if (commonParam.getGroupSeq() == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq()).equals("")) {
                commonParam.setGroupSeq(loginVo.getGroupSeq());
            }
            setCommonParams(sendParam);
            commonParam.setCompSeq(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            commonParam.setLangCode(CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE).toString());
            /* ???????????? - ???????????? */
            commonParam.setSearchType(commonCode.DOCSTATUS);
            commonListCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
            ExCommonResultVO allSts = new ExCommonResultVO();
            allSts.setCommonCode(commonCode.EMPTYSTR);
            if (loginVo.getLangCode().equals("en")) {
                allSts.setCommonName("all");
            } else {
                allSts.setCommonName("??????");
            }
            commonListCode.add(0, allSts);
            sendParam.put("commonCodeListDocStatus", JSONArray.fromObject(commonListCode));
            /* ????????? ????????? ?????? */
            ResultVO bizList = new ResultVO();
            Map<String, Object> bizParam = new HashMap<String, Object>();
            bizParam.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.GROUPSEQ).toString());
            bizParam.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            bizParam.put(commonCode.LANGCODE, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE).toString());
            bizParam.put(commonCode.CODETYPE, commonCode.BIZ);
            bizList = codeService.ExCommonCodeInfoSelect(bizParam);
            List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
            rList = bizList.getAaData();
            Map<String, Object> firstData = new HashMap<String, Object>();
            if (loginVo.getLangCode().equals("en")) {
                firstData.put("commonName", "all");
            } else {
                firstData.put("commonName", "??????");
            }
            firstData.put("commonCode", "");
            rList.add(0, firstData);
            /* ????????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.addObject("bizList", CommonConvert.CommonGetListMapToJson(rList));
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINSLIPREPORTEXPENDLIST);
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


    /* ????????? ?????? */
    /* ????????? */
    /* ????????? - ?????? */
    /* ????????? - ?????? - ???????????? ?????? */
    /* ????????? - ?????? - ???????????? ?????? */

    /* Content View - ????????? - ?????? - ???????????? ?????? - ?????? ?????? */
    @IncludedInfo(name = "[?????????] ?????? ??????(??????) // ! ?????????", order = 1104, gid = 110)
    @RequestMapping("/ex/admin/config/ExAuthConfig.do")
    public ModelAndView ExConfigAuthSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            // TODO : -
            throw new Exception("????????? ???????????????.");
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

    /* Content View - ????????? - ?????? - ???????????? ?????? - ?????? ?????? */
    @SuppressWarnings("unchecked")
    /* View - ?????????????????? */
    @IncludedInfo(name = "[?????????] ???????????? ??????(??????)", order = 1102, gid = 110)
    @RequestMapping("/ex/admin/config/ExCardConfig.do")
    public ModelAndView ExConfigCardSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ?????? ?????? */
            Map<String, Object> result = new HashMap<String, Object>();
            result = cardService.ExAdminCardConfigSendParam();
            mv.addObject("selUseYN", result.get("ex00001"));
            /* ???????????? ?????? View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ?????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result); /* result{ empInfo={}, erpTypeCode=, ex00001=[], ex00004=[] } */
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINCARDSETTING); /* /expend/ex/master/content/MasterCardSetting */
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

    /* Content View - ????????? - ?????? - ???????????? ?????? - ???????????? ?????? */
    @IncludedInfo(name = "[?????????] ???????????? ??????(??????)", order = 1103, gid = 110)
    @RequestMapping("/ex/admin/config/ExSummaryConfig.do")
    public ModelAndView ExConfigSummarySetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            setCommonParams(sendParam);
            /* ???????????? ?????? View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            // ????????? ??????
            mv.addObject("ViewBag", sendParam);
            mv.addObject("CL", vo.getData());
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINEXPENDSUMMARY);
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

    /* Content View - ????????? - ?????? - ???????????? ?????? - ???????????? ?????? */
    @IncludedInfo(name = "[?????????] ???????????? ??????(??????)", order = 1101, gid = 110)
    @RequestMapping("/ex/admin/config/ExAuthTypeConfig.do")
    public ModelAndView ExAdminExpendAuthTypeConfig(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            setCommonParams(sendParam);
            /* ???????????? ?????? View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            // ????????? ??????
            mv.addObject("ViewBag", sendParam);
            mv.addObject("CL", vo.getData());
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINEXPENDAUTH);
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

    /* [] ????????? - ?????? - ???????????? ?????? - ?????? ?????? ?????? */
    @IncludedInfo(name = "[?????????] ???????????? ??????(??????)", order = 1107, gid = 110)
    @RequestMapping("/ex/admin/config/ExMngDefSetting.do")
    public ModelAndView ExConfigSettingMng(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            sendParam = itemService.ExAdminItemConfigSendParam();
            setCommonParams(sendParam);
            /* ???????????? ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ???????????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINMNGDEFSETTING);
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

    /* [] ????????? - ?????? - ???????????? ?????? - ???????????? */
    @IncludedInfo(name = "[?????????] ????????????/????????????", order = 1108, gid = 110)
    @RequestMapping("/ex/admin/config/ExExpendSetting.do")
    public ModelAndView ExConfigExpendSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            sendParam = itemService.ExAdminItemConfigSendParam();
            setCommonParams(sendParam);
            /* ???????????? ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ???????????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINEXPENDSETTING);
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

    /* [] ????????? - ?????? - ???????????? ?????? - ????????????2 */
    @RequestMapping("/ex/admin/config/ExConfigExpendSetting2.do")
    public ModelAndView ExConfigExpendSetting2(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            mv.setViewName("/expend/ex/admin/content/" + "AdminExExpendSetting2");
        } catch (CheckAuthorityException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckAuth());
        } catch (NotFoundLoginSessionException e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (Exception e) {
            mv.addObject("errMsg", e.getMessage());
            mv.setViewName(CommonMapper.GetExError());
        }
        return mv;
    }

    /* Content View - ????????? - ?????? - ???????????? ?????? - ?????? ?????? */
    /* View - ????????? ???????????? */
    @IncludedInfo(name = "[?????????] ????????????", order = 1109, gid = 110)
    @RequestMapping("/ex/admin/config/ExButtonConfig.do")
    public ModelAndView ExConfigButtonSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ?????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("langCode", loginVo.getLangCode());
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINBUTTONSETTING);
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

    /* Content View - ????????? - ?????? - ???????????? ?????? - ?????? ?????? */
    /* View - ????????? ???????????? */
    @IncludedInfo(name = "[?????????] ????????????", order = 1110, gid = 110)
    @RequestMapping("/ex/admin/config/ExLabelConfig.do")
    public ModelAndView ExConfigLabelSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? ?????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ???????????? */
            mv.addObject("CL", vo.getData());
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINLABELSETTING);
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

    /* [] ????????? - ?????? - ???????????? ??????(?????????) */
    @IncludedInfo(name = "???????????? ??????", order = 1504, gid = 150)
    @RequestMapping("/ex/admin/report/ExApprovalList.do")
    public ModelAndView ExReportExpendList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            ExCommonResultVO commonParam = new ExCommonResultVO();
            List<ExCommonResultVO> commonListCode = new ArrayList<ExCommonResultVO>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* ????????? ?????? */
            if (commonParam.getGroupSeq() == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq()).equals("")) {
                commonParam.setGroupSeq(loginVo.getGroupSeq());
            }
            setCommonParams(sendParam);
            commonParam.setCompSeq(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            commonParam.setLangCode(CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE).toString());
            /* ???????????? - ???????????? */
            commonParam.setSearchType(commonCode.DOCSTATUS);
            commonListCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
            ExCommonResultVO allSts = new ExCommonResultVO();
            allSts.setCommonCode(commonCode.EMPTYSTR);
            if (loginVo.getLangCode().equals("en")) {
                allSts.setCommonName("all");
            } else {
                allSts.setCommonName("??????");
            }
            commonListCode.add(0, allSts);
            sendParam.put("commonCodeListDocStatus", JSONArray.fromObject(commonListCode));
            /* ????????? ????????? ?????? */
            ResultVO bizList = new ResultVO();
            Map<String, Object> bizParam = new HashMap<String, Object>();
            bizParam.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.GROUPSEQ).toString());
            bizParam.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            bizParam.put(commonCode.LANGCODE, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE).toString());
            bizParam.put(commonCode.CODETYPE, commonCode.BIZ);
            bizList = codeService.ExCommonCodeInfoSelect(bizParam);
            List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
            rList = bizList.getAaData();
            Map<String, Object> firstData = new HashMap<String, Object>();
            if (loginVo.getLangCode().equals("en")) {
                firstData.put("commonName", "all");
            } else {
                firstData.put("commonName", "??????");
            }
            firstData.put("commonCode", "");
            rList.add(0, firstData);
            /* ????????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.addObject("bizList", CommonConvert.CommonGetListMapToJson(rList));
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINEXPENDREPORT);
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

    /* Contents View */
    /* Contents View - ?????? (?????????) */
    /* Contents View - ?????? (?????????) - ???????????? ?????? */
    @IncludedInfo(name = "????????? ???????????? ??????", order = 1801, gid = 180)
    @RequestMapping("/ex/admin/yesil/ExAdminYesilReport.do")
    public ModelAndView ExAdminYesilReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* ERP ???????????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* ERP ?????? ?????? ?????? */
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());
            result = yesilService.ExAdminYesilSendParam(params);
            /* ???????????? ?????? */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ???????????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result);
            /* View path ?????? */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals("iCUBE")) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINYESILREPORT);
            } else {
                throw new NotFoundLogicException("iCUBE?????? ?????? ?????????.", conVo.getErpTypeCode());
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

    /* Contents View */
    /* Contents View - ?????? (?????????) */
    /* Contents View - ?????? (?????????) - ???????????? ??????2(PIVOT) */
    @IncludedInfo(name = "????????? ???????????? ??????2(PIVOT)", order = 1802, gid = 180)
    @RequestMapping("/ex/admin/yesil/ExAdminYesil2Report.do")
    public ModelAndView ExAdminYesil2Report(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* ERP ???????????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* ERP ?????? ?????? ?????? */
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());
            result = yesilService.ExAdminYesil2SendParam(params);
            /* ???????????? ?????? */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ???????????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result);
            /* View path ?????? */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals("ERPiU")) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINYESIL2REPORT);
            } else {
                throw new NotFoundLogicException("ERPiU?????? ?????? ?????????.", conVo.getErpTypeCode());
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


    /* Contents View */
    /* Contents View - ?????? (?????????) */
    /* Contents View - ?????? (?????????) - ???????????? ?????? 2.0  ?????? ?????? */
    @IncludedInfo(name = "????????? ???????????? ?????? 2.0", order = 1803, gid = 180)
    @RequestMapping("/ex/admin/yesil/ExAdminERPiUYesilReport.do")
    public ModelAndView ExAdmiERPiUYesilReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();

            /* ERP ???????????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* ERP ?????? ?????? ?????? */
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            result = yesil2Service.ExAdminIuYesilSendParam(params);
            /* ???????????? ?????? */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ???????????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result);
            /* View path ?????? */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals("ERPiU")) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINEXERPIUYESIL);
            } else {
                throw new NotFoundLogicException("ERPiU?????? ?????? ?????????.", conVo.getErpTypeCode());
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

   @RequestMapping("/ex/admin/ExIuYesilExpendDetailPop.do")
    public ModelAndView AdminIuYesilExpendDetailPop  ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {

      ModelAndView mv = new ModelAndView();

      try {

            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));

            mv.addObject( "CL", vo.getData( ) );
            mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
            mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
            mv.addObject( "fromDate", params.get( "fromDate" ) );
            mv.addObject( "toDate", params.get( "toDate" ) );
            mv.addObject( "erpCompSeq",params.get("erpCompSeq"));
            mv.addObject("params", params);

            if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
              mv.setViewName( commonExPath.ADMINPOPPATH + commonExPath.ADMINERPIUYESILEXPENDDETAILINFO );
            }

      } catch (Exception e) {
        mv.addObject( "errMsg", e.getMessage( ) );
        mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
      }

      return mv;
    }

    /* Contents View */
    /* Contents View - ?????? (?????????) */
    /* Contents View - ?????? (????????? ??????????????? ) - ???????????? ?????? */
    /* Contents View - ?????? (????????? ??????????????? ) - ???????????? ?????? - ???????????? ?????? */
    @RequestMapping("/ex/admin/report/ExFormAuthApprovalSendList.do")
    public ModelAndView ExAuthFormExpendManagerReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ?????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("AuthPageYN", 'Y');
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINEXPENDMANAGERREPORT);
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

    /* Contents View - ?????? (?????????) - ???????????? ?????? - ??????????????????????????? ?????? iCUBE */
    @IncludedInfo(name = "??????????????? ??????(iCUBE)", order = 1505, gid = 150)
    @RequestMapping("/ex/admin/report/ExAdminETaxlListiCUBE.do")
    public ModelAndView ExAdminETaxlListiCUBE(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ????????? ?????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            @SuppressWarnings("unused")
            ExCommonResultVO commonParam = new ExCommonResultVO();
            params.put("g20YN", conVo.getG20YN());
            params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
            params.put(commonCode.EMPSEQ, loginVo.getUniqId());
            mv.addObject("ViewBag", params);
            mv.addObject("ifUseSystem", conVo.getErpTypeCode());
            /* ???????????? */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ?????? ?????? */
            mv.addObject("CL", vo.getData());
            /* View path ?????? [AdminiCUBEETaxReport.jsp] */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINICUBEETAXREPORT);
            } else {
                throw new NotFoundLogicException(commonCode.ICUBE + "?????? ?????? ?????????.", conVo.getErpTypeCode());
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

    /* Contents View - ?????? (?????????) - ???????????? ?????? - ??????????????????????????? ?????? ERPiU */
    @IncludedInfo(name = "??????????????? ??????(ERPiU)", order = 1506, gid = 150)
    @RequestMapping("/ex/admin/report/ExAdminETaxlListERPiU.do")
    public ModelAndView ExAdminETaxlListERPiU(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ????????? ?????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            @SuppressWarnings("unused")
            ExCommonResultVO commonParam = new ExCommonResultVO();
            params.put("g20YN", conVo.getG20YN());
            params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
            params.put(commonCode.EMPSEQ, loginVo.getUniqId());
            mv.addObject("ViewBag", params);
            mv.addObject("ifUseSystem", conVo.getErpTypeCode());
            mv.addObject("CL", vo.getData());
            /* View path ?????? [AdminERPiUETaxReport.jsp] */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINERPIUETAXREPORT);
            } else {
                throw new NotFoundLogicException(commonCode.ERPIU + "?????? ?????? ?????????.", conVo.getErpTypeCode());
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

    /* [] ????????? - ?????? - iCUBE ???????????? ??????(?????????) */
    @IncludedInfo(name = "iCUBE ???????????? ??????", order = 1507, gid = 150)
    @RequestMapping("/ex/admin/report/ExiCUBEDocListReport.do")
    public ModelAndView ExiCUBEDocListReport(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            ExCommonResultVO commonParam = new ExCommonResultVO();
            List<ExCommonResultVO> commonListCode = new ArrayList<ExCommonResultVO>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* ????????? ?????? ?????? */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* ????????? ?????? */
            if (commonParam.getGroupSeq() == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq()).equals("")) {
                commonParam.setGroupSeq(loginVo.getGroupSeq());
            }
            setCommonParams(sendParam);
            commonParam.setCompSeq(loginVo.getCompSeq());
            commonParam.setLangCode(loginVo.getLangCode());
            /* ???????????? - ???????????? */
            commonParam.setSearchType(commonCode.DOCSTATUS);
            commonListCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
            ExCommonResultVO allSts = new ExCommonResultVO();
            allSts.setCommonCode(commonCode.EMPTYSTR);
            if (loginVo.getLangCode().equals("en")) {
                allSts.setCommonName("all");
            } else {
                allSts.setCommonName("??????");
            }

            commonListCode.add(0, allSts);
            sendParam.put("commonCodeListDocStatus", JSONArray.fromObject(commonListCode));
            /* ????????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.addObject("systemType", conVo.getErpTypeCode());
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINICUBEDOCLISTREPORT);
            } else {
                throw new NotFoundLogicException(commonCode.ICUBE + "?????? ?????? ?????????.", conVo.getErpTypeCode());
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

    /* [] ????????? - ?????? - ??????????????? ?????? ?????? ????????? */
    @IncludedInfo(name = "??????????????? ?????? ?????? ?????????", order = 1112, gid = 110)
    @RequestMapping("/ex/admin/config/ExETaxAuthSetting.do")
    public ModelAndView ExETaxAuthSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            ResultVO result = new ResultVO();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            Map<String, Object> empInfo = new HashMap<String, Object>();
            empInfo = CommonConvert.CommonGetEmpInfo(); /* ????????? ?????? */
            result.setaData(itemService.ExAdminItemConfigSendParam());
            mv.addObject("CL", vo.getData());
            mv.addObject("empInfo", CommonConvert.CommonGetMapToJSONObj(empInfo));
            mv.addObject("compSeq", empInfo.get(commonCode.COMPSEQ));
            /* ????????? ?????? */
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINETAXAUTHSETTING);
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

    /* [] ????????? - ?????? - ?????????????????? - ?????????????????????&?????????????????? */
    @RequestMapping("/ex/admin/config/ExFormLinkCodeSetting.do")
    public ModelAndView ExFormLinkCodeSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            Map<String, Object> empInfo = new HashMap<String, Object>();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ????????? ?????? */
            empInfo = CommonConvert.CommonGetEmpInfo(); /* ????????? ?????? */
            mv.addObject("empInfo", empInfo);
            mv.addObject("CL", vo.getData());
            mv.addObject("compSeq", empInfo.get(commonCode.COMPSEQ));
            /* ????????? ?????? */
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINFORMLINKCODESETTING);
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

    /* [] ????????? - ?????? - ?????????????????? - ???????????? ?????? ?????? */
    @RequestMapping("/ex/admin/config/ExCloseDateSetting.do")
    public ModelAndView ExCloseDateSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ???????????? */
            Map<String, Object> empInfo = new HashMap<String, Object>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            /* ????????? ?????? */
            empInfo = CommonConvert.CommonGetEmpInfo(); /* ????????? ?????? */
            sendParam.put("formList", CommonConvert.CommonGetListMapToJson(cmInfo.CommonGetExFormListInfo(empInfo)));
            mv.addObject("empInfo", empInfo);
            mv.addObject("compSeq", empInfo.get(commonCode.COMPSEQ));
            mv.addObject("ViewBag", sendParam);
            mv.addObject("CL", vo.getData());
            /* ????????? ?????? */
            mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADIMCLOSEDATESETTING);
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

    /* Content View - ????????? - ?????? - ???????????? ?????? - ?????? ??????(?????????) */
    @SuppressWarnings("unchecked")
    /* View - ??????????????????(?????????) */
    @IncludedInfo(name = "[?????????] ???????????? ??????(??????)-?????????", order = 1122, gid = 110)
    @RequestMapping("/ex/admin/config/NpExCardConfig.do")
    public ModelAndView NpExConfigCardSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("????????? ?????? ?????? ?????? ??????");
            }
            /* ?????? ?????? */
            Map<String, Object> result = new HashMap<String, Object>();
            result = cardService.ExAdminCardConfigSendParam();
            mv.addObject("selUseYN", result.get("ex00001"));
            mv.addObject("selSetYN", result.get("ex00033"));
            /* ???????????? ?????? View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* ?????? ?????? */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result); /* result{ empInfo={}, erpTypeCode=, ex00001=[], ex00004=[] } */
            mv.setViewName(commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPCARDSETTING); /* /expend/ex/master/content/MasterCardSetting */
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

    /**
     * <pre>
     * ?????? : ????????? > ?????? > ???????????? ?????? > ???????????? ??????
     * ?????? : ???????????? ????????? ?????? ?????? ????????? ???????????? ?????? ( 2019. 08. 21. ?????? ????????????(input)??? ?????? )
     * </pre>
     *
     * @param param
     * @param request
     * @return
     *
     *         <pre>
     * 1. UserInfo : ????????? ????????? ??????
     * 2. FormInfo : ???????????? ???????????? ?????? ??????
     * 3. CL : ????????? ??????
     *         </pre>
     *
     * @throws Exception
     */
    @IncludedInfo(name = "????????? > ?????? > ???????????? ?????? > ???????????? ??????", order = 1011, gid = 102)
    @RequestMapping("/ex/admin/config/ExExtInputItemConfig.do")
    public ModelAndView ExExtInputItemConfig(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            // ????????? ????????? ?????? ??????
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();
            if (this.GetUserAuth().equals(commonCode.USER)) {
                throw new CheckAuthorityException("????????? ????????? ?????? ???????????? ????????? ????????? ??? ????????????.");
            }

            // ERP ?????? ?????? ?????? ??????
            ConnectionVO con = new ConnectionVO();
            con = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(login.getCompSeq()));

            // ????????? ?????? ?????? ??????
            try {
                CustomLabelVO label = cmInfo.CommonGetCustomLabelInfo(login.getCompSeq(), login.getLangCode(), login.getGroupSeq());
                mv.addObject("CL", label.getData());
            } catch (Exception e) {
                ExpInfo.TipLog("????????? ?????? ????????? ????????? ?????????????????????. ????????? ????????? ????????? ???????????? ????????? ????????????, ????????? ?????? ?????? ????????? ???????????? ??????????????????.");
                throw new Exception(e);
            }

            // ????????? ?????? ?????? ??????
            mv = this.SetUserInfoToMNV(mv, con, login);

            // ?????? ?????? ?????? ??????
            mv.addObject("FormInfo", CommonConvert.CommonGetListMapToJson(cmInfo.CommonGetExFormListInfo(CommonConvert.CommonGetEmpInfo())));

            // JSP ?????? ??????
            mv.setViewName(CommonMapper.GetEXAdminExtInputConfig());
        } catch (CheckAuthorityException e) {
            ExpInfo.TipLog("????????? > ?????? > ???????????? ?????? > ???????????? ?????? ????????? ???????????? ????????? ???????????????.");
            mv.setViewName(CommonMapper.GetExErrorCheckAuth());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("????????? > ?????? > ???????????? ?????? > ???????????? ?????? ????????? ??????????????????, ????????? ?????????????????? ????????? ??? ????????????.");
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (CheckErpTypeException e) {
            ExpInfo.TipLog("????????? > ?????? > ???????????? ?????? > ???????????? ?????? ????????? ??????????????????, ERP ?????? ??????????????? ????????? ??? ????????????.");
            mv.setViewName(CommonMapper.GetExErrorCheckERP());
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            ExpInfo.TipLog(e.getLocalizedMessage(), e);
            mv.setViewName(CommonMapper.GetExError());
        }

        return mv;
    }

    /* Private --------------------------------------------------------------------------------------------- */
    /* View - ???????????? ?????? */
    private void setCommonParams(Map<String, Object> sendParam) throws Exception {
        LoginVO loginVo = new LoginVO();
        ExCommonResultVO commonParam = new ExCommonResultVO();
        List<ExCommonResultVO> commonCode = new ArrayList<ExCommonResultVO>();
        /* ????????? ?????? */
        loginVo = CommonConvert.CommonGetEmpVO();
        // sendParam = CommonConvert.CommonSetMapCopy( sendParam );
        if (commonParam.getGroupSeq() == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq()).equals("")) {
            commonParam.setGroupSeq(loginVo.getGroupSeq());
        }
        if (sendParam.get("compSeq") == null || CommonConvert.CommonGetStr(sendParam.get("compSeq")).equals(CommonInterface.commonCode.EMPTYSTR)) {
            commonParam.setCompSeq(loginVo.getCompSeq());
        }
        commonParam.setLangCode(loginVo.getLangCode());
        // VO -> Map
        sendParam.put("empInfo", CommonConvert.CommonGetObjectToMap(loginVo));
        /* ERP ???????????? ?????? */
        /* ????????? ?????? - ?????? ????????? ?????? ?????? */
        ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(commonParam.getCompSeq()));
        sendParam.put(CommonInterface.commonCode.IFSYSTEM, conVo.getErpTypeCode());
        /* ???????????? */
        /* ???????????? - ???????????? */
        // sendParam.put("compListInfo", JSONArray.fromObject(exMasterConfigService.GCompanyListS(sendParam)));
        commonCode = exUserCodeService.ExCodeCommonCompListInfoSelect(commonParam);
        sendParam.put("compListInfo", JSONArray.fromObject(commonCode));
        /* ???????????? - ???????????? */
        commonParam.setSearchType(CommonInterface.commonCodeKey.USEYN);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListUseYN", JSONArray.fromObject(commonCode));
        /* ???????????? - ??? / ????????? */
        commonParam.setSearchType(CommonInterface.commonCodeKey.YESORNO);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListYesOrNo", JSONArray.fromObject(commonCode));
        /* ???????????? - ???????????? */
        commonCode = exUserCodeService.ExCodeCommonFormListInfoSelect(commonParam);
        sendParam.put("formListInfo", JSONArray.fromObject(commonCode));
        /* ???????????? - ???????????? */
        commonParam.setSearchType(CommonInterface.commonCode.DRCRTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListDrcrGbn", JSONArray.fromObject(commonCode));
        /* ???????????? - ???????????? ?????? ?????? */
        commonParam.setSearchType(CommonInterface.commonCode.MNGMAPTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListMngMapType", JSONArray.fromObject(commonCode));
        /* ???????????? - ???????????? ?????? / ???????????? */
        commonParam.setSearchType(CommonInterface.commonCode.SUMMARYTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListSummaryType", JSONArray.fromObject(commonCode));
        /* ???????????? - ????????? ?????? */
        commonParam.setSearchType(CommonInterface.commonCode.SUMMARYSEARCHTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListSummarySearchType", JSONArray.fromObject(commonCode));
    }
}
