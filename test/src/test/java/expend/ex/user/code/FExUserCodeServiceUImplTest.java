package expend.ex.user.code;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.vo.common.ConnectionVO;
import common.vo.common.CommonInterface.commonCode;
import expend.TestCase;

/**
 * FExUserCodeServiceUImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2020-02-13.
 */
public class FExUserCodeServiceUImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserCodeServiceUImplTest.class);

	@Resource(name = "FExUserCodeServiceU")
    private FExUserCodeService codeU; /* ERP iU */
	@Resource(name = "FExUserCodeServiceUDAO")
    private FExUserCodeServiceUDAO dao;
	
	ConnectionVO conVo = new ConnectionVO();
	
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
		
//		conVo.setDatabaseType("oracle");
//		conVo.setDriver("oracle.jdbc.driver.OracleDriver");
//		conVo.setUrl("jdbc:oracle:thin:@10.20.97.13:1521:orcl");
//		conVo.setUserId("NEOE");
//		conVo.setPassword("NEOE");
//		conVo.setErpTypeCode("ERPiU");
		
		erpConnectionConfig(conVo);
	}
	
	/**
	 * ERPiU 공통코드 조회 테스트
	 * @throws Exception 
	 */
	@Test
	public void testExUserCommCodeSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("codeType", "BGACCT");
		params.put("acctCode", "");
		params.put("erpCompSeq", "10000");
		params.put("budgetCode", "1000");
		params.put("searchStr", "1010");
		
