package expend.ex.admin.report;

import static org.junit.Assert.assertNotNull;

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

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.CommonInterface.commonCode;
import expend.TestCase;

/**
 * FExAdminReportServiceAImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-05-07.
 */
public class FExAdminReportServiceAImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExAdminReportServiceAImplTest.class);
	
	@Autowired
	private FExAdminReportServiceADAO fExAdminReportServiceADAO;
	@Resource(name="FExAdminReportServiceA")
	private FExAdminReportService fExAdminReportService;

	/**
	 * 전자결재 회계API 연동 시에는 로그인세션이 따로 없기 때문에 로그인세션정보를 별도로 구해준다.
	 * @throws Exception 
	 */
	@Test
	public void testExGetLoginSessionForApprovalProcess() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put("groupSeq", "demo");
		param.put("expendSeq", "6786");
		
//		LoginVO result = ExGetLoginSessionForApprovalProcess(param);
		LoginVO result = fExAdminReportService.ExGetLoginSessionForApprovalProcess(param);
		
		logger.info("### result = {}", result);
		assertNotNull(result.getCompSeq());
	}
	
	private LoginVO ExGetLoginSessionForApprovalProcess(Map<String, Object> param) throws Exception {
		return fExAdminReportServiceADAO.ExGetLoginSessionForApprovalProcessSelect(param);
	}
}

