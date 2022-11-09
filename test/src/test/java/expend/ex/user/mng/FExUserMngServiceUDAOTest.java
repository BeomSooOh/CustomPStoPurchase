package expend.ex.user.mng;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;

import common.vo.common.ConnectionVO;
import common.vo.ex.ExExpendMngVO;
import expend.TestCase;

/**
 * FExUserMngServiceUDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-22.
 */
public class FExUserMngServiceUDAOTest extends TestCase {
	@Resource ( name = "FExUserMngServiceUDAO" )
	private FExUserMngServiceUDAO exUserMngServiceUDAO;
	
	private ConnectionVO conVo = new ConnectionVO();
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://103.8.100.106:3433;databasename=NEOE");
		conVo.setUserId("NEOE");
		conVo.setPassword("NEOE");
		conVo.setErpTypeCode("ERPiU");
	}

	/**
	 * 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 환종
	 * @throws Exception 
	 */
	@Test
	public void testExCodeMngDB24ListInfoSelect() throws Exception {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		mngVo.setErpCompSeq("10000");
		mngVo.setSearchStr("000");
		
		List<ExExpendMngVO> result = exUserMngServiceUDAO.ExCodeMngDB24ListInfoSelect(mngVo, conVo);
		assertTrue(result.size() > 0);
	}

}
