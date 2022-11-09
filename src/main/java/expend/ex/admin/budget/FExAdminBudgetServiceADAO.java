package expend.ex.admin.budget;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FExAdminBudgetServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FExAdminBudgetServiceADAO" )
public class FExAdminBudgetServiceADAO extends EgovComAbstractDAO {

	/* insert() : 성공(null) / 실패(에러) */
	/* update() : 성공(적용된 row 수) / 실패(0) */
	/* delete() : 성공(삭제된 row 수) / 실패(0) */
	/**
	 *   * @Method Name : SelectOrgUnitList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectOrgUnitList ( Map<String, Object> params ) {
		/* 변수정의 - List */
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>( );
		returnList = this.list( "ExAdminBudget.SelectOrgUnitList", params );
		/* 반환 - List */
		return returnList;
	}

	/**
	 *   * @Method Name : SelectOrgtListSearch
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectOrgtListSearch ( Map<String, Object> params ) {
		/* 변수정의 - List */
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>( );
		/* DAO - Select List */
		returnList = this.list( "ExAdminBudget.SelectOrgtListSearch", params );
		/* 반환 - List */
		return returnList;
	}

	/**
	 *   * @Method Name : SelectOrgInfoList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectOrgInfoList ( Map<String, Object> params ) {
		/* 변수정의 - List */
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>( );
		/* DAO - Select List */
		returnList = this.list( "ExAdminBudget.SelectOrgInfoList", params );
		/* 반환 - List */
		return returnList;
	}

	/**
	 *   * @Method Name : InserOrgBaseInfo
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean InserOrgBaseInfo ( Map<String, Object> params ) throws Exception {
		/* 변수정의 - Boolean */
		boolean result = true;
		try {
			/* DAO - Insert Item */
			this.insert( "ExAdminBudget.InserOrgBaseInfo", params );
		}
		catch ( Exception e ) {
			result = false;
			e.printStackTrace( );
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
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> chkBudgetAmt ( Map<String, Object> params ) {
		/* 변수정의 - Map */
		Map<String, Object> returnList = new HashMap<String, Object>( );
		/* DAO - Select Item */
		returnList = (Map<String, Object>) this.select( "ExAdminBudget.ChkBudgetAmt", params );
		/* 반환 - Map */
		return returnList;
	}
}
