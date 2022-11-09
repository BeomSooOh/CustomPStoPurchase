package expend.ex.user.card;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeCardVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import expend.TestCase;

/**
 * FExUserCardServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-02.
 */
public class FExUserCardServiceADAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserCardServiceADAOTest.class);

	@Autowired
	private FExUserCardServiceADAO fExUserCardServiceADAO;
	
	/**
	 * 지출결의 - 카드 사용내역 상세
	 * @throws Exception 
	 */
	@Test
	public void testExReportCardDetailInfoSelect() throws Exception  {
		ExCodeCardVO cardVo = new ExCodeCardVO(); 
		
		cardVo.setSyncId("508959");
		cardVo.setCompSeq("1241");
		
		ExCodeCardVO result = fExUserCardServiceADAO.ExReportCardDetailInfoSelect( cardVo );
		
		logger.info("### result = {}", result);
		assertNotNull(result.getSyncId());
	}
	
	/**
	 * 지출결의 - 카드 사용내역 상세_취소분 포함
	 * @throws Exception 
	 */
	@Test
	public void testExReportCardDetailInfoWithCancelInfoSelect() throws Exception {
		ExCodeCardVO cardVo = new ExCodeCardVO(); 
		
		cardVo.setSyncId("508959");
		cardVo.setCompSeq("1241");
		
		ExCodeCardVO result = fExUserCardServiceADAO.ExReportCardDetailInfoWithCancelInfoSelect( cardVo );
		
		logger.info("### result = {}", result);
		assertNotNull(result.getSyncId());
	}
	
	/**
	 * 지출결의 - 카드 상신 목록 조회 ( 사용자 )
	 * @throws Exception 
	 */
	@Test
	public void testExExpendEmpCardListInfoSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchFromDate", "20190101");
		params.put("searchToDate", "20190530");
		params.put("notInSyncId", "");
		params.put("deptSeq", "1242");
		params.put("empSeq", "1244");
		params.put("compSeq", "1241");
		params.put("searchStr", "'4140030349909900', '0000111122223333'");
		params.put("whereUsed", "우림");
		params.put("merc_saup_no", "");
		
		List<Map<String, Object>> result = fExUserCardServiceADAO.ExExpendEmpCardListInfoSelect( params );
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 지출결의 - 카드 상신 목록 조회 ( 사용자 )_카드취소분 포함
	 * @throws Exception 
	 */
	@Test
	public void testExExpendEmpCardListInfoWithCancelInfoSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchFromDate", "20190101");
		params.put("searchToDate", "20190530");
		params.put("notInSyncId", "");
		params.put("deptSeq", "1242");
		params.put("empSeq", "1244");
		params.put("compSeq", "1241");
		params.put("searchStr", "");
		params.put("whereUsed", "우림");
		params.put("merc_saup_no", "");
		
		List<Map<String, Object>> result = fExUserCardServiceADAO.ExExpendEmpCardListInfoWithCancelInfoSelect( params );
		
		assertTrue(result.size() > 0);
		
		logger.info("### totalCount = {}", result.size());
	}
	
	/**
	 * 지출결의 - 카드정보 도움창 - 카드정보 조회
	 */
	@Test
	public void testExExpendUserCardInfoSelect() {
		Map<String, Object> param = new HashMap<>();
		
		param.put("compSeq", "1241");
		param.put("deptSeq", "1242");
		param.put("empSeq", "1244");
		param.put("searchType", "ALL");
		param.put("searchStr", "");
		param.put("notUseCardYN", "");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(1);
		paginationInfo.setPageSize(10);
		
		Map<String, Object> temp = fExUserCardServiceADAO.ExExpendUserCardInfoSelect(param, paginationInfo);
		List<Map<String, Object>> result = (List<Map<String, Object>>)temp.get("list");
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 지출결의 - 카드 사용내역 상세
	 * @throws Exception 
	 */
	@Test
	public void testExExpendCardDetailInfoSelect() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put("syncId", "84502");
		
		ResultVO resultVo = new ResultVO();
		resultVo.setParams(param);
		
		Map<String, Object> result = fExUserCardServiceADAO.ExExpendCardDetailInfoSelect(resultVo);
		
		assertNotNull(result.get("syncId"));
	}
	

}
