package expend.ex.admin.budget;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


/**
 *   * @FileName : FExAdminBudgetServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FExAdminBudgetServiceA" )
public class FExAdminBudgetServiceAImpl implements FExAdminBudgetService {

	/**
	 * 
	 */
	@Resource ( name = "FExAdminBudgetServiceADAO" )
	private FExAdminBudgetServiceADAO dao;

	/**
	 *   * @Method Name : getOrgUnitList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public List<Map<String, Object>> getOrgUnitList ( Map<String, Object> params ) throws Exception {
		/* 변수정의 - List */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		/* DAO */
		try {
			/* PARAMETER : compSeq */
			/* DAO - 조회 - List */
			result = dao.SelectOrgUnitList( params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환 - List */
		return result;
	}

	/**
	 *   * @Method Name : getOrgListSearch
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public List<Map<String, Object>> getOrgListSearch ( Map<String, Object> params ) throws Exception {
		/* 변수정의 - List */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		/* DAO */
		try {
			/* DAO - 조회 - List */
			result = dao.SelectOrgtListSearch( params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환 - List */
		return result;
	}

	/**
	 *   * @Method Name : getOrgInfoList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public List<Map<String, Object>> getOrgInfoList ( Map<String, Object> params ) throws Exception {
		/* 변수정의 - List */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		/* DAO */
		try {
			/* DAO - 조회 - List */
			result = dao.SelectOrgInfoList( params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환 - List */
		return result;
	}

	/**
	 *   * @Method Name : insertOrgBaseInfo
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean insertOrgBaseInfo ( Map<String, Object> params ) throws Exception {
		/* 변수정의 - Boolean */
		boolean result = true;
		/* DAO */
		try {
			/* DAO - 생성 - Boolean */
			result = dao.InserOrgBaseInfo( params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환 - Boolean */
		return result;
	}

	/**
	 *   * @Method Name : chkBudgetAmt
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public Map<String, Object> chkBudgetAmt ( Map<String, Object> params ) throws Exception {
		/* 변수정의 - Map */
		Map<String, Object> result = new HashMap<String, Object>( );
		Map<String, Object> tempMap = new HashMap<String, Object>( );
		/* DAO */
		try {
			/* DAO - 생성 - Map */
			tempMap = dao.chkBudgetAmt( params );
			/* Service - 반환정의 */
			result.put( "budget_name", tempMap.get( "budget_name" ) );
			result.put( "unit_gb", tempMap.get( "unit_gb" ) );
			result.put( "org_year", tempMap.get( "org_year" ) );
			result.put( "control_gb", tempMap.get( "control_gb" ) );
			result.put( "acct_name", tempMap.get( "acct_name" ) );
			String[] moduleArray = { "org", "adj", "shi", "rec" };
			for ( int i = 0; i < moduleArray.length; i++ ) {
				List<Integer> amtInfo = new ArrayList<Integer>( );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "jan_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "feb_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "mar_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "apr_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "may_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "jun_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "jul_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "aug_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "sep_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "oct_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "nov_" + moduleArray[i] + "_amt" ) ) );
				amtInfo.add( Integer.parseInt( (String) tempMap.get( "dec_" + moduleArray[i] + "_amt" ) ) );
				result.put( moduleArray[i] + "_amt", amtInfo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환 - Map */
		return result;
	}
}
