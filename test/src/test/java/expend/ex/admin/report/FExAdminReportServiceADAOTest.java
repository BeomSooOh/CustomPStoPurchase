package expend.ex.admin.report;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import bizbox.orgchart.service.vo.LoginVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;
import expend.TestCase;

/**
 * FExAdminReportServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-03.
 */
public class FExAdminReportServiceADAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExAdminReportServiceADAOTest.class);
	
	@Autowired
	private FExAdminReportServiceADAO fExAdminReportServiceADAO;

	/**
	 * 카드 사용 현황 - 목록 조회
	 */
	@Test
	public void testExAdminCardReportListInfoSelect() {
		ExReportCardVO reportCardVO = new ExReportCardVO();
		reportCardVO.setCompSeq("1241");
		reportCardVO.setLangCode("kr");
		reportCardVO.setCardNum("");
		reportCardVO.setCardName("");
		reportCardVO.setFromDate("20190701");
		reportCardVO.setToDate("20190801");
		reportCardVO.setMercName("");
		reportCardVO.setDocSts("");
		reportCardVO.setUseYN("Y");
		
		List<Map<String, Object>> result = fExAdminReportServiceADAO.ExAdminCardReportListInfoSelect( reportCardVO );
		
		assertTrue(result.size() > 0);
	}

	/**
	 * 카드 사용 현황 - 엑셀데이터 조회
	 */
	@Test
	public void testExAdminCardReportListInfoSelectForExcel() {
		Map<String, Object> params = new HashMap<>();
		
		params.put("langCode", "kr");
		params.put("compSeq", "707010026273");
		params.put("cardNum", "");
		params.put("cardName", "");
		params.put("frDt", "20190201");
		params.put("toDt", "20190403");
		params.put("mercName", "");
		params.put("docSts", "");
		
		List<Map<String, Object>> result = fExAdminReportServiceADAO.ExAdminCardReportListInfoSelectForExcel(params);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * Bizbox Alpha - 지출결의 전체 정보 조회 - iCUBE용 포멧
	 */
	@Test
	public void testExAdminExpendReportListInfoSelect() {
		Map<String, Object> param = new HashMap<>();
		
		param.put("advExpendDt", "20190513");
		param.put("expendSeq", "6836");
		param.put("compSeq", "707010026273");
		
		List<Map<String, Object>> result = fExAdminReportServiceADAO.ExAdminExpendReportListInfoSelect( param );
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * Bizbox Alpha - 지출결의 전체 정보 조회 - iU용 포멧
	 */
	@Test
	public void testExAdminExpendReportListInfoSelectU() {
		Map<String, Object> param = new HashMap<>();
		
		param.put("advExpendDt", "20190513");
		param.put("expendSeq", "6847");
		param.put("compSeq", "707010026273");
		
		List<Map<String, Object>> result = fExAdminReportServiceADAO.ExAdminExpendReportListInfoSelectU( param );
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 전자결재 회계API 연동 시에는 로그인세션이 따로 없기 때문에 로그인세션정보를 별도로 구해준다.
	 */
	@Test
	public void testExGetLoginSessionForApprovalProcessSelect() {
		Map<String, Object> param = new HashMap<>();
		
		param.put("groupSeq", "demo");
		param.put("expendSeq", "6786");
		
		LoginVO result = fExAdminReportServiceADAO.ExGetLoginSessionForApprovalProcessSelect(param);
		
		logger.info("### result = {}", result);
		assertNotNull(result.getCompSeq());
	}
	
	/**
	 * Bizbox Alpha - 그룹웨어 문서 정보 조회 iCUBE
	 */
	@Test
	public void testExAdminExpendReportDocInfoSelect() {
		Map<String, Object> param = new HashMap<>();
		
		param.put("expendSeq", "3363");
		param.put("groupSeq", "dragons_test");
		
		Map<String, Object> result = fExAdminReportServiceADAO.ExAdminExpendReportDocInfoSelect(param);
		
		logger.info("### result = {}", result);
		assertNotNull(result.get("doc_id"));
	}
	
	/**
	 * 지출결의 - GW 세금계산서 정보 조회
	 * @throws Exception 
	 */
	@Test
	public void testExAdminGWEtaxInfoSelect() throws Exception {
		ResultVO param = new ResultVO();
		
		Map<String, Object> searchParam = new HashMap<>();
		
		searchParam.put("empSeq", "ADMIN");
		searchParam.put("compSeq", "1241");
		searchParam.put("searchFromDt", "20200101");
		searchParam.put("searchToDt", "20200401");
		
		param.setParams(searchParam);
		
		List<Map<String, Object>> result = fExAdminReportServiceADAO.ExAdminGWEtaxInfoSelect(param);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * ERPiU 문서 링크 전달 정보 조회
	 * @throws Exception 
	 */
	@Test
	public void testExAdminDocLinkListInfoSelect() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put("expendSeq", "3363");
		param.put("sendType", "");
		param.put("rowId", "");
		
		List<Map<String, Object>> result = fExAdminReportServiceADAO.ExAdminDocLinkListInfoSelect(param);
		
		assertTrue(result.size() > 0);
	}

}
