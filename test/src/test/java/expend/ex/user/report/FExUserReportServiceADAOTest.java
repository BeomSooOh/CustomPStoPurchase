package expend.ex.user.report;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.ex.ExReportCardVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import expend.TestCase;

/**
 * FExUserReportServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-01-23.
 */
public class FExUserReportServiceADAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserReportServiceADAOTest.class);
	
	@Autowired
	private FExUserReportServiceADAO userReportDAO;

	/**
	 * Bizbox Alpha - 나의 카드 사용 현황 - 목록 조회
	 */
	@Test
	public void testExUserCardReportListInfoSelect() {
		ExReportCardVO reportCardVO = new ExReportCardVO();
		reportCardVO.setLangCode("kr");
		reportCardVO.setCompSeq("1241");
		reportCardVO.setEmpSeq("1244");
		reportCardVO.setFromDate("20190701");
		reportCardVO.setToDate("20190801");
		reportCardVO.setCardNum("");
		reportCardVO.setCardName("");
		reportCardVO.setMercName("");
		reportCardVO.setDocSts("");
		reportCardVO.setSortField("authDate");
		reportCardVO.setSortType("desc");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(1);
		paginationInfo.setPageSize(10);
		
		Map<String, Object> result = userReportDAO.ExUserCardReportListInfoSelect( reportCardVO, paginationInfo );
		logger.info("### result = {}", result);
		List<Map<String, Object>> resultList = (List<Map<String, Object>>)result.get("list");
		
		assertTrue(resultList.size() > 0);
	}
	
	/**
	 * 세금계산서 현황 / 카드사용현황 외부시스템 이관처리 진행
	 */
	@Test
	public void testExUserInterfaceTransfer() {
		Map<String, Object> param = new HashMap<>();
		
		param.put("issNo", "FX2013025713755");
		param.put("hometaxIssNo", "201302014100009611006592");
		param.put("issDt", "20190417");
		param.put("trregNb", "1248300269");
		param.put("compSeq", "707010026273");
		
		//세금계산서 내역 등록 테스트
		this.insert( "ExUserETaxInsert", param );
	}
	
	/**
	 * 소계양식 데이터 조회
	 * @throws Exception 
	 */
	@Test
	public void testExReportSubtotalInterLockInfoSelect() throws Exception {
		Map<String, Object> params = new HashMap<>();
		
		params.put("expendSeq", "992");
		
		List<Map<String, Object>> result = userReportDAO.ExReportSubtotalInterLockInfoSelect( params );
		
		assertTrue(result.size() > 0);
	}

}
