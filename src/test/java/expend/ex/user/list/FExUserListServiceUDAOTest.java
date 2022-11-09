package expend.ex.user.list;

import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import expend.TestCase;

/**
 * FExUserListServiceUDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-09.
 */
public class FExUserListServiceUDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserListServiceUDAOTest.class);
	
	private CommonExConnect exConnect = new CommonExConnect( );
	private ConnectionVO conVo = new ConnectionVO();
	
	@Autowired
	FExUserListServiceUDAO userListServiceUDAO;
	
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
	}

	/**
	 * 외화입력 - 환율정보 조회
	 * @throws Exception 
	 */
	@Test
	public void testExchangeRateInfoSelect() throws Exception {
		ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();
		foreignCurrencyVO.setErpCompSeq("10000");
		foreignCurrencyVO.setAuthDate("20190814");
		foreignCurrencyVO.setExchangeUnitName("001");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		params.put("authDate", foreignCurrencyVO.getAuthDate());
		params.put("exchangeUnit", foreignCurrencyVO.getExchangeUnitName());
		
		ResultVO resultVo = userListServiceUDAO.ExchangeRateInfoSelect(foreignCurrencyVO, conVo);
		logger.info("### resultVo = {}", resultVo.getaData());
		
		assertNotNull(resultVo.getaData().get("resultExchangeRate"));
	}
	
	/**
	 * 외화입력 - 올림구분 조회
	 * @throws Exception 
	 */
	@Test
	public void testRoundingTypeInfoSelect() throws Exception {
		ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();
		foreignCurrencyVO.setErpCompSeq("10000");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		
		ResultVO resultVo = userListServiceUDAO.RoundingTypeInfoSelect(foreignCurrencyVO, conVo);
		logger.info("### resultVo = {}", resultVo.getaData());
		
		assertNotNull(resultVo.getaData().get("resultRoundingType"));
	}
	
	/**
	 * 외화입력 - 외화계정인지 확인
	 * @throws Exception 
	 */
	@Test
	public void testCheckForeignCurrencyAcctCode() throws Exception {
		ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();
		foreignCurrencyVO.setErpCompSeq("10000");
		foreignCurrencyVO.setDrAcctCode("10600");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		params.put("drAcctCode", foreignCurrencyVO.getDrAcctCode());
		
		ResultVO resultVo = userListServiceUDAO.CheckForeignCurrencyAcctCode(foreignCurrencyVO, conVo);
		logger.info("### resultVo = {}", resultVo.getaData());
		
		assertNotNull(resultVo.getaData().get("resultAcctCount"));
	}

}
