package expend.ex.admin.report;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;
import expend.TestCase;


public class FExAdminReportServiceUImplTest extends TestCase {
	
	@Resource(name = "FExAdminReportServiceU")
    private FExAdminReportService reportServiceU;
	
	@Resource(name = "FExAdminReportServiceA")
    private FExAdminReportService reportServiceA;
	
	private ConnectionVO conVo = new ConnectionVO();
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://103.8.100.106:3433;databasename=NEOE");
		conVo.setUserId("NEOE");
		conVo.setPassword("NEOE");
		conVo.setErpTypeCode("ERPiU");
		
//		conVo.setDatabaseType("oracle");
//		conVo.setDriver("oracle.jdbc.driver.OracleDriver");
//		conVo.setUrl("jdbc:oracle:thin:@10.20.97.13:1521:orcl");
//		conVo.setUserId("NEOE");
//		conVo.setPassword("NEOE");
//		conVo.setErpTypeCode("ERPiU");
	}

	@Test
	public void testExReportExpendSendListInfoSendByList() throws Exception {
		List<Map<String, Object>> param = new ArrayList<Map<String,Object>>();
		
		param = ExReportExpendDummyListInfoSelectU();
				
		ResultVO result = reportServiceU.ExReportExpendSendListInfoSendByList(param, conVo, loginVO);
		
		assertEquals(commonCode.SUCCESS, result.getResultCode());
	}
	
	@Test
	public void 더미_데이터_조회() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put("advExpendDt", "20190801");
		param.put("expendSeq", "5656");
		param.put("compSeq", "1229");
		
		ResultVO result = reportServiceA.ExReportExpendDummyListInfoSelectU(param);
		
		assertTrue(result.getAaData().size() > 0);
	}
	
	private List<Map<String, Object>> ExReportExpendDummyListInfoSelectU() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put("advExpendDt", "20190801");
		param.put("expendSeq", "5656");
		param.put("compSeq", "1229");
		
		ResultVO result = reportServiceA.ExReportExpendDummyListInfoSelectU(param);
		
		return result.getAaData();
	}

}
