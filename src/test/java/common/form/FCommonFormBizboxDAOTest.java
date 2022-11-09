package common.form;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import expend.TestCase;

/**
 * FCommonFormBizboxDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-09-25.
 */
public class FCommonFormBizboxDAOTest extends TestCase {

	@Resource(name = "FCommonFormBizboxDAO")
    private FCommonFormBizboxDAO dao;
	
	/**
	 * 양식 정보 조회
	 * @throws Exception 
	 */
	@Test
	public void testCommonFormDetailInfo() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("formSeq", "52");
		params.put("compSeq", "1241");
		
		Map<String, Object> result = dao.CommonFormDetailInfo(params);
		assertNotNull(result.get("formSeq"));
	}

}
