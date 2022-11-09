package expend.ex.user.code;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeCardVO;
import expend.TestCase;

/**
 * FExUserCodeServiceUDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-02.
 */
public class FExUserCodeServiceUDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserCodeServiceUDAOTest.class);
	
	@Autowired
	private FExUserCodeServiceUDAO fExUserCodeServiceUDAO;
	
	ConnectionVO conVo = new ConnectionVO();

	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
//		conVo.setDatabaseType("mssql");
//		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//		conVo.setUrl("jdbc:sqlserver://103.8.100.106:3433;databasename=NEOE");
//		conVo.setUserId("NEOE");
//		conVo.setPassword("NEOE");
//		conVo.setErpTypeCode("ERPiU");
		
		conVo.setDatabaseType("oracle");
		conVo.setDriver("oracle.jdbc.driver.OracleDriver");
		conVo.setUrl("jdbc:oracle:thin:@10.20.97.13:1521:orcl");
		conVo.setUserId("NEOE");
		conVo.setPassword("NEOE");
		conVo.setErpTypeCode("ERPiU");
		
		erpConnectionConfig(conVo);
	}
	
	/**
	 * 공통코드 - 카드 조회(ERPiU)
	 * 비고 : ExUserCardListInfoSelect 조회 할때 searchCardNum가 빈값으로 넘어가기 때문에 전체조회 되서 수정대상 아님
	 */
	@Test
	public void testExCodeCardInfoSelect() {
		ExCodeCardVO cardVo = new ExCodeCardVO();
		cardVo.setErpCompSeq("10000");
		cardVo.setSearchStr("0000111122223333");
		cardVo.setSearchCardNum("0000111122223333");
		
		//ERPiU 카드정보 조회
		cardVo = erpSession.selectOne( "ExCodeCardInfoSelect", cardVo );
		
		assertNotNull(cardVo.getErpCompSeq());
	}
	
	/**
	 * 공통코드 - ERP증빙 조회(ERPiU)
	 * @throws Exception 
	 */
	@Test
	public void testExCommonCodeErpAuthSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", "10000");
		params.put("searchStr", "");
		
		List<Map<String, Object>> result = fExUserCodeServiceUDAO.ExCommonCodeErpAuthSelect(params, conVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * ERPiU 카드정보 조회
	 */
	@Test
	public void testExCommonCodeCardSelect() {
		Map<String, Object> params = new HashMap<>();
		params.put("erpCompSeq", "10000");
		params.put("searchStr", "");
		
		List<Map<String, Object>> result = erpSession.selectList( "ExUserCode.ExCommonCodeCardSelect", params );
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 환종정보 조회
	 * @throws Exception 
	 */
	@Test
	public void testExCommonCodeExchangeUnitSelect() throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("erpCompSeq", "1000");
		params.put("searchStr", "KZT");
		
		List<Map<String, Object>> result = fExUserCodeServiceUDAO.ExCommonCodeExchangeUnitSelect(params, conVo);
		logger.info("### result = {}", result);
		
		assertTrue(result.size() > 0);
	}

}
