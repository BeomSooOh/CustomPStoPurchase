package expend.ex.admin.config;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import common.helper.convert.CommonConvert;
import expend.TestCase;

/**
 * FExAdminConfigServiceADAOTest JUnit테스트
 * Created by Kwon Oh Gwang on 2019-05-09.
 */
public class FExAdminConfigServiceADAOTest extends TestCase {
	@Autowired
	FExAdminConfigServiceADAO fExAdminConfigServiceADAO;

	/**
	 * 환경설정 옵션값 조회
	 */
	@Test
	public void testExAdminConfigOptionSelect() {
		Map<String, Object> param = new HashMap<>();
		
		param.put( "compSeq", "707010026273" );
		param.put( "groupSeq", "demo" );
		param.put( "formSeq", "10320" );
		param.put( "useSw", "ERPiU" );
		param.put( "optionCode", "003403" ); //종결시 자동전송 옵션
		
		List<Map<String, Object>> result = fExAdminConfigServiceADAO.ExAdminConfigOptionSelect(param);
		
		assertTrue(result.size() > 0);
	}
	
	/**
	 * ## 양식별 표준적요 설정 ## - 표준적요 등록
	 * @throws Exception 
	 */
	@Test
	public void testExAdminSetSummaryAuthCreate() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put( "compSeq", "1241" );
		param.put( "formSeq", "25" );
		param.put( "summaryCode", "18800" );
		param.put( "empSeq", "1244" ); //종결시 자동전송 옵션
		
		int result = fExAdminConfigServiceADAO.ExAdminSetSummaryAuthCreate(param);
		assertTrue(result > 0);
	}
	
	/**
	 * ## 양식별 표준적요 설정 ## - 표준적요 삭제
	 * @throws Exception 
	 */
	@Test
	public void testExAdminSetSummaryAuthDelete() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put( "compSeq", "1241" );
		param.put( "formSeq", "25" );
		param.put( "summaryCode", "18800" );
		param.put( "isInsert", "Y" ); // Y일 경우 표준적요 등록 전 삭제
		
		int result = fExAdminConfigServiceADAO.ExAdminSetSummaryAuthDelete(param);
		assertTrue(result > 0);
	}
	
	/**
	 * ## 양식별 증빙유형 설정 ## - 증빙유형 등록
	 * @throws Exception 
	 */
	@Test
	public void testExAdminSetAuthTypeAuthCreate() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put( "compSeq", "1241" );
		param.put( "formSeq", "25" );
		param.put( "authTypeCode", "3" );
		param.put( "empSeq", "1244" ); 
		
		int result = fExAdminConfigServiceADAO.ExAdminSetAuthTypeAuthCreate(param);
		assertTrue(result > 0);
	}
	
	/**
	 * ## 양식별 증빙유형 설정 ## - 증빙유형 삭제
	 * @throws Exception 
	 */
	@Test
	public void testExAdminSetAuthTypeAuthDelete() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put( "compSeq", "1241" );
		param.put( "formSeq", "25" );
		param.put( "authTypeCode", "1" );
		param.put( "isInsert", "Y" ); // Y일 경우 표준적요 등록 전 삭제
		
		int result = fExAdminConfigServiceADAO.ExAdminSetAuthTypeAuthDelete(param);
		assertTrue(result > 0);
	}
	
	/**
	 * 지출결의 마감 등록(전체양식)
	 * @throws Exception 
	 */
	@Test
	public void testExAdminExpendCloseInsertAllForm() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put( "compSeq", "1292" );
		param.put( "closeType", "E" );
		param.put( "closeFromDate", "20200305" );
		param.put( "closeToDate", "20200305" ); 
		param.put( "closeStat", "Y" ); 
		param.put( "note", "" ); 
		param.put( "createSeq", "1294" ); 
		param.put( "modifySeq", "1294" ); 
		param.put( "modifyName", "김더존" ); 
		
		String temp = "[{\"formSeq\":\"28\"},{\"formSeq\":\"32\"},{\"formSeq\":\"42\"}]";
		List<Map<String, Object>> exceptFormList = CommonConvert.ConvertJsonToListMap(CommonConvert.CommonGetStr(temp));
		param.put( "exceptFormList", exceptFormList ); 
		
		int result = fExAdminConfigServiceADAO.ExAdminExpendCloseInsertAllForm(param);
		assertTrue(result > 0);
	}
	
	/**
	 * 지출결의 마감 양식 전체 등록 전 날짜 중복 체크
	 * @throws Exception 
	 */
	@Test
	public void testExAdminExpendCloseFormInsertChkValidate() throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		param.put( "compSeq", "1241" );
		param.put( "closeType", "E" );
		param.put( "closeFromDate", "20200303" );
		param.put( "closeToDate", "20200303" ); 
		
		List<Map<String, Object>> result = fExAdminConfigServiceADAO.ExAdminExpendCloseFormInsertChkValidate(param);
		assertTrue(result.size() > 0);
	}

}
