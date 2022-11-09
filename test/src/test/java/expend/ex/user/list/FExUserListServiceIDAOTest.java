package expend.ex.user.list;

import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import expend.TestCase;

/**
 * FExUserListServiceIDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-22.
 */
public class FExUserListServiceIDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserListServiceIDAOTest.class);
	
	private ConnectionVO conVo = new ConnectionVO();

	@Autowired
	FExUserListServiceIDAO userListServiceIDAO;
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://175.206.170.90:3433;databasename=dzicube");
		conVo.setUserId("dzicube");
		conVo.setPassword("ejwhs123$");
		conVo.setErpTypeCode("iCUBE");
	}
	
	/**
	 * 외화입력 - 외화계정인지 확인
	 * @throws Exception
	 */
	@Test
	public void testCheckForeignCurrencyAcctCode() throws Exception {
		ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();
		foreignCurrencyVO.setErpCompSeq("0101");
		foreignCurrencyVO.setDrAcctCode("10302");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		params.put("drAcctCode", foreignCurrencyVO.getDrAcctCode());
		
		ResultVO resultVo = userListServiceIDAO.CheckForeignCurrencyAcctCode(foreignCurrencyVO, conVo);
		logger.info("### resultVo = {}", resultVo.getaData());
		
		assertNotNull(resultVo.getaData().get("resultAcctCount"));
	}
	
	/**
	 * 외화입력 - iCUBE 환율, 외화금액 소수점 자릿수 조회(iCUBE 시스템 환경설정)
	 * @throws Exception 
	 */
	@Test
	public void testPointLengthInfoSelect() throws Exception {
		ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();
		foreignCurrencyVO.setErpCompSeq("0101");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", foreignCurrencyVO.getErpCompSeq());
		
		ResultVO resultVo = userListServiceIDAO.PointLengthInfoSelect(foreignCurrencyVO, conVo);
		logger.info("### resultVo = {}", resultVo.getaData());
		
		assertNotNull(resultVo.getaData().get("foreignCurrencyAmountLength"));
	}

}
