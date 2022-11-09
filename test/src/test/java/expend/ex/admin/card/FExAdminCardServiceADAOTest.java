package expend.ex.admin.card;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import cmm.helper.ConvertManager;
import common.vo.common.ResultVO;
import expend.TestCase;

/**
 * FExAdminCardServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-04.
 */
public class FExAdminCardServiceADAOTest extends TestCase {
	
	@Autowired
	private FExAdminCardServiceADAO fExAdminCardServiceADAO;

	/**
	 * 법인카드 리스트 조회
	 * @throws Exception 
	 */
	@Test
	public void testExCodeCardInfoSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("eaType", "eap");
		params.put("compSeq", "1000");
		params.put("textFilter", "");
		params.put("useYN", "Y");
		
		ResultVO resultVo = fExAdminCardServiceADAO.ExCodeCardInfoSelect( params );
		
		
		List<Map<String, Object>> test = resultVo.getAaData();
		
		for(int i = 0; i< test.size(); i++) {
		  System.out.println("데이터 읽어오기 " + test);  
		}
		
		
	}
}


