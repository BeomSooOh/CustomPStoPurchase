package common.batch.cms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import bizbox.orgchart.constant.CloudConstants;
import bizbox.orgchart.util.JedisClient;
import cloud.CloudConnetInfo;
import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import egovframework.com.utl.fcc.service.EgovStringUtil;


public class CommonBatchCms extends TimerTask {

    /* ################################################## */
    /* 변수정의 */
    /* ################################################## */
    /* 변수정의 - Service */
    @Resource(name = "CommonBatchCmsService")
    CommonBatchCmsService cmsService;
    @Resource(name = "CommonBatchCmsServiceTest")
    CommonBatchCmsServiceTest cmsServiceTest;
    
    
    
    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    CommonLogger cmLog;

    private static final Logger logger = LoggerFactory.getLogger(CommonBatchCms.class);

    /* ################################################## */
    /* CMS 동기화 Task */
    /* ################################################## */
    @Override
    public void run() {
      logger.error("[CloudCmsRun] run 호출");
        try {
            /* CMS 동기화 실행 */
            /* CMS 동기화 실행 - ERPiU */
            /* CMS 동기화 실행 - ERPiU - 미구현 */
            /* CMS 동기화 실행 - iCUBE */
            /* CMS 동기화 실행 - iCUBE - 스마트 자금관리 미구현 */
            /* CMS 동기화 실행 - iCUBE - 하나은행 구현 완료 */

            Map<String,Object> params = new HashMap<>();
            params.put("issDtFrom", "");
            params.put("issDtTo", "");
            params.put("cmsPeriodSync", "");
            
            logger.error("[CloudCmsRun] CommonSetCmsSync 호출");
            cmsService.CommonSetCmsSync(params);  
            logger.error("[CloudCmsRun] CommonSetCmsSync 종료");
            
            /* 실행 방식의 변경 : bizboxa.properties의 BizboxA.mode 값이 live인 경우만 동작하도록 함. */
            /* 현재 다중서버의 "BizboxA.mode" 설정 상태 진행 중 설정 완료 후 일괄로 적용 진행 예정 - 우선 구현 내용 구석처리 진행 */
            /* ###############################################################################################
            if (BizboxAProperties.getProperty("BizboxA.mode").toString().toUpperCase().equals("LIVE")) {
                logger.info("CMS 동기화가 진행됩니다. - 서버의 설정에 따라서 실행됩니다. [BizboxA.mode]");
                cmsService.CommonSetCmsSync();
            } else {
                logger.info("CMS 동기화가 진행되지 않습니다. - 서버의 설정에 따라서 제한됩니다. [BizboxA.mode]");
            }
            ############################################################################################### */
        } catch (Exception e) {
            cmLog.CommonSetError(e);
        }
    }
    
//    // Task 추가 하여서 테스트용 생성 
//    public void checkingScheduled() {
//      logger.error("task:scheduled 동작 확인");
//    }
//    
//    public void cloudRuntest() {
//      logger.error("[CloudRunTest] cloudRuntest 호출");
//      try {
//      
//          Map<String,Object> params = new HashMap<>();
//          params.put("issDtFrom", "");
//          params.put("issDtTo", "");
//          params.put("cmsPeriodSync", "");
//          logger.error("[CloudRunTest] CommonSetCmsSynctest 호출 시작");
//          cmsServiceTest.CommonSetCmsSynctest(params);
//          logger.error("[CloudRunTest] CommonSetCmsSynctest 호출 종료");
//          
//      } catch (Exception e) {
//        cmLog.CommonSetError(e);
//      }
//      
//      
//    }
    
}
