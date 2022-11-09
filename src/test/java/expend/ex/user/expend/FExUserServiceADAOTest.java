package expend.ex.user.expend;

import static org.junit.Assert.*;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExpendVO;
import expend.TestCase;

/**
 * FExUserServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-03-11.
 */
public class FExUserServiceADAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserServiceADAOTest.class);

	@Autowired
	FExUserServiceADAO userServiceADAO;
	
	/**
	 * 지출결의 항목 조회
	 * @throws Exception 
	 */
	@Test
	public void testExUserListInfoSelect() throws Exception {
		ExExpendListVO listVo = new ExExpendListVO();
		listVo.setExpendSeq("5338");
		listVo.setListSeq("1");
		
		ExExpendListVO result = userServiceADAO.ExUserListInfoSelect(listVo);
		
		logger.info("### result = {}", result);
		assertNotNull(result.getExpendSeq());
	}
	
	/**
	 * 지출결의 조회
	 * @throws Exception
	 */
	@Test
	public void testExUserExpendInfoSelect() throws Exception {
		ExpendVO expendVo = new ExpendVO();
		
		expendVo.setExpendSeq("6502");
		
		ExpendVO result = userServiceADAO.ExUserExpendInfoSelect(expendVo);
		
		assertNotNull(result.getExpendSeq());
	}

}
