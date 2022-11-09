/**
  * @FileName : FEx2UserExpendServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.expend;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FEx2UserExpendServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FEx2UserExpendServiceADAO" )
public class FEx2UserExpendServiceADAO extends EgovComAbstractDAO {

	/* 접대비등록 생성 */
	public int setEntertainmentFeeInsert ( Map<String, Object> param ) throws Exception {
		int result = 0;
		result = (int) this.insert( "setEntertainmentFeeInsert", param );
		return result;
	}

	/* 접대비등록 수정 */
	public int setEntertainmentFeeUpdate ( Map<String, Object> param ) throws Exception {
		int result = 0;
		result = (int) this.update( "setEntertainmentFeeUpdate", param );
		return result;
	}

	/* 접대비등록 삭제 */
	public int setEntertainmentFeeDelete ( Map<String, Object> param ) throws Exception {
		int result = 0;
		result = (int) this.delete( "setEntertainmentFeeDelete", param );
		return result;
	}

	/* 접대비등록 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> setEntertainmentFeeSelect ( Map<String, Object> param ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) this.select( "setEntertainmentFeeSelect", param );
		return result;
	}
}
