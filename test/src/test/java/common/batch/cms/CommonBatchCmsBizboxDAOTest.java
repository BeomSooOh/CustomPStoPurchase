package common.batch.cms;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.vo.batch.CommonBatchCmsDataVO;
import expend.TestCase;

/**
 * CommonBatchCmsBizboxDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-10-16.
 */
public class CommonBatchCmsBizboxDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(CommonBatchCmsBizboxDAOTest.class);

	@Resource(name = "CommonBatchCmsBizboxDAO")
    CommonBatchCmsBizboxDAO daoBizbox;
	
	/**
	 * 카드 cms 데이터 저장
	 */
	@Test
	public void testCommonCmsCardTempInfoInsert() {
		CommonBatchCmsDataVO params = new CommonBatchCmsDataVO();
		
		params.setCardNum("4518444200491006");
		params.setAuthNum("16230518");
		params.setAuthDate("20200102");
		params.setAuthTime("000000");
		params.setGeoraeColl("459951167994040820190626730671201");
		params.setGeoraeStat("N");
		params.setGeoraeCand("");
		params.setRequestAmount("25000");
		params.setAmtAmount("22727");
		params.setVatAmount("2273");
		params.setSerAmount("0");
		params.setFreAmount("0");
		params.setAmtMdAmount("127273");
		params.setVatMdAmount("12727");
		params.setGeoraeGukga("KRW");
		params.setForAmount("0.0000");
		params.setUsdAmount("0.0000");
		params.setMercName("(주)블루아일랜드개발");
		params.setMercSaupNo("1378180474");
		params.setMercAddr("인천  서구  경서동 83690번지  베어즈베스트청라골프클럽");
		params.setMercRepr("윤해식");
		params.setMercTel("0325602023");
		params.setMercZip("");
		params.setMccName("");
		params.setMccCode("");
		params.setMccStat("");
		params.setVatStat("");
		params.setGongjeNoChk("N");
		params.setAbroad("A");
		params.setAquiRate("1100.0000");
		
		int result = daoBizbox.CommonCmsCardTempInfoInsert(params);
		assertTrue(result > 0);
	}
	
	@Test
	public void iCUBE_CMS_카드승인_데이터_입력_테스트() {
		CommonBatchCmsDataVO params = new CommonBatchCmsDataVO();

		params.setPK1("31");
		params.setPK2("5048209964");
		params.setPK3("1225122512251225");
		params.setPK4("20200201");
		params.setPK5("12:58:46");
		params.setPK6("35590824");
		params.setPK7("A");
		params.setISS_DT("20200201");
		params.setISS_SQ("13");
		params.setCARD_NO("1225122512251225");
		params.setAPPR_NO("35590824                                                                                            ");
		params.setAPPR_DT("20200201");
		params.setAPPR_TM("12:58:46");
		params.setCANCEL_YN("N");
		params.setAPPRTOT_AM("205480.0000");
		params.setSUPPLY_AM("205480.0000");
		params.setVAT_AM("0.0000");
		params.setSERVICE_AM("0.0000");
		params.setFEE_AM("0.0000");
		params.setCUR_CD("KRW");
		params.setCHAIN_CEO_NM("이니시스_취급수수료/(주)세중나모");
		params.setCHAIN_TEL("");
		params.setCHAIN_ZIP_CD("");
		params.setBUSINESS_NM("");
		params.setTAX_TY("9999");
		params.setCHAIN_CESS_DT("20200201");
		params.setDEDUCT_YN("N");
		params.setEBANK_KEY("5048209964|1225122512251225|20200201|12:58:46|35590824|A");
		
		int result = CommonCmsCardTempInfoAllInsert(params);
		logger.info("### result = {}", result);
		
		assertTrue(result > 0);
	}
	
	/**
	 * iCUBE CMS 데이터를 카드승인내역 테이블에 입력
	 * @param params
	 * @return
	 */
	private int CommonCmsCardTempInfoAllInsert(CommonBatchCmsDataVO params) {
		return Integer.parseInt((String)insert("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllInsert", params));
	}
	
	@Test
	public void iCUBE_CMS_카드승인_데이터_수정_테스트() {
		CommonBatchCmsDataVO params = new CommonBatchCmsDataVO();

		params.setPK1("31");
		params.setPK2("5048209964");
		params.setPK3("1225122512251225");
		params.setPK4("20200201");
		params.setPK5("12:58:46");
		params.setPK6("35590824");
		params.setPK7("A");
		params.setISS_DT("20200201");
		params.setISS_SQ("13");
		params.setCARD_NO("1225122512251225");
		params.setAPPR_NO("35590824                                                                                            ");
		params.setAPPR_DT("20200201");
		params.setAPPR_TM("12:58:46");
		params.setCANCEL_YN("N");
		params.setAPPRTOT_AM("205480.0000");
		params.setSUPPLY_AM("205480.0000");
		params.setVAT_AM("0.0000");
		params.setSERVICE_AM("0.0000");
		params.setFEE_AM("0.0000");
		params.setCUR_CD("KRW");
		params.setCHAIN_NM("");
		params.setCHAIN_REG_NO("");
		params.setCHAIN_ADDR1("");
		params.setCHAIN_ADDR2("");
		params.setCHAIN_CEO_NM("이니시스_취급수수료/(주)세중나모");
		params.setCHAIN_TEL("");
		params.setCHAIN_ZIP_CD("");
		params.setBUSINESS_NM("");
		params.setTAX_TY("9999");
		params.setCHAIN_CESS_DT("20200201");
		params.setDEDUCT_YN("N");
		params.setEBANK_KEY("5048209964|1225122512251225|20200201|12:58:46|35590824|A");
		
		int result = CommonCmsCardTempInfoAllUpdate(params);
		logger.info("### result = {}", result);
		
		assertTrue(result > 0);
	}
	
	/**
	 * iCUBE CMS 데이터를 카드승인내역 테이블에 수정
	 * @param params
	 * @return
	 */
	private int CommonCmsCardTempInfoAllUpdate(CommonBatchCmsDataVO params) {
		return update("CommonBatchCmsBizboxDAO.CommonCmsCardTempInfoAllUpdate", params);
	}
}
