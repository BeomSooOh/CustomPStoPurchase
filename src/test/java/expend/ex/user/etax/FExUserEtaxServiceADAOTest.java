package expend.ex.user.etax;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.ex.ExCodeETaxVO;
import expend.TestCase;

/**
 * FExUserEtaxServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-06-28.
 */
public class FExUserEtaxServiceADAOTest extends TestCase {
	@Autowired
	private FExUserEtaxServiceADAO daoA;

	/**
	 * 매입전자세금계산서 - 목록 조회
	 * @throws Exception 
	 */
	@Test
	public void testExExpendETaxSubListInfoSelect() throws Exception {
		ExCodeETaxVO etaxVo = new ExCodeETaxVO();
		
		etaxVo.setCompSeq("1241");
		etaxVo.setSearchFromDt("20190101");
		etaxVo.setSearchToDt("20190601");
		etaxVo.setSearchPartnerNo("");
		etaxVo.setNotInsertIssNo("TX2019038434839', 'TX2019056232910', 'TX2019016275011");
		
		List<ExCodeETaxVO> result = daoA.ExExpendETaxSubListInfoSelect(etaxVo);
		System.out.println("### result = " + result.get(0).getVaTypeCode());
		
		assertTrue(result.size() > 0);
	}

}
