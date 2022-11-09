package interlock.api.web;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import interlock.api.ex.BApiService;
import interlock.api.model.Result;

/**
 * 영리 API
 */
@Controller
public class BExApiController {

    // FAIL00001 : 파라미터 누락 오류

    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());


    @Resource(name = "BApiService")
    private BApiService service;

    /**
     * 카드 내역의 카드 상태값을 변경합니다. - 카드 : t_ex_card_aq_tmp - 파라미터 : groupSeq, compSeq, empSeq, syncId
     */
    @RequestMapping(value = "/api/v1/card/sync.do", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ModelAndView SetSendNotice(HttpServletRequest servletRequest, HttpServletResponse servletResponse, @RequestBody Map<String, Object> param) throws Exception {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("jsonView");
        Map<String, Object> resMap = new HashMap<String, Object>();
        Result result = new Result();
        String errorLogBase = "[/api/v1/card/sync.do] - 카드 내역의 카드 상태값을 변경합니다. >> ";

        try {
            /* 로그인 상태 점검 : 로그인이 되지 않은 경우 API 연동 불가 */
            // try {
            // CommonConvert.CommonGetEmpVO();
            // logger.info(errorLogBase + "로그인 상태에서 API 호출하였습니다.");
            // } catch (NotFoundLoginSessionException e) {
            // errorLogBase = "isLogin false " + errorLogBase;
            // logger.info(errorLogBase + "미로그인 상태에서 API 호출하였습니다.");
            // }

            if (!param.containsKey("groupSeq") || param.get("groupSeq") == null || param.get("groupSeq").toString().equals("")) {
                // groupSeq 검증
                // groupSeq가 수신되지 않았습니다.
                result.setResultCode("FAIL00001");
                result.setResultMessage("경고");
                result.setException("groupSeq가 수신되지 않았습니다.");
                logger.error(errorLogBase + result.getException());
            } else if (!param.containsKey("compSeq") || param.get("compSeq") == null || param.get("compSeq").toString().equals("")) {
                // compSeq 검증
                // compSeq가 수신되지 않았습니다.
                result.setResultCode("FAIL00001");
                result.setResultMessage("경고");
                result.setException("compSeq가 수신되지 않았습니다.");
                logger.error(errorLogBase + result.getException());
            } else if (!param.containsKey("empSeq") || param.get("empSeq") == null || param.get("empSeq").toString().equals("")) {
                // empSeq 검증
                // empSeq가 수신되지 않았습니다.
                result.setResultCode("FAIL00001");
                result.setResultMessage("경고");
                result.setException("empSeq가 수신되지 않았습니다.");
                logger.error(errorLogBase + result.getException());
            } else if (!param.containsKey("syncId") || param.get("syncId") == null || param.get("syncId").toString().equals("")) {
                // syncId가 수신되지 않았습니다.
                result.setResultCode("FAIL00001");
                result.setResultMessage("경고");
                result.setException("syncId가 수신되지 않았습니다.");
                logger.error(errorLogBase + result.getException());
            } else if (!param.containsKey("sendYn") || param.get("sendYn") == null || param.get("sendYn").toString().equals("")) {
                // sendYn가 수신되지 않았습니다.
                result.setResultCode("FAIL00001");
                result.setResultMessage("경고");
                result.setException("sendYn가 수신되지 않았습니다.");
                logger.error(errorLogBase + result.getException());
            } else if (!param.get("sendYn").toString().equals("N") && !param.get("sendYn").toString().equals("Y")) {
                // sendYn의 값이 잘못 수신되었습니다.
                result.setResultCode("FAIL00001");
                result.setResultMessage("경고");
                result.setException("sendYn의 값은 [Y || N] 만 가능합니다.");
                logger.error(errorLogBase + result.getException());
            } else {
                // 카드 상태값 업데이트 진행
                resMap = service.SetCardSync(param);
                result.setResultCode("SUCCESS");
                result.setResultMessage("정상");
                result.setException("");
            }
        } catch (Exception e) {
            result.setResultCode("FAIL");
            result.setResultMessage("오류");
            result.setException(e.getLocalizedMessage());
        }

        mv.addObject("request", param); // 파라미터
        mv.addObject("response", resMap); // 처리결과
        mv.addObject("result", result.getMap()); // 처리결과 반환

        return mv;
    }
}
