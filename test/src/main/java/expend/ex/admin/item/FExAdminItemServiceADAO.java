/**
  * @FileName : FExAdminItemServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.item;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.CommonInterface.commonCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FExAdminItemServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FExAdminItemServiceADAO" )
public class FExAdminItemServiceADAO extends EgovComAbstractDAO {

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
	/* [810208000]....└ 항목 설정 */ /* 관리자 > 회계 > 지출결의 설정 > 항목 설정 */
	/* ################################################## */
	/* 항목 설정 목록 조회 */
	/**
	 *   * @Method Name : ExAdminConfigItemListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 목록 조회
	 *   * @param params
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	List<Map<String, Object>> ExAdminConfigItemListInfoSelect ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ExAdminConfig.ExAdminConfigItemListInfoSelect", params );
		return result;
	}

	/* 항목 설정 생성 & 수정 */
	/**
	 *   * @Method Name : ExAdminConfigItemInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 생성 & 수정
	 *   * @param params
	 *   * @return
	 *   
	 */
	public int ExAdminConfigItemInfoInsert ( Map<String, Object> params ) {
		int result = Integer.parseInt( commonCode.EMPTYSEQ );
		try {
			result = (int) update( "ExAdminConfig.ExAdminConfigItemInfoInsert", params );
		}
		catch ( Exception e ) {
			result = Integer.parseInt( commonCode.EMPTYSEQ );
		}
		return result;
	}

	/* 항목 설정 초기화 */
	/**
	 *   * @Method Name : ExAdminConfigItemListInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 초기화
	 *   * @param params
	 *   * @return
	 *   
	 */
	public int ExAdminConfigItemListInfoDelete ( Map<String, Object> params ) {
		int result = Integer.parseInt( commonCode.EMPTYSEQ );
		try {
			result = (int) delete( "ExAdminConfig.ExAdminConfigItemListInfoDelete", params );
		}
		catch ( Exception e ) {
			result = Integer.parseInt( commonCode.EMPTYSEQ );
		}
		return result;
	}
}
