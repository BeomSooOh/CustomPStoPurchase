package expend.ex.user.card;

import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.enums.ex.OptionCodeType;
import common.enums.ex.TaxType;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import expend.TestCase;

/**
 * BExUserCardServiceImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2020-02-27.
 */
public class BExUserCardServiceImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(BExUserCardServiceImplTest.class);
	
	@Resource ( name = "FExUserCardServiceADAO" )
	private FExUserCardServiceADAO dao;

	/**
	 * 지출결의 - 카드 사용내역 상세
	 * @throws Exception 
	 */
	@Test
	public void testExExpendCardDetailInfoSelect() throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("syncId", "84200");
		
		Map<String, Object> result = ExExpendCardDetailInfoSelect(param);
		
		assertNotNull(result.get("syncId"));
	}
	
	// 카드 사용내역 상세내역 조회
	private Map<String, Object> ExExpendCardDetailInfoSelect(Map<String, Object> param) throws Exception {
		ResultVO params = new ResultVO();
		
		params.setParams(param);
		
		return dao.ExExpendCardDetailInfoSelect( params );
	}
	
	@Test
	public void 과세유형명_검색결과_추가() throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("syncId", "84196");
		
		Map<String, Object> result = ExExpendCardDetailInfoSelect(param);
		
		String taxTypeName = "";
		// vatStat를 먼저 읽어 매칭되는 값이 있을경우 taxTypeName 반환 그렇지 않은 경우 mccCode 사용
		if(TaxType.findByTaxTypeCode(CommonConvert.CommonGetStr(result.get("vatStat"))).equals("")){
			taxTypeName = TaxType.findByTaxTypeCode(CommonConvert.CommonGetStr(result.get("mccCode")));
		}else {
			taxTypeName = TaxType.findByTaxTypeCode(CommonConvert.CommonGetStr(result.get("vatStat")));
		}
		result.put("taxTypeName", taxTypeName);
		logger.info("### taxTypeName = {}", result.get("taxTypeName"));
		
		assertNotNull(result.get("taxTypeName"));
	}
	
}
