package interlock.exp.approval;

import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.common.ResultVO;
import expend.TestCase;

/**
 * FApprovalServicePDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-08-19.
 */
public class FApprovalServicePDAOTest extends TestCase {
	@Autowired
	private FApprovalServicePDAO dao;
	
	/**
	 * 지출결의 인터락 적요 상세 정보 조회
	 */
	@Test
	public void testSelectApprovalListInfo() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("expend_seq", "3690");
		params.put("list_seq", "1");
		
		ResultVO result = dao.SelectApprovalListInfo(params);
		assertTrue(result.getAaData().size() > 0);
	}

}
