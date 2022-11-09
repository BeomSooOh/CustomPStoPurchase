package expend.ex.budget;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import expend.TestCase;

/**
 * FExBudgetServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-10.
 */
public class FExBudgetServiceADAOTest extends TestCase {

	@Autowired
	FExBudgetServiceADAO budgetServiceADAO;
	
	/**
	 * rowid 생성
	 * @throws Exception 
	 */
	@Test
	public void testExInterlockERPiUBudgetInfoSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("expendSeq", "5116");
		
		List<Map<String, Object>> result = budgetServiceADAO.ExInterlockERPiUBudgetInfoSelect(params);
		assertTrue(result.size() > 0);
	}

}
