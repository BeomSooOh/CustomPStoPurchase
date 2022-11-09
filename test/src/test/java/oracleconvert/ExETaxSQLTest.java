package oracleconvert;

import static org.junit.Assert.*;

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
 * ExETaxSQLTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-08-27.
 * rollback 안됨. 주의필요.
 * Oracle Developer로 insert, update, delete문을 실행하고 반드시 commit 또는 rollback을 해야한다.
 */
public class ExETaxSQLTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(ExETaxSQLTest.class);
	
	private CommonExConnect exConnect = new CommonExConnect( );
	private ConnectionVO conVo = new ConnectionVO();

	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("oracle");
		conVo.setDriver("oracle.jdbc.driver.OracleDriver");
		conVo.setUrl("jdbc:oracle:thin:@10.20.97.13:1521:orcl");
		conVo.setUserId("NEOE");
		conVo.setPassword("NEOE");
		conVo.setErpTypeCode("ERPiU");
	}
	
	/**
	 * 세금계산서 조회 테이블 옵션 조회
	 */
	@Test
	public void testExTaxListCompOption() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("erpCompSeq", "1000");
		
		Map<String, Object> result = exConnect.Select( conVo, "ExUserERPiUETax.ExTaxListCompOption", param );
		assertNotNull(result.get("tpTbTaxCompany"));
		logger.info("### result = {}", result.get("tpTbTaxCompany"));
	}
	
	/**
	 * 매입전자세금계산서 - 내역 목록 조회
	 */
	@Test
	public void testExETaxListInfoSelect() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("tpTbTaxCompany", "N");
		param.put("coCd", "10000");
		param.put("searchFromDt", "20190701");
		param.put("searchToDt", "20190731");
		param.put("notInsertIssNo", "");
		param.put("searchPartnerNo", "");
		param.put("searchPartnerNm", "");
		param.put("searchIssNo", "");
		param.put("transferIssNo", "");
		param.put("trchargeEmail", "");
		param.put("trregNb", "2222222227");
		param.put("baseEmailAddr", "");
		
		List<Map<String, Object>> result = exConnect.List( conVo, "ExETaxListInfoSelect", param );
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
		param.put("searchToDt", "20190731");
		param.put("notInsertIssNo", "");
		param.put("searchPartnerNo", "2222222227");
		param.put("searchPartnerNm", "");
		param.put("searchIssNo", "");
		param.put("emailDc", "");
		param.put("transferIssNo", "");
		param.put("trchargeEmail", "");
		param.put("trregNb", "");
		param.put("baseEmailAddr", "");
		
		List<Map<String, Object>> result = exConnect.List( conVo, "ExETaxListInfoSelectMap", param );
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 매입전자세금계산서 - 매입전자세금계산서 귀속 사업장 정보 조회
	 */
	@Test
	public void testExETaxBizareaInfoSelectMap() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("issNo", "TX2019078566513");
		param.put("issDt", "20190718");
		param.put("erpCompSeq", "10000");
		param.put("userErpBizSeq", "10000");
		
		Map<String, Object> result = exConnect.Select( conVo, "ExETaxBizareaInfoSelectMap", param );
		assertNotNull(result.get("erpBizareaSeq"));
		logger.info("### result = {}", result);
		
	}
	
}
