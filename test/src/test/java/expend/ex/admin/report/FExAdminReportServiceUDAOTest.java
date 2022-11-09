package expend.ex.admin.report;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import expend.TestCase;

/**
 * FExAdminReportServiceUDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-04-18.
 * MS-SQL 롤백 안됨. 데이터 쌓임.
 */
public class FExAdminReportServiceUDAOTest extends TestCase {
	private static final Logger logger = LoggerFactory.getLogger(FExAdminReportServiceUDAOTest.class);

	private CommonExConnect connector = new CommonExConnect();
	private ConnectionVO conVo = new ConnectionVO();
	
	/**
	 * 테스트케이스 환경설정
	 * @throws Exception 
	 */
	@Before
	public void additionalSetUp() throws Exception {
//		conVo.setDatabaseType("mssql");
//		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//		conVo.setUrl("jdbc:sqlserver://103.8.100.106:3433;databasename=NEOE");
//		conVo.setUserId("NEOE");
//		conVo.setPassword("NEOE");
//		conVo.setErpTypeCode("ERPiU");
		
		conVo.setDatabaseType("oracle");
		conVo.setDriver("oracle.jdbc.driver.OracleDriver");
		conVo.setUrl("jdbc:oracle:thin:@10.20.97.13:1521:orcl");
		conVo.setUserId("NEOE");
		conVo.setPassword("NEOE");
		conVo.setErpTypeCode("ERPiU");
	}
	
	@Test
	public void testExAdminETaxListInfoSelectMap() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("tpTbTaxCompany", "N");
		param.put("erpCompSeq", "");
		param.put("searchFromDt", "20190101");
		param.put("searchToDt", "20190418");
		param.put("trregNb", "");
		param.put("trNm", "");
		param.put("issNo", "201903184100009645344477");
		param.put("orderBy", "");
		param.put("emailDc", "");
		
		List<Map<String, Object>> result = connector.List(conVo, "AdminiUReport.ExAdminETaxListInfoSelectMap", param);
		
