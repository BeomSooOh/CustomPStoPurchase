package expend.ex.user.etax;

import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import expend.TestCase;

/**
 * FExUserEtaxServiceUDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-18.
 */
public class FExUserEtaxServiceUDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserEtaxServiceUDAOTest.class);

	private CommonExConnect exConnect = new CommonExConnect( );
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
	}
	
	/**
	 * 지출결의 - 매입전자세금계산서 목록 조회
	 */
	@Test
	public void testExETaxListInfoSelect() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("tpTbTaxCompany", "N");
		param.put("coCd", "10000");
		param.put("searchFromDt", "20190101");
		param.put("searchToDt", "20190418");
		param.put("notInsertIssNo", "");
		param.put("searchStr", "201903184100009645344477");
		param.put("transferIssNo", "TX2019038434839");
		param.put("trchargeEmail", "");
		param.put("trregNb", "");
		param.put("baseEmailAddr", "");
		
		List<Map<String, Object>> result = exConnect.List( conVo, "ExETaxListInfoSelect", param );
		
		logger.info("### total = {}", result.size());
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 매입전자세금계산서 - 매입전자세금계산서 목록 조회
	 */
	@Test
	public void testExETaxListInfoSelectMap() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("tpTbTaxCompany", "N");
		param.put("erpCompSeq", "10000");
		param.put("searchFromDt", "20190101");
		param.put("searchToDt", "20190418");
		param.put("notInsertIssNo", "");
		param.put("searchPartnerNo", "");
		param.put("searchPartnerNm", "");
		param.put("searchIssNo", "201903184100009645344477");
		param.put("transferIssNo", "TX2019038434839");
		param.put("trchargeEmail", "");
		param.put("trregNb", "");
		param.put("baseEmailAddr", "");
		
		List<Map<String, Object>> result = exConnect.List( conVo, "ExETaxListInfoSelectMap", param );
		
		logger.info("### total = {}", result.size());
		assertTrue(result.size() > 0);
	}

}
