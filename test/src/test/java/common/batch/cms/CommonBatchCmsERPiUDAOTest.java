package common.batch.cms;

import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.vo.common.ConnectionVO;
import expend.TestCase;

/**
 * CommonBatchCmsERPiUDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-16.
 */
public class CommonBatchCmsERPiUDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(CommonBatchCmsERPiUDAOTest.class);

	@Resource(name = "CommonBatchCmsERPiUDAO")
    CommonBatchCmsERPiUDAO daoERPiU;
	
	ConnectionVO conVo = new ConnectionVO();
	
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
		
		erpConnectionConfig(conVo);
	}
	
	/**
	 * ERPiU CMS 조회
	 * @throws Exception 
	 */
	@Test
	public void testCommonCmsERPiUInfoListSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		List<Map<String, Object>> result = daoERPiU.CommonCmsERPiUInfoListSelect(conVo, params);
		assertTrue(result.size() > 0);
	}
	
	/**
	 * ERPiU CUSTOM CMS 조회
	 * @throws Exception 
	 */
	@Test
	public void testCommonCmsERPiUInfoListSelect_Procedure() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		List<Map<String, Object>> result = daoERPiU.CommonCmsERPiUInfoListSelect_Procedure(conVo, params);
		assertTrue(result.size() > 0);
	}

}
