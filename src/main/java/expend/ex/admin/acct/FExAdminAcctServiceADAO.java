/**
  * @FileName : FExAdminAcctServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.acct;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.CommonInterface.commonCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FExAdminAcctServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FExAdminAcctServiceADAO" )
public class FExAdminAcctServiceADAO extends EgovComAbstractDAO {
	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* ################################################## */
	/* [810000000]..회계 */
	/* ################################################## */
	/* ################################################## */
	/* [810200000]..└ 지출결의 설정 */
	/* ################################################## */
	/* ################################################## */
	/* [810201000]....└ 계정과목 설정 */ /* 관리자 > 회계 > 지출결의 설정 > 계정과목 설정 */
	/* ################################################## */
	/* 계정과목 목록 조회 */

	/**
	 *   * @Method Name : ExAdminConfigAcctListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 계정과목 목록 조회 ( Bizbox Alpha )
	 *   * @param params
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminConfigAcctListInfoSelect ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExAdminConfig.ExAdminConfigAcctListInfoSelect", params );
		return result;
	}

	/* 계정과목 등록 & 수정 */
	/**
	 *   * @Method Name : ExAdminConfigAcctInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 계정과목 등록 & 수정 ( Bizbox Alpha )
	 *   * @param params
	 *   * @return
	 *   
	 */
	public int ExAdminConfigAcctInfoInsert ( Map<String, Object> params ) {
		int result = Integer.parseInt( commonCode.EMPTYSEQ );
		try {
			result = (int) update( "ExAdminConfig.ExAdminConfigAcctInfoInsert", params );
		}
		catch ( Exception e ) {
			result = Integer.parseInt( commonCode.EMPTYSEQ );
		}
		return result;
	}

	/* 계정과목 삭제 */
	/**
	  * @Method Name : ExAdminConfigAcctInfoDelete
	  * @변경이력 : 
	  * @메뉴 : 
	  * @Method 설명 : 계정과목 삭제
	  * @param params
	  * @return
	  */
	public int ExAdminConfigAcctInfoDelete ( Map<String, Object> params ) {
		int result = Integer.parseInt( commonCode.EMPTYSEQ );
		try {
			result = (int) delete( "ExAdminConfig.ExAdminConfigAcctInfoDelete", params );
		}
		catch ( Exception e ) {
			result = Integer.parseInt( commonCode.EMPTYSEQ );
		}
		return result;
	}
}
