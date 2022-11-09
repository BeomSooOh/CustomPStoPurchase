package expend.ex.user.code;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.ex.ExCodePartnerVO;
import expend.TestCase;

/**
 * FExUserCodeServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-08.
 */
public class FExUserCodeServiceADAOTest extends TestCase {
	
	@Autowired
	private FExUserCodeServiceADAO fExUserCodeServiceADAO;

	/**
	 * 전자결재 본문 양식 생성 테스트
	 */
	@Test
	public void testExpendInfoSelect() {
		Map<String, Object> params = new HashMap<>();
		
		params.put("expendSeq", "1090");
		
		List<Map<String, Object>> result = list( "ExpendListInfoSelect", params );
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 지출결의 - 거래처 등록
	 * @throws Exception 
	 */
	@Test
	public void testExExpendPartnerInfoInsert() throws Exception {
		ExCodePartnerVO partnerVo = new ExCodePartnerVO();
		
		partnerVo.setPartnerCode("123");
		partnerVo.setPartnerName("test");
		partnerVo.setDepositName(null);
		
		ExCodePartnerVO resultVo = fExUserCodeServiceADAO.ExExpendPartnerInfoInsert( partnerVo );
		
		assertNotNull(resultVo.getPartnerCode());
	}

}
