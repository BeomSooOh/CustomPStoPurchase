package expend.ex.admin.config;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.TestCase;

/**
 * BExAdminConfigServiceImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-09-24.
 */
public class BExAdminConfigServiceImplTest extends TestCase {

	@Resource ( name = "FExAdminConfigServiceA" )
	private FExAdminConfigService adminConfigA;
	
	Map<String, Object> loginVOParam = new HashMap<String, Object>();
	
	@Before
	public void setupAdditional() {
		loginVOParam.put(commonCode.ID, CommonConvert.CommonGetStr(loginVO.getId())); /* 로그인 아이디 */
        loginVOParam.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr(loginVO.getGroupSeq())); /* 그룹시퀀스 */
        loginVOParam.put(commonCode.COMPSEQ, CommonConvert.CommonGetStr(loginVO.getCompSeq())); /* 회사시퀀스 */
        loginVOParam.put(commonCode.BIZSEQ, CommonConvert.CommonGetStr(loginVO.getBizSeq())); /* 사업장시퀀스 */
        loginVOParam.put(commonCode.DEPTSEQ, CommonConvert.CommonGetStr(loginVO.getOrgnztId())); /* 부서시퀀스 */
        loginVOParam.put(commonCode.EMPSEQ, CommonConvert.CommonGetStr(loginVO.getUniqId())); /* 사원시퀀스 */
        loginVOParam.put(commonCode.EMPNAME, CommonConvert.CommonGetStr(loginVO.getName())); /* 사원이름 */
        loginVOParam.put(commonCode.LANGCODE, CommonConvert.CommonGetStr(loginVO.getLangCode())); /* 사용언어코드 */
        loginVOParam.put(commonCode.USERSE, CommonConvert.CommonGetStr(loginVO.getUserSe())); /* 사용자접근권한 */
        loginVOParam.put(commonCode.ERPEMPSEQ, CommonConvert.CommonGetStr(loginVO.getErpEmpCd())); /* ERP사원번호 */
        loginVOParam.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetStr(loginVO.getErpCoCd())); /* ERP회사코드 */
        loginVOParam.put(commonCode.EATYPE, CommonConvert.CommonGetStr(loginVO.getEaType())); /* 연동 전자결재 구분 */
	}
	
	/**
	 * ## 양식별 표준적요 설정 ## - 표준적요 등록
	 * @throws Exception 
	 */
	@Test
	public void testExAdminSetSummaryAuthCreate() throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("summaryArr", "[{\"summaryCode\":\"18800\",\"formSeq\":\"25\"},{\"summaryCode\":\"10055\",\"formSeq\":\"25\"},{\"summaryCode\":\"80308\",\"formSeq\":\"25\"},{\"summaryCode\":\"4edrgdrg\",\"formSeq\":\"25\"}]");
		
		ResultVO result = new ResultVO( );
		
		List<Map<String, Object>> summaryArr = CommonConvert.ConvertJsonToListMap(param.get("summaryArr").toString());
		
		for(Map<String, Object> summaryParam : summaryArr) {
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( loginVOParam, summaryParam ) );
			result = adminConfigA.ExAdminSetSummaryAuthCreate( result );
			assertEquals("SUCCESS", result.getResultCode());
		}
		
	}
	
	@Test
	public void 표준적요_등록_전_삭제기능_테스트() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put("formSeq", "25");
		param.put("summaryCode", "18800");
		param.put("isInsert", "Y");
		
		ResultVO result = new ResultVO( );
		
		result.setParams( CommonConvert.CommonSetMapCopy( loginVOParam, param ) );
		result = adminConfigA.ExAdminSetSummaryAuthDelete( result );
		assertEquals("SUCCESS", result.getResultCode());
	}
	
	@Test
	public void 표준적요_등록_통합_테스트() throws Exception {
		// 등록 기능 전 먼저 수행되어야 함
		표준적요_등록_전_삭제기능_테스트();
		
		testExAdminSetSummaryAuthCreate();
	}

}