		logger.info("### total = {}", result.size());
		assertTrue(result.size() > 0);
	}
	
	/**
	 * ERP - IU 자동전표 전송
	 * 비고 : 테스트 후 MS-SQL 데이터 삭제 필요
	 */
	@Test
	public void testExReportExpendErpSend() {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("ROW_ID", "999999");
		param.put("ROW_NO", "1");
		param.put("CD_COMPANY", "10000");
		param.put("NO_DOLINE", "1");
		param.put("NO_DOCU", "0001");
		param.put("NO_TAX", "*");
		param.put("CD_PC", "1000");
		param.put("CD_WDEPT", "120000");
		param.put("ID_WRITE", "20060101");
		param.put("CD_DOCU", "13");
		param.put("DT_ACCT", "20190507");
		param.put("ST_DOCU", "1");
		param.put("TP_DRCR", "1");
		param.put("CD_ACCT", "10500");
		param.put("AMT", "1000");
		param.put("CD_PARTNER", "");
		param.put("DT_START", "");
		param.put("DT_END", "");
		param.put("AM_TAXSTD", "0");
		param.put("AM_ADDTAX", "0");
		param.put("TP_TAX", "");
		param.put("NO_COMPANY", "");
		param.put("NM_NOTE", "");
		param.put("CD_BIZAREA", "");
		param.put("CD_DEPT", "");
		param.put("CD_CC", "");
		param.put("CD_PJT", "");
		param.put("CD_FUND", "");
		param.put("CD_BUDGET", "");
		param.put("NO_CASH", "");
		param.put("ST_MUTUAL", "");
		param.put("CD_CARD", "");
		param.put("NO_DEPOSIT", "");
		param.put("CD_BANK", "");
		param.put("UCD_MNG1", "");
		param.put("UCD_MNG2", "");
		param.put("UCD_MNG3", "");
		param.put("UCD_MNG4", "");
		param.put("UCD_MNG5", "");
		param.put("CD_EMPLOY", "");
		param.put("CD_MNG", "");
		param.put("NO_BDOCU", "");
		param.put("NO_BDOLINE", "0");
		param.put("TP_DOCU", "Y");
		param.put("NO_ACCT", "0");
		param.put("TP_TRADE", "");
		param.put("CD_EXCH", "");
		param.put("RT_EXCH", "0");
		param.put("CD_TRADE", "");
		param.put("NO_CHECK2", "");
		param.put("NO_CHECK3", "");
		param.put("NO_CHECK4", "");
		param.put("TP_CROSS", "");
		param.put("ERP_CD", "");
		param.put("AM_EX", "0");
		param.put("NO_TO", "");
		param.put("DT_SHIPPING", "");
		param.put("TP_GUBUN", "3");
		param.put("NO_INVOICE", "");
		param.put("NO_ITEM", "");
		param.put("MD_TAX1", "");
		param.put("NM_ITEM1", "");
		param.put("NM_SIZE1", "");
		param.put("QT_TAX1", "0");
		param.put("AM_PRC1", "0");
		param.put("AM_SUPPLY1", "0");
		param.put("AM_TAX1", "0");
		param.put("NM_NOTE1", "");
		param.put("CD_BIZPLAN", "");
		param.put("CD_BGACCT", "");
		param.put("CD_MNGD1", "");
		param.put("NM_MNGD1", "");
		param.put("CD_MNGD2", "");
		param.put("NM_MNGD2", "");
		param.put("CD_MNGD3", "");
		param.put("NM_MNGD3", "");
		param.put("CD_MNGD4", "");
		param.put("NM_MNGD4", "");
		param.put("CD_MNGD5", "");
		param.put("NM_MNGD5", "");
		param.put("CD_MNGD6", "");
		param.put("NM_MNGD6", "");
		param.put("CD_MNGD7", "");
		param.put("NM_MNGD7", "");
		param.put("CD_MNGD8", "");
		param.put("NM_MNGD8", "");
		param.put("YN_ISS", "");
		param.put("TP_BILL", "");
		param.put("ST_TAX", "");
		param.put("MD_TAX2", "");
		param.put("NM_ITEM2", "");
		param.put("NM_SIZE2", "");
		param.put("QT_TAX2", "0");
		param.put("AM_PRC2", "0");
		param.put("AM_SUPPLY2", "0");
		param.put("AM_TAX2", "0");
		param.put("NM_NOTE2", "");
		param.put("MD_TAX3", "");
		param.put("NM_ITEM3", "");
		param.put("NM_SIZE3", "");
		param.put("QT_TAX3", "0");
		param.put("AM_PRC3", "0");
		param.put("AM_SUPPLY3", "0");
		param.put("AM_TAX3", "0");
		param.put("NM_NOTE3", "");
		param.put("MD_TAX4", "");
		param.put("NM_ITEM4", "");
		param.put("NM_SIZE4", "");
		param.put("QT_TAX4", "0");
		param.put("AM_PRC4", "0");
		param.put("AM_SUPPLY4", "0");
		param.put("AM_TAX4", "0");
		param.put("NM_NOTE4", "");
		param.put("FINAL_STATUS", "");
		param.put("NO_BILL", "");
		param.put("NO_ASSET", "");
		param.put("TP_RECORD", "");
		param.put("TP_ETCACCT", "");
		param.put("SELL_DAM_NM", "");
		param.put("SELL_DAM_EMAIL", "");
		param.put("SELL_DAM_MOBIL", "");
		param.put("ST_GWARE", "");
		param.put("NM_PUMM", "");
		param.put("JEONJASEND15_YN", "");
		param.put("DT_WRITE", "");
		param.put("NM_PTR", "");
		param.put("EX_HP", "");
		param.put("EX_EMIL", "");
		param.put("NM_PARTNER", "");
		param.put("CD_BIZCAR", ""); 
		param.put("TP_EVIDENCE", "1"); //ERP 증빙
		
		int result = connector.Insert(conVo, "ExFI_ADOCUInsert", param);
		
		assertTrue(result > 0);
	}

}
