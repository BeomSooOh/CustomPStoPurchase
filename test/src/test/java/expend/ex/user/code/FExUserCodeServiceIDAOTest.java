package expend.ex.user.code;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import common.helper.logger.ExpInfo;
import common.vo.common.ConnectionVO;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExCodeCardVO;
import expend.TestCase;

/**
 * FExUserCodeServiceIDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-03.
 */
public class FExUserCodeServiceIDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExUserCodeServiceIDAOTest.class);
	
	@Autowired
	private FExUserCodeServiceIDAO fExUserCodeServiceIDAO;
	
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
		
		erpConnectionConfig(conVo);
	}
	
	/**
	 * 공통코드 - 카드 조회(iCUBE) - 항목정보 생성 시 
	 */
	@Test
	public void testExCodeCardInfoSelect() {
		ExCodeCardVO cardVo = new ExCodeCardVO();
		cardVo.setErpCompSeq("0101");
		cardVo.setSearchCardNum("1111222233334444");
		
		//iCUBE 카드정보 조회
		cardVo = erpSession.selectOne( "ExCodeCardInfoSelect", cardVo );
		
		assertNotNull(cardVo.getErpCompSeq());
	}
	
	/**
	 * 공통코드 조회(프로젝트 도움창)_iCUBE
	 * @throws Exception
	 */
	@Test
	public void testExCommonCodeProjectSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("erpCompSeq", "0101");
		params.put("searchStr", "");
		params.put("selProjectStatus", "USE");
		
		List<Map<String, Object>> result = fExUserCodeServiceIDAO.ExCommonCodeProjectSelect(params, conVo);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * 환종정보 조회
	 * @throws Exception 
	 */
	@Test
	public void testExCommonCodeExchangeUnitSelect() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("erpCompSeq", "0101");
		params.put("searchStr", "ADP");
		
		List<Map<String, Object>> result = fExUserCodeServiceIDAO.ExCommonCodeExchangeUnitSelect(params, conVo);
		logger.info("### result = {}", result);
		
		assertTrue(result.size() > 0);
	}
	
	@Test
	public void iCUBE_카드도움창_공통코드_조회() throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("erpCompSeq", "8204");
		params.put("searchStr", "테스트1");
		
		List<Map<String, Object>> result = ExCommonCodeCardSelect(params, conVo);
		assertTrue(result.size() > 0);
	}
	
	public List<Map<String, Object>> ExCommonCodeCardSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = ExCommonCodeCardSelectForICUBE(params);
		/* 그룹웨어 카드정보 조회 */
		@SuppressWarnings ( "unchecked" )
		List<Map<String, Object>> resultBizboxA = (List<Map<String, Object>>) list( "ExUserCardListInfoSelect", params );
		/* ERP 데이터와 그룹웨어 데이터 조인 */
		for ( Map<String, Object> erpCardData : result ) {
			for ( Map<String, Object> gwCardData : resultBizboxA ) {
				if ( erpCardData.get( "cardCode" ).toString( ).equals( gwCardData.get( "cardCode" ) ) ) {
					if ( gwCardData.get( "partnerCode" ) != null && !gwCardData.get( "partnerCode" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
						erpCardData.put( "partnerCode", gwCardData.get( "partnerCode" ) );
						erpCardData.put( "partnerName", gwCardData.get( "partnerName" ) );
						break;
					}
				}
			}
		}
		return result;
	}
	
	@Test
	public void iCUBE_카드정보_조회() {
		Map<String, Object> params = new HashMap<>();
		params.put("erpCompSeq", "8204");
		params.put("searchStr", "테스트1");
		
		List<Map<String, Object>> result = ExCommonCodeCardSelectForICUBE(params);
		assertTrue(result.size() > 0);
	}
	
	private List<Map<String, Object>> ExCommonCodeCardSelectForICUBE(Map<String, Object> params){
		return erpSession.selectList("ExUserCode.ExCommonCodeCardSelect", params);
	}

}