//		List<Map<String, Object>> result = codeU.ExUserCommCodeSelect(params, conVo);
		List<Map<String, Object>> result = ExUserCommCodeSelect(params, conVo);
		assertTrue(result.size() > 0);
		
		logger.info("### result = {}", result);
	}
	
	/**
	 * ERPiU 공통코드 조회
	 * @param params
	 * @param conVo
	 * @return
	 * @throws Exception
	 */
    private List<Map<String, Object>> ExUserCommCodeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        String codeType = params.get(commonCode.CODETYPE).toString();
        if (codeType.toUpperCase().equals(commonCode.ACCT)) {
            return dao.ExCommonCodeAcctSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.BGACCT)) {
            if (CommonConvert.CommonGetStr(params.get("acctCode")).equals("")) {
                return dao.ExCommonCodeBgAcctSelect(params, conVo);
            } else {
                List<Map<String, Object>> temp = new ArrayList<Map<String, Object>>();
                temp = dao.ExCommonCodeBgAcctLinkAcctSelect(params, conVo);

                if (temp.size() > 0) {
                    return temp;
                } else {
                    return dao.ExCommonCodeBgAcctSelect(params, conVo);
                }
            }
        } else if (codeType.toUpperCase().equals(commonCode.BIZPLAN)) {
            return dao.ExCommonCodeBizplanSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.BUDGET)) {
            return dao.ExCommonCodeBudgetSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.CARD)) {
            return dao.ExCommonCodeCardSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.CC)) {
            return dao.ExCommonCodeCcSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EMP)) {
            return dao.ExCommonCodeEmpSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.DEPT)) {
            return dao.ExCommonCodeDeptSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EMPONE)) {
            return dao.ExCommonCodeEmpSelectOne(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.ERPAUTH)) {
            return dao.ExCommonCodeErpAuthSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.NOTAX)) {
            return dao.ExCommonCodeNotaxSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PARTNER)) {
            return dao.ExCommonCodePartnerSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PC)) {
            return dao.ExCommonCodePcSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.PROJECT)) {
            return dao.ExCommonCodeProjectSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.VATTYPE)) {
            return dao.ExCommonCodeVatTypeSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.REGNOPARTNER)) {
            return dao.ExCommonCodeRegNoPartnerSelect(params, conVo);
        } else if (codeType.toUpperCase().equals(commonCode.EXCHANGEUNIT)) {
        	return dao.ExCommonCodeExchangeUnitSelect(params, conVo);
        } else {
            throw new NotFoundLogicException(String.format("처리 분기 {0}를 찾을 수 없습니다.", codeType.toString()), commonCode.ERPIU);
        }
    }
    
    @Test
    public void 케이스별_예산계정_코드_조회_테스트() throws Exception {
    	Map<String, Object> params = new HashMap<String, Object>();
		
    	// 전체 예산계정조회
		params.put("codeType", "BGACCT");
		params.put("acctCode", "");
		params.put("erpCompSeq", "10000");
		params.put("budgetCode", "1000");
		params.put("searchStr", "");
		
    	List<Map<String, Object>> result = ExCommonCodeBgAcctSelect(params, conVo);
		assertTrue(result.size() > 0);
		
		logger.info("### result = {}", result);
		
		// 특정검색어 예산계정조회
		params = new HashMap<String, Object>();
		params.put("codeType", "BGACCT");
		params.put("acctCode", "");
		params.put("erpCompSeq", "10000");
		params.put("budgetCode", "1000");
		params.put("searchStr", "교통비");
		
		List<Map<String, Object>> result2 = ExCommonCodeBgAcctSelect(params, conVo);
		assertTrue(result2.size() > 0);
		
		logger.info("### result2 = {}", result2);
		
		// 회계계정연결 설정되어 있는경우 전체조회
		params = new HashMap<String, Object>();
		params.put("codeType", "BGACCT");
		params.put("acctCode", "30300");
		params.put("erpCompSeq", "10000");
		params.put("budgetCode", "1000");
		params.put("searchStr", "");
		
		List<Map<String, Object>> result3 = ExCommonCodeBgAcctSelect(params, conVo);
		assertTrue(result3.size() > 0);
		
		logger.info("### result3 = {}", result3);
		
		// 회계계정연결 설정되어 있는경우 특정검색어 조회
		params = new HashMap<String, Object>();
		params.put("codeType", "BGACCT");
		params.put("acctCode", "30300");
		params.put("erpCompSeq", "10000");
		params.put("budgetCode", "1000");
		params.put("searchStr", "하나투어");
		
		List<Map<String, Object>> result4 = ExCommonCodeBgAcctSelect(params, conVo);
		assertTrue(result4.size() > 0);
		
		logger.info("### result4 = {}", result4);
		
		// 회계계정연결 설정되어 있는경우 특정검색조건으로 검색 후 결과가 없을때
		params = new HashMap<String, Object>();
		params.put("codeType", "BGACCT");
		params.put("acctCode", "30300");
		params.put("erpCompSeq", "10000");
		params.put("budgetCode", "1000");
		params.put("searchStr", "테스트");
		
		List<Map<String, Object>> result5 = ExCommonCodeBgAcctSelect(params, conVo);
		assertTrue(result5.size() <= 0);
		
		logger.info("### result5 = {}", result5);
    }
    
    /**
     * 예산계정 코드 조회
     * @throws Exception 
     */
    private List<Map<String, Object>> ExCommonCodeBgAcctSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
    	Map<String, Object> checkResult = dao.checkBgAcctLinkAcct(params, conVo);
    	
    	// 회계계정연결 데이터가 있으면 연결설정된 데이터 내에서만 검색한다.
    	if(Integer.valueOf(CommonConvert.CommonGetSeq(checkResult.get("linkCount"))) > 0) {
    		return dao.ExCommonCodeBgAcctLinkAcctSelect(params, conVo);
    	}else {
    		return dao.ExCommonCodeBgAcctSelect(params, conVo);
    	}
    }
    
    @Test
    public void 회계계정연결_확인_테스트() throws Exception {
    	Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("erpCompSeq", "10000");
		params.put("acctCode", "30300");
		
    	Map<String, Object> result = dao.checkBgAcctLinkAcct(params, conVo);
		assertNotNull(result.get("linkCount"));
    }

}
