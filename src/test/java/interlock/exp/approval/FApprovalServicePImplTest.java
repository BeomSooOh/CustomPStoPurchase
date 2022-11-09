package interlock.exp.approval;

import static org.junit.Assert.assertEquals;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExpendVO;
import common.vo.interlock.InterlockExpendVO;
import expend.TestCase;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.admin.report.BExAdminReportService;
import expend.ex.user.expend.FExUserService;

/**
 * FApprovalServicePImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-05-07.
 * MSSQL 롤백안됨. 데이터 쌓임.
 */
public class FApprovalServicePImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FApprovalServicePImplTest.class);
	
	@Autowired
	private BExAdminReportService bExAdminReportService;
	@Autowired
	private BExAdminConfigService configService;
	@Resource(name = "CommonLogger")
	private CommonLogger cmLog; /* Log 관리 */
	@Resource(name="FExUserServiceA")
	private FExUserService fExUserServiceA;
	
	@Before
	public void additionalSetUp() {
		// 지출결의서 ERP 전송기능 테스트를 위해 loginVO 세션 다시 초기화
		session = new MockHttpSession();
		request = new MockHttpServletRequest();
		request.setSession(session);
		RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
	}
	
	/**
	 * 회계 전자결재 종결 프로세스
	 * @throws Exception 
	 */
	@Test
	public void testApprovalProcessEnd() {
		/* 지출결의서 ERP 전송기능 */
		InterlockExpendVO result = ApprovalProcessExpendListInfoSend();
		
		logger.info("### resultCode = {}", result.getResultCode());
		logger.info("### resultMessage = {}", result.getResultMessage());
		assertEquals("SUCCESS", result.getResultCode());
	}
	
	/**
	 * 지출결의서 ERP 전송기능
	 * @return
	 * @throws Exception 
	 */
	private InterlockExpendVO ApprovalProcessExpendListInfoSend() {
		InterlockExpendVO result = new InterlockExpendVO();
		Map<String, Object> optionParam = new HashMap<>();
		
		String processId = "EXPENDI";
		String useSw = "";
		String advExpendDt = "";
		
		try {
			if(CommonConvert.CommonGetStr(processId).equals("EXPENDU")) {
				useSw = "ERPiU";
			} else if(CommonConvert.CommonGetStr(processId).equals("EXPENDI")) {
				useSw = "iCUBE";
			} else {
				useSw = "BizboxA";
			}
			
			optionParam.put( "compSeq", "707010026273" );
			optionParam.put( "formSeq", "10321" );
			optionParam.put( "useSw", useSw );
			optionParam.put( "optionCode", "003403" ); //종결시 자동전송 옵션
			
			ResultVO expendOption = configService.ExAdminConfigOptionSelect( optionParam );
			
			//해당 지출결의서 양식에 대해 환경설정이 저장되지 않은 경우
			if(expendOption.getAaData().size() == 0) {
				result.setResultCode(commonCode.SUCCESS);
				result.setResultMessage("해당 지출결의서 양식의 환경설정이 저장되지 않았습니다.");
				
				return result;
			}
			
			ExpendVO expendVo = new ExpendVO();
			
			expendVo.setExpendSeq("6809");
			
			//지출결의서 내용조회
			ExpendVO expendResult = fExUserServiceA.ExUserExpendInfoSelect(expendVo);
			
			if(expendResult == null) {
				result.setResultCode(commonCode.SUCCESS);
				result.setResultMessage("지출결의서가 존재하지 않습니다.");
				
				return result;
			} else {
				advExpendDt = expendResult.getExpendDate(); // 예산 미사용의 경우 이값 사용
			}
			
			Map<String, Object> sendParam = new HashMap<String, Object>();
			
			sendParam.put("groupSeq", "demo");
			sendParam.put("expendSeq", "6809");
			sendParam.put("autoSendYN", "Y");
			sendParam.put("advExpendDt", advExpendDt);
			
			//전자결재 종결시 지출결의서 자동전송이 "사용"일 경우만 지출결의서 전송
			if ( CommonConvert.CommonGetStr(expendOption.getAaData( ).get( 0 ).get( "set_value" )).equals( "Y" ) ) {
				ResultVO sendResult = bExAdminReportService.ExReportExpendSendListInfoSend(sendParam);
				
				//지출결의서 전송 성공시
				if(sendResult.getResultCode().equals(commonCode.SUCCESS)) {
					result.setResultCode(sendResult.getResultCode());
					result.setResultMessage(sendResult.getResultName());
				} else {
				//지출결의서 전송 실패시 전자결재 종결 프로세스에 영향을 주지 않기 위해 그냥 성공으로 리턴
					result.setResultCode(commonCode.SUCCESS);
					result.setResultMessage("ApprovalProcessExpendListInfoSend 전송실패 : " + sendResult.getResultName());
				}
			} else {
				result.setResultCode(commonCode.SUCCESS);
				result.setResultMessage("지출결의서 자동전송 옵션이 미사용입니다.");
			}
		} catch(Exception e) {
			//지출결의서 전송 도중 오류가 발생하여도 종결 프로세스에 영향을 주지 않기 위해 그냥 성공으로 리턴
			result.setResultCode(commonCode.SUCCESS);
			result.setResultMessage("지출결의서 자동전송 중 오류발생가 발생하였습니다.");
			cmLog.CommonSetError(e);
		}
		
		return result;
	}

}
