package expend.ex.user.list;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.ex.ExExpendListVO;
import expend.TestCase;

/**
 * FExUserListServiceAImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-03-11.
 */
public class FExUserListServiceAImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserListServiceAImplTest.class);
	
	@Resource ( name = "FExUserListServiceA" )
	private FExUserListService userListServiceA; /* Bizbox Alpha */ 

	/**
	 * 항목정보 정렬순서 채번
	 * @throws Exception 
	 */
	@Test
	public void testExGetOrderSeqFromListInfo() throws Exception {
		ExExpendListVO listVo = new ExExpendListVO();
		
		listVo.setExpendSeq("1001");
		listVo.setListSeq("1");
		listVo.setOrderSeq(3);
		
		int result = userListServiceA.ExGetOrderSeqFromListInfo(listVo);
		
		logger.info("### result = " + result);
		assertNotNull(result);
	}

}
