package oracleconvert;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.vo.common.ConnectionVO;
import common.vo.ex.ExExpendMngVO;
import expend.TestCase;

/**
 * ExMngSQLTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-08-28.
 * rollback 됨.
 */
public class ExMngSQLTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(ExMngSQLTest.class);
	
	private ConnectionVO conVo = new ConnectionVO();

	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("oracle");
		conVo.setDriver("oracle.jdbc.driver.OracleDriver");
		conVo.setUrl("jdbc:oracle:thin:@10.20.97.13:1521:orcl");
		conVo.setUserId("NEOE");
		conVo.setPassword("NEOE");
		conVo.setErpTypeCode("ERPiU");
		
		erpConnectionConfig(conVo);
	}
	
	/**
	 * 공통코드 - 지출결의 항목 분개 관리항목 목록 조회
	 */
	@Test
	public void testExCodeMngListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setAcctCode("28100");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 귀속사업장
	 */
	@Test
	public void testExCodeMngDA01ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA01ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 코스트센타
	 */
	@Test
	public void testExCodeMngDA02ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA02ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 부서
	 */
	@Test
	public void testExCodeMngDA03ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA03ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 사원
	 */
	@Test
	public void testExCodeMngDA04ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA04ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 프로젝트
	 */
	@Test
	public void testExCodeMngDA05ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("ERPIU");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA05ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 거래처
	 */
	@Test
	public void testExCodeMngDA06ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("INITEST");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA06ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 예적금계좌
	 */
	@Test
	public void testExCodeMngDA07ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("0315");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA07ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 신용카드
	 */
	@Test
	public void testExCodeMngDA08ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("0315");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA08ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 금융기관
	 */
	@Test
	public void testExCodeMngDA09ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("3000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA09ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 품목
	 */
	@Test
	public void testExCodeMngDA10ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDA10ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 자산관리번호
	 */
	@Test
	public void testExCodeMngDB01ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("YHKIM");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDB01ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 자산처리구분
	 */
	@Test
	public void testExCodeMngDB11ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDB11ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 받을어음정리구분
	 */
	@Test
	public void testExCodeMngDB12ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDB12ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 환종
	 */
	@Test
	public void testExCodeMngDB24ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDB24ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 사업자등록번호
	 */
	@Test
	public void testExCodeMngDC01ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDC01ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 관련계정(프로시저), Mybatis 프로시저는 파라미터로 값이 반환되기 때문에 mngVo에 결과값 받는 필드 필요함(완료).
	 * @throws Exception 
	 */
	@Test
	public void testExCodeMngDC03ListInfoSelect() throws Exception {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		erpSession.selectOne("ExCodeMngDC03ListInfoSelect", mngVo);
		logger.info("### mngVo = {}", mngVo.getResult());
		assertTrue(mngVo.getResult().size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 세무구분
	 */
	@Test
	public void testExCodeMngDC14ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDC14ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 거래처 계좌번호
	 */
	@Test
	public void testExCodeMngDC15ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setCallback("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDC15ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 불공제구분
	 */
	@Test
	public void testExCodeMngDC18ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDC18ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 증빙구분
	 */
	@Test
	public void testExCodeMngDC20ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDC20ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 지급조건
	 */
	@Test
	public void testExCodeMngDC28ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("10");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDC28ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 - 업무용차량
	 */
	@Test
	public void testExCodeMngDB54ListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("0912");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDB54ListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 공통코드 - 관리항목 하위 코드 조회 - 관리내역
	 */
	@Test
	public void testExCodeMngDListInfoSelect() {
		ExExpendMngVO mngVo = new ExExpendMngVO();
		
		mngVo.setErpCompSeq("1000");
		mngVo.setMngCode("A22");
		mngVo.setSearchStr("");
		
		List<ExExpendMngVO> result = erpSession.selectList("ExCodeMngDListInfoSelect", mngVo);
		
		assertTrue(result.size() > 0);
	}

}
