package expend.ex.admin.etax;

import static org.junit.Assert.assertNotNull;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxAuthVO;
import expend.TestCase;

/**
 * FExAdminETaxServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-08-05.
 */
public class FExAdminETaxServiceADAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExAdminETaxServiceADAOTest.class);
	
	@Resource ( name = "FExAdminETaxServiceADAO" )
	private FExAdminETaxServiceADAO etaxADAO;

	/* 세금계산서 권한 설정 페이지 - 사업자등록번호 또는 이메일 중복체크 */
	@Test
	public void testExETaxAuthCodeDuplicationCheckSelect() throws Exception {
		ExCodeETaxAuthVO eTaxAuthVO = new ExCodeETaxAuthVO();
		eTaxAuthVO.setCompSeq("1241");
		eTaxAuthVO.setAuthType("P");
		eTaxAuthVO.setCode("123");
		
		ResultVO result = etaxADAO.ExETaxAuthCodeDuplicationCheckSelect(eTaxAuthVO);
		
		logger.info("### result = {}", result);
		assertNotNull(result.getaData().get("duplicationCount"));
	}

}
