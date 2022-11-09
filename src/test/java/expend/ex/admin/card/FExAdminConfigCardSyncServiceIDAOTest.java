package expend.ex.admin.card;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import expend.TestCase;

/**
 * FExAdminConfigCardSyncServiceIDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-04.
 */
public class FExAdminConfigCardSyncServiceIDAOTest extends TestCase {

	private CommonExConnect connector = new CommonExConnect( );
	private ConnectionVO conVo = new ConnectionVO();
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() {
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://175.206.170.90:3433;databasename=dzicube");
		conVo.setUserId("dzicube");
		conVo.setPassword("icbQorentks0(0");
		conVo.setErpTypeCode("iCUBE");
	}
	
	/**
	 * ERP 카드 조회
	 */
	@Test
	public void testExCommonCodeCardSelect() {
		Map<String, Object> params = new HashMap<>();
		
		params.put("erpCompSeq", "0101");
		
		List<Map<String, Object>> result = connector.List( conVo, "AdminiCUBEConfig.ExCommonCodeCardSelect", params );
		
		assertTrue(result.size() > 0);
	}

}
