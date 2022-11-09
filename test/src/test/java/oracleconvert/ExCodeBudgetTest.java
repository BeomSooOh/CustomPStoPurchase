package oracleconvert;

import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import expend.TestCase;

/**
 * ExCodeBudgetTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-08-27.
 * rollback 안됨. 주의필요.
 * Oracle Developer로 insert, update, delete문을 실행하고 반드시 commit 또는 rollback을 해야한다.
 */
public class ExCodeBudgetTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(ExCodeBudgetTest.class);
	
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
	 * 지출결의 - 임시예산 등록
	 */
	@Test
	public void testExExpendGmmsumOtherInfoInsert() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("rowId", "3");
		param.put("rowNo", "1");
		param.put("erpCompSeq", "10000");
		param.put("budgetCode", "1010");
		param.put("bizplanCode", "1010");
		param.put("bgacctCode", "1010");
		param.put("budgetYm", "201908");
		param.put("budgetGwAct", 1);
		param.put("erpEmpSeq", "1000");
		
		int result = exConnect.Insert( conVo, "ExExpendGmmsumOtherInfoInsert", param );
		logger.info("### result = {}", result);
		assertTrue(result > 0);
	}
	
	/**
	 * 지출결의 - 임시예산 삭제
	 */
	@Test
	public void testExExpendGmmsumOtherInfoDelete() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("rowId", "3");
		param.put("rowNo", "1");
		
		int result = exConnect.Delete( conVo, "ExExpendGmmsumOtherInfoDelete", param );
		assertTrue(result > 0);
	}

}
