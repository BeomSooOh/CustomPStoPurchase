package common.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.constant.CloudConstants;
import bizbox.orgchart.util.JedisClient;
import cmm.util.DecryptUtil;
import common.vo.common.CommonChecker;
import neos.cmm.util.BizboxAProperties;

@Controller
public class BCheckerController {

    //private org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());
	private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    /* ==================================================================================================== */
    /* 공용기술 요구사항 반영 */
    /* ==================================================================================================== */
    /**
     * <pre>
     * 제목 : orgchart-1.6.135 반영 여부 검수 방안.
     * 수신 : 그룹웨어 개발 담당자
     * 참조 : 수신자 제위
     *
     * 안녕하세요. 오덕진입니다.
     *
     * 이번 orgchart.1.6.135버전은 중요한 변경사항이기 때문에 다음 클라우드 배포시에 문제 없는지 확인하기 위해 다음 절차를 진행하고자 합니다.
     *
     * 각 war 파일 담당자들은 orgchart-1.6.135 버전을 적용 후 JedisClient.getCustInfoList() 를 호출하고 결과를 반환하는 테스트 API를 작성하여 공용기술 파트로 회신 부탁드립니다.
     *
     * 클라우드 배포 시 해당 API를 호출하여 orgchart-1.6.135 버전이 잘 적용되었는지 확인 하도록 하겠습니다.
     *
     * 답변은 가급적 ~7/19일 까지 부탁 드립니다.
     *
     * 감사합니다.
     *
     * ----------------------------------------
     * 보낸사람 : 정현수 이사[Pong1233]
     * 받은시간 : 2019.07.15 17:01:20
     * ----------------------------------------
     *
     * 다음 배포버전에 해당 버전의 OrgChart.jar가 잘 적용되었는지 검수 방안 정리해서 보고 바랍니다.
     *
     * ----------------------------------------
     * 보낸사람 : 오덕진 선임연구원[dangelj]
     * 받은시간 : 2019.07.15 16:52:48
     * ----------------------------------------
     * [중요] ※ 신규 OrgChart.jar[ver1.6.135] 전달
     *
     * 안녕하세요. 오덕진입니다. OrgChart.jar 최신 정보를 전달드립니다.
     *
     * (강조) 현재 클라우드 2번군 서버에 강제로 masterName을 고정한 버전을 수정하여 배포한 상황이기 때문에 반드시 다음 클라우드 패치 이전에 모든 war 파일들이 1.6.135 버전이 적용되어야 합니다.
     *
     * 변경 사항 : 1.2.135
     * ==================================
     *   ▶ Redis 생성시 파라미터 추가.
     *   메소드 형식 : getInstance(String host, int port, String password, String sentinelHosts, String masterName) : JedisClient
     *   : 5번째 파라미터로 masterName 이 추가되었습니다. 이 파라미터는 비즈박스 알파 클라우드 2번군 서버가 구성이 되며 1번군 서버와 2번군 서버의 Redis를 구분하기 위한 값입니다.
     *   해당 값은 /home/neos/tomcat/bizboxaconf/bizboxa.properties 문서의 [BizboxA.redis.master.name] 라는 키로 정의되었으며, getInstance 메소드 내부에서 예외처리(null, "")가 되어 있기 때문에, 프로퍼티에서 읽어서 추가하는 작업만 더 해주시면 됩니다.
     *
     * ※ 현재 클라우드 2번군 서버에 강제로 masterName을 고정한 버전을 수정하여 배포한 상황이기 때문에 반드시 다음 클라우드 패치 이전에 모든 war 파일들이 1.6.135 버전이 적용되어야 합니다.
     *
     * 변경 사항 : 1.6.124
     * ==================================
     *   ▶ getParamMap( 함수에서 반환하는 키에 "groupSeq"라는 기본 키와 값을 추가하였습니다.  이는 mybatis DB 쿼리에 대부분 #{groupSeq} 라는 이름으로 groupSeq키를 지정하기 때문에 해당 값을 잘못 지정하여 오류가 발생하는 현상을 방지하기 위함입니다. 해당 값은 CloudConstants.QUERY_GROUP_SEQ라는 키로 값을 구할 수 있습니다.
     *
     *   ▶ 검색엔진 일부 인덱스명의 오타를 수정하였습니다.
     *
     *   ▶ (재강조)getInstance(String host, int port, String password, String sentinelHosts)
     *   - Redis Cluster 모듈인 Sentinel을 지원하는 API가 추가되었습니다. sentinel로 동작하기 위해서는  bizboxa.properties 파일의 [BizboxA.redis.sentinel.client.hosts] 값을 sentinelHosts로 전달 해주시면 됩니다. API내에서 null 과 empty string을 체크하기 때문에 별다른 체크없이 프로퍼티에서 해당 값을 읽어 보내도록 처리하시면 되니 참고 부탁드립니다.
     *
     *   ▶ (재강조)클아우드의 경우 고객사 리스트 조회시 미개통 고객도 조회가 가능하도록 변경되었습니다. 클라우드 서버에 배포시에는 아래 예제와 같이 미개통 고객은 제외하도록 반드시 처리 부탁드립니다.
     *         try {
     *                 List<Map<String, String>> custList = jedis.getCustInfoList();
     *                 for(Map<String, String> custInfo : custList){
     *                         if(CloudConstants.OPERATE_STATUS_OPERATE.equals(custInfo.get(CloudConstants.OPERATE_STATUS))) {
     *                                 //처리로직
     *                         }
     *                 }
     *         }catch(Exception e) {
     *                 //TODO: 예외처리
     *         }
     *
     * <dependency>
     *   <groupId>bizbox</groupId>
     *   <artifactId>orgchart</artifactId>
     *   <version>1.6.135</version>
     * </dependency>
     *
     * 사용상의 문제나 오류 발견시 문의주시면 바로 확인하고 답변 드리겠습니다. 또한 예제소스가 필요하신 경우도 문의주시면 도움 드릴 수 있으니 연락 부탁드립니다.
     * 감사합니다.
     * </pre>
     */
    @RequestMapping("/Checker/OrgChart.do")
    public ModelAndView CheckerOrgChart(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        // http://localhost:8080/exp/Checker/OrgChart

        ModelAndView mv = new ModelAndView();
        CommonChecker result = new CommonChecker();

        try {
            JedisClient jedisClient = null;

            // set jedis client info
            String password = DecryptUtil.decrypt(BizboxAProperties.getProperty("BizboxA.redis.password"));
            String host = BizboxAProperties.getProperty("BizboxA.redis.ip");
            int port = Integer.parseInt(BizboxAProperties.getProperty("BizboxA.redis.port"));

            // set jedis client
            jedisClient = jedisClient.getInstance(host, port, password);

            // get cust info list
            List<Map<String, String>> custList = new ArrayList<Map<String, String>>();
            custList = jedisClient.getCustInfoList();

            List<Map<String, String>> resultCustList = new ArrayList<Map<String, String>>();
            for (Map<String, String> custInfo : custList) {
                if (CloudConstants.OPERATE_STATUS_OPERATE.equals(custInfo.get(CloudConstants.OPERATE_STATUS))) {
                    resultCustList.add(custInfo);
                }
            }

            mv.addObject("custList", resultCustList);

            result.setCallUrl("/Checker/OrgChart.do");
            result.setResultCode("SUCCESS");
            result.setResultMessage("orgchart version : orgchart-1.6.135");
        } catch (NumberFormatException e) {
            logger.error(e);
            result.setResultCode("FAIL");
            result.setResultMessage(e.getLocalizedMessage());
        } catch (Exception e) {
            logger.error(e);
            result.setResultCode("FAIL");
            result.setResultMessage(e.getLocalizedMessage());
        }

        mv.addObject("return", result);
        mv.setViewName("jsonView");
        return mv;
    }
}
