package expend.ex.user.mng;

import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;

import common.vo.common.ConnectionVO;
import common.vo.ex.ExExpendMngVO;
import expend.TestCase;

/**
 * FExUserMngServiceIDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-25.
 */
public class FExUserMngServiceIDAOTest extends TestCase {

	@Resource ( name = "FExUserMngServiceIDAO" )
	private FExUserMngServiceIDAO exUserMngServiceIDAO;
	
	private ConnectionVO conVo = new ConnectionVO();
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://175.206.170.90:3433;databasename=dzicube");
		conVo.setUserId("dzicube");
		conVo.setPassword("ejwhs123$");
		conVo.setErpTypeCode("iCUBE");
	}
	
	/**
	 * 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 관리내역
	 * @throws Exception 
	 */
	@Test
	public void testExCodeMngDListInfoSelect() throws Exception {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		mngVo.setMngCode("K2");
		mngVo.setErpCompSeq("0101");
		mngVo.setSearchStr("ADP");
		
		List<ExExpendMngVO> result = exUserMngServiceIDAO.ExCodeMngDListInfoSelect( mngVo, conVo );
		assertTrue(result.size() > 0);
	}

}
