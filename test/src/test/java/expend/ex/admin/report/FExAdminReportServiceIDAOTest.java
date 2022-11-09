package expend.ex.admin.report;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import common.vo.common.ConnectionVO;
import expend.TestCase;

/**
 * FExAdminReportServiceIDAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-02-07.
 * 비고 : MS-SQL 롤백 안됨.
 */
public class FExAdminReportServiceIDAOTest extends TestCase {

	@Autowired
	private FExAdminReportServiceIDAO daoI;
	
	/**
	 * ERP iCUBE 전표 정보 전송
	 * @throws Exception
	 */
	@Test
	public void testExReportExpendErpSendWithDocInfo() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("langCode", "kr");
		params.put("compSeq", "707010011562");
		params.put("empSeq", "707010011565");
		params.put("fromDate", "20181225");
		params.put("toDate", "20190125");
		params.put("searchCardNum", "");
		params.put("searchMercName", "");
		params.put("docSts", "");
		params.put("sortField", "authDate");
		params.put("sortType", "desc");
		
		ConnectionVO conVo = new ConnectionVO();
		
		conVo.setDatabaseType("mssql");
		conVo.setG20YN("N");
		conVo.setDriver("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		conVo.setUrl("jdbc:sqlserver://175.206.170.90:3433;databasename=DZICUBE");
		conVo.setUserId("dzicube");
		conVo.setPassword("ejwhs123$");
		conVo.setErpTypeCode("iCUBE");
		conVo.setErpCompSeq("0098");
		conVo.setErpCompName("	test");
		
		Map<String, Object> param = new HashMap<String, Object>(); 
		
		param.put("PAYMENT", ""); 
	    param.put("PRS_FG", ""); 
	    param.put("TR_CD", "2429"); 
	    param.put("DEPTCD_TY", "C1"); 
	    param.put("CT_RT", 0); 
	    param.put("RT_TY", ""); 
	    param.put("CT_DEAL", ""); 
	    param.put("DEPT_NM", "윤다혜"); 
	    param.put("IN_DIV_CD", "1000"); 
	    param.put("FRDT_TY", ""); 
	    param.put("TO_DT", ""); 
	    param.put("CT_USER2", ""); 
	    param.put("CT_USER1", ""); 
	    param.put("CT_NB", ""); 
	    param.put("PJT_CD", ""); 
	    param.put("USER1_NM", ""); 
	    param.put("CTNB_TY", ""); 
	    param.put("ISS_NO", ""); 
//	    param.put("CT_DEPT", "2015050101");
	    param.put("CT_DEPT", "0");
	    param.put("DEAL_TY", "");
	    param.put("mngSeq", ""); 
	    param.put("ENDORS_NM", "");
	    param.put("DRCR_FG", "3");
	    param.put("ACCT_CD", "51104"); 
	    param.put("TRCD_TY", "A1"); 
	    param.put("RMK_DCK", ""); 
	    param.put("TR_NMK", ""); 
	    param.put("RMK_NB", "0"); 
	    param.put("TRNM_TY", "B1"); 
	    param.put("LOGIC_CD", "21"); 
	    param.put("EX_FG", "0"); 
	    param.put("listSeq", "1"); 
	    param.put("TODT_TY", ""); 
	    param.put("PJT_NM", ""); 
	    param.put("expendSeq", "195"); 
	    param.put("QT_TY", ""); 
	    param.put("DEAL_NMK", "");
	    param.put("USER2_TY", ""); 
	    param.put("AM_TY", ""); 
	    param.put("CO_CD", "9800"); 
	    param.put("PJT_NMK", ""); 
	    param.put("IN_DT", "20190114"); 
	    param.put("EXCH_TY", ""); 
	    param.put("ISU_DOCK", ""); 
	    param.put("slipSeq", "1"); 
	    param.put("expendDate", "20190114"); 
	    param.put("JEONJA_YN", "0"); 
	    param.put("USER2_NMK", ""); 
	    param.put("ISU_NM", ""); 
	    param.put("PJTCD_TY", "D1"); 
	    param.put("USER1_TY", ""); 
	    param.put("DEPT_NMK", ""); 
	    param.put("FR_DT", "");
	    param.put("RMK_DC", "(복리)식비-체크카드"); 
	    param.put("TR_NM", "중화요리 미담"); 
	    param.put("CT_QT", 0); 
	    param.put("BILL_FG2", ""); 
	    param.put("BILL_FG1", ""); 
	    param.put("USER1_NMK", ""); 
	    param.put("ISU_DOC", "[(주)제이에이그린-2019-0049] 지출결의서(3552, 그룹, 미담)"); 
	    param.put("DEAL_FG", ""); 
	    param.put("DEAL_NM", ""); 
	    param.put("CT_AM", 0); 
	    param.put("DUMMY3", ""); 
	    param.put("PAYMENT_PT", ""); 
	    param.put("DUMMY2", ""); 
	    param.put("DUMMY1", ""); 
	    param.put("USER2_NM", ""); 
	    param.put("INSERT_DT", ""); 
	    param.put("ACCT_AM", 5455); 
	    param.put("EXCH_AM", 0); 
	    param.put("ATTR_CD", "");
				
		String IN_DT = "20190114";
		String IN_SQ = "1";
		int LN_SQ = 1;
		String doc_id = "742";
		String doc_no = "(주)제이에이그린-2019-0049";
		
		int result = daoI.ExReportExpendErpSendWithDocInfo(conVo, param, IN_DT, IN_SQ, LN_SQ, doc_id, doc_no);
		
		assertTrue(result > 0);
	}

}
