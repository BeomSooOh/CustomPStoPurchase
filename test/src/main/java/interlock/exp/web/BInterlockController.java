/**
 *   * @FileName : BInterlockController.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
package interlock.exp.web;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cloud.CloudConnetInfo;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;
import common.vo.interlock.InterlockNpInterfaceFormVO;
import interlock.exp.approval.BApprovalService;


/**
 *   * @FileName : BInterlockController.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
@Controller
public class BInterlockController {

    // 변수정의
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    // service
    @Resource(name = "BApprovalService")
    private BApprovalService approvalService;
    @Resource(name = "CommonLogger")
    private final CommonLogger cmLog = new CommonLogger();

    /* Approval process */
    /* Approval process - DocMake */
    @RequestMapping("/ApprovalDocMake.do")
    public ModelAndView ApprovalDocMake(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
        /* 변수정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* processId / approKey / docTitle / interlockUrl / interlockName / docSeq / formSeq */
            result.setProcessId(CommonConvert.CommonGetStr(params.get("processId")));
            result.setApproKey(CommonConvert.CommonGetStr(params.get("approKey")));
            result.setDocTitle(CommonConvert.CommonGetStr(params.get("docTitle")));
            result.setInterlockUrl(CommonConvert.CommonGetStr(params.get("interlockUrl")));
            result.setInterlockName(CommonConvert.CommonGetStr(params.get("interlockName")));
            // 20180910 soyoung, interlockName 이전단계 영문/일문/중문 추가
            result.setInterlockNameEn(CommonConvert.CommonGetStr(params.get(commonCode.INTERLOCKNAMEEN)));
            result.setInterlockNameJp(CommonConvert.CommonGetStr(params.get(commonCode.INTERLOCKNAMEJP)));
            result.setInterlockNameCn(CommonConvert.CommonGetStr(params.get(commonCode.INTERLOCKNAMECN)));
            result.setDocSeq(CommonConvert.CommonGetStr(params.get("docSeq")));
            result.setFormSeq(CommonConvert.CommonGetStr(params.get("formSeq")));
            result.setDocContent(CommonConvert.CommonGetStr(params.get("docContents")));
            result.setPreUrl(CommonConvert.CommonGetStr(params.get("preUrl")));
            result.setGroupSeq(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getGroupSeq()));

            if (CommonConvert.CommonGetStr(params.get("processId")).equals("ANGUI")) {
                /* 국고보조 한글 양식 코드 조회 쿼리 */
                if (params.containsKey("selectSql") && CommonConvert.CommonGetStr(params.get("selectSql")).equals("Y")) {

                    StringBuilder sb = new StringBuilder();
                    sb.append(" select  A.gisu_date AS startDt /* 결의일자 ( 회계일자 ) */ ");
                    sb.append("        , B.mosf_gisu_dt as reqDate /* 집행등록 결의일자 */ ");
                    sb.append("        , B.bsnsyear as bsnsyear /* 사업연도 */ ");
                    sb.append("        , B.excut_requst_de as excutRequstDe /* 증빙사용 일자 */ ");
                    sb.append("        , B.bcnc_cmpny_nm as bcncCmpnyNm /* 거래처 회사명 */ ");
                    sb.append(" from    ( ");
                    sb.append("                SELECT	comp_seq ");
                    sb.append("                        , anbojo_seq ");
                    sb.append("                        , doc_seq ");
                    sb.append("                        , form_seq ");
                    sb.append("                        , gisu_date /* 결의일자 ( 회계일자 ) */ ");
                    sb.append("                FROM		" + CloudConnetInfo.getParamMap(CommonConvert.CommonGetEmpVO().getGroupSeq()).get("DB_NEOS") + "t_ex_anbojo ");
                    sb.append("                where   anbojo_seq = " + CommonConvert.CommonGetStr(params.get("approKey")).replace("ANGUI_EX_", "") + " ");
                    sb.append("        ) A inner join ( ");
                    sb.append("                SELECT	anbojo_seq ");
                    sb.append("                        , d_seq ");
                    sb.append("                        , mosf_gisu_dt /* 집행등록 결의일자 */ ");
                    sb.append("                        , bsnsyear /* 사업연도 */ ");
                    sb.append("                        , excut_requst_de /* 증빙사용 일자 */ ");
                    sb.append("                        , bcnc_cmpny_nm /* 거래처 회사명 */ ");
                    sb.append("                FROM		" + CloudConnetInfo.getParamMap(CommonConvert.CommonGetEmpVO().getGroupSeq()).get("DB_NEOS") + "t_ex_anbojo_abdocu ");
                    sb.append("                WHERE   anbojo_seq = " + CommonConvert.CommonGetStr(params.get("approKey")).replace("ANGUI_EX_", "") + " ");
                    sb.append("        ) B on A.anbojo_seq = B.anbojo_seq ");

                    result.setSelectSql(sb.toString());
                } else {
                    result.setSelectSql("");
                }
            }

            /* 전자결재 문서 생성 */
            result = approvalService.DocMake(result);
            /* 반환값 정의 */
            mv.addObject("result", result);
            mv.setViewName("jsonView");
        } catch (Exception e) {
            // TODO: handle exception
            result.setDocSeq("-1");
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
            /* 반환값 정의 */
            mv.addObject("result", result);
            mv.setViewName("jsonView");
        }
        /* 반환 */
        return mv;
    }

    /* Approval process - 공통 */
    private String GetExpSeq(String processId, String approKey) throws Exception {
        String expSeq = "";

        switch (processId) {
            case commonCode.EXI:
            case commonCode.EXU:
                expSeq = approKey.replace(processId + "_EX_", commonCode.EMPTYSTR);
                break;
            case commonCode.EZICUBE:
            case commonCode.EZERPIU:
                expSeq = approKey.replace(processId + "_", commonCode.EMPTYSTR);
                break;
            case commonCode.EXNPCONI:
            case commonCode.EXNPCONU:
            case commonCode.EXNPRESI:
            case commonCode.EXNPRESU:
                expSeq = approKey.replace(processId + "_NP_", commonCode.EMPTYSTR);
                break;
            case commonCode.TRIPCONS:
            case commonCode.TRIPRES:
            	expSeq = approKey.replace(processId + "_TRIP_", commonCode.EMPTYSTR).split( "_" )[1];
            	break;
            default:
                throw new Exception("정의되지 않은 processId 가 수신되었습니다.");
        }

        return expSeq;
    }

    //private String GetTripSeq(String processId, String approKey) throws Exception {
    private String GetTripSeq(String approKey) throws Exception {
    	return approKey.split( "_" )[2];
    }

    @RequestMapping(value = "/ApprovalProcess.do", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public InterlockExpendVO ApprovalProcess(HttpServletRequest servletRequest, @RequestBody Map<String, Object> request, @RequestParam Map<String, Object> params) throws Exception {

        UUID uuid = UUID.randomUUID();
        String uID = uuid.toString();
        ExpInfo.CoreLogNotLoop("#[" + uID + "] 전자결재 외부 연동 API 수신 >> ", request.toString());

        // 반홥값 정
        InterlockExpendVO result = new InterlockExpendVO();

        try {
            // 변수정의
            Map<String, Object> approvalInfo = new HashMap<String, Object>();

            // 파라미터 정보
            approvalInfo = CommonConvert.CommonSetMapCopyNotKey(request);
            approvalInfo = CommonConvert.CommonSetMapCopy(approvalInfo);
            String processId = CommonConvert.CommonGetStr(approvalInfo.get(commonCode.PROCESSID));
            String approKey = CommonConvert.CommonGetSeq(approvalInfo.get(commonCode.APPROKEY));
            String requestDomain = servletRequest.getScheme() + "://" + ( servletRequest.getServerName() + ":" + servletRequest.getServerPort() );
            approvalInfo.put( "requestDomain", requestDomain );

            // exp seq 확인
            switch (processId) {
                case commonCode.EXI:
                case commonCode.EXU:
                    approvalInfo.put(commonCode.EXPENDSEQ, this.GetExpSeq(processId, approKey));
                    break;
                case commonCode.EZICUBE:
                case commonCode.EZERPIU:
                    approvalInfo.put(commonCode.SEQ, this.GetExpSeq(processId, approKey));
                    break;
                case commonCode.EXNPCONI:
                case commonCode.EXNPCONU:
                    approvalInfo.put(commonCode.CONSDOCSEQ, this.GetExpSeq(processId, approKey));
                    break;
                case commonCode.EXNPRESI:
                case commonCode.EXNPRESU:
                    approvalInfo.put(commonCode.RESDOCSEQ, this.GetExpSeq(processId, approKey));
                    break;
                case commonCode.TRIPCONS:
                	approvalInfo.put(commonCode.CONSDOCSEQ, this.GetExpSeq(processId, approKey));
                	//approvalInfo.put(commonCode.tripConsDocSeq, this.GetTripSeq(processId, approKey));
                	approvalInfo.put(commonCode.TRIPCONSDOCSEQ, this.GetTripSeq( approKey));
                	break;
                case commonCode.TRIPRES:
                	approvalInfo.put(commonCode.RESDOCSEQ, this.GetExpSeq(processId, approKey));
                	//approvalInfo.put(commonCode.tripResDocSeq, this.GetTripSeq(processId, approKey));
                	approvalInfo.put(commonCode.TRIPRESDOCSEQ, this.GetTripSeq(approKey));
                	break;
                default:
                    throw new Exception("#[" + uID + "] [양식 설정 오류] 전자결재 외부 연동 API >> 정의되지 않은 processId가 수신되었습니다. >> processId : " + processId);
            }

            if (processId.equals(commonCode.EXNPCONI) || processId.equals(commonCode.EXNPCONU) || processId.equals(commonCode.EXNPRESI) || processId.equals(commonCode.EXNPRESU)) {
                /* 결재문서 정보 조회 */
                if (CommonConvert.CommonGetStr(approvalInfo.get(commonCode.DOCNO)).equals(commonCode.EMPTYSTR)) {
                    ResultVO tApprovalInfo = new ResultVO();

                    try {
                        tApprovalInfo = approvalService.ApprovalInfoSelect(approvalInfo);
                    } catch (Exception e) {
                        ExpInfo.CLog("#[" + uID + "] [에러발생] 전자결재 외부 연동 API >> approvalService.ApprovalInfoSelect(approvalInfo);", approvalInfo);
                        throw new Exception(e);
                    }

                    if (tApprovalInfo.getaData() == null) {
                        tApprovalInfo.setaData(new HashMap<String, Object>());
                    }

                    approvalInfo.put(commonCode.DOCNO, CommonConvert.CommonGetStr(tApprovalInfo.getaData().get(commonCode.DOCNO)));
                }
                if (processId.indexOf("EXNPCON") > -1) {
                    String consDocSeq = approvalInfo.get(commonCode.APPROKEY).toString().split(processId + "_NP_")[1];
                    approvalInfo.put(commonCode.CONSDOCSEQ, consDocSeq);
                } else if (processId.indexOf("EXNPRES") > -1) {
                    String resDocSeq = approvalInfo.get(commonCode.APPROKEY).toString().split(processId + "_NP_")[1];
                    approvalInfo.put(commonCode.RESDOCSEQ, resDocSeq);
                }

                approvalInfo.put("docStatus", CommonConvert.CommonGetStr(approvalInfo.get(commonCode.DOCSTS)));
            }

            String advUseYn = "";

            try {
                advUseYn = approvalService.SelectAdvInterInfoCount(approvalInfo);
            } catch (Exception e) {
                ExpInfo.CLog("#[" + uID + "] [에러발생] 전자결재 외부 연동 API >> approvalService.SelectAdvInterInfoCount(approvalInfo);", approvalInfo);
                advUseYn = "N";
            }

            /* 커스터 마이징 대응 기능 */
            if (advUseYn.equals(commonCode.EMPTYYES)) {
                ResultVO advInterResult = new ResultVO();

                try {
                    advInterResult = approvalService.ExcuteAdvInter(approvalInfo);
                } catch (Exception e) {
                    ExpInfo.CLog("#[" + uID + "] [에러발생] 전자결재 외부 연동 API >> approvalService.ExcuteAdvInter(approvalInfo);", approvalInfo);
                    throw new Exception(e);
                }

                if (advInterResult.getResultCode().contentEquals(commonCode.FAIL)) {
                    throw new Exception(result.getResultCode());
                }
            }

            /* 문서상태별 처리 */
            switch (CommonConvert.CommonGetStr(approvalInfo.get(commonCode.DOCSTS))) {
                case "0":
                    ExpInfo.CoreLogNotLoop("#[" + uID + "] 전자결재 외부 연동 API >> 문서 상태 처리 >> 0 >> 본문조회", approvalInfo);
                    result.setContent(approvalService.ApprovalProcessContent(CommonConvert.CommonGetSeq(approvalInfo.get(commonCode.DOCSEQ)), CommonConvert.CommonGetSeq(approvalInfo.get(commonCode.EMPSEQ))));
                case "10":
                    ExpInfo.CoreLogNotLoop("#[" + uID + "] 전자결재 외부 연동 API >> 문서 상태 처리 >> 10 >> 임시보관(상신 > 상신취소)", approvalInfo);
                    result = ApprovalProcessSave(approvalInfo);
                    approvalInfo.put("gwState", "1"); // <<== 법인카드 승인내역 전자결재 상태 연동을 위한 코드 처리
                    break;
                case "20":
                case "002":
                    ExpInfo.CoreLogNotLoop("#[" + uID + "] 전자결재 외부 연동 API >> 문서 상태 처리 >> 20 >> 상신", approvalInfo);
                    result = ApprovalProcessApproval(approvalInfo);
                    approvalInfo.put("gwState", "1"); // <<== 법인카드 승인내역 전자결재 상태 연동을 위한 코드 처리
                    break;
                case "90":
                case "008":
                    ExpInfo.CoreLogNotLoop("#[" + uID + "] 전자결재 외부 연동 API >> 문서 상태 처리 >> 90 >> 종결", approvalInfo);
                    result = ApprovalProcessEnd(approvalInfo);
                    approvalInfo.put("gwState", "2"); // <<== 법인카드 승인내역 전자결재 상태 연동을 위한 코드 처리
                    break;
                case "100":
                case "007":
                case "005" :
                    ExpInfo.CoreLogNotLoop("#[" + uID + "] 전자결재 외부 연동 API >> 문서 상태 처리 >> 100 >> 반려", approvalInfo);
                    result = ApprovalProcessReturn(approvalInfo);
                    approvalInfo.put("gwState", ""); // <<== 법인카드 승인내역 전자결재 상태 연동을 위한 코드 처리
                    break;
                case "999":
                case "d":
                    ExpInfo.CoreLogNotLoop("#[" + uID + "] 전자결재 외부 연동 API >> 문서 상태 처리 >> 999 >> 삭제", approvalInfo);
                    result = ApprovalProcessDelete(approvalInfo);
                    approvalInfo.put("gwState", ""); // <<== 법인카드 승인내역 전자결재 상태 연동을 위한 코드 처리
                    break;
                default :
                	break;
            }

            /** iCUBE 연동 고객사 법인카드 승인 데이터 상태값 변경 **/
            switch (processId) {
            	case commonCode.EXNPRESI:
            	case commonCode.TRIPRES:
            		/* 비영리 결의서 법인카드 승인내역 조회 */
            		approvalInfo.put("moduleType", commonCode.MODULECODENP);
            		approvalService.ExcuteAdvInterICubeCard(approvalInfo);
            		break;
            	case commonCode.EXI:
            		/* 영리 결의서 법인카드 승인내역 조회 */
            		approvalInfo.put("moduleType", commonCode.MODULECODEEXP);
            		approvalService.ExcuteAdvInterICubeCard(approvalInfo);
            		break;
                default :
                	break;
            }

        } catch (Exception e) {
            logger.error(e);

            result.setResultCode(commonCode.FAIL);
            result.setResultMessage(e.getLocalizedMessage());
        }

        /* 반환처리 */
        return result;
    }

    /* Approval form test */
    @RequestMapping(value = "/ApprovalProcessNpInterfaceFormTest.do", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public InterlockNpInterfaceFormVO ApprovalProcessNpInterfaceFormTest(HttpServletRequest servletRequest, @RequestBody Map<String, Object> request, @RequestParam Map<String, Object> params) throws Exception {
        InterlockNpInterfaceFormVO result = new InterlockNpInterfaceFormVO();

        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
        sb.append("		<tr>");
        sb.append("			<td>");
        sb.append("				Hello World!");
        sb.append("			</td>");
        sb.append("		</tr>");
        sb.append("</table>");

        result.setResultCode(commonCode.SUCCESS);
        result.setResultContent(sb.toString());
        result.setResultMessage(commonCode.SUCCESS);

        return result;
    }

    /* Approval process - 보관 */
    private InterlockExpendVO ApprovalProcessSave(Map<String, Object> params) throws Exception {
        InterlockExpendVO result = new InterlockExpendVO();

        try {
            result = approvalService.ApprovalProcessSave(params);
        } catch (Exception e) {
            throw new Exception(e);
        }

        return result;
    }

    /* Approval process - 상신 */
    private InterlockExpendVO ApprovalProcessApproval(Map<String, Object> params) throws Exception {
        InterlockExpendVO result = new InterlockExpendVO();

        try {
            result = approvalService.ApprovalProcessApproval(params);
        } catch (Exception e) {
            throw new Exception(e);
        }

        return result;
    }

    /* Approval process - 종결 */
    private InterlockExpendVO ApprovalProcessEnd(Map<String, Object> params) throws Exception {
        InterlockExpendVO result = new InterlockExpendVO();

        try {
            result = approvalService.ApprovalProcessEnd(params);
        } catch (Exception e) {
            throw new Exception(e);
        }

        return result;
    }

    /* Approval process - 반려 */
    private InterlockExpendVO ApprovalProcessReturn(Map<String, Object> params) throws Exception {
        InterlockExpendVO result = new InterlockExpendVO();

        try {
            result = approvalService.ApprovalProcessReturn(params);
        } catch (Exception e) {
            throw new Exception(e);
        }

        return result;
    }

    /* Approval process - 삭제 */
    private InterlockExpendVO ApprovalProcessDelete(Map<String, Object> params) throws Exception {
        InterlockExpendVO result = new InterlockExpendVO();

        try {
            result = approvalService.ApprovalProcessDelete(params);
        } catch (Exception e) {
            throw new Exception(e);
        }

        return result;
    }
}
