package expend.ex.budget;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.common.ConnectionVO;
import expend.TestCase;


/**
 * FExBudgetServiceIDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-03-07.
 * 비고 : MS-SQL 롤백 안됨.
 */
public class FExBudgetServiceIDAOTest extends TestCase {
	
	@Autowired
	private FExBudgetServiceIDAO fExBudgetServiceIDAO;

	/**
	 * 예산사용 여부 조회
	 * 비고 : ssl연결 설정 테스트
	 * @throws Exception 
	 */
	@Test
	public void testExBudgetUseInfoSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("erpCompSeq", "1000");
		
		ConnectionVO conVo = new ConnectionVO();
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://222.113.227.144:5398;databasename=dzicube;encrypt=true;trustServerCertificate=true");
		conVo.setUserId("dzicube");
		conVo.setPassword("icbVB2271$$");
		conVo.setErpTypeCode("iCUBE");
		
		Map<String, Object> result = fExBudgetServiceIDAO.ExBudgetUseInfoSelect(params, conVo);
		
		assertNotNull(result);
	}

}
