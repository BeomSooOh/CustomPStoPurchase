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

    //예실대비 현황 2.0 - Jun
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
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    /**
     * <pre>
     * ㄴ 관리자
     *   ㄴ 회계
     *     ㄴ 지출결의 관리 [gid : 101]
     *       ㄴ 지출결의 확인 [gid : 101 / order : 1000]
     *       ㄴ 지출결의 확인(권한별) [gid : 101 / order : 1001]
     *       ㄴ 지출결의 상세현황 [gid : 101 / order : 1002]
     *       ㄴ 지출결의 현황 [gid : 101 / order : 1003]
     *       ㄴ 카드 사용 현황 [gid : 101 / order : 1004]
     *       ㄴ iCUBE 연동문서 현황 [gid : 101 / order : 1005]
     *       ㄴ 세금계산서현황(iCUBE) [gid : 101 / order : 1006]
     *       ㄴ 세금계산서현황(ERPiU) [gid : 101 / order : 1007]
     *     ㄴ 지출결의 설정 [gid : 102]
     *       ㄴ 카드 설정 [gid : 102 / order : 1000]
     *       ㄴ 표준적요 설정 [gid : 102 / order : 1001]
     *       ㄴ 증빙유형 설정 [gid : 102 / order : 1002]
     *       ㄴ 양식 별 표준적요 & 증빙유형 설정 [gid : 102 / order : 1003]
     *       ㄴ 환경 설정 [gid : 102 / order : 1004]
     *       ㄴ 항목 설정 [gid : 102 / order : 1005]
     *       ㄴ 관리항목 설정 [gid : 102 / order : 1006]
     *       ㄴ 명칭 설정 [gid : 102 / order : 1007]
     *       ㄴ 버튼 설정 [gid : 102 / order : 1008]
     *       ㄴ 매입전자세금계산서 설정 [gid : 102 / order : 1009]
     *       ㄴ 마감설정 [gid : 102 / order : 1010]
     *       ㄴ 확장입력 설정 [gid : 102 / order : 1011]
     *     ㄴ 예실대비 [gid : 103]
     *       ㄴ 예실대비 현황(iCUBE) [gid : 103 / order : 1000]
     *       ㄴ 예실대비 현황(ERPiU) [gid : 103 / order : 1000]
     *       ㄴ 예실대비 현황(ERPiU) [gid : 103 / order : 1000]
     * </pre>
     */
    @IncludedInfo(name = "관리자 > 회계 > 지출결의 설정 > 항목 설정", order = 1005, gid = 102)
    @RequestMapping("/ex/admin/config/ExItemSetting.do")
    public ModelAndView ExSettingItems(@RequestParam Map<String, Object> param) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            Map<String, Object> result = new HashMap<String, Object>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            setCommonParams(sendParam);
            result = itemService.ExAdminItemConfigSendParam();
            /* 명칭정보 ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            CommonConvert.CommonGetEmpVO();
            CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환값 정의 */
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

    @IncludedInfo(name = "관리자 > 회계 > 지출결의 관리 > 지출결의 확인", order = 1000, gid = 101)
    @RequestMapping("/ex/admin/report/ExApprovalSendList.do")
    public ModelAndView ExAdminExpendManagerReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String groupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, groupSeq);
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ)));
            /* 사업장 리스트 조회 */
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
                firstData.put("commonName", "전체");

            }
            firstData.put("commonCode", "");
            rList.add(0, firstData);
            /* 반환 설정 */
            mv.addObject("erpType", conVo.getErpTypeCode());
            mv.addObject("CL", vo.getData());
            mv.addObject("bizList", CommonConvert.CommonGetListMapToJson(rList));
            // mv.addObject( "AuthPageYN", 'N' );

            if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                mv.setViewName(CommonMapper.GetEXUAdminExpendConfirmReport());
            } else if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
                mv.setViewName(CommonMapper.GetEXIAdminExpendConfirmReport());
            } else {
                throw new CheckErpTypeException("ERP 연결 설정 확인 또는 기타ERP 설정 여부 점검이 필요합니다. ERPiU 및 iCUBE 연동만 지원합니다.");
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

    /* Contents View - 회계 (관리자) - 지출결의 관리 - 카드 사용 현황 */
    @IncludedInfo(name = "카드 사용 현황", order = 1503, gid = 150)
    @RequestMapping("/ex/admin/report/ExUseCardlList.do")
    public ModelAndView ExAdminCardReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 커넥션 설정 확인 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            /* 변수 설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            /* buildType 확인(구축형,클라우드형 ) */
            boolean bool = false;

            /* 그룹웨어에 cms 등록 여부 판 */
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

            /* 기초 데이터 결과 조회 */
            Map<String, Object> result = new HashMap<String, Object>();
            result = cardService.ExAdminCardConfigSendParam();
            result.put("g20YN", conVo.getG20YN());
            /* 결과 리턴 */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result); /* result{ empInfo={}, erpTypeCode=, ex00001=[], ex00004=[] } */
            mv.addObject("buildType", bool);
            mv.addObject("cmsDate", cmsDate);

            if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                mv.setViewName(CommonMapper.GetEXUAdminCardReport());
            } else if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
                mv.setViewName(CommonMapper.GetEXIAdminCardReport());
            } else {
                throw new CheckErpTypeException("ERP 연결 설정 확인 또는 기타ERP 설정 여부 점검이 필요합니다. ERPiU 및 iCUBE 연동만 지원합니다.");
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

    /* [] 관리자 - 회계 - 지출결의 상세 현황(관리자) 이준성 */
    @IncludedInfo(name = "지출결의 상세 현황", order = 1502, gid = 150)
    @RequestMapping("/ex/admin/report/ExApprovalSlipList.do")
    public ModelAndView ExSlipReportExpendList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            ExCommonResultVO commonParam = new ExCommonResultVO();
            List<ExCommonResultVO> commonListCode = new ArrayList<ExCommonResultVO>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 초기값 정의 */
            if (commonParam.getGroupSeq() == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq()).equals("")) {
                commonParam.setGroupSeq(loginVo.getGroupSeq());
            }
            setCommonParams(sendParam);
            commonParam.setCompSeq(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            commonParam.setLangCode(CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE).toString());
            /* 공통코드 - 문서상태 */
            commonParam.setSearchType(commonCode.DOCSTATUS);
            commonListCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
            ExCommonResultVO allSts = new ExCommonResultVO();
            allSts.setCommonCode(commonCode.EMPTYSTR);
            if (loginVo.getLangCode().equals("en")) {
                allSts.setCommonName("all");
            } else {
                allSts.setCommonName("전체");
            }
            commonListCode.add(0, allSts);
            sendParam.put("commonCodeListDocStatus", JSONArray.fromObject(commonListCode));
            /* 사업장 리스트 조회 */
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
                firstData.put("commonName", "전체");
            }
            firstData.put("commonCode", "");
            rList.add(0, firstData);
            /* 반환값 처리 */
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


    /* 관리자 모드 */
    /* 관리자 */
    /* 관리자 - 회계 */
    /* 관리자 - 회계 - 지출결의 관리 */
    /* 관리자 - 회계 - 지출결의 설정 */

    /* Content View - 관리자 - 회계 - 지출결의 설정 - 증빙 설정 */
    @IncludedInfo(name = "[관리자] 증빙 관리(설정) // ! 미개발", order = 1104, gid = 110)
    @RequestMapping("/ex/admin/config/ExAuthConfig.do")
    public ModelAndView ExConfigAuthSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            // TODO : -
            throw new Exception("미개발 기능입니다.");
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

    /* Content View - 관리자 - 회계 - 지출결의 설정 - 카드 설정 */
    @SuppressWarnings("unchecked")
    /* View - 법인카드관리 */
    @IncludedInfo(name = "[관리자] 법인카드 관리(설정)", order = 1102, gid = 110)
    @RequestMapping("/ex/admin/config/ExCardConfig.do")
    public ModelAndView ExConfigCardSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수 정의 */
            Map<String, Object> result = new HashMap<String, Object>();
            result = cardService.ExAdminCardConfigSendParam();
            mv.addObject("selUseYN", result.get("ex00001"));
            /* 명칭정보 사용 View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환 설정 */
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

    /* Content View - 관리자 - 회계 - 지출결의 설정 - 표준적요 설정 */
    @IncludedInfo(name = "[관리자] 표준적요 관리(설정)", order = 1103, gid = 110)
    @RequestMapping("/ex/admin/config/ExSummaryConfig.do")
    public ModelAndView ExConfigSummarySetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            setCommonParams(sendParam);
            /* 명칭정보 사용 View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            // 반환값 처리
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

    /* Content View - 관리자 - 회계 - 지출결의 설정 - 증빙유형 설정 */
    @IncludedInfo(name = "[관리자] 증빙유형 관리(설정)", order = 1101, gid = 110)
    @RequestMapping("/ex/admin/config/ExAuthTypeConfig.do")
    public ModelAndView ExAdminExpendAuthTypeConfig(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            setCommonParams(sendParam);
            /* 명칭정보 사용 View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            // 반환값 처리
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

    /* [] 관리자 - 회계 - 지출결의 설정 - 관리 항목 설정 */
    @IncludedInfo(name = "[관리자] 관리항목 관리(설정)", order = 1107, gid = 110)
    @RequestMapping("/ex/admin/config/ExMngDefSetting.do")
    public ModelAndView ExConfigSettingMng(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            sendParam = itemService.ExAdminItemConfigSendParam();
            setCommonParams(sendParam);
            /* 명칭정보 ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환처리 */
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

    /* [] 관리자 - 회계 - 지출결의 설정 - 환경설정 */
    @IncludedInfo(name = "[관리자] 지출결의/환경설정", order = 1108, gid = 110)
    @RequestMapping("/ex/admin/config/ExExpendSetting.do")
    public ModelAndView ExConfigExpendSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            sendParam = itemService.ExAdminItemConfigSendParam();
            setCommonParams(sendParam);
            /* 명칭정보 ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환처리 */
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

    /* [] 관리자 - 회계 - 지출결의 설정 - 환경설정2 */
    @RequestMapping("/ex/admin/config/ExConfigExpendSetting2.do")
    public ModelAndView ExConfigExpendSetting2(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
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

    /* Content View - 관리자 - 회계 - 지출결의 설정 - 버튼 설정 */
    /* View - 관리자 버튼설정 */
    @IncludedInfo(name = "[관리자] 버튼설정", order = 1109, gid = 110)
    @RequestMapping("/ex/admin/config/ExButtonConfig.do")
    public ModelAndView ExConfigButtonSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 명칭정보 ViewObject */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환 설정 */
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

    /* Content View - 관리자 - 회계 - 지출결의 설정 - 명칭 설정 */
    /* View - 관리자 명칭설정 */
    @IncludedInfo(name = "[관리자] 명칭설정", order = 1110, gid = 110)
    @RequestMapping("/ex/admin/config/ExLabelConfig.do")
    public ModelAndView ExConfigLabelSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 명칭설정 정보 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환처리 */
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

    /* [] 관리자 - 회계 - 지출결의 현황(관리자) */
    @IncludedInfo(name = "지출결의 현황", order = 1504, gid = 150)
    @RequestMapping("/ex/admin/report/ExApprovalList.do")
    public ModelAndView ExReportExpendList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            ExCommonResultVO commonParam = new ExCommonResultVO();
            List<ExCommonResultVO> commonListCode = new ArrayList<ExCommonResultVO>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 초기값 정의 */
            if (commonParam.getGroupSeq() == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq()).equals("")) {
                commonParam.setGroupSeq(loginVo.getGroupSeq());
            }
            setCommonParams(sendParam);
            commonParam.setCompSeq(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            commonParam.setLangCode(CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE).toString());
            /* 공통코드 - 문서상태 */
            commonParam.setSearchType(commonCode.DOCSTATUS);
            commonListCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
            ExCommonResultVO allSts = new ExCommonResultVO();
            allSts.setCommonCode(commonCode.EMPTYSTR);
            if (loginVo.getLangCode().equals("en")) {
                allSts.setCommonName("all");
            } else {
                allSts.setCommonName("전체");
            }
            commonListCode.add(0, allSts);
            sendParam.put("commonCodeListDocStatus", JSONArray.fromObject(commonListCode));
            /* 사업장 리스트 조회 */
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
                firstData.put("commonName", "전체");
            }
            firstData.put("commonCode", "");
            rList.add(0, firstData);
            /* 반환값 처리 */
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
    /* Contents View - 회계 (관리자) */
    /* Contents View - 회계 (관리자) - 예실대비 현황 */
    @IncludedInfo(name = "관리자 예실대비 현황", order = 1801, gid = 180)
    @RequestMapping("/ex/admin/yesil/ExAdminYesilReport.do")
    public ModelAndView ExAdminYesilReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* ERP 회사 코드 확인 */
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());
            result = yesilService.ExAdminYesilSendParam(params);
            /* 명칭정보 조회 */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환처리 */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", result);
            /* View path 정의 */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals("iCUBE")) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINYESILREPORT);
            } else {
                throw new NotFoundLogicException("iCUBE전용 메뉴 입니다.", conVo.getErpTypeCode());
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
    /* Contents View - 회계 (관리자) */
    /* Contents View - 회계 (관리자) - 예실대비 현황2(PIVOT) */
    @IncludedInfo(name = "관리자 예실대비 현황2(PIVOT)", order = 1802, gid = 180)
    @RequestMapping("/ex/admin/yesil/ExAdminYesil2Report.do")
    public ModelAndView ExAdminYesil2Report(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* ERP 회사 코드 확인 */
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());
            result = yesilService.ExAdminYesil2SendParam(params);
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
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINYESIL2REPORT);
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


    /* Contents View */
    /* Contents View - 회계 (관리자) */
    /* Contents View - 회계 (관리자) - 예실대비 현황 2.0  준성 개발 */
    @IncludedInfo(name = "관리자 예실대비 현황 2.0", order = 1803, gid = 180)
    @RequestMapping("/ex/admin/yesil/ExAdminERPiUYesilReport.do")
    public ModelAndView ExAdmiERPiUYesilReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
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
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINEXERPIUYESIL);
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

   @RequestMapping("/ex/admin/ExIuYesilExpendDetailPop.do")
    public ModelAndView AdminIuYesilExpendDetailPop  ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {

      ModelAndView mv = new ModelAndView();

      try {

            /* 변수정의 */
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
    /* Contents View - 회계 (관리자) */
    /* Contents View - 회계 (사용자 양식권한별 ) - 지출결의 관리 */
    /* Contents View - 회계 (사용자 양식권한별 ) - 지출결의 관리 - 지출결의 확인 */
    @RequestMapping("/ex/admin/report/ExFormAuthApprovalSendList.do")
    public ModelAndView ExAuthFormExpendManagerReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환 설정 */
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

    /* Contents View - 회계 (관리자) - 지출결의 관리 - 매입전자세금계산서 현황 iCUBE */
    @IncludedInfo(name = "세금계산서 현황(iCUBE)", order = 1505, gid = 150)
    @RequestMapping("/ex/admin/report/ExAdminETaxlListiCUBE.do")
    public ModelAndView ExAdminETaxlListiCUBE(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 커넥션 설정 확인 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            @SuppressWarnings("unused")
            ExCommonResultVO commonParam = new ExCommonResultVO();
            params.put("g20YN", conVo.getG20YN());
            params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
            params.put(commonCode.EMPSEQ, loginVo.getUniqId());
            mv.addObject("ViewBag", params);
            mv.addObject("ifUseSystem", conVo.getErpTypeCode());
            /* 변수정의 */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환 설정 */
            mv.addObject("CL", vo.getData());
            /* View path 정의 [AdminiCUBEETaxReport.jsp] */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINICUBEETAXREPORT);
            } else {
                throw new NotFoundLogicException(commonCode.ICUBE + "전용 메뉴 입니다.", conVo.getErpTypeCode());
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

    /* Contents View - 회계 (관리자) - 지출결의 관리 - 매입전자세금계산서 현황 ERPiU */
    @IncludedInfo(name = "세금계산서 현황(ERPiU)", order = 1506, gid = 150)
    @RequestMapping("/ex/admin/report/ExAdminETaxlListERPiU.do")
    public ModelAndView ExAdminETaxlListERPiU(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 커넥션 설정 확인 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            /* 변수정의 */
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
            /* View path 정의 [AdminERPiUETaxReport.jsp] */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINERPIUETAXREPORT);
            } else {
                throw new NotFoundLogicException(commonCode.ERPIU + "전용 메뉴 입니다.", conVo.getErpTypeCode());
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

    /* [] 관리자 - 회계 - iCUBE 연동문서 현황(관리자) */
    @IncludedInfo(name = "iCUBE 연동문서 현황", order = 1507, gid = 150)
    @RequestMapping("/ex/admin/report/ExiCUBEDocListReport.do")
    public ModelAndView ExiCUBEDocListReport(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            ExCommonResultVO commonParam = new ExCommonResultVO();
            List<ExCommonResultVO> commonListCode = new ArrayList<ExCommonResultVO>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 커넥션 설정 확인 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* 초기값 정의 */
            if (commonParam.getGroupSeq() == null || CommonConvert.CommonGetStr(commonParam.getGroupSeq()).equals("")) {
                commonParam.setGroupSeq(loginVo.getGroupSeq());
            }
            setCommonParams(sendParam);
            commonParam.setCompSeq(loginVo.getCompSeq());
            commonParam.setLangCode(loginVo.getLangCode());
            /* 공통코드 - 문서상태 */
            commonParam.setSearchType(commonCode.DOCSTATUS);
            commonListCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
            ExCommonResultVO allSts = new ExCommonResultVO();
            allSts.setCommonCode(commonCode.EMPTYSTR);
            if (loginVo.getLangCode().equals("en")) {
                allSts.setCommonName("all");
            } else {
                allSts.setCommonName("전체");
            }

            commonListCode.add(0, allSts);
            sendParam.put("commonCodeListDocStatus", JSONArray.fromObject(commonListCode));
            /* 반환값 처리 */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.addObject("systemType", conVo.getErpTypeCode());
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                mv.setViewName("/expend/ex/admin/content/" + commonExPath.ADMINICUBEDOCLISTREPORT);
            } else {
                throw new NotFoundLogicException(commonCode.ICUBE + "전용 메뉴 입니다.", conVo.getErpTypeCode());
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

    /* [] 관리자 - 회계 - 세금계산서 권한 설정 페이지 */
    @IncludedInfo(name = "세금계산서 권한 설정 페이지", order = 1112, gid = 110)
    @RequestMapping("/ex/admin/config/ExETaxAuthSetting.do")
    public ModelAndView ExETaxAuthSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            ResultVO result = new ResultVO();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            Map<String, Object> empInfo = new HashMap<String, Object>();
            empInfo = CommonConvert.CommonGetEmpInfo(); /* 사용자 정보 */
            result.setaData(itemService.ExAdminItemConfigSendParam());
            mv.addObject("CL", vo.getData());
            mv.addObject("empInfo", CommonConvert.CommonGetMapToJSONObj(empInfo));
            mv.addObject("compSeq", empInfo.get(commonCode.COMPSEQ));
            /* 반환값 처리 */
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

    /* [] 관리자 - 회계 - 지출결의설정 - 양식별표준적요&증빙유형설정 */
    @RequestMapping("/ex/admin/config/ExFormLinkCodeSetting.do")
    public ModelAndView ExFormLinkCodeSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            Map<String, Object> empInfo = new HashMap<String, Object>();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 기본값 정의 */
            empInfo = CommonConvert.CommonGetEmpInfo(); /* 사용자 정보 */
            mv.addObject("empInfo", empInfo);
            mv.addObject("CL", vo.getData());
            mv.addObject("compSeq", empInfo.get(commonCode.COMPSEQ));
            /* 반환값 정의 */
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

    /* [] 관리자 - 회계 - 지출결의설정 - 지출결의 마감 설정 */
    @RequestMapping("/ex/admin/config/ExCloseDateSetting.do")
    public ModelAndView ExCloseDateSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            Map<String, Object> empInfo = new HashMap<String, Object>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            /* 기본값 정의 */
            empInfo = CommonConvert.CommonGetEmpInfo(); /* 사용자 정보 */
            sendParam.put("formList", CommonConvert.CommonGetListMapToJson(cmInfo.CommonGetExFormListInfo(empInfo)));
            mv.addObject("empInfo", empInfo);
            mv.addObject("compSeq", empInfo.get(commonCode.COMPSEQ));
            mv.addObject("ViewBag", sendParam);
            mv.addObject("CL", vo.getData());
            /* 반환값 정의 */
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

    /* Content View - 관리자 - 회계 - 지출결의 설정 - 카드 설정(비영리) */
    @SuppressWarnings("unchecked")
    /* View - 법인카드관리(비영리) */
    @IncludedInfo(name = "[관리자] 법인카드 관리(설정)-비영리", order = 1122, gid = 110)
    @RequestMapping("/ex/admin/config/NpExCardConfig.do")
    public ModelAndView NpExConfigCardSetting(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (!CommonConvert.CommonGetEmpInfo().get("userSe").equals(commonCode.ADMIN)) {
                throw new CheckAuthorityException(commonCode.ADMIN);
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수 정의 */
            Map<String, Object> result = new HashMap<String, Object>();
            result = cardService.ExAdminCardConfigSendParam();
            mv.addObject("selUseYN", result.get("ex00001"));
            mv.addObject("selSetYN", result.get("ex00033"));
            /* 명칭정보 사용 View Object */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환 설정 */
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
     * 메뉴 : 관리자 > 회계 > 지출결의 설정 > 확장입력 설정
     * 기능 : 지출결의 양식의 추가 입력 정보를 설정하는 기능 ( 2019. 08. 21. 기준 직접입력(input)만 지원 )
     * </pre>
     *
     * @param param
     * @param request
     * @return
     *
     *         <pre>
     * 1. UserInfo : 로그인 사용자 정보
     * 2. FormInfo : 전자결재 지출결의 양식 목록
     * 3. CL : 다국어 정보
     *         </pre>
     *
     * @throws Exception
     */
    @IncludedInfo(name = "관리자 > 회계 > 지출결의 설정 > 확장입력 설정", order = 1011, gid = 102)
    @RequestMapping("/ex/admin/config/ExExtInputItemConfig.do")
    public ModelAndView ExExtInputItemConfig(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            // 사용자 로그인 정보 확인
            LoginVO login = new LoginVO();
            login = CommonConvert.CommonGetEmpVO();
            if (this.GetUserAuth().equals(commonCode.USER)) {
                throw new CheckAuthorityException("관리자 권한이 없는 사용자는 메뉴에 접근할 수 없습니다.");
            }

            // ERP 연결 설정 정보 확인
            ConnectionVO con = new ConnectionVO();
            con = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(login.getCompSeq()));

            // 다국어 정보 반환 정의
            try {
                CustomLabelVO label = cmInfo.CommonGetCustomLabelInfo(login.getCompSeq(), login.getLangCode(), login.getGroupSeq());
                mv.addObject("CL", label.getData());
            } catch (Exception e) {
                ExpInfo.TipLog("다국어 정보 조회중 오류가 발생되었습니다. 로그인 사용자 정보가 정상인지 확인이 필요하며, 다국어 정보 조회 쿼리가 정상인지 확인해주세요.");
                throw new Exception(e);
            }

            // 사용자 정보 반환 정의
            mv = this.SetUserInfoToMNV(mv, con, login);

            // 양식 정보 반환 정의
            mv.addObject("FormInfo", CommonConvert.CommonGetListMapToJson(cmInfo.CommonGetExFormListInfo(CommonConvert.CommonGetEmpInfo())));

            // JSP 반환 정의
            mv.setViewName(CommonMapper.GetEXAdminExtInputConfig());
        } catch (CheckAuthorityException e) {
            ExpInfo.TipLog("관리자 > 회계 > 지출결의 설정 > 확장입력 설정 메뉴는 관리자만 접근이 가능합니다.");
            mv.setViewName(CommonMapper.GetExErrorCheckAuth());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("관리자 > 회계 > 지출결의 설정 > 확장입력 설정 메뉴에 접근하였으나, 사용자 로그인정보를 확인할 수 없습니다.");
            mv.setViewName(CommonMapper.GetExErrorCheckLogin());
        } catch (CheckErpTypeException e) {
            ExpInfo.TipLog("관리자 > 회계 > 지출결의 설정 > 확장입력 설정 메뉴에 접근하였으나, ERP 연동 설정정보를 확인할 수 없습니다.");
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
    /* View - 공통코드 조회 */
    private void setCommonParams(Map<String, Object> sendParam) throws Exception {
        LoginVO loginVo = new LoginVO();
        ExCommonResultVO commonParam = new ExCommonResultVO();
        List<ExCommonResultVO> commonCode = new ArrayList<ExCommonResultVO>();
        /* 초기값 정의 */
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
        /* ERP 연결정보 조회 */
        /* 기본값 지정 - 연동 시스템 정보 처리 */
        ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(commonParam.getCompSeq()));
        sendParam.put(CommonInterface.commonCode.IFSYSTEM, conVo.getErpTypeCode());
        /* 공통코드 */
        /* 공통코드 - 회사목록 */
        // sendParam.put("compListInfo", JSONArray.fromObject(exMasterConfigService.GCompanyListS(sendParam)));
        commonCode = exUserCodeService.ExCodeCommonCompListInfoSelect(commonParam);
        sendParam.put("compListInfo", JSONArray.fromObject(commonCode));
        /* 공통코드 - 사용여부 */
        commonParam.setSearchType(CommonInterface.commonCodeKey.USEYN);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListUseYN", JSONArray.fromObject(commonCode));
        /* 공통코드 - 예 / 아니오 */
        commonParam.setSearchType(CommonInterface.commonCodeKey.YESORNO);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListYesOrNo", JSONArray.fromObject(commonCode));
        /* 전자결재 - 양식목록 */
        commonCode = exUserCodeService.ExCodeCommonFormListInfoSelect(commonParam);
        sendParam.put("formListInfo", JSONArray.fromObject(commonCode));
        /* 공통코드 - 차대구분 */
        commonParam.setSearchType(CommonInterface.commonCode.DRCRTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListDrcrGbn", JSONArray.fromObject(commonCode));
        /* 공통코드 - 관리항목 설정 항목 */
        commonParam.setSearchType(CommonInterface.commonCode.MNGMAPTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListMngMapType", JSONArray.fromObject(commonCode));
        /* 공통코드 - 표준적요 구분 / 적요구분 */
        commonParam.setSearchType(CommonInterface.commonCode.SUMMARYTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListSummaryType", JSONArray.fromObject(commonCode));
        /* 공통코드 - 검색어 구분 */
        commonParam.setSearchType(CommonInterface.commonCode.SUMMARYSEARCHTYPE);
        commonCode = exUserCodeService.ExCodeCommonCodeListInfoSelect(commonParam);
        sendParam.put("commonCodeListSummarySearchType", JSONArray.fromObject(commonCode));
    }
}
