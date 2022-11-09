/**
 *   * @FileName : BApprovalServiceImpl.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
package interlock.exp.approval;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.form.BCommonFormService;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonEaApi;
import common.vo.common.ResultVO;
import common.vo.interlock.InterlockExpendVO;
import interlock.exp.adv.FAdvInterService;
import main.web.BizboxAMessage;
import neos.cmm.util.HttpJsonUtil;
import net.sf.json.JSONObject;


/**
 *   * @FileName : BApprovalServiceImpl.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
@Service("BApprovalService")
public class BApprovalServiceImpl implements BApprovalService {

    /* 변수정의 */
    protected final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    /* 변수정의 - Service */
    @Resource(name = "FApprovalServiceA")
    private FApprovalService eaService;
    @Resource(name = "FApprovalServiceP")
    private FApprovalService eapService;
    /* 변수정의 - Class */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo;
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog;
    @Resource(name = "BCommonFormService")
    private BCommonFormService formService;
    @Resource(name = "FAdvInterServiceI")
    private FAdvInterService advInterServiceI;

    /* ################################################## */
    /* 결재 문서 생성 */
    /* ################################################## */
    /* 전자결재 기초 문서 생성 */
    /* 필수 파라메터 : ResultVO(processId, approKey, docTitle, docSeq, formSeq, header, conrtent, footer */
    @Override
    public ResultVO DocMake(ResultVO params) {
        LoginVO loginVo = new LoginVO();

        try {
            loginVo = CommonConvert.CommonGetEmpVO();
        } catch (Exception e) {
            logger.error(e);
            e.printStackTrace();
        }

        /* 변수정의 - JSONObject */
        JSONObject jBody = new JSONObject();
        JSONObject jBodyContent = new JSONObject();
        JSONObject jResult = new JSONObject();

        /* 기본값 지정 */
        /* 기본값 지정 - 전자결재 정보 */
        jBodyContent.put(commonCode.PROCESSID, CommonConvert.CommonGetStr(params.getProcessId()));
        jBodyContent.put(commonCode.APPROKEY, CommonConvert.CommonGetStr(params.getApproKey()));
        jBodyContent.put(commonCode.DOCTITLE, CommonConvert.CommonGetStr(params.getDocTitle()));
        /* TODO : 이전단계 구현 */
        jBodyContent.put(commonCode.INTERLOCKURL, CommonConvert.CommonGetStr(params.getInterlockUrl()));
        jBodyContent.put(commonCode.INTERLOCKNAME, CommonConvert.CommonGetStr(params.getInterlockName()));
        // 20180910 soyoung, interlockName 이전단계(정보수정) 영문/일문/중문 추가
        jBodyContent.put(commonCode.INTERLOCKNAMEEN, CommonConvert.CommonGetStr(params.getInterlockNameEn()));
        jBodyContent.put(commonCode.INTERLOCKNAMEJP, CommonConvert.CommonGetStr(params.getInterlockNameJp()));
        jBodyContent.put(commonCode.INTERLOCKNAMECN, CommonConvert.CommonGetStr(params.getInterlockNameCn()));
        // jBodyContent.put( commonCode.interlockUrl, commonCode.EMPTYSTR );
        // jBodyContent.put( commonCode.interlockName, commonCode.EMPTYSTR );
        jBodyContent.put("doc_id", CommonConvert.CommonGetSeq(params.getDocSeq()));
        jBodyContent.put("form_id", CommonConvert.CommonGetSeq(params.getFormSeq()));
        /* 비영리 전자결재 ( 재기안 연동 ) */
        if (loginVo.getEaType().toLowerCase().equals(commonCode.EA)) {
            jBodyContent.put("reDraftUrl", CommonConvert.CommonGetStr(params.getReDraftUrl()));

            if (!CommonConvert.CommonGetStr(params.getOriApproKey()).equals("")) {
                jBodyContent.put("redraftYn", "Y");
            }
        }

        if (CommonConvert.CommonGetStr(params.getDocContent()).equals(commonCode.EMPTYSTR)) {
            jBodyContent.put(commonCode.DOCCONTENT, CommonConvert.CommonGetStr(DocMakeContent(CommonConvert.CommonGetStr(params.getProcessId()), params.getHeader(), params.getContent(), params.getFooter())));
            params.setDocContent(CommonConvert.CommonGetStr(jBodyContent.get(commonCode.DOCCONTENT)));
        }

        jBodyContent.put(commonCode.DOCCONTENT, CommonConvert.CommonGetStr(params.getDocContent()));

        /* 비영리 양식 코드 조회 SQL */
        if (!CommonConvert.CommonGetStr(params.getSelectSql()).equals("")) {
            jBodyContent.put("selectSql", params.getSelectSql());
        }

        /* 참조 문서 정보 추가 */
        jBodyContent.put("refDocList", params.getRefDocList());

        /* 기본값 지정 - 로그인 정보 */
        jBodyContent.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr(loginVo.getGroupSeq()));
        jBodyContent.put("loginVo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetObjectToMap(loginVo)));
        /* 기본값 지정 - API 변수 정의 */
        jBody.put("body", jBodyContent);
        /* 전자결재 API 호출 */
        /* 전자결재 API 호출 - Sample : { "resultCode": "SUCCESS", "resultMessage": "성공하였습니다", "result": { "approKey": "EXPENDI", "processId": "EXPENDI", "docId": 172289 } } */
        params.setEaType(CommonConvert.CommonGetStr(loginVo.getEaType()));
        if (loginVo.getEaType().toLowerCase().equals(commonCode.EA)) {
            /* 비영리 */
            try {
                jResult = JSONObject.fromObject(HttpJsonUtil.execute(commonCode.POST, params.getPreUrl() + "/" + commonCode.EA + commonEaApi.DOCMAKE, jBody));
            } catch (Exception e) {
            	e.printStackTrace();
                ExpInfo.ProcessLog("비영리 전자결재 API 호출 오료 발생 >> " + (params.getPreUrl() + "/" + commonCode.EA + commonEaApi.DOCMAKE));
            } finally {
                ExpInfo.ProcessLog("비영리 전자결재 DocMake URL : " + (params.getPreUrl() + "/" + commonCode.EA + commonEaApi.DOCMAKE), jResult);
            }

            params.setDocSeq(CommonConvert.CommonGetStr(((JSONObject) jResult.get("result")).get("doc_id")));
            params.setResultCode( CommonConvert.CommonGetStr( jResult.get( "resultCode" ) ) );
        } else if (loginVo.getEaType().toLowerCase().equals(commonCode.EAP)) {
            /* 영리 */
            try {
                logger.info(" URL [" +  params.getPreUrl().toString() + "]");
                jResult = JSONObject.fromObject(HttpJsonUtil.execute(commonCode.POST, params.getPreUrl() + "/" + commonCode.EAP + commonEaApi.DOCMAKE, jBody));
            } catch (Exception e) {
                ExpInfo.ProcessLog("영리 전자결재 API 호출 오료 발생 >> " + (params.getPreUrl() + "/" + commonCode.EAP + commonEaApi.DOCMAKE));
            } finally {
                ExpInfo.ProcessLog("영리 전자결재 DocMake URL : " + (params.getPreUrl() + "/" + commonCode.EAP + commonEaApi.DOCMAKE), jResult);
            }

            if (jResult.get("result") == null) {
                jBodyContent.put("docContent", "");
                ExpInfo.ProcessLog("전자결재 API 호출에 실패하였습니다. >> " + jResult.toString(), jBodyContent);
                params.setDocSeq(loginVo.getEaType().toLowerCase().equals(commonCode.EA) ? "-1" : "0");
                params.setResultCode(commonCode.FAIL);
            } else {
                params.setDocSeq(CommonConvert.CommonGetStr(((JSONObject) jResult.get("result")).get(commonCode.DOCID)));
                params.setResultCode(CommonConvert.CommonGetStr(jResult.get("resultCode")));
            }
        }

        return params;
    }

    /* 결재 문서 생성 - 본문생성 */
    private String DocMakeContent(String processId, Map<String, Object> head, List<Map<String, Object>> content, Map<String, Object> footer) {

    	Map<String, Object> backFooter = footer;
    	/* 변수정의 - VO */
        LoginVO loginVo = new LoginVO();
        Map<String, Object> npFormParam = new HashMap<String, Object>();
        npFormParam = CommonConvert.CommonSetMapCopy(head, npFormParam);
        try {
            loginVo = CommonConvert.CommonGetEmpVO();
        } catch (NotFoundLoginSessionException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        switch (CommonConvert.CommonGetStr(processId)) {
            case commonCode.EXA:
            case commonCode.EXI:
            case commonCode.EXU:
                HashMap<String, Object> docParam = new HashMap<>();
                String result = "";
                try {
                    docParam.put("expendSeq", head.get("expendSeq"));
                    docParam.put("formSeq", head.get("formSeq"));
                    result = formService.DocMaker(docParam).getaData().get("html").toString();
                } catch (Exception e) {
                    e.printStackTrace();
                    return "";
                }
                return result;
            // 구버전
            // return DocMakeContentEx( processId, head, content, footer );
            case commonCode.ETC:
                return commonCode.EMPTYSTR;
            case commonCode.EZICUBE:
            case commonCode.EZERPIU:
                //return DocMakeContentEzbaro(processId, head, content, footer);
            	return DocMakeContentEzbaro(processId, head, content);
            case commonCode.EXNPCONI:
            case commonCode.EXNPCONU:
            case commonCode.EXNPRESI:
            case commonCode.EXNPRESU:
            case commonCode.TRIPCONS:
            case commonCode.TRIPRES:
                String npResult = "";
                npFormParam.put("eaType", loginVo.getEaType());
                npFormParam.put("needSample", "N");
                npFormParam.put("formSeq", head.get("formSeq").toString());
                npFormParam.put("compSeq", loginVo.getCompSeq());
                try {
                    // npResult = formService.NpDocMake( npFormParam ).getaData( ).get( "html" ).toString( );
                    /* 해당 양식 조회 */
                    String html = CommonConvert.CommonGetStr(formService.CommonNPFormDataInfo(npFormParam).getaData().get("formInfo"));
                    /* parameter : exDocSeq(cons_doc_seq,res_doc_seq), html(해당 html 정보) */
                    String approKey = npFormParam.get(commonCode.APPROKEY).toString();
                    if(approKey.contains("TRIP")) {
                    	String tripDocSeqKey = approKey.split(processId + "_TRIP_")[1];
                    	npFormParam.put("exDocSeq", tripDocSeqKey.split("_")[1]);
                    	if(approKey.contains("CONS")) {
                    		npFormParam.put("tripConsDocSeq", tripDocSeqKey.split("_")[0]);
                    	}
                    	else {
                    		npFormParam.put("tripResDocSeq", tripDocSeqKey.split("_")[0]);
                    	}
                    }else {
                    	npFormParam.put("exDocSeq", approKey.split(processId + "_NP_")[1]);
                    }
                    npFormParam.put("html", html);
                    ResultVO npdocmakerResult = formService.NPDocMaker(npFormParam);
                    if(npdocmakerResult.getaData().get("html")==null) {
                    	return commonCode.EMPTYSTR;
                    }
                    else {
                    	npResult = npdocmakerResult.getaData().get("html").toString();
                    	//npResult = formService.NPDocMaker(npFormParam).getaData().get("html").toString();
                    }
                } catch (Exception e) {
                	cmLog.CommonSetErrorToDatabase( e, "", "", "exnp" );
                	cmLog.CommonSetError( e );

                	StringWriter sw = new StringWriter();
                	e.printStackTrace(new PrintWriter(sw));
                    return e.getMessage( ) + "[ /// ]" + sw.toString( );
                }
                return npResult;
            default:
                return commonCode.EMPTYSTR;
        }
    }

    /* 결재 문서 생성 - 본문생성 - 지출결의서 */
    @SuppressWarnings("unused")
    private String DocMakeContentEx(String processId, Map<String, Object> head, List<Map<String, Object>> content, Map<String, Object> footer) {
        switch (CommonConvert.CommonGetStr(processId)) {
            case commonCode.EXA:
                //return DocMakeContentExA(head, content, footer);
            	return DocMakeContentExA();
            case commonCode.EXI:
                //return DocMakeContentExI(head, content, footer);
            	return DocMakeContentExI(head, content);
            case commonCode.EXU:
                //return DocMakeContentExU(head, content, footer);
            	return DocMakeContentExU(head, content);
            default:
                return commonCode.EMPTYSTR;
        }
    }

    /* 결재 문서 생성 - 본문생성 - 지출결의서 - Bizbox Alpha */
    //private String DocMakeContentExA(Map<String, Object> head, List<Map<String, Object>> content, Map<String, Object> footer) {
    private String DocMakeContentExA() {
    	return "Bizbox Alpha 지출결의 본문";
    }

    /* 결재 문서 생성 - 본문생성 - 지출결의서 - iCUBE */
    //private String DocMakeContentExI(Map<String, Object> head, List<Map<String, Object>> content, Map<String, Object> footer) {
    private String DocMakeContentExI(Map<String, Object> head, List<Map<String, Object>> content) {
        LoginVO loginVO = new LoginVO();
        try {
            loginVO = CommonConvert.CommonGetEmpVO();
        } catch (NotFoundLoginSessionException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        /* 변수정의 - StringBuilder */
        StringBuilder sbContent = new StringBuilder();
        /* 변수정의 - DecimalFormat */
        DecimalFormat decimalFormat = new DecimalFormat("#,##0");
        /* 변수정의 - Double */
        Double exStdAmt = (double) 0;
        Double exTaxAmt = (double) 0;
        Double exAmt = (double) 0;
        /* 변수정의 - int */
        int rowNum = 0;
        int lineSeq = 0;
        String expendReqDate = CommonConvert.CommonGetStr(head.get("expend_req_date"));
        if (expendReqDate != null && expendReqDate.length() == 8) {
            expendReqDate = expendReqDate.substring(0, 4) + "-" + expendReqDate.substring(4, 6) + "-" + expendReqDate.substring(6, 8);
        } else {
            expendReqDate = "0000-00-00";
        }
        String expendDate = CommonConvert.CommonGetStr(head.get("expend_date"));
        if (expendDate != null && expendDate.length() == 8) {
            expendDate = expendDate.substring(0, 4) + "-" + expendDate.substring(4, 6) + "-" + expendDate.substring(6, 8);
        } else {
            expendDate = "0000-00-00";
        }
        /* 첨부파일 조회 */
        boolean isHaveAttach = false;
        String lineSeqs = "";
        ResultVO attachInfo = new ResultVO();
        try {
            attachInfo = eapService.ApprovalSelectAttachInfo(head);
            isHaveAttach = (attachInfo.getAaData().size() != 0);
            lineSeqs = attachInfo.getResultName();
        } catch (Exception e) {
            isHaveAttach = false;
            lineSeqs = "";
        }
        /* 지출결의 양식 생성 - 고정양식으로 개발 */
        /* 지출결의 양식 생성 - 고정양식으로 개발 - 헤더 */
        sbContent.append("<TABLE class=\"statement\" width=\"100%\">");
        sbContent.append("	<colgroup width=\"5%\"></colgroup>"); /* 순번 라인 */
        sbContent.append("	<colgroup width=\"14%\"></colgroup>"); /* 계정분류 라인 */
        sbContent.append("	<colgroup></colgroup>"); /* 적요 1 라인 */
        sbContent.append("	<colgroup width=\"14%\"></colgroup>"); /* 적요 2 라인 */
        sbContent.append("	<colgroup width=\"15%\"></colgroup>"); /* 증빙구분 라인 */
        sbContent.append("	<colgroup width=\"15%\"></colgroup>"); /* 증빙일자 라인 */
        sbContent.append("	<colgroup width=\"19%\"></colgroup>"); /* 법인카드 라인 */
        sbContent.append("	<tr height=\"25\">");
        sbContent.append("		<th colspan=\"1\"><b>" + BizboxAMessage.getMessage("TX000005174", "회계일자") + "</b></th>");
        sbContent.append("		<td class=\"textL pdL5\" bgcolor=\"#FFFFFF\" colspan=\"2\">&nbsp;" + expendDate + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 회계일자 */
        sbContent.append("		<th colspan=\"2\"><b>" + BizboxAMessage.getMessage("TX000002867", "지급요청일자") + "</b></th>");
        sbContent.append("		<td class=\"textL pdL5\" bgcolor=\"#FFFFFF\" colspan=\"2\">&nbsp;" + expendReqDate + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 지급요청일자 */
        sbContent.append("	</tr>");
        sbContent.append("	<tr height=\"25\">");
        sbContent.append("		<th rowspan=\"2\"><b>" + BizboxAMessage.getMessage("TX000000335", "순번") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 순번 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000005177", "계정분류") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 계정분류 */
        sbContent.append("		<th colspan=\"2\"><b>" + BizboxAMessage.getMessage("TX000000604", "적요") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 적요 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000003872", "증빙구분") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 증빙구분 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000514", "증빙일자") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 증빙일자 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000003254", "법인카드") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 법인카드 */
        sbContent.append("	</tr>");
        sbContent.append("	<tr height=\"25\">");
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000519", "프로젝트") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 프로젝트 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000520", "거래처") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 거래처 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000516", "공급가액") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 공급가액 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000517", "부가세") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 부가세 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000518", "합계") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 합계 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000909", "첨부") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 첨부 */
        sbContent.append("	</tr>");
        /* 지출결의 양식 생성 - 고정양식으로 개발 - 콘텐츠 */
        for (Map<String, Object> map : content) {
            if (lineSeq != Integer.parseInt(CommonConvert.CommonGetSeq(map.get("list_seq")))) {
                rowNum++;
                lineSeq = Integer.parseInt(CommonConvert.CommonGetSeq(map.get("list_seq")));
            } else {
                continue;
            }
            exStdAmt = (Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_std_amt"))) + exStdAmt);
            exTaxAmt = (Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_tax_amt"))) + exTaxAmt);
            exAmt = (Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_amt"))) + exAmt);
            /* 증빙일자 */
            String authDate = CommonConvert.CommonGetStr(map.get("auth_date"));
            if (authDate.length() == 8) {
                authDate = authDate.substring(0, 4) + "-" + authDate.substring(4, 6) + "-" + authDate.substring(6, 8);
            } else if (authDate.length() > 6) {
                authDate = authDate.substring(0, 4) + "-" + authDate.substring(4, 6);
            }
            sbContent.append("	<tr height=\"25\">");
            /* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 순번 */
            sbContent.append("		<td rowspan=\"2\">" + rowNum + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 순번 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("acct_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 계정분류 */
            sbContent.append("		<td class=\"textL pdL5\" colspan=\"2\">&nbsp;" + CommonConvert.CommonGetStr(map.get("note")) + "<a onclick=\"javascript:window.open('/exp/ApprovalListPop.do" + "?" + "expend_seq=" + head.get("expend_seq").toString() + "&list_seq=" + lineSeq + "&group_seq=" + loginVO.getGroupSeq() + "'" + ",''" + ",'width=700, height=600')\" style='color:#3aa1f3;' href=\"#n\">" + "[상세]" + "</a> " + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 적요 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("auth_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 증빙구분 */
            sbContent.append("		<td>" + authDate + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 증빙일자 */
            /* 법인카드 여부 확인 */
            Object interfaceType = map.get("interface_type");
            if (interfaceType == null) {
                sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("card_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 법인카드 */
            } else if (!interfaceType.toString().equals("card")) {
                sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("card_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 법인카드 */
            } else {
                /* 법인카드 사용의 경우 */
                String cardTag = "<a href=\"#n\" onClick=\"javascript:window.open('/exp/expend/ex/user/card/ExExpendCardDetailInfo.do?syncId=" + map.get("interface_m_id").toString() + "', '', 'width=450, height=470, resizable=yes')\">" + CommonConvert.CommonGetStr(map.get("card_name")) + "</a>";
                sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + cardTag + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 법인카드 */
            }
            sbContent.append("	</tr>");
            sbContent.append("	<tr height=\"25\">");
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("project_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 프로젝트 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("partner_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 거래처 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_std_amt")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 공급가액 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_tax_amt")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 부가세 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_amt")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 합계 */
            if (isHaveAttach && (lineSeqs.indexOf("⊙" + lineSeq) > -1)) {
                sbContent.append("<td> " + "<a onclick=\"javascript:window.open('/exp/ApprovalAttachPop.do" + "?" + "expend_seq=" + head.get("expend_seq").toString() + "&list_seq=" + lineSeq + "&group_seq=" + loginVO.getGroupSeq() + "'" + ",''" + ",'width=500, height=500')\" href=\"#n\">" + "[+]" + "</a> " + "</td>");
            } else {
                sbContent.append(" <td> &nbsp; </td>");
            }
            sbContent.append("	</tr>");
        }
        /* 지출결의 양식 생성 - 고정양식으로 개발 - 푸터 */
        sbContent.append("	<tr height=\"25\">");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 */
        sbContent.append("		<th colspan=\"3\"><b>" + BizboxAMessage.getMessage("TX000000518", "합계") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 합계 */
        sbContent.append("		<th class=\"textR pdr5\">" + decimalFormat.format(exStdAmt) + "&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 공급가액 */
        sbContent.append("		<th class=\"textR pdr5\">" + decimalFormat.format(exTaxAmt) + "&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 부가세 */
        sbContent.append("		<th class=\"textR pdr5\">" + decimalFormat.format(exAmt) + "&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 합계 */
        sbContent.append("		<th>&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 공백 */
        sbContent.append("	</tr>");
        sbContent.append("</table>");
        /* 반환처리 */
        return sbContent.toString();
    }

    /* 결재 문서 생성 - 본문생성 - 지출결의서 - ERPiU */
    //private String DocMakeContentExU(Map<String, Object> head, List<Map<String, Object>> content, Map<String, Object> footer) {
    private String DocMakeContentExU(Map<String, Object> head, List<Map<String, Object>> content) {
        LoginVO loginVO = new LoginVO();
        try {
            loginVO = CommonConvert.CommonGetEmpVO();
        } catch (NotFoundLoginSessionException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        /* 변수정의 - StringBuilder */
        StringBuilder sbContent = new StringBuilder();
        /* 변수정의 - DecimalFormat */
        DecimalFormat decimalFormat = new DecimalFormat("#,##0");
        /* 변수정의 - Double */
        Double exStdAmt = (double) 0;
        Double exTaxAmt = (double) 0;
        Double exAmt = (double) 0;
        /* 변수정의 - int */
        int rowNum = 0;
        int lineSeq = 0;
        String expendReqDate = CommonConvert.CommonGetStr(head.get("expend_req_date"));
        if (expendReqDate != null && expendReqDate.length() == 8) {
            expendReqDate = expendReqDate.substring(0, 4) + "-" + expendReqDate.substring(4, 6) + "-" + expendReqDate.substring(6, 8);
        } else {
            expendReqDate = "0000-00-00";
        }
        String expendDate = CommonConvert.CommonGetStr(head.get("expend_date"));
        if (expendDate != null && expendDate.length() == 8) {
            expendDate = expendDate.substring(0, 4) + "-" + expendDate.substring(4, 6) + "-" + expendDate.substring(6, 8);
        } else {
            expendDate = "0000-00-00";
        }
        /* 첨부파일 조회 */
        boolean isHaveAttach = false;
        String lineSeqs = "";
        ResultVO attachInfo = new ResultVO();
        try {
            attachInfo = eapService.ApprovalSelectAttachInfo(head);
            isHaveAttach = (attachInfo.getAaData().size() != 0);
            lineSeqs = attachInfo.getResultName();
        } catch (Exception e) {
            isHaveAttach = false;
            lineSeqs = "";
        }
        /* 지출결의 양식 생성 - 고정양식으로 개발 */
        /* 지출결의 양식 생성 - 고정양식으로 개발 - 헤더 */
        sbContent.append("<TABLE class=\"statement\" width=\"100%\">");
        sbContent.append("	<colgroup width=\"5%\"></colgroup>"); /* 순번 라인 */
        sbContent.append("	<colgroup width=\"14%\"></colgroup>"); /* 계정분류 라인 */
        sbContent.append("	<colgroup></colgroup>"); /* 적요 1 라인 */
        sbContent.append("	<colgroup width=\"14%\"></colgroup>"); /* 적요 2 라인 */
        sbContent.append("	<colgroup width=\"15%\"></colgroup>"); /* 증빙구분 라인 */
        sbContent.append("	<colgroup width=\"15%\"></colgroup>"); /* 증빙일자 라인 */
        sbContent.append("	<colgroup width=\"19%\"></colgroup>"); /* 법인카드 라인 */
        sbContent.append("	<tr height=\"25\">");
        sbContent.append("		<th colspan=\"1\"><b>" + BizboxAMessage.getMessage("TX000005174", "회계일자") + "</b></th>");
        sbContent.append("		<td class=\"textL pdL5\" bgcolor=\"#FFFFFF\" colspan=\"2\">&nbsp;" + expendDate + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 회계일자 */
        sbContent.append("		<th colspan=\"2\"><b>" + BizboxAMessage.getMessage("TX000002867", "지급요청일자") + "</b></th>");
        sbContent.append("		<td class=\"textL pdL5\" bgcolor=\"#FFFFFF\" colspan=\"2\">&nbsp;" + expendReqDate + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 지급요청일자 */
        sbContent.append("	</tr>");
        sbContent.append("	<tr height=\"25\">");
        sbContent.append("		<th rowspan=\"3\"><b>" + BizboxAMessage.getMessage("TX000000335", "순번") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 순번 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000005177", "계정분류") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 계정분류 */
        sbContent.append("		<th colspan=\"2\"><b>" + BizboxAMessage.getMessage("TX000000604", "적요") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 적요 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000003872", "증빙구분") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 증빙구분 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000514", "증빙일자") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 증빙일자 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000003254", "법인카드") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 법인카드 */
        sbContent.append("	</tr>");
        sbContent.append("	<tr height=\"25\">");
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000519", "프로젝트") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 프로젝트 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000520", "거래처") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 거래처 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000516", "공급가액") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 공급가액 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000517", "부가세") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 부가세 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000518", "합계") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 합계 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000000909", "첨부") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 첨부 */
        sbContent.append("	</tr>");
        sbContent.append("	<tr height=\"25\">");
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000007201", "예산단위") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 예산단위 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000007200", "사업계획") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 사업계획 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000005263", "예산계정") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 예산계정 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000007249", "예산년월") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 예산년월 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000005469", "예산잔액") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 잔액 */
        sbContent.append("		<th><b>" + BizboxAMessage.getMessage("TX000007561", "집행금액") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 집행금액 */
        sbContent.append("	</tr>");
        /* 지출결의 양식 생성 - 고정양식으로 개발 - 콘텐츠 */
        for (Map<String, Object> map : content) {
            if (lineSeq != Integer.parseInt(CommonConvert.CommonGetSeq(map.get("list_seq")))) {
                rowNum++;
                lineSeq = Integer.parseInt(CommonConvert.CommonGetSeq(map.get("list_seq")));
            } else {
                continue;
            }
            exStdAmt = (Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_std_amt"))) + exStdAmt);
            exTaxAmt = (Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_tax_amt"))) + exTaxAmt);
            exAmt = (Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_amt"))) + exAmt);
            /* 증빙일자 */
            String authDate = CommonConvert.CommonGetStr(map.get("auth_date"));
            if (authDate.length() == 8) {
                authDate = authDate.substring(0, 4) + "-" + authDate.substring(4, 6) + "-" + authDate.substring(6, 8);
            } else if (authDate.length() > 6) {
                authDate = authDate.substring(0, 4) + "-" + authDate.substring(4, 6);
            }
            /* 예산년월 */
            String budgetYm = CommonConvert.CommonGetStr(map.get("budget_ym"));
            if (budgetYm != null && !budgetYm.equals(commonCode.EMPTYSTR) && budgetYm.length() == 6) {
                budgetYm = budgetYm.substring(0, 4) + "-" + budgetYm.substring(4, 6);
            } else if (budgetYm.length() < 6 || budgetYm.equals(commonCode.EMPTYSTR)) {
                budgetYm = "";
            }
            sbContent.append("	<tr height=\"25\">");
            /* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 순번 */
            sbContent.append("		<td rowspan=\"3\">" + rowNum + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 헤더 - 순번 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("acct_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 계정분류 */
            // sbContent.append( " <td class=\"textL pdL5\" colspan=\"2\">&nbsp;" + CommonConvert.CommonGetStr( map.get( "note" ) ) + "</td>" );/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 적요 */
            sbContent.append("		<td class=\"textL pdL5\" colspan=\"2\">&nbsp;" + CommonConvert.CommonGetStr(map.get("note")) + "<a onclick=\"javascript:window.open('/exp/ApprovalListPop.do" + "?" + "expend_seq=" + head.get("expend_seq").toString() + "&list_seq=" + lineSeq + "&group_seq=" + loginVO.getGroupSeq() + "'" + ",''" + ",'width=700, height=600')\" style='color:#3aa1f3;' href=\"#n\">" + "[상세]" + "</a> " + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 적요 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("auth_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 증빙구분 */
            sbContent.append("		<td>" + authDate + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 증빙일자 */
            /* 법인카드 여부 확인 */
            Object interfaceType = map.get("interface_type");
            if (interfaceType == null) {
                sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("card_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 법인카드 */
            } else if (!interfaceType.toString().equals("card")) {
                sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("card_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 법인카드 */
            } else {
                /* 법인카드 사용의 경우 */
                String cardTag = "<a href=\"#n\" onClick=\"javascript:window.open('/exp/expend/ex/user/card/ExExpendCardDetailInfo.do?syncId=" + map.get("interface_m_id").toString() + "', '', 'width=450, height=470, resizable=yes')\">" + CommonConvert.CommonGetStr(map.get("card_name")) + "</a>";
                sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + cardTag + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 법인카드 */
            }
            sbContent.append("	</tr>");
            sbContent.append("	<tr height=\"25\">");
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("project_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 프로젝트 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("partner_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 거래처 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_std_amt")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 공급가액 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_tax_amt")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 부가세 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("list_amt")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 합계 */
            if (isHaveAttach && (lineSeqs.indexOf("⊙" + lineSeq) > -1)) {
                sbContent.append("<td> " + "<a onclick=\"javascript:window.open('/exp/ApprovalAttachPop.do" + "?" + "expend_seq=" + head.get("expend_seq").toString() + "&list_seq=" + lineSeq + "&group_seq=" + loginVO.getGroupSeq() + "'" + ",''" + ",'width=500, height=500')\" href=\"#n\">" + "[+]" + "</a> " + "</td>");
            } else {
                sbContent.append(" <td> &nbsp; </td>");
            }
            sbContent.append("	</tr>");
            sbContent.append("	<tr height=\"25\">");
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("budget_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 예산단위 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("bizplan_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 사업계획 */
            sbContent.append("		<td class=\"textL pdL5\">&nbsp;" + CommonConvert.CommonGetStr(map.get("bgacct_name")) + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 예산계정 */
            sbContent.append("		<td class=\"textC pdL5\">&nbsp;" + budgetYm + "</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 예산년월 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("budget_actsum")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 잔액 */
            sbContent.append("		<td class=\"textR pdr5\">" + decimalFormat.format(Double.parseDouble(CommonConvert.CommonGetSeq(map.get("budget_jsum")))) + "&nbsp;</td>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 컨텐츠 - 집행금액 */
            sbContent.append("	</tr>");
        }
        /* 지출결의 양식 생성 - 고정양식으로 개발 - 푸터 */
        sbContent.append("	<tr height=\"25\">");/* 지출결의 양4식 생성 : 고정양식으로 개발 - 푸터 */
        sbContent.append("		<th colspan=\"3\"><b>" + BizboxAMessage.getMessage("TX000000518", "합계") + "</b></th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 합계 */
        sbContent.append("		<th class=\"textR pdr5\">" + decimalFormat.format(exStdAmt) + "&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 공급가액 */
        sbContent.append("		<th class=\"textR pdr5\">" + decimalFormat.format(exTaxAmt) + "&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 부가세 */
        sbContent.append("		<th class=\"textR pdr5\">" + decimalFormat.format(exAmt) + "&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 합계 */
        sbContent.append("		<th>&nbsp;</th>");/* 지출결의 양식 생성 : 고정양식으로 개발 - 푸터 - 공백 */
        sbContent.append("	</tr>");
        sbContent.append("</table>");
        /* 반환처리 */
        return sbContent.toString();
    }

    /* 결재 문서 생성 - 본문생성 - 지출결의서 */
    private String DocMakeContentEzbaro(String processId, Map<String, Object> head, List<Map<String, Object>> content) {
        switch (CommonConvert.CommonGetStr(processId)) {
            case commonCode.EZICUBE:
                //return DocMakeContentEzbaroI(head, content, footer);
            	return DocMakeContentEzbaroI(head, content);
            case commonCode.EZERPIU:
                //return DocMakeContentEzbarU(head, content, footer);
            	return DocMakeContentEzbarU();
            default:
                return commonCode.EMPTYSTR;
        }
    }

    /* 결재 문서 생성 - 본문생성 - 이지바로결의서 - ERPiU */
    //public String DocMakeContentEzbarU(Map<String, Object> head, List<Map<String, Object>> content, Map<String, Object> footer) {
    public String DocMakeContentEzbarU() {
        StringBuffer htmlContent = new StringBuffer();
        return htmlContent.toString();
    }

    /* 결재 문서 생성 - 본문생성 - 이지바로결의서 - ERPiCUBE */
    //public String DocMakeContentEzbaroI(Map<String, Object> head, List<Map<String, Object>> content, Map<String, Object> footer) {
    public String DocMakeContentEzbaroI(Map<String, Object> head, List<Map<String, Object>> content) {
        /* 전자결재 본문 생성 */
        int contentCount = 1;
        long totalSupplyAmt = 0;
        long totalTaxAmt = 0;
        long totalAmt = 0;
        StringBuffer htmlContent = new StringBuffer();
        htmlContent.append("<table class=\"statement fwb_th\" width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
        htmlContent.append("<colgroup>");
        htmlContent.append("<col width=\"34\" />");
        htmlContent.append("<col width=\"25%\" />");
        htmlContent.append("<col width=\"25%\" />");
        htmlContent.append("<col width=\"25%\" />");
        htmlContent.append("<col width=\"\" />");
        htmlContent.append("</colgroup>");
        htmlContent.append("<tbody>");
        htmlContent.append("<tr>");
        htmlContent.append("<th rowspan=\"3\">");
        htmlContent.append("</th>");
        //htmlContent.append("<th>" + BizboxAMessage.getMessage("TX000002866", "회계단위"));
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000002866", "회계단위"));
        htmlContent.append("</th>");
        htmlContent.append("<td>");
        htmlContent.append(head.get("AcctUnitNM"));
        htmlContent.append("<th>" + BizboxAMessage.getMessage("TX000009968", "결의부서") + "/" + BizboxAMessage.getMessage("TX000002723", "작성자"));
        htmlContent.append("</th>");
        htmlContent.append("<td>");
        //htmlContent.append(head.get("DEPTNM") + "/" + head.get("USERNM"));
        htmlContent.append(head.get("DEPTNM"));
        htmlContent.append("/");
        htmlContent.append(head.get("USERNM"));
        htmlContent.append("</td>");
        htmlContent.append("</tr>");
        htmlContent.append("<tr>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000000506", "결의일자"));
        htmlContent.append("</th>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000009966", "연구과제"));
        htmlContent.append("</th>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000009965", "세목"));
        htmlContent.append("</th>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000009964", "사용용도"));
        htmlContent.append("</th>");
        htmlContent.append("</tr>");
        htmlContent.append("<tr>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000009963", "집행방법"));
        htmlContent.append("</th>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000000516", "공급가액"));
        htmlContent.append("</th>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000000586", "세액"));
        htmlContent.append("</th>");
        htmlContent.append("<th>");
        htmlContent.append(BizboxAMessage.getMessage("TX000000538", "결의금액"));
        htmlContent.append("</th>");
        htmlContent.append("</tr>");
        // 반복 시작
        for (Map<String, Object> map : content) {
            htmlContent.append("<tr>");
            htmlContent.append("<td rowspan=\"2\">");
            htmlContent.append(Integer.toString(contentCount));
            contentCount++;
            htmlContent.append("</td>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("TASK_DT"));
            htmlContent.append("</td>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("PRJNAME") + "<a onclick=\"javascript:window.open('/exp/expend/ez/user/EzInspectInterlockPop.do" + "?" + "MASTER_SEQ=" + head.get("MASTER_SEQ").toString() + "&TASK_DT=" + map.get("TASK_DT").toString() + "&TASK_SQ=" + map.get("TASK_SQ").toString() + "&CO_CD=" + map.get("CO_CD").toString() + "'" + ",''" + ",'width=700, height=750')\" class=\"blue_a\" href=\"#n\">" + "[상세보기]" + "</a> ");
            htmlContent.append("</td>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("BMNAME"));
            htmlContent.append("</td>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("EXECDIV_NM"));
            htmlContent.append("</td>");
            htmlContent.append("</tr>");
            htmlContent.append("<tr>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("EXECMTD_NM"));
            htmlContent.append("</td>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("SUPPLYAMT"));
            htmlContent.append("</td>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("EXTTAX"));
            htmlContent.append("</td>");
            htmlContent.append("<td>");
            htmlContent.append(map.get("RESOLAMT"));
            htmlContent.append("</td>");
            htmlContent.append("</tr>");
            long supplyAmt = Long.parseLong(map.get("SUPPLYAMT").toString());
            long taxAmt = Long.parseLong(map.get("EXTTAX").toString());
            long resolAmt = Long.parseLong(map.get("RESOLAMT").toString());
            totalSupplyAmt = totalSupplyAmt + supplyAmt;
            totalTaxAmt = totalTaxAmt + taxAmt;
            totalAmt = totalAmt + resolAmt;
        }
        htmlContent.append("<tr>");
        htmlContent.append("<th colspan=\"2\" class=\"bg_normalgray\">");
        htmlContent.append(BizboxAMessage.getMessage("TX000000518", "합계"));
        htmlContent.append("</th>");
        htmlContent.append("<td class=\"ar fwb bg_normalgray\">");
        htmlContent.append(Long.toString(totalSupplyAmt));
        htmlContent.append("</td>");
        htmlContent.append("<td class=\"ar fwb bg_normalgray\">");
        htmlContent.append(Long.toString(totalTaxAmt));
        htmlContent.append("</td>");
        htmlContent.append("<td class=\"ar fwb bg_normalgray\">");
        htmlContent.append(Long.toString(totalAmt));
        htmlContent.append("</td>");
        htmlContent.append("</tr>");
        htmlContent.append("</tbody>");
        htmlContent.append("</table>");
        // /* 전자결재 본문 생성 - 고정양식으로 우선 개발 */
        // htmlContent.append( "<table width=\"100%\" bordercolor=\"black\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family:Dotum; font-size:10pt; border-collapse:collapse; border:0;margin-bottom:10px\">" );
        // htmlContent.append( " <tr>" );
        // htmlContent.append( " <td style=\"border: 0px solid #000;\" align=\"left\">" );
        // htmlContent.append( " <table width=\"100%\" bordercolor=\"black\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family:Dotum; font-size:10pt; border-collapse:collapse; border:0;\">" );
        // htmlContent.append( " <colgroup>" );
        // htmlContent.append( " <col width=\"25%\" />" );
        // htmlContent.append( " <col width=\"25%\" />" );
        // htmlContent.append( " <col width=\"25%\" />" );
        // htmlContent.append( " <col width=\"25%\" />" );
        // htmlContent.append( " </colgroup>" );
        // htmlContent.append( " <tr height=\"30\">" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000002866", "회계단위" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;padding-left:10px;\" align=\"left\">[" + (head.get( "AcctUnitCD" ) == null ? commonCode.EMPTYSTR : head.get( "AcctUnitCD" )) + "] " + (head.get( "AcctUnitNM" ) == null ? commonCode.EMPTYSTR : head.get( "AcctUnitNM" )) + "</td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000009968", "결의부서" ) + "</br>" + BizboxAMessage.getMessage( "TX000002723", "작성자" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;padding-left:10px;\" align=\"left\">[" + (head.get( "DeptCD" ) == null ? commonCode.EMPTYSTR : head.get( "DeptCD" )) + "] " + (head.get( "DeptNM" ) == null ? commonCode.EMPTYSTR : head.get( "DeptNM" )) + "</br>&nbsp;[" + (head.get( "EmpCD" ) == null ? commonCode.EMPTYSTR : head.get( "EmpCD" )) + "] " + (head.get( "EmpNM" ) == null ? commonCode.EMPTYSTR : head.get( "EmpNM" )) + "</td>" );
        // htmlContent.append( " </tr>" );
        // htmlContent.append( " </table>" );
        // htmlContent.append( " </td>" );
        // htmlContent.append( " </tr>" );
        // htmlContent.append( "</table>" );
        // htmlContent.append( "<table width=\"100%\" bordercolor=\"black\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family:Dotum; font-size:10pt; border-collapse:collapse; border:0;margin-bottom:10px\">" );
        // htmlContent.append( " <tr>" );
        // htmlContent.append( " <td style=\"border: 0px solid #000;\" align=\"left\">" );
        // htmlContent.append( " <table width=\"100%\" bordercolor=\"black\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family:Dotum; font-size:10pt; border-collapse:collapse; border:0;\">" );
        // htmlContent.append( " <colgroup>" );
        // htmlContent.append( " <col width=\"20%\" />" );
        // htmlContent.append( " <col width=\"20%\" />" );
        // htmlContent.append( " <col width=\"\" />" );
        // htmlContent.append( " <col width=\"20%\" />" );
        // htmlContent.append( " </colgroup>" );
        // htmlContent.append( " <tr height=\"30\">" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000000506", "결의일자" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000009966", "연구과제" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000009965", "세목" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000009964", "사용용도" ) + "</b></td>" );
        // htmlContent.append( " </tr>" );
        // htmlContent.append( " <tr height=\"30\">" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000009963", "집행방법" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000000516", "공급가액" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000000586", "세액" ) + "</b></td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" bgcolor=\"#f2f2f2\" align=\"center\"><b>" + BizboxAMessage.getMessage( "TX000000538", "결의금액" ) + "</b></td>" );
        // htmlContent.append( " </tr>" );
        //
        // for ( Map<String, Object> map : content ) {
        // htmlContent.append( " <tr height=\"30\">" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" align=\"center\">" + (map.get( "TASK_DT" ) == null ? commonCode.EMPTYSTR : map.get( "TASK_DT" )) + "</td>" );
        // //htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;padding-left:10px;\" align=\"left\">" + (map.get( "PRJNAME" ) == null ? commonCode.EMPTYSTR : map.get( "PRJNAME" )) + "<div onclick=\"fnInspectItems(\'\'" + map.get( "AcctUnitCD" ) + "\'\', \'\'" + map.get( "OFCODE" ) + "\'\', \'\'" + map.get( "PRJNO" ) + "\'\', \'\'" + map.get( "TASK_DT" ) + "\'\',\'\'" + head.get( "GW_MASTER_SEQ" ) + "\'\', \'\'" + map.get( "TASK_SQ" ) + "\'\')\">" + "<font style=\"color:#C33\">[" + BizboxAMessage.getMessage( "TX000006020", "상세보기" ) + "]</font></div>" + "</td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;padding-left:10px;\" align=\"left\">" + (map.get( "PRJNAME" ) == null ? commonCode.EMPTYSTR : map.get( "PRJNAME" )) +
        // "<a onclick=\"javascript:window.open('/exp/expend/ez/user/EzInspectInterlockPop.do" +
        // "?" + "master_seq=" + map.get( "master_seq" ).toString( ) +
        // "&TASK_DT="+ map.get( "TASK_DT" ).toString( ) +
        // "&TASK_SQ="+ map.get( "TASK_SQ" ).toString( ) +
        // "&CO_CD=" + map.get( "CO_CD" ).toString( ) +
        // "'" +
        // ",''"
        // + ",'width=700, height=600')\" href=\"#n\">" +
        // "[상세]" +
        // "</a> "
        // + "</td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" align=\"center\">" + (map.get( "BMNAME" ) == null ? commonCode.EMPTYSTR : map.get( "BMNAME" )) + "</td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" align=\"center\">" + (map.get( "EXECDIV_NM" ) == null ? commonCode.EMPTYSTR : map.get( "EXECDIV_NM" )) + "</td>" );
        // htmlContent.append( " </tr>" );
        // htmlContent.append( " <tr height=\"30\">" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;\" align=\"center\">" + (head.get( "EXECMTD_NM" ) == null ? commonCode.EMPTYSTR : head.get( "EXECMTD_NM" )) + "</td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;padding-right:10px;\" align=\"right\">" + (map.get( "SUPPLYAMT" ) == null ? commonCode.EMPTYSTR : map.get( "SUPPLYAMT" )) + "</td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;padding-right:10px;\" align=\"right\">" + (map.get( "EXTTAX" ) == null ? commonCode.EMPTYSTR : map.get( "EXTTAX" )) + "</td>" );
        // htmlContent.append( " <td style=\"border: 1px solid #dcdcdc;padding-right:10px;\" align=\"right\">" + (map.get( "RESOLAMT" ) == null ? commonCode.EMPTYSTR : map.get( "RESOLAMT" )) + "</td>" );
        // htmlContent.append( " </tr>" );
        // }
        //
        // htmlContent.append( " </table>" );
        // htmlContent.append( " </td>" );
        // htmlContent.append( " </tr>" );
        // htmlContent.append( "</table>" );
        return htmlContent.toString();
    }

    /* ################################################## */
    /* 결재 문서 본문 수정 */
    /* ################################################## */
    @Override
    public Map<String, Object> DocContentEdit(Map<String, Object> params) {
        return null;
    }

    /* ################################################## */
    /* [회계API] 본문조회 */
    /* ################################################## */
    @Override
    public String ApprovalProcessContent(String docSeq, String empSeq) {
        String result = commonCode.EMPTYSTR;
        try {
            switch (CommonConvert.CommonGetStr(cmInfo.CommonGetEmpEaTypeInfo(empSeq)).toLowerCase()) {
                case commonCode.EA: /* 비영리 */
                    // TODO : 비영리 개발 필요
                    result = commonCode.EMPTYSTR;
                    break;
                case commonCode.EAP: /* 영리 */
                    result = eapService.ApprovalContentInfoSelect(docSeq);
                    break;
                default :
                	break;
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 보관 */
    /* ################################################## */
    @Override
    public InterlockExpendVO ApprovalProcessSave(Map<String, Object> params) throws Exception {
        /* parameters : processId, approKey, docId, docSts, groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, docTitle */
        InterlockExpendVO result = new InterlockExpendVO();
        try {
            switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
                case commonCode.EA: /* 비영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eaService.ApprovalProcessEndAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            params.put("docStatus", "001");
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessSaveCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            params.put("docStatus", "001");
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessSaveRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.TRIPCONS:
                        	params.put("docStatus", "001");
                        	params.put("docNo","");
                        	result = eaService.ApprovalProcessTripCons(params);
                        	break;
                        case commonCode.TRIPRES:
                        	params.put("docStatus", "001");
                        	params.put("docNo","");
                        	result = eaService.ApprovalProcessTripRes(params);
                        	break;
                        default:
                            result = eaService.ApprovalProcessApproval(params);
                            result = eaService.ApprovalProcessSave(params);
                            break;
                    }
                    break;
                case commonCode.EAP: /* 영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eapService.ApprovalProcessEndAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessSaveCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessSaveRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        default:
                            result = eapService.ApprovalProcessSave(params);
                            break;
                    }
                    break;
                default:
                    result.setResultCode(commonCode.FAIL);
                    result.setResultCode("사용중인 전자결재 버전을 확인할 수 없습니다.");
                    break;
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 상신 */
    /* ################################################## */
    @Override
    public InterlockExpendVO ApprovalProcessApproval(Map<String, Object> params) throws Exception {
        /* parameters : processId, approKey, docId, docSts, groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, docTitle */
        InterlockExpendVO result = new InterlockExpendVO();
        try {
            switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
                case commonCode.EA: /* 비영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eaService.ApprovalProcessSaveAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            params.put("docStatus", "002");
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessSaveCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            params.put("docStatus", "002");
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessSaveRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.TRIPCONS:
                        	params.put("docStatus", "002");
                        	params.put("docNo","");
                        	result = eaService.ApprovalProcessTripCons(params);
                        	break;
                        case commonCode.TRIPRES:
                        	params.put("docStatus", "002");
                        	params.put("docNo","");
                        	result = eaService.ApprovalProcessTripRes(params);
                        	break;
                        default:
                            result = eaService.ApprovalProcessApproval(params);
                            break;
                    }
                    break;
                case commonCode.EAP: /* 영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eapService.ApprovalProcessSaveAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessSaveCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessSaveRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        default:
                            result = eapService.ApprovalProcessApproval(params);
                            break;
                    }
                    break;
                default:
                    result.setResultCode(commonCode.FAIL);
                    result.setResultCode("사용중인 전자결재 버전을 확인할 수 없습니다.");
                    break;
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 종결 */
    /* ################################################## */
    @Override
    public InterlockExpendVO ApprovalProcessEnd(Map<String, Object> params) throws Exception {
        /* parameters : processId, approKey, docId, docSts, groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, docTitle */
        InterlockExpendVO result = new InterlockExpendVO();
        try {
            switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
                case commonCode.EA: /* 비영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eaService.ApprovalProcessEndAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            /* out process의 경우에는 90번으로 연동 */
                            eaService.NpOutInterface(params);

                            params.put("docStatus", "008");
                            result = eaService.ApprovalProcessEndCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            /* out process의 경우에는 90번으로 연동 */
                            eaService.NpOutInterface(params);

                            params.put("docStatus", "008");
                            result = eaService.ApprovalProcessEndRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.TRIPCONS:
                        	params.put("docStatus", "008");
                        	result = eaService.ApprovalProcessTripCons(params);
                        	break;
                        case commonCode.TRIPRES:
                        	params.put("docStatus", "008");
                        	result = eaService.ApprovalProcessTripRes(params);
                        	break;
                        default:
                            result = eaService.ApprovalProcessEnd(params);
                            break;
                    }
                    break;
                case commonCode.EAP: /* 영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eapService.ApprovalProcessEndAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessEndCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessEndRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        default:
                            result = eapService.ApprovalProcessEnd(params);
                            break;
                    }
                    break;
                default:
                    result.setResultCode(commonCode.FAIL);
                    result.setResultCode("사용중인 전자결재 버전을 확인할 수 없습니다.");
                    break;
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 반려 */
    /* ################################################## */
    @Override
    public InterlockExpendVO ApprovalProcessReturn(Map<String, Object> params) throws Exception {
        /* parameters : processId, approKey, docId, docSts, groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, docTitle */
        InterlockExpendVO result = new InterlockExpendVO();
        try {
            switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
                case commonCode.EA: /* 비영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eaService.ApprovalProcessReturnAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            params.put("docStatus", "007");
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessReturnCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            params.put("docStatus", "007");
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessReturnRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.TRIPCONS:
                        	params.put("docStatus", "007");
                        	result = eaService.ApprovalProcessTripCons(params);
                        	break;
                        case commonCode.TRIPRES:
                        	params.put("docStatus", "007");
                        	result = eaService.ApprovalProcessTripRes(params);
                        	break;
                        default:
                            result = eaService.ApprovalProcessReturn(params);
                            break;
                    }
                    break;
                case commonCode.EAP: /* 영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.ANGUI:
                            result = eaService.ApprovalProcessReturnAngu(params);
                            break;
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessReturnCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessReturnRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        default:
                            result = eapService.ApprovalProcessReturn(params);
                            break;
                    }
                    break;
                default:
                    result.setResultCode(commonCode.FAIL);
                    result.setResultCode("사용중인 전자결재 버전을 확인할 수 없습니다.");
                    break;
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 삭제 */
    /* ################################################## */
    @Override
    public InterlockExpendVO ApprovalProcessDelete(Map<String, Object> params) throws Exception {
        /* parameters : processId, approKey, docId, docSts, groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, docTitle */
        InterlockExpendVO result = new InterlockExpendVO();
        try {
            switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
                case commonCode.EA: /* 비영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessDeleteCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            params.put("docStatus", "d");
                            eaService.NpOutInterface(params);
                            result = eaService.ApprovalProcessDeleteRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.TRIPCONS:
                        	params.put("docStatus", "d");
                        	result = eaService.ApprovalProcessTripCons(params);
                        	break;
                        case commonCode.TRIPRES:
                        	params.put("docStatus", "d");
                        	result = eaService.ApprovalProcessTripRes(params);
                        	break;
                        default:
                            result = eaService.ApprovalProcessDelete(params);
                            break;
                    }
                    break;
                case commonCode.EAP: /* 영리 */
                    switch (CommonConvert.CommonGetStr(params.get("processId"))) {
                        case commonCode.EXNPCONI:
                        case commonCode.EXNPCONU:
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessDeleteCons(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        case commonCode.EXNPRESI:
                        case commonCode.EXNPRESU:
                            params.put("docStatus", "d");
                            eapService.NpOutInterface(params);
                            result = eapService.ApprovalProcessDeleteRes(params);

                            if (!result.getResultCode().equals(commonCode.FAIL)) {
                                result.setResultCode(commonCode.SUCCESS);
                            }
                            break;
                        default:
                            result = eapService.ApprovalProcessDelete(params);
                            break;
                    }
                    break;
                default:
                    result.setResultCode(commonCode.FAIL);
                    result.setResultCode("사용중인 전자결재 버전을 확인할 수 없습니다.");
                    break;
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 분개 정보 상세 팝업 */
    /* ################################################## */
    @Override
    public ResultVO ApprovalSlipDetailInfoSelect(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result = eapService.ApprovalSlipDetailInfoSelect(params);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 관리항목 정보 상세 팝업 */
    /* ################################################## */
    @Override
    public ResultVO ApprovalMngDetailInfoSelect(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result = eapService.ApprovalMngDetailInfoSelect(params);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 첨부파일 정보 상세 팝업 */
    /* ################################################## */
    @Override
    public ResultVO SelectApprovalAttachInfo(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result.setResultCode(commonCode.SUCCESS);
            result = eapService.SelectApprovalAttachInfo(params);
        } catch (Exception e) {
            result.setResultCode(commonCode.FAIL);
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 적요[list] 정보 상세 팝업 */
    /* ################################################## */
    @Override
    public ResultVO SelectApprovalListInfo(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result.setResultCode(commonCode.SUCCESS);
            result = eapService.SelectApprovalListInfo(params);
        } catch (Exception e) {
            result.setResultCode(commonCode.FAIL);
        }
        return result;
    }

    /* ################################################## */
    /* [회계API] 분개[slip] 정보 상세 팝업 */
    /* ################################################## */
    @Override
    public ResultVO SelectApprovalSlipInfo(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result.setResultCode(commonCode.SUCCESS);
            result = eapService.SelectApprovalSlipInfo(params);
        } catch (Exception e) {
            result.setResultCode(commonCode.FAIL);
        }
        return result;
    }

    /* 결재문서 정보 조회 */
    @Override
    public ResultVO ApprovalInfoSelect(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
            case commonCode.EA: /* 비영리 */
                result = eaService.ApprovalInfoSelect(params);
                break;
            case commonCode.EAP:/* 영리 */
                result = eapService.ApprovalInfoSelect(params);
                break;
            default :
            	break;
        }
        return result;
    }

    @Override
    public String SelectAdvInterInfoCount(Map<String, Object> params) throws Exception {
        String result = "N";
        switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
            case commonCode.EA: /* 비영리 */
                result = eaService.SelectAdvInterInfoCount(params);
                break;
            case commonCode.EAP:/* 영리 */
                result = eapService.SelectAdvInterInfoCount(params);
                break;
            default :
            	break;
        }
        return result;
    }

    @Override
    public ResultVO ExcuteAdvInter(Map<String, Object> params) throws Exception {
        ResultVO result = new ResultVO();
        cmLog.CommonSetInfo("               [EXNP-ADV] CALL eaService.SelectAdvInterInfo");
        Map<String, Object> tmp = eaService.SelectAdvInterInfo(params);
        String advCode = CommonConvert.NullToString(tmp.get("methodName"));
        if (advCode.equals("0001")) {
            cmLog.CommonSetInfo("               [EXNP-ADV] CALL HAN ASEAN CUST.");
            /* 한아세안 센터 전용 개발 대응 */
            result = this.ExcuteAdv001(params);
        }
        // TODO .. adv code 추가..
        return result;
    }

    private ResultVO ExcuteAdv001(Map<String, Object> params) {
        ResultVO result = new ResultVO();
        try {
            advInterServiceI.advMethod001(params);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 	iCUBE 연동 고객사 법인카드 승인내역 연동 조회
     */
	@Override
	public ResultVO ExcuteAdvInterICubeCard ( Map<String, Object> params ) throws Exception {
		ResultVO result = new ResultVO();
        try {
            String moduleType = CommonConvert.NullToString( params.get( "moduleType" ) );
        	if(moduleType.equals( commonCode.MODULECODEEXP )){
        		/* 영리 회계 추가 카드 승인내역 정보 조회 */
        		result = eaService.SelectICubeCard_EXP( params );
        	}else if (moduleType.equals( commonCode.MODULECODENP )){
        		/* 비영리 회계 추가 카드 승인내역 정보 조회 */
        		result = eaService.SelectICubeCard_NP( params );
        	}

        	if(result.getResultCode( ).equals( commonCode.FAIL )){
        		return result;
        	}else if(result.getResultCode( ).equals( commonCode.SUCCESS )){
        		for(Map<String, Object> item : result.getAaData( )){
        			item.put( "gwState", params.get( "gwState" ) );
        			item.put( "groupSeq", params.get( "groupSeq" ) );
        			item.put( "compSeq", params.get( "compSeq" ) );
        			if(params.get("docSts").equals("100")) {
        				item.put("docNo", "");
        			}
        			/* t_ex_card_aq_tmp 확장 테이블 재조회 기능 추가 필요 */
        			ResultVO cardKeyResult = eaService.SelectICubeCardKey( item );
        			if(cardKeyResult.getResultCode( ).equals( commonCode.FAIL )){
        				continue;
        			}else {
        				/*2021/09/28 성일수정 	
        				 * icube DB의 회사, 카드번호, 승인번호 구분값 추가하여 업데이트
        				 * */
        				item.put( "issDt", cardKeyResult.getaData( ).get( "issDt" ) );
        				item.put( "issSq", cardKeyResult.getaData( ).get( "issSq" ) );
        				item.put( "authNum", cardKeyResult.getaData( ).get( "authNum" ) );
        				item.put( "cardNum", cardKeyResult.getaData( ).get( "cardNum" ) );
        			}

        			ResultVO cardUpdateResult = advInterServiceI.UpdateICubeCardGwState( item );//ERP상태연동
        			if(cardUpdateResult.getResultCode( ).equals( commonCode.FAIL )){
        				cmLog.CommonSetInfo( "               [EXNP-ADV] ERROR advInterServiceI.UpdateICubeCardGwState");
        				cmLog.CommonSetInfo( "               [EXNP-ADV] MESSAGE : " + cardUpdateResult.getResultName( ));
        			}
        		}
        	}
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            e.printStackTrace();
        }
        return result;
	}


    /**
     * 	인터락 양식 정보 업데이트
     */
	@Override
	public ResultVO UpdateInterlockForm ( Map<String, Object> params ) throws Exception{

		ResultVO result = new ResultVO();
		String preApproKey = CommonConvert.NullToString( params.get( "preApproKey" ) );
		String preErpType = CommonConvert.NullToString( params.get( "preErpType" ) );
		String exDocSeq = CommonConvert.NullToString( params.get( "exDocSeq" ) );
		String formSeq = CommonConvert.NullToString( params.get( "formSeq" ) );
		String processId = CommonConvert.NullToString( params.get( "processId" ) );

		if( exDocSeq.equals( "" )){
			throw new Exception ( "[ERROR] >>>>>> exDocSeq is white space" );
		}else if( formSeq.equals( "" )){
			throw new Exception ( "[ERROR] >>>>>> formSeq is white space" );
		}else if( processId.equals( "" )){
			throw new Exception ( "[ERROR] >>>>>> processId is white space" );
		}


		String approKey = preApproKey + preErpType + "_NP_" + params.get( "exDocSeq" );
		params.put( "approKey", approKey );

		try{
			/* INTER 양식 양식 설정 정보 조회 */
			String html = CommonConvert.CommonGetStr(formService.CommonNPFormDataInfo(params).getaData().get("formInfo"));
			params.put( "html", html );

			/* INTER양식 신규 생성 필요 */
			ResultVO interHTMLResult = formService.NPDocMaker( params );
			if(interHTMLResult.getResultCode( ).equals( commonCode.FAIL )){
				throw new Exception(interHTMLResult.getResultName( ) );
			}

			/* html 신규 컨텐츠 생성 */
			String newDocContents = CommonConvert.NullToString( interHTMLResult.getaData( ).get( "html" ) );
			params.put( "newDocContents", newDocContents );

			/* 전자결재 INTER영역 업데이트 */
			ResultVO eaUpdateResult = new ResultVO( );
			/* 전자결재 정보 Inter영역 업데이트 필요 */
			switch (cmInfo.CommonGetCompEaTypeInfo(CommonConvert.CommonGetStr(params.get(commonCode.GROUPSEQ)), CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)))) {
	            case commonCode.EA: /* 비영리 */
	            	eaUpdateResult = formService.CommonAInterlockUpdate(params);
	                break;
	            case commonCode.EAP:/* 영리 */
	            	eaUpdateResult = formService.CommonPInterlockUpdate(params);
	                break;
                default :
                	break;
	        }
			if(!eaUpdateResult.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception (eaUpdateResult.getResultName( ));
			}

		}catch (Exception ex){
			ex.printStackTrace( );
			result.setFail( ex.getLocalizedMessage( ) );
		}

		return result;
	}

	@Override
	public ResultVO CopyInterlock(Map<String, Object> params) throws Exception {
		ResultVO result = new ResultVO();

		try {
			result = formService.CopyInterlock(params);
			result.setSuccess();
		} catch( Exception e ) {
			e.printStackTrace();
			result.setFail("[EXNP] CopyInterlock ERROR : " + e.toString());
		}

		return result;
	}
}

