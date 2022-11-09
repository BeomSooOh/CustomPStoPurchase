package expend.ex.user.mng;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendVO;
import expend.TestCase;

/**
 * BExUserMngServiceImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2020-03-02.
 */
public class BExUserMngServiceImplTest extends TestCase {

	@Resource ( name = "FExUserMngServiceADAO" )
	private FExUserMngServiceADAO exUserMngServiceADAO;
	
	/**
	 * 지출결의 - 오류체크 - 관리항목
	 * @throws Exception 
	 */
	@Test
	public void testExMngErrorInfoSelect() throws Exception {
		ExExpendVO expendVo = new ExExpendVO();
		expendVo.setExpendSeq("6667");
		
		List<ExCommonResultVO> result = exUserMngServiceADAO.ExMngErrorInfoSelect(expendVo);
		assertTrue(result.size() > 0);
	}

}
