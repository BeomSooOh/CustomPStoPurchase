package expend.ex.admin.config;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cmm.util.MapUtil;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.TestCase;

/**
 * FExAdminConfigServiceAImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-09-24.
 */
public class FExAdminConfigServiceAImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExAdminConfigServiceAImplTest.class);

	/**
	 * ## 양식별 표준적요 설정 ## - 표쥰적요 삭제
	 */
	@Test
	public void 필수값_제외기능_테스트() {
		Map<String, Object> param = new HashMap<>();
		
		param.put("compSeq", "1241");
		param.put("formSeq", "25");
		param.put("summaryCode", "18800");
		param.put("isInsert", "Y");
		
		ResultVO result = new ResultVO();
		
		String[] parametersCheck = { commonCode.COMPSEQ, commonCode.EMPTYYES, commonCode.FORMSEQ, commonCode.EMPTYYES, "summaryCode", commonCode.EMPTYYES };
		
		if("Y".equals(param.get("isInsert"))) {
			List<String> list = new ArrayList<>(Arrays.asList(parametersCheck));
			list.remove(5);
			list.remove(4);
			
			parametersCheck = list.toArray(new String[list.size()]);
		}
		
		logger.info("### parametersCheck = {}", parametersCheck);
		
		if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
			result.setFail( "필수 입력 정보가 누락되었습니다." );
		}else {
			result.setSuccess();
		}
		
		assertEquals("SUCCESS", result.getResultCode());
	}
	
	/**
	 * 지출결의 마감일 설정 리스트 등록(전체양식)
	 */
	@Test
	public void 마감일이_겹치는_양식_목록_결합_테스트() {
		// 양식 목록 리스트
		List<Map<String, Object>> exceptFormList = new ArrayList<Map<String, Object>>( );
		
		// 임의의 formSeq값 넣기
		Map<String, Object> temp = new HashMap<>();
		temp.put("formSeq", "25");
		exceptFormList.add(temp);
		
		temp = new HashMap<>();
		temp.put("formSeq", "39");
		exceptFormList.add(temp);
		
		temp = new HashMap<>();
		temp.put("formSeq", "41");
		exceptFormList.add(temp);
		
		StringBuilder result = new StringBuilder();
		String separator = "";
		for(Map<String, Object> form : exceptFormList) {
			result.append(separator).append(form.get("formSeq"));
			separator = ",";
		}
		
		logger.info("### result = {}", result.toString());
		
	}

}
