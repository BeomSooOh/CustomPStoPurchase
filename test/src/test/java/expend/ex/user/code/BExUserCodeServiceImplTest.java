package expend.ex.user.code;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.CommonInterface.commonCode;
import common.vo.ex.ExCodeCardVO;
import expend.TestCase;

/**
 * BExUserCodeServiceImplTest JUnit테스트
 * Created by Kwon Oh Gwang on 2020-03-13.
 */
public class BExUserCodeServiceImplTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(BExUserCodeServiceImplTest.class);
	
	@Resource(name = "FExUserCodeServiceADAO")
    private FExUserCodeServiceADAO daoA; /* Bizbox Alpha */
	@Resource(name = "FExUserCodeServiceIDAO")
    private FExUserCodeServiceIDAO daoI; /* ERP iCUBE */
	
	ConnectionVO conVo = new ConnectionVO();
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
		conVo.setDatabaseType("mssql");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://175.206.170.90:3433;databasename=DZICUBE");
		conVo.setUserId("dzicube");
		conVo.setPassword("ejwhs123$");
		conVo.setErpTypeCode("iCUBE");
		conVo.setErpCompSeq("8204");
		
		erpConnectionConfig(conVo);
	}
	
	/**
	 * Biz - 지출결의 - 카드정보 조회
	 * @throws Exception 
	 */	
	@Test
	public void testExExpendCardInfoSelect() throws Exception {
		ExCodeCardVO cardVo = new ExCodeCardVO();
		cardVo.setCompSeq("1273");
		cardVo.setSeq(22587);
		
		ExCodeCardVO result = daoA.ExExpendCardInfoSelect(cardVo);
		assertNotNull(result.getSeq());
	}
	
	@Test
	public void iCUBE_카드정보_조회_거래처정보_포함() throws Exception {
		ExCodeCardVO cardVo = new ExCodeCardVO();
		cardVo.setCompSeq("1273");
		cardVo.setSeq(22587);
		
		ExCodeCardVO result = ExExpendCardInfoSelectWithPartner(cardVo, conVo);
		logger.info("### result = {}", result);
		assertNotNull(result.getSeq());
	}
	
	/**
	 * 카드정보 조회(iCUBE 일때만 해당) - iCUBE에 존재하는 카드이지만 그룹웨어에는 없을때 카드정보에 있는 거래처정보를 가져오기 위해 조회
	 * @throws Exception 
	 */
	public ExCodeCardVO ExExpendCardInfoSelectWithPartner(ExCodeCardVO cardVo, ConnectionVO conVo) throws Exception {
		try {
            cardVo = daoA.ExExpendCardInfoSelect(cardVo);
            
            // 카드정보의 거래처가 없을때
        	if(cardVo.getPartnerCode().equals(commonCode.EMPTYSTR)) {
        		Map<String, Object> params = new HashMap<>();
        		params.put("erpCompSeq", conVo.getErpCompSeq());
        		params.put("searchStr", cardVo.getCardCode());
        		
        		// iCUBE 카드정보 조회
        		List<Map<String, Object>> result = daoI.ExCommonCodeCardSelectForICUBE(params, conVo);
        		
        		if(result.size() > 0) {
        			cardVo.setPartnerCode(CommonConvert.CommonGetStr(result.get(0).get("partnerCode")));
        			cardVo.setPartnerName(CommonConvert.CommonGetStr(result.get(0).get("partnerName")));
        		}
        	}
        } catch (Exception e) {
            throw e;
        }
        return cardVo;
	}

}
